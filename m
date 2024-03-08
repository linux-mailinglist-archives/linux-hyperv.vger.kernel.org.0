Return-Path: <linux-hyperv+bounces-1687-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58AEC8767E3
	for <lists+linux-hyperv@lfdr.de>; Fri,  8 Mar 2024 16:58:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B52F1C21262
	for <lists+linux-hyperv@lfdr.de>; Fri,  8 Mar 2024 15:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E6501DDFC;
	Fri,  8 Mar 2024 15:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="PCD4aGlh"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11olkn2046.outbound.protection.outlook.com [40.92.18.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87264539C;
	Fri,  8 Mar 2024 15:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.18.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709913530; cv=fail; b=LoYMGiUkTuIVUHPxWtx55X9sLNAwME1HdYHB85lIaG5Lew5GvDqTPqZRE54B96SNnhryN+YFnJ7f/0LISc5YkDKdLAt0DjsO7T/yAxV2PvnJADdKMy3QuUGg/PEvTb5qnVu/PjJateOELLDBI5GuS/Fy7rFOjruKFs+KJkqoBh8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709913530; c=relaxed/simple;
	bh=RooIcm9THLN+QOTJ3wZ5UUcP3qw8bpyp7L8xEiNwYV8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cvN1hgYM6y5K1penIdMRQfGLaxsJKXJwPPsn3b5RUKoXxVJjTXm2df9YEQYN2mbITv1Ahe5Fq4Zs52uAwxykuxmjZ8UdPR3sED00qOmcnWtchIDn8K4UNgYs7OQtyya/lysDg/C9c3oSSchxqqcthbfHiq7P2BkavtodZsErUis=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=PCD4aGlh; arc=fail smtp.client-ip=40.92.18.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X1nudgqiqAJOSzYxM7FtcU3OUvEHf0yhJAWFtphJjIMxhLHfVq2fEmFCAqxyoIPRjcNBjUolYs97VRC1MyL+GstlWhJ8UkmP+5OFy5aZrNh+iVHXBv6+QRdZg5DcQbHW/9THeU4aZWak+AktFh7U+jWpbWKjTYU0J2wwhRWEqaSZdwokQk8/xVjB8EAfOFqU56KXhvNX7Z6s30dCkg/PqE1086EUI5Zrsnb6Xpk7wByX3ICwuLULFcWRCBrCJc609Q3gdM7iraRDYxNOdSTqSpdGFe0NjPKEXeicrO+x1w9JfQdWrTRIDjiYfuUsaRMx3o4aLCdD2c0ibfwjg7oKgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oy4GEvb7Y6P+9Ns06FsP+vxaXXetiw0OSnWtFL5fX9A=;
 b=EnSOxwURyWw0Ac0W4ffAlFRdce9djTVbHZiVgTyEEH6HffaR5Ch/D4OHFndf09hOHGHJfY98MM7jqz08ue0kE97AL7it5X9cewxxvazskyc8LUizB0CNMe/hXI7nWIsbq4C5w6wWEVOcKDxyPS06wewJfNCBKs5slOhc/MowfHKo6zqxe4g74jNovMPB4omJZxl21BWSpvRqfkrpvDqru8nKiE0usv46KlG/Rk2VSw/Q/YESxz22xZVGCVXH34eoxfx3vPMY4e3n4rXd7VU7z523yCJHoVSJ5OB1poRNoCSSrWGHQtc8o2/FUaOn0M2YAKpMmDbaoJqNy9fGbO1UbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oy4GEvb7Y6P+9Ns06FsP+vxaXXetiw0OSnWtFL5fX9A=;
 b=PCD4aGlh2Ncp4VbK2H+wUm6D4h+bjHtFsUXdHbLCkM6avN354UNEl/EQF/lCgNEJgYizftsWuESpykxrX2Igo8KRbIBOaMsBlk67yUG+lzy4yxKvXzDHqsDBAaSDH9b3Up0ZHsTz/4QBVzHHQ3lEAvrPNvR5z5aG0i3znmrtk+rW5MB7te8Dex2ZvVnf9K6fakG6g/6k3DNrLGRdM/j4miT9GmbWtfbazgfMjZp1DJ7FqskYlHZMatwTHmdD/YGsMKh+6QPtH0wPE5WGZQ7FTXOMHqVr8M0iR9ZaUOymFkLM4Y847Oz9PmOPo57hYFXb2z6zQiHUBvjYzkPHtz9nNA==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by SJ2PR02MB10123.namprd02.prod.outlook.com (2603:10b6:a03:55e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Fri, 8 Mar
 2024 15:58:46 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::67a9:f3c0:f57b:86dd]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::67a9:f3c0:f57b:86dd%5]) with mapi id 15.20.7362.024; Fri, 8 Mar 2024
 15:58:45 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "haiyangz@microsoft.com" <haiyangz@microsoft.com>, "kys@microsoft.com"
	<kys@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>, "catalin.marinas@arm.com"
	<catalin.marinas@arm.com>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "arnd@arndb.de"
	<arnd@arndb.de>
