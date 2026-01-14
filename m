Return-Path: <linux-hyperv+bounces-8281-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E054AD1BD49
	for <lists+linux-hyperv@lfdr.de>; Wed, 14 Jan 2026 01:41:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 969E93019194
	for <lists+linux-hyperv@lfdr.de>; Wed, 14 Jan 2026 00:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DDAD1D5ABA;
	Wed, 14 Jan 2026 00:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Lbf1Sqex"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EA9E1A08AF
	for <linux-hyperv@vger.kernel.org>; Wed, 14 Jan 2026 00:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768351274; cv=none; b=ira+6ElVxCvNew+VESJaV2Twu+UWWFjN1OFSfAO5cB0yHJslTEWJ9wGr7r5+CcuLs6R+waqZiFDkexplSn5AGJDeOXFofG0dRKAPqmPOor9t7lwRg7FnJk7KyYPe7eCwwjJNrmO8Vv5HQtczrM7hJuQbNuZsVn4dYtGiHF6PlJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768351274; c=relaxed/simple;
	bh=VgKKjYiqnYnAeueHrcrTggKN7xjWLttTdGnEDkGEblQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FWoyTJHJ+jxfo65ZfhUlIJk4r33CKcs/5ZJlM1xSUt0WHm65gNpvPVmJr4Az1kTrb34VrMjR/wsPrsbejXg256N/cVcErOpBIyesazJR72MnOIaVal7LrjfaYXqAOvNB97xBBQWbtw6mYXUkKCOjc1BReJtm2KmIY+NXu8sm8Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Lbf1Sqex; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii.localdomain (unknown [52.148.140.42])
	by linux.microsoft.com (Postfix) with ESMTPSA id 8B62D20B7165;
	Tue, 13 Jan 2026 16:41:09 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8B62D20B7165
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1768351269;
	bh=O7bKS0vm7dq30JeRN/aIA8W4b5uAK9gbRaq6BkOs6aE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Lbf1SqexcqBBv6garwWiX7DGAUA77GWESRVpLQoiPhCOq1OI2RHwiNh8NENkDZLLT
	 L8ySgNNW9AxkTTPvKsLoXDUfmGRhrDU7FnmknLNQOXy1wZmN9JduzjACO+U4M4AtVG
	 IhGJoUiXz4W2TDXYOZC3pNup/+82rIrH3rdcHXvE=
Date: Tue, 13 Jan 2026 16:41:08 -0800
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: Mukesh Rathor <mrathor@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, wei.liu@kernel.org,
	nunodasneves@linux.microsoft.com
Subject: Re: [PATCH] mshv: make certain field names descriptive in a header
 struct
Message-ID: <aWbmJPkrJyICk4Rh@skinsburskii.localdomain>
References: <20260109200611.1422390-1-mrathor@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260109200611.1422390-1-mrathor@linux.microsoft.com>

