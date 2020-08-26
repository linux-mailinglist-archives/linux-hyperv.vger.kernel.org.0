Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E30E2252E4A
	for <lists+linux-hyperv@lfdr.de>; Wed, 26 Aug 2020 14:11:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729890AbgHZMLP (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 26 Aug 2020 08:11:15 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:57868 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729389AbgHZMBd (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 26 Aug 2020 08:01:33 -0400
Message-Id: <20200826112332.859209894@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598443282;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=9wVfyDYOAPWBVALbIjeuB/5+lB8M43JevsiG5wUvbJw=;
        b=MC7/0To0WtlhO72Rb/Ni0Xi/EluPHJbJ9dEk1FnCnQjFBtoYfqZ/qvme4XXYsc6PpNtzmO
        XIl4Y5zPJHSMAELUHVmGr5CpJGxS3G+bk1ruelrOjrz5ENsi7aPbwF+cDXFe2L52aYKuoB
        dPXnhLCAGxSpxRnjw9MskRrw9XNuGgZjH/Cc43JB8/yj2VRLM+vIttPE6oAl6fQOk0jdP2
        J6WwWIc8ExNYplol64VweCD45neH2/p+X8bslHeO6FZuZk96C1By+NB4PQfZvduX089j/k
        oQ/RfgJ51ePj0KED7HGKxCKpo/MhicH9gdhrdXnHKbOt9cxd907X8x/fknt4rA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598443282;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=9wVfyDYOAPWBVALbIjeuB/5+lB8M43JevsiG5wUvbJw=;
        b=QHIuGUxybZuhBZOI7igCh3EajjkLBV3AlUzOdvbdkO3i6pN9FweuaNWcjjIynVJtr2HDw9
        xjn+SUPEx+7GdlAw==
Date:   Wed, 26 Aug 2020 13:16:50 +0200
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
Subject: [patch V2 22/46] x86/irq: Initialize PCI/MSI domain at PCI init time
References: <20200826111628.794979401@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

No point in initializing the default PCI/MSI interrupt domain early and no
point to create it when XEN PV/HVM/DOM0 are active.

Move the initialization to pci_arch_init() and convert it to init ops so
that XEN can override it as XEN has it's own PCI/MSI management. The XEN
override comes in a later step.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V2: Add missing include
---
 arch/x86/include/asm/irqdomain.h |    6 ++++--
 arch/x86/include/asm/x86_init.h  |    3 +++
 arch/x86/kernel/apic/msi.c       |   31 +++++++++++++++++++------------
 arch/x86/kernel/apic/vector.c    |    2 --
 arch/x86/kernel/x86_init.c       |    4 +++-
 arch/x86/pci/init.c              |    3 +++
 6 files changed, 32 insertions(+), 17 deletions(-)

--- a/arch/x86/include/asm/irqdomain.h
+++ b/arch/x86/include/asm/irqdomain.h
@@ -51,9 +51,11 @@ extern int mp_irqdomain_ioapic_idx(struc
 #endif /* CONFIG_X86_IO_APIC */
 
 #ifdef CONFIG_PCI_MSI
-extern void arch_init_msi_domain(struct irq_domain *domain);
+void x86_create_pci_msi_domain(void);
+struct irq_domain *native_create_pci_msi_domain(void);
 #else
-static inline void arch_init_msi_domain(struct irq_domain *domain) { }
+static inline void x86_create_pci_msi_domain(void) { }
+#define native_create_pci_msi_domain	NULL
 #endif
 
 #endif
--- a/arch/x86/include/asm/x86_init.h
+++ b/arch/x86/include/asm/x86_init.h
@@ -8,6 +8,7 @@ struct mpc_bus;
 struct mpc_cpu;
 struct mpc_table;
 struct cpuinfo_x86;
+struct irq_domain;
 
 /**
  * struct x86_init_mpparse - platform specific mpparse ops
@@ -42,12 +43,14 @@ struct x86_init_resources {
  * @intr_init:			interrupt init code
  * @intr_mode_select:		interrupt delivery mode selection
  * @intr_mode_init:		interrupt delivery mode setup
+ * @create_pci_msi_domain:	Create the PCI/MSI interrupt domain
  */
 struct x86_init_irqs {
 	void (*pre_vector_init)(void);
 	void (*intr_init)(void);
 	void (*intr_mode_select)(void);
 	void (*intr_mode_init)(void);
+	struct irq_domain *(*create_pci_msi_domain)(void);
 };
 
 /**
--- a/arch/x86/kernel/apic/msi.c
+++ b/arch/x86/kernel/apic/msi.c
@@ -21,7 +21,7 @@
 #include <asm/apic.h>
 #include <asm/irq_remapping.h>
 
-static struct irq_domain *msi_default_domain;
+static struct irq_domain *x86_pci_msi_default_domain __ro_after_init;
 
 static void __irq_msi_compose_msg(struct irq_cfg *cfg, struct msi_msg *msg)
 {
@@ -192,7 +192,7 @@ int native_setup_msi_irqs(struct pci_dev
 
 	domain = irq_remapping_get_irq_domain(&info);
 	if (domain == NULL)
-		domain = msi_default_domain;
+		domain = x86_pci_msi_default_domain;
 	if (domain == NULL)
 		return -ENOSYS;
 
@@ -235,25 +235,32 @@ static struct msi_domain_info pci_msi_do
 	.handler_name	= "edge",
 };
 
-void __init arch_init_msi_domain(struct irq_domain *parent)
+struct irq_domain * __init native_create_pci_msi_domain(void)
 {
 	struct fwnode_handle *fn;
+	struct irq_domain *d;
 
 	if (disable_apic)
-		return;
+		return NULL;
 
 	fn = irq_domain_alloc_named_fwnode("PCI-MSI");
-	if (fn) {
-		msi_default_domain =
-			pci_msi_create_irq_domain(fn, &pci_msi_domain_info,
-						  parent);
-	}
-	if (!msi_default_domain) {
+	if (!fn)
+		return NULL;
+
+	d = pci_msi_create_irq_domain(fn, &pci_msi_domain_info,
+				      x86_vector_domain);
+	if (!d) {
 		irq_domain_free_fwnode(fn);
-		pr_warn("failed to initialize irqdomain for MSI/MSI-x.\n");
+		pr_warn("Failed to initialize PCI-MSI irqdomain.\n");
 	} else {
-		msi_default_domain->flags |= IRQ_DOMAIN_MSI_NOMASK_QUIRK;
+		d->flags |= IRQ_DOMAIN_MSI_NOMASK_QUIRK;
 	}
+	return d;
+}
+
+void __init x86_create_pci_msi_domain(void)
+{
+	x86_pci_msi_default_domain = x86_init.irqs.create_pci_msi_domain();
 }
 
 #ifdef CONFIG_IRQ_REMAP
--- a/arch/x86/kernel/apic/vector.c
+++ b/arch/x86/kernel/apic/vector.c
@@ -713,8 +713,6 @@ int __init arch_early_irq_init(void)
 	BUG_ON(x86_vector_domain == NULL);
 	irq_set_default_host(x86_vector_domain);
 
-	arch_init_msi_domain(x86_vector_domain);
-
 	BUG_ON(!alloc_cpumask_var(&vector_searchmask, GFP_KERNEL));
 
 	/*
--- a/arch/x86/kernel/x86_init.c
+++ b/arch/x86/kernel/x86_init.c
@@ -24,6 +24,7 @@
 #include <asm/tsc.h>
 #include <asm/iommu.h>
 #include <asm/mach_traps.h>
+#include <asm/irqdomain.h>
 
 void x86_init_noop(void) { }
 void __init x86_init_uint_noop(unsigned int unused) { }
@@ -76,7 +77,8 @@ struct x86_init_ops x86_init __initdata
 		.pre_vector_init	= init_ISA_irqs,
 		.intr_init		= native_init_IRQ,
 		.intr_mode_select	= apic_intr_mode_select,
-		.intr_mode_init		= apic_intr_mode_init
+		.intr_mode_init		= apic_intr_mode_init,
+		.create_pci_msi_domain	= native_create_pci_msi_domain,
 	},
 
 	.oem = {
--- a/arch/x86/pci/init.c
+++ b/arch/x86/pci/init.c
@@ -3,6 +3,7 @@
 #include <linux/init.h>
 #include <asm/pci_x86.h>
 #include <asm/x86_init.h>
+#include <asm/irqdomain.h>
 
 /* arch_initcall has too random ordering, so call the initializers
    in the right sequence from here. */
@@ -10,6 +11,8 @@ static __init int pci_arch_init(void)
 {
 	int type;
 
+	x86_create_pci_msi_domain();
+
 	type = pci_direct_probe();
 
 	if (!(pci_probe & PCI_PROBE_NOEARLY))

