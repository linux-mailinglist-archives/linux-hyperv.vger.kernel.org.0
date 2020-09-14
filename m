Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22CD32692CC
	for <lists+linux-hyperv@lfdr.de>; Mon, 14 Sep 2020 19:16:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726119AbgINRPr (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 14 Sep 2020 13:15:47 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52884 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726211AbgINMbl (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 14 Sep 2020 08:31:41 -0400
Received: by mail-wm1-f66.google.com with SMTP id q9so10451115wmj.2;
        Mon, 14 Sep 2020 05:31:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NLfOZS+nMENh6nQLNeweD6rASsg7WB8GWbnu3z1jUFI=;
        b=Icjaua53T2NsVqO36bVuTlq9XEhHffVW1jJXXM806A2YISeHJRnDTQPpcQxm7X72ks
         6Mt6JHsJZmcOvygDn1YpbFZI57bIHm0EpRutyM/d0/4/RCZe20wPlAnGuP2KdVci60C3
         eAx0lEZ84UovhSQal23skzXspjY4/G0T8vOPc2TXpwZY8S6MvDTVUe982DRDWj7tGnhc
         eepUFhPezwZKLE8oc2LHl6WHMcgMbKZcjaczh3VtkIPNBvwR4SPkfaFh/so7NdpiXwUR
         7uVKZuut1W8nyrI2oAK8DZTX+zEuwj0R0uMhClkQmupyCP0DD9bkzxR7XJioTb+KqEtx
         eBxA==
X-Gm-Message-State: AOAM533ITI8EfK43j1U7kPEVMdchXo/zdVDhdITVDl+Oyq6cBliEEYpM
        nR9Y812Rmq9iS/Re8HlJAqfSPrOTA38=
X-Google-Smtp-Source: ABdhPJwM27h2ds1siRQTbg1TDMuWf1kMt4b2rneLFTdiBLJbFDWVswglDDRpbchqXhvHU45JSkm4Qg==
X-Received: by 2002:a05:600c:230c:: with SMTP id 12mr14443237wmo.23.1600084787176;
        Mon, 14 Sep 2020 04:59:47 -0700 (PDT)
Received: from liuwe-devbox-debian-v2.j3c5onc20sse1dnehy4noqpfcg.zx.internal.cloudapp.net ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id c205sm18764809wmd.33.2020.09.14.04.59.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 04:59:46 -0700 (PDT)
From:   Wei Liu <wei.liu@kernel.org>
To:     Linux on Hyper-V List <linux-hyperv@vger.kernel.org>
Cc:     virtualization@lists.linux-foundation.org,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Nuno Das Neves <nudasnev@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
        "H. Peter Anvin" <hpa@zytor.com>, Marc Zyngier <maz@kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH RFC v1 17/18] x86/ioapic: export a few functions and data structures via io_apic.h
Date:   Mon, 14 Sep 2020 11:59:26 +0000
Message-Id: <20200914115928.83184-9-wei.liu@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200914112802.80611-1-wei.liu@kernel.org>
References: <20200914112802.80611-1-wei.liu@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

We are about to implement an irqchip for IO-APIC when Linux runs as root
on Microsoft Hypervisor. At the same time we would like to reuse
existing code as much as possible.

Move mp_chip_data to io_apic.h and make a few helper functions
non-static.

No functional change.

Signed-off-by: Wei Liu <wei.liu@kernel.org>
---
 arch/x86/include/asm/io_apic.h | 20 ++++++++++++++++++++
 arch/x86/kernel/apic/io_apic.c | 28 +++++++++-------------------
 2 files changed, 29 insertions(+), 19 deletions(-)

diff --git a/arch/x86/include/asm/io_apic.h b/arch/x86/include/asm/io_apic.h
index fd20a2334885..9277530116fa 100644
--- a/arch/x86/include/asm/io_apic.h
+++ b/arch/x86/include/asm/io_apic.h
@@ -153,6 +153,15 @@ extern unsigned long io_apic_irqs;
 #define io_apic_assign_pci_irqs \
 	(mp_irq_entries && !skip_ioapic_setup && io_apic_irqs)
 
+struct mp_chip_data {
+	struct list_head irq_2_pin;
+	struct IO_APIC_route_entry entry;
+	int trigger;
+	int polarity;
+	u32 count;
+	bool isa_irq;
+};
+
 struct irq_cfg;
 extern void ioapic_insert_resources(void);
 extern int arch_early_ioapic_init(void);
@@ -196,6 +205,17 @@ extern void clear_IO_APIC(void);
 extern void restore_boot_irq_mode(void);
 extern int IO_APIC_get_PCI_irq_vector(int bus, int devfn, int pin);
 extern void print_IO_APICs(void);
+
+extern struct IO_APIC_route_entry ioapic_read_entry(int apic, int pin);
+extern void ioapic_write_entry(int apic, int pin, struct IO_APIC_route_entry e);
+extern void mask_ioapic_irq(struct irq_data *irq_data);
+extern void unmask_ioapic_irq(struct irq_data *irq_data);
+extern int ioapic_set_affinity(struct irq_data *irq_data, const struct cpumask *mask, bool force);
+extern struct irq_domain *mp_ioapic_irqdomain(int ioapic);
+enum irqchip_irq_state;
+extern int ioapic_irq_get_chip_state(struct irq_data *irqd,
+				enum irqchip_irq_state which,
+				bool *state);
 #else  /* !CONFIG_X86_IO_APIC */
 
 #define IO_APIC_IRQ(x)		0
diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
index 81ffcfbfaef2..43d151f9894b 100644
--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -88,15 +88,6 @@ struct irq_pin_list {
 	int apic, pin;
 };
 
-struct mp_chip_data {
-	struct list_head irq_2_pin;
-	struct IO_APIC_route_entry entry;
-	int trigger;
-	int polarity;
-	u32 count;
-	bool isa_irq;
-};
-
 struct mp_ioapic_gsi {
 	u32 gsi_base;
 	u32 gsi_end;
@@ -154,7 +145,7 @@ static inline bool mp_is_legacy_irq(int irq)
 	return irq >= 0 && irq < nr_legacy_irqs();
 }
 
-static inline struct irq_domain *mp_ioapic_irqdomain(int ioapic)
+struct irq_domain *mp_ioapic_irqdomain(int ioapic)
 {
 	return ioapics[ioapic].irqdomain;
 }
@@ -301,7 +292,7 @@ static struct IO_APIC_route_entry __ioapic_read_entry(int apic, int pin)
 	return eu.entry;
 }
 
