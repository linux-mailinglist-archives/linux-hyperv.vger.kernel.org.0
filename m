Return-Path: <linux-hyperv+bounces-4938-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 790DEA8B255
	for <lists+linux-hyperv@lfdr.de>; Wed, 16 Apr 2025 09:37:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EB4016F9D5
	for <lists+linux-hyperv@lfdr.de>; Wed, 16 Apr 2025 07:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E8BE227E8C;
	Wed, 16 Apr 2025 07:37:44 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A68EC8F7D;
	Wed, 16 Apr 2025 07:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744789064; cv=none; b=V0rhhpRneovA7NVk3u80DII5iSJ8i4n7Ha2XANHQApEzzm28qUC+yeS9Mo3c9uEbMULL82XQ48lddczMnR1DSKkBVLssfzI4r07DPEUoKG1PVCx2puKIP/SDHZtyd3gtHaevvZkrW0eGk/IHFwrFJpFA1uio1GkqjyfM+tcdeWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744789064; c=relaxed/simple;
	bh=A2zdC+VzZXUkztMafHM4wvtTwwSA7mHk2q5XfHtZX1k=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=o9PKP5zDinNBKs/ZNWA7ryhM8TWZBIc9f/wwBbrY4V/0u1wSB/lCTvs/CVYdTbFXCLT9Rsjbi2/yPwrI93x+8W1Mux9ZtSfgg5eZiMmPcenYr6z2/TurvI41E9w+TyvHz59Jeg8VEEWri74Nj/jR2JOsn4uJpGkO+sC3CHMa19o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4ZctBn03cVz1cyT0;
	Wed, 16 Apr 2025 15:36:49 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id AAC77180080;
	Wed, 16 Apr 2025 15:37:38 +0800 (CST)
Received: from [10.67.120.129] (10.67.120.129) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 16 Apr 2025 15:37:38 +0800
Message-ID: <d06a75d7-c503-4aa1-a846-d23ef5c48d3c@huawei.com>
Date: Wed, 16 Apr 2025 15:37:38 +0800
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] mm: page_frag: Check fragsz at the beginning of
 __page_frag_alloc_align()
To: Haiyang Zhang <haiyangz@microsoft.com>, <linux-hyperv@vger.kernel.org>,
	<akpm@linux-foundation.org>, <corbet@lwn.net>, <linux-mm@kvack.org>,
	<linux-doc@vger.kernel.org>
CC: <decui@microsoft.com>, <kys@microsoft.com>, <paulros@microsoft.com>,
	<olaf@aepfle.de>, <vkuznets@redhat.com>, <davem@davemloft.net>,
	<wei.liu@kernel.org>, <longli@microsoft.com>, <linux-kernel@vger.kernel.org>
References: <1743715309-318-1-git-send-email-haiyangz@microsoft.com>
 <1743715309-318-2-git-send-email-haiyangz@microsoft.com>
Content-Language: en-US
From: Yunsheng Lin <linyunsheng@huawei.com>
In-Reply-To: <1743715309-318-2-git-send-email-haiyangz@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemf200006.china.huawei.com (7.185.36.61)

On 2025/4/4 5:21, Haiyang Zhang wrote:
> Frag allocator is not designed for fragsz > PAGE_SIZE. So, check and return
> the error at the beginning of __page_frag_alloc_align(), instead of
> succeed for a few times, then fail due to not refilling the cache.
> 
> Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
> ---
>  mm/page_frag_cache.c | 22 +++++++++-------------
>  1 file changed, 9 insertions(+), 13 deletions(-)
> 
> diff --git a/mm/page_frag_cache.c b/mm/page_frag_cache.c
> index d2423f30577e..d6bf022087e7 100644
> --- a/mm/page_frag_cache.c
> +++ b/mm/page_frag_cache.c
> @@ -98,6 +98,15 @@ void *__page_frag_alloc_align(struct page_frag_cache *nc,
>  	unsigned int size, offset;
>  	struct page *page;
>  
> +	if (unlikely(fragsz > PAGE_SIZE)) {
> +		/*
> +		 * The caller is trying to allocate a fragment
> +		 * with fragsz > PAGE_SIZE which is not supported
> +		 * by design. So we simply return NULL here.
> +		 */
> +		return NULL;
> +	}

The checking is done at below to avoid doing the checking for the
likely case of cache being enough as the frag API is mostly used
to allocate small memory.

And it seems my recent refactoring to frag API have made two
frag API misuse more obvious if I recalled it correctly. If more
explicit about that for all the codepath is really helpful, perhaps
VM_BUG_ON() is an option to make it more explicit while avoiding
the checking as much as possible.

> +
>  	if (unlikely(!encoded_page)) {
>  refill:
>  		page = __page_frag_cache_refill(nc, gfp_mask);
> @@ -119,19 +128,6 @@ void *__page_frag_alloc_align(struct page_frag_cache *nc,
>  	size = PAGE_SIZE << encoded_page_decode_order(encoded_page);
>  	offset = __ALIGN_KERNEL_MASK(nc->offset, ~align_mask);
>  	if (unlikely(offset + fragsz > size)) {
> -		if (unlikely(fragsz > PAGE_SIZE)) {
> -			/*
> -			 * The caller is trying to allocate a fragment
> -			 * with fragsz > PAGE_SIZE but the cache isn't big
> -			 * enough to satisfy the request, this may
> -			 * happen in low memory conditions.
> -			 * We don't release the cache page because
> -			 * it could make memory pressure worse
> -			 * so we simply return NULL here.
> -			 */
> -			return NULL;
> -		}
> -
>  		page = encoded_page_decode_page(encoded_page);
>  
>  		if (!page_ref_sub_and_test(page, nc->pagecnt_bias))

