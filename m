Return-Path: <linux-hyperv+bounces-1679-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 567A3875703
	for <lists+linux-hyperv@lfdr.de>; Thu,  7 Mar 2024 20:22:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AB321C20A45
	for <lists+linux-hyperv@lfdr.de>; Thu,  7 Mar 2024 19:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39D07135A56;
	Thu,  7 Mar 2024 19:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="becw++JD"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11olkn2010.outbound.protection.outlook.com [40.92.20.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 293E02574B;
	Thu,  7 Mar 2024 19:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.20.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709839342; cv=fail; b=SNbu+8hfjA/8h4m7k5nXwuMq7x2UWFJszUxvJLFx2hG28z8V847gmhGNchcNGMRGCWgUkqceW/+aiYnnSV7idzipATGNgsR6bNahIANNj6xhxshGeMlzvDoXRXKxvE8Jnm6DrzFvdb+plBgwP0sCQ+hQbmJY+BlF8JLTZTwJCHw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709839342; c=relaxed/simple;
	bh=0WdsKOB26F997LnoBfOvIsNrFjMQut4AC7bzWMGdfFs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=j6D9QBpKq0BUd1ScHJ9U5+i6AOI1ewXxSxOvOG2E7jLpmObuFPbJ5RxMqKhSOeuRpA2mj813ZJKiGnsDFKGTVNlFw3RsK79IeC7iBT9//gKdUMzpk1OFpJNjnLsto6LifAF4o1nuPsW9yRm6p4iQFUHM+hd4d/KrxExcYL6l7fM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=becw++JD; arc=fail smtp.client-ip=40.92.20.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VnvO4/ycPe3hA3TU7e+Vu1Gpb8kxmLfVl4wX3/eOygdy21VeV7VT7Gkiy29+td9FjwAksH6lU/QAsvfHHSWXvDrLSsn3Ep1KgVMpXPeIJMUDJV5SxrPaMlebjVrM/K8V1aFh4a2K8kRqfz0i6GMwUMMQ1EgtNjas2MupR+CUdMCLW8SpBxlPHsfb1wjDy54Piq+dyKwJa9dVaoJzrrfzH1T0n0R4uWLEo2e46+ZQML7ITBJAfTN4VNHI4+m7m+LArgfa+iFwdJyo2qK99KZpaIgX2c48HkCfi80u7OBB8hUfBZqlSaM0ByiXXGzzUeQp/sVvQYUWDspoA8UI1iDz/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UUZnBEz95OUZPkryA4SJK5pmDhFdW6xpqvzAySjlGT4=;
 b=kodFUJwCQwjm+FiiX4GG6GXgq8oJfCgL8by/6GVrMjalad4R3GZkdBKtK+7uq3vQOt44ALkg4NaEFXQ02oIagpH+UZOyKYpPh6PwgdrXhwVuaMxIFRqOXM3MSV1/KErSmYAetXsjx03NSGanx5ScEUpEJKXf4WfV/2Rjq+m3iiMsnmGTVh6PM7T7IoXcgqw3RDPGHPYeXVg552czqZiAqVRqKE/sdARJgMASDeGPnK8bbjupiIrBga45SEf8I4Zc5cPmf2zTyiwRhOb6ZYNQHB9JrjowaiYTXcn3U3j9jfQzNmRCmZccKa2watMCyj3s7RVkmrzMR1A9Lb/HsKnIAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UUZnBEz95OUZPkryA4SJK5pmDhFdW6xpqvzAySjlGT4=;
 b=becw++JDtfN+CuEIbG0DtVpc6vPtdkWywImQhf3oBSho7brFTHuoPHCNIPCFdgTxz5samD25wCGrkut3bDkmQ7hcnqpjnaxYFcOvv7pfengOb1JqqrvcR0Hg3HYKxafyK9VrhauZuFgI/PxTidcbfGYOD26QVnyBwi0ML5aDwRpAD5hyuKqDRyMkzMfE1mVRohQOENRpY02YfNn+z2kJAqe+35wRcsvryYQpeZMTsHdaOC9oizIbSocaAtzvTDTw86o2hpyVC4AXpXH+B+53UXYoaL9KOrvkFj38tqDne6O/3f0w8kEAO+ID4TAzqhYJiqs2ry8TJbqgPXMgA6iAHA==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by CH0PR02MB8118.namprd02.prod.outlook.com (2603:10b6:610:10b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.27; Thu, 7 Mar
 2024 19:22:17 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::67a9:f3c0:f57b:86dd]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::67a9:f3c0:f57b:86dd%5]) with mapi id 15.20.7362.024; Thu, 7 Mar 2024
 19:22:17 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "mhkelley58@gmail.com" <mhkelley58@gmail.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "kys@microsoft.com" <kys@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>, "decui@microsoft.com"
	<decui@microsoft.com>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "arnd@arndb.de" <arnd@arndb.de>
