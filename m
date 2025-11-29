Return-Path: <linux-hyperv+bounces-7900-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 13667C938BD
	for <lists+linux-hyperv@lfdr.de>; Sat, 29 Nov 2025 07:48:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ADA944E033E
	for <lists+linux-hyperv@lfdr.de>; Sat, 29 Nov 2025 06:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 800F92264DC;
	Sat, 29 Nov 2025 06:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="mUD8tU3K"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azolkn19010021.outbound.protection.outlook.com [52.103.23.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C20422154B;
	Sat, 29 Nov 2025 06:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.23.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764398920; cv=fail; b=jgn+Qo0M8BbntIEri6sid7gIkPBv5DVkqsZMjIZz83qKrhnUmGlZ8C9DrgssvFu7U/oSV7zzotYZzUAzxUP3qcEw7PCMpPMUpM4nKE73XzsSGL3LmFrEnxzDx3bUiV6XhEXMW6WhmlMEcGaJ30tcYqaeAcraqlu49E8YOobwbVo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764398920; c=relaxed/simple;
	bh=vTjjjZ9baRbJ2sP7iZ9rKL0TSIJP+R0cY3lwUodM50w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XW5jyP0K/42YVW7K8KZfeVgYjkSbJApLYSRsueNYG5uOOZfNwbUk3X89lSKlwci/4NBZrMX22xhW0HI8Niue4nwFlMVsbaEmij4ies+Im0PFPDZVDWP4g63GR9NnjTk6/n+ObA/wSnlh9ct5cO/IHopABlntjq85mjsMXsw4nCU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=mUD8tU3K; arc=fail smtp.client-ip=52.103.23.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m0k2R7fGz/HS9SBR/Nu77I1EefL6zMYEqwQqCs3ex4VhLAFM/luFsKwlgHgPhGgO+/RqxNAveM05j0AyK6ELlBkKa11059TPplBAEpSJ6rsvZLm7Pash81v/WfgrEuQftukiZRuSd9vmZG9kxGFPr9qRNF4G07iHZXCuMPAUxIvUAYUSWMCxLhVnBQnD65AvE4ObXvq92Rs7kQiWZN3yvKQrMZnz+QsRhU5cTRKGNrGmnCbVWi7NduhGmOTO/aXUubqhKJIGFM4wDKNQt3dKIk8kcEn8pIpRiuVmQxAc1KL1zJWBfBzNd0IbTFl/LKeK35z2je8zI3/wogG5b43/tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wkv+RbdrTIn4E5TA/ldArwN8eORktzMVaZ+suyTJIZU=;
 b=uk0jyEN6ACxeOnWu0igxfeQlKzDIhYI5oDxxUQlsd0HZvi5UX8vr+MEIE/A+TMtZTHLCJlcdIOYPHlYvPh2kbD2Oy0bBS//eK4wUz4/kMchCyfIjtaVkZBHkOQWurtF0H9Vsz7PAxNz8DqR8mn/tu66wc1kTskFmfos51glIJF15D6g2ono0D632qSoXt1Y4jOGSGB3AXDzn46D/73N5tQOOdCi+ARZvquNtoj6Acqw+B7ZY/e1TQo7p822GDdljkvvxqVUqOfYTiZ6O/oVoQ/Bv9v5uevaC5y1bvhtQni1HYxnYqlQgZJxZnSEArXFxjqq5ayfX+GEcrB0SHQnkcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wkv+RbdrTIn4E5TA/ldArwN8eORktzMVaZ+suyTJIZU=;
 b=mUD8tU3KxkDdiK0oYS+IsA44pKf8IpKYdSIkD9ZCd7Nglt+RerS4YaIj5miU1ss9iSEJ/mU2vYt3y5ZhXJBH2k4WJfjR35rDbCWciSxKOBNVh13HN+m0jJpUJzMUozessNfB4x53iooFx0ELHUXOJ4Q1IaOK97XRNd21tnwLY8wc0kjJMSMKsPM+nhjxbLv4IHtcb+xuo0fF9cOIZB2vlJ69B+k0bG3jUqj+LsEGpYZIvqYoe0scVKuHAZm28nGDo+ZKCGRnG/SYP3uYvZDUzbKqgQxmAjmFiQZ4CE4yMEJERqexWj3A4gygkDTJObcQBdKFpWEtyJBf8DtUvRlCWw==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by DM4PR02MB8936.namprd02.prod.outlook.com (2603:10b6:8:8b::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.12; Sat, 29 Nov 2025 06:48:36 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%3]) with mapi id 15.20.9366.012; Sat, 29 Nov 2025
 06:48:36 +0000
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
Subject: RE: [PATCH v6 0/3] Add support for clean shutdown with MSHV
Thread-Topic: [PATCH v6 0/3] Add support for clean shutdown with MSHV
Thread-Index: AQHcXx6xe4Ys3qrPJESaCCzD1Bsln7UJMHZg
Date: Sat, 29 Nov 2025 06:48:36 +0000
Message-ID:
 <SN6PR02MB415792702B78B9855485DCE5D4DDA@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20251126215013.11549-1-prapal@linux.microsoft.com>
