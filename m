Return-Path: <linux-hyperv+bounces-7276-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D972BF2BB1
	for <lists+linux-hyperv@lfdr.de>; Mon, 20 Oct 2025 19:36:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 918A74E8C12
	for <lists+linux-hyperv@lfdr.de>; Mon, 20 Oct 2025 17:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 493D91C3C11;
	Mon, 20 Oct 2025 17:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="MOVaVLFz"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D99A17A2F0;
	Mon, 20 Oct 2025 17:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760981770; cv=none; b=sxGJyLW1J+TV1ER/3LQS++4MI8EkhwxLqMhk9ghSdZKANYgl0pzD2+VQfG22t3ZpCA961Z0jndz4KQvLOO3epPgpU9BIESTi4bMeRdEMD4a4J1WjsvBRp+eH9EorhoE6kMD1BMrw1kKRihmtRMGmqalGphDhnkoOY7KRn++LTc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760981770; c=relaxed/simple;
	bh=vxx9/4cCCY03npBjvOVZ7NC7E+G7omAROcH7XxW/M1U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lLruDFP82qj/XKTv7ERl16U60T01t44gXzAfh9S6SByIQJUU8NBNFvlam7Fwpz2lSwNpmsr6utDT98++dPV4lfzM5fNd4kOR+VqymlGuJfQttlSx7G//LCe6MtLhj067w7vA+FMvZtoOkISx5lTw0E9VdTekmxydRd+Lljtaa9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=MOVaVLFz; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii.localdomain (unknown [52.148.140.42])
	by linux.microsoft.com (Postfix) with ESMTPSA id B0A0820145D6;
	Mon, 20 Oct 2025 10:36:01 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B0A0820145D6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1760981761;
	bh=CyEfOum/PI6lAmsVpc6duy64Vl6aOsBo8xWvCa5cmR8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MOVaVLFz63ywltqZQ5uA8/qqmdw0T2/WIa1S4ZppclSla9pFtCDPbekRe/sxd1m4c
	 nQF1oIChOcpX1OlM1iWh8AcOkN4/ZPENEOUhvhtjQWjjLDKFncg8fiXr0BvoM8TLzH
	 Cx+P8pe4LUOfQkX+oDTNKfTN8+SJHGTp2FUbggK0=
Date: Mon, 20 Oct 2025 10:35:58 -0700
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: Mukesh R <mrathor@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 5/5] Drivers: hv: Add support for movable memory
 regions
Message-ID: <aPZy_mCJs3WdA0tt@skinsburskii.localdomain>
References: <176057396465.74314.10055784909009416453.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <176057443695.74314.10584965103467299030.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <2d5d540c-6ed5-455f-a895-9a3dd12bae2c@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2d5d540c-6ed5-455f-a895-9a3dd12bae2c@linux.microsoft.com>