-static struct IO_APIC_route_entry ioapic_read_entry(int apic, int pin)
+struct IO_APIC_route_entry ioapic_read_entry(int apic, int pin)
 {
 	union entry_union eu;
 	unsigned long flags;
@@ -328,7 +319,7 @@ static void __ioapic_write_entry(int apic, int pin, struct IO_APIC_route_entry e
 	io_apic_write(apic, 0x10 + 2*pin, eu.w1);
 }
 
-static void ioapic_write_entry(int apic, int pin, struct IO_APIC_route_entry e)
+void ioapic_write_entry(int apic, int pin, struct IO_APIC_route_entry e)
 {
 	unsigned long flags;
 
@@ -453,7 +444,7 @@ static void io_apic_sync(struct irq_pin_list *entry)
 	readl(&io_apic->data);
 }
 
-static void mask_ioapic_irq(struct irq_data *irq_data)
+void mask_ioapic_irq(struct irq_data *irq_data)
 {
 	struct mp_chip_data *data = irq_data->chip_data;
 	unsigned long flags;
@@ -468,7 +459,7 @@ static void __unmask_ioapic(struct mp_chip_data *data)
 	io_apic_modify_irq(data, ~IO_APIC_REDIR_MASKED, 0, NULL);
 }
 
-static void unmask_ioapic_irq(struct irq_data *irq_data)
+void unmask_ioapic_irq(struct irq_data *irq_data)
 {
 	struct mp_chip_data *data = irq_data->chip_data;
 	unsigned long flags;
@@ -1868,8 +1859,7 @@ static void ioapic_configure_entry(struct irq_data *irqd)
 		__ioapic_write_entry(entry->apic, entry->pin, mpd->entry);
 }
 
-static int ioapic_set_affinity(struct irq_data *irq_data,
-			       const struct cpumask *mask, bool force)
+int ioapic_set_affinity(struct irq_data *irq_data, const struct cpumask *mask, bool force)
 {
 	struct irq_data *parent = irq_data->parent_data;
 	unsigned long flags;
@@ -1898,9 +1888,9 @@ static int ioapic_set_affinity(struct irq_data *irq_data,
  *
  * Verify that the corresponding Remote-IRR bits are clear.
  */
-static int ioapic_irq_get_chip_state(struct irq_data *irqd,
-				   enum irqchip_irq_state which,
-				   bool *state)
+int ioapic_irq_get_chip_state(struct irq_data *irqd,
+				enum irqchip_irq_state which,
+				bool *state)
 {
 	struct mp_chip_data *mcd = irqd->chip_data;
 	struct IO_APIC_route_entry rentry;
-- 
2.20.1