In-Reply-To: <20251126215013.11549-1-prapal@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|DM4PR02MB8936:EE_
x-ms-office365-filtering-correlation-id: 90511b9b-a6de-42dc-b21b-08de2f135225
x-microsoft-antispam:
 BCL:0;ARA:14566002|13091999003|461199028|8060799015|8062599012|19110799012|12121999013|15080799012|31061999003|8022599003|440099028|3412199025|102099032;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?lSbirG22ARwk/v4ihvtKmeXO0blJzmaiAI8td2nQu3LReYX32Bi2GOW+M8zk?=
 =?us-ascii?Q?/0NjdiNR0XovffUeuFen+V06r1CSpkknwVXHxkHwydvnu7QS2CZzqhQOI564?=
 =?us-ascii?Q?j/19nrv3eAWHOijbezsBLYEZER6rAf+zhGWad4eZqT0YTLIn7Yz1PxnGRQ+U?=
 =?us-ascii?Q?p1YO1pEgK8VyS04LRGS8EmGZ2Ky9I6r9VDa5hYQ/cLQwdsKSKC6etRpM2J+8?=
 =?us-ascii?Q?B+YpuzQZWzM4JUHoENz6FD5oWwkJokRVnVkSaRC/rilKnnl6K5XaCeiLatTg?=
 =?us-ascii?Q?mDMNL/ULyqL8RB/3N87mkCcJ2WKb7+QQetI2bMogrn0gdHQZHR0cdUjDUrem?=
 =?us-ascii?Q?Yua3ISa1mkQEC34cGdh4y5KPgAkf7VqZM1FcPNeUKeqftlUiuXnIGib82/yL?=
 =?us-ascii?Q?tpSTP4Z0f1IA+02axoPSWP5Gua6f68OBPSxpN1ATQBuhCmPgeGgvsgEpchke?=
 =?us-ascii?Q?lkGGe+dHFqfT+xeASV8jvuGnZdELU8N9plkUS9+/RIfTot6/wDDQLqBWsG85?=
 =?us-ascii?Q?bfExSd0R8DFmDBqLYirPnLImyG7aLL/5p8O96UFiKNhC6d5IIChCz6EWcI5l?=
 =?us-ascii?Q?ux+NTzkVw8+4BpSv6+IBJQgSQn2ALS61nmu5VX6C9WDYRln8/JDqDVCFnu9t?=
 =?us-ascii?Q?fbZKPMV7hk13guNXJStbCxPHX9p2aniHQ7aRV748UvhteY/HlyfuJThtMjuN?=
 =?us-ascii?Q?O5h97nmyS2OV4dIDtygQa57eECmX5A7z903i8t1yFXygunTUeBhFaMSvX0uq?=
 =?us-ascii?Q?qyzjY9PRxEHFdVIpZ4UBTtamrU5KdqqLRMuLAlWWnl/ee+QuGM50bFdGcXex?=
 =?us-ascii?Q?JVC1tBxwt67F8Oo6qtqRgfHgNmOzE8Os8JEmGzajuilK2JRGiHA3RYl2RVLV?=
 =?us-ascii?Q?L2IhHS+0tPuRqmT4tAV37/nKTRiZjF5rUFgDzsPJMfIFEsnySJwUA6nUKmaR?=
 =?us-ascii?Q?tVq+dn1/2hRYBMv5m+H1WteuXMsAjp3a4iEH+aIzUos73yJSdtffW58Rme3R?=
 =?us-ascii?Q?BnZqCbHjrEtdu/8/Vm+pTswEz+wcxSta+SYcQTnDqwPhuXi6PS8bNQPQ0LGu?=
 =?us-ascii?Q?2xM4nL38AzuUwYkBVXboZGEUvbnHukgedVHJdIhiWZ6EXlfvS8FURrpoGZGH?=
 =?us-ascii?Q?MfICwykDIueA9Ss+SebRoUZ28eIj6LQB+zs9Ubz3/pRD19wXfbSR9EdCPgdU?=
 =?us-ascii?Q?LiqwxigGwIRGEVmFGOUbEsznLO0bqeIrRSziug=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?QnhUW1dRL54bo0s4864r3Ku7X7AdxV8ZH7EfRwqkargb04aXD+7D8fYKD2lW?=
 =?us-ascii?Q?kyC0CyFZkEJOewmmpJTM57N3wN/MGr5efKce6F/1U/6NefNMkXKDwXvIaklR?=
 =?us-ascii?Q?+f2x4A28B6vurlqEQYgGVIOHsQvqfp0kuiexcp266tJnJpiLdpuIJZWDJUHQ?=
 =?us-ascii?Q?VYbvhlGE0GYzwmc3S85ho/LLQrHiUi7F8V1ER6S9945mKwDKNiU0N+RAfvde?=
 =?us-ascii?Q?RKaU668jYbwOpJ05he3g7B8W7zp3f3sploPfpGbOqrEur4JUCJxcI0XPYPGQ?=
 =?us-ascii?Q?MyXSwZgQFRM4htHtYRRkvKZCCAeekJ9KzKYbaHjW2neLVxzEXbe2QTXEZDF2?=
 =?us-ascii?Q?SQ/YxctF+FSh2E7n5jfX2AGz6nWvUlhKMCfoREueoKW5/FRHr/aA683JQHPG?=
 =?us-ascii?Q?S8vfs1D+ypuij+T3WPVQf4rzmPw8HNuyyEIwmeVEGlGU5J78UX1Xf2fRo/RF?=
 =?us-ascii?Q?MJvv3gX267jKkUTPifGaaAmiLImQalGGDcYZ7gU91aV0L7s1pDz3/G2hPbEC?=
 =?us-ascii?Q?JrKqHahnKxQ/XRppEDpHt0ZxceijU9lweHYfuZj7e423jiBKFnqrxeVyzWns?=
 =?us-ascii?Q?dlJpQNa+mjUPa2UwzavC8PrnX6I6lLPBtJ2MoSLxVCHMZ9QNMZ+2off2niaZ?=
 =?us-ascii?Q?TMpQb2NGTf2npgGGcWcvOZPzh05uvs3oj04aMrkjlMNKN4toKUu52U10T8MK?=
 =?us-ascii?Q?YFKOvDP/xpqEWdbHRqRCLd79ig72LrLz5AvLtUwqrqlfjaWuMgKq8qnK+5bv?=
 =?us-ascii?Q?f9M9M8fzqbxWwuvuydoAJCIxbw30CuOFhLv1czijRkiJKydy/X9mY7ogTTd5?=
 =?us-ascii?Q?cQPt6WAeRKEEw/BTDxAbQ566zq50UksjlWAtg4U/ZPWQAM7rpr7PaOe1qoV1?=
 =?us-ascii?Q?VzaDGr+/6oKtCRhM9J5yE6FcnRL9uSY43/bpdZoBowvvhRURdkoPyKUkRqVr?=
 =?us-ascii?Q?VHh2IfZn7NZQF+R3k0zbVLWFSfOFDVFo3GJ64vAdBdtxDh1yVGdQdREAVI4n?=
 =?us-ascii?Q?3x1bvJSX1MKqPXMvrDnI3GE+VYpi/ijNhu0knsNGtaIqhd2trD7i7QPs3THl?=
 =?us-ascii?Q?OY1wJmZHb7hQHRDYpRXY4YH9fJuHfiEAD2cNFLbRS4Zz4JayPVUQAOaa1w7C?=
 =?us-ascii?Q?3KfKouDmqzFY9HoDwr/bhdoEMSuaIOyBshYC9umKTeN4DHglVOaI6gHwiDoa?=
 =?us-ascii?Q?4HFNxtgH1DvrDYdNHgoizTMzorx+1wRISx+C6iMOeTU4KRnvWUWAmzJc2oI?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 90511b9b-a6de-42dc-b21b-08de2f135225
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2025 06:48:36.1711
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR02MB8936

