Return-Path: <linux-hyperv+bounces-8155-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6905BCF4FB4
	for <lists+linux-hyperv@lfdr.de>; Mon, 05 Jan 2026 18:25:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E300C3005F1E
	for <lists+linux-hyperv@lfdr.de>; Mon,  5 Jan 2026 17:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0175309F18;
	Mon,  5 Jan 2026 17:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="QFRELGEZ"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4EB629DB65;
	Mon,  5 Jan 2026 17:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767633925; cv=none; b=V59AN6WQLTqeffXFysk+Ha9IpfzYvQD2TOgOMjEYjO31Puz1lVT8ohjZbQyT3HsOmN7TrZ6mg5Izlj5+a8/oulEnNL3lS7rwcdUPi/0WlqsJMBVTdVkySwS5TKIVpoXOUHH/IVjPqcFV0Kgl3OQd2U8CnOWrmWBaiHGvTmjjpT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767633925; c=relaxed/simple;
	bh=hL0CKt97cNJobWyx0QQ+AabzqAxTvxr6qXIWKBUw9Q0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i3WJEB8XfeUS5noo4pEUdebgYDncd9SbX+63kCOfDNoqN71di2baKvgvcdqJdT3wOlNHHzu5ugkJeP9PuBWVk1TA4IPXg/jXzkejnjHe3lYNBmAvGWC61g3P0j1SG1NmZejviJXKx1Okyjh4FTYTiWundq+oIXIlzo4z3J8OozA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=QFRELGEZ; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii.localdomain (c-98-225-44-182.hsd1.wa.comcast.net [98.225.44.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id 5EC742123283;
	Mon,  5 Jan 2026 09:25:21 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5EC742123283
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1767633922;
	bh=UKtqmRQdZE2sfKsRRif9u/CHaatDYh6mERNAYU6Yw+8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QFRELGEZ2ld5L+BEZIWFgjaQ6LSEcq/zK7dTZEv+3kC4xNZu84zl3z1Et6j+XGhrz
	 Wt9EE7BWBpchROYbivhIX6VJ5lnU3M/A8J+oVNblno5W5W1riVInjjRFR+AjN2iwa5
	 FcopiClVySoXszvrVxSS/nnxtBnnUHtWbuogfOF8=
Date: Mon, 5 Jan 2026 09:25:20 -0800
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
Message-ID: <aVv0ALacPukXIHTw@skinsburskii.localdomain>
References: <SN6PR02MB41578A17A4DADD9276392298D4B4A@SN6PR02MB4157.namprd02.prod.outlook.com>
 <SN6PR02MB4157AAFDD8BD5BDCD2D3DB99D4B5A@SN6PR02MB4157.namprd02.prod.outlook.com>
 <aUrCr5wBSTrGm-IM@skinsburskii.localdomain>
 <SN6PR02MB41573BF52C6A4447C720CDD6D4B5A@SN6PR02MB4157.namprd02.prod.outlook.com>
 <aVgDloDX9nMH6hZH@skinsburskii.localdomain>
 <SN6PR02MB4157288D26ECC9E69240CFECD4BBA@SN6PR02MB4157.namprd02.prod.outlook.com>
 <aVgkj4V60kddKk4o@skinsburskii.localdomain>
 <SN6PR02MB415724D13B2751F8FAA1053BD4BBA@SN6PR02MB4157.namprd02.prod.outlook.com>
 <aVhWMoH3GvpGAR0a@skinsburskii.localdomain>
 <SN6PR02MB415756A0783B634297F51320D4B8A@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <SN6PR02MB415756A0783B634297F51320D4B8A@SN6PR02MB4157.namprd02.prod.outlook.com>

On Sat, Jan 03, 2026 at 01:16:51AM +0000, Michael Kelley wrote:
> From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com> Sent: Friday, January 2, 2026 3:35 PM
> > 
> > On Fri, Jan 02, 2026 at 09:13:31PM +0000, Michael Kelley wrote:
> > > From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com> Sent: Friday, January 2, 2026 12:03 PM
> > > >
> > > > On Fri, Jan 02, 2026 at 06:04:56PM +0000, Michael Kelley wrote:
> > > > > From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com> Sent: Friday, January 2, 2026 9:43 AM
> > > > > >
> > > > > > On Tue, Dec 23, 2025 at 07:17:23PM +0000, Michael Kelley wrote:
> > > > > > > From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com> Sent: Tuesday, December 23, 2025 8:26 AM
> > > > > > > >
> > > > > > > > On Tue, Dec 23, 2025 at 03:51:22PM +0000, Michael Kelley wrote:
> > > > > > > > > From: Michael Kelley Sent: Monday, December 22, 2025 10:25 AM
> > > > > > > > > >
> > > > > > > > > [snip]
> > > > > > > > > >
> > > > > > > > > > Separately, in looking at this, I spotted another potential problem with
> > > > > > > > > > 2 Meg mappings that somewhat depends on hypervisor behavior that I'm
> > > > > > > > > > not clear on. To create a new region, the user space VMM issues the
> > > > > > > > > > MSHV_GET_GUEST_MEMORY ioctl, specifying the userspace address, the
> > > > > > > > > > size, and the guest PFN. The only requirement on these values is that the
> > > > > > > > > > userspace address and size be page aligned. But suppose a 4 Meg region is
> > > > > > > > > > specified where the userspace address and the guest PFN have different
> > > > > > > > > > offsets modulo 2 Meg. The userspace address range gets populated first,
> > > > > > > > > > and may contain a 2 Meg large page. Then when mshv_chunk_stride()
> > > > > > > > > > detects a 2 Meg aligned guest PFN so HVCALL_MAP_GPA_PAGES can be told
> > > > > > > > > > to create a 2 Meg mapping for the guest, the corresponding system PFN in
> > > > > > > > > > the page array may not be 2 Meg aligned. What does the hypervisor do in
> > > > > > > > > > this case? It can't create a 2 Meg mapping, right? So does it silently fallback
> > > > > > > > > > to creating 4K mappings, or does it return an error? Returning an error would
> > > > > > > > > > seem to be problematic for movable pages because the error wouldn't
> > > > > > > > > > occur until the guest VM is running and takes a range fault on the region.
> > > > > > > > > > Silently falling back to creating 4K mappings has performance implications,
> > > > > > > > > > though I guess it would work. My question is whether the
> > > > > > > > > > MSHV_GET_GUEST_MEMORY ioctl should detect this case and return an
> > > > > > > > > > error immediately.
> > > > > > > > > >
> > > > > > > > >
> > > > > > > > > In thinking about this more, I can answer my own question about the
> > > > > > > > > hypervisor behavior. When HVCALL_MAP_GPA_PAGES is set, the full
> > > > > > > > > list of 4K system PFNs is not provided as an input to the hypercall, so
> > > > > > > > > the hypervisor cannot silently fall back to 4K mappings. Assuming
> > > > > > > > > sequential PFNs would be wrong, so it must return an error if the
> > > > > > > > > alignment of a system PFN isn't on a 2 Meg boundary.
> > > > > > > > >
> > > > > > > > > For a pinned region, this error happens in mshv_region_map() as
> > > > > > > > > called from  mshv_prepare_pinned_region(), so will propagate back
> > > > > > > > > to the ioctl. But the error happens only if pin_user_pages_fast()
> > > > > > > > > allocates one or more 2 Meg pages. So creating a pinned region
> > > > > > > > > where the guest PFN and userspace address have different offsets
> > > > > > > > > modulo 2 Meg might or might not succeed.
> > > > > > > > >
> > > > > > > > > For a movable region, the error probably can't occur.
> > > > > > > > > mshv_region_handle_gfn_fault() builds an aligned 2 Meg chunk
> > > > > > > > > around the faulting guest PFN. mshv_region_range_fault() then
> > > > > > > > > determines the corresponding userspace addr, which won't be on
> > > > > > > > > a 2 Meg boundary, so the allocated memory won't contain a 2 Meg
> > > > > > > > > page. With no 2 Meg pages, mshv_region_remap_pages() will
> > > > > > > > > always do 4K mappings and will succeed. The downside is that a
> > > > > > > > > movable region with a guest PFN and userspace address with
> > > > > > > > > different offsets never gets any 2 Meg pages or mappings.
> > > > > > > > >
> > > > > > > > > My conclusion is the same -- such misalignment should not be
> > > > > > > > > allowed when creating a region that has the potential to use 2 Meg
> > > > > > > > > pages. Regions less than 2 Meg in size could be excluded from such
> > > > > > > > > a requirement if there is benefit in doing so. It's possible to have
> > > > > > > > > regions up to (but not including) 4 Meg where the alignment prevents
> > > > > > > > > having a 2 Meg page, and those could also be excluded from the
> > > > > > > > > requirement.
> > > > > > > > >
> > > > > > > >
> > > > > > > > I'm not sure I understand the problem.
> > > > > > > > There are three cases to consider:
> > > > > > > > 1. Guest mapping, where page sizes are controlled by the guest.
> > > > > > > > 2. Host mapping, where page sizes are controlled by the host.
> > > > > > >
> > > > > > > And by "host", you mean specifically the Linux instance running in the
> > > > > > > root partition. It hosts the VMM processes and creates the memory
> > > > > > > regions for each guest.
> > > > > > >
> > > > > > > > 3. Hypervisor mapping, where page sizes are controlled by the hypervisor.
> > > > > > > >
> > > > > > > > The first case is not relevant here and is included for completeness.
> > > > > > >
> > > > > > > Agreed.
> > > > > > >
> > > > > > > >
> > > > > > > > The second and third cases (host and hypervisor) share the memory layout,
> > > > > > >
> > > > > > > Right. More specifically, they are both operating on the same set of physical
> > > > > > > memory pages, and hence "share" a set of what I've referred to as
> > > > > > > "system PFNs" (to distinguish from guest PFNs, or GFNs).
> > > > > > >
> > > > > > > > but it is up
> > > > > > > > to each entity to decide which page sizes to use. For example, the host might map the
> > > > > > > > proposed 4M region with only 4K pages, even if a 2M page is available in the middle.
> > > > > > >
> > > > > > > Agreed.
> > > > > > >
> > > > > > > > In this case, the host will map the memory as represented by 4K pages, but the hypervisor
> > > > > > > > can still discover the 2M page in the middle and adjust its page tables to use a 2M page.
> > > > > > >
> > > > > > > Yes, that's possible, but subject to significant requirements. A 2M page can be
> > > > > > > used only if the underlying physical memory is a physically contiguous 2M chunk.
> > > > > > > Furthermore, that contiguous 2M chunk must start on a physical 2M boundary,
> > > > > > > and the virtual address to which it is being mapped must be on a 2M boundary.
> > > > > > > In the case of the host, that virtual address is the user space address in the
> > > > > > > user space process. In the case of the hypervisor, that "virtual address" is the
> > > > > > > the location in guest physical address space; i.e., the guest PFN left-shifted 9
> > > > > > > to be a guest physical address.
> > > > > > >
> > > > > > > These requirements are from the physical processor and its requirements on
> > > > > > > page table formats as specified by the hardware architecture. Whereas the
> > > > > > > page table entry for a 4K page contains the entire PFN, the page table entry
> > > > > > > for a 2M page omits the low order 9 bits of the PFN -- those bits must be zero,
> > > > > > > which is equivalent to requiring that the PFN be on a 2M boundary. These
> > > > > > > requirements apply to both host and hypervisor mappings.
> > > > > > >
> > > > > > > When MSHV code in the host creates a new pinned region via the ioctl,
> > > > > > > MSHV code first allocates memory for the region using pin_user_pages_fast(),
> > > > > > > which returns the system PFN for each page of physical memory that is
> > > > > > > allocated. If the host, at its discretion, allocates a 2M page, then a series
> > > > > > > of 512 sequential 4K PFNs is returned for that 2M page, and the first of
> > > > > > > the 512 sequential PFNs must have its low order 9 bits be zero.
> > > > > > >
> > > > > > > Then the MSHV ioctl makes the HVCALL_MAP_GPA_PAGES hypercall for
> > > > > > > the hypervisor to map the allocated memory into the guest physical
> > > > > > > address space at a particular guest PFN. If the allocated memory contains
> > > > > > > a 2M page, mshv_chunk_stride() will see a folio order of 9 for the 2M page,
> > > > > > > causing the HV_MAP_GPA_LARGE_PAGE flag to be set, which requests that
> > > > > > > the hypervisor do that mapping as a 2M large page. The hypercall does not
> > > > > > > have the option of dropping back to 4K page mappings in this case. If
> > > > > > > the 2M alignment of the system PFN is different from the 2M alignment
> > > > > > > of the target guest PFN, it's not possible to create the mapping and the
> > > > > > > hypercall fails.
> > > > > > >
> > > > > > > The core problem is that the same 2M of physical memory wants to be
> > > > > > > mapped by the host as a 2M page and by the hypervisor as a 2M page.
> > > > > > > That can't be done unless the host alignment (in the VMM virtual address
> > > > > > > space) and the guest physical address (i.e., the target guest PFN) alignment
> > > > > > > match and are both on 2M boundaries.
> > > > > > >
> > > > > >
> > > > > > But why is it a problem? If both the host and the hypervisor can map ap
> > > > > > huge page, but the guest can't, it's still a win, no?
> > > > > > In other words, if VMM passes a host huge page aligned region as a guest
> > > > > > unaligned, it's a VMM problem, not a hypervisor problem. And I' don't
> > > > > > understand why would we want to prevent such cases.
> > > > > >
> > > > >
> > > > > Fair enough -- mostly. If you want to allow the misaligned case and live
> > > > > with not getting the 2M mapping in the guest, that works except in the
> > > > > situation that I described above, where the HVCALL_MAP_GPA_PAGES
> > > > > hypercall fails when creating a pinned region.
> > > > >
> > > > > The failure is flakey in that if the Linux in the root partition does not
> > > > > map any of the region as a 2M page, the hypercall succeeds and the
> > > > > MSHV_GET_GUEST_MEMORY ioctl succeeds. But if the root partition
> > > > > happens to map any of the region as a 2M page, the hypercall will fail,
> > > > > and the MSHV_GET_GUEST_MEMORY ioctl will fail. Presumably such
> > > > > flakey behavior is bad for the VMM.
> > > > >
> > > > > One solution is that mshv_chunk_stride() must return a stride > 1 only
> > > > > if both the gfn (which it currently checks) AND the corresponding
> > > > > userspace_addr are 2M aligned. Then the HVCALL_MAP_GPA_PAGES
> > > > > hypercall will never have HV_MAP_GPA_LARGE_PAGE set for the
> > > > > misaligned case, and the failure won't occur.
> > > > >
> > > >
> > > > I think see your point, but I also think this issue doesn't exist,
> > > > because map_chunk_stride() returns huge page stride iff page if:
> > > > 1. the folio order is PMD_ORDER and
> > > > 2. GFN is huge page aligned and
> > > > 3. number of 4K pages is huge pages aligned.
> > > >
> > > > On other words, a host huge page won't be mapped as huge if the page
> > > > can't be mapped as huge in the guest.
> > >
> > > OK, I'm missing how what you say is true. For pinned regions,
> > > the memory is allocated and mapped into the host userspace address
> > > first, as done by mshv_prepare_pinned_region() calling mshv_region_pin(),
> > > which calls pin_user_pages_fast(). This is all done without considering
> > > the GFN or GFN alignment. So one or more 2M pages might be allocated
> > > and mapped in the host before any guest mapping is looked at. Agreed?
> > >
> > 
> > Agreed.
> > 
> > > Then mshv_prepare_pinned_region() calls mshv_region_map() to do the
> > > guest mapping. This eventually gets down to mshv_chunk_stride(). In
> > > mshv_chunk_stride() when your conditions #2 and #3 are met, the
> > > corresponding struct page argument to mshv_chunk_stride() may be a
> > > 4K page that is in the middle of a 2M page instead of at the beginning
> > > (if the region is mis-aligned). But the key point is that the 4K page in
> > > the middle is part of a folio that will return a folio order of PMD_ORDER.
> > > I.e., a folio order of PMD_ORDER is not sufficient to ensure that the
> > > struct page arg is at the *start* of a 2M-aligned physical memory range
> > > that can be mapped into the guest as a 2M page.
> > >
> > 
> > I'm trying to undestand how this can even happen, so please bear with
> > me.
> > In other words (and AFAIU), what you are saying in the following:
> > 
> > 1. VMM creates a mapping with a huge page(s) (this implies that virtual
> >    address is huge page aligned, size is huge page aligned and physical
> >    pages are consequtive).
> > 2. VMM tries to create a region via ioctl, but instead of passing the
> >    start of the region, is passes an offset into one of the the region's
> >    huge pages, and in the same time with the base GFN and the size huge
> >    page aligned (to meet the #2 and #3 conditions).
> > 3. mshv_chunk_stride() sees a folio order of PMD_ORDER, and tries to map
> >    the corresponding pages as huge, which will be rejected by the
> >    hypervisor.
> > 
> > Is this accurate?
> 
> Yes, pretty much. In Step 1, the VMM may just allocate some virtual
> address space, and not do anything to populate it with physical pages.
> So populating with any 2M pages may not happen until Step 2 when
> the ioctl calls pin_user_pages_fast(). But *when* the virtual address
> space gets populated with physical pages doesn't really matter. We
> just know that it happens before the ioctl tries to map the memory
> into the guest -- i.e., mshv_prepare_pinned_region() calls
> mshv_region_map().
> 
> And yes, the problem is what you call out in Step 2: as input to the
> ioctl, the fields "userspace_addr" and "guest_pfn" in struct
> mshv_user_mem_region could have different alignments modulo 2M
> boundaries. When they are different, that's what I'm calling a "mis-aligned
> region", (referring to a struct mshv_mem_region that is created and
> setup by the ioctl).
> 
> > A subseqeunt question: if it is accurate, why the driver needs to
> > support this case? It looks like a VMM bug to me.
> 
> I don't know if the driver needs to support this case. That's a question
> for the VMM people to answer. I wouldn't necessarily assume that the
> VMM always allocates virtual address space with exactly the size and
> alignment that matches the regions it creates with the ioctl. The
> kernel ioctl doesn't care how the VMM allocates and manages its
> virtual address space, so the VMM is free to do whatever it wants
> in that regard, as long as it meets the requirements of the ioctl. So
> the requirements of the ioctl in this case are something to be
> negotiated with the VMM.
> 
> > Also, how should it support it? By rejecting such requests in the ioctl?
> 
> Rejecting requests to create a mis-aligned region is certainly one option
> if the VMM agrees that's OK. The ioctl currently requires only that
> "userspace_addr" and "size" be page aligned, so those requirements
> could be tightened.
> 
> The other approach is to fix mshv_chunk_stride() to handle the
> mis-aligned case. Doing so it even easier than I first envisioned.
> I think this works:
> 
> @@ -49,7 +49,8 @@ static int mshv_chunk_stride(struct page *page,
>          */
>         if (page_order &&
>             IS_ALIGNED(gfn, PTRS_PER_PMD) &&
> -           IS_ALIGNED(page_count, PTRS_PER_PMD))
> +           IS_ALIGNED(page_count, PTRS_PER_PMD) &&
> +           IS_ALIGNED(page_to_pfn(page), PTRS_PER_PMD))
>                 return 1 << page_order;
> 
>         return 1;
> 
> But as we discussed earlier, this fix means never getting 2M mappings
> in the guest for a region that is mis-aligned.
> 

Although I understand the logic behind this fix, I’m hesitant to add it
because it looks like a workaround for a VMM bug that could bite back.
The approach you propose will silently map a huge page as a collection
of 4K pages, impacting guest performance (this will be especially
visible for a region containing a single huge page).

This fix silently allows such behavior instead of reporting it as an
error to user space. It’s worth noting that pinned-region population and
mapping happen upon ioctl invocation, so the VMM will either get an
error from the hypervisor (current behavior) or get a region mapped with
4K pages (proposed behavior).

The first case is an explicit error; the second — although it allows
adding a region — will be less performant, significantly increase region
mapping time and thus potentailly guest spin-up (creation) time, and be
less noticeable to customers, especially those who don’t really
understand what’s happening under the hood and simply stumbled upon some
VMM bug.

What’s your take?

Thanks,
Stanislav

> Michael
> 
> > 
> > Thanks,
> > Stanislav
> > 
> > > The problem does *not* happen with a movable region, but the reasoning
> > > is different. hmm_range_fault() is always called with a 2M range aligned
> > > to the GFN, which in a mis-aligned region means that the host userspace
> > > address is never 2M aligned. So hmm_range_fault() is never able to allocate
> > > and map a 2M page. mshv_chunk_stride() will never get a folio order > 1,
> > > and the hypercall is never asked to do a 2M mapping. Both host and guest
> > > mappings will always be 4K and everything works.
> > >
> > > Michael
> > >
> > > > And this function is called for
> > > > both movable and pinned region, so the hypercal should never fail due to
> > > > huge page alignment issue.
> > > >
> > > > What do I miss here?
> > > >
> > > > Thanks,
> > > > Stanislav
> > > >
> > > >
> > > > > Michael
> > > > >
> > > > > >
> > > > > > > Movable regions behave a bit differently because the memory for the
> > > > > > > region is not allocated on the host "up front" when the region is created.
> > > > > > > The memory is faulted in as the guest runs, and the vagaries of the current
> > > > > > > MSHV in Linux code are such that 2M pages are never created on the host
> > > > > > > if the alignments don't match. HV_MAP_GPA_LARGE_PAGE is never passed
> > > > > > > to the HVCALL_MAP_GPA_PAGES hypercall, so the hypervisor just does 4K
> > > > > > > mappings, which works even with the misalignment.
> > > > > > >
> > > > > > > >
> > > > > > > > This adjustment happens at runtime. Could this be the missing detail here?
> > > > > > >
> > > > > > > Adjustments at runtime are a different topic from the issue I'm raising,
> > > > > > > though eventually there's some relationship. My issue occurs in the
> > > > > > > creation of a new region, and the setting up of the initial hypervisor
> > > > > > > mapping. I haven't thought through the details of adjustments at runtime.
> > > > > > >
> > > > > > > My usual caveats apply -- this is all "thought experiment". If I had the
> > > > > > > means do some runtime testing to confirm, I would. It's possible the
> > > > > > > hypervisor is playing some trick I haven't envisioned, but I'm skeptical of
> > > > > > > that given the basics of how physical processors work with page tables.
> > > > > > >
> > > > > > > Michael

