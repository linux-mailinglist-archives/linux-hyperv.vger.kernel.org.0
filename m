Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0F6230F418
	for <lists+linux-hyperv@lfdr.de>; Thu,  4 Feb 2021 14:45:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236370AbhBDNov (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 4 Feb 2021 08:44:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236408AbhBDNnC (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 4 Feb 2021 08:43:02 -0500
X-Greylist: delayed 487 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 04 Feb 2021 05:42:20 PST
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFE7EC0613ED
        for <linux-hyperv@vger.kernel.org>; Thu,  4 Feb 2021 05:42:20 -0800 (PST)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id CA26F445; Thu,  4 Feb 2021 14:33:18 +0100 (CET)
Date:   Thu, 4 Feb 2021 14:33:17 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Wei Liu <wei.liu@kernel.org>
Cc:     Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
        virtualization@lists.linux-foundation.org,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Nuno Das Neves <nunodasneves@linux.microsoft.com>,
        pasha.tatashin@soleen.com, "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Will Deacon <will@kernel.org>,
        "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>
Subject: Re: [PATCH v6 16/16] iommu/hyperv: setup an IO-APIC IRQ remapping
 domain for root partition
Message-ID: <20210204133317.GB27686@8bytes.org>
References: <20210203150435.27941-1-wei.liu@kernel.org>
 <20210203150435.27941-17-wei.liu@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210203150435.27941-17-wei.liu@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Feb 03, 2021 at 03:04:35PM +0000, Wei Liu wrote:
> Just like MSI/MSI-X, IO-APIC interrupts are remapped by Microsoft
> Hypervisor when Linux runs as the root partition. Implement an IRQ
> domain to handle mapping and unmapping of IO-APIC interrupts.
> 
> Signed-off-by: Wei Liu <wei.liu@kernel.org>

Acked-by: Joerg Roedel <joro@8bytes.org>

> ---
> v6:
> 1. Simplify code due to changes in a previous patch.
> ---
>  arch/x86/hyperv/irqdomain.c     |  25 +++++
>  arch/x86/include/asm/mshyperv.h |   4 +
>  drivers/iommu/hyperv-iommu.c    | 177 +++++++++++++++++++++++++++++++-
>  3 files changed, 203 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/hyperv/irqdomain.c b/arch/x86/hyperv/irqdomain.c
> index 117f17e8c88a..0cabc9aece38 100644
> --- a/arch/x86/hyperv/irqdomain.c
> +++ b/arch/x86/hyperv/irqdomain.c
> @@ -360,3 +360,28 @@ struct irq_domain * __init hv_create_pci_msi_domain(void)
>  }
>  
>  #endif /* CONFIG_PCI_MSI */
> +
> +int hv_unmap_ioapic_interrupt(int ioapic_id, struct hv_interrupt_entry *entry)
> +{
> +	union hv_device_id device_id;
> +
> +	device_id.as_uint64 = 0;
> +	device_id.device_type = HV_DEVICE_TYPE_IOAPIC;
> +	device_id.ioapic.ioapic_id = (u8)ioapic_id;
> +
> +	return hv_unmap_interrupt(device_id.as_uint64, entry);
> +}
> +EXPORT_SYMBOL_GPL(hv_unmap_ioapic_interrupt);
> +
> +int hv_map_ioapic_interrupt(int ioapic_id, bool level, int cpu, int vector,
> +		struct hv_interrupt_entry *entry)
> +{
> +	union hv_device_id device_id;
> +
> +	device_id.as_uint64 = 0;
> +	device_id.device_type = HV_DEVICE_TYPE_IOAPIC;
> +	device_id.ioapic.ioapic_id = (u8)ioapic_id;
> +
> +	return hv_map_interrupt(device_id, level, cpu, vector, entry);
> +}
> +EXPORT_SYMBOL_GPL(hv_map_ioapic_interrupt);
> diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
> index ccc849e25d5e..345d7c6f8c37 100644
> --- a/arch/x86/include/asm/mshyperv.h
> +++ b/arch/x86/include/asm/mshyperv.h
> @@ -263,6 +263,10 @@ static inline void hv_set_msi_entry_from_desc(union hv_msi_entry *msi_entry,
>  
>  struct irq_domain *hv_create_pci_msi_domain(void);
>  
> +int hv_map_ioapic_interrupt(int ioapic_id, bool level, int vcpu, int vector,
> +		struct hv_interrupt_entry *entry);
> +int hv_unmap_ioapic_interrupt(int ioapic_id, struct hv_interrupt_entry *entry);
> +
>  #else /* CONFIG_HYPERV */
>  static inline void hyperv_init(void) {}
>  static inline void hyperv_setup_mmu_ops(void) {}
> diff --git a/drivers/iommu/hyperv-iommu.c b/drivers/iommu/hyperv-iommu.c
> index 1d21a0b5f724..e285a220c913 100644
> --- a/drivers/iommu/hyperv-iommu.c
> +++ b/drivers/iommu/hyperv-iommu.c
> @@ -20,6 +20,7 @@
>  #include <asm/io_apic.h>
>  #include <asm/irq_remapping.h>
>  #include <asm/hypervisor.h>
> +#include <asm/mshyperv.h>
>  
>  #include "irq_remapping.h"
>  
> @@ -115,30 +116,43 @@ static const struct irq_domain_ops hyperv_ir_domain_ops = {
>  	.free = hyperv_irq_remapping_free,
>  };
>  
> +static const struct irq_domain_ops hyperv_root_ir_domain_ops;
>  static int __init hyperv_prepare_irq_remapping(void)
>  {
>  	struct fwnode_handle *fn;
>  	int i;
> +	const char *name;
> +	const struct irq_domain_ops *ops;
>  
>  	if (!hypervisor_is_type(X86_HYPER_MS_HYPERV) ||
>  	    x86_init.hyper.msi_ext_dest_id() ||
>  	    !x2apic_supported())
>  		return -ENODEV;
>  
> -	fn = irq_domain_alloc_named_id_fwnode("HYPERV-IR", 0);
> +	if (hv_root_partition) {
> +		name = "HYPERV-ROOT-IR";
> +		ops = &hyperv_root_ir_domain_ops;
> +	} else {
> +		name = "HYPERV-IR";
> +		ops = &hyperv_ir_domain_ops;
> +	}
> +
> +	fn = irq_domain_alloc_named_id_fwnode(name, 0);
>  	if (!fn)
>  		return -ENOMEM;
>  
>  	ioapic_ir_domain =
>  		irq_domain_create_hierarchy(arch_get_ir_parent_domain(),
> -				0, IOAPIC_REMAPPING_ENTRY, fn,
> -				&hyperv_ir_domain_ops, NULL);
> +				0, IOAPIC_REMAPPING_ENTRY, fn, ops, NULL);
>  
>  	if (!ioapic_ir_domain) {
>  		irq_domain_free_fwnode(fn);
>  		return -ENOMEM;
>  	}
>  
> +	if (hv_root_partition)
> +		return 0; /* The rest is only relevant to guests */
> +
>  	/*
>  	 * Hyper-V doesn't provide irq remapping function for
>  	 * IO-APIC and so IO-APIC only accepts 8-bit APIC ID.
> @@ -166,4 +180,161 @@ struct irq_remap_ops hyperv_irq_remap_ops = {
>  	.enable			= hyperv_enable_irq_remapping,
>  };
>  
> +/* IRQ remapping domain when Linux runs as the root partition */
> +struct hyperv_root_ir_data {
> +	u8 ioapic_id;
> +	bool is_level;
> +	struct hv_interrupt_entry entry;
> +};
> +
> +static void
> +hyperv_root_ir_compose_msi_msg(struct irq_data *irq_data, struct msi_msg *msg)
> +{
> +	u64 status;
> +	u32 vector;
> +	struct irq_cfg *cfg;
> +	int ioapic_id;
> +	struct cpumask *affinity;
> +	int cpu;
> +	struct hv_interrupt_entry entry;
> +	struct hyperv_root_ir_data *data = irq_data->chip_data;
> +	struct IO_APIC_route_entry e;
> +
> +	cfg = irqd_cfg(irq_data);
> +	affinity = irq_data_get_effective_affinity_mask(irq_data);
> +	cpu = cpumask_first_and(affinity, cpu_online_mask);
> +
> +	vector = cfg->vector;
> +	ioapic_id = data->ioapic_id;
> +
> +	if (data->entry.source == HV_DEVICE_TYPE_IOAPIC
> +	    && data->entry.ioapic_rte.as_uint64) {
> +		entry = data->entry;
> +
> +		status = hv_unmap_ioapic_interrupt(ioapic_id, &entry);
> +
> +		if (status != HV_STATUS_SUCCESS)
> +			pr_debug("%s: unexpected unmap status %lld\n", __func__, status);
> +
> +		data->entry.ioapic_rte.as_uint64 = 0;
> +		data->entry.source = 0; /* Invalid source */
> +	}
> +
> +
> +	status = hv_map_ioapic_interrupt(ioapic_id, data->is_level, cpu,
> +					vector, &entry);
> +
> +	if (status != HV_STATUS_SUCCESS) {
> +		pr_err("%s: map hypercall failed, status %lld\n", __func__, status);
> +		return;
> +	}
> +
> +	data->entry = entry;
> +
> +	/* Turn it into an IO_APIC_route_entry, and generate MSI MSG. */
> +	e.w1 = entry.ioapic_rte.low_uint32;
> +	e.w2 = entry.ioapic_rte.high_uint32;
> +
> +	memset(msg, 0, sizeof(*msg));
> +	msg->arch_data.vector = e.vector;
> +	msg->arch_data.delivery_mode = e.delivery_mode;
> +	msg->arch_addr_lo.dest_mode_logical = e.dest_mode_logical;
> +	msg->arch_addr_lo.dmar_format = e.ir_format;
> +	msg->arch_addr_lo.dmar_index_0_14 = e.ir_index_0_14;
> +}
> +
> +static int hyperv_root_ir_set_affinity(struct irq_data *data,
> +		const struct cpumask *mask, bool force)
> +{
> +	struct irq_data *parent = data->parent_data;
> +	struct irq_cfg *cfg = irqd_cfg(data);
> +	int ret;
> +
> +	ret = parent->chip->irq_set_affinity(parent, mask, force);
> +	if (ret < 0 || ret == IRQ_SET_MASK_OK_DONE)
> +		return ret;
> +
> +	send_cleanup_vector(cfg);
> +
> +	return 0;
> +}
> +
> +static struct irq_chip hyperv_root_ir_chip = {
> +	.name			= "HYPERV-ROOT-IR",
> +	.irq_ack		= apic_ack_irq,
> +	.irq_set_affinity	= hyperv_root_ir_set_affinity,
> +	.irq_compose_msi_msg	= hyperv_root_ir_compose_msi_msg,
> +};
> +
> +static int hyperv_root_irq_remapping_alloc(struct irq_domain *domain,
> +				     unsigned int virq, unsigned int nr_irqs,
> +				     void *arg)
> +{
> +	struct irq_alloc_info *info = arg;
> +	struct irq_data *irq_data;
> +	struct hyperv_root_ir_data *data;
> +	int ret = 0;
> +
> +	if (!info || info->type != X86_IRQ_ALLOC_TYPE_IOAPIC || nr_irqs > 1)
> +		return -EINVAL;
> +
> +	ret = irq_domain_alloc_irqs_parent(domain, virq, nr_irqs, arg);
> +	if (ret < 0)
> +		return ret;
> +
> +	data = kzalloc(sizeof(*data), GFP_KERNEL);
> +	if (!data) {
> +		irq_domain_free_irqs_common(domain, virq, nr_irqs);
> +		return -ENOMEM;
> +	}
> +
> +	irq_data = irq_domain_get_irq_data(domain, virq);
> +	if (!irq_data) {
> +		kfree(data);
> +		irq_domain_free_irqs_common(domain, virq, nr_irqs);
> +		return -EINVAL;
> +	}
> +
> +	data->ioapic_id = info->devid;
> +	data->is_level = info->ioapic.is_level;
> +
> +	irq_data->chip = &hyperv_root_ir_chip;
> +	irq_data->chip_data = data;
> +
> +	return 0;
> +}
> +
> +static void hyperv_root_irq_remapping_free(struct irq_domain *domain,
> +				 unsigned int virq, unsigned int nr_irqs)
> +{
> +	struct irq_data *irq_data;
> +	struct hyperv_root_ir_data *data;
> +	struct hv_interrupt_entry *e;
> +	int i;
> +
> +	for (i = 0; i < nr_irqs; i++) {
> +		irq_data = irq_domain_get_irq_data(domain, virq + i);
> +
> +		if (irq_data && irq_data->chip_data) {
> +			data = irq_data->chip_data;
> +			e = &data->entry;
> +
> +			if (e->source == HV_DEVICE_TYPE_IOAPIC
> +			      && e->ioapic_rte.as_uint64)
> +				hv_unmap_ioapic_interrupt(data->ioapic_id,
> +							&data->entry);
> +
> +			kfree(data);
> +		}
> +	}
> +
> +	irq_domain_free_irqs_common(domain, virq, nr_irqs);
> +}
> +
> +static const struct irq_domain_ops hyperv_root_ir_domain_ops = {
> +	.select = hyperv_irq_remapping_select,
> +	.alloc = hyperv_root_irq_remapping_alloc,
> +	.free = hyperv_root_irq_remapping_free,
> +};
> +
>  #endif
> -- 
> 2.20.1
