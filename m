Return-Path: <linux-hyperv+bounces-7937-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0896BCA1323
	for <lists+linux-hyperv@lfdr.de>; Wed, 03 Dec 2025 19:58:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B238B3000915
	for <lists+linux-hyperv@lfdr.de>; Wed,  3 Dec 2025 18:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C57C309EF4;
	Wed,  3 Dec 2025 18:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="XE/K6SbP"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCA992750E6;
	Wed,  3 Dec 2025 18:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764788296; cv=none; b=YNFhYPaobQlOnXQ/CXOYtfQEVDFOJssAWMLLSMe0/PfzQ+UMNotckh++odgSWrKEF1J/a5WRwhfEE0x+MZZmMGYkT/eNPxvKWJ1YlkG+HTm2vRjGa/7cMVx12YwzMI8YVVZOei7NHy3n/bmntEmgco80DESic1xxWeTltIWdEu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764788296; c=relaxed/simple;
	bh=ecZP7AK1pokBRvPg2ubk/LyhB+okGT2xwaN18xZwVPg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=avdGSbsJV+8OvtgUOfuxNKoByFJ4TflAIq41phroevR6pCQolzcSgW8W4pDyAtoNFEV7MXF36Y6dHmv59JIyH4DS7ruF/1IVOrNYdzgsNTWmUTwZJsLN8UEqINPmQ2QxC7YYwek7KLNfq1tWl96moWBcpfGfNuzQhLDtTZwdOTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=XE/K6SbP; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.64.201.124] (unknown [52.148.138.235])
	by linux.microsoft.com (Postfix) with ESMTPSA id 064FB201C97E;
	Wed,  3 Dec 2025 10:58:13 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 064FB201C97E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1764788294;
	bh=zA8tvs3sopHDHRs8ihFWxnt+zb5S1SE743DIfYhAKW8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=XE/K6SbPI9DCabWJI3M8VHSECsH4g9awDj7osZzvAZxvebz8Ke6S6udhSVGMAhoFT
	 e6wCn134fBidVXUgxNpeXRtO6E+p6KD9JNlsUmByMXmXqa9YagFgDaDQs3c3WXwcwF
	 GrteFGwg7BuotBbs7qR97f60jlGN15m4j0JlIhJ4=
Message-ID: <2c853152-c2f8-49c6-a16c-be8aa1b59234@linux.microsoft.com>
Date: Wed, 3 Dec 2025 10:58:12 -0800
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 5/7] Drivers: hv: Improve region overlap detection in
 partition create
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
 kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
References: <176412196000.447063.4256335030026363827.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <176412295734.447063.5692907557041244468.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
Content-Language: en-US
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
In-Reply-To: <176412295734.447063.5692907557041244468.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/25/2025 6:09 PM, Stanislav Kinsburskii wrote:
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

This logic does not work. I fixed this check in
ba9eb9b86d23 mshv: Fix create memory region overlap check

This change would just be reverting that fix.

Consider an existing region at 0x2000 of size 0x1000. The user
tries to map a new region at 0x1000 of size 0x3000. Since the new region
starts before and ends after the existing region, the overlap would not
be detected by this logic. It just checks if an existing region contains
0x1000 or 0x4000 - 1 which it does not. This is why a manual iteration
here is needed.

> -	}
>  
>  	rg = mshv_region_create(mem->guest_pfn, nr_pages,
>  				mem->userspace_addr, mem->flags,
> 
> 


