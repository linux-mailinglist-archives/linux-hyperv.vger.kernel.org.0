Return-Path: <linux-hyperv+bounces-6117-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF774AFAA04
	for <lists+linux-hyperv@lfdr.de>; Mon,  7 Jul 2025 05:13:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AE351897D02
	for <lists+linux-hyperv@lfdr.de>; Mon,  7 Jul 2025 03:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AD4B2264CA;
	Mon,  7 Jul 2025 03:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="YRY9VLr1"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12olkn2098.outbound.protection.outlook.com [40.92.22.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A55136672;
	Mon,  7 Jul 2025 03:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.22.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751858028; cv=fail; b=f6tK/1O6fGe761ymzcaAGEzEklUDhpuM5RnO2XSZJSYRvQcrnVRzCIhpDdm5Ze3qYbJ/IA1itHphUBCmtXxlNAo6nmOYf0P1s+cMn4zLg9z/s8PwxH9dzkrWKjIXWgb3m+Ow9D80YJ/IghBmlkUOqJ3iud10LLO9l3wtkS9VIhY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751858028; c=relaxed/simple;
	bh=+DelOqIPsmwEHKkkwypsa1OlPnO4hdcQdQT8shDgYG0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=vD/5z8o1RVKRCvkalYscXHjel849XkIqjy0alEwMLNwf4PljjO44Gnta/T2ZuFH2uWx8dRDAMhhf4cH+hRna4TVev+rPJa/caVqJXLg+oU+e46XWWYegtwxkdFM/gAMQHU6no/e/wq7YWd/GUt/Z6YozABsEkrULVF1DFBIb04M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=YRY9VLr1; arc=fail smtp.client-ip=40.92.22.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wXfw/Dkgfvv58ihVEvMN5C3xhJTb1ZqbMuMMkNebXaRh4fwmcHEaxwdHmzvMTyo6kxZglb41Kdu9dE40Son98TvRlqCuv8OexjYr0N+VB0HzdIkBfc6YUHyTRDsqutxxmlg12/2f3GF9DX2yOVNa7wRdN7mUEfBwO5AjoaqoVforNWA4AR3T8QUOn4gu14cks8ql+o7aLdBTTtfv7eFO5yY/kGSlEM5dpQzSf3vetqn2S+wMQXUcnajK0sDKq30pOx5+8F0iNuzsJ9dLa0dhwd2nfH6NzWdhk2Aendn1XgpNQ+DRsHnRglRxyRgZcdDo/+thKIlHYxIJk+bHFZSo9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9nxiL1GJFxvG1YU1BWspqrVLPXq54g1gQk+3zF0AsmY=;
 b=ZquUqTdh34QMAJG0EC4G8GR+oZi/G7jvJajkCBbyAtUnCa4Sk+SbiauvWF5C4NUFpYwb4/XyiN+Prxdt8kII97mBQcwQpuZQP7Pm3P99bO7uF+H+zRFO4u3nM7E8EbVDztz3ujIRyJU4EGvaL8fymn5+geOVb3S3aS5CNUbLGxmnAkHgQpw+QVZ+ZVDwram0wBTkvtNFAH0v2rgJqtjIDQNMJB03tiMR56cs/z9gtDow0n5TXmeaizZu/qz2MMB8uYhOQCrMGg92E/6SHa6VFtt0rjyE5mknM1Dd3jFWnX+VeGNNm8doUBMWEijwY2odUDLcE32f8OMdCYdTRaub8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9nxiL1GJFxvG1YU1BWspqrVLPXq54g1gQk+3zF0AsmY=;
 b=YRY9VLr1KMRGC202E7givOsUP1tG1olrtiY+VCg6J23JejlrFcHRXSuX6sg+zrFZwFID3hZfhWHXcHgmiGjMZ4KLAN1i4skRw+sTpyHjBxu5yaPEjCBv/0k9fwd7ivU0sZsVTVYFwJK9/5r2Zn0d922rHXfv8C/G99Sbc4cBF+LhZ+11YX0P8TOU7+s9usd7JJpj/BN3U1o/EnE33T9Dt2h1M1K4sA4aplPcz7JZnGO0yKfUgI7/ldfw0AYSL5XxwxlTkcvMJM2uboWw3+yHSWwiV8wCtjrXyA8zEIj6WykWIa1vI4+xqfWj/e/WVcSaK1VHtpXKHRdu5tOFjCyk/g==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by SA1PR02MB8543.namprd02.prod.outlook.com (2603:10b6:806:1fa::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.22; Mon, 7 Jul
 2025 03:13:44 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%4]) with mapi id 15.20.8901.018; Mon, 7 Jul 2025
 03:13:44 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"bhelgaas@google.com" <bhelgaas@google.com>, "romank@linux.microsoft.com"
	<romank@linux.microsoft.com>
