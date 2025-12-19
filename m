Return-Path: <linux-hyperv+bounces-8058-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 58EA8CD2259
	for <lists+linux-hyperv@lfdr.de>; Fri, 19 Dec 2025 23:53:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 20BF5301C0B0
	for <lists+linux-hyperv@lfdr.de>; Fri, 19 Dec 2025 22:53:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44E9925F7A9;
	Fri, 19 Dec 2025 22:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="MpRc6QdP"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74347136349;
	Fri, 19 Dec 2025 22:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766184833; cv=none; b=fnzGYQptKDe73AXJpGqtICSa3HHEu/lIF44utyB7F5vvvJAlBS/rmfevOKB65Imcx5kAi7pconlUq1dTwLWRmhRuDENggpOKbE7tsbAoSFJvaMyiFV5StCwEP0W7K6FVdEHEHeu74FJszTczaVFjoRSeLHfvJKok0v8l2liuSLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766184833; c=relaxed/simple;
	bh=6UWj4Ouw7WmEWTvwXPPSg5+XcHeIgeQxsnpKmnZlmQY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lme4nwPcgPRCUB53SqJhKyV+RsruTzW4Xp7NHC6udfQIApppAcRDjepRRBCMjv/cQN0ENS6lFcPWO6Vj7YKzLnz+3cr3/fitWAgzsYkXTHBiD43dsfpnB0RKskO1Q7eXHQgNFD98ZFPMQ5NSUayNoUa26yjRGmVfw47f/P61w8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=MpRc6QdP; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii.localdomain (unknown [20.236.10.66])
	by linux.microsoft.com (Postfix) with ESMTPSA id 385B721260C7;
	Fri, 19 Dec 2025 14:53:44 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 385B721260C7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1766184824;
	bh=SDZOKDw3nX4xq1oBebrbB+bToH8Rl2kE+KCKaHF2v50=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MpRc6QdP1+bTWSPfR1xoCZIi/sIQVooX7t8U2ZTTWe50i7JPOnBWyXKYvKyc5Vqur
	 ajmXyd9y2ZnVI/b+dWAddYySGeXGZLEj8qw4sMF6Gp+L14rOY61P99dXSswBpkmmv1
	 QtcRYmGxMNStUXZCJXCw8KKTuu5L0vEwOGgOJ6Co=
Date: Fri, 19 Dec 2025 14:53:42 -0800
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: Michael Kelley <mhklinux@outlook.com>
Cc: "kys@microsoft.com" <kys@microsoft.com>,
	"haiyangz@microsoft.com" <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>,
	"longli@microsoft.com" <longli@microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mshv: Align huge page stride with guest mapping
Message-ID: <aUXXdjMyZ5swiCI2@skinsburskii.localdomain>
References: <176593206931.276257.13023250440372517478.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <SN6PR02MB4157D69A4C08B0A4FE01F9FED4A8A@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <SN6PR02MB4157D69A4C08B0A4FE01F9FED4A8A@SN6PR02MB4157.namprd02.prod.outlook.com>

On Thu, Dec 18, 2025 at 07:41:24PM +0000, Michael Kelley wrote:
> From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com> Sent: Tuesday, December 16, 2025 4:41 PM
> > 
> > Ensure that a stride larger than 1 (huge page) is only used when both
> > the guest frame number (gfn) and the operation size (page_count) are
> > aligned to the huge page size (PTRS_PER_PMD). This matches the
> > hypervisor requirement that map/unmap operations for huge pages must be
> > guest-aligned and cover a full huge page.
> > 
> > Add mshv_chunk_stride() to encapsulate this alignment and page-order
> > validation, and plumb a huge_page flag into the region chunk handlers.
> > This prevents issuing large-page map/unmap/share operations that the
> > hypervisor would reject due to misaligned guest mappings.
> 
> This code looks good to me on the surface. But I can only make an educated
> guess as to the hypervisor behavior in certain situations, and if my guess is
> correct there's still a flaw in one case.
> 
> Consider the madvise() DONTNEED experiment that I previously called out. [1]
> I surmise that the intent of this patch is to make that case work correctly.
> When the .invalidate callback is made for the 32 Kbyte range embedded in
> a previously mapped 2 Meg page, this new code detects that case. It calls the
> hypervisor to remap the 32 Kbyte range for no access, and clears the 8
> corresponding entries in the struct page array attached to the mshv region. The
> call to the hypervisor is made *without* the HV_MAP_GPA_LARGE_PAGE flag.
> Since the mapping was originally done *with* the HV_MAP_GPA_LARGE_PAGE
> flag, my guess is that the hypervisor is smart enough to handle this case by
> splitting the 2 Meg mapping it created, setting the 32 Kbyte range to no access,
> and returning "success". If my guess is correct, there's no problem here.
> 
> But then there's a second .invalidate callback for the entire 2 Meg page. Here's
> the call stack:
> 
> [  194.259337]  dump_stack+0x14/0x20
> [  194.259339]  mhktest_invalidate+0x2a/0x40  [my dummy invalidate callback]
> [  194.259342]  __mmu_notifier_invalidate_range_start+0x1f4/0x250
> [  194.259347]  __split_huge_pmd+0x14f/0x170
> [  194.259349]  unmap_page_range+0x104d/0x1a00
> [  194.259358]  unmap_single_vma+0x7d/0xc0
> [  194.259360]  zap_page_range_single_batched+0xe0/0x1c0
> [  194.259363]  madvise_vma_behavior+0xb01/0xc00
> [  194.259366]  madvise_do_behavior.part.0+0x3cd/0x4a0
> [  194.259375]  do_madvise+0xc7/0x170
> [  194.259380]  __x64_sys_madvise+0x2f/0x40
> [  194.259382]  x64_sys_call+0x1d77/0x21b0
> [  194.259385]  do_syscall_64+0x56/0x640
> [  194.259388]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> 
> In __split_huge_pmd(), the .invalidate callback is made *before* the 2 Meg
> page is actually split by the root partition. So mshv_chunk_stride() returns "9"
> for the stride, and the hypervisor is called with HV_MAP_GPA_LARGE_PAGE
> set. My guess is that the hypervisor returns an error because it has already
> split the mapping. The whole point of this patch set is to avoid passing
> HV_MAP_GPA_LARGE_PAGE to the hypervisor when the hypervisor mapping
> is not a large page mapping, but this looks like a case where it still happens.
> 
> My concern is solely from looking at the code and thinking about the problem,
> as I don't have an environment where I can test root partition interactions
> with the hypervisor. So maybe I'm missing something. Lemme know what you
> think .....
> 

