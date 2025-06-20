Return-Path: <linux-hyperv+bounces-5974-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF06EAE1108
	for <lists+linux-hyperv@lfdr.de>; Fri, 20 Jun 2025 04:17:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0022E19E2789
	for <lists+linux-hyperv@lfdr.de>; Fri, 20 Jun 2025 02:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13FEABA36;
	Fri, 20 Jun 2025 02:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="lzgJ8qBF"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02olkn2051.outbound.protection.outlook.com [40.92.15.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D74E1386B4;
	Fri, 20 Jun 2025 02:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.15.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750385867; cv=fail; b=ZaVVk+FmDp6FcouQH99kWUxsR3K0JzvsL5Ie0j10J23CiYizv0km+nk3gWJ40Uivbtv+/7iHr3OPEd2yoWZC2JQLjQRKQQ35sHQmgpy6sBCTwV9WmRgrOxuMRjzFdofERciGUL/GPHIdMXKupJTuDNjTiCAYxQQwS0V+jWLbLa8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750385867; c=relaxed/simple;
	bh=xBjAOvz26oWZtn04drzrZChQtRBLW2zxng7xgVkp1WA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dBzfkqDcERBiprgaP4TafgCyxHyMJV7bBrw3NVxx0BMLeAM2w8aG8dK78gcuY8JL0n2DeB9dFNOiRh1wKMCj/V2Sry9PvrZPrI8c8MUAqQtlr6+SJntaDReimLKTDXhn1+Kd/FVBx6dAM7j4tw8g78B2+k86ifLmTx7beaYJIQc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=lzgJ8qBF; arc=fail smtp.client-ip=40.92.15.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mz1wI4aDiobq6JP5OxBn5KLE3BnZ+0amJfQLnSJ/Ji6o3jg7Sa2/ddALgH02T3LxAqCj6L7jtcLku11VURSfagweWCXV3kDVaeNzszunLdsW9ooxFUSh9UnPsSaRuhauQ0kiLNLXnDfbmknV0XLDVJRwyH46YGJFc2lDFHmCBFRNfS3xR9PVsLxDI9gOOeb5wXp7eD27xcRKFYKI/v1nJJcdU/yS6t7AVXjY+Gs28oXMWGvOcsEpoNKzn9uMYLVc3vBxjkkRX+7jaBMQHVUlQ5LxIsg7vdkDY6Ys7Lc/aq5XnRDu5Ij/H1IUyzfbKUm5nC07cyyKb+7l/EGBrTrlPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Myp6DwVKc187/KOhK1Qv6ZfmZIieDYF6JafQZ0HWoU0=;
 b=Sq6afXFqASjCxpSL3jR8T9bcDeF7Xq07prsJPJdtL6aTf/gb6t/lotXFlw8MtdoTDMjIqFy4yghwRdR9dFI1aFJ220iK9KKooCpDN6i5yF7P1bKoRQhQFA0+PTffb7M17TQHE1NFXGi4zxXr7zHZD2hnj79nmcOaeXN4UixBuBFfZSHKu9iERQDhBbqb2ToWIE8e5plsdCVlKmVJRP20L5uKO3EH9j2xK8uwuZLGxFLMOEHxNUBK8qz6gKNiMwZPnR59jwNmt0ciMlnC2pGDVKVPp4D8CT0ioAQljyaxDSfFNTAw/KerNMaQn6ehif6EVEEW47laXNpjsH/3nbsSKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Myp6DwVKc187/KOhK1Qv6ZfmZIieDYF6JafQZ0HWoU0=;
 b=lzgJ8qBFjk/vVwm6DYRFZHWp3TT7NQpmnR0aqljgQB/iBDyvv45b9Tt+40AKwrSDmXB0g7fRWNJjXCELJhXgTQSNZa9EwuVgmNegyZZqyTQ9qGuiZSrjZloI5Hw6HXTZLqedq+C3sa7jW3GElDx5X0KoS9KErqqZBdUjrf8IOZFfi/KCMMZVVKKFlTQVDMpIWSPrMGZ4goJlw2paZA8UYGEGvIX9EFflMa0DsMgfjCM/Zzu11AYcvUkyhM65il9kUOAVsR8DTKpNJG1Gbd4eWpM+gq1nipWWwDto1PbEcnawNSF4cnO9yEQMVc//33xTQOjCZXJiyOh3S3ziFlNYjA==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by BN0PR02MB8206.namprd02.prod.outlook.com (2603:10b6:408:151::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Fri, 20 Jun
 2025 02:17:42 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%4]) with mapi id 15.20.8835.027; Fri, 20 Jun 2025
 02:17:42 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Tianyu Lan <ltykernel@gmail.com>, "kys@microsoft.com" <kys@microsoft.com>,
	"haiyangz@microsoft.com" <haiyangz@microsoft.com>, "wei.liu@kernel.org"
	<wei.liu@kernel.org>, "decui@microsoft.com" <decui@microsoft.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com"
	<mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, "kvijayab@amd.com"
	<kvijayab@amd.com>, "Neeraj.Upadhyay@amd.com" <Neeraj.Upadhyay@amd.com>
