Return-Path: <linux-hyperv+bounces-6947-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAB35B866DF
	for <lists+linux-hyperv@lfdr.de>; Thu, 18 Sep 2025 20:38:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 831C94E8560
	for <lists+linux-hyperv@lfdr.de>; Thu, 18 Sep 2025 18:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C29ED2BE647;
	Thu, 18 Sep 2025 18:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="CRjPnKlI"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 453062BE032;
	Thu, 18 Sep 2025 18:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758220702; cv=none; b=fEBm0MV3FF2xuPcieCGxovrdi7/98nTwilx1tbz9mCKyH+4Yn9a43EASgfFlaKY9o7Dj7zutN+xblqTZxYo+mCvqDHXpCMzJHiObmRoCoevc3aOtm9WiLQNI/TCsGu6kF+bhP2VGWB0qbJC7n01uOBMjaQwojs0Eaq8zN+Cc2rM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758220702; c=relaxed/simple;
	bh=ulC+1+5lGYgY+AuAZDgWQZqUtncUXzroNw/XNcNPbio=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wc5zd0RloQi7lCOj3Vifj8NsGIPZYQcOh0DI2zgw7emnPZTcCKwqnkkQDpNQtYgdsLoHjdmbFA7FXhCsnMmrstR3bBxXbWsyhI/CMnFrPWbfRgbbTzFt1z+8AeG6jrQbw1IQSgzEDT6aubP130OnXcbXfA+tGnPxNelou/xikuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=CRjPnKlI; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii.localdomain (unknown [131.107.8.20])
	by linux.microsoft.com (Postfix) with ESMTPSA id 46A5B20143DC;
	Thu, 18 Sep 2025 11:38:20 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 46A5B20143DC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1758220700;
	bh=Fg1119xSTDdSrtVPmSvIYGWSfphVptBg/VhVjiGu4GI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CRjPnKlI9372n9sjEj1POZJXUPRf0gQwknNRg09FEq6B3ZPwLsSa/TqrvZvNIGnDX
	 i8N3XmGoCC+FBy9qUgXkx2VYfhvQbHOF9TRUi1vvIOEfQDAB9zvsUD4DrtnfAgU8hG
	 yWPN819JE3LhaSqMxRWEGuXMooEcxuoZq6w7RvEI=
Date: Thu, 18 Sep 2025 11:38:17 -0700
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	prapal@linux.microsoft.com, easwar.hariharan@linux.microsoft.com,
	tiala@microsoft.com, anirudh@anirudhrb.com,
	paekkaladevi@linux.microsoft.com, kys@microsoft.com,
	haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com
Subject: Re: [PATCH v3 1/5] mshv: Only map vp->vp_stats_pages if on root
 scheduler
Message-ID: <aMxRme0kxXwE_jul@skinsburskii.localdomain>
References: <1758066262-15477-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1758066262-15477-2-git-send-email-nunodasneves@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1758066262-15477-2-git-send-email-nunodasneves@linux.microsoft.com>

On Tue, Sep 16, 2025 at 04:44:18PM -0700, Nuno Das Neves wrote:
> This mapping is only used for checking if the dispatch thread is
> blocked. This is only relevant for the root scheduler, so check the
> scheduler type to determine whether to map/unmap these pages, instead of
> the current check, which is incorrect.
> 
> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> Reviewed-by: Anirudh Rayabharam <anirudh@anirudhrb.com>
> Reviewed-by: Praveen K Paladugu <prapal@linux.microsoft.com>
> Reviewed-by: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
> Reviewed-by: Tianyu Lan <tiala@microsoft.com>
> ---
>  drivers/hv/mshv_root_main.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
> index e3b2bd417c46..24df47726363 100644
> --- a/drivers/hv/mshv_root_main.c
> +++ b/drivers/hv/mshv_root_main.c
> @@ -934,7 +934,11 @@ mshv_partition_ioctl_create_vp(struct mshv_partition *partition,
>  			goto unmap_register_page;
>  	}
>  
> -	if (hv_parent_partition()) {
> +	/*
> +	 * This mapping of the stats page is for detecting if dispatch thread
> +	 * is blocked - only relevant for root scheduler
> +	 */
> +	if (hv_scheduler_type == HV_SCHEDULER_TYPE_ROOT) {
>  		ret = mshv_vp_stats_map(partition->pt_id, args.vp_index,
>  					stats_pages);
>  		if (ret)
> @@ -963,7 +967,7 @@ mshv_partition_ioctl_create_vp(struct mshv_partition *partition,
>  	if (mshv_partition_encrypted(partition) && is_ghcb_mapping_available())
>  		vp->vp_ghcb_page = page_to_virt(ghcb_page);
>  
> -	if (hv_parent_partition())
> +	if (hv_scheduler_type == HV_SCHEDULER_TYPE_ROOT)
>  		memcpy(vp->vp_stats_pages, stats_pages, sizeof(stats_pages));
>  
>  	/*
> @@ -986,7 +990,7 @@ mshv_partition_ioctl_create_vp(struct mshv_partition *partition,
>  free_vp:
>  	kfree(vp);
>  unmap_stats_pages:
> -	if (hv_parent_partition())
> +	if (hv_scheduler_type == HV_SCHEDULER_TYPE_ROOT)
>  		mshv_vp_stats_unmap(partition->pt_id, args.vp_index);
>  unmap_ghcb_page:
>  	if (mshv_partition_encrypted(partition) && is_ghcb_mapping_available()) {
> @@ -1740,7 +1744,7 @@ static void destroy_partition(struct mshv_partition *partition)
>  			if (!vp)
>  				continue;
>  
> -			if (hv_parent_partition())
> +			if (hv_scheduler_type == HV_SCHEDULER_TYPE_ROOT)
>  				mshv_vp_stats_unmap(partition->pt_id, vp->vp_index);
>  
>  			if (vp->vp_register_page) {

Acked-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>

> -- 
> 2.34.1
> 

