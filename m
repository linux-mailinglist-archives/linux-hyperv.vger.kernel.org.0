Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1DABB17CA5
	for <lists+linux-hyperv@lfdr.de>; Wed,  8 May 2019 16:55:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727081AbfEHOzC (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 8 May 2019 10:55:02 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:46458 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727367AbfEHOzC (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 8 May 2019 10:55:02 -0400
Received: by mail-qk1-f196.google.com with SMTP id a132so12464415qkb.13
        for <linux-hyperv@vger.kernel.org>; Wed, 08 May 2019 07:55:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=1h5qqXP2zKn4t+f1DgpRlCP0iFG+3OcxmOSi/5AQUKo=;
        b=owTmczQ3w1w1mEKNmC+NnPJFFS1Ey4t6N979tl0DgEF6y6xB7Jqpo7wfiEk1agzfab
         kLO3to40Q5jA4SG3WqzNPnSm8AShebLuY7l2jaa/K6y06gaccBHj+EfFrtbxacHJ6S9t
         UiBcANfdRXXfrYBxzeEe/NK+8XtzQKV08ayFOTwTM20Hwv/9jR22mTVigsiWbtEM2N0c
         7lloEQCvaWBuioUxMa9vozuFtsIL6+5JysDzfdhmxhxIpDAsxQWzYn2ZPGD/OfjphL1v
         BC8DfbmF19LdDM9xXMZOT7EG0lRJPcnngIBdTRHSQxerDmR+MdMJHvKW6/cRsMql5puQ
         NE0A==
X-Gm-Message-State: APjAAAXa11BGalfXBtZ+YbfqC50Ql8I30PlAbqbDfNd8ssJUDU8x4h8Y
        U56QWw6pZaSWcxGNw3NKBLVqVA==
X-Google-Smtp-Source: APXvYqwKgHm3q5ceZf5k5cSq2FHnWs797Gib8eSwius8UF2SFBaMznBrZTcbOD1FM9mG93SE3TpYwQ==
X-Received: by 2002:a05:620a:15ad:: with SMTP id f13mr21262690qkk.101.1557327301283;
        Wed, 08 May 2019 07:55:01 -0700 (PDT)
Received: from vitty.brq.redhat.com ([64.251.121.244])
        by smtp.gmail.com with ESMTPSA id v185sm275704qkb.0.2019.05.08.07.55.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 08 May 2019 07:55:00 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Maya Nakamura <m.maya.nakamura@gmail.com>
Cc:     mikelley@microsoft.com, kys@microsoft.com, haiyangz@microsoft.com,
        sthemmin@microsoft.com, sashal@kernel.org, x86@kernel.org,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/6] x86: hv: hv_init.c: Replace alloc_page() with kmem_cache_alloc()
In-Reply-To: <20190508064559.GA54416@maya190131.isni1t2eisqetojrdim5hhf1se.xx.internal.cloudapp.net>
References: <cover.1554426039.git.m.maya.nakamura@gmail.com> <bdbacc872e369762a877af4415ad1b07054826db.1554426040.git.m.maya.nakamura@gmail.com> <87wok8it8p.fsf@vitty.brq.redhat.com> <20190412072401.GA69620@maya190131.isni1t2eisqetojrdim5hhf1se.xx.internal.cloudapp.net> <87mukvfynk.fsf@vitty.brq.redhat.com> <20190508064559.GA54416@maya190131.isni1t2eisqetojrdim5hhf1se.xx.internal.cloudapp.net>
Date:   Wed, 08 May 2019 10:54:59 -0400
Message-ID: <87mujxro70.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Maya Nakamura <m.maya.nakamura@gmail.com> writes:

> On Fri, Apr 12, 2019 at 09:52:47AM +0200, Vitaly Kuznetsov wrote:
>> Maya Nakamura <m.maya.nakamura@gmail.com> writes:
>> 
>> > On Fri, Apr 05, 2019 at 01:31:02PM +0200, Vitaly Kuznetsov wrote:
>> >> Maya Nakamura <m.maya.nakamura@gmail.com> writes:
>> >> 
>> >> > @@ -98,18 +99,20 @@ EXPORT_SYMBOL_GPL(hyperv_pcpu_input_arg);
>> >> >  u32 hv_max_vp_index;
>> >> >  EXPORT_SYMBOL_GPL(hv_max_vp_index);
>> >> >  
>> >> > +struct kmem_cache *cachep;
>> >> > +EXPORT_SYMBOL_GPL(cachep);
>> >> > +
>> >> >  static int hv_cpu_init(unsigned int cpu)
>> >> >  {
>> >> >  	u64 msr_vp_index;
>> >> >  	struct hv_vp_assist_page **hvp = &hv_vp_assist_page[smp_processor_id()];
>> >> >  	void **input_arg;
>> >> > -	struct page *pg;
>> >> >  
>> >> >  	input_arg = (void **)this_cpu_ptr(hyperv_pcpu_input_arg);
>> >> > -	pg = alloc_page(GFP_KERNEL);
>> >> > -	if (unlikely(!pg))
>> >> > +	*input_arg = kmem_cache_alloc(cachep, GFP_KERNEL);
>> >> 
>> >> I'm not sure use of kmem_cache is justified here: pages we allocate are
>> >> not cache-line and all these allocations are supposed to persist for the
>> >> lifetime of the guest. In case you think that even on x86 it will be
>> >> possible to see PAGE_SIZE != HV_HYP_PAGE_SIZE you can use alloc_pages()
>> >> instead.
>> >> 
>> > Thank you for your feedback, Vitaly!
>> >
>> > Will you please tell me how cache-line relates to kmem_cache?
>> >
>> > I understand that alloc_pages() would work when PAGE_SIZE <=
>> > HV_HYP_PAGE_SIZE, but I think that it would not work if PAGE_SIZE >
>> > HV_HYP_PAGE_SIZE.
>> 
>> Sorry, my bad: I meant to say "not cache-like" (these allocations are
>> not 'cache') but the typo made it completely incomprehensible. 
>  
> No worries! Thank you for sharing your thoughts with me, Vitaly.
>
> Do you know of any alternatives to kmem_cache that can allocate memory
> in a specified size (different than a guest page size) with alignment?
> Memory allocated by alloc_page() is aligned but limited to the guest
> page size, and kmalloc() can allocate a particular size but it seems
> that it does not guarantee alignment. I am asking this while considering
> the changes for architecture independent code.
>

I think we can consider these allocations being DMA-like (because
Hypervisor accesses this memory too) so you can probably take a look at
dma_pool_create()/dma_pool_alloc() and friends.

>> >> Also, in case the idea is to generalize stuff, what will happen if
>> >> PAGE_SIZE > HV_HYP_PAGE_SIZE? Who will guarantee proper alignment?
>> >> 
>> >> I think we can leave hypercall arguments, vp_assist and similar pages
>> >> alone for now: the code is not going to be shared among architectures
>> >> anyways.
>> >> 
>> > About the alignment, kmem_cache_create() aligns memory with its third
>> > parameter, offset.
>> 
>> Yes, I know, I was trying to think about a (hypothetical) situation when
>> page sizes differ: what would be the memory alignment requirements from
>> the hypervisor for e.g. hypercall arguments? In case it's always
>> HV_HYP_PAGE_SIZE we're good but could it be PAGE_SIZE (for e.g. TLB
>> flush hypercall)? I don't know. For x86 this discussion probably makes
>> no sense. I'm, however, struggling to understand what benefit we will
>> get from the change. Maybe just leave it as-is for now and fix
>> arch-independent code only? And later, if we decide to generalize this
>> code, make another approach? (Not insisting, just a suggestion)
>
> Thank you for the suggestion, Vitaly!
>
> The introduction of HV_HYP_PAGE_SIZE is weighing the assumption of the
> future page size—it can be bigger based on the general trend, not
> smaller, which is a reasonable assumption, I think.
>

Let's spell it out (as BUILD_BUG_ON(HV_HYP_PAGE_SIZE < PAGE_SIZE) or
something like that) then to make it clear.

-- 
Vitaly
