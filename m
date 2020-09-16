Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BE8526CDE4
	for <lists+linux-hyperv@lfdr.de>; Wed, 16 Sep 2020 23:07:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726627AbgIPVG5 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 16 Sep 2020 17:06:57 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55566 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726401AbgIPQOr (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 16 Sep 2020 12:14:47 -0400
Received: by mail-wm1-f68.google.com with SMTP id d4so3340641wmd.5
        for <linux-hyperv@vger.kernel.org>; Wed, 16 Sep 2020 09:14:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=G2L3TW2WxV4GsWXWBBVjTC9AR//at+StzHS5DH3Oqf0=;
        b=XTRy9q0WJmEEfr+olt7cp4NPBdLK8Y5ZTjXik5WfGg7CDqkbC+XP4G5ZbQGqiI3+y6
         pAakXdLMGZYVjfrrI1V5sTZf+4RBokZE807mOV3ugJSS4xCpieUtswn4OMKP0V60HJNr
         oV7iKsGARpgryO+I+12+OeMdBSJI3u9zXVnaPr8CV3ippsn91lpuYtXSVQthpuMWdKEd
         PTHOO2YWVgYYuJ7IzNDUv9UFZlzL9tAyS5CHC5X+Ew/ra+s7BC/g/0eIrszBi8Mvqkzd
         qHJnmxQgaKyY4HK8Kq7J9caP0/ZLSCb/NWn/0Wz3+ohbNG9lqPGvWPvBtyU6vZvbVcKm
         rPxg==
X-Gm-Message-State: AOAM531+/B+Be+Grkqrn2qD8KIvCl50gSu9VxEXAseyXnV2f+Uz7dUsZ
        MknhDWiWYljq0w/xHTqMmPQb/JBPRO4=
X-Google-Smtp-Source: ABdhPJwKDhptBJ/g7u54/YxLQysgEgYHB3c+TuF55KTGGzFdShYpmn2p1D0pmCSDGTuWaA29gAzqPw==
X-Received: by 2002:a05:600c:410e:: with SMTP id j14mr5699106wmi.13.1600270923209;
        Wed, 16 Sep 2020 08:42:03 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id t22sm7228468wmt.1.2020.09.16.08.42.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2020 08:42:02 -0700 (PDT)
Date:   Wed, 16 Sep 2020 15:42:00 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     Wei Liu <wei.liu@kernel.org>,
        Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
        virtualization@lists.linux-foundation.org,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Nuno Das Neves <nudasnev@microsoft.com>,
        Lillian Grassin-Drake <ligrassi@microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH RFC v1 06/18] x86/hyperv: allocate output arg pages if
 required
Message-ID: <20200916154200.7nf74vjmqu3f6sfq@liuwe-devbox-debian-v2>
References: <20200914112802.80611-1-wei.liu@kernel.org>
 <20200914112802.80611-7-wei.liu@kernel.org>
 <871rj3l4yt.fsf@vitty.brq.redhat.com>
 <20200915124318.z6tisek5y4d7e254@liuwe-devbox-debian-v2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200915124318.z6tisek5y4d7e254@liuwe-devbox-debian-v2>
User-Agent: NeoMutt/20180716
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Sep 15, 2020 at 12:43:18PM +0000, Wei Liu wrote:
> On Tue, Sep 15, 2020 at 12:16:58PM +0200, Vitaly Kuznetsov wrote:
> > Wei Liu <wei.liu@kernel.org> writes:
> > 
> > > When Linux runs as the root partition, it will need to make hypercalls
> > > which return data from the hypervisor.
> > >
> > > Allocate pages for storing results when Linux runs as the root
> > > partition.
> > >
> > > Signed-off-by: Lillian Grassin-Drake <ligrassi@microsoft.com>
> > > Co-Developed-by: Lillian Grassin-Drake <ligrassi@microsoft.com>
> > > Signed-off-by: Wei Liu <wei.liu@kernel.org>
> > > ---
> > >  arch/x86/hyperv/hv_init.c       | 45 +++++++++++++++++++++++++++++----
> > >  arch/x86/include/asm/mshyperv.h |  1 +
> > >  2 files changed, 41 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> > > index cac8e4c56261..ebba4be4185d 100644
> > > --- a/arch/x86/hyperv/hv_init.c
> > > +++ b/arch/x86/hyperv/hv_init.c
> > > @@ -45,6 +45,9 @@ EXPORT_SYMBOL_GPL(hv_vp_assist_page);
> > >  void  __percpu **hyperv_pcpu_input_arg;
> > >  EXPORT_SYMBOL_GPL(hyperv_pcpu_input_arg);
> > >  
> > > +void  __percpu **hyperv_pcpu_output_arg;
> > > +EXPORT_SYMBOL_GPL(hyperv_pcpu_output_arg);
> > > +
> > >  u32 hv_max_vp_index;
> > >  EXPORT_SYMBOL_GPL(hv_max_vp_index);
> > >  
> > > @@ -75,14 +78,29 @@ static int hv_cpu_init(unsigned int cpu)
> > >  	u64 msr_vp_index;
> > >  	struct hv_vp_assist_page **hvp = &hv_vp_assist_page[smp_processor_id()];
> > >  	void **input_arg;
> > > -	struct page *pg;
> > > +	struct page *input_pg;
> > >  
> > >  	input_arg = (void **)this_cpu_ptr(hyperv_pcpu_input_arg);
> > >  	/* hv_cpu_init() can be called with IRQs disabled from hv_resume() */
> > > -	pg = alloc_page(irqs_disabled() ? GFP_ATOMIC : GFP_KERNEL);
> > > -	if (unlikely(!pg))
> > > +	input_pg = alloc_page(irqs_disabled() ? GFP_ATOMIC : GFP_KERNEL);
> > > +	if (unlikely(!input_pg))
> > >  		return -ENOMEM;
> > > -	*input_arg = page_address(pg);
> > > +	*input_arg = page_address(input_pg);
> > > +
> > > +	if (hv_root_partition) {
> > > +		struct page *output_pg;
> > > +		void **output_arg;
> > > +
> > > +		output_pg = alloc_page(irqs_disabled() ? GFP_ATOMIC :
> > >  	GFP_KERNEL);
> > 
> > To simplify the code, can we just rename 'input_arg' to 'hypercall_args'
> > and do alloc_pages(rqs_disabled() ? GFP_ATOMIC : GFP_KERNEL, 1) to
> > allocate two pages above?
> 
> It should be doable, but I need to code it up and test it to be 100%
> sure.
> 

I switch to alloc_pages to allocate an order of 2 page if necessary, but
I keep input_arg and output_arg separate because I want to avoid code
churn in other places.

Wei.

> > 
> > >  
> [...]
> > > +	/* Allocate the per-CPU state for output arg for root */
> > > +	if (hv_root_partition) {
> > > +		hyperv_pcpu_output_arg = alloc_percpu(void  *);
> > 					redundant space ^^^^^
> 
> Fixed. Thanks. This is in fact copied from the input_arg code, so there
> is a similar issue there to be fixed. But that's going to wait till
> another day.
> 
> Wei.
