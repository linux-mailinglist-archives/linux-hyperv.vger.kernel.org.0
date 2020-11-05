Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3E312A8437
	for <lists+linux-hyperv@lfdr.de>; Thu,  5 Nov 2020 17:59:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731196AbgKEQ6n (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 5 Nov 2020 11:58:43 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37666 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731870AbgKEQ6m (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 5 Nov 2020 11:58:42 -0500
Received: by mail-wr1-f67.google.com with SMTP id w1so2604731wrm.4;
        Thu, 05 Nov 2020 08:58:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iGYCPoxbPXb/Nle4GGVqLIpoK4S0/Gv0sux/bkFSTu8=;
        b=dWf0L0/A80suyPiGN+PtivUSaTfSFKuhRCirqZ7IHb/G0DhCJYf8hwrDTTFroCtkan
         Xr8lzJP2kfbirqpSLsVxsvNRsxdWfK4QSkcG2mSa59Qv+1Vst6s98h+M8J4rLLkdDVsv
         givjtgl2nocMzuz2B7grAB+IYxo2OM+p6eBgA2CQkaawwAFDRWUF/neFu0I4OmCeGMUw
         RSxZChFDNznASLmfe/kkAxpDyRdl/+inyvmMqDNFynpBvdCko1lzzDfla/KBH6TaM49F
         AFCExYUTymk6dzXlpCqVptJZ5jOERySth47uaoSYECQPMHBCUnmHIgnAErTzvlUF9Amn
         0Eeg==
X-Gm-Message-State: AOAM531N7AblqqgKFh3XoPXNCGhnDTEytdpXp65TyI625Rl9WMJ6fzqx
        vZl04K0gNZzR1WMbryRfWeEJ1leE848=
X-Google-Smtp-Source: ABdhPJwhBVoFPf4mA0vdMrrROqEFgAFFQxFMJOWJppElZlSemqfbczYoOi9VV/24dcH0WLir1QDwmA==
X-Received: by 2002:adf:e287:: with SMTP id v7mr4179325wri.252.1604595519621;
        Thu, 05 Nov 2020 08:58:39 -0800 (PST)
Received: from liuwe-devbox-debian-v2.j3c5onc20sse1dnehy4noqpfcg.zx.internal.cloudapp.net ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id z5sm3350729wrw.87.2020.11.05.08.58.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 08:58:39 -0800 (PST)
From:   Wei Liu <wei.liu@kernel.org>
To:     Linux on Hyper-V List <linux-hyperv@vger.kernel.org>
Cc:     virtualization@lists.linux-foundation.org,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Nuno Das Neves <nunodasneves@linux.microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
        "H. Peter Anvin" <hpa@zytor.com>, Joerg Roedel <jroedel@suse.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jon Derrick <jonathan.derrick@intel.com>,
        YueHaibing <yuehaibing@huawei.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [PATCH v2 16/17] x86/ioapic: export a few functions and data structures via io_apic.h
Date:   Thu,  5 Nov 2020 16:58:13 +0000
Message-Id: <20201105165814.29233-17-wei.liu@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201105165814.29233-1-wei.liu@kernel.org>
References: <20201105165814.29233-1-wei.liu@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
 arch/x86/include/asm/io_apic.h | 21 +++++++++++++++++++++
 arch/x86/kernel/apic/io_apic.c | 28 +++++++++-------------------
 2 files changed, 30 insertions(+), 19 deletions(-)

diff --git a/arch/x86/include/asm/io_apic.h b/arch/x86/include/asm/io_apic.h
index a1a26f6d3aa4..1375983a6028 100644
--- a/arch/x86/include/asm/io_apic.h
+++ b/arch/x86/include/asm/io_apic.h
@@ -152,6 +152,15 @@ extern unsigned long io_apic_irqs;
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
@@ -195,6 +204,18 @@ extern void clear_IO_APIC(void);
 extern void restore_boot_irq_mode(void);
 extern int IO_APIC_get_PCI_irq_vector(int bus, int devfn, int pin);
 extern void print_IO_APICs(void);
+
+struct irq_data;
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
index 7b3c7e0d4a09..23047f98b5e4 100644
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

