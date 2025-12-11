Return-Path: <linux-hyperv+bounces-8017-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FC76CB6C88
	for <lists+linux-hyperv@lfdr.de>; Thu, 11 Dec 2025 18:46:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B0D22301CD04
	for <lists+linux-hyperv@lfdr.de>; Thu, 11 Dec 2025 17:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DB77328269;
	Thu, 11 Dec 2025 17:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Iuy+JZGv"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazolkn19012067.outbound.protection.outlook.com [52.103.14.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC1B1327BFD;
	Thu, 11 Dec 2025 17:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.14.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765474651; cv=fail; b=ZjNpIUY3xxYdID/Mhsjsh+dmLj8Hvr98KyBvo7ro7nYEcXHObJgZyd7mvjfKvw3pKt64+ZyjvOSRGp0vcRqhHj6Aip5NqXbLtc/6bd5t/vgN0vKEpCn7p5QgSPrCzKvA+qiryrz7emdxfabcIpgDVlDQAlROUY62lF5L7JUGzi0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765474651; c=relaxed/simple;
	bh=mnZKrpNduyU85YemgJ20g0SESI7UD+mwbheGY4PotRI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LANgbNnY35utYDzaQpoJbdwjVQ46f0Kyj1u6xfu6OCSmjeSEj0xc2VkeLIoPtktpsDtaQIXC9py+YRdD2Ko5K+cZt+V2AYHyl2T5ZUnSMmipnuFhHBZK/7nVTQsCqglpNNLeJ4TUYeJv2AAcfKsh58sFxkEmEiKhQrh9xDBNOvY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Iuy+JZGv; arc=fail smtp.client-ip=52.103.14.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=grfVeuqR8dADoBvekrIGI0Vk4m6K6M0p4/unNQh6Pjjt1gGF3pa6s4odjo2TaxUEpwjXx2W1OwVrjb3x4M6TR4PZaMGyq09BREKzAewWToSHyNSiPczCXfb27tYqs1p0oT3GIFXwS7+CiOrcc3mQgQKAnpF/ptmCfWkPc7PAfB4l5R3xgpXiVQMuiJFv8i+giZuCht5a/v32LSYlytMw0bulLR17qjXuaJEWZ1c0FUrFNFOddfCyrhnb94IE1ALwfItsipMV8xjXLwtmxNYjA+fLMjCrD6IPnDkLRvPNFcIOp2QvYBzSHUNAx5J3DaHyA/TOVo+nh9PZjM0fC3egzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e7NAzemTuQPDSCIHDWFPuO+vAi/HPKzWCW/P0b36ju4=;
 b=y4ZjjFXyAjYDah9lVRy6csyBt77J5HCFEyckLAWJ60J/yHa8uRvSDws0wr2gz8YqjC26HyD4Kg+jjjqqJ3XuLQg6AeW0cjrKz39qm18sTfNA4yGM6c3lvCBnTddlm/mDzv298/tJsiZOaO0AAL/fPHqkU1JM4Xf/qDBsKuSyDl2k/gBg+BVLuoUHZic7993uRtfZJmTqWXWfzS/BcXJ6fvFvHj9E2gfHPt0gvuoLiUHfbgR0vFBDYgmrgDkZs1gh9ahsraynPmV/DDCilGwqZf5Tf+5t3lqFRfpSIsxV2Q8NtVZfaRwD74qLO2s2g9c7Fg6uXM6FIktxPU3mOPJheQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e7NAzemTuQPDSCIHDWFPuO+vAi/HPKzWCW/P0b36ju4=;
 b=Iuy+JZGvqPwZS68TvLNWxpvvlXanQ5SIkA8YnqXYFJZSNSgI4JM/+VuJNA01+tzMQ4HhKTwgDEGGvJKGEZtn9sy2c2/WqCLEGJtqrsNhi1UfXRbDt00PeEnc8t+os60ud/vUhPFgukdXT5f/WR+G+Bi0vdjby/EWRK1JTWeBCuSXJzSyibZakmvLpLCPz5uhS0d+YJnPQE5F8g2PVqD7TY0LaT9BF0jlZbfnQaBcFL2Z1KDghzsqShagn/ztdUoS8asN3baAU0Ta7NicMTzkqpT767ALYD5jr8iTEbwMZlmmxeVNbMtKk4QxAdhY2odsY3Pl1fIJScA8yNIStBYnGA==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by PH7PR02MB9941.namprd02.prod.outlook.com (2603:10b6:510:2f4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.8; Thu, 11 Dec
 2025 17:37:26 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%3]) with mapi id 15.20.9412.005; Thu, 11 Dec 2025
 17:37:26 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
