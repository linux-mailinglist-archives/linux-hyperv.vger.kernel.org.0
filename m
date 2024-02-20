Return-Path: <linux-hyperv+bounces-1581-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BA1A85C37D
	for <lists+linux-hyperv@lfdr.de>; Tue, 20 Feb 2024 19:16:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E7991C2090F
	for <lists+linux-hyperv@lfdr.de>; Tue, 20 Feb 2024 18:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE8827764A;
	Tue, 20 Feb 2024 18:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="DwltjPfA"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10olkn2060.outbound.protection.outlook.com [40.92.41.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF65762EC;
	Tue, 20 Feb 2024 18:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.41.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708452957; cv=fail; b=IdDGWIaCKJa0CO8JqffoAQ+GzDBtwjNz2oDw2LWzvHMZjOgrhqoBjkaJWGRbGiCUdSGr2sBXaI/h03/QQ9etAqVBG1WbBvTxGP3jhEJq0pIWeubZ5QA2AG194drz8piy1jEhj11l8qWS1LkMJFjLisCXeFhZjFAdl/0N5bmM8xs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708452957; c=relaxed/simple;
	bh=0O9/e+MtHSH1azjh10/K9lxu2fjkEfst4wjFacfPkDc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Vak6NEx99a67k9VLGhMY9DLtphj1IXTa/iAIXSVURi0ayqrryKiPZUeh1m2omzD8+yvdAt3O3RXK8EzsHCq1bVpwupat135udRWZyto6GCnWAp1yYbcfAo00dfUBaWh55lz4uahx5XEFwoBraaTjRhoQdQVgdnysN5SCgAblSjU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=DwltjPfA; arc=fail smtp.client-ip=40.92.41.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A803cdgNAmCq0Mvi0ZkIRfiEDUxO7PCK4/3QLf3yKMW47knXhdIIhniUsOHBqc5l86hnz4q1wc+hnAavy4+wiPBjWji4sdssc0nzNWBthsuD4ANrvybtsNylVUfa7TyYTaHng6Cz03sCuCYPb3zdx3VtjKB8WoKwf4howpgvGQLyNnE3QrGvFcrNkUMkYCvWlOHLbNed1aUZUCuuLegRHV4rSuoA+wYBajxICN548CAWBvWwLWERAUH92Xcf3zK96kkAjqeTvEA2B30J22tQ6x2NKAEt49jk8WSHj13qgozUsFna4ibUrw0iBXLjs5wQEskU5wglOrp6MT+smve9iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VWy486X8Q4Fi7xosa0Ws16Ne6l8DRaJm2Mei90RFiig=;
 b=e+V3qDkuruAb/oAn+S6DeK2Ro3rEvPGt06yelBJ5kIbBDhQJrnqKfdqidbEz00X0FgywiwtLBMzd1eud85ejxmh7u0NrtiuFmOOVTixUtllEPb3yKrjTzGcj/BQ3HGpsv6aijmZpoWe9UjdTQLkAtvV9UQmTactA+XBt+YyfIiuqYHbb9hbbYGlDhQaHT8Al4+RQro776nW4gAjQT8OY971O6UzU2BrsZK4kE/+64Ly7BFA43zSDpTMu3Jst1z016cad3OvrgaGQgzskmi5gFrjyk9txYSLFZZKxKZ4LtUFTFpc1AsTLkJTJmtZfXS/1SWyHfv+Un64QJmD59zPurA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VWy486X8Q4Fi7xosa0Ws16Ne6l8DRaJm2Mei90RFiig=;
 b=DwltjPfABaxr3qshkZubJwrBsOUNuDlm+pxAgHJzORzwB45nZTqS0kcLPwyFjNwmbWaKlGa2J51FaCH0MucbXi706RUbmlPHNPdLrNgao3xLH/jPI2XLDR/EMFh6Is9Moni1MfjzZnQTX3JLF5E91QNXtaNKvOxcC3Cyf1lz3aXWSwn2Ix0NvCLPtzIuaaMYI1GdSxCVFkDXEbt6Iq6ipojZ1R82JnwrMFZw+ax2CAIt+acL7t1G0Wz2BGqFZ1CfrD8fFJtsp6kiOPY2JTORq49MWJIoAjvHCKFmG5q82mWA6GUMo99+M1+Dx0MUopCtMgk81DdzrWAYpRi32FkWBw==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by SJ2PR02MB10121.namprd02.prod.outlook.com (2603:10b6:a03:558::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39; Tue, 20 Feb
 2024 18:15:53 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::67a9:f3c0:f57b:86dd]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::67a9:f3c0:f57b:86dd%5]) with mapi id 15.20.7292.036; Tue, 20 Feb 2024
 18:15:53 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Boqun Feng <boqun.feng@gmail.com>, Saurabh Singh Sengar
	<ssengar@linux.microsoft.com>
