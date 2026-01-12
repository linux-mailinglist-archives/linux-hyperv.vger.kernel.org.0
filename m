Return-Path: <linux-hyperv+bounces-8225-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 774C2D14315
	for <lists+linux-hyperv@lfdr.de>; Mon, 12 Jan 2026 17:55:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EEFF430024EB
	for <lists+linux-hyperv@lfdr.de>; Mon, 12 Jan 2026 16:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8C8736B049;
	Mon, 12 Jan 2026 16:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="hDVyFbTH"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4439D2FA0DD
	for <linux-hyperv@vger.kernel.org>; Mon, 12 Jan 2026 16:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768236946; cv=none; b=qT6ubDyKFb7YOC8p5mvxRiR2P4GcpcvvopS71w2Sx/ZpYDmdl9+sniIzWWCfUvXdwu9avCFUEHKFu+aEEu7Bsp5DfO+/KHwD8/B9VO9xGnrRz4TdZt+OzvEjwORo1jV7wXcbd4v414JG2ZWoBEh+ye94D5hzZbD8aq2HhLEJPQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768236946; c=relaxed/simple;
	bh=r6TnOQCfBQOydTUZGnyfzUxDOA4tyATsr9E345ZA9Ds=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G/lYMPq03VokxWlFG+CdnTcJNUFmU5bArq3kHxi6YY69y3rb4Td2wvqBKW8A2jL8T9v+AgSdiZ9VRdrbHt9fYb9Si8UknJsUBWxs+dn1ByRe0N5I68K1+lpVExb0ah4Cjbg4TqXgOXPWhGs3pwgxL5gjjdAGLaA0iWrivdjn6zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=hDVyFbTH; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.65.232.172] (unknown [20.236.11.102])
	by linux.microsoft.com (Postfix) with ESMTPSA id 2CF54200DF42;
	Mon, 12 Jan 2026 08:55:44 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2CF54200DF42
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1768236944;
	bh=+u/W8SYif5zTjZ7eOSv6K5o3dY7v1GG3FEkYFuSEGHA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=hDVyFbTHIAJwDHer5w0RYcsd3ze0UpdeUPKJqQl1ZgjD1x40PVfM7zDAObK9QIPZ1
	 bg+thp/XhhV5eaBlfXY7G7/v9SeBvMssZSZOhaLa2nOXFuLwdeerw/71UIJF9ml8b/
	 zT75toHNWwmsYjqpnkMIO9yW++GrjyfLUXeiTsaA=
Message-ID: <1f772249-9f8a-4469-9dd9-2dde24850428@linux.microsoft.com>
Date: Mon, 12 Jan 2026 08:55:43 -0800
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mshv: make certain field names descriptive in a header
 struct
To: Mukesh Rathor <mrathor@linux.microsoft.com>, linux-hyperv@vger.kernel.org
Cc: wei.liu@kernel.org
References: <20260109200611.1422390-1-mrathor@linux.microsoft.com>
Content-Language: en-US
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
In-Reply-To: <20260109200611.1422390-1-mrathor@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/9/2026 12:06 PM, Mukesh Rathor wrote:
> There is no functional change. Just make couple field names in
> struct mshv_mem_region, in a header that can be used in many
> places, a little descriptive to make code easier to read by
> allowing better support for grep, cscope, etc.
> 

The commit message could be a improved a bit. Putting the
motivation first is usually better e.g.:

"
When struct fields use very common names like "pages" or "type",
it makes it difficult to find uses of these fields with tools
like grep and cscope.

Add the prefix mreg_ to some fields in struct mshv_mem_region to
make it easier to find them. No functional change.
"

Looks good to me otherwise.

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


