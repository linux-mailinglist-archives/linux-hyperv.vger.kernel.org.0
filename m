Return-Path: <linux-hyperv+bounces-6508-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9440AB1DE4F
	for <lists+linux-hyperv@lfdr.de>; Thu,  7 Aug 2025 22:27:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E311162717
	for <lists+linux-hyperv@lfdr.de>; Thu,  7 Aug 2025 20:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 665514438B;
	Thu,  7 Aug 2025 20:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="dHjFN+FL"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02olkn2012.outbound.protection.outlook.com [40.92.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C589482EB;
	Thu,  7 Aug 2025 20:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.44.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754598457; cv=fail; b=mnPsGOKWMhLdFp00X4cMiBzw97iu5V1iEQCeISx48VyaZUJJ4x5jMK+4PkzY9rePwtPuNeZ7+NifqfL1Up8igeFVeD4CfaDv6xe7MnS066dxl3Ke+lcaq9RSbC/SHypTm+MYCvT7Sko7DH+gK8cAKkPJQwuim84RisQamcyeGN0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754598457; c=relaxed/simple;
	bh=GPg/GEP1txUSGsoHhJo7OZ3jEwULlg8tsfrP12Xzhd4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=P00cv+mkXILb/6eUcbUC1Gfjgk/Z1HLYsB2sVcAk234VBIVf6Wqbfj++gXvYAZXYsgfa8GyZp1iWHZJJz+lAfZbko1MhbLumBFPDVhCfWLOwJkoRB1kTPwiCiGi/ab3jKzTP5J/aK48qUstDSrOcdQUORH0PWMt+TnH1ly5NfHc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=dHjFN+FL; arc=fail smtp.client-ip=40.92.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iucy9TReLpwloHASbvcPzlYEMGXlH1U4ZRuMw3F9x44jlkujPJGD5jYBh8A5i88SEvlza4LTN5QgLvXoM01vtf64b8pVUj/G1zKfKwhSEdQv5NjrsccyoCgDKqCnv0TRGElBRm8qfyknBSAWcIZU7G6mzuuHiH39O4VWIZdrSZaYniYftHBofC7fJ+0lEMLKxQbhULrhdgJhqnRu0yLuQRHs5UlQi9XxAHf68rSxoAW/ytV0KpDMwO4XYjROegufKOBhPqZAlyk/AsTR+P8LKMwa4oMZVYl87Edw7RizzQyYpUCwrewHw5Va2GGNZNQbSJARX83c5OVGB468l1yDKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8kyZ6oosmiG0QAIpd1Gz1JjACpWoQU8pAFN6sNZkjBA=;
 b=NR2Y2/dam0z/ZJrDAMwxMpFE/jHd4LxdPSeHDdpgUsoXp8QWIVkNIVn5QBrVlzknLtcoCe/Yg+SnWGmjt14BcGsDv2MO5BBLI/auc7uhRKM8mvIKId9N7SeC00UHrhFSqkRNd8qSmameZwlV3phLxDd+mMMfdcIc5NkHZjpf2yOwyfa7bvq6GWEQQZVYhhk+ZMZBiBCLeqmft1grEln7JY9fYkA7e4chBPfOuJKhEmJExQSYTPEdyMJbGKta2kMya1HEi1vBix9Rbzd+qtBfCZFCOiNcRWfPe8ul/ls34ycqdlARGakEWRCiUNpodJRRkJPm2wNV700iRpS8XkvTww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8kyZ6oosmiG0QAIpd1Gz1JjACpWoQU8pAFN6sNZkjBA=;
 b=dHjFN+FL1SWrIb1ZcZ+f0xlzSKXgKM86DeapBB8R3DeBKMHQIBO1plTPcebkoCQCnf7tMOoy9aIEg3y/hoDrYfKmlpUyzzWXdVKiJrK+FTfqecTwlHWWBJxUxVlt2j2QNO/AbiHnOpcUof7jYACOSkSljsJTKm5kVedxc6h3dfgs9It/WumhIudffE1jASZPAxSDM0xmMk7fs7PQO1xu4fdjS1UB0qcQ1eLC7OMN3JwkLYntn2k8cvnJfX7QFSdbhl6ut5ARGqSgEBDVXhGPjWZARs/alaKTrk1LInz669Voh6284KfSxB6If41YSdLV0dbbbnYl62dgv00eykxfNw==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by BN0PR02MB7885.namprd02.prod.outlook.com (2603:10b6:408:148::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.17; Thu, 7 Aug
 2025 20:27:33 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%4]) with mapi id 15.20.9009.013; Thu, 7 Aug 2025
 20:27:33 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: "wei.liu@kernel.org" <wei.liu@kernel.org>, Linux on Hyper-V List
	<linux-hyperv@vger.kernel.org>
