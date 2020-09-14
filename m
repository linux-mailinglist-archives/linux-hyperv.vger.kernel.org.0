Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49B87268AB3
	for <lists+linux-hyperv@lfdr.de>; Mon, 14 Sep 2020 14:13:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726087AbgINMNk (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 14 Sep 2020 08:13:40 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39132 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726173AbgINMHS (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 14 Sep 2020 08:07:18 -0400
Received: by mail-wr1-f68.google.com with SMTP id a17so18436641wrn.6;
        Mon, 14 Sep 2020 05:07:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CQhdWZLWboUGhTHEEHucOePIxWTmZ246kBEMlCiDNlc=;
        b=dim84q7TgnyOfj96GB77IEgyZiDhToILNHpxzWJUvmQtS8Dd69veyO1Gv3kImMFzt8
         g3BuzDFeYV2uKVuetkFElNfsvbo31OaYvpRbj2WirG4wLyNIy0lkfMVLP94veSqOAdWH
         VWAQasxJtu6X8LO0qvCezctLNyOCWqbKhceP4dNMpE4OOwbONYM6kjNivX3Jwa/jln6O
         WTzBUUqmS1lXbh7WoH9GZB0uXWR2V1MUqKrxNq2ZTGSELhy8RX9DVtWHSrC7Jc4L+1M2
         aYhvzOevQ+WyAXj2LkciYw8NzXwt7anuAh3nuDUt2aYXZSsSxCLHD/rrGag8AwaugyVY
         nv7w==
X-Gm-Message-State: AOAM530FE6R18Jx+66a5bRAfCovEEdOyVKNQpmM1plp1+S15Gf55ax0y
        /OZ8HQQLew2ohaSqqO30MK6U5bLzs4c=
X-Google-Smtp-Source: ABdhPJwKximYkg4wCi2sQm88MdSpFcX+3d475f+Opef7PPkK8J/+2yYInU30gpE+dYp6S+HG1kdJ3A==
X-Received: by 2002:adf:f042:: with SMTP id t2mr15018932wro.385.1600084787986;
        Mon, 14 Sep 2020 04:59:47 -0700 (PDT)
Received: from liuwe-devbox-debian-v2.j3c5onc20sse1dnehy4noqpfcg.zx.internal.cloudapp.net ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id c205sm18764809wmd.33.2020.09.14.04.59.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 04:59:47 -0700 (PDT)
From:   Wei Liu <wei.liu@kernel.org>
To:     Linux on Hyper-V List <linux-hyperv@vger.kernel.org>
Cc:     virtualization@lists.linux-foundation.org,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Nuno Das Neves <nudasnev@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH RFC v1 18/18] x86/hyperv: handle IO-APIC when running as root
Date:   Mon, 14 Sep 2020 11:59:27 +0000
Message-Id: <20200914115928.83184-10-wei.liu@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200914112802.80611-1-wei.liu@kernel.org>
References: <20200914112802.80611-1-wei.liu@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-hyperv-owner@vger.kernel.org
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
 arch/x86/hyperv/hv_init.c   |  11 ++
 arch/x86/hyperv/irqdomain.c | 225 ++++++++++++++++++++++++++++++++++++
 2 files changed, 236 insertions(+)

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index d26d9573ceab..0d6a6c0f288f 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -282,6 +282,12 @@ void hv_teardown_msi_irq(unsigned int irq);
 void hv_teardown_msi_irqs(struct pci_dev *dev);
 int hv_init_msi_domain(void);
 
+int hv_acpi_register_gsi(struct device *dev, u32 gsi, int trigger, int polarity);
+void hv_acpi_unregister_gsi(u32 gsi);
+
+extern int (*native_acpi_register_gsi)(struct device *dev, u32 gsi, int trigger, int polarity);
+extern void (*native_acpi_unregister_gsi)(u32 gsi);
+
 static int __init hv_pci_init(void)
 {
 	int gen2vm = efi_enabled(EFI_BOOT);
@@ -293,6 +299,11 @@ static int __init hv_pci_init(void)
 		x86_msi.setup_msi_irqs = hv_setup_msi_domain_irqs;
 		x86_msi.teardown_msi_irq = hv_teardown_msi_irq;
 		x86_msi.teardown_msi_irqs = hv_teardown_msi_irqs;
+
+		native_acpi_register_gsi = __acpi_register_gsi;
+		native_acpi_unregister_gsi = __acpi_unregister_gsi;
+		__acpi_register_gsi = hv_acpi_register_gsi;
+		__acpi_unregister_gsi = hv_acpi_unregister_gsi;
 	}
 
 	/*
diff --git a/arch/x86/hyperv/irqdomain.c b/arch/x86/hyperv/irqdomain.c
index 6ffe32d9cde5..2ce3dbd80c5d 100644
--- a/arch/x86/hyperv/irqdomain.c
+++ b/arch/x86/hyperv/irqdomain.c
@@ -353,3 +353,228 @@ void hv_teardown_msi_irqs(struct pci_dev *dev)
 		}
 	}
 }
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
+	eu.entry.polarity = 0;
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
+	int status;
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
+	int status;
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
+		return -1;
+	}
+
+	status = hv_map_ioapic_interrupt(ioapic_id, ire.trigger, vcpu, vector, &entry);
+
+	if (status != HV_STATUS_SUCCESS) {
+		pr_err("%s: map hypercall failed, status %d\n", __func__, status);
+		return -1;
+	}
+
+	/* Update the entry in mp_chip_data. It is used in other places. */
+	mp_data->entry = *(struct IO_APIC_route_entry *)&entry.ioapic_rte;
+
+	/* Sync polarity -- Hyper-V's returned polarity is always 0... */
+	mp_data->entry.polarity = ire.polarity;
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
+void hv_ioapic_ack_level(struct irq_data *irq_data)
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
-- 
2.20.1

