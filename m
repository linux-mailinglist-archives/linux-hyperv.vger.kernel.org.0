Return-Path: <linux-hyperv+bounces-4193-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B343A4AEBB
	for <lists+linux-hyperv@lfdr.de>; Sun,  2 Mar 2025 03:23:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E080C188E822
	for <lists+linux-hyperv@lfdr.de>; Sun,  2 Mar 2025 02:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 775CC1EF01;
	Sun,  2 Mar 2025 02:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iMtthqq7"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E9B3597E;
	Sun,  2 Mar 2025 02:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740882192; cv=none; b=AYSXVcpqHmqBqb/nDhD4RA9W3p5n4D+wZr6y0m0arRJ1TQXgBLSrYSXfi/0XJsg7rdpeVgjC3/qqzveal/DkU5EduoSOrs4p8ZA2QaCLL3buwnRyM86EzMUqRwyXRb/aTTGD/uJLxioLimz0bVFVhFl28o/UellvYtxiHOxxabE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740882192; c=relaxed/simple;
	bh=Ms35D6rpVAm4Wn+iz7v3jU9bT3pFycygdKwhAA7LcRQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lbuSYUMh1vZruxOqy5/I62xMNNj/Vl5eL4WfmUU3yFiEL8QkSyI5foTi8cKrBLPCXjeN+iZ5HjJ8PVPUoxO97EyLC4iPbY6hF5RCsnoQHHsx4swjXpqNZ1KPrwHFhX4yG09Ma8LMd1NtXwnDHBuM7FZ7n5DNCLemw9gwruPMpf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iMtthqq7; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-219f8263ae0so61659455ad.0;
        Sat, 01 Mar 2025 18:23:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740882190; x=1741486990; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bIgb5oCKHg0d8J0ugu6ecAoU1ogbWalfHnz6Q8BvygU=;
        b=iMtthqq7phxR3YYoFkGoonSvIJ+zvpHwH5kXEAIjE+GGCuMRAJc3FEnqmz26LmiUN3
         oQbDbljuMXtv0VlqO5hbmccMaljd2rOOYm2mHmumeqO54s8akCuktuOHsLIeKNT61DB/
         H6GrZsniQqUMAFUYDEm4kyel3WXQL9QkfQpFneNw+Gu6jimXa/yJHZawsbvAhteBsmwb
         YfnZYtBp8wOjZckEvA3r8/xjRZMa1OriFQtcisbvxPGBnjgNamoUjfo6Hw36Fp/WBDPc
         UoRqSNjZ5/O1rCnlLLkGMBuiaGi/Kfr610kKn+GgPYxpWhpzkXo3Wv7NUo0Vx++ujche
         Othw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740882190; x=1741486990;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bIgb5oCKHg0d8J0ugu6ecAoU1ogbWalfHnz6Q8BvygU=;
        b=LkSI6KYRpa6VdGNDtjutnURdxCATtKw7BuaoyqOpSROCNpFAJ3Ja2r5I7vKlPy+O7J
         0T1sapcacCGL7waKgnSFRCNRnJyVL4rSWnp+rCbF4gqdUobGQqcpIZJ4znJkx8L4xSl+
         0AKUtU1lT2ZfSFrb/i+5ZHv6PdgK3pgcrdUpoNhYLqsg33JqfPCNoDrFav7hjJIEEXKc
         ZM5jBHGJd2q/BZ5eTCEkt2lEl2BXpTMT+4y/w62BQXyK2/18VoKpY++kAXtoEUSePK3j
         hJMB6pkviDjHcZ+RMaSjFH/ztioNpmqb43eVTkQF0wHlGAsZ0tlA2x8exr+bxNtz8WRP
         wJMQ==
X-Forwarded-Encrypted: i=1; AJvYcCU51lBzm7fGxqqFpLMRBmBufMirNPbI4GGxa8fNLc6LPVxK8a6ggz08tCefElm8bNaBjGCbXSj+@vger.kernel.org, AJvYcCUG/ICcZPB6Yh/lNNNeoNXF34mjXRG06u+WqGcfovRXM0BuwkqiqoWcfWKiYn/LXBPCX+fomm1mx1i17k0=@vger.kernel.org, AJvYcCWswqTJGPR9i9jJTh2XRjS36/CHtzsWZW/2z7lGSTc9jrVTfT0sNk1mAFXNgktv+ph1JInvVgPGrbm2/swU@vger.kernel.org, AJvYcCXoI5BtzhWpZtN090WPIMQd8fbg+gX4nh2a/vy66gkveY2+2FBHJShDRcBwQLU5G6CtJsStsKkQ@vger.kernel.org
X-Gm-Message-State: AOJu0YwvxY7ypRO2S36UKKbaoD8HF1CGcIHa+dsqT1EZs+YGUsssZvsb
	44rplZAmFjQcw60vpjxFt0tGfZHZ4h3tDPEXGsNWb+p72AtYFDX2
