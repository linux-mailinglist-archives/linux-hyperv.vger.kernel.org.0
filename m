Return-Path: <linux-hyperv+bounces-3583-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CA7DA02F21
	for <lists+linux-hyperv@lfdr.de>; Mon,  6 Jan 2025 18:37:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B7EF1628F6
	for <lists+linux-hyperv@lfdr.de>; Mon,  6 Jan 2025 17:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62FA11DB92A;
	Mon,  6 Jan 2025 17:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Uz9LO3nv"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11olkn2108.outbound.protection.outlook.com [40.92.20.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 700CF1DE8A3;
	Mon,  6 Jan 2025 17:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.20.108
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736185046; cv=fail; b=d9QX8CD1AGEuuNK6kA90pZBfqSADPL4nztdZRTB5n8+JMQ8eqRO9Yysoxw0LLy1EoBgG/AQCrlgKoGkU03Cquf1daYYSQ/deq4NSfyYf4D83d5ADaXIHUTtOnSDsfQqt8fqYr2w+CFucnfSBbjLCYVmi8+TrY+VEpE6sEADtHiU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736185046; c=relaxed/simple;
	bh=xxeoHhq0UTawEOHtqxce5Z8a6XzPsOkX0Xuhfqnt6nM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=i++R7cMh4I9BhFg2OUVA7YrPeYy8wSHTEd9+SIhPsKzaQzhjrRamf87BPxVPUjowAAHBWMysawj7ERHoaIdsXgaxNyUxTC9fR8T537QaCBYAxb/j/K72mHhDGuf0EzGc4Pso6B+urCKVNJmmJL6Wrrgy/0xTLI/2gVZojsRjmRQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Uz9LO3nv; arc=fail smtp.client-ip=40.92.20.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GrxUq2jyi/pWXw8JQy0iZehyiSqp49Am+Ivh6/gEqjWmKixhs+I+C/eZOQpjRmnLCGJN3eCrVOBOh2yjh5RE9lvpF7tMVh8XZd4+qz1uX3GVf8f8KLzQ3mHvXTizXyQbvt84lP9eYdTRMRyV5ksT8iYrTHuGcU884v22HkYw0ZlWY/JpkwGi4Q0auZruEo/C2ExEKxqGwAfaoe2pszsNnEIWBVoUgtIlM/+gNBH8G8S5khbrchg9/TwZyw2SQx9vMAGKI95PTDXFmrLeGz6nLZpwlsDy6lciBV5v/++FyFfHe/4gU+SLmON55e5tFe54a/YC9dqlvBh2xgANoHKFhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Ph9MBGzNwPpx3pvnp+/FtkuhcX7bwkyR7tpPRyYt9I=;
 b=d9xTIU67RbvMiT6x8nOUqcErfzsM5Y75YHWaln+PSqtVXW4ASoS2sz3GOCG2u44Qpgqt3KR5wDrFn3vxmic19vMOCTTZ66I79b9RBOPYuiB59NxAhGSiDjXMVVM/RzZb4kOds24fRmf2QsLTd2o0Q680VXX9U+WXf7M7IddloKQtE7OEYS5wH54m6cHHcAyCunUx779BTtHtScPZMGkW4vfRwR/giwz55ES6gPlQe43jRvGbMICWMuoyLi9lkCSRHWHc3nbeuAZ5jd0Bc/Tx+NZ9/6jAVzx9cFafUG3dOcdoFoNyY8nc77PKhQhF0UYlgMXLW+J2920UneKH70Kx6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Ph9MBGzNwPpx3pvnp+/FtkuhcX7bwkyR7tpPRyYt9I=;
 b=Uz9LO3nvrH0+If10bbGvR65mgXhYCLabGSYJK1QIvJYbPtgi97h0S+kBsqmDepQObFoVCv4j+t5zspugvrXDL7hmocWckJDibMO3XHFcaVzM0zEPJHYZW380ptbB1s68DkJaitrkxs4CHh4EWxGNIkqJbjc0HAGXjyXLliONKcx7AL8/NryB22waJpgLZGf6eDldVQ2u+CYpWAmristcktPYxk9iS/16NXN4Qb20MnwCTwe5lSH7Q3re8RIDiSeYOlq7WjQEQcsZApstIyDw3SdkSPKhFV8sw1CndYtW7FRoYPwgRwJvVbA++XWXig4uq2wD92fRZCYlsxcKflBULw==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by DM6PR02MB6809.namprd02.prod.outlook.com (2603:10b6:5:218::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.18; Mon, 6 Jan
 2025 17:37:21 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%2]) with mapi id 15.20.8314.015; Mon, 6 Jan 2025
 17:37:21 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Roman Kisel <romank@linux.microsoft.com>, "hpa@zytor.com" <hpa@zytor.com>,
	"kys@microsoft.com" <kys@microsoft.com>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"decui@microsoft.com" <decui@microsoft.com>, "eahariha@linux.microsoft.com"
	<eahariha@linux.microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "mingo@redhat.com" <mingo@redhat.com>,
	"nunodasneves@linux.microsoft.com" <nunodasneves@linux.microsoft.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "tiala@microsoft.com"
	<tiala@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>