On Fri, Oct 17, 2025 at 04:55:24PM -0700, Mukesh R wrote:
> On 10/15/25 17:27, Stanislav Kinsburskii wrote:
> > Introduce support for movable memory regions in the Hyper-V root partition
> > driver, thus improving memory management flexibility and preparing the
> > driver for advanced use cases such as dynamic memory remapping.
> > 
> > Integrate mmu_interval_notifier for movable regions, implement functions to
> > handle HMM faults and memory invalidation, and update memory region mapping
> > logic to support movable regions.
> > 
> > While MMU notifiers are commonly used in virtualization drivers, this
> > implementation leverages HMM (Heterogeneous Memory Management) for its
> > tailored functionality. HMM provides a ready-made framework for mirroring,
> > invalidation, and fault handling, avoiding the need to reimplement these
> > mechanisms for a single callback. Although MMU notifiers are more generic,
> > using HMM reduces boilerplate and ensures maintainability by utilizing a
> > mechanism specifically designed for such use cases.
> > 
> > Signed-off-by: Anirudh Rayabharam <anrayabh@linux.microsoft.com>
> > Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
> > ---
> >  drivers/hv/Kconfig          |    1 
> >  drivers/hv/mshv_root.h      |    8 +
> >  drivers/hv/mshv_root_main.c |  328 ++++++++++++++++++++++++++++++++++++++++++-
> >  3 files changed, 327 insertions(+), 10 deletions(-)
> > 
> > diff --git a/drivers/hv/Kconfig b/drivers/hv/Kconfig
> > index 0b8c391a0342..5f1637cbb6e3 100644
> > --- a/drivers/hv/Kconfig
> > +++ b/drivers/hv/Kconfig
> > @@ -75,6 +75,7 @@ config MSHV_ROOT
> >  	depends on PAGE_SIZE_4KB
> >  	select EVENTFD
> >  	select VIRT_XFER_TO_GUEST_WORK
> > +	select HMM_MIRROR
> >  	default n
> >  	help
> >  	  Select this option to enable support for booting and running as root
> > diff --git a/drivers/hv/mshv_root.h b/drivers/hv/mshv_root.h
> > index 97e64d5341b6..13367c84497c 100644
> > --- a/drivers/hv/mshv_root.h
> > +++ b/drivers/hv/mshv_root.h
> > @@ -15,6 +15,7 @@
> >  #include <linux/hashtable.h>
> >  #include <linux/dev_printk.h>
> >  #include <linux/build_bug.h>
> > +#include <linux/mmu_notifier.h>
> >  #include <uapi/linux/mshv.h>
> >  
> >  /*
> > @@ -81,9 +82,14 @@ struct mshv_mem_region {
> >  	struct {
> >  		u64 large_pages:  1; /* 2MiB */
> >  		u64 range_pinned: 1;
> > -		u64 reserved:	 62;
> > +		u64 is_ram	: 1; /* mem region can be ram or mmio */
> 
> In case this gets accepted/merged, this is named 
> +               u64 memreg_isram: 1; /* mem region can be ram or mmio */
> 

The proposed naming scheme doesn't align with the other fields in this structure.
Renaming this one should be probably done along with the other fields in
a separate change.

Thanks,
Stanislav

