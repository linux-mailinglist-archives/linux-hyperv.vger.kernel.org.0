Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFFC339A955
	for <lists+linux-hyperv@lfdr.de>; Thu,  3 Jun 2021 19:37:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231197AbhFCRiu (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 3 Jun 2021 13:38:50 -0400
Received: from foss.arm.com ([217.140.110.172]:47234 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229845AbhFCRit (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 3 Jun 2021 13:38:49 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C2F0512FC;
        Thu,  3 Jun 2021 10:37:04 -0700 (PDT)
Received: from e123427-lin.cambridge.arm.com (unknown [10.57.39.253])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B0D853F73D;
        Thu,  3 Jun 2021 10:37:02 -0700 (PDT)
Date:   Thu, 3 Jun 2021 18:36:56 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     longli@linuxonhyperv.com
Cc:     "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Long Li <longli@microsoft.com>
Subject: Re: [Patch v3 1/2] PCI: hv: Fix a race condition when removing the
 device
Message-ID: <20210603173656.GA25081@e123427-lin.cambridge.arm.com>
References: <1620806800-30983-1-git-send-email-longli@linuxonhyperv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1620806800-30983-1-git-send-email-longli@linuxonhyperv.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, May 12, 2021 at 01:06:40AM -0700, longli@linuxonhyperv.com wrote:
> From: Long Li <longli@microsoft.com>
> 
> On removing the device, any work item (hv_pci_devices_present() or
> hv_pci_eject_device()) scheduled on workqueue hbus->wq may still be running
> and race with hv_pci_remove().
> 
> This can happen because the host may send PCI_EJECT or PCI_BUS_RELATIONS(2)
> and decide to rescind the channel immediately after that.
> 
> Fix this by flushing/destroying the workqueue of hbus before doing hbus remove.
> 
> Signed-off-by: Long Li <longli@microsoft.com>
> ---
> Change in v2: Remove unused bus state hv_pcibus_removed
> Change in v3: Change hv_pci_bus_exit() to not use workqueue to remove PCI devices
> 
>  drivers/pci/controller/pci-hyperv.c | 30 ++++++++++++++++++++++-------
>  1 file changed, 23 insertions(+), 7 deletions(-)

Applied series to pci/hv, thanks.

Lorenzo

> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
> index 27a17a1e4a7c..c6122a1b0c46 100644
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -444,7 +444,6 @@ enum hv_pcibus_state {
>  	hv_pcibus_probed,
>  	hv_pcibus_installed,
>  	hv_pcibus_removing,
> -	hv_pcibus_removed,
>  	hv_pcibus_maximum
>  };
>  
> @@ -3247,8 +3246,9 @@ static int hv_pci_bus_exit(struct hv_device *hdev, bool keep_devs)
>  		struct pci_packet teardown_packet;
>  		u8 buffer[sizeof(struct pci_message)];
>  	} pkt;
> -	struct hv_dr_state *dr;
>  	struct hv_pci_compl comp_pkt;
> +	struct hv_pci_dev *hpdev, *tmp;
> +	unsigned long flags;
>  	int ret;
>  
>  	/*
> @@ -3260,9 +3260,16 @@ static int hv_pci_bus_exit(struct hv_device *hdev, bool keep_devs)
>  
>  	if (!keep_devs) {
>  		/* Delete any children which might still exist. */
> -		dr = kzalloc(sizeof(*dr), GFP_KERNEL);
> -		if (dr && hv_pci_start_relations_work(hbus, dr))
> -			kfree(dr);
> +		spin_lock_irqsave(&hbus->device_list_lock, flags);
> +		list_for_each_entry_safe(hpdev, tmp, &hbus->children, list_entry) {
> +			list_del(&hpdev->list_entry);
> +			if (hpdev->pci_slot)
> +				pci_destroy_slot(hpdev->pci_slot);
> +			/* For the two refs got in new_pcichild_device() */
> +			put_pcichild(hpdev);
> +			put_pcichild(hpdev);
> +		}
> +		spin_unlock_irqrestore(&hbus->device_list_lock, flags);
>  	}
>  
>  	ret = hv_send_resources_released(hdev);
> @@ -3305,13 +3312,23 @@ static int hv_pci_remove(struct hv_device *hdev)
>  
>  	hbus = hv_get_drvdata(hdev);
>  	if (hbus->state == hv_pcibus_installed) {
> +		tasklet_disable(&hdev->channel->callback_event);
> +		hbus->state = hv_pcibus_removing;
> +		tasklet_enable(&hdev->channel->callback_event);
> +		destroy_workqueue(hbus->wq);
> +		hbus->wq = NULL;
> +		/*
> +		 * At this point, no work is running or can be scheduled
> +		 * on hbus-wq. We can't race with hv_pci_devices_present()
> +		 * or hv_pci_eject_device(), it's safe to proceed.
> +		 */
> +
>  		/* Remove the bus from PCI's point of view. */
>  		pci_lock_rescan_remove();
>  		pci_stop_root_bus(hbus->pci_bus);
>  		hv_pci_remove_slots(hbus);
>  		pci_remove_root_bus(hbus->pci_bus);
>  		pci_unlock_rescan_remove();
> -		hbus->state = hv_pcibus_removed;
>  	}
>  
>  	ret = hv_pci_bus_exit(hdev, false);
> @@ -3326,7 +3343,6 @@ static int hv_pci_remove(struct hv_device *hdev)
>  	irq_domain_free_fwnode(hbus->sysdata.fwnode);
>  	put_hvpcibus(hbus);
>  	wait_for_completion(&hbus->remove_event);
> -	destroy_workqueue(hbus->wq);
>  
>  	hv_put_dom_num(hbus->sysdata.domain);
>  
> -- 
> 2.27.0
> 
