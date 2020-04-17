Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67D511AD973
	for <lists+linux-hyperv@lfdr.de>; Fri, 17 Apr 2020 11:07:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729920AbgDQJHy (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 17 Apr 2020 05:07:54 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33051 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730084AbgDQJHx (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 17 Apr 2020 05:07:53 -0400
Received: by mail-wr1-f66.google.com with SMTP id a25so2216877wrd.0;
        Fri, 17 Apr 2020 02:07:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wI1y55Y/XC9CdKur/Gvt3DrDzcYQSGQGj6KuNobCV78=;
        b=RqYvg1YGWad1tXa46xDz+0FkPhMs4Fa1UZMoC+LiH7w+hVl9/D6jC4PcyMlLDg/bJG
         sPdJ8rrpQjxzwnNtby5j01WUrp13AE7kJz0lH8kHAm8z9lJQMjRHKP7cZDcOqC+6CoFZ
         C8AJVEZlYsr183GNkczb9yAJgleJV3Oivf806O9YM/xf7Qb0mKWQH8TdNbLOk5s41zd3
         EOLrzjCtQv8FZdXbUauP2Fsq2ofIy927Qyjh8IpNg3f6p9F8ziJHBm38g202D5ftL4uP
         kix3KiF7Jo9NQ3bl3XXcZMAyMiJC4L1sXN15/c/n81l6BodiuyaRJcW+ciViTQ73Vbs9
         Bg+w==
X-Gm-Message-State: AGi0PubzcZ0OCEeiC6B0TebvA++J2Zcplhmy/F4mcr3dbSzHnKoGsaBt
        HfmoZp7JAyocy39Pzo2rG6s=
X-Google-Smtp-Source: APiQypLIg1+NQJW8jorDaVZkvYD3niYOCvGrTyxkL2so7CrQI1HnQGwn8Y/g2jYqTBVczisANFScpA==
X-Received: by 2002:a5d:62cc:: with SMTP id o12mr2723067wrv.75.1587114471734;
        Fri, 17 Apr 2020 02:07:51 -0700 (PDT)
Received: from debian (44.142.6.51.dyn.plus.net. [51.6.142.44])
        by smtp.gmail.com with ESMTPSA id t13sm15183746wre.70.2020.04.17.02.07.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2020 02:07:50 -0700 (PDT)
Date:   Fri, 17 Apr 2020 10:07:48 +0100
From:   Wei Liu <wei.liu@kernel.org>
To:     Dexuan Cui <decui@microsoft.com>
Cc:     bp@alien8.de, haiyangz@microsoft.com, hpa@zytor.com,
        kys@microsoft.com, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        sthemmin@microsoft.com, tglx@linutronix.de, x86@kernel.org,
        mikelley@microsoft.com, vkuznets@redhat.com, wei.liu@kernel.org
Subject: Re: [PATCH] x86/hyperv: Suspend/resume the VP assist page for
 hibernation
Message-ID: <20200417090748.r2c45se5paqz5766@debian>
References: <1587104999-28927-1-git-send-email-decui@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1587104999-28927-1-git-send-email-decui@microsoft.com>
User-Agent: NeoMutt/20180716
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, Apr 16, 2020 at 11:29:59PM -0700, Dexuan Cui wrote:
> Unlike the other CPUs, CPU0 is never offlined during hibernation. So in the
> resume path, the "new" kernel's VP assist page is not suspended (i.e.
> disabled), and later when we jump to the "old" kernel, the page is not
> properly re-enabled for CPU0 with the allocated page from the old kernel.
> 
> So far, the VP assist page is only used by hv_apic_eoi_write(). When the
> page is not properly re-enabled, hvp->apic_assist is always 0, so the
> HV_X64_MSR_EOI MSR is always written. This is not ideal with respect to
> performance, but Hyper-V can still correctly handle this.
> 
> The issue is: the hypervisor can corrupt the old kernel memory, and hence
> sometimes cause unexpected behaviors, e.g. when the old kernel's non-boot
> CPUs are being onlined in the resume path, the VM can hang or be killed
> due to virtual triple fault.
> 
> Fix the issue by calling hv_cpu_die()/hv_cpu_init() in the syscore ops.
> 
> Without the fix, hibernation can fail at a rate of 1/300 ~ 1/500.
> With the fix, hibernation can pass a long-haul test of 2000 rounds.
> 
> Fixes: 05bd330a7fd8 ("x86/hyperv: Suspend/resume the hypercall page for hibernation")
> Cc: stable@vger.kernel.org
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> ---
>  arch/x86/hyperv/hv_init.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> index b0da5320bcff..4d3ce86331a3 100644
> --- a/arch/x86/hyperv/hv_init.c
> +++ b/arch/x86/hyperv/hv_init.c
> @@ -72,7 +72,8 @@ static int hv_cpu_init(unsigned int cpu)
>  	struct page *pg;
>  
>  	input_arg = (void **)this_cpu_ptr(hyperv_pcpu_input_arg);
> -	pg = alloc_page(GFP_KERNEL);
> +	/* hv_cpu_init() can be called with IRQs disabled from hv_resume() */
> +	pg = alloc_page(GFP_ATOMIC);

IMHO it would be better to  only tap into the reserve pool if so
required, e.g.

        pg = alloc_page(irqs_disabled() ? GFP_ATOMIC : GFP_KERNEL);

Wei.
