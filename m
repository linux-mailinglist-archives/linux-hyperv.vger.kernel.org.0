Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F2918390E
	for <lists+linux-hyperv@lfdr.de>; Tue,  6 Aug 2019 20:55:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726431AbfHFSzU (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 6 Aug 2019 14:55:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:44858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725906AbfHFSzU (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 6 Aug 2019 14:55:20 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7FD0620C01;
        Tue,  6 Aug 2019 18:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565117718;
        bh=Ustmi3DWOC84tR+WYloqJ/uy/NSHo3QjVpfDl9Z5/dw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PYXW3iaLX7bl0WxqXKfySdGMJlrCLlFEnaO/X7FZPOF1rZ1IjfT0WepvP3hRYIqzU
         H+Uiz+TeaEu/O0ortbiAeVps1ZPpbazBEAMJMuSWn1v1qRnWjoCG4QC0oAesVveFP6
         QtiA4R6AV4IDLq3ZMz/+BPW5vNEl6+JPCQukaqtg=
Date:   Tue, 6 Aug 2019 13:55:15 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Haiyang Zhang <haiyangz@microsoft.com>
Cc:     "sashal@kernel.org" <sashal@kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "olaf@aepfle.de" <olaf@aepfle.de>, vkuznets <vkuznets@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PCI: hv: Detect and fix Hyper-V PCI domain number
 collision
Message-ID: <20190806185515.GR151852@google.com>
References: <1564771954-9181-1-git-send-email-haiyangz@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1564771954-9181-1-git-send-email-haiyangz@microsoft.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, Aug 02, 2019 at 06:52:56PM +0000, Haiyang Zhang wrote:
> Due to Azure host agent settings, the device instance ID's bytes 8 and 9
> are no longer unique. This causes some of the PCI devices not showing up
> in VMs with multiple passthrough devices, such as GPUs. So, as recommended
> by Azure host team, we now use the bytes 4 and 5 which usually provide
> unique numbers.

What does "Azure host agent settings" mean?  Would it be useful to say
something more specific, so users could ready this and say "oh, I'm
using the Azure host agent settings mentioned here, so I need this
patch"?  Is this related to a specific Azure host agent commit or
release?

"This causes some of the PCI devices ..." is not a sentence.  I think
I understand what you're saying -- "This sometimes causes device
passthrough to VMs to fail." Is there something about GPUs that makes
them more susceptible to this problem?

I think there are really two changes in this patch:

  1) Start with a domain number from bytes 4-5 instead of bytes 8-9.

  2) If the domain number is not unique, allocate another one using
  the bitmap.

It sounds like part 2) by itself would be enough to solve the problem,
and including part 1) just reduces the likelihood of having to
allocate another domain number.

> In the rare cases of collision, we will detect and find another number
> that is not in use.
> Thanks to Michael Kelley <mikelley@microsoft.com> for proposing this idea.

This looks like two paragraphs and should have a blank line between
them.

> Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
> ---
>  drivers/pci/controller/pci-hyperv.c | 91 +++++++++++++++++++++++++++++++------
>  1 file changed, 78 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
> index 82acd61..6b9cc6e60a 100644
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -37,6 +37,8 @@
>   * the PCI back-end driver in Hyper-V.
>   */
>  
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/pci.h>
> @@ -2507,6 +2509,47 @@ static void put_hvpcibus(struct hv_pcibus_device *hbus)
>  		complete(&hbus->remove_event);
>  }
>  
> +#define HVPCI_DOM_MAP_SIZE (64 * 1024)
> +static DECLARE_BITMAP(hvpci_dom_map, HVPCI_DOM_MAP_SIZE);
> +
> +/* PCI domain number 0 is used by emulated devices on Gen1 VMs, so define 0
> + * as invalid for passthrough PCI devices of this driver.
> + */

Please use the usual multi-line comment style:

  /*
   * PCI domain number ...
   */

