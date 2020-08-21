Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DFA824CA95
	for <lists+linux-hyperv@lfdr.de>; Fri, 21 Aug 2020 04:20:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728140AbgHUCTs (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 20 Aug 2020 22:19:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727808AbgHUCQx (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 20 Aug 2020 22:16:53 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D26FC061385;
        Thu, 20 Aug 2020 19:16:53 -0700 (PDT)
Message-Id: <20200821002946.297823391@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1597976210;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=Si6kO+J1vEoaEWJXA2D20vb4LY9tJoOVRUcnzulF00g=;
        b=Ecc85/hW4+01eu+YGTcWSRkJH7rL71uvNLBqGIBcXyV0iDPqE1AMasaN3s4GcK1w9mBGtu
        ZBeewtjy/1fuQ9e2AsvtprDHe4EklVwkFIb2DgR5cchN73YI+dwFyB94v6qEhx3Jb7V6B+
        JWG3EZ0SBaJvsUFrtf7id2mQMxPMZQ77HhTG3JRKR1FDADKAuDja1LL/A74ESLc/mh42Q2
        AqP+1HoEndAmJgPcK1V97AEoLsqcyPwziF9Yk4N4e/zC3gUKeAD1t/FLySx5ihUPkUszvY
        9IsuDEOZ98pXHn5x9Q4K56nE8iu5cij0dIWaICCTY1Q+GlN9DbCWDLcbnyN33A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1597976210;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=Si6kO+J1vEoaEWJXA2D20vb4LY9tJoOVRUcnzulF00g=;
        b=I6boBPnH5+6FO4Pp3yBZHBps3Bvg7O2N3xa8rS2ZS0zg3XP3QEY9trSDnOpNsSV7h9V70v
        0jQLjLdks7BfahDg==
Date:   Fri, 21 Aug 2020 02:24:34 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Wei Liu <wei.liu@kernel.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Joerg Roedel <joro@8bytes.org>, linux-hyperv@vger.kernel.org,
        iommu@lists.linux-foundation.org,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Jon Derrick <jonathan.derrick@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Steve Wahl <steve.wahl@hpe.com>,
        Dimitri Sivanich <sivanich@hpe.com>,
        Russ Anderson <rja@hpe.com>, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jonathan Derrick <jonathan.derrick@intel.com>,
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
Subject: [patch RFC 10/38] x86/ioapic: Consolidate IOAPIC allocation
References: <20200821002424.119492231@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline;
 filename="x86-ioapic--Consolidate-IOAPIC-allocation.patch"
Content-transfer-encoding: 8-bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Move the IOAPIC specific fields into their own struct and reuse the common
devid. Get rid of the #ifdeffery as it does not matter at all whether the
alloc info is a couple of bytes longer or not.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Wei Liu <wei.liu@kernel.org>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: Stephen Hemminger <sthemmin@microsoft.com>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: linux-hyperv@vger.kernel.org
Cc: iommu@lists.linux-foundation.org
Cc: Haiyang Zhang <haiyangz@microsoft.com>
Cc: Jon Derrick <jonathan.derrick@intel.com>
Cc: Lu Baolu <baolu.lu@linux.intel.com>
---
 arch/x86/include/asm/hw_irq.h       |   23 ++++++-----
 arch/x86/kernel/apic/io_apic.c      |   70 ++++++++++++++++++------------------
 drivers/iommu/amd/iommu.c           |   14 +++----
 drivers/iommu/hyperv-iommu.c        |    2 -
 drivers/iommu/intel/irq_remapping.c |   18 ++++-----
 5 files changed, 64 insertions(+), 63 deletions(-)

--- a/arch/x86/include/asm/hw_irq.h
+++ b/arch/x86/include/asm/hw_irq.h
@@ -44,6 +44,15 @@ enum irq_alloc_type {
 	X86_IRQ_ALLOC_TYPE_HPET_GET_PARENT,
 };
 
+struct ioapic_alloc_info {
+	int				pin;
+	int				node;
+	u32				trigger : 1;
+	u32				polarity : 1;
+	u32				valid : 1;
+	struct IO_APIC_route_entry	*entry;
+};
+
 /**
  * irq_alloc_info - X86 specific interrupt allocation info
  * @type:	X86 specific allocation type
@@ -53,6 +62,8 @@ enum irq_alloc_type {
  * @mask:	CPU mask for vector allocation
  * @desc:	Pointer to msi descriptor
  * @data:	Allocation specific data
+ *
+ * @ioapic:	IOAPIC specific allocation data
  */
 struct irq_alloc_info {
 	enum irq_alloc_type	type;
@@ -64,6 +75,7 @@ struct irq_alloc_info {
 	void			*data;
 
 	union {
+		struct ioapic_alloc_info	ioapic;
 		int		unused;
 #ifdef	CONFIG_PCI_MSI
 		struct {
@@ -71,17 +83,6 @@ struct irq_alloc_info {
 			irq_hw_number_t	msi_hwirq;
 		};
 #endif
-#ifdef	CONFIG_X86_IO_APIC
-		struct {
-			int		ioapic_id;
-			int		ioapic_pin;
-			int		ioapic_node;
-			u32		ioapic_trigger : 1;
-			u32		ioapic_polarity : 1;
-			u32		ioapic_valid : 1;
-			struct IO_APIC_route_entry *ioapic_entry;
-		};
-#endif
 #ifdef	CONFIG_DMAR_TABLE
 		struct {
 			int		dmar_id;
--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -860,10 +860,10 @@ void ioapic_set_alloc_attr(struct irq_al
 {
 	init_irq_alloc_info(info, NULL);
 	info->type = X86_IRQ_ALLOC_TYPE_IOAPIC;
-	info->ioapic_node = node;
-	info->ioapic_trigger = trigger;
-	info->ioapic_polarity = polarity;
-	info->ioapic_valid = 1;
+	info->ioapic.node = node;
+	info->ioapic.trigger = trigger;
+	info->ioapic.polarity = polarity;
+	info->ioapic.valid = 1;
 }
 
 #ifndef CONFIG_ACPI
@@ -878,32 +878,32 @@ static void ioapic_copy_alloc_attr(struc
 
 	copy_irq_alloc_info(dst, src);
 	dst->type = X86_IRQ_ALLOC_TYPE_IOAPIC;
-	dst->ioapic_id = mpc_ioapic_id(ioapic_idx);
-	dst->ioapic_pin = pin;
-	dst->ioapic_valid = 1;
-	if (src && src->ioapic_valid) {
-		dst->ioapic_node = src->ioapic_node;
-		dst->ioapic_trigger = src->ioapic_trigger;
-		dst->ioapic_polarity = src->ioapic_polarity;
+	dst->devid = mpc_ioapic_id(ioapic_idx);
+	dst->ioapic.pin = pin;
+	dst->ioapic.valid = 1;
+	if (src && src->ioapic.valid) {
+		dst->ioapic.node = src->ioapic.node;
+		dst->ioapic.trigger = src->ioapic.trigger;
+		dst->ioapic.polarity = src->ioapic.polarity;
 	} else {
-		dst->ioapic_node = NUMA_NO_NODE;
+		dst->ioapic.node = NUMA_NO_NODE;
 		if (acpi_get_override_irq(gsi, &trigger, &polarity) >= 0) {
-			dst->ioapic_trigger = trigger;
-			dst->ioapic_polarity = polarity;
+			dst->ioapic.trigger = trigger;
+			dst->ioapic.polarity = polarity;
 		} else {
 			/*
 			 * PCI interrupts are always active low level
 			 * triggered.
 			 */
-			dst->ioapic_trigger = IOAPIC_LEVEL;
-			dst->ioapic_polarity = IOAPIC_POL_LOW;
+			dst->ioapic.trigger = IOAPIC_LEVEL;
+			dst->ioapic.polarity = IOAPIC_POL_LOW;
 		}
 	}
 }
 
 static int ioapic_alloc_attr_node(struct irq_alloc_info *info)
 {
-	return (info && info->ioapic_valid) ? info->ioapic_node : NUMA_NO_NODE;
+	return (info && info->ioapic.valid) ? info->ioapic.node : NUMA_NO_NODE;
 }
 
 static void mp_register_handler(unsigned int irq, unsigned long trigger)
@@ -933,14 +933,14 @@ static bool mp_check_pin_attr(int irq, s
 	 * pin with real trigger and polarity attributes.
 	 */
 	if (irq < nr_legacy_irqs() && data->count == 1) {
-		if (info->ioapic_trigger != data->trigger)
-			mp_register_handler(irq, info->ioapic_trigger);
-		data->entry.trigger = data->trigger = info->ioapic_trigger;
-		data->entry.polarity = data->polarity = info->ioapic_polarity;
+		if (info->ioapic.trigger != data->trigger)
+			mp_register_handler(irq, info->ioapic.trigger);
+		data->entry.trigger = data->trigger = info->ioapic.trigger;
+		data->entry.polarity = data->polarity = info->ioapic.polarity;
 	}
 
-	return data->trigger == info->ioapic_trigger &&
-	       data->polarity == info->ioapic_polarity;
+	return data->trigger == info->ioapic.trigger &&
+	       data->polarity == info->ioapic.polarity;
 }
 
 static int alloc_irq_from_domain(struct irq_domain *domain, int ioapic, u32 gsi,
@@ -1002,7 +1002,7 @@ static int alloc_isa_irq_from_domain(str
 		if (!mp_check_pin_attr(irq, info))
 			return -EBUSY;
 		if (__add_pin_to_irq_node(irq_data->chip_data, node, ioapic,
-					  info->ioapic_pin))
+					  info->ioapic.pin))
 			return -ENOMEM;
 	} else {
 		info->flags |= X86_IRQ_ALLOC_LEGACY;
@@ -2092,8 +2092,8 @@ static int mp_alloc_timer_irq(int ioapic
 		struct irq_alloc_info info;
 
 		ioapic_set_alloc_attr(&info, NUMA_NO_NODE, 0, 0);
-		info.ioapic_id = mpc_ioapic_id(ioapic);
-		info.ioapic_pin = pin;
+		info.devid = mpc_ioapic_id(ioapic);
+		info.ioapic.pin = pin;
 		mutex_lock(&ioapic_mutex);
 		irq = alloc_isa_irq_from_domain(domain, 0, ioapic, pin, &info);
 		mutex_unlock(&ioapic_mutex);
@@ -2297,7 +2297,7 @@ static int mp_irqdomain_create(int ioapi
 
 	init_irq_alloc_info(&info, NULL);
 	info.type = X86_IRQ_ALLOC_TYPE_IOAPIC_GET_PARENT;
-	info.ioapic_id = mpc_ioapic_id(ioapic);
+	info.devid = mpc_ioapic_id(ioapic);
 	parent = irq_remapping_get_irq_domain(&info);
 	if (!parent)
 		parent = x86_vector_domain;
@@ -2932,9 +2932,9 @@ int mp_ioapic_registered(u32 gsi_base)
 static void mp_irqdomain_get_attr(u32 gsi, struct mp_chip_data *data,
 				  struct irq_alloc_info *info)
 {
-	if (info && info->ioapic_valid) {
-		data->trigger = info->ioapic_trigger;
-		data->polarity = info->ioapic_polarity;
+	if (info && info->ioapic.valid) {
+		data->trigger = info->ioapic.trigger;
+		data->polarity = info->ioapic.polarity;
 	} else if (acpi_get_override_irq(gsi, &data->trigger,
 					 &data->polarity) < 0) {
 		/* PCI interrupts are always active low level triggered. */
@@ -2980,7 +2980,7 @@ int mp_irqdomain_alloc(struct irq_domain
 		return -EINVAL;
 
 	ioapic = mp_irqdomain_ioapic_idx(domain);
-	pin = info->ioapic_pin;
+	pin = info->ioapic.pin;
 	if (irq_find_mapping(domain, (irq_hw_number_t)pin) > 0)
 		return -EEXIST;
 
@@ -2988,7 +2988,7 @@ int mp_irqdomain_alloc(struct irq_domain
 	if (!data)
 		return -ENOMEM;
 
-	info->ioapic_entry = &data->entry;
+	info->ioapic.entry = &data->entry;
 	ret = irq_domain_alloc_irqs_parent(domain, virq, nr_irqs, info);
 	if (ret < 0) {
 		kfree(data);
@@ -2996,7 +2996,7 @@ int mp_irqdomain_alloc(struct irq_domain
 	}
 
 	INIT_LIST_HEAD(&data->irq_2_pin);
-	irq_data->hwirq = info->ioapic_pin;
+	irq_data->hwirq = info->ioapic.pin;
 	irq_data->chip = (domain->parent == x86_vector_domain) ?
 			  &ioapic_chip : &ioapic_ir_chip;
 	irq_data->chip_data = data;
@@ -3006,8 +3006,8 @@ int mp_irqdomain_alloc(struct irq_domain
 	add_pin_to_irq_node(data, ioapic_alloc_attr_node(info), ioapic, pin);
 
 	local_irq_save(flags);
-	if (info->ioapic_entry)
-		mp_setup_entry(cfg, data, info->ioapic_entry);
+	if (info->ioapic.entry)
+		mp_setup_entry(cfg, data, info->ioapic.entry);
 	mp_register_handler(virq, data->trigger);
 	if (virq < nr_legacy_irqs())
 		legacy_pic->mask(virq);
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -3508,7 +3508,7 @@ static int get_devid(struct irq_alloc_in
 	switch (info->type) {
 	case X86_IRQ_ALLOC_TYPE_IOAPIC:
 	case X86_IRQ_ALLOC_TYPE_IOAPIC_GET_PARENT:
-		return get_ioapic_devid(info->ioapic_id);
+		return get_ioapic_devid(info->devid);
 	case X86_IRQ_ALLOC_TYPE_HPET:
 	case X86_IRQ_ALLOC_TYPE_HPET_GET_PARENT:
 		return get_hpet_devid(info->devid);
@@ -3586,15 +3586,15 @@ static void irq_remapping_prepare_irte(s
 	switch (info->type) {
 	case X86_IRQ_ALLOC_TYPE_IOAPIC:
 		/* Setup IOAPIC entry */
-		entry = info->ioapic_entry;
-		info->ioapic_entry = NULL;
+		entry = info->ioapic.entry;
+		info->ioapic.entry = NULL;
 		memset(entry, 0, sizeof(*entry));
 		entry->vector        = index;
 		entry->mask          = 0;
-		entry->trigger       = info->ioapic_trigger;
-		entry->polarity      = info->ioapic_polarity;
+		entry->trigger       = info->ioapic.trigger;
+		entry->polarity      = info->ioapic.polarity;
 		/* Mask level triggered irqs. */
-		if (info->ioapic_trigger)
+		if (info->ioapic.trigger)
 			entry->mask = 1;
 		break;
 
@@ -3680,7 +3680,7 @@ static int irq_remapping_alloc(struct ir
 					iommu->irte_ops->set_allocated(table, i);
 			}
 			WARN_ON(table->min_index != 32);
-			index = info->ioapic_pin;
+			index = info->ioapic.pin;
 		} else {
 			index = -ENOMEM;
 		}
--- a/drivers/iommu/hyperv-iommu.c
+++ b/drivers/iommu/hyperv-iommu.c
@@ -101,7 +101,7 @@ static int hyperv_irq_remapping_alloc(st
 	 * in the chip_data and hyperv_irq_remapping_activate()/hyperv_ir_set_
 	 * affinity() set vector and dest_apicid directly into IO-APIC entry.
 	 */
-	irq_data->chip_data = info->ioapic_entry;
+	irq_data->chip_data = info->ioapic.entry;
 
 	/*
 	 * Hypver-V IO APIC irq affinity should be in the scope of
--- a/drivers/iommu/intel/irq_remapping.c
+++ b/drivers/iommu/intel/irq_remapping.c
@@ -1113,7 +1113,7 @@ static struct irq_domain *intel_get_irq_
 
 	switch (info->type) {
 	case X86_IRQ_ALLOC_TYPE_IOAPIC_GET_PARENT:
-		return map_ioapic_to_ir(info->ioapic_id);
+		return map_ioapic_to_ir(info->devid);
 	case X86_IRQ_ALLOC_TYPE_HPET_GET_PARENT:
 		return map_hpet_to_ir(info->devid);
 	case X86_IRQ_ALLOC_TYPE_PCI_MSI:
@@ -1254,16 +1254,16 @@ static void intel_irq_remapping_prepare_
 	switch (info->type) {
 	case X86_IRQ_ALLOC_TYPE_IOAPIC:
 		/* Set source-id of interrupt request */
-		set_ioapic_sid(irte, info->ioapic_id);
+		set_ioapic_sid(irte, info->devid);
 		apic_printk(APIC_VERBOSE, KERN_DEBUG "IOAPIC[%d]: Set IRTE entry (P:%d FPD:%d Dst_Mode:%d Redir_hint:%d Trig_Mode:%d Dlvry_Mode:%X Avail:%X Vector:%02X Dest:%08X SID:%04X SQ:%X SVT:%X)\n",
-			info->ioapic_id, irte->present, irte->fpd,
+			info->devid, irte->present, irte->fpd,
 			irte->dst_mode, irte->redir_hint,
 			irte->trigger_mode, irte->dlvry_mode,
 			irte->avail, irte->vector, irte->dest_id,
 			irte->sid, irte->sq, irte->svt);
 
-		entry = (struct IR_IO_APIC_route_entry *)info->ioapic_entry;
-		info->ioapic_entry = NULL;
+		entry = (struct IR_IO_APIC_route_entry *)info->ioapic.entry;
+		info->ioapic.entry = NULL;
 		memset(entry, 0, sizeof(*entry));
 		entry->index2	= (index >> 15) & 0x1;
 		entry->zero	= 0;
@@ -1273,11 +1273,11 @@ static void intel_irq_remapping_prepare_
 		 * IO-APIC RTE will be configured with virtual vector.
 		 * irq handler will do the explicit EOI to the io-apic.
 		 */
-		entry->vector	= info->ioapic_pin;
+		entry->vector	= info->ioapic.pin;
 		entry->mask	= 0;			/* enable IRQ */
-		entry->trigger	= info->ioapic_trigger;
-		entry->polarity	= info->ioapic_polarity;
-		if (info->ioapic_trigger)
+		entry->trigger	= info->ioapic.trigger;
+		entry->polarity	= info->ioapic.polarity;
+		if (info->ioapic.trigger)
 			entry->mask = 1; /* Mask level triggered irqs. */
 		break;
 

