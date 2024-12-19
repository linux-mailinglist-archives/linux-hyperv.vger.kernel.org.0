Return-Path: <linux-hyperv+bounces-3511-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D501D9F872C
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Dec 2024 22:38:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C0A416EBBB
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Dec 2024 21:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C2BA1991C8;
	Thu, 19 Dec 2024 21:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="qztM5LDb"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11olkn2088.outbound.protection.outlook.com [40.92.19.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE22E1509BD;
	Thu, 19 Dec 2024 21:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.19.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734644278; cv=fail; b=kdkh7q8aJkrHrx38qkbDRzC4LedE2rRwgDpekpdXncq6lnnsXbPU6MSCx+3SS3YJoTOCOySR6v6wNAJxaUwHFIz/ZAI3oLkXMsY1o7nRVQ1vJefGsz4RagD0dwXz+IrEUYW2k0mmchf6SU0ydmzapfyKg+TGILv6FmQ9gtygBPE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734644278; c=relaxed/simple;
	bh=5ApiSRxA+7kuDbk4oarbsKEGEBlqf9lbw9NEbCqIFEo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PfOPfMKOl4rW2axnED9UjdqWF+0adiTM42KzcEM8RInFVRrpnqisHlXeQ1DRcxLald2KoNwawfMhhtCQyGaIEys9iGr1JotKOxYpl5ov7YAtjfARr9xHWVQCJ8H22+r5WT+M2cc9JEgUaHa+GmX3e0L0dDURxxB47AHqcPl1Fwk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=qztM5LDb; arc=fail smtp.client-ip=40.92.19.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gruO4VleLqFyPe/8AhuLdxnLkY1AIuTm7bN5/HzyqKayLKSfrY6BhnthIZ+EV8SGs+9n53N8pYY24e4PgTsOSEU+RWA8OrpBytmgEg3g8Cvj2KGanrqvav8NMa2lWb0OJ5eVEa8SYkBLGXQPIdYLy7CaoI+Tr8HDmURBRNYoCCRTV//PiQDktuwXJ57vDFm8zuV2fehHi+xrUDpSD5Xh4jazER/cdTN4qxrjKX1xSVPmJBr0rsVkUyIXzHk+AJ7Eykh8k2qb4TB7LJirmnn5ee1rE6P79H4LyQlIqd6JMPu7qdl9pWT1/rENDDu6aCiwMdPCykuqTsX7qmId9BuyJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HN9HJ8lpIfOIDOAh4EI7Pm+IBeGtDNm/hzovXR2EFFs=;
 b=RinSgYMfm+Tds7+aFpVY7R8kZfCVd8i6X2xk05LpXnhJtas40c6GzogDaf49+xPSq+JHw903TiM1hXe6lvZfJzL4tV/9USYq2NELIsLPMuKaC1sgDd89KW1xczsOlK26O3NWkkdkbHdXnhn8D5a2ZjwlFguLcjslCHkaluzAndvgSaHOCxHpw3eQCVBOLYKlCLvSyj4h15NLbGuUwv7IrXkaR9c0TpM1kgRb68fVoKybDzMRhYUhdFNvQ6UbWZP+0iQMkyV526IurAuI4sfWEuyNcSO6kyeFbNBLZafzj2ycjGFI0CAClSJsv5Z0EGKFmSZI4EL6xZ9IXfoUnx6OhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HN9HJ8lpIfOIDOAh4EI7Pm+IBeGtDNm/hzovXR2EFFs=;
 b=qztM5LDbK25eAOVyFghqVwZoz9WW4RzPVQJKmiAH6wXh7V0q7ItwNCMvHSuoCBqGnk8ulz8wj0qjD/FAx/0z7KeIKcWUjrBBGgE1+5H2AwF0ccerbSuDHNyZtvG4Yquzl3l+evPhSaGeijElIeOm2hwTV2oKZXimk0EzbNQ/q1Er+PxX0/BHanmTKRP18rJcwny93pyRWQP7HHXmtigvInDvgSnxq+gHeEOwgY+cYLVgQXQYkJsBe0KDa+gJ/VxVDJE0h9SliiPtl/lAOq+LwkrS0OfqtxJtWSkSRHbtVSK3IVE+hyI7/Wgh/SPEEX0qlAT+ncdSGvpi+TabeDnZuQ==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by MN2PR02MB6959.namprd02.prod.outlook.com (2603:10b6:208:209::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.13; Thu, 19 Dec
 2024 21:37:53 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%4]) with mapi id 15.20.8251.015; Thu, 19 Dec 2024
 21:37:48 +0000
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
Thread-Index: AQHbUY8FyS1mz+ZwyUeCSpyj1Xg2I7Ls3DWAgAEFqICAAC/HYA==
Date: Thu, 19 Dec 2024 21:37:48 +0000
Message-ID:
 <SN6PR02MB4157DD7CE09E39C524775168D4062@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20241218205421.319969-1-romank@linux.microsoft.com>
 <20241218205421.319969-3-romank@linux.microsoft.com>
 <Z2OIHRF-cJ92IBv2@liuwe-devbox-debian-v2>
 <8da58247-87df-4250-820a-758ea8e00bbb@linux.microsoft.com>
