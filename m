Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 307F5606C2
	for <lists+linux-hyperv@lfdr.de>; Fri,  5 Jul 2019 15:41:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728121AbfGENlo (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 5 Jul 2019 09:41:44 -0400
Received: from foss.arm.com ([217.140.110.172]:38504 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727702AbfGENlo (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 5 Jul 2019 09:41:44 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2C082360;
        Fri,  5 Jul 2019 06:41:43 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (unknown [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0B0AF3F718;
        Fri,  5 Jul 2019 06:41:40 -0700 (PDT)
Date:   Fri, 5 Jul 2019 14:41:38 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Dexuan Cui <decui@microsoft.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "olaf@aepfle.de" <olaf@aepfle.de>,
        "apw@canonical.com" <apw@canonical.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        vkuznets <vkuznets@redhat.com>,
        "marcelo.cerri@canonical.com" <marcelo.cerri@canonical.com>,
        Michael Kelley <mikelley@microsoft.com>,
        "Lili Deng (Wicresoft North America Ltd)" <v-lide@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "driverdev-devel@linuxdriverproject.org" 
        <driverdev-devel@linuxdriverproject.org>
Subject: Re: [PATCH v2] PCI: hv: Fix a use-after-free bug in
 hv_eject_device_work()
Message-ID: <20190705134138.GB31464@e121166-lin.cambridge.arm.com>
References: <PU1P153MB0169D420EAB61757DF4B337FBFE70@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PU1P153MB0169D420EAB61757DF4B337FBFE70@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, Jun 21, 2019 at 11:45:23PM +0000, Dexuan Cui wrote:
> 
> The commit 05f151a73ec2 itself is correct, but it exposes this
> use-after-free bug, which is caught by some memory debug options.
> 
> Add a Fixes tag to indicate the dependency.
> 
> Fixes: 05f151a73ec2 ("PCI: hv: Fix a memory leak in hv_eject_device_work()")
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> Cc: stable@vger.kernel.org
> ---
> 
> In v2:
> Replaced "hpdev->hbus" with "hbus", since we have the new "hbus" variable. [Michael Kelley]
> 
>  drivers/pci/controller/pci-hyperv.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)

Applied to pci/hv for v5.3, thanks.

Lorenzo

> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
> index 808a182830e5..5dadc964ad3b 100644
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -1880,6 +1880,7 @@ static void hv_pci_devices_present(struct hv_pcibus_device *hbus,
>  static void hv_eject_device_work(struct work_struct *work)
>  {
>  	struct pci_eject_response *ejct_pkt;
> +	struct hv_pcibus_device *hbus;
>  	struct hv_pci_dev *hpdev;
>  	struct pci_dev *pdev;
>  	unsigned long flags;
> @@ -1890,6 +1891,7 @@ static void hv_eject_device_work(struct work_struct *work)
>  	} ctxt;
>  
>  	hpdev = container_of(work, struct hv_pci_dev, wrk);
> +	hbus = hpdev->hbus;
>  
>  	WARN_ON(hpdev->state != hv_pcichild_ejecting);
>  
> @@ -1900,8 +1902,7 @@ static void hv_eject_device_work(struct work_struct *work)
>  	 * because hbus->pci_bus may not exist yet.
>  	 */
>  	wslot = wslot_to_devfn(hpdev->desc.win_slot.slot);
> -	pdev = pci_get_domain_bus_and_slot(hpdev->hbus->sysdata.domain, 0,
> -					   wslot);
> +	pdev = pci_get_domain_bus_and_slot(hbus->sysdata.domain, 0, wslot);
>  	if (pdev) {
>  		pci_lock_rescan_remove();
>  		pci_stop_and_remove_bus_device(pdev);
> @@ -1909,9 +1910,9 @@ static void hv_eject_device_work(struct work_struct *work)
>  		pci_unlock_rescan_remove();
>  	}
>  
> -	spin_lock_irqsave(&hpdev->hbus->device_list_lock, flags);
> +	spin_lock_irqsave(&hbus->device_list_lock, flags);
>  	list_del(&hpdev->list_entry);
> -	spin_unlock_irqrestore(&hpdev->hbus->device_list_lock, flags);
> +	spin_unlock_irqrestore(&hbus->device_list_lock, flags);
>  
>  	if (hpdev->pci_slot)
>  		pci_destroy_slot(hpdev->pci_slot);
> @@ -1920,7 +1921,7 @@ static void hv_eject_device_work(struct work_struct *work)
>  	ejct_pkt = (struct pci_eject_response *)&ctxt.pkt.message;
>  	ejct_pkt->message_type.type = PCI_EJECTION_COMPLETE;
>  	ejct_pkt->wslot.slot = hpdev->desc.win_slot.slot;
> -	vmbus_sendpacket(hpdev->hbus->hdev->channel, ejct_pkt,
> +	vmbus_sendpacket(hbus->hdev->channel, ejct_pkt,
>  			 sizeof(*ejct_pkt), (unsigned long)&ctxt.pkt,
>  			 VM_PKT_DATA_INBAND, 0);
>  
> @@ -1929,7 +1930,9 @@ static void hv_eject_device_work(struct work_struct *work)
>  	/* For the two refs got in new_pcichild_device() */
>  	put_pcichild(hpdev);
>  	put_pcichild(hpdev);
> -	put_hvpcibus(hpdev->hbus);
> +	/* hpdev has been freed. Do not use it any more. */
> +
> +	put_hvpcibus(hbus);
>  }
>  
>  /**
> -- 
> 2.17.1
> 
