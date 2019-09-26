Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D819FBF6C1
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Sep 2019 18:31:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727478AbfIZQay (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 26 Sep 2019 12:30:54 -0400
Received: from foss.arm.com ([217.140.110.172]:54406 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727388AbfIZQay (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 26 Sep 2019 12:30:54 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 70CAA28;
        Thu, 26 Sep 2019 09:30:53 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (unknown [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1BF313F534;
        Thu, 26 Sep 2019 09:30:52 -0700 (PDT)
Date:   Thu, 26 Sep 2019 17:30:49 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Dexuan Cui <decui@microsoft.com>
Cc:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "sashal@kernel.org" <sashal@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>
Subject: Re: [PATCH 2/4] PCI: hv: Add the support of hibernation
Message-ID: <20190926163049.GB7827@e121166-lin.cambridge.arm.com>
References: <1568245086-70601-1-git-send-email-decui@microsoft.com>
 <1568245086-70601-3-git-send-email-decui@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1568245086-70601-3-git-send-email-decui@microsoft.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Sep 11, 2019 at 11:38:20PM +0000, Dexuan Cui wrote:
> Implement the suspend/resume callbacks for hibernation.
> 
> hv_pci_suspend() needs to prevent any new work from being queued: a later
> patch will address this issue.

I don't see why you have two separate patches, the second one fixing the
previous (this one). Squash them together and merge them as such, or
there is something I am missing here.

Lorenzo

> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> ---
>  drivers/pci/controller/pci-hyperv.c | 76 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 76 insertions(+)
> 
> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
> index 03fa039..3b77a3a 100644
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -1398,6 +1398,23 @@ static void prepopulate_bars(struct hv_pcibus_device *hbus)
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
> @@ -2737,6 +2754,63 @@ static int hv_pci_remove(struct hv_device *hdev)
>  	return ret;
>  }
>  
> +static int hv_pci_suspend(struct hv_device *hdev)
> +{
> +	struct hv_pcibus_device *hbus = hv_get_drvdata(hdev);
> +	int ret;
> +
> +	/* XXX: Need to prevent any new work from being queued. */
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
> @@ -2751,6 +2825,8 @@ static int hv_pci_remove(struct hv_device *hdev)
>  	.id_table	= hv_pci_id_table,
>  	.probe		= hv_pci_probe,
>  	.remove		= hv_pci_remove,
> +	.suspend	= hv_pci_suspend,
> +	.resume		= hv_pci_resume,
>  };
>  
>  static void __exit exit_hv_pci_drv(void)
> -- 
> 1.8.3.1
> 
