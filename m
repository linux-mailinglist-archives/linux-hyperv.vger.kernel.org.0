Return-Path: <linux-hyperv+bounces-2827-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A10195D7EB
	for <lists+linux-hyperv@lfdr.de>; Fri, 23 Aug 2024 22:42:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2B23B20E18
	for <lists+linux-hyperv@lfdr.de>; Fri, 23 Aug 2024 20:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8CC81BA296;
	Fri, 23 Aug 2024 20:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="FXq4SzOH"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azolkn19011027.outbound.protection.outlook.com [52.103.12.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C71231925B9;
	Fri, 23 Aug 2024 20:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.12.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724445734; cv=fail; b=g//LD6hIvfYMQVsvY/pGp0raMAMv3OoU0OK2KjzE21bXKoPzyrvL/PFHy253F/40zyjmYqh+yjAUliyp/fvRY8KvhBf9t7H3xIRKZiAwhPLcOlsp53/M7zyhTnGGRPJM7rz25NNXoMHnQ/2BfFPRSzgCEFcFnYVRHFZC3rt8Xzo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724445734; c=relaxed/simple;
	bh=g8+OzlFG9T+9i1xxguRm1jbXapuwj89SWZQb3Oko0gk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Z/xg+hWryACrDYZBkTDEul3btZHQz/IXXyioA56lDCkL9slZOKq9g5Iyh3hbI+OFdMJanFq3ZO2cMOl3IGxlfLsjK5jiUKxTWhOvySDed4p2uwBp9hRHBYgIxqS6QOVlf/xrIvM3mcKrx9nPrSiuhMxrVmY5gNfBs5sQIMRDjjg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=FXq4SzOH; arc=fail smtp.client-ip=52.103.12.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bZe3s0KJjL8MEYEU/tkU30ODHBtXiJNSgXx8sWn0XmrseFluEvVjwP/s4kH2zkxl58TZ5w3GbYlEml9NT4W8wz7TVY3u57KPxOjkSfnKszvoBlKNEhz16cVIMWkzHQLnQuAs5IBljpRvq1G9LOLbRtppAVy+Z60QOCdi6WHiLzFX9B+sjvPsJR/if3g2v0h3SYxZqaiPDWrF/sIte1Lw1XndlzfOyLm6+puQRzapfr0WtzedJ1aB8Tm1CHciK/eFPrqG421l8TsF5uIrT3syKbGq9BT7dF4FU+6qZvxb/A2+Loprm34XDhIdRjTUwNygyTD44wmTUVP0ps6hAVpU2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4bXh2/P24tjJ1WyKnKeIfw3zoSuYvfBsgY4PSc8jLGM=;
 b=Ldbaf3i1PKBbPatJY1YgQsw5sCerEdkF0lNoQNOK+DhR9OyCfGayhhAh5wnLs5bSlaR6tzwdgQQW9jIl8OH69gPeR6vhWVzSJYb1kFfsaxd12k/wFTEoGFHEqa3utu8+oPmN0o10Kj2H8p8EdJeh7hrKeoX/u8KO9dx8NG9b6wZZ1J4WUtyV+HveWMbjsIMwFg15jpzASWe6iZcBf3sQgrZXQbK6Iudv9k45cGa1FY/H1wDsLBNSsl+VGBv6AcXaTbpLXnAB23XikkOtax0PKzllLz4zS03Nb06Owf1PZvhNi15fDFfTcnx2ilRc6S6TXyoHX/ZH2nuFzis5+MbRoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4bXh2/P24tjJ1WyKnKeIfw3zoSuYvfBsgY4PSc8jLGM=;
 b=FXq4SzOHntvPrE0ETQ2PetwLJoSZVT6Qw9Av5Yhl3QKDPLLbZYa3aiIGWe1PMZRHqvRZkVv3mJSI0sDR8OPUamlpNwAvXoqXD83qhCB7FMw3Snbyyc+PQ6q96UslnU+dJFJmGoyVO77HjPScbeU/O3zr0kGEekQmcFYYsKgoyocFKej7v5bm07r6GTnJFsPIq9VJakAMl08Ca2FNywndQ2wS7AooUUOD9vTaTA0sapSxy6Toq24CJHtfNRfQhqmZ2fYLf9eff07aqCxrmL5lX79XxGa6bLm0Bix569WXbJtqVTYeicM9fxzaxChSpWB6l8N5Rcre2XjLxxn9vensNQ==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by BY5PR02MB6962.namprd02.prod.outlook.com (2603:10b6:a03:235::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.22; Fri, 23 Aug
 2024 20:42:09 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%6]) with mapi id 15.20.7875.018; Fri, 23 Aug 2024
 20:42:08 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: =?iso-8859-2?Q?Petr_Tesa=F8=EDk?= <petr@tesarici.cz>,
	"mhkelley58@gmail.com" <mhkelley58@gmail.com>
