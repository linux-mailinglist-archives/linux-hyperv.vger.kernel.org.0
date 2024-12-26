Return-Path: <linux-hyperv+bounces-3520-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C6419FCD83
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Dec 2024 21:04:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E03091881F3C
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Dec 2024 20:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D61B9149C57;
	Thu, 26 Dec 2024 20:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="anRL6Ht9"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11olkn2090.outbound.protection.outlook.com [40.92.19.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A66042AA1;
	Thu, 26 Dec 2024 20:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.19.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735243445; cv=fail; b=KTFT7DY2vsZKVvme4jufCGw9PzQa13mzxjPiMCtlY3mIGGZYtCL1HOVRkg9P67Eh2y1wPjfJqIHHLfd9Nc3YZXsiTWVB3hK2+q0Ryx0WDnqHGapNr9bLri0CaSjPHGkN8yry+T7mU47B4ePeJ95hYCYLacMzr+4bRUmmNAW8cf4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735243445; c=relaxed/simple;
	bh=mFH7lSyRM2K4dXHbhnPdw3FHdLloZlm9l26u4RQ5WlQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TvlQdOaVyKkvfS4gOzdLszCq+mIOFJ7bZ9toH6Ic9qqdAJ9geexAWmcevaSd9g/9WP6hoyOY/IoLbfaCsvFXqCuZomR+NNdy4pfiuSW+DpwMU2Q6wNSCvHHI35Lhvfau7dH34/woKMQOu0BNzfadPOa+ntNrm1ebm+1eMUa2Ndc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=anRL6Ht9; arc=fail smtp.client-ip=40.92.19.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X30rLCW+i9movRqxplcWtBgmGpSTiRJjI6MbGF+v1i6KZEked48ygnlz+t9xoaAs2OeDXhXKFqCfWhDmnPkiJYP1v74+hH86k9I+cYGEhR8z2KFyOlmmg5ClYEcvbIPJUrRd6/bLxnhRerveME68uD6gOuJmMYwRMyiI0hqKUoRj4nA4meBTTYdmAjV509GJ5esemm+iLyazwyuhJf9nOzyn6hWM1drDdfDvM55vCEWZcSun5ThmWSh9Rq3G3e172zTVpfMe7Hh1kSJf3gXD1pTZ2C1QmzYyrx5xbPmauBzDZXaC5BNaBZ3Cy0XNf+aqyVfVeiMFqYTC1JCri4BU3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TUmdOTYuOlgobiz48NRPAtuue/J6aLT/206y9OhdZTA=;
 b=uGQmUyHEj37dfVUxRoCrPr4ZlhN1Lh+TnR8Nj7LMh6aqcQcyp9xrfkhOCg3W7XLWDgPM4HncOa95FebyhyBidi/MEViE7FLy8K5+diNofmUwdEDnz2mbs3YLqVMgOXeWcUdQip8dxDtO6MDff35SrqlI+uV1i+lbR/L7fCZ4uTwcUihU19leGr3wBrFPwcmGUjCZzXcG1tsfBWiD8+7mWgNgY9d9loiDQ7/dXHHbc1oQearhblVYJBiqqBtFrFSRrCV2B1I1SvIc7HhsXSqKmvyThcMSiNErh/8iWwkOMybPTlMUtYcU2LJYEn6tlLfnSpoKsd8MGNVUu+n9LdPyFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TUmdOTYuOlgobiz48NRPAtuue/J6aLT/206y9OhdZTA=;
 b=anRL6Ht9XhltBGp3DDKwVfdQw3uaK/6UeaN9vjdJhag6Hr6TnBgX+9bPNfBNj+QSWQLxGj7Dr3XBjiPam0U2QZls/axlhG4+XMPhlmaay93YgbOX/nPixlkFTmiHyYLrkznaT5LjeVsU8JQzkfIXM35CyBv1tGarmVY2tIznLucunCcApfwR4JBCxO+GyNyVywfNSfzBmK9UGHNdNA+lB32IUcLI73KRlEVRRyajD5Qtyi+dMQW+n2GwYCqDBAMAK+c6Df574WY1Ptp5oAtEcetUa+BRu14VYJ3apHhgZR3/TWcmHPPOzHFaER++sva9Q8oIOMeqnJKtKwyVOHiO+A==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by PH0PR02MB8453.namprd02.prod.outlook.com (2603:10b6:510:de::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.14; Thu, 26 Dec
 2024 20:04:00 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%4]) with mapi id 15.20.8272.013; Thu, 26 Dec 2024
 20:04:00 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Roman Kisel <romank@linux.microsoft.com>, Wei Liu <wei.liu@kernel.org>
