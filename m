Return-Path: <linux-hyperv+bounces-5512-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0416AB7200
	for <lists+linux-hyperv@lfdr.de>; Wed, 14 May 2025 18:55:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A28786027C
	for <lists+linux-hyperv@lfdr.de>; Wed, 14 May 2025 16:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25D4813DDAA;
	Wed, 14 May 2025 16:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="qYp+Y23J"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10olkn2100.outbound.protection.outlook.com [40.92.41.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F3CD27E7D9;
	Wed, 14 May 2025 16:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.41.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747241693; cv=fail; b=SbjqirqFSQY4MfqyMy2tXGzuOWPVx2jOJ5NtcixsYofhOvdm+t8cm5jbH7IZ1FSCsXVClTO/S/5ent1pLbW9bAQ/w4SAiarwAClyafCfMAhzzYe+176I1NQXKqtptY69nER0/UBCsqnyPiKeERrIsdF3seVMD0GmLSb8X3tWgmo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747241693; c=relaxed/simple;
	bh=NQrYGc+3w40y3a4dZ+FQk76c4CzBrLuOTjHHsR/XBJo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RRFeKFJTAXySPN7XY+FBILPpZIu3Z6tqRyNBTxaJcMm67g87HEVBsa7bcN1OlJY4Rc5aBfZcZNNzHEQKO4HZ9M1trpdKfYRhCPjL5pz9ZkheNprcWECI1VFbzEy2wWiglwFdDMvQYZVRB68jDnlEhyjrSyZiY2il2cOZPknXHyw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=qYp+Y23J; arc=fail smtp.client-ip=40.92.41.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=INKe2FpkVKhuwq6o7fRCSSu8VPt2HlEz2lbWAL9kFy8XJIz1JChu1HevdL/HWlYvtyuwsZAKg5B3dvSA85de+dJ3fxZN1GikaYDR05sw8qC4iFdDSZwkqg9Dklfau1lCMcbFYzkfB00rKHIZOb/k+iScMGnqfqQn6POLvSVhsSR4BBxFWmu9hNvyjQYNDY31JgjTd+8uTaKcZekvOc4btZpSdwEefPmCrCjaC0B/ICdpQZrXEjfqo7n99wM41NuX98In580iOTzuAzNWLviSV0dKnEFchjYIWLH+nFxOYad7TMWWnUbEY3fyHrk+OR5c8BERuxo4tTmZlHBIxL6crw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GLMe/1lzv67XraEnKWerQ1Lq7KYUh/LnR5svpvX6I5M=;
 b=Fs1jH1sKw8ra4WPsAAWs4Be3oEI7tAI01TFSyuUKqwGObVLnzULLblnoGL9Jw3SXEsekO5V9px0lpDM8U+G+PKfHHIhqTOKAY+chOg8XPpMprmo6Ef/xxkF7Lfg6Ju8GnqxrVPwYLEwLY/S3DCpt7g1ycoZFszCG/H72Q+ybeMam5VeWKKeaEFgocx2G+iCIXeLvKgnj6s1CPdRxVuzCHZmOSWOasqvtl5VYIEIv5iZ8yxBiOpv7G0s+wcO6qKoO+EClFWNQPIVzsn2Z60kx6l48eucUoAuq7otLXXf0TEm3Rl0Evbv2R2sCHzqwIcz+0rH0I4Vf4ds+ljs94S9CrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GLMe/1lzv67XraEnKWerQ1Lq7KYUh/LnR5svpvX6I5M=;
 b=qYp+Y23J1VWayxetjoCpnnyKr/w5fQFDQtlhWFUB0L+K/unLmgOp4+v/V3Fcc7gA1H9TtqUA5XZtZ821B/6zK3v2+H4Gx302hv9Uer+l9PodQWLecgFgZoSTVfqnTLebsj00/dEeV0LAxmMc6SZX4xMXxfeb3gvbf/f8VyjSDX/NLqIs57JfCFnSxF2sRp3VyZNGw0eDKegQB3461rlrAT3z8An1jRd9QCibBr/SZVF06S4EnJYoGtdVTIOFr2wyrw6u9SBaBhlrutKJ9FEJVF4NFjaY7TpGvTLYpWXqvw3kA7xNiEfZwzf29Yo/8Juoid6Bg0nt5FDy0Eg1/aXWfg==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by DM4PR02MB9189.namprd02.prod.outlook.com (2603:10b6:8:10b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.28; Wed, 14 May
 2025 16:54:49 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%3]) with mapi id 15.20.8722.027; Wed, 14 May 2025
 16:54:49 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Tianyu Lan <ltykernel@gmail.com>, "kys@microsoft.com" <kys@microsoft.com>,
	"haiyangz@microsoft.com" <haiyangz@microsoft.com>, "wei.liu@kernel.org"
	<wei.liu@kernel.org>, "decui@microsoft.com" <decui@microsoft.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com"
	<mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, "Neeraj.Upadhyay@amd.com"
	<Neeraj.Upadhyay@amd.com>, "yuehaibing@huawei.com" <yuehaibing@huawei.com>,
	"kvijayab@amd.com" <kvijayab@amd.com>, "jacob.jun.pan@linux.intel.com"
	<jacob.jun.pan@linux.intel.com>, "jpoimboe@kernel.org" <jpoimboe@kernel.org>,
	"tiala@microsoft.com" <tiala@microsoft.com>