CC: "apais@microsoft.com" <apais@microsoft.com>, "benhill@microsoft.com"
	<benhill@microsoft.com>, "ssengar@microsoft.com" <ssengar@microsoft.com>,
	"sunilmut@microsoft.com" <sunilmut@microsoft.com>, "vdso@hexbites.dev"
	<vdso@hexbites.dev>
Subject: RE: [PATCH v5 1/5] hyperv: Define struct hv_output_get_vp_registers
Thread-Topic: [PATCH v5 1/5] hyperv: Define struct hv_output_get_vp_registers
Thread-Index: AQHbWuYC2DCvgIgzsku9OIIZyqWxALMKBg3Q
Date: Mon, 6 Jan 2025 17:37:21 +0000
Message-ID:
 <SN6PR02MB4157F8C28BD92F36B27C9032D4102@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20241230180941.244418-1-romank@linux.microsoft.com>
 <20241230180941.244418-2-romank@linux.microsoft.com>
In-Reply-To: <20241230180941.244418-2-romank@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|DM6PR02MB6809:EE_
x-ms-office365-filtering-correlation-id: 52f03d4f-fccf-4424-f582-08dd2e78c654
x-microsoft-antispam:
 BCL:0;ARA:14566002|8062599003|15080799006|8060799006|19110799003|461199028|102099032|440099028|3412199025;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?wiknHeqvCZH+e+uOPXZbgd48N+06kjVxI2rCVne5xZIo/sWIXRUWCInUZzqA?=
 =?us-ascii?Q?36MyOFm3dvHHJxHbh95V1KqkmXSwFmGILz4Hw64NMmgny+uWbO3yRJcvCflW?=
 =?us-ascii?Q?s4hL4DmhZLlSBsdoqA/riCL2PEgLg7vBQNS6GXctHvdxNuRuTtbmDcGAmA+v?=
 =?us-ascii?Q?0B7+8aPItQ6ESDPlxwXP398/pZtgjrT0IP/YgLpzZfHbUnFq7u6aA2AKw4vs?=
 =?us-ascii?Q?RnirtN1bumH0PNe3W6qwx+VJLzh7MtKIV7b+mOtUbSU+rh0iKxaDxanLxsKV?=
 =?us-ascii?Q?NYWy6DCDUe23IB4kLI0lHevB2XduUBH9XcbbFm+aJOgkRkiQpp2SsEr59XxG?=
 =?us-ascii?Q?yF0kwk2NqXpkjyGyq4s+t1cRrSfVa68J0SV4sXRNoPW3vW144h1HE6Kh9A4J?=
 =?us-ascii?Q?tfnhI+5I0Jv414D/W96yCyCy7Hazj2syLfasngLZrO5Adx0WEiC3rzy0SP9/?=
 =?us-ascii?Q?KncS9mwY8bJxzbQlOZuiRslKolE8rqS8AMiRqmhGDUqsH20WkM/b0nPa3kqo?=
 =?us-ascii?Q?F3wSZ3rRwWynVixjhGQarhR80PzGZ/1Pd28gxFlxK3shm/bFWNr4I1wYdj+g?=
 =?us-ascii?Q?Oq40TWk+KKshEX0zZCfFnIPjsNLJbnzAk/DK3/fNQctesvXPOfVIwV/EYSUY?=
 =?us-ascii?Q?/J0R+0u6iYWtzf15NJkl3mupkffMWaCmjEGz0JeW3VBo6NMgsIcQ79dCNUQt?=
 =?us-ascii?Q?rWFtuavncto8ryq4TYWZLleuzXOgc0vWcYpNOUjv6f3va0drZflAm9RBNKgD?=
 =?us-ascii?Q?/cr7rxATBgmT+VgZHhAaoFE4fxjhLd0Yx0T1yHBMYaFY76Z22hb9ZIrHLQ2p?=
 =?us-ascii?Q?6r8vBGzZBkEhRY9CKBAfob7KQZbCbvkyqtSc6j9ACFtXzjrfXM3Iik0d2qmC?=
 =?us-ascii?Q?7cWV9YX7w5wJ9KgijTLdV7ctL6S1jkLdJiJh7efA+E3Wj3hOSYFE0PAJliXB?=
 =?us-ascii?Q?TvYGCxTS/a3f43cHJRYnwNfG/YhybCm7eV/ey0xntouCvoBcLTEx7NkwXfOw?=
 =?us-ascii?Q?zbVwjNAfNcb0wKRZuiPBD94QOI0qopu909dZ48u9UHdvrlg=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?FWP6TnhBro8a/pSi+7C7s6+EK6ibT2D7Ywe8DqLR+/h1m5a25txjN9Qldmoz?=
 =?us-ascii?Q?/kCFtLYGy9ZmgA7+gVQk5tewVeL6YEKjZi1zX7z5nQbILJajYw2pjm4iin/T?=
 =?us-ascii?Q?KLRqyXB7MFsPsbhN6QnkaCsANhr8XPfqdVR6qiYzGiFOpUneLcvxmLjukB6x?=
 =?us-ascii?Q?JoqJo/HbJNdaXZQdrdl1GplPJLTYJ9SuK0RJpZcfSTbg61h5d0sbRrVWFQGi?=
 =?us-ascii?Q?2xVIYfLN//w85pGAZB+18ajxKtWUSOzxwwwOLDr9FVNimyjiokziCY7f1u7R?=
 =?us-ascii?Q?Wd4z1NMg8U6ko+YQMkS30KP/1OK2MDyqsp0HIMBgUTMEB79pLNGAG2Ol+tnd?=
 =?us-ascii?Q?7NgXeqGeUmoXOBk1TS1yYduUxgyKf14HQSlQTqO0lMAsa1CbaNqYkqmqjhUg?=
 =?us-ascii?Q?/2gisQ0oX2mqi37C4HIME7OOiIZ0QbTEp5ysNVH4+bbob9mN0EzrW00kSs/g?=
 =?us-ascii?Q?7sZ9Olyx80xowfRhYGV/w1cAvORxHBz+xZawua+gNnMFaCmOOreDBUbL5Y2w?=
 =?us-ascii?Q?jqo80UX1gbJnn+FeZzT5NbpnXV9/Nhxiwo6iVJTIQ4Hz6PyDG8u3FGo7DLYF?=
 =?us-ascii?Q?cKy46Trq97u9v66saBfssRicmAi8qpCu381IFw48IWKsRdRLfl+dtXB8lMx4?=
 =?us-ascii?Q?VHFIsbsu3co6o9hM8wn3//kb7x55gl5Qojl+R7vqkDi2xV/nyjg3ukt0vieD?=
 =?us-ascii?Q?xCayCakG+amV9kuEPD3xR8l8VNNtFv8Ck/fr+vA0cMLUR1WEu12vR75HZ10Z?=
 =?us-ascii?Q?QAPaPYEnIj5vbXYpJ/laboppCXJ5hSeZxTptaaXvsjTAKxtmZ6DEWBXXWoAm?=
 =?us-ascii?Q?aV0rgzBImZATCTkj3c2V+/fNyINKhLuqRJSxZwfPcuG4d62EobGgWGblWg/Q?=
 =?us-ascii?Q?+e8jPSf+IeFXc49eAv21WwjcpBAgrlp3ZMWLzurK4KFdopW0obfTr74RPXak?=
 =?us-ascii?Q?DCBN9dAPLydNt23uIzQIzME3om+CxHdFi6ifJoLncmt+AHHSacFaqRHAcfSs?=
 =?us-ascii?Q?EGJNHX1wB1G/l+Ntm/eOpn0MmeDSPhwyhkCBpr83iw/Tqm0L0mnDiVmMMKuX?=
 =?us-ascii?Q?Rt55CO+ybvXnWUZbAjmb6LlxHP2SWd3xbk9sSo9s3SyQpitGqMqV3u+m1uhH?=
 =?us-ascii?Q?pXncDZ4i6XAzCF04owpqIaNobHHrNBdrtzdnFIIoSlzU2ZXGIhMYLo8RPMgd?=
 =?us-ascii?Q?cUVOz05B+wcdrDHLYvtWcKEN7bIQqg0MTv/gAS+rykDyf/Oio4eDHKk25PY?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 52f03d4f-fccf-4424-f582-08dd2e78c654
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jan 2025 17:37:21.4813
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB6809

