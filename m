Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66F0B24CA62
	for <lists+linux-hyperv@lfdr.de>; Fri, 21 Aug 2020 04:18:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728115AbgHUCSL (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 20 Aug 2020 22:18:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727924AbgHUCRT (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 20 Aug 2020 22:17:19 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9865C061386;
        Thu, 20 Aug 2020 19:17:18 -0700 (PDT)
Message-Id: <20200821002948.379447552@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1597976237;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=/s0W3ueaG6RtDzEeGUOI0RGBVruM5KofEMx/9DI9MLQ=;
        b=lhEvEN53FVmm7WaATrlbrU5ndLFii2LKbFg5sOWGT7H+n7al6/w9HhdVruRVrDYtOIEFMv
        JDlX8SKzQY5EyF2uM472V9qjU3IMvsqzbOWjOd6lcSAS2lis/6p6/43NObKcwJMcaROLRT
        isNBG1VfW+VhAscmgCqMl6CbeQFaiqBUuhrbm4zGR06CHqJiGmm5tFrJul177II1iXHN6U
        JqiLxD/1koJNOnYePuc93IRS5OQ3wiHQUabnterO5JENke8VWJNXDg7Kxk4q9L0IZdzV8Z
        kO1OfD/dFzMjxmvoxXA6WcJ00IcS9QOm0WtLGabMefC5f/FLnv7iSqVJmJfmxA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1597976237;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=/s0W3ueaG6RtDzEeGUOI0RGBVruM5KofEMx/9DI9MLQ=;
        b=QHm30rz5+fz6MVN5gJxMivl2CwMWIfo/V05Ng5lEi8dMBMkPwGvNfN6ORhWZ6ka1Rkg62S
        pVIbqqFvU832pWBw==
Date:   Fri, 21 Aug 2020 02:24:55 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, xen-devel@lists.xenproject.org,
        linux-pci@vger.kernel.org, Joerg Roedel <joro@8bytes.org>,
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
        Juergen Gross <jgross@suse.com>,
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
Subject: [patch RFC 31/38] x86/irq: Cleanup the arch_*_msi_irqs() leftovers
References: <20200821002424.119492231@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline;
 filename="x86-irq--Cleanup-the-arch_msi_irqs-leftovers.patch"
Content-transfer-encoding: 8-bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Get rid of all the gunk and enable CONFIG_PCI_MSI_DISABLE_ARCH_FALLBACKS.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: xen-devel@lists.xenproject.org
Cc: linux-pci@vger.kernel.org
---
 arch/x86/Kconfig                |    1 +
 arch/x86/include/asm/pci.h      |   11 -----------
 arch/x86/include/asm/x86_init.h |    1 -
 arch/x86/kernel/apic/msi.c      |   22 ----------------------
 arch/x86/kernel/x86_init.c      |   18 ------------------
 arch/x86/pci/xen.c              |    7 -------
 6 files changed, 1 insertion(+), 59 deletions(-)

--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -225,6 +225,7 @@ config X86
 	select NEED_SG_DMA_LENGTH
 	select PCI_DOMAINS			if PCI
 	select PCI_LOCKLESS_CONFIG		if PCI
+	select PCI_MSI_DISABLE_ARCH_FALLBACKS
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
@@ -145,28 +145,10 @@ EXPORT_SYMBOL_GPL(x86_platform);
 
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
@@ -401,11 +401,6 @@ static void xen_pv_teardown_msi_irqs(str
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
@@ -482,8 +477,6 @@ static __init void xen_setup_pci_msi(voi
 		return;
 	}
 
-	x86_msi.teardown_msi_irq = xen_teardown_msi_irq;
-
 	/*
 	 * Override the PCI/MSI irq domain init function. No point
 	 * in allocating the native domain and never use it.

