Return-Path: <linux-hyperv+bounces-6732-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A86DB443CE
	for <lists+linux-hyperv@lfdr.de>; Thu,  4 Sep 2025 19:01:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36197487300
	for <lists+linux-hyperv@lfdr.de>; Thu,  4 Sep 2025 17:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D43B81F91C7;
	Thu,  4 Sep 2025 17:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b="BnuzWZfL"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8096322DFA7;
	Thu,  4 Sep 2025 17:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757005266; cv=pass; b=D9kN7NDwPTF0ieCHettnin0QDtqrJNJDw9LddpHh/lZTwOsCvpoZx5WFH+/PubSVub24QT8qbJdvgKONsYWABsBU78gKSdBmF0zhc1Bwu0vdABQpBG04Ioc6cYlgD3ThHBHSQjSepvZRErJNHHFjEZFaw4pUcOS1sS0GChK5Wfo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757005266; c=relaxed/simple;
	bh=V9n/QHN0W9ztS+8N+XUBp9EilvBCpifv7wr7DWe71TM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V1ME/CbB8Eq1jFxKJQdxo15M0p2OLuVrycIFlvPrd6An9bnU/qcj2dO7j00c1Tqrfs+TN7XnMZCZ8T9EcKIbXzoMrUtKIrc+9lWIXf31WSXNLlYURvGkOiRzKatScD4yO8Ao+4K+62XidERXrVFJ3d0/iKQTvqlqim+r/AZ+798=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=anirudhrb.com; spf=pass smtp.mailfrom=anirudhrb.com; dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b=BnuzWZfL; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=anirudhrb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=anirudhrb.com
ARC-Seal: i=1; a=rsa-sha256; t=1757005249; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=DWGLQq7eZb3SiSz0Qj3nvUj1c11o8rCtSLJYQpjgRuo0zvVfNsCzqzb04A+QxHR9wvOw+LmJwZXetPg/2kpHPthiH7PMr8I6RCdI6+r/Xjx7NZaGMza38Afs9LaiCKKrfSp4tf+UUlbCqhtJ3ZLplSjwuMSe0R/oOHT+iToARF0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1757005249; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Extfhguhi+MezMzEvb+E7LMw0/GYh3iGoM/RRDv0Pqw=; 
	b=DizWFRBstfRTqun/4F+8Nnfq6ijLRUuJTWuG+XZqJJ+HMWbSL0Bm7brEw+7LSGYWhj+75aFUsJ3kRMrmUe4UEAOSiwovpIG9EL4FSxFjh/Xi86Mly2IVnSDvfS+pvz+unDX0yb8RKK5ueBBHDOXhRUQx9Kkr20H8uhFxBawPCwY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=anirudhrb.com;
	spf=pass  smtp.mailfrom=anirudh@anirudhrb.com;
	dmarc=pass header.from=<anirudh@anirudhrb.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1757005249;
	s=zoho; d=anirudhrb.com; i=anirudh@anirudhrb.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=Extfhguhi+MezMzEvb+E7LMw0/GYh3iGoM/RRDv0Pqw=;
	b=BnuzWZfLmhem7+dZkUcUocRHRlUGx1gevuAWRIii+GKT6xlSETBvwi0hFaIt46qV
	vFCY9lRGxt+kEcGQWg4VW9LQV/nC+nz/Mx3NF72A52Dc/oMkoSI4xn6dqXlRCwpBNOo
	D/SR4n9U1f5CeRW+qQWs1Co4SZUHgkIB4rbVLXNc=
Received: by mx.zohomail.com with SMTPS id 1757005245827562.2744728676952;
	Thu, 4 Sep 2025 10:00:45 -0700 (PDT)
Date: Thu, 4 Sep 2025 17:00:39 +0000
From: Anirudh Rayabharam <anirudh@anirudhrb.com>
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	mhklinux@outlook.com, decui@microsoft.com,
	paekkaladevi@linux.microsoft.com
Subject: Re: [PATCH 1/6] mshv: Only map vp->vp_stats_pages if on root
 scheduler
Message-ID: <aLnFt6snPe-9uU4I@anirudh-surface.localdomain>
References: <1756428230-3599-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1756428230-3599-2-git-send-email-nunodasneves@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1756428230-3599-2-git-send-email-nunodasneves@linux.microsoft.com>
X-ZohoMailClient: External

On Thu, Aug 28, 2025 at 05:43:45PM -0700, Nuno Das Neves wrote:
> This mapping is only used for checking if the dispatch thread is
> blocked. This is only relevant for the root scheduler, so check the
> scheduler type to determine whether to map/unmap these pages, instead of
> the current check, which is incorrect.
> 
> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> ---
>  drivers/hv/mshv_root_main.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
> index e4ee9beddaf5..bbdefe8a2e9c 100644
> --- a/drivers/hv/mshv_root_main.c
> +++ b/drivers/hv/mshv_root_main.c
> @@ -987,7 +987,11 @@ mshv_partition_ioctl_create_vp(struct mshv_partition *partition,
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
> @@ -1016,7 +1020,7 @@ mshv_partition_ioctl_create_vp(struct mshv_partition *partition,
>  	if (mshv_partition_encrypted(partition) && is_ghcb_mapping_available())
>  		vp->vp_ghcb_page = page_to_virt(ghcb_page);
>  
> -	if (hv_parent_partition())
> +	if (hv_scheduler_type == HV_SCHEDULER_TYPE_ROOT)
>  		memcpy(vp->vp_stats_pages, stats_pages, sizeof(stats_pages));
>  
>  	/*
> @@ -1039,7 +1043,7 @@ mshv_partition_ioctl_create_vp(struct mshv_partition *partition,
>  free_vp:
>  	kfree(vp);
>  unmap_stats_pages:
> -	if (hv_parent_partition())
> +	if (hv_scheduler_type == HV_SCHEDULER_TYPE_ROOT)
>  		mshv_vp_stats_unmap(partition->pt_id, args.vp_index);
>  unmap_ghcb_page:
>  	if (mshv_partition_encrypted(partition) && is_ghcb_mapping_available()) {
> @@ -1793,7 +1797,7 @@ static void destroy_partition(struct mshv_partition *partition)
>  			if (!vp)
>  				continue;
>  
> -			if (hv_parent_partition())
> +			if (hv_scheduler_type == HV_SCHEDULER_TYPE_ROOT)
>  				mshv_vp_stats_unmap(partition->pt_id, vp->vp_index);
>  
>  			if (vp->vp_register_page) {
> -- 
> 2.34.1
> 

Reviewed-by: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>


