Return-Path: <linux-hyperv+bounces-2853-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 963DB95DCE2
	for <lists+linux-hyperv@lfdr.de>; Sat, 24 Aug 2024 10:16:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 19BCBB22A97
	for <lists+linux-hyperv@lfdr.de>; Sat, 24 Aug 2024 08:16:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84D361547CC;
	Sat, 24 Aug 2024 08:16:25 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C641179BD;
	Sat, 24 Aug 2024 08:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724487385; cv=none; b=ICqCANXD1z/dowhtaF9UFnAaM9umJzKHuwABnpUpLiJ4brCfUFW73hV+U2U2jkfXIrJztkZGnxp3kQSPt4ausI+2uzz4rp+ga75y/T9K4qIOwlAZD1G/OqFbt7NIsVJ9o421g7SHOEfpE+mLqQ0oAgJbFelISYiuK5YL/ACkZLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724487385; c=relaxed/simple;
	bh=tPuCwHyIKcY3Z4wwkH2t8Pvr1gWq8xRTEmWqoLqXl88=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GphJcCz3Q6Uzfy9OaZ1fZuTLnwFnuXWX0l6O5dgzBt8mGU0bwyd97rb1NuD8Lq0Df+ncsmFdQa2U4PHK1jWJvP72OHviXUQT1r0Cv4WoWatJybHqsAmvZFyM4+istFHMg2ZlBsH6UYwkNEmx+muLVYdme6hSTE05ksHTVg2YeC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4F46A227A87; Sat, 24 Aug 2024 10:16:18 +0200 (CEST)
Date: Sat, 24 Aug 2024 10:16:18 +0200
From: Christoph Hellwig <hch@lst.de>
To: mhklinux@outlook.com
Cc: kbusch@kernel.org, axboe@kernel.dk, sagi@grimberg.me,
	James.Bottomley@HansenPartnership.com, martin.petersen@oracle.com,
	kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, robin.murphy@arm.com, hch@lst.de,
	m.szyprowski@samsung.com, petr@tesarici.cz, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org, linux-hyperv@vger.kernel.org,
	linux-coco@lists.linux.dev
Subject: Re: [RFC 0/7] Introduce swiotlb throttling
Message-ID: <20240824081618.GB8527@lst.de>
References: <20240822183718.1234-1-mhklinux@outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240822183718.1234-1-mhklinux@outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Aug 22, 2024 at 11:37:11AM -0700, mhkelley58@gmail.com wrote:
> Because it's not possible to detect at runtime whether a DMA map call
> is made in a context that can block, the calls in key device drivers
> must be updated with a MAY_BLOCK attribute, if appropriate. When this
> attribute is set and swiotlb memory usage is above a threshold, the
> swiotlb allocation code can serialize swiotlb memory usage to help
> ensure that it is not exhausted.

One thing I've been doing for a while but haven't gotten to due to
my lack of semantic patching skills is that we really want to split
the few flags useful for dma_map* from DMA_ATTR_* which largely
only applies to dma_alloc.

Only DMA_ATTR_WEAK_ORDERING (if we can't just kill it entirely)
and for now DMA_ATTR_NO_WARN is used for both.

DMA_ATTR_SKIP_CPU_SYNC and your new SLEEP/BLOCK attribute is only
useful for mapping, and the rest is for allocation only.

So I'd love to move to a DMA_MAP_* namespace for the mapping flags
before adding more on potentially widely used ones.

With a little grace period we can then also phase out DMA_ATTR_NO_WARN
for allocations, as the gfp_t can control that much better.

> In general, storage device drivers can take advantage of the MAY_BLOCK
> option, while network device drivers cannot. The Linux block layer
> already allows storage requests to block when the BLK_MQ_F_BLOCKING
> flag is present on the request queue.

Note that this also in general involves changes to the block drivers
to set that flag, which is a bit annoying, but I guess there is not
easy way around it without paying the price for the BLK_MQ_F_BLOCKING
overhead everywhere.


