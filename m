Return-Path: <linux-hyperv+bounces-2523-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46D259254F5
	for <lists+linux-hyperv@lfdr.de>; Wed,  3 Jul 2024 09:57:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC02C1F2588C
	for <lists+linux-hyperv@lfdr.de>; Wed,  3 Jul 2024 07:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3349E137C34;
	Wed,  3 Jul 2024 07:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hTyE90hr"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7226513791F
	for <linux-hyperv@vger.kernel.org>; Wed,  3 Jul 2024 07:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719993454; cv=none; b=bgfmNXy/Oo262nFTioZyEtCLNFjX2UJuJCtS9sTtE5ZjFJ0189F9TaiFNqPRAEVKm5wBAYjZxSZcjSzrwn7omNI8fImPfdIxoH9DyKWPBrJJQfQEPzxO9gN91Hqkp+ISSYAdqQwrFSD7Oq8Ik4a39iNX0lgx29yyBh67VrAGyL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719993454; c=relaxed/simple;
	bh=U+tuZf+gHrZIew88Zq0HhyZ0+J7x2Mhz/9FZdbvH6Bg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H3iM31/1VUweL3IA3gJIZlvXPFZMHaySjS06eUjx45/lda8J5BxUDEq4YeNkOPlOByEsuTgPZxaCVU0+lSkiP1V+chAIgOUAT7uibDmmR7nb4Km6e1jThUXICTJnUsqu5U0/HXvQC55fTwh+E3CQ7pDlPE8e2l128D+Cx48lq14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hTyE90hr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719993451;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ATgbDzJNw/2oGwBMOiWIjN3Qn1UCklmeTzoV2zYR45Y=;
	b=hTyE90hrZpPA7rCvoJMFBttsO84hdETHQoiOo1/6jzwCukxY6T2bJqoE6G7z6J9+icfcYG
	AV8QBOcXUB6QoJI9IMwhAm8nFAhK13lqnAX9/y5aAnaatKQBzWTyqkW3hob8jBfxMtWMoI
	asOHuqBjUXLAYd31D9SeL1stxR9nv4g=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-587-ToZ1jbzTOu-evRXQnXuFFQ-1; Wed, 03 Jul 2024 03:57:30 -0400
X-MC-Unique: ToZ1jbzTOu-evRXQnXuFFQ-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3630a676a07so3194514f8f.2
        for <linux-hyperv@vger.kernel.org>; Wed, 03 Jul 2024 00:57:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719993449; x=1720598249;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ATgbDzJNw/2oGwBMOiWIjN3Qn1UCklmeTzoV2zYR45Y=;
        b=UK0/qepm0ZpKtC6LKNbCcFZgVdZ6DdYbeJTqmbjY6vfJu/Sg10LC4XpgAyVaEOwYM7
         y13fbuHGAMgGqiVCrwaJZQp3BzTJc3hj75WLujv/uz6DOxlNuT4ynO/t/IcDcyB7y3Hy
         T2aMu38sBWSOkTxql6dtOq2pXzuc1ry9Dj2r9QjzRf7t1Vrn+eCtJZUTrswHm9dR6cN9
         sOPtoW8Cy14maErao4eUhwYaLCoBft/B9CiDGWAWSxr0bRk7JiF6lrRblwJWnYK6Q8x6
         5wmJiXULX7y+PbizX0kYBH6Va7xx7DB31TzjP2Z98NAm5fir/ZcgoNBgxseyXQb8Dlg4
         1A+Q==
X-Forwarded-Encrypted: i=1; AJvYcCVn8t1JG8oCpXY/nUHcxuvB9R97uN07HDg+Ti3297+pyGIsmOAFTIsgkyTKvfdEE4Wqj3Mu27ROPcBeYwO4OxiFk1qd/aAqhLWNTJ0U
X-Gm-Message-State: AOJu0YzDWTJUYSwDXKsWi1+vHhJzG9zyMQdpL/nQKJCcGb6+DdnUrhJ4
	+t9mWgwKozBrtj1kEcbuur6fss1V0SzDpDM/QcsSaXxwa7TM4F+dmUob7i/OUbEJrobsMXm/LA0
	wae89It00w9KL0AoaQXbysXRXTwABo0ufQt3rU2IcVMkU/bZ/FwOm5RXQ3aMEpg==
