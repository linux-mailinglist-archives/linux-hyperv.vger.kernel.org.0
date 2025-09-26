Return-Path: <linux-hyperv+bounces-7001-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E321BA4DC4
	for <lists+linux-hyperv@lfdr.de>; Fri, 26 Sep 2025 20:16:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6CB364E0EB9
	for <lists+linux-hyperv@lfdr.de>; Fri, 26 Sep 2025 18:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 455041D7E31;
	Fri, 26 Sep 2025 18:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="OTPIjypa"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9858B19D8A8;
	Fri, 26 Sep 2025 18:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758910558; cv=none; b=A3xfPBQyv90r8Fkwxhbpb1yQoPmBgJ+cR/TqM5RAqEa/po9641mCOh06A63hWB35ksB4JSqtKV+9PfiN6nhaKv95srbSxijtfgQk671o+gbKBKfzN5tHoYhkc6OPS1aVgZUihbZ3plrCBowQ+BJ5LNeZ2kfzXg0iu9hUIBaUAKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758910558; c=relaxed/simple;
	bh=M+RqIrwCfv2C7Lr4JOEcpOoFWuHmGcWH+RhW+Lq/l5g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CEMp2Chh8zUNN62vYz9R9j7pyLs3TjtcBHGTqTcsLGNU+p6ga2ApgUkCtBmNPS0+hClhtcoAMlOZrDJbbYT46GDMHnVHo/3UC2GY5OokFrcr6bPcTdK3AGsKM6z/9BFdFHfjOpT9wTyAyw9QvkB78KmgU+S8SV5KzEzG31BHcRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=OTPIjypa; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.64.208.103] (unknown [20.191.74.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id 80DC82012C07;
	Fri, 26 Sep 2025 11:15:55 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 80DC82012C07
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1758910555;
	bh=qCs1jWjT2+H6PLYsMdYxCnndVS59gq/Zd0IU8uwLsgw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=OTPIjypaj7ga3kmX9Bc21UUs4KARApsBZrgajGAWIhxZEV2vx49b90z4N1PWOMCC5
	 eLKnpLWAMwE2/id3s0VmSRViy+TwDRmcMz3+uNOxOccfgwbpdwTsDd1PyXZ97mz6Hh
	 0+KzhiW87uV3COL7PSkCC6r+ZTTSBAxBXT0k8DYE=
Message-ID: <66893d19-654e-4ef7-9a9c-c33a5549dbea@linux.microsoft.com>
Date: Fri, 26 Sep 2025 11:15:54 -0700
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] Drivers: hv: Centralize guest memory region
 destruction in helper
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
 kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
References: <175874669044.157998.15064894246017794777.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <175874947750.157998.7004962396456082421.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
Content-Language: en-US
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
In-Reply-To: <175874947750.157998.7004962396456082421.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/24/2025 2:31 PM, Stanislav Kinsburskii wrote:
> This is a precursor and cleanup patch.
> 
This line can be removed, IMO, it doesn't add much.

> - Introduce mshv_partition_destroy_region() to encapsulate memory region
>   cleanup, including:

I think these points should just be short paragraphs instead.

>   - Removing the region from the partition's list
>   - Regaining access for encrypted partitions
>   - Unmapping only mapped pages for efficiency

The optimization here seems like new functionality that should be in a
separate patch. Also, can there be unmapped pages in a region before
patch #3? If not it should be introduced with/after that patch.

>   - Evicting and freeing the region
> 
> - Update mshv_unmap_user_memory() to call mshv_partition_destroy_region()
>   instead of duplicating cleanup logic.
> 
> - Update destroy_partition() to use mshv_partition_destroy_region() for
>   all regions, removing the previous inlined cleanup loop.
> 
> These changes eliminate code duplication, ensure consistent cleanup, and
> improve maintainability for both unmap and partition destruction paths.

This sentence maybe should go first in the description, because it summarizes
the reasoning for the changes nicely.

Also, make sure to describe your changes in imperative mood, e.g. Instead of
"These changes eliminate code duplication..." just "Eliminate code duplication..."

https://docs.kernel.org/process/submitting-patches.html#describe-your-changes

> 
> Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
> ---
>  drivers/hv/mshv_root_main.c |   83 ++++++++++++++++++++++++++-----------------
>  1 file changed, 51 insertions(+), 32 deletions(-)
> 
> diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
> index 5ed6bce334417..c0f6023e459c2 100644
> --- a/drivers/hv/mshv_root_main.c
> +++ b/drivers/hv/mshv_root_main.c
> @@ -1386,13 +1386,59 @@ mshv_map_user_memory(struct mshv_partition *partition,
>  	return ret;
>  }
>  
> +static void mshv_partition_destroy_region(struct mshv_mem_region *region)
> +{
> +	struct mshv_partition *partition = region->partition;
> +	u64 page_offset, page_count;
> +	u32 unmap_flags = 0;
> +	int ret;
> +
> +	hlist_del(&region->hnode);
> +
> +	if (mshv_partition_encrypted(partition)) {
> +		ret = mshv_partition_region_share(region);
> +		if (ret) {
> +			pt_err(partition,
> +			       "Failed to regain access to memory, unpinning user pages will fail and crash the host error: %d\n",
> +			       ret);
> +			return;
> +		}
> +	}
> +
> +	if (region->flags.large_pages)
> +		unmap_flags |= HV_UNMAP_GPA_LARGE_PAGE;
> +
> +	/*
> +	 * Unmap only the mapped pages to optimize performance,
> +	 * especially for large memory regions.
> +	 */
> +	for (page_offset = 0; page_offset < region->nr_pages; page_offset += page_count) {
> +		page_count = 1;
> +		if (!region->pages[page_offset])
> +			continue;
I mentioned it above, but can this even happen in the current code (i.e. without
moveable pages)?

Also, has the impact of this change been measured? I understand the logic behind
the change - there could be large unmapped sequences within the region so we might
be able to skip a lot of reps of the unmap hypercall, but the region could also be
very fragmented and this method might cause *more* reps in that case, right?

Either way, this change belongs in a separate patch.
> +
> +		for (; page_count < region->nr_pages - page_offset; page_count++) {
> +			if (!region->pages[page_offset + page_count])
> +				break;
> +		}
> +
> +		/* ignore unmap failures and continue as process may be exiting */
> +		hv_call_unmap_gpa_pages(partition->pt_id,
> +					region->start_gfn + page_offset,
> +					page_count, unmap_flags);
> +	}
> +
> +	mshv_region_evict(region);
> +
> +	vfree(region);
> +}
> +
>  /* Called for unmapping both the guest ram and the mmio space */
>  static long
>  mshv_unmap_user_memory(struct mshv_partition *partition,
>  		       struct mshv_user_mem_region mem)
>  {
>  	struct mshv_mem_region *region;
> -	u32 unmap_flags = 0;
>  
>  	if (!(mem.flags & BIT(MSHV_SET_MEM_BIT_UNMAP)))
>  		return -EINVAL;
> @@ -1407,18 +1453,7 @@ mshv_unmap_user_memory(struct mshv_partition *partition,
>  	    region->nr_pages != HVPFN_DOWN(mem.size))
>  		return -EINVAL;
>  
> -	hlist_del(&region->hnode);
> -
> -	if (region->flags.large_pages)
> -		unmap_flags |= HV_UNMAP_GPA_LARGE_PAGE;
> -
> -	/* ignore unmap failures and continue as process may be exiting */
> -	hv_call_unmap_gpa_pages(partition->pt_id, region->start_gfn,
> -				region->nr_pages, unmap_flags);
> -
> -	mshv_region_evict(region);
> -
> -	vfree(region);
> +	mshv_partition_destroy_region(region);
>  	return 0;
>  }
>  
> @@ -1754,8 +1789,8 @@ static void destroy_partition(struct mshv_partition *partition)
>  {
>  	struct mshv_vp *vp;
>  	struct mshv_mem_region *region;
> -	int i, ret;
>  	struct hlist_node *n;
> +	int i;
>  
>  	if (refcount_read(&partition->pt_ref_count)) {
>  		pt_err(partition,
> @@ -1815,25 +1850,9 @@ static void destroy_partition(struct mshv_partition *partition)
>  
>  	remove_partition(partition);
>  
> -	/* Remove regions, regain access to the memory and unpin the pages */
>  	hlist_for_each_entry_safe(region, n, &partition->pt_mem_regions,
> -				  hnode) {
> -		hlist_del(&region->hnode);
> -
> -		if (mshv_partition_encrypted(partition)) {
> -			ret = mshv_partition_region_share(region);
> -			if (ret) {
> -				pt_err(partition,
> -				       "Failed to regain access to memory, unpinning user pages will fail and crash the host error: %d\n",
> -				      ret);
> -				return;
> -			}
> -		}
> -
> -		mshv_region_evict(region);
> -
> -		vfree(region);
> -	}
> +				  hnode)
> +		mshv_partition_destroy_region(region);
>  
>  	/* Withdraw and free all pages we deposited */
>  	hv_call_withdraw_memory(U64_MAX, NUMA_NO_NODE, partition->pt_id);
> 
> 


