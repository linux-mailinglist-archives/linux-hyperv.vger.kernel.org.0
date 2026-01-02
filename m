Return-Path: <linux-hyperv+bounces-8133-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D359CEF7BA
	for <lists+linux-hyperv@lfdr.de>; Sat, 03 Jan 2026 00:35:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D1C33300A1F2
	for <lists+linux-hyperv@lfdr.de>; Fri,  2 Jan 2026 23:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A866A248F5A;
	Fri,  2 Jan 2026 23:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="L81kKUOD"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5C851A08BC;
	Fri,  2 Jan 2026 23:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767396921; cv=none; b=JuOfX3sF9gV3C2y6lJMvnYdPRRB5fyaZWC2/N6XOGBg9LdZml8gye/qFz4kKGKKm+yNmTJqHRsrY2k2xJr6k9vOkIOR7TUBiuPWNlUF4niOCmED5lvZjE1DQAIX8Yv+yZ+9e0fF3JASFdNqKWBxRJQ0owOq1zRHk/BG2ZggZncQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767396921; c=relaxed/simple;
	bh=MTbWTXskR9shkEyRyRBWFKrL/Y1N4v5S8iXjPmoxS0M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jcltI9Xw6jcOPcSiINgA5uPZSu8A0os+SnxzJMmzSnLlJBVyQwo78HBXFLUpzuurYp7iXF/bPqihEi/lqLyy8AAwn4GpPuzQrblmvZLqserOoT/6fWMnWd13WYQ3sYQjUmRFLHYyRLZ7/Q0QRxYn0+F0V9yWko/2yzNf5oqAQ7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=L81kKUOD; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii.localdomain (unknown [20.191.74.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id EC9A22124E24;
	Fri,  2 Jan 2026 15:35:17 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com EC9A22124E24
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1767396918;
	bh=7qDfKHU38fidhfq5HXOSE9CmvwkWQVAyRGFV25/twUk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L81kKUOD6JRdH8DuVYyCuaci3p2gSW1u86LQcheJ7e7lHE2pMoAuDyae6kBJuBN0u
	 vq9YpRy9pEzaQUKWZ2uzTsfZIMRViCiPT/U0XN2jFD9IY6JZELM4ZFUJ6U8Qw1neAb
	 MZCXR911qHQpS8cZvAcjbghLs2wxjZkfC2UCyj94=
Date: Fri, 2 Jan 2026 15:35:14 -0800
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
Message-ID: <aVhWMoH3GvpGAR0a@skinsburskii.localdomain>
References: <SN6PR02MB4157D69A4C08B0A4FE01F9FED4A8A@SN6PR02MB4157.namprd02.prod.outlook.com>
 <aUXXdjMyZ5swiCI2@skinsburskii.localdomain>
 <SN6PR02MB41578A17A4DADD9276392298D4B4A@SN6PR02MB4157.namprd02.prod.outlook.com>
 <SN6PR02MB4157AAFDD8BD5BDCD2D3DB99D4B5A@SN6PR02MB4157.namprd02.prod.outlook.com>
 <aUrCr5wBSTrGm-IM@skinsburskii.localdomain>
 <SN6PR02MB41573BF52C6A4447C720CDD6D4B5A@SN6PR02MB4157.namprd02.prod.outlook.com>
 <aVgDloDX9nMH6hZH@skinsburskii.localdomain>
 <SN6PR02MB4157288D26ECC9E69240CFECD4BBA@SN6PR02MB4157.namprd02.prod.outlook.com>
 <aVgkj4V60kddKk4o@skinsburskii.localdomain>
 <SN6PR02MB415724D13B2751F8FAA1053BD4BBA@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR02MB415724D13B2751F8FAA1053BD4BBA@SN6PR02MB4157.namprd02.prod.outlook.com>

On Fri, Jan 02, 2026 at 09:13:31PM +0000, Michael Kelley wrote:
> From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com> Sent: Friday, January 2, 2026 12:03 PM
> > 
> > On Fri, Jan 02, 2026 at 06:04:56PM +0000, Michael Kelley wrote:
> > > From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com> Sent: Friday, January 2, 2026 9:43 AM
> > > >
> > > > On Tue, Dec 23, 2025 at 07:17:23PM +0000, Michael Kelley wrote:
> > > > > From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com> Sent: Tuesday, December 23, 2025 8:26 AM
> > > > > >
> > > > > > On Tue, Dec 23, 2025 at 03:51:22PM +0000, Michael Kelley wrote:
> > > > > > > From: Michael Kelley Sent: Monday, December 22, 2025 10:25 AM
> > > > > > > >
> > > > > > > [snip]
> > > > > > > >
> > > > > > > > Separately, in looking at this, I spotted another potential problem with
> > > > > > > > 2 Meg mappings that somewhat depends on hypervisor behavior that I'm
> > > > > > > > not clear on. To create a new region, the user space VMM issues the
> > > > > > > > MSHV_GET_GUEST_MEMORY ioctl, specifying the userspace address, the
> > > > > > > > size, and the guest PFN. The only requirement on these values is that the
> > > > > > > > userspace address and size be page aligned. But suppose a 4 Meg region is
> > > > > > > > specified where the userspace address and the guest PFN have different
> > > > > > > > offsets modulo 2 Meg. The userspace address range gets populated first,
> > > > > > > > and may contain a 2 Meg large page. Then when mshv_chunk_stride()
> > > > > > > > detects a 2 Meg aligned guest PFN so HVCALL_MAP_GPA_PAGES can be told
> > > > > > > > to create a 2 Meg mapping for the guest, the corresponding system PFN in
> > > > > > > > the page array may not be 2 Meg aligned. What does the hypervisor do in
> > > > > > > > this case? It can't create a 2 Meg mapping, right? So does it silently fallback
> > > > > > > > to creating 4K mappings, or does it return an error? Returning an error would
> > > > > > > > seem to be problematic for movable pages because the error wouldn't
> > > > > > > > occur until the guest VM is running and takes a range fault on the region.
> > > > > > > > Silently falling back to creating 4K mappings has performance implications,
> > > > > > > > though I guess it would work. My question is whether the
> > > > > > > > MSHV_GET_GUEST_MEMORY ioctl should detect this case and return an
> > > > > > > > error immediately.
> > > > > > > >
> > > > > > >
> > > > > > > In thinking about this more, I can answer my own question about the
> > > > > > > hypervisor behavior. When HVCALL_MAP_GPA_PAGES is set, the full
> > > > > > > list of 4K system PFNs is not provided as an input to the hypercall, so
> > > > > > > the hypervisor cannot silently fall back to 4K mappings. Assuming
> > > > > > > sequential PFNs would be wrong, so it must return an error if the
> > > > > > > alignment of a system PFN isn't on a 2 Meg boundary.
> > > > > > >
> > > > > > > For a pinned region, this error happens in mshv_region_map() as
> > > > > > > called from  mshv_prepare_pinned_region(), so will propagate back
> > > > > > > to the ioctl. But the error happens only if pin_user_pages_fast()
> > > > > > > allocates one or more 2 Meg pages. So creating a pinned region
> > > > > > > where the guest PFN and userspace address have different offsets
> > > > > > > modulo 2 Meg might or might not succeed.
> > > > > > >
> > > > > > > For a movable region, the error probably can't occur.
> > > > > > > mshv_region_handle_gfn_fault() builds an aligned 2 Meg chunk
> > > > > > > around the faulting guest PFN. mshv_region_range_fault() then
> > > > > > > determines the corresponding userspace addr, which won't be on
> > > > > > > a 2 Meg boundary, so the allocated memory won't contain a 2 Meg
> > > > > > > page. With no 2 Meg pages, mshv_region_remap_pages() will
> > > > > > > always do 4K mappings and will succeed. The downside is that a
> > > > > > > movable region with a guest PFN and userspace address with
> > > > > > > different offsets never gets any 2 Meg pages or mappings.
> > > > > > >
> > > > > > > My conclusion is the same -- such misalignment should not be
> > > > > > > allowed when creating a region that has the potential to use 2 Meg
> > > > > > > pages. Regions less than 2 Meg in size could be excluded from such
> > > > > > > a requirement if there is benefit in doing so. It's possible to have
> > > > > > > regions up to (but not including) 4 Meg where the alignment prevents
> > > > > > > having a 2 Meg page, and those could also be excluded from the
> > > > > > > requirement.
> > > > > > >
> > > > > >
> > > > > > I'm not sure I understand the problem.
> > > > > > There are three cases to consider:
> > > > > > 1. Guest mapping, where page sizes are controlled by the guest.
> > > > > > 2. Host mapping, where page sizes are controlled by the host.
> > > > >
> > > > > And by "host", you mean specifically the Linux instance running in the
> > > > > root partition. It hosts the VMM processes and creates the memory
> > > > > regions for each guest.
> > > > >
> > > > > > 3. Hypervisor mapping, where page sizes are controlled by the hypervisor.
> > > > > >
> > > > > > The first case is not relevant here and is included for completeness.
> > > > >
> > > > > Agreed.
> > > > >
> > > > > >
> > > > > > The second and third cases (host and hypervisor) share the memory layout,
> > > > >
> > > > > Right. More specifically, they are both operating on the same set of physical
> > > > > memory pages, and hence "share" a set of what I've referred to as
> > > > > "system PFNs" (to distinguish from guest PFNs, or GFNs).
> > > > >
> > > > > > but it is up
> > > > > > to each entity to decide which page sizes to use. For example, the host might map the
> > > > > > proposed 4M region with only 4K pages, even if a 2M page is available in the middle.
> > > > >
> > > > > Agreed.
> > > > >
> > > > > > In this case, the host will map the memory as represented by 4K pages, but the hypervisor
> > > > > > can still discover the 2M page in the middle and adjust its page tables to use a 2M page.
> > > > >
> > > > > Yes, that's possible, but subject to significant requirements. A 2M page can be
> > > > > used only if the underlying physical memory is a physically contiguous 2M chunk.
> > > > > Furthermore, that contiguous 2M chunk must start on a physical 2M boundary,
> > > > > and the virtual address to which it is being mapped must be on a 2M boundary.
> > > > > In the case of the host, that virtual address is the user space address in the
> > > > > user space process. In the case of the hypervisor, that "virtual address" is the
> > > > > the location in guest physical address space; i.e., the guest PFN left-shifted 9
> > > > > to be a guest physical address.
> > > > >
> > > > > These requirements are from the physical processor and its requirements on
> > > > > page table formats as specified by the hardware architecture. Whereas the
> > > > > page table entry for a 4K page contains the entire PFN, the page table entry
> > > > > for a 2M page omits the low order 9 bits of the PFN -- those bits must be zero,
> > > > > which is equivalent to requiring that the PFN be on a 2M boundary. These
> > > > > requirements apply to both host and hypervisor mappings.
> > > > >
> > > > > When MSHV code in the host creates a new pinned region via the ioctl,
> > > > > MSHV code first allocates memory for the region using pin_user_pages_fast(),
> > > > > which returns the system PFN for each page of physical memory that is
> > > > > allocated. If the host, at its discretion, allocates a 2M page, then a series
> > > > > of 512 sequential 4K PFNs is returned for that 2M page, and the first of
> > > > > the 512 sequential PFNs must have its low order 9 bits be zero.
> > > > >
> > > > > Then the MSHV ioctl makes the HVCALL_MAP_GPA_PAGES hypercall for
> > > > > the hypervisor to map the allocated memory into the guest physical
> > > > > address space at a particular guest PFN. If the allocated memory contains
> > > > > a 2M page, mshv_chunk_stride() will see a folio order of 9 for the 2M page,
> > > > > causing the HV_MAP_GPA_LARGE_PAGE flag to be set, which requests that
> > > > > the hypervisor do that mapping as a 2M large page. The hypercall does not
> > > > > have the option of dropping back to 4K page mappings in this case. If
> > > > > the 2M alignment of the system PFN is different from the 2M alignment
> > > > > of the target guest PFN, it's not possible to create the mapping and the
> > > > > hypercall fails.
> > > > >
> > > > > The core problem is that the same 2M of physical memory wants to be
> > > > > mapped by the host as a 2M page and by the hypervisor as a 2M page.
> > > > > That can't be done unless the host alignment (in the VMM virtual address
> > > > > space) and the guest physical address (i.e., the target guest PFN) alignment
> > > > > match and are both on 2M boundaries.
> > > > >
> > > >
> > > > But why is it a problem? If both the host and the hypervisor can map ap
> > > > huge page, but the guest can't, it's still a win, no?
> > > > In other words, if VMM passes a host huge page aligned region as a guest
> > > > unaligned, it's a VMM problem, not a hypervisor problem. And I' don't
> > > > understand why would we want to prevent such cases.
> > > >
> > >
> > > Fair enough -- mostly. If you want to allow the misaligned case and live
> > > with not getting the 2M mapping in the guest, that works except in the
> > > situation that I described above, where the HVCALL_MAP_GPA_PAGES
> > > hypercall fails when creating a pinned region.
> > >
> > > The failure is flakey in that if the Linux in the root partition does not
> > > map any of the region as a 2M page, the hypercall succeeds and the
> > > MSHV_GET_GUEST_MEMORY ioctl succeeds. But if the root partition
> > > happens to map any of the region as a 2M page, the hypercall will fail,
> > > and the MSHV_GET_GUEST_MEMORY ioctl will fail. Presumably such
> > > flakey behavior is bad for the VMM.
> > >
> > > One solution is that mshv_chunk_stride() must return a stride > 1 only
> > > if both the gfn (which it currently checks) AND the corresponding
> > > userspace_addr are 2M aligned. Then the HVCALL_MAP_GPA_PAGES
> > > hypercall will never have HV_MAP_GPA_LARGE_PAGE set for the
> > > misaligned case, and the failure won't occur.
> > >
> > 
> > I think see your point, but I also think this issue doesn't exist,
> > because map_chunk_stride() returns huge page stride iff page if:
> > 1. the folio order is PMD_ORDER and
> > 2. GFN is huge page aligned and
> > 3. number of 4K pages is huge pages aligned.
> > 
> > On other words, a host huge page won't be mapped as huge if the page
> > can't be mapped as huge in the guest.
> 
> OK, I'm missing how what you say is true. For pinned regions,
> the memory is allocated and mapped into the host userspace address
> first, as done by mshv_prepare_pinned_region() calling mshv_region_pin(),
> which calls pin_user_pages_fast(). This is all done without considering
> the GFN or GFN alignment. So one or more 2M pages might be allocated
> and mapped in the host before any guest mapping is looked at. Agreed?
> 

Agreed.

> Then mshv_prepare_pinned_region() calls mshv_region_map() to do the
> guest mapping. This eventually gets down to mshv_chunk_stride(). In
> mshv_chunk_stride() when your conditions #2 and #3 are met, the
> corresponding struct page argument to mshv_chunk_stride() may be a
> 4K page that is in the middle of a 2M page instead of at the beginning
> (if the region is mis-aligned). But the key point is that the 4K page in
> the middle is part of a folio that will return a folio order of PMD_ORDER.
> I.e., a folio order of PMD_ORDER is not sufficient to ensure that the
> struct page arg is at the *start* of a 2M-aligned physical memory range
> that can be mapped into the guest as a 2M page.
> 

I'm trying to undestand how this can even happen, so please bear with
me.
In other words (and AFAIU), what you are saying in the following:

1. VMM creates a mapping with a huge page(s) (this implies that virtual
   address is huge page aligned, size is huge page aligned and physical
   pages are consequtive).
2. VMM tries to create a region via ioctl, but instead of passing the
   start of the region, is passes an offset into one of the the region's
   huge pages, and in the same time with the base GFN and the size huge
   page aligned (to meet the #2 and #3 conditions).
3. mshv_chunk_stride() sees a folio order of PMD_ORDER, and tries to map
   the corresponding pages as huge, which will be rejected by the
   hypervisor.

Is this accurate?
A subseqeunt question: if it is accurate, why the driver needs to
support this case? It looks like a VMM bug to me.
Also, how should it support it? By rejecting such requests in the ioctl?

Thanks,
Stanislav

> The problem does *not* happen with a movable region, but the reasoning
> is different. hmm_range_fault() is always called with a 2M range aligned
> to the GFN, which in a mis-aligned region means that the host userspace
> address is never 2M aligned. So hmm_range_fault() is never able to allocate
> and map a 2M page. mshv_chunk_stride() will never get a folio order > 1,
> and the hypercall is never asked to do a 2M mapping. Both host and guest
> mappings will always be 4K and everything works.
> 
> Michael
> 
> > And this function is called for
> > both movable and pinned region, so the hypercal should never fail due to
> > huge page alignment issue.
> > 
> > What do I miss here?
> > 
> > Thanks,
> > Stanislav
> > 
> > 
> > > Michael
> > >
> > > >
> > > > > Movable regions behave a bit differently because the memory for the
> > > > > region is not allocated on the host "up front" when the region is created.
> > > > > The memory is faulted in as the guest runs, and the vagaries of the current
> > > > > MSHV in Linux code are such that 2M pages are never created on the host
> > > > > if the alignments don't match. HV_MAP_GPA_LARGE_PAGE is never passed
> > > > > to the HVCALL_MAP_GPA_PAGES hypercall, so the hypervisor just does 4K
> > > > > mappings, which works even with the misalignment.
> > > > >
> > > > > >
> > > > > > This adjustment happens at runtime. Could this be the missing detail here?
> > > > >
> > > > > Adjustments at runtime are a different topic from the issue I'm raising,
> > > > > though eventually there's some relationship. My issue occurs in the
> > > > > creation of a new region, and the setting up of the initial hypervisor
> > > > > mapping. I haven't thought through the details of adjustments at runtime.
> > > > >
> > > > > My usual caveats apply -- this is all "thought experiment". If I had the
> > > > > means do some runtime testing to confirm, I would. It's possible the
> > > > > hypervisor is playing some trick I haven't envisioned, but I'm skeptical of
> > > > > that given the basics of how physical processors work with page tables.
> > > > >
> > > > > Michael

