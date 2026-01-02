Return-Path: <linux-hyperv+bounces-8119-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 748B2CEF160
	for <lists+linux-hyperv@lfdr.de>; Fri, 02 Jan 2026 18:42:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DC5B03008184
	for <lists+linux-hyperv@lfdr.de>; Fri,  2 Jan 2026 17:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51FCF2EB5A9;
	Fri,  2 Jan 2026 17:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="nruN8O7h"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D2132EDD78;
	Fri,  2 Jan 2026 17:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767375772; cv=none; b=bF2Mb/Z4Xsf3fR4MVOKlwxai9x+Q0a3hyNf/s4YAuW1fuC75eYTw3aGqYX/sdvmzZYdCQQ6LjPR86CO+AhqPCawq9nc4jD3Z9eJgP+fEndpKkaZoUl42bqkTLojZ+OeFHUqBoLQFwRVGmObSKVk3tmkOpFxMFJm4DyLZzOoMJX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767375772; c=relaxed/simple;
	bh=HQb3vB8ICaoBnPji3MaESERZAp6eVSq6rzx32OOqKL8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fdS0YUfMmLKICDzzAwBh59rc9m5IWP6E91hElJRkNS3N8SY7XpFmE3t5eBcJ5V8sHIVOyDt3e+c5W2+uEzxyeAHtAmajP0boXO9w21acUeWtyYnVueTE0W/CmlwGB9W/z7fLhOeBaAlhU6Iq7TjSfAA01CvVzk7MHpMOws4IJ7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=nruN8O7h; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii.localdomain (unknown [40.65.108.177])
	by linux.microsoft.com (Postfix) with ESMTPSA id 1535E2124E24;
	Fri,  2 Jan 2026 09:42:48 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1535E2124E24
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1767375769;
	bh=QXyUTXmLfoXrjFJhlfdYahGR+dfBm2YCOEEev3H8Ebg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nruN8O7hehT6KaMnaxBiWV/SOJm0FlbfDUuyG57HqABKfGgg1jrXFjySCd1Jw45dK
	 OF32bbWLG7Xhz8kDLrChMf2hOqidN07ukJ8qnX/fWBaO3fKhfjMbtjzMNTke+qeujT
	 Cb765uuIAcRcympEh/Lihem9fzQbaHYwCpp2WTLw=
Date: Fri, 2 Jan 2026 09:42:46 -0800
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
Message-ID: <aVgDloDX9nMH6hZH@skinsburskii.localdomain>
References: <176593206931.276257.13023250440372517478.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <SN6PR02MB4157D69A4C08B0A4FE01F9FED4A8A@SN6PR02MB4157.namprd02.prod.outlook.com>
 <aUXXdjMyZ5swiCI2@skinsburskii.localdomain>
 <SN6PR02MB41578A17A4DADD9276392298D4B4A@SN6PR02MB4157.namprd02.prod.outlook.com>
 <SN6PR02MB4157AAFDD8BD5BDCD2D3DB99D4B5A@SN6PR02MB4157.namprd02.prod.outlook.com>
 <aUrCr5wBSTrGm-IM@skinsburskii.localdomain>
 <SN6PR02MB41573BF52C6A4447C720CDD6D4B5A@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR02MB41573BF52C6A4447C720CDD6D4B5A@SN6PR02MB4157.namprd02.prod.outlook.com>

