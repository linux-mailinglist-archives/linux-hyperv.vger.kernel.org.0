Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B5BD252DFA
	for <lists+linux-hyperv@lfdr.de>; Wed, 26 Aug 2020 14:08:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729776AbgHZMIO (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 26 Aug 2020 08:08:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729428AbgHZMB4 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 26 Aug 2020 08:01:56 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C30C8C061574;
        Wed, 26 Aug 2020 05:01:53 -0700 (PDT)
Message-Id: <20200826112335.202234502@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598443312;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=uPQqEgGFOe4cl6XAlfv+gagaLsuiNZm2NWUpf1sogAY=;
        b=zyVd7NX6ttwVL4AxLaDbK+42XmkO5hSjdZ+yHCJtQTRzO5BkPhQ0siM+olIZkmvOtlPyR5
        qoIdRg7v+ZoUpI6Garx+ZUpueZPO3JuVdeLVi8onnz1vkzHUrM9oVExcVgJjGAAYHHKghw
        bC6iDtRAwu27SbvZwNdlbpL5PtqT9hq8Jpoxs6aPmfa4/H297Vm4iPn23gYPm78j3yePHh
        XFPIDXpGksQvfO0bU87Jr0bwWCqGCxHKoRP+2fqfCh3pKYt5LBO9Pd2pQSLB0mcyWe/5i3
        dqtZ8CVnIqGLUUO9SMTgOUtJqC93FlQCDOvNJhJwi5GFSuFX686Z2haE0N+grg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598443312;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=uPQqEgGFOe4cl6XAlfv+gagaLsuiNZm2NWUpf1sogAY=;
        b=+iA+4gTK4+hVCN7IQ5xXgQsk1j5xKpfs62FvyLwf2zKAjL323xaFNOuSL/nz/DvdzDwINe
        r57s9BG+f4uFPZDg==
Date:   Wed, 26 Aug 2020 13:17:14 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux-foundation.org, linux-hyperv@vger.kernel.org,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Jon Derrick <jonathan.derrick@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Wei Liu <wei.liu@kernel.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Steve Wahl <steve.wahl@hpe.com>,
        Dimitri Sivanich <sivanich@hpe.com>,
        Russ Anderson <rja@hpe.com>, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        xen-devel@lists.xenproject.org, Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Megha Dey <megha.dey@intel.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Jacob Pan <jacob.jun.pan@intel.com>,
        Baolu Lu <baolu.lu@intel.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: [patch V2 46/46] irqchip: Add IMS (Interrupt Message Storm) driver -
 NOT FOR MERGING
References: <20200826111628.794979401@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Generic IMS irq chips and irq domain implementations for IMS based devices
in both variants:

   - Message store in an array in device memory
   - Message store in system RAM (part of queue memory)

Allocation and freeing of interrupts happens via the generic
msi_domain_alloc/free_irqs() interface. No special purpose IMS magic
required as long as the interrupt domain is stored in the underlying device
struct.
                                                                                                                                                                                                                                                                               
Completely untested of course and mostly for illustration and educational
purpose. This should of course be a modular irq chip, but adding that
support is left as an exercise for the people who care about this deeply.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V2: Reworked to handle both devmem arrays and queue based storage.
---
 drivers/irqchip/Kconfig             |   19 +
 drivers/irqchip/Makefile            |    1 
 drivers/irqchip/irq-ims-msi.c       |  343 ++++++++++++++++++++++++++++++++++++
 include/linux/irqchip/irq-ims-msi.h |   95 +++++++++
 4 files changed, 458 insertions(+)

--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -571,4 +571,23 @@ config LOONGSON_PCH_MSI
 	help
 	  Support for the Loongson PCH MSI Controller.
 
+config IMS_MSI
+	depends on PCI
+	select DEVICE_MSI
+	bool
+
+config IMS_MSI_ARRAY
+	bool "IMS Interrupt Message Storm MSI controller for device memory storage arrays"
+	select IMS_MSI
+	help
+	  Support for IMS Interrupt Message Storm MSI controller
+	  with IMS slot storage in a slot array in device memory
+
+config IMS_MSI_QUEUE
+	bool "IMS Interrupt Message Storm MSI controller for IMS queue storage"
+	select IMS_MSI
+	help
+	  Support for IMS Interrupt Message Storm MSI controller
+	  with IMS slot storage in the queue storage of a device
+
 endmenu
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -111,3 +111,4 @@ obj-$(CONFIG_LOONGSON_HTPIC)		+= irq-loo
 obj-$(CONFIG_LOONGSON_HTVEC)		+= irq-loongson-htvec.o
 obj-$(CONFIG_LOONGSON_PCH_PIC)		+= irq-loongson-pch-pic.o
 obj-$(CONFIG_LOONGSON_PCH_MSI)		+= irq-loongson-pch-msi.o
+obj-$(CONFIG_IMS_MSI)			+= irq-ims-msi.o
--- /dev/null
+++ b/drivers/irqchip/irq-ims-msi.c
@@ -0,0 +1,343 @@
+// SPDX-License-Identifier: GPL-2.0
+// (C) Copyright 2020 Thomas Gleixner <tglx@linutronix.de>
+/*
+ * Shared interrupt chips and irq domains for IMS devices
+ */
+#include <linux/device.h>
+#include <linux/slab.h>
+#include <linux/msi.h>
+#include <linux/irq.h>
+
+#include <linux/irqchip/irq-ims-msi.h>
+
+#ifdef CONFIG_IMS_ARRAY
+
+struct ims_array_data {
+	struct ims_array_info	info;
+	unsigned long		map[0];
+};
+
+static void ims_array_mask_irq(struct irq_data *data)
+{
+	struct msi_desc *desc = irq_data_get_msi_desc(data);
+	struct ims_slot __iomem *slot = desc->device_msi.priv_iomem;
+	u32 __iomem *ctrl = &slot->ctrl;
+
+	iowrite32(ioread32(ctrl) & ~IMS_VECTOR_CTRL_UNMASK, ctrl);
+}
+
+static void ims_array_unmask_irq(struct irq_data *data)
+{
+	struct msi_desc *desc = irq_data_get_msi_desc(data);
+	struct ims_slot __iomem *slot = desc->device_msi.priv_iomem;
+	u32 __iomem *ctrl = &slot->ctrl;
+
+	iowrite32(ioread32(ctrl) | IMS_VECTOR_CTRL_UNMASK, ctrl);
+}
+
+static void ims_array_write_msi_msg(struct irq_data *data, struct msi_msg *msg)
+{
+	struct msi_desc *desc = irq_data_get_msi_desc(data);
+	struct ims_slot __iomem *slot = desc->device_msi.priv_iomem;
+
+	iowrite32(msg->address_lo, &slot->address_lo);
+	iowrite32(msg->address_hi, &slot->address_hi);
+	iowrite32(msg->data, &slot->data);
+}
+
+static const struct irq_chip ims_array_msi_controller = {
+	.name			= "IMS",
+	.irq_mask		= ims_array_mask_irq,
+	.irq_unmask		= ims_array_unmask_irq,
+	.irq_write_msi_msg	= ims_array_write_msi_msg,
+	.irq_retrigger		= irq_chip_retrigger_hierarchy,
+	.flags			= IRQCHIP_SKIP_SET_WAKE,
+};
+
+static void ims_array_reset_slot(struct ims_slot __iomem *slot)
+{
+	iowrite32(0, &slot->address_lo);
+	iowrite32(0, &slot->address_hi);
+	iowrite32(0, &slot->data);
+	iowrite32(0, &slot->ctrl);
+}
+
+static void ims_array_free_msi_store(struct irq_domain *domain,
+				     struct device *dev)
+{
+	struct msi_domain_info *info = domain->host_data;
+	struct ims_array_data *ims = info->data;
+	struct msi_desc *entry;
+
+	for_each_msi_entry(entry, dev) {
+		if (entry->device_msi.priv_iomem) {
+			clear_bit(entry->device_msi.hwirq, ims->map);
+			ims_array_reset_slot(entry->device_msi.priv_iomem);
+			entry->device_msi.priv_iomem = NULL;
+			entry->device_msi.hwirq = 0;
+		}
+	}
+}
+
+static int ims_array_alloc_msi_store(struct irq_domain *domain,
+				     struct device *dev, int nvec)
+{
+	struct msi_domain_info *info = domain->host_data;
+	struct ims_array_data *ims = info->data;
+	struct msi_desc *entry;
+
+	for_each_msi_entry(entry, dev) {
+		unsigned int idx;
+
+		idx = find_first_zero_bit(ims->map, ims->info.max_slots);
+		if (idx >= ims->info.max_slots)
+			goto fail;
+		set_bit(idx, ims->map);
+		entry->device_msi.priv_iomem = &ims->info.slots[idx];
+		entry->device_msi.hwirq = idx;
+	}
+	return 0;
+
+fail:
+	ims_array_free_msi_store(domain, dev);
+	return -ENOSPC;
+}
+
+struct ims_domain_template {
+	struct msi_domain_ops	ops;
+	struct msi_domain_info	info;
+};
+
+static const struct ims_array_domain_template ims_array_domain_template = {
+	.ops = {
+		.msi_alloc_store	= ims_array_alloc_msi_store,
+		.msi_free_store		= ims_array_free_msi_store,
+	},
+	.info = {
+		.flags		= MSI_FLAG_USE_DEF_DOM_OPS |
+				  MSI_FLAG_USE_DEF_CHIP_OPS,
+		.handler	= handle_edge_irq,
+		.handler_name	= "edge",
+	},
+};
+
+struct irq_domain *
+pci_ims_array_create_msi_irq_domain(struct pci_dev *pdev,
+				    struct ims_array_info *ims_info)
+{
+	struct ims_domain_template *info;
+	struct ims_array_data *data;
+	struct irq_domain *domain;
+	struct irq_chip *chip;
+	unsigned int size;
+
+	/* Allocate new domain storage */
+	info = kmemdup(&ims_array_domain_template,
+		       sizeof(ims_array_domain_template), GFP_KERNEL);
+	if (!info)
+		return NULL;
+	/* Link the ops */
+	info->info.ops = &info->ops;
+
+	/* Allocate ims_info along with the bitmap */
+	size = sizeof(*data);
+	size += BITS_TO_LONGS(ims_info->max_slots) * sizeof(unsigned long);
+	data = kzalloc(size, GFP_KERNEL);
+	if (!data)
+		goto err_info;
+
+	data->info = *ims_info;
+	info->info.data = data;
+
+	/*
+	 * Allocate an interrupt chip because the core needs to be able to
+	 * update it with default callbacks.
+	 */
+	chip = kmemdup(&ims_array_msi_controller,
+		       sizeof(ims_array_msi_controller), GFP_KERNEL);
+	if (!chip)
+		goto err_data;
+	info->info.chip = chip;
+
+	domain = pci_subdevice_msi_create_irq_domain(pdev, &info->info);
+	if (!domain)
+		goto err_chip;
+
+	return domain;
+
+err_chip:
+	kfree(chip);
+err_data:
+	kfree(data);
+err_info:
+	kfree(info);
+	return NULL;
+}
+EXPORT_SYMBOL_GPL(pci_ims_array_create_msi_irq_domain);
+
+#endif /* CONFIG_IMS_ARRAY */
+
+#ifdef CONFIG_IMS_QUEUE
+
+static void ims_queue_mask_irq(struct irq_data *data)
+{
+	struct msi_desc *desc = irq_data_get_msi_desc(data);
+	struct ims_slot *slot = desc->device_msi.priv;
+
+	slot->ctrl &= ~IMS_VECTOR_CTRL_UNMASK;
+}
+
+static void ims_queue_unmask_irq(struct irq_data *data)
+{
+	struct msi_desc *desc = irq_data_get_msi_desc(data);
+	struct ims_slot *slot = desc->device_msi.priv;
+
+	slot->ctrl |= IMS_VECTOR_CTRL_UNMASK;
+}
+
+static void ims_queue_write_msi_msg(struct irq_data *data, struct msi_msg *msg)
+{
+	struct msi_desc *desc = irq_data_get_msi_desc(data);
+	struct ims_slot *slot = desc->device_msi.priv;
+
+	slot->address_lo = msg->address_lo;
+	slot->address_hi = msg->address_hi;
+	slot->data = msg->data;
+}
+
+static void ims_queue_lock(struct irq_data *data)
+{
+	struct ims_queue_info *ims = irq_data_get_chip_data(data);
+	struct msi_desc *desc = irq_data_get_msi_desc(data);
+
+	ims->queue_lock(desc->device_msi.priv);
+}
+
+static void ims_queue_sync_unlock(struct irq_data *data)
+{
+	struct ims_queue_info *ims = irq_data_get_chip_data(data);
+	struct msi_desc *desc = irq_data_get_msi_desc(data);
+
+	ims->queue_sync_unlock(desc->device_msi.priv);
+}
+
+static const struct irq_chip ims_queue_msi_controller = {
+	.name			= "IMS",
+	.irq_mask		= ims_queue_mask_irq,
+	.irq_unmask		= ims_queue_unmask_irq,
+	.irq_disable		= ims_queue_mask_irq,
+	.irq_enable		= ims_queue_unmask_irq,
+	.irq_write_msi_msg	= ims_queue_write_msi_msg,
+	.irq_retrigger		= irq_chip_retrigger_hierarchy,
+	.irq_bus_lock		= ims_queue_lock,
+	.irq_bus_sync_unlock	= ims_queue_sync_unlock,
+	.flags			= IRQCHIP_SKIP_SET_WAKE,
+};
+
+static void ims_queue_reset_slot(struct ims_slot *slot)
+{
+	memset(slot, 0, sizeof(*slot));
+}
+
+static void ims_queue_free_msi_store(struct irq_domain *domain, struct device *dev)
+{
+	struct msi_domain_info *info = domain->host_data;
+	struct ims_queue_info *ims = info->chip_data;
+	struct msi_desc *entry;
+
+	for_each_msi_entry(entry, dev) {
+		if (entry->device_msi.priv) {
+			ims_queue_reset_slot(entry->device_msi.priv);
+			entry->device_msi.priv = NULL;
+			entry->device_msi.hwirq = 0;
+		}
+	}
+}
+
+static int ims_queue_alloc_msi_store(struct irq_domain *domain,
+				     struct device *dev,
+				     int nvec)
+{
+	struct msi_domain_info *info = domain->host_data;
+	struct ims_queue_info *ims = info->chip_data;
+	struct msi_desc *entry;
+	struct ims_slot *slot;
+	int idx = 0;
+
+	for_each_msi_entry(entry, dev) {
+		slot = ims->queue_get_shadow(dev, idx);
+		if (!slot)
+			goto fail;
+		entry->device_msi.priv = slot;
+		entry->device_msi.hwirq = (dev->id << 16) | idx;
+		idx++;
+	}
+	return 0;
+
+fail:
+	ims_queue_free_msi_store(domain, dev);
+	return -ENOSPC;
+}
+
+struct ims_domain_template {
+	struct msi_domain_ops	ops;
+	struct msi_domain_info	info;
+};
+
+static const struct ims_queue_domain_template ims_queue_domain_template = {
+	.ops = {
+		.msi_alloc_store	= ims_queue_alloc_msi_store,
+		.msi_free_store		= ims_queue_free_msi_store,
+	},
+	.info = {
+		.flags		= MSI_FLAG_USE_DEF_DOM_OPS |
+				  MSI_FLAG_USE_DEF_CHIP_OPS,
+		.handler	= handle_edge_irq,
+		.handler_name	= "edge",
+	},
+};
+
+struct irq_domain *
+pci_ims_queue_create_msi_irq_domain(struct pci_dev *pdev,
+				    struct ims_queue_info *ims_info)
+{
+	struct ims_domain_template *info;
+	struct irq_domain *domain;
+	struct irq_chip *chip;
+	unsigned int size;
+
+	/* Allocate new domain storage */
+	info = kmemdup(&ims_queue_domain_template,
+			  sizeof(ims_queue_domain_template), GFP_KERNEL);
+	if (!info)
+		return NULL;
+	/* Link the ops */
+	info->info.ops = &info->ops;
+
+	info->info.chip_data = ims_info;
+
+	/*
+	 * Allocate an interrupt chip because the core needs to be able to
+	 * update it with default callbacks.
+	 */
+	chip = kmemdup(&ims_queue_msi_controller,
+		       sizeof(ims_queue_msi_controller), GFP_KERNEL);
+	if (!chip)
+		goto err_info;
+	info->info.chip = chip;
+
+	domain = pci_subdevice_msi_create_irq_domain(pdev, &info->info);
+	if (!domain)
+		goto err_chip;
+
+	return domain;
+
+err_chip:
+	kfree(chip);
+err_info:
+	kfree(info);
+	return NULL;
+}
+EXPORT_SYMBOL_GPL(pci_ims_queue_create_msi_irq_domain);
+
+#endif /* CONFIG_IMS_ARRAY */
--- /dev/null
+++ b/include/linux/irqchip/irq-ims-msi.h
@@ -0,0 +1,95 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* (C) Copyright 2020 Thomas Gleixner <tglx@linutronix.de> */
+
+#ifndef _LINUX_IRQCHIP_IRQ_IMS_MSI_H
+#define _LINUX_IRQCHIP_IRQ_IMS_MSI_H
+
+#include <linux/types.h>
+
+/**
+ * ims_hw_slot - The hardware layout of an IMS based MSI message
+ * @address_lo:	Lower 32bit address
+ * @address_hi:	Upper 32bit address
+ * @data:	Message data
+ * @ctrl:	Control word
+ *
+ * This structure is used by both the device memory array and the queue
+ * memory variants of IMS.
+ */
+struct ims_slot {
+	u32	address_lo;
+	u32	address_hi;
+	u32	data;
+	u32	ctrl;
+} __packed;
+
+/* Bit to unmask the interrupt in ims_hw_slot::ctrl */
+#define IMS_VECTOR_CTRL_UNMASK	0x01
+
+/**
+ * struct ims_array_info - Information to create an IMS array domain
+ * @slots:	Pointer to the start of the array
+ * @max_slots:	Maximum number of slots in the array
+ */
+struct ims_array_info {
+	struct ims_slot		__iomem *slots;
+	unsigned int		max_slots;
+};
+
+/**
+ * ims_queue_info - Information to create an IMS queue domain
+ * @queue_lock:		Callback which informs the device driver that
+ *			an interrupt management operation starts.
+ * @queue_sync_unlock:	Callback which informs the device driver that an
+ *			interrupt management operation ends.
+
+ * @queue_get_shadow:   Callback to retrieve te shadow storage for a MSI
+ *			entry associated to a queue. The queue is
+ *			identified by the device struct which is used for
+ *			allocating interrupts and the msi entry index.
+ *
+ * @queue_lock() and @queue_sync_unlock() are only called for management
+ * operations on a particular interrupt: request, free, enable, disable,
+ * affinity setting.  These functions are never called from atomic context,
+ * like low level interrupt handling code. The purpose of these functions
+ * is to signal the device driver the start and end of an operation which
+ * affects the IMS queue shadow state. @queue_lock() allows the driver to
+ * do preperatory work, e.g. locking. Note, that @queue_lock() has to
+ * preserve the sleepable state on return. That means the driver cannot
+ * disable preemption and (soft)interrupts in @queue_lock and then undo
+ * that operation in @queue_sync_unlock() which restricts the lock types
+ * for eventual serialization of these operations to sleepable locks. Of
+ * course the driver can disable preemption and (soft)interrupts
+ * temporarily for internal work.
+ *
+ * On @queue_sync_unlock() the driver has to check whether the shadow state
+ * changed and issue a command to update the hardware state and wait for
+ * the command to complete. If the command fails or times out then the
+ * driver has to take care of the resulting mess as this is called from
+ * functions which have no return value and none of the callers can deal
+ * with the failure. The lock which is used by the driver to protect a
+ * operation sequence must obviously not be released before the command
+ * completes or fails. Otherwise new operations on the same interrupt line
+ * could take place and change the shadow state before the driver was able
+ * to compose the command.
+ *
+ * The serialization is not provided by the common interrupt chip and also
+ * not by the core code to let the driver decide about the granularity of
+ * the locking and the lock type.
+ */
+struct ims_queue_info {
+	void		(*queue_lock)(struct ims_slot *shadow);
+	void		(*queue_sync_unlock)(struct ims_slot *shadow);
+	struct ims_slot	*(*queue_get_shadow)(struct device *dev, unsigned int msi_index);
+};
+
+struct pci_dev;
+struct irq_domain;
+
+struct irq_domain *pci_ims_array_create_msi_irq_domain(struct pci_dev *pdev,
+						       struct ims_array_info *ims_info);
+
+struct irq_domain *pci_ims_queue_create_msi_irq_domain(struct pci_dev *pdev,
+						       struct ims_queue_info *ims_info);
+
+#endif

