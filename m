Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 865B426A2FD
	for <lists+linux-hyperv@lfdr.de>; Tue, 15 Sep 2020 12:17:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726169AbgIOKRH (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 15 Sep 2020 06:17:07 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:53895 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726095AbgIOKRF (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 15 Sep 2020 06:17:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600165023;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lvDxiNfszvjzZ71NMuSHhOpWhvbYiEYO1BfYGhw1hYw=;
        b=bFSgoidacUQBpsh3c7jcYbCvWPPpmd6JXw+fsdVD4t4bEjhiB1AznJQIX/T3PQZGRoroYp
        ew3yYdKKauo2MiqLn0QuL3dbNAbCJVZJ94n1tfw1GY6cchS0QbIhroAk9Wn9lXECsK1k4o
        9lvpoRv1CSNP1S9uiG+CC2s0yhL2mHA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-252-7tODOkQGPGG3ZkBdmAgpIA-1; Tue, 15 Sep 2020 06:17:02 -0400
X-MC-Unique: 7tODOkQGPGG3ZkBdmAgpIA-1
Received: by mail-wr1-f71.google.com with SMTP id v5so1028106wrs.17
        for <linux-hyperv@vger.kernel.org>; Tue, 15 Sep 2020 03:17:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=lvDxiNfszvjzZ71NMuSHhOpWhvbYiEYO1BfYGhw1hYw=;
        b=KLmVTKx3ZXhF395ngiyBqhzNCs4GeVN4HY4CVyFtM6sXCKz4B0HQvy23XEJSGkHQHS
         nm8h3cqaxHirLMy1YzfF3Vp4Pg70bzjSE9SVjzs7maqj0l5SRCRhgaIAWfGYW2G6QHv9
         EFQQ11oahVrhE1QKiyWfEdW9ccY74pWB9VWU03g3MR8D7yfmPNpeC2LTfRQ1/ScvAGOa
         hgx/bhA7Zt0nI+EweVoU80FSsj3YHgXOzu1E35/lG+oidscki38mWbBXBrCAIrDQhV/p
         JDwI7LeynOvvu3e2pAXbkI/APYGlPTmNzuH13W0IG0MKY+3Fh7Am4woBZHFDvk3d1pdi
         o60Q==
X-Gm-Message-State: AOAM531rJSGIBmjC9AYHSHwjfftC4zXgGHLwhecUhvH/wbRB+oSp7AcM
        fgGSK9tRYCzYxgM0RuGpyf9ziiy5U/2QAh8Bfh2m5z+AVYjZ/eto7BMSiSp9qB/5GCw2M+k95K7
        JW9rISlylquKs6t2VROjuiqrz
X-Received: by 2002:a5d:4ccc:: with SMTP id c12mr20381521wrt.160.1600165020818;
        Tue, 15 Sep 2020 03:17:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzbSRV/JarLXH4jdQkPEdpmjY/jHaczd6pEh5Z7HCZ1RyRuon98yVLOetuc0w33FBKkbh666g==
X-Received: by 2002:a5d:4ccc:: with SMTP id c12mr20381495wrt.160.1600165020611;
        Tue, 15 Sep 2020 03:17:00 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id t17sm1559921wrx.82.2020.09.15.03.16.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2020 03:17:00 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Wei Liu <wei.liu@kernel.org>,
        Linux on Hyper-V List <linux-hyperv@vger.kernel.org>
Cc:     virtualization@lists.linux-foundation.org,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Nuno Das Neves <nudasnev@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Lillian Grassin-Drake <ligrassi@microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "maintainer\:X86 ARCHITECTURE \(32-BIT AND 64-BIT\)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH RFC v1 06/18] x86/hyperv: allocate output arg pages if required
In-Reply-To: <20200914112802.80611-7-wei.liu@kernel.org>
References: <20200914112802.80611-1-wei.liu@kernel.org> <20200914112802.80611-7-wei.liu@kernel.org>
Date:   Tue, 15 Sep 2020 12:16:58 +0200
Message-ID: <871rj3l4yt.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-hyperv-owner@vger.kernel.org
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
>  arch/x86/hyperv/hv_init.c       | 45 +++++++++++++++++++++++++++++----
>  arch/x86/include/asm/mshyperv.h |  1 +
>  2 files changed, 41 insertions(+), 5 deletions(-)
>
> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> index cac8e4c56261..ebba4be4185d 100644
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
> @@ -75,14 +78,29 @@ static int hv_cpu_init(unsigned int cpu)
>  	u64 msr_vp_index;
>  	struct hv_vp_assist_page **hvp = &hv_vp_assist_page[smp_processor_id()];
>  	void **input_arg;
> -	struct page *pg;
> +	struct page *input_pg;
>  
>  	input_arg = (void **)this_cpu_ptr(hyperv_pcpu_input_arg);
>  	/* hv_cpu_init() can be called with IRQs disabled from hv_resume() */
> -	pg = alloc_page(irqs_disabled() ? GFP_ATOMIC : GFP_KERNEL);
> -	if (unlikely(!pg))
> +	input_pg = alloc_page(irqs_disabled() ? GFP_ATOMIC : GFP_KERNEL);
> +	if (unlikely(!input_pg))
>  		return -ENOMEM;
> -	*input_arg = page_address(pg);
> +	*input_arg = page_address(input_pg);
> +
> +	if (hv_root_partition) {
> +		struct page *output_pg;
> +		void **output_arg;
> +
> +		output_pg = alloc_page(irqs_disabled() ? GFP_ATOMIC :
>  	GFP_KERNEL);

To simplify the code, can we just rename 'input_arg' to 'hypercall_args'
and do alloc_pages(rqs_disabled() ? GFP_ATOMIC : GFP_KERNEL, 1) to
allocate two pages above?

> +		if (unlikely(!output_pg)) {
> +			free_page((unsigned long)*input_arg);
> +			*input_arg = NULL;
> +			return -ENOMEM;
> +		}
> +
> +		output_arg = (void **)this_cpu_ptr(hyperv_pcpu_output_arg);
> +		*output_arg = page_address(output_pg);
> +	}
>  
>  	hv_get_vp_index(msr_vp_index);
>  
> @@ -209,14 +227,25 @@ static int hv_cpu_die(unsigned int cpu)
>  	unsigned int new_cpu;
>  	unsigned long flags;
>  	void **input_arg;
> -	void *input_pg = NULL;
> +	void *input_pg = NULL, *output_pg = NULL;
>  
>  	local_irq_save(flags);
>  	input_arg = (void **)this_cpu_ptr(hyperv_pcpu_input_arg);
>  	input_pg = *input_arg;
>  	*input_arg = NULL;
> +
> +	if (hv_root_partition) {
> +		void **output_arg;
> +
> +		output_arg = (void **)this_cpu_ptr(hyperv_pcpu_output_arg);
> +		output_pg = *output_arg;
> +		*output_arg = NULL;
> +	}
> +
>  	local_irq_restore(flags);
> +
>  	free_page((unsigned long)input_pg);
> +	free_page((unsigned long)output_pg);
>  
>  	if (hv_vp_assist_page && hv_vp_assist_page[cpu])
>  		wrmsrl(HV_X64_MSR_VP_ASSIST_PAGE, 0);
> @@ -350,6 +379,12 @@ void __init hyperv_init(void)
>  
>  	BUG_ON(hyperv_pcpu_input_arg == NULL);
>  
> +	/* Allocate the per-CPU state for output arg for root */
> +	if (hv_root_partition) {
> +		hyperv_pcpu_output_arg = alloc_percpu(void  *);
					redundant space ^^^^^

> +		BUG_ON(hyperv_pcpu_output_arg == NULL);
> +	}
> +
>  	/* Allocate percpu VP index */
>  	hv_vp_index = kmalloc_array(num_possible_cpus(), sizeof(*hv_vp_index),
>  				    GFP_KERNEL);
> diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
> index 2a2cc81beac6..f5c62140f28d 100644
> --- a/arch/x86/include/asm/mshyperv.h
> +++ b/arch/x86/include/asm/mshyperv.h
> @@ -63,6 +63,7 @@ static inline void hv_disable_stimer0_percpu_irq(int irq) {}
>  #if IS_ENABLED(CONFIG_HYPERV)
>  extern void *hv_hypercall_pg;
>  extern void  __percpu  **hyperv_pcpu_input_arg;
> +extern void  __percpu  **hyperv_pcpu_output_arg;
>  
>  static inline u64 hv_do_hypercall(u64 control, void *input, void *output)
>  {

-- 
Vitaly

