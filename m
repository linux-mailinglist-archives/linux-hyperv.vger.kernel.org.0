Return-Path: <linux-hyperv+bounces-10225-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uKw5NJhd5ml6vQEAu9opvQ
	(envelope-from <linux-hyperv+bounces-10225-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 20 Apr 2026 19:08:40 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 687F64309D0
	for <lists+linux-hyperv@lfdr.de>; Mon, 20 Apr 2026 19:08:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 923033130ADD
	for <lists+linux-hyperv@lfdr.de>; Mon, 20 Apr 2026 16:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BE2C3537CE;
	Mon, 20 Apr 2026 16:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="O51m9m10"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADF9834CFC2;
	Mon, 20 Apr 2026 16:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776702948; cv=none; b=jNQF0BCYwEojdQ1oQWVncRbEchL76k8zbcrExgD9SCzmy4g11d12QCFMTqqv4I0sDfUovRFjPt3ciwC03N1z0Ofkmo2UbuOfK/UHJneqrrJhuu9sWsoMR++AbfIAORbcEQDT+5vgMf7kmt9+SovYiZl1eis3y9qlXGk+JweqPwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776702948; c=relaxed/simple;
	bh=uRfTs+6JC3tKl9ZkqvzbCiEm6i5ZBGlqHzGBpkyjVHI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GjBhY+Fvr0r4fHraQMi+xJUaeDI3YkoW8QURAYkXr79FDHybL/jKmy36zdvxT5B2fOyKNOTcyVEThXysZ68h1WkUjMbfrAfMssFBCamWRIpqHVt5XJ7xgTJ0NYcD+MxPp+7t/ZAApdkz+DpYv84Xnv5nBCGE3PXdXsSSUSFaT4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=O51m9m10; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii.localdomain (unknown [20.236.10.129])
	by linux.microsoft.com (Postfix) with ESMTPSA id 262BA20B6F01;
	Mon, 20 Apr 2026 09:35:46 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 262BA20B6F01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1776702946;
	bh=YbBiAx8gbU8zddV0VLXNf8+cnF/mnJA4apyRCfzD2XQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O51m9m1080rNYXccUwiVW3aiAFCAPnR5864NEqUJZTcf5Aj1K0f9ZDt1bCAnKJJiZ
	 uOrnPz2dvhnvmBJNAUGXvn3G3Wp3guHpF7eCou2XnYlqi+AXNOxQCj8/KppHN3ORp8
	 xExmZRxJDLNIx4yhyH0MXeuqvXF8uxazmQGVcsF0=
Date: Mon, 20 Apr 2026 09:35:42 -0700
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: Michael Kelley <mhklinux@outlook.com>
Cc: "kys@microsoft.com" <kys@microsoft.com>,
	"haiyangz@microsoft.com" <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>,
	"longli@microsoft.com" <longli@microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 5/7] mshv: Map populated pages on movable region creation
