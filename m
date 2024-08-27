Return-Path: <linux-hyperv+bounces-2876-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3500E9602BB
	for <lists+linux-hyperv@lfdr.de>; Tue, 27 Aug 2024 09:15:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4C1F1F2308F
	for <lists+linux-hyperv@lfdr.de>; Tue, 27 Aug 2024 07:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEC3D155322;
	Tue, 27 Aug 2024 07:14:44 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D80815383F;
	Tue, 27 Aug 2024 07:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724742884; cv=none; b=cSJdKsiPAPrtRK/XSSDW4hCF4yZCuqDObggNWEWlSUqJieDKBe3/cMLZNeqSmlbcjCnBu4ZlunJip6DQFiqDWk7tQswbCWFrTwKzBxVLdjqGTvPpMUPl0C5wrnwQqTe3ayXZOyuwMCcJSh1Tq/cdHE0CEUBcMz8BUZ9PJpA/sng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724742884; c=relaxed/simple;
	bh=nhjxhmNHLo5IoXdK9az/5+6rhAZctBlOH954/my4wZo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nr1cLdX5Ee+67UWm/uPk+4bbGkphTov1RHjoXxr9Fu5mE8WibDKdC8ZZlpqQyOCN8hLosshzctNvM0iryLzl5CSQYT1mPDPEz63EdDYr033GOAhR1jjQb+VwxONxW5wki/ZN7jpyBPfMsnQnQ7i96vVk/blHG6YFSSHNytb9Mtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6526A227AAA; Tue, 27 Aug 2024 09:14:28 +0200 (CEST)
Date: Tue, 27 Aug 2024 09:14:28 +0200
From: Christoph Hellwig <hch@lst.de>
To: Michael Kelley <mhklinux@outlook.com>
Cc: Christoph Hellwig <hch@lst.de>, "kbusch@kernel.org" <kbusch@kernel.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>,
	"sagi@grimberg.me" <sagi@grimberg.me>,
	"James.Bottomley@HansenPartnership.com" <James.Bottomley@HansenPartnership.com>,
	"martin.petersen@oracle.com" <martin.petersen@oracle.com>,
	"kys@microsoft.com" <kys@microsoft.com>,
	"haiyangz@microsoft.com" <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>,
	"m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
	"petr@tesarici.cz" <petr@tesarici.cz>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>
Subject: Re: [RFC 0/7] Introduce swiotlb throttling
Message-ID: <20240827071428.GA12797@lst.de>
References: <20240822183718.1234-1-mhklinux@outlook.com> <20240824081618.GB8527@lst.de> <SN6PR02MB415753359387FBC8977A9598D48B2@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR02MB415753359387FBC8977A9598D48B2@SN6PR02MB4157.namprd02.prod.outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Aug 26, 2024 at 03:27:30PM +0000, Michael Kelley wrote:
> OK, this makes sense to me. The DMA_ATTR_* symbols are currently
> defined as just values that are not part of an enum or any other higher
> level abstraction, and the "attrs" parameter to the dma_* functions is
> just "unsigned long". Are you thinking that the separate namespace is
> based only on the symbolic name (i.e., DMA_MAP_* vs DMA_ATTR_*),
> with the values being disjoint? That seems straightforward to me.

Yes. Although initially I'd just keep ATTR for the allocation and then
maybe do a scripted run to convert it.

> Changing the "attrs" parameter to an enum is a much bigger change ....

I don't think an enum makes much sense as we have bits defined.  A
__bitwise type would be nice, but not required.

> For a transition period we can have both DMA_ATTR_SKIP_CPU_SYNC
> and DMA_MAP_SKIP_CPU_SYNC, and then work to change all
> occurrences of the former to the latter.
> 
> I'll have to look more closely at WEAK_ORDERING and NO_WARN.
> 
> There are also a couple of places where DMA_ATTR_NO_KERNEL_MAPPING
> is used for dma_map_* calls, but those are clearly bogus since that
> attribute is never tested in the map path.

Yeah, these kinds of bogus things is what I'd like to kill..


> > Note that this also in general involves changes to the block drivers
> > to set that flag, which is a bit annoying, but I guess there is not
> > easy way around it without paying the price for the BLK_MQ_F_BLOCKING
> > overhead everywhere.
> 
> Agreed. I assumed there was some cost to BLK_MQ_F_BLOCKING since
> the default is !BLK_MQ_F_BLOCKING, but I don't really know what
> that is. Do you have a short summary, just for my education?

I think the biggest issue is that synchronize_srcu is pretty damn
expensive, but there's also a whole bunch of places that unconditionally
defer to the workqueue.