On Fri, Jan 09, 2026 at 12:06:11PM -0800, Mukesh Rathor wrote:
> There is no functional change. Just make couple field names in
> struct mshv_mem_region, in a header that can be used in many
> places, a little descriptive to make code easier to read by
> allowing better support for grep, cscope, etc.
> 
> Signed-off-by: Mukesh Rathor <mrathor@linux.microsoft.com>
> ---
>  drivers/hv/mshv_regions.c   | 44 ++++++++++++++++++-------------------
>  drivers/hv/mshv_root.h      |  6 ++---
>  drivers/hv/mshv_root_main.c | 10 ++++-----
>  3 files changed, 30 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/hv/mshv_regions.c b/drivers/hv/mshv_regions.c
> index 202b9d551e39..af81405f859b 100644
> --- a/drivers/hv/mshv_regions.c
> +++ b/drivers/hv/mshv_regions.c
> @@ -52,7 +52,7 @@ static long mshv_region_process_chunk(struct mshv_mem_region *region,
>  	struct page *page;
>  	int ret;
>  
> -	page = region->pages[page_offset];
> +	page = region->mreg_pages[page_offset];

What does "m" mean here - "mreg_pages"? Is it "memory region"?
If so, then it's misleading, because the same region stuct is used to
the MMIO regions as well. Maybe "region_pages" would be better?

Also, while we're at it, maybe rename "mshv_mem_region" to "mshv_region" to reflect that?

Thanks,
Stanislav

>  	if (!page)
>  		return -EINVAL;
>  
> @@ -65,7 +65,7 @@ static long mshv_region_process_chunk(struct mshv_mem_region *region,
>  
>  	/* Start at stride since the first page is validated */
>  	for (count = stride; count < page_count; count += stride) {
> -		page = region->pages[page_offset + count];
> +		page = region->mreg_pages[page_offset + count];
>  
>  		/* Break if current page is not present */
>  		if (!page)
> @@ -117,7 +117,7 @@ static int mshv_region_process_range(struct mshv_mem_region *region,
>  
>  	while (page_count) {
>  		/* Skip non-present pages */
> -		if (!region->pages[page_offset]) {
> +		if (!region->mreg_pages[page_offset]) {
>  			page_offset++;
>  			page_count--;
>  			continue;
> @@ -164,13 +164,13 @@ static int mshv_region_chunk_share(struct mshv_mem_region *region,
>  				   u32 flags,
>  				   u64 page_offset, u64 page_count)
>  {
> -	struct page *page = region->pages[page_offset];
> +	struct page *page = region->mreg_pages[page_offset];
>  
>  	if (PageHuge(page) || PageTransCompound(page))
>  		flags |= HV_MODIFY_SPA_PAGE_HOST_ACCESS_LARGE_PAGE;
>  
>  	return hv_call_modify_spa_host_access(region->partition->pt_id,
> -					      region->pages + page_offset,
> +					      region->mreg_pages + page_offset,
>  					      page_count,
>  					      HV_MAP_GPA_READABLE |
>  					      HV_MAP_GPA_WRITABLE,
> @@ -190,13 +190,13 @@ static int mshv_region_chunk_unshare(struct mshv_mem_region *region,
>  				     u32 flags,
>  				     u64 page_offset, u64 page_count)
>  {
> -	struct page *page = region->pages[page_offset];
> +	struct page *page = region->mreg_pages[page_offset];
>  
>  	if (PageHuge(page) || PageTransCompound(page))
>  		flags |= HV_MODIFY_SPA_PAGE_HOST_ACCESS_LARGE_PAGE;
>  
>  	return hv_call_modify_spa_host_access(region->partition->pt_id,
> -					      region->pages + page_offset,
> +					      region->mreg_pages + page_offset,
>  					      page_count, 0,
>  					      flags, false);
>  }
> @@ -214,7 +214,7 @@ static int mshv_region_chunk_remap(struct mshv_mem_region *region,
>  				   u32 flags,
>  				   u64 page_offset, u64 page_count)
>  {
> -	struct page *page = region->pages[page_offset];
> +	struct page *page = region->mreg_pages[page_offset];
>  
>  	if (PageHuge(page) || PageTransCompound(page))
>  		flags |= HV_MAP_GPA_LARGE_PAGE;
> @@ -222,7 +222,7 @@ static int mshv_region_chunk_remap(struct mshv_mem_region *region,
>  	return hv_call_map_gpa_pages(region->partition->pt_id,
>  				     region->start_gfn + page_offset,
>  				     page_count, flags,
> -				     region->pages + page_offset);
> +				     region->mreg_pages + page_offset);
>  }
>  
>  static int mshv_region_remap_pages(struct mshv_mem_region *region,
> @@ -245,10 +245,10 @@ int mshv_region_map(struct mshv_mem_region *region)
>  static void mshv_region_invalidate_pages(struct mshv_mem_region *region,
>  					 u64 page_offset, u64 page_count)
>  {
> -	if (region->type == MSHV_REGION_TYPE_MEM_PINNED)
> -		unpin_user_pages(region->pages + page_offset, page_count);
> +	if (region->mreg_type == MSHV_REGION_TYPE_MEM_PINNED)
> +		unpin_user_pages(region->mreg_pages + page_offset, page_count);
>  
> -	memset(region->pages + page_offset, 0,
> +	memset(region->mreg_pages + page_offset, 0,
>  	       page_count * sizeof(struct page *));
>  }
>  
> @@ -265,7 +265,7 @@ int mshv_region_pin(struct mshv_mem_region *region)
>  	int ret;
>  
>  	for (done_count = 0; done_count < region->nr_pages; done_count += ret) {
> -		pages = region->pages + done_count;
> +		pages = region->mreg_pages + done_count;
>  		userspace_addr = region->start_uaddr +
>  				 done_count * HV_HYP_PAGE_SIZE;
>  		nr_pages = min(region->nr_pages - done_count,
> @@ -297,7 +297,7 @@ static int mshv_region_chunk_unmap(struct mshv_mem_region *region,
>  				   u32 flags,
>  				   u64 page_offset, u64 page_count)
>  {
> -	struct page *page = region->pages[page_offset];
> +	struct page *page = region->mreg_pages[page_offset];
>  
>  	if (PageHuge(page) || PageTransCompound(page))
>  		flags |= HV_UNMAP_GPA_LARGE_PAGE;
> @@ -321,7 +321,7 @@ static void mshv_region_destroy(struct kref *ref)
>  	struct mshv_partition *partition = region->partition;
>  	int ret;
>  
> -	if (region->type == MSHV_REGION_TYPE_MEM_MOVABLE)
> +	if (region->mreg_type == MSHV_REGION_TYPE_MEM_MOVABLE)
>  		mshv_region_movable_fini(region);
>  
>  	if (mshv_partition_encrypted(partition)) {
> @@ -374,9 +374,9 @@ static int mshv_region_hmm_fault_and_lock(struct mshv_mem_region *region,
>  	int ret;
>  
>  	range->notifier_seq = mmu_interval_read_begin(range->notifier);
> -	mmap_read_lock(region->mni.mm);
> +	mmap_read_lock(region->mreg_mni.mm);
>  	ret = hmm_range_fault(range);
> -	mmap_read_unlock(region->mni.mm);
> +	mmap_read_unlock(region->mreg_mni.mm);
>  	if (ret)
>  		return ret;
>  
> @@ -407,7 +407,7 @@ static int mshv_region_range_fault(struct mshv_mem_region *region,
>  				   u64 page_offset, u64 page_count)
>  {
>  	struct hmm_range range = {
> -		.notifier = &region->mni,
> +		.notifier = &region->mreg_mni,
>  		.default_flags = HMM_PFN_REQ_FAULT | HMM_PFN_REQ_WRITE,
>  	};
>  	unsigned long *pfns;
> @@ -430,7 +430,7 @@ static int mshv_region_range_fault(struct mshv_mem_region *region,
>  		goto out;
>  
>  	for (i = 0; i < page_count; i++)
> -		region->pages[page_offset + i] = hmm_pfn_to_page(pfns[i]);
> +		region->mreg_pages[page_offset + i] = hmm_pfn_to_page(pfns[i]);
>  
>  	ret = mshv_region_remap_pages(region, region->hv_map_flags,
>  				      page_offset, page_count);
> @@ -489,7 +489,7 @@ static bool mshv_region_interval_invalidate(struct mmu_interval_notifier *mni,
>  {
>  	struct mshv_mem_region *region = container_of(mni,
>  						      struct mshv_mem_region,
> -						      mni);
> +						      mreg_mni);
>  	u64 page_offset, page_count;
>  	unsigned long mstart, mend;
>  	int ret = -EPERM;
> @@ -535,14 +535,14 @@ static const struct mmu_interval_notifier_ops mshv_region_mni_ops = {
>  
>  void mshv_region_movable_fini(struct mshv_mem_region *region)
>  {
> -	mmu_interval_notifier_remove(&region->mni);
> +	mmu_interval_notifier_remove(&region->mreg_mni);
>  }
>  
>  bool mshv_region_movable_init(struct mshv_mem_region *region)
>  {
>  	int ret;
>  
> -	ret = mmu_interval_notifier_insert(&region->mni, current->mm,
> +	ret = mmu_interval_notifier_insert(&region->mreg_mni, current->mm,
>  					   region->start_uaddr,
>  					   region->nr_pages << HV_HYP_PAGE_SHIFT,
>  					   &mshv_region_mni_ops);
> diff --git a/drivers/hv/mshv_root.h b/drivers/hv/mshv_root.h
> index 3c1d88b36741..f5b6d3979e5a 100644
> --- a/drivers/hv/mshv_root.h
> +++ b/drivers/hv/mshv_root.h
> @@ -85,10 +85,10 @@ struct mshv_mem_region {
>  	u64 start_uaddr;
>  	u32 hv_map_flags;
>  	struct mshv_partition *partition;
> -	enum mshv_region_type type;
> -	struct mmu_interval_notifier mni;
> +	enum mshv_region_type mreg_type;
> +	struct mmu_interval_notifier mreg_mni;
>  	struct mutex mutex;	/* protects region pages remapping */
> -	struct page *pages[];
> +	struct page *mreg_pages[];
>  };
>  
>  struct mshv_irq_ack_notifier {
> diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
> index 1134a82c7881..eff1b21461dc 100644
> --- a/drivers/hv/mshv_root_main.c
> +++ b/drivers/hv/mshv_root_main.c
> @@ -657,7 +657,7 @@ static bool mshv_handle_gpa_intercept(struct mshv_vp *vp)
>  		return false;
>  
>  	/* Only movable memory ranges are supported for GPA intercepts */
> -	if (region->type == MSHV_REGION_TYPE_MEM_MOVABLE)
> +	if (region->mreg_type == MSHV_REGION_TYPE_MEM_MOVABLE)
>  		ret = mshv_region_handle_gfn_fault(region, gfn);
>  	else
>  		ret = false;
> @@ -1175,12 +1175,12 @@ static int mshv_partition_create_region(struct mshv_partition *partition,
>  		return PTR_ERR(rg);
>  
>  	if (is_mmio)
> -		rg->type = MSHV_REGION_TYPE_MMIO;
> +		rg->mreg_type = MSHV_REGION_TYPE_MMIO;
>  	else if (mshv_partition_encrypted(partition) ||
>  		 !mshv_region_movable_init(rg))
> -		rg->type = MSHV_REGION_TYPE_MEM_PINNED;
> +		rg->mreg_type = MSHV_REGION_TYPE_MEM_PINNED;
>  	else
> -		rg->type = MSHV_REGION_TYPE_MEM_MOVABLE;
> +		rg->mreg_type = MSHV_REGION_TYPE_MEM_MOVABLE;
>  
>  	rg->partition = partition;
>  
> @@ -1297,7 +1297,7 @@ mshv_map_user_memory(struct mshv_partition *partition,
>  	if (ret)
>  		return ret;
>  
> -	switch (region->type) {
> +	switch (region->mreg_type) {
>  	case MSHV_REGION_TYPE_MEM_PINNED:
>  		ret = mshv_prepare_pinned_region(region);
>  		break;
> -- 
> 2.51.2.vfs.0.1
> 

