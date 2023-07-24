Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5577A7600DF
	for <lists+linux-hyperv@lfdr.de>; Mon, 24 Jul 2023 23:06:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbjGXVGm (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 24 Jul 2023 17:06:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbjGXVGl (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 24 Jul 2023 17:06:41 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A64110FA;
        Mon, 24 Jul 2023 14:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=N3iwInQIj2/YuIQ+ANXYVcDoWVmU02nNRa9+HoqMVvY=; b=RdAOdRnniSR+QFsDIxcoqreHNz
        6VPUNtl1Gh9KWpjlWzq1hkv8HtV0ipYtzYgely3faXRA9Kple1CVCOhcOD30CxudcKOhcnZfGwwWu
        ZoAw1CLita25/SRcaY1H3+FEcQY3SU7+bd8qdJVX0cWAFE7QZ6u2vo17GH8Wubvkc85ourRXucxKg
        7T18Oa+uqqimA6wSQezdIfOexFhQoLokLhpgO/Nywp6ZCaFYU/enEouXitV8yOtNSbeG3GLf6QaNs
        bEY1SQ4C9ZPhuTl9K+gvF8WWzPV6qXgIsSOm8uFTicxAoXnboU951grBff5IQTPxHxKD1gZd0LJQQ
        3MaQSe8Q==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qO2lC-004oHb-3Y; Mon, 24 Jul 2023 21:06:30 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A8F8130036B;
        Mon, 24 Jul 2023 23:06:29 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9448726688798; Mon, 24 Jul 2023 23:06:29 +0200 (CEST)
Date:   Mon, 24 Jul 2023 23:06:29 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/1] x86/hyperv: Disable IBT when hypercall page lacks
 ENDBR instruction
Message-ID: <20230724210629.GF3745454@hirez.programming.kicks-ass.net>
References: <1690001476-98594-1-git-send-email-mikelley@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1690001476-98594-1-git-send-email-mikelley@microsoft.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, Jul 21, 2023 at 09:51:16PM -0700, Michael Kelley wrote:
> On hardware that supports Indirect Branch Tracking (IBT), Hyper-V VMs
> with ConfigVersion 9.3 or later support IBT in the guest. However,
> current versions of Hyper-V have a bug in that there's not an ENDBR64
> instruction at the beginning of the hypercall page. Since hypercalls are
> made with an indirect call to the hypercall page, all hypercall attempts
> fail with an exception and Linux panics.
> 
> A Hyper-V fix is in progress to add ENDBR64. But guard against the Linux
> panic by clearing X86_FEATURE_IBT if the hypercall page doesn't start
> with ENDBR. The VM will boot and run without IBT.
> 
> If future Linux 32-bit kernels were to support IBT, additional hypercall
> page hackery would be needed to make IBT work for such kernels in a
> Hyper-V VM.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Michael Kelley <mikelley@microsoft.com>

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

> ---
> 
> Changes in v2:
> * Use pr_warn() instead of pr_info() [Peter Zijlstra]
> 
>  arch/x86/hyperv/hv_init.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> index 6c04b52..5cbee24 100644
> --- a/arch/x86/hyperv/hv_init.c
> +++ b/arch/x86/hyperv/hv_init.c
> @@ -14,6 +14,7 @@
>  #include <asm/apic.h>
>  #include <asm/desc.h>
>  #include <asm/sev.h>
> +#include <asm/ibt.h>
>  #include <asm/hypervisor.h>
>  #include <asm/hyperv-tlfs.h>
>  #include <asm/mshyperv.h>
> @@ -472,6 +473,26 @@ void __init hyperv_init(void)
>  	}
>  
>  	/*
> +	 * Some versions of Hyper-V that provide IBT in guest VMs have a bug
> +	 * in that there's no ENDBR64 instruction at the entry to the
> +	 * hypercall page. Because hypercalls are invoked via an indirect call
> +	 * to the hypercall page, all hypercall attempts fail when IBT is
> +	 * enabled, and Linux panics. For such buggy versions, disable IBT.
> +	 *
> +	 * Fixed versions of Hyper-V always provide ENDBR64 on the hypercall
> +	 * page, so if future Linux kernel versions enable IBT for 32-bit
> +	 * builds, additional hypercall page hackery will be required here
> +	 * to provide an ENDBR32.
> +	 */
> +#ifdef CONFIG_X86_KERNEL_IBT
> +	if (cpu_feature_enabled(X86_FEATURE_IBT) &&
> +	    *(u32 *)hv_hypercall_pg != gen_endbr()) {
> +		setup_clear_cpu_cap(X86_FEATURE_IBT);
> +		pr_warn("Hyper-V: Disabling IBT because of Hyper-V bug\n");
> +	}
> +#endif
> +
> +	/*
>  	 * hyperv_init() is called before LAPIC is initialized: see
>  	 * apic_intr_mode_init() -> x86_platform.apic_post_init() and
>  	 * apic_bsp_setup() -> setup_local_APIC(). The direct-mode STIMER
> -- 
> 1.8.3.1
> 
