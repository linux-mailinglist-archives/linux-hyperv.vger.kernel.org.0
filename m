Return-Path: <linux-hyperv+bounces-2901-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 543FF962DA6
	for <lists+linux-hyperv@lfdr.de>; Wed, 28 Aug 2024 18:30:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E86AE283D27
	for <lists+linux-hyperv@lfdr.de>; Wed, 28 Aug 2024 16:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1E001A257A;
	Wed, 28 Aug 2024 16:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Ugx8USb2"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazolkn19011035.outbound.protection.outlook.com [52.103.13.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA3EB1A257C;
	Wed, 28 Aug 2024 16:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.13.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724862611; cv=fail; b=S3q0Xt9K5vRYdFhLDJp+VRsEjP8t9q//ZWVU6VrEcivV8t4rbVQq77V1xRKAwytJmi/FvIQnpp9Ffl445kkEnwhAd/G6vSs0Cu4sahwi+hUeTLDOCk0Ga4U0ITt9I4NqCzS+Jc5X6zOmROsOSTlxJN1Q3Kdg4+7dXcGfz5Bzk6Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724862611; c=relaxed/simple;
	bh=AOgSYKIhH8oYHWArfVbW+nbSVHl6iHXacfMbPm+Fntw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sGI4lrsWabXqsY6/Q8a7aUtCtKx/dO6mpqviio7PzXmL/jgXH3PPR1y0tznJvUeRyZCtvnBogyQAwJyGUOFdSuautEOFBg893gPcozoUGuf3hTxrQopGDkBjoB/EyPoPvy0u/sYz64Kw1jB+00axrYEzNJIqDhapdDLCS1FPTH4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Ugx8USb2; arc=fail smtp.client-ip=52.103.13.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LCv7ind5zL9VYKqMPUSTyNOps9FQggylISULN2lH24Hv5Wm/LJjU8qXsnH0cTyu+DudanCp1EUjSHukqIGXCuzKrmA9tq2LbROG0VMG6ywZlI4foD66kUbuCwJJvQ4IzODOKbtXbgb2rx8BLKqQSgRnBv6bwzDdiqV2KxI70TrAm+3KU9yIrEMNXTohqsTX5QdrYDThgNZoW/wVsbDHFhqcx70B+PjkZDOY2m56tueNBih7VKkEMpzoiuQkOBrsZkicpG9tTmTDHKHRVkiqMomNfe+ua819SrOIcHbz0fpyseYx4c5RipIcjqI8goAB+T9adX/ITs6X49vjX2+VI7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AOgSYKIhH8oYHWArfVbW+nbSVHl6iHXacfMbPm+Fntw=;
 b=EUWAVf/x8vVhG+28dj488wmsQkmnJElIt2smT/1ORjY2cOfGgK5HZoCWk/P0j8os543cWc3Aa6Pys2WctLsCtXiWGLgKu2pC4K6aNtoV3fC50uo+nhMtnkQm0vWWe1YGngGMmPzDfh5EFbGcqlMOsBiBUmBF4+JV4XWE5rNF+x9S6Io/UDfQ3Y/6FXzm/lWzr5Lu3f7C6nVgiw+Qtp4HMRibl/2mnSjmKscSTpagIq+jpBA8wX+WGYzpwwhplAs2PU46pKclCC8oqwgkm0ebCupGzFJTlkk9yeX/ALI59ElxRnWqMkvdHXF6fz4oci1IkL0LZ1/IvuaTwZikkDM49A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AOgSYKIhH8oYHWArfVbW+nbSVHl6iHXacfMbPm+Fntw=;
 b=Ugx8USb2B9WR8rQAYx7wN6qBBry9z9cS0PmBg38hy0LuJ4budxDlbkmUY4NpGKPVCnJQwvPWUg8GKzTxfoXn0CKIki9nF4SKf3gZnevcER+8nb51yJhosls3L3ULErhBHx06GXkpeQsg8yxFPbEkm3pOPuDoua8weEBAhtgDLWAH2pSy3JxLcc0dbpe82ajrIUJFMPMjlPivYMtrAW9sCbtuOnbtuODh+U0mZLn1ePtOXYfd5xj+oDM5U+Xx51Bi4F/7VJ+vbKycSwV2vtjAU5/tnJz2os09Ukpf32ylYdEcJH9Vs2Fx7kVpwbN7D6+zc7Ehr8ieavnfe6bGY12a6Q==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by SA1PR02MB8696.namprd02.prod.outlook.com (2603:10b6:806:1f3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.26; Wed, 28 Aug
 2024 16:30:04 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%6]) with mapi id 15.20.7875.018; Wed, 28 Aug 2024
 16:30:04 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: =?iso-8859-2?Q?Petr_Tesa=F8=EDk?= <petr@tesarici.cz>, Robin Murphy
	<robin.murphy@arm.com>
