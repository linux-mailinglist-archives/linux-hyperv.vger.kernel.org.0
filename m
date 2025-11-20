Return-Path: <linux-hyperv+bounces-7709-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id DAB76C71994
	for <lists+linux-hyperv@lfdr.de>; Thu, 20 Nov 2025 01:48:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id F14AB2F668
	for <lists+linux-hyperv@lfdr.de>; Thu, 20 Nov 2025 00:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 805231F418F;
	Thu, 20 Nov 2025 00:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="DBEz/sPV"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77C62846F;
	Thu, 20 Nov 2025 00:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763599509; cv=none; b=W+ugRb07t+fcShmhuUpCrUFAghQDkCbqmEchvkPRziqwM6P0Ywahbea7v4iESduDrjBwEUt8HbR6VlJC89xuXg9JX5BVJ75qZZYM5pRsEgiuc383epX6iA7KXbRX5zmSIsmyXN0A+fIzF7zSs6wSGYWLhE1QwIKaI8j5DTcrEVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763599509; c=relaxed/simple;
	bh=YiyMVBfVa+xJCWDsMidcDuFzomFMqyPyCeO9SM0M31E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C7dZH3g1yvnlou4vkSX8UFf/0h6ZPv2BYmzMYTKSTNyX1K0z/7z9mOkw+Gj94eymkytigJnV3btteNW8ymqfGNEO1dLxkA+gMTHEf+78nh9M5mYx/oEWmWzFeJ5HAi98Zy2oxjGmSLLiMRpmbHm7LLqVlXhjBsRwce+UquuOcbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=DBEz/sPV; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii.localdomain (unknown [20.236.11.102])
	by linux.microsoft.com (Postfix) with ESMTPSA id 3D0012119CB4;
	Wed, 19 Nov 2025 16:45:04 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3D0012119CB4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1763599504;
	bh=fzicUkPdCtlI0muynT4CSHtSRpRHY9NXn0fK7UjtOQg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DBEz/sPVPBbNqBQucqiJr/DSLH5qUS4sGGD1NOgDMYFE7MzNEKtQZ1/6kyL2XmEsa
	 FU76vhjQOdLMmOFJWpqkrX7sZrXcdB2JoX5THDcHChroa1VTEHe1Z4o6F9oKLcQwfx
	 6q4wSpwkKrzYOr5bgtdE5hLg+yNwFVqxSVScOrDU=
Date: Wed, 19 Nov 2025 16:45:02 -0800
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: Michael Kelley <mhklinux@outlook.com>
Cc: "kys@microsoft.com" <kys@microsoft.com>,
	"haiyangz@microsoft.com" <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 5/5] Drivers: hv: Add support for movable memory
 regions
Message-ID: <aR5kjh-d6UAqy88t@skinsburskii.localdomain>
References: <176339789196.27330.10517676002564595057.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <176339837995.27330.14240947043073674139.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <SN6PR02MB4157DB4154734C44B5D85A88D4D6A@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR02MB4157DB4154734C44B5D85A88D4D6A@SN6PR02MB4157.namprd02.prod.outlook.com>

On Tue, Nov 18, 2025 at 04:29:56PM +0000, Michael Kelley wrote:
> From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com> Sent: Monday, November 17, 2025 8:53 AM
> > 
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
> 
> I wasn't previously familiar with HMM when reviewing this code, so I had to
> work through the details, and mentally build a high-level view of how this
> case use maps to concepts in the Linux kernel documentation for HMM.
> Here's my take:
> 
> In this use case, the goal is what HMM calls "address space mirroring"
> between Linux in the root partition and a guest VM. Linux in the root
> partition is the primary owner of the memory. Each guest VM is a
> "device" from the HMM standpoint, and the device page tables are the
> hypervisor's SLAT entries that are managed using hypercalls to map and
> unmap memory. When a guest VM is using unpinned memory, the guest
> VM faults and generates a VP intercept when it first touches a page in its
> GFN space. MSHV is the device driver for the "device", and it handles the
> VP intercept by calling hmm_range_fault() to populate the pages, and then
> making hypercalls to set up the "device" page tables (i.e., the SLAT entries).
> Linux in the root partition can reclaim ownership of a memory range via
> the HMM "invalidate" callback, which MSHV handles by making hypercalls
> to clear the SLAT entries. After such a invalidate, the guest VM will fault
> again if it touches the memory range.
> 
> Is this a correct understanding?  If so, including such a summary in the
> commit message or as a code comment would be helpful to people
> in the future who are looking at the code.
> 

Yes, this is a correct understanding.
I'll add a description to the commit message.

> > 
> > Signed-off-by: Anirudh Rayabharam <anrayabh@linux.microsoft.com>
> > Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
> > ---
> >  drivers/hv/Kconfig          |    1
> >  drivers/hv/mshv_root.h      |    8 +
> >  drivers/hv/mshv_root_main.c |  328
> > ++++++++++++++++++++++++++++++++++++++++++-
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
> 
> Couldn't you also do "select MMU_NOTIFIER" to avoid the #ifdef's
> and stubs for when it isn't selected? There are other Linux kernel
> drivers that select it. Or is the intent to allow building an image that
> doesn't support unpinned memory, and the #ifdef's save space?
> 