Message-ID: <aeZV3keaRnlDsYdE@skinsburskii.localdomain>
References: <177490099488.81669.3758562641675983608.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <177490108104.81669.2129535961068627665.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <SN6PR02MB415725768DFBF9502CE942DDD4242@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR02MB415725768DFBF9502CE942DDD4242@SN6PR02MB4157.namprd02.prod.outlook.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10225-lists,linux-hyperv=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[outlook.com];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skinsburskii@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.microsoft.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,skinsburskii.localdomain:mid]
X-Rspamd-Queue-Id: 687F64309D0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 13, 2026 at 09:09:08PM +0000, Michael Kelley wrote:
> From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com> Sent: Monday, March 30, 2026 1:05 PM
> > 
> > Map any populated pages into the hypervisor upfront when creating a
> > movable region, rather than waiting for faults. Previously, movable
> > regions were created with all pages marked as HV_MAP_GPA_NO_ACCESS
> > regardless of whether the userspace mapping contained populated pages.
> > 
> > This guarantees that if the caller passes a populated mapping, those
> > present pages will be mapped into the hypervisor immediately during
> > region creation instead of being faulted in later.
> > 
> > Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
> > ---
> >  drivers/hv/mshv_regions.c   |   65 ++++++++++++++++++++++++++++++++-----------
> >  drivers/hv/mshv_root.h      |    1 +
> >  drivers/hv/mshv_root_main.c |   10 +------
> >  3 files changed, 50 insertions(+), 26 deletions(-)
> > 
> > diff --git a/drivers/hv/mshv_regions.c b/drivers/hv/mshv_regions.c
> > index 133ec7771812..28d3f488d89f 100644
> > --- a/drivers/hv/mshv_regions.c
> > +++ b/drivers/hv/mshv_regions.c
> > @@ -519,7 +519,8 @@ int mshv_region_get(struct mshv_mem_region *region)
> >  static int mshv_region_hmm_fault_and_lock(struct mshv_mem_region *region,
> >  					  unsigned long start,
> >  					  unsigned long end,
> > -					  unsigned long *pfns)
> > +					  unsigned long *pfns,
> > +					  bool do_fault)
> >  {
> >  	struct hmm_range range = {
> >  		.notifier = &region->mreg_mni,
> > @@ -540,9 +541,12 @@ static int mshv_region_hmm_fault_and_lock(struct mshv_mem_region *region,
> >  		range.hmm_pfns = pfns;
> >  		range.start = start;
> >  		range.end = min(vma->vm_end, end);
> > -		range.default_flags = HMM_PFN_REQ_FAULT;
> > -		if (vma->vm_flags & VM_WRITE)
> > -			range.default_flags |= HMM_PFN_REQ_WRITE;
> > +		range.default_flags = 0;
> > +		if (do_fault) {
> > +			range.default_flags = HMM_PFN_REQ_FAULT;
> > +			if (vma->vm_flags & VM_WRITE)
> > +				range.default_flags |= HMM_PFN_REQ_WRITE;
> > +		}
> > 
> >  		ret = hmm_range_fault(&range);
> >  		if (ret)
> > @@ -567,26 +571,40 @@ static int mshv_region_hmm_fault_and_lock(struct mshv_mem_region *region,
> >  }
> > 
> >  /**
> > - * mshv_region_range_fault - Handle memory range faults for a given region.
> > - * @region: Pointer to the memory region structure.
> > - * @pfn_offset: Offset of the page within the region.
> > - * @pfn_count: Number of pages to handle.
> > + * mshv_region_collect_and_map - Collect PFNs for a user range and map them
> > + * @region    : memory region being processed
> > + * @pfn_offset: PFNs offset within the region
> > + * @pfn_count : number of PFNs to process
> > + * @do_fault  : if true, fault in missing pages;
> > + *              if false, collect only present pages
> >   *
> > - * This function resolves memory faults for a specified range of pages
> > - * within a memory region. It uses HMM (Heterogeneous Memory Management)
> > - * to fault in the required pages and updates the region's page array.
> > + * Collects PFNs for the specified portion of @region from the
> > + * corresponding userspace VMA and maps them into the hypervisor. The
> 
> Actually, this should be "userspace VMAs" (i.e., plural)
> 

Will change.

> > + * behavior depends on @do_fault:
> >   *
> > - * Return: 0 on success, negative error code on failure.
> > + * - true: Fault in missing pages from userspace, ensuring all pages in the
> > + *   range are present. Used for on-demand page population.
> > + * - false: Collect PFNs only for pages already present in userspace,
> > + *   leaving missing pages as invalid PFN markers.
> > + *   Used for initial region setup.
> > + *
> > + * Collected PFNs are stored in region->mreg_pfns[] with HMM bookkeeping
> > + * flags cleared, then the range is mapped into the hypervisor. Present
> > + * PFNs get mapped with region access permissions; missing PFNs (zero
> > + * entries) get mapped with no-access permissions.
> 
> Hmmm. The missing PFNs are just skipped and the mreg_pfns[] array
> is not updated. Is the corresponding entry in mreg_pfns[] known to
> already be set to MSHV_INVALID_PFN? When mapping a new movable
> region, that appears to be so. I'm less sure about the 
> mshv_region_range_fault() case, though mshv_region_invalidate_pfns()
> does such initialization of any entries that are invalidated. At that point
> in the code, I'd add a comment about that assumption, as it took me a
> bit to figure it out.
> 

This logic is called for movable regions only.
Should this be mentioned in the comment from your POV?

> So does the comment about "zero entries" refer to what is returned
> by hmm_range_fault() via mshv_region_hmm_fault_and_lock()?
> The mention of "zero entries" here is a bit confusing.
> 

"Zero entries" should be changed to invalid PFN markers, which are
defined as MSHV_INVALID_PFN. I'll update the comment to clarify that.

Thanks,
Stanislav

> > + *
> > + * Return: 0 on success, negative errno on failure.
> >   */
> > -static int mshv_region_range_fault(struct mshv_mem_region *region,
> > -				   u64 pfn_offset, u64 pfn_count)
> > +static int mshv_region_collect_and_map(struct mshv_mem_region *region,
> > +				       u64 pfn_offset, u64 pfn_count,
> > +				       bool do_fault)
> >  {
> >  	unsigned long start, end;
> >  	unsigned long *pfns;
> >  	int ret;
> >  	u64 i;
> > 
> > -	pfns = kmalloc_array(pfn_count, sizeof(*pfns), GFP_KERNEL);
> > +	pfns = vmalloc_array(pfn_count, sizeof(unsigned long));
> >  	if (!pfns)
> >  		return -ENOMEM;
> > 
> > @@ -595,7 +613,7 @@ static int mshv_region_range_fault(struct mshv_mem_region *region,
> > 
> >  	do {
> >  		ret = mshv_region_hmm_fault_and_lock(region, start, end,
> > -						     pfns);
> > +						     pfns, do_fault);
> >  	} while (ret == -EBUSY);
> > 
> >  	if (ret)
> > @@ -613,10 +631,17 @@ static int mshv_region_range_fault(struct mshv_mem_region *region,
> > 
> >  	mutex_unlock(&region->mreg_mutex);
> >  out:
> > -	kfree(pfns);
> > +	vfree(pfns);
> >  	return ret;
> >  }
> > 
> > +static int mshv_region_range_fault(struct mshv_mem_region *region,
> > +				   u64 pfn_offset, u64 pfn_count)
> > +{
> > +	return mshv_region_collect_and_map(region, pfn_offset, pfn_count,
> > +					   true);
> > +}
> > +
> >  bool mshv_region_handle_gfn_fault(struct mshv_mem_region *region, u64 gfn)
> >  {
> >  	u64 pfn_offset, pfn_count;
> > @@ -800,3 +825,9 @@ int mshv_map_pinned_region(struct mshv_mem_region
> > *region)
> >  err_out:
> >  	return ret;
> >  }
> > +
> > +int mshv_map_movable_region(struct mshv_mem_region *region)
> > +{
> > +	return mshv_region_collect_and_map(region, 0, region->nr_pfns,
> > +					   false);
> > +}
> > diff --git a/drivers/hv/mshv_root.h b/drivers/hv/mshv_root.h
> > index d2e65a137bf4..02c1c11f701c 100644
> > --- a/drivers/hv/mshv_root.h
> > +++ b/drivers/hv/mshv_root.h
> > @@ -374,5 +374,6 @@ bool mshv_region_handle_gfn_fault(struct mshv_mem_region
> > *region, u64 gfn);
> >  void mshv_region_movable_fini(struct mshv_mem_region *region);
> >  bool mshv_region_movable_init(struct mshv_mem_region *region);
> >  int mshv_map_pinned_region(struct mshv_mem_region *region);
> > +int mshv_map_movable_region(struct mshv_mem_region *region);
> > 
> >  #endif /* _MSHV_ROOT_H_ */
> > diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
> > index c393b5144e0b..91dab2a3bc92 100644
> > --- a/drivers/hv/mshv_root_main.c
> > +++ b/drivers/hv/mshv_root_main.c
> > @@ -1299,15 +1299,7 @@ mshv_map_user_memory(struct mshv_partition
> > *partition,
> >  		ret = mshv_map_pinned_region(region);
> >  		break;
> >  	case MSHV_REGION_TYPE_MEM_MOVABLE:
> > -		/*
> > -		 * For movable memory regions, remap with no access to let
> > -		 * the hypervisor track dirty pages, enabling pre-copy live
> > -		 * migration.
> > -		 */
> > -		ret = hv_call_map_ram_pfns(partition->pt_id,
> > -					   region->start_gfn,
> > -					   region->nr_pfns,
> > -					   HV_MAP_GPA_NO_ACCESS, NULL);
> > +		ret = mshv_map_movable_region(region);
> >  		break;
> >  	case MSHV_REGION_TYPE_MMIO:
> >  		ret = hv_call_map_mmio_pfns(partition->pt_id,
> > 
> > 

