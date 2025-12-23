Return-Path: <linux-hyperv+bounces-8063-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1412ACD9F71
	for <lists+linux-hyperv@lfdr.de>; Tue, 23 Dec 2025 17:30:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D51313037539
	for <lists+linux-hyperv@lfdr.de>; Tue, 23 Dec 2025 16:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 529672E1C57;
	Tue, 23 Dec 2025 16:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="p5D5kS8N"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A80102222A9;
	Tue, 23 Dec 2025 16:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766507260; cv=none; b=nDH+eShtnvZbtRJb7LjMuyra6wWmlvBsSYD92OPKxQdgHK6cIRnGNRxl995LUkDiGp3oNjOiaCp8g3D5OjEpgwT6PQo2JVDK+0G4TCZQ94XGjOr0g3mp8PjKk8dlGqR9pW65+irnOa/QlNVu7a8HFY03w9EDGp3262EjlcbHOrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766507260; c=relaxed/simple;
	bh=wizaPBw6S6+gWXjzNDRrGDKm1kXJHDPD+feJkH64nEo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tGOPyFw81EkGNZgqBopW6y3ECwroAeT0NQz54Kx4ftChQGiV99gQFs6dQJ1iWYftEvZiNAHWOvjkTeLykT2V/uIkBc0dCO543HK1SpNidWakXfcpirD61VWUIG6gruZzojtrsHZekMlLbcTUPX6g9mLC9rz0o7GWD0xm7izGBac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=p5D5kS8N; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii.localdomain (c-98-225-44-182.hsd1.wa.comcast.net [98.225.44.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id CEA5E206C171;
	Tue, 23 Dec 2025 08:27:36 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com CEA5E206C171
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1766507257;
	bh=4JBYQIBu2vKnlfcg4UJjooyq9mN3EG03Bl67MpDEkmA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p5D5kS8N5vPL7Rfd+8IhSwNm3NHkoLJZ70CXUULm9h5h6DZd1GbzRkE1ksDnwkEh5
	 XSjhNn7woOWUzWzjnCEQ1mUmCKC+cocz+Tp+tFouUwPiGCnLb4rsFdlfch7i4W1qfC
	 y/uRlFG9lSoH7ZS/Q6613R/EXBG8urbviiHgOImw=
Date: Tue, 23 Dec 2025 08:27:35 -0800
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
Message-ID: <aUrC94YvscoqBzh3@skinsburskii.localdomain>
References: <176593206931.276257.13023250440372517478.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <SN6PR02MB4157D69A4C08B0A4FE01F9FED4A8A@SN6PR02MB4157.namprd02.prod.outlook.com>
 <aUXXdjMyZ5swiCI2@skinsburskii.localdomain>
 <SN6PR02MB41578A17A4DADD9276392298D4B4A@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR02MB41578A17A4DADD9276392298D4B4A@SN6PR02MB4157.namprd02.prod.outlook.com>

On Mon, Dec 22, 2025 at 06:25:02PM +0000, Michael Kelley wrote:
> From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com> Sent: Friday, December 19, 2025 2:54 PM
> > 
> > On Thu, Dec 18, 2025 at 07:41:24PM +0000, Michael Kelley wrote:
> > > From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com> Sent: Tuesday,
> > December 16, 2025 4:41 PM
> > > >
> > > > Ensure that a stride larger than 1 (huge page) is only used when both
> > > > the guest frame number (gfn) and the operation size (page_count) are
> > > > aligned to the huge page size (PTRS_PER_PMD). This matches the
> > > > hypervisor requirement that map/unmap operations for huge pages must be
> > > > guest-aligned and cover a full huge page.
> > > >
> > > > Add mshv_chunk_stride() to encapsulate this alignment and page-order
> > > > validation, and plumb a huge_page flag into the region chunk handlers.
> > > > This prevents issuing large-page map/unmap/share operations that the
> > > > hypervisor would reject due to misaligned guest mappings.
> > >
> > > This code looks good to me on the surface. But I can only make an educated
> > > guess as to the hypervisor behavior in certain situations, and if my guess is
> > > correct there's still a flaw in one case.
> > >
> > > Consider the madvise() DONTNEED experiment that I previously called out. [1]
> > > I surmise that the intent of this patch is to make that case work correctly.
> > > When the .invalidate callback is made for the 32 Kbyte range embedded in
> > > a previously mapped 2 Meg page, this new code detects that case. It calls the
> > > hypervisor to remap the 32 Kbyte range for no access, and clears the 8
> > > corresponding entries in the struct page array attached to the mshv region. The
> > > call to the hypervisor is made *without* the HV_MAP_GPA_LARGE_PAGE flag.
> > > Since the mapping was originally done *with* the HV_MAP_GPA_LARGE_PAGE
> > > flag, my guess is that the hypervisor is smart enough to handle this case by
> > > splitting the 2 Meg mapping it created, setting the 32 Kbyte range to no access,
> > > and returning "success". If my guess is correct, there's no problem here.
> > >
> > > But then there's a second .invalidate callback for the entire 2 Meg page. Here's
> > > the call stack:
> > >
> > > [  194.259337]  dump_stack+0x14/0x20
> > > [  194.259339]  mhktest_invalidate+0x2a/0x40  [my dummy invalidate callback]
> > > [  194.259342]  __mmu_notifier_invalidate_range_start+0x1f4/0x250
> > > [  194.259347]  __split_huge_pmd+0x14f/0x170
> > > [  194.259349]  unmap_page_range+0x104d/0x1a00
> > > [  194.259358]  unmap_single_vma+0x7d/0xc0
> > > [  194.259360]  zap_page_range_single_batched+0xe0/0x1c0
> > > [  194.259363]  madvise_vma_behavior+0xb01/0xc00
> > > [  194.259366]  madvise_do_behavior.part.0+0x3cd/0x4a0
> > > [  194.259375]  do_madvise+0xc7/0x170
> > > [  194.259380]  __x64_sys_madvise+0x2f/0x40
> > > [  194.259382]  x64_sys_call+0x1d77/0x21b0
> > > [  194.259385]  do_syscall_64+0x56/0x640
> > > [  194.259388]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > >
> > > In __split_huge_pmd(), the .invalidate callback is made *before* the 2 Meg
> > > page is actually split by the root partition. So mshv_chunk_stride() returns "9"
> > > for the stride, and the hypervisor is called with HV_MAP_GPA_LARGE_PAGE
> > > set. My guess is that the hypervisor returns an error because it has already
> > > split the mapping. The whole point of this patch set is to avoid passing
> > > HV_MAP_GPA_LARGE_PAGE to the hypervisor when the hypervisor mapping
> > > is not a large page mapping, but this looks like a case where it still happens.
> > >
> > > My concern is solely from looking at the code and thinking about the problem,
> > > as I don't have an environment where I can test root partition interactions
> > > with the hypervisor. So maybe I'm missing something. Lemme know what you
> > > think .....
> > >
> > 
> > Yeah, I see your point: according to this stack, once a part of the page
> > is invalidated, the folio order remains the same until another invocation
> > of the same callback - this time for the whole huge
> > page - is made. Thus, the stride is still reported as the huge page size,
> > even though a part of the page has already been unmapped.
> > 
> > This indeed looks like a flaw in the current approach, but it's actually
> > not. The reason is that upon the invalidation callback, the driver
> > simply remaps the whole huge page with no access (in this case, the PFNs
> > provided to the hypervisor are zero), and it's fine as the hypervisor
> > simply drops all the pages from the previous mapping and marks this page
> > as inaccessible. The only check the hypervisor makes in this case is
> > that both the GFN and mapping size are huge page aligned (which they are
> > in this case).
> > 
> > I hope this clarifies the situation. Please let me know if you have any
> > other questions.
> 
> Thanks. Yes, this clarifies. My guess about the hypervisor behavior was wrong.
> Based on what you've said about what the hypervisor does, and further studying
> MSHV code, here's my recap of the HV_MAP_GPA_LARGE_PAGE flag:
> 
> 1. The hypervisor uses the flag to determine the granularity (4K or 2M) of the
> mapping HVCALL_MAP_GPA_PAGES or HVCALL_UNMAP_GPA_PAGES will
> create/remove. As such, the hypercall "repcount" is in this granularity. GFNs,
> such as the target_gpa_base input parameter and GFNs in the pfn_array, are
> always 4K GFNs, but if the flag is set, a GFN is treated as the first 4K GFN in
> a contiguous 2M range. If the flag is set, the target_gpa_base GFN must be
> 2M aligned.
> 
> 2. The hypervisor doesn't care whether any existing mapping is 4K or 2M. It
> always removes an existing mapping, including splitting any 2M mappings if
> necessary. Then if the operation is to create/re-create a mapping, it creates
> an appropriate new mapping.
> 
> My error was in thinking that the flag had to match any existing mapping.
> But the behavior you've clarified is certainly better. It handles the vagaries
> of the Linux "mm" subsystem, which in one case in my original experiment
> (madvise) invalidates the small range, then the 2M range, but the other
> case (mprotect) invalidates the 2M range, then the small range.
> 
> Since there's no documentation for these root partition hypercalls, it sure
> would be nice if this info could be captured in code comments for some
> future developer to benefit from. If that's not something you want to
> worry about, I could submit a patch later to add the code comments
> (subject to your review, of course).
> 

Please, feel free ti add the comments you see fit. I think you'll do it
better as you have a better understanding of what needs to be
documented.

Thanks,
Stanislav

> Separately, in looking at this, I spotted another potential problem with
> 2 Meg mappings that somewhat depends on hypervisor behavior that I'm
> not clear on. To create a new region, the user space VMM issues the
> MSHV_GET_GUEST_MEMORY ioctl, specifying the userspace address, the
> size, and the guest PFN. The only requirement on these values is that the
> userspace address and size be page aligned. But suppose a 4 Meg region is
> specified where the userspace address and the guest PFN have different
> offsets modulo 2 Meg. The userspace address range gets populated first,
> and may contain a 2 Meg large page. Then when mshv_chunk_stride()
> detects a 2 Meg aligned guest PFN so HVCALL_MAP_GPA_PAGES can be told
> to create a 2 Meg mapping for the guest, the corresponding system PFN in
> the page array may not be 2 Meg aligned. What does the hypervisor do in
> this case? It can't create a 2 Meg mapping, right? So does it silently fallback
> to creating 4K mappings, or does it return an error? Returning an error would
> seem to be problematic for movable pages because the error wouldn't
> occur until the guest VM is running and takes a range fault on the region.
> Silently falling back to creating 4K mappings has performance implications,
> though I guess it would work. My question is whether the
> MSHV_GET_GUEST_MEMORY ioctl should detect this case and return an
> error immediately.
> 
> Michael
> 
> > >
> > > [1] https://lore.kernel.org/linux-hyperv/SN6PR02MB4157978DFAA6C2584D0678E1D4A1A@SN6PR02MB4157.namprd02.prod.outlook.com/