CC: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [RFC PATCH 5/6] x86/Hyper-V: Not use auto-eoi when Secure AVIC is
 available
Thread-Topic: [RFC PATCH 5/6] x86/Hyper-V: Not use auto-eoi when Secure AVIC
 is available
Thread-Index: AQHbvofzfdXevgSmaE2su/+ELxetK7PSYfow
Date: Wed, 14 May 2025 16:54:49 +0000
Message-ID:
 <SN6PR02MB41578854FF8D79504DB847A0D491A@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20250506130712.156583-1-ltykernel@gmail.com>
 <20250506130712.156583-6-ltykernel@gmail.com>
In-Reply-To: <20250506130712.156583-6-ltykernel@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|DM4PR02MB9189:EE_
x-ms-office365-filtering-correlation-id: c644df36-67c5-4773-70c4-08dd930809f3
x-ms-exchange-slblob-mailprops:
 ZILSnhm0P3mDoogZiIYtj6aHx7ik50F06c8bBwmMRM5H0wyElm6SNft5hef5hRQs+vP+sZRSFlzWqHwyTrJOfG6vwKh0EYOeLYoQeOQ28mgnEj0t/GS9QUd2ggy1QypbaJZKYL5NdNN8LIsQQOvKsD0CNZxeeZHgK8vv7rtPGzd/S19IZHKvFkV+uPSOHrp9B8bDASE/yU8PDz7Nfre9x2//xEvW8Islkh48K655aIgYL5HccE6BZAnPzit0NS50qwOfrqsa2qhs4V1vuzlQ6qmQeNHCjFqtvXtRBFEiV5jnAOlFKxMt2eKatv4TsPweg7X+Cv2wC6vMO9rYd69kS3RVNltvpMy0RGRSp6df4p7l+nPpC1McoteMm1RY+XBgd0im4KWo3He0ha62OawvIAjU+JwxMnn4AgUOWAH+II5qWiq5uT6AJas5RT7W8vyfTOqA7mDzxn69G2hxPjP6ewJY8LupUps8DJsu3jYY6ZK5HcGbAAcNdcsMoptLst1TnAlmJ2r+IjPU2xJw0oHCnygDBrhak6hrPLCrsS93IlxsmNIhYVrYpLIiDfUhFgzRXboCrwloRHzBFLnankUgs5t7IOPBCnokMWyaqNCqGQ1/j3L1D4K86zEVgPNryR9tHlGNinou9ioMOoHDd4lE1sYO9gpdI7CNDrM4Aw/3ztTFQ+I3pFk0qEvTnYfSii3JVYtGaGxfKRNvzFdHPKUpNvqjL0fmOnsB74NVi3XSgIofBIicG+OBpaeAwdsqamxP9EtvxIH+kFWyBRmXPljrNfMsuPSBQZDM
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199028|15080799009|8060799009|19110799006|8062599006|56899033|440099028|3412199025|102099032;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?Nm8DyXPltrOz6liBvMtoxvV7YjuPW8bp20XNUlnJP66oTFQUZUW7k7xGMtYT?=
 =?us-ascii?Q?zfqAG2TzAj26f4I442cdCxl84NDHI2691Gcae3/kEX1RYeeeQE5KWEURPuj/?=
 =?us-ascii?Q?kWoSDAiHMAADeQ5AxZj+5aWx4gttG9eL/uocWSj+mQBKcsTr9HxPM9EZXxFN?=
 =?us-ascii?Q?88tEuK8O4KfoBkd8poC9w0m32KlZ7dtUg4ACMliCJ8MJERIADa7/fYi6Ftj6?=
 =?us-ascii?Q?Z57LhOfNPTDOEXusp8vgKsK13z0RbNK+g1ApbQnP3QbrKgpdzk3u/mPF617P?=
 =?us-ascii?Q?vHZ3nIkMuOzMTm5kfcEjjyU8mKBQXWyoeXLZes8e7uCZ2196UyW6qgQhO6QF?=
 =?us-ascii?Q?lSjq5FBh10QINSN1OYnocETt3PzemRC83xIpXK9ilIhuQ+hEVhwnHYUVkHqT?=
 =?us-ascii?Q?LOMKjRaZAubdCkHqbuPQwAT7aMEZ3pf6zXVKhCB0Go7zjs2m32KGE9Ha+Afi?=
 =?us-ascii?Q?YYk7gnnFwDMtfaoVroE6BOzv/hcEwl50C/k5yEExDNZLFFhV6uHMajzbmv2l?=
 =?us-ascii?Q?NALJXacQKgd4Ke4gY7UkLPBx4+fLNiZSEGWD46EF1ZQy8H2sR73uQlcnMjxn?=
 =?us-ascii?Q?++PNqxo5/2i48KJMnaNFd/anrSKD1HIaenHtG8qBb7jZqgoNzza6WVqkuJR5?=
 =?us-ascii?Q?QmAs1TJjtlWiIjW6tHpPbMR9BxFdmtQq8dmaZA3Av2ePY6P/RMKbv3WwaU80?=
 =?us-ascii?Q?VjasUX793xdCPqZdbAsD1q94Sq0lTaOsWtf254DxOSJr/w8KzlhsAddreQX5?=
 =?us-ascii?Q?/WZuxIwSodA+te/WcHngndIslKArT54zJvCwUgHemXRZM/9JJmMmj4wfiFew?=
 =?us-ascii?Q?HiqKNFNWFFRkVArCzNC/snPVaCv2pc0wSAWzV+I9wnW+X5iLmmM+VvIYVSrV?=
 =?us-ascii?Q?pwZVTvJ6aKVIw1KFFoYK8gao/nSCDW82OoVTUIPq3dgnva8045dcD+ENSuoW?=
 =?us-ascii?Q?4/7i5tyGwtnmQU9D1DkcAxB8HA1hNf1JCgHhzbFaZMUnr25RAJaLCKRxIIRx?=
 =?us-ascii?Q?LuIy6HiPirtyihk0cjeONjuZulRHv5hlR+j2BFrCRDdYqm8sKEKM8JikJoi7?=
 =?us-ascii?Q?7J8YxkJW/B6xN6Hh4PCHuXJcHxupaw=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?D9ThpOYA3Hue5k+JTjebYjlFRXGf7N/3DNjqn2MJ4b2qBY6VlYvaQUmpHTtp?=
 =?us-ascii?Q?ys2CK9uUJ8YiuYIHh3o0DbXcG5sd0VKM1IHm2G+FTyXcZhM4G86nQYTxEVv9?=
 =?us-ascii?Q?DcCRDhApVi/Xz2IPBrA0us9wvcsYXGuVH2+QCQqD21yePZZMT6Wj4v+4gRAU?=
 =?us-ascii?Q?PBLJOqrmMStF7z+70JjUEq+kaFmM2W2D3UXChn7dd2ED7DnaOpwXcplMRzVe?=
 =?us-ascii?Q?tOnUmLSQeFdjBM8YQO3Zcz4qDw9WN9zNNTLpRZifPpHVSdfudb+GjrOl1Igx?=
 =?us-ascii?Q?8aQ97Z/LHmQJnALeGaO0F5oUkuLeLmf7hNLeWVM3vqSWffRSgwc5l5w+MIE3?=
 =?us-ascii?Q?4ExSA1aQBw9vTZr33G6IKnoRb/ub5rGH87MKAx7l/3Xn/uSAuc5vMymzYfhd?=
 =?us-ascii?Q?hxlSuqayZcJmAGKB3BnqTjxNEiasYV8RWguM7ySgy1rLShAJXhZtLRSmZX/x?=
 =?us-ascii?Q?4VCNGHjMhowYPnA5bUGpv0bKZj2hiB3MIddolHFLfiFVWR4q07MHG7sM5NCu?=
 =?us-ascii?Q?2rL/2Z8hT9NwtiEzk8cuSpTc6oSHZKLxDTkmi0TICOiDtRjuoSJX4p60Xwa4?=
 =?us-ascii?Q?Ra1kxBQy1nLJttV9axF2+3jbKPRDvFwXgyBLy8t6cX4cEiImoEsyDq7aTW5v?=
 =?us-ascii?Q?ykmjP35kbrGAOtsVd3+VMr6qFRa6mC/iySn9QNNsZ8vJItgWFWU66mRQuMvK?=
 =?us-ascii?Q?vM/xRxyrE3ZODZfUFTCEFyLgXyKOIzQ6lOVYP4Hjm7t4KUbnMsehM5jmGSzZ?=
 =?us-ascii?Q?E0UalI2aXfGCMeoIsUsvsXd9BX9J+49l1uAS0TgG414DKfLJaUSduoO3jmNB?=
 =?us-ascii?Q?zo+8mfyco8/RBVvQdxoQtrN22liryvgbKphuGH1hGcdncK+aaTQ3kzZg130a?=
 =?us-ascii?Q?DK9LnpnzIGuUP/sHO+rdg/cpO8wWE4qxvg2sMRZ40bvpLqIy91negaBt5tL3?=
 =?us-ascii?Q?ucgZx8ruWyXunKgKzA7Koh8yfvJ4MPGfCVPWe8XPP83av4TQWHjuiWWhQSLX?=
 =?us-ascii?Q?w9BCCtgEeH1zamNjEqtEn1JjmOBOb+bzrT/nPxw1g8ziVVQoiqfsTZVQ/D3q?=
 =?us-ascii?Q?y9Qmj5BpyPUzmaVLvpnY7CPZkIkdQ6CLatYIlDheBzJ4vSIiMaEFWYORDf8d?=
 =?us-ascii?Q?TiryjelZd5vacFcNOQ3fzZnMbCr3TeaEZjVMB7HXp/1O0at1+Pclgl2we+b6?=
 =?us-ascii?Q?iaq2Ocu9yT8YzXCYh4gfvPi2zZQXYQmj0u27T0JbnDULuRpoQwEciLgSj3I?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c644df36-67c5-4773-70c4-08dd930809f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2025 16:54:49.2108
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR02MB9189

From: Tianyu Lan <ltykernel@gmail.com> Sent: Tuesday, May 6, 2025 6:07 AM
>=20

For the patch Subject, use:

x86/hyperv: Don't use auto-EOI when Secure AVIC is available

> Hyper-V doesn't support auto-eoi with Secure AVIC.
> So Enable HV_DEPRECATING_AEOI_RECOMMENDED flag

s/Enable/enable/
> to force to write eoi register after handling interrupt.

"to force writing the EOI register after handling an interrupt."

>=20
> Signed-off-by: Tianyu Lan <tiala@microsoft.com>
> ---
>  arch/x86/kernel/cpu/mshyperv.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyper=
v.c
> index 3e2533954675..fbe45b5e9790 100644
> --- a/arch/x86/kernel/cpu/mshyperv.c
> +++ b/arch/x86/kernel/cpu/mshyperv.c
> @@ -463,6 +463,9 @@ static void __init ms_hyperv_init_platform(void)
>=20
>  	hv_identify_partition_type();
>=20
> +	if (cc_platform_has(CC_ATTR_SNP_SECURE_AVIC))
> +		ms_hyperv.hints |=3D HV_DEPRECATING_AEOI_RECOMMENDED;
> +

Shouldn't Hyper-V already be setting this flag if it is offering Secure AVI=
C
to guests? I guess it doesn't hurt to do this in the Linux code, but it see=
ms
like it should be Hyper-V's responsibility.

Michael

>  	if (ms_hyperv.hints & HV_X64_HYPERV_NESTED) {
>  		hv_nested =3D true;
>  		pr_info("Hyper-V: running on a nested hypervisor\n");
> --
> 2.25.1
>=20