> +#define HVPCI_DOM_INVALID 0
> +
> +/**
> + * hv_get_dom_num() - Get a valid PCI domain number
> + * Check if the PCI domain number is in use, and return another number if
> + * it is in use.
> + *
> + * @dom: Requested domain number
> + *
> + * return: domain number on success, HVPCI_DOM_INVALID on failure
> + */
> +static u16 hv_get_dom_num(u16 dom)
> +{
> +	unsigned int i;
> +
> +	if (test_and_set_bit(dom, hvpci_dom_map) == 0)
> +		return dom;
> +
> +	for_each_clear_bit(i, hvpci_dom_map, HVPCI_DOM_MAP_SIZE) {
> +		if (test_and_set_bit(i, hvpci_dom_map) == 0)
> +			return i;
> +	}
> +
> +	return HVPCI_DOM_INVALID;
> +}
> +
> +/**
> + * hv_put_dom_num() - Mark the PCI domain number as free
> + * @dom: Domain number to be freed
> + */
> +static void hv_put_dom_num(u16 dom)
> +{
> +	clear_bit(dom, hvpci_dom_map);
> +}
> +
>  /**
>   * hv_pci_probe() - New VMBus channel probe, for a root PCI bus
>   * @hdev:	VMBus's tracking struct for this root PCI bus
> @@ -2518,6 +2561,7 @@ static int hv_pci_probe(struct hv_device *hdev,
>  			const struct hv_vmbus_device_id *dev_id)
>  {
>  	struct hv_pcibus_device *hbus;
> +	u16 dom_req, dom;
>  	int ret;
>  
>  	/*
> @@ -2532,19 +2576,32 @@ static int hv_pci_probe(struct hv_device *hdev,
>  	hbus->state = hv_pcibus_init;
>  
>  	/*
> -	 * The PCI bus "domain" is what is called "segment" in ACPI and
> -	 * other specs.  Pull it from the instance ID, to get something
> -	 * unique.  Bytes 8 and 9 are what is used in Windows guests, so
> -	 * do the same thing for consistency.  Note that, since this code
> -	 * only runs in a Hyper-V VM, Hyper-V can (and does) guarantee
> -	 * that (1) the only domain in use for something that looks like
> -	 * a physical PCI bus (which is actually emulated by the
> -	 * hypervisor) is domain 0 and (2) there will be no overlap
> -	 * between domains derived from these instance IDs in the same
> -	 * VM.
> +	 * The PCI bus "domain" is what is called "segment" in ACPI and other
> +	 * specs. Pull it from the instance ID, to get something usually
> +	 * unique. In rare cases of collision, we will find out another number
> +	 * not in use.
> +	 * Note that, since this code only runs in a Hyper-V VM, Hyper-V
> +	 * together with this guest driver can guarantee that (1) The only
> +	 * domain used by Gen1 VMs for something that looks like a physical
> +	 * PCI bus (which is actually emulated by the hypervisor) is domain 0.
> +	 * (2) There will be no overlap between domains (after fixing possible
> +	 * collisions) in the same VM.

Please use blank lines between paragraphs.

>  	 */
> -	hbus->sysdata.domain = hdev->dev_instance.b[9] |
> -			       hdev->dev_instance.b[8] << 8;
> +	dom_req = hdev->dev_instance.b[5] << 8 | hdev->dev_instance.b[4];
> +	dom = hv_get_dom_num(dom_req);
> +
> +	if (dom == HVPCI_DOM_INVALID) {
> +		pr_err("Unable to use dom# 0x%hx or other numbers",
> +		       dom_req);
> +		ret = -EINVAL;
> +		goto free_bus;
> +	}
> +
> +	if (dom != dom_req)
> +		pr_info("PCI dom# 0x%hx has collision, using 0x%hx",
> +			dom_req, dom);

Can these use "dev_err/info(&hdev->device, ...)" like the other
message in this function?  It's always nicer to have a specific device
reference when one is available.  Probably don't need the new pr_fmt()
definition if you do this.

> +
> +	hbus->sysdata.domain = dom;
>  
>  	hbus->hdev = hdev;
>  	refcount_set(&hbus->remove_lock, 1);
> @@ -2559,7 +2616,7 @@ static int hv_pci_probe(struct hv_device *hdev,
>  					   hbus->sysdata.domain);
>  	if (!hbus->wq) {
>  		ret = -ENOMEM;
> -		goto free_bus;
> +		goto free_dom;
>  	}
>  
>  	ret = vmbus_open(hdev->channel, pci_ring_size, pci_ring_size, NULL, 0,
> @@ -2636,6 +2693,8 @@ static int hv_pci_probe(struct hv_device *hdev,
>  	vmbus_close(hdev->channel);
>  destroy_wq:
>  	destroy_workqueue(hbus->wq);
> +free_dom:
> +	hv_put_dom_num(hbus->sysdata.domain);
>  free_bus:
>  	free_page((unsigned long)hbus);
>  	return ret;
> @@ -2717,6 +2776,9 @@ static int hv_pci_remove(struct hv_device *hdev)
>  	put_hvpcibus(hbus);
>  	wait_for_completion(&hbus->remove_event);
>  	destroy_workqueue(hbus->wq);
> +
> +	hv_put_dom_num(hbus->sysdata.domain);
> +
>  	free_page((unsigned long)hbus);
>  	return 0;
>  }
> @@ -2744,6 +2806,9 @@ static void __exit exit_hv_pci_drv(void)
>  
>  static int __init init_hv_pci_drv(void)
>  {
> +	/* Set the invalid domain number's bit, so it will not be used */
> +	set_bit(HVPCI_DOM_INVALID, hvpci_dom_map);
> +
>  	return vmbus_driver_register(&hv_pci_drv);
>  }
>  
> -- 
> 1.8.3.1
> 
