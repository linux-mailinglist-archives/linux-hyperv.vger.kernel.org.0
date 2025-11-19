Return-Path: <linux-hyperv+bounces-7704-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DE29DC70801
	for <lists+linux-hyperv@lfdr.de>; Wed, 19 Nov 2025 18:43:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 928FF242CB
	for <lists+linux-hyperv@lfdr.de>; Wed, 19 Nov 2025 17:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA20F30FC3A;
	Wed, 19 Nov 2025 17:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Dr9FZ+3Y"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35D3B2144D7;
	Wed, 19 Nov 2025 17:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763574181; cv=none; b=cJb2G/PwrSybq+lw0j/ce5E/4gyLwkhvG320CTRmGu68MheQdlUmtGIif/DJEj79U5p6cXJll97AKUkfmKRysw85dSaXsp0zwpLBRaihyEAkdVcdJBS0ZQ7AJvPeHkDZSTnPeHmiI2AKPcQlGt7ug9C2/aRT7a0ftzTpWyh6mRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763574181; c=relaxed/simple;
	bh=2+DpSKwDzxl37QKWj3fyT+/CNIIj23Lc7LVZoHXrnbU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bLpWuxV8dFIsZ8Kk6vhIQlwaxbCFnkFOk+e0WAcFtvU1W0WVQjMPJw7fsUzo7XYKvt3OFKBxLs8n+wkqNG6fHlWLz2+EimtTgBaRd1akMurpQ29R6EK3P4bPDkWZZsnU32jIT3Y2uh4Mxf6Af6+N0h5BEbTSSpk1X8JoUshybpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Dr9FZ+3Y; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii.localdomain (unknown [40.65.108.177])
	by linux.microsoft.com (Postfix) with ESMTPSA id 8277E2119CB4;
	Wed, 19 Nov 2025 09:42:52 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8277E2119CB4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1763574172;
	bh=S8W+yMGFxLMDMoPpSsXxjY0OkpZh9nTEAVI+QKQLUFg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Dr9FZ+3YTssw3mJAFTnbpQ7aVEzHp4KWjaZstEY61sXo9A69Y+D0ToLgkbBSUZtzf
	 NfdMs9cMpS7Z9dXRunswlKhUww8kUTPC60QNn21ij+BH79g866a0yEIBMwFk3epVpo
	 buXgf/rCOqJtGHnvofprjDIsh2wHQbTkiq6lvrSw=
Date: Wed, 19 Nov 2025 09:42:50 -0800
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: Michael Kelley <mhklinux@outlook.com>
Cc: "kys@microsoft.com" <kys@microsoft.com>,
	"haiyangz@microsoft.com" <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 3/5] Drivers: hv: Batch GPA unmap operations to
 improve large region performance
Message-ID: <aR4Bmp009k09JasA@skinsburskii.localdomain>
References: <176339789196.27330.10517676002564595057.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <176339836892.27330.9465609709535892557.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <SN6PR02MB41574B72041F6AFB1B83DE36D4D6A@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR02MB41574B72041F6AFB1B83DE36D4D6A@SN6PR02MB4157.namprd02.prod.outlook.com>

On Tue, Nov 18, 2025 at 04:28:55PM +0000, Michael Kelley wrote:
> From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com> Sent: Monday, November 17, 2025 8:53 AM
> > 
> > Reduce overhead when unmapping large memory regions by batching GPA unmap
> > operations in 2MB-aligned chunks.
> > 
> > Use a dedicated constant for batch size to improve code clarity and
> > maintainability.
> > 
> > Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
> > Reviewed-by: Michael Kelley <mhklinux@outlook.com>
> > Reviewed-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> > ---
> >  drivers/hv/mshv_root.h         |    2 ++
> >  drivers/hv/mshv_root_hv_call.c |    2 +-
> >  drivers/hv/mshv_root_main.c    |   36 ++++++++++++++++++++++++++++++------
> >  3 files changed, 33 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/hv/mshv_root.h b/drivers/hv/mshv_root.h
> > index 3eb815011b46..5eece7077f8b 100644
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
> > index caf02cfa49c9..8fa983f1109b 100644
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
> > index a85872b72b1a..ef36d8115d8a 100644
> > --- a/drivers/hv/mshv_root_main.c
> > +++ b/drivers/hv/mshv_root_main.c
> > @@ -1365,7 +1365,7 @@ mshv_map_user_memory(struct mshv_partition *partition,
> >  static void mshv_partition_destroy_region(struct mshv_mem_region *region)
> >  {
> >  	struct mshv_partition *partition = region->partition;
> > -	u32 unmap_flags = 0;
> > +	u64 gfn, gfn_count, start_gfn, end_gfn;
> >  	int ret;
> > 
> >  	hlist_del(&region->hnode);
> > @@ -1380,12 +1380,36 @@ static void mshv_partition_destroy_region(struct mshv_mem_region *region)
> >  		}
> >  	}
> > 
> > -	if (region->flags.large_pages)
> > -		unmap_flags |= HV_UNMAP_GPA_LARGE_PAGE;
> > +	start_gfn = region->start_gfn;
> > +	end_gfn = region->start_gfn + region->nr_pages;
> > +
> > +	for (gfn = start_gfn; gfn < end_gfn; gfn += gfn_count) {
> > +		u32 unmap_flags = 0;
> > +
> > +		if (gfn % MSHV_MAX_UNMAP_GPA_PAGES)
> > +			gfn_count = ALIGN(gfn, MSHV_MAX_UNMAP_GPA_PAGES) - gfn;
> > +		else
> > +			gfn_count = MSHV_MAX_UNMAP_GPA_PAGES;
> > +
> > +		if (gfn + gfn_count > end_gfn)
> > +			gfn_count = end_gfn - gfn;
> > 
> > -	/* ignore unmap failures and continue as process may be exiting */
> > -	hv_call_unmap_gpa_pages(partition->pt_id, region->start_gfn,
> > -				region->nr_pages, unmap_flags);
> > +		/* Skip all pages in this range if none are mapped */
> > +		if (!memchr_inv(region->pages + (gfn - start_gfn), 0,
> > +				gfn_count * sizeof(struct page *)))
> > +			continue;
> > +
> > +		if (region->flags.large_pages &&
> > +		    VALUE_PMD_ALIGNED(gfn) && VALUE_PMD_ALIGNED(gfn_count))
> 
> VALUE_PMD_ALIGNED isn't defined until Patch 4 of this series.
> 
> The idea of a page count being PMD aligned occurs a few other places in
> Linux kernel code, and it is usually written as IS_ALIGNED(count, PTRS_PER_PMD),
> though there's one occurrence of !(count % PTRS_PER_PMD).
> 
> Also mshv_root_hv_call.c has HV_PAGE_COUNT_2M_ALIGNED() that does
> the same thing. Some macro consolidation is appropriate, or just open code
> as IS_ALIGNED(<cnt>, PTRS_PER_PMD) and eliminate the macros.
> 

Thanks for the idea.
I'll update accordingly.

Thanks,
Stanislav

> > +			unmap_flags |= HV_UNMAP_GPA_LARGE_PAGE;
> > +
> > +		ret = hv_call_unmap_gpa_pages(partition->pt_id, gfn,
> > +					      gfn_count, unmap_flags);
> > +		if (ret)
> > +			pt_err(partition,
> > +			       "Failed to unmap GPA pages %#llx-%#llx: %d\n",
> > +			       gfn, gfn + gfn_count - 1, ret);
> > +	}
> > 
> >  	mshv_region_invalidate(region);
> > 
> > 
> > 

