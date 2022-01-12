Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0245048C5F2
	for <lists+linux-hyperv@lfdr.de>; Wed, 12 Jan 2022 15:27:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354089AbiALO0l (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 12 Jan 2022 09:26:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239105AbiALO0j (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 12 Jan 2022 09:26:39 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26053C06173F;
        Wed, 12 Jan 2022 06:26:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D5B7CB81F0F;
        Wed, 12 Jan 2022 14:26:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40ABFC36AEA;
        Wed, 12 Jan 2022 14:26:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641997594;
        bh=Of9s1U/c/4ZrioTqbXt+GoX9s9yd9C0ccT69AJL5N8k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=JdOHYls9XkLlsnubveVe4Eh0BPHJKcwPYLHjcHFYISqIwhpdWV2bDrx6XiRqMvO0a
         uWps9L74aQoq16lO45eyYuEknbIjqSHj0TWPAk8HwVLMIW+HqD8+d9q74BIRPiEhku
         DN+cpcETPeozEofVk6CXlZJW+93cZlGMhDwG/4lv5YKzihdX78OkJ6RVEBFBj/GENv
         kdj4kQd+zjea1+y/WPTaHxz7of6SbN8ua8tIqkVBw4a3sQEEsOjbl0C2aqAuE7wpP2
         zxWnL5r1lGLHi2WqxOEGmGQX4azprFQk8jUAeq1VD+P50DweqidJmy1TNgb/Rgbkyg
         coZt1R4UAbsOQ==
Date:   Wed, 12 Jan 2022 08:26:32 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     kys@microsoft.com, sunilmut@microsoft.com, haiyangz@microsoft.com,
        sthemmin@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
        lorenzo.pieralisi@arm.com, robh@kernel.org, kw@linux.com,
        bhelgaas@google.com, mikelley@microsoft.com, maz@kernel.org,
        linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH -next v2] PCI: hv: Fix an ignored error return from
 bitmap_find_free_region()
Message-ID: <20220112142632.GA252208@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220112003324.62755-1-yang.lee@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Jan 12, 2022 at 08:33:24AM +0800, Yang Li wrote:
> An error return from bitmap_find_free_region() is currently ignored 
> and we instead return a completely bogus *hwirq from 
> hv_pci_vec_alloc_device_irq().
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Fixes: c10bdb758ca4 ("PCI: hv: Add arm64 Hyper-V vPCI support")
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>

Thanks, I squashed this into c10bdb758ca4.

> ---
> 
> Change in v2:
> --According to Bjorn's suggestion, the corresponding changes were made.
>   https://lore.kernel.org/lkml/20220111155412.GA142851@bhelgaas/
> 
>  drivers/pci/controller/pci-hyperv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
> index 26c9c8ec0989..20ea2ee330b8 100644
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -701,7 +701,7 @@ static int hv_pci_vec_alloc_device_irq(struct irq_domain *domain,
>  				       irq_hw_number_t *hwirq)
>  {
>  	struct hv_pci_chip_data *chip_data = domain->host_data;
> -	unsigned int index;
> +	int index;
>  
>  	/* Find and allocate region from the SPI bitmap */
>  	mutex_lock(&chip_data->map_lock);
> -- 
> 2.20.1.7.g153144c
> 
