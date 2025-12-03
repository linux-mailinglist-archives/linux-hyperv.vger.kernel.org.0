Return-Path: <linux-hyperv+bounces-7946-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 11DC6CA1934
	for <lists+linux-hyperv@lfdr.de>; Wed, 03 Dec 2025 21:36:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A7148300D4A0
	for <lists+linux-hyperv@lfdr.de>; Wed,  3 Dec 2025 20:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BD79255E43;
	Wed,  3 Dec 2025 20:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="qalnHqRF"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 677442C0268;
	Wed,  3 Dec 2025 20:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764794175; cv=none; b=Qka35iy7SwIB+3oaYUOujmKhwEnIgRJrFngOobGItbFCGYIaS3GCJgy29xYC99UM1TkGC3U6oNNrsGX9hBhHdKgVOYpU9xDxqJZvJmhriFdhc7AxRxt7NdmCtYQCmQK5a5a6o0A4j+JqQh/t29LO/Ryu01bVvjVd+r41QJgqZt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764794175; c=relaxed/simple;
	bh=gKq7ltB2vo2ue6PpgBSO4YWyGDaumHjYNBKIGo3k1a8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JROiReaZm0jTjowwYIn/CNkcacdJV+DoCGimYZrg+9AJLMIfhDrnX3IdAJplgUvOQ2Vu63rkEqSSfgDk10+cU65Nvm2i/VmU53K34GOyCvmu4AeY9aJHMm4wUetT0FP5v5jJumzjawQ/T2GCKYv1+eytPejCYFrpgzVEcEhNJc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=qalnHqRF; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.64.161.205] (unknown [52.148.140.42])
	by linux.microsoft.com (Postfix) with ESMTPSA id 1805D2120731;
	Wed,  3 Dec 2025 12:36:09 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1805D2120731
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1764794169;
	bh=LWhJ8Vu5dz9/Cy/AR6IXcX1SRP4joxugXUc3wgVRJF4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qalnHqRFWL7Y7IwIRaEvxFlUYOPqao8zDOFEPFCPzVu+zbiZ1Etlia6e+Wwq1zlye
	 L43jjsFQoWD8UBVZVjUTQkWzCgI+CuExdvgRN74xwixRGXxoWEyJrWLHFq5tEhiSOu
	 lsOEtV5PJiOabNu/TuH7HXNk2eszXNqLsdVL9ILM=
Message-ID: <5d309f95-84d0-462e-a463-16d303629907@linux.microsoft.com>
Date: Wed, 3 Dec 2025 12:36:07 -0800
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 6/6] Drivers: hv: Add support for movable memory
 regions
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
 kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
