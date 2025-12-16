Return-Path: <linux-hyperv+bounces-8039-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A3E8CC450D
	for <lists+linux-hyperv@lfdr.de>; Tue, 16 Dec 2025 17:33:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 742E1306D080
	for <lists+linux-hyperv@lfdr.de>; Tue, 16 Dec 2025 16:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9A302D8799;
	Tue, 16 Dec 2025 16:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="dyZHsGi3"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 681E52ED844;
	Tue, 16 Dec 2025 16:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765901903; cv=none; b=nW66AbKOZUGlDnY9YGj+HZ8JKp9XmavKeZ/imp3aTUGBaGn5lNQFxDbkRaINX6CcQtx6GsUWD595BnVObmNkiNssRvL9BiNIR/TeoapWE2O8ZN7bCJMHoNoYHDlxOGZr5ntOIekBsmkD2ICtYTS7saSmATqJQWfNenbPa9CuoLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765901903; c=relaxed/simple;
	bh=X0rFzhnu7bCktMIQpOEnWn4wVISeuppZJlk0RdW0ETY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tn/g50KzOLljRHe5W4NA3arCy019kyR8P68PdDA+82M9vz0ZV6LvzjgoeJ2jCKPOPtNmAe/jN7fi37UKVI6muajxT2mqHvoayhwagC3HJsBc774DUFyyPRYaNqq1n1UR5YarKC2Ds5rTGOMeZ49u0mw2OSUtw2JElDt+ub4Edgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=dyZHsGi3; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii.localdomain (unknown [52.148.140.42])
	by linux.microsoft.com (Postfix) with ESMTPSA id 94428200D63A;
	Tue, 16 Dec 2025 08:18:21 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 94428200D63A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1765901901;
	bh=0Vj9Jd7QEb7NJy4Pvk9EFitPbr6znNdlj8ccgZrjNwI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dyZHsGi34OsTPF/Ij0Jp8PfWBGhTqANixSW04XFD1VnVLm9gvTR301w+wfn0TwRH3
	 PCo/2oVlfTxjGGt9THsqdOfYFOGfG7un2Re2OosH2Hp7niN84to6WisEcmRQU8ir69
	 eZMPwmR1tB/38aKvTfu1A51cuKrQgo6kmsrHc2SA=
Date: Tue, 16 Dec 2025 08:18:19 -0800
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: Anirudh Rayabharam <anirudh@anirudhrb.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, longli@microsoft.com,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] mshv: release mutex on region invalidation failure
Message-ID: <aUGGS0v-n6K7ehI8@skinsburskii.localdomain>
References: <20251216142030.4095527-1-anirudh@anirudhrb.com>
 <20251216142030.4095527-4-anirudh@anirudhrb.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251216142030.4095527-4-anirudh@anirudhrb.com>

On Tue, Dec 16, 2025 at 02:20:30PM +0000, Anirudh Rayabharam wrote:
> From: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>
> 
> In the region invalidation failure path in
> mshv_region_interval_invalidate(), the region mutex is not released. Fix
> it by releasing the mutex in the failure path.
> 

Please, add the corresponding "Fixes" tag.

Acked-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>

> Signed-off-by: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>
> ---
>  drivers/hv/mshv_regions.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hv/mshv_regions.c b/drivers/hv/mshv_regions.c
> index 8abf80129f9b..30bacba6aec3 100644
> --- a/drivers/hv/mshv_regions.c
> +++ b/drivers/hv/mshv_regions.c
> @@ -511,7 +511,7 @@ static bool mshv_region_interval_invalidate(struct mmu_interval_notifier *mni,
>  	ret = mshv_region_remap_pages(region, HV_MAP_GPA_NO_ACCESS,
>  				      page_offset, page_count);
>  	if (ret)
> -		goto out_fail;
> +		goto out_unlock;
>  
>  	mshv_region_invalidate_pages(region, page_offset, page_count);
>  
> @@ -519,6 +519,8 @@ static bool mshv_region_interval_invalidate(struct mmu_interval_notifier *mni,
>  
>  	return true;
>  
> +out_unlock:
> +	mutex_unlock(&region->mutex);
>  out_fail:
>  	WARN_ONCE(ret,
>  		  "Failed to invalidate region %#llx-%#llx (range %#lx-%#lx, event: %u, pages %#llx-%#llx, mm: %#llx): %d\n",
> -- 
> 2.34.1
> 

