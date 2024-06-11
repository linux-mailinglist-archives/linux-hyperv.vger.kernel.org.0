Return-Path: <linux-hyperv+bounces-2381-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E1BE90385F
	for <lists+linux-hyperv@lfdr.de>; Tue, 11 Jun 2024 12:07:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD295B21197
	for <lists+linux-hyperv@lfdr.de>; Tue, 11 Jun 2024 10:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C418A1779BD;
	Tue, 11 Jun 2024 10:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J5bglAl2"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DCDD156E4
	for <linux-hyperv@vger.kernel.org>; Tue, 11 Jun 2024 10:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718100424; cv=none; b=BW5HOOp9gozvJz18RsGQ9P9QggGM4nedRhcQNroj+Ka/tDCe7R8ksHL8TDq94mmhOTxVDnr1VtlRUXeJMAzHou30my4Om5JwfZ3XMyJbzKtKGFMGnTagRfq5JM+Umxirklg8KBqPmn5lsQAHqOcUSTdzrPZVfyKsodeFhi5qX7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718100424; c=relaxed/simple;
	bh=pzWOboj2SdczWO97ibV1x/fRKpOO+i16TZis1aetObU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pLZl3h/bQCYpSBfkE61sJSDWQIRIOOBgeTR/gXD2C3eiwvyFfId9ua0XVX5dH++fmxohWlVMkRGf8uX0QQQjsCPiIDUI6ZaVZ6NBNuiA6MpgYcVSO4sRHakkWgWv4YGrLR16Z9jCasY20t7imQw0hRYix/qrX497vFFmYz/GRa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J5bglAl2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718100422;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=F/H/c4fGsFUdJRDofZpCfuHa+2bAf+RkO1DuZv3WdgI=;
	b=J5bglAl2hbB6QyihHx/iMZNYmTt9BOqhSfI+fqWpV3xws3ysg0Pe1Ph7nSdR+HbvLfoBCf
	GSrF+C8pzOS5Ww554eN9YO9HVwDDH2qEmzc3oOztT+LBQotUByMaP96537Nr4F13c0bEyv
	SRxWoiSXL9N+hoKxBMqYZbolEsRSwA0=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-GCcrY7qbOSu_Jpi7gNn7iw-1; Tue, 11 Jun 2024 06:07:00 -0400
X-MC-Unique: GCcrY7qbOSu_Jpi7gNn7iw-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2eb6f6b1b2dso24544751fa.0
        for <linux-hyperv@vger.kernel.org>; Tue, 11 Jun 2024 03:07:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718100419; x=1718705219;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=F/H/c4fGsFUdJRDofZpCfuHa+2bAf+RkO1DuZv3WdgI=;
        b=nE0lDDGGnsZhdEz1jYxSD30wLRZJ9fQ+9CH/Tbr3TJ8LG69OxFAV4OQUSdjEFmxdZH
         PLTD+SotzPhi1EtnmZGkbXEECsZYWAzsBBLds8K4Y7WQIbLpv/cCiE/Ywc8f0oqczE48
         SroqPCIJQBjWTq6WkD15MqHkxYdLpUTG0uXQTWz85Bxgw3KkWPRKUPdB7cpwg4xsMhIy
         wpf2IQA4IURpv0QfirlR+mKhMRZgZRoDK7jIhUeQGmbvfv20fDGGBNecUgDa8wgseIfv
         N8FOG3LuQs8xjynevTYRzZOmnfxBIXgvXAZFBxuXmdeA9fWTw7rSh9wXIu/ALw2OTLgn
         /V9g==
X-Forwarded-Encrypted: i=1; AJvYcCVHcdYzdb2BY3Ga9Hh9jJJhW6m+i8exA6jK7GMaPTAd/EuriZYNX9QE7Xq83x/+kP2sY1ge+wwfqJ3a2rZH3R3fhchco3gN/0yYNleZ
X-Gm-Message-State: AOJu0Yxa/7EguRftvuBF0oRgNFwflnxg5ViQ8yeqVOgu0rOLf7p37lmN
	YW7aNxH2Lr8H6Yquuo4NpcYb0Zcnu2x31egDlXqpUh+Nu0BKBwb3j+MMK6BKkwfEJBHFC0Ik2Mt
	Rm7Z2ZusqLi0NyYgpgMx8YvqycvP9GXZYy015adQl3n0zdJm0uo17vMsti+X99A==
X-Received: by 2002:a2e:908e:0:b0:2eb:ee64:1e19 with SMTP id 38308e7fff4ca-2ebee641fb3mr18566681fa.42.1718100418969;
        Tue, 11 Jun 2024 03:06:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFTPfn39pFW+4UY1ixf2NXkOeipXmnEb8MezD4IOdN3tIhaG3lKM4bAlWBQ/Nnh1BIsuQ/pCw==
X-Received: by 2002:a2e:908e:0:b0:2eb:ee64:1e19 with SMTP id 38308e7fff4ca-2ebee641fb3mr18566441fa.42.1718100418548;
        Tue, 11 Jun 2024 03:06:58 -0700 (PDT)
Received: from ?IPV6:2003:cb:c748:ba00:1c00:48ea:7b5a:c12b? (p200300cbc748ba001c0048ea7b5ac12b.dip0.t-ipconnect.de. [2003:cb:c748:ba00:1c00:48ea:7b5a:c12b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-421818907b6sm86762715e9.27.2024.06.11.03.06.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jun 2024 03:06:57 -0700 (PDT)
Message-ID: <2ed64218-7f3b-4302-a5dc-27f060654fe2@redhat.com>
Date: Tue, 11 Jun 2024 12:06:56 +0200
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/3] mm: pass meminit_context to __free_pages_core()
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-hyperv@vger.kernel.org,
 virtualization@lists.linux.dev, xen-devel@lists.xenproject.org,
 kasan-dev@googlegroups.com, Mike Rapoport <rppt@kernel.org>,
 Oscar Salvador <osalvador@suse.de>, "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Juergen Gross <jgross@suse.com>, Stefano Stabellini
 <sstabellini@kernel.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>,
 Dmitry Vyukov <dvyukov@google.com>
References: <20240607090939.89524-1-david@redhat.com>
 <20240607090939.89524-2-david@redhat.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240607090939.89524-2-david@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 07.06.24 11:09, David Hildenbrand wrote:
> In preparation for further changes, let's teach __free_pages_core()
> about the differences of memory hotplug handling.
> 
> Move the memory hotplug specific handling from generic_online_page() to
> __free_pages_core(), use adjust_managed_page_count() on the memory
> hotplug path, and spell out why memory freed via memblock
> cannot currently use adjust_managed_page_count().
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---

@Andrew, can you squash the following?

 From 0a7921cf21cacf178ca7485da0138fc38a97a28e Mon Sep 17 00:00:00 2001
From: David Hildenbrand <david@redhat.com>
Date: Tue, 11 Jun 2024 12:05:09 +0200
Subject: [PATCH] fixup: mm/highmem: make nr_free_highpages() return "unsigned
  long"

Fixup the memblock comment.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
  mm/page_alloc.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index e0c8a8354be36..fc53f96db58a2 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1245,7 +1245,7 @@ void __free_pages_core(struct page *page, unsigned int order,
  		debug_pagealloc_map_pages(page, nr_pages);
  		adjust_managed_page_count(page, nr_pages);
  	} else {
-		/* memblock adjusts totalram_pages() ahead of time. */
+		/* memblock adjusts totalram_pages() manually. */
  		atomic_long_add(nr_pages, &page_zone(page)->managed_pages);
  	}
  
-- 
2.45.2



-- 
Cheers,

David / dhildenb