In-Reply-To: <8da58247-87df-4250-820a-758ea8e00bbb@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|MN2PR02MB6959:EE_
x-ms-office365-filtering-correlation-id: 47956a8f-ae5f-4161-e6ad-08dd207561d1
x-ms-exchange-slblob-mailprops:
 ymJijV9pwJk27+axzTH4qfXnaf5wM6uSLeMnK2t7SUcl9nTbab1586/kRC5Ccx2Kp/M0F3L0wu8Kjryi+drGul/xLqAdNEQOUplTBdaAolSTOjM1j4Cr/U+yBiT3y0UiRXhj46N5w8ID5QzW2c//ptf/JdEO3A8zpSXMkHSQHe0oxhBz3c+pg22HhdZ0qPwlDSdX+LcBfyBLpOVDglWf0UELBpH89chFUezHLXURxGTqs/qHy+QQe1sBo8G5+YFzxaqJQA78C0E8sluGIgpVEoZzj5sSFn77g/0PKNSTtT2zJEJgDOvyY62BvGCzqr35MloCovFrUav/G9ZGxai3HeJxJ2PbubWzxAKDaQGJHnV2jh+7na9xN9+NuJmqf5PHKKJGQwC6P9fto3Hqf21alJ/ftwlYG3aZTVqrvZxuDhUK4Eloc6NZD9yxXOWUAOaU/Z6BFIomJFGCEVDFzFEnNyUjP0OZTI0FrTOXtxhY4CORZWqepQ3+3pN2rH4voLq0pyVbE34SFFhL7RjoPxoza1PSL7wPkdSHbm6gCYo9Gx5KlwEtspBctk1+7vGukmVJDU8qqHSXEnSmucFWfyoEVbnQDL6Z24qUbFUdCpNDjQ8ynjLjUcyZxIiT4OwsdgtjIURIPsgVL3gjk2JLVJYKvF1LHhXfuAtyDUYUgGh5QcKUPmfFzb0PVBVFdMBwdcvHBt7P7adi5bFziDVEzcN26SdQJymm+CcuBa576saDmE6YsFmjXwYLXHdloyqL8p6N1Lvwis7E/KJRQFAWt5LU9O+gzHFwiz70FAb4+DMj8kZoEZXDa4/Im+i/5Z8dXE1A
