Return-Path: <linux-hyperv+bounces-1536-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 422E584FE2B
	for <lists+linux-hyperv@lfdr.de>; Fri,  9 Feb 2024 22:07:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42F301C2111A
	for <lists+linux-hyperv@lfdr.de>; Fri,  9 Feb 2024 21:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A80514F6C;
	Fri,  9 Feb 2024 21:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="DoRD4jlq"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11olkn2068.outbound.protection.outlook.com [40.92.18.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1871B1AAC9;
	Fri,  9 Feb 2024 21:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.18.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707512854; cv=fail; b=sZWFwJBBTvgUK1AOBOZjzDE9cbjanFl3o4pAeLgDq3d6FHQ3TKU8EhXAHQv0NtcQLc7cBtJDuoZP7W/NLB14fyDQ3T/hRPaO7zGYupI2hdwVe2RgNY6sIQ9FESmL8XFZ9RsUJl4ai4pmRML3Cz6iKPTv0uwdUBP9K6aqSUtJtFw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707512854; c=relaxed/simple;
	bh=4dwyTf7j1AS5pE04DqjTwMNI0Hj0t7Zm6Sqw3OFZXFw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Qxp5HHDZqit1M13+EBducTEV+GegwOUGElVhCqu20DAiRUozInQQQJESuBtjK5/fDX2wxIse2CdVNMMfZP5CWO3WyAsO6z9/M6k4pvQLvq+7KFdgOmJ9iMllZdbqUThRwOyowzDMgDz8OpV0HBuB5FYycKf6Li7MpTJi7ADj2ok=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=DoRD4jlq; arc=fail smtp.client-ip=40.92.18.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NvWiZMExaeipgVmSpgMPngDb6yd1TawTTw9bUblsxxrpMO/7KOfX1Op3rWzHYDo4R3+wDoI4FnfQncVynldD3p724K70Jzy+nA42zzkzK+wX8vWuLZZvrYwxEgFSwVk2TOoif73DzOd054k0rnOxXBh/XSWMUN08aUbRbBgvUMIM1PwuIhnHaOqNj/pw2XDpXoRkyouQRe9Z8WaQdQ+NK5SFd1XyC42IoAwooq470FSg1QRFW0Ff47tiNOFIb+ANoFmqspfEoa9db53nadKQ0e2i3d3DBt3XH1/xMPGX5L+CBRiFqAVoedTnzMUjhudHeBaD/X54oK1ADzkVFg71WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fbL9oxUJgOw+ECmeuJ9FByn7HSt2fuBxJ1akn5NV1wk=;
 b=Fp7cEkKWKOkjIYa71THrtrLIDU4/ZKLOGH9YgrSjItldOM1/VXR7C/20QQqeuTQyesIq1UdzsBpR0SeYo3OR19MooE4sPyAQ9d02Cj08mtJ17Rh91ZNpGzS3h6PjxQHo5SbYBSRxv0d0RKKPLan2wY2+1D6jbVvAhwHjBotsJbS0f4+S+zJDo+IGys7zScY+w0ZNfPNkvDXLIpsei0dmKR3LEngVtn48AxXQQQNq6koDs+yp1xdHrGlA+pbgt0CK8JxuMmSI2Nyjg2XJg/Oc412SvedDjOgiDf9Efreio7sbM9EUjW5pXTOPI1Bkj6kEPuFtol3PDQju04mjG4OkBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fbL9oxUJgOw+ECmeuJ9FByn7HSt2fuBxJ1akn5NV1wk=;
 b=DoRD4jlqq1286jkExeP6KAXz+4Kl/FKAhUFCrLGNRW69GKCULMM2bd4GbTCuDGF5kQP7TFpzH3U7VHwDjHzvv8O+eDtDPjD4S/QfDh2gcPrUTvLEUNy+yJ/CfhF/+XkvtLKv9DXrktscIr9nZnXLAtmg9ugwxRL/zHtA4DmAKqwpfie6zQY2T0AWZkILRGKKEHj8EfzYW3WOKwesAEYnbRP37EMahDIBVDfu5BpckKFkKOM9+5pwXU79JzTndVAZhgKdQ7GsgQm/1nOUXhIooY3KA1XWsWVhxRrlCTMbdLVlIA/H4UR4WR4Iy0sPIeYK95ufUzNFlzeYu7+3mrF/Dw==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by LV3PR02MB9982.namprd02.prod.outlook.com (2603:10b6:408:1a7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.38; Fri, 9 Feb
 2024 21:07:26 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::67a9:f3c0:f57b:86dd]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::67a9:f3c0:f57b:86dd%5]) with mapi id 15.20.7249.027; Fri, 9 Feb 2024
 21:07:26 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
	"mikelley@microsoft.com" <mikelley@microsoft.com>, "kys@microsoft.com"
	<kys@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>, "catalin.marinas@arm.com"
	<catalin.marinas@arm.com>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>, "arnd@arndb.de"
	<arnd@arndb.de>
Subject: RE: [PATCH] hyperv-tlfs: Change prefix of generic HV_REGISTER_* MSRs
 to HV_MSR_*
Thread-Topic: [PATCH] hyperv-tlfs: Change prefix of generic HV_REGISTER_* MSRs
 to HV_MSR_*
Thread-Index: AQHaWn1Y9dmtRlV6xUadGJxZ89x7frECfmKg
Date: Fri, 9 Feb 2024 21:07:26 +0000
Message-ID:
 <SN6PR02MB4157199AA51C64FCE17695D2D44B2@SN6PR02MB4157.namprd02.prod.outlook.com>
References:
 <1707389540-6655-1-git-send-email-nunodasneves@linux.microsoft.com>
In-Reply-To:
 <1707389540-6655-1-git-send-email-nunodasneves@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tmn: [XskKIc554RjnwyzIM41QMQpsYgifGhg9]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|LV3PR02MB9982:EE_