Subject: RE: [PATCH v2] mshyperv: Introduce hv_get_hypervisor_version function
Thread-Topic: [PATCH v2] mshyperv: Introduce hv_get_hypervisor_version
 function
Thread-Index: AQHacOPCxBjS73trgEWJu7hckxXQp7EuACFA
Date: Fri, 8 Mar 2024 15:58:45 +0000
Message-ID:
 <SN6PR02MB415711AAB604257B4F23A4AAD4272@SN6PR02MB4157.namprd02.prod.outlook.com>
References:
 <1709852618-29110-1-git-send-email-nunodasneves@linux.microsoft.com>
In-Reply-To:
 <1709852618-29110-1-git-send-email-nunodasneves@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tmn: [zc4r/iJ5eoIJAiLKJmouMYqvqOZQWS3n]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|SJ2PR02MB10123:EE_
x-ms-office365-filtering-correlation-id: 82dedd36-8522-4cf7-86c8-08dc3f88a2cb
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 YwNH2UWdVUUmAN/T5YzMa+yq5mzPwcuNeT1MNd6hNr5C3zYvTLU2BbI/wS0v4HrY2di3hJK8DJ/z407bGXGopeEpc7WCnotV6kdigwrc/HJyd4+7J78rIT9gd/d6oGd1lP8ZEGtGAbuidOYE+ql5Wfdqph2E5YD00Joqe5XGMGfc9yH2A9DH4GiIr+4ydsw7Ct1kftwM+XXvIw2lWJlkOUJlWk6J4tUeEmwaVQL82HZj+lE4/8K7fUC4Zrv7mz5nq8rbwdhwLzO3ISXUd9KvSthbH2e6a9S3bwgf9PJJ4jiOyNnn80OWYecAlP2kfN98MuUc6TC9h+8GGlZxT1n6aNDfc++orwn9kglLn9WV9x8IDcGUUBNNcJFp3K/+0U6P/wFgcRFklTAuFp+hoZutA+kO/ufhSOmPpeofbcOzLhvVbwM5MpgfB8s2Hq0G2DCsWtHNiEynZ1mtLn5i8jo4OhewhS1f+c47tqO0z6YojQlylt/WIZZeluN1wVyc+8Kb6Adfh1rfvmHy2uPCzdn9bHKZ/KEDVIoX+ot1WOMjghElEAKUXZjOfVHvHZ8kPCJM
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?XhK1EwwadjoxRl8lK/k1g/Z4q1M20kmeBB1zDJ9IXJlTaheOQHT0bTYv8IHv?=
 =?us-ascii?Q?Ah4L7NRJS73xf59/PGr54aAXN6M7kOYRo9o8pavv8w/mkVLfw7dgQSeoVwxx?=
 =?us-ascii?Q?ZxVwwUY8Ksa4r/bPhUq5zNe+UXxFpR5kaUUn7ah2t3L4me/g5wDYEvHDok3S?=
 =?us-ascii?Q?a5J+18L3Flk1HHDYjYq4YR+xCHKp6o+hR3d7/ydA5aaT5SdGy1yLRJD6UHyB?=
 =?us-ascii?Q?tzXw8e6FLXTJvHgTXrgBdaFIPor3i7oqKjv7kq0nfC4TAuwIFBAQptCTOO/W?=
 =?us-ascii?Q?yd4NC9T5HDNJROM6ZEAJ4Bw4J/XRj0lRFnJyrMlELDtVo3ghCXXM16vyqSrp?=
 =?us-ascii?Q?+AAc/Wa0k+ln4D6Q94ZT2gHkVslalPUyIl1FXCrkd0VP1HhMHIK+9Wj0vGqD?=
 =?us-ascii?Q?333Bc2IfKH5+2LhEh0k92pDGfxmV9gon3jPoNPuLa47rQhHOOzoWYSeAJnJk?=
 =?us-ascii?Q?iP574iNJ7VPw2UQGQ2qwnlwDHUOH1VK2iWXvQXHq4AHihWkNyTVHE9bJhtNR?=
 =?us-ascii?Q?3dQ+M8IaJ9eAp9YMdsWWb4pt0WQ4Xt8Rq16JijY6YJc+RrdOxZ32N2BCwfvK?=
 =?us-ascii?Q?s6j/RFiSfwTb+7YKtEVhTfeLlKyoHJBdnoKmpbWx98afVqToL5Ps3J8MfPVH?=
 =?us-ascii?Q?kzEOFcdoj/lGWaRQyYUO8Rqs9BURzVY3H1dlumKrKCoaImqJyCdi4y9FBdf0?=
 =?us-ascii?Q?jEy1bxKziw3tn6xOjVWZ8YFYWQec7Z6PEyXOqY0bri0upWhA3JAwhukyYHJV?=
 =?us-ascii?Q?Dogj3+ryU6wK+SK24RHfU6BWqND6LcKCaow22s/PJm+ZjlsXpipdrWIADkNC?=
 =?us-ascii?Q?V1m6hkFtQplhX2Cc+shV9pNqpJ0qXJiZGX2RBMlZVz4Lw9r4IxPeQyXYwdFm?=
 =?us-ascii?Q?qEyTrYXpVwv2PB5w6OWGGK+7cb+4jwoPjgNPjLQ/GX+gJB4vFMV4S1lm/DJF?=
 =?us-ascii?Q?3F0T0791PGAacXQl/oHFUfbeJyvJLwLplfHhwkDCd4gIG38RI/foOOY6b6CE?=
 =?us-ascii?Q?EsLbJihStYaX18cG/xdOMgs0LX1XJktkxnxs3ktp9nGRH11Nobiwd/VAtttq?=
 =?us-ascii?Q?obK4ZcehRC6lU2fr8Ucl5VJJFeTiO1qvhBx5XkuDN2vubB8hBlAAkuEX/9Zi?=
 =?us-ascii?Q?EWUhTN0v0m/RWPWSeofiKbNIH76YEGT3gEefGbA7/E1etYltx8sNOk1I6NsF?=
 =?us-ascii?Q?nsNqv07qO3HapRjnSlEUdwJ3QuSNbPIYau4xlw=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 82dedd36-8522-4cf7-86c8-08dc3f88a2cb
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2024 15:58:45.8949
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR02MB10123