x-microsoft-antispam:
 BCL:0;ARA:14566002|8062599003|19110799003|15080799006|8060799006|461199028|102099032|10035399004|4302099013|440099028|3412199025|56899033|1602099012;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?gbiAeh5acXU+yIPzRYdGHVT5RytQGEh+e2db6BelmlP23KjCzHP8W/LPK02W?=
 =?us-ascii?Q?pdCRyvLqbjdAMWP+/Y0/CmtYVh8f93yMH6sg/HiGauDjo+dx+W2FWiZxjaMs?=
 =?us-ascii?Q?HIQCXU44TgckxlYC8DZwXkvvkB7RW98e49Awc2+rNCKkr9vBKmMvI6a6bUN7?=
 =?us-ascii?Q?H9lzuidAl77301PGmtvH11WTmdVJSM1Q5s5WQdj1VKjt+kYpZISnKHDvBONs?=
 =?us-ascii?Q?yiplMCqRro/Kt4pHGUfhF+Ed8zu0uTME+FsZAtHKJAcg26gskSCFYVlBfqxR?=
 =?us-ascii?Q?Eb9cPRqK//6Epgs/uUCUyDaZ2r2uq2tLPRQ1iOczrlMLoLA3w13mfNfZricp?=
 =?us-ascii?Q?aHg72fMZn2aQmzjAt0aiUnjiVYQDYGEU80kDWbx/VaP68C4Rtdmlf+WIRq6r?=
 =?us-ascii?Q?+DiBQ1yC6hwXnKSTZGaCr/XCmpHLf4tMi8lWVJyVJN1oOHwuimnqfD9IBpXG?=
 =?us-ascii?Q?SbdTTI904wqt7zuZIlFZbZbJittingG4BNHMOSs8C79HjkNb9HTUSBGGq6+C?=
 =?us-ascii?Q?kvTkc11ZcNTBm5LggFCVzB9iE/Gwe47MiZZqNovRyMUaQGu/quWfFnRK+3+p?=
 =?us-ascii?Q?A91EJCVzbhz7gilKlWqdFVAPoFFjGDOgZb6HXh4TZG7ydPQ+sdPUubpwdban?=
 =?us-ascii?Q?IjpV0vsiUr4APf+xCghr4P0Jr1tbXcQWJcKeqd4Rzvh3lmcA25/nEv3gz1Ju?=
 =?us-ascii?Q?WZH0xqcnIEf+8h4VyZ7Yax1SiKabxInIVuUb6z6DPkcPH++gptJdhNkVPLMK?=
 =?us-ascii?Q?BYeARJ1spaHsFiPi9BL9dhfi0vTiPuaiDYYBJquhytMR/0cXO86jcYX4PU9d?=
 =?us-ascii?Q?Qbe0qxB4eS6WCHYYBz2FzNe6VIdqU4M/2LZQtZegcIUyr0X1IkuV//ffcqj9?=
 =?us-ascii?Q?7BkPT1FHVTg+LkSUCzFdvCOn1eQT77m5rq+Xxwc1wWqQA8/el7bqdK3GPglt?=
 =?us-ascii?Q?a3w15FQufizHSJPCgrTaZOFIGL2igmZ8asPY1qdHWm2x+CXeIuoJk5PAT0Bl?=
 =?us-ascii?Q?sCTDg9mruqNTwBhjR7DTGTXfU1hT8kR75EifkgDICYCk1KgR56uU4oVr8XBe?=
 =?us-ascii?Q?3feJd6ZprzPrQnnMq0NwU/o3KXMLYsrd34PhtWNmKT/gC4IwYdqZZ6eGCc8U?=
 =?us-ascii?Q?OpNfFpAirLzv4KO9zTKm1NdY0T0AXMztJlz2JYMq1X3BxmPaUWxxa1k=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?zer4JQ8jyqchXfakGHEYYv44YHDakzviW/Wyh90fsJZkrVqSjALT3M/0Yx4S?=
 =?us-ascii?Q?FgoWVIL2Y2GHI+9WcAPpY+BoJMDC0sGH6RhaPfpTXDGA7yao8PB839BwI11U?=
 =?us-ascii?Q?zsy24WShyU4ggLX0s54oJ+mL7/P/Ab8bglasAuSk8cgS8E9NgyajSHmd9SdA?=
 =?us-ascii?Q?l/V/J8mJyaHI/jI67minSW97UKc6UM4JGTpRak9HBTgzMibELvZhJLHg6ju7?=
 =?us-ascii?Q?hekJKvnWqKIwSttIpQ5jonj196Xbl1e2gZ6mAiZgTL+7yHcho5ks9D8gJzwi?=
 =?us-ascii?Q?i8I6jOYONwUJAfNvhashgPhxEixyjCqujdIMZOXnuz8VW1YQeEh8x4aw0sER?=
 =?us-ascii?Q?SQV10jQBqBfNxCwlMxrZ+6vlouCanUJ9Jib6AkKnwG3dOrV4LeXwguKy1n2N?=
 =?us-ascii?Q?NkAn8SajB3rUDQjnq22A+opE8lEc3kRhNJgBtQv9NQjSXGrck+6693w7XBAQ?=
 =?us-ascii?Q?ScJFjOC19uQiGsuKy4KXFKOukSyHwMrdSieJghfspB/nKe32XHJ8jbcMhvg4?=
 =?us-ascii?Q?5Jvgynrev4ku3ARb5e6kJuNOPeRYyu5lKKaAReTclD4jNbfjbSEeYEDP+PCk?=
 =?us-ascii?Q?7TRcTjUca9OD399IMuVWtbAZUCj9NBZb5ujlHbqPTMKPK7rz/XEkwtY/ggV2?=
 =?us-ascii?Q?Ii/iRjF4IRrnN4UOiIfoCWN+3Eq3M0Cgbu0Mxa6EIGdruKsmgrU84cA68sI9?=
 =?us-ascii?Q?SMylfmnr01d8spCQbvgRPIovspGDhL/ztpkKLoldrKvDviju9LsnfplwruPz?=
 =?us-ascii?Q?8haix6awkER8hhRolvchnaHM8bC8ipdEeE/PFJ+usf8Y383b8gzrRP1i8pvn?=
 =?us-ascii?Q?sKtAmErYPxVdB60Qb63esRCckBJ3801VetMO+g/KBUfRqmqXxp29s1mCNL9I?=
 =?us-ascii?Q?zmzK5zSW9Gf6DOq8/J7NMp1k196W0cvARj3+sOqlhGtITf5UmOmIIJrLwUQM?=
 =?us-ascii?Q?H/PKkWI0CFVDI+wJ/CjlhoWvALGAnGwBlIMnQzJkpbp4ZqGIvnyNGPGBAVcl?=
 =?us-ascii?Q?M45gRyiP1jAjEaUHIAQlWOyIdvhuicM1CpcuqONlwEPm6mE/ijzqqX1Lt35n?=
 =?us-ascii?Q?+Hy3uhzqBhbuPzD9Q3gn+VGNPx2z5qwjE7IoD1XKmROHXyTM3WUGFGHKsevd?=
 =?us-ascii?Q?ISvlCRWSUxdE8h1qjkBGat6GdkYgErAkf1bir18KUUtH7HejzGwc/z8sIleY?=
 =?us-ascii?Q?vDiZX8IXTOlPEQ1asswHrP+CgMKJQjMlOglnuohINeG9Ap1dUe67gg4cvsE?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 47956a8f-ae5f-4161-e6ad-08dd207561d1
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2024 21:37:48.0737
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6959

