Return-Path: <linux-hyperv+bounces-2367-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2354D901D0C
	for <lists+linux-hyperv@lfdr.de>; Mon, 10 Jun 2024 10:38:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A31341F2152A
	for <lists+linux-hyperv@lfdr.de>; Mon, 10 Jun 2024 08:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 188316F2E3;
	Mon, 10 Jun 2024 08:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UE4CD9OV"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D8CF558A0
	for <linux-hyperv@vger.kernel.org>; Mon, 10 Jun 2024 08:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718008699; cv=none; b=qba6+J+movwGRC2K1Lju+jo7jcF85VIEzC2ev54/xVAsgst5fT+0wBjaSsTRvHIOZ81PjbPA8/KHGXWfbl5AlijfQp8Vu4EjW4qcQDuSjoY/+DWawURtx9csArUFJ2v/KB2JjuDmNvP3kfdN+tqcS/hwo//MXiXUahWe1NGTI2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718008699; c=relaxed/simple;
	bh=PKzZA1Tyb9IrkR6CjttNB5iU/gycey9RVJ7xg2XmZls=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=olJ11QSZRsJ4mbWmAcyaSshvabfNjt/P/4MvwenYfcP8I8S+4HwMQbpapcGx2HnG60QHnXbI9+3YV82wCd62ROPgEdBB9j+coA5y80DzDozdlQn6vw2vrlm9uETlBqW14yhQy19tjX7XiYyeeMfwnLnW8t0gYwjCzTSth+W0Mkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UE4CD9OV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718008696;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=w6nrbStgbGoljYTouWdcfenV64/6o+i5+It1jT8aCEg=;
	b=UE4CD9OVImDXlHksw9I1TO1/shRLrWjqatsnj7QBIqruNUpOf8/8+Fk7wAgq45I/18qy/X
	KHkUjmIXFOIY9TKVnPhFMo487JzFSLMkRUWNAnQtb2RGHxyc9R4ZfU+JViqEIekbz/dce5
	BubQOdjatzKfmEKPvf351JJQi+i3feg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-118-Kprg8v6MMcW4iKxzfQZboA-1; Mon, 10 Jun 2024 04:38:09 -0400
X-MC-Unique: Kprg8v6MMcW4iKxzfQZboA-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-35f1ddd8a47so594732f8f.3
        for <linux-hyperv@vger.kernel.org>; Mon, 10 Jun 2024 01:38:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718008688; x=1718613488;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=w6nrbStgbGoljYTouWdcfenV64/6o+i5+It1jT8aCEg=;
        b=Da/cEUEFX7mvVokbW2a4VtDsgvOEqx8H1+zfwIX03q7b3xE8p82b5XtGHia4ogGRT+
         8FhvYjOwu3StMANV63jsCoA+AwnctmRU+SUN6lqd9jQpjQ0UQmLuYNuxHYFjMznIK2ax
         9bpxgnnkNp8X6GCi6T8VUIC49Q3LFn9owyr4FncRg+bVqXKHzn/E3V5fOrtO6rkmJuq6
         wAwLLCY02IGbpPO28qVMGg+Mj5ALPr+rC58a3GRSA/f0/LQBB5nY265jBbQQjC/Av7ii
         Kgn7BZynHE08ZwMw9fZINY4/lHfG0xFyvzqkxMTh0fReYSvkpRNd5HHRVzkCARHp3zHl
         F8GA==
X-Forwarded-Encrypted: i=1; AJvYcCXrJQC8jfhrleQ1k2kDOcvqm5tqJh1YiG9A5oWfncxD6WXZBFQsOtErNo/sUInoUknqFyvlEPkLjj39EWvDN667KC1Ou7SALAHjNrOh
X-Gm-Message-State: AOJu0Yx0qaZtEdzrugkX+/tyLfiDUVyPeJwkEZvGqCh3dHZRy2I4crnm
	OyKcnbDLkB0G7fOsBwFEP0bor4ZRDOdQP+HW7WM2NhjhdvZTkd8NsbVphKYD07ru5VySFdPrkB4
	ctmSAGjmVzEjHM4W5Qm22uS4LQjvAuqp1N7EI0nwhvi5LGPevI3iJRI01qO9/KQ==
X-Received: by 2002:a5d:5f90:0:b0:35f:22d9:cab3 with SMTP id ffacd0b85a97d-35f22d9cd51mr2249195f8f.36.1718008687504;
        Mon, 10 Jun 2024 01:38:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHXEFywI0gemoc9w1rogNSIeoaxga56ZirfcbsHoHRmzr//4KCG2uOiq+HM1RIZR6Nee59Wpg==
X-Received: by 2002:a5d:5f90:0:b0:35f:22d9:cab3 with SMTP id ffacd0b85a97d-35f22d9cd51mr2249152f8f.36.1718008686974;
        Mon, 10 Jun 2024 01:38:06 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35f29629231sm157912f8f.67.2024.06.10.01.38.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jun 2024 01:38:06 -0700 (PDT)
Message-ID: <13070847-4129-490c-b228-2e52bd77566a@redhat.com>
Date: Mon, 10 Jun 2024 10:38:05 +0200
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/3] mm: pass meminit_context to __free_pages_core()
To: Oscar Salvador <osalvador@suse.de>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-hyperv@vger.kernel.org, virtualization@lists.linux.dev,
 xen-devel@lists.xenproject.org, kasan-dev@googlegroups.com,
 Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>,
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
 <ZmZ7GgwJw4ucPJaM@localhost.localdomain>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <ZmZ7GgwJw4ucPJaM@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10.06.24 06:03, Oscar Salvador wrote:
> On Fri, Jun 07, 2024 at 11:09:36AM +0200, David Hildenbrand wrote:
>> In preparation for further changes, let's teach __free_pages_core()
>> about the differences of memory hotplug handling.
>>
>> Move the memory hotplug specific handling from generic_online_page() to
>> __free_pages_core(), use adjust_managed_page_count() on the memory
>> hotplug path, and spell out why memory freed via memblock
>> cannot currently use adjust_managed_page_count().
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
> 
> All looks good but I am puzzled with something.
> 
>> +	} else {
>> +		/* memblock adjusts totalram_pages() ahead of time. */
>> +		atomic_long_add(nr_pages, &page_zone(page)->managed_pages);
>> +	}
> 
> You say that memblock adjusts totalram_pages ahead of time, and I guess
> you mean in memblock_free_all()

And memblock_free_late(), which uses atomic_long_inc().

> 
>   pages = free_low_memory_core_early()
>   totalram_pages_add(pages);
> 
> but that is not ahead, it looks like it is upading __after__ sending
> them to buddy?

Right (it's suboptimal, but not really problematic so far. Hopefully Wei 
can clean it up and move it in here as well)

For the time being

"/* memblock adjusts totalram_pages() manually. */"

?

Thanks!

-- 
Cheers,

David / dhildenb


