Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E99711C5A67
	for <lists+linux-hyperv@lfdr.de>; Tue,  5 May 2020 17:03:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729474AbgEEPDX (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 5 May 2020 11:03:23 -0400
Received: from foss.arm.com ([217.140.110.172]:42644 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729832AbgEEPDX (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 5 May 2020 11:03:23 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B10C01FB;
        Tue,  5 May 2020 08:03:22 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2B4BB3F68F;
        Tue,  5 May 2020 08:03:21 -0700 (PDT)
Date:   Tue, 5 May 2020 16:03:15 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Wei Hu <weh@microsoft.com>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, robh@kernel.org, bhelgaas@google.com,
        linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, decui@microsoft.com,
        mikelley@microsoft.com
Subject: Re: [PATCH v2 1/2] PCI: hv: Fix the PCI HyperV probe failure path to
 release resource properly
Message-ID: <20200505150315.GA16228@e121166-lin.cambridge.arm.com>
References: <20200501053617.24689-1-weh@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200501053617.24689-1-weh@microsoft.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, May 01, 2020 at 01:36:17PM +0800, Wei Hu wrote:
> Some error cases in hv_pci_probe() were not handled. Fix these error
> paths to release the resourses and clean up the state properly.

This patch does more than that. It adds a variable to store the
number of slots actually allocated - I presume to free only
allocated on slots on the exit path.

Two patches required I am afraid.

> Signed-off-by: Wei Hu <weh@microsoft.com>
> ---
>  drivers/pci/controller/pci-hyperv.c | 20 ++++++++++++++++----
>  1 file changed, 16 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
> index e15022ff63e3..e6fac0187722 100644
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -480,6 +480,9 @@ struct hv_pcibus_device {
>  
>  	struct workqueue_struct *wq;
>  
> +	/* Highest slot of child device with resources allocated */
> +	int wslot_res_allocated;

I don't understand why you need an int rather than a u32.

Furthermore, I think a bitmap is more appropriate for what this
variable is used for.

> +
>  	/* hypercall arg, must not cross page boundary */
>  	struct hv_retarget_device_interrupt retarget_msi_interrupt_params;
>  
> @@ -2847,7 +2850,7 @@ static int hv_send_resources_allocated(struct hv_device *hdev)
>  	struct hv_pci_dev *hpdev;
>  	struct pci_packet *pkt;
>  	size_t size_res;
> -	u32 wslot;
> +	int wslot;
>  	int ret;
>  
>  	size_res = (hbus->protocol_version < PCI_PROTOCOL_VERSION_1_2)
> @@ -2900,6 +2903,8 @@ static int hv_send_resources_allocated(struct hv_device *hdev)
>  				comp_pkt.completion_status);
>  			break;
>  		}
> +
> +		hbus->wslot_res_allocated = wslot;
>  	}
>  
>  	kfree(pkt);
> @@ -2918,10 +2923,10 @@ static int hv_send_resources_released(struct hv_device *hdev)
>  	struct hv_pcibus_device *hbus = hv_get_drvdata(hdev);
>  	struct pci_child_message pkt;
>  	struct hv_pci_dev *hpdev;
> -	u32 wslot;
> +	int wslot;
>  	int ret;
>  
> -	for (wslot = 0; wslot < 256; wslot++) {
> +	for (wslot = hbus->wslot_res_allocated; wslot >= 0; wslot--) {
>  		hpdev = get_pcichild_wslot(hbus, wslot);
>  		if (!hpdev)
>  			continue;
> @@ -2936,8 +2941,12 @@ static int hv_send_resources_released(struct hv_device *hdev)
>  				       VM_PKT_DATA_INBAND, 0);
>  		if (ret)
>  			return ret;
> +
> +		hbus->wslot_res_allocated = wslot - 1;

Do you really need to set it at every loop iteration ?

Moreover, I think a bitmap is better suited for what you are doing,
given that you may skip some loop indexes on !hpdev.

>  	}
>  
> +	hbus->wslot_res_allocated = -1;
> +
>  	return 0;
>  }
>  
> @@ -3037,6 +3046,7 @@ static int hv_pci_probe(struct hv_device *hdev,
>  	if (!hbus)
>  		return -ENOMEM;
>  	hbus->state = hv_pcibus_init;
> +	hbus->wslot_res_allocated = -1;
>  
>  	/*
>  	 * The PCI bus "domain" is what is called "segment" in ACPI and other
> @@ -3136,7 +3146,7 @@ static int hv_pci_probe(struct hv_device *hdev,
>  
>  	ret = hv_pci_allocate_bridge_windows(hbus);
>  	if (ret)
> -		goto free_irq_domain;
> +		goto exit_d0;
>  
>  	ret = hv_send_resources_allocated(hdev);
>  	if (ret)
> @@ -3154,6 +3164,8 @@ static int hv_pci_probe(struct hv_device *hdev,
>  
>  free_windows:
>  	hv_pci_free_bridge_windows(hbus);
> +exit_d0:
> +	(void) hv_pci_bus_exit(hdev, true);

Remove the (void) cast.

Lorenzo

>  free_irq_domain:
>  	irq_domain_remove(hbus->irq_domain);
>  free_fwnode:
> -- 
> 2.20.1
> 