CC: "haiyangz@microsoft.com" <haiyangz@microsoft.com>, "wei.liu@kernel.org"
	<wei.liu@kernel.org>, "decui@microsoft.com" <decui@microsoft.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: RE: [PATCH 1/1] Drivers: hv: vmbus: Calculate ring buffer size for
 more efficient use of memory
Thread-Topic: [PATCH 1/1] Drivers: hv: vmbus: Calculate ring buffer size for
 more efficient use of memory
Thread-Index: AQHaXkS5EPrFeM+bCUuIdPJ7ndDWZrESz/SAgAC4IYCAAAQbgA==
Date: Tue, 20 Feb 2024 18:15:52 +0000
Message-ID:
 <SN6PR02MB4157CF4A309971B21296D465D4502@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20240213061959.782110-1-mhklinux@outlook.com>
 <20240220063007.GA17584@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <ZdThZUUmGhY2shrX@boqun-archlinux>
In-Reply-To: <ZdThZUUmGhY2shrX@boqun-archlinux>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tmn: [BvSbcq3l4S6OPaaf6fYz/ZKSptrCQj0o]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|SJ2PR02MB10121:EE_
x-ms-office365-filtering-correlation-id: 58409dff-ba0b-49e1-aaff-08dc323ff98e
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 nDWEOs44dY7M5FMssyCv59/dyepj56p3qCSAoTx057T7vuYoS4HynOWJyMOda2CY5WL8epNVVcUzw8nX5D+QUhFibKm96gEmcHGetZrrQpxq/M6Pd4XokZyJMMDp/wr3E6cGJ5UnXgC7k/p+mCeAy5ExGWslxLcdck2qqXol/xjwObdNwx0fCvMtc/qr6rdDfNv/O511cxZMt1rFsPtRPuuYmVP+X6VUyu0TI06lWdXxm6h5taGDBWlXQR68LO1vYd5V/bBsStthITHCdLkd8dVOmw2yNsjxrWetRFHN9SZ+IbjaidIyqbxtSNB4FnE0jEs0LbMG9M7z0wqOLZQuHpOiHUw3k8OjTmJLcUTGfPN+012URTjPRvmq1hHD4fEF0TnROI3dmHjUugEI+6umbCrMvJcIPuRvWkCxm5VMP5hGk5w4ZC7k4VHhurP/i5oUgugaBy5gmXUJtyQU8ieEePPdlnyMQlamemRcNGJwQrpumWj0ZRxBDxjbKDfatyyEe9oshfRnvnXH+Vc6emk7FrMuxKe3i4d1mUsGCZ7VEdSpykMzC48i/M0h2QC18ybw
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?EuEWnoe3axsNIQpvJIRE2ryDyF3+nJmBJpXiqFHJaR/a6G3yYpAOiZ6Cw6Yy?=
 =?us-ascii?Q?g2QtVu6gqLTKXDxMO/yOgSBWEKs0BS2G0mL9t26gpcdrUaF5Q3ndJON8Mj1k?=
 =?us-ascii?Q?MqOBTWo3WBy3ceIXcwNj38uAl3tmoc4YQqa3C7AG1+2lOtnzFGH6InuDJ2mh?=
 =?us-ascii?Q?uG1L73KqodJ+fPf4XE7N/cRVO8WWG3d8SyshHE0kdPteuA5QRSsYYt21YQm5?=
 =?us-ascii?Q?6xTB8bD+xW8OAhlFQ8gErhs/pgd3vqLSc54Q48abqip/v4R/3GPV1ZfizTUp?=
 =?us-ascii?Q?ExrAVGQf2+uho50Pp5S61YHDgkGZzwDN8eQL1c7IabRiXpBuS5wZQr8RyCDo?=
 =?us-ascii?Q?QGT2K9OK2XnWV73cIJ6R5mXpanm4QGF91OgAr7hqt4fLdMmEy6IOpz3JBIIM?=
 =?us-ascii?Q?H78OsCviJ4wX/x4MsW0ndwZtsuEizCmVrpRlCXJLqQpLVgKn1qUTVRB46TPb?=
 =?us-ascii?Q?j+8MaXFYcqe7EpEzSl5uXwq5EQJSpi0J2lcc08o/WI1PwvtVwVTr71mXiDGh?=
 =?us-ascii?Q?Az1jp8PufpuZc5tFUmQDVSici0oT+hIx1UR5LX/IET1ZWoyp4JsOka9SKetr?=
 =?us-ascii?Q?xipblWYZ5yqrHZtJ0AJMBvzVyOQoXsR0P5QZQZeinsyPAjyEEGD+ksNXo8PI?=
 =?us-ascii?Q?CzzHcawfQALn9FK7dUFR2+0VkGFlLqtZRbIjGdcr1BuLijh0/7iREwRy48Fr?=
 =?us-ascii?Q?Q59H6GDrImdL8/QeVoCtgOqQGy6jydbhv3sT4uH0T6FKrp9ntUwficswZkUQ?=
 =?us-ascii?Q?1TQn5FU1GmKJ/tl6VI2pEjGTaebBLwbkBEQW6Q6orrAYGwuoPApVG+byzpJX?=
 =?us-ascii?Q?F7VTn6JHe+5rYboTQXFrYEt8GC4+5UDm81LjQCf+llhRe/J07fIMGEP9B9As?=
 =?us-ascii?Q?YtGxg/19pA+mJTzwxVWIdBsFG9S4KGsWHd3p4yQ2TqYWWvXBuZ0Gy9RKNfqF?=
 =?us-ascii?Q?JItPhypEDFxVvv/+SNjruZsnYmjeQBVA9PFMD06kBUUvQsH1mQkeaTeIWi/z?=
 =?us-ascii?Q?5ei6uUbsnDaQEHleFPyanTmLkyaXGlcB1WqR0fiACTdVgwiCBcFL60Yjsf0O?=
 =?us-ascii?Q?FR01krbqFTz5z06eX+XNgkS/HK2SGfZKLqXLltCHuNZ9GnZAcv+eWT3zHF8J?=
 =?us-ascii?Q?gHojZ4LtwUi8G/LS/cFlpQT6j5v7L8eZugkH5YiB/DIfq8tbsqFlw9uaNT/v?=
 =?us-ascii?Q?7JVO8XsoHgwPZx3wR24a3sLFOhN43JOLqk1dRg=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 58409dff-ba0b-49e1-aaff-08dc323ff98e
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2024 18:15:53.0454
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR02MB10121

