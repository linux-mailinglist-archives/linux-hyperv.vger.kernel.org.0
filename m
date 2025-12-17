Return-Path: <linux-hyperv+bounces-8045-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C5A60CC5A51
	for <lists+linux-hyperv@lfdr.de>; Wed, 17 Dec 2025 01:54:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C365E3008549
	for <lists+linux-hyperv@lfdr.de>; Wed, 17 Dec 2025 00:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A6511E3DDE;
	Wed, 17 Dec 2025 00:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="oKZya3s5"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18C8E1D5CF2;
	Wed, 17 Dec 2025 00:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765932878; cv=none; b=Eq7MLi3eTh9H3jU/kKdQpi1Dqpc3iTxGYuZIg/Ihp9XuNY+McA+8nslYpE3PAc4kKMfztp9GsA6ueK231BnvkaI2nvhN7JWYox17Kpnrlm9S0rQXhDDXpIDmzCCq3pOjuKy8CST1wlaimqhP7YSPdiugsx068YccuwfR9OfVCkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765932878; c=relaxed/simple;
	bh=B6jqiFHJGo73OSQDGSjkIuN0dis9sT79ULbkG+pHCwg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pNdszkY8l7nzGHF3AYGFJnJ8nSMo069zsTTsohoEMPIAtJkDwE1lyArsB+wZOt+inxT9NLjGcpiTYf5uidIQooHvDuSZ3TAETIUJYOcrvQ44XgBmZLhXi6QZhtj5sOwkYM5CE0jg8M0WX9tVtC8Se0sQKDUHC7i3O0CSE/DTgiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=oKZya3s5; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii.localdomain (unknown [20.236.10.120])
	by linux.microsoft.com (Postfix) with ESMTPSA id F2BBD200D625;
	Tue, 16 Dec 2025 16:54:35 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com F2BBD200D625
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1765932876;
	bh=57oUEXqIupiGf8NLoDCpehApbaxQOY8q0ozd+Cpxqsk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oKZya3s5X7Rvz2kjb98h2guXGx4kjnIXSgvwSBffzgZaeRZWE9cLGO8zV/Y98NBaB
	 pexPuFKzKLlJYj7vDKciSmvHYb6bMLvYatslyGuDjuG7RLMiX93+2NOTMsi89KuGsO
	 7inv3/hU9/4TsOWM24C1tIrUJ35l94xmvnxRN2WY=
Date: Tue, 16 Dec 2025 16:54:34 -0800
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
Message-ID: <aUH_Sh6Mvta7AH2Q@skinsburskii.localdomain>
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

<snip>


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
> Michael
> 

The issue is addressed by "mshv: Align huge page stride with guest
mapping" patch.

Thanks a lot once again for your help in identifying it,
Stanislav