From: Praveen K Paladugu <prapal@linux.microsoft.com> Sent: Wednesday, Nove=
mber 26, 2025 1:50 PM
>=20
> Add support for clean shutdown of the root partition when running on
> MSHV Hypervisor.
>=20
> v6:
>  - Fixed build errors, by adding CONFIG_X86_64 guard

Adding the CONFIG_X86_64 guard seems like the right solution, and it does
make the build errors go away. However note that as coded in drivers/hv/Mak=
efile,
 the code under the new guard won't be built at all unless CONFIG_MSHV_ROOT
is set (ignoring the VTL case for now), which can only happen in the X86_64=
 or
ARM64 cases. So it was nagging at me as to why the guard is needed for an
x86 32-bit build failure reported by the kernel test robot.

It turns out there's an underlying bug in drivers/hv/Makefile causing
mshv_common.o to be built in cases when it shouldn't be, such as the x86
32-bit case. The build failures reported by the kernel test robot were on t=
hese
cases when it shouldn't be built in the first place. The bug is in this Mak=
efile line:

ifneq ($(CONFIG_MSHV_ROOT) $(CONFIG_MSHV_VTL),)

which should be=20

ifneq ($(CONFIG_MSHV_ROOT)$(CONFIG_MSHV_VTL),)

The buggy version has a spurious "space" character before the start of
$(CONFIG_MSHV_VTL) such that the result is always "not equal" and
mshv_common.o is always built.