CC: "kys@microsoft.com" <kys@microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v7 4/7] Drivers: hv: Fix huge page handling in memory
 region traversal
Thread-Topic: [PATCH v7 4/7] Drivers: hv: Fix huge page handling in memory
 region traversal
Thread-Index: AQHcXnnA9RWbyZ3vaUihOD1Emk/4ULURp4HAgABf1ICACZYREA==
Date: Thu, 11 Dec 2025 17:37:26 +0000
Message-ID:
 <SN6PR02MB4157978DFAA6C2584D0678E1D4A1A@SN6PR02MB4157.namprd02.prod.outlook.com>
References:
 <176412196000.447063.4256335030026363827.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <176412295155.447063.16512843211428609586.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <SN6PR02MB4157F10A84C4BE170AB040F4D4A6A@SN6PR02MB4157.namprd02.prod.outlook.com>
 <aTH4T-FKcL1knHaD@skinsburskii.localdomain>
In-Reply-To: <aTH4T-FKcL1knHaD@skinsburskii.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|PH7PR02MB9941:EE_
x-ms-office365-filtering-correlation-id: 7e08bf3f-52d3-48a0-e75c-08de38dbf321
x-microsoft-antispam:
 BCL:0;ARA:14566002|15080799012|19110799012|461199028|13091999003|31061999003|8022599003|12121999013|8062599012|8060799015|41001999006|440099028|3412199025|12091999003|102099032;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?durp1MpV7k01sgG2B/wimqW52A9BJk+OIHaO/aB8SUu1oiQPFjw2t1j2W8qw?=
 =?us-ascii?Q?4iWtxh0AHVnSlNe13lltoh4DFPBZpA2GH5zMJa0C9vZTkI4wSMOjbMig7fn4?=
 =?us-ascii?Q?EIqSSHHfcbPuSDfD1pGhFaPKY5POghUd/4C+JeR8uaKTcqcYdomKCPJFQ8K1?=
 =?us-ascii?Q?CGZQN71RnkMq7ccNHPxxVGjAd/aa/jLvfg/v5qzwEHhns0OYDFqvkdwFj8CV?=
 =?us-ascii?Q?H2DcYZB/4ZvnaCoFTVmBuCnzIHCziPi7VbkN/bpKsA2qYqnNiSODUx3qOZWS?=
 =?us-ascii?Q?z8sSYCDPDETJ567b7uE8XsQ4NyTk5Mhq1Sf0IpOtJR9siKEkSn3T+4B4cK0x?=
 =?us-ascii?Q?gXxHXaWEpUY9hNoK3gTiXaSHSks0fRVqRQlz7JTVacJU2rnFWthY4JJjfWP6?=
 =?us-ascii?Q?Q0A7Eh4ho1c9AwcJEKdoHbKgiYm5wklE8GqTLwJ1Ztvbok3BrZZkhPfsBbC4?=
 =?us-ascii?Q?PcXI+BNeLt32V7Fx2tqVo+McE6pNIqzhroTiYFALiEa2+y/wVHmJs48a+CAF?=
 =?us-ascii?Q?rfI+PUNHSbNntyJyJz56LPCJ/pV7x1WSFQfbGp5Hre3hl7PBx29nC4fcy8Ha?=
 =?us-ascii?Q?ohez0c0iwGBmiCuDSeArIiMmRDjEuj0fHGu00sqhlEnIuJnyTpdMlYfq0PTj?=
 =?us-ascii?Q?OvSqvA839AAxM8lLLBBaz61hS8hhV/6DdFf8GLJ5cxg+DggBhx59JTCICc1P?=
 =?us-ascii?Q?6GUm8oH8Fuenn4ImUtfn4/4CD1JRPznQQEQFsd3rMFAzEL4rml/b3fTgU8Y7?=
 =?us-ascii?Q?pTQ9GXtuY/n1bU5QCXsTqqDUPB2QsVFdy8ejKJdtAFs8we4xfyGTpA9dPL6M?=
 =?us-ascii?Q?ftnc/bwAAScs9c4E4nExfCFVJL3NEZxJb+Y++HTuw1jPsBw7JQLiDp/OP43K?=
 =?us-ascii?Q?2vc10cVyTkWiAahmUvSn22c4OzK2Klmz1CP2PlxyCYgO20AWDf2Qite5XmHh?=
 =?us-ascii?Q?nvh65K8rQzNWw+fHYCYtRQIU8o94AlDoxt9gFkAZtvKtSvvUNayZ9F85hyUd?=
 =?us-ascii?Q?mNFhM6426Kr5tlefJfoN3os9XzgURPLztvq8EpHYmGJzusdCT/54+kH5ihL/?=
 =?us-ascii?Q?EJtZGctbDKT2o0BiFh/ixAPnH+oL6ViQliSqWFEtS+6l7/ARd4/4AixNMfDh?=
 =?us-ascii?Q?PymXTlXOWRW8Fciq55rhRaZizJrxSVUS2VI9Rg2dE65RN7+431LwSSHQ4mpb?=
 =?us-ascii?Q?ZO1I/eTi3aAAsOkdff3hJMWWTI8HRXOTNJ6fF03OODMbSlZ/rwzgFdTwSi5D?=
 =?us-ascii?Q?jHRnDqunUrhRgDFQTSVhVWqMgvhTjARhJoJr6Vzgpg=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?/HtwH76tj7dGtnuZ6kfjtapNkdI0SJoeWE/3YKtDLIC82GWYz5cdOI8saAKz?=
 =?us-ascii?Q?gtMWo9l4C6cD2YcwTZcvs6Hhe7x8258MT/ix/RbtAtYFZLb3xGja3u+M9uBZ?=
 =?us-ascii?Q?9rLzZ2vZK6gJ798tvb8PnIGYG3JLoUiSyv2XaMj/R5fFPcqQT37ACIM0ga+B?=
 =?us-ascii?Q?jLkW1LQaXh23kOplgiPEJz4HvOUk3r8148J9FUbpR/Gh8xKYpM/PAQ26Pqen?=
 =?us-ascii?Q?P9umTe2H5wE1OQmGcyhqLgzwj2G8wR9AD6owch1s4E6FwxNhbavCjPAtWbiw?=
 =?us-ascii?Q?mTj1B8NpqXFO0InVeOE1N0nDFyYgNS+QipxI3ejyp5EgNDrw1FuxuImDZHK6?=
 =?us-ascii?Q?gLWGRVFgRj9qw9k+RAUxb9C9bPJK4wBH4lFyXV5mUKtnOpXhSROridJ1NBq4?=
 =?us-ascii?Q?wEB7Yez5Pa8bPg7NP6HLahrmBfWD2Xy4NLe9YE+6sbM5nfpltgnfEn7NEkY9?=
 =?us-ascii?Q?ewx541toFBRJkEgI5Vz1vOGK1WW7PFx3GiIpDKGlHuqVq9ZPDV2PtlgataDr?=
 =?us-ascii?Q?ScaPI3YWji7MM30uzcFzvRGR08Uj/eVGTqXkvCfzczmznhPOifnd6iMyl24a?=
 =?us-ascii?Q?DdR99xUmswi5SV6CngkQApzmwRmrrfHn7AYfK5jCfOaeXVr8bhzEldky6ts0?=
 =?us-ascii?Q?iMvSuv0GPoWN3+CwqQGQi7kU8Zsp2y8/DZZjP+wjxmyV+T7m0UrG3FRigQUl?=
 =?us-ascii?Q?jpPdTXD/+ocDTdNXjfdL+o8UuSn8/xuRW4pmbWB8A5GaNGWgw2cy0nQ/aMaS?=
 =?us-ascii?Q?/mb73GdLhASLnLIzAyy05NnhPZWUhzZlbLczZjPWI7KSLl+x1g0xgbLwEn41?=
 =?us-ascii?Q?5DBsCOsgFxhaH4k/v4RAdP+PcSIpQ/KVP3GOc8PnSbU7t/bP80QEHVeQ2jGy?=
 =?us-ascii?Q?FjCHyzB7DY8SaktFV4hKDnYzfpbBloAp1ybspkZN2Jix0GBjLLhwkw7toXVo?=
 =?us-ascii?Q?vNbUh7DFScYaq88MK+uLFo/MKHd1FCjya3YSSAmYSglN611SaeBoxIKsQmSS?=
 =?us-ascii?Q?SaVhNi5wJumIr3AvCbBu+bUcdT+NzuJSICrlPwgvIoBdafKw9HVRRG/r0mbk?=
 =?us-ascii?Q?sEorwPtMUohXzfjYTG5CM86sC+1SGnQIPBR23txxLEuayzZudTCpkC3emF+p?=
 =?us-ascii?Q?TjUpaKO6aMt79GwFWezX0OLCewN5jlm9YreeGO/DDajxmevGdryt1t3cC4sN?=
 =?us-ascii?Q?ctpoAvHHA+2lipnZZqHeL09nFuswMtjeAW20odnoWyqQZSvza57dqOAqAY4?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e08bf3f-52d3-48a0-e75c-08de38dbf321
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2025 17:37:26.1023
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR02MB9941