From: Nuno Das Neves <nunodasneves@linux.microsoft.com> Sent: Thursday, Mar=
ch 7, 2024 3:04 PM
>=20
> Introduce x86_64 and arm64 functions to get the hypervisor version
> information and store it in a structure for simpler parsing.
>=20
> Use the new function to get and parse the version at boot time. While at
> it, move the printing code to hv_common_init() so it is not duplicated.
>=20
> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> Acked-by: Wei Liu <wei.liu@kernel.org>

Reviewed-by: Michael Kelley <mhklinux@outlook.com>

> ---
> Changes since v1:
> - Amend commit message
> - Address minor style issues
> - Remove unneeded EXPORT_SYMBOL_GPL(hv_get_hypervisor_version)
> ---
>  arch/arm64/hyperv/mshyperv.c      | 18 ++++++++--------
>  arch/x86/kernel/cpu/mshyperv.c    | 34 ++++++++++++++-----------------
>  drivers/hv/hv_common.c            |  8 ++++++++
>  include/asm-generic/hyperv-tlfs.h | 23 +++++++++++++++++++++
>  include/asm-generic/mshyperv.h    |  1 +
>  5 files changed, 55 insertions(+), 29 deletions(-)
>=20
> diff --git a/arch/arm64/hyperv/mshyperv.c
> b/arch/arm64/hyperv/mshyperv.c
> index f1b8a04ee9f2..99362716ac87 100644
> --- a/arch/arm64/hyperv/mshyperv.c
> +++ b/arch/arm64/hyperv/mshyperv.c
> @@ -19,10 +19,17 @@
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
> +
>  static int __init hyperv_init(void)
>  {
>  	struct hv_get_vp_registers_output	result;
> -	u32	a, b, c, d;
>  	u64	guest_id;
>  	int	ret;
>=20
> @@ -54,15 +61,6 @@ static int __init hyperv_init(void)
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
> index d306f6184cee..56e731d8f513 100644
> --- a/arch/x86/kernel/cpu/mshyperv.c
> +++ b/arch/x86/kernel/cpu/mshyperv.c
> @@ -350,13 +350,24 @@ static void __init reduced_hw_init(void)
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
> @@ -407,21 +418,6 @@ static void __init ms_hyperv_init_platform(void)
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
> index 2f1dd4b07f9a..5d64cb0a709d 100644
> --- a/drivers/hv/hv_common.c
> +++ b/drivers/hv/hv_common.c
> @@ -278,6 +278,14 @@ static void hv_kmsg_dump_register(void)
>  int __init hv_common_init(void)
>  {
>  	int i;
> +	union hv_hypervisor_version_info version;
> +
> +	/* Get information about the Hyper-V host version */
> +	if (!hv_get_hypervisor_version(&version))
> +		pr_info("Hyper-V: Host Build %d.%d.%d.%d-%d-%d\n",
> +			version.major_version, version.minor_version,
> +			version.build_number, version.service_number,
> +			version.service_pack, version.service_branch);
>=20
>  	if (hv_is_isolation_supported())
>  		sysctl_record_panic_msg =3D 0;
> diff --git a/include/asm-generic/hyperv-tlfs.h b/include/asm-generic/hype=
rv-
> tlfs.h
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
> +	};
> +};
> +
>  /*
>   * The whole argument should fit in a page to be able to pass to the hyp=
ervisor
>   * in one hypercall.
> diff --git a/include/asm-generic/mshyperv.h b/include/asm-
> generic/mshyperv.h
> index 04424a446bb7..f8e7428f1e55 100644
> --- a/include/asm-generic/mshyperv.h
> +++ b/include/asm-generic/mshyperv.h
> @@ -275,6 +275,7 @@ static inline int cpumask_to_vpset_skip(struct
> hv_vpset *vpset,
>  	return __cpumask_to_vpset(vpset, cpus, func);
>  }
>=20
> +int hv_get_hypervisor_version(union hv_hypervisor_version_info *info);
>  void hyperv_report_panic(struct pt_regs *regs, long err, bool in_die);
>  bool hv_is_hyperv_initialized(void);
>  bool hv_is_hibernation_supported(void);
> --
> 2.25.1
>=20


