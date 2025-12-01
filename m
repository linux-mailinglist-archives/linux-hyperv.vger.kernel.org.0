Return-Path: <linux-hyperv+bounces-7902-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id BDDA9C96D72
	for <lists+linux-hyperv@lfdr.de>; Mon, 01 Dec 2025 12:12:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 35EE2343F73
	for <lists+linux-hyperv@lfdr.de>; Mon,  1 Dec 2025 11:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2788930749A;
	Mon,  1 Dec 2025 11:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b="HmjxCzSH"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from sender4-of-o52.zoho.com (sender4-of-o52.zoho.com [136.143.188.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98CC306B11;
	Mon,  1 Dec 2025 11:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764587558; cv=pass; b=kuqo8DUOzLt2lk1wiVznX3tiU7eWoB5qvWpW4cTFlTC+kNEX9SkHD2YuqcQBF+DraEQ2U/HBTJopHh6ssN58Eq0tPEmKvHSt6SKXy0xJPVi7lH1llUYSukLKiZMA+Wo2ZpB0DM5TEIssUjo5p1W5tKAJVCeBfF9OzdVmoSeU8d8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764587558; c=relaxed/simple;
	bh=4OZGLUHw7HDaHsAGu3Kxn5ReuEsYpdOtKCRO/rk01hM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rWJiLorfLjp2N4K601QxZo0TQtkQilWwxQGAzxcu7sFXrBI8Mp+tOzHVARlhZl+Vx3Rbx67fodp0OnnMiDa5DYD9+v2Qq93FBmdiRdMJHLZwRUQjQMEeZXhqfBKpPQ91fMWTsWY7ZnfMW6mcj2wKz24orjhux1uKJP64RVbG/D4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=anirudhrb.com; spf=pass smtp.mailfrom=anirudhrb.com; dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b=HmjxCzSH; arc=pass smtp.client-ip=136.143.188.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=anirudhrb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=anirudhrb.com
ARC-Seal: i=1; a=rsa-sha256; t=1764587549; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=cJ9ecqsQYStF0dWsQ1b/N/NgDt2y0JwnC5DMsF5izh5oIV8K9GebFY5DXf/+raQ6N6EshWMd454+i88NaEzlU9ugDjZJ0uziIC/5s0pUZlW1g2V6XeZA3/akJ1L2Yw7c2l7Rs5iTCkixYAchzRGXlZgYSvZ0nviMIcLMZYrap/o=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1764587549; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=NKEvddvssUesWzws3Y9jIy5N6HIw5ibEdZY+4Z+I9ts=; 
	b=GMg4TkUgTIfxhL9qKU1ia3dGpUtjLohexvW+/7Xq3iNz3otsiEEgsuneg97E57AS4SQwZSVAd96PbHzIXFf238DdtyEJl+xDl6jnqcz0N30J7nl7jOwcNz4ORoAs334fhyNSxIbpT/dZ14fs43mxqqtb2V0vxvyXmpyO6mfQCT0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=anirudhrb.com;
	spf=pass  smtp.mailfrom=anirudh@anirudhrb.com;
	dmarc=pass header.from=<anirudh@anirudhrb.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1764587549;
	s=zoho; d=anirudhrb.com; i=anirudh@anirudhrb.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=NKEvddvssUesWzws3Y9jIy5N6HIw5ibEdZY+4Z+I9ts=;
	b=HmjxCzSHQQ/zcRyW02SS8VLumesRDxaM2f+ZLvscAue0jkrydJ7Ibbbcy21buUsL
	y6lqvKB9zXYVZlK/dwcB1koGzvlbhQF52Ms7P0rIG0exT2+a9bFygnks+Yptzpzi1K4
	CUeBisuO9iS91thtiDdiBFTuqtnNgN++YrHl+df8=
Received: by mx.zohomail.com with SMTPS id 1764587543810488.0206629646394;
	Mon, 1 Dec 2025 03:12:23 -0800 (PST)
Date: Mon, 1 Dec 2025 11:12:19 +0000
From: Anirudh Rayabharam <anirudh@anirudhrb.com>
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 2/7] Drivers: hv: Centralize guest memory region
 destruction
Message-ID: <aS14E-QpVccRc6Gz@anirudh-surface.localdomain>
References: <176412196000.447063.4256335030026363827.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <176412293764.447063.2221992979416155779.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <176412293764.447063.2221992979416155779.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
X-ZohoMailClient: External

On Wed, Nov 26, 2025 at 02:08:57AM +0000, Stanislav Kinsburskii wrote:
> Centralize guest memory region destruction to prevent resource leaks and
> inconsistent cleanup across unmap and partition destruction paths.
> 
> Unify region removal, encrypted partition access recovery, and region
> invalidation to improve maintainability and reliability. Reduce code
> duplication and make future updates less error-prone by encapsulating
> cleanup logic in a single helper.
> 
> Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
> Reviewed-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> ---
>  drivers/hv/mshv_root_main.c |   65 ++++++++++++++++++++++---------------------
>  1 file changed, 34 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
> index fec82619684a..ec18984c3f2d 100644
> --- a/drivers/hv/mshv_root_main.c
> +++ b/drivers/hv/mshv_root_main.c
> @@ -1356,13 +1356,42 @@ mshv_map_user_memory(struct mshv_partition *partition,
>  	return ret;
>  }
>  
> +static void mshv_partition_destroy_region(struct mshv_mem_region *region)
> +{
> +	struct mshv_partition *partition = region->partition;
> +	u32 unmap_flags = 0;
> +	int ret;
> +
> +	hlist_del(&region->hnode);
> +
> +	if (mshv_partition_encrypted(partition)) {
> +		ret = mshv_partition_region_share(region);
> +		if (ret) {
> +			pt_err(partition,
> +			       "Failed to regain access to memory, unpinning user pages will fail and crash the host error: %d\n",
> +			       ret);
> +			return;
> +		}
> +	}
> +
> +	if (region->flags.large_pages)
> +		unmap_flags |= HV_UNMAP_GPA_LARGE_PAGE;
> +
> +	/* ignore unmap failures and continue as process may be exiting */
> +	hv_call_unmap_gpa_pages(partition->pt_id, region->start_gfn,
> +				region->nr_pages, unmap_flags);
> +
> +	mshv_region_invalidate(region);
> +
> +	vfree(region);
> +}
> +
>  /* Called for unmapping both the guest ram and the mmio space */
>  static long
>  mshv_unmap_user_memory(struct mshv_partition *partition,
>  		       struct mshv_user_mem_region mem)
>  {
>  	struct mshv_mem_region *region;
> -	u32 unmap_flags = 0;
>  
>  	if (!(mem.flags & BIT(MSHV_SET_MEM_BIT_UNMAP)))
>  		return -EINVAL;
> @@ -1377,18 +1406,8 @@ mshv_unmap_user_memory(struct mshv_partition *partition,
>  	    region->nr_pages != HVPFN_DOWN(mem.size))
>  		return -EINVAL;
>  
> -	hlist_del(&region->hnode);
> +	mshv_partition_destroy_region(region);
>  
> -	if (region->flags.large_pages)
> -		unmap_flags |= HV_UNMAP_GPA_LARGE_PAGE;
> -
> -	/* ignore unmap failures and continue as process may be exiting */
> -	hv_call_unmap_gpa_pages(partition->pt_id, region->start_gfn,
> -				region->nr_pages, unmap_flags);
> -
> -	mshv_region_invalidate(region);
> -
> -	vfree(region);
>  	return 0;
>  }
>  
> @@ -1724,8 +1743,8 @@ static void destroy_partition(struct mshv_partition *partition)
>  {
>  	struct mshv_vp *vp;
>  	struct mshv_mem_region *region;
> -	int i, ret;
>  	struct hlist_node *n;
> +	int i;
>  
>  	if (refcount_read(&partition->pt_ref_count)) {
>  		pt_err(partition,
> @@ -1789,25 +1808,9 @@ static void destroy_partition(struct mshv_partition *partition)
>  
>  	remove_partition(partition);
>  
> -	/* Remove regions, regain access to the memory and unpin the pages */
>  	hlist_for_each_entry_safe(region, n, &partition->pt_mem_regions,
> -				  hnode) {
> -		hlist_del(&region->hnode);
> -
> -		if (mshv_partition_encrypted(partition)) {
> -			ret = mshv_partition_region_share(region);
> -			if (ret) {
> -				pt_err(partition,
> -				       "Failed to regain access to memory, unpinning user pages will fail and crash the host error: %d\n",
> -				      ret);
> -				return;
> -			}
> -		}
> -
> -		mshv_region_invalidate(region);
> -
> -		vfree(region);
> -	}
> +				  hnode)
> +		mshv_partition_destroy_region(region);
>  
>  	/* Withdraw and free all pages we deposited */
>  	hv_call_withdraw_memory(U64_MAX, NUMA_NO_NODE, partition->pt_id);
> 
> 

Reviewed-by: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>


