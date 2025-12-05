Return-Path: <linux-hyperv+bounces-7980-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A805CCA98AD
	for <lists+linux-hyperv@lfdr.de>; Fri, 05 Dec 2025 23:52:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EAF54300F89C
	for <lists+linux-hyperv@lfdr.de>; Fri,  5 Dec 2025 22:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5A5F26F467;
	Fri,  5 Dec 2025 22:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="b2PdJU8e"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5199F12B93;
	Fri,  5 Dec 2025 22:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764975046; cv=none; b=jJBW9sR3AAolIwYRWJndyJucuy2F/a9QAlzS1ug0oTp942etCQxePncXoZG5bz0aMaynY8//49NVjECFn6OxTy4BESVOnR1BZiWfOXTxs8dw5BU/IuOBERraSh1r188KUrEdwnFRG/+CyPqZO6pcYnAs2HQXU46YodkzQjb8FkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764975046; c=relaxed/simple;
	bh=N4Cg5lnh9cHPV54s9VfduitLRPslA8kNs3w4AUsxeY4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PjAL+fwbg+gY6pVFxReogbSI0Zy4pus9eRsPh5sUbK+GrKr6AgUAjCSQoZPd+/NTQwr2azSbP4XSz/h2NjTFDCViVX5ckSj3YmrKczvlYbKWIgOiEe72/Ibpxp2M3SaxLlOTbiF4pUo8TpT5RCSQ02h9dQny0VgxXTQ8UHaLgCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=b2PdJU8e; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii.localdomain (unknown [20.236.11.185])
	by linux.microsoft.com (Postfix) with ESMTPSA id 2E44A201D7E1;
	Fri,  5 Dec 2025 14:50:44 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2E44A201D7E1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1764975044;
	bh=gwcUev1a30eQljE9GxEU/TmV3QpST+wcmgeRtY4VfX0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b2PdJU8eYuQApWgxRQV+JlpiF831TPo3DkAo4ZlF73K50qIRyPUTqx7OjAjSQm5+i
	 ORb5A42g7fywwtZYlbvPRM1uqla7G1xv92rpB+RemNxNWU2oQlXW8QL9Yly7bLyvlB
	 vnpfllWBqXF+dIs2aznSBplFvw4vk2m6NX/NBLbM=
Date: Fri, 5 Dec 2025 14:50:41 -0800
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, longli@microsoft.com, mhklinux@outlook.com,
	prapal@linux.microsoft.com, mrathor@linux.microsoft.com,
	paekkaladevi@linux.microsoft.com
Subject: Re: [PATCH v2 1/3] mshv: Ignore second stats page map result failure
Message-ID: <aTNhwdDWfSdBA43l@skinsburskii.localdomain>
References: <1764961122-31679-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1764961122-31679-2-git-send-email-nunodasneves@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1764961122-31679-2-git-send-email-nunodasneves@linux.microsoft.com>

On Fri, Dec 05, 2025 at 10:58:40AM -0800, Nuno Das Neves wrote:
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

Reviewed-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>

> Signed-off-by: Purna Pavan Chandra Aekkaladevi <paekkaladevi@linux.microsoft.com>
> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> Reviewed-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
> ---
>  drivers/hv/mshv_root_hv_call.c | 41 ++++++++++++++++++++++++++++++----
>  drivers/hv/mshv_root_main.c    |  3 +++
>  2 files changed, 40 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/hv/mshv_root_hv_call.c b/drivers/hv/mshv_root_hv_call.c
> index 598eaff4ff29..b1770c7b500c 100644
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
> @@ -878,11 +896,26 @@ static int hv_call_map_stats_page(enum hv_stats_object_type type,
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