CC: "kys@microsoft.com" <kys@microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>, "catalin.marinas@arm.com"
	<catalin.marinas@arm.com>, "will@kernel.org" <will@kernel.org>,
	"mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "hpa@zytor.com"
	<hpa@zytor.com>, "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"kw@linux.com" <kw@linux.com>, "robh@kernel.org" <robh@kernel.org>,
	"jinankjain@linux.microsoft.com" <jinankjain@linux.microsoft.com>,
	"skinsburskii@linux.microsoft.com" <skinsburskii@linux.microsoft.com>,
	"mrathor@linux.microsoft.com" <mrathor@linux.microsoft.com>, "x86@kernel.org"
	<x86@kernel.org>
Subject: RE: [PATCH v2 2/6] Drivers: hv: Use nested hypercall for post message
 and signal event
Thread-Topic: [PATCH v2 2/6] Drivers: hv: Use nested hypercall for post
 message and signal event
Thread-Index: AQHb7GwYlh5esMaOEkKWizhFY+4XUbQjmWLA
Date: Mon, 7 Jul 2025 03:13:43 +0000
Message-ID:
 <SN6PR02MB41576CBCA98ECA4C77BCC2D7D44FA@SN6PR02MB4157.namprd02.prod.outlook.com>
References:
 <1751582677-30930-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1751582677-30930-3-git-send-email-nunodasneves@linux.microsoft.com>
In-Reply-To:
 <1751582677-30930-3-git-send-email-nunodasneves@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|SA1PR02MB8543:EE_
