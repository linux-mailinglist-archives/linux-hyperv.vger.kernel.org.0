Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D44B22EB07
	for <lists+linux-hyperv@lfdr.de>; Mon, 27 Jul 2020 13:19:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728075AbgG0LT2 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 27 Jul 2020 07:19:28 -0400
Received: from foss.arm.com ([217.140.110.172]:42188 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726269AbgG0LT1 (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 27 Jul 2020 07:19:27 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AEC9E30E;
        Mon, 27 Jul 2020 04:19:26 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 292EC3F66E;
        Mon, 27 Jul 2020 04:19:25 -0700 (PDT)
Date:   Mon, 27 Jul 2020 12:18:52 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Wei Hu <weh@microsoft.com>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, robh@kernel.org, bhelgaas@google.com,
        linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, decui@microsoft.com,
        mikelley@microsoft.com
Subject: Re: [PATCH v4] PCI: hv: Fix a timing issue which causes kdump to
 fail occasionally
Message-ID: <20200727111852.GA14239@e121166-lin.cambridge.arm.com>
References: <20200727071731.18516-1-weh@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200727071731.18516-1-weh@microsoft.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, Jul 27, 2020 at 03:17:31PM +0800, Wei Hu wrote:
> Kdump could fail sometime on Hyper-V guest over Accelerated Network
> interface. This is because the retry in hv_pci_enter_d0() releases
> child device strurctures in hv_pci_bus_exit(). Although there is
> a second asynchronous device relations message sending from the host,
> if this message arrives guest after hv_send_resource_allocated() is
> called, the retry would fail.
> 
> Fix the problem by moving retry to hv_pci_probe() and starting retry
> from hv_pci_query_relations() call.  This will cause a device relations
> message to arrive guest synchronously.  The guest would be able to
> rebuild the child device structures before calling
> hv_send_resource_allocated().
> 
> This problem only happens on Accelerated Network or SRIOV devices as
> only such devices currently are attached under vmbus PCI bridge.
> 
> Fixes: c81992e7f4aa ("PCI: hv: Retry PCI bus D0 entry on invalid device state")
> Signed-off-by: Wei Hu <weh@microsoft.com>
> Reviewed-by: Michael Kelley <mikelley@microsoft.com>
> ---
>     v2: Adding Fixes tag according to Michael Kelley's review comment.
>     v3: Fix couple typos and reword commit message to make it clearer.
>     Thanks the comments from Bjorn Helgaas.
>     v4: Adding more  problem descritpions in the commit message
>     and code upon request from Lorenze Pieralisi.
> 
>  drivers/pci/controller/pci-hyperv.c | 71 +++++++++++++++--------------
>  1 file changed, 37 insertions(+), 34 deletions(-)
> 
> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c

I edited commit log and a comment in the code to fix a typo and pushed
out to pci/hv.

Thanks,
Lorenzo

> index bf40ff09c99d..d1758986fbc9 100644
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
> @@ -3178,11 +3145,47 @@ static int hv_pci_probe(struct hv_device *hdev,
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
> +	 * Since the hv_pci_bus_exit() call releases structures
> +	 * of all its child devices, we need to start the retry from
> +	 * hv_pci_query_relations() call, requesting host to send
> +	 * the synchronous child device relations message before this
> +	 * information is needed in hv_send_resources_allocated()
> +	 * call later .
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
