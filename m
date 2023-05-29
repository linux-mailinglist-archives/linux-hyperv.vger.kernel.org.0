Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37AD57145FB
	for <lists+linux-hyperv@lfdr.de>; Mon, 29 May 2023 10:06:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231651AbjE2IGO (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 29 May 2023 04:06:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231654AbjE2IGK (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 29 May 2023 04:06:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10EBA11C
        for <linux-hyperv@vger.kernel.org>; Mon, 29 May 2023 01:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685347523;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CpXGXTkTxrhIRYrLt2lLMkztlxS7BwAzRZ0iAN75Je0=;
        b=gA1vJynILb/mEHdttbkRse7gXd0OPZf5CS/govUNC8V2l7JzwpGj/qB2HkwZ3Se/7wKw+3
        crnNxt1dO0dhCfgUOVv5RQeXoj/IswAPc5Zm/hyP6Dp4i0HI03tDTkNRKh13jJPo2TmBbb
        m+tzQoRT58wJyueJht7z5UA7rmCGQ+4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-363-PS06uvB-PgyVBUZvf7qtKA-1; Mon, 29 May 2023 04:05:14 -0400
X-MC-Unique: PS06uvB-PgyVBUZvf7qtKA-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-3f6069f764bso50379075e9.0
        for <linux-hyperv@vger.kernel.org>; Mon, 29 May 2023 01:05:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685347513; x=1687939513;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CpXGXTkTxrhIRYrLt2lLMkztlxS7BwAzRZ0iAN75Je0=;
        b=bf8DON2IYVn6ZsukNVTltQLzrzorsFCLI+5nkxiE1b+RizrcorT08iuQZTXfj8kS/A
         xnmtNhc1KCqkFHXCrydMEWZfuIWliqplGggCao7d18mm6dUniWUGmJd7ax23EiiX7fr7
         vaVTczROWbvIWKv7OPszv+/BNfSr9I/Adrf5XXG3PjqdCsqfSH8BgJtLVR95wIUHXhHr
         2JddtSYvy2/qnayAE+fp6BZ6w17vgQFhKDAVU5WT5IANbdF5Yr7VO9nlZXgbZ6KVdV9R
         1tcTkVCkPPTOP/WLFVrXFnroddKgTQ7eHNlysqDBukkRAeoaANs99VnRnUsLKUtfyAhO
         MU/g==
X-Gm-Message-State: AC+VfDxeIKwuXnYpQei+PxqDnWbKzwdAyaWld7FZZPNn+WWMokpncApB
        agdAVTYSogCoH7MrDvMGccClPBI2aLZY7UplXS6i898KRmqsgaBd+8t9DZrn6ejuJfMLaMJV8+L
        KnKvU4UmAyAd5Mz27gRf5X9S3E9XegEWS
X-Received: by 2002:a1c:4c04:0:b0:3f6:962d:405c with SMTP id z4-20020a1c4c04000000b003f6962d405cmr7618066wmf.41.1685347513220;
        Mon, 29 May 2023 01:05:13 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5JCcb0ErnkhpRDN5dBN9m2v2k+nLtLxMn7tzxa4LWxwKWYL5WQNXAhC3VyIx6jZm+M/J6r4w==
X-Received: by 2002:a1c:4c04:0:b0:3f6:962d:405c with SMTP id z4-20020a1c4c04000000b003f6962d405cmr7618045wmf.41.1685347512897;
        Mon, 29 May 2023 01:05:12 -0700 (PDT)
Received: from fedora (g2.ign.cz. [91.219.240.8])
        by smtp.gmail.com with ESMTPSA id c7-20020a05600c0ac700b003f4fb5532a1sm13240464wmr.43.2023.05.29.01.05.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 May 2023 01:05:12 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, catalin.marinas@arm.com, will@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, x86@kernel.org
Subject: Re: [PATCH v2 1/2] x86/hyperv: Fix hyperv_pcpu_input_arg handling
 when CPUs go online/offline
In-Reply-To: <1684862062-51576-1-git-send-email-mikelley@microsoft.com>
References: <1684862062-51576-1-git-send-email-mikelley@microsoft.com>
Date:   Mon, 29 May 2023 10:05:11 +0200
Message-ID: <87cz2j5zrc.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Michael Kelley <mikelley@microsoft.com> writes:

> These commits
>
> a494aef23dfc ("PCI: hv: Replace retarget_msi_interrupt_params with hyperv_pcpu_input_arg")
> 2c6ba4216844 ("PCI: hv: Enable PCI pass-thru devices in Confidential VMs")
>
> update the Hyper-V virtual PCI driver to use the hyperv_pcpu_input_arg
> because that memory will be correctly marked as decrypted or encrypted
> for all VM types (CoCo or normal). But problems ensue when CPUs in the
> VM go online or offline after virtual PCI devices have been configured.
>
> When a CPU is brought online, the hyperv_pcpu_input_arg for that CPU is
> initialized by hv_cpu_init() running under state CPUHP_AP_ONLINE_DYN.
> But this state occurs after state CPUHP_AP_IRQ_AFFINITY_ONLINE, which
> may call the virtual PCI driver and fault trying to use the as yet
> uninitialized hyperv_pcpu_input_arg. A similar problem occurs in a CoCo
> VM if the MMIO read and write hypercalls are used from state
> CPUHP_AP_IRQ_AFFINITY_ONLINE.
>
> When a CPU is taken offline, IRQs may be reassigned in state
> CPUHP_TEARDOWN_CPU. Again, the virtual PCI driver may fault trying to
> use the hyperv_pcpu_input_arg that has already been freed by a
> higher state.
>
> Fix the onlining problem by adding state CPUHP_AP_HYPERV_ONLINE
> immediately after CPUHP_AP_ONLINE_IDLE (similar to CPUHP_AP_KVM_ONLINE)
> and before CPUHP_AP_IRQ_AFFINITY_ONLINE. Use this new state for
> Hyper-V initialization so that hyperv_pcpu_input_arg is allocated
> early enough.
>
> Fix the offlining problem by not freeing hyperv_pcpu_input_arg when
> a CPU goes offline. Retain the allocated memory, and reuse it if
> the CPU comes back online later.
>
> Signed-off-by: Michael Kelley <mikelley@microsoft.com>

Very minor nitpick: I would've changed the Subject of the patch to
something a bit more meaningful, e.g.

"x86/hyperv: Avoid freeing per-CPU hyperv_pcpu_{input,output}_arg upon CPU offlining"

or something like that. 

> ---
>
> Changes in v2:
> * Put CPUHP_AP_HYPERV_ONLINE before CPUHP_AP_KVM_ONLINE [Vitaly
>   Kuznetsov]
>
>  arch/x86/hyperv/hv_init.c  |  2 +-
>  drivers/hv/hv_common.c     | 48 +++++++++++++++++++++++-----------------------
>  include/linux/cpuhotplug.h |  1 +
>  3 files changed, 26 insertions(+), 25 deletions(-)
>
> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> index a5f9474..6c04b52 100644
> --- a/arch/x86/hyperv/hv_init.c
> +++ b/arch/x86/hyperv/hv_init.c
> @@ -416,7 +416,7 @@ void __init hyperv_init(void)
>  			goto free_vp_assist_page;
>  	}
>  
> -	cpuhp = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "x86/hyperv_init:online",
> +	cpuhp = cpuhp_setup_state(CPUHP_AP_HYPERV_ONLINE, "x86/hyperv_init:online",
>  				  hv_cpu_init, hv_cpu_die);
>  	if (cpuhp < 0)
>  		goto free_ghcb_page;
> diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
> index 64f9cec..542a1d5 100644
> --- a/drivers/hv/hv_common.c
> +++ b/drivers/hv/hv_common.c
> @@ -364,13 +364,20 @@ int hv_common_cpu_init(unsigned int cpu)
>  	flags = irqs_disabled() ? GFP_ATOMIC : GFP_KERNEL;
>  
>  	inputarg = (void **)this_cpu_ptr(hyperv_pcpu_input_arg);
> -	*inputarg = kmalloc(pgcount * HV_HYP_PAGE_SIZE, flags);
> -	if (!(*inputarg))
> -		return -ENOMEM;
>  
> -	if (hv_root_partition) {
> -		outputarg = (void **)this_cpu_ptr(hyperv_pcpu_output_arg);
> -		*outputarg = (char *)(*inputarg) + HV_HYP_PAGE_SIZE;
> +	/*
> +	 * hyperv_pcpu_input_arg and hyperv_pcpu_output_arg memory is already
> +	 * allocated if this CPU was previously online and then taken offline
> +	 */
> +	if (!*inputarg) {
> +		*inputarg = kmalloc(pgcount * HV_HYP_PAGE_SIZE, flags);

Nitpick: I see this was in the original code but we could probably
switch to kcalloc() here.

> +		if (!(*inputarg))
> +			return -ENOMEM;
> +
> +		if (hv_root_partition) {
> +			outputarg = (void **)this_cpu_ptr(hyperv_pcpu_output_arg);
> +			*outputarg = (char *)(*inputarg) + HV_HYP_PAGE_SIZE;
> +		}
>  	}
>  
>  	msr_vp_index = hv_get_register(HV_REGISTER_VP_INDEX);
> @@ -385,24 +392,17 @@ int hv_common_cpu_init(unsigned int cpu)
>  
>  int hv_common_cpu_die(unsigned int cpu)
>  {
> -	unsigned long flags;
> -	void **inputarg, **outputarg;
> -	void *mem;
> -
> -	local_irq_save(flags);
> -
> -	inputarg = (void **)this_cpu_ptr(hyperv_pcpu_input_arg);
> -	mem = *inputarg;
> -	*inputarg = NULL;
> -
> -	if (hv_root_partition) {
> -		outputarg = (void **)this_cpu_ptr(hyperv_pcpu_output_arg);
> -		*outputarg = NULL;
> -	}
> -
> -	local_irq_restore(flags);
> -
> -	kfree(mem);
> +	/*
> +	 * The hyperv_pcpu_input_arg and hyperv_pcpu_output_arg memory
> +	 * is not freed when the CPU goes offline as the hyperv_pcpu_input_arg
> +	 * may be used by the Hyper-V vPCI driver in reassigning interrupts
> +	 * as part of the offlining process.  The interrupt reassignment
> +	 * happens *after* the CPUHP_AP_HYPERV_ONLINE state has run and
> +	 * called this function.
> +	 *
> +	 * If a previously offlined CPU is brought back online again, the
> +	 * originally allocated memory is reused in hv_common_cpu_init().
> +	 */
>  
>  	return 0;
>  }
> diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
> index 0f1001d..3ceb9df 100644
> --- a/include/linux/cpuhotplug.h
> +++ b/include/linux/cpuhotplug.h
> @@ -200,6 +200,7 @@ enum cpuhp_state {
>  
>  	/* Online section invoked on the hotplugged CPU from the hotplug thread */
>  	CPUHP_AP_ONLINE_IDLE,
> +	CPUHP_AP_HYPERV_ONLINE,
>  	CPUHP_AP_KVM_ONLINE,
>  	CPUHP_AP_SCHED_WAIT_EMPTY,
>  	CPUHP_AP_SMPBOOT_THREADS,

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly

