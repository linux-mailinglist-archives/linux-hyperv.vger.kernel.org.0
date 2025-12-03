Return-Path: <linux-hyperv+bounces-7938-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 433CDCA13AE
	for <lists+linux-hyperv@lfdr.de>; Wed, 03 Dec 2025 20:03:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 66B78300CAC3
	for <lists+linux-hyperv@lfdr.de>; Wed,  3 Dec 2025 19:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23917324707;
	Wed,  3 Dec 2025 19:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="j8Rk7png"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9320F320A05;
	Wed,  3 Dec 2025 19:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764788613; cv=none; b=BbAePKBEdGa9HJpfY/A+v16WpvxSv8OAlTwnTidLhCd+zO93WbYeVTZEynnWz1dAVLPYkSD5IQsRJyrvE5KYsqof9D35X2WyAhX5Om8Al0rZzWXq+ZrCXNylag52Dcgw8d3nVHJGLOSq7JMloomm9ts8Ot7Mn5of0roJftiQdmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764788613; c=relaxed/simple;
	bh=q3x/AVm+76yhfEuQzM260JyNdFB+ydfI8Qu4CZGDTX8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E1t38btzBPIjlVQ9ZlD/EqRQNV9WYihTEzmNANG+0c/qRqF5yu3h2mbb1oevPv7Q/+QVaY497Cf0lFVloEp+h2PsTlI1436IME8OJVyTc+QYEB1s4qfB3uVBj5qVenPm1VUjPh12nixee4Dfk++2WiJyVqMAm8X2sCFzj0mgY+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=j8Rk7png; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii.localdomain (unknown [20.236.11.102])
	by linux.microsoft.com (Postfix) with ESMTPSA id 90CC121203BE;
	Wed,  3 Dec 2025 11:03:30 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 90CC121203BE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1764788610;
	bh=KZIb9GlMNrT2R266jDXA+OHDM73Sy48tbKkMJOJ1IHg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j8Rk7pngXoN3tPRTmIxQmo+pdhd/2DNZh1FOSnvWUErzYEqnSLDjS4oybLeN7IjEh
	 mYMZVYygUOlZtwcqxrbEkXhmgA+D/hTg2BfwlJ6GiyYJSK0JWPqUuSMq4ussMeR+cF
	 1+EUFblYAsZ1h6YCJ6W9ELCXhGIUlC0DdQWB37JA=
Date: Wed, 3 Dec 2025 11:03:28 -0800
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, longli@microsoft.com, mhklinux@outlook.com,
	prapal@linux.microsoft.com, mrathor@linux.microsoft.com,
	paekkaladevi@linux.microsoft.com
Subject: Re: [PATCH 1/3] mshv: Ignore second stats page map result failure
Message-ID: <aTCJgA3p9UKcIiU5@skinsburskii.localdomain>
References: <1764784405-4484-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1764784405-4484-2-git-send-email-nunodasneves@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1764784405-4484-2-git-send-email-nunodasneves@linux.microsoft.com>

