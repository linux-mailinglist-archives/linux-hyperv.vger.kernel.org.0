Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1626E297F01
	for <lists+linux-hyperv@lfdr.de>; Sat, 24 Oct 2020 23:36:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1764855AbgJXVge (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sat, 24 Oct 2020 17:36:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1764735AbgJXVfx (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 24 Oct 2020 17:35:53 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAAF6C0613DE;
        Sat, 24 Oct 2020 14:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=qsCHCzuqbKzUc8Q7JnSzQDu1Xg9LlTdgdmmLOdJmYNU=; b=j4Q4IgyEkH1lWUFhdm6C8eJMUn
        OFEaJT8blY7NObghJXoc6JCzIEYZKOGTW0ofNPWJVqpqS+DmdXluznbvRmDqPO/NTVp3EaofxjYsc
        aB29SVBgcZwa7GlyM9GPAO7BgNjA90fnI9BTsYCOP2yHbTCsWuqfR5MJojxodsO1QFYpAr27DFxLB
        lffdDptE5B0CgxZa1UHal0wibSUuDcEmwT+aoo2rtfhNXGtZUrIO5yv2BhY2WyJlugTBzfqx4Awbk
        D0RQnf+QjUebj7wLZnyFwlKN9XPvpzvhCh3rTIyA+Id0u5VDBx7rr/PyoYCPu4/yyuQQDUJ3AZvqE
        bXGyxQDA==;
Received: from i7.infradead.org ([2001:8b0:10b:1:21e:67ff:fecb:7a92])
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kWRCT-0008Bb-7b; Sat, 24 Oct 2020 21:35:45 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.93 #3 (Red Hat Linux))
        id 1kWRCN-001rOw-5P; Sat, 24 Oct 2020 22:35:39 +0100
From:   David Woodhouse <dwmw2@infradead.org>
To:     x86@kernel.org
Cc:     kvm <kvm@vger.kernel.org>, iommu@lists.linux-foundation.org,
        joro@8bytes.org, Thomas Gleixner <tglx@linutronix.de>,
        Paolo Bonzini <pbonzini@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-hyperv@vger.kernel.org, maz@misterjones.org,
        Dexuan Cui <decui@microsoft.com>
Subject: [PATCH v3 21/35] x86/ioapic: Generate RTE directly from parent irqchip's MSI message
Date:   Sat, 24 Oct 2020 22:35:21 +0100
Message-Id: <20201024213535.443185-22-dwmw2@infradead.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201024213535.443185-1-dwmw2@infradead.org>
References: <e6601ff691afb3266e365a91e8b221179daf22c2.camel@infradead.org>
 <20201024213535.443185-1-dwmw2@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: David Woodhouse <dwmw2@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by merlin.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: David Woodhouse <dwmw@amazon.co.uk>

The I/O-APIC generates an MSI cycle with address/data bits taken from its
Redirection Table Entry in some combination which used to make sense, but
now is just a bunch of bits which get passed through in some seemingly
arbitrary order.

Instead of making IRQ remapping drivers directly frob the I/OA-PIC RTE, let
them just do their job and generate an MSI message. The bit swizzling to
turn that MSI message into the I/O-APIC's RTE is the same in all cases,
since it's a function of the I/O-APIC hardware. The IRQ remappers have no
real need to get involved with that.

The only slight caveat is that the I/OAPIC is interpreting some of those
fields too, and it does want the 'vector' field to be unique to make EOI
work. The AMD IOMMU happens to put its IRTE index in the bits that the
I/O-APIC thinks are the vector field, and accommodates this requirement by
reserving the first 32 indices for the I/O-APIC.  The Intel IOMMU doesn't
actually use the bits that the I/O-APIC thinks are the vector field, so it
fills in the 'pin' value there instead.

[ tglx: Replaced the unreadably macro maze with the cleaned up RTE/msi_msg
  	bitfields and added commentry to explain the mapping magic ]

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/include/asm/hw_irq.h       |  11 ++-
 arch/x86/kernel/apic/io_apic.c      | 103 +++++++++++++++++++---------
 drivers/iommu/amd/iommu.c           |  12 ----
 drivers/iommu/hyperv-iommu.c        |  31 ---------
 drivers/iommu/intel/irq_remapping.c |  31 ++-------
 5 files changed, 83 insertions(+), 105 deletions(-)

diff --git a/arch/x86/include/asm/hw_irq.h b/arch/x86/include/asm/hw_irq.h
index 517847a94dbe..83a69f62637e 100644
--- a/arch/x86/include/asm/hw_irq.h
+++ b/arch/x86/include/asm/hw_irq.h
@@ -45,12 +45,11 @@ enum irq_alloc_type {
 };
 
 struct ioapic_alloc_info {
-	int				pin;
-	int				node;
-	u32				is_level	: 1;
-	u32				active_low	: 1;
-	u32				valid		: 1;
-	struct IO_APIC_route_entry	*entry;
+	int		pin;
+	int		node;
+	u32		is_level	: 1;
+	u32		active_low	: 1;
+	u32		valid		: 1;
 };
 
 struct uv_alloc_info {
diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
index 07e754131854..ea983da1a57f 100644
--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -48,6 +48,7 @@
 #include <linux/jiffies.h>	/* time_after() */
 #include <linux/slab.h>
 #include <linux/memblock.h>
+#include <linux/msi.h>
 
 #include <asm/irqdomain.h>
 #include <asm/io.h>
@@ -63,7 +64,6 @@
 #include <asm/setup.h>
 #include <asm/irq_remapping.h>
 #include <asm/hw_irq.h>
-
 #include <asm/apic.h>
 
 #define	for_each_ioapic(idx)		\
@@ -1848,21 +1848,58 @@ static void ioapic_ir_ack_level(struct irq_data *irq_data)
 	eoi_ioapic_pin(data->entry.vector, data);
 }
 
+/*
+ * The I/OAPIC is just a device for generating MSI messages from legacy
+ * interrupt pins. Various fields of the RTE translate into bits of the
+ * resulting MSI which had a historical meaning.
+ *
+ * With interrupt remapping, many of those bits have different meanings
+ * in the underlying MSI, but the way that the I/OAPIC transforms them
+ * from its RTE to the MSI message is the same. This function allows
+ * the parent IRQ domain to compose the MSI message, then takes the
+ * relevant bits to put them in the appropriate places in the RTE in
+ * order to generate that message when the IRQ happens.
+ *
+ * The setup here relies on a preconfigured route entry (is_level,
+ * active_low, masked) because the parent domain is merely composing the
+ * generic message routing information which is used for the MSI.
+ */
+static void ioapic_setup_msg_from_msi(struct irq_data *irq_data,
+				      struct IO_APIC_route_entry *entry)
+{
+	struct msi_msg msg;
+
+	/* Let the parent domain compose the MSI message */
+	irq_chip_compose_msi_msg(irq_data, &msg);
+
+	/*
+	 * - Real vector
+	 * - DMAR/IR: 8bit subhandle (ioapic.pin)
+	 * - AMD/IR:  8bit IRTE index
+	 */
+	entry->vector			= msg.arch_data.vector;
+	/* Delivery mode (for DMAR/IR all 0) */
+	entry->delivery_mode		= msg.arch_data.delivery_mode;
+	/* Destination mode or DMAR/IR index bit 15 */
+	entry->dest_mode_logical	= msg.arch_addr_lo.dest_mode_logical;
+	/* DMAR/IR: 1, 0 for all other modes */
+	entry->ir_format		= msg.arch_addr_lo.dmar_format;
+	/*
+	 * DMAR/IR: index bit 0-14.
+	 *
+	 * All other modes have bit 0-6 of dmar_index_0_14 cleared and the
+	 * topmost 8 bits are destination id bit 0-7 (entry::destid_0_7).
+	 */
+	entry->ir_index_0_14		= msg.arch_addr_lo.dmar_index_0_14;
+}
+
 static void ioapic_configure_entry(struct irq_data *irqd)
 {
 	struct mp_chip_data *mpd = irqd->chip_data;
-	struct irq_cfg *cfg = irqd_cfg(irqd);
 	struct irq_pin_list *entry;
 
-	/*
-	 * Only update when the parent is the vector domain, don't touch it
-	 * if the parent is the remapping domain. Check the installed
-	 * ioapic chip to verify that.
-	 */
-	if (irqd->chip == &ioapic_chip) {
-		mpd->entry.destid_0_7 = cfg->dest_apicid;
-		mpd->entry.vector = cfg->vector;
-	}
+	ioapic_setup_msg_from_msi(irqd, &mpd->entry);
+
 	for_each_irq_pin(entry, mpd->irq_2_pin)
 		__ioapic_write_entry(entry->apic, entry->pin, mpd->entry);
 }
@@ -2919,14 +2956,23 @@ static void mp_irqdomain_get_attr(u32 gsi, struct mp_chip_data *data,
 	}
 }
 
-static void mp_setup_entry(struct irq_cfg *cfg, struct mp_chip_data *data,
-			   struct IO_APIC_route_entry *entry)
+/*
+ * Configure the I/O-APIC specific fields in the routing entry.
+ *
+ * This is important to setup the I/O-APIC specific bits (is_level,
+ * active_low, masked) because the underlying parent domain will only
+ * provide the routing information and is oblivious of the I/O-APIC
+ * specific bits.
+ *
+ * The entry is just preconfigured at this point and not written into the
+ * RTE. This happens later during activation which will fill in the actual
+ * routing information.
+ */
+static void mp_preconfigure_entry(struct mp_chip_data *data)
 {
+	struct IO_APIC_route_entry *entry = &data->entry;
+
 	memset(entry, 0, sizeof(*entry));
-	entry->delivery_mode	 = apic->delivery_mode;
-	entry->dest_mode_logical = apic->dest_mode_logical;
-	entry->destid_0_7	 = cfg->dest_apicid;
-	entry->vector		 = cfg->vector;
 	entry->is_level		 = data->is_level;
 	entry->active_low	 = data->active_low;
 	/*
@@ -2939,11 +2985,10 @@ static void mp_setup_entry(struct irq_cfg *cfg, struct mp_chip_data *data,
 int mp_irqdomain_alloc(struct irq_domain *domain, unsigned int virq,
 		       unsigned int nr_irqs, void *arg)
 {
-	int ret, ioapic, pin;
-	struct irq_cfg *cfg;
-	struct irq_data *irq_data;
-	struct mp_chip_data *data;
 	struct irq_alloc_info *info = arg;
+	struct mp_chip_data *data;
+	struct irq_data *irq_data;
+	int ret, ioapic, pin;
 	unsigned long flags;
 
 	if (!info || nr_irqs > 1)
@@ -2961,7 +3006,6 @@ int mp_irqdomain_alloc(struct irq_domain *domain, unsigned int virq,
 	if (!data)
 		return -ENOMEM;
 
-	info->ioapic.entry = &data->entry;
 	ret = irq_domain_alloc_irqs_parent(domain, virq, nr_irqs, info);
 	if (ret < 0) {
 		kfree(data);
@@ -2975,23 +3019,20 @@ int mp_irqdomain_alloc(struct irq_domain *domain, unsigned int virq,
 	irq_data->chip_data = data;
 	mp_irqdomain_get_attr(mp_pin_to_gsi(ioapic, pin), data, info);
 
-	cfg = irqd_cfg(irq_data);
 	add_pin_to_irq_node(data, ioapic_alloc_attr_node(info), ioapic, pin);
 
-	local_irq_save(flags);
-	if (info->ioapic.entry)
-		mp_setup_entry(cfg, data, info->ioapic.entry);
+	mp_preconfigure_entry(data);
 	mp_register_handler(virq, data->is_level);
+
+	local_irq_save(flags);
 	if (virq < nr_legacy_irqs())
 		legacy_pic->mask(virq);
 	local_irq_restore(flags);
 
 	apic_printk(APIC_VERBOSE, KERN_DEBUG
-		    "IOAPIC[%d]: Set routing entry (%d-%d -> 0x%x -> IRQ %d Mode:%i Active:%i Dest:%d)\n",
-		    ioapic, mpc_ioapic_id(ioapic), pin, cfg->vector,
-		    virq, data->is_level, data->active_low,
-		    cfg->dest_apicid);
-
+		    "IOAPIC[%d]: Preconfigured routing entry (%d-%d -> IRQ %d Level:%i ActiveLow:%i)\n",
+		    ioapic, mpc_ioapic_id(ioapic), pin, virq,
+		    data->is_level, data->active_low);
 	return 0;
 }
 
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 3d72ec7bbbf8..9744cdbefd88 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -3669,7 +3669,6 @@ static void irq_remapping_prepare_irte(struct amd_ir_data *data,
 				       int devid, int index, int sub_handle)
 {
 	struct irq_2_irte *irte_info = &data->irq_2_irte;
-	struct IO_APIC_route_entry *entry;
 	struct amd_iommu *iommu = amd_iommu_rlookup_table[devid];
 
 	if (!iommu)
@@ -3683,17 +3682,6 @@ static void irq_remapping_prepare_irte(struct amd_ir_data *data,
 
 	switch (info->type) {
 	case X86_IRQ_ALLOC_TYPE_IOAPIC:
-		/* Setup IOAPIC entry */
-		entry = info->ioapic.entry;
-		info->ioapic.entry = NULL;
-		memset(entry, 0, sizeof(*entry));
-		entry->vector		= index;
-		entry->is_level		= info->ioapic.is_level;
-		entry->active_low	= info->ioapic.active_low;
-		/* Mask level triggered irqs. */
-		entry->masked		= info->ioapic.is_level;
-		break;
-
 	case X86_IRQ_ALLOC_TYPE_HPET:
 	case X86_IRQ_ALLOC_TYPE_PCI_MSI:
 	case X86_IRQ_ALLOC_TYPE_PCI_MSIX:
diff --git a/drivers/iommu/hyperv-iommu.c b/drivers/iommu/hyperv-iommu.c
index 1ab7eb918a5c..37dd485a5640 100644
--- a/drivers/iommu/hyperv-iommu.c
+++ b/drivers/iommu/hyperv-iommu.c
@@ -40,7 +40,6 @@ static int hyperv_ir_set_affinity(struct irq_data *data,
 {
 	struct irq_data *parent = data->parent_data;
 	struct irq_cfg *cfg = irqd_cfg(data);
-	struct IO_APIC_route_entry *entry;
 	int ret;
 
 	/* Return error If new irq affinity is out of ioapic_max_cpumask. */
@@ -51,9 +50,6 @@ static int hyperv_ir_set_affinity(struct irq_data *data,
 	if (ret < 0 || ret == IRQ_SET_MASK_OK_DONE)
 		return ret;
 
-	entry = data->chip_data;
-	entry->destid_0_7 = cfg->dest_apicid;
-	entry->vector = cfg->vector;
 	send_cleanup_vector(cfg);
 
 	return 0;
@@ -89,20 +85,6 @@ static int hyperv_irq_remapping_alloc(struct irq_domain *domain,
 
 	irq_data->chip = &hyperv_ir_chip;
 
-	/*
-	 * If there is interrupt remapping function of IOMMU, setting irq
-	 * affinity only needs to change IRTE of IOMMU. But Hyper-V doesn't
-	 * support interrupt remapping function, setting irq affinity of IO-APIC
-	 * interrupts still needs to change IO-APIC registers. But ioapic_
-	 * configure_entry() will ignore value of cfg->vector and cfg->
-	 * dest_apicid when IO-APIC's parent irq domain is not the vector
-	 * domain.(See ioapic_configure_entry()) In order to setting vector
-	 * and dest_apicid to IO-APIC register, IO-APIC entry pointer is saved
-	 * in the chip_data and hyperv_irq_remapping_activate()/hyperv_ir_set_
-	 * affinity() set vector and dest_apicid directly into IO-APIC entry.
-	 */
-	irq_data->chip_data = info->ioapic.entry;
-
 	/*
 	 * Hypver-V IO APIC irq affinity should be in the scope of
 	 * ioapic_max_cpumask because no irq remapping support.
@@ -119,22 +101,9 @@ static void hyperv_irq_remapping_free(struct irq_domain *domain,
 	irq_domain_free_irqs_common(domain, virq, nr_irqs);
 }
 
-static int hyperv_irq_remapping_activate(struct irq_domain *domain,
-			  struct irq_data *irq_data, bool reserve)
-{
-	struct irq_cfg *cfg = irqd_cfg(irq_data);
-	struct IO_APIC_route_entry *entry = irq_data->chip_data;
-
-	entry->destid_0_7 = cfg->dest_apicid;
-	entry->vector = cfg->vector;
-
-	return 0;
-}
-
 static const struct irq_domain_ops hyperv_ir_domain_ops = {
 	.alloc = hyperv_irq_remapping_alloc,
 	.free = hyperv_irq_remapping_free,
-	.activate = hyperv_irq_remapping_activate,
 };
 
 static int __init hyperv_prepare_irq_remapping(void)
diff --git a/drivers/iommu/intel/irq_remapping.c b/drivers/iommu/intel/irq_remapping.c
index 625bdb9f1627..96c84b19940e 100644
--- a/drivers/iommu/intel/irq_remapping.c
+++ b/drivers/iommu/intel/irq_remapping.c
@@ -1280,9 +1280,9 @@ static void intel_irq_remapping_prepare_irte(struct intel_ir_data *data,
 					     int index, int sub_handle)
 {
 	struct irte *irte = &data->irte_entry;
-	struct IO_APIC_route_entry *entry;
 
 	prepare_irte(irte, irq_cfg->vector, irq_cfg->dest_apicid);
+
 	switch (info->type) {
 	case X86_IRQ_ALLOC_TYPE_IOAPIC:
 		/* Set source-id of interrupt request */
@@ -1293,39 +1293,20 @@ static void intel_irq_remapping_prepare_irte(struct intel_ir_data *data,
 			irte->trigger_mode, irte->dlvry_mode,
 			irte->avail, irte->vector, irte->dest_id,
 			irte->sid, irte->sq, irte->svt);
-
-		entry = info->ioapic.entry;
-		info->ioapic.entry = NULL;
-		memset(entry, 0, sizeof(*entry));
-		entry->ir_index_15	= !!(index & 0x8000);
-		entry->ir_format	= true;
-		entry->ir_index_0_14	= index & 0x7fff;
-		/*
-		 * IO-APIC RTE will be configured with virtual vector.
-		 * irq handler will do the explicit EOI to the io-apic.
-		 */
-		entry->vector		= info->ioapic.pin;
-		entry->is_level		= info->ioapic.is_level;
-		entry->active_low	= info->ioapic.active_low;
-		/* Mask level triggered irqs. */
-		entry->masked		= info->ioapic.is_level;
+		sub_handle = info->ioapic.pin;
 		break;
-
 	case X86_IRQ_ALLOC_TYPE_HPET:
+		set_hpet_sid(irte, info->devid);
+		break;
 	case X86_IRQ_ALLOC_TYPE_PCI_MSI:
 	case X86_IRQ_ALLOC_TYPE_PCI_MSIX:
-		if (info->type == X86_IRQ_ALLOC_TYPE_HPET)
-			set_hpet_sid(irte, info->devid);
-		else
-			set_msi_sid(irte, msi_desc_to_pci_dev(info->desc));
-
-		fill_msi_msg(&data->msi_entry, index, sub_handle);
+		set_msi_sid(irte, msi_desc_to_pci_dev(info->desc));
 		break;
-
 	default:
 		BUG_ON(1);
 		break;
 	}
+	fill_msi_msg(&data->msi_entry, index, sub_handle);
 }
 
 static void intel_free_irq_resources(struct irq_domain *domain,
-- 
2.26.2

