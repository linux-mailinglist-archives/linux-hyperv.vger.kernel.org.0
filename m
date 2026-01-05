Return-Path: <linux-hyperv+bounces-8159-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D8278CF56D5
	for <lists+linux-hyperv@lfdr.de>; Mon, 05 Jan 2026 20:50:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0621C306088A
	for <lists+linux-hyperv@lfdr.de>; Mon,  5 Jan 2026 19:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09D962773C3;
	Mon,  5 Jan 2026 19:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="gSRDAtG+"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46EF4283FE5;
	Mon,  5 Jan 2026 19:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767642438; cv=none; b=BBAItFXI5IiU4Ng9xo0uGHaEd3hMM5MVO4gXL05ix2dOxI/I5qeglVxRxFqeF28MpcFwNxHvT9ERQYRg18B6CTy6x3X8ufyKGiCHCGSmeRooPil2suFe0S/evjgPSxq8pw4AUmbv+2ATz1F7ZEm3a5inVy7aL1B+0zJ1EEGQl4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767642438; c=relaxed/simple;
	bh=On+SsU7gIwuAwhvZNQieLvj6wARmH/3XaBltqMe+h+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EKr2g94nbI+jiHOkJIp4/TcipYpp3tbDqJJ+sBMjPU/wovsxgQJPKYlAtYXM3/KxD+SEteoqzmBXSSWShBvXPYsqMKLaVCXe6xO1rM+bApVeC0S9HNQ+ZhSkmjJu9p3ZTHj/prp0ctQ34c98GLd6FO55Ju4x5uukDhV7Y7G58q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=gSRDAtG+; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii.localdomain (unknown [20.236.10.206])
	by linux.microsoft.com (Postfix) with ESMTPSA id 1CA6321260DF;
	Mon,  5 Jan 2026 11:47:16 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1CA6321260DF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1767642436;
	bh=pgzJ/NsvJbe0sYU2ZGY9vzL+epEIX2UHWAoJiswmR40=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gSRDAtG+wG/A0+pzxcBhu5GWFhucLm56j0yM9cskErRcJwGH1hLgIRgOhcSYp5rHS
	 AzG6LYXGTVa8Xu9ktbCqhp8kHmrjogbaShLYNtJi+WdGq3UY764PQB5D55pcqkDEjz
	 Vwb7EpF6zGC68ECOypDFA1qBkCmGWc9TtS1gAj4Y=
Date: Mon, 5 Jan 2026 11:47:14 -0800
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
Message-ID: <aVwVQoTWSNN9Fw3v@skinsburskii.localdomain>
References: <aUrCr5wBSTrGm-IM@skinsburskii.localdomain>
 <SN6PR02MB41573BF52C6A4447C720CDD6D4B5A@SN6PR02MB4157.namprd02.prod.outlook.com>
 <aVgDloDX9nMH6hZH@skinsburskii.localdomain>
 <SN6PR02MB4157288D26ECC9E69240CFECD4BBA@SN6PR02MB4157.namprd02.prod.outlook.com>
 <aVgkj4V60kddKk4o@skinsburskii.localdomain>
 <SN6PR02MB415724D13B2751F8FAA1053BD4BBA@SN6PR02MB4157.namprd02.prod.outlook.com>
 <aVhWMoH3GvpGAR0a@skinsburskii.localdomain>
 <SN6PR02MB415756A0783B634297F51320D4B8A@SN6PR02MB4157.namprd02.prod.outlook.com>
 <aVv0ALacPukXIHTw@skinsburskii.localdomain>
 <SN6PR02MB4157C177954C42B9C026DB27D486A@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <SN6PR02MB4157C177954C42B9C026DB27D486A@SN6PR02MB4157.namprd02.prod.outlook.com>

