Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B47BD2B087A
	for <lists+linux-hyperv@lfdr.de>; Thu, 12 Nov 2020 16:35:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728345AbgKLPf4 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 12 Nov 2020 10:35:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:60138 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727796AbgKLPfz (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 12 Nov 2020 10:35:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605195353;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kY0AiU5FU6oVbA1XAM3cZ9/C4ZQ8vxNIxYPcv88wzRE=;
        b=iiQIDqhPJjxo+gbWGltOR3qhNy2trAZqsHDL7nln0VJ33o6VhJQBBwC2zg+DpTXIvASdye
        ofLV/7IdB46xDbFi1lNh0Pc/SH6gph5S0aMmb7BwGcnDbsUnW696+841KTDOuTG2l4Nah9
        aC9JcXg5P1x9eKokbLfuqXTW41oAdow=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-324-gA-86X86OCyVO0gLY-jDpA-1; Thu, 12 Nov 2020 10:35:52 -0500
X-MC-Unique: gA-86X86OCyVO0gLY-jDpA-1
Received: by mail-wm1-f69.google.com with SMTP id o19so2307108wme.2
        for <linux-hyperv@vger.kernel.org>; Thu, 12 Nov 2020 07:35:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=kY0AiU5FU6oVbA1XAM3cZ9/C4ZQ8vxNIxYPcv88wzRE=;
        b=hNGmN/dp5j49NNF8xYUOO6dZX0f5KW+ZZ9sQpjd0qlLdzmhkCPvgC5WqnjI0eC3AgJ
         fTwRI1/bs/OBh6TXeDgx/duSY81rylOVELpa8gXjjYhBTHNgumXaxrGM9i+X7FRDPaWu
         WV1HsqEcaF64asa0gjGq9Z/ivuoO3A157ugAQCxztKNACAU49IEGqByx/rnXqJ70uIP/
         5DHiCFpcbINJaRidVqiQYgM5VUczeopYtQQKE9ajEj8c+FWcPegx1l2/FjfkX/8iCNpT
         idf2iF0OwjTVcGzecC/shNa3AgOtR0XTUbGHPxPqAX7XAxLqXUW7sEbclsXc/1s/2RCj
         ReHg==
X-Gm-Message-State: AOAM5302xEySOmmgWble9FPtHaVfHuhOLOdzPYkFhoCDoL4uMOUdfq3f
        jLqo+tolrWo8ug6zVffphsLMNfLKiizncRVYpxDcl31oUCpqBVdGOB593+UcYUSmFgR1dtQZFnt
        qn9UzBmvSJ8cLrG5kwNBjmwi3
X-Received: by 2002:a5d:5308:: with SMTP id e8mr60526wrv.299.1605195350613;
        Thu, 12 Nov 2020 07:35:50 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyX+g1Xxy4OaSz6R8CmLM779s2IPaL2uIDtQKDL0WAaJDiYdwAr+Qec54DwIygNSmyCPc/rjA==
X-Received: by 2002:a5d:5308:: with SMTP id e8mr60496wrv.299.1605195350447;
        Thu, 12 Nov 2020 07:35:50 -0800 (PST)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id 60sm4066744wrs.69.2020.11.12.07.35.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 07:35:49 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Wei Liu <wei.liu@kernel.org>,
        Linux on Hyper-V List <linux-hyperv@vger.kernel.org>
Cc:     virtualization@lists.linux-foundation.org,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Nuno Das Neves <nunodasneves@linux.microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Lillian Grassin-Drake <ligrassi@microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v2 06/17] x86/hyperv: allocate output arg pages if required
In-Reply-To: <20201105165814.29233-7-wei.liu@kernel.org>
References: <20201105165814.29233-1-wei.liu@kernel.org>
 <20201105165814.29233-7-wei.liu@kernel.org>
Date:   Thu, 12 Nov 2020 16:35:48 +0100
Message-ID: <87a6vmy4dn.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Wei Liu <wei.liu@kernel.org> writes:

