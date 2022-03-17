Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D82064DCBC5
	for <lists+linux-hyperv@lfdr.de>; Thu, 17 Mar 2022 17:52:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234557AbiCQQyF (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 17 Mar 2022 12:54:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231928AbiCQQyE (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 17 Mar 2022 12:54:04 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 345B5217950;
        Thu, 17 Mar 2022 09:52:48 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EB4591682;
        Thu, 17 Mar 2022 09:52:47 -0700 (PDT)
Received: from [10.57.42.204] (unknown [10.57.42.204])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 23B8C3F7B4;
        Thu, 17 Mar 2022 09:52:44 -0700 (PDT)
Message-ID: <e2ceb902-6fe2-bcb9-259a-f120901672b6@arm.com>
Date:   Thu, 17 Mar 2022 16:52:37 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH 3/4 RESEND] Drivers: hv: vmbus: Propagate VMbus coherence
 to each VMbus device
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
 <1647534311-2349-4-git-send-email-mikelley@microsoft.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <1647534311-2349-4-git-send-email-mikelley@microsoft.com>
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
> VMbus synthetic devices are not represented in the ACPI DSDT -- only
> the top level VMbus device is represented. As a result, on ARM64
> coherence information in the _CCA method is not specified for
> synthetic devices, so they default to not hardware coherent.
> Drivers for some of these synthetic devices have been recently
> updated to use the standard DMA APIs, and they are incurring extra
> overhead of unneeded software coherence management.
> 
> Fix this by propagating coherence information from the VMbus node
> in ACPI to the individual synthetic devices. There's no effect on
> x86/x64 where devices are always hardware coherent.
> 
> Signed-off-by: Michael Kelley <mikelley@microsoft.com>
> ---
>   drivers/hv/vmbus_drv.c | 15 +++++++++++++++
>   1 file changed, 15 insertions(+)
> 
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index 12a2b37..c0e993ad 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -904,6 +904,21 @@ static int vmbus_probe(struct device *child_device)
>   			drv_to_hv_drv(child_device->driver);
>   	struct hv_device *dev = device_to_hv_device(child_device);
>   	const struct hv_vmbus_device_id *dev_id;
> +	enum dev_dma_attr coherent;
> +
> +	/*
> +	 * On ARM64, propagate the DMA coherence setting from the top level
> +	 * VMbus ACPI device to the child VMbus device being added here.
> +	 * Older Hyper-V ARM64 versions don't set the _CCA method on the
> +	 * top level VMbus ACPI device as they should.  Treat these cases
> +	 * as DMA coherent since that's the assumption made by Hyper-V.
> +	 *
> +	 * On x86/x64 these calls assume coherence and have no effect.
> +	 */
> +	coherent = acpi_get_dma_attr(hv_acpi_dev);
> +	if (coherent == DEV_DMA_NOT_SUPPORTED)
> +		coherent = DEV_DMA_COHERENT;
> +	acpi_dma_configure(child_device, coherent);

acpi_dma_configure is for devices represented in ACPI. The commit 
message implies that these VMBus devices aren't represented in ACPI. 
What gives?

Robin.

>   
>   	dev_id = hv_vmbus_get_id(drv, dev);
>   	if (drv->probe) {
