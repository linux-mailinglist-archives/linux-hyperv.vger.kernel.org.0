Return-Path: <linux-hyperv+bounces-2395-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D84F90453A
	for <lists+linux-hyperv@lfdr.de>; Tue, 11 Jun 2024 21:51:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4475282A46
	for <lists+linux-hyperv@lfdr.de>; Tue, 11 Jun 2024 19:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 103491527A2;
	Tue, 11 Jun 2024 19:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D2u31ezr"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E25C11514C9
	for <linux-hyperv@vger.kernel.org>; Tue, 11 Jun 2024 19:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718135460; cv=none; b=p3VfrR5QbxM1k/8SbuSgji2Qljcn/TmPaiVAwMqbPUiZsVwYwuMyh26gTyOR4IcwXZtrlGLYOFjJnPsKKeQ/socdJNSOUuHBwEOQt9DXEhjbtGQ+XCe1B7KWJClNcFBPxXuEcDsDFddpc2hVJYKj3a+NrznlIoneiaX9P1qcgLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718135460; c=relaxed/simple;
	bh=tLhF0gzIDb0MMKkTBdWoOAVCCwxF0E4J4wjD9vy2SBU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JATSjEFOjADfZCqDdMTHz4tsyQZEzxcUUjcIjLDtTAGfFbDEnsKe6mRrQenl9kWnodghTqODTZ7dpjFBOzNgBsso9cZYUNvaUJWFyU27Jqnx+CKXjPwKzx7jRL9cCGiEyn/vjebYaZFNoumREXA1GNCHb+nptrjeIGA9ladiJbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D2u31ezr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718135458;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=VC/FKQpyiv8QuT0prkiboQ+mv2U8+abllOC5cV7bqrg=;
	b=D2u31ezrnjgBAxp9J5QUBXEJ2kRFoMpc/7lLHczFAjU1hGqhn+zqpRUY9wcez5yHHpyIoq
	SUlQA6GbwwfFEPcN+DAPdH09MqZrhU2zd1/RpSoAPxMkQJxaIoMr8ub25Qnur8m2mEintn
	4Q17pTcH6OBsjm0kNt861gvcPgQbZjg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-10ZCTVCOPXmyhYQWgkBgYw-1; Tue, 11 Jun 2024 15:50:56 -0400
X-MC-Unique: 10ZCTVCOPXmyhYQWgkBgYw-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-421eed70e30so17815905e9.1
        for <linux-hyperv@vger.kernel.org>; Tue, 11 Jun 2024 12:50:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718135455; x=1718740255;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VC/FKQpyiv8QuT0prkiboQ+mv2U8+abllOC5cV7bqrg=;
        b=TzUcnBj3oDKSvejwIjoBqXSWWCpkTfEOAqYBeAAjvL6mAx1Jau8UcEMbPdE6gKvriO
         1c4INSNGEi0uSd1B5MJgKGLlP6VRpFyg+eXEVWZAEw3PVGEO0wTmSW8DqPsDBIrhfVhD
         SFg5jMjeip1bBYENczU2YtHVq0UvgtPaF/H57bW6DmdZPiuCOSXPRJQLyMzRRoVU+DXr
         vBZToRN2kl7UiG5m9VxNSgKh089pgtNMeYCCIpy48wwpnqN70WIFC8DGUxnKyh0s5Jwh
         LnALVNmT5p3stWWZaAmsnx69SiTvsNP/ZdhotMmRABxceE8K0uVUbGk8LuZK7WUKEs+p
         PlOA==