On Tue, Dec 23, 2025 at 07:17:23PM +0000, Michael Kelley wrote:
> From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com> Sent: Tuesday, December 23, 2025 8:26 AM
> > 
> > On Tue, Dec 23, 2025 at 03:51:22PM +0000, Michael Kelley wrote:
> > > From: Michael Kelley Sent: Monday, December 22, 2025 10:25 AM
> > > >
> > > [snip]
> > > >
> > > > Separately, in looking at this, I spotted another potential problem with
> > > > 2 Meg mappings that somewhat depends on hypervisor behavior that I'm
> > > > not clear on. To create a new region, the user space VMM issues the
> > > > MSHV_GET_GUEST_MEMORY ioctl, specifying the userspace address, the
> > > > size, and the guest PFN. The only requirement on these values is that the
> > > > userspace address and size be page aligned. But suppose a 4 Meg region is
> > > > specified where the userspace address and the guest PFN have different
> > > > offsets modulo 2 Meg. The userspace address range gets populated first,
> > > > and may contain a 2 Meg large page. Then when mshv_chunk_stride()
> > > > detects a 2 Meg aligned guest PFN so HVCALL_MAP_GPA_PAGES can be told
> > > > to create a 2 Meg mapping for the guest, the corresponding system PFN in
> > > > the page array may not be 2 Meg aligned. What does the hypervisor do in
> > > > this case? It can't create a 2 Meg mapping, right? So does it silently fallback
> > > > to creating 4K mappings, or does it return an error? Returning an error would
> > > > seem to be problematic for movable pages because the error wouldn't
> > > > occur until the guest VM is running and takes a range fault on the region.
> > > > Silently falling back to creating 4K mappings has performance implications,
> > > > though I guess it would work. My question is whether the
> > > > MSHV_GET_GUEST_MEMORY ioctl should detect this case and return an
> > > > error immediately.
> > > >
> > >
> > > In thinking about this more, I can answer my own question about the
> > > hypervisor behavior. When HVCALL_MAP_GPA_PAGES is set, the full
> > > list of 4K system PFNs is not provided as an input to the hypercall, so
> > > the hypervisor cannot silently fall back to 4K mappings. Assuming
> > > sequential PFNs would be wrong, so it must return an error if the
> > > alignment of a system PFN isn't on a 2 Meg boundary.
> > >
> > > For a pinned region, this error happens in mshv_region_map() as
> > > called from  mshv_prepare_pinned_region(), so will propagate back
> > > to the ioctl. But the error happens only if pin_user_pages_fast()
> > > allocates one or more 2 Meg pages. So creating a pinned region
> > > where the guest PFN and userspace address have different offsets
> > > modulo 2 Meg might or might not succeed.
> > >
> > > For a movable region, the error probably can't occur.
> > > mshv_region_handle_gfn_fault() builds an aligned 2 Meg chunk
> > > around the faulting guest PFN. mshv_region_range_fault() then
> > > determines the corresponding userspace addr, which won't be on
> > > a 2 Meg boundary, so the allocated memory won't contain a 2 Meg
> > > page. With no 2 Meg pages, mshv_region_remap_pages() will
> > > always do 4K mappings and will succeed. The downside is that a
> > > movable region with a guest PFN and userspace address with
> > > different offsets never gets any 2 Meg pages or mappings.
> > >
> > > My conclusion is the same -- such misalignment should not be
> > > allowed when creating a region that has the potential to use 2 Meg
> > > pages. Regions less than 2 Meg in size could be excluded from such
> > > a requirement if there is benefit in doing so. It's possible to have
> > > regions up to (but not including) 4 Meg where the alignment prevents
> > > having a 2 Meg page, and those could also be excluded from the
> > > requirement.
> > >
> > 
> > I'm not sure I understand the problem.
> > There are three cases to consider:
> > 1. Guest mapping, where page sizes are controlled by the guest.
> > 2. Host mapping, where page sizes are controlled by the host.
> 
> And by "host", you mean specifically the Linux instance running in the
> root partition. It hosts the VMM processes and creates the memory
> regions for each guest.
> 
> > 3. Hypervisor mapping, where page sizes are controlled by the hypervisor.
> > 
> > The first case is not relevant here and is included for completeness.
> 
> Agreed.
> 
> > 
> > The second and third cases (host and hypervisor) share the memory layout, 
> 
> Right. More specifically, they are both operating on the same set of physical
> memory pages, and hence "share" a set of what I've referred to as
> "system PFNs" (to distinguish from guest PFNs, or GFNs).
> 
> > but it is up
> > to each entity to decide which page sizes to use. For example, the host might map the
> > proposed 4M region with only 4K pages, even if a 2M page is available in the middle.
> 
> Agreed.
> 
> > In this case, the host will map the memory as represented by 4K pages, but the hypervisor
> > can still discover the 2M page in the middle and adjust its page tables to use a 2M page.
> 
> Yes, that's possible, but subject to significant requirements. A 2M page can be
> used only if the underlying physical memory is a physically contiguous 2M chunk.
> Furthermore, that contiguous 2M chunk must start on a physical 2M boundary,
> and the virtual address to which it is being mapped must be on a 2M boundary.
> In the case of the host, that virtual address is the user space address in the
> user space process. In the case of the hypervisor, that "virtual address" is the
> the location in guest physical address space; i.e., the guest PFN left-shifted 9
> to be a guest physical address.
> 
> These requirements are from the physical processor and its requirements on
> page table formats as specified by the hardware architecture. Whereas the
> page table entry for a 4K page contains the entire PFN, the page table entry
> for a 2M page omits the low order 9 bits of the PFN -- those bits must be zero,
> which is equivalent to requiring that the PFN be on a 2M boundary. These
> requirements apply to both host and hypervisor mappings.
> 
> When MSHV code in the host creates a new pinned region via the ioctl,
> MSHV code first allocates memory for the region using pin_user_pages_fast(),
> which returns the system PFN for each page of physical memory that is
> allocated. If the host, at its discretion, allocates a 2M page, then a series
> of 512 sequential 4K PFNs is returned for that 2M page, and the first of
> the 512 sequential PFNs must have its low order 9 bits be zero.
> 
> Then the MSHV ioctl makes the HVCALL_MAP_GPA_PAGES hypercall for
> the hypervisor to map the allocated memory into the guest physical
> address space at a particular guest PFN. If the allocated memory contains
> a 2M page, mshv_chunk_stride() will see a folio order of 9 for the 2M page,
> causing the HV_MAP_GPA_LARGE_PAGE flag to be set, which requests that
> the hypervisor do that mapping as a 2M large page. The hypercall does not
> have the option of dropping back to 4K page mappings in this case. If
> the 2M alignment of the system PFN is different from the 2M alignment
> of the target guest PFN, it's not possible to create the mapping and the
> hypercall fails.
> 
> The core problem is that the same 2M of physical memory wants to be
> mapped by the host as a 2M page and by the hypervisor as a 2M page.
> That can't be done unless the host alignment (in the VMM virtual address
> space) and the guest physical address (i.e., the target guest PFN) alignment
> match and are both on 2M boundaries.
> 