CC: "kbusch@kernel.org" <kbusch@kernel.org>, "axboe@kernel.dk"
	<axboe@kernel.dk>, "sagi@grimberg.me" <sagi@grimberg.me>,
	"James.Bottomley@HansenPartnership.com"
	<James.Bottomley@HansenPartnership.com>, "martin.petersen@oracle.com"
	<martin.petersen@oracle.com>, "kys@microsoft.com" <kys@microsoft.com>,
	"haiyangz@microsoft.com" <haiyangz@microsoft.com>, "wei.liu@kernel.org"
	<wei.liu@kernel.org>, "decui@microsoft.com" <decui@microsoft.com>,
	"hch@lst.de" <hch@lst.de>, "m.szyprowski@samsung.com"
	<m.szyprowski@samsung.com>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>
Subject: RE: [RFC 0/7] Introduce swiotlb throttling
Thread-Topic: [RFC 0/7] Introduce swiotlb throttling
Thread-Index: AQHa9MJuV8zHlUlbFEOu4P5Y/AqjALI8msyAgAARKQCAADFrgA==
Date: Wed, 28 Aug 2024 16:30:04 +0000
Message-ID:
 <SN6PR02MB4157F23504BEB951BB19CE9BD4952@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20240822183718.1234-1-mhklinux@outlook.com>
	<efc1eafc-dba4-4991-9f9a-58ceca1d9a35@arm.com>
 <20240828150356.46d3d3dc@mordecai.tesarici.cz>
In-Reply-To: <20240828150356.46d3d3dc@mordecai.tesarici.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tmn: [efJSXScSU6YLrnokPeb+gJCtn0x8Vq8h]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|SA1PR02MB8696:EE_
x-ms-office365-filtering-correlation-id: c43f2dba-419a-4c9b-9187-08dcc77eabd0
x-microsoft-antispam:
 BCL:0;ARA:14566002|15080799006|461199028|8060799006|19110799003|440099028|102099032|3412199025;
