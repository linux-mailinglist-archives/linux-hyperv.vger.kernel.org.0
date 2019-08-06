Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 92B7783A24
	for <lists+linux-hyperv@lfdr.de>; Tue,  6 Aug 2019 22:16:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726018AbfHFUQO (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 6 Aug 2019 16:16:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:33028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725881AbfHFUQO (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 6 Aug 2019 16:16:14 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E7AD82070C;
        Tue,  6 Aug 2019 20:16:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565122573;
        bh=CHdEFDdC6MO7xI0dc+/jQv+NXvBM8cI43X6TKLK577M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ow2jBeqS4Y7JdM2VwzqcvRHDfcYU5ouUMku8rA0TEMfRBQDVxyFec06eyKybYUgQj
         KySLkYju9Gy0giIsRKiwHVCe2w5O03hmfEqqL1u/EMaYF4M5aWvTCLomJ6ILbWLvTT
         r29xKNy6KNSqg5rwyLzneBnk8LV420HPO1gyF9MM=
Date:   Tue, 6 Aug 2019 15:16:11 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Dexuan Cui <decui@microsoft.com>
Cc:     "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
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
        "jackm@mellanox.com" <jackm@mellanox.com>
Subject: Re: [PATCH v2] PCI: hv: Fix panic by calling hv_pci_remove_slots()
 earlier
Message-ID: <20190806201611.GT151852@google.com>
References: <PU1P153MB01693F32F6BB02F9655CC84EBFD90@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PU1P153MB01693F32F6BB02F9655CC84EBFD90@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Thanks for updating this.  But you didn't update the subject line,
which is really still a little too low-level.  Maybe Lorenzo will fix
this.  Something like this, maybe?

  PCI: hv: Avoid use of hv_pci_dev->pci_slot after freeing it

On Fri, Aug 02, 2019 at 10:50:20PM +0000, Dexuan Cui wrote:
> 
> The slot must be removed before the pci_dev is removed, otherwise a panic
> can happen due to use-after-free.
> 
> Fixes: 15becc2b56c6 ("PCI: hv: Add hv_pci_remove_slots() when we unload the driver")
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> Cc: stable@vger.kernel.org
> ---
> 
> Changes in v2:
>   Improved the changelog accordign to the discussion with Bjorn Helgaas:
> 	  https://lkml.org/lkml/2019/8/1/1173
> 	  https://lkml.org/lkml/2019/8/2/1559
> 
>  drivers/pci/controller/pci-hyperv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
> index 6b9cc6e60a..68c611d 100644
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -2757,8 +2757,8 @@ static int hv_pci_remove(struct hv_device *hdev)
>  		/* Remove the bus from PCI's point of view. */
>  		pci_lock_rescan_remove();
>  		pci_stop_root_bus(hbus->pci_bus);
> -		pci_remove_root_bus(hbus->pci_bus);
>  		hv_pci_remove_slots(hbus);
> +		pci_remove_root_bus(hbus->pci_bus);
>  		pci_unlock_rescan_remove();
>  		hbus->state = hv_pcibus_removed;
>  	}
> -- 
> 1.8.3.1
> 
