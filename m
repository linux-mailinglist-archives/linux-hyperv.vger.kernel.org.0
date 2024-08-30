Return-Path: <linux-hyperv+bounces-2919-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F38C0965604
	for <lists+linux-hyperv@lfdr.de>; Fri, 30 Aug 2024 05:58:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D1131F23F66
	for <lists+linux-hyperv@lfdr.de>; Fri, 30 Aug 2024 03:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA1FE136E3F;
	Fri, 30 Aug 2024 03:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="kKGeTYzl"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10olkn2029.outbound.protection.outlook.com [40.92.40.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A883FF1;
	Fri, 30 Aug 2024 03:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.40.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724990302; cv=fail; b=eFTBo3i/Ljr7p9J1vNx7uIfA6Z5nXYqSwqIoDSMCtZSrI6SPvzHDpE/KORKNDlQqhRCdByHA2i9aYO32UkykwXqqrJZntLzFSXebIseDG+/kWmvZyxtzEqcVAvcpVX5M3+6tqvVGMdJb0QhTsdoZhcfPoJrlaYJUWhvl0fbUoHU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724990302; c=relaxed/simple;
	bh=jPcciqwgxZdPPl5o7GuGG+IYM/LeORIt5qI+6yU+8GA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=p+SoG+DUhv0b5x377w1Ek9eUlnZdudhn6JXVCdWO62QhTkk/sW6ZuWoQnWHoYf9AtVUZFRa9BoUNBUou6od9S0tbQo8HLux5AhN53sfcRqhQ+g8Ph/LcRm3AUnrl0BkzGzscOtaOrAEVQSsr1r8YPf5DovBLwxguaMDSww/lgrY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=kKGeTYzl; arc=fail smtp.client-ip=40.92.40.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lpTMbQ+yLSQKd35VAZ4ztd6UTqs+EpvRrLzYc48KWjz8ZWwdpGhG5IX2IL1QG5DJstQ5DmGF0dgHFUlSVxxTEpH6Qll+vHrCAJtMaAqJ/B6uZBymK9UiLkeEZh+/G8TLsgbRj4bTT1afqBIMFwefS5RAJ3z2Q6DKPdriuzSRsnBh7rDhFVBT6+EgG02jKZJ/iPmJSyLmEZNqYvdEQCfC/+8W5HS4c3pRl91+MXbj0oEshf2vaJz7/lt7KoCtBu3xfZ77FM7LqdobSfvuZkNgq8WT0q8GJETnuJyEl30PB+rWk50kfg6S+qtFMlHJrHfaDFCsgeEW6c4mDclADn4e6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jPcciqwgxZdPPl5o7GuGG+IYM/LeORIt5qI+6yU+8GA=;
 b=DBFqZB4arMhqG55vBpsDbGMMS8lT85aLKyMiOL6hebArZBIsDLKNQnliaTVeNwWbeMLFHZ45E8a5ILMAqhYjRMbqbzZ5LIUUEcPyCuUjLEz+hWAJZCFknPnGy4SFWFmp0HXBkQg2QikTYz7W07ZLKMADa/Fq/xsidtrK0DQk/2h/Z3Mkdwh0Z1qzSeasNKPHU+8IC1y/5WtrzL5faitr3qzGR9kMVX6fFFJzFlf/m+rXXVj3kcUwuuZDSMseauXhxDnp55Yr1tbSH7MGCqROrxBoQZZYypnQzP4/IjUEyq7/PcfC06Wfpg3+QFrAqEPdozDWMKPfmor1Rm6HSpuyWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jPcciqwgxZdPPl5o7GuGG+IYM/LeORIt5qI+6yU+8GA=;
 b=kKGeTYzl5ABk0+auMYYbFZxq8u7RCp4I5RnoakfTAmrzcknSBaM/5keotJg+jlttY6fPdsgKqFTlaukQUv1ta1Jj+h4jiwgi598CFg0xImrBp5iIEudSsSYsicNKnk+d5Iq4/51r24w7PpACD6v/LaKT/OmmiM+oAUTXGTz7IXLtEiekwd8p+Q3hLL8fGllxVpUrJyEg2TVOaVhwkPJkjnavxVLcCD48j3aQqrhyXBtiDmriL+FOQuabU+2TZvuxUEYt1vV8xDgmo13tpdxbPrK8jdHO13mw8MYfjdypl4RVRIM8ART7VEbuMkhgirgYO+Xuf9yGe3FjBKHmPvNqvQ==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by PH0PR02MB9308.namprd02.prod.outlook.com (2603:10b6:510:288::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.28; Fri, 30 Aug
 2024 03:58:16 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%6]) with mapi id 15.20.7875.018; Fri, 30 Aug 2024
 03:58:16 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Robin Murphy <robin.murphy@arm.com>, =?iso-8859-2?Q?Petr_Tesa=F8=EDk?=
	<petr@tesarici.cz>
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
Thread-Index: AQHa9MJuV8zHlUlbFEOu4P5Y/AqjALI8msyAgAARKQCAAHGNgIACBi6w
Date: Fri, 30 Aug 2024 03:58:16 +0000
Message-ID:
 <SN6PR02MB4157DA9719D1F6EEC4F00E57D4972@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20240822183718.1234-1-mhklinux@outlook.com>
 <efc1eafc-dba4-4991-9f9a-58ceca1d9a35@arm.com>
 <20240828150356.46d3d3dc@mordecai.tesarici.cz>
 <bb7dd4ca-948f-4af7-b2ac-3ca02e82699f@arm.com>