But why is it a problem? If both the host and the hypervisor can map ap
huge page, but the guest can't, it's still a win, no?
In other words, if VMM passes a host huge page aligned region as a guest
unaligned, it's a VMM problem, not a hypervisor problem. And I' don't
understand why would we want to prevent such cases.

Thanks,
Stanislav

> Movable regions behave a bit differently because the memory for the
> region is not allocated on the host "up front" when the region is created.
> The memory is faulted in as the guest runs, and the vagaries of the current
> MSHV in Linux code are such that 2M pages are never created on the host
> if the alignments don't match. HV_MAP_GPA_LARGE_PAGE is never passed
> to the HVCALL_MAP_GPA_PAGES hypercall, so the hypervisor just does 4K
> mappings, which works even with the misalignment.
> 
> > 
> > This adjustment happens at runtime. Could this be the missing detail here?
> 
> Adjustments at runtime are a different topic from the issue I'm raising,
> though eventually there's some relationship. My issue occurs in the
> creation of a new region, and the setting up of the initial hypervisor
> mapping. I haven't thought through the details of adjustments at runtime.
> 
> My usual caveats apply -- this is all "thought experiment". If I had the
> means do some runtime testing to confirm, I would. It's possible the
> hypervisor is playing some trick I haven't envisioned, but I'm skeptical of
> that given the basics of how physical processors work with page tables.
> 
> Michael