On Wed, Dec 03, 2025 at 09:53:23AM -0800, Nuno Das Neves wrote:
> From: Purna Pavan Chandra Aekkaladevi <paekkaladevi@linux.microsoft.com>
> 
> Older versions of the hypervisor do not support HV_STATS_AREA_PARENT
> and return HV_STATUS_INVALID_PARAMETER for the second stats page
> mapping request.
> 
> This results a failure in module init. Instead of failing, gracefully
> fall back to populating stats_pages[HV_STATS_AREA_PARENT] with the
> already-mapped stats_pages[HV_STATS_AREA_SELF].
> 
> Signed-off-by: Purna Pavan Chandra Aekkaladevi <paekkaladevi@linux.microsoft.com>
> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> ---
>  drivers/hv/mshv_root_hv_call.c | 43 ++++++++++++++++++++++++++++++----
>  drivers/hv/mshv_root_main.c    |  3 +++
>  2 files changed, 42 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/hv/mshv_root_hv_call.c b/drivers/hv/mshv_root_hv_call.c
> index 598eaff4ff29..0427785bb7fe 100644
> --- a/drivers/hv/mshv_root_hv_call.c
> +++ b/drivers/hv/mshv_root_hv_call.c
> @@ -855,6 +855,24 @@ static int hv_call_map_stats_page2(enum hv_stats_object_type type,
>  	return ret;
>  }
>  
> +static int
> +hv_stats_get_area_type(enum hv_stats_object_type type,
> +		       const union hv_stats_object_identity *identity)
> +{
> +	switch (type) {
> +	case HV_STATS_OBJECT_HYPERVISOR:
> +		return identity->hv.stats_area_type;
> +	case HV_STATS_OBJECT_LOGICAL_PROCESSOR:
> +		return identity->lp.stats_area_type;
> +	case HV_STATS_OBJECT_PARTITION:
> +		return identity->partition.stats_area_type;
> +	case HV_STATS_OBJECT_VP:
> +		return identity->vp.stats_area_type;
> +	}
> +
> +	return -EINVAL;
> +}
> +
>  static int hv_call_map_stats_page(enum hv_stats_object_type type,
>  				  const union hv_stats_object_identity *identity,
>  				  void **addr)
> @@ -863,7 +881,7 @@ static int hv_call_map_stats_page(enum hv_stats_object_type type,
>  	struct hv_input_map_stats_page *input;
>  	struct hv_output_map_stats_page *output;
>  	u64 status, pfn;
> -	int ret = 0;
> +	int hv_status, ret = 0;
>  
>  	do {
>  		local_irq_save(flags);
> @@ -878,11 +896,28 @@ static int hv_call_map_stats_page(enum hv_stats_object_type type,
>  		pfn = output->map_location;
>  
>  		local_irq_restore(flags);
> -		if (hv_result(status) != HV_STATUS_INSUFFICIENT_MEMORY) {
> -			ret = hv_result_to_errno(status);
> +
> +		hv_status = hv_result(status);
> +		if (hv_status != HV_STATUS_INSUFFICIENT_MEMORY) {
>  			if (hv_result_success(status))
>  				break;
> -			return ret;
> +
> +			/*
> +			 * Older versions of the hypervisor do not support the
> +			 * PARENT stats area. In this case return "success" but
> +			 * set the page to NULL. The caller should check for
> +			 * this case and instead just use the SELF area.
> +			 */
> +			if (hv_stats_get_area_type(type, identity) == HV_STATS_AREA_PARENT &&
> +			    hv_status == HV_STATUS_INVALID_PARAMETER) {
> +				pr_debug_once("%s: PARENT area type is unsupported\n",
> +					      __func__);

Nit: this gebug once looks a bit odd. Why not having it printed always
(especially given the unconfidional status print a few lines below)?

Reviewed-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>

Thanks,
Stanislav

> +				*addr = NULL;
> +				return 0;
> +			}
> +
> +			hv_status_debug(status, "\n");
> +			return hv_result_to_errno(status);
>  		}
>  
>  		ret = hv_call_deposit_pages(NUMA_NO_NODE,
> diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
> index bc15d6f6922f..f59a4ab47685 100644
> --- a/drivers/hv/mshv_root_main.c
> +++ b/drivers/hv/mshv_root_main.c
> @@ -905,6 +905,9 @@ static int mshv_vp_stats_map(u64 partition_id, u32 vp_index,
>  	if (err)
>  		goto unmap_self;
>  
> +	if (!stats_pages[HV_STATS_AREA_PARENT])
> +		stats_pages[HV_STATS_AREA_PARENT] = stats_pages[HV_STATS_AREA_SELF];
> +
>  	return 0;
>  
>  unmap_self:
> -- 
> 2.34.1
> 

