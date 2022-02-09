Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6082A4AF63B
	for <lists+linux-hyperv@lfdr.de>; Wed,  9 Feb 2022 17:12:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236670AbiBIQMX (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 9 Feb 2022 11:12:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233603AbiBIQMV (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 9 Feb 2022 11:12:21 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91F37C0613C9;
        Wed,  9 Feb 2022 08:12:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2E7EF6178D;
        Wed,  9 Feb 2022 16:12:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E587BC340E7;
        Wed,  9 Feb 2022 16:12:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644423143;
        bh=m3/DCmKw6+XqkFayBElGVHbTdWMUgdbgYLhOgJ1SVRQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Eq2V2AOH7HmO+ekuO/1S0ugmsKp5DANBwvob+DQ7ABf5OR+IK2Lmg8R6kgtU/S/op
         nqKzsF5XOT9XbWjFIQRj1Et9aUDff6jaIIjlCEDU0T9/L1QoLpcYFiaNaG35+YlG9l
         EwKaz1rik05jWapb4XRrIA3YSFRFgK+8v7dZunborSwf+/ZqiDHcwCRskBBDEU810I
         CmX2AIZtkVSru1zAasEY2X3fLmWiwUAbzfKZU+EeA7WL20cJc1nT8hEItyAAt/4yj3
         OySfTc9HcdfKXU6ZpSQL5Cb2/ydDm9n3+xHyEYHTQ7yv1m40dooIvG2S/xCwPIfdLs
         TCmfVXZ/UcUqw==
Date:   Wed, 9 Feb 2022 10:12:20 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Wei Liu <wei.liu@kernel.org>,
        Sunil Muthuswamy <sunilmut@linux.microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] PCI: hv: Avoid the retarget interrupt hypercall in
 irq_unmask() on ARM64
Message-ID: <20220209161220.GA559499@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220209023722.2866009-1-boqun.feng@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Feb 09, 2022 at 10:37:20AM +0800, Boqun Feng wrote:
> On ARM64 Hyper-V guests, SPIs are used for the interrupts of virtual PCI
> devices, and SPIs can be managed directly via GICD registers. Therefore
> the retarget interrupt hypercall is not needed on ARM64.
> 
> The retarget interrupt hypercall related code is now put in a helper
> function and only called on x86.
> 
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> ---
>  drivers/pci/controller/pci-hyperv.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
> index 20ea2ee330b8..80aa33ef5bf0 100644
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -1457,7 +1457,7 @@ static void hv_irq_mask(struct irq_data *data)
>  }
>  
>  /**
> - * hv_irq_unmask() - "Unmask" the IRQ by setting its current
> + * __hv_irq_unmask() - "Unmask" the IRQ by setting its current
>   * affinity.
>   * @data:	Describes the IRQ
>   *
> @@ -1466,7 +1466,7 @@ static void hv_irq_mask(struct irq_data *data)
>   * is built out of this PCI bus's instance GUID and the function
>   * number of the device.
>   */
> -static void hv_irq_unmask(struct irq_data *data)
> +static void __hv_irq_unmask(struct irq_data *data)
>  {
>  	struct msi_desc *msi_desc = irq_data_get_msi_desc(data);
>  	struct hv_retarget_device_interrupt *params;
> @@ -1569,6 +1569,13 @@ static void hv_irq_unmask(struct irq_data *data)
>  	if (!hv_result_success(res) && hbus->state != hv_pcibus_removing)
>  		dev_err(&hbus->hdev->device,
>  			"%s() failed: %#llx", __func__, res);
> +}
> +
> +static void hv_irq_unmask(struct irq_data *data)
> +{
> +	/* Only use a hypercall on x86 */

This comment isn't useful because it only repeats what we can already
see from the "IS_ENABLED(CONFIG_X86)" below and it doesn't say
anything about *why*.

Didn't we just go though an exercise of adding interfaces for
arch-specific things, i.e., 831c1ae725f7 ("PCI: hv: Make the code arch
neutral by adding arch specific interfaces")?  Maybe this should be
another such interface?

If you add Hyper-V support for a third arch, this #ifdef will likely
be silently incorrect.  If you add an interface, there's at least a
clue that this needs to be evaluated.

> +	if (IS_ENABLED(CONFIG_X86))
> +		__hv_irq_unmask(data);
>  
>  	if (data->parent_data->chip->irq_unmask)
>  		irq_chip_unmask_parent(data);
> -- 
> 2.35.1
> 
