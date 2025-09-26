Return-Path: <linux-hyperv+bounces-7003-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0E6CBA54DE
	for <lists+linux-hyperv@lfdr.de>; Sat, 27 Sep 2025 00:10:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F3491734BB
	for <lists+linux-hyperv@lfdr.de>; Fri, 26 Sep 2025 22:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9866929AB05;
	Fri, 26 Sep 2025 22:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="N1GdRCW4"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F58026C3B6;
	Fri, 26 Sep 2025 22:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758924645; cv=none; b=r4RF09sBbVBWp8K1zC8cO4VNO3gBleJDGTi3HofY5NYxJoKjABA3WzO+ooMS7Y3ZGkIYF7cAonBp6AwcrrXhQWO/GV6TQPEQL4bgJZPdEYtR/CqfFVCNEMDE9lrHZmpB5mlOzjiY4zpU+iseFt8v6QSyYQ7ERfvvgNn6nn7Ha74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758924645; c=relaxed/simple;
	bh=3UVQ5H/bgILzhC94Y9eHH4EpZ9MZ2hY2Jtvlz5kPdjc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ow2JeQ+t767fGtxDU6xO7EQTwgkYgFPBpZyCi5tacUoMBRzJK2MGYURnGbz3hNjg8g3GkHPY7LLiu0DOAXxCeJoSYkj1QrbZaYQjlXRH2xKqKLH6zow7hRq2VOy/3yMHjToahSTvqI+yipXCr/3Vp1lDnlP10xmrEuOjUDOO+e4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=N1GdRCW4; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii.localdomain (unknown [20.236.11.102])
	by linux.microsoft.com (Postfix) with ESMTPSA id 1FB6A2012C14;
	Fri, 26 Sep 2025 15:10:42 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1FB6A2012C14
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1758924642;
	bh=p6xwXuS5jxknhCEzUXgLwDn3UogvPABGxyn+YRcWwrw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N1GdRCW4hSSn5yXTXeSPPBXmBWaNUyLx+Ka1sH99ybWBJv8sTQNRmfIECmFLe0Cof
	 0wFH5X69D9LNuIbrc+EtU5eeFZ09SHl2V6OGBcDJbQlabbG7LMpMEvnCbcsUvQ3TxC
	 OuLTr8FhOARD+rcAaUtekbRO4BPsyWXD0HAciHS0=
Date: Fri, 26 Sep 2025 15:10:40 -0700
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] Drivers: hv: Centralize guest memory region
 destruction in helper
Message-ID: <aNcPYJzETLZHCNpW@skinsburskii.localdomain>
References: <175874669044.157998.15064894246017794777.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <175874947750.157998.7004962396456082421.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <66893d19-654e-4ef7-9a9c-c33a5549dbea@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66893d19-654e-4ef7-9a9c-c33a5549dbea@linux.microsoft.com>

On Fri, Sep 26, 2025 at 11:15:54AM -0700, Nuno Das Neves wrote:
> On 9/24/2025 2:31 PM, Stanislav Kinsburskii wrote:

<snip>

> > +	/*
> > +	 * Unmap only the mapped pages to optimize performance,
> > +	 * especially for large memory regions.
> > +	 */
> > +	for (page_offset = 0; page_offset < region->nr_pages; page_offset += page_count) {
> > +		page_count = 1;
> > +		if (!region->pages[page_offset])
> > +			continue;
> I mentioned it above, but can this even happen in the current code (i.e. without
> moveable pages)?
> 

No.

> Also, has the impact of this change been measured? I understand the logic behind
> the change - there could be large unmapped sequences within the region so we might
> be able to skip a lot of reps of the unmap hypercall, but the region could also be
> very fragmented and this method might cause *more* reps in that case, right?
> 

I see your point. Indeed, we should optimize the number of pages to
unmap by the maximum number allowed for the hypercall.
I'll make this change, thanks.

> Either way, this change belongs in a separate patch.

Fair enough.

Thanks,
Stanislav

> > +
> > +		for (; page_count < region->nr_pages - page_offset; page_count++) {
> > +			if (!region->pages[page_offset + page_count])
> > +				break;
> > +		}
> > +
> > +		/* ignore unmap failures and continue as process may be exiting */
> > +		hv_call_unmap_gpa_pages(partition->pt_id,
> > +					region->start_gfn + page_offset,
> > +					page_count, unmap_flags);
> > +	}
> > +
> > +	mshv_region_evict(region);
> > +
> > +	vfree(region);
> > +}
> > +
> >  /* Called for unmapping both the guest ram and the mmio space */
> >  static long
> >  mshv_unmap_user_memory(struct mshv_partition *partition,
> >  		       struct mshv_user_mem_region mem)
> >  {
> >  	struct mshv_mem_region *region;
> > -	u32 unmap_flags = 0;
> >  
> >  	if (!(mem.flags & BIT(MSHV_SET_MEM_BIT_UNMAP)))
> >  		return -EINVAL;
> > @@ -1407,18 +1453,7 @@ mshv_unmap_user_memory(struct mshv_partition *partition,
> >  	    region->nr_pages != HVPFN_DOWN(mem.size))
> >  		return -EINVAL;
> >  
> > -	hlist_del(&region->hnode);
> > -
> > -	if (region->flags.large_pages)
> > -		unmap_flags |= HV_UNMAP_GPA_LARGE_PAGE;
> > -
> > -	/* ignore unmap failures and continue as process may be exiting */
> > -	hv_call_unmap_gpa_pages(partition->pt_id, region->start_gfn,
> > -				region->nr_pages, unmap_flags);
> > -
> > -	mshv_region_evict(region);
> > -
> > -	vfree(region);
> > +	mshv_partition_destroy_region(region);
> >  	return 0;
> >  }
> >  
> > @@ -1754,8 +1789,8 @@ static void destroy_partition(struct mshv_partition *partition)
> >  {
> >  	struct mshv_vp *vp;
> >  	struct mshv_mem_region *region;
> > -	int i, ret;
> >  	struct hlist_node *n;
> > +	int i;
> >  
> >  	if (refcount_read(&partition->pt_ref_count)) {
> >  		pt_err(partition,
> > @@ -1815,25 +1850,9 @@ static void destroy_partition(struct mshv_partition *partition)
> >  
> >  	remove_partition(partition);
> >  
> > -	/* Remove regions, regain access to the memory and unpin the pages */
> >  	hlist_for_each_entry_safe(region, n, &partition->pt_mem_regions,
> > -				  hnode) {
> > -		hlist_del(&region->hnode);
> > -
> > -		if (mshv_partition_encrypted(partition)) {
> > -			ret = mshv_partition_region_share(region);
> > -			if (ret) {
> > -				pt_err(partition,
> > -				       "Failed to regain access to memory, unpinning user pages will fail and crash the host error: %d\n",
> > -				      ret);
> > -				return;
> > -			}
> > -		}
> > -
> > -		mshv_region_evict(region);
> > -
> > -		vfree(region);
> > -	}
> > +				  hnode)
> > +		mshv_partition_destroy_region(region);
> >  
> >  	/* Withdraw and free all pages we deposited */
> >  	hv_call_withdraw_memory(U64_MAX, NUMA_NO_NODE, partition->pt_id);
> > 
> > 
> 

