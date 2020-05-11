Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04F511CD7CC
	for <lists+linux-hyperv@lfdr.de>; Mon, 11 May 2020 13:21:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726068AbgEKLVS (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 11 May 2020 07:21:18 -0400
Received: from foss.arm.com ([217.140.110.172]:57476 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729687AbgEKLVQ (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 11 May 2020 07:21:16 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E26D1106F;
        Mon, 11 May 2020 04:21:15 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5E02D3F7B4;
        Mon, 11 May 2020 04:21:14 -0700 (PDT)
Date:   Mon, 11 May 2020 12:21:12 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Wei Hu <weh@microsoft.com>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, robh@kernel.org, bhelgaas@google.com,
        linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, decui@microsoft.com,
        mikelley@microsoft.com
Subject: Re: [PATCH v3 2/2] PCI: hv: Retry PCI bus D0 entry when the first
 attempt failed with invalid device state
Message-ID: <20200511112112.GC24954@e121166-lin.cambridge.arm.com>
References: <20200507050300.10974-1-weh@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200507050300.10974-1-weh@microsoft.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, May 07, 2020 at 01:03:00PM +0800, Wei Hu wrote:
> In the case of kdump, the PCI device was not cleanly shut down
> before the kdump kernel starts. This causes the initial
> attempt of entering D0 state in the kdump kernel to fail with
> invalid device state returned from Hyper-V host.
> When this happens, explicitly call PCI bus exit and retry to
> enter the D0 state.
> 
> Signed-off-by: Wei Hu <weh@microsoft.com>
> ---
>     v2: Incorporate review comments from Michael Kelley, Dexuan Cui and
>     Bjorn Helgaas
> 
>  drivers/pci/controller/pci-hyperv.c | 40 +++++++++++++++++++++++++++--
>  1 file changed, 38 insertions(+), 2 deletions(-)

Subject: exceeded 80 chars and commit log needed rewording and
paragraphs rewrapping. I did it this time but please pay attention
to commit log content (and format).

Thanks,
Lorenzo

> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
> index e6fac0187722..92092a47d3af 100644
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -2739,6 +2739,8 @@ static void hv_free_config_window(struct hv_pcibus_device *hbus)
>  	vmbus_free_mmio(hbus->mem_config->start, PCI_CONFIG_MMIO_LENGTH);
>  }
>  
> +static int hv_pci_bus_exit(struct hv_device *hdev, bool keep_devs);
> +
>  /**
>   * hv_pci_enter_d0() - Bring the "bus" into the D0 power state
>   * @hdev:	VMBus's tracking struct for this root PCI bus
> @@ -2751,8 +2753,10 @@ static int hv_pci_enter_d0(struct hv_device *hdev)
>  	struct pci_bus_d0_entry *d0_entry;
>  	struct hv_pci_compl comp_pkt;
>  	struct pci_packet *pkt;
> +	bool retry = true;
>  	int ret;
>  
> +enter_d0_retry:
>  	/*
>  	 * Tell the host that the bus is ready to use, and moved into the
>  	 * powered-on state.  This includes telling the host which region
> @@ -2779,6 +2783,38 @@ static int hv_pci_enter_d0(struct hv_device *hdev)
>  	if (ret)
>  		goto exit;
>  
> +	/*
> +	 * In certain case (Kdump) the pci device of interest was
> +	 * not cleanly shut down and resource is still held on host
> +	 * side, the host could return invalid device status.
> +	 * We need to explicitly request host to release the resource
> +	 * and try to enter D0 again.
> +	 */
> +	if (comp_pkt.completion_status < 0 && retry) {
> +		retry = false;
> +
> +		dev_err(&hdev->device, "Retrying D0 Entry\n");
> +
> +		/*
> +		 * Hv_pci_bus_exit() calls hv_send_resource_released()
> +		 * to free up resources of its child devices.
> +		 * In the kdump kernel we need to set the
> +		 * wslot_res_allocated to 255 so it scans all child
> +		 * devices to release resources allocated in the
> +		 * normal kernel before panic happened.
> +		 */
> +		hbus->wslot_res_allocated = 255;
> +
> +		ret = hv_pci_bus_exit(hdev, true);
> +
> +		if (ret == 0) {
> +			kfree(pkt);
> +			goto enter_d0_retry;
> +		}
> +		dev_err(&hdev->device,
> +			"Retrying D0 failed with ret %d\n", ret);
> +	}
> +
>  	if (comp_pkt.completion_status < 0) {
>  		dev_err(&hdev->device,
>  			"PCI Pass-through VSP failed D0 Entry with status %x\n",
> @@ -3185,7 +3221,7 @@ static int hv_pci_probe(struct hv_device *hdev,
>  	return ret;
>  }
>  
> -static int hv_pci_bus_exit(struct hv_device *hdev, bool hibernating)
> +static int hv_pci_bus_exit(struct hv_device *hdev, bool keep_devs)
>  {
>  	struct hv_pcibus_device *hbus = hv_get_drvdata(hdev);
>  	struct {
> @@ -3203,7 +3239,7 @@ static int hv_pci_bus_exit(struct hv_device *hdev, bool hibernating)
>  	if (hdev->channel->rescind)
>  		return 0;
>  
> -	if (!hibernating) {
> +	if (!keep_devs) {
>  		/* Delete any children which might still exist. */
>  		dr = kzalloc(sizeof(*dr), GFP_KERNEL);
>  		if (dr && hv_pci_start_relations_work(hbus, dr))
> -- 
> 2.20.1
> 
