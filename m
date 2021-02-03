Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93F0430DA29
	for <lists+linux-hyperv@lfdr.de>; Wed,  3 Feb 2021 13:51:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbhBCMtv (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 3 Feb 2021 07:49:51 -0500
Received: from mail-wm1-f46.google.com ([209.85.128.46]:38693 "EHLO
        mail-wm1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbhBCMrs (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 3 Feb 2021 07:47:48 -0500
Received: by mail-wm1-f46.google.com with SMTP id y187so5096590wmd.3;
        Wed, 03 Feb 2021 04:47:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IZflTpVi58KCkqF3w6IrG6LAD11tU7+eH6DvsYEmc00=;
        b=sf/1SSkySUI0mz4G7faMARzoqoQFKWQIeDduLtfv3k7wIvIV3B3RK9dXYXwEyve7wz
         CVDZbBQTneS36pHJpeEBRPNdd0ZK9NxcySnHCPcoLbasXIDCEzD33w+p5KRa7mk5kyQo
         NXRMEoF978cgBl4EMZ0oGXBt11hc3+10oKbGeIQvzVZAfWu4985bX3qFQjYqrMar7tlH
         ETcLW5VPtnkmU9opwQY0sQRPFKwh8PmWb8t2GcMe75MOHbBK6HGWFrRrRTT+n+8JABa7
         qH4Z6lSo6Pd4Ox/Jyro8Ua+54DgPzRQCtx6kPa5AGo7+wmd+iCQZJf35JoTeCjFdTA/x
         L+Fw==
X-Gm-Message-State: AOAM5321Qaiy68gmWfkwTaA4C2bCn017Y45RuS7/OA0q8OTf+LAuGw+r
        joWz3vY7VXVaPYDKUmt2Pl4=
X-Google-Smtp-Source: ABdhPJyeU3BhuMLmDKNujJgChleD1PVXDcffBTm5NGXAfwDtli6d5lxAPaCCG/yDEk87/4XnfDgBwQ==
X-Received: by 2002:a7b:cb58:: with SMTP id v24mr2696118wmj.182.1612356422842;
        Wed, 03 Feb 2021 04:47:02 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id n4sm3508645wrt.47.2021.02.03.04.47.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Feb 2021 04:47:02 -0800 (PST)
Date:   Wed, 3 Feb 2021 12:47:00 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     Wei Liu <wei.liu@kernel.org>,
        Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Nuno Das Neves <nunodasneves@linux.microsoft.com>,
        "pasha.tatashin@soleen.com" <pasha.tatashin@soleen.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>
Subject: Re: [PATCH v5 16/16] iommu/hyperv: setup an IO-APIC IRQ remapping
 domain for root partition
Message-ID: <20210203124700.ugx5vd526455u7lb@liuwe-devbox-debian-v2>
References: <20210120120058.29138-1-wei.liu@kernel.org>
 <20210120120058.29138-17-wei.liu@kernel.org>
 <MWHPR21MB15936ED25B56AF897B655B76D7BB9@MWHPR21MB1593.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MWHPR21MB15936ED25B56AF897B655B76D7BB9@MWHPR21MB1593.namprd21.prod.outlook.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Jan 27, 2021 at 05:47:08AM +0000, Michael Kelley wrote:
> From: Wei Liu <wei.liu@kernel.org> Sent: Wednesday, January 20, 2021 4:01 AM
> > 
> > Just like MSI/MSI-X, IO-APIC interrupts are remapped by Microsoft
> > Hypervisor when Linux runs as the root partition. Implement an IRQ
> > domain to handle mapping and unmapping of IO-APIC interrupts.
> > 
> > Signed-off-by: Wei Liu <wei.liu@kernel.org>
> > ---
> >  arch/x86/hyperv/irqdomain.c     |  54 ++++++++++
> >  arch/x86/include/asm/mshyperv.h |   4 +
> >  drivers/iommu/hyperv-iommu.c    | 179 +++++++++++++++++++++++++++++++-
> >  3 files changed, 233 insertions(+), 4 deletions(-)
> > 
> > diff --git a/arch/x86/hyperv/irqdomain.c b/arch/x86/hyperv/irqdomain.c
> > index 19637cd60231..8e2b4e478b70 100644
> > --- a/arch/x86/hyperv/irqdomain.c
> > +++ b/arch/x86/hyperv/irqdomain.c
> > @@ -330,3 +330,57 @@ struct irq_domain * __init hv_create_pci_msi_domain(void)
> >  }
> > 
> >  #endif /* CONFIG_PCI_MSI */
> > +
> > +int hv_unmap_ioapic_interrupt(int ioapic_id, struct hv_interrupt_entry *entry)
> > +{
> > +	union hv_device_id device_id;
> > +
> > +	device_id.as_uint64 = 0;
> > +	device_id.device_type = HV_DEVICE_TYPE_IOAPIC;
> > +	device_id.ioapic.ioapic_id = (u8)ioapic_id;
> > +
> > +	return hv_unmap_interrupt(device_id.as_uint64, entry) & HV_HYPERCALL_RESULT_MASK;
> 
> The masking is already done in hv_unmap_interrupt.

Fixed.

> 
> > +}
> > +EXPORT_SYMBOL_GPL(hv_unmap_ioapic_interrupt);
> > +
> > +int hv_map_ioapic_interrupt(int ioapic_id, bool level, int vcpu, int vector,
> > +		struct hv_interrupt_entry *entry)
> > +{
> > +	unsigned long flags;
> > +	struct hv_input_map_device_interrupt *input;
> > +	struct hv_output_map_device_interrupt *output;
> > +	union hv_device_id device_id;
> > +	struct hv_device_interrupt_descriptor *intr_desc;
> > +	u16 status;
> > +
> > +	device_id.as_uint64 = 0;
> > +	device_id.device_type = HV_DEVICE_TYPE_IOAPIC;
> > +	device_id.ioapic.ioapic_id = (u8)ioapic_id;
> > +
> > +	local_irq_save(flags);
> > +	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
> > +	output = *this_cpu_ptr(hyperv_pcpu_output_arg);
> > +	memset(input, 0, sizeof(*input));
> > +	intr_desc = &input->interrupt_descriptor;
> > +	input->partition_id = hv_current_partition_id;
> > +	input->device_id = device_id.as_uint64;
> > +	intr_desc->interrupt_type = HV_X64_INTERRUPT_TYPE_FIXED;
> > +	intr_desc->target.vector = vector;
> > +	intr_desc->vector_count = 1;
> > +
> > +	if (level)
> > +		intr_desc->trigger_mode = HV_INTERRUPT_TRIGGER_MODE_LEVEL;
> > +	else
> > +		intr_desc->trigger_mode = HV_INTERRUPT_TRIGGER_MODE_EDGE;
> > +
> > +	__set_bit(vcpu, (unsigned long *)&intr_desc->target.vp_mask);
> > +
> > +	status = hv_do_rep_hypercall(HVCALL_MAP_DEVICE_INTERRUPT, 0, 0, input, output) &
> > +			 HV_HYPERCALL_RESULT_MASK;
> > +	local_irq_restore(flags);
> > +
> > +	*entry = output->interrupt_entry;
> > +
> > +	return status;
> 
> As a cross-check, I was comparing this code against hv_map_msi_interrupt().  They are
> mostly parallel, though some of the assignments are done in a different order.  It's a nit,
> but making them as parallel as possible would be nice. :-)
> 

Indeed. I will see about factoring out a function.

> Same 64 vCPU comment applies here as well.
> 

This is changed to use vpset instead. Took me a bit of time to get it
working because document is a bit lacking.

> 
> > +}
> > +EXPORT_SYMBOL_GPL(hv_map_ioapic_interrupt);
> > diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
> > index ccc849e25d5e..345d7c6f8c37 100644
> > --- a/arch/x86/include/asm/mshyperv.h
> > +++ b/arch/x86/include/asm/mshyperv.h
> > @@ -263,6 +263,10 @@ static inline void hv_set_msi_entry_from_desc(union
> > hv_msi_entry *msi_entry,
> > 
> >  struct irq_domain *hv_create_pci_msi_domain(void);
> > 
> > +int hv_map_ioapic_interrupt(int ioapic_id, bool level, int vcpu, int vector,
> > +		struct hv_interrupt_entry *entry);
> > +int hv_unmap_ioapic_interrupt(int ioapic_id, struct hv_interrupt_entry *entry);
> > +
> >  #else /* CONFIG_HYPERV */
> >  static inline void hyperv_init(void) {}
> >  static inline void hyperv_setup_mmu_ops(void) {}
> > diff --git a/drivers/iommu/hyperv-iommu.c b/drivers/iommu/hyperv-iommu.c
> > index b7db6024e65c..6d35e4c303c6 100644
> > --- a/drivers/iommu/hyperv-iommu.c
> > +++ b/drivers/iommu/hyperv-iommu.c
> > @@ -116,30 +116,43 @@ static const struct irq_domain_ops hyperv_ir_domain_ops = {
> >  	.free = hyperv_irq_remapping_free,
> >  };
> > 
> > +static const struct irq_domain_ops hyperv_root_ir_domain_ops;
> >  static int __init hyperv_prepare_irq_remapping(void)
> >  {
> >  	struct fwnode_handle *fn;
> >  	int i;
> > +	const char *name;
> > +	const struct irq_domain_ops *ops;
> > 
> >  	if (!hypervisor_is_type(X86_HYPER_MS_HYPERV) ||
> >  	    x86_init.hyper.msi_ext_dest_id() ||
> > -	    !x2apic_supported() || hv_root_partition)
> > +	    !x2apic_supported())
> 
> Any reason that the check for hv_root_partition was added
> in patch #4  of this series, and then removed here?  Could
> patch #4 just be dropped?
> 

Before v5 (or v4?) IO-APIC was not handled via Hyper-V IOMMU. Now it is.

Patch 4 has become redundant with that change. I already dropped patch 4
in the v6 branch I have locally.

> >  		return -ENODEV;
> > 
> > -	fn = irq_domain_alloc_named_id_fwnode("HYPERV-IR", 0);
> > +	if (hv_root_partition) {
> > +		name = "HYPERV-ROOT-IR";
> > +		ops = &hyperv_root_ir_domain_ops;
> > +	} else {
> > +		name = "HYPERV-IR";
> > +		ops = &hyperv_ir_domain_ops;
> > +	}
> > +
[...]
> > +static void
> > +hyperv_root_ir_compose_msi_msg(struct irq_data *irq_data, struct msi_msg *msg)
> > +{
> > +	u16 status;
> > +	u32 vector;
> > +	struct irq_cfg *cfg;
> > +	int ioapic_id;
> > +	struct cpumask *affinity;
> > +	int cpu, vcpu;
> > +	struct hv_interrupt_entry entry;
> > +	struct hyperv_root_ir_data *data = irq_data->chip_data;
> > +	struct IO_APIC_route_entry e;
> > +
> > +	cfg = irqd_cfg(irq_data);
> > +	affinity = irq_data_get_effective_affinity_mask(irq_data);
> > +	cpu = cpumask_first_and(affinity, cpu_online_mask);
> > +	vcpu = hv_cpu_number_to_vp_number(cpu);
> > +
> > +	vector = cfg->vector;
> > +	ioapic_id = data->ioapic_id;
> > +
> > +	if (data->entry.source == HV_DEVICE_TYPE_IOAPIC
> 
> Does 'data' need to be checked to be non-NULL?  The parallel code in
> hv_irq_compose_msi_msg() makes such a check.

The usage of irq_data->chip_data is different in these two functions.

In this function, we're sure it is correctly allocated by
hyperv_root_ir_remapping_alloc at some point before.

In hv_irq_compose_msi_msg, irq_data->chip_data is instead used as a
temporary place to stash some state that is controlled solely by the
said function.

Once we get to the point of introducing a paravirtualized IOMMU for the
root partition, we can then unify these two paths.

> 
> > +	    && data->entry.ioapic_rte.as_uint64) {
> > +		entry = data->entry;
> > +
> > +		status = hv_unmap_ioapic_interrupt(ioapic_id, &entry);
> > +
> > +		if (status != HV_STATUS_SUCCESS)
> > +			pr_debug("%s: unexpected unmap status %d\n", __func__, status);
> > +
> > +		data->entry.ioapic_rte.as_uint64 = 0;
> > +		data->entry.source = 0; /* Invalid source */
> 
> Again comparing, hv_irq_compose_msi_msg() frees the old
> entry, and then allocates a new one.   This code reuses the old entry. 
> Any reason for the difference?
> 

See above.

I can perhaps tweak the logic a bit to reuse the same entry, but the
overall design won't change. I opted to always reallocate because that
looked more straight-forward to me.

Let me know if you feel strongly about reusing.

> > +	}
> > +
> > +
> > +	status = hv_map_ioapic_interrupt(ioapic_id, data->is_level, vcpu,
> > +					vector, &entry);
> > +
> > +	if (status != HV_STATUS_SUCCESS) {
> > +		pr_err("%s: map hypercall failed, status %d\n", __func__, status);
> > +		return;
> > +	}
> > +
> > +	data->entry = entry;
> > +
> > +	/* Turn it into an IO_APIC_route_entry, and generate MSI MSG. */
> > +	e.w1 = entry.ioapic_rte.low_uint32;
> > +	e.w2 = entry.ioapic_rte.high_uint32;
> > +
> > +	memset(msg, 0, sizeof(*msg));
> > +	msg->arch_data.vector = e.vector;
> > +	msg->arch_data.delivery_mode = e.delivery_mode;
> > +	msg->arch_addr_lo.dest_mode_logical = e.dest_mode_logical;
> > +	msg->arch_addr_lo.dmar_format = e.ir_format;
> > +	msg->arch_addr_lo.dmar_index_0_14 = e.ir_index_0_14;
> > +}
> 
> Having this whole function be more parallel to hv_irq_compose_msi_msg()
> would be nice. :-)
> 

Unlike hv_map_ioapic_interrupt and hv_map_msi_interrupt, which can
benefit from unifying now, this and hv_irq_compose_msi_msg will need to
wait till we have an IOMMU for the reason I stated above.

> > +
> > +static int hyperv_root_ir_set_affinity(struct irq_data *data,
> > +		const struct cpumask *mask, bool force)
> > +{
> > +	struct irq_data *parent = data->parent_data;
> > +	struct irq_cfg *cfg = irqd_cfg(data);
> > +	int ret;
> > +
> > +	ret = parent->chip->irq_set_affinity(parent, mask, force);
> > +	if (ret < 0 || ret == IRQ_SET_MASK_OK_DONE)
> > +		return ret;
> > +
> > +	send_cleanup_vector(cfg);
> > +
> > +	return 0;
> > +}
> > +
[...]
> > +
> > +static void hyperv_root_irq_remapping_free(struct irq_domain *domain,
> > +				 unsigned int virq, unsigned int nr_irqs)
> > +{
> > +	struct irq_data *irq_data;
> > +	struct hyperv_root_ir_data *data;
> > +	struct hv_interrupt_entry *e;
> > +	int i;
> > +
> > +	for (i = 0; i < nr_irqs; i++) {
> > +		irq_data = irq_domain_get_irq_data(domain, virq + i);
> > +
> > +		if (irq_data && irq_data->chip_data) {
> > +			data = irq_data->chip_data;
> 
> Set irq_data->chip_data to NULL?  That seems to be done in other
> similar places in your code.

There is no need to do that. By the time this function returns, irq_data
will be gone too -- freed by irq_domain_free_irqs_common.

> 
> > +			e = &data->entry;
> > +
> > +			if (e->source == HV_DEVICE_TYPE_IOAPIC
> > +			      && e->ioapic_rte.as_uint64)
> > +				hv_unmap_ioapic_interrupt(data->ioapic_id,
> > +							&data->entry);
> > +
> > +			kfree(data);
> > +		}
> > +	}
> > +
> > +	irq_domain_free_irqs_common(domain, virq, nr_irqs);
> > +}
> > +
> > +static const struct irq_domain_ops hyperv_root_ir_domain_ops = {
> > +	.select = hyperv_irq_remapping_select,
> > +	.alloc = hyperv_root_irq_remapping_alloc,
> > +	.free = hyperv_root_irq_remapping_free,
> > +};
> > +
> >  #endif
> > --
> > 2.20.1
> 
