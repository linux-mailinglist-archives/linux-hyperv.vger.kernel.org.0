Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF9C71041F6
	for <lists+linux-hyperv@lfdr.de>; Wed, 20 Nov 2019 18:20:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727619AbfKTRUb (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 20 Nov 2019 12:20:31 -0500
Received: from foss.arm.com ([217.140.110.172]:43472 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727127AbfKTRUa (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 20 Nov 2019 12:20:30 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0600F1045;
        Wed, 20 Nov 2019 09:20:30 -0800 (PST)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8EE153F703;
        Wed, 20 Nov 2019 09:20:28 -0800 (PST)
Date:   Wed, 20 Nov 2019 17:20:26 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Dexuan Cui <decui@microsoft.com>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        sashal@kernel.org, bhelgaas@google.com,
        linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, mikelley@microsoft.com,
        Alexander.Levin@microsoft.com
Subject: Re: [PATCH v2 2/4] PCI: hv: Add the support of hibernation
Message-ID: <20191120172026.GE3279@e121166-lin.cambridge.arm.com>
References: <1574234218-49195-1-git-send-email-decui@microsoft.com>
 <1574234218-49195-3-git-send-email-decui@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1574234218-49195-3-git-send-email-decui@microsoft.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Nov 19, 2019 at 11:16:56PM -0800, Dexuan Cui wrote:
> Implement the suspend/resume callbacks.
> 
> We must make sure there is no pending work items before we call
> vmbus_close().

Where ? Why ? Imagine a developer reading this log to try to understand
why you made this change, do you really think this commit log is
informative in its current form ?

I am not asking a book but this is a significant feature please make
an effort to explain it (I can update the log for you but please
write one and I shall do it).

Lorenzo

> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> ---
> 
> Changes in v2: this patch is a simple merge of 2 previous smaller patches,
> accordign to the suggestion of Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>.
> 
>  drivers/pci/controller/pci-hyperv.c | 107 +++++++++++++++++++++++++++-
>  1 file changed, 105 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
> index 65f18f840ce9..e71eb6e0bfdd 100644
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -455,6 +455,7 @@ enum hv_pcibus_state {
>  	hv_pcibus_init = 0,
>  	hv_pcibus_probed,
>  	hv_pcibus_installed,
> +	hv_pcibus_removing,
>  	hv_pcibus_removed,
>  	hv_pcibus_maximum
>  };
> @@ -1681,6 +1682,23 @@ static void prepopulate_bars(struct hv_pcibus_device *hbus)
>  
>  	spin_lock_irqsave(&hbus->device_list_lock, flags);
>  
> +	/*
> +	 * Clear the memory enable bit, in case it's already set. This occurs
> +	 * in the suspend path of hibernation, where the device is suspended,
> +	 * resumed and suspended again: see hibernation_snapshot() and
> +	 * hibernation_platform_enter().
> +	 *
> +	 * If the memory enable bit is already set, Hyper-V sliently ignores
> +	 * the below BAR updates, and the related PCI device driver can not
> +	 * work, because reading from the device register(s) always returns
> +	 * 0xFFFFFFFF.
> +	 */
> +	list_for_each_entry(hpdev, &hbus->children, list_entry) {
> +		_hv_pcifront_read_config(hpdev, PCI_COMMAND, 2, &command);
> +		command &= ~PCI_COMMAND_MEMORY;
> +		_hv_pcifront_write_config(hpdev, PCI_COMMAND, 2, command);
> +	}
> +
>  	/* Pick addresses for the BARs. */
>  	do {
>  		list_for_each_entry(hpdev, &hbus->children, list_entry) {
> @@ -2107,6 +2125,12 @@ static void hv_pci_devices_present(struct hv_pcibus_device *hbus,
>  	unsigned long flags;
>  	bool pending_dr;
>  
> +	if (hbus->state == hv_pcibus_removing) {
> +		dev_info(&hbus->hdev->device,
> +			 "PCI VMBus BUS_RELATIONS: ignored\n");
> +		return;
> +	}
> +
>  	dr_wrk = kzalloc(sizeof(*dr_wrk), GFP_NOWAIT);
>  	if (!dr_wrk)
>  		return;
> @@ -2223,11 +2247,19 @@ static void hv_eject_device_work(struct work_struct *work)
>   */
>  static void hv_pci_eject_device(struct hv_pci_dev *hpdev)
>  {
> +	struct hv_pcibus_device *hbus = hpdev->hbus;
> +	struct hv_device *hdev = hbus->hdev;
> +
> +	if (hbus->state == hv_pcibus_removing) {
> +		dev_info(&hdev->device, "PCI VMBus EJECT: ignored\n");
> +		return;
> +	}
> +
>  	hpdev->state = hv_pcichild_ejecting;
>  	get_pcichild(hpdev);
>  	INIT_WORK(&hpdev->wrk, hv_eject_device_work);
> -	get_hvpcibus(hpdev->hbus);
> -	queue_work(hpdev->hbus->wq, &hpdev->wrk);
> +	get_hvpcibus(hbus);
> +	queue_work(hbus->wq, &hpdev->wrk);
>  }
>  
>  /**
> @@ -3107,6 +3139,75 @@ static int hv_pci_remove(struct hv_device *hdev)
>  	return ret;
>  }
>  
> +static int hv_pci_suspend(struct hv_device *hdev)
> +{
> +	struct hv_pcibus_device *hbus = hv_get_drvdata(hdev);
> +	enum hv_pcibus_state old_state;
> +	int ret;
> +
> +	tasklet_disable(&hdev->channel->callback_event);
> +
> +	/* Change the hbus state to prevent new work items. */
> +	old_state = hbus->state;
> +	if (hbus->state == hv_pcibus_installed)
> +		hbus->state = hv_pcibus_removing;
> +
> +	tasklet_enable(&hdev->channel->callback_event);
> +
> +	if (old_state != hv_pcibus_installed)
> +		return -EINVAL;
> +
> +	flush_workqueue(hbus->wq);
> +
> +	ret = hv_pci_bus_exit(hdev, true);
> +	if (ret)
> +		return ret;
> +
> +	vmbus_close(hdev->channel);
> +
> +	return 0;
> +}
> +
> +static int hv_pci_resume(struct hv_device *hdev)
> +{
> +	struct hv_pcibus_device *hbus = hv_get_drvdata(hdev);
> +	enum pci_protocol_version_t version[1];
> +	int ret;
> +
> +	hbus->state = hv_pcibus_init;
> +
> +	ret = vmbus_open(hdev->channel, pci_ring_size, pci_ring_size, NULL, 0,
> +			 hv_pci_onchannelcallback, hbus);
> +	if (ret)
> +		return ret;
> +
> +	/* Only use the version that was in use before hibernation. */
> +	version[0] = pci_protocol_version;
> +	ret = hv_pci_protocol_negotiation(hdev, version, 1);
> +	if (ret)
> +		goto out;
> +
> +	ret = hv_pci_query_relations(hdev);
> +	if (ret)
> +		goto out;
> +
> +	ret = hv_pci_enter_d0(hdev);
> +	if (ret)
> +		goto out;
> +
> +	ret = hv_send_resources_allocated(hdev);
> +	if (ret)
> +		goto out;
> +
> +	prepopulate_bars(hbus);
> +
> +	hbus->state = hv_pcibus_installed;
> +	return 0;
> +out:
> +	vmbus_close(hdev->channel);
> +	return ret;
> +}
> +
>  static const struct hv_vmbus_device_id hv_pci_id_table[] = {
>  	/* PCI Pass-through Class ID */
>  	/* 44C4F61D-4444-4400-9D52-802E27EDE19F */
> @@ -3121,6 +3222,8 @@ static struct hv_driver hv_pci_drv = {
>  	.id_table	= hv_pci_id_table,
>  	.probe		= hv_pci_probe,
>  	.remove		= hv_pci_remove,
> +	.suspend	= hv_pci_suspend,
> +	.resume		= hv_pci_resume,
>  };
>  
>  static void __exit exit_hv_pci_drv(void)
> -- 
> 2.19.1
> 
