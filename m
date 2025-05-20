Return-Path: <linux-hyperv+bounces-5562-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E45DFABCC4F
	for <lists+linux-hyperv@lfdr.de>; Tue, 20 May 2025 03:33:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F34761886668
	for <lists+linux-hyperv@lfdr.de>; Tue, 20 May 2025 01:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A53BB254862;
	Tue, 20 May 2025 01:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="bxXE4w9u"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azolkn19010023.outbound.protection.outlook.com [52.103.12.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C357B1D89E3;
	Tue, 20 May 2025 01:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.12.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747704772; cv=fail; b=J1kq+l31M55NugxLsm7MI7hqu8C3aISvO9tuw2bEEcjzfxN8kD31fu/WmsQUp9Y7HEyy5Jpt5ug5Qm+uoamxv2UvSwL/Ioz8LmeF6k1OFMz5OsBjUx0XRBdNxi08R/2eBIPg1cctItzgT+RJMPA6Sa81XXLiQ94uEZMCkZE/Ut4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747704772; c=relaxed/simple;
	bh=BeNacwcoXeBD/Dag/kQCjk9oXH0fEZIS/SuxT1wvABk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hn8agqyRGv3DNB/3Fjwj78//dVozY7Cx63RB9zAUQ1m6iwGj4vRqhJ/suD9k4cp0wnvRThvmRfXqO5qOCtPNarE8EUiaQBQT4krbGMXSLsDEBvW+N/I70sYnYyL+xIbswOsqzpor52CK+HWB9LxbJ/J8p55gHKzGbTpcf3P/NQk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=bxXE4w9u; arc=fail smtp.client-ip=52.103.12.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IMqRziI+fylc1R7JVzkuBDKgtfnMAoWWlkWkNAEP9nuQ9JjBzCaxM57O3Q6UxAMV1xjddYEkq7JmdcsudhFD14RCVWnX1P3QzP6w1pJd56Pj6l+9SP4QbNHTkdAEPPfdzPiyXYq2Cv9Fc8tJUZxrIYSxJGlvJ23dP0CA+uWOw2NUuZjXAR1BajRx1RFMLxm9Xd0TUB4o1wAot5pOaEFwfWELT0pVoGCYq7X9ydzhpOlKzYoS7lTIOmtOhPlXaHkBxBXRWX12QDrWgRC69n/KqImFQinu/LuKxo6YsPhktiq6giB22WV1jV0ev96770Wi3CWUOXZTRBYy3GiY+Fl2jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CJmPGgyfR6VSMA4rMhN1rVz2hJxrQ9SGFpAONHgpyhc=;
 b=E4X3yLMSiXTGx/xkfBxVZmfEXt+yugFCIsyWvPOZk9F0l8bkZE/ivEE9/yystg4HwotqOMiw4v56BoApvczOlfqHpSjFMJ64MFwYkDL06y/c6Z7zmh6rLCzPOGtkC1Kapr493Q1J5q83PvzkLDUNHBec+va9CLqbRcbGlz3bsqmRkMciDVgyZ2DYx72OJ8VjRmc/PLahNNUJRdXQZLdrT3FwLkPI4Lz/izTUZEEayshmllzLXHT9JG1SAFL0D4nyq7hF+ZS8/sQt6HZCL0fqm+1IoXr/r5TjVf8rBS7rg74GdfznumODboj8LF79Rt9VqFkgfnT75Dau+dY/cfmr9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CJmPGgyfR6VSMA4rMhN1rVz2hJxrQ9SGFpAONHgpyhc=;
 b=bxXE4w9uygIElZf9hJl+Sq1+TLSnhY+IYR+YuEuP7L6pedOqI5bP3cu+rKlN3+FOLguO7TUCM8sqBdcs0GxYhjPNejQnZ6geq7ZQMbHplSYbMeh3Z9NNiAEdmcZwN6c1XJqrqCZ9jO+jMWr+RXB3rfqLWKN3L3m+wr+54wp+ZsyTkE4g2o5ORrKtr+ar+44ChC0uE5rMdN+XPmb9JKKV1NmXmE0NX0+3CQAM4QZdBvh1ruDoeBYokhOGqqnNQtpUscPDu4zUIotFaz8sow0L2nnGp2fmkyAgm2NmeMjjjt3+Z0EGjSeFZxWWp85NpX1ziCNWRojqGpBfc7sl06iuVw==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by BY5PR02MB7044.namprd02.prod.outlook.com (2603:10b6:a03:232::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.16; Tue, 20 May
 2025 01:32:47 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%3]) with mapi id 15.20.8722.027; Tue, 20 May 2025
 01:32:46 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Rob Herring <robh@kernel.org>, "K. Y. Srinivasan"
	<kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu
	<wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>