CC: Tianyu Lan <tiala@microsoft.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [RFC Patch v2 3/4] x86/Hyper-V: Not use auto-eoi when Secure AVIC
 is available
Thread-Topic: [RFC Patch v2 3/4] x86/Hyper-V: Not use auto-eoi when Secure
 AVIC is available
Thread-Index: AQHb3FOmU6o5oxrqU0yX8LvkSQ5Y8bQKsMiQ
Date: Fri, 20 Jun 2025 02:17:42 +0000
Message-ID:
 <SN6PR02MB41570F86633D660CD61080DFD47CA@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20250613110829.122371-1-ltykernel@gmail.com>
 <20250613110829.122371-4-ltykernel@gmail.com>
In-Reply-To: <20250613110829.122371-4-ltykernel@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|BN0PR02MB8206:EE_
x-ms-office365-filtering-correlation-id: 10b5951c-8e3d-4101-bd85-08ddafa0a348
x-ms-exchange-slblob-mailprops:
 qdrM8TqeFBvg+tg/MNoCQ4s7gWjgMwzwj9qqZ5d9RGK1LGHNpgqtj6XGuliCuF2bUmsoas3DVCAk6Gl08cyfKzInCqWmVLfU//XuMQvm2+jN0h1XIx0+Obt6YAiqKgO0PfHoIC15rFoegUaa04dAjnjBolnoUBw+55JXhM+in7Vin66WQ+7+mXSoFL8MSvIVeaEJAL+WuFkDjE/5YJwd+e1KOQ5WkrepsF9Ni6svPxh5NUkg4V0fzI2/5Vu9G25Jhf2DnJ3FSTKdgZcBCxTghfp+PMqxk0PCN+kFfSeoqJmF9CqgJC21C6c5ECaESPpBplrlC9DSsNOIEjFJ1rCZgVaQ79yRHa8/c7TaZgaH5FV7NjJfsNt0qo5dDD3h0hEKFT7apdUuREiasmIgoUW6FP7S017tlz/lx/vRu0XgCgDZJttrhsbGWJaeOf7xso0IQqkQwHeeWeEU4GPgXj6GylWwfg52y4KGBmXTzWGhPXr5crdqpn5a5au6Xoi6l/rR6N7eyj1rzobFJYJGKvBSNfqUgVAvDA7MUw7qi3J43oyeRfMspS83KeqBsSK8KU8arXcwVDalk7mWJ535anw+N8tne0r3X5cSA5Is/ifGj2U0Xb8vVAVfJ+wPs8IVyE2VNtzm47CspInw2D9MTouTZvMCcLCHQ5Jxuc/UFdYsxZReMF9HfbYTTpkrb25oHAMPRMk9jzC/EnBJpBd7H5d1HRPKGexiizFZEO42EJPoDTA0NZLIcA2+k7MpCHkKDvzYJ5Lf0d8ckFLKdzYwwnuRduOi/dbya3EH
