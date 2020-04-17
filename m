Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2FF51ADBC9
	for <lists+linux-hyperv@lfdr.de>; Fri, 17 Apr 2020 13:00:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729682AbgDQLAM (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 17 Apr 2020 07:00:12 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39939 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729558AbgDQLAM (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 17 Apr 2020 07:00:12 -0400
Received: by mail-wm1-f66.google.com with SMTP id a81so2511042wmf.5;
        Fri, 17 Apr 2020 04:00:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LhgE/f1EBRGWX6Y4huoPpvwd2o6+jMydBsQ1KJjHv1Q=;
        b=RJovW3JPEWReiDFh5xm7qArlaRAq56a7g00/5GsGCQKxyni+vnxElx0fkHTgZTTz9a
         R+Zj6VuBOuxHBc//OBzKMraZxQbjlxEz6K3lXrF6+oUSxYXEHITRZMqPRSOn4Mk+ZKTE
         /j4QRlOOjodOHvb1qqooqkhpA9X86iYoa3EEnIdqrwXTfvV1Hj8lnIL37i8UQ9uk3+u7
         kiJMkkGprEdpePmjHkcLM9dPKuTgb714ll2uDV87yKdAzUqZ00Uo9ugEBnmrJTfYQcLT
         0dx5LG8FsqiV6PpZka9UNSXood0sHSJMh6MQAFtAr3bAkwViH6IlbnkDTfcv4pBCdPbq
         AT9g==
X-Gm-Message-State: AGi0PuZTR0Hu3GmAhiZkZ0arc1PgkrnZ0dmc7/TlFafDjCc0XQVjy986
        hs3R2/trvygfndG4cu6hcVc=
X-Google-Smtp-Source: APiQypK8Bo/MSKxXXaQaPjF1LGejnPhJegTJnzOfls9M1hQxZIlDy1nOgvYyBi5r+5CeRy5TwGxFRw==
X-Received: by 2002:a7b:c1d4:: with SMTP id a20mr2883208wmj.111.1587121210149;
        Fri, 17 Apr 2020 04:00:10 -0700 (PDT)
Received: from debian (44.142.6.51.dyn.plus.net. [51.6.142.44])
        by smtp.gmail.com with ESMTPSA id o16sm31831230wrs.44.2020.04.17.04.00.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2020 04:00:09 -0700 (PDT)
Date:   Fri, 17 Apr 2020 12:00:07 +0100
From:   Wei Liu <wei.liu@kernel.org>
To:     Dexuan Cui <decui@microsoft.com>
Cc:     bp@alien8.de, haiyangz@microsoft.com, hpa@zytor.com,
        kys@microsoft.com, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        sthemmin@microsoft.com, tglx@linutronix.de, x86@kernel.org,
        mikelley@microsoft.com, vkuznets@redhat.com, wei.liu@kernel.org
Subject: Re: [PATCH] x86/hyperv: Suspend/resume the VP assist page for
 hibernation
Message-ID: <20200417110007.uzfo6musx2x2suw7@debian>
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

I don't quite follow here.

The first sentence is rather alarming -- why would Hyper-V corrupt
guest's memory (kernel or not)?

Secondly, code below only specifies cpu0. What does it do with non-boot
cpus on the resume path?

Wei.

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
>  	if (unlikely(!pg))
>  		return -ENOMEM;
>  	*input_arg = page_address(pg);
> @@ -253,6 +254,7 @@ static int __init hv_pci_init(void)
>  static int hv_suspend(void)
>  {
>  	union hv_x64_msr_hypercall_contents hypercall_msr;
> +	int ret;
>  
>  	/*
>  	 * Reset the hypercall page as it is going to be invalidated
> @@ -269,12 +271,17 @@ static int hv_suspend(void)
>  	hypercall_msr.enable = 0;
>  	wrmsrl(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
>  
> -	return 0;
> +	ret = hv_cpu_die(0);
> +	return ret;
>  }
>  
>  static void hv_resume(void)
>  {
>  	union hv_x64_msr_hypercall_contents hypercall_msr;
> +	int ret;
> +
> +	ret = hv_cpu_init(0);
> +	WARN_ON(ret);
>  
>  	/* Re-enable the hypercall page */
>  	rdmsrl(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
> @@ -287,6 +294,7 @@ static void hv_resume(void)
>  	hv_hypercall_pg_saved = NULL;
>  }
>  
> +/* Note: when the ops are called, only CPU0 is online and IRQs are disabled. */
>  static struct syscore_ops hv_syscore_ops = {
>  	.suspend	= hv_suspend,
>  	.resume		= hv_resume,
> -- 
> 2.19.1
> 