CC: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Saurabh Sengar
	<ssengar@linux.microsoft.com>, Chris Oo <cho@microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, "Kirill A.
 Shutemov" <kirill.shutemov@linux.intel.com>, "linux-acpi@vger.kernel.org"
	<linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
	Ricardo Neri <ricardo.neri@intel.com>
Subject: RE: [PATCH v3 11/13] x86/smpboot: Add a helper get the address of the
 wakeup mailbox
Thread-Topic: [PATCH v3 11/13] x86/smpboot: Add a helper get the address of
 the wakeup mailbox
Thread-Index: AQHbvF8CohDddNcOXkqwG3RqzVDZa7Pa1TLg
Date: Tue, 20 May 2025 01:32:46 +0000
Message-ID:
 <SN6PR02MB415791B34FC2FF98CBA4B2CED49FA@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20250503191515.24041-1-ricardo.neri-calderon@linux.intel.com>
 <20250503191515.24041-12-ricardo.neri-calderon@linux.intel.com>
In-Reply-To: <20250503191515.24041-12-ricardo.neri-calderon@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|BY5PR02MB7044:EE_
x-ms-office365-filtering-correlation-id: 0e46e54e-5a52-47f4-ea76-08dd973e3997
x-ms-exchange-slblob-mailprops:
 znQPCv1HvwVu6ov8hlKZu5ytU8AWxKlxcJ5uXEpk+grfXlaY6OWIdV2z8x1E1X+VQm52gfWUF0WbFnGFUTC2PcGI6CGxny+7C+31IDOEUSGKzjvkuMnrWl5/FIN6BKpxTKNH+Wz2zg8tTOA6i6UiX2lfPPGmJnTliWgc9MoyVDdbp8EmQWfO+kJo9aQr49IhkaHyX4cXqrArB8KARSL89lK62y7uePO5OLdVAYb8DYzKZD2U+V1W3XBOPbLuyiDGqfxjAX0OPEwouQOO8IjQocWONKkdxjT8b3U+D2BsSk9+wyjE8WxMd16OiOoq7w+nTaTDcy4waxWzauuumEbEcQ+Y+lr6kSgMH/dE3gGlinb/XJ+JllsEcNKFQ3OslUTK8HvJApHmWB82o/xfDlnITzpJD1VPvbV9JSFTdEHC7IceMZrcOgZj6pEBsF7VJWOzMN35+S9Hz1k8fM8jR1MUSxecKgOMwNU4Sk+nPLvQYohIf1h/H09XOq9YcaIMw4fqNz0NWMJMB42yrtDr2vXXxegPm9lZiOhrkBkidDQqOp4IhFMDnEKq8Bjotb4k81cQ9CHRKLSZK3sf3xF5dTQH2w0ZQmjUdSFyn3oP+GfVq7d8ER8RXBURNdGWuP20f7csl+6K9/M6fBtSIInMVXU6HfPgS7XAEXgRL+QoW6irbQ5SMqp0k7CTBvRDSZprdoS6M4g0RyYFbntP+caOZt8Wt9YPjBbyCjw4p2ShwR3/Ts0W/tLuxgf0IZCF8edQTZ+UAzUqPlxVGs8=