x-ms-office365-filtering-correlation-id: a4d09741-f208-4bbd-3d6a-08dc29b31e80
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 xmfzghYBoVGhsQU+uEyAjhPcEtms8mxUKsXCAbjbN6np/kBO0vciBpGsO161pivEaP/kN67y4mcK3TDD1eL4+Wmpf+pMB9N6V75HnIS/cqOtmTStzHnBfQbYLnpvLTSUgHzNfq5xMFvzf02X0n349DBWTocOUiKxyJ8SgHU7mLnXw3uFHiEE5kfJWIAHQgXny5JT8Z868Tb3RHnwOZLWxm/hWyRUTZCje2FMqymo+qWK1CJo3HKQs4uwLMdrVfKZiuhq65wBSEuRHxehtDc8QicaooLDM+ldWqPHrfkhFP2IZoj/faa1s2Buri0YTUd6HXweenJZV7EuCEBbTjcWFbx0AU3bfvjTtNVwkJYhTKxRqE3Z1xA7tMQm9GxykvXlsXpB1GR419roLa4s7NJFrkDLv3/1Pgmkm9hb2SlPaoZFu7AgdS568yJwJM83t7ail/sWE7YTF2gxqctN8wZybrxyCYN5IiBeS2KjzVGE31XVJer0FQrbeRgy7YukyJsuQCg1LahC6kiXQ0Z0tmS6iwrAkAzzW1auphWYb5zqoD/ow/Ye/IcZg/EFdPr6xqR0
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?rAwXCmp6ru4O3C6V/dAHiLAIceRnNMI0zsyOuzSf6pkc+UhbIuvOavl5KUDo?=
 =?us-ascii?Q?a7gDl3I0Vk7fJWz1h2GA7QsM7ETGH/E+4fk+JGgt8VqvVrl4afjN4DNE4kMC?=
 =?us-ascii?Q?2TJ/M5yJ3RoxSkQJ/izBt+jN7LNDbgZ1/K4n82TYcoLkB7AQs5TG4iZzqtBK?=
 =?us-ascii?Q?MvTYUq/5pRKZcDCfV1goGkmQKv81xVoe3vTfX46K5Rxj5O9TzAlTMtCRRc52?=
 =?us-ascii?Q?eNIyJVYpW6I/XJOEFDduw+bnPyD5+OMP7hithp7VCGEE1me05n60dKSSlCuw?=
 =?us-ascii?Q?BUAH3krZshUXTkusVuW9HK8Hpp/JRHEuBrvmX+gmOawZ+Tvv69GZVorjL/6n?=
 =?us-ascii?Q?GTN3mxomWd3YNHcW6REnRuVr1/xuJ7knXTAp6DY8c+twRcKTfieO+7QnqJCW?=
 =?us-ascii?Q?eI2XKr5ky8gLq8MDk5BN9LYV92yWY+2bIcOZZnKwvcjhE08zW+yVxeYp8Yjh?=
 =?us-ascii?Q?SLckptb4Ffk/VUc5M3Cb850CTDx6jCM+BG7IHzcNX9DLdbw19QqxLS3aNUWQ?=
 =?us-ascii?Q?UV8564E4wtvf4EF73KLuQ539OPuqsAB+/Au2M11hnq4gZ9r0XYf4J7aBClUv?=
 =?us-ascii?Q?HUv4+/fkeJRcG2WjCgGWtSCiEAoVQdZOexJrjTw4RmKOPCe/i+MCjeupmNrP?=
 =?us-ascii?Q?lkESNfuKd6MWrKPE5oPmZqy0doXLekBV01845JJV5ebrayb/hzHRZjOTQz+2?=
 =?us-ascii?Q?wwsISP8V4v8Iap5KPWO7ztlFbIpms9AxJGMWxn1ryInb069mdYCCMGUvxNgO?=
 =?us-ascii?Q?gOWtxy4ij/Y/4RKBQIA7vFSaYSdI/OqyFZZQbzSRiRLrxzdJHn8l4p5N6/bF?=
 =?us-ascii?Q?Xm+E9sBfRHmUMNFVjr/mEZYUqEZ7iHf51Scy7bzaZWGJ+HAHfcPqxl3NkHfH?=
 =?us-ascii?Q?yxIUjHi+qUCzGhzL0K/G9Pqf4HjwSRJPz5fvB05BBQH0Wf0ghd50ITqQyC4R?=
 =?us-ascii?Q?s0OXSQ6zzksFzLP94VVCgWbzBU5O6Fj2DglHnrfXVIKLYGKpgtf2zuD8w6Ct?=
 =?us-ascii?Q?vvt23rwqzTm5Y49OAz/GRLHWg5Z7X5MUDcnB+/MpdqTZgdhxWrNvpresqwzV?=
 =?us-ascii?Q?XgiZaorUjDW3jCjzFXfMGHuEG7FwFt+htX8khOzP9p1yYhZ+5TivVEWa3xlS?=
 =?us-ascii?Q?N3O/Wmkxn8hxSH5hxPx8u6AUqz+5PgtHXFAlAh3KdYU014+l6A0xm3sOSEWS?=
 =?us-ascii?Q?ryuOg2ST1AwQOl4SXdponsXqr2OFMHf3xF5VP+zkZg6qp+Q4nPChr2UbefU?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a4d09741-f208-4bbd-3d6a-08dc29b31e80
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2024 21:07:26.7257
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR02MB9982

From: Nuno Das Neves <nunodasneves@linux.microsoft.com> Sent: Thursday, Feb=
ruary 8, 2024 2:52 AM
>=20
> The HV_REGISTER_ are used as arguments to hv_set/get_register(), which
> delegate to arch-specific mechanisms for getting/setting synthetic
> Hyper-V MSRs.
>=20
> On arm64, HV_REGISTER_ defines are synthetic VP registers accessed via
> the get/set vp registers hypercalls. The naming matches the TLFS
> document, although these register names are not specific to arm64.
>=20
> However, on x86 the prefix HV_REGISTER_ indicates Hyper-V MSRs accessed
> via rdmsrl()/wrmsrl(). This is not consistent with the TLFS doc, where
> HV_REGISTER_ is *only* used for used for VP register names used by
> the get/set register hypercalls.
>=20
> To fix this inconsistency and prevent future confusion, change the
> arch-generic aliases used by callers of hv_set/get_register() to have
> the prefix HV_MSR_ instead of HV_REGISTER_.
>=20
> Use the prefix HV_X64_MSR_ for the x86-only Hyper-V MSRs. On x86, the
> generic HV_MSR_'s point to the corresponding HV_X64_MSR_.
>=20
> Move the arm64 HV_REGISTER_* defines to the asm-generic hyperv-tlfs.h,
> since these are not specific to arm64. On arm64, the generic HV_MSR_'s
> point to the corresponding HV_REGISTER_.
>=20
> While at it, rename hv_get/set_registers() and related functions to
> hv_get/set_msr(), hv_get/set_nested_msr(), etc. These are only used for
> Hyper-V MSRs and this naming makes that clear.
>=20
> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> Reviewed-by: Wei Liu <wei.liu@kernel.org>

