Return-Path: <linux-hyperv+bounces-7965-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D547CA56EB
	for <lists+linux-hyperv@lfdr.de>; Thu, 04 Dec 2025 22:18:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 757C23155F86
	for <lists+linux-hyperv@lfdr.de>; Thu,  4 Dec 2025 21:16:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDEB72C21C0;
	Thu,  4 Dec 2025 21:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="jOgOsSqz"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06CA328980F;
	Thu,  4 Dec 2025 21:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764882516; cv=none; b=XHiNuxBNdZq5JURRCAwu8Mm5i06NywogDOMJHUYJ6cqGbovxXnQhzvXF1ksHQUTW7BKwsKEmsBGsowwjMA6/afJPhHFFFoDCyFqxUxZc2/2EEnvSqtMobr200VewAuV50c6iHb9vK8Iayhp3vSchV1AXI1qg2m6O669eLpXBfnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764882516; c=relaxed/simple;
	bh=o5rW8zX2wHaGBiX8S2Noa/Rtl6Hs+MeTbNSz7Xl6vn4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UV3Y4VCjUmxBYKH9OACzk9aLVoE0v8AszP+n9DI0IIDLkG4zbkGzyTLpOxsRV65Joh+q0QCGFSvZc46sHwfYliZdEp1d80fZ4+e32QmQOjWN7fTTzIi6N3EWCB8jOnQgqoM0EUneSDvMMvap3sDwv7CrMl3HXLw1G9zWluy5nms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=jOgOsSqz; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii.localdomain (unknown [20.236.11.102])
	by linux.microsoft.com (Postfix) with ESMTPSA id 9F7342123262;
	Thu,  4 Dec 2025 13:08:33 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9F7342123262
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1764882513;
	bh=pOuU2v2FxGUee7WDIhDlbUfHV75DGC+xAFra0bG1pZM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jOgOsSqzFXBwL5Rj37XOtOpgPihEd5YkHdpfdZlWHaEDgpzpf8q22mV4cJtIAoLh6
	 9/yVIg2dH85doSvqvn8cFGXv7Cw2+hEezUsFdMajpvmUHRjJVSM+lNyDvhUSpEEFQU
	 6CyzuKEWV6jlPbCngUVJ+6pgvSYvPeGnrR4ARLH8=
Date: Thu, 4 Dec 2025 13:08:31 -0800
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: Michael Kelley <mhklinux@outlook.com>
Cc: "kys@microsoft.com" <kys@microsoft.com>,
	"haiyangz@microsoft.com" <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 4/7] Drivers: hv: Fix huge page handling in memory
 region traversal
Message-ID: <aTH4T-FKcL1knHaD@skinsburskii.localdomain>
References: <176412196000.447063.4256335030026363827.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <176412295155.447063.16512843211428609586.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <SN6PR02MB4157F10A84C4BE170AB040F4D4A6A@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR02MB4157F10A84C4BE170AB040F4D4A6A@SN6PR02MB4157.namprd02.prod.outlook.com>

