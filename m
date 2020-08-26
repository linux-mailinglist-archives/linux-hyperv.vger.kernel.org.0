Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20699252E21
	for <lists+linux-hyperv@lfdr.de>; Wed, 26 Aug 2020 14:09:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729296AbgHZMJl (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 26 Aug 2020 08:09:41 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:58102 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729408AbgHZMBl (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 26 Aug 2020 08:01:41 -0400
Message-Id: <20200826112334.086003720@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598443298;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=4GR30s5GgYbrNACLVjkL2Z4Vc3S8YRxhz8JprbkQ4/Q=;
        b=15vzrh+WEt/YNZOsozwZ+WvaE0KRfmdkhA6KFC+jQ577UxrHhrtciftZ2WN553VbQ7FbrN
        nxh/mQXcDb42ecdHwTgxAxp/rVdziiFKVIlqPDDDmhA8wcipnzpgcAy9YX31cElht5snPh
        aRe8AL/ngpPV/0D6Gcvrm9OAh8W8OUeFGBdTh59wOMgelq9vBfUd1pV769vuqbRPcVUwvc
        iWO/jJU+1PKpMQ65WwaKFIRX/4fbahxl8EHUOErEg/LhtqzshmKPdjLuyHJdjBfekPfehw
        sAbS5Ei1NWTirGg3JVgec2tphKQAaviPw68KaXjf76/TOdCoZ+q+MgjrOTzDlA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598443298;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=4GR30s5GgYbrNACLVjkL2Z4Vc3S8YRxhz8JprbkQ4/Q=;
        b=kD7LSBOGP377ptxMy8QUsT8p4tGWKTXIjr5euUh4DjI5Nu9+rSEdclDD/RedRs6uVRrjoi
        q5eGzh+h+HBqKyAQ==
Date:   Wed, 26 Aug 2020 13:17:03 +0200
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
Subject: [patch V2 35/46] x86/irq: Cleanup the arch_*_msi_irqs() leftovers
References: <20200826111628.794979401@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

Get rid of all the gunk and remove the 'select PCI_MSI_ARCH_FALLBACK' from
the x86 Kconfig so the weak functions in the PCI core are replaced by stubs
which emit a warning, which ensures that any fail to set the irq domain
pointer results in a warning when the device is used.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V2: Adjust to the PCI_MSI_ARCH_FALLBACK change, i.e. remove it instead
    of selecting the disabler.
---
 arch/x86/Kconfig                |    1 -
 arch/x86/include/asm/pci.h      |   11 -----------
 arch/x86/include/asm/x86_init.h |    1 -
 arch/x86/kernel/apic/msi.c      |   22 ----------------------
 arch/x86/kernel/x86_init.c      |   18 ------------------
 arch/x86/pci/xen.c              |    7 -------
 6 files changed, 60 deletions(-)

--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -225,7 +225,6 @@ config X86
 	select NEED_SG_DMA_LENGTH
 	select PCI_DOMAINS			if PCI
 	select PCI_LOCKLESS_CONFIG		if PCI
-	select PCI_MSI_ARCH_FALLBACKS
 	select PERF_EVENTS
 	select RTC_LIB
 	select RTC_MC146818_LIB
--- a/arch/x86/include/asm/pci.h
+++ b/arch/x86/include/asm/pci.h
@@ -105,17 +105,6 @@ static inline void early_quirks(void) {
 
 extern void pci_iommu_alloc(void);
 
-#ifdef CONFIG_PCI_MSI
-/* implemented in arch/x86/kernel/apic/io_apic. */
-struct msi_desc;
-int native_setup_msi_irqs(struct pci_dev *dev, int nvec, int type);
-void native_teardown_msi_irq(unsigned int irq);
-void native_restore_msi_irqs(struct pci_dev *dev);
-#else
-#define native_setup_msi_irqs		NULL
-#define native_teardown_msi_irq		NULL
-#endif
-
 /* generic pci stuff */
 #include <asm-generic/pci.h>
 
--- a/arch/x86/include/asm/x86_init.h
+++ b/arch/x86/include/asm/x86_init.h
@@ -277,7 +277,6 @@ struct pci_dev;
 
 struct x86_msi_ops {
 	int (*setup_msi_irqs)(struct pci_dev *dev, int nvec, int type);
-	void (*teardown_msi_irq)(unsigned int irq);
 	void (*teardown_msi_irqs)(struct pci_dev *dev);
 	void (*restore_msi_irqs)(struct pci_dev *dev);
 };
--- a/arch/x86/kernel/apic/msi.c
+++ b/arch/x86/kernel/apic/msi.c
@@ -182,28 +182,6 @@ static struct irq_chip pci_msi_controlle
 	.flags			= IRQCHIP_SKIP_SET_WAKE,
 };
 
-int native_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
-{
-	struct irq_domain *domain;
-	struct irq_alloc_info info;
-
-	init_irq_alloc_info(&info, NULL);
-	info.type = X86_IRQ_ALLOC_TYPE_PCI_MSI;
-
-	domain = irq_remapping_get_irq_domain(&info);
-	if (domain == NULL)
-		domain = x86_pci_msi_default_domain;
-	if (domain == NULL)
-		return -ENOSYS;
-
-	return msi_domain_alloc_irqs(domain, &dev->dev, nvec);
-}
-
-void native_teardown_msi_irq(unsigned int irq)
-{
-	irq_domain_free_irqs(irq, 1);
-}
-
 int pci_msi_prepare(struct irq_domain *domain, struct device *dev, int nvec,
 		    msi_alloc_info_t *arg)
 {
--- a/arch/x86/kernel/x86_init.c
+++ b/arch/x86/kernel/x86_init.c
@@ -146,28 +146,10 @@ EXPORT_SYMBOL_GPL(x86_platform);
 
 #if defined(CONFIG_PCI_MSI)
 struct x86_msi_ops x86_msi __ro_after_init = {
-	.setup_msi_irqs		= native_setup_msi_irqs,
-	.teardown_msi_irq	= native_teardown_msi_irq,
-	.teardown_msi_irqs	= default_teardown_msi_irqs,
 	.restore_msi_irqs	= default_restore_msi_irqs,
 };
 
 /* MSI arch specific hooks */
-int arch_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
-{
-	return x86_msi.setup_msi_irqs(dev, nvec, type);
-}
-
-void arch_teardown_msi_irqs(struct pci_dev *dev)
-{
-	x86_msi.teardown_msi_irqs(dev);
-}
-
-void arch_teardown_msi_irq(unsigned int irq)
-{
-	x86_msi.teardown_msi_irq(irq);
-}
-
 void arch_restore_msi_irqs(struct pci_dev *dev)
 {
 	x86_msi.restore_msi_irqs(dev);
--- a/arch/x86/pci/xen.c
+++ b/arch/x86/pci/xen.c
@@ -402,11 +402,6 @@ static void xen_pv_teardown_msi_irqs(str
 	xen_teardown_msi_irqs(dev);
 }
 
-static void xen_teardown_msi_irq(unsigned int irq)
-{
-	WARN_ON_ONCE(1);
-}
-
 static int xen_msi_domain_alloc_irqs(struct irq_domain *domain,
 				     struct device *dev,  int nvec)
 {
@@ -483,8 +478,6 @@ static __init void xen_setup_pci_msi(voi
 		return;
 	}
 
-	x86_msi.teardown_msi_irq = xen_teardown_msi_irq;
-
 	/*
 	 * Override the PCI/MSI irq domain init function. No point
 	 * in allocating the native domain and never use it.