On Mon, Jan 05, 2026 at 06:07:00PM +0000, Michael Kelley wrote:
> From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com> Sent: Monday, January 5, 2026 9:25 AM
> > 
> > On Sat, Jan 03, 2026 at 01:16:51AM +0000, Michael Kelley wrote:
> > > From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com> Sent: Friday, January 2, 2026 3:35 PM
> > > >
> > > > On Fri, Jan 02, 2026 at 09:13:31PM +0000, Michael Kelley wrote:
> > > > > From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com> Sent: Friday, January 2, 2026 12:03 PM
> > > > > >
> 
> [snip]
> 
> > > > > >
> > > > > > I think see your point, but I also think this issue doesn't exist,
> > > > > > because map_chunk_stride() returns huge page stride iff page if:
> > > > > > 1. the folio order is PMD_ORDER and
> > > > > > 2. GFN is huge page aligned and
> > > > > > 3. number of 4K pages is huge pages aligned.
> > > > > >
> > > > > > On other words, a host huge page won't be mapped as huge if the page
> > > > > > can't be mapped as huge in the guest.
> > > > >
> > > > > OK, I'm missing how what you say is true. For pinned regions,
> > > > > the memory is allocated and mapped into the host userspace address
> > > > > first, as done by mshv_prepare_pinned_region() calling mshv_region_pin(),
> > > > > which calls pin_user_pages_fast(). This is all done without considering
> > > > > the GFN or GFN alignment. So one or more 2M pages might be allocated
> > > > > and mapped in the host before any guest mapping is looked at. Agreed?
> > > > >
> > > >
> > > > Agreed.
> > > >
> > > > > Then mshv_prepare_pinned_region() calls mshv_region_map() to do the
> > > > > guest mapping. This eventually gets down to mshv_chunk_stride(). In
> > > > > mshv_chunk_stride() when your conditions #2 and #3 are met, the
> > > > > corresponding struct page argument to mshv_chunk_stride() may be a
> > > > > 4K page that is in the middle of a 2M page instead of at the beginning
> > > > > (if the region is mis-aligned). But the key point is that the 4K page in
> > > > > the middle is part of a folio that will return a folio order of PMD_ORDER.
> > > > > I.e., a folio order of PMD_ORDER is not sufficient to ensure that the
> > > > > struct page arg is at the *start* of a 2M-aligned physical memory range
> > > > > that can be mapped into the guest as a 2M page.
> > > > >
> > > >
> > > > I'm trying to undestand how this can even happen, so please bear with
> > > > me.
> > > > In other words (and AFAIU), what you are saying in the following:
> > > >
> > > > 1. VMM creates a mapping with a huge page(s) (this implies that virtual
> > > >    address is huge page aligned, size is huge page aligned and physical
> > > >    pages are consequtive).
> > > > 2. VMM tries to create a region via ioctl, but instead of passing the
> > > >    start of the region, is passes an offset into one of the the region's
> > > >    huge pages, and in the same time with the base GFN and the size huge
> > > >    page aligned (to meet the #2 and #3 conditions).
> > > > 3. mshv_chunk_stride() sees a folio order of PMD_ORDER, and tries to map
> > > >    the corresponding pages as huge, which will be rejected by the
> > > >    hypervisor.
> > > >
> > > > Is this accurate?
> > >
> > > Yes, pretty much. In Step 1, the VMM may just allocate some virtual
> > > address space, and not do anything to populate it with physical pages.
> > > So populating with any 2M pages may not happen until Step 2 when
> > > the ioctl calls pin_user_pages_fast(). But *when* the virtual address
> > > space gets populated with physical pages doesn't really matter. We
> > > just know that it happens before the ioctl tries to map the memory
> > > into the guest -- i.e., mshv_prepare_pinned_region() calls
> > > mshv_region_map().
> > >
> > > And yes, the problem is what you call out in Step 2: as input to the
> > > ioctl, the fields "userspace_addr" and "guest_pfn" in struct
> > > mshv_user_mem_region could have different alignments modulo 2M
> > > boundaries. When they are different, that's what I'm calling a "mis-aligned
> > > region", (referring to a struct mshv_mem_region that is created and
> > > setup by the ioctl).
> > >
> > > > A subseqeunt question: if it is accurate, why the driver needs to
> > > > support this case? It looks like a VMM bug to me.
> > >
> > > I don't know if the driver needs to support this case. That's a question
> > > for the VMM people to answer. I wouldn't necessarily assume that the
> > > VMM always allocates virtual address space with exactly the size and
> > > alignment that matches the regions it creates with the ioctl. The
> > > kernel ioctl doesn't care how the VMM allocates and manages its
> > > virtual address space, so the VMM is free to do whatever it wants
> > > in that regard, as long as it meets the requirements of the ioctl. So
> > > the requirements of the ioctl in this case are something to be
> > > negotiated with the VMM.
> > >
> > > > Also, how should it support it? By rejecting such requests in the ioctl?
> > >
> > > Rejecting requests to create a mis-aligned region is certainly one option
> > > if the VMM agrees that's OK. The ioctl currently requires only that
> > > "userspace_addr" and "size" be page aligned, so those requirements
> > > could be tightened.
> > >
> > > The other approach is to fix mshv_chunk_stride() to handle the
> > > mis-aligned case. Doing so it even easier than I first envisioned.
> > > I think this works:
> > >
> > > @@ -49,7 +49,8 @@ static int mshv_chunk_stride(struct page *page,
> > >          */
> > >         if (page_order &&
> > >             IS_ALIGNED(gfn, PTRS_PER_PMD) &&
> > > -           IS_ALIGNED(page_count, PTRS_PER_PMD))
> > > +           IS_ALIGNED(page_count, PTRS_PER_PMD) &&
> > > +           IS_ALIGNED(page_to_pfn(page), PTRS_PER_PMD))
> > >                 return 1 << page_order;
> > >
> > >         return 1;
> > >
> > > But as we discussed earlier, this fix means never getting 2M mappings
> > > in the guest for a region that is mis-aligned.
> > >
> > 
> > Although I understand the logic behind this fix, I’m hesitant to add it
> > because it looks like a workaround for a VMM bug that could bite back.
> > The approach you propose will silently map a huge page as a collection
> > of 4K pages, impacting guest performance (this will be especially
> > visible for a region containing a single huge page).
> > 
> > This fix silently allows such behavior instead of reporting it as an
> > error to user space. It’s worth noting that pinned-region population and
> > mapping happen upon ioctl invocation, so the VMM will either get an
> > error from the hypervisor (current behavior) or get a region mapped with
> > 4K pages (proposed behavior).
> > 
> > The first case is an explicit error; the second — although it allows
> > adding a region — will be less performant, significantly increase region
> > mapping time and thus potentailly guest spin-up (creation) time, and be
> > less noticeable to customers, especially those who don’t really
> > understand what’s happening under the hood and simply stumbled upon some
> > VMM bug.
> > 
> > What’s your take?
> > 
> 
> Yes, I agree with everything you say. Silently dropping into a mode where
> guest performance might be noticeably affected is usually not a good
> thing. So if the VMM code is OK with the restriction, then I'm fine with
> adding an explicit alignment check in the ioctl path code to disallow the
> mis-aligned case.
> 

But the explicit alignment check in the ioctl is already there. The only
difference is that it's done in the hypervisor and not in the kernel.

> An explicit check is needed because the code "as is" is somewhat flakey
> as I pointed out earlier. Mis-aligned pinned regions will succeed if the
> host doesn't allocate any 2M pages, but will fail it is does. And mis-aligned
> movable regions silently go into the mode of doing all 4K mappings. An
> explicit check in the ioctl path avoids the flakiness and makes pinned
> and movable regions have consistent requirements.
> 
> On the flip side: The ioctl that creates a region is only used by the VMM,
> not by random end-user provided code like the system call API or general
> ioctls. As such, I could see the VMM wanting mis-aligned regions to work,
> with the understanding that there is potential perf impact. The VMM is
> sophisticated system software, and it may want to take the responsibility
> for making that tradeoff rather than have the kernel enforce a requirement.
> There may be cases where it makes sense to create small regions that are
> mis-aligned. I just don't know what the VMM needs or wants to do in
> creating regions.
> 

That's a fair point. Let me loop back with the VMM folks and see what
they think.

Thanks,
Stanislav

> So it's hard for me to lean either way.  I think the question must go
> to the VMM folks.
> 
> Michael
> 
> 
> 
> 
> 
> 
> 
> 