Subject: RE: [PATCH] mshyperv: Introduce hv_get_hypervisor_version function
Thread-Topic: [PATCH] mshyperv: Introduce hv_get_hypervisor_version function
Thread-Index: AQHacCkXRLZn90Nzd0e0IGhecFdkYLEspa9A
Date: Thu, 7 Mar 2024 19:22:16 +0000
Message-ID:
 <SN6PR02MB4157D470D0E46FA9B2ACD8EBD4202@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <1709772454-861-1-git-send-email-nunodasneves@linux.microsoft.com>
In-Reply-To:
 <1709772454-861-1-git-send-email-nunodasneves@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tmn: [y5RF2zfTHcyMFtcxiFT44aJQlcZCLWJ7]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|CH0PR02MB8118:EE_
x-ms-office365-filtering-correlation-id: 509ff0cc-fdee-4f9d-fd49-08dc3edbe6a8
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 UBcbIU5+gfOcTaeoEjDXxpv8Zn8io366Eh12qV7jrjd77mqgEG3+xk71xVU8kR2FzKaaLEiLX76Z7iGYJqOlJnKVpSz+gDxtbTpntVPpw5oor5X0c4gXXblHblEMDQvXUHi/zLpv8ZGIsRcmt7VURVx5CGQOU94Cz9YbUJS+3465TKhftT011XT7g79Njvc/FkL4g/o5e467JQg+fa01xLVV4vftCmxRJWyPbxM1br8V4bMu1uPOBeZrrTRZHZ3G9dCBdbvQWv54o/iKU5snd2UlIV8UlO13SLUpXU6fNS48x3JXrV2YTZEZb6QiJtoqmC1TPy4o1ModaZaYco9A0qAiP9qgDTH3VWUm7YIV4fDn51/XafOPxkVCEHoBBnCbLxGlrM8H8AXw0GmXenSKz17T9Xv1KoGMOi9pEbU6sbdxzg8nHkfuCkiEu/dGtu/JcG9ky/mwXcZiYubIjvOEvlAU4GKeBOBPS34V2HULlal6YKdTQF//V3xhGR4DDVS9o9i7xZgx505Oe+FbPCn9dyy2ICO26+FuN3gjdX9dEuWyY185U+kE1NG10so890vW
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?dOL/eDtVEU0kzRXYVFgewCjtsVS9pRcu0xg6RlR7/S9oHk4JICwXky8Kfjl2?=
 =?us-ascii?Q?BScW1qVqKoqZ6S5PMUCrbcNnvggU8WnkrrjVQwE9N78ZCrUJD7VSCfhHE5oW?=
 =?us-ascii?Q?JCch6i0asWR5rsthUVi/BlAS1bX+cPydJXrx34L1S0Pf6HwQw3MFvcGSmn9H?=
 =?us-ascii?Q?akIdp1PSA6m7CfPDsiv1Dq6RqvcaXFktH4VFvrtufLXSQHDcwmLZJmvGVU9V?=
 =?us-ascii?Q?Z+ZcB4iAzWooFk7VJXHGarGcV1WPZUXCA+ndl0JxPKxLCCOEsnLz+bStyjEo?=
 =?us-ascii?Q?EESaOmt7rLkrhhWbaryGfdY2Iy4hsl5VSaOIxM1lVYq77XXx04UiLM1af3Sb?=
 =?us-ascii?Q?tWqLC6gxTHFuVekEAMmdR2+g7Ykc6zTUjhzO6N4Omik/DcK1ev0cDZBMZK0W?=
 =?us-ascii?Q?6UA3WFDme8w+nr230+DE2fbllr0e4Hb4ES3sNkzyiR3ftbW6RxSxzvFcZaGX?=
 =?us-ascii?Q?duxmH2PrXP6K2sCx7/zHs/pwShKi6B+3eWgNCHWp4JaWUePnA+KauTX7Bx0x?=
 =?us-ascii?Q?mHutFsmkhvZDiplfRblwakPiWQGIu+tzgytuIBHVpL5ueWE3TQYCZYR3UjWO?=
 =?us-ascii?Q?NXkCIRwTU3iUdGE1/jnzlYX/WDq9TuWwLI/F2WYn2H1mD+7+dpzT/5IhpIFs?=
 =?us-ascii?Q?GsM2bTp4fdPO0vrY1ZgORPxq2Xqrsa3zyHXfxGWfVK6iCtroH+rtZO1YWwzd?=
 =?us-ascii?Q?W6uMgKwFjZtg5eoDruIZlCSOgYMx+sGG8BEA/lCEODuKWObv0+7cLxzdkQdl?=
 =?us-ascii?Q?8n6S7v7qf/q+VJEbfnemC1sodeU9rD+sOcHlR/XC29N4AksrrrpinayqmqtB?=
 =?us-ascii?Q?xJHGOGr19hNEYJR7iG53U5/7bMpqIs3kEX84P018cdotY/JXiVqf55x9opVR?=
 =?us-ascii?Q?YXpQZULyz5vamot74jD2rosVmj0sFPPFRPxV9h9pf2G8IcnCxQMjmLiL8rEJ?=
 =?us-ascii?Q?iIHGz/yiFyYK8QRyb4kHQTEqfbsEbaCkdUIAiqmilKd0LqS17VVTnPVHf5Vo?=
 =?us-ascii?Q?wv3d8w9WxhV9C3APAo9PalCJ6TGpKS5xe30uM/qemKbbqjaC8iZg2chPPS7w?=
 =?us-ascii?Q?8O4BXIlE2aHQG+VK2ZvdOVBJ4cfY3iZXwI5VLZxM5gW6fCoVsErEu7xd1rfJ?=
 =?us-ascii?Q?5aLHfprlxBuvCyrz4FbFilc+ixLzkw5GmHGhYD+ieS6XWdh0zJRIQTphh/6l?=
 =?us-ascii?Q?8ruaVE7z6PedNlewYXS+KjumG2SrirP2gGkl4A=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 509ff0cc-fdee-4f9d-fd49-08dc3edbe6a8
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2024 19:22:16.7824
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR02MB8118