X-Forwarded-Encrypted: i=1; AJvYcCUmcNXGUf0hMzNbZp3IMg+eHTDrvLMGspju4h55YSxHtOk/vYAUHVA93O5uc4KeO4bmKL8NeN3qtSvwwHXeFHq6NFG5R/WzOfe7PvxH
X-Gm-Message-State: AOJu0YwSOYQxQi6KGuQnNgjhwELmxO0B7oIp8OpXICsUrn8xjLZuS5YM
	IM4ToJIz+TZpWFTOskHHXoKFPNc/Eu7BdwJqGcpCILGhDld7TcXTLI5d+9NxuPpVmngYHW0Quvt
	c5TM0kDp20GdkylZbZy0bVOF54hdgwbaWyGXpU16cafpmg2V/cgJmOnKYeG/fZQ==
X-Received: by 2002:a05:600c:1c91:b0:421:8028:a507 with SMTP id 5b1f17b1804b1-4218028a5f6mr70330515e9.18.1718135455371;
        Tue, 11 Jun 2024 12:50:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEeIZw5rvJCb1LtW+k52Hf6likkqbQ5y9zsOlyQgFY0I2VYm+kIPKpawNjMsNjEje9W3JPASg==
X-Received: by 2002:a05:600c:1c91:b0:421:8028:a507 with SMTP id 5b1f17b1804b1-4218028a5f6mr70330165e9.18.1718135454911;
        Tue, 11 Jun 2024 12:50:54 -0700 (PDT)
Received: from ?IPV6:2003:cb:c748:ba00:1c00:48ea:7b5a:c12b? (p200300cbc748ba001c0048ea7b5ac12b.dip0.t-ipconnect.de. [2003:cb:c748:ba00:1c00:48ea:7b5a:c12b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42274379b83sm16254225e9.28.2024.06.11.12.50.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jun 2024 12:50:54 -0700 (PDT)
Message-ID: <fff6e4d3-4a11-4481-b28c-edfb072daf35@redhat.com>
Date: Tue, 11 Jun 2024 21:50:52 +0200
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/3] mm: pass meminit_context to __free_pages_core()
To: Tim Chen <tim.c.chen@linux.intel.com>, linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, linux-hyperv@vger.kernel.org,
 virtualization@lists.linux.dev, xen-devel@lists.xenproject.org,
 kasan-dev@googlegroups.com, Andrew Morton <akpm@linux-foundation.org>,
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
 <80532f73e52e2c21fdc9aac7bce24aefb76d11b0.camel@linux.intel.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <80532f73e52e2c21fdc9aac7bce24aefb76d11b0.camel@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11.06.24 21:41, Tim Chen wrote:
> On Fri, 2024-06-07 at 11:09 +0200, David Hildenbrand wrote:
>> In preparation for further changes, let's teach __free_pages_core()
>> about the differences of memory hotplug handling.
>>
>> Move the memory hotplug specific handling from generic_online_page() to
>> __free_pages_core(), use adjust_managed_page_count() on the memory
>> hotplug path, and spell out why memory freed via memblock
>> cannot currently use adjust_managed_page_count().
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>   mm/internal.h       |  3 ++-
>>   mm/kmsan/init.c     |  2 +-
>>   mm/memory_hotplug.c |  9 +--------
>>   mm/mm_init.c        |  4 ++--
>>   mm/page_alloc.c     | 17 +++++++++++++++--
>>   5 files changed, 21 insertions(+), 14 deletions(-)
>>
>> diff --git a/mm/internal.h b/mm/internal.h
>> index 12e95fdf61e90..3fdee779205ab 100644
>> --- a/mm/internal.h
>> +++ b/mm/internal.h
>> @@ -604,7 +604,8 @@ extern void __putback_isolated_page(struct page *page, unsigned int order,
>>   				    int mt);
>>   extern void memblock_free_pages(struct page *page, unsigned long pfn,
>>   					unsigned int order);
>> -extern void __free_pages_core(struct page *page, unsigned int order);
>> +extern void __free_pages_core(struct page *page, unsigned int order,
>> +		enum meminit_context);
> 
> Shouldn't the above be
> 		enum meminit_context context);

Although C allows parameters without names in declarations, this was 
unintended.

Thanks!

-- 
Cheers,

David / dhildenb