x-microsoft-antispam:
 BCL:0;ARA:14566002|8060799009|15080799009|461199028|19110799006|8062599006|102099032|3412199025|40105399003|440099028;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?AGnL2waPwNW6f5cRUa/4zopVq54fsWG2J3U0EeaSOlY2yiBHILUFUDT2SjrJ?=
 =?us-ascii?Q?TUpo/PrvNut3fl6VBswFssmFhDWrk/3V6HvzRLcOgVSkUH58DfzeTGr0rSH6?=
 =?us-ascii?Q?Wu2aXnfqbm9LEtssywH+HOzGICJo3ctXonPAJHnUQi9BmX0H3BX3YCyLpV9u?=
 =?us-ascii?Q?bHGmvVZovK5fLHN68JgtEj9weRktDCNfTtKYZ2GbESzVEcIsROzujBrH3fZQ?=
 =?us-ascii?Q?ufyOul1hvcirdqcVJ9snJFo9Xgn4KoKef97YuL03OmLYb/nWGas1M9o3h5vo?=
 =?us-ascii?Q?WaS6qpjrHM3LnvhQ0ocrPGULCJpgqt0agWnGQpCyovEOKMyJs5eu2Ulkj66c?=
 =?us-ascii?Q?cKOQ3zJO0T5MVkHB2hTbROPrJkmkmkgX2DeG60cmahBsBhH1zXQSpbCNj7+E?=
 =?us-ascii?Q?CHy0OZl3n3CLBM8fITa6Wl8ocNxSwv9iRznGC5mhg9CfQ2dHMZzpEOhuI5c/?=
 =?us-ascii?Q?gNdggIB8bQbbel+0yTLkr54NS6ML41cEf0N7vuRcQ4MTMu9g6SYuEW2dL9v7?=
 =?us-ascii?Q?TeUypBwNWnDBJkcDB34MHicogbf5A/R79vJ6z3rGOYWSVille1GnS2eoa9dk?=
 =?us-ascii?Q?8paRrpbgzJjYyXq2PFBY5P8MIFCAgcYh873Kklmbq0lwj+X72ehDjSRiT/4k?=
 =?us-ascii?Q?+mG/yn+m4RCwwPtDUJDMyyp1YCLMFXXxHuUXVFwh1BgoUqJK/efWBYWmdUSw?=
 =?us-ascii?Q?r/WjYgYhMC4Wr86WIwbplDR4ZkLlBeFZcNr4U1lj6R7ww/NN7/ns/n45Wgrr?=
 =?us-ascii?Q?flA834/NkY3JSdZka5eJhZbBOkjsRyeJIoCr6E74gnY6Lvm99I37o1EV4Qs0?=
 =?us-ascii?Q?XQQJSJidjYwhT0sl/X+x2Oke6s1uSEk0L6PMAp7PgzJNvjyLrsX2g08X7LRu?=
 =?us-ascii?Q?IQCsObi+xvhI0uOxpWYE2heet8SAW/DSgSdb5RjC/Z00ZSJJ6DSHIMVWKfmc?=
 =?us-ascii?Q?vYW39ymWwI+ltumRl7f8ULte3zB4JLHuZyzm8QeZDgng/hZ2ChvYbgtIsUcT?=
 =?us-ascii?Q?qYs8bZahrJKMlMrv2CKDAGKMse0vmlPDSMuyZ17gfdIrB/GZPvF1WMXuzGXx?=
 =?us-ascii?Q?YYwp/AOfQwhyC1JB+VjcNkQE2vHefinVhEpwAhonDx7X6WQXUCo=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?z71zTcdrGT/ZMuDYrChhHkd+vXh9v1AAi2HeOuRWmMEzPxqNan8JGrIigmE5?=
 =?us-ascii?Q?N4g6WM4YhAR8rviyGrBiuGapi2nINqQpuPJo3vSTiCYKKlckXdP+U7k8ZEvC?=
 =?us-ascii?Q?tbFy9D56+u3l/iOXVaSCsdcaTa+itCxEREyB2QYiCBF9gn8AHjdxxdT0zVcU?=
 =?us-ascii?Q?/s2NjPgnXGS3vZwd8Q25aKRaCjWxPCXRsywTdAJCyfItqw1ItKoTR52wsLny?=
 =?us-ascii?Q?f7TtSTImD1PjT+TRzzPD09rjS0ftVp0MPbM5u0+HhIQ48iXAP9i8dx0H1y6E?=
 =?us-ascii?Q?8UkMqTz/DPeqE/uncGF0OxAQc81FKJWXfscegahpc6WcviHCyQloX4ueNew+?=
 =?us-ascii?Q?KydPSwrU+xIKUEy0Wex3lLQsEpNindxEK3lolbY8odCFjxVr8VrcIDxv2Ic2?=
 =?us-ascii?Q?mjMXHhr7jGbQPCJBNldFVcoHmxuZut+zQd7msFBiOfOM7MJ6NgAe9uF07zzb?=
 =?us-ascii?Q?mwmclOk1S7nN++QCNT1nR3jPvAv/lcAEx/jWp+8KuqIOfrfdlKGL0D5IgDwC?=
 =?us-ascii?Q?iuHb1b751k6zwLf624nUo1qh0+iWaBQk+Ruij6XnrGWiaGnJntgK7gjLRdff?=
 =?us-ascii?Q?M5icZ9FgeGpipXUzoplIpYt2c2ugI1FaRoQMOjS4VDTR9Cm8b0GuIpscyDkC?=
 =?us-ascii?Q?DLuG0xhq13edU/UjQA5+pn8vqEP0XzjOtFXgvZMt63+xgIc1nCI9ekeBYHtN?=
 =?us-ascii?Q?ySHxgHGdiUBoKNb/mSV1GRGMvgzPHQVUHmpGr+jdTqDEklV0Af+7LQ03dL2w?=
 =?us-ascii?Q?XcicxWkie5NyFqze97f8hgBI2fQSi6AFzVLlE2DVySEcCzS4R8jNF2O1PlQe?=
 =?us-ascii?Q?Nj1dgW+eVtjHe3Scp6Wp7bh34taLmWIQkFXg1x4ZbAAPiWkGp5SLX+YGvnXe?=
 =?us-ascii?Q?C6FjIolSrDv7wCSxnmF2b1Dt0Si3zhefNQGzJy9qBcBhzYUf+98SOV4GL3W3?=
 =?us-ascii?Q?+M52XR4kxRCsKJQ5SfisHH9cw4+EZzmLSEbsTFonPiByd2PglAqDjdPNsqFo?=
 =?us-ascii?Q?A00inkzpTI9QquIRVpqe0Y+L1qFBMGifgu+dPeFV8qVAfGFioZbiNNe+BdF7?=
 =?us-ascii?Q?HdMDdwhzUhGn5PN87rLJRQsv7CfeOl9G7SJH0cLSyFyCwdJsO3J2kPzX4mLv?=
 =?us-ascii?Q?RhyE2YXixivRIjIWOcZ8yCj0998LFyZ5RYH0s7fPiqZmVDvY3FSob2s1KYWd?=
 =?us-ascii?Q?wvWjneAetjJW+PrfoJJYCEfZ/BI6N16pShXbr1TrnPkQbPN03nMNLkuyftQ?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 10b5951c-8e3d-4101-bd85-08ddafa0a348
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2025 02:17:42.5170
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR02MB8206

