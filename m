Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9C5A305998
	for <lists+linux-hyperv@lfdr.de>; Wed, 27 Jan 2021 12:26:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S313371AbhAZW5L (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 26 Jan 2021 17:57:11 -0500
Received: from mail-wr1-f51.google.com ([209.85.221.51]:36787 "EHLO
        mail-wr1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389836AbhAZSKd (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 26 Jan 2021 13:10:33 -0500
Received: by mail-wr1-f51.google.com with SMTP id 6so17476227wri.3;
        Tue, 26 Jan 2021 10:10:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yAMoXzLcjrWPt500TAMZczC/o1tGq6IfnACyff/bf1c=;
        b=Y3oO78H5qBlSetyTgNINSorGhroRNIFH1RDISzRBv27s4ho7A0is07ihMUcYgtvI9z
         hG4sgiw4ltai/TkYcbjsA0B2bxyJf6YpIWCm277eB0qIVqk6aMRyLFr1DGj2f6bE/Iz7
         HgFgPUqMkoq44DGe+UpATqR8mkgrrNKHPuJvsuoUP/iz89mdP/Gks2Q7boLe68OUA93C
         zaf0LPzeTODyWXcaMyVRLKkwXvC5ncjgH6ARoFkeP6kuPoObQto9c2w9jFjGpTthAw06
         KGi8lIprvl5PZ7Chqsl4krTtHlSmnbtk3utCkaf7SN2++Es9dnvh/O11X0LpSRNxnN94
         Szow==
X-Gm-Message-State: AOAM532ANkqsWar9Ta+9F199B1+8wgMFFQi9Hjc6Jn7j/zagxd2eCQvL
        REbUkYYy6k7DWhKffrtewUg=
X-Google-Smtp-Source: ABdhPJxOk0RPGHODs7Wf5z6WHeBaHwSB8GV9/rasLcI8APf8d6GbKCSmbW7PWVn5fGKW6w37JK5Gxw==
X-Received: by 2002:a5d:6351:: with SMTP id b17mr7332167wrw.410.1611684590871;
        Tue, 26 Jan 2021 10:09:50 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id h18sm8778091wru.65.2021.01.26.10.09.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 10:09:50 -0800 (PST)
Date:   Tue, 26 Jan 2021 18:09:48 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     Wei Liu <wei.liu@kernel.org>,
        Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Nuno Das Neves <nunodasneves@linux.microsoft.com>,
        "pasha.tatashin@soleen.com" <pasha.tatashin@soleen.com>,
        Lillian Grassin-Drake <Lillian.GrassinDrake@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v5 06/16] x86/hyperv: allocate output arg pages if
 required
Message-ID: <20210126180948.mytpoenruhx4g43u@liuwe-devbox-debian-v2>
References: <20210120120058.29138-1-wei.liu@kernel.org>
 <20210120120058.29138-7-wei.liu@kernel.org>
 <MWHPR21MB15938593C5E118766FECB58FD7BC9@MWHPR21MB1593.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MWHPR21MB15938593C5E118766FECB58FD7BC9@MWHPR21MB1593.namprd21.prod.outlook.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Jan 26, 2021 at 12:41:05AM +0000, Michael Kelley wrote:
> From: Wei Liu <wei.liu@kernel.org> Sent: Wednesday, January 20, 2021 4:01 AM
> > 
> > When Linux runs as the root partition, it will need to make hypercalls
> > which return data from the hypervisor.
> > 
> > Allocate pages for storing results when Linux runs as the root
> > partition.
> > 
> > Signed-off-by: Lillian Grassin-Drake <ligrassi@microsoft.com>
> > Co-Developed-by: Lillian Grassin-Drake <ligrassi@microsoft.com>
> > Signed-off-by: Wei Liu <wei.liu@kernel.org>
> > ---
> > v3: Fix hv_cpu_die to use free_pages.
> > v2: Address Vitaly's comments
> > ---
> >  arch/x86/hyperv/hv_init.c       | 35 ++++++++++++++++++++++++++++-----
> >  arch/x86/include/asm/mshyperv.h |  1 +
> >  2 files changed, 31 insertions(+), 5 deletions(-)
> > 
> > diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> > index e04d90af4c27..6f4cb40e53fe 100644
> > --- a/arch/x86/hyperv/hv_init.c
> > +++ b/arch/x86/hyperv/hv_init.c
> > @@ -41,6 +41,9 @@ EXPORT_SYMBOL_GPL(hv_vp_assist_page);
> >  void  __percpu **hyperv_pcpu_input_arg;
> >  EXPORT_SYMBOL_GPL(hyperv_pcpu_input_arg);
> > 
> > +void  __percpu **hyperv_pcpu_output_arg;
> > +EXPORT_SYMBOL_GPL(hyperv_pcpu_output_arg);
> > +
> >  u32 hv_max_vp_index;
> >  EXPORT_SYMBOL_GPL(hv_max_vp_index);
> > 
> > @@ -73,12 +76,19 @@ static int hv_cpu_init(unsigned int cpu)
> >  	void **input_arg;
> >  	struct page *pg;
> > 
> > -	input_arg = (void **)this_cpu_ptr(hyperv_pcpu_input_arg);
> >  	/* hv_cpu_init() can be called with IRQs disabled from hv_resume() */
> > -	pg = alloc_page(irqs_disabled() ? GFP_ATOMIC : GFP_KERNEL);
> > +	pg = alloc_pages(irqs_disabled() ? GFP_ATOMIC : GFP_KERNEL, hv_root_partition ?
> > 1 : 0);
> >  	if (unlikely(!pg))
> >  		return -ENOMEM;
> > +
> > +	input_arg = (void **)this_cpu_ptr(hyperv_pcpu_input_arg);
> >  	*input_arg = page_address(pg);
> > +	if (hv_root_partition) {
> > +		void **output_arg;
> > +
> > +		output_arg = (void **)this_cpu_ptr(hyperv_pcpu_output_arg);
> > +		*output_arg = page_address(pg + 1);
> > +	}
> > 
> >  	hv_get_vp_index(msr_vp_index);
> > 
> > @@ -205,14 +215,23 @@ static int hv_cpu_die(unsigned int cpu)
> >  	unsigned int new_cpu;
> >  	unsigned long flags;
> >  	void **input_arg;
> > -	void *input_pg = NULL;
> > +	void *pg;
> > 
> >  	local_irq_save(flags);
> >  	input_arg = (void **)this_cpu_ptr(hyperv_pcpu_input_arg);
> > -	input_pg = *input_arg;
> > +	pg = *input_arg;
> >  	*input_arg = NULL;
> > +
> > +	if (hv_root_partition) {
> > +		void **output_arg;
> > +
> > +		output_arg = (void **)this_cpu_ptr(hyperv_pcpu_output_arg);
> > +		*output_arg = NULL;
> > +	}
> > +
> >  	local_irq_restore(flags);
> > -	free_page((unsigned long)input_pg);
> > +
> > +	free_pages((unsigned long)pg, hv_root_partition ? 1 : 0);
> > 
> >  	if (hv_vp_assist_page && hv_vp_assist_page[cpu])
> >  		wrmsrl(HV_X64_MSR_VP_ASSIST_PAGE, 0);
> > @@ -346,6 +365,12 @@ void __init hyperv_init(void)
> > 
> >  	BUG_ON(hyperv_pcpu_input_arg == NULL);
> > 
> > +	/* Allocate the per-CPU state for output arg for root */
> > +	if (hv_root_partition) {
> > +		hyperv_pcpu_output_arg = alloc_percpu(void *);
> > +		BUG_ON(hyperv_pcpu_output_arg == NULL);
> > +	}
> > +
> >  	/* Allocate percpu VP index */
> >  	hv_vp_index = kmalloc_array(num_possible_cpus(), sizeof(*hv_vp_index),
> >  				    GFP_KERNEL);
> > diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
> > index ac2b0d110f03..62d9390f1ddf 100644
> > --- a/arch/x86/include/asm/mshyperv.h
> > +++ b/arch/x86/include/asm/mshyperv.h
> > @@ -76,6 +76,7 @@ static inline void hv_disable_stimer0_percpu_irq(int irq) {}
> >  #if IS_ENABLED(CONFIG_HYPERV)
> >  extern void *hv_hypercall_pg;
> >  extern void  __percpu  **hyperv_pcpu_input_arg;
> > +extern void  __percpu  **hyperv_pcpu_output_arg;
> > 
> >  static inline u64 hv_do_hypercall(u64 control, void *input, void *output)
> >  {
> > --
> > 2.20.1
> 
> I think this all works OK.  But a meta question:  Do we need a separate
> per-cpu output argument page?  From the Hyper-V hypercall standpoint, I
> don't think input and output args need to be in separate pages.  They both

That's correct. They don't have to be in separate pages.

> just need to not cross a page boundary.  As long as we don't have a hypercall
> where the sum of the sizes of the input and output args exceeds a page,
> we could just have a single page, and split it up in any manner that works
> for the particular hypercall.
> 

There is one more requirement: The pointers must be 8-byte aligned. That
means we may need to explicitly pad things a bit. That quickly becomes
tedious if we do it in every call site; or we will need to provide a
macro to do the calculation correctly.

Another consideration is hypercalls that take variable-length input /
output. Admittedly I haven't seen one that takes variable-length
arguments and needs to do input and output at the same time, I wouldn't
want to paint ourselves into the corner now because sizing
variable-length input and output at the same time can be non-trivial.

Wei.

> Thoughts?
> 
> Michael
> 
> 