References: <176478581828.114132.13305536829966527782.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <176478627345.114132.10738191092601354463.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
Content-Language: en-US
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
In-Reply-To: <176478627345.114132.10738191092601354463.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/3/2025 10:24 AM, Stanislav Kinsburskii wrote:
> Introduce support for movable memory regions in the Hyper-V root partition
> driver to improve memory management flexibility and enable advanced use
> cases such as dynamic memory remapping.
> 
> Mirror the address space between the Linux root partition and guest VMs
> using HMM. The root partition owns the memory, while guest VMs act as
> devices with page tables managed via hypercalls. MSHV handles VP intercepts
> by invoking hmm_range_fault() and updating SLAT entries. When memory is
> reclaimed, HMM invalidates the relevant regions, prompting MSHV to clear
> SLAT entries; guest VMs will fault again on access.
> 
> Integrate mmu_interval_notifier for movable regions, implement handlers for
> HMM faults and memory invalidation, and update memory region mapping logic
> to support movable regions.
> 
> While MMU notifiers are commonly used in virtualization drivers, this
> implementation leverages HMM (Heterogeneous Memory Management) for its
> specialized functionality. HMM provides a framework for mirroring,
> invalidation, and fault handling, reducing boilerplate and improving
> maintainability compared to generic MMU notifiers.
> 
> Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
> ---
>  drivers/hv/Kconfig          |    2 
>  drivers/hv/mshv_regions.c   |  215 ++++++++++++++++++++++++++++++++++++++++++-
>  drivers/hv/mshv_root.h      |   17 +++
>  drivers/hv/mshv_root_main.c |  139 +++++++++++++++++++++++-----
>  4 files changed, 343 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/hv/Kconfig b/drivers/hv/Kconfig
> index d4a8d349200c..7937ac0cbd0f 100644
> --- a/drivers/hv/Kconfig
> +++ b/drivers/hv/Kconfig
> @@ -76,6 +76,8 @@ config MSHV_ROOT
>  	depends on PAGE_SIZE_4KB
>  	select EVENTFD
>  	select VIRT_XFER_TO_GUEST_WORK
> +	select HMM_MIRROR
> +	select MMU_NOTIFIER
>  	default n
>  	help
>  	  Select this option to enable support for booting and running as root
> diff --git a/drivers/hv/mshv_regions.c b/drivers/hv/mshv_regions.c
> index 94f33754f545..afe03258caf0 100644
> --- a/drivers/hv/mshv_regions.c
> +++ b/drivers/hv/mshv_regions.c
> @@ -7,6 +7,8 @@
>   * Authors: Microsoft Linux virtualization team
>   */
>  
> +#include <linux/hmm.h>
> +#include <linux/hyperv.h>
>  #include <linux/kref.h>
>  #include <linux/mm.h>
>  #include <linux/vmalloc.h>
> @@ -15,6 +17,8 @@
>  
>  #include "mshv_root.h"
>  
> +#define MSHV_MAP_FAULT_IN_PAGES				PTRS_PER_PMD
> +
>  /**
>   * mshv_region_process_chunk - Processes a contiguous chunk of memory pages
>   *                             in a region.
> @@ -152,9 +156,6 @@ struct mshv_mem_region *mshv_region_create(u64 guest_pfn, u64 nr_pages,
>  	if (flags & BIT(MSHV_SET_MEM_BIT_EXECUTABLE))
>  		region->hv_map_flags |= HV_MAP_GPA_EXECUTABLE;
>  
> -	if (!is_mmio)
> -		region->flags.range_pinned = true;
> -

The parameter is_mmio is now unused in this function.

>  	kref_init(&region->refcount);
>  
>  	return region;
> @@ -239,7 +240,7 @@ int mshv_region_map(struct mshv_mem_region *region)
>  static void mshv_region_invalidate_pages(struct mshv_mem_region *region,
>  					 u64 page_offset, u64 page_count)
>  {
> -	if (region->flags.range_pinned)
> +	if (region->type == MSHV_REGION_TYPE_MEM_PINNED)
>  		unpin_user_pages(region->pages + page_offset, page_count);
>  
>  	memset(region->pages + page_offset, 0,
> @@ -313,6 +314,9 @@ static void mshv_region_destroy(struct kref *ref)
>  	struct mshv_partition *partition = region->partition;
>  	int ret;
>  
> +	if (region->type == MSHV_REGION_TYPE_MEM_MOVABLE)
> +		mshv_region_movable_fini(region);
> +
>  	if (mshv_partition_encrypted(partition)) {
>  		ret = mshv_region_share(region);
>  		if (ret) {
> @@ -339,3 +343,206 @@ int mshv_region_get(struct mshv_mem_region *region)
>  {
>  	return kref_get_unless_zero(&region->refcount);
>  }
> +
> +/**
> + * mshv_region_hmm_fault_and_lock - Handle HMM faults and lock the memory region
> + * @region: Pointer to the memory region structure
> + * @range: Pointer to the HMM range structure
> + *
> + * This function performs the following steps:
> + * 1. Reads the notifier sequence for the HMM range.
> + * 2. Acquires a read lock on the memory map.
> + * 3. Handles HMM faults for the specified range.
> + * 4. Releases the read lock on the memory map.
> + * 5. If successful, locks the memory region mutex.
> + * 6. Verifies if the notifier sequence has changed during the operation.
> + *    If it has, releases the mutex and returns -EBUSY to match with
> + *    hmm_range_fault() return code for repeating.
> + *
> + * Return: 0 on success, a negative error code otherwise.
> + */
> +static int mshv_region_hmm_fault_and_lock(struct mshv_mem_region *region,
> +					  struct hmm_range *range)
> +{
> +	int ret;
> +
> +	range->notifier_seq = mmu_interval_read_begin(range->notifier);
> +	mmap_read_lock(region->mni.mm);
> +	ret = hmm_range_fault(range);
> +	mmap_read_unlock(region->mni.mm);
> +	if (ret)
> +		return ret;
> +
> +	mutex_lock(&region->mutex);
> +
> +	if (mmu_interval_read_retry(range->notifier, range->notifier_seq)) {
> +		mutex_unlock(&region->mutex);
> +		cond_resched();
> +		return -EBUSY;
> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + * mshv_region_range_fault - Handle memory range faults for a given region.
> + * @region: Pointer to the memory region structure.
> + * @page_offset: Offset of the page within the region.
> + * @page_count: Number of pages to handle.
> + *
> + * This function resolves memory faults for a specified range of pages
> + * within a memory region. It uses HMM (Heterogeneous Memory Management)
> + * to fault in the required pages and updates the region's page array.
> + *
> + * Return: 0 on success, negative error code on failure.
> + */
> +static int mshv_region_range_fault(struct mshv_mem_region *region,
> +				   u64 page_offset, u64 page_count)
> +{
> +	struct hmm_range range = {
> +		.notifier = &region->mni,
> +		.default_flags = HMM_PFN_REQ_FAULT | HMM_PFN_REQ_WRITE,
> +	};
> +	unsigned long *pfns;
> +	int ret;
> +	u64 i;
> +
> +	pfns = kmalloc_array(page_count, sizeof(unsigned long), GFP_KERNEL);

nit: Prefer sizeof(*pfns)

<snip>

The rest looks fine to me. With the minor issues above fixed,
Reviewed-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>