In-Reply-To: <bb7dd4ca-948f-4af7-b2ac-3ca02e82699f@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tmn: [XnpFdCy9JpXFM4vaUkM7MP1hn62bVrVO]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|PH0PR02MB9308:EE_
x-ms-office365-filtering-correlation-id: e77092f7-9564-4a2a-469f-08dcc8a7fa3f
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199028|8060799006|15080799006|19110799003|56899033|440099028|3412199025|102099032;
x-microsoft-antispam-message-info:
 aPivHA7xj6RKuxZVK/mXErjbvwleqZnT+UzQL9I+rUtWExOCWwEJ0NA3u9kLmednAD2ECOHEhc4w7JlOUbxfnQB9Stk/YErHwEFYQu3skUgPcoJDmDd7TS2WJFqNoTFEStAibERrtDwdUFRO++PVm19c3KWxr/vOhpwDrXN3PXEL7ksPmX4GAEyWDZXZ4md/4BKsf7b8NLsO+ABx/Zm7QYBLcbgMi7eyrYZtlKMmwTldVEopK1aAnxgJUMmwOFMo7IAyscc6u3jX+swF2iVsa+9CUQVlg+zh9GmlZA4LKU0MYyltx6+3+vONyTd/CXKSP+hWjdlzxCxCTbLnvJVgiVwDOgHdOPrbjr7pfoPECI1qHxDZDKKJzYRPhPQ/Tj/UahSNOm4WrDBeY4mFv4G/vY3EiKirRM2hoi2WnXUUuTyu+bz9Vbea9Hv0JXz6Ox34T5si5B3UW0QD1sQKrkbQoBgL6xuVi/H4j/+L8X5vEbOqwyp/z4ollTLVgXDwoqAl3j8oXsl0/J5zYFfGnpEakgVrM7t09wGjhhhH00Afc+wv19giutEefC7dV7JBS8IDwsXkv/28cia4HvihusJsIGcItD/JsnClTnIjeXP4FKJz/GnfdxygWQMTXX3NBlw29j7e8KVepM4VPklyjA0tpQ9EjkZZqs24Q6ogL73yxh7SmNHEADqtO3WjcHKAiYzI
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-2?Q?KACHvPkVyfmJYRzbfqDqKxJyqYh8AYKBa/PvNsUQC9FocSTXxZLxTBmKQI?=
 =?iso-8859-2?Q?a22fLRwXNONVSkTEKIdTWU/cFLcXtZdp2H/SUzG6reGnfPvU4XFa5lvR4y?=
 =?iso-8859-2?Q?TQH9oVEcS8ov0gb8VqOAYNwn8BUD0A1U/YHDiA3yrKn71kPgFbwROOfbYu?=
 =?iso-8859-2?Q?nyLRXRoyjvnJk/WyriLF/qOjYhA1dgNkEU7CgtyNEAqZr+Ue24rYwEYjaP?=
 =?iso-8859-2?Q?th2IhTbTKcdWDr8mJz3+elkEEMGnafbWYugdK+uIEZShr6zqtTGxMbau0C?=
 =?iso-8859-2?Q?2kvvMux3qkf7LBxuJ4qbBus5X3tUEPeciK2JQSJCsWmc0YS1ltpF7Lam2e?=
 =?iso-8859-2?Q?dStb+xX4n5FK4CvFTAxexo39zn48Dmq5zpbDzq7FaKw22ecE35ZOgse93w?=
 =?iso-8859-2?Q?ncjr4jq40Vp0eH4vIhk3EDQDmX6O4OXEkDfrLHPbOVDktoYlpP8bIjFeGR?=
 =?iso-8859-2?Q?EbAZ+pqYAdo1KFC4a4DBHkY7qaGjgA++A/N9XUp08eDnUsRSXi2hTh/Pw6?=
 =?iso-8859-2?Q?GoY2+3Z/9yJaCDB6QhjkpXPQ3w8nXxfjY7eAop5V5EgpAGZQSgUSomxmsx?=
 =?iso-8859-2?Q?3vVQUCUjjX/I7XpIAofy/3a/fJI75lTg83z1aO3GrUlruo6yqy2CzOiQID?=
 =?iso-8859-2?Q?zcnirkNLbtvQGobV9ZP4unlvIHXE/fNPmvJAYeFzlBOW5Aj7NOZer5/HuD?=
 =?iso-8859-2?Q?gia2Fuf3vBY/tPSyjeI+zMTLWXTyFdnTqtdt4Ei8Gi46Rlj1Q/xG4kPcvP?=
 =?iso-8859-2?Q?wzT46fWA3RMiI0CdaY/8LPqjroBGncboLtJTJWNOuky0Bp49SWwnf4CJJ3?=
 =?iso-8859-2?Q?CvxZgv48HsOQX26VtM5sXJ2A3lneEkFsEzSccn1/rwFsSP0Bs3ZlYE9Ge+?=
 =?iso-8859-2?Q?yFYgZRP7xIsOUZz3xsy/2MhCllPJl/TER8/0dzxkdv7arfxOre5p/MI2U1?=
 =?iso-8859-2?Q?yH4Ogx1T3Xobg7sLccXGg1M4aEJafvNZuUtgUspFXeNpbAp8Ku5tZJycQ5?=
 =?iso-8859-2?Q?KoEo2ELysfutcBM9qZdcCz4pWJmmUkib+5prPQF7h5sJ+q8DtzI7CDaaM0?=
 =?iso-8859-2?Q?F4/WEd/eG9UdCDGb3GBeTFsr9FMPryHnSNzRv10XHbRsV7msK69226N4zt?=
 =?iso-8859-2?Q?/r2uRGknQMRHsfKJhEIkQlVbXW5i0LANhRp5qxpZclc1mSxLmq0Z8MAY/V?=
 =?iso-8859-2?Q?vpnY35Vr5kFGhOCU8smBPPqrdLE4H69RRLvhO+IHgz5WsOTQJI+MRNh1RU?=
 =?iso-8859-2?Q?eShmC3xGgNIaspaG2blbPW3RhYNB7SMlCT9PIVgmQ=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e77092f7-9564-4a2a-469f-08dcc8a7fa3f
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2024 03:58:16.2933
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB9308