CC: "kbusch@kernel.org" <kbusch@kernel.org>, "axboe@kernel.dk"
	<axboe@kernel.dk>, "sagi@grimberg.me" <sagi@grimberg.me>,
	"James.Bottomley@HansenPartnership.com"
	<James.Bottomley@HansenPartnership.com>, "martin.petersen@oracle.com"
	<martin.petersen@oracle.com>, "kys@microsoft.com" <kys@microsoft.com>,
	"haiyangz@microsoft.com" <haiyangz@microsoft.com>, "wei.liu@kernel.org"
	<wei.liu@kernel.org>, "decui@microsoft.com" <decui@microsoft.com>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>, "hch@lst.de" <hch@lst.de>,
	"m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>
Subject: RE: [RFC 2/7] dma: Handle swiotlb throttling for SGLs
Thread-Topic: [RFC 2/7] dma: Handle swiotlb throttling for SGLs
Thread-Index: AQHa9MJ/oxYKIvOEI0OiEOMXXoWk37I0fC8AgADHTjA=
Date: Fri, 23 Aug 2024 20:42:08 +0000
Message-ID:
 <SN6PR02MB41577D08C73A93C32F836E17D4882@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20240822183718.1234-1-mhklinux@outlook.com>
	<20240822183718.1234-3-mhklinux@outlook.com>
 <20240823100252.4f2a1a43@meshulam.tesarici.cz>
In-Reply-To: <20240823100252.4f2a1a43@meshulam.tesarici.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tmn: [se22CpFv1QSMEMUWMwWrzQzn2+j4tbfQ]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|BY5PR02MB6962:EE_
x-ms-office365-filtering-correlation-id: 5f86e127-89f9-44bf-95e1-08dcc3b40e85
x-microsoft-antispam:
 BCL:0;ARA:14566002|8060799006|19110799003|15080799003|461199028|102099032|3412199025|440099028;