From: Tianyu Lan <ltykernel@gmail.com> Sent: Friday, June 13, 2025 4:08 AM
>=20
> From: Tianyu Lan <tiala@microsoft.com>

Suggested Subject line:

x86/hyperv: Don't use auto-eoi when Secure AVIC is available

>=20
> Hyper-V doesn't support auto-eoi with Secure AVIC.
> So Enable HV_DEPRECATING_AEOI_RECOMMENDED flag
> to force to write eoi register after handling
> interrupt.

Wording:

Hyper-V doesn't support auto-eoi with Secure AVIC.
So set the HV_DEPRECATING_AEOI_RECOMMENDED flag
to force writing the EIO register after handling an interrupt.

>=20
> Signed-off-by: Tianyu Lan <tiala@microsoft.com>
> ---
>  arch/x86/kernel/cpu/mshyperv.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyper=
v.c
> index c78f860419d6..8f029650f16c 100644
> --- a/arch/x86/kernel/cpu/mshyperv.c
> +++ b/arch/x86/kernel/cpu/mshyperv.c
> @@ -463,6 +463,8 @@ static void __init ms_hyperv_init_platform(void)
>  		 ms_hyperv.max_vp_index, ms_hyperv.max_lp_index);
>=20
>  	hv_identify_partition_type();
> +	if (cc_platform_has(CC_ATTR_SNP_SECURE_AVIC))
> +		ms_hyperv.hints |=3D HV_DEPRECATING_AEOI_RECOMMENDED;
>=20
>  	if (ms_hyperv.hints & HV_X64_HYPERV_NESTED) {
>  		hv_nested =3D true;
> --
> 2.25.1
>=20


