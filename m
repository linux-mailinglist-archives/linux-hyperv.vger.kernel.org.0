Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B19772F01D1
	for <lists+linux-hyperv@lfdr.de>; Sat,  9 Jan 2021 17:45:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726395AbhAIQpy (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sat, 9 Jan 2021 11:45:54 -0500
Received: from mail-wm1-f46.google.com ([209.85.128.46]:36355 "EHLO
        mail-wm1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbhAIQpx (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 9 Jan 2021 11:45:53 -0500
Received: by mail-wm1-f46.google.com with SMTP id y23so11074287wmi.1;
        Sat, 09 Jan 2021 08:45:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ny+4xbbpzzJqGhoOe/2PKxMoxEZX7nO4lN2skz+XnXA=;
        b=d0NGTxlYujTeEEwJvnp05LW6ReQdyJy8g/s/lpL88+U509Vno9PcH6aKq7FN3YkTJw
         chCeCrUx7ysiszevfcN6ziZNnpXO1fM2Hm14o1BxHpd1xyDAPEVEdVX310XJzL0QnJiM
         SCa+CES91v/fwcWDUEOn5JrCeuv4Lydi+rJHjyA9IIhsesupIj+DT8rcItz+1Z79A7Ow
         sIoXKlUF42/HVHEYZpFJsBQP73QUp+7+WSexkra++6N64wBwu97+2hG8U6eGuTa8dxYb
         l8P/I0r7VY5rQ81z4KLMVZPwyk1STbSnFqaOFLW9oFIDM+UmuFDik/lLwHiKNl/gGR1a
         hBjQ==
X-Gm-Message-State: AOAM532788tQrz1W6JpxdOlqJEO/YXNWqjZUbCHGHqPlST0Uznux3BSz
        VXHQfQWr9Xp6Y1ivh9p6HpEdDHfBuPs=
X-Google-Smtp-Source: ABdhPJxlv630GEE8PEZzdUjRuvnxnIYgnfdf6Mv2451FQeYXJ+3u/htjAwvHa+jLoqttImg6wiZNCQ==
X-Received: by 2002:a1c:6741:: with SMTP id b62mr7851628wmc.21.1610210709765;
        Sat, 09 Jan 2021 08:45:09 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id s13sm18461450wra.53.2021.01.09.08.45.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Jan 2021 08:45:09 -0800 (PST)
Date:   Sat, 9 Jan 2021 16:45:07 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Linux on Hyper-V List <linux-hyperv@vger.kernel.org>
Cc:     virtualization@lists.linux-foundation.org,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Nuno Das Neves <nunodasneves@linux.microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, joro@8bytes.org
Subject: Re: [PATCH v4 17/17] x86/hyperv: handle IO-APIC when running as root
Message-ID: <20210109164507.cpowxln6uriupvaq@liuwe-devbox-debian-v2>
References: <20210106203350.14568-1-wei.liu@kernel.org>
 <20210106203350.14568-18-wei.liu@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210106203350.14568-18-wei.liu@kernel.org>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Jan 06, 2021 at 08:33:50PM +0000, Wei Liu wrote:
> Just like MSI/MSI-X, IO-APIC interrupts are remapped by Microsoft
> Hypervisor when Linux runs as the root partition. Implement an IRQ chip
> to handle mapping and unmapping of IO-APIC interrupts.
> 
> Use custom functions for mapping and unmapping ACPI GSIs. They will
> issue Microsoft Hypervisor specific hypercalls on top of the native
> routines.
> 

This patch is superseded by a new patch I recently wrote.

The new approach is to implement a parent IRQ remapping domain for the
IO-APIC domain in Linux. It fits cleanly into Linux's architecture. No
more horrendous hooking required! :-)

Please review the following patch instead.

CC IOMMU maintainer. FYI.

---8<---
From 53d2346c97efdfc6ac3bc435990767bdd29ef311 Mon Sep 17 00:00:00 2001
From: Wei Liu <wei.liu@kernel.org>
Date: Fri, 8 Jan 2021 21:29:24 +0000
Subject: [PATCH] iommu/hyperv: setup an IO-APIC IRQ remapping domain for root
 partition

Just like MSI/MSI-X, IO-APIC interrupts are remapped by Microsoft
Hypervisor when Linux runs as the root partition. Implement an IRQ
domain to handle mapping and unmapping of IO-APIC interrupts.

Signed-off-by: Wei Liu <wei.liu@kernel.org>
---
 arch/x86/hyperv/irqdomain.c     |  54 ++++++++++
 arch/x86/include/asm/mshyperv.h |   4 +
 drivers/iommu/hyperv-iommu.c    | 179 +++++++++++++++++++++++++++++++-
 3 files changed, 233 insertions(+), 4 deletions(-)

diff --git a/arch/x86/hyperv/irqdomain.c b/arch/x86/hyperv/irqdomain.c
index 19637cd60231..8e2b4e478b70 100644
--- a/arch/x86/hyperv/irqdomain.c
+++ b/arch/x86/hyperv/irqdomain.c
@@ -330,3 +330,57 @@ struct irq_domain * __init hv_create_pci_msi_domain(void)
 }
 
 #endif /* CONFIG_PCI_MSI */
+
+int hv_unmap_ioapic_interrupt(int ioapic_id, struct hv_interrupt_entry *entry)
+{
+	union hv_device_id device_id;
+
+	device_id.as_uint64 = 0;
+	device_id.device_type = HV_DEVICE_TYPE_IOAPIC;
+	device_id.ioapic.ioapic_id = (u8)ioapic_id;
+
+	return hv_unmap_interrupt(device_id.as_uint64, entry) & HV_HYPERCALL_RESULT_MASK;
+}
+EXPORT_SYMBOL_GPL(hv_unmap_ioapic_interrupt);
+
+int hv_map_ioapic_interrupt(int ioapic_id, bool level, int vcpu, int vector,
+		struct hv_interrupt_entry *entry)
+{
+	unsigned long flags;
+	struct hv_input_map_device_interrupt *input;
+	struct hv_output_map_device_interrupt *output;
+	union hv_device_id device_id;
+	struct hv_device_interrupt_descriptor *intr_desc;
+	u16 status;
+
+	device_id.as_uint64 = 0;
+	device_id.device_type = HV_DEVICE_TYPE_IOAPIC;
+	device_id.ioapic.ioapic_id = (u8)ioapic_id;
+
+	local_irq_save(flags);
+	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
+	output = *this_cpu_ptr(hyperv_pcpu_output_arg);
+	memset(input, 0, sizeof(*input));
+	intr_desc = &input->interrupt_descriptor;
+	input->partition_id = hv_current_partition_id;
+	input->device_id = device_id.as_uint64;
+	intr_desc->interrupt_type = HV_X64_INTERRUPT_TYPE_FIXED;
+	intr_desc->target.vector = vector;
+	intr_desc->vector_count = 1;
+
+	if (level)
+		intr_desc->trigger_mode = HV_INTERRUPT_TRIGGER_MODE_LEVEL;
+	else
+		intr_desc->trigger_mode = HV_INTERRUPT_TRIGGER_MODE_EDGE;
+
+	__set_bit(vcpu, (unsigned long *)&intr_desc->target.vp_mask);
+
+	status = hv_do_rep_hypercall(HVCALL_MAP_DEVICE_INTERRUPT, 0, 0, input, output) &
+			 HV_HYPERCALL_RESULT_MASK;
+	local_irq_restore(flags);
+
+	*entry = output->interrupt_entry;
+
+	return status;
+}
+EXPORT_SYMBOL_GPL(hv_map_ioapic_interrupt);
diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index ccc849e25d5e..345d7c6f8c37 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -263,6 +263,10 @@ static inline void hv_set_msi_entry_from_desc(union hv_msi_entry *msi_entry,
 
 struct irq_domain *hv_create_pci_msi_domain(void);
 
+int hv_map_ioapic_interrupt(int ioapic_id, bool level, int vcpu, int vector,
+		struct hv_interrupt_entry *entry);
+int hv_unmap_ioapic_interrupt(int ioapic_id, struct hv_interrupt_entry *entry);
+
 #else /* CONFIG_HYPERV */
 static inline void hyperv_init(void) {}
 static inline void hyperv_setup_mmu_ops(void) {}
diff --git a/drivers/iommu/hyperv-iommu.c b/drivers/iommu/hyperv-iommu.c
index b7db6024e65c..6d35e4c303c6 100644
--- a/drivers/iommu/hyperv-iommu.c
+++ b/drivers/iommu/hyperv-iommu.c
@@ -116,30 +116,43 @@ static const struct irq_domain_ops hyperv_ir_domain_ops = {
 	.free = hyperv_irq_remapping_free,
 };
 
+static const struct irq_domain_ops hyperv_root_ir_domain_ops;
 static int __init hyperv_prepare_irq_remapping(void)
 {
 	struct fwnode_handle *fn;
 	int i;
+	const char *name;
+	const struct irq_domain_ops *ops;
 
 	if (!hypervisor_is_type(X86_HYPER_MS_HYPERV) ||
 	    x86_init.hyper.msi_ext_dest_id() ||
-	    !x2apic_supported() || hv_root_partition)
+	    !x2apic_supported())
 		return -ENODEV;
 
-	fn = irq_domain_alloc_named_id_fwnode("HYPERV-IR", 0);
+	if (hv_root_partition) {
+		name = "HYPERV-ROOT-IR";
+		ops = &hyperv_root_ir_domain_ops;
+	} else {
+		name = "HYPERV-IR";
+		ops = &hyperv_ir_domain_ops;
+	}
+
+	fn = irq_domain_alloc_named_id_fwnode(name, 0);
 	if (!fn)
 		return -ENOMEM;
 
 	ioapic_ir_domain =
 		irq_domain_create_hierarchy(arch_get_ir_parent_domain(),
-				0, IOAPIC_REMAPPING_ENTRY, fn,
-				&hyperv_ir_domain_ops, NULL);
+				0, IOAPIC_REMAPPING_ENTRY, fn, ops, NULL);
 
 	if (!ioapic_ir_domain) {
 		irq_domain_free_fwnode(fn);
 		return -ENOMEM;
 	}
 
+	if (hv_root_partition)
+		return 0; /* The rest is only relevant to guests */
+
 	/*
 	 * Hyper-V doesn't provide irq remapping function for
 	 * IO-APIC and so IO-APIC only accepts 8-bit APIC ID.
@@ -167,4 +180,162 @@ struct irq_remap_ops hyperv_irq_remap_ops = {
 	.enable			= hyperv_enable_irq_remapping,
 };
 
+/* IRQ remapping domain when Linux runs as the root partition */
+struct hyperv_root_ir_data {
+	u8 ioapic_id;
+	bool is_level;
+	struct hv_interrupt_entry entry;
+};
+
+static void
+hyperv_root_ir_compose_msi_msg(struct irq_data *irq_data, struct msi_msg *msg)
+{
+	u16 status;
+	u32 vector;
+	struct irq_cfg *cfg;
+	int ioapic_id;
+	struct cpumask *affinity;
+	int cpu, vcpu;
+	struct hv_interrupt_entry entry;
+	struct hyperv_root_ir_data *data = irq_data->chip_data;
+	struct IO_APIC_route_entry e;
+
+	cfg = irqd_cfg(irq_data);
+	affinity = irq_data_get_effective_affinity_mask(irq_data);
+	cpu = cpumask_first_and(affinity, cpu_online_mask);
+	vcpu = hv_cpu_number_to_vp_number(cpu);
+
+	vector = cfg->vector;
+	ioapic_id = data->ioapic_id;
+
+	if (data->entry.source == HV_DEVICE_TYPE_IOAPIC
+	    && data->entry.ioapic_rte.as_uint64) {
+		entry = data->entry;
+
+		status = hv_unmap_ioapic_interrupt(ioapic_id, &entry);
+
+		if (status != HV_STATUS_SUCCESS)
+			pr_debug("%s: unexpected unmap status %d\n", __func__, status);
+
+		data->entry.ioapic_rte.as_uint64 = 0;
+		data->entry.source = 0; /* Invalid source */
+	}
+
+
+	status = hv_map_ioapic_interrupt(ioapic_id, data->is_level, vcpu,
+					vector, &entry);
+
+	if (status != HV_STATUS_SUCCESS) {
+		pr_err("%s: map hypercall failed, status %d\n", __func__, status);
+		return;
+	}
+
+	data->entry = entry;
+
+	/* Turn it into an IO_APIC_route_entry, and generate MSI MSG. */
+	e.w1 = entry.ioapic_rte.low_uint32;
+	e.w2 = entry.ioapic_rte.high_uint32;
+
+	memset(msg, 0, sizeof(*msg));
+	msg->arch_data.vector = e.vector;
+	msg->arch_data.delivery_mode = e.delivery_mode;
+	msg->arch_addr_lo.dest_mode_logical = e.dest_mode_logical;
+	msg->arch_addr_lo.dmar_format = e.ir_format;
+	msg->arch_addr_lo.dmar_index_0_14 = e.ir_index_0_14;
+}
+
+static int hyperv_root_ir_set_affinity(struct irq_data *data,
+		const struct cpumask *mask, bool force)
+{
+	struct irq_data *parent = data->parent_data;
+	struct irq_cfg *cfg = irqd_cfg(data);
+	int ret;
+
+	ret = parent->chip->irq_set_affinity(parent, mask, force);
+	if (ret < 0 || ret == IRQ_SET_MASK_OK_DONE)
+		return ret;
+
+	send_cleanup_vector(cfg);
+
+	return 0;
+}
+
+static struct irq_chip hyperv_root_ir_chip = {
+	.name			= "HYPERV-ROOT-IR",
+	.irq_ack		= apic_ack_irq,
+	.irq_set_affinity	= hyperv_root_ir_set_affinity,
+	.irq_compose_msi_msg	= hyperv_root_ir_compose_msi_msg,
+};
+
+static int hyperv_root_irq_remapping_alloc(struct irq_domain *domain,
+				     unsigned int virq, unsigned int nr_irqs,
+				     void *arg)
+{
+	struct irq_alloc_info *info = arg;
+	struct irq_data *irq_data;
+	struct hyperv_root_ir_data *data;
+	int ret = 0;
+
+	if (!info || info->type != X86_IRQ_ALLOC_TYPE_IOAPIC || nr_irqs > 1)
+		return -EINVAL;
+
+	ret = irq_domain_alloc_irqs_parent(domain, virq, nr_irqs, arg);
+	if (ret < 0)
+		return ret;
+
+	data = kzalloc(sizeof(*data), GFP_KERNEL);
+	if (!data) {
+		irq_domain_free_irqs_common(domain, virq, nr_irqs);
+		return -ENOMEM;
+	}
+
+	irq_data = irq_domain_get_irq_data(domain, virq);
+	if (!irq_data) {
+		kfree(data);
+		irq_domain_free_irqs_common(domain, virq, nr_irqs);
+		return -EINVAL;
+	}
+
+	data->ioapic_id = info->devid;
+	data->is_level = info->ioapic.is_level;
+
+	irq_data->chip = &hyperv_root_ir_chip;
+	irq_data->chip_data = data;
+
+	return 0;
+}
+
+static void hyperv_root_irq_remapping_free(struct irq_domain *domain,
+				 unsigned int virq, unsigned int nr_irqs)
+{
+	struct irq_data *irq_data;
+	struct hyperv_root_ir_data *data;
+	struct hv_interrupt_entry *e;
+	int i;
+
+	for (i = 0; i < nr_irqs; i++) {
+		irq_data = irq_domain_get_irq_data(domain, virq + i);
+
+		if (irq_data && irq_data->chip_data) {
+			data = irq_data->chip_data;
+			e = &data->entry;
+
+			if (e->source == HV_DEVICE_TYPE_IOAPIC
+			      && e->ioapic_rte.as_uint64)
+				hv_unmap_ioapic_interrupt(data->ioapic_id,
+							&data->entry);
+
+			kfree(data);
+		}
+	}
+
+	irq_domain_free_irqs_common(domain, virq, nr_irqs);
+}
+
+static const struct irq_domain_ops hyperv_root_ir_domain_ops = {
+	.select = hyperv_irq_remapping_select,
+	.alloc = hyperv_root_irq_remapping_alloc,
+	.free = hyperv_root_irq_remapping_free,
+};
+
 #endif
-- 
2.20.1

