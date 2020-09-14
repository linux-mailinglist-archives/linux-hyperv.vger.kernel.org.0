Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A535269319
	for <lists+linux-hyperv@lfdr.de>; Mon, 14 Sep 2020 19:25:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725987AbgINRXo (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 14 Sep 2020 13:23:44 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39020 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726461AbgINM26 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 14 Sep 2020 08:28:58 -0400
Received: by mail-wm1-f65.google.com with SMTP id b79so11044559wmb.4;
        Mon, 14 Sep 2020 05:28:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ypKnVguSioF9ouhxjPXnj5ZRw/vZhm+WW1oDqzaGvAs=;
        b=kq0+gBq4YGQ4NEFZ2jYezBmXn2enRhX3naFiZ+B70UrDvXWsVbwn1+rOXaRm9jy4im
         TmYDfQyMQz1OSDKcxW1yMhFU5lNwqWdmdah8WV/k63Om081gacEkkeQx89wgAxvQFFN6
         QNa74jwNg/H2ADDHdJpYT4Zx3pHlW1QcPWajFds1nrRyG/1B7jioQYJn1L95ijyqWOAV
         t1LwGkWLXgESaGl66eDf97eLnt4a7cKh7bSqg2ll0TlmmlEuNga07Trmiw6UVYt5ybum
         w4IT3KtCz/JDRE0brSQQvrGg1shUN0ULEkLGQ5cTKga2ghDvuHmBzVbBzuEQoAYsgzAp
         NghA==
X-Gm-Message-State: AOAM533a/xQdyAgqRA9bcft+cl+Bx8ssFzYCaTvc+dXjyc8rrzGPqvxA
        bunGJGXChRWg4leQVA/M6AfiliGhucg=
X-Google-Smtp-Source: ABdhPJxcDjGNgbQk8dioN3L/e131lh4Y4dWNvT6u3/b/2NHfFw2D6lqUsYttoDo7bOBObwkY8vwG6A==
X-Received: by 2002:a1c:39c4:: with SMTP id g187mr14339186wma.126.1600084784452;
        Mon, 14 Sep 2020 04:59:44 -0700 (PDT)
Received: from liuwe-devbox-debian-v2.j3c5onc20sse1dnehy4noqpfcg.zx.internal.cloudapp.net ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id c205sm18764809wmd.33.2020.09.14.04.59.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 04:59:44 -0700 (PDT)
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
Subject: [PATCH RFC v1 16/18] x86/hyperv: implement MSI domain for root partition
Date:   Mon, 14 Sep 2020 11:59:25 +0000
Message-Id: <20200914115928.83184-8-wei.liu@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200914112802.80611-1-wei.liu@kernel.org>
References: <20200914112802.80611-1-wei.liu@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

When Linux runs as the root partition on Microsoft Hypervisor, its
interrupts are remapped.  Linux will need to explicitly map and unmap
interrupts for hardware.

Implement an MSI domain to issue the correct hypercalls. And initialize
this irqdomain in the PCI init hook.

Signed-off-by: Sunil Muthuswamy <sunilmut@microsoft.com>
Co-Developed-by: Sunil Muthuswamy <sunilmut@microsoft.com>
Signed-off-by: Wei Liu <wei.liu@kernel.org>
---
 arch/x86/hyperv/Makefile    |   2 +-
 arch/x86/hyperv/hv_init.c   |  14 ++
 arch/x86/hyperv/irqdomain.c | 355 ++++++++++++++++++++++++++++++++++++
 3 files changed, 370 insertions(+), 1 deletion(-)
 create mode 100644 arch/x86/hyperv/irqdomain.c

diff --git a/arch/x86/hyperv/Makefile b/arch/x86/hyperv/Makefile
index 565358020921..48e2c51464e8 100644
--- a/arch/x86/hyperv/Makefile
+++ b/arch/x86/hyperv/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0-only
-obj-y			:= hv_init.o mmu.o nested.o
+obj-y			:= hv_init.o mmu.o nested.o irqdomain.o
 obj-$(CONFIG_X86_64)	+= hv_apic.o hv_proc.o
 
 ifdef CONFIG_X86_64
diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index 26233aebc86c..d26d9573ceab 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -277,10 +277,24 @@ static int hv_cpu_die(unsigned int cpu)
 	return 0;
 }
 