x-microsoft-antispam-message-info:
 EI6MxPeVTO/MD5kPflM34fnZoGunmeY/FtRVg7kCRyhMiWReUGfTyRnVPdeU8DgB3ToZxVGX7Amx5bzR+77thJVX3um+FhuV9ep+YtGnr9msvw4eMUFg2/vwYVqc4BhtdjZhFL0ibnuRTAznyb7+YYyrKzj4NOPzG0PeBpDJLxOc/eLfnphJTI7kwb1x0dOdmKUElmJh0JUUXkKNMNaDpXUhWotxJ1HuYI3IDolKXkESNrYWFF12BOyx3c6XXYf917yW9eFiwI3EJ4+91BMbz6hYxtl5aHLBW7ZFj+qPDFIqws4Q5FRovZKX9V7tL/Qa5tSfKrSATT/7595RDdcFjTVN33UrVCkXcZ+A/23rJrnNBvkyjhkZPvFVTQiUOad1acDk3jq5N7Ax+IML5ZbppGVR/LeSuWi19+EmB8rCxv/DoLNoSdDIQ7OsNer8dF/ZG4MbTl2VpEA7nllRFc7DRJ7n79ofekvphf2nDizgJl/2Qd65TPUe2sKcp8WNBvaC0Vx+mMg1yN+JVRs7OFay6lWoa9javKfYch2y96MNp4Wu9W2WM2JI/TPCJkz6W5x3h0+pRJtaHTic/lvnIZtzrrVjk5wGa1FWpl9PRlMbGasnTmyuMbzFN2X5zymNAz+7RlUfAlS6/aBSjKF+7vuY9d8/MOcP8yuEXIR73Ii312m+dQAMke2wFOFVkeo367Qr
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-2?Q?HPUNzVkYPmQFeWqshxomWU6YKpDx/faGvgfwmJWuO0YLDzAhJ1MA7KotJr?=
 =?iso-8859-2?Q?2vuhD8kQDxac6EkE7e/xfdfFDPkQDmxUaZbDTN1+KVOLiB5RzVa8gxsuQG?=
 =?iso-8859-2?Q?+kUXPvYXAJ3x+cc5Z3dQ/Wksvb0Fco714vgZO52HYqbGfUJQ7XI0uvhmg1?=
 =?iso-8859-2?Q?rTcT5zUfTw1Gzl14EGXIkuv9G32pDWjr/6Xzv9LBdggfazoJGET2dj5RM8?=
 =?iso-8859-2?Q?XsjouzE45oVJG4agpAyxByZwCHh3IQsgXUGPJMEcJBVwRwhqzlmCrgcww5?=
 =?iso-8859-2?Q?oIAl6E3FHZpQzsbo6pC8t18/IDavGju66covwa0D5ZbIdEBBPajezminBX?=
 =?iso-8859-2?Q?HdlsQbRJ0x+k3B+nlVdHZ8BDpvMCxsxdAfz28lvrlMXAOj5/GkQEjCLQDH?=
 =?iso-8859-2?Q?stPeMVNJLU44/dQoPqyLsY8kKydGlmwndd4WSQkZYQYRlb8k5HDzCqMfGw?=
 =?iso-8859-2?Q?4VaBcHdA6x+0HmHn/c4cvwkPa3TtdkI5GCqMio3/7+S12tB/JYvrAsJwSl?=
 =?iso-8859-2?Q?ZfeIxkeCSbgLdPPw0VgvIiSq7klBY8EZikc04RdgKAT2kaeRqsT7vbsiLP?=
 =?iso-8859-2?Q?OkyM0l1/93UET+6XVaByrFO+5KVurCImJpLpl1HZ8+uIHJaW3XPGg7btRK?=
 =?iso-8859-2?Q?uTchLEqKF0QQb6AEnFhZg8m1a+OiydNG265MxIBPJzF00mjw3cRrrgdJYI?=
 =?iso-8859-2?Q?aDv6iV16QyPmJH30ERRDxvWCc9I1OguXPYL8HsHpd8v6n3DpQKj3ZWJfVt?=
 =?iso-8859-2?Q?L6o5kJGQtV+xWktkg/fwi+DCbNp7IF6FSjHUxHp5esa1gZfsr/C308tIk7?=
 =?iso-8859-2?Q?4ZFBz/Q8enpoEdv7qSOtt2aPAczfTpMuKGr1Vm1tMDe/LNusBpYaxYkebb?=
 =?iso-8859-2?Q?DkAVwvwAVRS8bE0+RpZv4ViY5vFSgfa1HLiCAvTjGeI3PJ+BBf6hRSY6OE?=
 =?iso-8859-2?Q?1sBIv1Ip92enxcfevEtIWErlVzL3F5kZ3j/MjdbKHwapvF8b1q7oAU7bcV?=
 =?iso-8859-2?Q?irmDGdY/hd4cfrSJzVve2DQNfIVSQYddcFp7f4+9NL6o44UEB1eEFr8z8K?=
 =?iso-8859-2?Q?2pMxq1JFsxM3H+MQjASdE3qtmznwB5kt/7bqwEwlXw8MkbltRE3Nmq9jnK?=
 =?iso-8859-2?Q?wFr+VknSYyZ/5AuxYsH9bSbLJyfELOEXKpl2GEbQYU1gaACJyhJHlAc9gZ?=
 =?iso-8859-2?Q?3GwdnOUzYRISwz6V4B4i9V8VBhmKBXvPVh0MSCZRy7yunjUZU50wURVtDZ?=
 =?iso-8859-2?Q?Jg3aSzZFmPsJwfJqpn3UqZl/xVH3I5PRpNtYbPZ5Q=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f86e127-89f9-44bf-95e1-08dcc3b40e85
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2024 20:42:08.4402
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6962

