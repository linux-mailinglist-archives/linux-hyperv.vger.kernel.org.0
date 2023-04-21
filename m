Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE16F6EA799
	for <lists+linux-hyperv@lfdr.de>; Fri, 21 Apr 2023 11:54:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbjDUJy1 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 21 Apr 2023 05:54:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231301AbjDUJy0 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 21 Apr 2023 05:54:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 080341731;
        Fri, 21 Apr 2023 02:54:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9CE0D64F91;
        Fri, 21 Apr 2023 09:54:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C02EC4339B;
        Fri, 21 Apr 2023 09:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682070864;
        bh=jx47eb6GtiJ0tw6fDSwNwaDW+uhBn/Dda5fxHwTKoUQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ikXp+sOjbhO7PxZpEnD/kgKHkabrc+mpVG1r/2X16WqRW26MVkgvrCns1deCTt2E/
         Wm1tItf3Lg16gwQGTqvkN7v5C+BEsPBGKjsp/YkrWkHb2X/NNId1mI3JKCGAUKHICE
         nnNmK7R3MG1SKgpvNmgRwA7qz7Z/oM4FFl9mUDTIYc/7Ac/aBgLyJArliBz8MqP9mK
         F6DMoKEmb0H61YNFPa6KW4fjnZOM9kKEcCA1/DxkG5m8dHiGMo9GaObCwZWQIJ0wk0
         8IlsPeZxT2z4qIQJdA0XhE7yc8UArmYphtPqAoya97pFBecVZIIDCj2oK1/h+UNJvB
         vHAQN5dz4eIAQ==
Date:   Fri, 21 Apr 2023 11:54:17 +0200
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     Dexuan Cui <decui@microsoft.com>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        kw@linux.com, robh@kernel.org, bhelgaas@google.com,
        linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org,
        mikelley@microsoft.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PCI: hv: Replace retarget_msi_interrupt_params with
 hyperv_pcpu_input_arg
Message-ID: <ZEJdSXv6IwSxPp9r@lpieralisi>
References: <20230421013025.17152-1-decui@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230421013025.17152-1-decui@microsoft.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, Apr 20, 2023 at 06:30:25PM -0700, Dexuan Cui wrote:
> 4 commits are involved here:
> A (2016): commit 0de8ce3ee8e3 ("PCI: hv: Allocate physically contiguous hypercall params buffer")
> B (2017): commit be66b6736591 ("PCI: hv: Use page allocation for hbus structure")
> C (2019): commit 877b911a5ba0 ("PCI: hv: Avoid a kmemleak false positive caused by the hbus buffer")
> D (2018): commit 68bb7bfb7985 ("X86/Hyper-V: Enable IPI enlightenments")
> 
> Patch D introduced the per-CPU hypercall input page "hyperv_pcpu_input_arg"
> in 2018. With patch D, we no longer need the per-Hyper-V-PCI-bus hypercall
> input page "hbus->retarget_msi_interrupt_params" that was added in patch A,
> and the issue addressed by patch B is no longer an issue, and we can also
> get rid of patch C.
> 
> The change here is required for PCI device assignment to work for
> Confidential VMs (CVMs) running without a paravisor, because otherwise we
> would have to call set_memory_decrypted() for
> "hbus->retarget_msi_interrupt_params" before calling the hypercall
> HVCALL_RETARGET_INTERRUPT.
> 
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> Reviewed-by: Michael Kelley <mikelley@microsoft.com>
> ---
> 
> Changes in v2:
>   Fixed the inaccuracy in the commit message (Thanks Michael):
>     "Confidential VMs (CVMs)" -> "Confidential VMs (CVMs) running without a paravisor".
> 
>   Added Michael's Reviewed-by.
> 
>  drivers/pci/controller/pci-hyperv.c | 48 +++++------------------------
>  1 file changed, 7 insertions(+), 41 deletions(-)

Acked-by: Lorenzo Pieralisi <lpieralisi@kernel.org>

> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
> index 337f3b4a04fc0..bc32662c6bb7f 100644
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -508,20 +508,11 @@ struct hv_pcibus_device {
>  	struct msi_domain_info msi_info;
>  	struct irq_domain *irq_domain;
>  
> -	spinlock_t retarget_msi_interrupt_lock;
> -
>  	struct workqueue_struct *wq;
>  
>  	/* Highest slot of child device with resources allocated */
>  	int wslot_res_allocated;
>  	bool use_calls; /* Use hypercalls to access mmio cfg space */
> -
> -	/* hypercall arg, must not cross page boundary */
> -	struct hv_retarget_device_interrupt retarget_msi_interrupt_params;
> -
> -	/*
> -	 * Don't put anything here: retarget_msi_interrupt_params must be last
> -	 */
>  };
>  
>  /*
> @@ -645,9 +636,9 @@ static void hv_arch_irq_unmask(struct irq_data *data)
>  	hbus = container_of(pbus->sysdata, struct hv_pcibus_device, sysdata);
>  	int_desc = data->chip_data;
>  
> -	spin_lock_irqsave(&hbus->retarget_msi_interrupt_lock, flags);
> +	local_irq_save(flags);
>  
> -	params = &hbus->retarget_msi_interrupt_params;
> +	params = *this_cpu_ptr(hyperv_pcpu_input_arg);
>  	memset(params, 0, sizeof(*params));
>  	params->partition_id = HV_PARTITION_ID_SELF;
>  	params->int_entry.source = HV_INTERRUPT_SOURCE_MSI;
> @@ -680,7 +671,7 @@ static void hv_arch_irq_unmask(struct irq_data *data)
>  
>  		if (!alloc_cpumask_var(&tmp, GFP_ATOMIC)) {
>  			res = 1;
> -			goto exit_unlock;
> +			goto out;
>  		}
>  
>  		cpumask_and(tmp, dest, cpu_online_mask);
> @@ -689,7 +680,7 @@ static void hv_arch_irq_unmask(struct irq_data *data)
>  
>  		if (nr_bank <= 0) {
>  			res = 1;
> -			goto exit_unlock;
> +			goto out;
>  		}
>  
>  		/*
> @@ -708,8 +699,8 @@ static void hv_arch_irq_unmask(struct irq_data *data)
>  	res = hv_do_hypercall(HVCALL_RETARGET_INTERRUPT | (var_size << 17),
>  			      params, NULL);
>  
> -exit_unlock:
> -	spin_unlock_irqrestore(&hbus->retarget_msi_interrupt_lock, flags);
> +out:
> +	local_irq_restore(flags);
>  
>  	/*
>  	 * During hibernation, when a CPU is offlined, the kernel tries
> @@ -3598,35 +3589,11 @@ static int hv_pci_probe(struct hv_device *hdev,
>  	bool enter_d0_retry = true;
>  	int ret;
>  
> -	/*
> -	 * hv_pcibus_device contains the hypercall arguments for retargeting in
> -	 * hv_irq_unmask(). Those must not cross a page boundary.
> -	 */
> -	BUILD_BUG_ON(sizeof(*hbus) > HV_HYP_PAGE_SIZE);
> -
>  	bridge = devm_pci_alloc_host_bridge(&hdev->device, 0);
>  	if (!bridge)
>  		return -ENOMEM;
>  
> -	/*
> -	 * With the recent 59bb47985c1d ("mm, sl[aou]b: guarantee natural
> -	 * alignment for kmalloc(power-of-two)"), kzalloc() is able to allocate
> -	 * a 4KB buffer that is guaranteed to be 4KB-aligned. Here the size and
> -	 * alignment of hbus is important because hbus's field
> -	 * retarget_msi_interrupt_params must not cross a 4KB page boundary.
> -	 *
> -	 * Here we prefer kzalloc to get_zeroed_page(), because a buffer
> -	 * allocated by the latter is not tracked and scanned by kmemleak, and
> -	 * hence kmemleak reports the pointer contained in the hbus buffer
> -	 * (i.e. the hpdev struct, which is created in new_pcichild_device() and
> -	 * is tracked by hbus->children) as memory leak (false positive).
> -	 *
> -	 * If the kernel doesn't have 59bb47985c1d, get_zeroed_page() *must* be
> -	 * used to allocate the hbus buffer and we can avoid the kmemleak false
> -	 * positive by using kmemleak_alloc() and kmemleak_free() to ask
> -	 * kmemleak to track and scan the hbus buffer.
> -	 */
> -	hbus = kzalloc(HV_HYP_PAGE_SIZE, GFP_KERNEL);
> +	hbus = kzalloc(sizeof(*hbus), GFP_KERNEL);
>  	if (!hbus)
>  		return -ENOMEM;
>  
> @@ -3683,7 +3650,6 @@ static int hv_pci_probe(struct hv_device *hdev,
>  	INIT_LIST_HEAD(&hbus->dr_list);
>  	spin_lock_init(&hbus->config_lock);
>  	spin_lock_init(&hbus->device_list_lock);
> -	spin_lock_init(&hbus->retarget_msi_interrupt_lock);
>  	hbus->wq = alloc_ordered_workqueue("hv_pci_%x", 0,
>  					   hbus->bridge->domain_nr);
>  	if (!hbus->wq) {
> -- 
> 2.25.1
> 