+int hv_setup_msi_domain_irqs(struct pci_dev *dev, int nvec, int type);
+void hv_teardown_msi_irq(unsigned int irq);
+void hv_teardown_msi_irqs(struct pci_dev *dev);
+int hv_init_msi_domain(void);
+
 static int __init hv_pci_init(void)
 {
 	int gen2vm = efi_enabled(EFI_BOOT);
 
+	if (hv_root_partition) {
+		if (hv_init_msi_domain() < 0)
+			panic("Failed to allocate MSI domain\n");
+
+		x86_msi.setup_msi_irqs = hv_setup_msi_domain_irqs;
+		x86_msi.teardown_msi_irq = hv_teardown_msi_irq;
+		x86_msi.teardown_msi_irqs = hv_teardown_msi_irqs;
+	}
+
 	/*
 	 * For Generation-2 VM, we exit from pci_arch_init() by returning 0.
 	 * The purpose is to suppress the harmless warning:
diff --git a/arch/x86/hyperv/irqdomain.c b/arch/x86/hyperv/irqdomain.c
new file mode 100644
index 000000000000..6ffe32d9cde5
--- /dev/null
+++ b/arch/x86/hyperv/irqdomain.c
@@ -0,0 +1,355 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// Irqdomain for Linux to run as the root partition on Microsoft Hypervisor.
+//
+// Authors:
+//   Sunil Muthuswamy <sunilmut@microsoft.com>
+//   Wei Liu <wei.liu@kernel.org>
+
+#include <linux/pci.h>
+#include <linux/irq.h>
+#include <asm/mshyperv.h>
+
+struct rid_data {
+	struct pci_dev *bridge;
+	u32 rid;
+};
+
+static int get_rid_cb(struct pci_dev *pdev, u16 alias, void *data)
+{
+	struct rid_data *rd = data;
+	u8 bus = PCI_BUS_NUM(rd->rid);
+
+	if (pdev->bus->number != bus || PCI_BUS_NUM(alias) != bus) {
+		rd->bridge = pdev;
+		rd->rid = alias;
+	}
+
+	return 0;
+}
+
+static union hv_device_id hv_build_pci_dev_id(struct pci_dev *dev)
+{
+	union hv_device_id dev_id;
+	struct rid_data data = {
+		.bridge = NULL,
+		.rid = PCI_DEVID(dev->bus->number, dev->devfn)
+	};
+
+	pci_for_each_dma_alias(dev, get_rid_cb, &data);
+
+	dev_id.as_uint64 = 0;
+	dev_id.device_type = HV_DEVICE_TYPE_PCI;
+	dev_id.pci.segment = pci_domain_nr(dev->bus);
+
+	dev_id.pci.bdf.bus = PCI_BUS_NUM(data.rid);
+	dev_id.pci.bdf.device = PCI_SLOT(data.rid);
+	dev_id.pci.bdf.function = PCI_FUNC(data.rid);
+	dev_id.pci.source_shadow = HV_SOURCE_SHADOW_NONE;
+
+	if (data.bridge) {
+		int pos;
+
+		/*
+		 * Microsoft Hypervisor requires a bus range when the bridge is
+		 * running in PCI-X mode.
+		 *
+		 * To distinguish conventional vs PCI-X bridge, we can check
+		 * the bridge's PCI-X Secondary Status Register, Secondary Bus
+		 * Mode and Frequency bits. See PCI Express to PCI/PCI-X Bridge
+		 * Specification Revision 1.0 5.2.2.1.3.
+		 *
+		 * Value zero means it is in conventional mode, otherwise it is
+		 * in PCI-X mode.
+		 */
+
+		pos = pci_find_capability(data.bridge, PCI_CAP_ID_PCIX);
+		if (pos) {
+			u16 status;
+
+			pci_read_config_word(data.bridge, pos +
+					PCI_X_BRIDGE_SSTATUS, &status);
+
+			if (status & PCI_X_SSTATUS_FREQ) {
+				/* Non-zero, PCI-X mode */
+				u8 sec_bus, sub_bus;
+
+				dev_id.pci.source_shadow = HV_SOURCE_SHADOW_BRIDGE_BUS_RANGE;
+
+				pci_read_config_byte(data.bridge, PCI_SECONDARY_BUS, &sec_bus);
+				dev_id.pci.shadow_bus_range.secondary_bus = sec_bus;
+				pci_read_config_byte(data.bridge, PCI_SUBORDINATE_BUS, &sub_bus);
+				dev_id.pci.shadow_bus_range.subordinate_bus = sub_bus;
+			}
+		}
+	}
+
+	return dev_id;
+}
+
+static int hv_map_msi_interrupt(struct pci_dev *dev, int vcpu, int vector,
+				struct hv_interrupt_entry *entry)
+{
+	struct hv_input_map_device_interrupt *input;
+	struct hv_output_map_device_interrupt *output;
+	struct hv_device_interrupt_descriptor *intr_desc;
+	unsigned long flags;
+	int status;
+
+	local_irq_save(flags);
+
+	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
+	output = *this_cpu_ptr(hyperv_pcpu_output_arg);
+
+	intr_desc = &input->interrupt_descriptor;
+	memset(input, 0, sizeof(*input));
+	input->partition_id = hv_current_partition_id;
+	input->device_id = hv_build_pci_dev_id(dev).as_uint64;
+	intr_desc->interrupt_type = HV_X64_INTERRUPT_TYPE_FIXED;
+	intr_desc->trigger_mode = HV_INTERRUPT_TRIGGER_MODE_EDGE;
+	intr_desc->vector_count = 1;
+	intr_desc->target.vector = vector;
+	__set_bit(vcpu, (unsigned long*)&intr_desc->target.vp_mask);
+
+	status = hv_do_rep_hypercall(HVCALL_MAP_DEVICE_INTERRUPT, 0, 0, input, output) &
+			 HV_HYPERCALL_RESULT_MASK;
+	local_irq_restore(flags);
+
+	if (status != HV_STATUS_SUCCESS) {
+		pr_err("%s: hypercall failed, status %d\n", __func__, status);
+		return status;
+	}
+
+	*entry = output->interrupt_entry;
+
+	return status;
+}
+
+static inline void entry_to_msi_msg(struct hv_interrupt_entry *entry, struct msi_msg *msg)
+{
+	/* High address is always 0 */
+	msg->address_hi = 0;
+	msg->address_lo = entry->msi_entry.address.as_uint32;
+	msg->data = entry->msi_entry.data.as_uint32;
+}
+
+static int hv_unmap_msi_interrupt(struct pci_dev *dev, struct hv_interrupt_entry *old_entry);
+static void hv_irq_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
+{
+	struct msi_desc *msidesc;
+	struct pci_dev *dev;
+	struct hv_interrupt_entry out_entry, *stored_entry;
+	struct irq_cfg *cfg = irqd_cfg(data);
+	struct cpumask *affinity;
+	int cpu, vcpu;
+	int status;
+
+	msidesc = irq_data_get_msi_desc(data);
+	dev = msi_desc_to_pci_dev(msidesc);
+
+	if (!cfg) {
+		pr_debug("%s: cfg is NULL", __func__);
+		return;
+	}
+
+	affinity = irq_data_get_effective_affinity_mask(data);
+	cpu = cpumask_first_and(affinity, cpu_online_mask);
+	vcpu = hv_cpu_number_to_vp_number(cpu);
+
+	if (data->chip_data) {
+		/*
+		 * This interrupt is already mapped. Let's unmap first.
+		 *
+		 * We don't use retarget interrupt hypercalls here because
+		 * Microsoft Hypervisor doens't allow root to change the vector
+		 * or specify VPs outside of the set that is initially used
+		 * during mapping.
+		 */
+		stored_entry = data->chip_data;
+		data->chip_data = NULL;
+
+		status = hv_unmap_msi_interrupt(dev, stored_entry);
+
+		kfree(stored_entry);
+
+		if (status != HV_STATUS_SUCCESS) {
+			pr_debug("%s: failed to unmap, status %d", __func__, status);
+			return;
+		}
+	}
+
+	stored_entry = kzalloc(sizeof(*stored_entry), GFP_ATOMIC);
+	if (!stored_entry) {
+		pr_debug("%s: failed to allocate chip data\n", __func__);
+		return;
+	}
+
+	status = hv_map_msi_interrupt(dev, vcpu, cfg->vector, &out_entry);
+	if (status != HV_STATUS_SUCCESS) {
+		kfree(stored_entry);
+		return;
+	}
+
+	*stored_entry = out_entry;
+	data->chip_data = stored_entry;
+	entry_to_msi_msg(&out_entry, msg);
+
+	return;
+}
+
+/*
+ * IRQ Chip for MSI PCI/PCI-X/PCI-Express Devices,
+ * which implement the MSI or MSI-X Capability Structure.
+ */
+static struct irq_chip hv_pci_msi_controller = {
+	.name			= "HV-PCI-MSI",
+	.irq_unmask		= pci_msi_unmask_irq,
+	.irq_mask		= pci_msi_mask_irq,
+	.irq_ack		= irq_chip_ack_parent,
+	.irq_retrigger		= irq_chip_retrigger_hierarchy,
+	.irq_compose_msi_msg	= hv_irq_compose_msi_msg,
+	.irq_set_affinity	= msi_domain_set_affinity,
+	.flags			= IRQCHIP_SKIP_SET_WAKE,
+};
+
+static struct msi_domain_ops pci_msi_domain_ops = {
+	.get_hwirq	= pci_msi_get_hwirq,
+	.msi_prepare	= pci_msi_prepare,
+	.set_desc	= pci_msi_set_desc,
+};
+
+static struct msi_domain_info hv_pci_msi_domain_info = {
+	.flags		= MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
+			  MSI_FLAG_PCI_MSIX,
+	.ops		= &pci_msi_domain_ops,
+	.chip		= &hv_pci_msi_controller,
+	.handler	= handle_edge_irq,
+	.handler_name	= "edge",
+};
+
+static struct irq_domain *hv_msi_domain;
+
+int hv_init_msi_domain(void)
+{
+	struct fwnode_handle *fn;
+
+	fn = irq_domain_alloc_named_fwnode("HV-PCI-MSI");
+	if (!fn) {
+		pr_debug("irq_domain_alloc_named_fwnode failed\n");
+		return -1;
+	}
+
+	hv_msi_domain = pci_msi_create_irq_domain(fn, &hv_pci_msi_domain_info,
+					  x86_vector_domain);
+	irq_domain_free_fwnode(fn);
+	if (!hv_msi_domain) {
+		pr_warn("Failed to initialize irqdomain for MSI/MSI-X.\n");
+		return -1;
+	}
+
+	return 0;
+}
+
+int hv_setup_msi_domain_irqs(struct pci_dev *dev, int nvec, int type)
+{
+	int ret;
+
+	if (type == PCI_CAP_ID_MSI && nvec > 1) {
+		pr_debug("%s: Multi-message PCI MSI not supported", __func__);
+		return 1;
+	}
+
+	ret = msi_domain_alloc_irqs(hv_msi_domain, &dev->dev, nvec);
+	if (ret)
+		pr_debug("%s: msi_domain_alloc_irqs returned: %d\n", __func__, ret);
+
+	return ret;
+}
+
+static int hv_unmap_interrupt(u64 id, struct hv_interrupt_entry *old_entry)
+{
+	unsigned long flags;
+	struct hv_input_unmap_device_interrupt *input;
+	struct hv_interrupt_entry *intr_entry;
+	int status;
+
+	local_irq_save(flags);
+	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
+
+	memset(input, 0, sizeof(*input));
+	intr_entry = &input->interrupt_entry;
+	input->partition_id = hv_current_partition_id;
+	input->device_id = id;
+	*intr_entry = *old_entry;
+
+	status = hv_do_rep_hypercall(HVCALL_UNMAP_DEVICE_INTERRUPT, 0, 0, input, NULL) &
+			 HV_HYPERCALL_RESULT_MASK;
+	local_irq_restore(flags);
+
+	return status;
+}
+
+static int hv_unmap_msi_interrupt(struct pci_dev *dev, struct hv_interrupt_entry *old_entry)
+{
+	return hv_unmap_interrupt(hv_build_pci_dev_id(dev).as_uint64, old_entry)
+		& HV_HYPERCALL_RESULT_MASK;
+}
+
+static void hv_teardown_msi_irq_common(struct pci_dev *dev, struct msi_desc *msidesc, int irq)
+{
+	int status;
+	struct hv_interrupt_entry old_entry;
+	struct irq_desc *desc;
+	struct irq_data *data;
+	struct msi_msg msg;
+
+	desc = irq_to_desc(irq);
+	if (!desc) {
+		pr_debug("%s: no irq desc\n", __func__);
+		return;
+	}
+
+	data = &desc->irq_data;
+	if (!data) {
+		pr_debug("%s: no irq data\n", __func__);
+		return;
+	}
+
+	if (!data->chip_data) {
+		pr_debug("%s: no chip data\n!", __func__);
+		return;
+	}
+
+	old_entry = *(struct hv_interrupt_entry *)data->chip_data;
+	entry_to_msi_msg(&old_entry, &msg);
+
+	kfree(data->chip_data);
+	data->chip_data = NULL;
+
+	status = hv_unmap_msi_interrupt(dev, &old_entry);
+
+	if (status != HV_STATUS_SUCCESS) {
+		pr_err("%s: hypercall failed, status %d\n", __func__, status);
+		return;
+	}
+}
+
+void hv_teardown_msi_irq(unsigned int irq)
+{
+	irq_domain_free_irqs(irq, 1);
+}
+
+void hv_teardown_msi_irqs(struct pci_dev *dev)
+{
+	int i;
+	struct msi_desc *entry;
+
+	for_each_pci_msi_entry(entry, dev) {
+		if (entry->irq) {
+			for (i = 0; i < entry->nvec_used; i++) {
+				hv_teardown_msi_irq_common(dev, entry, entry->irq + i);
+				hv_teardown_msi_irq(entry->irq + i);
+			}
+		}
+	}
+}
-- 
2.20.1