If the Makefile is fixed, then the X86_64 guards you added in
mshv_common.c are not needed. Furthermore, the stubs for
hv_sleep_notifiers_register() and hv_machine_power_off() in
arch/x86/include/asm/mshyperv.h for the !CONFIG_X86_64 case aren't
needed. And the declarations for hv_sleep_notifiers_register() and
hv_machine_power_off() can be moved out from under the #ifdef
CONFIG_X86_64. The bottom line is that nothing in this patch set needs
to be guarded by CONFIG_X86_64.

Here's a quick diff of what I changed on top of your v6 patch set
(including the fix to drivers/hv/Makefile). I tested the build process
on both x86/64 and arm64, with and without CONFIG_MSHV_ROOT
selected.

diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyper=
v.h
index 4c22f3257368..01d192e70211 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -178,16 +178,15 @@ int hyperv_fill_flush_guest_mapping_list(
                struct hv_guest_mapping_flush_list *flush,
                u64 start_gfn, u64 end_gfn);

+void hv_sleep_notifiers_register(void);
+void hv_machine_power_off(void);
+
 #ifdef CONFIG_X86_64
 void hv_apic_init(void);
 void __init hv_init_spinlocks(void);
 bool hv_vcpu_is_preempted(int vcpu);
-void hv_sleep_notifiers_register(void);
-void hv_machine_power_off(void);
 #else
 static inline void hv_apic_init(void) {}
