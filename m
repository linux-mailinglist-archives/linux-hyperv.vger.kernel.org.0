Return-Path: <linux-hyperv+bounces-7126-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D5AACBBFC8F
	for <lists+linux-hyperv@lfdr.de>; Tue, 07 Oct 2025 01:33:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9296D4E4117
	for <lists+linux-hyperv@lfdr.de>; Mon,  6 Oct 2025 23:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45A061F9EC0;
	Mon,  6 Oct 2025 23:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Wifod4DZ"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCE81126C1E;
	Mon,  6 Oct 2025 23:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759793578; cv=none; b=iECffFIpVuTpXuCR6urEBrjqR1ffbA608uT7fMCC7cKvI7NuHYIXIrxVs7IR3hAb8K+PwKDZ59T0PEgwaSGMG0PCyNmdQtszu9CcD0ZxqFWyh7yMDISTuDrfZYmypRkcm90S6y8gNkm30dG04mdnCvcytEGWw7i0uPsTJXNVcMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759793578; c=relaxed/simple;
	bh=q3UJNBaXy3+iKXS786Mg8FWrBiHfF+qntnETEIONvrM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D1xSz9UyNZJBnF8xmJ/BiSW5syXmtocmY5wYlItAaPX0OGuCeNZ+fBLe9TQW0urxmdRpMvHdOe6etfJKIXaaz/NeddKc/vh2Gm9M09rH0iMJzrM1T8jYm40iC9sJ3dr2a4OozaRfyGp+znBvwSBPE8ZE6bVIl8eIDeUDSRDiEFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Wifod4DZ; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii.localdomain (unknown [52.148.138.235])
	by linux.microsoft.com (Postfix) with ESMTPSA id BA2642012C23;
	Mon,  6 Oct 2025 16:32:55 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com BA2642012C23
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1759793575;
	bh=inkR22e2GxB4PsK3P6rb64wIDV4aJVaAG7bIWDgOcRY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Wifod4DZmoTNYD+mOrY3dAMJorrnx/oomm3C1B+VXZXeIoy0iVCmlQl89A23zZnXt
	 edqTSCJgFzD4rw0b+Xa/EyOWUexHJP0xq8U+D43JEGfhryOreY+q4SOT3ZX4nSU7HO
	 EZVx6JH/gCnbyrLI3k11KmZAKXUQMRKWJX4mxfho=
Date: Mon, 6 Oct 2025 16:32:54 -0700
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: Michael Kelley <mhklinux@outlook.com>
Cc: "kys@microsoft.com" <kys@microsoft.com>,
	"haiyangz@microsoft.com" <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 3/5] Drivers: hv: Batch GPA unmap operations to
 improve large region performance
Message-ID: <aORRplcP1r17gave@skinsburskii.localdomain>
References: <175976284493.16834.4572937416426518745.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <175976318688.16834.16198650808431263017.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <SN6PR02MB4157A4FBBF17A73E5D549DDFD4E3A@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <SN6PR02MB4157A4FBBF17A73E5D549DDFD4E3A@SN6PR02MB4157.namprd02.prod.outlook.com>

On Mon, Oct 06, 2025 at 05:09:07PM +0000, Michael Kelley wrote:
> From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com> Sent: Monday, October 6, 2025 8:06 AM
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
> >  drivers/hv/mshv_root_main.c    |   28 +++++++++++++++++++++++++---
> >  3 files changed, 28 insertions(+), 4 deletions(-)
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
> > index 97e322f3c6b5e..b61bef6b9c132 100644
> > --- a/drivers/hv/mshv_root_main.c
> > +++ b/drivers/hv/mshv_root_main.c
> > @@ -1378,6 +1378,7 @@ mshv_map_user_memory(struct mshv_partition *partition,
> >  static void mshv_partition_destroy_region(struct mshv_mem_region *region)
> >  {
> >  	struct mshv_partition *partition = region->partition;
> > +	u64 gfn, gfn_count, start_gfn, end_gfn;
> >  	u32 unmap_flags = 0;
> >  	int ret;
> > 
> > @@ -1396,9 +1397,30 @@ static void mshv_partition_destroy_region(struct mshv_mem_region *region)
> >  	if (region->flags.large_pages)
> >  		unmap_flags |= HV_UNMAP_GPA_LARGE_PAGE;
> > 
> > -	/* ignore unmap failures and continue as process may be exiting */
> > -	hv_call_unmap_gpa_pages(partition->pt_id, region->start_gfn,
> > -				region->nr_pages, unmap_flags);
> > +	start_gfn = region->start_gfn;
> > +	end_gfn = region->start_gfn + region->nr_pages;
> > +
> > +	for (gfn = start_gfn; gfn < end_gfn; gfn += gfn_count) {
> > +		if (gfn % MSHV_MAX_UNMAP_GPA_PAGES)
> > +			gfn_count = ALIGN(gfn, MSHV_MAX_UNMAP_GPA_PAGES) - gfn;
> > +		else
> > +			gfn_count = MSHV_MAX_UNMAP_GPA_PAGES;
> 
> You could do the entire if/else as:
> 
> 		gfn_count = ALIGN(gfn + 1, MSHV_MAX_UNMAP_GPA_PAGES) - gfn;
> 
> Using "gfn + 1" handles the case where gfn is already aligned. Arguably, this is a bit
> more obscure, so it's just a suggestion.
> 
> > +
> > +		if (gfn + gfn_count > end_gfn)
> > +			gfn_count = end_gfn - gfn;
> 
> Or
> 		gfn_count = min(gfn_count, end_gfn - gfn);
> 
> I usually prefer the "min" function instead of an "if" statement if logically
> the intent is to compute the minimum. But again, just a suggestion.
> 
> > +
> > +		/* Skip if all pages in this range if none is mapped */
> > +		if (!memchr_inv(region->pages + (gfn - start_gfn), 0,
> > +				gfn_count * sizeof(struct page *)))
> > +			continue;
> > +
> > +		ret = hv_call_unmap_gpa_pages(partition->pt_id, gfn,
> > +					      gfn_count, unmap_flags);
> > +		if (ret)
> > +			pt_err(partition,
> > +			       "Failed to unmap GPA pages %#llx-%#llx: %d\n",
> > +			       gfn, gfn + gfn_count - 1, ret);
> > +	}
> 
> Overall, I think this algorithm looks good and handles all the edge cases.
> 

Thank you for your suggestions. I also generally prefer reducing the
code in a similar way, but in this case, I deliberately chose a more
elaborate approach to improve clarity.

So, if you don’t mind, I’d rather keep it as is, since this version is
easy to understand and self-documenting.

Thanks,
Stanislav

> Michael
> 
> > 
> >  	mshv_region_invalidate(region);
> > 
> > 
> > 
> 

