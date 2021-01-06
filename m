Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 530E22EC50A
	for <lists+linux-hyperv@lfdr.de>; Wed,  6 Jan 2021 21:35:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727497AbhAFUfA (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 6 Jan 2021 15:35:00 -0500
Received: from mail-wm1-f51.google.com ([209.85.128.51]:51224 "EHLO
        mail-wm1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727126AbhAFUe7 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 6 Jan 2021 15:34:59 -0500
Received: by mail-wm1-f51.google.com with SMTP id v14so3451533wml.1;
        Wed, 06 Jan 2021 12:34:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UWtWu1KsYS/sKox+22vutoiZdiG8nrd65LCIrjkIsmQ=;
        b=alSu4RLoWoYv0DaMmO1I7dnpzQmDKRrvG1RgfgLuUvop8CwiKpVgGoXLbR304lZPtx
         NGBdm3kjuyLMvH5eNeTGL+WJSHVjCJLdkQ7Iw2JQC5cT7eLBaflRnm5lleYmFqexspDu
         ebcPYmOE15fQ7LFCvLU6YFdoUOQUhvQHWX69oqXUUBQIFE6Yg6HIqmIhs7hMzznzw8kD
         WTaiB0bTejpaSfqbGfNGQp0eFqwTKFxyE0NvxKrJBFeid/pZwIFwWJ0jIgGgpu7Qz8xr
         VJGVzzXbVIOIwG6N2XOdB3zpzZ/kTZKGGwOyV1n0U2DoU7iwpnDL9lt3hebFOtPFiK54
         cIxg==
X-Gm-Message-State: AOAM532id+raaXdwv8Fy9bvqwOw5LWuB/N0v3kUETNskGCXKxrQjOttE
        m885e9VO3oAv4mOFtUUlr5x0oH0fQ5U=
X-Google-Smtp-Source: ABdhPJyi/mk6bJEZpv4s04siFrGz4WFRslSdKzefDyuzKa6sA6Wz0fXcfCKCT+MmF7Qp4lnVkD6dkQ==
X-Received: by 2002:a7b:c385:: with SMTP id s5mr5144514wmj.170.1609965255500;
        Wed, 06 Jan 2021 12:34:15 -0800 (PST)
Received: from liuwe-devbox-debian-v2.j3c5onc20sse1dnehy4noqpfcg.zx.internal.cloudapp.net ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id u9sm4499456wmb.32.2021.01.06.12.34.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jan 2021 12:34:15 -0800 (PST)
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
        x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v4 17/17] x86/hyperv: handle IO-APIC when running as root
Date:   Wed,  6 Jan 2021 20:33:50 +0000
Message-Id: <20210106203350.14568-18-wei.liu@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210106203350.14568-1-wei.liu@kernel.org>
References: <20210106203350.14568-1-wei.liu@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Just like MSI/MSI-X, IO-APIC interrupts are remapped by Microsoft
Hypervisor when Linux runs as the root partition. Implement an IRQ chip
to handle mapping and unmapping of IO-APIC interrupts.

Use custom functions for mapping and unmapping ACPI GSIs. They will
issue Microsoft Hypervisor specific hypercalls on top of the native
routines.

Signed-off-by: Sunil Muthuswamy <sunilmut@microsoft.com>
Co-Developed-by: Sunil Muthuswamy <sunilmut@microsoft.com>
Signed-off-by: Wei Liu <wei.liu@kernel.org>
---
 arch/x86/hyperv/hv_init.c       |  10 ++
 arch/x86/hyperv/irqdomain.c     | 227 ++++++++++++++++++++++++++++++++
 arch/x86/include/asm/mshyperv.h |   3 +
 3 files changed, 240 insertions(+)

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index 56145aaa1732..d695567b7ead 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -263,10 +263,20 @@ static int hv_cpu_die(unsigned int cpu)
 	return 0;
 }
 
