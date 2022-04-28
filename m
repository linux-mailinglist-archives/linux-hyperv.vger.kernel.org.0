Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 968F451378C
	for <lists+linux-hyperv@lfdr.de>; Thu, 28 Apr 2022 16:58:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348636AbiD1PBo (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 28 Apr 2022 11:01:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348682AbiD1PBn (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 28 Apr 2022 11:01:43 -0400
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4DC8B1AB2;
        Thu, 28 Apr 2022 07:58:27 -0700 (PDT)
Received: by mail-wr1-f54.google.com with SMTP id x18so7201871wrc.0;
        Thu, 28 Apr 2022 07:58:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pJht61S4RPriKsV7ekQVDQgy26tmGAG/x3RwoDVfuKU=;
        b=QV445xQbcZWqH+LHxBR426qlyBqCACoCPswsk+h3LCEAoGFb6f/4Nt8OrHjOS6GAL8
         GiUI1PvdaOIj5pEz+8QvQnP0aqo3Rieji6qo3GXg0gKjwR4uXWY4TaSF8wEFvxXvRtXq
         FXI7aZ1HwWy9Imui0vPGVG6+2aszVAJLU6Zf0TikIpktlrDIy106BC53i/ceoaNU1Ywa
         EVyWlAi2xSb4j+yPZtYfkkbLd/4afCj0HYY3qCHTR51rqqvrLSmD+IPgNnqMDROQZMvp
         x1YtWyCQDuVJKYd1yUwg6KxQoa0TCitnE6xJa3gO86t4NlLiO5AqVr8XeJJAluSROtj0
         pvBQ==
X-Gm-Message-State: AOAM530qqFT/AQIcr0aVob0F76+coeB/BXzRRs8rl52EaQe/BWIv39+3
        jXZzU2tGbzIVs09D29qau+U=
X-Google-Smtp-Source: ABdhPJzx8zxA97eGWHYaZo9Wi6fH6fF6SL0+ElSUzq3Y5I1Ax/WjHMM68KNWAlW1N/gXYJmiLV/e3g==
X-Received: by 2002:adf:db8b:0:b0:207:9a90:3819 with SMTP id u11-20020adfdb8b000000b002079a903819mr27687180wri.617.1651157906185;
        Thu, 28 Apr 2022 07:58:26 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id n16-20020a05600c3b9000b0039411b2e96fsm1639020wms.30.2022.04.28.07.58.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Apr 2022 07:58:25 -0700 (PDT)
Date:   Thu, 28 Apr 2022 14:58:24 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Jeffrey Hugo <quic_jhugo@quicinc.com>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, decui@microsoft.com, lorenzo.pieralisi@arm.com,
        robh@kernel.org, kw@linux.com, bhelgaas@google.com,
        bjorn.andersson@linaro.org, linux-hyperv@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: hv: Fix hv_arch_irq_unmask() for multi-MSI
Message-ID: <20220428145824.kp4p5qacgnncsxls@liuwe-devbox-debian-v2>
References: <1651068453-29588-1-git-send-email-quic_jhugo@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1651068453-29588-1-git-send-email-quic_jhugo@quicinc.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Apr 27, 2022 at 08:07:33AM -0600, Jeffrey Hugo wrote:
> In the multi-MSI case, hv_arch_irq_unmask() will only operate on the first
> MSI of the N allocated.  This is because only the first msi_desc is cached
> and it is shared by all the MSIs of the multi-MSI block.  This means that
> hv_arch_irq_unmask() gets the correct address, but the wrong data (always
> 0).
> 
> This can break MSIs.
> 
> Lets assume MSI0 is vector 34 on CPU0, and MSI1 is vector 33 on CPU0.
> 
> hv_arch_irq_unmask() is called on MSI0.  It uses a hypercall to configure
> the MSI address and data (0) to vector 34 of CPU0.  This is correct.  Then
> hv_arch_irq_unmask is called on MSI1.  It uses another hypercall to
> configure the MSI address and data (0) to vector 33 of CPU0.  This is
> wrong, and results in both MSI0 and MSI1 being routed to vector 33.  Linux
> will observe extra instances of MSI1 and no instances of MSI0 despite the
> endpoint device behaving correctly.
> 
> For the multi-MSI case, we need unique address and data info for each MSI,
> but the cached msi_desc does not provide that.  However, that information
> can be gotten from the int_desc cached in the chip_data by
> compose_msi_msg().  Fix the multi-MSI case to use that cached information
> instead.  Since hv_set_msi_entry_from_desc() is no longer applicable,
> remove it.
> 
> Signed-off-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
> ---
>  drivers/pci/controller/pci-hyperv.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
> index 5800ecf..7aea0b7 100644
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -611,13 +611,6 @@ static unsigned int hv_msi_get_int_vector(struct irq_data *data)
>  	return cfg->vector;
>  }
>  
> -static void hv_set_msi_entry_from_desc(union hv_msi_entry *msi_entry,
> -				       struct msi_desc *msi_desc)
> -{
> -	msi_entry->address.as_uint32 = msi_desc->msg.address_lo;
> -	msi_entry->data.as_uint32 = msi_desc->msg.data;
> -}
> -

Instead of dropping this function, can you change the second argument to
take struct tran_int_desc *?

This way you can use the same function in hv_compose_msi_msg.

Thanks,
Wei.

>  static int hv_msi_prepare(struct irq_domain *domain, struct device *dev,
>  			  int nvec, msi_alloc_info_t *info)
>  {
> @@ -647,6 +640,7 @@ static void hv_arch_irq_unmask(struct irq_data *data)
>  {
>  	struct msi_desc *msi_desc = irq_data_get_msi_desc(data);
>  	struct hv_retarget_device_interrupt *params;
> +	struct tran_int_desc *int_desc;
>  	struct hv_pcibus_device *hbus;
>  	struct cpumask *dest;
>  	cpumask_var_t tmp;
> @@ -661,6 +655,7 @@ static void hv_arch_irq_unmask(struct irq_data *data)
>  	pdev = msi_desc_to_pci_dev(msi_desc);
>  	pbus = pdev->bus;
>  	hbus = container_of(pbus->sysdata, struct hv_pcibus_device, sysdata);
> +	int_desc = data->chip_data;
>  
>  	spin_lock_irqsave(&hbus->retarget_msi_interrupt_lock, flags);
>  
> @@ -668,7 +663,8 @@ static void hv_arch_irq_unmask(struct irq_data *data)
>  	memset(params, 0, sizeof(*params));
>  	params->partition_id = HV_PARTITION_ID_SELF;
>  	params->int_entry.source = HV_INTERRUPT_SOURCE_MSI;
> -	hv_set_msi_entry_from_desc(&params->int_entry.msi_entry, msi_desc);
> +	params->int_entry.msi_entry.address.as_uint32 = int_desc->address & 0xffffffff;
> +	params->int_entry.msi_entry.data.as_uint32 = int_desc->data;
>  	params->device_id = (hbus->hdev->dev_instance.b[5] << 24) |
>  			   (hbus->hdev->dev_instance.b[4] << 16) |
>  			   (hbus->hdev->dev_instance.b[7] << 8) |
> -- 
> 2.7.4
> 
