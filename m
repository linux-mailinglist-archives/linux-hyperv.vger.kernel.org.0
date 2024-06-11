Return-Path: <linux-hyperv+bounces-2379-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44F339034BF
	for <lists+linux-hyperv@lfdr.de>; Tue, 11 Jun 2024 10:04:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF291282928
	for <lists+linux-hyperv@lfdr.de>; Tue, 11 Jun 2024 08:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EABDB171082;
	Tue, 11 Jun 2024 08:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="biL/kLWJ"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA842AF11
	for <linux-hyperv@vger.kernel.org>; Tue, 11 Jun 2024 08:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718093069; cv=none; b=VWjpq0aub3Vp1xO7xC9A2w1jO8thdOQtJ/ZV6rSvU/YPBl3UaFTn77w+kZX90tokQaz+dl5dZSChznWrSue4vEi7GxbfYlBbHfSlMjoyMMhTn2tOq6amsWzBBvw8eLanJpZXwiJG8kA6peUtOkcuDwmlV/Nj6YCwwIep8A1JHE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718093069; c=relaxed/simple;
	bh=IGkPU0Scjshr8UBWNnXfhsHmwWKbEoHOCDVcv+syyFo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IS9EBrEpJowFNZ/3WrJexdCdVYMvEQyNI0ahpzovVA6IT5i+aEX6OkAsCqwpGNM3L3UJNEVBUC7f8d8QtcUPQRblbkhzAXQ23kSkdZZjpN6CPefvwyxP3/E3Yt2QI1YEeOJ/DuO43Za6pDcIOgJ2gZ9kU/AhebddJEJ4Slr/6qE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=biL/kLWJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718093066;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=hqXBYKFMfHuGo/oWXFTKDIQ0hmdU9g1oFp9QTADLe9k=;
	b=biL/kLWJMREardvu7DxoxdJPKP8nyhEAn50y/PXX9p4/Tf5z5GSQ3nQSjIT/HieiLPJlTK
	tvxjF1g4UYB+wSNCAXxwTWZRvymwp5xSqYed2cnm/GM4yzlDWm2nEIdb5830XjvOU6sXSW
	9vHmaa6Y0i4DmX8P5stZ3KY0bJ6hVwQ=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-IQsCM4XdPjuv0g5buBTvRQ-1; Tue, 11 Jun 2024 04:04:19 -0400
X-MC-Unique: IQsCM4XdPjuv0g5buBTvRQ-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2eae96cecaeso30962441fa.2
        for <linux-hyperv@vger.kernel.org>; Tue, 11 Jun 2024 01:04:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718093058; x=1718697858;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hqXBYKFMfHuGo/oWXFTKDIQ0hmdU9g1oFp9QTADLe9k=;
        b=r1vwgKrWxS0rZfCd8ozBjjdvgsja2RwDShdKlFxrQmGNiCyeKi1BLZxz2YrOCwm0V8
         Xnriv78FcGEqmzsuaCp5oUN5SwU1itZ7glKbvf2Y1/+TzUqhiBGJbAo8L1/cBHX7Ha2N
         leYZ1l8WleS7KCe8eJnldmzQqDutE3YSfmgguu/qzFMGRLk7Ow/hOHQ3fTvmqaU4bBrk
         qV6xfGwVKDMXg/PPZkIqwgYlhNTHfkgKQV4f+MT1bfQuiSdROXp1wR01m6Vlj4Wv7DPL
         zEWdx1q8xA0jZggE/ezPjHevK5S6Xat4R+naQMSFjT7bDdjDLkpVW8xSWJbCAnOsvKkA
         fsGg==
