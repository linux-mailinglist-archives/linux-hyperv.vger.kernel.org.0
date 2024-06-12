Return-Path: <linux-hyperv+bounces-2406-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 404A2905B2B
	for <lists+linux-hyperv@lfdr.de>; Wed, 12 Jun 2024 20:38:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B09891F21317
	for <lists+linux-hyperv@lfdr.de>; Wed, 12 Jun 2024 18:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E712B4EB45;
	Wed, 12 Jun 2024 18:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ORYCUpDH"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D7647F6B
	for <linux-hyperv@vger.kernel.org>; Wed, 12 Jun 2024 18:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718217509; cv=none; b=M7r2Y3IShggMF4h3JDMqn19ncMTNgan51ZyenAUd/JzWUDDclF4J3IA44XFXiFU0E+w5Bj1u6Vyoz1xjRrDpjNLvbs2Hf48GoDR1l2P4P+94fDGxRbwWoc5X8wy5zEEhrjgGe15e0CukdJSzGMfA2IFRd5t/RPV3nH48ncvwrvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718217509; c=relaxed/simple;
	bh=da4qQp7q9FRHa14+3H2CymUF4f/YBETTMzj+yV5bx9g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QDLQjmr8wQuUIg+UF3Ws6NW/zklW9Ozn0sasy0e3iLdYzJ6MmGep+vZqSOMMlJb7VFpaAE07NIt6xdK0oYTOHc23Eq3HbpCxEBp9ACRDyumKAcbe3wT3TImcMH/XSyKjjB/R5co26sXdci/On9sWj7kBaN984PJZTH/YcUXV+Ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ORYCUpDH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718217507;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=eHkiYypujAnwSi5QrP8pZu0qQw3cLgJft3y7PW/t9t4=;
	b=ORYCUpDHd7ycd/UMM0kfT657bEQiHayWHOm9X9/YzGVbZJzjFNtWIpK6Dq7HdV+mpr5U2j
	XXxZiLH2vk9K5cw5pVdof+2xchKEY6bFWvoPny2KzpIRNJ4lv/FhkdlRInvps6MIPxnoot
	H4GMilHb5k72hooLgFZlTs7OTsuGXgw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-446-SU4sFziLMluWaa0YW3zHmQ-1; Wed, 12 Jun 2024 14:38:25 -0400
X-MC-Unique: SU4sFziLMluWaa0YW3zHmQ-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-421292df2adso1034165e9.3
        for <linux-hyperv@vger.kernel.org>; Wed, 12 Jun 2024 11:38:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718217504; x=1718822304;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eHkiYypujAnwSi5QrP8pZu0qQw3cLgJft3y7PW/t9t4=;
        b=ZQbZybv1cGaxLP3yuNQ5tW/Cmqc7l07afa0PTYckRIvgjGXCvBFN/ILU10lqborAJh
         K0cNrgNfDMN0MwrcKjuq/ehlLm82cLNhW+MC4TQxqQNe1NXjcdzu0kHzc8AP1k2IQfGW
         33F5/4lsJByeS+WqHERWCosH9stKrnhALgpSvMxZRDFDdpNRr/LOeOQ+kRnQQZyhqtvc
         32XQ6uWxlKTYyZEnsRNqI5xl0ZuEn5RmP7yjGsjStnziEzfL10bPrOd7KIHdvx3xN2gj
         oENjvXwFC6m99FhYIT41np3MyNtkOcoMfF/ag6sANUECqUx0eRCfXYhbQ/QNL9w86N1J
         Ue6g==
X-Forwarded-Encrypted: i=1; AJvYcCVuNcwQJyloqvUoKK/mJUTef2XtOqVq08EhmWxfseo27qtgnJpBtJEN5A6ijQ4Cxy7ZGxogUzXLL0XFywlHRUUKNEqa49Af72ehHVAx
X-Gm-Message-State: AOJu0Yy3qIxljjP8byFcvOkWMm/jC8uZ8s0y2F19HJkvHJfI/tU5CBic
	Ezn4uTBOC47jaNQvdakWJ0HcBuMZhFUSqFvQDsak2WyQpS8wIvpA2zMoUsekwkcx/KuzY6Io8pI
	8P1ZLfpMwwKTP4yVHhbbovT6iBdjGXyR5FR/Qb0uctlP1r4N9TD/0iS8tHkho1Q==
