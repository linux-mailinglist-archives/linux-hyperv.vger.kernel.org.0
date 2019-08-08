Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 411E186A7E
	for <lists+linux-hyperv@lfdr.de>; Thu,  8 Aug 2019 21:19:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404241AbfHHTTQ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 8 Aug 2019 15:19:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:49890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404214AbfHHTTP (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 8 Aug 2019 15:19:15 -0400
Received: from localhost (unknown [150.199.191.185])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BC811214C6;
        Thu,  8 Aug 2019 19:19:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565291955;
        bh=I85MDT/rKbkFPix7KBGWUeZg9LoqJU6dSIlhS3m8a5g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vpDboZe/vRDL5+uvHLu9w2zQuVsD051Exm+FqXk436rp7K5xoYjKyulcfTeuL8yjC
         sEIg4r0zhQrZhCELdFKxA94tDML8MTm3kLCdhxj9kNz5nYgIwfXikWQBhFLPNv//U7
         vpQfbZpj3jEk3bfxfpq1LoEehzSSIGbZ7u5v0fPw=
Date:   Thu, 8 Aug 2019 14:19:13 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Dexuan Cui <decui@microsoft.com>
Cc:     "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "driverdev-devel@linuxdriverproject.org" 
        <driverdev-devel@linuxdriverproject.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        "olaf@aepfle.de" <olaf@aepfle.de>,
        "apw@canonical.com" <apw@canonical.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        vkuznets <vkuznets@redhat.com>,
        "marcelo.cerri@canonical.com" <marcelo.cerri@canonical.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "jackm@mellanox.com" <jackm@mellanox.com>
Subject: Re: [PATCH] PCI: PM: Also move to D0 before calling
 pci_legacy_resume_early()
Message-ID: <20190808191913.GI151852@google.com>
References: <PU1P153MB01695867B01987A8C239A8CCBFD70@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PU1P153MB01695867B01987A8C239A8CCBFD70@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, Aug 08, 2019 at 06:46:51PM +0000, Dexuan Cui wrote:
> 
> In pci_legacy_suspend_late(), the device state is moved to PCI_UNKNOWN.
> In pci_pm_thaw_noirq(), the state is supposed to be moved back to PCI_D0,
> but the current code misses the pci_legacy_resume_early() path, so the
> state remains in PCI_UNKNOWN in that path, and during hiberantion this
> causes an error for the Mellanox VF driver, which fails to enable
> MSI-X: pci_msi_supported() is false due to dev->current_state != PCI_D0:

s/hiberantion/hibernation/

Actually, it sounds more like "during *resume*, this causes an error",
so maybe you want s/hiberantion/resume/ instead?

> mlx4_core a6d1:00:02.0: Detected virtual function - running in slave mode
> mlx4_core a6d1:00:02.0: Sending reset
> mlx4_core a6d1:00:02.0: Sending vhcr0
> mlx4_core a6d1:00:02.0: HCA minimum page size:512
> mlx4_core a6d1:00:02.0: Timestamping is not supported in slave mode
> mlx4_core a6d1:00:02.0: INTx is not supported in multi-function mode, aborting
> PM: dpm_run_callback(): pci_pm_thaw+0x0/0xd7 returns -95
> PM: Device a6d1:00:02.0 failed to thaw: error -95
> 
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> ---
>  drivers/pci/pci-driver.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index 36dbe960306b..27dfc68db9e7 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -1074,15 +1074,16 @@ static int pci_pm_thaw_noirq(struct device *dev)
>  			return error;
>  	}
>  
> -	if (pci_has_legacy_pm_support(pci_dev))
> -		return pci_legacy_resume_early(dev);
> -
>  	/*
>  	 * pci_restore_state() requires the device to be in D0 (because of MSI
>  	 * restoration among other things), so force it into D0 in case the
>  	 * driver's "freeze" callbacks put it into a low-power state directly.
>  	 */
>  	pci_set_power_state(pci_dev, PCI_D0);
> +
> +	if (pci_has_legacy_pm_support(pci_dev))
> +		return pci_legacy_resume_early(dev);
> +
>  	pci_restore_state(pci_dev);
>  
>  	if (drv && drv->pm && drv->pm->thaw_noirq)
> -- 
> 2.19.1
> 