+extern int (*native_acpi_register_gsi)(struct device *dev, u32 gsi, int trigger, int polarity);
+extern void (*native_acpi_unregister_gsi)(u32 gsi);
+
 static int __init hv_pci_init(void)
 {
 	int gen2vm = efi_enabled(EFI_BOOT);
 
+	if (hv_root_partition) {
+		native_acpi_register_gsi = __acpi_register_gsi;
+		native_acpi_unregister_gsi = __acpi_unregister_gsi;
+		__acpi_register_gsi = hv_acpi_register_gsi;
+		__acpi_unregister_gsi = hv_acpi_unregister_gsi;
+	}
+
 	/*
 	 * For Generation-2 VM, we exit from pci_arch_init() by returning 0.
 	 * The purpose is to suppress the harmless warning:
diff --git a/arch/x86/hyperv/irqdomain.c b/arch/x86/hyperv/irqdomain.c
index 19637cd60231..18026885c796 100644
--- a/arch/x86/hyperv/irqdomain.c
+++ b/arch/x86/hyperv/irqdomain.c
@@ -9,6 +9,8 @@
 #include <linux/pci.h>
 #include <linux/irq.h>
 #include <asm/mshyperv.h>
+#include <asm/apic.h>
+#include <asm/io_apic.h>
 
 static int hv_unmap_interrupt(u64 id, struct hv_interrupt_entry *old_entry)
 {
@@ -330,3 +332,228 @@ struct irq_domain * __init hv_create_pci_msi_domain(void)
 }
 
 #endif /* CONFIG_PCI_MSI */
+
+/* Copied from io_apic.c */
+union entry_union {
+	struct { u32 w1, w2; };
+	struct IO_APIC_route_entry entry;
+};
+
+static int hv_unmap_ioapic_interrupt(int gsi)
+{
+	union hv_device_id device_id;
+	int ioapic, ioapic_id;
+	u8 ioapic_pin;
+	struct IO_APIC_route_entry ire;
+	union entry_union eu;
+	struct hv_interrupt_entry entry;
+
+	ioapic = mp_find_ioapic(gsi);
+	ioapic_pin = mp_find_ioapic_pin(ioapic, gsi);
+	ioapic_id = mpc_ioapic_id(ioapic);
+	ire = ioapic_read_entry(ioapic, ioapic_pin);
+
+	eu.entry = ire;
+
+	/*
+	 * Polarity may have been set by us, but Hyper-V expects the exact same
+	 * entry. See the mapping routine.
+	 */
+	eu.entry.active_low = 0;
+
+	memset(&entry, 0, sizeof(entry));
+	entry.source = HV_INTERRUPT_SOURCE_IOAPIC;
+	entry.ioapic_rte.low_uint32 = eu.w1;
+	entry.ioapic_rte.high_uint32 = eu.w2;
+
+	device_id.as_uint64 = 0;
+	device_id.device_type = HV_DEVICE_TYPE_IOAPIC;
+	device_id.ioapic.ioapic_id = (u8)ioapic_id;
+
+	return hv_unmap_interrupt(device_id.as_uint64, &entry) & HV_HYPERCALL_RESULT_MASK;
+}
+
+static int hv_map_ioapic_interrupt(int ioapic_id, int trigger, int vcpu, int vector,
+		struct hv_interrupt_entry *out_entry)
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
+	if (trigger)
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
+	*out_entry = output->interrupt_entry;
+
+	return status;
+}
+
+static unsigned int hv_ioapic_startup_irq(struct irq_data *data)
+{
+	u16 status;
+	struct IO_APIC_route_entry ire;
+	u32 vector;
+	struct irq_cfg *cfg;
+	int ioapic;
+	u8 ioapic_pin;
+	int ioapic_id;
+	int gsi;
+	union entry_union eu;
+	struct cpumask *affinity;
+	int cpu, vcpu;
+	struct hv_interrupt_entry entry;
+	struct mp_chip_data *mp_data = data->chip_data;
+
+	gsi = data->irq;
+	cfg = irqd_cfg(data);
+	affinity = irq_data_get_effective_affinity_mask(data);
+	cpu = cpumask_first_and(affinity, cpu_online_mask);
+	vcpu = hv_cpu_number_to_vp_number(cpu);
+
+	vector = cfg->vector;
+
+	ioapic = mp_find_ioapic(gsi);
+	ioapic_pin = mp_find_ioapic_pin(ioapic, gsi);
+	ioapic_id = mpc_ioapic_id(ioapic);
+	ire = ioapic_read_entry(ioapic, ioapic_pin);
+
+	/*
+	 * Always try unmapping. We do not have visibility into which whether
+	 * an IO-APIC has been mapped or not. We can't use chip_data because it
+	 * already points to mp_data.
+	 *
+	 * We don't use retarget interrupt hypercalls here because Hyper-V
+	 * doens't allow root to change the vector or specify VPs outside of
+	 * the set that is initially used during mapping.
+	 */
+	status = hv_unmap_ioapic_interrupt(gsi);
+
+	if (!(status == HV_STATUS_SUCCESS || status == HV_STATUS_INVALID_PARAMETER)) {
+		pr_debug("%s: unexpected unmap status %d\n", __func__, status);
+		return -EINVAL;
+	}
+
+	status = hv_map_ioapic_interrupt(ioapic_id, ire.is_level, vcpu, vector, &entry);
+
+	if (status != HV_STATUS_SUCCESS) {
+		pr_err("%s: map hypercall failed, status %d\n", __func__, status);
+		return -EINVAL;
+	}
+
+	/* Update the entry in mp_chip_data. It is used in other places. */
+	mp_data->entry = *(struct IO_APIC_route_entry *)&entry.ioapic_rte;
+
+	/* Sync polarity -- Hyper-V's returned polarity is always 0... */
+	mp_data->entry.active_low = ire.active_low;
+
+	eu.w1 = entry.ioapic_rte.low_uint32;
+	eu.w2 = entry.ioapic_rte.high_uint32;
+	ioapic_write_entry(ioapic, ioapic_pin, eu.entry);
+
+	return 0;
+}
+
+static void hv_ioapic_mask_irq(struct irq_data *data)
+{
+	mask_ioapic_irq(data);
+}
+
+static void hv_ioapic_unmask_irq(struct irq_data *data)
+{
+	unmask_ioapic_irq(data);
+}
+
+static int hv_ioapic_set_affinity(struct irq_data *data,
+			       const struct cpumask *mask, bool force)
+{
+	/*
+	 * We only update the affinity mask here. Programming the hardware is
+	 * done in irq_startup.
+	 */
+	return ioapic_set_affinity(data, mask, force);
+}
+
+static void hv_ioapic_ack_level(struct irq_data *irq_data)
+{
+	/*
+	 * Per email exchange with Hyper-V team, all is needed is write to
+	 * LAPIC's EOI register. They don't support directed EOI to IO-APIC.
+	 * Hyper-V handles it for us.
+	 */
+	apic_ack_irq(irq_data);
+}
+
+struct irq_chip hv_ioapic_chip __read_mostly = {
+	.name			= "HV-IO-APIC",
+	.irq_startup		= hv_ioapic_startup_irq,
+	.irq_mask		= hv_ioapic_mask_irq,
+	.irq_unmask		= hv_ioapic_unmask_irq,
+	.irq_ack		= irq_chip_ack_parent,
+	.irq_eoi		= hv_ioapic_ack_level,
+	.irq_set_affinity	= hv_ioapic_set_affinity,
+	.irq_retrigger		= irq_chip_retrigger_hierarchy,
+	.irq_get_irqchip_state	= ioapic_irq_get_chip_state,
+	.flags			= IRQCHIP_SKIP_SET_WAKE,
+};
+
+
+int (*native_acpi_register_gsi)(struct device *dev, u32 gsi, int trigger, int polarity);
+void (*native_acpi_unregister_gsi)(u32 gsi);
+
+int hv_acpi_register_gsi(struct device *dev, u32 gsi, int trigger, int polarity)
+{
+	int irq = gsi;
+
+#ifdef CONFIG_X86_IO_APIC
+	irq = native_acpi_register_gsi(dev, gsi, trigger, polarity);
+	if (irq < 0) {
+		pr_err("native_acpi_register_gsi failed %d\n", irq);
+		return irq;
+	}
+
+	if (trigger) {
+		irq_set_status_flags(irq, IRQ_LEVEL);
+		irq_set_chip_and_handler_name(irq, &hv_ioapic_chip,
+			handle_fasteoi_irq, "ioapic-fasteoi");
+	} else {
+		irq_clear_status_flags(irq, IRQ_LEVEL);
+		irq_set_chip_and_handler_name(irq, &hv_ioapic_chip,
+			handle_edge_irq, "ioapic-edge");
+	}
+#endif
+	return irq;
+}
+
+void hv_acpi_unregister_gsi(u32 gsi)
+{
+#ifdef CONFIG_X86_IO_APIC
+	(void)hv_unmap_ioapic_interrupt(gsi);
+	native_acpi_unregister_gsi(gsi);
+#endif
+}
diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index cbee72550a12..542dd5994912 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -261,6 +261,9 @@ static inline void hv_set_msi_entry_from_desc(union hv_msi_entry *msi_entry,
 	msi_entry->data.as_uint32 = msi_desc->msg.data;
 }
 
+int hv_acpi_register_gsi(struct device *dev, u32 gsi, int trigger, int polarity);
+void hv_acpi_unregister_gsi(u32 gsi);
+
 #else /* CONFIG_HYPERV */
 static inline void hyperv_init(void) {}
 static inline void hyperv_setup_mmu_ops(void) {}
-- 
2.20.1