X-Received: by 2002:a05:6000:400d:b0:366:e685:d0cb with SMTP id ffacd0b85a97d-3677569762bmr7597293f8f.6.1719993449006;
        Wed, 03 Jul 2024 00:57:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEgd9U2eqDjR78JXH16dEWMefFhv6oCfwMwNT/hPSpZD56c2ut2zLCAdpneI7XMTfA346aUUg==
X-Received: by 2002:a05:6000:400d:b0:366:e685:d0cb with SMTP id ffacd0b85a97d-3677569762bmr7597268f8f.6.1719993448595;
        Wed, 03 Jul 2024 00:57:28 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:d5:a000:680e:9bf4:b6a9:959b? ([2a01:e0a:d5:a000:680e:9bf4:b6a9:959b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3675a0cd623sm15223623f8f.16.2024.07.03.00.57.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jul 2024 00:57:28 -0700 (PDT)
Message-ID: <10ea2ea1-e692-443e-8b48-ce9884e8b942@redhat.com>
Date: Wed, 3 Jul 2024 09:57:26 +0200
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] printk: Add a short description string to kmsg_dump()
To: Kees Cook <kees@kernel.org>
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
 <gpiccoli@igalia.com>, Petr Mladek <pmladek@suse.com>,
 Steven Rostedt <rostedt@goodmis.org>, John Ogness
 <john.ogness@linutronix.de>, Sergey Senozhatsky <senozhatsky@chromium.org>,
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
Content-Language: en-US, fr
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <202407021326.E75B8EA@keescook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 02/07/2024 22:29, Kees Cook wrote:
> On Tue, Jul 02, 2024 at 02:26:04PM +0200, Jocelyn Falempe wrote:
>> kmsg_dump doesn't forward the panic reason string to the kmsg_dumper
>> callback.
>> This patch adds a new struct kmsg_dump_detail, that will hold the
>> reason and description, and pass it to the dump() callback.
> 
> Thanks! I like this much better. :)
> 
>>
>> To avoid updating all kmsg_dump() call, it adds a kmsg_dump_desc()
>> function and a macro for backward compatibility.
>>
>> I've written this for drm_panic, but it can be useful for other
>> kmsg_dumper.
>> It allows to see the panic reason, like "sysrq triggered crash"
>> or "VFS: Unable to mount root fs on xxxx" on the drm panic screen.
>>
>> v2:
>>   * Use a struct kmsg_dump_detail to hold the reason and description
>>     pointer, for more flexibility if we want to add other parameters.
>>     (Kees Cook)
>>   * Fix powerpc/nvram_64 build, as I didn't update the forward
>>     declaration of oops_to_nvram()
> 
> The versioning history commonly goes after the "---".

ok, I was not aware of this.
> 
>> [...]
>> diff --git a/include/linux/kmsg_dump.h b/include/linux/kmsg_dump.h
>> index 906521c2329c..65f5a47727bc 100644
>> --- a/include/linux/kmsg_dump.h
>> +++ b/include/linux/kmsg_dump.h
>> @@ -39,6 +39,17 @@ struct kmsg_dump_iter {
>>   	u64	next_seq;
>>   };
>>   
>> +/**
>> + *struct kmsg_dump_detail - kernel crash detail
> 
> Is kern-doc happy with this? I think there is supposed to be a space
> between the "*" and the first word:
> 
>   /**
>    * struct kmsg...
> 
> 
Good catch, yes there is a space missing.

I just checked with "make htmldocs", and in fact 
include/linux/kmsg_dump.h is not indexed for kernel documentation.
And you can't find the definition of struct kmsg_dumper in the online doc.
https://www.kernel.org/doc/html/latest/search.html?q=kmsg_dumper

> Otherwise looks good to me!
> 

Thanks.

As this patch touches different subsystems, do you know on which tree it 
should land ?

-- 

Jocelyn


