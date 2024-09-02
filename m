Return-Path: <linux-hyperv+bounces-2925-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6A5F967E2E
	for <lists+linux-hyperv@lfdr.de>; Mon,  2 Sep 2024 05:35:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F38C428184C
	for <lists+linux-hyperv@lfdr.de>; Mon,  2 Sep 2024 03:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCC3E13AD29;
	Mon,  2 Sep 2024 03:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="daJ070KM"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azolkn19010007.outbound.protection.outlook.com [52.103.12.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0709013A88A;
	Mon,  2 Sep 2024 03:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.12.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725248117; cv=fail; b=oNDSHrp+3dKeTMBGHYd566y2ynWOnTuFttPiT4RU4gmLezoiFH3aql9XnNfTMcyu0yTn4OmdQAt6+LAfzWMTodOfPJySwX85olLH0gvyXAFbi6xuPz1Zcxol1N31DXf/j5K3ZD1XmKfot36Kw6XrvHOA4GAVUehGtNnWCYN3PQk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725248117; c=relaxed/simple;
	bh=rp6RQun22GuIz8xA03K7lMUOuBUW878M3UcW8P5JOVQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NrmOYjwdDvMegrmFHVE49X76KNjLpqGLUtwb3LmPLd7v2ikyQ2tf0YyHLJl017W2MovwvwYc11tAf/+NE9twmDYj54M2ROb28nZB8XhgvL5U4I2qzTozTZKcHqx2g16dnfdLDgUxdKAg33XmdulBXlRS57IhRKGE9fOZ+GpgSsM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=daJ070KM; arc=fail smtp.client-ip=52.103.12.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A20TFQtjK4F4P4p7dnAPepUO0xV6QCjmD1jP3QrVNS4Uec4Sh/79THPv2KXrf1JeI/SUwuLZITneanED29seAH3wsA5rhR5DwrtplwxhIGcRsPKmd4pMkClptU250pIdlbNuaIi3MeeVFz1fsBHngKMbIs6Q8bImKFtCYoz/W6fuu/d0jbnloO8ODI1oNJ2tqr9VD/kQSz9y/csVIHJwt3lUGVMN1OmcZLXVaR+HiOnE1QFiJzhUhXCA+oWBTZyX/UVrxzHyf2vKnb9gi+NLAe2Lg6mZ9VDWketZ2vFBF9qJNvnI3PumY7ZB4yv80LaS1JTE9TNOI13dLrWLheMblw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dZaQA057cdfGjhQ/YVawsvaVGfx2LNKFrNt5lNuKeSY=;
 b=nllqbyYAwRyBMN4VkJqUm8+/GW1RAmGbzR52KxhBheJxhe1gI0gtq2KuIcaJrDGDYrL2gC91GOdWPQdphS1e/9pSVti21u/yX9MCvKZmkqOgvGqojDa6cxPXAfm69wki0Jpyo8RxfzRmnQlwgM3FcuHSOgnNZ39hh85KXLMx5dS7HsrUDp/60w1KCmK7BfQjylB9Bt0a27Y3lsFgZSVFFXBdrODRIpQdSEH9P5rcVLZQF6hmN0+RlCg7xmoCue5r4Mv/maBf1oh7WJX7F8XBcWv0TLP6qmtmSEtwDPAiZCLuw5mT/ER9uW6XADhs3PbtcY7uDAfdLHSy16IBaiv9Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dZaQA057cdfGjhQ/YVawsvaVGfx2LNKFrNt5lNuKeSY=;
 b=daJ070KMRvnddk3cZyEEA0xHbRx2BSYKxsKUB1jIWHB+nXXeAtkI7wFk3odmHeqDrtIb6YCmYVOv5cRpPiVdlYj+KPBgXWbXdpafLn06saR7pHgDlfFIdCjlac09NGht7r0pSU6A9mxrS1yi6lAa/W6a9kDZF7u18LD7PAkjphPVJ9MHpOSUlQiOh/qniyzH9pAJXqetLktdAVZph47blp4XrrVCE9RMDMUDVhDwjp0asz3ozi6YkTIO/1ooSs1KZ71e8BEkY1Kc+zlZOq6qbt2d2uoVmxT+OCWgQBWgZEud3SVZ38YwJhTcmF2URk9eEbYKa/Yxxnxx8BYTOlUzaQ==
Received: from BN7PR02MB4148.namprd02.prod.outlook.com (2603:10b6:406:f6::17)
 by SA1PR02MB8655.namprd02.prod.outlook.com (2603:10b6:806:1fe::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Mon, 2 Sep
 2024 03:35:13 +0000
Received: from BN7PR02MB4148.namprd02.prod.outlook.com
 ([fe80::1c3a:f677:7a85:4911]) by BN7PR02MB4148.namprd02.prod.outlook.com
 ([fe80::1c3a:f677:7a85:4911%7]) with mapi id 15.20.7875.019; Mon, 2 Sep 2024
 03:35:13 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Yunhong Jiang <yunhong.jiang@linux.intel.com>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de"
	<bp@alien8.de>, "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
	"robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"kys@microsoft.com" <kys@microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>, "rafael@kernel.org"
	<rafael@kernel.org>, "lenb@kernel.org" <lenb@kernel.org>,
	"kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: RE: [PATCH v2 4/9] x86/hyperv: Parse the ACPI wakeup mailbox
Thread-Topic: [PATCH v2 4/9] x86/hyperv: Parse the ACPI wakeup mailbox
Thread-Index: AQHa9bO0nzfAUElulUSDKnXvnxUSrLJC/MhA
Date: Mon, 2 Sep 2024 03:35:13 +0000
Message-ID:
 <BN7PR02MB4148CC3F9091BC2604E457CFD4922@BN7PR02MB4148.namprd02.prod.outlook.com>
References: <20240823232327.2408869-1-yunhong.jiang@linux.intel.com>
 <20240823232327.2408869-5-yunhong.jiang@linux.intel.com>
In-Reply-To: <20240823232327.2408869-5-yunhong.jiang@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tmn: [+KC5F93PM8l7dzX0LNF03lfr8+liQrUq]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN7PR02MB4148:EE_|SA1PR02MB8655:EE_
x-ms-office365-filtering-correlation-id: 3761d8bb-17fa-4720-a837-08dccb004103
x-microsoft-antispam:
 BCL:0;ARA:14566002|15080799006|8060799006|19110799003|461199028|3412199025|440099028|102099032;
x-microsoft-antispam-message-info:
 z8VxAB+Kuw57AzC96rIODW62wg8XZZwvmgbXc1kHngh/zt17iRpbV+M6fkpz729YMGKtR6E0q2CvYO/23N622jM+gODzm57eFICsQyBkuO9zpR9ZFO/N3JTTyGGTqzdQQxvSCjNS6r+5VHdFbC11rNWNma6VZUb1AALJUMMg8t0bLnCoXz4ihmT8TpO059Xv6ErKQSGRg3gviEpfrxPvKsrkL11ymVY6ifk5horgxGt1UpoibY/Wnqog3UF0Z5g+wwlYYOMlI63vW8XYGpu/84Hkhr/AUmv2uzIxzWgktZa/GAoWdY1SwxIP/okuDs+U8gm27uYK7fK4j84WT9hC7+xAWjMakukzGGD0hz5dH0EcYsWfqs2rmOC6GDs1SaFKBJqTcVwmjS4Nw6ijlmM6wdId8kJejMNDxHBPW7FrFAOJSkb3EUOTtCIYJOCeC+a5r61eRJOxWWTRYCIHrCHYKQupHWTDHpjnoEbslt9ilZbm3ezOv4EGaQiO/Rf0bNOoYQKpW4PtmVJItVZmIeI4E4xT8Z4rZYXbzHRS9EmBUt4XcLzlWazVMytDbnjR8aIsLUWVcw7ZYwdev47tDj52Ycu71ETulaXn4BVI4IHwHcqWKezrlKrRIRGZulOvsrwYrHM5Ia9SDP9vdnF7z576PQ6JcHQ7XAkFKZwB9y7ig1sQiVBRaZ80b962vF/JxGeG
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?iW6JFPHaxIwdbD1FlXYqZW5Tp/AC3lzqseQK2+AyK5ArOH+a4Uy6hqxzV47g?=
 =?us-ascii?Q?kFjJ4D0zCJK9YiCPOof3DQUlkYsyCzDjrUdWcTGokQyhc8arQfN6HTBLt0MQ?=
 =?us-ascii?Q?TF4tTNH8S3e7Qhte2thYhCb5t0qrWmqYE4+TWRgebTeOFFQ4qCw5sQuFxDsD?=
 =?us-ascii?Q?RY2N+odqqFsUCRski8zbwElILh754WpLQ6UhoE2tVa5bB3CtEUSZL66nKTuQ?=
 =?us-ascii?Q?Gf5ueceTAAvKKP3H8cYe3tMqws7RxW0x/qoQllmIROzkU6DVVQ4Wua6cp0/n?=
 =?us-ascii?Q?Pr+pKtMy+4VGa5C+HmMThgX3vjs+q4qwU59YszP04FTvT5Nd69B4cREoDSZl?=
 =?us-ascii?Q?zwyFyvfMrtrwgkMvNUj/39q7eIV1dvj0WyNqYtaHqYKmD5kP58OsedVMU1pI?=
 =?us-ascii?Q?B8xIuUekQ6LmPQTwxMz6Mwqr2Td/kmzeY+AUSUnNaFqYmdKRTJJCdX/w/uo0?=
 =?us-ascii?Q?1GkRKCzvi3qdmmMaBtnfY22p3H42+yxwoFexJzMIQAtacH4OErBT+kHCje9U?=
 =?us-ascii?Q?1TyUHeg4s1Ao0+Jj9scbQWIhUXeFjBkdZCJk0GoOxAU4xy0Rtq2z75pLq6OB?=
 =?us-ascii?Q?k5MBH36XK8FkFR6gsvaKv5SsGGoA8yQBQ/llhM3oknoLuw04u4U7FfidDv1g?=
 =?us-ascii?Q?jAdOSSLwG0RODZGJsG4wk2nI5vJ6eMDdQAsDi18WHQtWYnHIKa0JbsSK3rfN?=
 =?us-ascii?Q?4v6nBtj6EFdS1qrq5ZAkRWzR93MOa0g1CVJhMkif82+ICscI0O3T0sMEuF+H?=
 =?us-ascii?Q?m+y/GiTD6iGSV31pEkXV115s6ZhNFO1WaaZ9VG5REIDb1CGtzoig+tQJBKsS?=
 =?us-ascii?Q?zImJ6o0t+xa2OQKpjFnxYboIgm4cnJ32RpPsG9ksvjFn+OBEBJU7ROq1caA9?=
 =?us-ascii?Q?/Psl8C3n5QeqIZG4jvO+5WytMxPwgfpV+PUEvdMdB0TZMNBr1pru0iwwqLrH?=
 =?us-ascii?Q?KP8Ib3/jjiCBVeDqz/N2PfyZiA9FPXVX+zWx6VFSwEZVBgx9zi1bfhJCiT7C?=
 =?us-ascii?Q?v9l9YeHmdyn+hwxhO4cmMezDSGWepPTl9dO7YMO7QnlIKv0uHYdePgzdUt1J?=
 =?us-ascii?Q?XOd0LRvOTg30fOrwkr/e6MU90SPo1gyU5T/9u74BdY4DjFFgr6kDLlTmaFDu?=
 =?us-ascii?Q?pSew3KioxHw6yVPrxfSlzX8S3rIlRsh3w3yq7wvNN1+i5mbA1i3QO7g0U4yY?=
 =?us-ascii?Q?OS8g5yVc/I2rjGFjybaBOhuMSigSSoffzSJnYnMMlWXYaHDMYE7t45LyCtU?=
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
X-MS-Exchange-CrossTenant-AuthSource: BN7PR02MB4148.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 3761d8bb-17fa-4720-a837-08dccb004103
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2024 03:35:13.0427
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR02MB8655

From: Yunhong Jiang <yunhong.jiang@linux.intel.com>
>=20
> Parse the wakeup mailbox VTL2 TDX guest. Put it to the guest_late_init, s=
o
> that it will be invoked before hyperv_init() where the mailbox address is
> checked.

Could you elaborate on the choice to set the wakeup_mailbox_address
in ms_hyperv_late_init()? The code in hv_common.c is intended to be
code that is architecture neutral (see the comment at the top of the module=
),
so it's a red flag to see #ifdef CONFIG_X86_64. Couldn't the
wakeup_mailbox_address be set in the x86 version of hyperv_init()
before it is needed?

>=20
> Signed-off-by: Yunhong Jiang <yunhong.jiang@linux.intel.com>
> ---
>  arch/x86/include/asm/mshyperv.h | 3 +++
>  arch/x86/kernel/cpu/mshyperv.c  | 2 ++
>  drivers/hv/hv_common.c          | 8 ++++++++
>  3 files changed, 13 insertions(+)
>=20
> diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyp=
erv.h
> index 390c4d13956d..5178b96c7fc9 100644
> --- a/arch/x86/include/asm/mshyperv.h
> +++ b/arch/x86/include/asm/mshyperv.h
> @@ -10,6 +10,7 @@
>  #include <asm/nospec-branch.h>
>  #include <asm/paravirt.h>
>  #include <asm/mshyperv.h>
> +#include <asm/madt_wakeup.h>
>=20
>  /*
>   * Hyper-V always provides a single IO-APIC at this MMIO address.
> @@ -49,6 +50,8 @@ extern u64 hv_current_partition_id;
>=20
>  extern union hv_ghcb * __percpu *hv_ghcb_pg;
>=20
> +extern u64 wakeup_mailbox_addr;
> +
>  bool hv_isolation_type_snp(void);
>  bool hv_isolation_type_tdx(void);
>  u64 hv_tdx_hypercall(u64 control, u64 param1, u64 param2);
> diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyper=
v.c
> index 3d4237f27569..f6b727b4bd0b 100644
> --- a/arch/x86/kernel/cpu/mshyperv.c
> +++ b/arch/x86/kernel/cpu/mshyperv.c
> @@ -43,6 +43,8 @@ struct ms_hyperv_info ms_hyperv;
>  bool hyperv_paravisor_present __ro_after_init;
>  EXPORT_SYMBOL_GPL(hyperv_paravisor_present);
>=20
> +u64 wakeup_mailbox_addr;

This value duplicates acpi_mp_wake_mailbox_paddr in
madt_wakeup.c. It looks like the duplicate value is used
for two things:

1) In hv_is_private_mmio_tdx() to control the encrypted
vs. decrypted mapping (Patch 5 of this series)

2) As a boolean in hv_vtl_early_init() to avoid overwriting
the wakeup_secondary_cpu_64 value when
dtb_parse_mp_wake() has set it to acpi_wakeup_cpu().
(Patch 9 of this series).

Having a duplicate value is messy, and I'm wondering if
it can be avoided. For (1), hv_private_mmio_tdx() could call
into a function added to madt_wakeup.c to make the
check.  For (2), the check should probably be based on
hv_isolation_type_tdx() instead of whether the wakeup
mailbox address is set.  I'll note that Patch 5 of this series
is using hv_isolation_type_tdx(), so there's a bit of an
inconsistency in testing the wakeup_mailbox_addr in
Patch 9.

This is just a suggestion, as I haven't worked out all
the details. If you think it ends up being messier than
the duplicate value, then I'm OK with it.

Michael

> +
>  #if IS_ENABLED(CONFIG_HYPERV)
>  static inline unsigned int hv_get_nested_msr(unsigned int reg)
>  {
> diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
> index 9c452bfbd571..14b005b6270f 100644
> --- a/drivers/hv/hv_common.c
> +++ b/drivers/hv/hv_common.c
> @@ -365,6 +365,14 @@ void __init ms_hyperv_late_init(void)
>  	u8 *randomdata;
>  	u32 length, i;
>=20
> +	/*
> +	 * Parse the ACPI wakeup structure information from device tree.
> +	 * Currently VTL2 TDX guest only.
> +	 */
> +#ifdef CONFIG_X86_64
> +	wakeup_mailbox_addr =3D dtb_parse_mp_wake();
> +#endif
> +
>  	/*
>  	 * Seed the Linux random number generator with entropy provided by
>  	 * the Hyper-V host in ACPI table OEM0.
> --
> 2.25.1
>=20


