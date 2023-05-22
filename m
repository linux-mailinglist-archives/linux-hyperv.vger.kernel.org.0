Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 528E270B82D
	for <lists+linux-hyperv@lfdr.de>; Mon, 22 May 2023 10:57:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232689AbjEVI5z (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 22 May 2023 04:57:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232692AbjEVI51 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 22 May 2023 04:57:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 850D7CE
        for <linux-hyperv@vger.kernel.org>; Mon, 22 May 2023 01:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684745776;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=v4/mES/i+aWv5NPMCuzU07vDqmm6ywd8X/SsDFXQTQU=;
        b=gKK5hQeH7VW7Ar0wRR1jXYAicW6Pxyepqrv1yR60/EXYGiuk2UZEebB3LJiLn5cTQGaKS5
        Gc+EUka0ezIYBptcwTm5b7xwSBsxwgXPy2ABhj5wV/NMHIwTq7FeGbpIzH13W3evr7dF2d
        wNmW29Dpbjj7WgFCYi6kEzvDT4lphAU=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-X6o9032WM_u0NjydH6A8Hg-1; Mon, 22 May 2023 04:56:10 -0400
X-MC-Unique: X6o9032WM_u0NjydH6A8Hg-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6237c937691so20607346d6.0
        for <linux-hyperv@vger.kernel.org>; Mon, 22 May 2023 01:56:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684745769; x=1687337769;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v4/mES/i+aWv5NPMCuzU07vDqmm6ywd8X/SsDFXQTQU=;
        b=fbB60NbV4TX7F3rOvhlBZ/bIlB3BA2a2P8HdiDs6XEQQx+Jb6C5FlmSR0XNxfjPG89
         7JXSQRoawo6l6UJTmTUbHcw4Wuuc+1eCXsyz6M79JQZYg1ouxmp9eIzGcW0byX1R2a5q
         FRUL9J5YsV5zGqwwbm4HxN7AYpH1A+P5yzEyaknt0fiIwjbRfbdYWjwB8AMAGr61sZJX
         UNvT85EdwfhsVFlPtchUaaZipXP+BfMm64lQiQQNH0u6qwf0g+tXf6rd3015fJxQ1c7E
         arJbwo8CerAR4S9FX/QUInAMS/NVKA++fh8mthuL0/FFtpBLVZWsRCaY+oCHZlpJa/47
         x6xQ==
X-Gm-Message-State: AC+VfDwnMHKgmjsC0px1zubWJgyTiJE9oXyuB/nyTvmRmw4w6/A2tRrc
        hPDV2LeXkyVk2E8PHgePjmh8kVnRYVAZfuqjnKadWGpBkKNB8FmXz+eDnnGWEoKgW7lUhoeejTZ
        Lb6v+qIn9RIzdl8RMijy6oQp/
X-Received: by 2002:ad4:574f:0:b0:61b:58ec:24c8 with SMTP id q15-20020ad4574f000000b0061b58ec24c8mr19041567qvx.10.1684745769587;
        Mon, 22 May 2023 01:56:09 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6uniPtYnrTfdnta4PkKXkaaURbeQlrK+ltmlFW9A16ZWTL6u653yf9McI3kMPgTvMlDD4Mow==
X-Received: by 2002:ad4:574f:0:b0:61b:58ec:24c8 with SMTP id q15-20020ad4574f000000b0061b58ec24c8mr19041550qvx.10.1684745769306;
        Mon, 22 May 2023 01:56:09 -0700 (PDT)
Received: from fedora (g2.ign.cz. [91.219.240.8])
        by smtp.gmail.com with ESMTPSA id f28-20020ad4559c000000b0061f7cf8207asm1810803qvx.133.2023.05.22.01.56.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 01:56:08 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     mikelley@microsoft.com, kys@microsoft.com, haiyangz@microsoft.com,
        wei.liu@kernel.org, decui@microsoft.com, catalin.marinas@arm.com,
        will@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, x86@kernel.org,
        kvm@vger.kernel.org
Subject: Re: [PATCH 1/2] x86/hyperv: Fix hyperv_pcpu_input_arg handling when
 CPUs go online/offline
In-Reply-To: <1684506832-41392-1-git-send-email-mikelley@microsoft.com>
References: <1684506832-41392-1-git-send-email-mikelley@microsoft.com>
Date:   Mon, 22 May 2023 10:56:05 +0200
Message-ID: <87o7mczqvu.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
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
> ---
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
> index 64f9cec..4c5cee4 100644
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
> index 0f1001d..696004a 100644
> --- a/include/linux/cpuhotplug.h
> +++ b/include/linux/cpuhotplug.h
> @@ -201,6 +201,7 @@ enum cpuhp_state {
>  	/* Online section invoked on the hotplugged CPU from the hotplug thread */
>  	CPUHP_AP_ONLINE_IDLE,
>  	CPUHP_AP_KVM_ONLINE,
> +	CPUHP_AP_HYPERV_ONLINE,

(Cc: KVM)

I would very much prefer we swap the order with KVM here: hv_cpu_init()
allocates and sets vCPU's VP assist page which is used by KVM on
CPUHP_AP_KVM_ONLINE:

kvm_online_cpu() -> __hardware_enable_nolock() ->
kvm_arch_hardware_enable() -> vmx_hardware_enable():

        /*
         * This can happen if we hot-added a CPU but failed to allocate
         * VP assist page for it.
         */
	if (kvm_is_using_evmcs() && !hv_get_vp_assist_page(cpu))
		return -EFAULT;

With the change, this is likely broken.

FWIF, KVM also needs current vCPU's VP index (also set by hv_cpu_init())
through __kvm_x86_vendor_init() -> set_hv_tscchange_cb() call chain but
this happens upon KVM module load so CPU hotplug ordering should not
matter as this always happens on a CPU which is already online.

Generally, as 'KVM on Hyper-V' is a supported scenario, doing Hyper-V
init before KVM's (and vice versa on teardown) makes sense.

>  	CPUHP_AP_SCHED_WAIT_EMPTY,
>  	CPUHP_AP_SMPBOOT_THREADS,
>  	CPUHP_AP_X86_VDSO_VMA_ONLINE,

-- 
Vitaly