x-microsoft-antispam:
 BCL:0;ARA:14566002|41001999006|8060799009|461199028|19110799006|15080799009|8062599006|102099032|13041999003|3412199025|440099028;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?5rvyx8wrSm2u3+mMmVLCIdJaKmvFnBCdgDDjjAL0uTXJtjnFDV9HQXzBgany?=
 =?us-ascii?Q?51ztgQB/i1062+SEx2JDdJ1mxStj94UjbA3zTDZz9dd/4RWkkELBtw4WLuas?=
 =?us-ascii?Q?ulwB/9L1J+eUVq06txz9Ll8OZ15uzk42CIcb/CMpcN4+auAhm7D6cBPU6nZw?=
 =?us-ascii?Q?4na0r/8W7ajt4fYbxS+PnrxfPJXcsikgEXr8U7R4n3H3cX1NH8gG5mLjxBZf?=
 =?us-ascii?Q?c9pVXWxS3TErnTLEdMlQOYpQ0S+5I4oSAuTH2zcojb5bXs2R++fiBqJnHjJW?=
 =?us-ascii?Q?sCmBIbugIKHkLfb/Sk50PZBNrheWgC4UXU/AvfCzAhoEwpnazq0dZlnYApsY?=
 =?us-ascii?Q?Key89k/khiV3ygb+AtuJYkbdQkmtGVMdmJwhBd9w5vTsy5ww3Oi0GvMWsHWA?=
 =?us-ascii?Q?MOF0dcj5aTZzmOU7EUy2Xq5+elI7c98yJiaM4EnMlWWbbiNUODUhSnFbODm6?=
 =?us-ascii?Q?dDHGKhTiBBXkq/mH3iffNzpv2LedVYMSftLyfCyZjcoemnoXQSvK9sBukVm1?=
 =?us-ascii?Q?WXGhzYuy84T1O/0LqVo88y+XViCNBarA37MywMTWiGMlSa3d6e5rbK40cIZt?=
 =?us-ascii?Q?IiCimlTTXQkdYfS+Mrn0YsQozMVgrBsaHs1fzR3ao15XhciLJj5lm4KJehAQ?=
 =?us-ascii?Q?tBrt4JfizO6kyLlIiaZPJ9gnkhPXIHbOC0aLy0O1+CxpMxpSQZcN8d7J+0P7?=
 =?us-ascii?Q?Bu2jrSXhreYudxQ3qmkpPtdFmOv/gRnoi1QEbuc5RW7xHM8BDgAyuS5yVFUF?=
 =?us-ascii?Q?u91YyK+YwsHhfO2VvN0GsFqFHZeE02uwz6BU5bQ85tGbW1eLBY/z8ULx+zI6?=
 =?us-ascii?Q?YXIY8ratI5MKHtCj274+sZDZMfor5XUwYLcINnVGLn0/3+FvRxfdQoOuMBmj?=
 =?us-ascii?Q?gQ+r9pz/kJtFJdPEFkeTW/nOUNGfEJQEGRbqf58QfDfnts8TNlpKMNFHO7mW?=
 =?us-ascii?Q?qf/vHZ7/vMzhQ49qcTrShq/JqYPQTFvGOuFE05Xmzpy8PnsJFge5K2E03pbQ?=
 =?us-ascii?Q?wlipx8kCo/M4MJ+mtOl9cOMG5xB1evBt1pG1CHdxfNpj1wjxts0wJl3lJLPh?=
 =?us-ascii?Q?reCKQzzALa5f/jF3UDCynIa85Su3gChIRqbLNoOS0+fyHtM7K6HhZHo2+myG?=
 =?us-ascii?Q?V0KEOX0ZkOeX3R/GFD7HbcxpYcO215ILOw=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?+6V5sj1VNDtPMiMyTqZQFZT2SxwxBaIO2H1bAshPjV9fAVc8C5kq5oWBcngk?=
 =?us-ascii?Q?j+hwJoRCY0vgGKG/Vzs7FGfdhcSrW9aCXxHE9OUupXGdHVBEG/1w7cphrrh5?=
 =?us-ascii?Q?Tf+Oi8OMAGTLrpKyS026TZXCtdNVKRv836h1AQLMsZ68VW18RtgSPvOv3o8t?=
 =?us-ascii?Q?DKuJBGad4f+K6i9NPH2v+im3id7I9g7vpn77c8p7R9g0gOGfgqWbL9BDkfii?=
 =?us-ascii?Q?y/3FsIS+d86nqGOTv1LvT0IB1KOpX+N7xNid7bveKpooqpyNob1fVLYrXq1L?=
 =?us-ascii?Q?8ObEUNtkOeUeh6rbv35Z5XHvhNGEKquMdJSlN1tbzFbuNEXWbctt0dA4jNXz?=
 =?us-ascii?Q?Y3F4yHyBsfHSleXZ2+ydFzAOUe6hkPwbM9MZmHJqPC7c+Lm7jVKD0AJ76Og5?=
 =?us-ascii?Q?oqg0JTXKYH8eC1TcBRto98FS6utsQLcy/poSyoq2Kp4vsJ/u7Iqs6irZPeiK?=
 =?us-ascii?Q?9QhsqE35C3y+SmkTBFEmMK06Ughb956sa+jpX1yFOt2cn6TQriFj2pn3R62c?=
 =?us-ascii?Q?3CeYEfbvQzI/tIPcGQrSpxF/b9Mmka3C42uNUypdeTSjpzS9ogNtk0RjBlZC?=
 =?us-ascii?Q?atX5Ay/UH2KWtY0pzEkM0PN9GZoE1zXaQ/2LjQZtmnRqMaFqy/rsUs0jAbNB?=
 =?us-ascii?Q?TGlCORzF1KA+2BNlqx6EvEQCNCQTRIqCX4AezMyoC48yPgSXQt+hUQzk51bU?=
 =?us-ascii?Q?zGkWLDRlJ3OF12M2aw3pcyesvTs0BYJ8tz44TVqEBBHxs4PjElPAeMR9lEIe?=
 =?us-ascii?Q?wbHmDDWcEZLQGWsHs5wfV6/0F2Y8HzqiI1ZXcGFt1b9B/N0GKuwTCuNe0Yxi?=
 =?us-ascii?Q?RpstpfpS2+/Bmltu5ulRH4u+2gt9JsEzdp7PZx1vN1v73mHq9krAYJ6aKO53?=
 =?us-ascii?Q?aCIUfqKjMt2LvdcYpAlBbdvICHR8gEyyJN4US4nmgPml9pExSJwThZa5cAi7?=
 =?us-ascii?Q?3Mmar2I5aCCikfB5HqQKf3XVscCgk+Yz5IoqhuHnYcqS/MPpD2fagqD8neNj?=
 =?us-ascii?Q?a+tPxGA1sq8BCJDowMkZ6rnf0pw/SHX1EqQ4Diia2bLFXjskL14677I++RWR?=
 =?us-ascii?Q?J3gsodjhXR+qhpvPlzhsz3qCsFjz2XWSvdP8aHuPiWaffxdyV1ojjuFobdse?=
 =?us-ascii?Q?ENTQpKwIKVV7I1/YJhNfoZcJQDrRq+FQfpaIyKQ9vwqwuhteYYhdn4vYHiCE?=
 =?us-ascii?Q?hkEoj2+PI/VmkRtwuucsxaj+DkZua08kM87Z3mIiYYlY6EyFYVwM/jFwE9E?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e46e54e-5a52-47f4-ea76-08dd973e3997
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2025 01:32:46.6064
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB7044

