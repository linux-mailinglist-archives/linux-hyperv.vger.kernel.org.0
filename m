Return-Path: <linux-hyperv+bounces-2856-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EB4C95DFED
	for <lists+linux-hyperv@lfdr.de>; Sat, 24 Aug 2024 21:56:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 764951F21B8D
	for <lists+linux-hyperv@lfdr.de>; Sat, 24 Aug 2024 19:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A0A37DA9E;
	Sat, 24 Aug 2024 19:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b="k+tG6Lis"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from bee.tesarici.cz (bee.tesarici.cz [37.205.15.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DE0061FFC;
	Sat, 24 Aug 2024 19:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.205.15.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724529410; cv=none; b=R4gFJCAxoGYgx4dgB2+PWEstWcHqpL7sVbJt2X8pTw7L/9enslAzHzFPA2+YB7hSoCXlimzPJHpB69dKHOKKB0+LI94TrfO17vtZTwyFzpviHCxdHfR8xtidwMVl/0KgQljcTDC+n27BhBIEWTFILlIqr7Ouul2V8+iHNZaRVJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724529410; c=relaxed/simple;
	bh=tUc6wqBgvvSHEzhitXtazy+5fPbQNKmrQu5tbupGBZ0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FLfoidnMAd9WTjsXZ6RhQe4w2tkjxlR6T/NJibJOgnuaFLY8j0avICgdxc7XUL2ecj/7QmXlfe51TcYKRzm2bayTuw1BDLXGcClKolcsX+GDRy6fOckHi55Ljse8QJcpkQT6WG30rXsJ4BBBJcfuoFbPnMbu7GyEmH5B5ew3uL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz; spf=pass smtp.mailfrom=tesarici.cz; dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b=k+tG6Lis; arc=none smtp.client-ip=37.205.15.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tesarici.cz
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by bee.tesarici.cz (Postfix) with ESMTPSA id D8C081EF371;
	Sat, 24 Aug 2024 21:56:38 +0200 (CEST)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=quarantine dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tesarici.cz; s=mail;
	t=1724529399; bh=jmAC944ISCidHnUwcR4x0UuSWh9TH7n54p4N1rya7jM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=k+tG6LisKBq7voHQ0bQ6+lBvUOcU2LoyXaJfiah5wNcUIauVh56QV0v9PFOeg6Drl
	 Fr+oRwGly1ejLvF3qN6qwmuVgyq4nS9Uzpz73JNo2EyW55InLgf490RISl+cF2idpM
	 CuPX/kj5djSrNU8RpJ5u9kd5pJp/cMwHU1IumdzgjBNfbzMtvoKgfLS8JrzJ79+ApU
	 6uNPr7caYHUeRdr/dEPZZpQ4tkR2fzWl6BTDlesDjpjuxMHu+/VbuzSG4ZZDh3UzyP
	 PdnheeGXY5skrcWIBrRbzThAvl0Ifzg8tNiIA7Lf9ecCbAaMoIH+yvyH4XBztvZe0v
	 bMuGG9mOlbedA==
Date: Sat, 24 Aug 2024 21:56:37 +0200
From: Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To: Michael Kelley <mhklinux@outlook.com>
Cc: "mhkelley58@gmail.com" <mhkelley58@gmail.com>, "kbusch@kernel.org"
 <kbusch@kernel.org>, "axboe@kernel.dk" <axboe@kernel.dk>,
 "sagi@grimberg.me" <sagi@grimberg.me>,
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
Subject: Re: [RFC 2/7] dma: Handle swiotlb throttling for SGLs
Message-ID: <20240824215637.2bbacb50@meshulam.tesarici.cz>
In-Reply-To: <SN6PR02MB41577D08C73A93C32F836E17D4882@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20240822183718.1234-1-mhklinux@outlook.com>
	<20240822183718.1234-3-mhklinux@outlook.com>
	<20240823100252.4f2a1a43@meshulam.tesarici.cz>
	<SN6PR02MB41577D08C73A93C32F836E17D4882@SN6PR02MB4157.namprd02.prod.outlook.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 23 Aug 2024 20:42:08 +0000
Michael Kelley <mhklinux@outlook.com> wrote:

> From: Petr Tesa=C5=99=C3=ADk <petr@tesarici.cz> Sent: Friday, August 23, =
2024 1:03 AM
> >=20
> > On Thu, 22 Aug 2024 11:37:13 -0700
> > mhkelley58@gmail.com wrote:
> >  =20
> > > From: Michael Kelley <mhklinux@outlook.com>
> > >
> > > When a DMA map request is for a SGL, each SGL entry results in an
> > > independent mapping operation. If the mapping requires a bounce buffer
> > > due to running in a CoCo VM or due to swiotlb=3Dforce on the boot lin=
e,
> > > swiotlb is invoked. If swiotlb throttling is enabled for the request,
> > > each SGL entry results in a separate throttling operation. This is
> > > problematic because a thread may be holding swiotlb memory while wait=
ing
> > > for memory to become free.
> > >
> > > Resolve this problem by only allowing throttling on the 0th SGL
> > > entry. When unmapping the SGL, unmap entries 1 thru N-1 first, then
> > > unmap entry 0 so that the throttle isn't released until all swiotlb
> > > memory has been freed.
> > >
> > > Signed-off-by: Michael Kelley <mhklinux@outlook.com>
> > > ---
> > > This approach to SGLs muddies the line between DMA direct and swiotlb
> > > throttling functionality. To keep the MAY_BLOCK attr fully generic, it
> > > should propagate to the mapping of all SGL entries.
> > >
> > > An alternate approach is to define an additional DMA attribute that
> > > is internal to the DMA layer. Instead of clearing MAX_BLOCK, this
> > > attr is added by dma_direct_map_sg() when mapping SGL entries other
> > > than the 0th entry. swiotlb would do throttling only when MAY_BLOCK
> > > is set and this new attr is not set.
> > >
> > > This approach has a modest amount of additional complexity. Given
> > > that we currently have no other users of the MAY_BLOCK attr, the
> > > conceptual cleanliness may not be warranted until we do.
> > >
> > > Thoughts? =20
> >=20
> > If we agree to change the unthrottling logic (see my comment to your
> > RFC 1/7), we'll need an additional attribute to delay unthrottling when
> > unmapping sg list entries 1 to N-1. This attribute could convey that
> > the mapping is the non-initial segment of an sg list and it could then
> > be also used to disable blocking in swiotlb_tbl_map_single().
> >  =20
> > >
> > >  kernel/dma/direct.c | 35 ++++++++++++++++++++++++++++++-----
> > >  1 file changed, 30 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> > > index 4480a3cd92e0..80e03c0838d4 100644
> > > --- a/kernel/dma/direct.c
> > > +++ b/kernel/dma/direct.c
> > > @@ -438,6 +438,18 @@ void dma_direct_sync_sg_for_cpu(struct device *d=
ev,
> > >  		arch_sync_dma_for_cpu_all();
> > >  }
> > >
> > > +static void dma_direct_unmap_sgl_entry(struct device *dev,
> > > +		struct scatterlist *sgl, enum dma_data_direction dir, =20
> >=20
> > Nitpick: This parameter should probably be called "sg", because it is
> > never used to do any operation on the whole list. Similarly, the
> > function could be called dma_direct_unmap_sg_entry(), because there is
> > no dma_direct_unmap_sgl() either... =20
>=20
> OK.  I agree.
>=20
> >  =20
> > > +		unsigned long attrs)
> > > +
> > > +{
> > > +	if (sg_dma_is_bus_address(sgl))
> > > +		sg_dma_unmark_bus_address(sgl);
> > > +	else
> > > +		dma_direct_unmap_page(dev, sgl->dma_address,
> > > +				      sg_dma_len(sgl), dir, attrs);
> > > +}
> > > +
> > >  /*
> > >   * Unmaps segments, except for ones marked as pci_p2pdma which do not
> > >   * require any further action as they contain a bus address.
> > > @@ -449,12 +461,20 @@ void dma_direct_unmap_sg(struct device *dev, st=
ruct =20
> > scatterlist *sgl, =20
> > >  	int i;
> > >
> > >  	for_each_sg(sgl,  sg, nents, i) {
> > > -		if (sg_dma_is_bus_address(sg))
> > > -			sg_dma_unmark_bus_address(sg);
> > > -		else
> > > -			dma_direct_unmap_page(dev, sg->dma_address,
> > > -					      sg_dma_len(sg), dir, attrs);
> > > +		/*
> > > +		 * Skip the 0th SGL entry in case this SGL consists of
> > > +		 * throttled swiotlb mappings. In such a case, any other
> > > +		 * entries should be unmapped first since unmapping the
> > > +		 * 0th entry will release the throttle semaphore.
> > > +		 */
> > > +		if (!i)
> > > +			continue;
> > > +		dma_direct_unmap_sgl_entry(dev, sg, dir, attrs);
> > >  	}
> > > +
> > > +	/* Now do the 0th SGL entry */
> > > +	if (nents) =20
> >=20
> > I wonder if nents can ever be zero here, but it's nowhere enforced and
> > dma_map_sg_attrs() is exported, so I agree, let's play it safe. =20
>=20
> Yep -- my thinking exactly.
>=20
> >  =20
> > > +		dma_direct_unmap_sgl_entry(dev, sgl, dir, attrs);
> > >  }
> > >  #endif
> > >
> > > @@ -492,6 +512,11 @@ int dma_direct_map_sg(struct device *dev, struct=
 scatterlist =20
> > *sgl, int nents, =20
> > >  			ret =3D -EIO;
> > >  			goto out_unmap;
> > >  		}
> > > +
> > > +		/* Allow only the 0th SGL entry to block */
> > > +		if (!i) =20
> >=20
> > Are you sure? I think the modified value of attrs is first used in the
> > next loop iteration, so the conditional should be removed, or else both
> > segment index 0 and 1 will keep the flag. =20
>=20
> I don't understand your comment. If it's present, the MAY_BLOCK flag
> is used for the index 0 SGL entry, and then is cleared before the loop is
> run again for the index 1 and subsequent SGL entries. But it would
> still work with the conditional removed, and maybe the CPU overhead
> of always clearing the flag is the same as doing the conditional.

Yes, this was my original thinking, but then I somehow got caught up in
it and went on to thinking that the condition was not only unnecessary,
but wrong. You're right, the code is perfectly fine as it is.

Sorry for the noise.

Petr T

