Return-Path: <linux-hyperv+bounces-8038-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CBC24CC4317
	for <lists+linux-hyperv@lfdr.de>; Tue, 16 Dec 2025 17:17:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A8F8D30221AD
	for <lists+linux-hyperv@lfdr.de>; Tue, 16 Dec 2025 16:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 713B428A3FA;
	Tue, 16 Dec 2025 16:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Hx7Y7Py4"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECD652652B0;
	Tue, 16 Dec 2025 16:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765901466; cv=none; b=lAIaTM1LhT5MhkcuccH5Vmw6ScS9MBshT1nSK0bg9TnO0C06kZYwCw6ZiKbwG+41JHvBZ2pTzdRfcgCQuYZ8QHSYI59bY443BResZ2EHJGDbegaC5H0zOu0OIjIHuemjKers6teYrBza01KnNLiiCXokI2kNDSrpRAw72yr1BY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765901466; c=relaxed/simple;
	bh=rIYXXwGc848NzWrAXTtsvMu593ydNFHRlu2gYtIZlh0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kgBRSnc5afm/JYmnpMpZ1oqrVnL4G7WNTaqFDf3qEBMrxUb7i5arHokCR82fU/DszoD14ppmOSuF9iIcZXv3IS0WLcoSiyfGTc8Pcn56ygUsygG2jJiCoyOK4BgY3RxpAp0HWKx3hvvnuUBLz5X7CCbxLsJ/BXemI1L7k77feI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Hx7Y7Py4; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii.localdomain (c-98-225-44-166.hsd1.wa.comcast.net [98.225.44.166])
	by linux.microsoft.com (Postfix) with ESMTPSA id F4005200D637;
	Tue, 16 Dec 2025 08:11:03 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com F4005200D637
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1765901464;
	bh=qBsBfAd61nSY6ZnIJ+HNzx1T7sGNXAlci92O3KjhZYY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Hx7Y7Py4ZGZeoluYekyfTGMkJ/x/wVSqJ+A+ksw1sG8ViRgk0Jtt+xmg8ebQoKEp4
	 Q7FRO/G8gz5lp0P1RLIMpGBJKK6rLSC5JO8eTco+4f4uq0Vs/M3gn5k77Xw/znB5zi
	 HZ0XQdrQ/pK93OtMghnK0RB+I4ar/J6QtiP2985w=
Date: Tue, 16 Dec 2025 08:11:01 -0800
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: Anirudh Rayabharam <anirudh@anirudhrb.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, longli@microsoft.com,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] mshv: handle gpa intercepts for arm64
Message-ID: <aUGElRga1r2g8cb-@skinsburskii.localdomain>
References: <20251216142030.4095527-1-anirudh@anirudhrb.com>
 <20251216142030.4095527-3-anirudh@anirudhrb.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251216142030.4095527-3-anirudh@anirudhrb.com>

On Tue, Dec 16, 2025 at 02:20:29PM +0000, Anirudh Rayabharam wrote:
> From: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>
> 
> The mshv driver now uses movable pages for guests. For arm64 guests
> to be functional, handle gpa intercepts for arm64 too (the current
> code implements handling only for x86). Without this, arm64 guests are
> broken.
> 
> Move some arch-agnostic functions out of #ifdefs so that they can be
> re-used.
> 
> Signed-off-by: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>
> ---
>  drivers/hv/mshv_root_main.c | 38 ++++++++++++++++++++++++++++---------
>  1 file changed, 29 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
> index 9cf28a3f12fe..882605349664 100644
> --- a/drivers/hv/mshv_root_main.c
> +++ b/drivers/hv/mshv_root_main.c
> @@ -608,7 +608,6 @@ mshv_partition_region_by_gfn(struct mshv_partition *partition, u64 gfn)
>  	return NULL;
>  }
>  
> -#ifdef CONFIG_X86_64
>  static struct mshv_mem_region *
>  mshv_partition_region_by_gfn_get(struct mshv_partition *p, u64 gfn)
>  {
> @@ -625,6 +624,34 @@ mshv_partition_region_by_gfn_get(struct mshv_partition *p, u64 gfn)
>  	return region;
>  }
>  
> +#ifdef CONFIG_X86_64
> +static u64 mshv_get_gpa_intercept_gfn(struct mshv_vp *vp)
> +{
> +	struct hv_x64_memory_intercept_message *msg;
> +	u64 gfn;
> +
> +	msg = (struct hv_x64_memory_intercept_message *)
> +		vp->vp_intercept_msg_page->u.payload;
> +
> +	gfn = HVPFN_DOWN(msg->guest_physical_address);
> +
> +	return gfn;
> +}
> +#else  /* CONFIG_X86_64 */

It's better to explicitly branch for ARM64 here for clarity as
hv_arm64_memory_intercept_message is defined only for ARM64.

> +static u64 mshv_get_gpa_intercept_gfn(struct mshv_vp *vp)
> +{
> +	struct hv_arm64_memory_intercept_message *msg;
> +	u64 gfn;
> +
> +	msg = (struct hv_arm64_memory_intercept_message *)
> +		vp->vp_intercept_msg_page->u.payload;
> +
> +	gfn = HVPFN_DOWN(msg->guest_physical_address);
> +
> +	return gfn;
> +}
> +#endif /* CONFIG_X86_64 */
> +

Are these functions really needed?
It would be clearer (and shorter) to branch directly in
mshv_handle_gpa_intercept.

Thanks,
Stanislav

>  /**
>   * mshv_handle_gpa_intercept - Handle GPA (Guest Physical Address) intercepts.
>   * @vp: Pointer to the virtual processor structure.
> @@ -640,14 +667,10 @@ static bool mshv_handle_gpa_intercept(struct mshv_vp *vp)
>  {
>  	struct mshv_partition *p = vp->vp_partition;
>  	struct mshv_mem_region *region;
> -	struct hv_x64_memory_intercept_message *msg;
>  	bool ret;
>  	u64 gfn;
>  
> -	msg = (struct hv_x64_memory_intercept_message *)
> -		vp->vp_intercept_msg_page->u.payload;
> -
> -	gfn = HVPFN_DOWN(msg->guest_physical_address);
> +	gfn = mshv_get_gpa_intercept_gfn(vp);
>  
>  	region = mshv_partition_region_by_gfn_get(p, gfn);
>  	if (!region)
> @@ -663,9 +686,6 @@ static bool mshv_handle_gpa_intercept(struct mshv_vp *vp)
>  
>  	return ret;
>  }
> -#else  /* CONFIG_X86_64 */
> -static bool mshv_handle_gpa_intercept(struct mshv_vp *vp) { return false; }
> -#endif /* CONFIG_X86_64 */
>  
>  static bool mshv_vp_handle_intercept(struct mshv_vp *vp)
>  {
> -- 
> 2.34.1
> 

