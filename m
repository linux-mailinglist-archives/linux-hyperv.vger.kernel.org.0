Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F361628827
	for <lists+linux-hyperv@lfdr.de>; Mon, 14 Nov 2022 19:18:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236176AbiKNSSd (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 14 Nov 2022 13:18:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238388AbiKNSSL (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 14 Nov 2022 13:18:11 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2D6362F019;
        Mon, 14 Nov 2022 10:18:05 -0800 (PST)
Received: from skinsburskii.localdomain (c-67-170-100-148.hsd1.wa.comcast.net [67.170.100.148])
        by linux.microsoft.com (Postfix) with ESMTPSA id 9CA0720B717A;
        Mon, 14 Nov 2022 10:18:04 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9CA0720B717A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1668449884;
        bh=KRO/TqGp4x1anSCsu7IgV88Z9AUtXq8bdapPCe4k3bE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HwJcOTiX0CJurxpdLC+rWT0os26XIouCyWM9brJ0xd2i2lEpi8SgiOipAr2NaiFMC
         ep3DpGLk9AEnqJSWkNMND+7mmlWRMJdouHEHzgML/FwjIZEXOyCJWloZlrmSK6Kbs8
         C6drVwwC4ByD6bCaxIXGzRQrO6s7bPWmDZEQnULA=
Date:   Thu, 10 Nov 2022 05:41:52 -0800
From:   Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To:     Nuno Das Neves <nunodasneves@linux.microsoft.com>
Cc:     linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev, mikelley@microsoft.com,
        sunilmut@microsoft.com, wei.liu@kernel.org, kys@microsoft.com,
        Tianyu.Lan@microsoft.com, haiyangz@microsoft.com,
        decui@microsoft.com, dwmw2@infradead.org, joro@8bytes.org,
        will@kernel.org
Subject: Re: [PATCH] iommu/hyper-v: Allow hyperv irq remapping without x2apic
Message-ID: <20221110134152.GA27026@skinsburskii.localdomain>
References: <1668020853-23950-1-git-send-email-nunodasneves@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1668020853-23950-1-git-send-email-nunodasneves@linux.microsoft.com>
X-Spam-Status: No, score=-16.4 required=5.0 tests=BAYES_00,DATE_IN_PAST_96_XX,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Nov 09, 2022 at 11:07:33AM -0800, Nuno Das Neves wrote:
> If x2apic is not available, hyperv-iommu skips remapping
> irqs. This breaks root partition which always needs irqs
> remapped.
> 
> Fix this by allowing irq remapping regardless of x2apic,
> and change hyperv_enable_irq_remapping() to return
> IRQ_REMAP_XAPIC_MODE in case x2apic is missing.
> 
> Tested with root and non-root hyperv partitions.
> 
> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> ---
>  drivers/iommu/Kconfig        | 6 +++---
>  drivers/iommu/hyperv-iommu.c | 7 ++++---
>  2 files changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> index dc5f7a156ff5..cf7433652db0 100644
> --- a/drivers/iommu/Kconfig
> +++ b/drivers/iommu/Kconfig
> @@ -474,13 +474,13 @@ config QCOM_IOMMU
>  	  Support for IOMMU on certain Qualcomm SoCs.
>  
>  config HYPERV_IOMMU
> -	bool "Hyper-V x2APIC IRQ Handling"
> +	bool "Hyper-V IRQ Handling"
>  	depends on HYPERV && X86
>  	select IOMMU_API
>  	default HYPERV
>  	help
> -	  Stub IOMMU driver to handle IRQs as to allow Hyper-V Linux
> -	  guests to run with x2APIC mode enabled.
> +	  Stub IOMMU driver to handle IRQs to support Hyper-V Linux
> +	  guest and root partitions.
>  
>  config VIRTIO_IOMMU
>  	tristate "Virtio IOMMU driver"
> diff --git a/drivers/iommu/hyperv-iommu.c b/drivers/iommu/hyperv-iommu.c
> index e190bb8c225c..abd1826a9e63 100644
> --- a/drivers/iommu/hyperv-iommu.c
> +++ b/drivers/iommu/hyperv-iommu.c
> @@ -123,8 +123,7 @@ static int __init hyperv_prepare_irq_remapping(void)
>  	const struct irq_domain_ops *ops;
>  
>  	if (!hypervisor_is_type(X86_HYPER_MS_HYPERV) ||
> -	    x86_init.hyper.msi_ext_dest_id() ||
> -	    !x2apic_supported())
> +	    x86_init.hyper.msi_ext_dest_id())
>  		return -ENODEV;
>  
>  	if (hv_root_partition) {
> @@ -170,7 +169,9 @@ static int __init hyperv_prepare_irq_remapping(void)
>  
>  static int __init hyperv_enable_irq_remapping(void)
>  {
> -	return IRQ_REMAP_X2APIC_MODE;
> +	if (x2apic_supported())
> +		return IRQ_REMAP_X2APIC_MODE;
> +	return IRQ_REMAP_XAPIC_MODE;
>  }
>  
>  struct irq_remap_ops hyperv_irq_remap_ops = {
> -- 
> 2.25.1

Reviewed-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