x-microsoft-antispam-message-info:
 bo3YNMA7DUWFK6LONNCSUevtZeNEOdxRuTI40Sfibe7NacO4yiKd6K4/gH+isfmyAkj8gSvt1zeO8A823FCPDdLXyC6QN4VM2ytmfl51pSFCIYYehFwAwwqWBFJ7tH2S5TSBuFZV06+GHhtnxZu3j5Mifzybh8U9UYQm1NVulv97QUl9o+11Q2QOkhXvdJ0YHVKhMlNvcvuO28O0NfRNbwzllRlSf7XNl80wkWoHR/RrZBJps1kBTaCOXfgDqI9p/LGZJ09iPlw9GE+2ExXdMLVQSRq38LAltUG0X1cI3sh/rbyGplQY8YMsqQSQd24LYjaOSj50vP7f35Hf4rZWqzDFcxjobdfax6IUzVSj9iEVI1rDbjpDwoC/S8Pei4RA7faOgrYuB0VTpYPvv633Jbidis4uDbTGWYSWVbRzf9lALkLyw7YGgpyurizwvsfF/UDYHqB5Cis2SfcJb2XzWld3Vd561H/23c4jc8i78WtkcrWH1SFuCclV5qADIrV/SsAULcciyHunE1fV9OeRkGSDgU7bgSt0pH9QnBoj169at0lNtJQd+ExHembZD6gFwa6Czgc93skMfAVyQFtHzgaQQndhprzfj63evjYbgMZ/tAWFshchc+Bvc3QxUOGSIetXLZQ3U6l+dwVTbbZz5jQ95W3nGKO8k4Bl/ht3oYMrJKzGjG3Lm/2BsmhcEE/w
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-2?Q?keWlc+cPxV1QX3VWYjxWB3KNfWrNzgU9s1QtnXRoJHASd+pm2EHEonRxQC?=
 =?iso-8859-2?Q?+mVL3+DhoohxjcFeEZdfOXxrqNgXIqNbpiEsDqIAwnwxxjtttz17RRfDAc?=
 =?iso-8859-2?Q?UpsRJjSxsVec3JPcpopog5SMmQw8VPCykcfn23Fr3pemBhH28TSsS5rlT9?=
 =?iso-8859-2?Q?aekJ/LEEJ2os0S6WV4+sRq0f7SavwbhMmAIzXxbPhZVfMItvMsEKjE7L+f?=
 =?iso-8859-2?Q?exbnsHAT3tu20jME7DpAv5nJ3pDb4CDFu+e3j43obba7xsDM2g1mLPI0xO?=
 =?iso-8859-2?Q?aSSZArMu3CgQlMOO7qMN3tQkF/0h2G+zSVHKrnbtlQlk3ZqHih5l3+OXwi?=
 =?iso-8859-2?Q?MUHn0vjTJXulx9n6Z4k4McZAksX8uAAE2AXKOh603nvUyBvjMSLI7cf7pv?=
 =?iso-8859-2?Q?E93s+UjrHWw82ZE60iGebGtoUJNDxD6l17h84tEt5VkDNYbFHf+ueRs4mn?=
 =?iso-8859-2?Q?54Mtgn9XsWWPtET0L8Y7ZUfY/RERiBV0erHfYF9IbYGc9oir+8Xrzr6ATS?=
 =?iso-8859-2?Q?XGkLb7qtHDkzsfB6EuCKCvmzAyI1ljVrnvoVeJKW7EKgVqKYFh7Vo3g0RL?=
 =?iso-8859-2?Q?JrnEwtJPapUWVcHB5G5fY8qpvByrYmpNBkemBC+t57d3xHn0FllWIbGinM?=
 =?iso-8859-2?Q?tm/+qYuaLifq+vf0JFLS9ThGXa+d07nk5gEu/LDMin+ee07K/lp3+GLwIz?=
 =?iso-8859-2?Q?JhAjBYl6UynvrHmHqJTw42ZpYXJ1ogc9Elew4k22Y6au7xMp1F4ROSzQ9E?=
 =?iso-8859-2?Q?pk0Ybu5+1gsGiuyslqHi4ZZC+esa6zZxTyeKvM2zfTsL1wD13nqsf5T0BR?=
 =?iso-8859-2?Q?dCFd/taXMozU+DQab/PfH2E2BNbFPE+S7zomIxN2ab6AW70GRUiTMbT2X5?=
 =?iso-8859-2?Q?4khkCT7j3vrjakPJu7RwNqpcu5bxREjqCbKkrKN/6J2mq4UccvQsPwgiIK?=
 =?iso-8859-2?Q?ZRHPNSAS9v9ZEjnhLo8tvFtJa6pS/2TzuazS9TFXFotb1Zd0lZQ8hDxrLB?=
 =?iso-8859-2?Q?qWXf6XERKrlqctcP+f4ztqXfhga8AJjyJxzX2vbfeHjzzrmgvTR4IraOJN?=
 =?iso-8859-2?Q?p6q/gKw5h+LJeusWZn944yYeFOLK6PDwIbrutpvIy5QcTbPUK0i6EM86zm?=
 =?iso-8859-2?Q?Me74vCif+w+iYoo4l0N8QJEzXjbRKI5ptY2LMvj9Eb7b/M+n02DClYKMYr?=
 =?iso-8859-2?Q?Lfp8AKm8XeO9RLJyoctFkiJ2hXRTNf5g1IWiEKXsufk/AA6vLM01DWhckG?=
 =?iso-8859-2?Q?+RYLKUz2+G1/lkaar7LO857UWvY0ye7R4dfn4K+PE=3D?=
Content-Type: text/plain; charset="iso-8859-2"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c43f2dba-419a-4c9b-9187-08dcc77eabd0
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2024 16:30:04.1921
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR02MB8696

