Return-Path: <linux-hyperv+bounces-7104-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C4435BBE6A9
	for <lists+linux-hyperv@lfdr.de>; Mon, 06 Oct 2025 16:57:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5895B4EF2C5
	for <lists+linux-hyperv@lfdr.de>; Mon,  6 Oct 2025 14:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1465A2D5C74;
	Mon,  6 Oct 2025 14:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="oEStiC6v"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DA962874FC;
	Mon,  6 Oct 2025 14:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759762658; cv=none; b=c5fuvABmDkMUu4tKa7cz41UZp1HvZ8fTBJTlTNriDiRsPfnlingqRfiq/1/bJ4EucdWHv7MVOejZq7F/FQklqdhVWbd6mV7UhoLAFevOmUJO/DaW2Ln29zztH9bAhdlC85W4oh5Fs8dmkoDekWHfneO2TFomcrOgQ+szkgRdLKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759762658; c=relaxed/simple;
	bh=ytf4ipQXatOJxMwXD9g2DwKjh0LUdQtU5IEm8uwoCio=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qSmHV2lR8u/e/N9X4u2lcPFNc05LoklUCDafdD9HhqBSxL8yQrm9s+kSW8LgFBcDesM2Q8Hj/5+X6ng0F0WxyF+PG+1fOL1qHYDhrA/VvarJi6bXkYj3ycwd+hJtoRHMVwIEBhtSytQWg546bMv7HqcvV0KNFBHXDswPD8NKHqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=oEStiC6v; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii.localdomain (unknown [20.236.11.29])
	by linux.microsoft.com (Postfix) with ESMTPSA id 85458211AF2F;
	Mon,  6 Oct 2025 07:57:35 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 85458211AF2F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1759762655;
	bh=LHomZsLEZ2pFtx8kCHjpo3QuoYe8gJzHT3CKF8ivZbY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oEStiC6vW1ya8MyD8tb3oH8I2uDE5CKzC8hZTQtqPhnJraGpswKrfVr0JUwRyKvrY
	 5BGV3XOLFJJpdEvQ+OI0Dzup6UYQnSo1dv30UGmw8NiZmgrHZFLyJnH/i9UtcoOPUG
	 LXXKDHgrOoRmjMYPZPV43Reo/7h+o/ENsbKpVgv8=
Date: Mon, 6 Oct 2025 07:57:32 -0700
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: Michael Kelley <mhklinux@outlook.com>
Cc: "kys@microsoft.com" <kys@microsoft.com>,
	"haiyangz@microsoft.com" <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/5] Drivers: hv: Refactor and rename memory region
 handling functions
Message-ID: <aOPY3J-opH2k6YZ-@skinsburskii.localdomain>
References: <175942263069.128138.16103948906881178993.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <175942295032.128138.5037691911773684559.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <SN6PR02MB4157D88089F3221A853B1C67D4E3A@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR02MB4157D88089F3221A853B1C67D4E3A@SN6PR02MB4157.namprd02.prod.outlook.com>

On Mon, Oct 06, 2025 at 03:08:02AM +0000, Michael Kelley wrote:
> From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com> Sent: Thursday, October 2, 2025 9:36 AM
> > 
> > Simplify and unify memory region management to improve code clarity and
> > reliability. Consolidate pinning and invalidation logic, adopt consistent
> > naming, and remove redundant checks to reduce complexity.
> > 
> > Enhance documentation and update call sites for maintainability.
> > 
> > Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
> > ---
> >  drivers/hv/mshv_root_main.c |   78 +++++++++++++++++++------------------------
> >  1 file changed, 35 insertions(+), 43 deletions(-)
> > 
> > diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
> > index fa42c40e1e02f..29d0c2c9ae4c8 100644
> > --- a/drivers/hv/mshv_root_main.c
> > +++ b/drivers/hv/mshv_root_main.c
> 
> [snip]
> 
> > @@ -1264,17 +1248,25 @@ static int mshv_partition_create_region(struct mshv_partition *partition,
> >  	return 0;
> >  }
> > 
> > -/*
> > - * Map guest ram. if snp, make sure to release that from the host first
> > - * Side Effects: In case of failure, pages are unpinned when feasible.
> > +/**
> > + * mshv_prepare_pinned_region - Pin and map memory regions
> > + * @region: Pointer to the memory region structure
> > + *
> > + * This function processes memory regions that are explicitly marked as pinned.
> > + * Pinned regions are preallocated, mapped upfront, and do not rely on fault-based
> > + * population. The function ensures the region is properly populated, handles
> > + * encryption requirements for SNP partitions if applicable, maps the region,
> > + * and performs necessary sharing or eviction operations based on the mapping
> > + * result.
> > + *
> > + * Return: 0 on success, negative error code on failure.
> >   */
> > -static int
> > -mshv_partition_mem_region_map(struct mshv_mem_region *region)
> > +static int mshv_prepare_pinned_region(struct mshv_mem_region *region)
> >  {
> >  	struct mshv_partition *partition = region->partition;
> >  	int ret;
> > 
> > -	ret = mshv_region_populate(region);
> > +	ret = mshv_region_pin(region);
> >  	if (ret) {
> >  		pt_err(partition, "Failed to populate memory region: %d\n",
> 
> Nit: This error message should probably use the new "pin" terminology
> instead of "populate".
> 

Yes, it should.

Thanks,
Stanislav

> Michael