From: Roman Kisel <romank@linux.microsoft.com> Sent: Monday, December 30, 2=
024 10:10 AM
>=20
> There is no definition of the output structure for the
> GetVpRegisters hypercall. Hence, using the hypercall
> is not possible when the output value has some structure
> to it. Even getting a datum of a primitive type reads
> as ad-hoc without that definition.
>=20
> Define struct hv_output_get_vp_registers to enable using
> the GetVpRegisters hypercall. Make provisions for all
> supported architectures. No functional changes.
>=20
> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
> ---
>  include/hyperv/hvgdk_mini.h | 49 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 49 insertions(+)
>=20
> diff --git a/include/hyperv/hvgdk_mini.h b/include/hyperv/hvgdk_mini.h
> index db3d1aaf7330..e8e3faa78e15 100644
> --- a/include/hyperv/hvgdk_mini.h
> +++ b/include/hyperv/hvgdk_mini.h
> @@ -1068,6 +1068,35 @@ union hv_dispatch_suspend_register {
>  	} __packed;
>  };
>=20
> +union hv_arm64_pending_interruption_register {
> +	u64 as_uint64;
> +	struct {
> +		u64 interruption_pending : 1;
> +		u64 interruption_type : 1;
> +		u64 reserved : 30;
> +		u32 error_code;

These bit field definitions don't look right. We want to "fill up"
the field size, so that we're explicit about each bit, and not leave
it to the compiler to add padding (which __packed tells the
compiler not to do). So in aggregate, the "u64" bit fields should
account for all 64 bits, but here you account for only 32 bits.
There are two ways to fix this:

		u32 interruption_pending : 1;
		u32 interruption_type: 1;
		u32 reserved : 30;
		u32 error_code;
Or
		u64 interruption_pending : 1;
		u64 interruption_type: 1;
		u64 reserved : 30;
		u64 error_code : 32;

> +	} __packed;
> +};
> +
> +union hv_arm64_interrupt_state_register {
> +	u64 as_uint64;
> +	struct {
> +		u64 interrupt_shadow : 1;
> +		u64 reserved : 63;
> +	} __packed;
> +};
> +
> +union hv_arm64_pending_synthetic_exception_event {
> +	u64 as_uint64[2];
> +	struct {
> +		u32 event_pending : 1;
> +		u32 event_type : 3;
> +		u32 reserved : 4;

Same here. Expand the "reserved" field to 28 bits?  Or maybe
there's a reason to have two separate reserved fields of 4 bits
and 24 bits. I'm not sure what the register layout is supposed to
be. Looking at hv_arm64_pending_synthetic_exception_event
in the OHCL-Linux-Kernel github tree shows the same gap of
24 bits, so that doesn't provide any guidance.

> +		u32 exception_type;
> +		u64 context;
> +	} __packed;
> +};
> +
>  union hv_x64_interrupt_state_register {
>  	u64 as_uint64;
>  	struct {
> @@ -1103,8 +1132,28 @@ union hv_register_value {
>  	union hv_explicit_suspend_register explicit_suspend;
>  	union hv_intercept_suspend_register intercept_suspend;
>  	union hv_dispatch_suspend_register dispatch_suspend;
> +#ifdef CONFIG_ARM64
> +	union hv_arm64_interrupt_state_register interrupt_state;
> +	union hv_arm64_pending_interruption_register pending_interruption;
> +#endif
> +#ifdef CONFIG_X86
>  	union hv_x64_interrupt_state_register interrupt_state;
>  	union hv_x64_pending_interruption_register pending_interruption;
> +#endif
> +	union hv_arm64_pending_synthetic_exception_event pending_synthetic_exce=
ption_event;
> +};

Per the previous discussion, I can see that the #ifdef's are needed
here to disambiguate the field names that are the same, but have
different unions on x86 and arm64.

But on the flip side, I wonder if the field names should really be the
same. Because of the different unions, it seems like they couldn't be
accessed by architecture neutral code (unless the access is just using
the "as_uint64" option?). So giving the fields names like
"x86_interrupt_state" and "arm64_interrupt_state" instead of just
"interrupt_state" might be more consistent with how the rest of this
file handles architecture differences. But I don't know all the implication=
s
of making such a change.

Nuno -- your thoughts?

Michael

> +
> +/*
> + * NOTE: Linux helper struct - NOT from Hyper-V code.
> + * DECLARE_FLEX_ARRAY() needs to be wrapped into
> + * a structure and have at least one more member besides
> + * DECLARE_FLEX_ARRAY.
> + */
> +struct hv_output_get_vp_registers {
> +	struct {
> +		DECLARE_FLEX_ARRAY(union hv_register_value, values);
> +		struct {} values_end;
> +	};
>  };
>=20
>  #if defined(CONFIG_ARM64)
> --
> 2.34.1