From: Roman Kisel <romank@linux.microsoft.com> Sent: Thursday, December 19,=
 2024 10:19 AM
>=20
> On 12/18/2024 6:42 PM, Wei Liu wrote:
> > On Wed, Dec 18, 2024 at 12:54:21PM -0800, Roman Kisel wrote:

[...]

> >> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> >> index c7185c6a290b..90c9ea00273e 100644
> >> --- a/arch/x86/hyperv/hv_init.c
> >> +++ b/arch/x86/hyperv/hv_init.c
> >> @@ -422,7 +422,7 @@ static u8 __init get_vtl(void)
> >>
> >>   	local_irq_save(flags);
> >>   	input =3D *this_cpu_ptr(hyperv_pcpu_input_arg);
> >> -	output =3D (struct hv_get_vp_registers_output *)input;
> >> +	output =3D *this_cpu_ptr(hyperv_pcpu_output_arg);
> >
> > You can do
> >
> > 	output =3D (char *)input + HV_HYP_PAGE_SIZE / 2;
> >
> > to avoid the extra allocation.
> >
> > The input and output structures surely won't take up half of the page.
> Agreed on the both counts! I do think that the attempt to save here
> won't help much: the hypercall output per-CPU pages in the VTL mode are
> needed just as in the dom0/root partition mode because this hypercall
> isn't going to be the only one required.
>=20
> In other words, we will have to allocate these pages anyway as we evolve
> the code; we are trying to save here what is going to be spent anyway.
> Sort of, kicking the can down the road as the saying goes :)
>=20
> I do understand that within the code that is already merged, there is
> just one this place in this function where the hypercall that returns
> data is used. And the proposed approach makes the code self-explanatory:
> ```
> output =3D *this_cpu_ptr(hyperv_pcpu_output_arg);
> ```
>=20
> as opposed to
>=20
> ```
> output =3D (char *)input + HV_HYP_PAGE_SIZE / 2;
> ```
>=20
> or, as it existed,
>=20
> ```
> output =3D (struct hv_get_vp_registers_output *)input;
> ```
>=20
> which both do require a good comment I believe.
>=20
> There will surely be more hypercall usage in the VTL mode that return
> data and require the output pages as we progress with upstreaming the
> VTL patches. Enabling the hypercall output pages allows to fix the
> function in question in a very natural way, making it possible to
> replace with some future `hv_get_vp_register` that would work for both
> dom0 and VTL mode just the same.
>=20
> All told, if you believe that we should make this patch a one-liner,
> I'll do as you suggested.
>=20