Overall, this looks good to me.  It cleans up the mess I made five
years ago when first separating x86 from ARM64. :-(

See one comment below, but otherwise,

Reviewed-by: Michael Kelley <mhklinux@outlook.com>

> ---
>  arch/arm64/include/asm/hyperv-tlfs.h |  45 ++++-----
>  arch/arm64/include/asm/mshyperv.h    |   4 +-
>  arch/x86/hyperv/hv_init.c            |   8 +-
>  arch/x86/include/asm/hyperv-tlfs.h   | 145 ++++++++++++++-------------
>  arch/x86/include/asm/mshyperv.h      |  30 +++---
>  arch/x86/kernel/cpu/mshyperv.c       |  56 +++++------
>  drivers/clocksource/hyperv_timer.c   |  26 ++---
>  drivers/hv/hv.c                      |  36 +++----
>  drivers/hv/hv_common.c               |  22 ++--
>  include/asm-generic/hyperv-tlfs.h    |  32 +++++-
>  include/asm-generic/mshyperv.h       |   2 +-
>  11 files changed, 216 insertions(+), 190 deletions(-)
>=20
> diff --git a/arch/arm64/include/asm/hyperv-tlfs.h
> b/arch/arm64/include/asm/hyperv-tlfs.h
> index bc6c7ac934a1..54846d1d29c3 100644
> --- a/arch/arm64/include/asm/hyperv-tlfs.h
> +++ b/arch/arm64/include/asm/hyperv-tlfs.h
> @@ -21,14 +21,6 @@
>   * byte ordering of Linux running on ARM64, so no special handling is re=
quired.
>   */
>=20
> -/*
> - * These Hyper-V registers provide information equivalent to the CPUID
> - * instruction on x86/x64.
> - */
> -#define HV_REGISTER_HYPERVISOR_VERSION		0x00000100 /*CPUID 0x40000002 */
> -#define HV_REGISTER_FEATURES			0x00000200 /*CPUID 0x40000003 */
> -#define HV_REGISTER_ENLIGHTENMENTS		0x00000201 /*CPUID 0x40000004 */
> -
>  /*
>   * Group C Features. See the asm-generic version of hyperv-tlfs.h
>   * for a description of Feature Groups.
> @@ -41,28 +33,29 @@
>  #define HV_STIMER_DIRECT_MODE_AVAILABLE		BIT(13)
>=20
>  /*
> - * Synthetic register definitions equivalent to MSRs on x86/x64
> + * To support arch-generic code calling hv_set/get_register:
> + * - On x86, HV_MSR_ indicates an MSR accessed via rdmsrl/wrmsrl
> + * - On ARM, HV_MSR_ indicates a VP register accessed via hypercall
>   */
> -#define HV_REGISTER_CRASH_P0		0x00000210
> -#define HV_REGISTER_CRASH_P1		0x00000211
> -#define HV_REGISTER_CRASH_P2		0x00000212
> -#define HV_REGISTER_CRASH_P3		0x00000213
> -#define HV_REGISTER_CRASH_P4		0x00000214
> -#define HV_REGISTER_CRASH_CTL		0x00000215
> +#define HV_MSR_CRASH_P0		(HV_REGISTER_CRASH_P0)
> +#define HV_MSR_CRASH_P1		(HV_REGISTER_CRASH_P1)
> +#define HV_MSR_CRASH_P2		(HV_REGISTER_CRASH_P2)
> +#define HV_MSR_CRASH_P3		(HV_REGISTER_CRASH_P3)
> +#define HV_MSR_CRASH_P4		(HV_REGISTER_CRASH_P4)
> +#define HV_MSR_CRASH_CTL	(HV_REGISTER_CRASH_CTL)
>=20
> -#define HV_REGISTER_GUEST_OSID		0x00090002
> -#define HV_REGISTER_VP_INDEX		0x00090003
> -#define HV_REGISTER_TIME_REF_COUNT	0x00090004
> -#define HV_REGISTER_REFERENCE_TSC	0x00090017
> +#define HV_MSR_VP_INDEX		(HV_REGISTER_VP_INDEX)
> +#define HV_MSR_TIME_REF_COUNT	(HV_REGISTER_TIME_REF_COUNT)
> +#define HV_MSR_REFERENCE_TSC	(HV_REGISTER_REFERENCE_TSC)
>=20
> -#define HV_REGISTER_SINT0		0x000A0000
> -#define HV_REGISTER_SCONTROL		0x000A0010
> -#define HV_REGISTER_SIEFP		0x000A0012
> -#define HV_REGISTER_SIMP		0x000A0013
> -#define HV_REGISTER_EOM			0x000A0014
> +#define HV_MSR_SINT0		(HV_REGISTER_SINT0)
> +#define HV_MSR_SCONTROL		(HV_REGISTER_SCONTROL)
> +#define HV_MSR_SIEFP		(HV_REGISTER_SIEFP)
> +#define HV_MSR_SIMP		(HV_REGISTER_SIMP)
> +#define HV_MSR_EOM		(HV_REGISTER_EOM)
>=20
> -#define HV_REGISTER_STIMER0_CONFIG	0x000B0000
> -#define HV_REGISTER_STIMER0_COUNT	0x000B0001
> +#define HV_MSR_STIMER0_CONFIG	(HV_REGISTER_STIMER0_CONFIG)
> +#define HV_MSR_STIMER0_COUNT	(HV_REGISTER_STIMER0_COUNT)
>=20
>  union hv_msi_entry {
>  	u64 as_uint64[2];
> diff --git a/arch/arm64/include/asm/mshyperv.h
> b/arch/arm64/include/asm/mshyperv.h
> index 20070a847304..a975e1a689dd 100644
> --- a/arch/arm64/include/asm/mshyperv.h
> +++ b/arch/arm64/include/asm/mshyperv.h
> @@ -31,12 +31,12 @@ void hv_set_vpreg(u32 reg, u64 value);
>  u64 hv_get_vpreg(u32 reg);
>  void hv_get_vpreg_128(u32 reg, struct hv_get_vp_registers_output *result=
);
>=20
> -static inline void hv_set_register(unsigned int reg, u64 value)
> +static inline void hv_set_msr(unsigned int reg, u64 value)
>  {
>  	hv_set_vpreg(reg, value);
>  }
>=20
> -static inline u64 hv_get_register(unsigned int reg)
> +static inline u64 hv_get_msr(unsigned int reg)
>  {
>  	return hv_get_vpreg(reg);
>  }
> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> index 783ed339f341..0c74012b2594 100644
> --- a/arch/x86/hyperv/hv_init.c
> +++ b/arch/x86/hyperv/hv_init.c
> @@ -642,14 +642,14 @@ void hyperv_cleanup(void)
>  	hv_hypercall_pg =3D NULL;
>=20
>  	/* Reset the hypercall page */
> -	hypercall_msr.as_uint64 =3D hv_get_register(HV_X64_MSR_HYPERCALL);
> +	hypercall_msr.as_uint64 =3D hv_get_msr(HV_X64_MSR_HYPERCALL);
>  	hypercall_msr.enable =3D 0;
> -	hv_set_register(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
> +	hv_set_msr(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
>=20
>  	/* Reset the TSC page */
> -	tsc_msr.as_uint64 =3D hv_get_register(HV_X64_MSR_REFERENCE_TSC);
> +	tsc_msr.as_uint64 =3D hv_get_msr(HV_X64_MSR_REFERENCE_TSC);
>  	tsc_msr.enable =3D 0;
> -	hv_set_register(HV_X64_MSR_REFERENCE_TSC, tsc_msr.as_uint64);
> +	hv_set_msr(HV_X64_MSR_REFERENCE_TSC, tsc_msr.as_uint64);
>  }
>=20
>  void hyperv_report_panic(struct pt_regs *regs, long err, bool in_die)
> diff --git a/arch/x86/include/asm/hyperv-tlfs.h
> b/arch/x86/include/asm/hyperv-tlfs.h
> index 2ff26f53cd62..3787d26810c1 100644
> --- a/arch/x86/include/asm/hyperv-tlfs.h
> +++ b/arch/x86/include/asm/hyperv-tlfs.h
> @@ -182,7 +182,7 @@ enum hv_isolation_type {
>  #define HV_X64_MSR_HYPERCALL			0x40000001
>=20
>  /* MSR used to provide vcpu index */
> -#define HV_REGISTER_VP_INDEX			0x40000002
> +#define HV_X64_MSR_VP_INDEX			0x40000002
>=20
>  /* MSR used to reset the guest OS. */
>  #define HV_X64_MSR_RESET			0x40000003
> @@ -191,10 +191,10 @@ enum hv_isolation_type {
>  #define HV_X64_MSR_VP_RUNTIME			0x40000010
>=20
>  /* MSR used to read the per-partition time reference counter */
> -#define HV_REGISTER_TIME_REF_COUNT		0x40000020
> +#define HV_X64_MSR_TIME_REF_COUNT		0x40000020
>=20
>  /* A partition's reference time stamp counter (TSC) page */
> -#define HV_REGISTER_REFERENCE_TSC		0x40000021
> +#define HV_X64_MSR_REFERENCE_TSC		0x40000021
>=20
>  /* MSR used to retrieve the TSC frequency */
>  #define HV_X64_MSR_TSC_FREQUENCY		0x40000022
> @@ -209,61 +209,61 @@ enum hv_isolation_type {
>  #define HV_X64_MSR_VP_ASSIST_PAGE		0x40000073
>=20
>  /* Define synthetic interrupt controller model specific registers. */
> -#define HV_REGISTER_SCONTROL			0x40000080
> -#define HV_REGISTER_SVERSION			0x40000081
> -#define HV_REGISTER_SIEFP			0x40000082
> -#define HV_REGISTER_SIMP			0x40000083
> -#define HV_REGISTER_EOM				0x40000084
> -#define HV_REGISTER_SINT0			0x40000090
> -#define HV_REGISTER_SINT1			0x40000091
> -#define HV_REGISTER_SINT2			0x40000092
> -#define HV_REGISTER_SINT3			0x40000093
> -#define HV_REGISTER_SINT4			0x40000094
> -#define HV_REGISTER_SINT5			0x40000095
> -#define HV_REGISTER_SINT6			0x40000096
> -#define HV_REGISTER_SINT7			0x40000097
> -#define HV_REGISTER_SINT8			0x40000098
> -#define HV_REGISTER_SINT9			0x40000099
> -#define HV_REGISTER_SINT10			0x4000009A
> -#define HV_REGISTER_SINT11			0x4000009B
> -#define HV_REGISTER_SINT12			0x4000009C
> -#define HV_REGISTER_SINT13			0x4000009D
> -#define HV_REGISTER_SINT14			0x4000009E
> -#define HV_REGISTER_SINT15			0x4000009F
> +#define HV_X64_MSR_SCONTROL			0x40000080
> +#define HV_X64_MSR_SVERSION			0x40000081
> +#define HV_X64_MSR_SIEFP			0x40000082
> +#define HV_X64_MSR_SIMP				0x40000083
> +#define HV_X64_MSR_EOM				0x40000084
> +#define HV_X64_MSR_SINT0			0x40000090
> +#define HV_X64_MSR_SINT1			0x40000091
> +#define HV_X64_MSR_SINT2			0x40000092
> +#define HV_X64_MSR_SINT3			0x40000093
> +#define HV_X64_MSR_SINT4			0x40000094
> +#define HV_X64_MSR_SINT5			0x40000095
> +#define HV_X64_MSR_SINT6			0x40000096
> +#define HV_X64_MSR_SINT7			0x40000097
> +#define HV_X64_MSR_SINT8			0x40000098
> +#define HV_X64_MSR_SINT9			0x40000099
> +#define HV_X64_MSR_SINT10			0x4000009A
> +#define HV_X64_MSR_SINT11			0x4000009B
> +#define HV_X64_MSR_SINT12			0x4000009C
> +#define HV_X64_MSR_SINT13			0x4000009D
> +#define HV_X64_MSR_SINT14			0x4000009E
> +#define HV_X64_MSR_SINT15			0x4000009F
>=20
>  /*
>   * Define synthetic interrupt controller model specific registers for
>   * nested hypervisor.
>   */
> -#define HV_REGISTER_NESTED_SCONTROL            0x40001080
> -#define HV_REGISTER_NESTED_SVERSION            0x40001081
> -#define HV_REGISTER_NESTED_SIEFP               0x40001082
> -#define HV_REGISTER_NESTED_SIMP                0x40001083
> -#define HV_REGISTER_NESTED_EOM                 0x40001084
> -#define HV_REGISTER_NESTED_SINT0               0x40001090
> +#define HV_X64_MSR_NESTED_SCONTROL		0x40001080
> +#define HV_X64_MSR_NESTED_SVERSION		0x40001081
> +#define HV_X64_MSR_NESTED_SIEFP			0x40001082
> +#define HV_X64_MSR_NESTED_SIMP			0x40001083
> +#define HV_X64_MSR_NESTED_EOM			0x40001084
> +#define HV_X64_MSR_NESTED_SINT0			0x40001090
>=20
>  /*
>   * Synthetic Timer MSRs. Four timers per vcpu.
>   */
> -#define HV_REGISTER_STIMER0_CONFIG		0x400000B0
> -#define HV_REGISTER_STIMER0_COUNT		0x400000B1
> -#define HV_REGISTER_STIMER1_CONFIG		0x400000B2
> -#define HV_REGISTER_STIMER1_COUNT		0x400000B3
> -#define HV_REGISTER_STIMER2_CONFIG		0x400000B4
> -#define HV_REGISTER_STIMER2_COUNT		0x400000B5
> -#define HV_REGISTER_STIMER3_CONFIG		0x400000B6
> -#define HV_REGISTER_STIMER3_COUNT		0x400000B7
> +#define HV_X64_MSR_STIMER0_CONFIG		0x400000B0
> +#define HV_X64_MSR_STIMER0_COUNT		0x400000B1
> +#define HV_X64_MSR_STIMER1_CONFIG		0x400000B2
> +#define HV_X64_MSR_STIMER1_COUNT		0x400000B3
> +#define HV_X64_MSR_STIMER2_CONFIG		0x400000B4
> +#define HV_X64_MSR_STIMER2_COUNT		0x400000B5
> +#define HV_X64_MSR_STIMER3_CONFIG		0x400000B6
> +#define HV_X64_MSR_STIMER3_COUNT		0x400000B7
>=20
>  /* Hyper-V guest idle MSR */
>  #define HV_X64_MSR_GUEST_IDLE			0x400000F0
>=20
>  /* Hyper-V guest crash notification MSR's */
> -#define HV_REGISTER_CRASH_P0			0x40000100
> -#define HV_REGISTER_CRASH_P1			0x40000101
> -#define HV_REGISTER_CRASH_P2			0x40000102
> -#define HV_REGISTER_CRASH_P3			0x40000103
> -#define HV_REGISTER_CRASH_P4			0x40000104
> -#define HV_REGISTER_CRASH_CTL			0x40000105
> +#define HV_X64_MSR_CRASH_P0			0x40000100
> +#define HV_X64_MSR_CRASH_P1			0x40000101
> +#define HV_X64_MSR_CRASH_P2			0x40000102
> +#define HV_X64_MSR_CRASH_P3			0x40000103
> +#define HV_X64_MSR_CRASH_P4			0x40000104
> +#define HV_X64_MSR_CRASH_CTL			0x40000105
>=20
>  /* TSC emulation after migration */
>  #define HV_X64_MSR_REENLIGHTENMENT_CONTROL	0x40000106
> @@ -276,31 +276,38 @@ enum hv_isolation_type {
>  /* HV_X64_MSR_TSC_INVARIANT_CONTROL bits */
>  #define HV_EXPOSE_INVARIANT_TSC		BIT_ULL(0)
>=20
> -/* Register name aliases for temporary compatibility */
> -#define HV_X64_MSR_STIMER0_COUNT
> 	HV_REGISTER_STIMER0_COUNT
> -#define HV_X64_MSR_STIMER0_CONFIG
> 	HV_REGISTER_STIMER0_CONFIG
> -#define HV_X64_MSR_STIMER1_COUNT
> 	HV_REGISTER_STIMER1_COUNT
> -#define HV_X64_MSR_STIMER1_CONFIG
> 	HV_REGISTER_STIMER1_CONFIG
> -#define HV_X64_MSR_STIMER2_COUNT
> 	HV_REGISTER_STIMER2_COUNT
> -#define HV_X64_MSR_STIMER2_CONFIG
> 	HV_REGISTER_STIMER2_CONFIG
> -#define HV_X64_MSR_STIMER3_COUNT
> 	HV_REGISTER_STIMER3_COUNT
> -#define HV_X64_MSR_STIMER3_CONFIG
> 	HV_REGISTER_STIMER3_CONFIG
> -#define HV_X64_MSR_SCONTROL		HV_REGISTER_SCONTROL
> -#define HV_X64_MSR_SVERSION		HV_REGISTER_SVERSION
> -#define HV_X64_MSR_SIMP			HV_REGISTER_SIMP
> -#define HV_X64_MSR_SIEFP		HV_REGISTER_SIEFP
> -#define HV_X64_MSR_VP_INDEX		HV_REGISTER_VP_INDEX
> -#define HV_X64_MSR_EOM			HV_REGISTER_EOM
> -#define HV_X64_MSR_SINT0		HV_REGISTER_SINT0
> -#define HV_X64_MSR_SINT15		HV_REGISTER_SINT15
> -#define HV_X64_MSR_CRASH_P0		HV_REGISTER_CRASH_P0
> -#define HV_X64_MSR_CRASH_P1		HV_REGISTER_CRASH_P1
> -#define HV_X64_MSR_CRASH_P2		HV_REGISTER_CRASH_P2
> -#define HV_X64_MSR_CRASH_P3		HV_REGISTER_CRASH_P3
> -#define HV_X64_MSR_CRASH_P4		HV_REGISTER_CRASH_P4
> -#define HV_X64_MSR_CRASH_CTL		HV_REGISTER_CRASH_CTL
> -#define HV_X64_MSR_TIME_REF_COUNT
> 	HV_REGISTER_TIME_REF_COUNT
> -#define HV_X64_MSR_REFERENCE_TSC
> 	HV_REGISTER_REFERENCE_TSC
> +/*
> + * To support arch-generic code calling hv_set/get_register:
> + * - On x86, HV_MSR_ indicates an MSR accessed via rdmsrl/wrmsrl
> + * - On ARM, HV_MSR_ indicates a VP register accessed via hypercall
> + */
> +#define HV_MSR_CRASH_P0		(HV_X64_MSR_CRASH_P0)
> +#define HV_MSR_CRASH_P1		(HV_X64_MSR_CRASH_P1)
> +#define HV_MSR_CRASH_P2		(HV_X64_MSR_CRASH_P2)
> +#define HV_MSR_CRASH_P3		(HV_X64_MSR_CRASH_P3)
> +#define HV_MSR_CRASH_P4		(HV_X64_MSR_CRASH_P4)
> +#define HV_MSR_CRASH_CTL	(HV_X64_MSR_CRASH_CTL)
> +
> +#define HV_MSR_VP_INDEX		(HV_X64_MSR_VP_INDEX)
> +#define HV_MSR_TIME_REF_COUNT	(HV_X64_MSR_TIME_REF_COUNT)
> +#define HV_MSR_REFERENCE_TSC	(HV_X64_MSR_REFERENCE_TSC)
> +
> +#define HV_MSR_SINT0		(HV_X64_MSR_SINT0)
> +#define HV_MSR_SVERSION		(HV_X64_MSR_SVERSION)
> +#define HV_MSR_SCONTROL		(HV_X64_MSR_SCONTROL)
> +#define HV_MSR_SIEFP		(HV_X64_MSR_SIEFP)
> +#define HV_MSR_SIMP		(HV_X64_MSR_SIMP)
> +#define HV_MSR_EOM		(HV_X64_MSR_EOM)
> +
> +#define HV_MSR_NESTED_SCONTROL	(HV_X64_MSR_NESTED_SCONTROL)
> +#define HV_MSR_NESTED_SVERSION	(HV_X64_MSR_NESTED_SVERSION)
> +#define HV_MSR_NESTED_SIEFP	(HV_X64_MSR_NESTED_SIEFP)
> +#define HV_MSR_NESTED_SIMP	(HV_X64_MSR_NESTED_SIMP)
> +#define HV_MSR_NESTED_EOM	(HV_X64_MSR_NESTED_EOM)
> +#define HV_MSR_NESTED_SINT0	(HV_X64_MSR_NESTED_SINT0)
> +
> +#define HV_MSR_STIMER0_CONFIG	(HV_X64_MSR_STIMER0_CONFIG)
> +#define HV_MSR_STIMER0_COUNT	(HV_X64_MSR_STIMER0_COUNT)
>=20
>  /*
>   * Registers are only accessible via HVCALL_GET_VP_REGISTERS hvcall and
> diff --git a/arch/x86/include/asm/mshyperv.h
> b/arch/x86/include/asm/mshyperv.h
> index 033b53f993c6..b06d6fd75367 100644
> --- a/arch/x86/include/asm/mshyperv.h
> +++ b/arch/x86/include/asm/mshyperv.h
> @@ -293,24 +293,24 @@ static inline void hv_ivm_msr_write(u64 msr, u64
> value) {}
>  static inline void hv_ivm_msr_read(u64 msr, u64 *value) {}
>  #endif
>=20
> -static inline bool hv_is_synic_reg(unsigned int reg)
> +static inline bool hv_is_synic_msr(unsigned int reg)
>  {
> -	return (reg >=3D HV_REGISTER_SCONTROL) &&
> -	       (reg <=3D HV_REGISTER_SINT15);
> +	return (reg >=3D HV_X64_MSR_SCONTROL) &&
> +	       (reg <=3D HV_X64_MSR_SINT15);
>  }
>=20
> -static inline bool hv_is_sint_reg(unsigned int reg)
> +static inline bool hv_is_sint_msr(unsigned int reg)
>  {
> -	return (reg >=3D HV_REGISTER_SINT0) &&
> -	       (reg <=3D HV_REGISTER_SINT15);
> +	return (reg >=3D HV_X64_MSR_SINT0) &&
> +	       (reg <=3D HV_X64_MSR_SINT15);
>  }
>=20
> -u64 hv_get_register(unsigned int reg);
> -void hv_set_register(unsigned int reg, u64 value);
> -u64 hv_get_non_nested_register(unsigned int reg);
> -void hv_set_non_nested_register(unsigned int reg, u64 value);
> +u64 hv_get_msr(unsigned int reg);
> +void hv_set_msr(unsigned int reg, u64 value);
> +u64 hv_get_non_nested_msr(unsigned int reg);
> +void hv_set_non_nested_msr(unsigned int reg, u64 value);
>=20
> -static __always_inline u64 hv_raw_get_register(unsigned int reg)
> +static __always_inline u64 hv_raw_get_msr(unsigned int reg)
>  {
>  	return __rdmsr(reg);
>  }
> @@ -331,10 +331,10 @@ static inline int
> hyperv_flush_guest_mapping_range(u64 as,
>  {
>  	return -1;
>  }
> -static inline void hv_set_register(unsigned int reg, u64 value) { }
> -static inline u64 hv_get_register(unsigned int reg) { return 0; }
> -static inline void hv_set_non_nested_register(unsigned int reg, u64 valu=
e) { }
> -static inline u64 hv_get_non_nested_register(unsigned int reg) { return =
0; }
> +static inline void hv_set_msr(unsigned int reg, u64 value) { }
> +static inline u64 hv_get_msr(unsigned int reg) { return 0; }
> +static inline void hv_set_non_nested_msr(unsigned int reg, u64 value) { =
}
> +static inline u64 hv_get_non_nested_msr(unsigned int reg) { return 0; }
>  #endif /* CONFIG_HYPERV */
>=20
>=20
> diff --git a/arch/x86/kernel/cpu/mshyperv.c
> b/arch/x86/kernel/cpu/mshyperv.c
> index e6bba12c759c..649c1127054c 100644
> --- a/arch/x86/kernel/cpu/mshyperv.c
> +++ b/arch/x86/kernel/cpu/mshyperv.c
> @@ -45,70 +45,70 @@ bool hyperv_paravisor_present __ro_after_init;
>  EXPORT_SYMBOL_GPL(hyperv_paravisor_present);
>=20
>  #if IS_ENABLED(CONFIG_HYPERV)
> -static inline unsigned int hv_get_nested_reg(unsigned int reg)
> +static inline unsigned int hv_get_nested_msr(unsigned int reg)
>  {
> -	if (hv_is_sint_reg(reg))
> -		return reg - HV_REGISTER_SINT0 + HV_REGISTER_NESTED_SINT0;
> +	if (hv_is_sint_msr(reg))
> +		return reg - HV_MSR_SINT0 + HV_MSR_NESTED_SINT0;
>=20
>  	switch (reg) {
> -	case HV_REGISTER_SIMP:
> -		return HV_REGISTER_NESTED_SIMP;
> -	case HV_REGISTER_SIEFP:
> -		return HV_REGISTER_NESTED_SIEFP;
> -	case HV_REGISTER_SVERSION:
> -		return HV_REGISTER_NESTED_SVERSION;
> -	case HV_REGISTER_SCONTROL:
> -		return HV_REGISTER_NESTED_SCONTROL;
> -	case HV_REGISTER_EOM:
> -		return HV_REGISTER_NESTED_EOM;
> +	case HV_MSR_SIMP:
> +		return HV_MSR_NESTED_SIMP;
> +	case HV_MSR_SIEFP:
> +		return HV_MSR_NESTED_SIEFP;
> +	case HV_MSR_SVERSION:
> +		return HV_MSR_NESTED_SVERSION;
> +	case HV_MSR_SCONTROL:
> +		return HV_MSR_NESTED_SCONTROL;
> +	case HV_MSR_EOM:
> +		return HV_MSR_NESTED_EOM;
>  	default:
>  		return reg;
>  	}
>  }

This function is x86 specific, but you are using the generic HV_MSR_* flavo=
r
instead of the x86 specific HV_X64_MSR_* flavor like in other x86 specific =
code.
Both flavors work, but I wondered if there is any reason for using the gene=
ric flavor.

I remember debating myself the merits of one approach vs. the other, but I
don't think there was a solid argument either way.   Given that you are
doing the work to get this all fixed like it should have been originally, I=
 would
argue for being consistently one way or the other.  ARM64 specific code is
*not* using the generic HV_MSR_* flavor, so I suspect x86 code should not
either.

Michael

>=20
> -u64 hv_get_non_nested_register(unsigned int reg)
> +u64 hv_get_non_nested_msr(unsigned int reg)
>  {
>  	u64 value;
>=20
> -	if (hv_is_synic_reg(reg) && ms_hyperv.paravisor_present)
> +	if (hv_is_synic_msr(reg) && ms_hyperv.paravisor_present)
>  		hv_ivm_msr_read(reg, &value);
>  	else
>  		rdmsrl(reg, value);
>  	return value;
>  }
> -EXPORT_SYMBOL_GPL(hv_get_non_nested_register);
> +EXPORT_SYMBOL_GPL(hv_get_non_nested_msr);
>=20
> -void hv_set_non_nested_register(unsigned int reg, u64 value)
> +void hv_set_non_nested_msr(unsigned int reg, u64 value)
>  {
> -	if (hv_is_synic_reg(reg) && ms_hyperv.paravisor_present) {
> +	if (hv_is_synic_msr(reg) && ms_hyperv.paravisor_present) {
>  		hv_ivm_msr_write(reg, value);
>=20
>  		/* Write proxy bit via wrmsl instruction */
> -		if (hv_is_sint_reg(reg))
> +		if (hv_is_sint_msr(reg))
>  			wrmsrl(reg, value | 1 << 20);
>  	} else {
>  		wrmsrl(reg, value);
>  	}
>  }
> -EXPORT_SYMBOL_GPL(hv_set_non_nested_register);
> +EXPORT_SYMBOL_GPL(hv_set_non_nested_msr);
>=20
> -u64 hv_get_register(unsigned int reg)
> +u64 hv_get_msr(unsigned int reg)
>  {
>  	if (hv_nested)
> -		reg =3D hv_get_nested_reg(reg);
> +		reg =3D hv_get_nested_msr(reg);
>=20
> -	return hv_get_non_nested_register(reg);
> +	return hv_get_non_nested_msr(reg);
>  }
> -EXPORT_SYMBOL_GPL(hv_get_register);
> +EXPORT_SYMBOL_GPL(hv_get_msr);
>=20
> -void hv_set_register(unsigned int reg, u64 value)
> +void hv_set_msr(unsigned int reg, u64 value)
>  {
>  	if (hv_nested)
> -		reg =3D hv_get_nested_reg(reg);
> +		reg =3D hv_get_nested_msr(reg);
>=20
> -	hv_set_non_nested_register(reg, value);
> +	hv_set_non_nested_msr(reg, value);
>  }
> -EXPORT_SYMBOL_GPL(hv_set_register);
> +EXPORT_SYMBOL_GPL(hv_set_msr);
>=20
>  static void (*vmbus_handler)(void);
>  static void (*hv_stimer0_handler)(void);
> diff --git a/drivers/clocksource/hyperv_timer.c
> b/drivers/clocksource/hyperv_timer.c
> index 8ff7cd4e20bb..b2a080647e41 100644
> --- a/drivers/clocksource/hyperv_timer.c
> +++ b/drivers/clocksource/hyperv_timer.c
> @@ -81,14 +81,14 @@ static int hv_ce_set_next_event(unsigned long delta,
>=20
>  	current_tick =3D hv_read_reference_counter();
>  	current_tick +=3D delta;
> -	hv_set_register(HV_REGISTER_STIMER0_COUNT, current_tick);
> +	hv_set_msr(HV_MSR_STIMER0_COUNT, current_tick);
>  	return 0;
>  }
>=20
>  static int hv_ce_shutdown(struct clock_event_device *evt)
>  {
> -	hv_set_register(HV_REGISTER_STIMER0_COUNT, 0);
> -	hv_set_register(HV_REGISTER_STIMER0_CONFIG, 0);
> +	hv_set_msr(HV_MSR_STIMER0_COUNT, 0);
> +	hv_set_msr(HV_MSR_STIMER0_CONFIG, 0);
>  	if (direct_mode_enabled && stimer0_irq >=3D 0)
>  		disable_percpu_irq(stimer0_irq);
>=20
> @@ -119,7 +119,7 @@ static int hv_ce_set_oneshot(struct
> clock_event_device *evt)
>  		timer_cfg.direct_mode =3D 0;
>  		timer_cfg.sintx =3D stimer0_message_sint;
>  	}
> -	hv_set_register(HV_REGISTER_STIMER0_CONFIG,
> timer_cfg.as_uint64);
> +	hv_set_msr(HV_MSR_STIMER0_CONFIG, timer_cfg.as_uint64);
>  	return 0;
>  }
>=20
> @@ -372,11 +372,11 @@ static __always_inline u64
> read_hv_clock_msr(void)
>  	 * is set to 0 when the partition is created and is incremented in 100
>  	 * nanosecond units.
>  	 *
> -	 * Use hv_raw_get_register() because this function is used from
> -	 * noinstr. Notable; while HV_REGISTER_TIME_REF_COUNT is a
> synthetic
> +	 * Use hv_raw_get_msr() because this function is used from
> +	 * noinstr. Notable; while HV_MSR_TIME_REF_COUNT is a synthetic
>  	 * register it doesn't need the GHCB path.
>  	 */
> -	return hv_raw_get_register(HV_REGISTER_TIME_REF_COUNT);
> +	return hv_raw_get_msr(HV_MSR_TIME_REF_COUNT);
>  }
>=20
>  /*
> @@ -439,9 +439,9 @@ static void suspend_hv_clock_tsc(struct clocksource
> *arg)
>  	union hv_reference_tsc_msr tsc_msr;
>=20
>  	/* Disable the TSC page */
> -	tsc_msr.as_uint64 =3D hv_get_register(HV_REGISTER_REFERENCE_TSC);
> +	tsc_msr.as_uint64 =3D hv_get_msr(HV_MSR_REFERENCE_TSC);
>  	tsc_msr.enable =3D 0;
> -	hv_set_register(HV_REGISTER_REFERENCE_TSC, tsc_msr.as_uint64);
> +	hv_set_msr(HV_MSR_REFERENCE_TSC, tsc_msr.as_uint64);
>  }
>=20
>=20
> @@ -450,10 +450,10 @@ static void resume_hv_clock_tsc(struct clocksource
> *arg)
>  	union hv_reference_tsc_msr tsc_msr;
>=20
>  	/* Re-enable the TSC page */
> -	tsc_msr.as_uint64 =3D hv_get_register(HV_REGISTER_REFERENCE_TSC);
> +	tsc_msr.as_uint64 =3D hv_get_msr(HV_MSR_REFERENCE_TSC);
>  	tsc_msr.enable =3D 1;
>  	tsc_msr.pfn =3D tsc_pfn;
> -	hv_set_register(HV_REGISTER_REFERENCE_TSC, tsc_msr.as_uint64);
> +	hv_set_msr(HV_MSR_REFERENCE_TSC, tsc_msr.as_uint64);
>  }
>=20
>  #ifdef HAVE_VDSO_CLOCKMODE_HVCLOCK
> @@ -555,14 +555,14 @@ static void __init hv_init_tsc_clocksource(void)
>  	 * thus TSC clocksource will work even without the real TSC page
>  	 * mapped.
>  	 */
> -	tsc_msr.as_uint64 =3D hv_get_register(HV_REGISTER_REFERENCE_TSC);
> +	tsc_msr.as_uint64 =3D hv_get_msr(HV_MSR_REFERENCE_TSC);
>  	if (hv_root_partition)
>  		tsc_pfn =3D tsc_msr.pfn;
>  	else
>  		tsc_pfn =3D HVPFN_DOWN(virt_to_phys(tsc_page));
>  	tsc_msr.enable =3D 1;
>  	tsc_msr.pfn =3D tsc_pfn;
> -	hv_set_register(HV_REGISTER_REFERENCE_TSC, tsc_msr.as_uint64);
> +	hv_set_msr(HV_MSR_REFERENCE_TSC, tsc_msr.as_uint64);
>=20
>  	clocksource_register_hz(&hyperv_cs_tsc, NSEC_PER_SEC/100);
>=20
> diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
> index 51e5018ac9b2..a8ad728354cb 100644
> --- a/drivers/hv/hv.c
> +++ b/drivers/hv/hv.c
> @@ -270,7 +270,7 @@ void hv_synic_enable_regs(unsigned int cpu)
>  	union hv_synic_scontrol sctrl;
>=20
>  	/* Setup the Synic's message page */
> -	simp.as_uint64 =3D hv_get_register(HV_REGISTER_SIMP);
> +	simp.as_uint64 =3D hv_get_msr(HV_MSR_SIMP);
>  	simp.simp_enabled =3D 1;
>=20
>  	if (ms_hyperv.paravisor_present || hv_root_partition) {
> @@ -286,10 +286,10 @@ void hv_synic_enable_regs(unsigned int cpu)
>  			>> HV_HYP_PAGE_SHIFT;
>  	}
>=20
> -	hv_set_register(HV_REGISTER_SIMP, simp.as_uint64);
> +	hv_set_msr(HV_MSR_SIMP, simp.as_uint64);
>=20
>  	/* Setup the Synic's event page */
> -	siefp.as_uint64 =3D hv_get_register(HV_REGISTER_SIEFP);
> +	siefp.as_uint64 =3D hv_get_msr(HV_MSR_SIEFP);
>  	siefp.siefp_enabled =3D 1;
>=20
>  	if (ms_hyperv.paravisor_present || hv_root_partition) {
> @@ -305,13 +305,12 @@ void hv_synic_enable_regs(unsigned int cpu)
>  			>> HV_HYP_PAGE_SHIFT;
>  	}
>=20
> -	hv_set_register(HV_REGISTER_SIEFP, siefp.as_uint64);
> +	hv_set_msr(HV_MSR_SIEFP, siefp.as_uint64);
>=20
>  	/* Setup the shared SINT. */
>  	if (vmbus_irq !=3D -1)
>  		enable_percpu_irq(vmbus_irq, 0);
> -	shared_sint.as_uint64 =3D hv_get_register(HV_REGISTER_SINT0 +
> -					VMBUS_MESSAGE_SINT);
> +	shared_sint.as_uint64 =3D hv_get_msr(HV_MSR_SINT0 +
> VMBUS_MESSAGE_SINT);
>=20
>  	shared_sint.vector =3D vmbus_interrupt;
>  	shared_sint.masked =3D false;
> @@ -326,14 +325,13 @@ void hv_synic_enable_regs(unsigned int cpu)
>  #else
>  	shared_sint.auto_eoi =3D 0;
>  #endif
> -	hv_set_register(HV_REGISTER_SINT0 + VMBUS_MESSAGE_SINT,
> -				shared_sint.as_uint64);
> +	hv_set_msr(HV_MSR_SINT0 + VMBUS_MESSAGE_SINT,
> shared_sint.as_uint64);
>=20
>  	/* Enable the global synic bit */
> -	sctrl.as_uint64 =3D hv_get_register(HV_REGISTER_SCONTROL);
> +	sctrl.as_uint64 =3D hv_get_msr(HV_MSR_SCONTROL);
>  	sctrl.enable =3D 1;
>=20
> -	hv_set_register(HV_REGISTER_SCONTROL, sctrl.as_uint64);
> +	hv_set_msr(HV_MSR_SCONTROL, sctrl.as_uint64);
>  }
>=20
>  int hv_synic_init(unsigned int cpu)
> @@ -357,17 +355,15 @@ void hv_synic_disable_regs(unsigned int cpu)
>  	union hv_synic_siefp siefp;
>  	union hv_synic_scontrol sctrl;
>=20
> -	shared_sint.as_uint64 =3D hv_get_register(HV_REGISTER_SINT0 +
> -					VMBUS_MESSAGE_SINT);
> +	shared_sint.as_uint64 =3D hv_get_msr(HV_MSR_SINT0 +
> VMBUS_MESSAGE_SINT);
>=20
>  	shared_sint.masked =3D 1;
>=20
>  	/* Need to correctly cleanup in the case of SMP!!! */
>  	/* Disable the interrupt */
> -	hv_set_register(HV_REGISTER_SINT0 + VMBUS_MESSAGE_SINT,
> -				shared_sint.as_uint64);
> +	hv_set_msr(HV_MSR_SINT0 + VMBUS_MESSAGE_SINT,
> shared_sint.as_uint64);
>=20
> -	simp.as_uint64 =3D hv_get_register(HV_REGISTER_SIMP);
> +	simp.as_uint64 =3D hv_get_msr(HV_MSR_SIMP);
>  	/*
>  	 * In Isolation VM, sim and sief pages are allocated by
>  	 * paravisor. These pages also will be used by kdump
> @@ -382,9 +378,9 @@ void hv_synic_disable_regs(unsigned int cpu)
>  		simp.base_simp_gpa =3D 0;
>  	}
>=20
> -	hv_set_register(HV_REGISTER_SIMP, simp.as_uint64);
> +	hv_set_msr(HV_MSR_SIMP, simp.as_uint64);
>=20
> -	siefp.as_uint64 =3D hv_get_register(HV_REGISTER_SIEFP);
> +	siefp.as_uint64 =3D hv_get_msr(HV_MSR_SIEFP);
>  	siefp.siefp_enabled =3D 0;
>=20
>  	if (ms_hyperv.paravisor_present || hv_root_partition) {
> @@ -394,12 +390,12 @@ void hv_synic_disable_regs(unsigned int cpu)
>  		siefp.base_siefp_gpa =3D 0;
>  	}
>=20
> -	hv_set_register(HV_REGISTER_SIEFP, siefp.as_uint64);
> +	hv_set_msr(HV_MSR_SIEFP, siefp.as_uint64);
>=20
>  	/* Disable the global synic bit */
> -	sctrl.as_uint64 =3D hv_get_register(HV_REGISTER_SCONTROL);
> +	sctrl.as_uint64 =3D hv_get_msr(HV_MSR_SCONTROL);
>  	sctrl.enable =3D 0;
> -	hv_set_register(HV_REGISTER_SCONTROL, sctrl.as_uint64);
> +	hv_set_msr(HV_MSR_SCONTROL, sctrl.as_uint64);
>=20
>  	if (vmbus_irq !=3D -1)
>  		disable_percpu_irq(vmbus_irq);
> diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
> index ccad7bca3fd3..65c0740484cb 100644
> --- a/drivers/hv/hv_common.c
> +++ b/drivers/hv/hv_common.c
> @@ -228,19 +228,19 @@ static void hv_kmsg_dump(struct kmsg_dumper
> *dumper,
>  	 * contain the size of the panic data in that page. Rest of the
>  	 * registers are no-op when the NOTIFY_MSG flag is set.
>  	 */
> -	hv_set_register(HV_REGISTER_CRASH_P0, 0);
> -	hv_set_register(HV_REGISTER_CRASH_P1, 0);
> -	hv_set_register(HV_REGISTER_CRASH_P2, 0);
> -	hv_set_register(HV_REGISTER_CRASH_P3,
> virt_to_phys(hv_panic_page));
> -	hv_set_register(HV_REGISTER_CRASH_P4, bytes_written);
> +	hv_set_msr(HV_MSR_CRASH_P0, 0);
> +	hv_set_msr(HV_MSR_CRASH_P1, 0);
> +	hv_set_msr(HV_MSR_CRASH_P2, 0);
> +	hv_set_msr(HV_MSR_CRASH_P3, virt_to_phys(hv_panic_page));
> +	hv_set_msr(HV_MSR_CRASH_P4, bytes_written);
>=20
>  	/*
>  	 * Let Hyper-V know there is crash data available along with
>  	 * the panic message.
>  	 */
> -	hv_set_register(HV_REGISTER_CRASH_CTL,
> -			(HV_CRASH_CTL_CRASH_NOTIFY |
> -			 HV_CRASH_CTL_CRASH_NOTIFY_MSG));
> +	hv_set_msr(HV_MSR_CRASH_CTL,
> +		   (HV_CRASH_CTL_CRASH_NOTIFY |
> +		    HV_CRASH_CTL_CRASH_NOTIFY_MSG));
>  }
>=20
>  static struct kmsg_dumper hv_kmsg_dumper =3D {
> @@ -311,7 +311,7 @@ int __init hv_common_init(void)
>  		 * Register for panic kmsg callback only if the right
>  		 * capability is supported by the hypervisor.
>  		 */
> -		hyperv_crash_ctl =3D
> hv_get_register(HV_REGISTER_CRASH_CTL);
> +		hyperv_crash_ctl =3D hv_get_msr(HV_MSR_CRASH_CTL);
>  		if (hyperv_crash_ctl & HV_CRASH_CTL_CRASH_NOTIFY_MSG)
>  			hv_kmsg_dump_register();
>=20
> @@ -410,7 +410,7 @@ int hv_common_cpu_init(unsigned int cpu)
>  		*inputarg =3D mem;
>  	}
>=20
> -	msr_vp_index =3D hv_get_register(HV_REGISTER_VP_INDEX);
> +	msr_vp_index =3D hv_get_msr(HV_MSR_VP_INDEX);
>=20
>  	hv_vp_index[cpu] =3D msr_vp_index;
>=20
> @@ -507,7 +507,7 @@
> EXPORT_SYMBOL_GPL(hv_is_hibernation_supported);
>   */
>  static u64 __hv_read_ref_counter(void)
>  {
> -	return hv_get_register(HV_REGISTER_TIME_REF_COUNT);
> +	return hv_get_msr(HV_MSR_TIME_REF_COUNT);
>  }
>=20
>  u64 (*hv_read_reference_counter)(void) =3D __hv_read_ref_counter;
> diff --git a/include/asm-generic/hyperv-tlfs.h b/include/asm-generic/hype=
rv-
> tlfs.h
> index fdac4a1714ec..3d1b31f90ed6 100644
> --- a/include/asm-generic/hyperv-tlfs.h
> +++ b/include/asm-generic/hyperv-tlfs.h
> @@ -625,6 +625,37 @@ struct hv_retarget_device_interrupt {
>  	struct hv_device_interrupt_target int_target;
>  } __packed __aligned(8);
>=20
> +/*
> + * These Hyper-V registers provide information equivalent to the CPUID
> + * instruction on x86/x64.
> + */
> +#define HV_REGISTER_HYPERVISOR_VERSION		0x00000100 /*CPUID
> 0x40000002 */
> +#define HV_REGISTER_FEATURES			0x00000200 /*CPUID
> 0x40000003 */
> +#define HV_REGISTER_ENLIGHTENMENTS		0x00000201 /*CPUID
> 0x40000004 */
> +
> +/*
> + * Synthetic register definitions equivalent to MSRs on x86/x64
> + */
> +#define HV_REGISTER_CRASH_P0		0x00000210
> +#define HV_REGISTER_CRASH_P1		0x00000211
> +#define HV_REGISTER_CRASH_P2		0x00000212
> +#define HV_REGISTER_CRASH_P3		0x00000213
> +#define HV_REGISTER_CRASH_P4		0x00000214
> +#define HV_REGISTER_CRASH_CTL		0x00000215
> +
> +#define HV_REGISTER_GUEST_OSID		0x00090002
> +#define HV_REGISTER_VP_INDEX		0x00090003
> +#define HV_REGISTER_TIME_REF_COUNT	0x00090004
> +#define HV_REGISTER_REFERENCE_TSC	0x00090017
> +
> +#define HV_REGISTER_SINT0		0x000A0000
> +#define HV_REGISTER_SCONTROL		0x000A0010
> +#define HV_REGISTER_SIEFP		0x000A0012
> +#define HV_REGISTER_SIMP		0x000A0013
> +#define HV_REGISTER_EOM			0x000A0014
> +
> +#define HV_REGISTER_STIMER0_CONFIG	0x000B0000
> +#define HV_REGISTER_STIMER0_COUNT	0x000B0001
>=20
>  /* HvGetVpRegisters hypercall input with variable size reg name list*/
>  struct hv_get_vp_registers_input {
> @@ -640,7 +671,6 @@ struct hv_get_vp_registers_input {
>  	} element[];
>  } __packed;
>=20
> -
>  /* HvGetVpRegisters returns an array of these output elements */
>  struct hv_get_vp_registers_output {
>  	union {
> diff --git a/include/asm-generic/mshyperv.h b/include/asm-
> generic/mshyperv.h
> index cecd2b7bd033..2dc65c1d3117 100644
> --- a/include/asm-generic/mshyperv.h
> +++ b/include/asm-generic/mshyperv.h
> @@ -157,7 +157,7 @@ static inline void vmbus_signal_eom(struct
> hv_message *msg, u32 old_msg_type)
>  		 * possibly deliver another msg from the
>  		 * hypervisor
>  		 */
> -		hv_set_register(HV_REGISTER_EOM, 0);
> +		hv_set_msr(HV_MSR_EOM, 0);
>  	}
>  }
>=20
> --
> 2.25.1
>=20


