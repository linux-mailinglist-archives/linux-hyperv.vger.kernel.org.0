Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63A2B24CA88
	for <lists+linux-hyperv@lfdr.de>; Fri, 21 Aug 2020 04:20:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbgHUCT3 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 20 Aug 2020 22:19:29 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:52880 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727785AbgHUCRD (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 20 Aug 2020 22:17:03 -0400
Message-Id: <20200821002947.075507468@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1597976220;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=R6JxsviuQwbwX1XcXkkzKQyT+T09StpqXEtTQLkEikY=;
        b=DQo5o0E2WeO60HEbPpznUfv/fyHaZz6TzI8gYCMBjgqs4f3s7extmvfXyO7EAhTksKFRKq
        mvtWArIM2U1VOhePfnms1RYw8XDK9WpqVobucAP6JaquG3rVNS2CLVdbHu/TBc3qsigxVg
        uHbxWuIZd26AsH63CUHieyPhvEjiStO37f1hYv54ZnHBkcQKk6bzmSD7/A/Fxdkkb/Syij
        YxqKenD82ZQdMn2h5p5d73A+PqERU4aI52sNyvm88zGFFhHt0oeiD1bMCVY5n3i8KBw+kn
        t0SxvyiQ+H8LfApRgesHYdyXcQ/KzNm81G0Ix1yA/VCHh/asmwD6xUUwXIf3EA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1597976220;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=R6JxsviuQwbwX1XcXkkzKQyT+T09StpqXEtTQLkEikY=;
        b=BRfXUkkOYf/yCGZZ1rSc74TlbnMx60yjOLHMFdtEViH1OQED5w/ZEnmHNmx+f/pGQQFIDh
        05oW78opN0GrQEDA==
Date:   Fri, 21 Aug 2020 02:24:42 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, linux-pci@vger.kernel.org,
        Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux-foundation.org, linux-hyperv@vger.kernel.org,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Jon Derrick <jonathan.derrick@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Wei Liu <wei.liu@kernel.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Steve Wahl <steve.wahl@hpe.com>,
        Dimitri Sivanich <sivanich@hpe.com>,
        Russ Anderson <rja@hpe.com>,
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
Subject: [patch RFC 18/38] x86/irq: Initialize PCI/MSI domain at PCI init time
References: <20200821002424.119492231@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline;
 filename="x86-irq--Initialize-PCI-MSI-domain-at-PCI-init-time.patch"
Content-transfer-encoding: 8-bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

No point in initializing the default PCI/MSI interrupt domain early and no
point to create it when XEN PV/HVM/DOM0 are active.

Move the initialization to pci_arch_init() and convert it to init ops so
that XEN can override it as XEN has it's own PCI/MSI management. The XEN
override comes in a later step.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-pci@vger.kernel.org
---
 arch/x86/include/asm/irqdomain.h |    6 ++++--
 arch/x86/include/asm/x86_init.h  |    3 +++
 arch/x86/kernel/apic/msi.c       |   26 ++++++++++++++++----------
 arch/x86/kernel/apic/vector.c    |    2 --
 arch/x86/kernel/x86_init.c       |    3 ++-
 arch/x86/pci/init.c              |    3 +++
 6 files changed, 28 insertions(+), 15 deletions(-)

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
 
@@ -243,25 +243,31 @@ static struct msi_domain_info pci_msi_do
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
 	if (fn) {
-		msi_default_domain =
-			pci_msi_create_irq_domain(fn, &pci_msi_domain_info,
-						  parent);
+		d = pci_msi_create_irq_domain(fn, &pci_msi_domain_info,
+					      x86_vector_domain);
 	}
-	if (!msi_default_domain) {
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
@@ -76,7 +76,8 @@ struct x86_init_ops x86_init __initdata
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

