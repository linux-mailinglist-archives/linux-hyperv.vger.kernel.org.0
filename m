Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7903622AD52
	for <lists+linux-hyperv@lfdr.de>; Thu, 23 Jul 2020 13:14:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727828AbgGWLON (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 23 Jul 2020 07:14:13 -0400
Received: from foss.arm.com ([217.140.110.172]:44004 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726867AbgGWLON (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 23 Jul 2020 07:14:13 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 413A1D6E;
        Thu, 23 Jul 2020 04:14:12 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AE4663F718;
        Thu, 23 Jul 2020 04:14:10 -0700 (PDT)
Date:   Thu, 23 Jul 2020 12:14:02 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Wei Hu <weh@microsoft.com>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, robh@kernel.org, bhelgaas@google.com,
        linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, decui@microsoft.com,
        mikelley@microsoft.com
Subject: Re: [PATCH v3] PCI: hv: Fix a timing issue which causes kdump to
 fail occasionally
Message-ID: <20200723111402.GA8120@e121166-lin.cambridge.arm.com>
References: <20200718034752.4843-1-weh@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200718034752.4843-1-weh@microsoft.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Sat, Jul 18, 2020 at 11:47:52AM +0800, Wei Hu wrote:
> Kdump could fail sometime on Hyper-V guest over Accelerated Network
> interface. This is because the retry in hv_pci_enter_d0() relies on
> an asynchronous host event arriving before the guest calls
> hv_send_resources_allocated(). Fix the problem by moving retry
> to hv_pci_probe(), removing this dependency and making the calling
> sequence synchronous.

You have to explain why this code move fixes the problem and you
also have to add a comment to the code so that anyone who has to
fix it in the future can understand why the code is where you
are moving it to and why that's a solution.

> Fixes: c81992e7f4aa ("PCI: hv: Retry PCI bus D0 entry on invalid device state")
> Signed-off-by: Wei Hu <weh@microsoft.com>

Please carry tags and send patches -in-reply-to the previous version
to allow threading.

Thanks,
Lorenzo

> ---
>     v2: Adding Fixes tag according to Michael Kelley's review comment.
>     v3: Fix couple typos and reword commit message to make it clearer.
>     Thanks the comments from Bjorn Helgaas.
> 
>  drivers/pci/controller/pci-hyperv.c | 66 ++++++++++++++---------------
>  1 file changed, 32 insertions(+), 34 deletions(-)
> 
> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
> index bf40ff09c99d..738ee30f3334 100644
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -2759,10 +2759,8 @@ static int hv_pci_enter_d0(struct hv_device *hdev)
>  	struct pci_bus_d0_entry *d0_entry;
>  	struct hv_pci_compl comp_pkt;
>  	struct pci_packet *pkt;
> -	bool retry = true;
>  	int ret;
>  
> -enter_d0_retry:
>  	/*
>  	 * Tell the host that the bus is ready to use, and moved into the
>  	 * powered-on state.  This includes telling the host which region
> @@ -2789,38 +2787,6 @@ static int hv_pci_enter_d0(struct hv_device *hdev)
>  	if (ret)
>  		goto exit;
>  
> -	/*
> -	 * In certain case (Kdump) the pci device of interest was
> -	 * not cleanly shut down and resource is still held on host
> -	 * side, the host could return invalid device status.
> -	 * We need to explicitly request host to release the resource
> -	 * and try to enter D0 again.
> -	 */
> -	if (comp_pkt.completion_status < 0 && retry) {
> -		retry = false;
> -
> -		dev_err(&hdev->device, "Retrying D0 Entry\n");
> -
> -		/*
> -		 * Hv_pci_bus_exit() calls hv_send_resource_released()
> -		 * to free up resources of its child devices.
> -		 * In the kdump kernel we need to set the
> -		 * wslot_res_allocated to 255 so it scans all child
> -		 * devices to release resources allocated in the
> -		 * normal kernel before panic happened.
> -		 */
> -		hbus->wslot_res_allocated = 255;
> -
> -		ret = hv_pci_bus_exit(hdev, true);
> -
> -		if (ret == 0) {
> -			kfree(pkt);
> -			goto enter_d0_retry;
> -		}
> -		dev_err(&hdev->device,
> -			"Retrying D0 failed with ret %d\n", ret);
> -	}
> -
>  	if (comp_pkt.completion_status < 0) {
>  		dev_err(&hdev->device,
>  			"PCI Pass-through VSP failed D0 Entry with status %x\n",
> @@ -3058,6 +3024,7 @@ static int hv_pci_probe(struct hv_device *hdev,
>  	struct hv_pcibus_device *hbus;
>  	u16 dom_req, dom;
>  	char *name;
> +	bool enter_d0_retry = true;
>  	int ret;
>  
>  	/*
> @@ -3178,11 +3145,42 @@ static int hv_pci_probe(struct hv_device *hdev,
>  	if (ret)
>  		goto free_fwnode;
>  
> +retry:
>  	ret = hv_pci_query_relations(hdev);
>  	if (ret)
>  		goto free_irq_domain;
>  
>  	ret = hv_pci_enter_d0(hdev);
> +	/*
> +	 * In certain case (Kdump) the pci device of interest was
> +	 * not cleanly shut down and resource is still held on host
> +	 * side, the host could return invalid device status.
> +	 * We need to explicitly request host to release the resource
> +	 * and try to enter D0 again.
> +	 * The retry should start from hv_pci_query_relations() call.
> +	 */
> +	if (ret == -EPROTO && enter_d0_retry) {
> +		enter_d0_retry = false;
> +
> +		dev_err(&hdev->device, "Retrying D0 Entry\n");
> +
> +		/*
> +		 * Hv_pci_bus_exit() calls hv_send_resources_released()
> +		 * to free up resources of its child devices.
> +		 * In the kdump kernel we need to set the
> +		 * wslot_res_allocated to 255 so it scans all child
> +		 * devices to release resources allocated in the
> +		 * normal kernel before panic happened.
> +		 */
> +		hbus->wslot_res_allocated = 255;
> +		ret = hv_pci_bus_exit(hdev, true);
> +
> +		if (ret == 0)
> +			goto retry;
> +
> +		dev_err(&hdev->device,
> +			"Retrying D0 failed with ret %d\n", ret);
> +	}
>  	if (ret)
>  		goto free_irq_domain;
>  
> -- 
> 2.20.1
> 
