Return-Path: <linux-hyperv+bounces-7071-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 84692BB79C2
	for <lists+linux-hyperv@lfdr.de>; Fri, 03 Oct 2025 18:52:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 61A604ED514
	for <lists+linux-hyperv@lfdr.de>; Fri,  3 Oct 2025 16:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20F8B2D3EEA;
	Fri,  3 Oct 2025 16:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="sUW4RWmm"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C5962D2485;
	Fri,  3 Oct 2025 16:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759510342; cv=none; b=aVrIVBh2TrAgmns8xduFsMnP2l9nDp2ZVz/r77q6Mk2qCfD0/m6npikskEJg4/UZibhThDzgrwrKB5405xB/3JlGkwJRkEdkqkAH4ut70S52z4xt0yqTyK5Y0h2dFGrV5DyiL2vybw7R8+nopqMOAab+1cNYqm6rg65sfEgYlXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759510342; c=relaxed/simple;
	bh=XopMqeBEhXWvFMPQFEtogrEfzYADeZLpFbReGstZ9vM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZG83ExxNzudPYpvbjQu9jexSZJ1cXgDfQnJNCEyzP8ezCVK14tB+3zriYws7kV9ujH0UdxteV5c1aZYA//I+w3pQhu2OLXlnTT7ZFoaJ1KqIqUuHQj9FGIlEOHenPZfqIyLckccUqYWLFVpfAYzGIn5AfDAzhAuOmU2nVWU+W/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=sUW4RWmm; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii.localdomain (unknown [52.148.171.5])
	by linux.microsoft.com (Postfix) with ESMTPSA id 73B94211D8C8;
	Fri,  3 Oct 2025 09:52:19 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 73B94211D8C8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1759510339;
	bh=FD7HWPe0C/v7A3S/nQyeRDNE2l3vn3CGHv8EhytZTng=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sUW4RWmmBm7LEZN5/klHAbY/rFTlyD4az9XqYLPRhydkxVvYz2ALNt0G+nCfciyzN
	 7j7YdZt+Dj0Ejf5cgj2daCxzyhiOjQZojzopWH8Wie6bMAbfDFICgjKjZJsK/Ayxbv
	 8EBQtpUeh6lDPZemKG66Ex1/Zkfk/PIW/m4CEnB4=
Date: Fri, 3 Oct 2025 09:52:17 -0700
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
Message-ID: <aN__QWQZkXN8k1-V@skinsburskii.localdomain>
References: <175942263069.128138.16103948906881178993.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <175942296162.128138.15731950243504649929.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <SN6PR02MB415777407333F3EC40CC05B7D4E4A@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <SN6PR02MB415777407333F3EC40CC05B7D4E4A@SN6PR02MB4157.namprd02.prod.outlook.com>

