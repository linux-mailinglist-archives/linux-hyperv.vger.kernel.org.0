Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6DD44DCC32
	for <lists+linux-hyperv@lfdr.de>; Thu, 17 Mar 2022 18:19:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236818AbiCQRVB (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 17 Mar 2022 13:21:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230168AbiCQRVA (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 17 Mar 2022 13:21:00 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1CC03E9966;
        Thu, 17 Mar 2022 10:19:43 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D273E1682;
        Thu, 17 Mar 2022 10:19:42 -0700 (PDT)
Received: from [10.57.42.204] (unknown [10.57.42.204])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 132683F7B4;
        Thu, 17 Mar 2022 10:19:39 -0700 (PDT)
Message-ID: <d480c8ea-f047-2854-b1cf-041475b451db@arm.com>
Date:   Thu, 17 Mar 2022 17:19:36 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH 2/4 RESEND] dma-mapping: Add wrapper function to set
 dma_coherent
Content-Language: en-GB
To:     Michael Kelley <mikelley@microsoft.com>, sthemmin@microsoft.com,
        kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, rafael@kernel.org, lenb@kernel.org,
        lorenzo.pieralisi@arm.com, robh@kernel.org, kw@linux.com,
        bhelgaas@google.com, hch@lst.de, m.szyprowski@samsung.com,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org,
        iommu@lists.linux-foundation.org
References: <1647534311-2349-1-git-send-email-mikelley@microsoft.com>
 <1647534311-2349-3-git-send-email-mikelley@microsoft.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <1647534311-2349-3-git-send-email-mikelley@microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 2022-03-17 16:25, Michael Kelley via iommu wrote:
> Add a wrapper function to set dma_coherent, avoiding the need for
> complex #ifdef's when setting it in architecture independent code.

No. It might happen to work out on the architectures you're looking at, 
but if Hyper-V were ever to support, say, AArch32 VMs you might see the 
problem. arch_setup_dma_ops() is the tool for this job.

Robin.

> Signed-off-by: Michael Kelley <mikelley@microsoft.com>
> ---
>   include/linux/dma-map-ops.h | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/include/linux/dma-map-ops.h b/include/linux/dma-map-ops.h
> index 0d5b06b..3350e7a 100644
> --- a/include/linux/dma-map-ops.h
> +++ b/include/linux/dma-map-ops.h
> @@ -254,11 +254,20 @@ static inline bool dev_is_dma_coherent(struct device *dev)
>   {
>   	return dev->dma_coherent;
>   }
> +static inline void dev_set_dma_coherent(struct device *dev,
> +		bool coherent)
> +{
> +	dev->dma_coherent = coherent;
> +}
>   #else
>   static inline bool dev_is_dma_coherent(struct device *dev)
>   {
>   	return true;
>   }
> +static inline void dev_set_dma_coherent(struct device *dev,
> +		bool coherent)
> +{
> +}
>   #endif /* CONFIG_ARCH_HAS_DMA_COHERENCE_H */
>   
>   void *arch_dma_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
