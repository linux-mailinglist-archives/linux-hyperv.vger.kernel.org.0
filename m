Return-Path: <linux-hyperv+bounces-6797-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D7B1B50053
	for <lists+linux-hyperv@lfdr.de>; Tue,  9 Sep 2025 16:55:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C263D7B390E
	for <lists+linux-hyperv@lfdr.de>; Tue,  9 Sep 2025 14:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB1E434F46F;
	Tue,  9 Sep 2025 14:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lJSjJ7WW"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 133722D12EF;
	Tue,  9 Sep 2025 14:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757429583; cv=none; b=lxgXwexvEYiF4jE6UxrqgK9G1xyScP8KEJNhLOVMeHk3Srvt3mNWc2v3N59cNUlihQaTFrAM5VdBUqUGxPSrXJFaY4t9U2juwS5BajeDW433ESU5txVIl7GzKG4IxxeqZLL4mk6Zinw1v3/nn3PgFH+nIW34lc3/2ce3QXMPjQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757429583; c=relaxed/simple;
	bh=66nPuSBirVQT9vezFvQGkDiUzK2HFA4UtEg/bWFBJQw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rPzEkdRgW/EMUMHW3mjn/NUOCn0kK8jGnZe5Bmc6exjDb/80T3dMT8A57JXbiIZaYxK1lYk59fuNGGzQtnYkdH9CYzerXVFmn/A94mEKlqCVoyNaO3ubDpXCFY7KjnXnL2/ThgC3XpLfRCdruloGrkcKOswmzk7xP+ggH5JbQGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lJSjJ7WW; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-74381df387fso2426115a34.0;
        Tue, 09 Sep 2025 07:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757429581; x=1758034381; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n/7XLahcDuaxLti/kmzeslbSXIyvMH6j2jV4N78vcic=;
        b=lJSjJ7WWdAswpnUVGys1qyl4U7O2ZFAPYHGee+HXyQowcDAO9K8bvK1qz2mdyK08X1
         a2blSqjIxIBOSCPzeN1iPwr85mhfuqN/p4C6DDZI5majhpN+4tgutKG5UnHTufayAIf9
         MKlQCLbW08IlUzvVMFEBYP+UIusgdKgWTYY9Uk3tKRxxlhXSxKBubD0euQImBisIQee/
         XXA//X68+InV1/DvHW8yl0pveUBRgbjaSXwsSRcBNvyID3zlhpjR+8LRxMjGMjOA0kAk
         nise/xlHWdy+hcEjYIIEd0ylvj9OWf+8JBbMoE5Lzw1Hmm7aPnQRC0/TaBCNRCioe2sn
         FLmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757429581; x=1758034381;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n/7XLahcDuaxLti/kmzeslbSXIyvMH6j2jV4N78vcic=;
        b=cQiEwaFjCxiQd2ZV/BHViPbWeS3AqP4aCkmhNxxYWHGg1vKAr9L13oJI9zriLOihxs
         ZhZtrsZNx7rAg7J57CgUE/fcgFlkLa9c9jNxQcVxsefixW2mIZkBNYUwGNWvcSt/ldo9
         Z3SZXIJzOO9pgkwh21o8TvEVFCylWiRPjKGTtyfozilaKrE6+dIXFeS6DmKgiE+vKljE
         P9fCSLhSbS80m4k+lwbk4KY5xWO3aXwg1ImU71Y43xNCrrmKchTjFELpuus+HiSQF0Yh
         AN9hRK/G/U8CDh2aYhuENZiUP5D7J+T55c5Po5toCXeCaZacVi1L6nS+Y1pgHoNtv7mz
         GGkw==
X-Forwarded-Encrypted: i=1; AJvYcCW+t7fMnlmn6xbDTBqdZvrEila4rc+XRtjkI8i2dH03zHxJkwV/tNaNEYCboEwUpH3W2wYsZctSGgYE4+M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5rGKEYWlJiPHzGfD1PPCnWfuiYv6tBQ4PrSp3N4eleFt3JWms
	U1jr7N6D5T+1HAzOmMJu4NJrxw67+EwhrwwpaQSLXJwFD3d1nJoRT9Vw
X-Gm-Gg: ASbGnct0VPeNLN/BADDfUYkGTKqscf4L1Q7DzU2nosHIDN6mjfsPPZmXdYifjHXBuKn
	N9+BXmfq6Nk1zvtxcSFWX0TUNpRiYaz5Q2Gb+xRjFjXAyinVc3doS4DaVnF+JedQz5Xenqi6hv1
	AsGFcEoT/ohdJUN3hksn5MK1AFYCq43eThVIi3Sc5gGuL9EtNsipSVKddd0dIbF6V95VrOJS4Jv
	u3Llzepvfltlm0YYm5LJ9oS41hCFLNlFl6aMldrK9kvQxkPiESN3splJ6oKHOXh5Dl8szVMZza7
	E9enYmWyoBjYQZqB8OLuu0h36rIMmOAMJrSz8GyLtynz4Uy9orx69fi0tD8OMJHB/BVXFr3QLHJ
	2Y9wkFmrMfu0Cgt/I2MYaj5WzSn1LWLLyA9Xrvgst7A==
