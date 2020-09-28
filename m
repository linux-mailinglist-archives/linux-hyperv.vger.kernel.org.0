Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 881F127AC20
	for <lists+linux-hyperv@lfdr.de>; Mon, 28 Sep 2020 12:43:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726681AbgI1KnR (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 28 Sep 2020 06:43:17 -0400
Received: from foss.arm.com ([217.140.110.172]:49148 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726667AbgI1KnR (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 28 Sep 2020 06:43:17 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7427C1063;
        Mon, 28 Sep 2020 03:43:16 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E33693F6CF;
        Mon, 28 Sep 2020 03:43:14 -0700 (PDT)
Date:   Mon, 28 Sep 2020 11:43:09 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Dexuan Cui <decui@microsoft.com>
Cc:     wei.liu@kernel.org, kys@microsoft.com, haiyangz@microsoft.com,
        sthemmin@microsoft.com, bhelgaas@google.com,
        linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, mikelley@microsoft.com,
        jakeo@microsoft.com, maz@kernel.org
Subject: Re: [PATCH v2] PCI: hv: Fix hibernation in case interrupts are not
 re-created
Message-ID: <20200928104309.GA12565@e121166-lin.cambridge.arm.com>
References: <20200908231759.13336-1-decui@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200908231759.13336-1-decui@microsoft.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

[+MarcZ - this patch needs IRQ maintainers vetting]

On Tue, Sep 08, 2020 at 04:17:59PM -0700, Dexuan Cui wrote:
> Hyper-V doesn't trap and emulate the accesses to the MSI/MSI-X registers,
> and we must use hv_compose_msi_msg() to ask Hyper-V to create the IOMMU
> Interrupt Remapping Table Entries. This is not an issue for a lot of
> PCI device drivers (e.g. NVMe driver, Mellanox NIC drivers), which
> destroy and re-create the interrupts across hibernation, so
> hv_compose_msi_msg() is called automatically. However, some other PCI
> device drivers (e.g. the Nvidia driver) may not destroy and re-create
> the interrupts across hibernation, so hv_pci_resume() has to call
> hv_compose_msi_msg(), otherwise the PCI device drivers can no longer
> receive MSI/MSI-X interrupts after hibernation.

This looks like drivers bugs and I don't think the HV controller
driver is where you should fix them. Regardless, this commit log
does not provide the information that it should.

> Fixes: ac82fc832708 ("PCI: hv: Add hibernation support")
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> Reviewed-by: Jake Oshins <jakeo@microsoft.com>
> 
> ---
> 
> Changes in v2:
>     Fixed a typo in the comment in hv_irq_unmask. Thanks to Michael!
>     Added Jake's Reviewed-by.
> 
>  drivers/pci/controller/pci-hyperv.c | 44 +++++++++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
> 
> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
> index fc4c3a15e570..dd21afb5d62b 100644
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -1211,6 +1211,21 @@ static void hv_irq_unmask(struct irq_data *data)
>  	pbus = pdev->bus;
>  	hbus = container_of(pbus->sysdata, struct hv_pcibus_device, sysdata);
>  
> +	if (hbus->state == hv_pcibus_removing) {
> +		/*
> +		 * During hibernation, when a CPU is offlined, the kernel tries
> +		 * to move the interrupt to the remaining CPUs that haven't
> +		 * been offlined yet. In this case, the below hv_do_hypercall()
> +		 * always fails since the vmbus channel has been closed, so we
> +		 * should not call the hypercall, but we still need
> +		 * pci_msi_unmask_irq() to reset the mask bit in desc->masked:
> +		 * see cpu_disable_common() -> fixup_irqs() ->
> +		 * irq_migrate_all_off_this_cpu() -> migrate_one_irq().
> +		 */
> +		pci_msi_unmask_irq(data);

This is not appropriate - it looks like a plaster to paper over an
issue with hyper-V hibernation code sequence. Fix that issue instead
of papering over it here.

Thanks,
Lorenzo

> +		return;
> +	}
> +
>  	spin_lock_irqsave(&hbus->retarget_msi_interrupt_lock, flags);
>  
>  	params = &hbus->retarget_msi_interrupt_params;
> @@ -3372,6 +3387,33 @@ static int hv_pci_suspend(struct hv_device *hdev)
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
> + * re-writes the MSI/MSI-X registers, but since Hyper-V doesn't trap and
> + * emulate the accesses, we have to call hv_compose_msi_msg() to ask
> + * Hyper-V to re-create the IOMMU Interrupt Remapping Table Entries.
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
