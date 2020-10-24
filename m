Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7914297EFA
	for <lists+linux-hyperv@lfdr.de>; Sat, 24 Oct 2020 23:36:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1764836AbgJXVgY (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sat, 24 Oct 2020 17:36:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1764747AbgJXVfx (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 24 Oct 2020 17:35:53 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CA09C0613A5;
        Sat, 24 Oct 2020 14:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=65EqOIAei8UNtoCihXT6EwVwA/KCxAd2clo88kBuGxI=; b=VgPDO8FWx821f1Wut/TvJI3OT/
        3M/kPBD5FR3Sl/rcZ+2fHIETtIhaJaz6fHNKjWln2uPvEpZ9LExkZNQdEMSZQAPi/PnmTLBEs93hH
        HkBDmHutd+85DAv8kNJ8Odz+LA8dGQuIQAOreXNE1sxFdsCemI9GmVNhIRRiPKJyY6unPjkjEJWOG
        5BbXi89MpRrPZR7ffhGxqNiHLnGUS+bTIVs9xR1JXfFChm26KGPwbT0eWK8do5Qbqgs6svnFuno2n
        UkZO6qTvztXDSPbJUptf9MweAxXxF6cXAi/z/sFF0433t5wdj8Ze2nD1Qz3PfdAeuKilsdy853GRh
        oTsroTSw==;
Received: from i7.infradead.org ([2001:8b0:10b:1:21e:67ff:fecb:7a92])
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kWRCS-0006HF-IL; Sat, 24 Oct 2020 21:35:47 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.93 #3 (Red Hat Linux))
        id 1kWRCN-001rOs-49; Sat, 24 Oct 2020 22:35:39 +0100
From:   David Woodhouse <dwmw2@infradead.org>
To:     x86@kernel.org
Cc:     kvm <kvm@vger.kernel.org>, iommu@lists.linux-foundation.org,
        joro@8bytes.org, Thomas Gleixner <tglx@linutronix.de>,
        Paolo Bonzini <pbonzini@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-hyperv@vger.kernel.org, maz@misterjones.org,
        Dexuan Cui <decui@microsoft.com>
Subject: [PATCH v3 20/35] x86/ioapic: Cleanup IO/APIC route entry structs
Date:   Sat, 24 Oct 2020 22:35:20 +0100
Message-Id: <20201024213535.443185-21-dwmw2@infradead.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201024213535.443185-1-dwmw2@infradead.org>
References: <e6601ff691afb3266e365a91e8b221179daf22c2.camel@infradead.org>
 <20201024213535.443185-1-dwmw2@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: David Woodhouse <dwmw2@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

Having two seperate structs for the I/O-APIC RTE entries (non-remapped and
DMAR remapped) requires type casts and makes it hard to map.

Combine them in IO_APIC_routing_entry by defining a union of two 64bit
bitfields. Use naming which reflects which bits are shared and which bits
are actually different for the operating modes.

[dwmw2: Fix it up and finish the job, pulling the 32-bit w1,w2 words for
        register access into the same union and eliminating a few more
        places where bits were accessed through masks and shifts.]

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/include/asm/io_apic.h      |  78 ++++++---------
 arch/x86/kernel/apic/io_apic.c      | 144 +++++++++++++---------------
 drivers/iommu/amd/iommu.c           |   8 +-
 drivers/iommu/hyperv-iommu.c        |   4 +-
 drivers/iommu/intel/irq_remapping.c |  19 ++--
 5 files changed, 108 insertions(+), 145 deletions(-)

diff --git a/arch/x86/include/asm/io_apic.h b/arch/x86/include/asm/io_apic.h
index a1a26f6d3aa4..73da644b2f0d 100644
--- a/arch/x86/include/asm/io_apic.h
+++ b/arch/x86/include/asm/io_apic.h
@@ -13,15 +13,6 @@
  * Copyright (C) 1997, 1998, 1999, 2000 Ingo Molnar
  */
 
-/* I/O Unit Redirection Table */
-#define IO_APIC_REDIR_VECTOR_MASK	0x000FF
-#define IO_APIC_REDIR_DEST_LOGICAL	0x00800
-#define IO_APIC_REDIR_DEST_PHYSICAL	0x00000
-#define IO_APIC_REDIR_SEND_PENDING	(1 << 12)
-#define IO_APIC_REDIR_REMOTE_IRR	(1 << 14)
-#define IO_APIC_REDIR_LEVEL_TRIGGER	(1 << 15)
-#define IO_APIC_REDIR_MASKED		(1 << 16)
-
 /*
  * The structure of the IO-APIC:
  */
@@ -65,52 +56,39 @@ union IO_APIC_reg_03 {
 };
 
 struct IO_APIC_route_entry {
-	__u32	vector		:  8,
-		delivery_mode	:  3,	/* 000: FIXED
-					 * 001: lowest prio
-					 * 111: ExtINT
-					 */
-		dest_mode	:  1,	/* 0: physical, 1: logical */
-		delivery_status	:  1,
-		polarity	:  1,
-		irr		:  1,
-		trigger		:  1,	/* 0: edge, 1: level */
-		mask		:  1,	/* 0: enabled, 1: disabled */
-		__reserved_2	: 15;
-
-	__u32	__reserved_3	: 24,
-		dest		:  8;
-} __attribute__ ((packed));
-
-struct IR_IO_APIC_route_entry {
-	__u64	vector		: 8,
-		zero		: 3,
-		index2		: 1,
-		delivery_status : 1,
-		polarity	: 1,
-		irr		: 1,
-		trigger		: 1,
-		mask		: 1,
-		reserved	: 31,
-		format		: 1,
-		index		: 15;
+	union {
+		struct {
+			u64	vector			:  8,
+				delivery_mode		:  3,
+				dest_mode_logical	:  1,
+				delivery_status		:  1,
+				active_low		:  1,
+				irr			:  1,
+				is_level		:  1,
+				masked			:  1,
+				reserved_0		: 15,
+				reserved_1		: 24,
+				destid_0_7		:  8;
+		};
+		struct {
+			u64	ir_shared_0		:  8,
+				ir_zero			:  3,
+				ir_index_15		:  1,
+				ir_shared_1		:  5,
+				ir_reserved_0		: 31,
+				ir_format		:  1,
+				ir_index_0_14		: 15;
+		};
+		struct {
+			u64	w1			: 32,
+				w2			: 32;
+		};
+	};
 } __attribute__ ((packed));
 
 struct irq_alloc_info;
 struct ioapic_domain_cfg;
 
-#define IOAPIC_EDGE			0
-#define IOAPIC_LEVEL			1
-
-#define IOAPIC_MASKED			1
-#define IOAPIC_UNMASKED			0
-
-#define IOAPIC_POL_HIGH			0
-#define IOAPIC_POL_LOW			1
-
-#define IOAPIC_DEST_MODE_PHYSICAL	0
-#define IOAPIC_DEST_MODE_LOGICAL	1
-
 #define	IOAPIC_MAP_ALLOC		0x1
 #define	IOAPIC_MAP_CHECK		0x2
 
diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
index 24a7bba7cbf4..07e754131854 100644
--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -286,31 +286,26 @@ static void io_apic_write(unsigned int apic, unsigned int reg,
 	writel(value, &io_apic->data);
 }
 
-union entry_union {
-	struct { u32 w1, w2; };
-	struct IO_APIC_route_entry entry;
-};
-
 static struct IO_APIC_route_entry __ioapic_read_entry(int apic, int pin)
 {
-	union entry_union eu;
+	struct IO_APIC_route_entry entry;
 
-	eu.w1 = io_apic_read(apic, 0x10 + 2 * pin);
-	eu.w2 = io_apic_read(apic, 0x11 + 2 * pin);
+	entry.w1 = io_apic_read(apic, 0x10 + 2 * pin);
+	entry.w2 = io_apic_read(apic, 0x11 + 2 * pin);
 
-	return eu.entry;
+	return entry;
 }
 
 static struct IO_APIC_route_entry ioapic_read_entry(int apic, int pin)
 {
-	union entry_union eu;
+	struct IO_APIC_route_entry entry;
 	unsigned long flags;
 
 	raw_spin_lock_irqsave(&ioapic_lock, flags);
-	eu.entry = __ioapic_read_entry(apic, pin);
+	entry = __ioapic_read_entry(apic, pin);
 	raw_spin_unlock_irqrestore(&ioapic_lock, flags);
 
-	return eu.entry;
+	return entry;
 }
 
 /*
@@ -321,11 +316,8 @@ static struct IO_APIC_route_entry ioapic_read_entry(int apic, int pin)
  */
 static void __ioapic_write_entry(int apic, int pin, struct IO_APIC_route_entry e)
 {
-	union entry_union eu = {{0, 0}};
-
-	eu.entry = e;
-	io_apic_write(apic, 0x11 + 2*pin, eu.w2);
-	io_apic_write(apic, 0x10 + 2*pin, eu.w1);
+	io_apic_write(apic, 0x11 + 2*pin, e.w2);
+	io_apic_write(apic, 0x10 + 2*pin, e.w1);
 }
 
 static void ioapic_write_entry(int apic, int pin, struct IO_APIC_route_entry e)
@@ -344,12 +336,12 @@ static void ioapic_write_entry(int apic, int pin, struct IO_APIC_route_entry e)
  */
 static void ioapic_mask_entry(int apic, int pin)
 {
+	struct IO_APIC_route_entry e = { .masked = true };
 	unsigned long flags;
-	union entry_union eu = { .entry.mask = IOAPIC_MASKED };
 
 	raw_spin_lock_irqsave(&ioapic_lock, flags);
-	io_apic_write(apic, 0x10 + 2*pin, eu.w1);
-	io_apic_write(apic, 0x11 + 2*pin, eu.w2);
+	io_apic_write(apic, 0x10 + 2*pin, e.w1);
+	io_apic_write(apic, 0x11 + 2*pin, e.w2);
 	raw_spin_unlock_irqrestore(&ioapic_lock, flags);
 }
 
@@ -422,20 +414,15 @@ static void __init replace_pin_at_irq_node(struct mp_chip_data *data, int node,
 	add_pin_to_irq_node(data, node, newapic, newpin);
 }
 
-static void io_apic_modify_irq(struct mp_chip_data *data,
-			       int mask_and, int mask_or,
+static void io_apic_modify_irq(struct mp_chip_data *data, bool masked,
 			       void (*final)(struct irq_pin_list *entry))
 {
-	union entry_union eu;
 	struct irq_pin_list *entry;
 
-	eu.entry = data->entry;
-	eu.w1 &= mask_and;
-	eu.w1 |= mask_or;
-	data->entry = eu.entry;
+	data->entry.masked = masked;
 
 	for_each_irq_pin(entry, data->irq_2_pin) {
-		io_apic_write(entry->apic, 0x10 + 2 * entry->pin, eu.w1);
+		io_apic_write(entry->apic, 0x10 + 2 * entry->pin, data->entry.w1);
 		if (final)
 			final(entry);
 	}
@@ -459,13 +446,13 @@ static void mask_ioapic_irq(struct irq_data *irq_data)
 	unsigned long flags;
 
 	raw_spin_lock_irqsave(&ioapic_lock, flags);
-	io_apic_modify_irq(data, ~0, IO_APIC_REDIR_MASKED, &io_apic_sync);
+	io_apic_modify_irq(data, true, &io_apic_sync);
 	raw_spin_unlock_irqrestore(&ioapic_lock, flags);
 }
 
 static void __unmask_ioapic(struct mp_chip_data *data)
 {
-	io_apic_modify_irq(data, ~IO_APIC_REDIR_MASKED, 0, NULL);
+	io_apic_modify_irq(data, false, NULL);
 }
 
 static void unmask_ioapic_irq(struct irq_data *irq_data)
@@ -506,8 +493,8 @@ static void __eoi_ioapic_pin(int apic, int pin, int vector)
 		/*
 		 * Mask the entry and change the trigger mode to edge.
 		 */
-		entry1.mask = IOAPIC_MASKED;
-		entry1.trigger = IOAPIC_EDGE;
+		entry1.masked = true;
+		entry1.is_level = false;
 
 		__ioapic_write_entry(apic, pin, entry1);
 
@@ -542,8 +529,8 @@ static void clear_IO_APIC_pin(unsigned int apic, unsigned int pin)
 	 * Make sure the entry is masked and re-read the contents to check
 	 * if it is a level triggered pin and if the remote-IRR is set.
 	 */
-	if (entry.mask == IOAPIC_UNMASKED) {
-		entry.mask = IOAPIC_MASKED;
+	if (!entry.masked) {
+		entry.masked = true;
 		ioapic_write_entry(apic, pin, entry);
 		entry = ioapic_read_entry(apic, pin);
 	}
@@ -556,8 +543,8 @@ static void clear_IO_APIC_pin(unsigned int apic, unsigned int pin)
 		 * doesn't clear the remote-IRR if the trigger mode is not
 		 * set to level.
 		 */
-		if (entry.trigger == IOAPIC_EDGE) {
-			entry.trigger = IOAPIC_LEVEL;
+		if (!entry.is_level) {
+			entry.is_level = true;
 			ioapic_write_entry(apic, pin, entry);
 		}
 		raw_spin_lock_irqsave(&ioapic_lock, flags);
@@ -659,8 +646,8 @@ void mask_ioapic_entries(void)
 			struct IO_APIC_route_entry entry;
 
 			entry = ioapics[apic].saved_registers[pin];
-			if (entry.mask == IOAPIC_UNMASKED) {
-				entry.mask = IOAPIC_MASKED;
+			if (!entry.masked) {
+				entry.masked = true;
 				ioapic_write_entry(apic, pin, entry);
 			}
 		}
@@ -947,8 +934,8 @@ static bool mp_check_pin_attr(int irq, struct irq_alloc_info *info)
 	if (irq < nr_legacy_irqs() && data->count == 1) {
 		if (info->ioapic.is_level != data->is_level)
 			mp_register_handler(irq, info->ioapic.is_level);
-		data->entry.trigger = data->is_level = info->ioapic.is_level;
-		data->entry.polarity = data->active_low = info->ioapic.active_low;
+		data->entry.is_level = data->is_level = info->ioapic.is_level;
+		data->entry.active_low = data->active_low = info->ioapic.active_low;
 	}
 
 	return data->is_level == info->ioapic.is_level &&
@@ -1231,10 +1218,9 @@ void ioapic_zap_locks(void)
 
 static void io_apic_print_entries(unsigned int apic, unsigned int nr_entries)
 {
-	int i;
-	char buf[256];
 	struct IO_APIC_route_entry entry;
-	struct IR_IO_APIC_route_entry *ir_entry = (void *)&entry;
+	char buf[256];
+	int i;
 
 	printk(KERN_DEBUG "IOAPIC %d:\n", apic);
 	for (i = 0; i <= nr_entries; i++) {
@@ -1242,20 +1228,20 @@ static void io_apic_print_entries(unsigned int apic, unsigned int nr_entries)
 		snprintf(buf, sizeof(buf),
 			 " pin%02x, %s, %s, %s, V(%02X), IRR(%1d), S(%1d)",
 			 i,
-			 entry.mask == IOAPIC_MASKED ? "disabled" : "enabled ",
-			 entry.trigger == IOAPIC_LEVEL ? "level" : "edge ",
-			 entry.polarity == IOAPIC_POL_LOW ? "low " : "high",
+			 entry.masked ? "disabled" : "enabled ",
+			 entry.is_level ? "level" : "edge ",
+			 entry.active_low ? "low " : "high",
 			 entry.vector, entry.irr, entry.delivery_status);
-		if (ir_entry->format)
+		if (entry.ir_format) {
 			printk(KERN_DEBUG "%s, remapped, I(%04X),  Z(%X)\n",
-			       buf, (ir_entry->index2 << 15) | ir_entry->index,
-			       ir_entry->zero);
-		else
-			printk(KERN_DEBUG "%s, %s, D(%02X), M(%1d)\n",
 			       buf,
-			       entry.dest_mode == IOAPIC_DEST_MODE_LOGICAL ?
-			       "logical " : "physical",
-			       entry.dest, entry.delivery_mode);
+			       (entry.ir_index_15 << 15) | entry.ir_index_0_14,
+				entry.ir_zero);
+		} else {
+			printk(KERN_DEBUG "%s, %s, D(%02X), M(%1d)\n", buf,
+			       entry.dest_mode_logical ? "logical " : "physical",
+			       entry.destid_0_7, entry.delivery_mode);
+		}
 	}
 }
 
@@ -1380,8 +1366,8 @@ void __init enable_IO_APIC(void)
 		/* If the interrupt line is enabled and in ExtInt mode
 		 * I have found the pin where the i8259 is connected.
 		 */
-		if ((entry.mask == 0) &&
-		    (entry.delivery_mode == APIC_DELIVERY_MODE_EXTINT)) {
+		if (!entry.masked &&
+		    entry.delivery_mode == APIC_DELIVERY_MODE_EXTINT) {
 			ioapic_i8259.apic = apic;
 			ioapic_i8259.pin  = pin;
 			goto found_i8259;
@@ -1425,12 +1411,12 @@ void native_restore_boot_irq_mode(void)
 		struct IO_APIC_route_entry entry;
 
 		memset(&entry, 0, sizeof(entry));
-		entry.mask		= IOAPIC_UNMASKED;
-		entry.trigger		= IOAPIC_EDGE;
-		entry.polarity		= IOAPIC_POL_HIGH;
-		entry.dest_mode		= IOAPIC_DEST_MODE_PHYSICAL;
+		entry.masked		= false;
+		entry.is_level		= false;
+		entry.active_low	= false;
+		entry.dest_mode_logical	= false;
 		entry.delivery_mode	= APIC_DELIVERY_MODE_EXTINT;
-		entry.dest		= read_apic_id();
+		entry.destid_0_7	= read_apic_id();
 
 		/*
 		 * Add it to the IO-APIC irq-routing table:
@@ -1709,13 +1695,13 @@ static bool io_apic_level_ack_pending(struct mp_chip_data *data)
 
 	raw_spin_lock_irqsave(&ioapic_lock, flags);
 	for_each_irq_pin(entry, data->irq_2_pin) {
-		unsigned int reg;
+		struct IO_APIC_route_entry e;
 		int pin;
 
 		pin = entry->pin;
-		reg = io_apic_read(entry->apic, 0x10 + pin*2);
+		e.w1 = io_apic_read(entry->apic, 0x10 + pin*2);
 		/* Is the remote IRR bit set? */
-		if (reg & IO_APIC_REDIR_REMOTE_IRR) {
+		if (e.irr) {
 			raw_spin_unlock_irqrestore(&ioapic_lock, flags);
 			return true;
 		}
@@ -1874,7 +1860,7 @@ static void ioapic_configure_entry(struct irq_data *irqd)
 	 * ioapic chip to verify that.
 	 */
 	if (irqd->chip == &ioapic_chip) {
-		mpd->entry.dest = cfg->dest_apicid;
+		mpd->entry.destid_0_7 = cfg->dest_apicid;
 		mpd->entry.vector = cfg->vector;
 	}
 	for_each_irq_pin(entry, mpd->irq_2_pin)
@@ -1932,7 +1918,7 @@ static int ioapic_irq_get_chip_state(struct irq_data *irqd,
 		 * irrelevant because the IO-APIC treats them as fire and
 		 * forget.
 		 */
-		if (rentry.irr && rentry.trigger) {
+		if (rentry.irr && rentry.is_level) {
 			*state = true;
 			break;
 		}
@@ -2057,12 +2043,12 @@ static inline void __init unlock_ExtINT_logic(void)
 
 	memset(&entry1, 0, sizeof(entry1));
 
-	entry1.dest_mode = IOAPIC_DEST_MODE_PHYSICAL;
-	entry1.mask = IOAPIC_UNMASKED;
-	entry1.dest = hard_smp_processor_id();
-	entry1.delivery_mode = APIC_DELIVERY_MODE_EXTINT;
-	entry1.polarity = entry0.polarity;
-	entry1.trigger = IOAPIC_EDGE;
+	entry1.dest_mode_logical	= true;
+	entry1.masked			= false;
+	entry1.destid_0_7		= hard_smp_processor_id();
+	entry1.delivery_mode		= APIC_DELIVERY_MODE_EXTINT;
+	entry1.active_low		= entry0.active_low;
+	entry1.is_level			= false;
 	entry1.vector = 0;
 
 	ioapic_write_entry(apic, pin, entry1);
@@ -2937,17 +2923,17 @@ static void mp_setup_entry(struct irq_cfg *cfg, struct mp_chip_data *data,
 			   struct IO_APIC_route_entry *entry)
 {
 	memset(entry, 0, sizeof(*entry));
-	entry->delivery_mode = apic->delivery_mode;
-	entry->dest_mode     = apic->dest_mode_logical;
-	entry->dest	     = cfg->dest_apicid;
-	entry->vector	     = cfg->vector;
-	entry->trigger	     = data->is_level;
-	entry->polarity	     = data->active_low;
+	entry->delivery_mode	 = apic->delivery_mode;
+	entry->dest_mode_logical = apic->dest_mode_logical;
+	entry->destid_0_7	 = cfg->dest_apicid;
+	entry->vector		 = cfg->vector;
+	entry->is_level		 = data->is_level;
+	entry->active_low	 = data->active_low;
 	/*
 	 * Mask level triggered irqs. Edge triggered irqs are masked
 	 * by the irq core code in case they fire.
 	 */
-	entry->mask = data->is_level;
+	entry->masked		= data->is_level;
 }
 
 int mp_irqdomain_alloc(struct irq_domain *domain, unsigned int virq,
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index b0e5210e53b2..3d72ec7bbbf8 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -3687,11 +3687,11 @@ static void irq_remapping_prepare_irte(struct amd_ir_data *data,
 		entry = info->ioapic.entry;
 		info->ioapic.entry = NULL;
 		memset(entry, 0, sizeof(*entry));
-		entry->vector	= index;
-		entry->trigger	= info->ioapic.is_level;
-		entry->polarity	= info->ioapic.active_low;
+		entry->vector		= index;
+		entry->is_level		= info->ioapic.is_level;
+		entry->active_low	= info->ioapic.active_low;
 		/* Mask level triggered irqs. */
-		entry->mask	= info->ioapic.is_level;
+		entry->masked		= info->ioapic.is_level;
 		break;
 
 	case X86_IRQ_ALLOC_TYPE_HPET:
diff --git a/drivers/iommu/hyperv-iommu.c b/drivers/iommu/hyperv-iommu.c
index e09e2d734c57..1ab7eb918a5c 100644
--- a/drivers/iommu/hyperv-iommu.c
+++ b/drivers/iommu/hyperv-iommu.c
@@ -52,7 +52,7 @@ static int hyperv_ir_set_affinity(struct irq_data *data,
 		return ret;
 
 	entry = data->chip_data;
-	entry->dest = cfg->dest_apicid;
+	entry->destid_0_7 = cfg->dest_apicid;
 	entry->vector = cfg->vector;
 	send_cleanup_vector(cfg);
 
@@ -125,7 +125,7 @@ static int hyperv_irq_remapping_activate(struct irq_domain *domain,
 	struct irq_cfg *cfg = irqd_cfg(irq_data);
 	struct IO_APIC_route_entry *entry = irq_data->chip_data;
 
-	entry->dest = cfg->dest_apicid;
+	entry->destid_0_7 = cfg->dest_apicid;
 	entry->vector = cfg->vector;
 
 	return 0;
diff --git a/drivers/iommu/intel/irq_remapping.c b/drivers/iommu/intel/irq_remapping.c
index 54ca69333445..625bdb9f1627 100644
--- a/drivers/iommu/intel/irq_remapping.c
+++ b/drivers/iommu/intel/irq_remapping.c
@@ -1279,8 +1279,8 @@ static void intel_irq_remapping_prepare_irte(struct intel_ir_data *data,
 					     struct irq_alloc_info *info,
 					     int index, int sub_handle)
 {
-	struct IR_IO_APIC_route_entry *entry;
 	struct irte *irte = &data->irte_entry;
+	struct IO_APIC_route_entry *entry;
 
 	prepare_irte(irte, irq_cfg->vector, irq_cfg->dest_apicid);
 	switch (info->type) {
@@ -1294,22 +1294,21 @@ static void intel_irq_remapping_prepare_irte(struct intel_ir_data *data,
 			irte->avail, irte->vector, irte->dest_id,
 			irte->sid, irte->sq, irte->svt);
 
-		entry = (struct IR_IO_APIC_route_entry *)info->ioapic.entry;
+		entry = info->ioapic.entry;
 		info->ioapic.entry = NULL;
 		memset(entry, 0, sizeof(*entry));
-		entry->index2	= (index >> 15) & 0x1;
-		entry->zero	= 0;
-		entry->format	= 1;
-		entry->index	= (index & 0x7fff);
+		entry->ir_index_15	= !!(index & 0x8000);
+		entry->ir_format	= true;
+		entry->ir_index_0_14	= index & 0x7fff;
 		/*
 		 * IO-APIC RTE will be configured with virtual vector.
 		 * irq handler will do the explicit EOI to the io-apic.
 		 */
-		entry->vector	= info->ioapic.pin;
-		entry->trigger	= info->ioapic.is_level;
-		entry->polarity	= info->ioapic.active_low;
+		entry->vector		= info->ioapic.pin;
+		entry->is_level		= info->ioapic.is_level;
+		entry->active_low	= info->ioapic.active_low;
 		/* Mask level triggered irqs. */
-		entry->mask	= info->ioapic.is_level;
+		entry->masked		= info->ioapic.is_level;
 		break;
 
 	case X86_IRQ_ALLOC_TYPE_HPET:
-- 
2.26.2

