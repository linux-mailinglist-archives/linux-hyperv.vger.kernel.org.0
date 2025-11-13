Return-Path: <linux-hyperv+bounces-7554-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AB29CC59D04
	for <lists+linux-hyperv@lfdr.de>; Thu, 13 Nov 2025 20:42:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A0E8A4E1570
	for <lists+linux-hyperv@lfdr.de>; Thu, 13 Nov 2025 19:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B912E31BCBD;
	Thu, 13 Nov 2025 19:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="D86lyxVb"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azolkn19012057.outbound.protection.outlook.com [52.103.10.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C555F315D3B;
	Thu, 13 Nov 2025 19:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.10.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763062925; cv=fail; b=JFRR3Mp59eova5PGKORgxe6rdR7C5FKF2FzFGtRHAiomv+ur7zHjMiUM/QGh9UlJeWUKmVtjfoV9kkq6tKgoZuDnwJx5nv9QM+iyjycSdflX+4iCBFB41PEnL7pK2pmSWNBXU1pMvGfzvH/+tmT1vkiDx/hCvr+UdIOewLx2jwE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763062925; c=relaxed/simple;
	bh=uB9cNr8jV/rc+qiTNSUHA85Z6rnLoXC81/V4z/UQ9vI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aWl8Quzfx96SlHPACGHkhT9YqHCa0i3EoCbojRvI938o5ghXQtAVCOoVua/hMVbR0dvyCnmcb7LKzgSL2ye7bC0kzeK+JeVnw0iHsVVpd/zF4AnstVHUc3LYRfc2zTuboPqSJcpSHjCUwKwOGeTRsCSrg903mVi5V6uBB308XbE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=D86lyxVb; arc=fail smtp.client-ip=52.103.10.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dq2tE30BiQd3FEyJECXPmdD7rH3/MClxstkYCtS3O3KAyg83RYZmqDhyWgIxnlgtb0qCeh+Ai1kk6bib0F57LDnwnRAUDY/88Y2dL3skhQ9howQpnoSLzZMtwSlY08jN2Cdw2hlPAsLxoWIU5b2T1qGIpZlsFXDdr8TCsY/gszYg8rY2eUMmHFagskE/9WXpi9D5Cr/zN1HqTC1o/sOcPx8ROtWFHI3l4F+0eQteFuiE1P6DeUpkIRR6OKkWUbrC6FCiXBX97zT8iTDQ8SbmUhbcLTIyI69qcIbw7szu88zI9qWwBToyc/L2eIE+fHGf/BMbCYW1VZCOsIiBDCKsQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iXg1a3hOMfkP6nBTk4f4vv9wU2WkAsXAxEHEyqNkBhQ=;
 b=MwYmqBHRnNNGWht+CLGlpSpxn3b9IYcrvOb3da/xgiB3YsA5Lx9JIpq2PsNvg+0flfrH/mdk3oOxz+FaERK/dPNu5ejy7ahbPUwkIIFFUdnHQXVafLG/YCzFECenI2HQF+I9kQpBhgMaVWnpprJzhyA8Tu2tA0tLH1H/m82pN3sGcKIu2YlFuMKLpZQ1q6vBJOUykg2bb+O5VZ8btb11Enj4A/ePhJvNrqndmWwnT/Yp9TGH9LGAGMqOagNmxfTlqIdHvFNROVDeNAKhfv62i/w+UE/y43wAYgzN3r/i92A4Ex2WdE6hGbfDxpGj9sW9b4umgCKqJjKWiWYV+RIwVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iXg1a3hOMfkP6nBTk4f4vv9wU2WkAsXAxEHEyqNkBhQ=;
 b=D86lyxVbXrOhpl56OCEJzIHFBCy+9wqrI4iOQT34S+VwR3DA41nS3CSJe0PbliLwTB5ooop1NIzRFjT5Z84szkHFMOlqjR/D41gP/WT6UH9KOg1WXCdWleqQRzufiwae73C/fD3Lv/yRm0XLyWVg8sY+nBQSG0QqSFJyDsD6nQFDE/kJ5FcnzoKmQOlL789XT/LS6G/yZhdwMTJXl+OHvIUEHYb4E8CHb2yTkyPDEs8D+3DnRsppzHfJnzN4/ABG0rbAcIDzLHq3T5XVkQANunC7hrM5s08wonndId1rKE7HY187fxZgBOfcLu/lEaf7KJp4b6752Nyf/zK6HnlFXA==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by CYXPR02MB10195.namprd02.prod.outlook.com (2603:10b6:930:d7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Thu, 13 Nov
 2025 19:42:01 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%2]) with mapi id 15.20.9320.013; Thu, 13 Nov 2025
 19:42:01 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Praveen K Paladugu <prapal@linux.microsoft.com>, "kys@microsoft.com"
	<kys@microsoft.com>, "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>, "decui@microsoft.com"
	<decui@microsoft.com>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"mingo@redhat.com" <mingo@redhat.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, "arnd@arndb.de"
	<arnd@arndb.de>