From: Boqun Feng <boqun.feng@gmail.com> Sent: Tuesday, February 20, 2024 9:=
29 AM
>=20
> On Mon, Feb 19, 2024 at 10:30:07PM -0800, Saurabh Singh Sengar wrote:
> > On Mon, Feb 12, 2024 at 10:19:59PM -0800, mhkelley58@gmail.com wrote:
> > > From: Michael Kelley <mhklinux@outlook.com>
> > >
> > > The VMBUS_RING_SIZE macro adds space for a ring buffer header to the
> > > requested ring buffer size.  The header size is always 1 page, and so
> > > its size varies based on the PAGE_SIZE for which the kernel is built.
> > > If the requested ring buffer size is a large power-of-2 size and the =
header
> > > size is small, the resulting size is inefficient in its use of memory=
.
> > > For example, a 512 Kbyte ring buffer with a 4 Kbyte page size results=
 in
> > > a 516 Kbyte allocation, which is rounded to up 1 Mbyte by the memory
> > > allocator, and wastes 508 Kbytes of memory.
> > >
> > > In such situations, the exact size of the ring buffer isn't that impo=
rtant,
> > > and it's OK to allocate the 4 Kbyte header at the beginning of the 51=
2
> > > Kbytes, leaving the ring buffer itself with just 508 Kbytes. The memo=
ry
> > > allocation can be 512 Kbytes instead of 1 Mbyte and nothing is wasted=
.
> > >
> > > Update VMBUS_RING_SIZE to implement this approach for "large" ring bu=
ffer
> > > sizes.  "Large" is somewhat arbitrarily defined as 8 times the size o=
f
> > > the ring buffer header (which is of size PAGE_SIZE).  For example, fo=
r
> > > 4 Kbyte PAGE_SIZE, ring buffers of 32 Kbytes and larger use the first
> > > 4 Kbytes as the ring buffer header.  For 64 Kbyte PAGE_SIZE, ring buf=
fers
> > > of 512 Kbytes and larger use the first 64 Kbytes as the ring buffer
> > > header.  In both cases, smaller sizes add space for the header so
> > > the ring size isn't reduced too much by using part of the space for
> > > the header.  For example, with a 64 Kbyte page size, we don't want
> > > a 128 Kbyte ring buffer to be reduced to 64 Kbytes by allocating half
> > > of the space for the header.  In such a case, the memory allocation
> > > is less efficient, but it's the best that can be done.
> > >
> > > Fixes: c1135c7fd0e9 ("Drivers: hv: vmbus: Introduce types of GPADL")
> > > Signed-off-by: Michael Kelley <mhklinux@outlook.com>
> > > ---
> > >  include/linux/hyperv.h | 22 +++++++++++++++++++++-
> > >  1 file changed, 21 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
> > > index 2b00faf98017..6ef0557b4bff 100644
> > > --- a/include/linux/hyperv.h
> > > +++ b/include/linux/hyperv.h
> > > @@ -164,8 +164,28 @@ struct hv_ring_buffer {
> > >  	u8 buffer[];
> > >  } __packed;
> > >
> > > +
> > > +/*
> > > + * If the requested ring buffer size is at least 8 times the size of=
 the
> > > + * header, steal space from the ring buffer for the header. Otherwis=
e, add
> > > + * space for the header so that is doesn't take too much of the ring=
 buffer
> > > + * space.
> > > + *
> > > + * The factor of 8 is somewhat arbitrary. The goal is to prevent add=
ing a
> > > + * relatively small header (4 Kbytes on x86) to a large-ish power-of=
-2 ring
> > > + * buffer size (such as 128 Kbytes) and so end up making a nearly tw=
ice as
> > > + * large allocation that will be almost half wasted. As a contrastin=
g example,
> > > + * on ARM64 with 64 Kbyte page size, we don't want to take 64 Kbytes=
 for the
> > > + * header from a 128 Kbyte allocation, leaving only 64 Kbytes for th=
e ring.
> > > + * In this latter case, we must add 64 Kbytes for the header and not=
 worry
> > > + * about what's wasted.
> > > + */
> > > +#define VMBUS_HEADER_ADJ(payload_sz) \
> > > +	((payload_sz) >=3D  8 * sizeof(struct hv_ring_buffer) ? \
> > > +	0 : sizeof(struct hv_ring_buffer))
> > > +
> > >  /* Calculate the proper size of a ringbuffer, it must be page-aligne=
d */
> > > -#define VMBUS_RING_SIZE(payload_sz) PAGE_ALIGN(sizeof(struct hv_ring=
_buffer) + \
> > > +#define VMBUS_RING_SIZE(payload_sz) PAGE_ALIGN(VMBUS_HEADER_ADJ(payl=
oad_sz) + \
> > >  					       (payload_sz))
>=20
> I generally see the point of this patch, however, it changes the
> semantics of VMBUS_RING_SIZE() (similiar as Saurabh mentioned below),
> before VMBUS_RING_SIZE() will give you a ring buffer size which has at
> least "payload_sz" bytes, but after the change, you may not get "enough"
> bytes for the vmbus ring buffer.

