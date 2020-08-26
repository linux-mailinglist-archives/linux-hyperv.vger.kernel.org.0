Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0716D252E35
	for <lists+linux-hyperv@lfdr.de>; Wed, 26 Aug 2020 14:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729867AbgHZMKZ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 26 Aug 2020 08:10:25 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:57940 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729401AbgHZMBf (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 26 Aug 2020 08:01:35 -0400
Message-Id: <20200826112333.420224092@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598443290;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=5gSA5lrpFSSx0Sk4Rz0WYJJ5HYHvpjnq38rOpqhYXaQ=;
        b=Y+GSAhB9I36ILIa68AiuAQJaHfzKn5so+JvNIdTBqFRIqLfYtpG7S52bXnYinuagR1Ip4L
        m8ZI3O8AJJprbiNcgau3OA/UyXKhe8yA71EmDsg9ZT9Y3mrvCpDRjbGIAko4LoIH3/u8Ko
        s5CUikykjxRGFY5TXjJaLHg+9FVAjzmW+N1wkHUv/lHixzLJktkwID/TfAcKwzO7cNez2Y
        RSO9ziIpIHPtWi5VTPLYywmcFUMzIkKuUQthsArASiS+zngpUfZ/QcIB0iFra9bqB6J4T3
        YktiFwVO2L8l8lr9+SwGIoMLzf+agbrEPGfFNyWc8848xpUs7TbmEGCXTUtPcA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598443290;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=5gSA5lrpFSSx0Sk4Rz0WYJJ5HYHvpjnq38rOpqhYXaQ=;
        b=Leew08eWQ6Ztik03CCxHcAXfQtPZJzm1YgdLVOV6/36hmFk1C7Z6JLGuHg3TjGFN8XbonQ
        Wtd37okFERh9L3Dw==
Date:   Wed, 26 Aug 2020 13:16:56 +0200
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
Subject: [patch V2 28/46] x86/xen: Consolidate XEN-MSI init
References: <20200826111628.794979401@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

X86 cannot store the irq domain pointer in struct device without breaking
XEN because the irq domain pointer takes precedence over arch_*_msi_irqs()
fallbacks.

To achieve this XEN MSI interrupt management needs to be wrapped into an
irq domain.

Move the x86_msi ops setup into a single function to prepare for this.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V2: Use the proper logic to select initial domain setup
---
 arch/x86/pci/xen.c |   51 ++++++++++++++++++++++++++++++++-------------------
 1 file changed, 32 insertions(+), 19 deletions(-)

--- a/arch/x86/pci/xen.c
+++ b/arch/x86/pci/xen.c
@@ -372,7 +372,10 @@ static void xen_initdom_restore_msi_irqs
 		WARN(ret && ret != -ENOSYS, "restore_msi -> %d\n", ret);
 	}
 }
-#endif
+#else /* CONFIG_XEN_DOM0 */
+#define xen_initdom_setup_msi_irqs	NULL
+#define xen_initdom_restore_msi_irqs	NULL
+#endif /* !CONFIG_XEN_DOM0 */
 
 static void xen_teardown_msi_irqs(struct pci_dev *dev)
 {
@@ -404,7 +407,31 @@ static void xen_teardown_msi_irq(unsigne
 	WARN_ON_ONCE(1);
 }
 
-#endif
+static __init void xen_setup_pci_msi(void)
+{
+	if (xen_pv_domain()) {
+		if (xen_initial_domain()) {
+			x86_msi.setup_msi_irqs = xen_initdom_setup_msi_irqs;
+			x86_msi.restore_msi_irqs = xen_initdom_restore_msi_irqs;
+		} else {
+			x86_msi.setup_msi_irqs = xen_setup_msi_irqs;
+		}
+		x86_msi.teardown_msi_irqs = xen_pv_teardown_msi_irqs;
+		pci_msi_ignore_mask = 1;
+	} else if (xen_hvm_domain()) {
+		x86_msi.setup_msi_irqs = xen_hvm_setup_msi_irqs;
+		x86_msi.teardown_msi_irqs = xen_teardown_msi_irqs;
+	} else {
+		WARN_ON_ONCE(1);
+		return;
+	}
+
+	x86_msi.teardown_msi_irq = xen_teardown_msi_irq;
+}
+
+#else /* CONFIG_PCI_MSI */
+static inline void xen_setup_pci_msi(void) { }
+#endif /* CONFIG_PCI_MSI */
 
 int __init pci_xen_init(void)
 {
@@ -421,12 +448,7 @@ int __init pci_xen_init(void)
 	/* Keep ACPI out of the picture */
 	acpi_noirq_set();
 
-#ifdef CONFIG_PCI_MSI
-	x86_msi.setup_msi_irqs = xen_setup_msi_irqs;
-	x86_msi.teardown_msi_irq = xen_teardown_msi_irq;
-	x86_msi.teardown_msi_irqs = xen_pv_teardown_msi_irqs;
-	pci_msi_ignore_mask = 1;
-#endif
+	xen_setup_pci_msi();
 	return 0;
 }
 
@@ -446,10 +468,7 @@ static void __init xen_hvm_msi_init(void
 		    ((eax & XEN_HVM_CPUID_APIC_ACCESS_VIRT) && boot_cpu_has(X86_FEATURE_APIC)))
 			return;
 	}
-
-	x86_msi.setup_msi_irqs = xen_hvm_setup_msi_irqs;
-	x86_msi.teardown_msi_irqs = xen_teardown_msi_irqs;
-	x86_msi.teardown_msi_irq = xen_teardown_msi_irq;
+	xen_setup_pci_msi();
 }
 #endif
 
@@ -482,13 +501,7 @@ int __init pci_xen_initial_domain(void)
 {
 	int irq;
 
-#ifdef CONFIG_PCI_MSI
-	x86_msi.setup_msi_irqs = xen_initdom_setup_msi_irqs;
-	x86_msi.teardown_msi_irq = xen_teardown_msi_irq;
-	x86_msi.teardown_msi_irqs = xen_teardown_pv_msi_irqs;
-	x86_msi.restore_msi_irqs = xen_initdom_restore_msi_irqs;
-	pci_msi_ignore_mask = 1;
-#endif
+	xen_setup_pci_msi();
 	__acpi_register_gsi = acpi_register_gsi_xen;
 	__acpi_unregister_gsi = NULL;
 	/*

