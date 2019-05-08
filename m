Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3402C171DF
	for <lists+linux-hyperv@lfdr.de>; Wed,  8 May 2019 08:46:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725910AbfEHGqF (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 8 May 2019 02:46:05 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:35956 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726527AbfEHGqF (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 8 May 2019 02:46:05 -0400
Received: by mail-pl1-f196.google.com with SMTP id d21so1952199plr.3;
        Tue, 07 May 2019 23:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=4DUh9Xcm/+kqmJjlUuDP+kgdaf/m7nKRE3FjK2Rv110=;
        b=Hy8NDYrsqnZwnd9CfIDCFYNKEpEd9gKQcdtQmPWmnREKmprUM7peDj4+UQLeVIKKFe
         7Qw7mz2heQhEniNotufd5mzaYUDHnbRh4a53Di4iSNe5lccr7796R7fonx6WTJPlsHu+
         L7iOHauF+jbf9T/vSrsWWKg/n02K+4Dq2atIvFXPws68f2R8kPSLPkEaKCWE7xVzVeur
         LRyWIiB5jCj8GhbkKO8+pIqLbXu1NUHPUan7wvyEZEv2qeUYTNTYZUnsh16cf3fr3Dr0
         zGAuqE1kjMNpBUvDOwzg+N/5xEfU1JZD57cTn7kpirnWZaHbRCf6/lyi1cghgzqrwmG/
         n4cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=4DUh9Xcm/+kqmJjlUuDP+kgdaf/m7nKRE3FjK2Rv110=;
        b=ZPsqFi+hOTN8OEXudWBsuwwqZfznC4FOMa3pTNBOXi6TZk/1HTS23Mz2sRTgOfT/g/
         N/tPSeuYC+CPmgVhXfVHijrBHzB4qml8MyMAPEpyw/JMIbWrVJFGfj1At6vX5155/cEy
         vWIATgRddjCJxTRiFMcfhbCBcKR+s8tYL7tNFrM7ptpDf2QdQKFUClj18foT49dj8gTs
         IOYJ2/q6ljfeSIXZjUV+8i1QTh62X0oct80OIPGkFrqiFxEh4NJas57BnEAfwSM09XuB
         yhSrw/EFHm5LEHl5GCOSIZ8EM2SHNe9BYXc/4OMCkweqPbRQLriwl8FxjZVsaN4Wiw+Z
         x/BQ==
X-Gm-Message-State: APjAAAWlamPYaBGaTF+C1xVGqlu8v2Au+AtBCBJS0m7TEQmOOT8NXwPx
        lFddp2j0bIh/JlVeteAOl9433dDu3zE8ZA==
X-Google-Smtp-Source: APXvYqzNYhgPTvQOvaTTd6e7w+Nt3e97ZY7V+6OX4zzbAoi+KgoQYyvevP7E2LfOEEsKyIt+ShlZkg==
X-Received: by 2002:a17:902:b581:: with SMTP id a1mr10275191pls.206.1557297964208;
        Tue, 07 May 2019 23:46:04 -0700 (PDT)
Received: from maya190131 ([52.229.39.81])
        by smtp.gmail.com with ESMTPSA id c137sm26005567pfb.154.2019.05.07.23.46.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 May 2019 23:46:03 -0700 (PDT)
Date:   Wed, 8 May 2019 06:46:02 +0000
From:   Maya Nakamura <m.maya.nakamura@gmail.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     mikelley@microsoft.com, kys@microsoft.com, haiyangz@microsoft.com,
        sthemmin@microsoft.com, sashal@kernel.org, x86@kernel.org,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/6] x86: hv: hv_init.c: Replace alloc_page() with
 kmem_cache_alloc()
Message-ID: <20190508064559.GA54416@maya190131.isni1t2eisqetojrdim5hhf1se.xx.internal.cloudapp.net>
References: <cover.1554426039.git.m.maya.nakamura@gmail.com>
 <bdbacc872e369762a877af4415ad1b07054826db.1554426040.git.m.maya.nakamura@gmail.com>
 <87wok8it8p.fsf@vitty.brq.redhat.com>
 <20190412072401.GA69620@maya190131.isni1t2eisqetojrdim5hhf1se.xx.internal.cloudapp.net>
 <87mukvfynk.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87mukvfynk.fsf@vitty.brq.redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, Apr 12, 2019 at 09:52:47AM +0200, Vitaly Kuznetsov wrote:
> Maya Nakamura <m.maya.nakamura@gmail.com> writes:
> 
> > On Fri, Apr 05, 2019 at 01:31:02PM +0200, Vitaly Kuznetsov wrote:
> >> Maya Nakamura <m.maya.nakamura@gmail.com> writes:
> >> 
> >> > @@ -98,18 +99,20 @@ EXPORT_SYMBOL_GPL(hyperv_pcpu_input_arg);
> >> >  u32 hv_max_vp_index;
> >> >  EXPORT_SYMBOL_GPL(hv_max_vp_index);
> >> >  
> >> > +struct kmem_cache *cachep;
> >> > +EXPORT_SYMBOL_GPL(cachep);
> >> > +
> >> >  static int hv_cpu_init(unsigned int cpu)
> >> >  {
> >> >  	u64 msr_vp_index;
> >> >  	struct hv_vp_assist_page **hvp = &hv_vp_assist_page[smp_processor_id()];
> >> >  	void **input_arg;
> >> > -	struct page *pg;
> >> >  
> >> >  	input_arg = (void **)this_cpu_ptr(hyperv_pcpu_input_arg);
> >> > -	pg = alloc_page(GFP_KERNEL);
> >> > -	if (unlikely(!pg))
> >> > +	*input_arg = kmem_cache_alloc(cachep, GFP_KERNEL);
> >> 
> >> I'm not sure use of kmem_cache is justified here: pages we allocate are
> >> not cache-line and all these allocations are supposed to persist for the
> >> lifetime of the guest. In case you think that even on x86 it will be
> >> possible to see PAGE_SIZE != HV_HYP_PAGE_SIZE you can use alloc_pages()
> >> instead.
> >> 
> > Thank you for your feedback, Vitaly!
> >
> > Will you please tell me how cache-line relates to kmem_cache?
> >
> > I understand that alloc_pages() would work when PAGE_SIZE <=
> > HV_HYP_PAGE_SIZE, but I think that it would not work if PAGE_SIZE >
> > HV_HYP_PAGE_SIZE.
> 
> Sorry, my bad: I meant to say "not cache-like" (these allocations are
> not 'cache') but the typo made it completely incomprehensible. 
 
No worries! Thank you for sharing your thoughts with me, Vitaly.

Do you know of any alternatives to kmem_cache that can allocate memory
in a specified size (different than a guest page size) with alignment?
Memory allocated by alloc_page() is aligned but limited to the guest
page size, and kmalloc() can allocate a particular size but it seems
that it does not guarantee alignment. I am asking this while considering
the changes for architecture independent code.

> >> Also, in case the idea is to generalize stuff, what will happen if
> >> PAGE_SIZE > HV_HYP_PAGE_SIZE? Who will guarantee proper alignment?
> >> 
> >> I think we can leave hypercall arguments, vp_assist and similar pages
> >> alone for now: the code is not going to be shared among architectures
> >> anyways.
> >> 
> > About the alignment, kmem_cache_create() aligns memory with its third
> > parameter, offset.
> 
> Yes, I know, I was trying to think about a (hypothetical) situation when
> page sizes differ: what would be the memory alignment requirements from
> the hypervisor for e.g. hypercall arguments? In case it's always
> HV_HYP_PAGE_SIZE we're good but could it be PAGE_SIZE (for e.g. TLB
> flush hypercall)? I don't know. For x86 this discussion probably makes
> no sense. I'm, however, struggling to understand what benefit we will
> get from the change. Maybe just leave it as-is for now and fix
> arch-independent code only? And later, if we decide to generalize this
> code, make another approach? (Not insisting, just a suggestion)

Thank you for the suggestion, Vitaly!

The introduction of HV_HYP_PAGE_SIZE is weighing the assumption of the
future page size—it can be bigger based on the general trend, not
smaller, which is a reasonable assumption, I think.

> >> > @@ -338,7 +349,10 @@ void __init hyperv_init(void)
> >> >  	guest_id = generate_guest_id(0, LINUX_VERSION_CODE, 0);
> >> >  	wrmsrl(HV_X64_MSR_GUEST_OS_ID, guest_id);
> >> >  
> >> > -	hv_hypercall_pg  = __vmalloc(PAGE_SIZE, GFP_KERNEL, PAGE_KERNEL_RX);
> >> > +	hv_hypercall_pg = kmem_cache_alloc(cachep, GFP_KERNEL);
> >> > +	if (hv_hypercall_pg)
> >> > +		set_memory_x((unsigned long)hv_hypercall_pg, 1);
> >> 
> >> _RX is not writeable, right?
> >> 
> > Yes, you are correct. I should use set_memory_ro() in addition to
> > set_memory_x().
> >
> >> > @@ -416,6 +431,7 @@ void hyperv_cleanup(void)
> >> >  	 * let hypercall operations fail safely rather than
> >> >  	 * panic the kernel for using invalid hypercall page
> >> >  	 */
> >> > +	kmem_cache_free(cachep, hv_hypercall_pg);
> >> 
> >> Please don't do that: hyperv_cleanup() is called on kexec/kdump and
> >> we're trying to do the bare minimum to allow next kernel to boot. Doing
> >> excessive work here will likely lead to consequent problems (we're
> >> already crashing the case it's kdump!).
> >> 
> > Thank you for the explanation! I will remove that.
> >
> 
> -- 
> Vitaly