X-Gm-Gg: ASbGncux1RXzrZq+PjoXOTMqvJhXugg5G6JwegoslTKkpc4Ix/tTncFoFkhhMql1IBV
	Re0TlvYhgYJT8AEDn7mxXL4cWfzpJ+qymbb9NDdDPf2P2nBcbbKNe5/RpSBDL6uE9FYezEhoG2J
	wsKXPPidk3bqQxO0BSYawOKS+qHTJdqA8hnK6SGaB0C+V9XfA+/ZRlod6vrjkuklUwIiJtHAk3e
	gFMO00hFxFjnnvX7hW4J2DA5d9I7nA0DZcTKyInWFOgRlLGFC9SLpofphrYwZyYsZJSh+xNx9li
	LMAnpo6SOU7ttD69Nv9/oW1ntA00FqtCWnwgTUFgHs7ez7FFwguQhJZ/4jFl8RT6Pm/jmpciz/B
	gX/eGKbD9Z+fQlqdsR1nBoXfm+t7I7h8D
X-Google-Smtp-Source: AGHT+IF7Tj08QU1/XlQt1s/pvFZTEEH8FOsLcUTfASRUZhpzzuMZ+JW2GadNl6cju1yKvhSSnz94fA==
X-Received: by 2002:a05:6a21:110:b0:1ee:e655:97ea with SMTP id adf61e73a8af0-1f2f4e4e782mr15784551637.41.1740882189968;
        Sat, 01 Mar 2025 18:23:09 -0800 (PST)
Received: from ?IPV6:2409:8a55:301b:e120:3115:39d1:77ff:54d2? ([2409:8a55:301b:e120:3115:39d1:77ff:54d2])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-aee7dedea46sm4862492a12.67.2025.03.01.18.23.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Mar 2025 18:23:09 -0800 (PST)
Message-ID: <68f83951-881f-49a6-8599-e47956b984fe@gmail.com>
Date: Sun, 2 Mar 2025 10:22:59 +0800
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [EXTERNAL] Re: [PATCH] mm: page_frag: Fix refill handling in
 __page_frag_alloc_align()
To: Haiyang Zhang <haiyangz@microsoft.com>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>
Cc: Dexuan Cui <decui@microsoft.com>, KY Srinivasan <kys@microsoft.com>,
 Paul Rosswurm <paulros@microsoft.com>, "olaf@aepfle.de" <olaf@aepfle.de>,
 vkuznets <vkuznets@redhat.com>, "davem@davemloft.net" <davem@davemloft.net>,
 "wei.liu@kernel.org" <wei.liu@kernel.org>, Long Li <longli@microsoft.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linyunsheng@huawei.com" <linyunsheng@huawei.com>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Alexander Duyck <alexander.duyck@gmail.com>
References: <1740794613-30500-1-git-send-email-haiyangz@microsoft.com>
 <cc3034c6-2589-4e9a-97af-a7879998d7d8@gmail.com>
 <MN0PR21MB3437E18AA793762F242BE795CACF2@MN0PR21MB3437.namprd21.prod.outlook.com>
 <MN0PR21MB3437DB9A18F1C354963C5EF3CACF2@MN0PR21MB3437.namprd21.prod.outlook.com>
Content-Language: en-US
From: Yunsheng Lin <yunshenglin0825@gmail.com>
In-Reply-To: <MN0PR21MB3437DB9A18F1C354963C5EF3CACF2@MN0PR21MB3437.namprd21.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/2/2025 7:16 AM, Haiyang Zhang wrote:

...

>> We are already aware of this, and have error checking in place for the
>> failover
>> case to "base page".
>>
>>  From the discussion thread above, there are other drivers using
>> page_frag_alloc_align() for over PAGE_SIZE too. If making the page_frag
>> API
>> support only fragsz <= PAGE_SIZE is desired, can we create another API?
>> One
>> keeps the existing API semantics (allowing > PAGE_SIZE), the other uses
>> your new code. By the way, it should add an explicit check and fail ALL
>> requests
>> for fragsz > PAGE_SIZE. Currently your code successfully allocates big
>> frags
>> for a few times, then fail. This is not a desired behavior. It's also a
>> breaking change for our MANA driver, which can no longer run Jumbo frames.

It seems there was some memory corruption problem that may caused by
reuse of the previously allocated frag cache memory by following a
LARGER allocations before 'using initial zero offset'.

https://lore.kernel.org/netdev/b711ca5f-4180-d658-a330-89bd5dcb0acb@gmail.com/T/#m12ebdefb8ee653b281d477d2310218b4ac138cde

'using initial zero offset' seems to just make the API misuse problem
more obvious.

>>
>> @Andrew Morton <akpm@linux-foundation.org>
>> And other maintainers, could you please also evaluate the idea above?
>>
> 
> And, quote from current doc 6.14.0-rc4:
> "A page fragment is an arbitrary-length arbitrary-offset area of memory
> which resides within a 0 or higher order compound page."
> https://web.git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/Documentation/mm/page_frags.rst
> 
> So, it is designed to be *arbitrary-length* within a 0 or higher order
> compound page.
> 
> If the commit 8218f62c9c9b ("mm: page_frag: use initial zero offset for
> page_frag_alloc_align()") intended to change the existing API semantics
> to be Page Frag Length <= PAGE_SIZE, the document and all breaking drivers
> need to be updated.

Yes, updating the Documemntation to make it more obvious seems like the
right thing to do.

> 
> Thanks,
> - Haiyang
> 


