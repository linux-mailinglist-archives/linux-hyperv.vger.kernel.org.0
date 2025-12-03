Return-Path: <linux-hyperv+bounces-7943-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 88D47CA1789
	for <lists+linux-hyperv@lfdr.de>; Wed, 03 Dec 2025 20:51:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 50F343013559
	for <lists+linux-hyperv@lfdr.de>; Wed,  3 Dec 2025 19:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF8D630C343;
	Wed,  3 Dec 2025 19:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="TynQi20y"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED6E5304BB3;
	Wed,  3 Dec 2025 19:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764791282; cv=none; b=GOtf+YM55Wai7SUEG61d5T3rT1K3qiMJxjSIa5prYH9/KpJ9PCZyXPA0pmZ5hmlc4L4jfFszcq8TNsxdZ0zx59l0dJN4K8cPamutGnhwot6gtI+4lRjtMh/qcH5tffhbAlGqn4wx89EGGMWri6qeiyvWPzJgNSOqRRJI2bn7Jv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764791282; c=relaxed/simple;
	bh=13MXun50sKC7GmNleAqlUxWznnxmYCJO8BI3ZVpTAVo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IlLE/7uguhcZ37zyhcfBorWDmHmwvU4sPRUSxBtGBjjF2VJJRG2JUBN+au+aDMzNwnZuiYPrRGS+PjSPUiuiDlLnahIT9X5+/hOzUSmmlNT8d5rrIzXTK9Wp7bZdoazcALiB7OvZyO7rA8y7PBcGWBBBrn9lF0RFfzQ6u8nk1nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=TynQi20y; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.64.161.205] (unknown [52.148.140.42])
	by linux.microsoft.com (Postfix) with ESMTPSA id 832AC2120731;
	Wed,  3 Dec 2025 11:47:59 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 832AC2120731
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1764791279;
	bh=O0RlC/8L6t3mL1OhwJOmQXaTNM3d2ESt9lroZ4SU8uY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=TynQi20yu2Mso9IDsEenW1vwU2vRsmj2TvQnm4c+7r+kS8XVF44f2IfOcowAvvYLW
	 mUQGTDcc9ZwuHdgETKkQH9OkaHW2SVkqsMOmxgeXnccq31c8CDLnSfJ6xliN9AziVe
	 ysSgUmuFRImjmTqV4V1z1h8+zDulEJzUBJfRwNtE=
Message-ID: <b865edd4-261c-4a71-be29-b595c60d2d01@linux.microsoft.com>
Date: Wed, 3 Dec 2025 11:47:58 -0800
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 4/6] Drivers: hv: Fix huge page handling in memory
 region traversal
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
 kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
References: <176478581828.114132.13305536829966527782.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <176478626161.114132.15355588085583516799.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
Content-Language: en-US
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
In-Reply-To: <176478626161.114132.15355588085583516799.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/3/2025 10:24 AM, Stanislav Kinsburskii wrote:
> The previous code assumed that if a region's first page was huge, the
> entire region consisted of huge pages and stored this in a large_pages
> flag. This premise is incorrect not only for movable regions (where
> pages can be split and merged on invalidate callbacks or page faults),
> but even for pinned regions: THPs can be split and merged during
> allocation, so a large, pinned region may contain a mix of huge and
> regular pages.
> 
> This change removes the large_pages flag and replaces region-wide
> assumptions with per-chunk inspection of the actual page size when
> mapping, unmapping, sharing, and unsharing. This makes huge page
> handling correct for mixed-page regions and avoids relying on stale
> metadata that can easily become invalid as memory is remapped.
> 
> Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
> Reviewed-by: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>

I was still looking at v7 when you posted v8 of this series.
Re-posting my review of this patch here so the discussion can be in the
right thread.