x-ms-office365-filtering-correlation-id: 6fc47c1e-3282-45d3-438e-08ddbd0447e6
x-microsoft-antispam:
 BCL:0;ARA:14566002|8062599006|8060799009|41001999006|19110799006|15080799009|461199028|40105399003|3412199025|440099028|102099032;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?CZ79aImf6gkfJrKY18EtS/xc6pNLf4t5R5HnBs+JDs9b7FYyBFwkcJGt90MM?=
 =?us-ascii?Q?z1QZNJmqfaeh4byMaW1skrYNp7hA6kgR5tCk7qM6A0D/RYEa6fpSQEpGC80V?=
 =?us-ascii?Q?I2SEiCRZeVA2NZ6FtBxluQxmYhvcp+E4g2QUv2J8VWL/zfFVo8zb+vhZfiR7?=
 =?us-ascii?Q?z5FQRegYFg4L0YRQRbzxP6AxQ+yV3ZT4PP1mH4NhR9SeFykx1MtzNE5jQBzD?=
 =?us-ascii?Q?Lk3wDaMPs0j5zENQswQwoq3kZhYCyDiwU+W0aUAkH/KGYpsP1Q0AoRI58Eid?=
 =?us-ascii?Q?SgNHa8gmERXH0axEESv/reY9ZIzy6cG/cLtNqVvK1Ue7u/8w4gxQazOfOhdq?=
 =?us-ascii?Q?mB+/LJTLuTaBqIpSEvpMGmhPZasmSSYOkm9HSYGRN4dO9d6358SVxpSyCmR2?=
 =?us-ascii?Q?r5VznFCLrMLJ/FUzvpUevx+c2//fglANzoWN00LzIJpYwLK5RCIf46RV00pt?=
 =?us-ascii?Q?QDS5NDcMVHbtfKmw2D5EG962YtmxKNSb5PCJJ6qFS2efy8vH9ESpzVB/ji90?=
 =?us-ascii?Q?1Ch0ED8C3gWytApdjHcYObbaLylMPKcG6ri/L+IkBYM8TC4GnWWtRms5hquk?=
 =?us-ascii?Q?PLpUz4REvnPn/+FcA+El/0EiAVh8XTGF1l6kiVluwsvPPdL/hwJDfsEFM0C0?=
 =?us-ascii?Q?+vPtZ/E2bqUn6hiZbQPcr43sXBFqmlAFg4jexP7IyiG2WB+VyqVWNxVWUrtO?=
 =?us-ascii?Q?IpBXGWyB8ryJTvtQPQKtKIxT6w5LTvGUXgEC9wXX+igSvxY5SHjlnZYIDucQ?=
 =?us-ascii?Q?uZP5lHZukicApnfZ5etcvtFpB57EYToISUYXjNQ/aVqjfvq3PvnmET5+0RGS?=
 =?us-ascii?Q?kaWQ1M4enpWCnxW5ezl2h+1mGAddFQCsCAQg+mfl7kiXk1/K1NcE0NsNq8a6?=
 =?us-ascii?Q?APb5+3NFqlJR48Muj0CMvM9t0T5y3YXtNT13RrAsTl0QWQcycSUgzo0v5wbp?=
 =?us-ascii?Q?EaChaKIZyDhHDfQbSWSqQA2B/V3iMz2tqMziHn9mwuuZ6qog+OgCHhbQzeym?=
 =?us-ascii?Q?+OKywwCRkICmZo0NkGmM3wjOVOpiJiSSKVifwmwc5NSldtkVfBDLh7lnT1H6?=
 =?us-ascii?Q?Pe9EKl7DB3MuJr3CVw1o8tsm+Xt+4e60asCkV6AzZ3THOaDP03SHYxMV6Plb?=
 =?us-ascii?Q?ucawAetCTwuIeQhL+8yW0QngA5iJuiRGJw=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?x0B8xJC5cOGkEdUFxdkDU7BZgNFX71+a58Um+MXbWvQ8O5U59PoejjzzwtkO?=
 =?us-ascii?Q?v2lUwfQALioCEqY0OROzoEQnqy579oy0WeJRkItxHN5i68qocJK1FMSUL6s9?=
 =?us-ascii?Q?/piKyJFSQn3pIxek5PxLntRk6+CYRtWZV5QL1j2gXtKBjcpHzeoOjuZ+AQp/?=
 =?us-ascii?Q?RkXevDnlQ4fDPX5THL6dpNdyav11y1iO+ys4z2tm7tvN1c0pp+7yyi7W8Q4T?=
 =?us-ascii?Q?EB9RApkV+FcztbMQQx3Ot+2t+jrUiz9kABOsLeNn0qb/DsbXf0zjyX86P007?=
 =?us-ascii?Q?VaLjWNL5fGHZoN/bYmI1Jy8L56Qk2yAh+7KACTnynBo1LgC8OQ5T/CN3B3bb?=
 =?us-ascii?Q?HY/J8Ca3NCPRAfy2t+GbF3udJPUXarCzLGsCiGBSmv1yIKm5b1F4AG7arX9j?=
 =?us-ascii?Q?hZcgwUTAScjskeftMkZClX006bN4KYiD9QlxmqWuOhxkawB5k+yemuBD2b39?=
 =?us-ascii?Q?+nbXOxY+ToKMTbJdATmL9zetmIjqWKxxGixsnc9ktJ7COj+v/gobLd3k+g5I?=
 =?us-ascii?Q?Hf8IXtc9z2uxjeg0B4bntrnGxG77CCPdc3k+5IJT7IQyLg/4O2bgZoVGExrd?=
 =?us-ascii?Q?3p5lAmo7X4kNgw34BAVCvx70CN7J+5tzdeXgmE6Ay8FYb22qbfchBqIPXHRk?=
 =?us-ascii?Q?VPN0bFWNevgWhSa4hgSdMKLJl52HMkTWub+QLMkdxNqIQ/4zXMbFKid0KwXF?=
 =?us-ascii?Q?fBz0aMpQU1hzbQ2awiHiBDJZvp2u+1k95kMRpob3sE0n6CN5cXTJBWf44BIS?=
 =?us-ascii?Q?BGVJvWO10LwGIkii953DRZqoHSlKRlBCb+Ge9mvcOdPjAv3MJSoS8uMHBkuX?=
 =?us-ascii?Q?WaDmHtRsEhKQvgAzBDJAWK1ie5HFCLE/W/HJXUeg72MHeQ3mnqUWoRJZGCZ9?=
 =?us-ascii?Q?KjINUWXXvsKCUzBU+rlo3gdLkSS1bXPmU6Jx/6Aw1sLyVU8Iyefua18zO7yw?=
 =?us-ascii?Q?GZ6yuDTN5m60zCHThQI3q6FUM4badpJj1GtCWgielzbjB0/bLLlQwPHKjnbT?=
 =?us-ascii?Q?sSx2mfhHYo4lKdVKjp49JHx+duD7TUUpqRUbjAoVt2tFoCbTzgduW4s0ftkP?=
 =?us-ascii?Q?nDI/eMvuqqRvK/p4OKVNT/XjanY9MB4W3azcDQizbs/DPbJmS9Xbwd0I5v5i?=
 =?us-ascii?Q?I5FnKDCBF/cSy0/DLAIKDFEe5B+EyFnTg4WrKinOhHJss2zCTvNMwn9Ju62m?=
 =?us-ascii?Q?GJtmDJWlrrRkuq/b8MyG8+GspwH4DbxFMz1OvHvqt9nUwHI6DuhMj2Yebzw?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fc47c1e-3282-45d3-438e-08ddbd0447e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2025 03:13:43.9816
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR02MB8543

