Return-Path: <linux-hyperv+bounces-7904-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 08FAAC97F59
	for <lists+linux-hyperv@lfdr.de>; Mon, 01 Dec 2025 16:07:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 21779343D39
	for <lists+linux-hyperv@lfdr.de>; Mon,  1 Dec 2025 15:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AD6B244663;
	Mon,  1 Dec 2025 15:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b="HJG+L3w7"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from sender3-of-o52.zoho.com (sender3-of-o52.zoho.com [136.143.184.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 343C5313E0C;
	Mon,  1 Dec 2025 15:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.184.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764601624; cv=pass; b=QjoqjG2lSPG92xr0EmHs5nPWRta5ALaWtHuNO+ZIaZYTWctZZQb2nnWCMGnSdMWxn2u+2mwVP9XwVaA5iY0zYY4KqtIJKtMto7GdRu9wjWD3JU/FES5A3lsRrRigkVcP3YvvLVmFKSzsmwtOkkZY6AXSP+ajka1v+JopKsCI5Vs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764601624; c=relaxed/simple;
	bh=0PtOwjWXgtjdZ6uBeBUwp+fU3PeBJDwkgVXvRhk1HC4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rDt7/iD2FQKStsTA1ir3JqKAtaZ8BnhopDYy+8DVUJ1bqRhXKZGlA02rfu98wivGohZ4v+AYncpMhjoJJyYh4XZk+CMMPljp0sDaZ/5vxsDqSmuIhYUjvqPQvR46CGU7gA1Aj3GjbMe+HitIYQTutuoVriPsqLHUS5xs/8mYeo8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=anirudhrb.com; spf=pass smtp.mailfrom=anirudhrb.com; dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b=HJG+L3w7; arc=pass smtp.client-ip=136.143.184.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=anirudhrb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=anirudhrb.com
ARC-Seal: i=1; a=rsa-sha256; t=1764601613; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Js11EpjzlHRkzF686gl7pzU4qp5tXmTo5OdP5tiTUXo0t6LjI5P7H0iT8hoR9oaXwvuQ5QC8RtghTMzQph8cxIFmUeJyCOutMFVM1Ng3jcyPkWtuPKUEKyM8ibljPqrRUdqmRMZetvo1Qx35rlN59QPGGFFmpUoZPje8EfZpkbY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1764601613; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=jGdXy/eVIK0q0xI9LMLSvhs6tLDGAUagHToNqahAwl0=; 
	b=Wv0XK1lsGIdI/HVA6m7IeySUHzrnVofNx6FDA811tHHFfvtyH/XB1lIxaQWN69pc1BRpILryFlF8n75j9uRLW41KmypGtRvLpq6oPq+k9NUiAsS6KogN6beTTA6x/rXFQ2czBaDds9OV+C0pygZ/+3RiFAADz2YCPK/Cj9itJ9E=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=anirudhrb.com;
	spf=pass  smtp.mailfrom=anirudh@anirudhrb.com;
	dmarc=pass header.from=<anirudh@anirudhrb.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1764601613;
	s=zoho; d=anirudhrb.com; i=anirudh@anirudhrb.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=jGdXy/eVIK0q0xI9LMLSvhs6tLDGAUagHToNqahAwl0=;
	b=HJG+L3w7LyaqyYkPYsWbODx8cpSoUYBiZ4+0EC9gnI/fu6jUnDfrgPU8LTqHcPLq
	PpPEI7InaqqdrvplFJs35MhoLWENseeQwHVUGYIi76Zd4Lin8uJr9AHCskr0Or4Nnkw
	jh/n+TCHRbYZrOIn400tCulr3iEstdwHKVKNuuvY=
Received: by mx.zohomail.com with SMTPS id 1764601610798849.6715280313184;
	Mon, 1 Dec 2025 07:06:50 -0800 (PST)
Date: Mon, 1 Dec 2025 15:06:47 +0000
From: Anirudh Rayabharam <anirudh@anirudhrb.com>
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 5/7] Drivers: hv: Improve region overlap detection in
 partition create
Message-ID: <aS2vB4QS_VeHrRvB@anirudh-surface.localdomain>
References: <176412196000.447063.4256335030026363827.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <176412295734.447063.5692907557041244468.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <176412295734.447063.5692907557041244468.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
X-ZohoMailClient: External

On Wed, Nov 26, 2025 at 02:09:17AM +0000, Stanislav Kinsburskii wrote:
> Refactor region overlap check in mshv_partition_create_region to use
> mshv_partition_region_by_gfn for both start and end guest PFNs, replacing
> manual iteration.
> 
> This is a cleaner approach that leverages existing functionality to
> accurately detect overlapping memory regions.
> 
> Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
> ---
>  drivers/hv/mshv_root_main.c |    8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
> index 5dfb933da981..ae600b927f49 100644
> --- a/drivers/hv/mshv_root_main.c
> +++ b/drivers/hv/mshv_root_main.c
> @@ -1086,13 +1086,9 @@ static int mshv_partition_create_region(struct mshv_partition *partition,
>  	u64 nr_pages = HVPFN_DOWN(mem->size);
>  
>  	/* Reject overlapping regions */
> -	hlist_for_each_entry(rg, &partition->pt_mem_regions, hnode) {
> -		if (mem->guest_pfn + nr_pages <= rg->start_gfn ||
> -		    rg->start_gfn + rg->nr_pages <= mem->guest_pfn)
> -			continue;
> -
> +	if (mshv_partition_region_by_gfn(partition, mem->guest_pfn) ||
> +	    mshv_partition_region_by_gfn(partition, mem->guest_pfn + nr_pages - 1))
>  		return -EEXIST;
> -	}
>  
>  	rg = mshv_region_create(mem->guest_pfn, nr_pages,
>  				mem->userspace_addr, mem->flags,
> 
> 

Reviewed-by: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>