On Fri, Oct 03, 2025 at 12:27:13AM +0000, Michael Kelley wrote:
> From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com> Sent: Thursday, October 2, 2025 9:36 AM
> > 
> > Reduce overhead when unmapping large memory regions by batching GPA unmap
> > operations in 2MB-aligned chunks.
> > 
> > Use a dedicated constant for batch size to improve code clarity and
> > maintainability.
> > 
> > Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
> > ---
> >  drivers/hv/mshv_root.h         |    2 ++
> >  drivers/hv/mshv_root_hv_call.c |    2 +-
> >  drivers/hv/mshv_root_main.c    |   15 ++++++++++++---
> >  3 files changed, 15 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/hv/mshv_root.h b/drivers/hv/mshv_root.h
> > index e3931b0f12693..97e64d5341b6e 100644
> > --- a/drivers/hv/mshv_root.h
> > +++ b/drivers/hv/mshv_root.h
> > @@ -32,6 +32,8 @@ static_assert(HV_HYP_PAGE_SIZE == MSHV_HV_PAGE_SIZE);
> > 
> >  #define MSHV_PIN_PAGES_BATCH_SIZE	(0x10000000ULL / HV_HYP_PAGE_SIZE)
> > 
> > +#define MSHV_MAX_UNMAP_GPA_PAGES	512
> > +
> >  struct mshv_vp {
> >  	u32 vp_index;
> >  	struct mshv_partition *vp_partition;
> > diff --git a/drivers/hv/mshv_root_hv_call.c b/drivers/hv/mshv_root_hv_call.c
> > index c9c274f29c3c6..0696024ccfe31 100644
> > --- a/drivers/hv/mshv_root_hv_call.c
> > +++ b/drivers/hv/mshv_root_hv_call.c
> > @@ -17,7 +17,7 @@
> >  /* Determined empirically */
> >  #define HV_INIT_PARTITION_DEPOSIT_PAGES 208
> >  #define HV_MAP_GPA_DEPOSIT_PAGES	256
> > -#define HV_UMAP_GPA_PAGES		512
> > +#define HV_UMAP_GPA_PAGES		MSHV_MAX_UNMAP_GPA_PAGES
> > 
> >  #define HV_PAGE_COUNT_2M_ALIGNED(pg_count) (!((pg_count) & (0x200 - 1)))
> > 
> > diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
> > index 7ef66c43e1515..8bf0b5af25802 100644
> > --- a/drivers/hv/mshv_root_main.c
> > +++ b/drivers/hv/mshv_root_main.c
> > @@ -1378,6 +1378,7 @@ mshv_map_user_memory(struct mshv_partition *partition,
> >  static void mshv_partition_destroy_region(struct mshv_mem_region *region)
> >  {
> >  	struct mshv_partition *partition = region->partition;
> > +	u64 page_offset;
> >  	u32 unmap_flags = 0;
> >  	int ret;
> > 
> > @@ -1396,9 +1397,17 @@ static void mshv_partition_destroy_region(struct mshv_mem_region *region)
> >  	if (region->flags.large_pages)
> >  		unmap_flags |= HV_UNMAP_GPA_LARGE_PAGE;
> > 
> > -	/* ignore unmap failures and continue as process may be exiting */
> > -	hv_call_unmap_gpa_pages(partition->pt_id, region->start_gfn,
> > -				region->nr_pages, unmap_flags);
> > +	for (page_offset = 0; page_offset < region->nr_pages; page_offset++) {
> > +		if (!region->pages[page_offset])
> > +			continue;
> > +
> > +		hv_call_unmap_gpa_pages(partition->pt_id,
> > +					ALIGN(region->start_gfn + page_offset,
> > +					      MSHV_MAX_UNMAP_GPA_PAGES),
> 
> Seems like this should be ALIGN_DOWN() instead of ALIGN().  ALIGN() rounds
> up to get the requested alignment, which could skip over some non-zero
> entries in region->pages[].
> 

Indeed, the goal is to unmap in 2MB chunks as it's the max payload that
can be passed to hypervisor.
I'll replace it with ALIGN_DOWN in the next revision.

> And I'm assuming the unmap hypercall is idempotent in that if the specified
> partition PFN range includes some pages that aren't mapped, the hypercall
> just skips them and keeps going without returning an error.
> 

It might be the case, but it's not reliable.
If the region size isn’t aligned to MSHV_MAX_UNMAP_GPA_PAGES (i.e., not
aligned to 2M), the hypervisor can return an error for the trailing
invalid (non-zero) PFNs.
I’ll fix this in the next revision.

> > +					MSHV_MAX_UNMAP_GPA_PAGES, unmap_flags);
> > +
> > +		page_offset += MSHV_MAX_UNMAP_GPA_PAGES - 1;
> 
> This update to the page_offset doesn't take into account the effect of the
> ALIGN (or ALIGN_DOWN) call.  With a change to ALIGN_DOWN(), it may
> increment too far and perhaps cause the "for" loop to be exited prematurely,
> which would fail to unmap some of the pages.
> 

I’m not sure I see the problem here.  If we align the offset by
MSHV_MAX_UNMAP_GPA_PAGES and unmap the same number of pages, then we
should increment the offset by that very same number, shouldn’t we?

Thanks,
Stanislav

> > +	}
> > 
> >  	mshv_region_invalidate(region);
> > 
> > 
> > 
> 

