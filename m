Return-Path: <linux-hyperv+bounces-4187-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4B59A4AB61
	for <lists+linux-hyperv@lfdr.de>; Sat,  1 Mar 2025 14:50:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A4D918977B8
	for <lists+linux-hyperv@lfdr.de>; Sat,  1 Mar 2025 13:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4F7F1DEFF5;
	Sat,  1 Mar 2025 13:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R0fHVrJH"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA881DED51;
	Sat,  1 Mar 2025 13:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740837032; cv=none; b=qLWTwmBwdoTtIvRU9U1uwXcJqvqkWOwaCZMRPMZt7Jbp0LuYnBPE1vYIHbIZRe+qcJp8FeT05rHzjIf1trP/KPjWp2/hWXmtu2uO5VCX/oXWQ6SHc9Ev3e0qSRJen1gfeIcPW8P6z6oPfpU9BWv6tCv0pUZJHMpP+BumDS7Ib40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740837032; c=relaxed/simple;
	bh=ME5xNwEUvmZIhrCna/NGeAum7nG3bjJMPxsf3gI42Bc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ANzOm52PokiTjx1yBkvvsrshBlGP8YG16G0TtWpph9rDf43gNfJkW33oF5nN9t1nweCJ+6yoOrt9tMlDUlTkfpVsD9jMQEDpL3i/KCbmUL80v0q97q6ydWkaYVJvcVIzE9XFTQ9M1P3joYJw2sVMW88b5+guL5l96/jALh52zns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R0fHVrJH; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-22113560c57so59084025ad.2;
        Sat, 01 Mar 2025 05:50:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740837030; x=1741441830; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pJgxQ9kTw71K96V2pNjoEy9ewjLpxCqdEPFpCMMN/U4=;
        b=R0fHVrJH2Ms/6/iKsBK4NeJNQjyIXmFB6B9L4AarEAsS4eZ20pbaFImTy+TkRObknG
         Zf/INMiGF6NJfZS1OhneR48y4QLpc0uM9btq8bFKvA6zkkzS9ydWW3Gj58ZNP76JfoUE
         +eicF6T4hBFsHN5n05K7pVVRAF1jD1GLt/gNsLHfRAecUPCtt40UcWy0NmIxFtOt8Fo3
         n6vqMjRg6tpFoFhcXNPgHbaBewVw+TB+oFGMw/vAn7fbZpqhLwr0cOMQ2nt0YAj6+mGF
         3R6GCZ+BW5bPmVWoaHORgQ6GM5dAX77/cplkZ+AvJXxJgkWFoXNAIpa7jgVs8UjRhuBy
         Rtig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740837030; x=1741441830;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pJgxQ9kTw71K96V2pNjoEy9ewjLpxCqdEPFpCMMN/U4=;
        b=dGMYXNGhvPWID0N6aessuO6+fBR+UgG7+HDDts8sldG1c3Pn8elZPBqyzy254P1nRI
         L5VaVwPJO6qcDwvbYmGt5c2AWKXcfxHkENr1Xznit7J2BSS3yZdtFaIyCuWDAuC4COHo
         2cFQSt+ANRxjbXqhD6I2KS2B2V+rUODDNN9hhhcMqBAuRGFyPRo9Z0Q0XSmKspJiLwxQ
         cYO1k4JCAKWLuqMZg4tzJDyjMZlDG+ngM/zWXE7f4GwdBiq6E8h3sfC+CCDxRnLKFNho
         77T3i/n1wDSOS63bSn+MvCxTuECf55YNYZMqleyPEBMO18K8WheLlmtEdiZ5BIZZgSb4
         YWdA==
X-Forwarded-Encrypted: i=1; AJvYcCVW1sRmtZY25fdaiHE/asicouqQ4d+mbisyV4s1tng6R/bp9lA/VjwTGqOriaofQqJPCY9smZ8W+b0WSXOz@vger.kernel.org, AJvYcCWR6O3z0/p2UsP9323KKWo0Lop2esRIMoQKYnKqNW5NC+yF11oXMqL7ivyACW5GF8fRNQOv2Oms@vger.kernel.org, AJvYcCX7z4RNFIwJhJ+oYKHXD2RaAsM6ZCWNZKcCnb/Gv4FEfsfd4HICVSk+9/f7s4vqy8aDgMfLE1GdRppWx3I=@vger.kernel.org, AJvYcCXUyUaZRc8JiI1vciBBvR/1zrrdbVFC9TDXuDk0o5A5zLN+vo8vOqokirhTEAFTJyjaR3qHnNm9@vger.kernel.org
X-Gm-Message-State: AOJu0YyhxRXvzL4mUvEFqao8JoYToVzf2sIpuL8LR9ALt/x7Fa68pKhL
	6UoJ4NgqMtiVHB7tW2vCg3mNZ7hHbLVY1DFCvgxgzWFhs3iogInD
X-Gm-Gg: ASbGncuPhgaVfc2VGjJBvzwxDTIFzK0DT4EcB8gBQUJiTnVF1oswPEbex/ZFKOsG3Fh
	VUHrL3Z0fUlRyWERk/GtjOrm5gi6bX7IllPj08MOLEzyXjA38pQiyA8y4gJDjK9+b8Nv2dHazbD
	oxiKiQ1UeM18x7bXjEdfgKk5EqNnqTcBOoEXsh9zjWvv7Jsg8LNR0w8CG2Vqmi1KUbDdQ+Ed+R6
	S3sBrI6ONYYCDNsEYsOJqlew2imWsLE7DaHVIxqDEWiXGWd+O6bu/6SDX+UUfM1IgsACmiEJDel
	kuLQYUlJmtfHJuSeAGP+vII8RACNTnidN9JAgevyEPv5G5up3zHJOhbuUH/TYxs6zi7VxRowKnD
	A5A9FPT0sV22rVnmL0OZ9uP/AMafsdEKK