From: Robin Murphy <robin.murphy@arm.com> Sent: Wednesday, August 28, 2024 =
12:50 PM
>=20
> On 2024-08-28 2:03 pm, Petr Tesa=F8=EDk wrote:
> > On Wed, 28 Aug 2024 13:02:31 +0100
> > Robin Murphy <robin.murphy@arm.com> wrote:
> >
> >> On 2024-08-22 7:37 pm, mhkelley58@gmail.com wrote:
> >>> From: Michael Kelley <mhklinux@outlook.com>
> >>>
> >>> Background
> >>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>> Linux device drivers may make DMA map/unmap calls in contexts that
> >>> cannot block, such as in an interrupt handler. Consequently, when a
> >>> DMA map call must use a bounce buffer, the allocation of swiotlb
> >>> memory must always succeed immediately. If swiotlb memory is
> >>> exhausted, the DMA map call cannot wait for memory to be released. Th=
e
> >>> call fails, which usually results in an I/O error.
> >>>
> >>> Bounce buffers are usually used infrequently for a few corner cases,
> >>> so the default swiotlb memory allocation of 64 MiB is more than
> >>> sufficient to avoid running out and causing errors. However, recently
> >>> introduced Confidential Computing (CoCo) VMs must use bounce buffers
> >>> for all DMA I/O because the VM's memory is encrypted. In CoCo VMs
> >>> a new heuristic allocates ~6% of the VM's memory, up to 1 GiB, for
> >>> swiotlb memory. This large allocation reduces the likelihood of a
> >>> spike in usage causing DMA map failures. Unfortunately for most
> >>> workloads, this insurance against spikes comes at the cost of
> >>> potentially "wasting" hundreds of MiB's of the VM's memory, as swiotl=
b
> >>> memory can't be used for other purposes.
> >>>
> >>> Approach
> >>> =3D=3D=3D=3D=3D=3D=3D=3D
> >>> The goal is to significantly reduce the amount of memory reserved as
> >>> swiotlb memory in CoCo VMs, while not unduly increasing the risk of
> >>> DMA map failures due to memory exhaustion.
> >>
> >> Isn't that fundamentally the same thing that SWIOTLB_DYNAMIC was alrea=
dy
> >> meant to address? Of course the implementation of that is still young
> >> and has plenty of scope to be made more effective, and some of the ide=
as
> >> here could very much help with that, but I'm struggling a little to se=
e
> >> what's really beneficial about having a completely disjoint mechanism
> >> for sitting around doing nothing in the precise circumstances where it
> >> would seem most possible to allocate a transient buffer and get on wit=
h it.
> >
> > This question can be probably best answered by Michael, but let me give
> > my understanding of the differences. First the similarity: Yes, one
> > of the key new concepts is that swiotlb allocation may block, and I
> > introduced a similar attribute in one of my dynamic SWIOTLB patches; it
> > was later dropped, but dynamic SWIOTLB would still benefit from it.
> >
> > More importantly, dynamic SWIOTLB may deplete memory following an I/O
> > spike. I do have some ideas how memory could be returned back to the
> > allocator, but the code is not ready (unlike this patch series).
> > Moreover, it may still be a better idea to throttle the devices
> > instead, because returning DMA'able memory is not always cheap. In a
> > CoCo VM, this memory must be re-encrypted, and that requires a
> > hypercall that I'm told is expensive.
>=20
> Sure, making a hypercall in order to progress is expensive relative to
> being able to progress without doing that, but waiting on a lock for an
> unbounded time in the hope that other drivers might release their DMA
> mappings soon represents a potentially unbounded expense, since it
> doesn't even carry any promise of progress at all=20