CC: "hpa@zytor.com" <hpa@zytor.com>, "kys@microsoft.com" <kys@microsoft.com>,
	"bp@alien8.de" <bp@alien8.de>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "decui@microsoft.com" <decui@microsoft.com>,
	"eahariha@linux.microsoft.com" <eahariha@linux.microsoft.com>,
	"haiyangz@microsoft.com" <haiyangz@microsoft.com>, "mingo@redhat.com"
	<mingo@redhat.com>, "nunodasneves@linux.microsoft.com"
	<nunodasneves@linux.microsoft.com>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "tiala@microsoft.com" <tiala@microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>, "apais@microsoft.com"
	<apais@microsoft.com>, "benhill@microsoft.com" <benhill@microsoft.com>,
	"ssengar@microsoft.com" <ssengar@microsoft.com>, "sunilmut@microsoft.com"
	<sunilmut@microsoft.com>, "vdso@hexbites.dev" <vdso@hexbites.dev>
Subject: RE: [PATCH 2/2] hyperv: Do not overlap the input and output hypercall
 areas in get_vtl(void)
Thread-Topic: [PATCH 2/2] hyperv: Do not overlap the input and output
 hypercall areas in get_vtl(void)
Thread-Index:
 AQHbUY8FyS1mz+ZwyUeCSpyj1Xg2I7Ls3DWAgAEFqICAAC/HYIAAKaUAgAAX9gCAATAqAIAALJZQgASfzoCAAU++oIADKIEAgAA1eUA=
Date: Thu, 26 Dec 2024 20:04:00 +0000
Message-ID:
 <SN6PR02MB4157B98CD34781CC87A9D921D40D2@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20241218205421.319969-1-romank@linux.microsoft.com>
 <20241218205421.319969-3-romank@linux.microsoft.com>
 <Z2OIHRF-cJ92IBv2@liuwe-devbox-debian-v2>
 <8da58247-87df-4250-820a-758ea8e00bbb@linux.microsoft.com>
 <SN6PR02MB4157DD7CE09E39C524775168D4062@SN6PR02MB4157.namprd02.prod.outlook.com>
 <d8c4613a-33b6-4aa6-a3ae-7c888ab2d727@linux.microsoft.com>
 <BN7PR02MB41482EDAA9CD96EF2ECE6532D4072@BN7PR02MB4148.namprd02.prod.outlook.com>
 <eba74adf-4891-46f8-a3ef-e116000dd566@linux.microsoft.com>
 <SN6PR02MB4157FD829416A7ACA2FF9300D4072@SN6PR02MB4157.namprd02.prod.outlook.com>
 <ff359a3e-a275-4146-8e99-a06fea69b7a9@linux.microsoft.com>
 <SN6PR02MB41570091569D9365185B9F8AD4032@SN6PR02MB4157.namprd02.prod.outlook.com>
 <9c138f4e-9258-4457-b85b-69ae111894fb@linux.microsoft.com>