X-Google-Smtp-Source: AGHT+IHaL4hbyWgR+iPuNLWB5nxuPIRAPj7rx5fVWakRllPjjwrCtFNjMmeB9yAzirq0UbQe6nIUbQ==
X-Received: by 2002:a17:902:fc87:b0:223:6744:bfb9 with SMTP id d9443c01a7336-22369247768mr116255305ad.41.1740837030212;
        Sat, 01 Mar 2025 05:50:30 -0800 (PST)
Received: from ?IPV6:2409:8a55:301b:e120:3c9b:1380:5d8c:26d0? ([2409:8a55:301b:e120:3c9b:1380:5d8c:26d0])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2235052005fsm48280085ad.227.2025.03.01.05.50.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Mar 2025 05:50:29 -0800 (PST)
Message-ID: <cc3034c6-2589-4e9a-97af-a7879998d7d8@gmail.com>
Date: Sat, 1 Mar 2025 21:49:55 +0800
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: page_frag: Fix refill handling in
 __page_frag_alloc_align()
To: Haiyang Zhang <haiyangz@microsoft.com>, linux-hyperv@vger.kernel.org,
 akpm@linux-foundation.org, linux-mm@kvack.org
Cc: decui@microsoft.com, kys@microsoft.com, paulros@microsoft.com,
 olaf@aepfle.de, vkuznets@redhat.com, davem@davemloft.net,
 wei.liu@kernel.org, longli@microsoft.com, linux-kernel@vger.kernel.org,
 linyunsheng@huawei.com, stable@vger.kernel.org, netdev@vger.kernel.org,
 Alexander Duyck <alexander.duyck@gmail.com>
References: <1740794613-30500-1-git-send-email-haiyangz@microsoft.com>
Content-Language: en-US
From: Yunsheng Lin <yunshenglin0825@gmail.com>
In-Reply-To: <1740794613-30500-1-git-send-email-haiyangz@microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

+cc netdev ML & Alexander

On 3/1/2025 10:03 AM, Haiyang Zhang wrote:
> In commit 8218f62c9c9b ("mm: page_frag: use initial zero offset for
> page_frag_alloc_align()"), the check for fragsz is moved earlier.
> So when the cache is used up, and if the fragsz > PAGE_SIZE, it won't
> try to refill, and just return NULL.
> I tested it with fragsz:8192, cache-size:32768. After the initial four
> successful allocations, it failed, even there is plenty of free memory
> in the system.

Hi, Haiyang
It seems the PAGE_SIZE is 4K for the tested system?
Which drivers or subsystems are passing the fragsz being bigger than
PAGE_SIZE to page_frag_alloc_align() related API?

> To fix, revert the refill logic like before: the refill is attempted
> before the check & return NULL.

page_frag API is not really for allocating memory being bigger than
PAGE_SIZE as __page_frag_cache_refill() will not try hard enough to
allocate order 3 compound page when calling __alloc_pages() and will
fail back to allocate base page as the discussed in below:
https://lore.kernel.org/all/ead00fb7-8538-45b3-8322-8a41386e7381@huawei.com/

> 
> Cc: linyunsheng@huawei.com
> Cc: stable@vger.kernel.org
> Fixes: 8218f62c9c9b ("mm: page_frag: use initial zero offset for page_frag_alloc_align()")
> Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
> ---
>   mm/page_frag_cache.c | 26 +++++++++++++-------------
>   1 file changed, 13 insertions(+), 13 deletions(-)
> 
> diff --git a/mm/page_frag_cache.c b/mm/page_frag_cache.c
> index d2423f30577e..82935d7e53de 100644
> --- a/mm/page_frag_cache.c
> +++ b/mm/page_frag_cache.c
> @@ -119,19 +119,6 @@ void *__page_frag_alloc_align(struct page_frag_cache *nc,
>   	size = PAGE_SIZE << encoded_page_decode_order(encoded_page);
>   	offset = __ALIGN_KERNEL_MASK(nc->offset, ~align_mask);
>   	if (unlikely(offset + fragsz > size)) {
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
>   		page = encoded_page_decode_page(encoded_page);
>   
>   		if (!page_ref_sub_and_test(page, nc->pagecnt_bias))
> @@ -149,6 +136,19 @@ void *__page_frag_alloc_align(struct page_frag_cache *nc,
>   		/* reset page count bias and offset to start of new frag */
>   		nc->pagecnt_bias = PAGE_FRAG_CACHE_MAX_SIZE + 1;
>   		offset = 0;
> +
> +		if (unlikely(fragsz > size)) {
> +			/*
> +			 * The caller is trying to allocate a fragment
> +			 * with fragsz > size but the cache isn't big
> +			 * enough to satisfy the request, this may
> +			 * happen in low memory conditions.
> +			 * We don't release the cache page because
> +			 * it could make memory pressure worse
> +			 * so we simply return NULL here.
> +			 */
> +			return NULL;
> +		}
>   	}
>   
>   	nc->pagecnt_bias--;