On Thu, Dec 04, 2025 at 04:03:26PM +0000, Michael Kelley wrote:
> From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com> Sent: Tuesday, November 25, 2025 6:09 PM
> > 
> > The previous code assumed that if a region's first page was huge, the
> > entire region consisted of huge pages and stored this in a large_pages
> > flag. This premise is incorrect not only for movable regions (where
> > pages can be split and merged on invalidate callbacks or page faults),
> > but even for pinned regions: THPs can be split and merged during
> > allocation, so a large, pinned region may contain a mix of huge and
> > regular pages.
> > 
> > This change removes the large_pages flag and replaces region-wide
> > assumptions with per-chunk inspection of the actual page size when
> > mapping, unmapping, sharing, and unsharing. This makes huge page
> > handling correct for mixed-page regions and avoids relying on stale
> > metadata that can easily become invalid as memory is remapped.
> > 
> > Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
> > ---
> >  drivers/hv/mshv_regions.c |  213 +++++++++++++++++++++++++++++++++++++++-
> > -----
> >  drivers/hv/mshv_root.h    |    3 -
> >  2 files changed, 184 insertions(+), 32 deletions(-)
> > 
> > diff --git a/drivers/hv/mshv_regions.c b/drivers/hv/mshv_regions.c
> > index 35b866670840..d535d2e3e811 100644
> > --- a/drivers/hv/mshv_regions.c
> > +++ b/drivers/hv/mshv_regions.c
> > @@ -14,6 +14,124 @@
> > 
> >  #include "mshv_root.h"
> > 
> > +/**
> > + * mshv_region_process_chunk - Processes a contiguous chunk of memory pages
> > + *                             in a region.
> > + * @region     : Pointer to the memory region structure.
> > + * @flags      : Flags to pass to the handler.
> > + * @page_offset: Offset into the region's pages array to start processing.
> > + * @page_count : Number of pages to process.
> > + * @handler    : Callback function to handle the chunk.
> > + *
> > + * This function scans the region's pages starting from @page_offset,
> > + * checking for contiguous present pages of the same size (normal or huge).
> > + * It invokes @handler for the chunk of contiguous pages found. Returns the
> > + * number of pages handled, or a negative error code if the first page is
> > + * not present or the handler fails.
> > + *
> > + * Note: The @handler callback must be able to handle both normal and huge
> > + * pages.
> > + *
> > + * Return: Number of pages handled, or negative error code.
> > + */
> > +static long mshv_region_process_chunk(struct mshv_mem_region *region,
> > +				      u32 flags,
> > +				      u64 page_offset, u64 page_count,
> > +				      int (*handler)(struct mshv_mem_region *region,
> > +						     u32 flags,
> > +						     u64 page_offset,
> > +						     u64 page_count))
> > +{
> > +	u64 count, stride;
> > +	unsigned int page_order;
> > +	struct page *page;
> > +	int ret;
> > +
> > +	page = region->pages[page_offset];
> > +	if (!page)
> > +		return -EINVAL;
> > +
> > +	page_order = folio_order(page_folio(page));
> > +	/* 1G huge pages aren't supported by the hypercalls */
> > +	if (page_order == PUD_ORDER)
> > +		return -EINVAL;
> 
> In the general case, folio_order() could return a variety of values ranging from
> 0 up to at least PUD_ORDER.  For example, "2" would be valid value in file
> system code that uses folios to do I/O in 16K blocks instead of just 4K blocks.
> Since this function is trying to find contiguous chunks of either single pages
> or 2M huge pages, I think you are expecting only three possible values: 0,
> PMD_ORDER, or PUD_ORDER. But do you know that "2" (for example)
> would never be returned? The memory involved here is populated using
> pin_user_pages_fast() for the pinned case, or using hmm_range_fault() for
> the movable case. I don't know mm behavior well enough to know if those
> functions could ever populate with a folio with an order other than 0 or
> PMD_ORDER. If such a folio could ever be used, then the way you check
> for a page size change won't be valid. For purposes of informing Hyper-V
> about 2 Meg pages, folio orders 0 through 8 are all equivalent, with folio
> order 9 (PMD_ORDER) being the marker for the start of 2 Meg large page.
> 
> Somebody who knows mm behavior better than I do should comment. Or
> maybe you could just be more defensive and handle the case of folio orders
> not equal to 0 or PMD_ORDER.
> 

Thanks for the comment.
This is addressed this in v9 by expclitly checking for 0 and HUGE_PMD_ORDER.

> > +
> > +	stride = 1 << page_order;
> > +
> > +	/* Start at stride since the first page is validated */
> > +	for (count = stride; count < page_count; count += stride) {
> 
> This striding doesn't work properly in the general case. Suppose the
> page_offset value puts the start of the chunk in the middle of a 2 Meg
> page, and that 2 Meg page is then followed by a bunch of single pages.
> (Presumably the mmu notifier "invalidate" callback could do this.)
> The use of the full stride here jumps over the remaining portion of the
> 2 Meg page plus some number of the single pages, which isn't what you
> want. For the striding to work, it must figure out how much remains in the
> initial large page, and then once the striding is aligned to the large page
> boundaries, the full stride length works.
> 
> Also, what do the hypercalls in the handler functions do if a chunk starts
> in the middle of a 2 Meg page? It looks like the handler functions will set
> the *_LARGE_PAGE flag to the hypercall but then the hv_call_* function
> will fail if the page_count isn't 2 Meg aligned.
> 

This situation you described is not possible, because invalidation
callback simply can't invalidate a part of the huge page even in THP
case (leave aside hugetlb case) without splitting it beforehand, and
splitting a huge page requires invalidation of the whole huge page
first.

> > +		page = region->pages[page_offset + count];
> > +
> > +		/* Break if current page is not present */
> > +		if (!page)
> > +			break;
> > +
> > +		/* Break if page size changes */
> > +		if (page_order != folio_order(page_folio(page)))
> > +			break;
> > +	}
> > +
> > +	ret = handler(region, flags, page_offset, count);
> > +	if (ret)
> > +		return ret;
> > +
> > +	return count;
> > +}
> > +
> > +/**
> > + * mshv_region_process_range - Processes a range of memory pages in a
> > + *                             region.
> > + * @region     : Pointer to the memory region structure.
> > + * @flags      : Flags to pass to the handler.
> > + * @page_offset: Offset into the region's pages array to start processing.
> > + * @page_count : Number of pages to process.
> > + * @handler    : Callback function to handle each chunk of contiguous
> > + *               pages.
> > + *
> > + * Iterates over the specified range of pages in @region, skipping
> > + * non-present pages. For each contiguous chunk of present pages, invokes
> > + * @handler via mshv_region_process_chunk.
> > + *
> > + * Note: The @handler callback must be able to handle both normal and huge
> > + * pages.
> > + *
> > + * Returns 0 on success, or a negative error code on failure.
> > + */
> > +static int mshv_region_process_range(struct mshv_mem_region *region,
> > +				     u32 flags,
> > +				     u64 page_offset, u64 page_count,
> > +				     int (*handler)(struct mshv_mem_region *region,
> > +						    u32 flags,
> > +						    u64 page_offset,
> > +						    u64 page_count))
> > +{
> > +	long ret;
> > +
> > +	if (page_offset + page_count > region->nr_pages)
> > +		return -EINVAL;
> > +
> > +	while (page_count) {
> > +		/* Skip non-present pages */
> > +		if (!region->pages[page_offset]) {
> > +			page_offset++;
> > +			page_count--;
> > +			continue;
> > +		}
> > +
> > +		ret = mshv_region_process_chunk(region, flags,
> > +						page_offset,
> > +						page_count,
> > +						handler);
> > +		if (ret < 0)
> > +			return ret;
> > +
> > +		page_offset += ret;
> > +		page_count -= ret;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> >  struct mshv_mem_region *mshv_region_create(u64 guest_pfn, u64 nr_pages,
> >  					   u64 uaddr, u32 flags,
> >  					   bool is_mmio)
> > @@ -33,55 +151,80 @@ struct mshv_mem_region *mshv_region_create(u64 guest_pfn, u64 nr_pages,
> >  	if (flags & BIT(MSHV_SET_MEM_BIT_EXECUTABLE))
> >  		region->hv_map_flags |= HV_MAP_GPA_EXECUTABLE;
> > 
> > -	/* Note: large_pages flag populated when we pin the pages */
> >  	if (!is_mmio)
> >  		region->flags.range_pinned = true;
> > 
> >  	return region;
> >  }
> > 
> > +static int mshv_region_chunk_share(struct mshv_mem_region *region,
> > +				   u32 flags,
> > +				   u64 page_offset, u64 page_count)
> > +{
> > +	if (PageTransCompound(region->pages[page_offset]))
> > +		flags |= HV_MODIFY_SPA_PAGE_HOST_ACCESS_LARGE_PAGE;
> 
> mshv_region_process_chunk() uses folio_size() to detect single pages vs. 2 Meg
> large pages. Here you are using PageTransCompound(). Any reason for the
> difference? This may be perfectly OK, but my knowledge of mm is too limited to
> know for sure. Looking at the implementations of folio_size() and
> PageTransCompound(), they seem to be looking at different fields in the struct page,
> and I don't know if the different fields are always in sync. Another case for someone
> with mm expertise to review carefully ....
> 

Indeed, folio_order could be used here as well PageTransCompound could
be used in the chunk processing function (but then the size of the page
would still needed to be checked).
On the other hand, there is subtle difference between the chunk
procesing function and the callback in calls: the latter doesn't
validate the input, thus the chunk processing function should.

Thanks,
Stanislav

> Michael
> 
> > +
> > +	return hv_call_modify_spa_host_access(region->partition->pt_id,
> > +					      region->pages + page_offset,
> > +					      page_count,
> > +					      HV_MAP_GPA_READABLE |
> > +					      HV_MAP_GPA_WRITABLE,
> > +					      flags, true);
> > +}
> > +
> >  int mshv_region_share(struct mshv_mem_region *region)
> >  {
> >  	u32 flags = HV_MODIFY_SPA_PAGE_HOST_ACCESS_MAKE_SHARED;
> > 
> > -	if (region->flags.large_pages)
> > +	return mshv_region_process_range(region, flags,
> > +					 0, region->nr_pages,
> > +					 mshv_region_chunk_share);
> > +}
> > +
> > +static int mshv_region_chunk_unshare(struct mshv_mem_region *region,
> > +				     u32 flags,
> > +				     u64 page_offset, u64 page_count)
> > +{
> > +	if (PageTransCompound(region->pages[page_offset]))
> >  		flags |= HV_MODIFY_SPA_PAGE_HOST_ACCESS_LARGE_PAGE;
> > 
> >  	return hv_call_modify_spa_host_access(region->partition->pt_id,
> > -			region->pages, region->nr_pages,
> > -			HV_MAP_GPA_READABLE | HV_MAP_GPA_WRITABLE,
> > -			flags, true);
> > +					      region->pages + page_offset,
> > +					      page_count, 0,
> > +					      flags, false);
> >  }
> > 
> >  int mshv_region_unshare(struct mshv_mem_region *region)
> >  {
> >  	u32 flags = HV_MODIFY_SPA_PAGE_HOST_ACCESS_MAKE_EXCLUSIVE;
> > 
> > -	if (region->flags.large_pages)
> > -		flags |= HV_MODIFY_SPA_PAGE_HOST_ACCESS_LARGE_PAGE;
> > -
> > -	return hv_call_modify_spa_host_access(region->partition->pt_id,
> > -			region->pages, region->nr_pages,
> > -			0,
> > -			flags, false);
> > +	return mshv_region_process_range(region, flags,
> > +					 0, region->nr_pages,
> > +					 mshv_region_chunk_unshare);
> >  }
> > 
> > -static int mshv_region_remap_pages(struct mshv_mem_region *region,
> > -				   u32 map_flags,
> > +static int mshv_region_chunk_remap(struct mshv_mem_region *region,
> > +				   u32 flags,
> >  				   u64 page_offset, u64 page_count)
> >  {
> > -	if (page_offset + page_count > region->nr_pages)
> > -		return -EINVAL;
> > -
> > -	if (region->flags.large_pages)
> > -		map_flags |= HV_MAP_GPA_LARGE_PAGE;
> > +	if (PageTransCompound(region->pages[page_offset]))
> > +		flags |= HV_MAP_GPA_LARGE_PAGE;
> > 
> >  	return hv_call_map_gpa_pages(region->partition->pt_id,
> >  				     region->start_gfn + page_offset,
> > -				     page_count, map_flags,
> > +				     page_count, flags,
> >  				     region->pages + page_offset);
> >  }
> > 
> > +static int mshv_region_remap_pages(struct mshv_mem_region *region,
> > +				   u32 map_flags,
> > +				   u64 page_offset, u64 page_count)
> > +{
> > +	return mshv_region_process_range(region, map_flags,
> > +					 page_offset, page_count,
> > +					 mshv_region_chunk_remap);
> > +}
> > +
> >  int mshv_region_map(struct mshv_mem_region *region)
> >  {
> >  	u32 map_flags = region->hv_map_flags;
> > @@ -134,9 +277,6 @@ int mshv_region_pin(struct mshv_mem_region *region)
> >  			goto release_pages;
> >  	}
> > 
> > -	if (PageHuge(region->pages[0]))
> > -		region->flags.large_pages = true;
> > -
> >  	return 0;
> > 
> >  release_pages:
> > @@ -144,10 +284,28 @@ int mshv_region_pin(struct mshv_mem_region *region)
> >  	return ret;
> >  }
> > 
> > +static int mshv_region_chunk_unmap(struct mshv_mem_region *region,
> > +				   u32 flags,
> > +				   u64 page_offset, u64 page_count)
> > +{
> > +	if (PageTransCompound(region->pages[page_offset]))
> > +		flags |= HV_UNMAP_GPA_LARGE_PAGE;
> > +
> > +	return hv_call_unmap_gpa_pages(region->partition->pt_id,
> > +				       region->start_gfn + page_offset,
> > +				       page_count, 0);
> > +}
> > +
> > +static int mshv_region_unmap(struct mshv_mem_region *region)
> > +{
> > +	return mshv_region_process_range(region, 0,
> > +					 0, region->nr_pages,
> > +					 mshv_region_chunk_unmap);
> > +}
> > +
> >  void mshv_region_destroy(struct mshv_mem_region *region)
> >  {
> >  	struct mshv_partition *partition = region->partition;
> > -	u32 unmap_flags = 0;
> >  	int ret;
> > 
> >  	hlist_del(&region->hnode);
> > @@ -162,12 +320,7 @@ void mshv_region_destroy(struct mshv_mem_region *region)
> >  		}
> >  	}
> > 
> > -	if (region->flags.large_pages)
> > -		unmap_flags |= HV_UNMAP_GPA_LARGE_PAGE;
> > -
> > -	/* ignore unmap failures and continue as process may be exiting */
> > -	hv_call_unmap_gpa_pages(partition->pt_id, region->start_gfn,
> > -				region->nr_pages, unmap_flags);
> > +	mshv_region_unmap(region);
> > 
> >  	mshv_region_invalidate(region);
> > 
> > diff --git a/drivers/hv/mshv_root.h b/drivers/hv/mshv_root.h
> > index 0366f416c2f0..ff3374f13691 100644
> > --- a/drivers/hv/mshv_root.h
> > +++ b/drivers/hv/mshv_root.h
> > @@ -77,9 +77,8 @@ struct mshv_mem_region {
> >  	u64 start_uaddr;
> >  	u32 hv_map_flags;
> >  	struct {
> > -		u64 large_pages:  1; /* 2MiB */
> >  		u64 range_pinned: 1;
> > -		u64 reserved:	 62;
> > +		u64 reserved:	 63;
> >  	} flags;
> >  	struct mshv_partition *partition;
> >  	struct page *pages[];
> > 
> > 
> 