CC: "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang
	<haiyangz@microsoft.com>, Dexuan Cui <decui@microsoft.com>, Thomas Gleixner
	<tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, "maintainer:X86
 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>, "H. Peter Anvin"
	<hpa@zytor.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, "open list:X86
 ARCHITECTURE (32-BIT AND 64-BIT)" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] clocksource: hyper-v: Prefer architecture counter when
 running as root partition
Thread-Topic: [PATCH] clocksource: hyper-v: Prefer architecture counter when
 running as root partition
Thread-Index: AQHcB7yPjc9ici+kvkGUOSXJK4d+QLRXm4UQ
Date: Thu, 7 Aug 2025 20:27:32 +0000
Message-ID:
 <SN6PR02MB41578685EF8F664D77DF2156D42CA@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20250807165846.1804541-1-wei.liu@kernel.org>
In-Reply-To: <20250807165846.1804541-1-wei.liu@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|BN0PR02MB7885:EE_
x-ms-office365-filtering-correlation-id: b4c6fa0d-b659-4bf1-3893-08ddd5f0d6d2
x-microsoft-antispam:
 BCL:0;ARA:14566002|19110799012|8062599012|8060799015|461199028|31061999003|15080799012|3412199025|440099028|40105399003|102099032|56899033;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?LQUC1XrEgPnkia1U9OcZelz3yPxbRP9lZzRKFFhhQeo/wPUeX358yA31RYaJ?=
 =?us-ascii?Q?ktqcRMya+dA2/IazYIJFvs2vZQBSM7L/BkinuUFtNVKlm1PMenV1KbieVatb?=
 =?us-ascii?Q?b/RplaXHuhWI+NM9JzHGq1M9/war88uDfkGOyLe4qzCrroLfEwXOmKOZzKta?=
 =?us-ascii?Q?hNagM/x1fNbuUsatZEsEnY/+b9lGZW7h8dkfc6SQG3GU53yYHXjFVhOwMtAa?=
 =?us-ascii?Q?7MgrslMl52yG8O7Cq3Q9Ay3QhWvuIS7a5EEmlg+W1M3C55E7MORufxFD7oS9?=
 =?us-ascii?Q?xe1uemvE4VmkYntxLttw6bjniKTxn1quWZD5n8s9GYcZvPM8PPRoA2yFKEWs?=
 =?us-ascii?Q?NAWfQH7tNBAa1zJfhJ2NVtYP42DTC5561MTRMVayK7BisOkwD8QneeuROTt8?=
 =?us-ascii?Q?QddVuAFByfTo/BIjoCXkKXOmTyHxBsJnnjqlaHJp1gxMyFCQsU1fV6x8AB4U?=
 =?us-ascii?Q?5cXnNMWDhyFHiEQ0ePDzO297DWIPj50/Kad/8GPTdxTxZysIhOsOSHJyeSBe?=
 =?us-ascii?Q?moGMJmjwWUtv3O+dSeNshhcgB/kWiQcuHV3BX2VTf3oZ219Q20iesosQgMpb?=
 =?us-ascii?Q?q0CUMysPjAf/N+p/jvatfzpXUFgHJiBSLg8TI4LnpGXSuRhAkCPJbKCqylEH?=
 =?us-ascii?Q?xT3sdVIhVDr1eCddEI+qNxrDe05dPfcCKhtdYcHKbS+Y/RqdPnYhtLiT1AY9?=
 =?us-ascii?Q?oXAxMjzLmia0vNS/3gQcyuLZKX+lDypWrJuCXWrMclzSM6VHoBNNmOKh+U8R?=
 =?us-ascii?Q?8jSnX/9bnQ+B7MuO2nQUhCBI7K4ywkz9o9hhbNj/C5ONn1fEPy/L8E20hVDJ?=
 =?us-ascii?Q?qS6bAUNDconlRZUBtbLBHUWAtpAx246MvGXNjnVVneZvJKCf2+E/dDk7xibL?=
 =?us-ascii?Q?0499qdIV2xHWgRtej1nuXwwzQqyG8hDZ9cZzubJRsK4//r6Y9sek8cUdVcFj?=
 =?us-ascii?Q?xpDlXu7o6jodeAeLcSpXxre5gDf4UPwvQHtvxhiniB8QQyk3sz5qV0qJVZC9?=
 =?us-ascii?Q?QbUBl0VXsK44xv3A43fFCjr2Q7mR90QHq2EueVY+Ym6I52foDtIt84MRF+TQ?=
 =?us-ascii?Q?D4WHo+8XSXELQXnO7g7bHH4fZV3RE2YbTAH6J5Q/J424QkZZsUFhkdf/vFhZ?=
 =?us-ascii?Q?AcaKOjgCFkE/Snnx5LV8j7HBi16s3WaAgw=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?2JoXKm59pbmg0o/J5249gjmnQWr0YlzYHYhpH7XGrW4E+pZ8A1QREWh2Pl7A?=
 =?us-ascii?Q?Z40l+6wiKUifI65CeKtK0u0Mc/JzIKIPiH5K1Z3K38UJxdhZG4pUhpMFzUuU?=
 =?us-ascii?Q?7fa/HK5vZYz2XmtvvQQkN7Q1YHhdpqw1MU+ATBehofoHyAshC6WGobKDOM3w?=
 =?us-ascii?Q?Ca2uAoU0OPTGKRxAXaRNBPNnRLGt1C7k4fch9tiPmW+ZJG60C/f6a90Aklui?=
 =?us-ascii?Q?xY7wIouVDVSPprUJbguu3NhO17thjDkGO6zsVApsTKc9TPxxN05N9z5TfzaS?=
 =?us-ascii?Q?scC0EBjjE33QSm1g5ANP4mYkvnfb59I34kytdfNGlXHynnG6U+SDdUN5PnzP?=
 =?us-ascii?Q?O8i5Plm0mpcvlnuTG/dOrvVzaxleqyLD/PzdLptoS9cNTGL93PtN5FbEIIaW?=
 =?us-ascii?Q?6g8KGZ1dBigu+nsSuaJlOoidO/oZ+uT0E4xfdlKW4+1SZJ1yOSpjBdjykeXH?=
 =?us-ascii?Q?qsloAnpdLAlI/g7vGrVv5qjNaYsS/FNV1PV2r4tSwi9wgWL8Q7+6YxXXcvMr?=
 =?us-ascii?Q?2lmKcf2ZDuY9K3iztkjy6/684UTYnIRJFWXrz5zEYwKAMzJ8+pI9/2RWTstq?=
 =?us-ascii?Q?CrgCk+/xxZSLIf72f26oczT4hmM7rItuFX5/yVAH1NujkkAoEsX1ZxhTQ60w?=
 =?us-ascii?Q?95BeA8Ihjjk4mHO+p65XZq2Gtiiy9xahfY+NPxDMX0oihUfAUlMzkE1z/45A?=
 =?us-ascii?Q?0H9En2jYiB8JoDF2ZJyZsMZMW2p6tpuc6FAU8PgZiisx76f1GYd/lh/S2bIo?=
 =?us-ascii?Q?ghiU2k3LVM2qlJ8Q6KPEuvj8ADzc+PfesLH8zLMJZGGFHKCu99Mff06l+FAL?=
 =?us-ascii?Q?xBFswAxOooXJAaVl+OPcRhzklq6LRWeNeByGvmgrhvHJKG564BRb2qbaUNQ/?=
 =?us-ascii?Q?J/gwBB2s64GuWivussglQXQCvO3UDy/t7njjisXjGeTCb97+ZBuvPVrsQLkG?=
 =?us-ascii?Q?QhClGc2Z5fAhkhoC3V0puMPpVQeTDHIYHySt/4WUejwz4fzv6sV8okBm9S3A?=
 =?us-ascii?Q?0n8xgujIlXCZUtr4Xah0oRg7HJaBOT+mHdDKJVKwHHD6EszX5w6TmS8RckYY?=
 =?us-ascii?Q?mUG03nPoT6WGPbsVR3bKHjdEAyUOTJrjFkIw0oy2JLE9TFQKBNlhG+FKHXeG?=
 =?us-ascii?Q?mrR+uW2oB8d/f7vTpTbDkMMZ5nS52yOokZBjtN0sBh7Vyk1j6irXvw3KWsBF?=
 =?us-ascii?Q?pTf/Dg63PqAFav/6TiMOYElJoicL7jDR8c4nkccE3Z17UFTsWLRYrPSJWp0?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b4c6fa0d-b659-4bf1-3893-08ddd5f0d6d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2025 20:27:32.9401
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR02MB7885