X-Google-Smtp-Source: AGHT+IEi/V8F1DA9tie9k0hyBVHA+zCEHuxDA0FuoN1EGLE05Fg1te4DcF2nA8SPNDrcMyHZnE8BMA==
X-Received: by 2002:a05:6830:67cf:b0:74a:8a06:1ded with SMTP id 46e09a7af769-74c6f0232b3mr7115802a34.6.1757429581041;
        Tue, 09 Sep 2025 07:53:01 -0700 (PDT)
Received: from ?IPV6:2603:8081:c640:1::1006? ([2603:8081:c640:1::1006])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-62178df6810sm1678150eaf.10.2025.09.09.07.53.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Sep 2025 07:53:00 -0700 (PDT)
Message-ID: <6252578f-df25-4510-bc18-8f593739fb83@gmail.com>
Date: Tue, 9 Sep 2025 09:52:59 -0500
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] mshv: Ignore second stats page map result failure
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>,
 Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
 kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 mhklinux@outlook.com, decui@microsoft.com, paekkaladevi@linux.microsoft.com
References: <1756428230-3599-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1756428230-3599-3-git-send-email-nunodasneves@linux.microsoft.com>
 <efc78065-3556-410a-866f-961a7f1fc1ac@linux.microsoft.com>
 <874a2370-84f1-4cec-bb06-a13fe11b49ca@linux.microsoft.com>
 <7b4fafc7-cf89-45f6-ac5c-59a4c9f53f79@linux.microsoft.com>
 <23d93b71-86cc-4c01-9264-b049cfec39e0@linux.microsoft.com>
Content-Language: en-US
From: Praveen K Paladugu <praveenkpaladugu@gmail.com>
In-Reply-To: <23d93b71-86cc-4c01-9264-b049cfec39e0@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/8/2025 1:06 PM, Nuno Das Neves wrote:
> On 9/8/2025 10:22 AM, Easwar Hariharan wrote:
>> On 9/8/2025 10:04 AM, Nuno Das Neves wrote:
>>> On 9/5/2025 12:21 PM, Easwar Hariharan wrote:
>>>> On 8/28/2025 5:43 PM, Nuno Das Neves wrote:
>>>>> From: Purna Pavan Chandra Aekkaladevi <paekkaladevi@linux.microsoft.com>
>>>>>
>>>>> Some versions of the hypervisor do not support HV_STATUS_AREA_PARENT and
>>>>> return HV_STATUS_INVALID_PARAMETER for the second stats page mapping
>>>>> request.
>>>>>
>>>>> This results a failure in module init. Instead of failing, gracefully
>>>>> fall back to populating stats_pages[HV_STATS_AREA_PARENT] with the
>>>>> already-mapped stats_pages[HV_STATS_AREA_SELF].
>>>>
>>>> What's the impact of this graceful fallback? It occurs to me that if a stats
>>>> accumulator, in userspace perhaps, expected to get stats from the 2 pages,
>>>> it'd get incorrect values.
>>>>
>>> This is going out of scope of this series a bit but I'll explain briefly.
>>>
>>> When we do add the code to expose these stats to userspace, the SELF and
>>> PARENT pages won't be exposed separately, there is no duplication.
>>>
>>> For each stat counter in the page, we'll expose either the SELF or PARENT
>>> value, depending on whether there is anything in that slot (whether it's zero
>>> or not).
>>>
>>> Some stats are available via the SELF page, and some via the PARENT page, but
>>> the counters in the page have the same layout. So some counters in the SELF
>>> page will all stay zero while on the PARENT page they are updated, and vice
>>> versa.
>>>
>>> I believe the hypervisor takes this strange approach for the purpose of
>>> backward compatibility. Introducing L1VH created the need for this SELF/PARENT
>>> distinction.
>>>
>>> Hope that makes some kind of sense...it will be clearer when we post the mshv
>>> debugfs code itself.
>>>
>>> To put it another way, falling back to the SELF page won't cause any impact
>>> to userspace because the distinction between the pages is all handled in the
>>> driver, and we only read each stat value from either SELF or PARENT.
>>>
>>> Nuno
>>
>> Thank you for that explanation, it sorta makes sense.
>>
>> I think it'd be better if this patch is part of the series that exposes the stats
>> to userspace, so that it can be reviewed in context with the rest of the code in
>> the driver that manages the pick-and-choose of a stat value from the SELF/PARENT
>> page.
>>
> Good idea, I think I'll do that. Thanks!
> 
>> Unless there's an active problem now in the upstream kernel that this patch solves?
>> i.e. are the versions of the hypervisor that don't support the PARENT stats
>> page available in the wild?
>>
> I thought there was, but on reflection, no it doesn't solve a problem that exists in
> the code today.
> 
> Nuno
>

The usecases for stats exposed by the hypervisor are:
1) used within the kernel by root scheduler
2) exposed to userspace via debugfs.

I thought we are addressing the first use-case here (patch1 in this 
series). If root scheduler support was upstreamed then this patchset 
does solve a problem in upstream code.


>> Thanks,
>> Easwar (he/him)
> 
> 

-- 
Regards,
Praveen K Paladugu


