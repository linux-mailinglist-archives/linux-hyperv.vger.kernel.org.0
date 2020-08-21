Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4197424CA55
	for <lists+linux-hyperv@lfdr.de>; Fri, 21 Aug 2020 04:18:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728077AbgHUCSA (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 20 Aug 2020 22:18:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727942AbgHUCRW (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 20 Aug 2020 22:17:22 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32760C061388;
        Thu, 20 Aug 2020 19:17:22 -0700 (PDT)
Message-Id: <20200821002948.664301259@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1597976240;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=IwU9izKFyrpGzvPqUYbXOT7wStkGGFUidxtSyI7gSuU=;
        b=BEmgTzBxRO6uP/nQragORSfmUBwF9g5jAN8GwWNyIDqCY4t9h3ubI9++1vqwr8KU9IbZLO
        p10e+l66E+ryn4Ttlv8e/y2BBV7V+gjAbAuCb1GFvddNAGXqQChjTpRKq59SWiJZXpfZov
        jFshF4WsVdOngCAm3eagjJnbmGf9AGKSdFN0+AlyAkysQTGaD26h6xR6sSFnWKMkmNNiyX
        H0B2uy0Y4GfLOEL62Z00xUZqtRMKBpIUPpxUPgTf8Bp78w+wI4nVXHV5xQE1J39tbV6jKL
        MrW0YTdmu4U3XmeAtdJSVC5lYS5hw8biIfLfcbKqGDhb/BSiRo5tRLn9JtrWfQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1597976240;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=IwU9izKFyrpGzvPqUYbXOT7wStkGGFUidxtSyI7gSuU=;
        b=T+P8E/4ofySSwCHEUhHzxsNh0HImJ7FPAu6EkeURZr78qBWqiOVLSSqiG1nrI+PJMJvkx8
        Dwt9OYTzDoUQoeCw==
Date:   Fri, 21 Aug 2020 02:24:58 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, linux-pci@vger.kernel.org,
        linux-hyperv@vger.kernel.org, Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux-foundation.org,
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
Subject: [patch RFC 34/38] x86/msi: Let pci_msi_prepare() handle non-PCI MSI
References: <20200821002424.119492231@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline;
 filename="x86-msi--Let-pci_msi_prepare---handle-non-PCI-MSI.patch"
Content-transfer-encoding: 8-bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Rename it to x86_msi_prepare() and handle the allocation type setup
depending on the device type.

Add a new arch_msi_prepare define which will be utilized by the upcoming
device MSI support. Define it to NULL if not provided by an architecture in
the generic MSI header.

One arch specific function for MSI support is truly enough.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-pci@vger.kernel.org
Cc: linux-hyperv@vger.kernel.org
---
 arch/x86/include/asm/msi.h          |    4 +++-
 arch/x86/kernel/apic/msi.c          |   27 ++++++++++++++++++++-------
 drivers/pci/controller/pci-hyperv.c |    2 +-
 include/linux/msi.h                 |    4 ++++
 4 files changed, 28 insertions(+), 9 deletions(-)

--- a/arch/x86/include/asm/msi.h
+++ b/arch/x86/include/asm/msi.h
@@ -6,7 +6,9 @@
 
 typedef struct irq_alloc_info msi_alloc_info_t;
 
-int pci_msi_prepare(struct irq_domain *domain, struct device *dev, int nvec,
+int x86_msi_prepare(struct irq_domain *domain, struct device *dev, int nvec,
 		    msi_alloc_info_t *arg);
 
+#define arch_msi_prepare		x86_msi_prepare
+
 #endif /* _ASM_X86_MSI_H */
--- a/arch/x86/kernel/apic/msi.c
+++ b/arch/x86/kernel/apic/msi.c
@@ -182,26 +182,39 @@ static struct irq_chip pci_msi_controlle
 	.flags			= IRQCHIP_SKIP_SET_WAKE,
 };
 
-int pci_msi_prepare(struct irq_domain *domain, struct device *dev, int nvec,
-		    msi_alloc_info_t *arg)
+static void pci_msi_prepare(struct device *dev, msi_alloc_info_t *arg)
 {
-	struct pci_dev *pdev = to_pci_dev(dev);
-	struct msi_desc *desc = first_pci_msi_entry(pdev);
+	struct msi_desc *desc = first_msi_entry(dev);
 
-	init_irq_alloc_info(arg, NULL);
 	if (desc->msi_attrib.is_msix) {
 		arg->type = X86_IRQ_ALLOC_TYPE_PCI_MSIX;
 	} else {
 		arg->type = X86_IRQ_ALLOC_TYPE_PCI_MSI;
 		arg->flags |= X86_IRQ_ALLOC_CONTIGUOUS_VECTORS;
 	}
+}
+
+static void dev_msi_prepare(struct device *dev, msi_alloc_info_t *arg)
+{
+	arg->type = X86_IRQ_ALLOC_TYPE_DEV_MSI;
+}
+
+int x86_msi_prepare(struct irq_domain *domain, struct device *dev, int nvec,
+		    msi_alloc_info_t *arg)
+{
+	init_irq_alloc_info(arg, NULL);
+
+	if (dev_is_pci(dev))
+		pci_msi_prepare(dev, arg);
+	else
+		dev_msi_prepare(dev, arg);
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(pci_msi_prepare);
+EXPORT_SYMBOL_GPL(x86_msi_prepare);
 
 static struct msi_domain_ops pci_msi_domain_ops = {
-	.msi_prepare	= pci_msi_prepare,
+	.msi_prepare	= x86_msi_prepare,
 };
 
 static struct msi_domain_info pci_msi_domain_info = {
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -1532,7 +1532,7 @@ static struct irq_chip hv_msi_irq_chip =
 };
 
 static struct msi_domain_ops hv_msi_ops = {
-	.msi_prepare	= pci_msi_prepare,
+	.msi_prepare	= arch_msi_prepare,
 	.msi_free	= hv_msi_free,
 };
 
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -430,4 +430,8 @@ static inline struct irq_domain *pci_msi
 }
 #endif /* CONFIG_PCI_MSI_IRQ_DOMAIN */
 
+#ifndef arch_msi_prepare
+# define arch_msi_prepare	NULL
+#endif
+
 #endif /* LINUX_MSI_H */