FWIW, Roman and I had this same discussion back in August. See [1].
I'll add one new thought that wasn't part of the August discussion.

To my knowledge, the hypercalls that *may* use a full page for input
and/or a full page for output don't actually *require* a full page. The
size of the input and output depends on how many "entries" the
hypercall is specified to process, where "entries" could be registers,
memory PFNs, or whatever. I would expect the code to invoke these
hypercalls must already deal with the case where the requested number
of entries causes the input or output size to exceed one page, so the
code just iterates making multiple invocations of the hypercall with
a "batch size" that fits in one page.

It would be perfectly reasonable to limit the batch size so that a
"batch" of input or output fits in a half page instead of a full page,
avoiding the need to allocate hyperv_pcpu_output_arg. Or if the
input and output sizes are not equal, use whatever input vs. output
partitioning of a single page make sense for that hypercall. The
tradeoff, of course, is having to make the hypercall more times
with smaller batches. But if the hypercall is not in a hot path, this
might be a reasonable tradeoff to avoid the additional memory
allocation. Or if the hypercall processing time per "entry" is high,
the added overhead of more invocations with smaller batches is
probably negligible compared to the time processing the entries.

This scheme could also be used in the existing root partition code
that is currently the only user of the hyperv_pcpu_output_arg.
I could see a valid argument being made to drop
hyperv_pcpu_output_arg entirely and just use smaller batches.

Or are there hypercalls where a smaller batch size doesn't work
at all or is a bad tradeoff for performance reasons? I know I'm not
familiar with *all* the hypercalls that might be used in root
partition or VTL code. If there are such hypercalls, I would be curious
to know about them.

Michael

[1] https://lore.kernel.org/linux-hyperv/SN6PR02MB415759676AEF931F030430FDD=
4BE2@SN6PR02MB4157.namprd02.prod.outlook.com/

