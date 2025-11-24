Return-Path: <linux-hyperv+bounces-7811-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C627C8288B
	for <lists+linux-hyperv@lfdr.de>; Mon, 24 Nov 2025 22:28:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 425893ABCA0
	for <lists+linux-hyperv@lfdr.de>; Mon, 24 Nov 2025 21:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D18332E6AA;
	Mon, 24 Nov 2025 21:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="LGPzxP2Q"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A4F932E69B;
	Mon, 24 Nov 2025 21:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764019694; cv=none; b=a2bCDxA2diz3O4vVXpb7h05hTEloXYrvMr49XaVw591apjqjWkho+F6/WZ65wm0K83OvCB6XBZIrcRR/rDLSLuKH8iGvUfCPAWa2q31NSXqe6GMXY2ZX9u6gIEdvuTdzcPQwc+0E9o+0qBIqFUT8p5jqThEbqd1AjbJjP4rU/3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764019694; c=relaxed/simple;
	bh=TZIxW9GD+DAEWFPpGRTcM/XmuC7sgZFfDKj7jfI72HE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JvNy9u6ctvUGT8MGlnk7Z0iszcgMvTNOZT3oqrlSqbH3XqVq5h/ySFHSsx0Gsh8V55ZOrQQ0hJOPzNnOIiK23wwAxgg7oO9Ny9axvbOBlfskjORezYmk3W7+CtlIMugxBF/cxvDRG7QW0zMqpQvahIfn9wrXR9qaXUud9kR8ymA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=LGPzxP2Q; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii.localdomain (unknown [20.236.10.206])
	by linux.microsoft.com (Postfix) with ESMTPSA id 5DD972120382;
	Mon, 24 Nov 2025 13:28:04 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5DD972120382
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1764019684;
	bh=3QNiKRsDcXEBiKDwSBm23e0S49+64xhogRDpiY7/9tQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LGPzxP2QzoJtAx8+/4+u76sbgkHjc1F0bYHsybstW27VSTHRV4DhMJaqkiXuerBST
	 +mto+Xj4SjcOgfSEgaNvReEcqjSATW8YpnrFjnMrERTgU6YjAOJaCFIFDNy0XWFMaD
	 Ohnwk2MRI/i+3vb4nOrUnd7M6xqQ5JfWCzFaK9NY=
Date: Mon, 24 Nov 2025 13:28:02 -0800
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
Message-ID: <aSTN4nlRiXOXmKlA@skinsburskii.localdomain>
References: <176339789196.27330.10517676002564595057.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <176339837995.27330.14240947043073674139.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <SN6PR02MB4157DB4154734C44B5D85A88D4D6A@SN6PR02MB4157.namprd02.prod.outlook.com>
 <aR5kjh-d6UAqy88t@skinsburskii.localdomain>
 <SN6PR02MB415740A80DA4FF9661040147D4D5A@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR02MB415740A80DA4FF9661040147D4D5A@SN6PR02MB4157.namprd02.prod.outlook.com>

On Fri, Nov 21, 2025 at 05:45:20AM +0000, Michael Kelley wrote:
> From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com> Sent: Wednesday, November 19, 2025 4:45 PM
> > 
> > On Tue, Nov 18, 2025 at 04:29:56PM +0000, Michael Kelley wrote:
> > > From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com> Sent: Monday, November 17, 2025 8:53 AM
> 
> [snip]
> 
> > > > diff --git a/drivers/hv/Kconfig b/drivers/hv/Kconfig
> > > > index 0b8c391a0342..5f1637cbb6e3 100644
> > > > --- a/drivers/hv/Kconfig
> > > > +++ b/drivers/hv/Kconfig
> > > > @@ -75,6 +75,7 @@ config MSHV_ROOT
> > > >  	depends on PAGE_SIZE_4KB
> > > >  	select EVENTFD
> > > >  	select VIRT_XFER_TO_GUEST_WORK
> > > > +	select HMM_MIRROR
> > >
> > > Couldn't you also do "select MMU_NOTIFIER" to avoid the #ifdef's
> > > and stubs for when it isn't selected? There are other Linux kernel
> > > drivers that select it. Or is the intent to allow building an image that
> > > doesn't support unpinned memory, and the #ifdef's save space?
> > >
> > 
> > That's an interesting question. This driver can function without MMU notifiers
> > by pinning all memory, which might be advantageous for certain real-time
> > applications.
> > However, since most other virtualization solutions use MMU_NOTIFIER, there
> > doesn't appear to be a strong reason for this driver to deviate.
> 
> I'm not clear on your last sentence. Could you elaborate?
> 

I meant I'll select MMU_NOTIFIER.

> 
> Right. But even for pinned regions as coded today, is that assumption
> correct? Due to memory being fragmented at the time of region creation,
> it would be possible that some 2Meg ranges in a region are backed by a large
> page, while other 2Meg ranges are not. In that case, a single per-region flag
> isn't enough information. Or does the hypercall work OK if the "map huge
> page" flag is passed when the range isn't a huge page? I'm not clear on what
> the hypercall requires as input.
> 

It is not with THP enabled and missing MAP_HUGETLB mmap flag.
I'll fix it in the next revision.

> 
> OK.  So what is the impact? Losing the perf benefit of mapping guest
> memory in the SLAT as a 2 Meg large page vs. a bunch of individual 4K
> pages? Anything else?
> 

I decided to rework it in scope of these the series.

> > 
> > This is possible, if hypervisor returns some invalid GFN.
> > But there is also a possibility, that this code can race with region removal from a guest.
> > I'll address it in the next revision.
> 
> In either of these cases, what happens next? The MSHV_RUN_VP ioctl
> will return to user space with the unhandled HVMSG_GPA_INTERCEPT
> message. Is there anything user space can do to enable the VP to make
> progress past the fault? Or does user space just have to terminate the
> guest VM?
> 

I don't think there is much to be done here in kernel.
Control will be returned to VMM, which will likely kill the guest.

> > >
> > > I'm pretty sure region->start_uaddr is always page aligned. But what
> > > about range->start and range->end?  The code here and below assumes
> > > they are page aligned. It also assumes that range->end is greater than
> > > range->start so the computation of page_count doesn't wrap and so
> > > page_count is >= 1. I don't know whether checks for these assumptions
> > > are appropriate.
> > >
> > 
> > There is a check for memory region size to be non-zero and page aligned
> > in mshv_partition_ioct_set_memory function, which is the only caller for
> > memory region creation. And region start is defined in PFNs.
> > 
> 
> Right -- no disagreement that the region start and size are page aligned
> and non-zero. But what about the range that is being invalidated?
> (i.e., range->start and range->end) The values in that range are coming
> from the mm subsystem, and aren't governed by how a region is created.
> If that range is a subset of the MSHV region, then
> mshv_region_internal_invalidate() will be operating on whatever subset
> was provided in the 'range' argument.
> 
> mshv_region_interval_invalidate() is ultimately called from
> mmu_notifier_invalidate_range_start(), which has about 30 different
> callers in the kernel, mostly in the mm subsystem. It wasn't
> clear to me what rules, if any, those 30 callers are following when they
> set up the range to be invalidated. 
> 
> Michael

I see what you mean. Yes, these values are guarantee to be page aligned.
And it must be as anything else can't be invalidated.

Thanks,
Stanislav