From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com> Sent: Thursd=
ay, December 4, 2025 1:09 PM
>=20
> On Thu, Dec 04, 2025 at 04:03:26PM +0000, Michael Kelley wrote:
> > From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com> Sent: Tu=
esday, November 25, 2025 6:09 PM
> > >

[snip]

> > > +static long mshv_region_process_chunk(struct mshv_mem_region *region=
,
> > > +				      u32 flags,
> > > +				      u64 page_offset, u64 page_count,
> > > +				      int (*handler)(struct mshv_mem_region *region,
> > > +						     u32 flags,
> > > +						     u64 page_offset,
> > > +						     u64 page_count))
> > > +{
> > > +	u64 count, stride;
> > > +	unsigned int page_order;
> > > +	struct page *page;
> > > +	int ret;
> > > +
> > > +	page =3D region->pages[page_offset];
> > > +	if (!page)
> > > +		return -EINVAL;
> > > +
> > > +	page_order =3D folio_order(page_folio(page));
> > > +	/* 1G huge pages aren't supported by the hypercalls */
> > > +	if (page_order =3D=3D PUD_ORDER)
> > > +		return -EINVAL;
> >
> > In the general case, folio_order() could return a variety of values ran=
ging from
> > 0 up to at least PUD_ORDER.  For example, "2" would be valid value in f=
ile
> > system code that uses folios to do I/O in 16K blocks instead of just 4K=
 blocks.
> > Since this function is trying to find contiguous chunks of either singl=
e pages
> > or 2M huge pages, I think you are expecting only three possible values:=
 0,
> > PMD_ORDER, or PUD_ORDER. But do you know that "2" (for example)
> > would never be returned? The memory involved here is populated using
> > pin_user_pages_fast() for the pinned case, or using hmm_range_fault() f=
or
> > the movable case. I don't know mm behavior well enough to know if those
> > functions could ever populate with a folio with an order other than 0 o=
r
> > PMD_ORDER. If such a folio could ever be used, then the way you check
> > for a page size change won't be valid. For purposes of informing Hyper-=
V
> > about 2 Meg pages, folio orders 0 through 8 are all equivalent, with fo=
lio
> > order 9 (PMD_ORDER) being the marker for the start of 2 Meg large page.
> >
> > Somebody who knows mm behavior better than I do should comment. Or
> > maybe you could just be more defensive and handle the case of folio ord=
ers
> > not equal to 0 or PMD_ORDER.
> >
>=20
> Thanks for the comment.
> This is addressed this in v9 by expclitly checking for 0 and HUGE_PMD_ORD=
ER.
>=20
> > > +
> > > +	stride =3D 1 << page_order;
> > > +
> > > +	/* Start at stride since the first page is validated */
> > > +	for (count =3D stride; count < page_count; count +=3D stride) {
> >
> > This striding doesn't work properly in the general case. Suppose the
> > page_offset value puts the start of the chunk in the middle of a 2 Meg
> > page, and that 2 Meg page is then followed by a bunch of single pages.
> > (Presumably the mmu notifier "invalidate" callback could do this.)
> > The use of the full stride here jumps over the remaining portion of the
> > 2 Meg page plus some number of the single pages, which isn't what you
> > want. For the striding to work, it must figure out how much remains in =
the
> > initial large page, and then once the striding is aligned to the large =
page
> > boundaries, the full stride length works.
> >
> > Also, what do the hypercalls in the handler functions do if a chunk sta=
rts
> > in the middle of a 2 Meg page? It looks like the handler functions will=
 set
> > the *_LARGE_PAGE flag to the hypercall but then the hv_call_* function
> > will fail if the page_count isn't 2 Meg aligned.
> >
>=20
> This situation you described is not possible, because invalidation
> callback simply can't invalidate a part of the huge page even in THP
> case (leave aside hugetlb case) without splitting it beforehand, and
> splitting a huge page requires invalidation of the whole huge page
> first.

I've been playing around with mmu notifiers and 2 Meg pages. At least in my
experiment, there's a case where the .invalidate callback is invoked on a
range *before* the 2 Meg page is split. The kernel code that does this is
in zap_page_range_single_batched(). Early on this function calls
mmu_notifier_invalidate_range_start(), which invokes the .invalidate
callback on the initial range. Later on, unmap_single_vma() is called, whic=
h
does the split and eventually makes a second .invalidate callback for the
entire 2 Meg page.

Details:  My experiment is a user space program that does the following:

1. Allocates 16 Megs of memory on a 16 Meg boundary using
posix_memalign(). So this is private anonymous memory. Transparent
huge pages are enabled.

2. Writes to a byte in each 4K page so they are all populated.=20
/proc/meminfo shows eight 2 Meg pages have been allocated.

3. Creates an mmu notifier for the allocated 16 Megs, using an ioctl
hacked into the kernel for experimentation purposes.

4. Uses madvise() with the DONTNEED option to free 32 Kbytes on a 4K
page boundary somewhere in the 16 Meg allocation. This results in an mmu
notifier invalidate callback for that 32 Kbytes. Then there's a second inva=
lidate
callback covering the entire 2 Meg page that contains the 32 Kbyte range.
Kernel stack traces for the two invalidate callbacks show them originating
in zap_page_range_single_batched().

5. Sleeps for 60 seconds. During that time, khugepaged wakes up and does
hpage_collapse_scan_pmd() -> collapse_huge_page(), which generates a third
.invalidate callback for the 2 Meg page. I'm haven't investigated what this=
 is
all about.

6. Interestingly, if Step 4 above does a slightly different operation using
mprotect() with PROT_READ instead of madvise(), the 2 Meg page is split fir=
st.
The .invalidate callback for the full 2 Meg happens before the .invalidate
callback for the specified range.

The root partition probably isn't doing madvise() with DONTNEED for memory
allocated for guests. But regardless of what user space does or doesn't do,=
 MSHV's
invalidate callback path should be made safe for this case. Maybe that's ju=
st
detecting it and returning an error (and maybe a WARN_ON) if user space
doesn't need it to work.

Michael

>=20
> > > +		page =3D region->pages[page_offset + count];
> > > +
> > > +		/* Break if current page is not present */
> > > +		if (!page)
> > > +			break;
> > > +
> > > +		/* Break if page size changes */
> > > +		if (page_order !=3D folio_order(page_folio(page)))
> > > +			break;
> > > +	}
> > > +
> > > +	ret =3D handler(region, flags, page_offset, count);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	return count;
> > > +}
> > > +
> > > +/**
> > > + * mshv_region_process_range - Processes a range of memory pages in =
a
> > > + *                             region.
> > > + * @region     : Pointer to the memory region structure.
> > > + * @flags      : Flags to pass to the handler.
> > > + * @page_offset: Offset into the region's pages array to start proce=
ssing.
> > > + * @page_count : Number of pages to process.
> > > + * @handler    : Callback function to handle each chunk of contiguou=
s
> > > + *               pages.
> > > + *
> > > + * Iterates over the specified range of pages in @region, skipping
> > > + * non-present pages. For each contiguous chunk of present pages, in=
vokes
> > > + * @handler via mshv_region_process_chunk.
> > > + *
> > > + * Note: The @handler callback must be able to handle both normal an=
d huge
> > > + * pages.
> > > + *
> > > + * Returns 0 on success, or a negative error code on failure.
> > > + */
> > > +static int mshv_region_process_range(struct mshv_mem_region *region,
> > > +				     u32 flags,
> > > +				     u64 page_offset, u64 page_count,
> > > +				     int (*handler)(struct mshv_mem_region *region,
> > > +						    u32 flags,
> > > +						    u64 page_offset,
> > > +						    u64 page_count))
> > > +{
> > > +	long ret;
> > > +
> > > +	if (page_offset + page_count > region->nr_pages)
> > > +		return -EINVAL;
> > > +
> > > +	while (page_count) {
> > > +		/* Skip non-present pages */
> > > +		if (!region->pages[page_offset]) {
> > > +			page_offset++;
> > > +			page_count--;
> > > +			continue;
> > > +		}
> > > +
> > > +		ret =3D mshv_region_process_chunk(region, flags,
> > > +						page_offset,
> > > +						page_count,
> > > +						handler);
> > > +		if (ret < 0)
> > > +			return ret;
> > > +
> > > +		page_offset +=3D ret;
> > > +		page_count -=3D ret;
> > > +	}
> > > +
> > > +	return 0;
> > > +}
> > > +
> > >  struct mshv_mem_region *mshv_region_create(u64 guest_pfn, u64 nr_pag=
es,
> > >  					   u64 uaddr, u32 flags,
> > >  					   bool is_mmio)
> > > @@ -33,55 +151,80 @@ struct mshv_mem_region *mshv_region_create(u64
> guest_pfn, u64 nr_pages,
> > >  	if (flags & BIT(MSHV_SET_MEM_BIT_EXECUTABLE))
> > >  		region->hv_map_flags |=3D HV_MAP_GPA_EXECUTABLE;
> > >
> > > -	/* Note: large_pages flag populated when we pin the pages */
> > >  	if (!is_mmio)
> > >  		region->flags.range_pinned =3D true;
> > >
> > >  	return region;
> > >  }
> > >
> > > +static int mshv_region_chunk_share(struct mshv_mem_region *region,
> > > +				   u32 flags,
> > > +				   u64 page_offset, u64 page_count)
> > > +{
> > > +	if (PageTransCompound(region->pages[page_offset]))
> > > +		flags |=3D HV_MODIFY_SPA_PAGE_HOST_ACCESS_LARGE_PAGE;
> >
> > mshv_region_process_chunk() uses folio_size() to detect single pages vs=
. 2 Meg
> > large pages. Here you are using PageTransCompound(). Any reason for the
> > difference? This may be perfectly OK, but my knowledge of mm is too lim=
ited to
> > know for sure. Looking at the implementations of folio_size() and
> > PageTransCompound(), they seem to be looking at different fields in the=
 struct page,
> > and I don't know if the different fields are always in sync. Another ca=
se for someone
> > with mm expertise to review carefully ....
> >
>=20
> Indeed, folio_order could be used here as well PageTransCompound could
> be used in the chunk processing function (but then the size of the page
> would still needed to be checked).
> On the other hand, there is subtle difference between the chunk
> procesing function and the callback in calls: the latter doesn't
> validate the input, thus the chunk processing function should.
>=20
> Thanks,
> Stanislav
>=20
> > Michael
> >
> > > +
> > > +	return hv_call_modify_spa_host_access(region->partition->pt_id,
> > > +					      region->pages + page_offset,
> > > +					      page_count,
> > > +					      HV_MAP_GPA_READABLE |
> > > +					      HV_MAP_GPA_WRITABLE,
> > > +					      flags, true);
> > > +}
> > > +
> > >  int mshv_region_share(struct mshv_mem_region *region)
> > >  {
> > >  	u32 flags =3D HV_MODIFY_SPA_PAGE_HOST_ACCESS_MAKE_SHARED;
> > >
> > > -	if (region->flags.large_pages)
> > > +	return mshv_region_process_range(region, flags,
> > > +					 0, region->nr_pages,
> > > +					 mshv_region_chunk_share);
> > > +}
> > > +
> > > +static int mshv_region_chunk_unshare(struct mshv_mem_region *region,
> > > +				     u32 flags,
> > > +				     u64 page_offset, u64 page_count)
> > > +{
> > > +	if (PageTransCompound(region->pages[page_offset]))
> > >  		flags |=3D HV_MODIFY_SPA_PAGE_HOST_ACCESS_LARGE_PAGE;
> > >
> > >  	return hv_call_modify_spa_host_access(region->partition->pt_id,
> > > -			region->pages, region->nr_pages,
> > > -			HV_MAP_GPA_READABLE | HV_MAP_GPA_WRITABLE,
> > > -			flags, true);
> > > +					      region->pages + page_offset,
> > > +					      page_count, 0,
> > > +					      flags, false);
> > >  }
> > >
> > >  int mshv_region_unshare(struct mshv_mem_region *region)
> > >  {
> > >  	u32 flags =3D HV_MODIFY_SPA_PAGE_HOST_ACCESS_MAKE_EXCLUSIVE;
> > >
> > > -	if (region->flags.large_pages)
> > > -		flags |=3D HV_MODIFY_SPA_PAGE_HOST_ACCESS_LARGE_PAGE;
> > > -
> > > -	return hv_call_modify_spa_host_access(region->partition->pt_id,
> > > -			region->pages, region->nr_pages,
> > > -			0,
> > > -			flags, false);
> > > +	return mshv_region_process_range(region, flags,
> > > +					 0, region->nr_pages,
> > > +					 mshv_region_chunk_unshare);
> > >  }
> > >
> > > -static int mshv_region_remap_pages(struct mshv_mem_region *region,
> > > -				   u32 map_flags,
> > > +static int mshv_region_chunk_remap(struct mshv_mem_region *region,
> > > +				   u32 flags,
> > >  				   u64 page_offset, u64 page_count)
> > >  {
> > > -	if (page_offset + page_count > region->nr_pages)
> > > -		return -EINVAL;
> > > -
> > > -	if (region->flags.large_pages)
> > > -		map_flags |=3D HV_MAP_GPA_LARGE_PAGE;
> > > +	if (PageTransCompound(region->pages[page_offset]))
> > > +		flags |=3D HV_MAP_GPA_LARGE_PAGE;
> > >
> > >  	return hv_call_map_gpa_pages(region->partition->pt_id,
> > >  				     region->start_gfn + page_offset,
> > > -				     page_count, map_flags,
> > > +				     page_count, flags,
> > >  				     region->pages + page_offset);
> > >  }
> > >
> > > +static int mshv_region_remap_pages(struct mshv_mem_region *region,
> > > +				   u32 map_flags,
> > > +				   u64 page_offset, u64 page_count)
> > > +{
> > > +	return mshv_region_process_range(region, map_flags,
> > > +					 page_offset, page_count,
> > > +					 mshv_region_chunk_remap);
> > > +}
> > > +
> > >  int mshv_region_map(struct mshv_mem_region *region)
> > >  {
> > >  	u32 map_flags =3D region->hv_map_flags;
> > > @@ -134,9 +277,6 @@ int mshv_region_pin(struct mshv_mem_region *regio=
n)
> > >  			goto release_pages;
> > >  	}
> > >
> > > -	if (PageHuge(region->pages[0]))
> > > -		region->flags.large_pages =3D true;
> > > -
> > >  	return 0;
> > >
> > >  release_pages:
> > > @@ -144,10 +284,28 @@ int mshv_region_pin(struct mshv_mem_region *reg=
ion)
> > >  	return ret;
> > >  }
> > >
> > > +static int mshv_region_chunk_unmap(struct mshv_mem_region *region,
> > > +				   u32 flags,
> > > +				   u64 page_offset, u64 page_count)
> > > +{
> > > +	if (PageTransCompound(region->pages[page_offset]))
> > > +		flags |=3D HV_UNMAP_GPA_LARGE_PAGE;
> > > +
> > > +	return hv_call_unmap_gpa_pages(region->partition->pt_id,
> > > +				       region->start_gfn + page_offset,
> > > +				       page_count, 0);
> > > +}
> > > +
> > > +static int mshv_region_unmap(struct mshv_mem_region *region)
> > > +{
> > > +	return mshv_region_process_range(region, 0,
> > > +					 0, region->nr_pages,
> > > +					 mshv_region_chunk_unmap);
> > > +}
> > > +
> > >  void mshv_region_destroy(struct mshv_mem_region *region)
> > >  {
> > >  	struct mshv_partition *partition =3D region->partition;
> > > -	u32 unmap_flags =3D 0;
> > >  	int ret;
> > >
> > >  	hlist_del(&region->hnode);
> > > @@ -162,12 +320,7 @@ void mshv_region_destroy(struct mshv_mem_region
> *region)
> > >  		}
> > >  	}
> > >
> > > -	if (region->flags.large_pages)
> > > -		unmap_flags |=3D HV_UNMAP_GPA_LARGE_PAGE;
> > > -
> > > -	/* ignore unmap failures and continue as process may be exiting */
> > > -	hv_call_unmap_gpa_pages(partition->pt_id, region->start_gfn,
> > > -				region->nr_pages, unmap_flags);
> > > +	mshv_region_unmap(region);
> > >
> > >  	mshv_region_invalidate(region);
> > >
> > > diff --git a/drivers/hv/mshv_root.h b/drivers/hv/mshv_root.h
> > > index 0366f416c2f0..ff3374f13691 100644
> > > --- a/drivers/hv/mshv_root.h
> > > +++ b/drivers/hv/mshv_root.h
> > > @@ -77,9 +77,8 @@ struct mshv_mem_region {
> > >  	u64 start_uaddr;
> > >  	u32 hv_map_flags;
> > >  	struct {
> > > -		u64 large_pages:  1; /* 2MiB */
> > >  		u64 range_pinned: 1;
> > > -		u64 reserved:	 62;
> > > +		u64 reserved:	 63;
> > >  	} flags;
> > >  	struct mshv_partition *partition;
> > >  	struct page *pages[];
> > >
> > >
> >