From: Petr Tesa=F8=EDk <petr@tesarici.cz> Sent: Friday, August 23, 2024 1:0=
3 AM
>=20
> On Thu, 22 Aug 2024 11:37:13 -0700
> mhkelley58@gmail.com wrote:
>=20
> > From: Michael Kelley <mhklinux@outlook.com>
> >
> > When a DMA map request is for a SGL, each SGL entry results in an
> > independent mapping operation. If the mapping requires a bounce buffer
> > due to running in a CoCo VM or due to swiotlb=3Dforce on the boot line,
> > swiotlb is invoked. If swiotlb throttling is enabled for the request,
> > each SGL entry results in a separate throttling operation. This is
> > problematic because a thread may be holding swiotlb memory while waitin=
g
> > for memory to become free.
> >
> > Resolve this problem by only allowing throttling on the 0th SGL
> > entry. When unmapping the SGL, unmap entries 1 thru N-1 first, then
> > unmap entry 0 so that the throttle isn't released until all swiotlb
> > memory has been freed.
> >
> > Signed-off-by: Michael Kelley <mhklinux@outlook.com>
> > ---
> > This approach to SGLs muddies the line between DMA direct and swiotlb
> > throttling functionality. To keep the MAY_BLOCK attr fully generic, it
> > should propagate to the mapping of all SGL entries.
> >
> > An alternate approach is to define an additional DMA attribute that
> > is internal to the DMA layer. Instead of clearing MAX_BLOCK, this
> > attr is added by dma_direct_map_sg() when mapping SGL entries other
> > than the 0th entry. swiotlb would do throttling only when MAY_BLOCK
> > is set and this new attr is not set.
> >
> > This approach has a modest amount of additional complexity. Given
> > that we currently have no other users of the MAY_BLOCK attr, the
> > conceptual cleanliness may not be warranted until we do.
> >
> > Thoughts?
>=20
> If we agree to change the unthrottling logic (see my comment to your
> RFC 1/7), we'll need an additional attribute to delay unthrottling when
> unmapping sg list entries 1 to N-1. This attribute could convey that
> the mapping is the non-initial segment of an sg list and it could then
> be also used to disable blocking in swiotlb_tbl_map_single().
>=20
> >
> >  kernel/dma/direct.c | 35 ++++++++++++++++++++++++++++++-----
> >  1 file changed, 30 insertions(+), 5 deletions(-)
> >
> > diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> > index 4480a3cd92e0..80e03c0838d4 100644
> > --- a/kernel/dma/direct.c
> > +++ b/kernel/dma/direct.c
> > @@ -438,6 +438,18 @@ void dma_direct_sync_sg_for_cpu(struct device *dev=
,
> >  		arch_sync_dma_for_cpu_all();
> >  }
> >
> > +static void dma_direct_unmap_sgl_entry(struct device *dev,
> > +		struct scatterlist *sgl, enum dma_data_direction dir,
>=20
> Nitpick: This parameter should probably be called "sg", because it is
> never used to do any operation on the whole list. Similarly, the
> function could be called dma_direct_unmap_sg_entry(), because there is
> no dma_direct_unmap_sgl() either...

OK.  I agree.

>=20
> > +		unsigned long attrs)
> > +
> > +{
> > +	if (sg_dma_is_bus_address(sgl))
> > +		sg_dma_unmark_bus_address(sgl);
> > +	else
> > +		dma_direct_unmap_page(dev, sgl->dma_address,
> > +				      sg_dma_len(sgl), dir, attrs);
> > +}
> > +
> >  /*
> >   * Unmaps segments, except for ones marked as pci_p2pdma which do not
> >   * require any further action as they contain a bus address.
> > @@ -449,12 +461,20 @@ void dma_direct_unmap_sg(struct device *dev, stru=
ct
> scatterlist *sgl,
> >  	int i;
> >
> >  	for_each_sg(sgl,  sg, nents, i) {
> > -		if (sg_dma_is_bus_address(sg))
> > -			sg_dma_unmark_bus_address(sg);
> > -		else
> > -			dma_direct_unmap_page(dev, sg->dma_address,
> > -					      sg_dma_len(sg), dir, attrs);
> > +		/*
> > +		 * Skip the 0th SGL entry in case this SGL consists of
> > +		 * throttled swiotlb mappings. In such a case, any other
> > +		 * entries should be unmapped first since unmapping the
> > +		 * 0th entry will release the throttle semaphore.
> > +		 */
> > +		if (!i)
> > +			continue;
> > +		dma_direct_unmap_sgl_entry(dev, sg, dir, attrs);
> >  	}
> > +
> > +	/* Now do the 0th SGL entry */
> > +	if (nents)
>=20
> I wonder if nents can ever be zero here, but it's nowhere enforced and
> dma_map_sg_attrs() is exported, so I agree, let's play it safe.

Yep -- my thinking exactly.

>=20
> > +		dma_direct_unmap_sgl_entry(dev, sgl, dir, attrs);
> >  }
> >  #endif
> >
> > @@ -492,6 +512,11 @@ int dma_direct_map_sg(struct device *dev, struct s=
catterlist
> *sgl, int nents,
> >  			ret =3D -EIO;
> >  			goto out_unmap;
> >  		}
> > +
> > +		/* Allow only the 0th SGL entry to block */
> > +		if (!i)
>=20
> Are you sure? I think the modified value of attrs is first used in the
> next loop iteration, so the conditional should be removed, or else both
> segment index 0 and 1 will keep the flag.

I don't understand your comment. If it's present, the MAY_BLOCK flag
is used for the index 0 SGL entry, and then is cleared before the loop is
run again for the index 1 and subsequent SGL entries. But it would
still work with the conditional removed, and maybe the CPU overhead
of always clearing the flag is the same as doing the conditional.

Michael

>=20
> Petr T
>=20
> > +			attrs &=3D ~DMA_ATTR_MAY_BLOCK;
> > +
> >  		sg_dma_len(sg) =3D sg->length;
> >  	}
> >