X-Forwarded-Encrypted: i=1; AJvYcCVH31E0TaD5CMPY5XD8h0hdCcK3UfKI4E1fUFMuU2OIIuYCaaNmjbDVxyyImfHbHEZg2pNtiSy67TKKz54XpjIkhhcl1991IsW1+Cm3
X-Gm-Message-State: AOJu0YyaV7lKgWCfBVBSlnvVgZeBA8pYrFByQSsVJTSvRnhiRK9sEm5P
	i3bRFScPM7WHcbMKjP8ijS01o53xtQRK1jV9OyqRsn5a7YaS2tpMBnb/+9wSdw9UtQveUglT26G
	EyobZNUuDbYDr/PO3OKGDxtzab1XLySMQiLZ+dL8eZ8wQ2Ld6CbwH9md09vrq+A==
X-Received: by 2002:a2e:87cb:0:b0:2eb:f82a:d8d2 with SMTP id 38308e7fff4ca-2ebf82adfe7mr159561fa.41.1718093058330;
        Tue, 11 Jun 2024 01:04:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFKToayglVvfmqXbbZxIgMw6bY+YaaS9CFQLQWFoPjFHVHH1W6TdHfgwTXUw4yHKqwXuMGUGQ==
X-Received: by 2002:a2e:87cb:0:b0:2eb:f82a:d8d2 with SMTP id 38308e7fff4ca-2ebf82adfe7mr159231fa.41.1718093057647;
        Tue, 11 Jun 2024 01:04:17 -0700 (PDT)