That's an interesting question. This driver can function without MMU notifiers
by pinning all memory, which might be advantageous for certain real-time
applications.
However, since most other virtualization solutions use MMU_NOTIFIER, there
doesn't appear to be a strong reason for this driver to deviate.

> >  	default n
> >  	help
> >  	  Select this option to enable support for booting and running as root
> > diff --git a/drivers/hv/mshv_root.h b/drivers/hv/mshv_root.h
> > index 5eece7077f8b..117399dea780 100644
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
> The combination of "range_pinned" and "is_ram" effectively define three
> MSHV region types:
> 
> 1) MMIO
> 2) Pinned RAM
> 3) Unpinned RAM
> 
> Would it make sense to have an enum instead of 2 booleans? It seems
> like that would simplify the code a bit in a couple places. For example,
> mshv_handle_gpa_intercept() could just do one WARN_ON() instead of two.
> Also you would not need mshv_partition_destroy_region() testing "is_ram",
> and then mshv_region_movable_fini() testing "range_pinned". A single test
> could cover both.
> 
> Just a suggestion. Ignore my comment if you prefer the 2 booleans.
> 

I's rather keep it as is as it's a legacy pattern people have been used
to. A small runtime optimization doesn't worth the churn from my POV.

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
> 
> I expected the looping on -EBUSY to be in mshv_region_hmm_fault_and_lock(),
> but I guess it really doesn't matter.
> 
> > +
> > +	if (ret)
> > +		goto out;
> > +
> > +	for (i = 0; i < page_count; i++)
> > +		region->pages[page_offset + i] = hmm_pfn_to_page(pfns[i]);
> 
> The comment with hmm_pfn_to_page() says that the caller is assumed to
> have tested the pfn for HMM_PFN_VALID, which I don't see done anywhere.
> Is there a reason it's not necessary to test?
> 

The reason is the HMM_PFN_REQ_FAULT range flag, which requires all PFNs to be
faulted and populated, or mshv_region_hmm_fault_and_lock will return -EFAULT.
Additionally, note that mshv_region_hmm_fault_and_lock returns with
region->mutex held upon success, ensuring that no page can be moved until the
lock is released.

> > +
> > +	if (PageHuge(region->pages[page_offset]))
> > +		region->flags.large_pages = true;
> 
> See comment below in mshv_region_handle_gfn_fault().
> 
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
> 
> These computations make the range defined by page_offset and page_count
> start on a 512 page boundary relative to start_gfn, and have a size that is a
> multiple of 512 pages. But they don't ensure that the range aligns to a large page
> boundary within gfn space since region->start_gfn may not be a multiple of
> 512. Then mshv_region_range_fault() tests the first page of the range for
> being a large page, and if so, sets region->large_pages. This doesn't make
> sense to me if the range doesn't align to a large page boundary.
> 
> Does this code need to make sure that the range is aligned to a large
> page boundary in gfn space? Or am I misunderstanding what the
> region->large_pages flag means? Given the fixes in this v6 of the
> patch set, I was thinking that region->large_pages means that every
> large page aligned area within the region is a large page. If region->
> start_gfn and region->nr_pages aren't multiples of 512, then there
> may be an initial range and a final range that aren't large pages,
> but everything in between is. If that's not a correct understanding,
> could you clarify the exact meaning of the region->large_pages
> flag?
>

That's a good catch. Initially, the approach to memory deposit involved pinning
and depositing all pages. The code assumes that if the first page in the region
is huge, it is sufficient to use the "map huge page" flag in the hypercall.

With this series, the region is sparse by default, reducing the likelihood of
huge pages in the region. As a result, using this flag seems neither correct
nor reasonable.

Ideally, whether to use the flag should be determined during each guest memory
map/unmap operation, rather than relying on the flag set during the initial
region mapping.

For now, I will remove the large_pages flag for movable regions in this
series, as it is the least intrusive change. However, I plan to investigate
this further and potentially replace the large_pages flag with a runtime
check in the next series.

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
> 
> Does it ever happen that the gfn is legitimately not found in any
> region, perhaps due to a race? I think the vp_mutex is held here,
> so maybe that protects the region layout for the VP and "not found"
> should never occur. If so, should there be a WARN_ON here?
> 
> If "gfn not found" can be legitimate, perhaps a comment to
> explain the circumstances would be helpful.
> 

This is possible, if hypervisor returns some invalid GFN.
But there is also a possibility, that this code can race with region removal from a guest.
I'll address it in the next revision.

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
> > @@ -1194,6 +1385,110 @@ mshv_partition_region_by_gfn(struct mshv_partition *partition, u64 gfn)
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
> 
> I'm pretty sure region->start_uaddr is always page aligned. But what
> about range->start and range->end?  The code here and below assumes
> they are page aligned. It also assumes that range->end is greater than
> range->start so the computation of page_count doesn't wrap and so
> page_count is >= 1. I don't know whether checks for these assumptions
> are appropriate.
> 

There is a check for memory region size to be non-zero and page aligned
in mshv_partition_ioct_set_memory function, which is the only caller for
memory region creation. And region start is defined in PFNs.

Thanks,
Stanislav


