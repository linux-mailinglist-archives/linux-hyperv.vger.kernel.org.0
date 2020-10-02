Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88313281152
	for <lists+linux-hyperv@lfdr.de>; Fri,  2 Oct 2020 13:38:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387765AbgJBLiX (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 2 Oct 2020 07:38:23 -0400
Received: from foss.arm.com ([217.140.110.172]:33194 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725964AbgJBLiX (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 2 Oct 2020 07:38:23 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 050C31063;
        Fri,  2 Oct 2020 04:38:22 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 68DB53F73B;
        Fri,  2 Oct 2020 04:38:20 -0700 (PDT)
Date:   Fri, 2 Oct 2020 12:38:15 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Dexuan Cui <decui@microsoft.com>
Cc:     maz@kernel.org, bhelgaas@google.com, linux-hyperv@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        mikelley@microsoft.com, wei.liu@kernel.org, kys@microsoft.com,
        haiyangz@microsoft.com, sthemmin@microsoft.com, jakeo@microsoft.com
Subject: Re: [PATCH v3] PCI: hv: Fix hibernation in case interrupts are not
 re-created
Message-ID: <20201002113814.GA23526@e121166-lin.cambridge.arm.com>
References: <20201002085158.9168-1-decui@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201002085158.9168-1-decui@microsoft.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, Oct 02, 2020 at 01:51:58AM -0700, Dexuan Cui wrote:
> pci_restore_msi_state() directly writes the MSI/MSI-X related registers
> via MMIO. On a physical machine, this works perfectly; for a Linux VM
> running on a hypervisor, which typically enables IOMMU interrupt remapping,
> the hypervisor usually should trap and emulate the MMIO accesses in order
> to re-create the necessary interrupt remapping table entries in the IOMMU,
> otherwise the interrupts can not work in the VM after hibernation.
> 
> Hyper-V is different from other hypervisors in that it does not trap and
> emulate the MMIO accesses, and instead it uses a para-virtualized method,
> which requires the VM to call hv_compose_msi_msg() to notify the hypervisor
> of the info that would be passed to the hypervisor in the case of the
> trap-and-emulate method. This is not an issue to a lot of PCI device
> drivers, which destroy and re-create the interrupts across hibernation, so
> hv_compose_msi_msg() is called automatically. However, some PCI device
> drivers (e.g. the in-tree GPU driver nouveau and the out-of-tree Nvidia
> proprietary GPU driver) do not destroy and re-create MSI/MSI-X interrupts
> across hibernation, so hv_pci_resume() has to call hv_compose_msi_msg(),
> otherwise the PCI device drivers can no longer receive interrupts after
> the VM resumes from hibernation.
> 
> Hyper-V is also different in that chip->irq_unmask() may fail in a
> Linux VM running on Hyper-V (on a physical machine, chip->irq_unmask()
> can not fail because unmasking an MSI/MSI-X register just means an MMIO
> write): during hibernation, when a CPU is offlined, the kernel tries
> to move the interrupt to the remaining CPUs that haven't been offlined
> yet. In this case, hv_irq_unmask() -> hv_do_hypercall() always fails
> because the vmbus channel has been closed: here the early "return" in
> hv_irq_unmask() means the pci_msi_unmask_irq() is not called, i.e. the
> desc->masked remains "true", so later after hibernation, the MSI interrupt
> always remains masked, which is incorrect. Refer to cpu_disable_common()
> -> fixup_irqs() -> irq_migrate_all_off_this_cpu() -> migrate_one_irq():
> 
> static bool migrate_one_irq(struct irq_desc *desc)
> {
> ...
>         if (maskchip && chip->irq_mask)
>                 chip->irq_mask(d);
> ...
>         err = irq_do_set_affinity(d, affinity, false);
> ...
>         if (maskchip && chip->irq_unmask)
>                 chip->irq_unmask(d);
> 
> Fix the issue by calling pci_msi_unmask_irq() unconditionally in
> hv_irq_unmask(). Also suppress the error message for hibernation because
> the hypercall failure during hibernation does not matter (at this time
> all the devices have been frozen). Note: the correct affinity info is
> still updated into the irqdata data structure in migrate_one_irq() ->
> irq_do_set_affinity() -> hv_set_affinity(), so later when the VM
> resumes, hv_pci_restore_msi_state() is able to correctly restore
> the interrupt with the correct affinity.
> 
> Fixes: ac82fc832708 ("PCI: hv: Add hibernation support")
> Reviewed-by: Jake Oshins <jakeo@microsoft.com>
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> ---
> 
> Changes in v2:
>     Fixed a typo in the comment in hv_irq_unmask. Thanks to Michael!
>     Added Jake's Reviewed-by.
> 
> Changes in v3:
>     Improved the commit log.
>     Improved the comments.
>     Improved the change in hv_irq_unmask(): removed the early "return"
>         and call pci_msi_unmask_irq() unconditionally.
> 
>  drivers/pci/controller/pci-hyperv.c | 50 +++++++++++++++++++++++++++--
>  1 file changed, 47 insertions(+), 3 deletions(-)

Applied to pci/hv, thanks !

Lorenzo

> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
> index fc4c3a15e570..a9df492fbffa 100644
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -1276,11 +1276,25 @@ static void hv_irq_unmask(struct irq_data *data)
>  exit_unlock:
>  	spin_unlock_irqrestore(&hbus->retarget_msi_interrupt_lock, flags);
>  
> -	if (res) {
> +	/*
> +	 * During hibernation, when a CPU is offlined, the kernel tries
> +	 * to move the interrupt to the remaining CPUs that haven't
> +	 * been offlined yet. In this case, the below hv_do_hypercall()
> +	 * always fails since the vmbus channel has been closed:
> +	 * refer to cpu_disable_common() -> fixup_irqs() ->
> +	 * irq_migrate_all_off_this_cpu() -> migrate_one_irq().
> +	 *
> +	 * Suppress the error message for hibernation because the failure
> +	 * during hibernation does not matter (at this time all the devices
> +	 * have been frozen). Note: the correct affinity info is still updated
> +	 * into the irqdata data structure in migrate_one_irq() ->
> +	 * irq_do_set_affinity() -> hv_set_affinity(), so later when the VM
> +	 * resumes, hv_pci_restore_msi_state() is able to correctly restore
> +	 * the interrupt with the correct affinity.
> +	 */
> +	if (res && hbus->state != hv_pcibus_removing)
>  		dev_err(&hbus->hdev->device,
>  			"%s() failed: %#llx", __func__, res);
> -		return;
> -	}
>  
>  	pci_msi_unmask_irq(data);
>  }
> @@ -3372,6 +3386,34 @@ static int hv_pci_suspend(struct hv_device *hdev)
>  	return 0;
>  }
>  
> +static int hv_pci_restore_msi_msg(struct pci_dev *pdev, void *arg)
> +{
> +	struct msi_desc *entry;
> +	struct irq_data *irq_data;
> +
> +	for_each_pci_msi_entry(entry, pdev) {
> +		irq_data = irq_get_irq_data(entry->irq);
> +		if (WARN_ON_ONCE(!irq_data))
> +			return -EINVAL;
> +
> +		hv_compose_msi_msg(irq_data, &entry->msg);
> +	}
> +
> +	return 0;
> +}
> +
> +/*
> + * Upon resume, pci_restore_msi_state() -> ... ->  __pci_write_msi_msg()
> + * directly writes the MSI/MSI-X registers via MMIO, but since Hyper-V
> + * doesn't trap and emulate the MMIO accesses, here hv_compose_msi_msg()
> + * must be used to ask Hyper-V to re-create the IOMMU Interrupt Remapping
> + * Table entries.
> + */
> +static void hv_pci_restore_msi_state(struct hv_pcibus_device *hbus)
> +{
> +	pci_walk_bus(hbus->pci_bus, hv_pci_restore_msi_msg, NULL);
> +}
> +
>  static int hv_pci_resume(struct hv_device *hdev)
>  {
>  	struct hv_pcibus_device *hbus = hv_get_drvdata(hdev);
> @@ -3405,6 +3447,8 @@ static int hv_pci_resume(struct hv_device *hdev)
>  
>  	prepopulate_bars(hbus);
>  
> +	hv_pci_restore_msi_state(hbus);
> +
>  	hbus->state = hv_pcibus_installed;
>  	return 0;
>  out:
> -- 
> 2.19.1
> 
