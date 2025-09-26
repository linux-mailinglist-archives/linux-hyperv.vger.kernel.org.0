Return-Path: <linux-hyperv+bounces-7002-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7697BA545D
	for <lists+linux-hyperv@lfdr.de>; Fri, 26 Sep 2025 23:58:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 431A71B28065
	for <lists+linux-hyperv@lfdr.de>; Fri, 26 Sep 2025 21:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C70DD238C08;
	Fri, 26 Sep 2025 21:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="XZHjD+zg"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 452324C81;
	Fri, 26 Sep 2025 21:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758923913; cv=none; b=WpcBto/01RtONm2mCYraIONxBx5sXMniiYP2ZEAu0UsuO38ssLBHhylQxteBJJrwB05bTDGR2/F5TzpE0iDobSz7F8rQiDaGznlNNYCgLhxiPUNXqjb+B2T9T1cGMFUtIOFsYncSI1teYrrQA4NfWD3kvILGv06Fmc7F9T5+m6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758923913; c=relaxed/simple;
	bh=2N3i7wka3y8r1W/+OH2cVEfXc55IH00qOw70jq68llg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aINkqtR8zYls5fjO1JxC4Xna1G9uoqTDlqreufy6F+QJnqlG5BT7Nw+DI0XGt+BqPFJZc256AqDw/qu6sRv9XT1vT+u5yPPHtIES/Q1LQRJSthwt5sSMjV7i7257kZ0lkHHprfyaKXi45ywaUfsmDJJ8IxNlWNG0rjxW6EIoKus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=XZHjD+zg; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii.localdomain (unknown [20.236.11.102])
	by linux.microsoft.com (Postfix) with ESMTPSA id 3B19D2012C0C;
	Fri, 26 Sep 2025 14:58:31 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3B19D2012C0C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1758923911;
	bh=FV8lRpz9S5mLSQKVSflWbp+yw7n2B+SKyFcl+EB+6qw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XZHjD+zglUVnQAFz1z10+gAimcWCJtq9z7WUlINwfpTMyzYUhnGS05Ndd9cA+7DpK
	 kSpiKztKhGGGHEytMOwaZPg0At7/K5DQ+Pr0QLsW7fn2WMPYSpHuSCqhe/PbX/hgVA
	 sIuctMJkDqq0gMPI8207uezs2R+9N2iI1WrmoiZw=
Date: Fri, 26 Sep 2025 14:58:26 -0700
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] Drivers: hv: Rename a few memory region related
 functions for clarity
Message-ID: <aNcMgqJrPzcGumUp@skinsburskii.localdomain>
References: <175874669044.157998.15064894246017794777.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <175874946244.157998.2185691597101633735.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <6165c48c-a71e-4aa0-99d3-2ff8158ddd4a@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6165c48c-a71e-4aa0-99d3-2ff8158ddd4a@linux.microsoft.com>

On Fri, Sep 26, 2025 at 10:14:25AM -0700, Nuno Das Neves wrote:
> On 9/24/2025 2:31 PM, Stanislav Kinsburskii wrote:
> > A cleanup and precursor patch.
> > 
> This line doesn't add much, I think you can remove it.
> 

It actually means something important: it explains why a change is being
made and that other changes to follow will make more sense out of this
one.

> >  
> >  static int
> > -mshv_region_populate(struct mshv_mem_region *region)
> > +mshv_region_pin(struct mshv_mem_region *region)
> >  {
> > -	return mshv_region_populate_pages(region, 0, region->nr_pages);
> > +	return mshv_region_pin_pages(region, 0, region->nr_pages);
> >  }
> Do we ever partially pin a region? Maybe we don't need a function called
> mshv_region_pin_pages() and we just have mshv_region_pin() instead.
> 

We don't and we likley won't until we support virtio-iommu.
I'll can remove mshv_region_pin_pages.

> >  
> >  static struct mshv_mem_region *
> > @@ -1264,17 +1259,25 @@ static int mshv_partition_create_region(struct mshv_partition *partition,
> >  	return 0;
> >  }
> >  
> > -/*
> > - * Map guest ram. if snp, make sure to release that from the host first
> > - * Side Effects: In case of failure, pages are unpinned when feasible.
> > +/**
> > + * mshv_handle_pinned_region - Handle pinned memory regions
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
> > +static int mshv_handle_pinned_region(struct mshv_mem_region *region)
> 
> Why the verb "handle"? It doesn't provide any information on what the function does,
> when it might be called etc. Maybe mshv_init_pinned_region() ?
> 

I see what you mean. Indeed, "handle" isn't goot, but "init" is quite
overloaded either. I think "mshv_prepare_pinned_region" suit better
here.
Is it okay with you?

Thanks,
Stanilav