X-Received: by 2002:a05:600c:358b:b0:422:683b:df4d with SMTP id 5b1f17b1804b1-422862aca70mr25635855e9.8.1718217504335;
        Wed, 12 Jun 2024 11:38:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF9c6UnJX0cTtZy9cm2l0blMA61xj4ptfyilK9HIBnbYNBzABHUDtJIhxGr1xkMg1evDFPT+w==
X-Received: by 2002:a05:600c:358b:b0:422:683b:df4d with SMTP id 5b1f17b1804b1-422862aca70mr25635525e9.8.1718217503744;
        Wed, 12 Jun 2024 11:38:23 -0700 (PDT)
Received: from ?IPV6:2003:cb:c702:bf00:abf6:cc3a:24d6:fa55? (p200300cbc702bf00abf6cc3a24d6fa55.dip0.t-ipconnect.de. [2003:cb:c702:bf00:abf6:cc3a:24d6:fa55])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422870f760fsm35980815e9.33.2024.06.12.11.38.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jun 2024 11:38:23 -0700 (PDT)
Message-ID: <ca575956-f0dd-4fb9-a307-6b7621681ed9@redhat.com>
Date: Wed, 12 Jun 2024 20:38:21 +0200
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/3] mm: pass meminit_context to __free_pages_core()
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-hyperv@vger.kernel.org, virtualization@lists.linux.dev,
 xen-devel@lists.xenproject.org, kasan-dev@googlegroups.com,
 Mike Rapoport <rppt@kernel.org>, Oscar Salvador <osalvador@suse.de>,
 "K. Y. Srinivasan" <kys@microsoft.com>,
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
 <2ed64218-7f3b-4302-a5dc-27f060654fe2@redhat.com>
 <20240611121942.050a2215143af0ecb576122f@linux-foundation.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240611121942.050a2215143af0ecb576122f@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11.06.24 21:19, Andrew Morton wrote:
> On Tue, 11 Jun 2024 12:06:56 +0200 David Hildenbrand <david@redhat.com> wrote:
> 
>> On 07.06.24 11:09, David Hildenbrand wrote:
>>> In preparation for further changes, let's teach __free_pages_core()
>>> about the differences of memory hotplug handling.
>>>
>>> Move the memory hotplug specific handling from generic_online_page() to
>>> __free_pages_core(), use adjust_managed_page_count() on the memory
>>> hotplug path, and spell out why memory freed via memblock
>>> cannot currently use adjust_managed_page_count().
>>>
>>> Signed-off-by: David Hildenbrand <david@redhat.com>
>>> ---
>>
>> @Andrew, can you squash the following?
> 
> Sure.
> 
> I queued it against "mm: pass meminit_context to __free_pages_core()",
> not against
> 
>> Subject: [PATCH] fixup: mm/highmem: make nr_free_highpages() return "unsigned
>>    long"
> 

Can you squash the following as well? (hopefully the last fixup, otherwise I
might just resend a v2)


 From 53c8c5834e638b2ae5e2a34fa7d49ce0dcf25192 Mon Sep 17 00:00:00 2001
From: David Hildenbrand <david@redhat.com>
Date: Wed, 12 Jun 2024 20:31:07 +0200
Subject: [PATCH] fixup: mm: pass meminit_context to __free_pages_core()

Let's add the parameter name also in the declaration.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
  mm/internal.h | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/internal.h b/mm/internal.h
index 14bab8a41baf6..254dd907bf9a2 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -605,7 +605,7 @@ extern void __putback_isolated_page(struct page *page, unsigned int order,
  extern void memblock_free_pages(struct page *page, unsigned long pfn,
  					unsigned int order);
  extern void __free_pages_core(struct page *page, unsigned int order,
-		enum meminit_context);
+		enum meminit_context context);
  
  /*
   * This will have no effect, other than possibly generating a warning, if the
-- 
2.45.2


-- 
Cheers,

David / dhildenb