-static inline void hv_sleep_notifiers_register(void) {};
-static inline void hv_machine_power_off(void) {};
 #endif

 struct irq_domain *hv_create_pci_msi_domain(void);
diff --git a/drivers/hv/Makefile b/drivers/hv/Makefile
index 58b8d07639f3..6d929fb0e13d 100644
--- a/drivers/hv/Makefile
+++ b/drivers/hv/Makefile
@@ -20,6 +20,6 @@ mshv_vtl-y :=3D mshv_vtl_main.o
 # Code that must be built-in
 obj-$(CONFIG_HYPERV) +=3D hv_common.o
 obj-$(subst m,y,$(CONFIG_MSHV_ROOT)) +=3D hv_proc.o
-ifneq ($(CONFIG_MSHV_ROOT) $(CONFIG_MSHV_VTL),)
+ifneq ($(CONFIG_MSHV_ROOT)$(CONFIG_MSHV_VTL),)
        obj-y +=3D mshv_common.o
 endif
diff --git a/drivers/hv/mshv_common.c b/drivers/hv/mshv_common.c
index 28905e3ed9c0..73505cbdc324 100644
--- a/drivers/hv/mshv_common.c
+++ b/drivers/hv/mshv_common.c
@@ -142,7 +142,6 @@ int hv_call_get_partition_property(u64 partition_id,
 }
 EXPORT_SYMBOL_GPL(hv_call_get_partition_property);

-#ifdef CONFIG_X86_64
 /*
  * Corresponding sleep states have to be initialized in order for a subseq=
uent
  * HVCALL_ENTER_SLEEP_STATE call to succeed. Currently only S5 state as pe=
r
@@ -235,4 +234,3 @@ void hv_machine_power_off(void)
        local_irq_restore(flags);

 }
-#endif

The Makefile fix needs to be a separate patch.

I think I got all this correct, but please double-check my work! :-)

Michael

>  - Moved machine_ops hook definition to ms_hyperv_init_platform
>  - Addressed review comments in v5
>=20
> v5:
>  - Fixed build errors
>  - Padded struct hv_input_set_system_property for alignment
>  - Dropped CONFIG_ACPI stub
>=20
> v4:
>  - Adopted machine_ops to order invoking HV_ENTER_SLEEP_STATE as the
>    last step in shutdown sequence.
>  - This ensures rest of the cleanups are done before powering off
>=20
> v3:
>  - Dropped acpi_sleep handlers as they are not used on mshv
>  - Applied ordering for hv_reboot_notifier
>  - Fixed build issues on i386, arm64 architectures
>=20
> v2:
>   - Addressed review comments from v1.
>   - Moved all sleep state handling methods under CONFIG_ACPI stub
>   - - This fixes build issues on non-x86 architectures.
>=20
>=20
> Praveen K Paladugu (3):
>   hyperv: Add definitions for MSHV sleep state configuration
>   hyperv: Use reboot notifier to configure sleep state
>   hyperv: Cleanly shutdown root partition with MSHV
>=20
>  arch/x86/hyperv/hv_init.c       |  1 +
>  arch/x86/include/asm/mshyperv.h |  4 ++
>  arch/x86/kernel/cpu/mshyperv.c  |  2 +
>  drivers/hv/mshv_common.c        | 98 +++++++++++++++++++++++++++++++++
>  include/hyperv/hvgdk_mini.h     |  4 +-
>  include/hyperv/hvhdk_mini.h     | 40 ++++++++++++++
>  6 files changed, 148 insertions(+), 1 deletion(-)
>=20
> --
> 2.51.0
>=20