> ---
>  drivers/hv/mshv_regions.c |  213 +++++++++++++++++++++++++++++++++++++++------
>  drivers/hv/mshv_root.h    |    3 -
>  2 files changed, 184 insertions(+), 32 deletions(-)
> 
> diff --git a/drivers/hv/mshv_regions.c b/drivers/hv/mshv_regions.c
> index 35b866670840..1356f68ccb29 100644
> --- a/drivers/hv/mshv_regions.c
> +++ b/drivers/hv/mshv_regions.c
> @@ -14,6 +14,124 @@
>  
>  #include "mshv_root.h"
>  
> +/**
> + * mshv_region_process_chunk - Processes a contiguous chunk of memory pages
> + *                             in a region.
> + * @region     : Pointer to the memory region structure.
> + * @flags      : Flags to pass to the handler.
> + * @page_offset: Offset into the region's pages array to start processing.
> + * @page_count : Number of pages to process.
> + * @handler    : Callback function to handle the chunk.
> + *
> + * This function scans the region's pages starting from @page_offset,
> + * checking for contiguous present pages of the same size (normal or huge).
> + * It invokes @handler for the chunk of contiguous pages found. Returns the
> + * number of pages handled, or a negative error code if the first page is
> + * not present or the handler fails.
> + *
> + * Note: The @handler callback must be able to handle both normal and huge
> + * pages.
> + *
> + * Return: Number of pages handled, or negative error code.
> + */
> +static long mshv_region_process_chunk(struct mshv_mem_region *region,
> +				      u32 flags,
> +				      u64 page_offset, u64 page_count,
> +				      int (*handler)(struct mshv_mem_region *region,
> +						     u32 flags,
> +						     u64 page_offset,
> +						     u64 page_count))
> +{
> +	u64 count, stride;
> +	unsigned int page_order;
> +	struct page *page;
> +	int ret;
> +
> +	page = region->pages[page_offset];
> +	if (!page)
> +		return -EINVAL;
> +
> +	page_order = folio_order(page_folio(page));
> +	/* 1G huge pages aren't supported by the hypercalls */
> +	if (page_order == PUD_ORDER)
> +		return -EINVAL;
> +

I'd prefer to be explicit about exactly which page_orders we *do*
support instead of just disallowing PUD_ORDER.

Without looking up folio_order(), there's an implication here that
page_order can be anything except PUD_ORDER, but that's not the case;
there's only 2 valid values for page_order.

The comment can instead read something like:
"The hypervisor only supports 4K and 2M page sizes"

> +	stride = 1 << page_order;
> +
> +	/* Start at stride since the first page is validated */
> +	for (count = stride; count < page_count; count += stride) {
> +		page = region->pages[page_offset + count];
> +
> +		/* Break if current page is not present */
> +		if (!page)
> +			break;
> +
> +		/* Break if page size changes */
> +		if (page_order != folio_order(page_folio(page)))
> +			break;
> +	}
> +
> +	ret = handler(region, flags, page_offset, count);
> +	if (ret)
> +		return ret;
> +
> +	return count;
> +}
> +
> +/**
> + * mshv_region_process_range - Processes a range of memory pages in a
> + *                             region.
> + * @region     : Pointer to the memory region structure.
> + * @flags      : Flags to pass to the handler.
> + * @page_offset: Offset into the region's pages array to start processing.
> + * @page_count : Number of pages to process.
> + * @handler    : Callback function to handle each chunk of contiguous
> + *               pages.
> + *
> + * Iterates over the specified range of pages in @region, skipping
> + * non-present pages. For each contiguous chunk of present pages, invokes
> + * @handler via mshv_region_process_chunk.
> + *
> + * Note: The @handler callback must be able to handle both normal and huge
> + * pages.
> + *
> + * Returns 0 on success, or a negative error code on failure.
> + */
> +static int mshv_region_process_range(struct mshv_mem_region *region,
> +				     u32 flags,
> +				     u64 page_offset, u64 page_count,
> +				     int (*handler)(struct mshv_mem_region *region,
> +						    u32 flags,
> +						    u64 page_offset,
> +						    u64 page_count))
> +{
> +	long ret;
> +
> +	if (page_offset + page_count > region->nr_pages)
> +		return -EINVAL;
> +
> +	while (page_count) {
> +		/* Skip non-present pages */
> +		if (!region->pages[page_offset]) {
> +			page_offset++;
> +			page_count--;
> +			continue;
> +		}
> +
> +		ret = mshv_region_process_chunk(region, flags,
> +						page_offset,
> +						page_count,
> +						handler);
> +		if (ret < 0)
> +			return ret;
> +
> +		page_offset += ret;
> +		page_count -= ret;
> +	}
> +
> +	return 0;
> +}
> +
>  struct mshv_mem_region *mshv_region_create(u64 guest_pfn, u64 nr_pages,
>  					   u64 uaddr, u32 flags,
>  					   bool is_mmio)
> @@ -33,55 +151,80 @@ struct mshv_mem_region *mshv_region_create(u64 guest_pfn, u64 nr_pages,
>  	if (flags & BIT(MSHV_SET_MEM_BIT_EXECUTABLE))
>  		region->hv_map_flags |= HV_MAP_GPA_EXECUTABLE;
>  
> -	/* Note: large_pages flag populated when we pin the pages */
>  	if (!is_mmio)
>  		region->flags.range_pinned = true;
>  
>  	return region;
>  }
>  
> +static int mshv_region_chunk_share(struct mshv_mem_region *region,
> +				   u32 flags,
> +				   u64 page_offset, u64 page_count)
> +{
> +	if (PageTransCompound(region->pages[page_offset]))
> +		flags |= HV_MODIFY_SPA_PAGE_HOST_ACCESS_LARGE_PAGE;

PageTransCompound() returns false if CONFIG_TRANSPARENT_HUGEPAGE is not
enabled. This won't work for hugetlb pages, will it?

Do we need to check if (PageHuge(page) || PageTransCompound(page)) ?

> +
> +	return hv_call_modify_spa_host_access(region->partition->pt_id,
> +					      region->pages + page_offset,
> +					      page_count,
> +					      HV_MAP_GPA_READABLE |
> +					      HV_MAP_GPA_WRITABLE,
> +					      flags, true);
> +}
> +
>  int mshv_region_share(struct mshv_mem_region *region)
>  {
>  	u32 flags = HV_MODIFY_SPA_PAGE_HOST_ACCESS_MAKE_SHARED;
>  
> -	if (region->flags.large_pages)
> +	return mshv_region_process_range(region, flags,
> +					 0, region->nr_pages,
> +					 mshv_region_chunk_share);
> +}
> +
> +static int mshv_region_chunk_unshare(struct mshv_mem_region *region,
> +				     u32 flags,
> +				     u64 page_offset, u64 page_count)
> +{
> +	if (PageTransCompound(region->pages[page_offset]))
>  		flags |= HV_MODIFY_SPA_PAGE_HOST_ACCESS_LARGE_PAGE;
>  
>  	return hv_call_modify_spa_host_access(region->partition->pt_id,
> -			region->pages, region->nr_pages,
> -			HV_MAP_GPA_READABLE | HV_MAP_GPA_WRITABLE,
> -			flags, true);
> +					      region->pages + page_offset,
> +					      page_count, 0,
> +					      flags, false);
>  }
>  
>  int mshv_region_unshare(struct mshv_mem_region *region)
>  {
>  	u32 flags = HV_MODIFY_SPA_PAGE_HOST_ACCESS_MAKE_EXCLUSIVE;
>  
> -	if (region->flags.large_pages)
> -		flags |= HV_MODIFY_SPA_PAGE_HOST_ACCESS_LARGE_PAGE;
> -
> -	return hv_call_modify_spa_host_access(region->partition->pt_id,
> -			region->pages, region->nr_pages,
> -			0,
> -			flags, false);
> +	return mshv_region_process_range(region, flags,
> +					 0, region->nr_pages,
> +					 mshv_region_chunk_unshare);
>  }
>  
> -static int mshv_region_remap_pages(struct mshv_mem_region *region,
> -				   u32 map_flags,
> +static int mshv_region_chunk_remap(struct mshv_mem_region *region,
> +				   u32 flags,
>  				   u64 page_offset, u64 page_count)

nit: Why the name change from map_flags to flags? It creates some
noise here.

>  {
> -	if (page_offset + page_count > region->nr_pages)
> -		return -EINVAL;
> -
> -	if (region->flags.large_pages)
> -		map_flags |= HV_MAP_GPA_LARGE_PAGE;
> +	if (PageTransCompound(region->pages[page_offset]))
> +		flags |= HV_MAP_GPA_LARGE_PAGE;
>  
>  	return hv_call_map_gpa_pages(region->partition->pt_id,
>  				     region->start_gfn + page_offset,
> -				     page_count, map_flags,
> +				     page_count, flags,
>  				     region->pages + page_offset);
>  }
>  
> +static int mshv_region_remap_pages(struct mshv_mem_region *region,
> +				   u32 map_flags,
> +				   u64 page_offset, u64 page_count)
> +{
> +	return mshv_region_process_range(region, map_flags,
> +					 page_offset, page_count,
> +					 mshv_region_chunk_remap);
> +}
> +
>  int mshv_region_map(struct mshv_mem_region *region)
>  {
>  	u32 map_flags = region->hv_map_flags;
> @@ -134,9 +277,6 @@ int mshv_region_pin(struct mshv_mem_region *region)
>  			goto release_pages;
>  	}
>  
> -	if (PageHuge(region->pages[0]))
> -		region->flags.large_pages = true;
> -
>  	return 0;
>  
>  release_pages:
> @@ -144,10 +284,28 @@ int mshv_region_pin(struct mshv_mem_region *region)
>  	return ret;
>  }
>  
> +static int mshv_region_chunk_unmap(struct mshv_mem_region *region,
> +				   u32 flags,
> +				   u64 page_offset, u64 page_count)
> +{
> +	if (PageTransCompound(region->pages[page_offset]))
> +		flags |= HV_UNMAP_GPA_LARGE_PAGE;
> +
> +	return hv_call_unmap_gpa_pages(region->partition->pt_id,
> +				       region->start_gfn + page_offset,
> +				       page_count, flags);
> +}
> +
> +static int mshv_region_unmap(struct mshv_mem_region *region)
> +{
> +	return mshv_region_process_range(region, 0,
> +					 0, region->nr_pages,
> +					 mshv_region_chunk_unmap);
> +}
> +
>  void mshv_region_destroy(struct mshv_mem_region *region)
>  {
>  	struct mshv_partition *partition = region->partition;
> -	u32 unmap_flags = 0;
>  	int ret;
>  
>  	hlist_del(&region->hnode);
> @@ -162,12 +320,7 @@ void mshv_region_destroy(struct mshv_mem_region *region)
>  		}
>  	}
>  
> -	if (region->flags.large_pages)
> -		unmap_flags |= HV_UNMAP_GPA_LARGE_PAGE;
> -
> -	/* ignore unmap failures and continue as process may be exiting */
> -	hv_call_unmap_gpa_pages(partition->pt_id, region->start_gfn,
> -				region->nr_pages, unmap_flags);
> +	mshv_region_unmap(region);
>  
>  	mshv_region_invalidate(region);
>  
> diff --git a/drivers/hv/mshv_root.h b/drivers/hv/mshv_root.h
> index 0366f416c2f0..ff3374f13691 100644
> --- a/drivers/hv/mshv_root.h
> +++ b/drivers/hv/mshv_root.h
> @@ -77,9 +77,8 @@ struct mshv_mem_region {
>  	u64 start_uaddr;
>  	u32 hv_map_flags;
>  	struct {
> -		u64 large_pages:  1; /* 2MiB */
>  		u64 range_pinned: 1;
> -		u64 reserved:	 62;
> +		u64 reserved:	 63;
>  	} flags;
>  	struct mshv_partition *partition;
>  	struct page *pages[];
> 
> 


