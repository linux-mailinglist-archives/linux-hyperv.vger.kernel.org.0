Return-Path: <linux-hyperv+bounces-7191-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FA63BCEBDE
	for <lists+linux-hyperv@lfdr.de>; Sat, 11 Oct 2025 01:07:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BE9719A4740
	for <lists+linux-hyperv@lfdr.de>; Fri, 10 Oct 2025 23:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 238C227B4E4;
	Fri, 10 Oct 2025 23:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="P3IoGEBO"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B623C1A4E70;
	Fri, 10 Oct 2025 23:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760137664; cv=none; b=SROZFxQtoDiIjbt0wMrLZ5WGWMUC2eNV5hagPH1/zSaGl+D0Fh1OvVAR8YI0gzzbMqrKrBOhxui3C7R3rVBVkr1XyzDVxYiyjr6OFHAZvTjxzHkoLgnF6AQmuK0E5KfWJIeoCsGokfaX1JSxHeqZ62f47q4D0JEx8Qy0VP/5Amk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760137664; c=relaxed/simple;
	bh=q+3ahshQYQyCOTi0imG7YQ8916B5kPZTrAr3NC/1zS0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gqzbX+0+7i0Ww2ewtbWJGwAWGvBhJot1GUtc3CqL9KPky1MgKW+tDq0XNTKDbx6qJwOp87ke+Ed7X0qFy963HrP55AuSYlpReJfn3eFpIlx5LkHPHXW16fKIgonXIZPjQ/DdpoGe8ZOs7dluJUcV0sKJlP4xQ0GaT7EzZil5kOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=P3IoGEBO; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.65.97.55] (unknown [20.236.10.120])
	by linux.microsoft.com (Postfix) with ESMTPSA id 9F4312016020;
	Fri, 10 Oct 2025 16:07:41 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9F4312016020
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1760137662;
	bh=Doi2VmtCCQUx3LFEiAsRBKfYt6Hirm/ROsJntgdqAII=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=P3IoGEBOZi7szmESTLNBl4l5A6ZIfXAcu5xTmCFc9ZupLRoL9QymAk00mkbLsjdN0
	 Qenc4/MoDCGEGYAfloL0fEsh8fK9enB7GCFTEOmG3bfQva7nErPppyjft3Rm8yKnIG
	 75yUv/QKi5K5fEJF3YAVG6dHeB+D2oe9LM79aCH8=
Message-ID: <c84cb93c-7248-4f56-8b16-9b1c6b481a64@linux.microsoft.com>
Date: Fri, 10 Oct 2025 16:07:40 -0700
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/5] Drivers: hv: Ensure large page GPA mapping is
 PMD-aligned
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
 kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
References: <175976284493.16834.4572937416426518745.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <175976319301.16834.18430498559434584549.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
Content-Language: en-US
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
In-Reply-To: <175976319301.16834.18430498559434584549.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/6/2025 8:06 AM, Stanislav Kinsburskii wrote:
> With the upcoming introduction of movable pages, a region doesn't guarantee
> always having large pages mapped. Both mapping on fault and unmapping
> during PTE invalidation may not be 2M-aligned, while the hypervisor
> requires both the GFN and page count to be 2M-aligned to use the large page
> flag.
> 
> Update the logic for large page mapping in mshv_region_remap_pages() to
> require both page_offset and page_count to be PMD-aligned.
> 
> Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
> ---
>  drivers/hv/mshv_root_main.c |    6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
> index b61bef6b9c132..cb462495f34b5 100644
> --- a/drivers/hv/mshv_root_main.c
> +++ b/drivers/hv/mshv_root_main.c
> @@ -34,6 +34,8 @@
>  #include "mshv.h"
>  #include "mshv_root.h"
>  
> +#define VALUE_PMD_ALIGNED(c)			(!((c) & (PTRS_PER_PMD - 1)))
> +
>  MODULE_AUTHOR("Microsoft");
>  MODULE_LICENSE("GPL");
>  MODULE_DESCRIPTION("Microsoft Hyper-V root partition VMM interface /dev/mshv");
> @@ -1100,7 +1102,9 @@ mshv_region_remap_pages(struct mshv_mem_region *region, u32 map_flags,
>  	if (page_offset + page_count > region->nr_pages)
>  		return -EINVAL;
>  
> -	if (region->flags.large_pages)
> +	if (region->flags.large_pages &&
> +	    VALUE_PMD_ALIGNED(page_offset) &&
> +	    VALUE_PMD_ALIGNED(page_count))
>  		map_flags |= HV_MAP_GPA_LARGE_PAGE;
>  
>  	/* ask the hypervisor to map guest ram */
> 
> 

Reviewed-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>