> When Linux runs as the root partition, it will need to make hypercalls
> which return data from the hypervisor.
>
> Allocate pages for storing results when Linux runs as the root
> partition.
>
> Signed-off-by: Lillian Grassin-Drake <ligrassi@microsoft.com>
> Co-Developed-by: Lillian Grassin-Drake <ligrassi@microsoft.com>
> Signed-off-by: Wei Liu <wei.liu@kernel.org>
> ---
> v2: Address Vitaly's comments
> ---
>  arch/x86/hyperv/hv_init.c       | 35 ++++++++++++++++++++++++++++-----
>  arch/x86/include/asm/mshyperv.h |  1 +
>  2 files changed, 31 insertions(+), 5 deletions(-)
>
> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> index 533fe9e887f2..7a2e37f025b0 100644
> --- a/arch/x86/hyperv/hv_init.c
> +++ b/arch/x86/hyperv/hv_init.c
> @@ -45,6 +45,9 @@ EXPORT_SYMBOL_GPL(hv_vp_assist_page);
>  void  __percpu **hyperv_pcpu_input_arg;
>  EXPORT_SYMBOL_GPL(hyperv_pcpu_input_arg);
>  
> +void  __percpu **hyperv_pcpu_output_arg;
> +EXPORT_SYMBOL_GPL(hyperv_pcpu_output_arg);
> +
>  u32 hv_max_vp_index;
>  EXPORT_SYMBOL_GPL(hv_max_vp_index);
>  
> @@ -77,12 +80,19 @@ static int hv_cpu_init(unsigned int cpu)
>  	void **input_arg;
>  	struct page *pg;
>  
> -	input_arg = (void **)this_cpu_ptr(hyperv_pcpu_input_arg);
>  	/* hv_cpu_init() can be called with IRQs disabled from hv_resume() */
> -	pg = alloc_page(irqs_disabled() ? GFP_ATOMIC : GFP_KERNEL);
> +	pg = alloc_pages(irqs_disabled() ? GFP_ATOMIC : GFP_KERNEL, hv_root_partition ? 1 : 0);
>  	if (unlikely(!pg))
>  		return -ENOMEM;
> +
> +	input_arg = (void **)this_cpu_ptr(hyperv_pcpu_input_arg);
>  	*input_arg = page_address(pg);
> +	if (hv_root_partition) {
> +		void **output_arg;
> +
> +		output_arg = (void **)this_cpu_ptr(hyperv_pcpu_output_arg);
> +		*output_arg = page_address(pg + 1);
> +	}
>  
>  	hv_get_vp_index(msr_vp_index);
>  
> @@ -209,14 +219,23 @@ static int hv_cpu_die(unsigned int cpu)
>  	unsigned int new_cpu;
>  	unsigned long flags;
>  	void **input_arg;
> -	void *input_pg = NULL;
> +	void *pg;
>  
>  	local_irq_save(flags);
>  	input_arg = (void **)this_cpu_ptr(hyperv_pcpu_input_arg);
> -	input_pg = *input_arg;
> +	pg = *input_arg;
>  	*input_arg = NULL;
> +
> +	if (hv_root_partition) {
> +		void **output_arg;
> +
> +		output_arg = (void **)this_cpu_ptr(hyperv_pcpu_output_arg);
> +		*output_arg = NULL;
> +	}
> +
>  	local_irq_restore(flags);
> -	free_page((unsigned long)input_pg);
> +
> +	free_page((unsigned long)pg);
>  

Hm, but in case we've allocated output_arg, don't we need to do
	free_pages((unsigned long)pg, 1);

instead?

>  	if (hv_vp_assist_page && hv_vp_assist_page[cpu])
>  		wrmsrl(HV_X64_MSR_VP_ASSIST_PAGE, 0);
> @@ -350,6 +369,12 @@ void __init hyperv_init(void)
>  
>  	BUG_ON(hyperv_pcpu_input_arg == NULL);
>  
> +	/* Allocate the per-CPU state for output arg for root */
> +	if (hv_root_partition) {
> +		hyperv_pcpu_output_arg = alloc_percpu(void *);
> +		BUG_ON(hyperv_pcpu_output_arg == NULL);
> +	}
> +
>  	/* Allocate percpu VP index */
>  	hv_vp_index = kmalloc_array(num_possible_cpus(), sizeof(*hv_vp_index),
>  				    GFP_KERNEL);
> diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
> index ac2b0d110f03..62d9390f1ddf 100644
> --- a/arch/x86/include/asm/mshyperv.h
> +++ b/arch/x86/include/asm/mshyperv.h
> @@ -76,6 +76,7 @@ static inline void hv_disable_stimer0_percpu_irq(int irq) {}
>  #if IS_ENABLED(CONFIG_HYPERV)
>  extern void *hv_hypercall_pg;
>  extern void  __percpu  **hyperv_pcpu_input_arg;
> +extern void  __percpu  **hyperv_pcpu_output_arg;
>  
>  static inline u64 hv_do_hypercall(u64 control, void *input, void *output)
>  {

-- 
Vitaly