From: Nuno Das Neves <nunodasneves@linux.microsoft.com> Sent: Thursday, Jul=
y 3, 2025 3:45 PM
>=20
> When running nested, these hypercalls must be sent to the L0 hypervisor
> or VMBus will fail.
>=20
> Remove hv_do_nested_hypercall() and hv_do_fast_nested_hypercall8()
> altogether and open-code these cases, since there are only 2 and all
> they do is add the nested bit.
>=20
> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> Reviewed-by: Roman Kisel <romank@linux.microsoft.com>
> ---
>  arch/x86/include/asm/mshyperv.h | 20 --------------------
>  drivers/hv/connection.c         |  7 +++++--
>  drivers/hv/hv.c                 |  6 ++++--
>  3 files changed, 9 insertions(+), 24 deletions(-)
>=20
> diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyp=
erv.h
> index 5ec92e3e2e37..e00a8431ef8e 100644
> --- a/arch/x86/include/asm/mshyperv.h
> +++ b/arch/x86/include/asm/mshyperv.h
> @@ -111,12 +111,6 @@ static inline u64 hv_do_hypercall(u64 control, void =
*input,
> void *output)
>  	return hv_status;
>  }
>=20
> -/* Hypercall to the L0 hypervisor */
> -static inline u64 hv_do_nested_hypercall(u64 control, void *input, void =
*output)
> -{
> -	return hv_do_hypercall(control | HV_HYPERCALL_NESTED, input, output);
> -}
> -
>  /* Fast hypercall with 8 bytes of input and no output */
>  static inline u64 _hv_do_fast_hypercall8(u64 control, u64 input1)
>  {
> @@ -164,13 +158,6 @@ static inline u64 hv_do_fast_hypercall8(u16 code, u6=
4 input1)
>  	return _hv_do_fast_hypercall8(control, input1);
>  }
>=20
> -static inline u64 hv_do_fast_nested_hypercall8(u16 code, u64 input1)
> -{
> -	u64 control =3D (u64)code | HV_HYPERCALL_FAST_BIT | HV_HYPERCALL_NESTED=
;
> -
> -	return _hv_do_fast_hypercall8(control, input1);
> -}
> -
>  /* Fast hypercall with 16 bytes of input */
>  static inline u64 _hv_do_fast_hypercall16(u64 control, u64 input1, u64 i=
nput2)
>  {
> @@ -222,13 +209,6 @@ static inline u64 hv_do_fast_hypercall16(u16 code, u=
64 input1, u64 input2)
>  	return _hv_do_fast_hypercall16(control, input1, input2);
>  }
>=20
> -static inline u64 hv_do_fast_nested_hypercall16(u16 code, u64 input1, u6=
4 input2)
> -{
> -	u64 control =3D (u64)code | HV_HYPERCALL_FAST_BIT | HV_HYPERCALL_NESTED=
;
> -
> -	return _hv_do_fast_hypercall16(control, input1, input2);
> -}
> -
>  extern struct hv_vp_assist_page **hv_vp_assist_page;
>=20
>  static inline struct hv_vp_assist_page *hv_get_vp_assist_page(unsigned i=
nt cpu)
> diff --git a/drivers/hv/connection.c b/drivers/hv/connection.c
> index be490c598785..47c93cee1ef6 100644
> --- a/drivers/hv/connection.c
> +++ b/drivers/hv/connection.c
> @@ -518,8 +518,11 @@ void vmbus_set_event(struct vmbus_channel *channel)
>  					 channel->sig_event, 0);
>  		else
>  			WARN_ON_ONCE(1);
> -	} else {
> -		hv_do_fast_hypercall8(HVCALL_SIGNAL_EVENT, channel->sig_event);
> +	} else if (hv_nested) {

As coded, this won't make any hypercall for the non-nested case.
The "else if (hv_nested)" should be just "else".

Michael

> +		u64 control =3D HVCALL_SIGNAL_EVENT;
> +
> +		control |=3D hv_nested ? HV_HYPERCALL_NESTED : 0;
> +		hv_do_fast_hypercall8(control, channel->sig_event);
>  	}
>  }
>  EXPORT_SYMBOL_GPL(vmbus_set_event);
> diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
> index 308c8f279df8..b14c5f9e0ef2 100644
> --- a/drivers/hv/hv.c
> +++ b/drivers/hv/hv.c
> @@ -85,8 +85,10 @@ int hv_post_message(union hv_connection_id connection_=
id,
>  		else
>  			status =3D HV_STATUS_INVALID_PARAMETER;
>  	} else {
> -		status =3D hv_do_hypercall(HVCALL_POST_MESSAGE,
> -					 aligned_msg, NULL);
> +		u64 control =3D HVCALL_POST_MESSAGE;
> +
> +		control |=3D hv_nested ? HV_HYPERCALL_NESTED : 0;
> +		status =3D hv_do_hypercall(control, aligned_msg, NULL);
>  	}
>=20
>  	local_irq_restore(flags);
> --
> 2.34.1


