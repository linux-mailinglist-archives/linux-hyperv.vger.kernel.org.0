Return-Path: <linux-hyperv+bounces-7105-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16D75BBE6C4
	for <lists+linux-hyperv@lfdr.de>; Mon, 06 Oct 2025 17:00:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F2131899B8E
	for <lists+linux-hyperv@lfdr.de>; Mon,  6 Oct 2025 15:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B50472D6E74;
	Mon,  6 Oct 2025 15:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="OrXovkpA"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FC522D6E59;
	Mon,  6 Oct 2025 15:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759762818; cv=none; b=DWuZa+EDNsT2UL5CBVca4nVAnhmEE5+vDu5wwXcWZD2RDmuVaBp5JRCYKxCwEjW12P6iWAAa2DLs/fHim7lEq1OF+j7BTMZSGLg04o6NenfchsKQhJHzPkyYEuHM2nWrWhRXCenEOV7Tc+wLDADLjhh8jS8BRn8O8FMLSnKWPSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759762818; c=relaxed/simple;
	bh=YrvVDm4++2peY3eEOwdvTaSPdF9i9+OfuFb0/EZ3rKI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eTqUeV/7hmg3f0ezOMT2TyVWM2ay2IQKFBfO2h0I28Q9oBfcJ1ugCU+Ff2ZT5p8HPaBMevyGkp8wDhG6mL+ZSc6r3M7kLcBZO0EWtHfKWVV+dOGk5mz4q2t4lWUI1NdlhjJxe75agRzFIuR1ZOtTM5L0+27PRwUhN2YGZX5kAf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=OrXovkpA; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii.localdomain (unknown [20.236.10.120])
	by linux.microsoft.com (Postfix) with ESMTPSA id 3C71E211AF2F;
	Mon,  6 Oct 2025 08:00:16 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3C71E211AF2F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1759762816;
	bh=9PRAZqGEqsnKOBhJBvCf0MSlmktvmXX9+od7bbBWL5w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OrXovkpAfmKTFp8whd5dmrdQMgEde/DvBeo69JpwpJXWumEHohVEJ21R70Y6qRhrE
	 qbTEJZ0Sp8/AIUrOsmvdF0xB364qhQfO3Ju6owPvyDWm8TQsbG2xZizRJ+/Q5HQ4bv
	 UKF5VTfCPaFtSMl63XT9TsfdOiOg1xRxJ14Jhd74=
Date: Mon, 6 Oct 2025 08:00:13 -0700
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: Michael Kelley <mhklinux@outlook.com>
Cc: "kys@microsoft.com" <kys@microsoft.com>,
	"haiyangz@microsoft.com" <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 3/5] Drivers: hv: Batch GPA unmap operations to
 improve large region performance
Message-ID: <aOPZfZV6uLOePaZo@skinsburskii.localdomain>
References: <175942263069.128138.16103948906881178993.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <175942296162.128138.15731950243504649929.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <SN6PR02MB415777407333F3EC40CC05B7D4E4A@SN6PR02MB4157.namprd02.prod.outlook.com>
 <aN__QWQZkXN8k1-V@skinsburskii.localdomain>
 <SN6PR02MB415777A957EF622587C54A35D4E4A@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <SN6PR02MB415777A957EF622587C54A35D4E4A@SN6PR02MB4157.namprd02.prod.outlook.com>

On Fri, Oct 03, 2025 at 09:41:32PM +0000, Michael Kelley wrote:
> From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com> Sent: Friday, October 3, 2025 9:52 AM
> 
> > 
> > On Fri, Oct 03, 2025 at 12:27:13AM +0000, Michael Kelley wrote:
> > > From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com> Sent: Thursday, October 2, 2025 9:36 AM
> > > >
> > > > Reduce overhead when unmapping large memory regions by batching GPA unmap
> > > > operations in 2MB-aligned chunks.
> > > >
> > > > Use a dedicated constant for batch size to improve code clarity and
> > > > maintainability.
> > > >
> > > > Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>

<snip>

> > > > +					MSHV_MAX_UNMAP_GPA_PAGES, unmap_flags);
> > > > +
> > > > +		page_offset += MSHV_MAX_UNMAP_GPA_PAGES - 1;
> > >
> > > This update to the page_offset doesn't take into account the effect of the
> > > ALIGN (or ALIGN_DOWN) call.  With a change to ALIGN_DOWN(), it may
> > > increment too far and perhaps cause the "for" loop to be exited prematurely,
> > > which would fail to unmap some of the pages.
> > >
> > 
> > I’m not sure I see the problem here.  If we align the offset by
> > MSHV_MAX_UNMAP_GPA_PAGES and unmap the same number of pages, then we
> > should increment the offset by that very same number, shouldn’t we?
> 
> Here's an example showing the problem I see (assuming ALIGN_DOWN
> instead of ALIGN):
> 
> 1) For simplicity in the example, assume region->start_gfn is zero.
> 2) Entries 0 thru 3 (i.e., 4 entries) in region->pages[] are zero.
> 3) Entries 4 thru 515 (the next 512 entries) are non-zero.
> 4) Entries 516 thru 1023 (the next 508 entries) are zero.
> 5) Entries 1024 thru 1535 (the last 512 entries) are non-zero.
> 
> Upon entering the "for" loop for the first time, page_offset gets
> incremented to 4 because of skipping entries 0 thru 3 that are zero.
> On the next iteration where page_offset is 4, the hypercall is made,
> passing 0 for the gfn (because of ALIGN_DOWN), with a count of
> 512, so entries 0 thru 511 are unmapped. Entries 0 thru 3 are valid
> entries, and the fact that they aren't mapped is presumably ignored
> by the hypercall, so everything works.
> 
> Then page_offset is incremented by 511, so it will be 515. Continuing
> the "for" loop increments page_offset to 516. The zero entries 516
> thru 1023 increment page_offset to 1024. Finally the hypercall is made
> again covering entries 1024 thru 1535, none of which are zero.
> 
> But notice that entries 512 thru 515 (which are non-zero) got skipped.
> That's because the first invocation of the hypercall covered only through
> entry 511, while page_offset was incremented to 515. page_offset
> should have been set to 511, since that's the last entry processed by
> the first invocation of the hypercall.
> 
> Michael

I see the problem now. Thank you.
I'll fix it in the next revision.

Thanks,
Stanislav