In-Reply-To: <9c138f4e-9258-4457-b85b-69ae111894fb@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|PH0PR02MB8453:EE_
x-ms-office365-filtering-correlation-id: bba58c67-b158-4bd5-9ba8-08dd25e8705e
x-microsoft-antispam:
 BCL:0;ARA:14566002|15080799006|8060799006|8062599003|19110799003|461199028|10035399004|102099032|4302099013|3412199025|440099028|56899033|1602099012;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?u82vlb/o1KSla6HmzXTqJ2zV5S1dCHyOLbUztqpxRbzL3EExbTLILmENShrI?=
 =?us-ascii?Q?BEmHCkaKc/7slj8JGT9VSJqBiTusqt2aEJyvEuO+3lA+8gJmTEO0s+iA+c9l?=
 =?us-ascii?Q?lYLknFg3Ogb3fsv/2bYJ14UIgTKk7LEyf5LnPr0wXslVSrzy9RhZCQsPuif7?=
 =?us-ascii?Q?Qr+tnBoqRYmYtb2u3Muj9/5tRvz9eHqUXcj2Qp5/M+Y52O96yAqRIM33gAN1?=
 =?us-ascii?Q?dE6q/LdPBMW2GC7gOnzui5LXCENejeAZs+3ZLXbptaZ+MJwj6Okn5YU5LQru?=
 =?us-ascii?Q?CtDBuGke+H1I2FqviU1m5JDFsyLFO/pkA7qgKHO/9xprvJOlk/tBjvRnCsP4?=
 =?us-ascii?Q?0cHC4nGyol041zXAyqq2DC1PBIP34o59VLMsPqfZfCMmBc5boUHHOTQGQ3TR?=
 =?us-ascii?Q?J5Lg9d5nyHD86YUVEWclGrhiYXUcf/RaetnKhH/2LjRAp9aco7CXhQKWberI?=
 =?us-ascii?Q?OFURKTFydJ96cpIMQsb17iTk+EvRjbnB8topALH2hNfv4poS4FFGai/9/UG8?=
 =?us-ascii?Q?aVHByaJpjC3xC+pHjyJBxJacSnHbrfGMHz6rM2rtaCU9cWOOlydCdFITnmxs?=
 =?us-ascii?Q?VnbulNs4jRCaxBrHwdFR+SM2ZlFdVY7zOTvYXYAHSCRuwHJfEPQKP8mbGBeX?=
 =?us-ascii?Q?NznjiwLfhHukz1Q3oHZeKFoIkI6MKM5xDYll4Mo4Iyr0nXDvNuWdOyeKhSWb?=
 =?us-ascii?Q?i55WOgmsoRAk8URJueDNDv3uFiQW2klrBcV/0TpRz0n4M3FWs+KhqBMqr6wP?=
 =?us-ascii?Q?APZ3WuhRWaIovYlRbDrUsmyvhTb6o5DcSuFZHJKLktXE2KYJY+09QZ+bh00b?=
 =?us-ascii?Q?VwvtQN5oWJu4RaXvZov7wSYrG8f24X6MtfgLoZb63CSSRV6YghhaZqjqaGK4?=
 =?us-ascii?Q?xMffqTne9TKqrxsj/azIHBCp0BZzJWSfPhkQpzvvkLCO+rMHxoGHvLTG8xu/?=
 =?us-ascii?Q?oQMcDw8QFl9ha5iqspuMcrjMSbX3UqfqQ/8sppq8enaTUnYHwn05YeF34tNU?=
 =?us-ascii?Q?jJVfRjx5y3GCt6Ivk7iSNTHKUfAiMerMaZrHxsOi8X+DdydmsbLIdkXIKAiF?=
 =?us-ascii?Q?09JyAz0GFBM34yhgs8sR2G9MAJIiZsmhxvdobHukDgW6Eivgk2J7ebkDhsBT?=
 =?us-ascii?Q?vYe4baVC81+x2BnpsTzYFa94Mgk3qMNPCD96djKIzqussnLRnj/qC05u+hGa?=
 =?us-ascii?Q?QcX2atM0gy4/j8PZR8DNcm9/Z/P8ym4XsuEvXw=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Ab0RFETPzPLTbkJyzlNg2yfYMl/Tu+hO5vZMEpmIpNDURaRCSmCIdrSjiIIk?=
 =?us-ascii?Q?3iw+llibr7760+TCesLuedfu2JjEuZOOr1FRIAr/4k8J3xux2jqFeGDGQNhK?=
 =?us-ascii?Q?TX/nea58fYwFVurpha67yBe+ihpgWul8FWyResoip7muxRqdueSs/bHgBwb4?=
 =?us-ascii?Q?9zRsS96aeYvjEJsNxFelI36UDh5XczIWQ06/t2RUOfR8otPfNzhm9vQm6SMx?=
 =?us-ascii?Q?AbEAYsam8A3nZVR7c+7xojIx+9eEPHWd2bLTZzPuVMSfejyQCh9UavgQ6IuR?=
 =?us-ascii?Q?/HuqdwEnC3iTGxPnai5zQgsz87USXtn3FT5mWoBMT8nVExRtI9N0LSoWdx67?=
 =?us-ascii?Q?ZlzRCbAhDyOi4RrrT3Von7HlA7PvZrEG6WXHFlXxEpY4AGEgilK8I3Jb2KiY?=
 =?us-ascii?Q?NJvKIxe9Dw29Qh7JnXh4aRvtYeM5U+RQNoK8CVC2yi4M7opquXPDvXrUblVi?=
 =?us-ascii?Q?uqWCd03GVv5tRwp8c06ttux+SZiOIfGks+rkp7W8fbbZtlE3GyJkGU0WoEQn?=
 =?us-ascii?Q?m9LVSi8BHh3iPIRjDBLP8sbsnN0pb4eoKPNjbdEoKNnAc/Q+ezGH+IhLqHu5?=
 =?us-ascii?Q?X3AucWnhaTwNrs/+OqHOvdicjNo2rKULmOKzMs2tGwWJRhsFAUKhRagloHnq?=
 =?us-ascii?Q?K4BXEkv4051pBdvCVBOoYd2P99aqayVnxMYfE0QikJg9FLjXBnStI/1KFKJo?=
 =?us-ascii?Q?qID01keXf89S36E+OR8DehWcGqhEh51Vijv/UfwUVRn2krJ7o9o4QmRnoTCm?=
 =?us-ascii?Q?mcNx/bQCp94rmCc3AC9+zivp+O2hx3gz3e+Gz+rqbh6Q6bTucEbUax6elJ1C?=
 =?us-ascii?Q?+vUNH8Wq6Rxs7X50KaKmvqbSEZQjCHvHdn7Wj6zHnpizJW6EvcZvaeckkP8q?=
 =?us-ascii?Q?j9+IzscbtKYPyIaL0gLuhy3p7gl4WUUFowBvVWxWW4c45JWjFbWaRVS4CWiw?=
 =?us-ascii?Q?dTRyKqU+BGytF7z8iLDc4GFy+PavbSm5mzQYVDfFErOmQAxH/3YofbgatzNh?=
 =?us-ascii?Q?e0F7U3zfPvHRZZOF+hqZbfzJofDqxHpHMcu+HfC6h/YlOMNvmtUX3VDXi1jl?=
 =?us-ascii?Q?K6jZp/Ag96mS3DxcWo1/XVebvSBM80Q6Yy5PGwUy+kqf53/hW/xR4YUg7g9u?=
 =?us-ascii?Q?fxrw+SG3ULae8PAJ6y1oxacw5Sv8b5N+91jsLed89mvXK1dADimwUKvgjH+e?=
 =?us-ascii?Q?Z1wHDYtIh979OtXVXdCOhjRYPADgIJucSVlyhR82uQrIFpC8A2pzTxwh/YI?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: bba58c67-b158-4bd5-9ba8-08dd25e8705e
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Dec 2024 20:04:00.3954
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB8453