From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com> Sent: Saturday, =
May 3, 2025 12:15 PM
>=20
> A Hyper-V VTL level 2 guest on a TDX environment needs to map the
> physical page of the ACPI Multiprocessor Wakeup Structure as private
> (encrypted). It needs to know the physical address of this structure.
> Add a helper function.
>=20
> Suggested-by: Michael Kelley <mhklinux@outlook.com>
> Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> ---
> Changes since v2:
>  - Introduced this patch
>=20
> Changes since v1:
>  - N/A
> ---
>  arch/x86/include/asm/smp.h | 1 +
>  arch/x86/kernel/smpboot.c  | 5 +++++
>  2 files changed, 6 insertions(+)
>=20
> diff --git a/arch/x86/include/asm/smp.h b/arch/x86/include/asm/smp.h
> index 97bfbd0d24d4..18003453569a 100644
> --- a/arch/x86/include/asm/smp.h
> +++ b/arch/x86/include/asm/smp.h
> @@ -149,6 +149,7 @@ static inline struct cpumask *cpu_l2c_shared_mask(int=
 cpu)
>  #ifdef CONFIG_X86_64
>  void setup_mp_wakeup_mailbox(u64 addr);
>  struct acpi_madt_multiproc_wakeup_mailbox *get_mp_wakeup_mailbox(void);
> +u64 get_mp_wakeup_mailbox_paddr(void);
>  #endif
>=20
>  #else /* !CONFIG_SMP */
> diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
> index 6f39ebe4d192..1e211c78c1d3 100644
> --- a/arch/x86/kernel/smpboot.c
> +++ b/arch/x86/kernel/smpboot.c
> @@ -1431,4 +1431,9 @@ struct acpi_madt_multiproc_wakeup_mailbox
> *get_mp_wakeup_mailbox(void)
>  {
>  	return acpi_mp_wake_mailbox;
>  }
> +
> +u64 get_mp_wakeup_mailbox_paddr(void)
> +{
> +	return acpi_mp_wake_mailbox_paddr;
> +}
>  #endif
> --
> 2.43.0

Reviewed-by: Michael Kelley <mhklinux@outlook.com>


