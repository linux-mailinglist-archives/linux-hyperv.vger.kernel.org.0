Return-Path: <linux-hyperv+bounces-2533-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F1B13926640
	for <lists+linux-hyperv@lfdr.de>; Wed,  3 Jul 2024 18:40:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 574F9B20D58
	for <lists+linux-hyperv@lfdr.de>; Wed,  3 Jul 2024 16:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 472711822EC;
	Wed,  3 Jul 2024 16:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hr1hiLgu"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A152317995
	for <linux-hyperv@vger.kernel.org>; Wed,  3 Jul 2024 16:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720024820; cv=none; b=d3Mza3GS/1leQf55v1K8OZzbei29FsUq0lA1Obiu3BVl/bjtowzcdiWr0XVPROwJr8l7Mm/JfHpV8gPcAK4DUVeNJdBTlTeCcqtiYn9gITDoVG8KZiBeRW9F+63iImqyhLVpb8/yc1eCcGDHI5aJcL+5btBpCWWBSKm9EwRWUbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720024820; c=relaxed/simple;
	bh=21K+un7CaiJVoHI9Gxi8vgmdLcVLvKjA1T7x4gcPYqE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UuqOQtQp7RqZKvB/CufLfUUU/BbVTpOlWj1re/fndqMit0TZmRDasF8c8v6Rrj5Oey9FZGu2xjmlggPM+y/Tou1F1j0pYw6B6FTQ6gxIUJzy84ErJfVR7UQQEInT+ltwCRIvIcdXUfHzdxICrw6Zt7mNxvDiIr/gX8zbxfTNAIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Hr1hiLgu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720024817;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f/NKPoncPw4sIDqFM3t6GuhdQa0oQUQo4XXTqMGF3ME=;
	b=Hr1hiLguSGzp+Ntsm0ONhMyTT/yPsioiNQjnA+1D3qy+IV6yvHXOJzQ4SiXax7Tvx0TTEm
	lwwwHBWezU7N0TUF8ENVncZCvOhFx3eDkRrms7TXbb2yKds5k8GzAB1opWxu9jtYC50fkA
	Sl/uGgiySc0510ha6304DOOEdwMp4zs=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-403-7U-vT19YPSqAlrKt6t3RDg-1; Wed, 03 Jul 2024 12:40:16 -0400
X-MC-Unique: 7U-vT19YPSqAlrKt6t3RDg-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3678f832c75so1088813f8f.3
        for <linux-hyperv@vger.kernel.org>; Wed, 03 Jul 2024 09:40:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720024815; x=1720629615;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f/NKPoncPw4sIDqFM3t6GuhdQa0oQUQo4XXTqMGF3ME=;
        b=VBmRRTzwWt9flaZJ7Q2G1d5QkW7lnAwX3JzzIdl15auEeS5S1hneS9XdTf7cPC/9HB
         KHIqDCPw3s8Jv1fsWvaZegmvg0ctD8934DSrCQcMqzpOPaDfJI2Lz7ze1wCHxw589YKf
         67fxBw0OJ/9wsrnyB2hDsyiKlZDwdsuFIMPBbAqtyUPFJ+0JalGO4Rx8oaCCB/p16jf+
         cidsiqdljK57yC8ugzTZPc/wLYuyHcV3prh0Jafq7mh2391u/9S5tAsrcQZ2DulFghM9
         K8+k8NckGG45EsGej9Nc/9/eue5N2MbNzmGLYGHZ+rwwTQ2IoFW+PIApFtpTwRJMxWB8
         Md3Q==
X-Forwarded-Encrypted: i=1; AJvYcCX3zBBNjrILqnc8sxOgvbhVjjRu3o8iqko5Fu4T05Wh41OGdWSTW6QdiIrX5DyLcJHexRn/UQmUUMgV07huA85iezIH8S6LuUzR0Kc0
X-Gm-Message-State: AOJu0YwLkoHEWxfHmZtSmjG5YhGdeikI4wkbMgaBzbIIoJYk9LFTN0Av
	5pSktF3azSt3BGkCU57VI4Y829CgA0HDhBtMHMO7ywGts2xLLUtPWFy9JEoHtxt3oCWGUvJzzUZ
	4I/JlTMiLNO9wFbmpHBBFiz+UyokAJQ4VIxqASV2WQieGug+b5ATF8LCquKAO6Q==
X-Received: by 2002:adf:fa83:0:b0:367:890e:838e with SMTP id ffacd0b85a97d-367890e86c6mr3596790f8f.40.1720024815358;
        Wed, 03 Jul 2024 09:40:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFECIbpt3OJn614ksUNxWcM5kxqBGXD+RFA85ATl3K5a4iBL/0MjztMRm9i7OEdpByRhuroqQ==
X-Received: by 2002:adf:fa83:0:b0:367:890e:838e with SMTP id ffacd0b85a97d-367890e86c6mr3596739f8f.40.1720024814927;
        Wed, 03 Jul 2024 09:40:14 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:d5:a000:680e:9bf4:b6a9:959b? ([2a01:e0a:d5:a000:680e:9bf4:b6a9:959b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36791d7a93bsm2401812f8f.81.2024.07.03.09.40.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jul 2024 09:40:14 -0700 (PDT)
Message-ID: <9e7023f4-775c-4371-ade5-1ed860545aaa@redhat.com>
Date: Wed, 3 Jul 2024 18:40:12 +0200
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] printk: Add a short description string to kmsg_dump()
To: Kees Cook <kees@kernel.org>, Petr Mladek <pmladek@suse.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin
 <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>,
 "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 Tony Luck <tony.luck@intel.com>, "Guilherme G. Piccoli"
 <gpiccoli@igalia.com>, Steven Rostedt <rostedt@goodmis.org>,
 John Ogness <john.ogness@linutronix.de>,
 Sergey Senozhatsky <senozhatsky@chromium.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Jani Nikula <jani.nikula@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Kefeng Wang <wangkefeng.wang@huawei.com>,
 Thomas Gleixner <tglx@linutronix.de>, Uros Bizjak <ubizjak@gmail.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-hyperv@vger.kernel.org,
 linux-mtd@lists.infradead.org, linux-hardening@vger.kernel.org
References: <20240702122639.248110-1-jfalempe@redhat.com>
 <202407021326.E75B8EA@keescook>
 <10ea2ea1-e692-443e-8b48-ce9884e8b942@redhat.com>
 <ZoUKM9-RiOrv0_Vf@pathway.suse.cz> <202407030926.D5DA9B901D@keescook>
Content-Language: en-US, fr
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <202407030926.D5DA9B901D@keescook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 03/07/2024 18:27, Kees Cook wrote:
> On Wed, Jul 03, 2024 at 10:22:11AM +0200, Petr Mladek wrote:
>> On Wed 2024-07-03 09:57:26, Jocelyn Falempe wrote:
>>>
>>>
>>> On 02/07/2024 22:29, Kees Cook wrote:
>>>> On Tue, Jul 02, 2024 at 02:26:04PM +0200, Jocelyn Falempe wrote:
>>>>> kmsg_dump doesn't forward the panic reason string to the kmsg_dumper
>>>>> callback.
>>>>> This patch adds a new struct kmsg_dump_detail, that will hold the
>>>>> reason and description, and pass it to the dump() callback.
>>>>
>>>> Thanks! I like this much better. :)
>>>>
>>>>>
>>>>> To avoid updating all kmsg_dump() call, it adds a kmsg_dump_desc()
>>>>> function and a macro for backward compatibility.
>>>>>
>>>>> I've written this for drm_panic, but it can be useful for other
>>>>> kmsg_dumper.
>>>>> It allows to see the panic reason, like "sysrq triggered crash"
>>>>> or "VFS: Unable to mount root fs on xxxx" on the drm panic screen.
>>>>>
>>>>> v2:
>>>>>    * Use a struct kmsg_dump_detail to hold the reason and description
>>>>>      pointer, for more flexibility if we want to add other parameters.
>>>>>      (Kees Cook)
>>>>>    * Fix powerpc/nvram_64 build, as I didn't update the forward
>>>>>      declaration of oops_to_nvram()
>>>>
>>>> The versioning history commonly goes after the "---".
>>>
>>> ok, I was not aware of this.
>>>>
>>>>> [...]
>>>>> diff --git a/include/linux/kmsg_dump.h b/include/linux/kmsg_dump.h
>>>>> index 906521c2329c..65f5a47727bc 100644
>>>>> --- a/include/linux/kmsg_dump.h
>>>>> +++ b/include/linux/kmsg_dump.h
>>>>> @@ -39,6 +39,17 @@ struct kmsg_dump_iter {
>>>>>    	u64	next_seq;
>>>>>    };
>>>>> +/**
>>>>> + *struct kmsg_dump_detail - kernel crash detail
>>>>
>>>> Is kern-doc happy with this? I think there is supposed to be a space
>>>> between the "*" and the first word:
>>>>
>>>>    /**
>>>>     * struct kmsg...
>>>>
>>>>
>>> Good catch, yes there is a space missing.
>>>
>>> I just checked with "make htmldocs", and in fact include/linux/kmsg_dump.h
>>> is not indexed for kernel documentation.
>>> And you can't find the definition of struct kmsg_dumper in the online doc.
>>> https://www.kernel.org/doc/html/latest/search.html?q=kmsg_dumper
>>>
>>>> Otherwise looks good to me!
>>>>
>>>
>>> Thanks.
>>>
>>> As this patch touches different subsystems, do you know on which tree it
>>> should land ?
>>
>> Andrew usually takes patches against kernel/panic.c.
>>
>> Or you could take it via the DRM tree, especially if you already have the code
>> using the string.

If it's not taken in Andrew's tree next week, I will see if I can push 
it to the drm-misc tree. I think there is a very low chance of conflicts.

>>
>> Also I could take it via the printk tree. The only complication is
>> that I am going to be away the following two weeks and would come
>> back in the middle of the merge window. I do not expect much problems
>> with this change but...
> 
> If DRM doesn't want to carry it, I can put it in through the pstore
> tree. Let me know! :)
> 

Thanks for the proposition, I will see how it goes, it would be nice to 
have it in time for the v6.11 merge window.

Best regards,

-- 

Jocelyn


