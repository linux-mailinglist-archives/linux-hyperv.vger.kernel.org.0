Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7947C80123
	for <lists+linux-hyperv@lfdr.de>; Fri,  2 Aug 2019 21:40:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406211AbfHBTk7 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 2 Aug 2019 15:40:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:56576 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406158AbfHBTk6 (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 2 Aug 2019 15:40:58 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6262920B7C;
        Fri,  2 Aug 2019 19:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564774857;
        bh=WiQohTwdjNs2nhpJWkvzqSmwuYyHvaf+sHB+D1spqu8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QUsBRKRWYzLfCeXsS6GiwNhtsEX7cZ4/deEYSQbShEjDdg5AQCe0hJQdmMJasAXkL
         uGdQuNPSn6njNM9u3rOBE0gF5dgrwOSS9c1ZYKi3rRX9nKRIQNv2Ns7pMRQgM5vllh
         2RzkOn5+cLcnW0/Xgx/2zgGZFfQNtTbpHlR6SMRs=
Date:   Fri, 2 Aug 2019 14:40:53 -0500
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
        Stephen Hemminger <sthemmin@microsoft.com>,
        "olaf@aepfle.de" <olaf@aepfle.de>,
        "apw@canonical.com" <apw@canonical.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        vkuznets <vkuznets@redhat.com>,
        "marcelo.cerri@canonical.com" <marcelo.cerri@canonical.com>,
        "jackm@mellanox.com" <jackm@mellanox.com>
Subject: Re: [PATCH] PCI: hv: Fix panic by calling hv_pci_remove_slots()
 earlier
Message-ID: <20190802194053.GL151852@google.com>
References: <PU1P153MB0169DBCFEE7257F5BB93580ABFD90@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PU1P153MB0169DBCFEE7257F5BB93580ABFD90@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hi Dexuan,

The subject line only describes the mechanical code change, which is
obvious from the patch.  It would be better if we could say something
about *why* we need this.

On Fri, Aug 02, 2019 at 01:32:28AM +0000, Dexuan Cui wrote:
> 
> When a slot is removed, the pci_dev must still exist.
> 
> pci_remove_root_bus() removes and free all the pci_devs, so
> hv_pci_remove_slots() must be called before pci_remove_root_bus(),
> otherwise a general protection fault can happen, if the kernel is built

"general protection fault" is an x86 term that doesn't really say what
the issue is.  I suspect this would be a "use-after-free" problem.

> with the memory debugging options.
> 
> Fixes: 15becc2b56c6 ("PCI: hv: Add hv_pci_remove_slots() when we unload the driver")
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> Cc: stable@vger.kernel.org
> 
> ---
> 
> When pci-hyperv is unloaded, this panic can happen:
> 
>  general protection fault:
>  CPU: 2 PID: 1091 Comm: rmmod Not tainted 5.2.0+
>  RIP: 0010:pci_slot_release+0x30/0xd0
>  Call Trace:
>   kobject_release+0x65/0x190
>   pci_destroy_slot+0x25/0x60
>   hv_pci_remove+0xec/0x110 [pci_hyperv]
>   vmbus_remove+0x20/0x30 [hv_vmbus]
>   device_release_driver_internal+0xd5/0x1b0
>   driver_detach+0x44/0x7c
>   bus_remove_driver+0x75/0xc7
>   vmbus_driver_unregister+0x50/0xbd [hv_vmbus]
>   __x64_sys_delete_module+0x136/0x200
>   do_syscall_64+0x5e/0x220
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

I'm curious about why we need hv_pci_remove_slots() at all.  None of
the other callers of pci_stop_root_bus() and pci_remove_root_bus() do
anything similar to hv_pci_remove_slots().

Surely some of those callers also support slots, so there must be some
other path that calls pci_destroy_slot() in those cases.  Can we use a
similar strategy here?

>  		pci_unlock_rescan_remove();
>  		hbus->state = hv_pcibus_removed;
>  	}
> -- 
> 1.8.3.1
> 
