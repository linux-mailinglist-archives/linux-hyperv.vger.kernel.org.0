Return-Path: <linux-hyperv+bounces-7190-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65938BCEBD5
	for <lists+linux-hyperv@lfdr.de>; Sat, 11 Oct 2025 01:06:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2676D54447A
	for <lists+linux-hyperv@lfdr.de>; Fri, 10 Oct 2025 23:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10D4A27B4F5;
	Fri, 10 Oct 2025 23:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="TS8lkZH6"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D0AE27B4E4;
	Fri, 10 Oct 2025 23:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760137610; cv=none; b=DLSOQpJLaxEezMPjJCOflmd8IXkbsDxjHoVcQT9rJgJhpwhBNHp+qEUMdPuqEyQQRN+r/ibT+B46xftclnN1KIiFd7xebijXLXoorcyXHGp+p5A3+LFWMRduYxPzIiIkzLUxWPo4/mFriYA9k3jYLP10WT4KF29XZoxmtD8goTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760137610; c=relaxed/simple;
	bh=vP5QNSY1W31DnU2sT3J2iOCPuLZnuDapSlYjRFxK/n4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Otknbs9r/9tkPkvpAiUJTj6w72AZIK8zAqhxGI8Ix9TGUTMSApXmfPkfzdk6mY7fQhPiWavhYOzeN/f2SLaBqD7ieBK43FypZhRrVHMK0M3Yd4COKCvFztpHBYgaVCBxnVKkNc8PBLAkrniRUop34qzVO7ta0MkwiXITiGrb+pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=TS8lkZH6; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.65.97.55] (unknown [20.236.11.102])
	by linux.microsoft.com (Postfix) with ESMTPSA id B0DC4201601D;
	Fri, 10 Oct 2025 16:06:44 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B0DC4201601D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1760137605;
	bh=mwIFeJ1KKd5Sc2uIhclnh5A/XfzapTJ/Acz9suBhQ20=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=TS8lkZH6I5W3fD+l1DI5DtiA8OibFFmYmowc7nJnvK0wZm4h0JjBXxEmaMVAkfPTM
	 cE0QFG0LV1ZKkfyBbiKCq0FeNNFei8iPvTQoHwv1+ViLxgm9/jqKrlqf8mjENGFO8J
	 FJfTIgsZ9rCtoAr/0OCsepPWE00AxRrHhxPk3p84=
Message-ID: <5be44d00-2a34-49cf-828f-105c2e07874b@linux.microsoft.com>
Date: Fri, 10 Oct 2025 16:06:43 -0700
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/5] Drivers: hv: Batch GPA unmap operations to improve
 large region performance
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
 kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
References: <175976284493.16834.4572937416426518745.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <175976318688.16834.16198650808431263017.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
Content-Language: en-US
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
In-Reply-To: <175976318688.16834.16198650808431263017.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/6/2025 8:06 AM, Stanislav Kinsburskii wrote:
> Reduce overhead when unmapping large memory regions by batching GPA unmap
> operations in 2MB-aligned chunks.
> 
> Use a dedicated constant for batch size to improve code clarity and
> maintainability.
> 
> Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
> ---
>  drivers/hv/mshv_root.h         |    2 ++
>  drivers/hv/mshv_root_hv_call.c |    2 +-
>  drivers/hv/mshv_root_main.c    |   28 +++++++++++++++++++++++++---
>  3 files changed, 28 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/hv/mshv_root.h b/drivers/hv/mshv_root.h
> index e3931b0f12693..97e64d5341b6e 100644
> --- a/drivers/hv/mshv_root.h
> +++ b/drivers/hv/mshv_root.h
> @@ -32,6 +32,8 @@ static_assert(HV_HYP_PAGE_SIZE == MSHV_HV_PAGE_SIZE);
>  
>  #define MSHV_PIN_PAGES_BATCH_SIZE	(0x10000000ULL / HV_HYP_PAGE_SIZE)
>  
> +#define MSHV_MAX_UNMAP_GPA_PAGES	512
> +
>  struct mshv_vp {
>  	u32 vp_index;
>  	struct mshv_partition *vp_partition;
> diff --git a/drivers/hv/mshv_root_hv_call.c b/drivers/hv/mshv_root_hv_call.c
> index c9c274f29c3c6..0696024ccfe31 100644
> --- a/drivers/hv/mshv_root_hv_call.c
> +++ b/drivers/hv/mshv_root_hv_call.c
> @@ -17,7 +17,7 @@
>  /* Determined empirically */
>  #define HV_INIT_PARTITION_DEPOSIT_PAGES 208
>  #define HV_MAP_GPA_DEPOSIT_PAGES	256
> -#define HV_UMAP_GPA_PAGES		512
> +#define HV_UMAP_GPA_PAGES		MSHV_MAX_UNMAP_GPA_PAGES
>  
>  #define HV_PAGE_COUNT_2M_ALIGNED(pg_count) (!((pg_count) & (0x200 - 1)))
>  
> diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
> index 97e322f3c6b5e..b61bef6b9c132 100644
> --- a/drivers/hv/mshv_root_main.c
> +++ b/drivers/hv/mshv_root_main.c
> @@ -1378,6 +1378,7 @@ mshv_map_user_memory(struct mshv_partition *partition,
>  static void mshv_partition_destroy_region(struct mshv_mem_region *region)
>  {
>  	struct mshv_partition *partition = region->partition;
> +	u64 gfn, gfn_count, start_gfn, end_gfn;
>  	u32 unmap_flags = 0;
>  	int ret;
>  
> @@ -1396,9 +1397,30 @@ static void mshv_partition_destroy_region(struct mshv_mem_region *region)
>  	if (region->flags.large_pages)
>  		unmap_flags |= HV_UNMAP_GPA_LARGE_PAGE;
>  
> -	/* ignore unmap failures and continue as process may be exiting */
> -	hv_call_unmap_gpa_pages(partition->pt_id, region->start_gfn,
> -				region->nr_pages, unmap_flags);
> +	start_gfn = region->start_gfn;
> +	end_gfn = region->start_gfn + region->nr_pages;
> +
> +	for (gfn = start_gfn; gfn < end_gfn; gfn += gfn_count) {
> +		if (gfn % MSHV_MAX_UNMAP_GPA_PAGES)
> +			gfn_count = ALIGN(gfn, MSHV_MAX_UNMAP_GPA_PAGES) - gfn;
> +		else
> +			gfn_count = MSHV_MAX_UNMAP_GPA_PAGES;
> +
> +		if (gfn + gfn_count > end_gfn)
> +			gfn_count = end_gfn - gfn;
> +
> +		/* Skip if all pages in this range if none is mapped */

nit: comment grammar. Suggest "Skip all pages in this range if none are mapped"

Looks good otherwise.

Reviewed-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>

> +		if (!memchr_inv(region->pages + (gfn - start_gfn), 0,
> +				gfn_count * sizeof(struct page *)))
> +			continue;
> +
> +		ret = hv_call_unmap_gpa_pages(partition->pt_id, gfn,
> +					      gfn_count, unmap_flags);
> +		if (ret)
> +			pt_err(partition,
> +			       "Failed to unmap GPA pages %#llx-%#llx: %d\n",
> +			       gfn, gfn + gfn_count - 1, ret);
> +	}
>  
>  	mshv_region_invalidate(region);
>  
> 
> 


