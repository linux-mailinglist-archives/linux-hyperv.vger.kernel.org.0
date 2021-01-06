Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 613C82EC508
	for <lists+linux-hyperv@lfdr.de>; Wed,  6 Jan 2021 21:35:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727689AbhAFUe5 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 6 Jan 2021 15:34:57 -0500
Received: from mail-wm1-f52.google.com ([209.85.128.52]:53484 "EHLO
        mail-wm1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727497AbhAFUe5 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 6 Jan 2021 15:34:57 -0500
Received: by mail-wm1-f52.google.com with SMTP id k10so3449014wmi.3;
        Wed, 06 Jan 2021 12:34:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GK+vVhDsK71vLw/318wUqwSDLwvrBlAFUO2whIdhuJk=;
        b=AVKUKGY6mc4pMersfx6p7hqy74IlYUBnr7bu6dXLA0nEcX66XhpIFCriInqy7YOq7j
         nDC3sN/DP7qNuRdGQFJCB9SBGPW4faoyjZV2IdfHFDmf95kb7kMr8QnlPlU59x3tcaTb
         KTI1gHEeSDlALoaf4M7HMKiUmv1teJRu9A7zbok5j7awlbNtqpXkW0+Vy2ZGzNF89KD3
         lES2liokDFsHjgVw08WLiLzRnpwlwWbcqA+w1pV+nwE1WLY8wc2ZPS2yVrAq19WBgHKD
         ycFX1XjBIjbfufXJaTz+3rW2tp5tPuNB+KNR3147BmOJKG1VieHQMdzjbkXbEnR3+o9Y
         Z4tw==
X-Gm-Message-State: AOAM532xvnzT4j0VES+2Dn4FilVcjyAHvznq3uDWMJS1z4eJQ+f4D2KF
        V1Zod5Ltvp8vqGZxaxzzXHy/JHgUGx8=
X-Google-Smtp-Source: ABdhPJzdCwTS4takFC+Rso/pju9mAMGxfngXDXFbS+lpKsvo8fJ6D8zp0Xl4aBpQjuRxnQ1ueNmqDw==
X-Received: by 2002:a7b:cc16:: with SMTP id f22mr5022521wmh.131.1609965254524;
        Wed, 06 Jan 2021 12:34:14 -0800 (PST)
Received: from liuwe-devbox-debian-v2.j3c5onc20sse1dnehy4noqpfcg.zx.internal.cloudapp.net ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id u9sm4499456wmb.32.2021.01.06.12.34.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jan 2021 12:34:14 -0800 (PST)
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
        "H. Peter Anvin" <hpa@zytor.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Joerg Roedel <jroedel@suse.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Jon Derrick <jonathan.derrick@intel.com>
Subject: [PATCH v4 16/17] x86/ioapic: export a few functions and data structures via io_apic.h
Date:   Wed,  6 Jan 2021 20:33:49 +0000
Message-Id: <20210106203350.14568-17-wei.liu@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210106203350.14568-1-wei.liu@kernel.org>
References: <20210106203350.14568-1-wei.liu@kernel.org>
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
 arch/x86/include/asm/io_apic.h | 22 ++++++++++++++++++++++
 arch/x86/kernel/apic/io_apic.c | 25 ++++++++-----------------
 2 files changed, 30 insertions(+), 17 deletions(-)

diff --git a/arch/x86/include/asm/io_apic.h b/arch/x86/include/asm/io_apic.h
index 437aa8d00e53..8e2b78a0edbd 100644
--- a/arch/x86/include/asm/io_apic.h
+++ b/arch/x86/include/asm/io_apic.h
@@ -87,6 +87,15 @@ struct IO_APIC_route_entry {
 	};
 } __attribute__ ((packed));
 
+struct mp_chip_data {
+	struct list_head		irq_2_pin;
+	struct IO_APIC_route_entry	entry;
+	bool				is_level;
+	bool				active_low;
+	bool				isa_irq;
+	u32 count;
+};
+
 struct irq_alloc_info;
 struct ioapic_domain_cfg;
 
@@ -174,6 +183,19 @@ extern void clear_IO_APIC(void);
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
+
 #else  /* !CONFIG_X86_IO_APIC */
 
 #define IO_APIC_IRQ(x)		0
diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
index e4ab4804b20d..05cc91d3d607 100644
--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -88,15 +88,6 @@ struct irq_pin_list {
 	int apic, pin;
 };
 
-struct mp_chip_data {
-	struct list_head		irq_2_pin;
-	struct IO_APIC_route_entry	entry;
-	bool				is_level;
-	bool				active_low;
-	bool				isa_irq;
-	u32 count;
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
@@ -296,7 +287,7 @@ static struct IO_APIC_route_entry __ioapic_read_entry(int apic, int pin)
 	return entry;
 }
 
-static struct IO_APIC_route_entry ioapic_read_entry(int apic, int pin)
+struct IO_APIC_route_entry ioapic_read_entry(int apic, int pin)
 {
 	struct IO_APIC_route_entry entry;
 	unsigned long flags;
@@ -320,7 +311,7 @@ static void __ioapic_write_entry(int apic, int pin, struct IO_APIC_route_entry e
 	io_apic_write(apic, 0x10 + 2*pin, e.w1);
 }
 
-static void ioapic_write_entry(int apic, int pin, struct IO_APIC_route_entry e)
+void ioapic_write_entry(int apic, int pin, struct IO_APIC_route_entry e)
 {
 	unsigned long flags;
 
@@ -440,7 +431,7 @@ static void io_apic_sync(struct irq_pin_list *entry)
 	readl(&io_apic->data);
 }
 
-static void mask_ioapic_irq(struct irq_data *irq_data)
+void mask_ioapic_irq(struct irq_data *irq_data)
 {
 	struct mp_chip_data *data = irq_data->chip_data;
 	unsigned long flags;
@@ -455,7 +446,7 @@ static void __unmask_ioapic(struct mp_chip_data *data)
 	io_apic_modify_irq(data, false, NULL);
 }
 
-static void unmask_ioapic_irq(struct irq_data *irq_data)
+void unmask_ioapic_irq(struct irq_data *irq_data)
 {
 	struct mp_chip_data *data = irq_data->chip_data;
 	unsigned long flags;
@@ -1906,8 +1897,8 @@ static void ioapic_configure_entry(struct irq_data *irqd)
 		__ioapic_write_entry(entry->apic, entry->pin, mpd->entry);
 }
 
-static int ioapic_set_affinity(struct irq_data *irq_data,
-			       const struct cpumask *mask, bool force)
+int ioapic_set_affinity(struct irq_data *irq_data,
+		       const struct cpumask *mask, bool force)
 {
 	struct irq_data *parent = irq_data->parent_data;
 	unsigned long flags;
@@ -1936,7 +1927,7 @@ static int ioapic_set_affinity(struct irq_data *irq_data,
  *
  * Verify that the corresponding Remote-IRR bits are clear.
  */
-static int ioapic_irq_get_chip_state(struct irq_data *irqd,
+int ioapic_irq_get_chip_state(struct irq_data *irqd,
 				   enum irqchip_irq_state which,
 				   bool *state)
 {
-- 
2.20.1