CC: "anbelski@linux.microsoft.com" <anbelski@linux.microsoft.com>,
	"easwar.hariharan@linux.microsoft.com"
	<easwar.hariharan@linux.microsoft.com>, "nunodasneves@linux.microsoft.com"
	<nunodasneves@linux.microsoft.com>, "skinsburskii@linux.microsoft.com"
	<skinsburskii@linux.microsoft.com>
Subject: RE: [PATCH v4 2/3] hyperv: Use reboot notifier to configure sleep
 state
Thread-Topic: [PATCH v4 2/3] hyperv: Use reboot notifier to configure sleep
 state
Thread-Index: AQHcUDRGYuHbq54y2kyknpmdm0xJl7TnymWAgAk74QA=
Date: Thu, 13 Nov 2025 19:42:00 +0000
Message-ID:
 <SN6PR02MB4157396FA3D70F49220C83FED4CDA@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20251107221700.45957-1-prapal@linux.microsoft.com>
 <20251107221700.45957-3-prapal@linux.microsoft.com>
 <21d31d05-a55e-4717-a44d-673aa395a5d0@linux.microsoft.com>
In-Reply-To: <21d31d05-a55e-4717-a44d-673aa395a5d0@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|CYXPR02MB10195:EE_
x-ms-office365-filtering-correlation-id: 8d5cd62a-ee33-4e50-5109-08de22ecb774
x-microsoft-antispam:
 BCL:0;ARA:14566002|13091999003|31061999003|461199028|8060799015|41001999006|19110799012|51005399006|8062599012|15080799012|440099028|3412199025|40105399003|12091999003|102099032;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?4fXTWI4WcwUOai50reQTsucZU9UrXB+Px7FDLzfuUP62zp/F+6aQocs+wsEl?=
 =?us-ascii?Q?LSLw4qY6GC7baH2LjxRIOVxzUp+EZySmkY9qlBGSxi5Gsf6y1k95igw5Kl1+?=
 =?us-ascii?Q?+W7OYZPOqub0CIYr87xo4Vv4I8/m88POfwCOmj/93vs+6/wf+WdN4BKMscZV?=
 =?us-ascii?Q?yaMzlblD2Veh0ZlApYlkFP5fZV19WUDEP0NeFJSpjaW/GElO5oXgPwDxeGfq?=
 =?us-ascii?Q?DjzpBEW+1nVtIwea73Ebi0az1XiWN4wnnKZKnfbop05o1UT/jg+Okx2L7xcu?=
 =?us-ascii?Q?BRLXF9Z8LOZHSq+DUfWtQIvE5GMvNw/PucgpFO26MXYFxuknn/diR/eF93Mz?=
 =?us-ascii?Q?rEphd6h+djAZ6chgLqDKU8cbtXdXrbdjClo7kilYin+RlTfMK0cwRyjra9wG?=
 =?us-ascii?Q?h+YsOguVbR4jjGZ/JcNxwX19V+pxCRxUsDTZiSkeY76HboWHCMihFA1OmZXX?=
 =?us-ascii?Q?DpJxTNgNYFbEihAHLmMSOhbhUF/H9fFjFjizQ+2RK49t2b1IB3vHEFu3fMuN?=
 =?us-ascii?Q?DqkUirMn8q0AhJplCQuQtgNdjzjmlSO3VZY+5xQ57nn6pN4t9bbAVVaYre2S?=
 =?us-ascii?Q?xw2426bwRZjopAJv+qKP+ZqFJdtD0n3KXnneV2Sp5VeHKnDrUBnssxotYGe/?=
 =?us-ascii?Q?gTKtFGk8nyY+WrXSmRzerT0ma5pN4EBgQOhkSaqtOF6XfcQr6PGU01Luhm1N?=
 =?us-ascii?Q?5YonZutvo6RkG4aSoRkl+uJIaJOClE0VjB4JvoAVkDD4UGl1RZ2lwwFbhLhQ?=
 =?us-ascii?Q?zi7IJegX8jN9FNKtLzINJm+nnUFVNVV2f/gpCNi2HIwLbQ2PZNr6YbR1YDF3?=
 =?us-ascii?Q?6JDjh3kvsJzIcBNbOH69elDr5bYUcqhZLcm+6SmMqbK0Sd3dLj4EFZvSPraU?=
 =?us-ascii?Q?dsWBWbwIo58rt0Jki+IYkKlFYLX68xYB5k1O19vSD+jNqy8EBy8FYdcrCO7h?=
 =?us-ascii?Q?EoWYOcVuJl3m6x21VYfpKANnCzb/j+BKXswuJHtTx+7xLzzsqs9jZ8uMKb2g?=
 =?us-ascii?Q?SPllX8dvszspopjceWnwsAXCJmZoO2coPyYFbas4P+vdbJYxPfVMs+jHfbc/?=
 =?us-ascii?Q?torwBzD6BWzv8qrvs2V5/nT/sohL1EsF9jNylJA0tSVqQkJMc3x86V4uvP5Q?=
 =?us-ascii?Q?hWFh4AXfmKFMDH2tUfu2tj2Bd7ZKOHlknoKKaGsj3+GNG+Px3EjkCsXymsv1?=
 =?us-ascii?Q?D9WMv5ie+q4JaHJnGivIajbGtXi3mqmdIY71idA/NWiNZADul9DckREOKkP8?=
 =?us-ascii?Q?q4AH0okc6SNACL3gZTecEFpj8yY5TReg+3xrkadEcg=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?OxWcFCpN/ES8dIs6URqXSY1Jz8ezWnF1IDSk+McV2nCTDbB2DhrCvpdXS5gB?=
 =?us-ascii?Q?XEx6X5FdyrDHxcwW/UwK2Jm0wXHEdxB3cAzVq6eSzFA/eJxe6jvi9P+wgb03?=
 =?us-ascii?Q?LusHMEpojqsacEX9AD7sUGKS9OqzaiCazFIzNalEvPVlpLR53U+EsNv2CO8D?=
 =?us-ascii?Q?ylEEfkRIVKQYgIC0ujGSJoT6/TxbJQfToX68/L1egiHi2E/YXQj0YoOGP6Sz?=
 =?us-ascii?Q?oa7IaIiB0Ud6haH3jAM3JNKEyHZ+8rmgZrK2NcTGceAMD7eicpBz8XzvFrl2?=
 =?us-ascii?Q?W8Qnxexji5tXuO70sv5s+TiFHDC+JmVnYt0kJHYbwsjQ8CQ81dD+/GTiKpjz?=
 =?us-ascii?Q?CFwF3I+sfvU+zqE+b4ILqFtOGFxszKXcRhk3P2s7GT6HgbE3/P9sKrCm8s+Y?=
 =?us-ascii?Q?6yMlgT2XinseiLkR3p9ocO4AQdIGyCO4nX6YKadpcxnzbV74lt9zoHwj+bSX?=
 =?us-ascii?Q?ySlgTQzF70+9ZlXSiEKeHP5AI4Oj5fI/5xs9xlWHElF0Eesv08eR3KRtpVq2?=
 =?us-ascii?Q?2GxU2uOZCstFnnC9+/VzAei3A31smEqakCyRFbdg4w3ANaQq0kjpIvL8F9SO?=
 =?us-ascii?Q?iAUTtQjrztQMrbBUvFrEcnec8a/EC7cJu9i4Hr+TsJ+BCeVsjLxUJeMR9SY+?=
 =?us-ascii?Q?9Cfb0CjbAKCC2Fq6Mc24XkrAmT67e1Hurl8JgF8pv1Wi3q/MwM61fYg/ikOc?=
 =?us-ascii?Q?9/+g7WQBEWHRFd0Zl/3jqBJ7W6+TLJmiqzxIhP8gfZ46wMyCo96VsrCLXCTn?=
 =?us-ascii?Q?DmAsDhdjeXP7s9muHfhDWc/8bl1cVtsESGb6jV+ydfr3OlsF1kAsojOc9/QF?=
 =?us-ascii?Q?QTJEM6RuIFvSEk2gk5wXIuHFoHALOmAV95wZ4P9AFPochgWjwgeGU1/yieWh?=
 =?us-ascii?Q?qTcG/SsouwhBTAffgkgh3n5L23/4WmR+7H79/GPHY9vXCA4TqbdI5V8wWFr0?=
 =?us-ascii?Q?53981bNkL3j0N9ZMhC2FztbtnYp+chjczi5HyBlK+3PFvi2ANNlq5tQILdR0?=
 =?us-ascii?Q?fr6mKm/OuPbhc017u2CvP8N4p8xIOs++nx0E0frn5Nz4WN/53rYfP6csoHgz?=
 =?us-ascii?Q?lgWRWXzMoUqmSMLY0ATmVJoc2L2EwSSkquRJRehPopD58nUv08sCbDVC6DYH?=
 =?us-ascii?Q?FR4KuGnP2RiZHDzMHMBp1LoH6NicA6ookK0RnLSNG+gHyUtOq8fiAKSjlEuM?=
 =?us-ascii?Q?5QNqOC4S3D8giLAFZX42rNpvI9rJO8p/DI8ElhTKSA72DFTeJyp4Ty8i82A?=
 =?us-ascii?Q?=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR02MB4157.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d5cd62a-ee33-4e50-5109-08de22ecb774
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2025 19:42:00.7938
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR02MB10195