From: Nuno Das Neves <nunodasneves@linux.microsoft.com> Sent: Wednesday, Ma=
rch 6, 2024 4:48 PM
>=20
> Introduce x86_64 and arm64 functions for getting the hypervisor version
> information and storing it in a structure for simpler parsing.
>=20
> Use the new function to get and parse the version at boot time. While at
> it, print the version in the same format for each architecture, and move
> the printing code to hv_common_init() so it is not duplicated.

Isn't the format already the same for x86 and ARM64?   A couple of
years ago they didn't match.  But that was fixed in commit eeda29db98f4.

>=20
> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> Acked-by: Wei Liu <wei.liu@kernel.org>
> ---
>  arch/arm64/hyperv/mshyperv.c      | 19 ++++++++---------
>  arch/x86/kernel/cpu/mshyperv.c    | 35 ++++++++++++++-----------------
>  drivers/hv/hv_common.c            |  9 ++++++++
>  include/asm-generic/hyperv-tlfs.h | 23 ++++++++++++++++++++
>  include/asm-generic/mshyperv.h    |  2 ++
>  5 files changed, 59 insertions(+), 29 deletions(-)
>=20
> diff --git a/arch/arm64/hyperv/mshyperv.c
> b/arch/arm64/hyperv/mshyperv.c
> index f1b8a04ee9f2..55dc224d466d 100644
> --- a/arch/arm64/hyperv/mshyperv.c
> +++ b/arch/arm64/hyperv/mshyperv.c
> @@ -19,10 +19,18 @@
>=20
>  static bool hyperv_initialized;
>=20
> +int hv_get_hypervisor_version(union hv_hypervisor_version_info *info)
> +{
> +	hv_get_vpreg_128(HV_REGISTER_HYPERVISOR_VERSION,
> +			 (struct hv_get_vp_registers_output *)info);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(hv_get_hypervisor_version);

I don't think this need to be exported, at least not for the usage in
this patch.  The caller in hv_common.c is never part of a module -- it's
always built-in. But maybe you are anticipating future use cases
from a module?

> +
>  static int __init hyperv_init(void)
>  {
>  	struct hv_get_vp_registers_output	result;
> -	u32	a, b, c, d;
>  	u64	guest_id;
>  	int	ret;
>=20
> @@ -54,15 +62,6 @@ static int __init hyperv_init(void)
>  		ms_hyperv.features, ms_hyperv.priv_high, ms_hyperv.hints,
>  		ms_hyperv.misc_features);
>=20
> -	/* Get information about the Hyper-V host version */
> -	hv_get_vpreg_128(HV_REGISTER_HYPERVISOR_VERSION, &result);
> -	a =3D result.as32.a;
> -	b =3D result.as32.b;
> -	c =3D result.as32.c;
> -	d =3D result.as32.d;
> -	pr_info("Hyper-V: Host Build %d.%d.%d.%d-%d-%d\n",
> -		b >> 16, b & 0xFFFF, a,	d & 0xFFFFFF, c, d >> 24);
> -
>  	ret =3D hv_common_init();
>  	if (ret)
>  		return ret;
> diff --git a/arch/x86/kernel/cpu/mshyperv.c
> b/arch/x86/kernel/cpu/mshyperv.c
> index d306f6184cee..03a3445faf7a 100644
> --- a/arch/x86/kernel/cpu/mshyperv.c
> +++ b/arch/x86/kernel/cpu/mshyperv.c
> @@ -350,13 +350,25 @@ static void __init reduced_hw_init(void)
>  	x86_init.irqs.pre_vector_init	=3D x86_init_noop;
>  }
>=20
> +int hv_get_hypervisor_version(union hv_hypervisor_version_info *info)
> +{
> +	unsigned int hv_max_functions;
> +
> +	hv_max_functions =3D cpuid_eax(HYPERV_CPUID_VENDOR_AND_MAX_FUNCTIONS);
> +	if (hv_max_functions < HYPERV_CPUID_VERSION) {
> +		pr_err("%s: Could not detect Hyper-V version\n", __func__);
> +		return -ENODEV;
> +	}
> +
> +	cpuid(HYPERV_CPUID_VERSION, &info->eax, &info->ebx, &info->ecx, &info->=
edx);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(hv_get_hypervisor_version);

Same for this EXPORT.

> +
>  static void __init ms_hyperv_init_platform(void)
>  {
>  	int hv_max_functions_eax;
> -	int hv_host_info_eax;
> -	int hv_host_info_ebx;
> -	int hv_host_info_ecx;
> -	int hv_host_info_edx;
>=20
>  #ifdef CONFIG_PARAVIRT
>  	pv_info.name =3D "Hyper-V";
> @@ -407,21 +419,6 @@ static void __init ms_hyperv_init_platform(void)
>  		pr_info("Hyper-V: running on a nested hypervisor\n");
>  	}
>=20
> -	/*
> -	 * Extract host information.
> -	 */
> -	if (hv_max_functions_eax >=3D HYPERV_CPUID_VERSION) {
> -		hv_host_info_eax =3D cpuid_eax(HYPERV_CPUID_VERSION);
> -		hv_host_info_ebx =3D cpuid_ebx(HYPERV_CPUID_VERSION);
> -		hv_host_info_ecx =3D cpuid_ecx(HYPERV_CPUID_VERSION);
> -		hv_host_info_edx =3D cpuid_edx(HYPERV_CPUID_VERSION);
> -
> -		pr_info("Hyper-V: Host Build %d.%d.%d.%d-%d-%d\n",
> -			hv_host_info_ebx >> 16, hv_host_info_ebx & 0xFFFF,
> -			hv_host_info_eax, hv_host_info_edx & 0xFFFFFF,
> -			hv_host_info_ecx, hv_host_info_edx >> 24);
> -	}
> -
>  	if (ms_hyperv.features & HV_ACCESS_FREQUENCY_MSRS &&
>  	    ms_hyperv.misc_features & HV_FEATURE_FREQUENCY_MSRS_AVAILABLE) {
>  		x86_platform.calibrate_tsc =3D hv_get_tsc_khz;
> diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
> index 2f1dd4b07f9a..4d72c528af68 100644
> --- a/drivers/hv/hv_common.c
> +++ b/drivers/hv/hv_common.c
> @@ -278,6 +278,15 @@ static void hv_kmsg_dump_register(void)
>  int __init hv_common_init(void)
>  {
>  	int i;
> +	union hv_hypervisor_version_info version;
> +
> +	/* Get information about the Hyper-V host version */
> +	if (hv_get_hypervisor_version(&version) =3D=3D 0) {

The usual idiom would be:

	if (!hv_get_hypervisor_version(&version)) {

> +		pr_info("Hyper-V: Host Build %d.%d.%d.%d-%d-%d\n",
> +			version.major_version, version.minor_version,
> +			version.build_number, version.service_number,
> +			version.service_pack, version.service_branch);
> +	}
>=20
>  	if (hv_is_isolation_supported())
>  		sysctl_record_panic_msg =3D 0;
> diff --git a/include/asm-generic/hyperv-tlfs.h b/include/asm-generic/hype=
rv-tlfs.h
> index 3d1b31f90ed6..32514a870b98 100644
> --- a/include/asm-generic/hyperv-tlfs.h
> +++ b/include/asm-generic/hyperv-tlfs.h
> @@ -817,6 +817,29 @@ struct hv_input_unmap_device_interrupt {
>  #define HV_SOURCE_SHADOW_NONE               0x0
>  #define HV_SOURCE_SHADOW_BRIDGE_BUS_RANGE   0x1
>=20
> +/*
> + * Version info reported by hypervisor
> + */
> +union hv_hypervisor_version_info {
> +	struct {
> +		u32 build_number;
> +
> +		u32 minor_version : 16;
> +		u32 major_version : 16;
> +
> +		u32 service_pack;
> +
> +		u32 service_number : 24;
> +		u32 service_branch : 8;
> +	};
> +	struct {
> +		u32 eax;
> +		u32 ebx;
> +		u32 ecx;
> +		u32 edx;

Nit:  These names are x86-isms appearing in the generic portion
of hyperv-tlfs.h.  On the ARM64 side I had called the four parts
"a", "b", "c", and "d" to be slightly more generic.  But if want to
keep the x86 register names, I won't object.

Michael

> +	};
> +};
> +
>  /*
>   * The whole argument should fit in a page to be able to pass to the hyp=
ervisor
>   * in one hypercall.
> diff --git a/include/asm-generic/mshyperv.h b/include/asm-
> generic/mshyperv.h
> index 04424a446bb7..452b7c089b71 100644
> --- a/include/asm-generic/mshyperv.h
> +++ b/include/asm-generic/mshyperv.h
> @@ -161,6 +161,8 @@ static inline void vmbus_signal_eom(struct
> hv_message *msg, u32 old_msg_type)
>  	}
>  }
>=20
> +int hv_get_hypervisor_version(union hv_hypervisor_version_info *info);
> +
>  void hv_setup_vmbus_handler(void (*handler)(void));
>  void hv_remove_vmbus_handler(void);
>  void hv_setup_stimer0_handler(void (*handler)(void));
> --
> 2.25.1
>=20