Received: from ?IPV6:2003:cb:c748:ba00:1c00:48ea:7b5a:c12b? (p200300cbc748ba001c0048ea7b5ac12b.dip0.t-ipconnect.de. [2003:cb:c748:ba00:1c00:48ea:7b5a:c12b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42182ed2b23sm75337235e9.18.2024.06.11.01.04.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jun 2024 01:04:17 -0700 (PDT)
Message-ID: <30b5d493-b7c2-4e63-86c1-dcc73d21dc15@redhat.com>
Date: Tue, 11 Jun 2024 10:04:15 +0200
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/3] mm/memory_hotplug: initialize memmap of
 !ZONE_DEVICE with PageOffline() instead of PageReserved()
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
 <20240607090939.89524-3-david@redhat.com>
 <ZmZ_3Xc7fdrL1R15@localhost.localdomain>
 <5d9583e1-3374-437d-8eea-6ab1e1400a30@redhat.com>
 <ZmgAsolx7SAHeDW7@localhost.localdomain>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 xsFNBFXLn5EBEAC+zYvAFJxCBY9Tr1xZgcESmxVNI/0ffzE/ZQOiHJl6mGkmA1R7/uUpiCjJ
 dBrn+lhhOYjjNefFQou6478faXE6o2AhmebqT4KiQoUQFV4R7y1KMEKoSyy8hQaK1umALTdL
 QZLQMzNE74ap+GDK0wnacPQFpcG1AE9RMq3aeErY5tujekBS32jfC/7AnH7I0v1v1TbbK3Gp
 XNeiN4QroO+5qaSr0ID2sz5jtBLRb15RMre27E1ImpaIv2Jw8NJgW0k/D1RyKCwaTsgRdwuK
 Kx/Y91XuSBdz0uOyU/S8kM1+ag0wvsGlpBVxRR/xw/E8M7TEwuCZQArqqTCmkG6HGcXFT0V9
 PXFNNgV5jXMQRwU0O/ztJIQqsE5LsUomE//bLwzj9IVsaQpKDqW6TAPjcdBDPLHvriq7kGjt
 WhVhdl0qEYB8lkBEU7V2Yb+SYhmhpDrti9Fq1EsmhiHSkxJcGREoMK/63r9WLZYI3+4W2rAc
 UucZa4OT27U5ZISjNg3Ev0rxU5UH2/pT4wJCfxwocmqaRr6UYmrtZmND89X0KigoFD/XSeVv
 jwBRNjPAubK9/k5NoRrYqztM9W6sJqrH8+UWZ1Idd/DdmogJh0gNC0+N42Za9yBRURfIdKSb
 B3JfpUqcWwE7vUaYrHG1nw54pLUoPG6sAA7Mehl3nd4pZUALHwARAQABzSREYXZpZCBIaWxk
 ZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT7CwZgEEwEIAEICGwMGCwkIBwMCBhUIAgkKCwQW
 AgMBAh4BAheAAhkBFiEEG9nKrXNcTDpGDfzKTd4Q9wD/g1oFAl8Ox4kFCRKpKXgACgkQTd4Q
 9wD/g1oHcA//a6Tj7SBNjFNM1iNhWUo1lxAja0lpSodSnB2g4FCZ4R61SBR4l/psBL73xktp
 rDHrx4aSpwkRP6Epu6mLvhlfjmkRG4OynJ5HG1gfv7RJJfnUdUM1z5kdS8JBrOhMJS2c/gPf
 wv1TGRq2XdMPnfY2o0CxRqpcLkx4vBODvJGl2mQyJF/gPepdDfcT8/PY9BJ7FL6Hrq1gnAo4
 3Iv9qV0JiT2wmZciNyYQhmA1V6dyTRiQ4YAc31zOo2IM+xisPzeSHgw3ONY/XhYvfZ9r7W1l
 pNQdc2G+o4Di9NPFHQQhDw3YTRR1opJaTlRDzxYxzU6ZnUUBghxt9cwUWTpfCktkMZiPSDGd
 KgQBjnweV2jw9UOTxjb4LXqDjmSNkjDdQUOU69jGMUXgihvo4zhYcMX8F5gWdRtMR7DzW/YE
 BgVcyxNkMIXoY1aYj6npHYiNQesQlqjU6azjbH70/SXKM5tNRplgW8TNprMDuntdvV9wNkFs
 9TyM02V5aWxFfI42+aivc4KEw69SE9KXwC7FSf5wXzuTot97N9Phj/Z3+jx443jo2NR34XgF
 89cct7wJMjOF7bBefo0fPPZQuIma0Zym71cP61OP/i11ahNye6HGKfxGCOcs5wW9kRQEk8P9
 M/k2wt3mt/fCQnuP/mWutNPt95w9wSsUyATLmtNrwccz63XOwU0EVcufkQEQAOfX3n0g0fZz
 Bgm/S2zF/kxQKCEKP8ID+Vz8sy2GpDvveBq4H2Y34XWsT1zLJdvqPI4af4ZSMxuerWjXbVWb
 T6d4odQIG0fKx4F8NccDqbgHeZRNajXeeJ3R7gAzvWvQNLz4piHrO/B4tf8svmRBL0ZB5P5A
 2uhdwLU3NZuK22zpNn4is87BPWF8HhY0L5fafgDMOqnf4guJVJPYNPhUFzXUbPqOKOkL8ojk
 CXxkOFHAbjstSK5Ca3fKquY3rdX3DNo+EL7FvAiw1mUtS+5GeYE+RMnDCsVFm/C7kY8c2d0G
 NWkB9pJM5+mnIoFNxy7YBcldYATVeOHoY4LyaUWNnAvFYWp08dHWfZo9WCiJMuTfgtH9tc75
 7QanMVdPt6fDK8UUXIBLQ2TWr/sQKE9xtFuEmoQGlE1l6bGaDnnMLcYu+Asp3kDT0w4zYGsx
 5r6XQVRH4+5N6eHZiaeYtFOujp5n+pjBaQK7wUUjDilPQ5QMzIuCL4YjVoylWiBNknvQWBXS
 lQCWmavOT9sttGQXdPCC5ynI+1ymZC1ORZKANLnRAb0NH/UCzcsstw2TAkFnMEbo9Zu9w7Kv
 AxBQXWeXhJI9XQssfrf4Gusdqx8nPEpfOqCtbbwJMATbHyqLt7/oz/5deGuwxgb65pWIzufa
 N7eop7uh+6bezi+rugUI+w6DABEBAAHCwXwEGAEIACYCGwwWIQQb2cqtc1xMOkYN/MpN3hD3
 AP+DWgUCXw7HsgUJEqkpoQAKCRBN3hD3AP+DWrrpD/4qS3dyVRxDcDHIlmguXjC1Q5tZTwNB
 boaBTPHSy/Nksu0eY7x6HfQJ3xajVH32Ms6t1trDQmPx2iP5+7iDsb7OKAb5eOS8h+BEBDeq
 3ecsQDv0fFJOA9ag5O3LLNk+3x3q7e0uo06XMaY7UHS341ozXUUI7wC7iKfoUTv03iO9El5f
 XpNMx/YrIMduZ2+nd9Di7o5+KIwlb2mAB9sTNHdMrXesX8eBL6T9b+MZJk+mZuPxKNVfEQMQ
 a5SxUEADIPQTPNvBewdeI80yeOCrN+Zzwy/Mrx9EPeu59Y5vSJOx/z6OUImD/GhX7Xvkt3kq
 Er5KTrJz3++B6SH9pum9PuoE/k+nntJkNMmQpR4MCBaV/J9gIOPGodDKnjdng+mXliF3Ptu6
 3oxc2RCyGzTlxyMwuc2U5Q7KtUNTdDe8T0uE+9b8BLMVQDDfJjqY0VVqSUwImzTDLX9S4g/8
 kC4HRcclk8hpyhY2jKGluZO0awwTIMgVEzmTyBphDg/Gx7dZU1Xf8HFuE+UZ5UDHDTnwgv7E
 th6RC9+WrhDNspZ9fJjKWRbveQgUFCpe1sa77LAw+XFrKmBHXp9ZVIe90RMe2tRL06BGiRZr
 jPrnvUsUUsjRoRNJjKKA/REq+sAnhkNPPZ/NNMjaZ5b8Tovi8C0tmxiCHaQYqj7G2rgnT0kt
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <ZmgAsolx7SAHeDW7@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11.06.24 09:45, Oscar Salvador wrote:
> On Mon, Jun 10, 2024 at 10:56:02AM +0200, David Hildenbrand wrote:
>> There are fortunately not that many left.
>>
>> I'd even say marking them (vmemmap) reserved is more wrong than right: note
>> that ordinary vmemmap pages after memory hotplug are not reserved! Only
>> bootmem should be reserved.
> 
> Ok, that is a very good point that I missed.
> I thought that hotplugged-vmemmap pages (not selfhosted) were marked as
> Reserved, that is why I thought this would be inconsistent.
> But then, if that is the case, I think we are safe as kernel can already
> encounter vmemmap pages that are not reserved and it deals with them
> somehow.
> 
>> Let's take at the relevant core-mm ones (arch stuff is mostly just for MMIO
>> remapping)
>>
> ...
>> Any PageReserved user that I am missing, or why we should handle these
>> vmemmap pages differently than the ones allocated during ordinary memory
>> hotplug?
> 
> No, I cannot think of a reason why normal vmemmap pages should behave
> different than self-hosted.
> 
> I was also confused because I thought that after this change
> pfn_to_online_page() would be different for self-hosted vmemmap pages,
> because I thought that somehow we relied on PageOffline(), but it is not
> the case.

Fortunately not :) PageFakeOffline() or PageLogicallyOffline()  might be 
clearer, but I don't quite like these names. If you have a good idea, 
please let me know.

> 
>> In the future, we might want to consider using a dedicated page type for
>> them, so we can stop using a bit that doesn't allow to reliably identify
>> them. (we should mark all vmemmap with that type then)
> 
> Yes, a all-vmemmap pages type would be a good thing, so we do not have
> to special case.
> 
> Just one last thing.
> Now self-hosted vmemmap pages will have the PageOffline cleared, and that
> will still remain after the memory-block they belong to has gone
> offline, which is ok because those vmemmap pages lay around until the
> chunk of memory gets removed.

Yes, and that memmap might even get poisoned in debug kernels to catch 
any wrong access.

> 
> Ok, just wanted to convince myself that there will no be surprises.
> 
> Thanks David for claryfing.

Thanks for the review and raising that. I'll add more details to the 
patch description!

-- 
Cheers,

David / dhildenb