Yeah, I see your point: according to this stack, once a part of the page
is invalidated, the folio order remains the same until another invocation
of the same callback — this time for the whole huge
page — is made. Thus, the stride is still reported as the huge page size,
even though a part of the page has already been unmapped.

This indeed looks like a flaw in the current approach, but it's actually
not. The reason is that upon the invalidation callback, the driver
simply remaps the whole huge page with no access (in this case, the PFNs
provided to the hypervisor are zero), and it's fine as the hypervisor
simply drops all the pages from the previous mapping and marks this page
as inaccessible. The only check the hypervisor makes in this case is
that both the GFN and mapping size are huge page aligned (which they are
in this case).
 
I hope this clarifies the situation. Please let me know if you have any
other questions.

Thanks,
Stanislav

> Michael
> 
> [1] https://lore.kernel.org/linux-hyperv/SN6PR02MB4157978DFAA6C2584D0678E1D4A1A@SN6PR02MB4157.namprd02.prod.outlook.com/
> 
> > 
> > Fixes: abceb4297bf8 ("mshv: Fix huge page handling in memory region traversal")
> > Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
> > ---
> >  drivers/hv/mshv_regions.c |   94 ++++++++++++++++++++++++++++++---------------
> >  1 file changed, 63 insertions(+), 31 deletions(-)
> > 
> > diff --git a/drivers/hv/mshv_regions.c b/drivers/hv/mshv_regions.c
> > index 30bacba6aec3..29776019bcde 100644
> > --- a/drivers/hv/mshv_regions.c
> > +++ b/drivers/hv/mshv_regions.c
> > @@ -19,6 +19,42 @@
> > 
> >  #define MSHV_MAP_FAULT_IN_PAGES				PTRS_PER_PMD
> > 
> > +/**
> > + * mshv_chunk_stride - Compute stride for mapping guest memory
> > + * @page      : The page to check for huge page backing
> > + * @gfn       : Guest frame number for the mapping
> > + * @page_count: Total number of pages in the mapping
> > + *
> > + * Determines the appropriate stride (in pages) for mapping guest memory.
> > + * Uses huge page stride if the backing page is huge and the guest mapping
> > + * is properly aligned; otherwise falls back to single page stride.
> > + *
> > + * Return: Stride in pages, or -EINVAL if page order is unsupported.
> > + */
> > +static int mshv_chunk_stride(struct page *page,
> > +			     u64 gfn, u64 page_count)
> > +{
> > +	unsigned int page_order;
> > +
> > +	page_order = folio_order(page_folio(page));
> > +	/* The hypervisor only supports 4K and 2M page sizes */
> > +	if (page_order && page_order != PMD_ORDER)
> > +		return -EINVAL;
> > +
> > +	/*
> > +	 * Default to a single page stride. If page_order is set and both
> > +	 * the guest frame number (gfn) and page_count are huge-page
> > +	 * aligned (PTRS_PER_PMD), use a larger stride so the mapping can
> > +	 * be backed by a huge page in both guest and hypervisor.
> > +	 */
> > +	if (page_order &&
> > +	    IS_ALIGNED(gfn, PTRS_PER_PMD) &&
> > +	    IS_ALIGNED(page_count, PTRS_PER_PMD))
> > +		return 1 << page_order;
> > +
> > +	return 1;
> > +}
> > +
> >  /**
> >   * mshv_region_process_chunk - Processes a contiguous chunk of memory pages
> >   *                             in a region.
> > @@ -45,25 +81,23 @@ static long mshv_region_process_chunk(struct mshv_mem_region *region,
> >  				      int (*handler)(struct mshv_mem_region *region,
> >  						     u32 flags,
> >  						     u64 page_offset,
> > -						     u64 page_count))
> > +						     u64 page_count,
> > +						     bool huge_page))
> >  {
> > -	u64 count, stride;
> > -	unsigned int page_order;
> > +	u64 gfn = region->start_gfn + page_offset;
> > +	u64 count;
> >  	struct page *page;
> > -	int ret;
> > +	int stride, ret;
> > 
> >  	page = region->pages[page_offset];
> >  	if (!page)
> >  		return -EINVAL;
> > 
> > -	page_order = folio_order(page_folio(page));
> > -	/* The hypervisor only supports 4K and 2M page sizes */
> > -	if (page_order && page_order != PMD_ORDER)
> > -		return -EINVAL;
> > -
> > -	stride = 1 << page_order;
> > +	stride = mshv_chunk_stride(page, gfn, page_count);
> > +	if (stride < 0)
> > +		return stride;
> > 
> > -	/* Start at stride since the first page is validated */
> > +	/* Start at stride since the first stride is validated */
> >  	for (count = stride; count < page_count; count += stride) {
> >  		page = region->pages[page_offset + count];
> > 
> > @@ -71,12 +105,13 @@ static long mshv_region_process_chunk(struct mshv_mem_region *region,
> >  		if (!page)
> >  			break;
> > 
> > -		/* Break if page size changes */
> > -		if (page_order != folio_order(page_folio(page)))
> > +		/* Break if stride size changes */
> > +		if (stride != mshv_chunk_stride(page, gfn + count,
> > +						page_count - count))
> >  			break;
> >  	}
> > 
> > -	ret = handler(region, flags, page_offset, count);
> > +	ret = handler(region, flags, page_offset, count, stride > 1);
> >  	if (ret)
> >  		return ret;
> > 
> > @@ -108,7 +143,8 @@ static int mshv_region_process_range(struct mshv_mem_region *region,
> >  				     int (*handler)(struct mshv_mem_region *region,
> >  						    u32 flags,
> >  						    u64 page_offset,
> > -						    u64 page_count))
> > +						    u64 page_count,
> > +						    bool huge_page))
> >  {
> >  	long ret;
> > 
> > @@ -162,11 +198,10 @@ struct mshv_mem_region *mshv_region_create(u64 guest_pfn, u64 nr_pages,
> > 
> >  static int mshv_region_chunk_share(struct mshv_mem_region *region,
> >  				   u32 flags,
> > -				   u64 page_offset, u64 page_count)
> > +				   u64 page_offset, u64 page_count,
> > +				   bool huge_page)
> >  {
> > -	struct page *page = region->pages[page_offset];
> > -
> > -	if (PageHuge(page) || PageTransCompound(page))
> > +	if (huge_page)
> >  		flags |= HV_MODIFY_SPA_PAGE_HOST_ACCESS_LARGE_PAGE;
> > 
> >  	return hv_call_modify_spa_host_access(region->partition->pt_id,
> > @@ -188,11 +223,10 @@ int mshv_region_share(struct mshv_mem_region *region)
> > 
> >  static int mshv_region_chunk_unshare(struct mshv_mem_region *region,
> >  				     u32 flags,
> > -				     u64 page_offset, u64 page_count)
> > +				     u64 page_offset, u64 page_count,
> > +				     bool huge_page)
> >  {
> > -	struct page *page = region->pages[page_offset];
> > -
> > -	if (PageHuge(page) || PageTransCompound(page))
> > +	if (huge_page)
> >  		flags |= HV_MODIFY_SPA_PAGE_HOST_ACCESS_LARGE_PAGE;
> > 
> >  	return hv_call_modify_spa_host_access(region->partition->pt_id,
> > @@ -212,11 +246,10 @@ int mshv_region_unshare(struct mshv_mem_region *region)
> > 
> >  static int mshv_region_chunk_remap(struct mshv_mem_region *region,
> >  				   u32 flags,
> > -				   u64 page_offset, u64 page_count)
> > +				   u64 page_offset, u64 page_count,
> > +				   bool huge_page)
> >  {
> > -	struct page *page = region->pages[page_offset];
> > -
> > -	if (PageHuge(page) || PageTransCompound(page))
> > +	if (huge_page)
> >  		flags |= HV_MAP_GPA_LARGE_PAGE;
> > 
> >  	return hv_call_map_gpa_pages(region->partition->pt_id,
> > @@ -295,11 +328,10 @@ int mshv_region_pin(struct mshv_mem_region *region)
> > 
> >  static int mshv_region_chunk_unmap(struct mshv_mem_region *region,
> >  				   u32 flags,
> > -				   u64 page_offset, u64 page_count)
> > +				   u64 page_offset, u64 page_count,
> > +				   bool huge_page)
> >  {
> > -	struct page *page = region->pages[page_offset];
> > -
> > -	if (PageHuge(page) || PageTransCompound(page))
> > +	if (huge_page)
> >  		flags |= HV_UNMAP_GPA_LARGE_PAGE;
> > 
> >  	return hv_call_unmap_gpa_pages(region->partition->pt_id,
> > 
> > 
> 

