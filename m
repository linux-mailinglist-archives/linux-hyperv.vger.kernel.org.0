Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CE061BB1B1
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 Apr 2020 00:51:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726261AbgD0Wvf (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 27 Apr 2020 18:51:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:37616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726224AbgD0Wvf (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 27 Apr 2020 18:51:35 -0400
Received: from localhost (mobile-166-175-187-210.mycingular.net [166.175.187.210])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5260020661;
        Mon, 27 Apr 2020 22:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588027894;
        bh=whRFNUD4BZPg0hJwHb5jAU8zt3B+MFfDdFnuCfCh21Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=jbJ+hBWbFaPZLAZpJBho1x6SwnoZZdRmb11ZCOfY2HQAirKqK3Ud5K3Tc2P/CEHxq
         YfIhwWgwPQzTeUCIK4Wz08oScj7EyiAqznu4rK0Hp9AVonP8uSBxI/HxMtjBtLKEKg
         /QFWHJDSaVjtDIOGeZy74eppVI0aTWQr0pZCSHyU=
Date:   Mon, 27 Apr 2020 17:51:32 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Wei Hu <weh@microsoft.com>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, lorenzo.pieralisi@arm.com, robh@kernel.org,
        linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, decui@microsoft.com,
        mikelley@microsoft.com
Subject: Re: [PATCH] PCI: pci-hyperv: Retry PCI bus D0 entry when the first
 attempt failed with invalid device state 0xC0000184.
Message-ID: <20200427225132.GA9339@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200426132430.1756-1-weh@microsoft.com>
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Please pay attention to the changelog history and make yours match:

  $ git log --oneline drivers/pci/controller/pci-hyperv.c
  1cf106d93245 ("PCI: hv: Introduce hv_msi_entry")
  61bfd920abbf ("PCI: hv: Move retarget related structures into tlfs header")
  b00f80fcfaa0 ("PCI: hv: Move hypercall related definitions into tlfs header")
  067fb6c97e7e ("PCI: hv: Replace zero-length array with flexible-array member")
  999dd956d838 ("PCI: hv: Add support for protocol 1.3 and support PCI_BUS_RELATIONS2")
  f9ad0f361cf3 ("PCI: hv: Decouple the func definition in hv_dr_state from VSP message")
  42c3d41832ef ("PCI: hv: Add missing kfree(hbus) in hv_pci_probe()'s error handling path")
  e658a4fea8ef ("PCI: hv: Remove unnecessary type casting from kzalloc")

No period at end of subject.

On Sun, Apr 26, 2020 at 09:24:30PM +0800, Wei Hu wrote:
> In the case of kdump, the PCI device was not cleanly shut down
> before the kdump kernel starts. This causes the initial
> attempt of entering D0 state in the kdump kernel to fail with
> invalid device state 0xC0000184 returned from Hyper-V host.
> When this happens, explicitly call PCI bus exit and retry to
> enter the D0 state.
> 
> Also fix the PCI probe failure path to release the PCI device
> resource properly.

This sounds like two separate fixes that should be in separate
patches?

> Signed-off-by: Wei Hu <weh@microsoft.com>
> ---
>  drivers/pci/controller/pci-hyperv.c | 34 ++++++++++++++++++++++++++++-
>  1 file changed, 33 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
> index e15022ff63e3..eb4781fa058d 100644
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -2736,6 +2736,10 @@ static void hv_free_config_window(struct hv_pcibus_device *hbus)
>  	vmbus_free_mmio(hbus->mem_config->start, PCI_CONFIG_MMIO_LENGTH);
>  }
>  
> +#define STATUS_INVALID_DEVICE_STATE		0xC0000184
> +
> +static int hv_pci_bus_exit(struct hv_device *hdev, bool hibernating);
> +
>  /**
>   * hv_pci_enter_d0() - Bring the "bus" into the D0 power state
>   * @hdev:	VMBus's tracking struct for this root PCI bus
> @@ -2748,8 +2752,10 @@ static int hv_pci_enter_d0(struct hv_device *hdev)
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
> @@ -2780,6 +2786,30 @@ static int hv_pci_enter_d0(struct hv_device *hdev)
>  		dev_err(&hdev->device,
>  			"PCI Pass-through VSP failed D0 Entry with status %x\n",
>  			comp_pkt.completion_status);
> +
> +		/*
> +		 * In certain case (Kdump) the pci device of interest was
> +		 * not cleanly shut down and resource is still held on host
> +		 * side, the host could return STATUS_INVALID_DEVICE_STATE.
> +		 * We need to explicitly request host to release the resource
> +		 * and try to enter D0 again.
> +		 */
> +		if (comp_pkt.completion_status == STATUS_INVALID_DEVICE_STATE &&
> +		    retry) {
> +			ret = hv_pci_bus_exit(hdev, true);
> +
> +			retry = false;
> +
> +			if (ret == 0) {
> +				kfree(pkt);
> +				goto enter_d0_retry;
> +			} else {
> +				dev_err(&hdev->device,
> +					"PCI bus D0 exit failed with ret %d\n",
> +					ret);
> +			}
> +		}
> +
>  		ret = -EPROTO;
>  		goto exit;
>  	}
> @@ -3136,7 +3166,7 @@ static int hv_pci_probe(struct hv_device *hdev,
>  
>  	ret = hv_pci_allocate_bridge_windows(hbus);
>  	if (ret)
> -		goto free_irq_domain;
> +		goto exit_d0;
>  
>  	ret = hv_send_resources_allocated(hdev);
>  	if (ret)
> @@ -3154,6 +3184,8 @@ static int hv_pci_probe(struct hv_device *hdev,
>  
>  free_windows:
>  	hv_pci_free_bridge_windows(hbus);
> +exit_d0:
> +	(void) hv_pci_bus_exit(hdev, true);
>  free_irq_domain:
>  	irq_domain_remove(hbus->irq_domain);
>  free_fwnode:
> -- 
> 2.20.1
> 