From: Petr Tesa=F8=EDk <petr@tesarici.cz> Sent: Wednesday, August 28, 2024 =
6:04 AM
>=20
> On Wed, 28 Aug 2024 13:02:31 +0100
> Robin Murphy <robin.murphy@arm.com> wrote:
>=20
> > On 2024-08-22 7:37 pm, mhkelley58@gmail.com wrote:
> > > From: Michael Kelley <mhklinux@outlook.com>
> > >
> > > Background
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > Linux device drivers may make DMA map/unmap calls in contexts that
> > > cannot block, such as in an interrupt handler. Consequently, when a
> > > DMA map call must use a bounce buffer, the allocation of swiotlb
> > > memory must always succeed immediately. If swiotlb memory is
> > > exhausted, the DMA map call cannot wait for memory to be released. Th=
e
> > > call fails, which usually results in an I/O error.
> > >
> > > Bounce buffers are usually used infrequently for a few corner cases,
> > > so the default swiotlb memory allocation of 64 MiB is more than
> > > sufficient to avoid running out and causing errors. However, recently
> > > introduced Confidential Computing (CoCo) VMs must use bounce buffers
> > > for all DMA I/O because the VM's memory is encrypted. In CoCo VMs
> > > a new heuristic allocates ~6% of the VM's memory, up to 1 GiB, for
> > > swiotlb memory. This large allocation reduces the likelihood of a
> > > spike in usage causing DMA map failures. Unfortunately for most
> > > workloads, this insurance against spikes comes at the cost of
> > > potentially "wasting" hundreds of MiB's of the VM's memory, as swiotl=
b
> > > memory can't be used for other purposes.
> > >
> > > Approach
> > > =3D=3D=3D=3D=3D=3D=3D=3D
> > > The goal is to significantly reduce the amount of memory reserved as
> > > swiotlb memory in CoCo VMs, while not unduly increasing the risk of
> > > DMA map failures due to memory exhaustion.
> >
> > Isn't that fundamentally the same thing that SWIOTLB_DYNAMIC was alread=
y
> > meant to address? Of course the implementation of that is still young
> > and has plenty of scope to be made more effective, and some of the idea=
s
> > here could very much help with that, but I'm struggling a little to see
> > what's really beneficial about having a completely disjoint mechanism
> > for sitting around doing nothing in the precise circumstances where it
> > would seem most possible to allocate a transient buffer and get on with=
 it.
>=20
> This question can be probably best answered by Michael, but let me give
> my understanding of the differences. First the similarity: Yes, one
> of the key new concepts is that swiotlb allocation may block, and I
> introduced a similar attribute in one of my dynamic SWIOTLB patches; it
> was later dropped, but dynamic SWIOTLB would still benefit from it.
>=20
> More importantly, dynamic SWIOTLB may deplete memory following an I/O
> spike. I do have some ideas how memory could be returned back to the
> allocator, but the code is not ready (unlike this patch series).
> Moreover, it may still be a better idea to throttle the devices
> instead, because returning DMA'able memory is not always cheap. In a
> CoCo VM, this memory must be re-encrypted, and that requires a
> hypercall that I'm told is expensive.
>=20
> In short, IIUC it is faster in a CoCo VM to delay some requests a bit
> than to grow the swiotlb.
>=20
> Michael, please add your insights.
>=20
> Petr T
>=20

The other limitation of SWIOTLB_DYNAMIC is that growing swiotlb
memory requires large chunks of physically contiguous memory,
which may be impossible to get after a system has been running a
while. With a major rework of swiotlb memory allocation code, it might
be possible to get by with a piecewise assembly of smaller contiguous
memory chunks, but getting many smaller chunks could also be
challenging.

Growing swiotlb memory also must be done as a background async
operation if the DMA map operation can't block. So transient buffers
are needed, which must be encrypted and decrypted on every round
trip in a CoCo VM. The transient buffer memory comes from the
atomic pool, which typically isn't that large and could itself become
exhausted. So we're somewhat playing whack-a-mole on the memory
allocation problem.

We discussed the limitations of SWIOTLB_DYNAMIC in large CoCo VMs
at the time SWIOTLB_DYNAMIC was being developed, and I think there
was general agreement that throttling would be better for the CoCo
VM scenario.

Broadly, throttling DMA map requests seems like a fundamentally more
robust approach than growing swiotlb memory. And starting down
the path of allowing designated DMA map requests to block might have
broader benefits as well, perhaps on the IOMMU path.

These points are all arguable, and your point about having two somewhat
overlapping mechanisms is valid. Between the two, my personal viewpoint
is that throttling is the better approach, but I'm probably biased by my
background in the CoCo VM world. Petr and others may see the tradeoffs
differently.

Michael