From: wei.liu@kernel.org <wei.liu@kernel.org> Sent: Thursday, August 7, 202=
5 9:59 AM
>=20
> There is no HV_ACCESS_TSC_INVARIANT bit when Linux runs as the root
> partition.=20

Some clarifying questions here: When you say "there is no
HV_ACCESS_TSC_INVARIANT bit", does that mean that bit 15 of the
HV_PARTITION_PRIVILEGE_MASK is just unused and undefined?

And what is the behavior if the root partition writes to
HV_X64_MSR_TSC_INVARIANT_CONTROL? In a normal x86 guest,
HV_X64_MSR_TSC_INVARIANT_CONTROL determines whether
CPUID 0x80000007/EDX bit 8 is set. What will the root partition see
for CPUID 0x80000007/EDX bit 8? Whatever the underlying hardware
provides? See also the comment in ms_hyperv_init_platform().

Michael

> The old logic caused the native TSC clock source to be
> incorrectly marked as unstable on x86.
>=20
> The clock source driver runs on both x86 and ARM64. Change it to prefer
> architectural counter when it runs on Linux root.
>=20
> Signed-off-by: Wei Liu <wei.liu@kernel.org>
> ---
> Cc: Michael Kelley <mhklinux@outlook.com>
>=20
> Pending further testing.
>=20
> The preference of architectural counter over Hyper-V Reference TSC for
> Linux root is confirmed by the hypervisor team.
> ---
>  arch/x86/kernel/cpu/mshyperv.c     |  6 +++++-
>  drivers/clocksource/hyperv_timer.c | 10 +++++++++-
>  2 files changed, 14 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyper=
v.c
> index fd708180d2d9..1713545dcf4a 100644
> --- a/arch/x86/kernel/cpu/mshyperv.c
> +++ b/arch/x86/kernel/cpu/mshyperv.c
> @@ -966,8 +966,12 @@ static void __init ms_hyperv_init_platform(void)
>  	 * TSC should be marked as unstable only after Hyper-V
>  	 * clocksource has been initialized. This ensures that the
>  	 * stability of the sched_clock is not altered.
> +	 *
> +	 * The root partition doesn't see HV_ACCESS_TSC_INVARIANT.
> +	 * No need to check for it.
>  	 */
> -	if (!(ms_hyperv.features & HV_ACCESS_TSC_INVARIANT))
> +	if (!hv_root_partition() &&
> +	    !(ms_hyperv.features & HV_ACCESS_TSC_INVARIANT))
>  		mark_tsc_unstable("running on Hyper-V");
>=20
>  	hardlockup_detector_disable();
> diff --git a/drivers/clocksource/hyperv_timer.c b/drivers/clocksource/hyp=
erv_timer.c
> index f6415e726e96..59c3e09f1961 100644
> --- a/drivers/clocksource/hyperv_timer.c
> +++ b/drivers/clocksource/hyperv_timer.c
> @@ -534,14 +534,22 @@ static void __init hv_init_tsc_clocksource(void)
>  	union hv_reference_tsc_msr tsc_msr;
>=20
>  	/*
> +	 * When running as a guest partition:
> +	 *
>  	 * If Hyper-V offers TSC_INVARIANT, then the virtualized TSC correctly
>  	 * handles frequency and offset changes due to live migration,
>  	 * pause/resume, and other VM management operations.  So lower the
>  	 * Hyper-V Reference TSC rating, causing the generic TSC to be used.
>  	 * TSC_INVARIANT is not offered on ARM64, so the Hyper-V Reference
>  	 * TSC will be preferred over the virtualized ARM64 arch counter.
> +	 *
> +	 * When running as the root partition:
> +	 *
> +	 * There is no HV_ACCESS_TSC_INVARIANT feature. Always prefer the
> +	 * architectural defined counter over the Hyper-V Reference TSC.
>  	 */
> -	if (ms_hyperv.features & HV_ACCESS_TSC_INVARIANT) {
> +	if ((ms_hyperv.features & HV_ACCESS_TSC_INVARIANT) ||
> +	    hv_root_partition()) {
>  		hyperv_cs_tsc.rating =3D 250;
>  		hyperv_cs_msr.rating =3D 245;
>  	}
> --
> 2.43.0