From: Roman Kisel <romank@linux.microsoft.com> Sent: Thursday, December 26,=
 2024 8:46 AM
>=20
> On 12/24/2024 8:45 AM, Michael Kelley wrote:
>=20
> [...]
>=20
> >
> > OK, my understanding is that your concern about spec conformance is
> > just that Linux should be able to allocate enough input and output spac=
e
> > for the maximum case, which is 4KiB of input *plus* 4KiB of output. If
> > the total amount of input plus output for a particular hypercall is les=
s
> > than 4KiB, then there's no conformance problem with having the input
> > and output share a page, as long as the "no overlap" rule is observed.
> >
> Appreciate bearing with me and guiding me towards expressing the intent
> clearer :) Yes, the logic chain has been:
>=20
> * can't overlap input and output due to TLFS req's =3D>
> * need to fix get_vtl() *&&* dom0 uses the output page *&&* VTLs use
>    the output page =3D>
> * let us fix the overlap *&&* make get_vtl() look as get_vp_register()
>    as this is what it actually is so soon we should be able to have less
>    code.
>=20
> Getting rid of the hypercall output page feels like too much as if the
> code base is dovetailed to that and the hypervisor gets a hypercall
> whose output is as large as a page (however unlikely that sounds, but
> first there was an opinion that 640KiB is plenty, then 32 address lines,
> then 48 bits in the PA and 4 level pages, then 57 bits and 5 levels,
> ...), we'd need to fix the code or allocate and deallocate on demand.
> That tradeoff b/w saving a page and adding special cases makes me lean
> to just allocate the page as it is allocated anyway.
>=20
> > There's an idea kicking around in my head about a different way to
> > handle all this that might be cleaner and less code all-around. If I
> > get motivated, I may code it up and see if it really works. If so,
> > I'll run it by you to see what you think.
> MUCH appreciated!! The complexity appears to be increasing over time,
> and it would be incredible to pack all we got into less code without
> constraining ourselves too much :)
>=20

As I was looking at how hypercall input and output arguments are
managed in upstream code and in the OHCL-Linux-Kernel repo,
I noticed two things:

1) There's a bug in mshv_vtl_hvcall_call() in the OHCL-Linux-Kernel
repo, for which I filed a github issue. [1]

2) hv_vtl_apicid_to_vp_id() also has the overlapping hypercall input
and output spec violation. You might want to fix that occurrence as
well in this patch set.

Michael

[1] https://github.com/microsoft/OHCL-Linux-Kernel/issues/33

