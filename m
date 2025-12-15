Return-Path: <linux-hyperv+bounces-8023-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F892CBFB61
	for <lists+linux-hyperv@lfdr.de>; Mon, 15 Dec 2025 21:17:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 939D93003F71
	for <lists+linux-hyperv@lfdr.de>; Mon, 15 Dec 2025 20:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 807C230C35F;
	Mon, 15 Dec 2025 20:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="qlQ7YAWL"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FDD91DF75B;
	Mon, 15 Dec 2025 20:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765829580; cv=none; b=V2YBIWQix6FUJAaQj+OnzQDI7xrBnY3ha9aUvMGYH5BkkcAA3J2M9WQ+PpXaIVy/602s7mYCGp0pWvEWD/Rq7isnEveUXutL2DBy+CiDq0JAoRxBBf28fyj3PXTdLQN/spAeLw1jHOQWbTD1k1qXiZA97zztnvSzICQD8BkFy3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765829580; c=relaxed/simple;
	bh=Zq0hcMcIbQhk7TjBpKZbwHh9Jln6DkDO5vGTDLqCHZw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jjVCTHcyU3BTClLfN7/sXLCbwNQgyGPz+NIUUTSk9O5R8aohBMRGXfU8PjkZRHKFwSV2OgfsF384lapMm+8vrdOjQSMH6akOYlykcGw2X3q1VqxuVGjoJ203qiyxp5P9aY4H1kgd56N3dZtH7ovURVO/IimMVwUvQeXJ3VOSidQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=qlQ7YAWL; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii.localdomain (c-98-225-44-166.hsd1.wa.comcast.net [98.225.44.166])
	by linux.microsoft.com (Postfix) with ESMTPSA id 74659200D626;
	Mon, 15 Dec 2025 12:12:50 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 74659200D626
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1765829570;
	bh=AupiNJ3Q5CoZkiRyC/MSrJvKCwKKhgSZhbO0uiaxMvY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qlQ7YAWLXvegEztJr0IGAVB6ycgPhXHvJ96z2CY+MSezAWHF2A1T7o1dk1BG77KG0
	 sIFr1yUoLxRMhcauGKiCJO/OKbs4Vclfm8wZYnex8xbd41WCDOvnnRA3/IdiNn2YGc
	 6E7jgfSFNwz8ir2o4d7VnYPsKpNIZHGu+W3xLjEk=
Date: Mon, 15 Dec 2025 12:12:48 -0800
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: Michael Kelley <mhklinux@outlook.com>
Cc: "kys@microsoft.com" <kys@microsoft.com>,
	"haiyangz@microsoft.com" <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 4/7] Drivers: hv: Fix huge page handling in memory
 region traversal
Message-ID: <aUBrwAWqGEgV9GxK@skinsburskii.localdomain>
References: <176412196000.447063.4256335030026363827.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <176412295155.447063.16512843211428609586.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <SN6PR02MB4157F10A84C4BE170AB040F4D4A6A@SN6PR02MB4157.namprd02.prod.outlook.com>
 <aTH4T-FKcL1knHaD@skinsburskii.localdomain>
 <SN6PR02MB4157978DFAA6C2584D0678E1D4A1A@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR02MB4157978DFAA6C2584D0678E1D4A1A@SN6PR02MB4157.namprd02.prod.outlook.com>

On Thu, Dec 11, 2025 at 05:37:26PM +0000, Michael Kelley wrote:
> From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com> Sent: Thursday, December 4, 2025 1:09 PM
> > 
> > On Thu, Dec 04, 2025 at 04:03:26PM +0000, Michael Kelley wrote:
> > > From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com> Sent: Tuesday, November 25, 2025 6:09 PM
> > > >
> 
> [snip]
> 

<snip>

> > > > +
> > > > +	stride = 1 << page_order;
> > > > +
> > > > +	/* Start at stride since the first page is validated */
> > > > +	for (count = stride; count < page_count; count += stride) {
> > >
> > > This striding doesn't work properly in the general case. Suppose the
> > > page_offset value puts the start of the chunk in the middle of a 2 Meg
> > > page, and that 2 Meg page is then followed by a bunch of single pages.
> > > (Presumably the mmu notifier "invalidate" callback could do this.)
> > > The use of the full stride here jumps over the remaining portion of the
> > > 2 Meg page plus some number of the single pages, which isn't what you
> > > want. For the striding to work, it must figure out how much remains in the
> > > initial large page, and then once the striding is aligned to the large page
> > > boundaries, the full stride length works.
> > >
> > > Also, what do the hypercalls in the handler functions do if a chunk starts
> > > in the middle of a 2 Meg page? It looks like the handler functions will set
> > > the *_LARGE_PAGE flag to the hypercall but then the hv_call_* function
> > > will fail if the page_count isn't 2 Meg aligned.
> > >
> > 
> > This situation you described is not possible, because invalidation
> > callback simply can't invalidate a part of the huge page even in THP
> > case (leave aside hugetlb case) without splitting it beforehand, and
> > splitting a huge page requires invalidation of the whole huge page
> > first.
> 
> I've been playing around with mmu notifiers and 2 Meg pages. At least in my
> experiment, there's a case where the .invalidate callback is invoked on a
> range *before* the 2 Meg page is split. The kernel code that does this is
> in zap_page_range_single_batched(). Early on this function calls
> mmu_notifier_invalidate_range_start(), which invokes the .invalidate
> callback on the initial range. Later on, unmap_single_vma() is called, which
> does the split and eventually makes a second .invalidate callback for the
> entire 2 Meg page.
> 
> Details:  My experiment is a user space program that does the following:
> 
> 1. Allocates 16 Megs of memory on a 16 Meg boundary using
> posix_memalign(). So this is private anonymous memory. Transparent
> huge pages are enabled.
> 
> 2. Writes to a byte in each 4K page so they are all populated. 
> /proc/meminfo shows eight 2 Meg pages have been allocated.
> 
> 3. Creates an mmu notifier for the allocated 16 Megs, using an ioctl
> hacked into the kernel for experimentation purposes.
> 
> 4. Uses madvise() with the DONTNEED option to free 32 Kbytes on a 4K
> page boundary somewhere in the 16 Meg allocation. This results in an mmu
> notifier invalidate callback for that 32 Kbytes. Then there's a second invalidate
> callback covering the entire 2 Meg page that contains the 32 Kbyte range.
> Kernel stack traces for the two invalidate callbacks show them originating
> in zap_page_range_single_batched().
> 
> 5. Sleeps for 60 seconds. During that time, khugepaged wakes up and does
> hpage_collapse_scan_pmd() -> collapse_huge_page(), which generates a third
> .invalidate callback for the 2 Meg page. I'm haven't investigated what this is
> all about.
> 
> 6. Interestingly, if Step 4 above does a slightly different operation using
> mprotect() with PROT_READ instead of madvise(), the 2 Meg page is split first.
> The .invalidate callback for the full 2 Meg happens before the .invalidate
> callback for the specified range.
> 
> The root partition probably isn't doing madvise() with DONTNEED for memory
> allocated for guests. But regardless of what user space does or doesn't do, MSHV's
> invalidate callback path should be made safe for this case. Maybe that's just
> detecting it and returning an error (and maybe a WARN_ON) if user space
> doesn't need it to work.
> 

This is a deep research, Michael. Thanks a lot for you effort.
I'll think more about it and will likely follow up.

Thank you,
Stanislav

> Michael
> 