Storvsc and netvsc were previously not using VMBUS_RING_SIZE(),
so space for the ring buffer header was already being "stolen" from
the specified ring size.  But if this new version of VMBUS_RING_SIZE()
still allows the ring buffer header space to be "stolen" from the
large-ish ring buffers, I don't see that as a problem.  The ring buffer
sizes have always been a swag value for the low-speed devices with
small ring buffers.  For the high-speed devices (netvsc and storvsc)
the ring buffer sizes have been somewhat determined by perf
measurements, but the ring buffers are much bigger, so stealing
a little bit of space doesn't have any noticeable effect.  Even with
the perf measurements, the sizes aren't very exact. Performance
just isn't sensitive to the size of the ring buffer except at a gross level=
.

>=20
> One cause of the waste memory is using alloc_pages() to get physical
> continuous, however, after a quick look into GPADL, looks like it also
> supports uncontinuous pages. Maybe that's the longer-term solution?

Yes, that seems like a desirable long-term solution.  While the GPADL
code handles vmalloc memory correctly (because the netvsc send and
receive buffers are vmalloc memory), hv_ringbuffer_init() assumes
physically contiguous memory.  It would need to use vmalloc_to_page()
in building the pages_wraparound array instead of just indexing into
the struct page array.  But that's an easy fix.  Another problem is the
uio_hv_generic.c driver, where hv_uio_ring_mmap() assumes a physically
contiguous ring. Maybe there's a straightforward way to fix it as well,
but it isn't immediately obvious to me.

Using vmalloc memory for ring buffers has another benefit as well.
Today, adding a new NIC to a VM that has been running for a while
could fail because of not being able to allocate 1 Mbyte contiguous
memory for the ring buffers used by each VMBus channel.  There
could be plenty of memory available, but fragmentation could prevent
getting 1 Mbyte contiguous.  Using vmalloc'ed ring buffers would
solve this problem.

Michael

>=20
> Regards,
> Boqun
>=20
> > >
> > >  struct hv_ring_buffer_info {
> >
> > Thanks for the patch.
> > It's worth noting that this will affect the size of ringbuffer calculat=
ion for
> > some of the drivers: netvsc, storvsc_drv, hid-hyperv, and hyperv-keyboa=
rd.c.
> > It will be nice to have this comment added in commit for future referen=
ce.
> >
> > Looks a good improvement to me,
> > Reviewed-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> >
> > > --
> > > 2.25.1
> > >

