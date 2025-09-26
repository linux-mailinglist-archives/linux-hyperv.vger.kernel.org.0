Return-Path: <linux-hyperv+bounces-7000-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 911CEBA4C21
	for <lists+linux-hyperv@lfdr.de>; Fri, 26 Sep 2025 19:14:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E65F11BC854A
	for <lists+linux-hyperv@lfdr.de>; Fri, 26 Sep 2025 17:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 588A930C609;
	Fri, 26 Sep 2025 17:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="nyFs2Qp1"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3B4A15278E;
	Fri, 26 Sep 2025 17:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758906869; cv=none; b=bc7jTYjSKppbZGbArsuhmG8HAo9geDTeSRBNrSsLd7+8LI1gTcktWi8QcuGKQuEfYqeYOs7/PHj3/UPNJirHNsCD0BYwGzcD/VkWns7aoB0ZjavMuKzsPjjvDTdCBw4i4aNhtP6jDtR79/qk7erEOE8H7IGwZSU6eUmi+Z1SkC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758906869; c=relaxed/simple;
	bh=F56XhL2WB5+Raoz6SFJqw1y6IuAiLOaE8CMfxRCc91Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BsU4YFoygNMZyCwWKvhOZeoZVXdvcWJss4zdiziyifozGak9GPWxLi5NzRR9NPI+K8SbA08QJN2dkDtzG6YgjJegzRmFikWWI+fW/GvsZV1YS4bVUmvgmbgVoctQO3HhmDEUkg10tFlVyDp/GFMiCbrJATAvjDk4G3ZulOBWbLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=nyFs2Qp1; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.64.208.103] (unknown [20.191.74.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id D2B9B2012C01;
	Fri, 26 Sep 2025 10:14:26 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D2B9B2012C01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1758906867;
	bh=lhA5ubL5wAIX7qegcOZTUKfUmVT9AAUyNQ2Jl0en+x4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=nyFs2Qp1fpLPb6vjj9fsP9omY3zs7IC/bzLKMeIvuIdU6VCkw2NiOTkhh3W0cvBqM
	 83zUG2d2U6JhiBVqVI8+U9bJjzI3EY4XYvtKM5UYfWhpfdsp/r5mVQJHC/XiWrVx5q
	 Ua4ALvV+MKRHWc/jLe3vGWtSQyEPT7j2ZKcs5N5M=
Message-ID: <6165c48c-a71e-4aa0-99d3-2ff8158ddd4a@linux.microsoft.com>
Date: Fri, 26 Sep 2025 10:14:25 -0700
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] Drivers: hv: Rename a few memory region related
 functions for clarity
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
 kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
References: <175874669044.157998.15064894246017794777.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <175874946244.157998.2185691597101633735.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
Content-Language: en-US
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
In-Reply-To: <175874946244.157998.2185691597101633735.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/24/2025 2:31 PM, Stanislav Kinsburskii wrote:
> A cleanup and precursor patch.
> 
This line doesn't add much, I think you can remove it.

> Rename "mshv_partition_mem_region_map" to "mshv_handle_pinned_region",
> "mshv_region_populate" to "mshv_pin_region" and
> "mshv_region_populate_pages" to "mshv_region_pin_pages"
> to better reflect its purpose of handling pinned memory regions.
> 
> Update the "mshv_handle_pinned_region" function's documentation to provide
> detailed information about its behavior and return values.
> 
> Also drop the check for range as pinned, as this function is static and
> all the memory regions are pinned anyway.
> 
> Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
> ---
>  drivers/hv/mshv_root_main.c |   41 ++++++++++++++++++++++-------------------
>  1 file changed, 22 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
> index a1c8c3bc79bf1..5ed6bce334417 100644
> --- a/drivers/hv/mshv_root_main.c
> +++ b/drivers/hv/mshv_root_main.c
> @@ -1137,8 +1137,8 @@ mshv_region_evict(struct mshv_mem_region *region)
>  }
>  
>  static int
> -mshv_region_populate_pages(struct mshv_mem_region *region,
> -			   u64 page_offset, u64 page_count)
> +mshv_region_pin_pages(struct mshv_mem_region *region,
> +		      u64 page_offset, u64 page_count)
>  {
>  	u64 done_count, nr_pages;
>  	struct page **pages;
> @@ -1164,14 +1164,9 @@ mshv_region_populate_pages(struct mshv_mem_region *region,
>  		 * with the FOLL_LONGTERM flag does a large temporary
>  		 * allocation of contiguous memory.
>  		 */
> -		if (region->flags.range_pinned)
> -			ret = pin_user_pages_fast(userspace_addr,
> -						  nr_pages,
> -						  FOLL_WRITE | FOLL_LONGTERM,
> -						  pages);
> -		else
> -			ret = -EOPNOTSUPP;
> -
> +		ret = pin_user_pages_fast(userspace_addr, nr_pages,
> +					  FOLL_WRITE | FOLL_LONGTERM,
> +					  pages);
>  		if (ret < 0)
>  			goto release_pages;
>  	}
> @@ -1187,9 +1182,9 @@ mshv_region_populate_pages(struct mshv_mem_region *region,
>  }
>  
>  static int
> -mshv_region_populate(struct mshv_mem_region *region)
> +mshv_region_pin(struct mshv_mem_region *region)
>  {
> -	return mshv_region_populate_pages(region, 0, region->nr_pages);
> +	return mshv_region_pin_pages(region, 0, region->nr_pages);
>  }
Do we ever partially pin a region? Maybe we don't need a function called
mshv_region_pin_pages() and we just have mshv_region_pin() instead.

>  
>  static struct mshv_mem_region *
> @@ -1264,17 +1259,25 @@ static int mshv_partition_create_region(struct mshv_partition *partition,
>  	return 0;
>  }
>  
> -/*
> - * Map guest ram. if snp, make sure to release that from the host first
> - * Side Effects: In case of failure, pages are unpinned when feasible.
> +/**
> + * mshv_handle_pinned_region - Handle pinned memory regions
> + * @region: Pointer to the memory region structure
> + *
> + * This function processes memory regions that are explicitly marked as pinned.
> + * Pinned regions are preallocated, mapped upfront, and do not rely on fault-based
> + * population. The function ensures the region is properly populated, handles
> + * encryption requirements for SNP partitions if applicable, maps the region,
> + * and performs necessary sharing or eviction operations based on the mapping
> + * result.
> + *
> + * Return: 0 on success, negative error code on failure.
>   */
> -static int
> -mshv_partition_mem_region_map(struct mshv_mem_region *region)
> +static int mshv_handle_pinned_region(struct mshv_mem_region *region)

Why the verb "handle"? It doesn't provide any information on what the function does,
when it might be called etc. Maybe mshv_init_pinned_region() ?

>  {
>  	struct mshv_partition *partition = region->partition;
>  	int ret;
>  
> -	ret = mshv_region_populate(region);
> +	ret = mshv_region_pin(region);
>  	if (ret) {
>  		pt_err(partition, "Failed to populate memory region: %d\n",
>  		       ret);
> @@ -1368,7 +1371,7 @@ mshv_map_user_memory(struct mshv_partition *partition,
>  		ret = hv_call_map_mmio_pages(partition->pt_id, mem.guest_pfn,
>  					     mmio_pfn, HVPFN_DOWN(mem.size));
>  	else
> -		ret = mshv_partition_mem_region_map(region);
> +		ret = mshv_handle_pinned_region(region);
>  
>  	if (ret)
>  		goto errout;
> 
> 