FWIW, the implementation in this patch set guarantees forward
progress for throttled requests as long as drivers that use MAY_BLOCK
are well-behaved.

> - oops userspace just
> filled up SWIOTLB with a misguided dma-buf import and now the OS has
> livelocked on stalled I/O threads fighting to retry :(
>=20
> As soon as we start tracking thresholds etc. then that should equally
> put us in the position to be able to manage the lifecycle of both
> dynamic and transient pools more effectively - larger allocations which
> can be reused by multiple mappings until the I/O load drops again could
> amortise that initial cost quite a bit.

I'm not understanding what you envision here. Could you elaborate?
With the current implementation of SWIOTLB_DYNAMIC, dynamic
pools are already allocated with size MAX_PAGE_ORDER (or smaller
if that size isn't available). That size really isn't big enough in CoCo
VMs with more than 16 vCPUs since we want to split the allocation
into per-CPU areas. To fix this, we would need to support swiotlb
pools that are stitched together from multiple contiguous physical
memory ranges. That probably could be done, but I don't see how
it's related to thresholds.

>=20
> Furthermore I'm not entirely convinced that the rationale for throttling
> being beneficial is even all that sound. Serialising requests doesn't
> make them somehow use less memory, it just makes them use it...
> serially. If a single CPU is capable of queueing enough requests at once
> to fill the SWIOTLB, this is going to do absolutely nothing; if two CPUs
> are capable of queueing enough requests together to fill the SWIOTLB,
> making them take slightly longer to do so doesn't inherently mean
> anything more than reaching the same outcome more slowly.

I don't get your point. My intent with throttling is that it caps the
system-wide high-water mark for swiotlb memory usage, without
causing I/O errors due to DMA map failures. Without
SWIOTLB_DYNAMIC, the original boot-time allocation size is the limit
for swiotlb memory usage, and DMA map fails if the system-wide
high-water mark tries to rise above that limit. With SWIOTLB_DYNAMIC,
the current code continues to allocate additional system memory and
turn it into swiotlb memory, with no limit. There probably *should*
be a limit, even for SWIOTLB_DYNAMIC.
=20
I've run "fio" loads with and without throttling as implemented in this
patch set. Without SWIOTLB_DYNAMIC and no throttling, it's pretty
easy to reach the limit and get I/O errors due to DMA map failure. With
throttling and the same "fio" load, the usage high-water mark stays
near the throttling threshold, with no I/O errors. The limit should be
set large enough for a workload to operate below the throttling
threshold. But if the threshold is exceeded, throttling should avoid a
big failure due to DMA map failures.

My mental model here is somewhat like blk-mq tags. There's a fixed
number allocated with the storage controller. Block I/O requests must
get a tag, and if one isn't available, the requesting thread is pended
until one becomes available. The fixed number of tags is the limit, but
the requestor doesn't get an error if a tag isn't available -- it just
waits. The fixed number of tags necessarily imposes a kind of
resource limit on block I/O requests, rather than just always allocating
an additional tag if there's a request that can't get an existing tag. I th=
ink
the same model makes sense for swiotlb memory when the device
driver can support it.

> At worst, if a
> thread is blocked from polling for completion and releasing a bunch of
> mappings of already-finished descriptors because it's stuck on an unfair
> lock trying to get one last one submitted, then throttling has actively
> harmed the situation.

OK, yes, I can understand there might be an issue with a driver (like
NVMe) that supports polling. I'll look at that more closely and see
if there is.

>=20
> AFAICS this is dependent on rather particular assumptions of driver
> behaviour in terms of DMA mapping patterns and interrupts, plus the
> overall I/O workload shape, and it's not clear to me how well that
> really generalises.
>=20
> > In short, IIUC it is faster in a CoCo VM to delay some requests a bit
> > than to grow the swiotlb.
>=20
> I'm not necessarily disputing that for the cases where the assumptions
> do hold, it's still more a question of why those two things should be
> separate and largely incompatible (I've only skimmed the patches here,
> but my impression is that it doesn't look like they'd play all that
> nicely together if both enabled).

As I've mulled over your comments the past day, I'm not sure the two
things really are incompatible or even overlapping. To me it seems like
SWIOTLB_DYNAMIC is about whether the swiotlb memory is pre-allocated
at boot time, or allocated as needed. But SWIOTLB_DYNAMIC currently
doesn't have a limit to how much it will allocate, and it probably should.
(Though SWIOTLB_DYNAMIC has a limit imposed upon it if there's isn't
enough contiguous physical memory to grow the swiotlb pool.) Given a
limit, both the pre-allocate case and allocate-as-needed case have the
same question about what to do when the limit is reached. In both cases,
we're generally forced to set the limit pretty high, because DMA map
failures occur if you broach the limit. Throttling is about dealing with
the limit in a better way when permitted by the driver. That in turn
allows setting a tighter limit and not having to overprovision the
swiotlb memory.

> To me it would make far more sense for
> this to be a tuneable policy of a more holistic SWIOTLB_DYNAMIC itself,
> i.e. blockable calls can opportunistically wait for free space up to a
> well-defined timeout, but then also fall back to synchronously
> allocating a new pool in order to assure a definite outcome of success
> or system-is-dying-level failure.

Yes, I can see value in the kind of interaction you describe before any
limits are approached. But to me the primary question is dealing better
with the limit.

Michael=20

>=20
> Thanks,
> Robin.