From: Praveen K Paladugu <prapal@linux.microsoft.com> Sent: Friday, Novembe=
r 7, 2025 2:25 PM
>=20
> On 11/7/2025 4:16 PM, Praveen K Paladugu wrote:
> > Configure sleep state information in mshv hypervisor. This sleep state
> > information from ACPI will be used by hypervisor to poweroff the host.
> >
> > Signed-off-by: Praveen K Paladugu <prapal@linux.microsoft.com>
> > Co-developed-by: Anatol Belski <anbelski@linux.microsoft.com>
> > Signed-off-by: Anatol Belski <anbelski@linux.microsoft.com>
> > ---
> >   arch/x86/hyperv/hv_init.c       |  7 +++
> >   arch/x86/include/asm/mshyperv.h |  2 +
> >   drivers/hv/mshv_common.c        | 80 ++++++++++++++++++++++++++++++++=
+
> >   3 files changed, 89 insertions(+)
> >
> > diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> > index e28737ec7054..645b52dd732e 100644
> > --- a/arch/x86/hyperv/hv_init.c
> > +++ b/arch/x86/hyperv/hv_init.c
> > @@ -555,6 +555,13 @@ void __init hyperv_init(void)
> >
> >   		hv_remap_tsc_clocksource();
> >   		hv_root_crash_init();
> > +		/*
> > +		 * The notifier registration might fail at various hops.
> > +		 * Corresponding error messages will land in dmesg. There is
> > +		 * otherwise nothing that can be specifically done to handle
> > +		 * failures here.
> > +		 */
> > +		hv_sleep_notifiers_register();
> >   	} else {
> >   		hypercall_msr.guest_physical_address =3D vmalloc_to_pfn(hv_hypercal=
l_pg);
> >   		wrmsrq(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
> > diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/msh=
yperv.h
> > index 1342d55c2545..fbc1233175ce 100644
> > --- a/arch/x86/include/asm/mshyperv.h
> > +++ b/arch/x86/include/asm/mshyperv.h
> > @@ -181,8 +181,10 @@ int hyperv_fill_flush_guest_mapping_list(
> >   void hv_apic_init(void);
> >   void __init hv_init_spinlocks(void);
> >   bool hv_vcpu_is_preempted(int vcpu);
> > +void hv_sleep_notifiers_register(void);
> >   #else
> >   static inline void hv_apic_init(void) {}
> > +static inline void hv_sleep_notifiers_register(void) {};
> >   #endif
> >
> >   struct irq_domain *hv_create_pci_msi_domain(void);
> > diff --git a/drivers/hv/mshv_common.c b/drivers/hv/mshv_common.c
> > index aa2be51979fd..d1a1daa52b65 100644
> > --- a/drivers/hv/mshv_common.c
> > +++ b/drivers/hv/mshv_common.c
> > @@ -14,6 +14,9 @@
> >   #include <asm/mshyperv.h>
> >   #include <linux/resume_user_mode.h>
> >   #include <linux/export.h>
> > +#include <linux/acpi.h>
> > +#include <linux/notifier.h>
> > +#include <linux/reboot.h>
> >
> >   #include "mshv.h"
> >
> > @@ -138,3 +141,80 @@ int hv_call_get_partition_property(u64 partition_i=
d,
> >   	return 0;
> >   }
> >   EXPORT_SYMBOL_GPL(hv_call_get_partition_property);
> > +
> > +#if IS_ENABLED(CONFIG_ACPI)

Is gating on CONFIG_ACPI necessary? I thought this might be leftover from e=
arlier
versions when you were calling acpi_os_set_prepare_sleep() and
acpi_os_set_prepare_extended_sleep(). In my testing, this current version
compiles OK if the gating is removed and CONFIG_ACPI=3Dn, as the ACPI funct=
ions
you are calling have stubs in that case.

> > +/*
> > + * Corresponding sleep states have to be initialized in order for a su=
bsequent
> > + * HVCALL_ENTER_SLEEP_STATE call to succeed. Currently only S5 state a=
s per
> > + * ACPI 6.4 chapter 7.4.2 is relevant, while S1, S2 and S3 can be supp=
orted.
> > + *
> > + * In order to pass proper PM values to mshv, ACPI should be initializ=
ed and
> > + * should support S5 sleep state when this method is invoked.
> > + */
> > +static int hv_initialize_sleep_states(void)
> > +{
> > +	u64 status;
> > +	unsigned long flags;
> > +	struct hv_input_set_system_property *in;
> > +	acpi_status acpi_status;
> > +	u8 sleep_type_a, sleep_type_b;
> > +
> > +	if (!acpi_sleep_state_supported(ACPI_STATE_S5)) {
> > +		pr_err("%s: S5 sleep state not supported.\n", __func__);
> > +		return -ENODEV;
> > +	}
> > +
> > +	acpi_status =3D acpi_get_sleep_type_data(ACPI_STATE_S5, &sleep_type_a=
,
> > +					       &sleep_type_b);
> > +	if (ACPI_FAILURE(acpi_status))
> > +		return -ENODEV;
> > +
> > +	local_irq_save(flags);
> > +	in =3D *this_cpu_ptr(hyperv_pcpu_input_arg);
> > +	memset(in, 0, sizeof(*in));
> > +
> > +	in->property_id =3D HV_SYSTEM_PROPERTY_SLEEP_STATE;
> > +	in->set_sleep_state_info.sleep_state =3D HV_SLEEP_STATE_S5;
> > +	in->set_sleep_state_info.pm1a_slp_typ =3D sleep_type_a;
> > +	in->set_sleep_state_info.pm1b_slp_typ =3D sleep_type_b;
> > +
> > +	status =3D hv_do_hypercall(HVCALL_SET_SYSTEM_PROPERTY, in, NULL);
> > +	local_irq_restore(flags);
> > +
> > +	if (!hv_result_success(status)) {
> > +		hv_status_err(status, "\n");
> > +		return hv_result_to_errno(status);
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +/*
> > + * This notifier initializes sleep states in mshv hypervisor which wil=
l be
> > + * used during power off.
> > + */
> > +static int hv_reboot_notifier_handler(struct notifier_block *this,
> > +				      unsigned long code, void *another)
> > +{
> > +	int ret =3D 0;
> > +
> > +	if (code =3D=3D SYS_POWER_OFF)
>=20
> This patchset only addresses poweroff.
> Reboot currently works via ACPI. Nothing more is needed there.
>=20
> `kernel_halt` needs the use of a different hypercall. Support for
> Halting will be introduced later.
> > +		ret =3D hv_initialize_sleep_states();
> > +
> > +	return ret ? NOTIFY_DONE : NOTIFY_OK;
> > +}
> > +
> > +static struct notifier_block hv_reboot_notifier =3D {
> > +	.notifier_call =3D hv_reboot_notifier_handler,
> > +};
> > +
> > +void hv_sleep_notifiers_register(void)
> > +{
> > +	int ret;
> > +
> > +	ret =3D register_reboot_notifier(&hv_reboot_notifier);
> > +	if (ret)
> > +		pr_err("%s: cannot register reboot notifier %d\n", __func__,
> > +		       ret);
> > +}
> > +#endif


