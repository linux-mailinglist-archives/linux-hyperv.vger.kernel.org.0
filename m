Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A90248B161
	for <lists+linux-hyperv@lfdr.de>; Tue, 11 Jan 2022 16:54:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349736AbiAKPyR (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 11 Jan 2022 10:54:17 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:33616 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349717AbiAKPyQ (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 11 Jan 2022 10:54:16 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6D14FB81BF8;
        Tue, 11 Jan 2022 15:54:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE563C36AEB;
        Tue, 11 Jan 2022 15:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641916454;
        bh=T5c0P8FQreFRKifJE6e3VfdZbkyIrx9FCHWvF3HAhiI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=rwbeq0Su4ZnZp2ul6F2k4DIsunfjn6CeEzBimEPwKjVYMlRM6nJZ8i/lcseyZRq01
         hOsT1xxCdws9wKyLY6i7K8lt4RBwpZUuCdosDgMwKxx8sRsfdET0b+MyZ7u6fhVktB
         gVhE7WzIruePUwNtqQdtp0bHmiBB5obNXMRY3F7XSI93JQVPj2OyMOR2sk+3JNFgUv
         donNVu2a5vMyZle3x858i2iPLij2yL7sI5EqVlBH1OtkH36dpPqN9rNwthRuTbrCB/
         Nq7mcEnsLoEi7dX2ZO9eRW6CDCXmpwmT5de/JXb0uQsAjZKOKAgg00y8Iw1XEymkEb
         lmjrjZF8x49Pg==
Date:   Tue, 11 Jan 2022 09:54:12 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, decui@microsoft.com, lorenzo.pieralisi@arm.com,
        robh@kernel.org, kw@linux.com, bhelgaas@google.com,
        linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>
Subject: Re: [PATCH -next] PCI: hv: Unsigned comparison with less than zero
Message-ID: <20220111155412.GA142851@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220111012622.19447-1-yang.lee@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

[+cc Sunil]

On Tue, Jan 11, 2022 at 09:26:22AM +0800, Yang Li wrote:
> The return from the call to bitmap_find_free_region() is int, it can be
> a negative error code, however this is being assigned to an unsigned
> int variable 'index', so making 'index' an int.
> 
> Eliminate the following coccicheck warning:
> ./drivers/pci/controller/pci-hyperv.c:712:5-10: WARNING: Unsigned
> expression compared with zero: index < 0

Definitely looks like a bug.  Thanks very much for catching it!

Minor things:

  1) Can you make the subject and commit log talk about the *bug* this
     fixes, which is that an error return from
     bitmap_find_free_region() is currently ignored and we instead
     return a completely bogus *hwirq from
     hv_pci_vec_alloc_device_irq()?

     The warning is only secondary.

  2) When fixing a bug, can you also mention the commit that
     *introduced* the bug, so we can figure out where the fix needs to
     be backported?

     It looks like c10bdb758ca4 ("PCI: hv: Add arm64 Hyper-V vPCI
     support"), so we should have a line like this:

     Fixes: c10bdb758ca4 ("PCI: hv: Add arm64 Hyper-V vPCI support")

     In this case, c10bdb758ca4 is still pending for the current merge
     window, so we'll probably squash this fix into the commit so
     there's no bisection window between c10bdb758ca4 and the fix.

  3) Please cc the author of the original commit in case there's
     something we're missing (I added Sunil here).

  4) Make the subject line start with a verb so it matches the style
     in drivers/pci/, where I try to make the subject line a sentence
     that makes sense all by itself and tells what the patch does.

Thanks again for the fix!

Bjorn

> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
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