> Keeping the name same will avoid unnecessary diffs when we try to compare
> files to see what is missing internally or externally.
> 
> Thanks,
> -Mukesh
> 
> >  	} flags;
> >  	struct mshv_partition *partition;
> > +#if defined(CONFIG_MMU_NOTIFIER)
> > +	struct mmu_interval_notifier mni;
> > +	struct mutex mutex;	/* protects region pages remapping */
> > +#endif
> >  	struct page *pages[];
> >  };
> >  
> > diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
> > index c4f114376435..b2738443ac5d 100644
> > --- a/drivers/hv/mshv_root_main.c
> > +++ b/drivers/hv/mshv_root_main.c
> > @@ -29,6 +29,7 @@
> >  #include <linux/crash_dump.h>
> >  #include <linux/panic_notifier.h>
> >  #include <linux/vmalloc.h>
> > +#include <linux/hmm.h>
> >  
> >  #include "mshv_eventfd.h"
> >  #include "mshv.h"
> > @@ -36,6 +37,8 @@
> >  
> >  #define VALUE_PMD_ALIGNED(c)			(!((c) & (PTRS_PER_PMD - 1)))
> >  
> > +#define MSHV_MAP_FAULT_IN_PAGES			HPAGE_PMD_NR
> > +
> >  MODULE_AUTHOR("Microsoft");
> >  MODULE_LICENSE("GPL");
> >  MODULE_DESCRIPTION("Microsoft Hyper-V root partition VMM interface /dev/mshv");
> > @@ -76,6 +79,11 @@ static int mshv_vp_mmap(struct file *file, struct vm_area_struct *vma);
> >  static vm_fault_t mshv_vp_fault(struct vm_fault *vmf);
> >  static int mshv_init_async_handler(struct mshv_partition *partition);
> >  static void mshv_async_hvcall_handler(void *data, u64 *status);
> > +static struct mshv_mem_region
> > +	*mshv_partition_region_by_gfn(struct mshv_partition *pt, u64 gfn);
> > +static int mshv_region_remap_pages(struct mshv_mem_region *region,
> > +				   u32 map_flags, u64 page_offset,
> > +				   u64 page_count);
> >  
> >  static const union hv_input_vtl input_vtl_zero;
> >  static const union hv_input_vtl input_vtl_normal = {
> > @@ -602,14 +610,197 @@ static long mshv_run_vp_with_root_scheduler(struct mshv_vp *vp)
> >  static_assert(sizeof(struct hv_message) <= MSHV_RUN_VP_BUF_SZ,
> >  	      "sizeof(struct hv_message) must not exceed MSHV_RUN_VP_BUF_SZ");
> >  
> > +#ifdef CONFIG_X86_64
> > +
> > +#if defined(CONFIG_MMU_NOTIFIER)
> > +/**
> > + * mshv_region_hmm_fault_and_lock - Handle HMM faults and lock the memory region
> > + * @region: Pointer to the memory region structure
> > + * @range: Pointer to the HMM range structure
> > + *
> > + * This function performs the following steps:
> > + * 1. Reads the notifier sequence for the HMM range.
> > + * 2. Acquires a read lock on the memory map.
> > + * 3. Handles HMM faults for the specified range.
> > + * 4. Releases the read lock on the memory map.
> > + * 5. If successful, locks the memory region mutex.
> > + * 6. Verifies if the notifier sequence has changed during the operation.
> > + *    If it has, releases the mutex and returns -EBUSY to match with
> > + *    hmm_range_fault() return code for repeating.
> > + *
> > + * Return: 0 on success, a negative error code otherwise.
> > + */
> > +static int mshv_region_hmm_fault_and_lock(struct mshv_mem_region *region,
> > +					  struct hmm_range *range)
> > +{
> > +	int ret;
> > +
> > +	range->notifier_seq = mmu_interval_read_begin(range->notifier);
> > +	mmap_read_lock(region->mni.mm);
> > +	ret = hmm_range_fault(range);
> > +	mmap_read_unlock(region->mni.mm);
> > +	if (ret)
> > +		return ret;
> > +
> > +	mutex_lock(&region->mutex);
> > +
> > +	if (mmu_interval_read_retry(range->notifier, range->notifier_seq)) {
> > +		mutex_unlock(&region->mutex);
> > +		cond_resched();
> > +		return -EBUSY;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +/**
> > + * mshv_region_range_fault - Handle memory range faults for a given region.
> > + * @region: Pointer to the memory region structure.
> > + * @page_offset: Offset of the page within the region.
> > + * @page_count: Number of pages to handle.
> > + *
> > + * This function resolves memory faults for a specified range of pages
> > + * within a memory region. It uses HMM (Heterogeneous Memory Management)
> > + * to fault in the required pages and updates the region's page array.
> > + *
> > + * Return: 0 on success, negative error code on failure.
> > + */
> > +static int mshv_region_range_fault(struct mshv_mem_region *region,
> > +				   u64 page_offset, u64 page_count)
> > +{
> > +	struct hmm_range range = {
> > +		.notifier = &region->mni,
> > +		.default_flags = HMM_PFN_REQ_FAULT | HMM_PFN_REQ_WRITE,
> > +	};
> > +	unsigned long *pfns;
> > +	int ret;
> > +	u64 i;
> > +
> > +	pfns = kmalloc_array(page_count, sizeof(unsigned long), GFP_KERNEL);
> > +	if (!pfns)
> > +		return -ENOMEM;
> > +
> > +	range.hmm_pfns = pfns;
> > +	range.start = region->start_uaddr + page_offset * HV_HYP_PAGE_SIZE;
> > +	range.end = range.start + page_count * HV_HYP_PAGE_SIZE;
> > +
> > +	do {
> > +		ret = mshv_region_hmm_fault_and_lock(region, &range);
> > +	} while (ret == -EBUSY);
> > +
> > +	if (ret)
> > +		goto out;
> > +
> > +	for (i = 0; i < page_count; i++)
> > +		region->pages[page_offset + i] = hmm_pfn_to_page(pfns[i]);
> > +
> > +	if (PageHuge(region->pages[page_offset]))
> > +		region->flags.large_pages = true;
> > +
> > +	ret = mshv_region_remap_pages(region, region->hv_map_flags,
> > +				      page_offset, page_count);
> > +
> > +	mutex_unlock(&region->mutex);
> > +out:
> > +	kfree(pfns);
> > +	return ret;
> > +}
> > +#else /* CONFIG_MMU_NOTIFIER */
> > +static int mshv_region_range_fault(struct mshv_mem_region *region,
> > +				   u64 page_offset, u64 page_count)
> > +{
> > +	return -ENODEV;
> > +}
> > +#endif /* CONFIG_MMU_NOTIFIER */
> > +
> > +static bool mshv_region_handle_gfn_fault(struct mshv_mem_region *region, u64 gfn)
> > +{
> > +	u64 page_offset, page_count;
> > +	int ret;
> > +
> > +	if (WARN_ON_ONCE(region->flags.range_pinned))
> > +		return false;
> > +
> > +	/* Align the page offset to the nearest MSHV_MAP_FAULT_IN_PAGES. */
> > +	page_offset = ALIGN_DOWN(gfn - region->start_gfn,
> > +				 MSHV_MAP_FAULT_IN_PAGES);
> > +
> > +	/* Map more pages than requested to reduce the number of faults. */
> > +	page_count = min(region->nr_pages - page_offset,
> > +			 MSHV_MAP_FAULT_IN_PAGES);
> > +
> > +	ret = mshv_region_range_fault(region, page_offset, page_count);
> > +
> > +	WARN_ONCE(ret,
> > +		  "p%llu: GPA intercept failed: region %#llx-%#llx, gfn %#llx, page_offset %llu, page_count %llu\n",
> > +		  region->partition->pt_id, region->start_uaddr,
> > +		  region->start_uaddr + (region->nr_pages << HV_HYP_PAGE_SHIFT),
> > +		  gfn, page_offset, page_count);
> > +
> > +	return !ret;
> > +}
> > +
> > +/**
> > + * mshv_handle_gpa_intercept - Handle GPA (Guest Physical Address) intercepts.
> > + * @vp: Pointer to the virtual processor structure.
> > + *
> > + * This function processes GPA intercepts by identifying the memory region
> > + * corresponding to the intercepted GPA, aligning the page offset, and
> > + * mapping the required pages. It ensures that the region is valid and
> > + * handles faults efficiently by mapping multiple pages at once.
> > + *
> > + * Return: true if the intercept was handled successfully, false otherwise.
> > + */
> > +static bool mshv_handle_gpa_intercept(struct mshv_vp *vp)
> > +{
> > +	struct mshv_partition *p = vp->vp_partition;
> > +	struct mshv_mem_region *region;
> > +	struct hv_x64_memory_intercept_message *msg;
> > +	u64 gfn;
> > +
> > +	msg = (struct hv_x64_memory_intercept_message *)
> > +		vp->vp_intercept_msg_page->u.payload;
> > +
> > +	gfn = HVPFN_DOWN(msg->guest_physical_address);
> > +
> > +	region = mshv_partition_region_by_gfn(p, gfn);
> > +	if (!region)
> > +		return false;
> > +
> > +	if (WARN_ON_ONCE(!region->flags.is_ram))
> > +		return false;
> > +
> > +	if (WARN_ON_ONCE(region->flags.range_pinned))
> > +		return false;
> > +
> > +	return mshv_region_handle_gfn_fault(region, gfn);
> > +}
> > +
> > +#else	/* CONFIG_X86_64 */
> > +
> > +static bool mshv_handle_gpa_intercept(struct mshv_vp *vp) { return false; }
> > +
> > +#endif	/* CONFIG_X86_64 */
> > +
> > +static bool mshv_vp_handle_intercept(struct mshv_vp *vp)
> > +{
> > +	switch (vp->vp_intercept_msg_page->header.message_type) {
> > +	case HVMSG_GPA_INTERCEPT:
> > +		return mshv_handle_gpa_intercept(vp);
> > +	}
> > +	return false;
> > +}
> > +
> >  static long mshv_vp_ioctl_run_vp(struct mshv_vp *vp, void __user *ret_msg)
> >  {
> >  	long rc;
> >  
> > -	if (hv_scheduler_type == HV_SCHEDULER_TYPE_ROOT)
> > -		rc = mshv_run_vp_with_root_scheduler(vp);
> > -	else
> > -		rc = mshv_run_vp_with_hyp_scheduler(vp);
> > +	do {
> > +		if (hv_scheduler_type == HV_SCHEDULER_TYPE_ROOT)
> > +			rc = mshv_run_vp_with_root_scheduler(vp);
> > +		else
> > +			rc = mshv_run_vp_with_hyp_scheduler(vp);
> > +	} while (rc == 0 && mshv_vp_handle_intercept(vp));
> >  
> >  	if (rc)
> >  		return rc;
> > @@ -1209,6 +1400,110 @@ mshv_partition_region_by_uaddr(struct mshv_partition *partition, u64 uaddr)
> >  	return NULL;
> >  }
> >  
> > +#if defined(CONFIG_MMU_NOTIFIER)
> > +static void mshv_region_movable_fini(struct mshv_mem_region *region)
> > +{
> > +	if (region->flags.range_pinned)
> > +		return;
> > +
> > +	mmu_interval_notifier_remove(&region->mni);
> > +}
> > +
> > +/**
> > + * mshv_region_interval_invalidate - Invalidate a range of memory region
> > + * @mni: Pointer to the mmu_interval_notifier structure
> > + * @range: Pointer to the mmu_notifier_range structure
> > + * @cur_seq: Current sequence number for the interval notifier
> > + *
> > + * This function invalidates a memory region by remapping its pages with
> > + * no access permissions. It locks the region's mutex to ensure thread safety
> > + * and updates the sequence number for the interval notifier. If the range
> > + * is blockable, it uses a blocking lock; otherwise, it attempts a non-blocking
> > + * lock and returns false if unsuccessful.
> > + *
> > + * NOTE: Failure to invalidate a region is a serious error, as the pages will
> > + * be considered freed while they are still mapped by the hypervisor.
> > + * Any attempt to access such pages will likely crash the system.
> > + *
> > + * Return: true if the region was successfully invalidated, false otherwise.
> > + */
> > +static bool
> > +mshv_region_interval_invalidate(struct mmu_interval_notifier *mni,
> > +				const struct mmu_notifier_range *range,
> > +				unsigned long cur_seq)
> > +{
> > +	struct mshv_mem_region *region = container_of(mni,
> > +						struct mshv_mem_region,
> > +						mni);
> > +	u64 page_offset, page_count;
> > +	unsigned long mstart, mend;
> > +	int ret = -EPERM;
> > +
> > +	if (mmu_notifier_range_blockable(range))
> > +		mutex_lock(&region->mutex);
> > +	else if (!mutex_trylock(&region->mutex))
> > +		goto out_fail;
> > +
> > +	mmu_interval_set_seq(mni, cur_seq);
> > +
> > +	mstart = max(range->start, region->start_uaddr);
> > +	mend = min(range->end, region->start_uaddr +
> > +		   (region->nr_pages << HV_HYP_PAGE_SHIFT));
> > +
> > +	page_offset = HVPFN_DOWN(mstart - region->start_uaddr);
> > +	page_count = HVPFN_DOWN(mend - mstart);
> > +
> > +	ret = mshv_region_remap_pages(region, HV_MAP_GPA_NO_ACCESS,
> > +				      page_offset, page_count);
> > +	if (ret)
> > +		goto out_fail;
> > +
> > +	mshv_region_invalidate_pages(region, page_offset, page_count);
> > +
> > +	mutex_unlock(&region->mutex);
> > +
> > +	return true;
> > +
> > +out_fail:
> > +	WARN_ONCE(ret,
> > +		  "Failed to invalidate region %#llx-%#llx (range %#lx-%#lx, event: %u, pages %#llx-%#llx, mm: %#llx): %d\n",
> > +		  region->start_uaddr,
> > +		  region->start_uaddr + (region->nr_pages << HV_HYP_PAGE_SHIFT),
> > +		  range->start, range->end, range->event,
> > +		  page_offset, page_offset + page_count - 1, (u64)range->mm, ret);
> > +	return false;
> > +}
> > +
> > +static const struct mmu_interval_notifier_ops mshv_region_mni_ops = {
> > +	.invalidate = mshv_region_interval_invalidate,
> > +};
> > +
> > +static bool mshv_region_movable_init(struct mshv_mem_region *region)
> > +{
> > +	int ret;
> > +
> > +	ret = mmu_interval_notifier_insert(&region->mni, current->mm,
> > +					   region->start_uaddr,
> > +					   region->nr_pages << HV_HYP_PAGE_SHIFT,
> > +					   &mshv_region_mni_ops);
> > +	if (ret)
> > +		return false;
> > +
> > +	mutex_init(&region->mutex);
> > +
> > +	return true;
> > +}
> > +#else
> > +static inline void mshv_region_movable_fini(struct mshv_mem_region *region)
> > +{
> > +}
> > +
> > +static inline bool mshv_region_movable_init(struct mshv_mem_region *region)
> > +{
> > +	return false;
> > +}
> > +#endif
> > +
> >  /*
> >   * NB: caller checks and makes sure mem->size is page aligned
> >   * Returns: 0 with regionpp updated on success, or -errno
> > @@ -1241,9 +1536,14 @@ static int mshv_partition_create_region(struct mshv_partition *partition,
> >  	if (mem->flags & BIT(MSHV_SET_MEM_BIT_EXECUTABLE))
> >  		region->hv_map_flags |= HV_MAP_GPA_EXECUTABLE;
> >  
> > -	/* Note: large_pages flag populated when we pin the pages */
> > -	if (!is_mmio)
> > -		region->flags.range_pinned = true;
> > +	/* Note: large_pages flag populated when pages are allocated. */
> > +	if (!is_mmio) {
> > +		region->flags.is_ram = true;
> > +
> > +		if (mshv_partition_encrypted(partition) ||
> > +		    !mshv_region_movable_init(region))
> > +			region->flags.range_pinned = true;
> > +	}
> >  
> >  	region->partition = partition;
> >  
> > @@ -1363,9 +1663,16 @@ mshv_map_user_memory(struct mshv_partition *partition,
> >  	if (is_mmio)
> >  		ret = hv_call_map_mmio_pages(partition->pt_id, mem.guest_pfn,
> >  					     mmio_pfn, HVPFN_DOWN(mem.size));
> > -	else
> > +	else if (region->flags.range_pinned)
> >  		ret = mshv_prepare_pinned_region(region);
> > -
> > +	else
> > +		/*
> > +		 * For non-pinned regions, remap with no access to let the
> > +		 * hypervisor track dirty pages, enabling pre-copy live
> > +		 * migration.
> > +		 */
> > +		ret = mshv_region_remap_pages(region, HV_MAP_GPA_NO_ACCESS,
> > +					      0, region->nr_pages);
> >  	if (ret)
> >  		goto errout;
> >  
> > @@ -1388,6 +1695,9 @@ static void mshv_partition_destroy_region(struct mshv_mem_region *region)
> >  
> >  	hlist_del(&region->hnode);
> >  
> > +	if (region->flags.is_ram)
> > +		mshv_region_movable_fini(region);
> > +
> >  	if (mshv_partition_encrypted(partition)) {
> >  		ret = mshv_partition_region_share(region);
> >  		if (ret) {
> > 
> > 

