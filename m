Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2705252E45
	for <lists+linux-hyperv@lfdr.de>; Wed, 26 Aug 2020 14:11:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729419AbgHZMLR (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 26 Aug 2020 08:11:17 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:57828 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729387AbgHZMBc (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 26 Aug 2020 08:01:32 -0400
Message-Id: <20200826112331.943993771@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598443271;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=smN5Lw4O6gmWewW32/CNzDhDg44t7zx2oz8Ohy7d/iE=;
        b=znarvJZWtDATtlJI8tOo2+tiLdVrGcoHLqDkmFaTrOTfXRWl8qVB6xD+GDQCsM7HmfRUrK
        JvKagkhyZlsO+Ugqesetp7KDtVkB4/Lu8nW9SalZiwbcrxrstycWplN4ZmzycRSSyGp4u9
        iZSfxMzZX5U00wrSxHqOcVWyETZKtM7FxRGeSYJMR0WZv+5oOX356Q4FQdRaqCO5QARFvA
        Bwk1NsKLYiudaIx8BkNsDFZ+KVAL6ym3iouXM6jKjT5OtGOg0dIfJKChOal3L26MWnBKmA
        ZH2npVDrfeeVUM7aaMuGSA93ZKeuhvb3Ra7zUmrKu77nvb0WQzrOxd6i+fZLlQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598443271;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=smN5Lw4O6gmWewW32/CNzDhDg44t7zx2oz8Ohy7d/iE=;
        b=d+LBHoPqo9jhxBe2+7tlgUGtfmujgPoaPeVgH14+w1GryJONvme6F47/Po20GiMhqzpwfk
        RUbqsNrpsGalcCBw==
Date:   Wed, 26 Aug 2020 13:16:41 +0200
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
Subject: [patch V2 13/46] x86/msi: Consolidate HPET allocation
References: <20200826111628.794979401@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

None of the magic HPET fields are required in any way.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 arch/x86/include/asm/hw_irq.h       |    7 -------
 arch/x86/kernel/apic/msi.c          |   14 +++++++-------
 drivers/iommu/amd/iommu.c           |    2 +-
 drivers/iommu/intel/irq_remapping.c |    4 ++--
 4 files changed, 10 insertions(+), 17 deletions(-)

--- a/arch/x86/include/asm/hw_irq.h
+++ b/arch/x86/include/asm/hw_irq.h
@@ -65,13 +65,6 @@ struct irq_alloc_info {
 
 	union {
 		int		unused;
-#ifdef	CONFIG_HPET_TIMER
-		struct {
-			int		hpet_id;
-			int		hpet_index;
-			void		*hpet_data;
-		};
-#endif
 #ifdef	CONFIG_PCI_MSI
 		struct {
 			struct pci_dev	*msi_dev;
--- a/arch/x86/kernel/apic/msi.c
+++ b/arch/x86/kernel/apic/msi.c
@@ -427,7 +427,7 @@ static struct irq_chip hpet_msi_controll
 static irq_hw_number_t hpet_msi_get_hwirq(struct msi_domain_info *info,
 					  msi_alloc_info_t *arg)
 {
-	return arg->hpet_index;
+	return arg->hwirq;
 }
 
 static int hpet_msi_init(struct irq_domain *domain,
@@ -435,8 +435,8 @@ static int hpet_msi_init(struct irq_doma
 			 irq_hw_number_t hwirq, msi_alloc_info_t *arg)
 {
 	irq_set_status_flags(virq, IRQ_MOVE_PCNTXT);
-	irq_domain_set_info(domain, virq, arg->hpet_index, info->chip, NULL,
-			    handle_edge_irq, arg->hpet_data, "edge");
+	irq_domain_set_info(domain, virq, arg->hwirq, info->chip, NULL,
+			    handle_edge_irq, arg->data, "edge");
 
 	return 0;
 }
@@ -477,7 +477,7 @@ struct irq_domain *hpet_create_irq_domai
 
 	init_irq_alloc_info(&info, NULL);
 	info.type = X86_IRQ_ALLOC_TYPE_HPET_GET_PARENT;
-	info.hpet_id = hpet_id;
+	info.devid = hpet_id;
 	parent = irq_remapping_get_irq_domain(&info);
 	if (parent == NULL)
 		parent = x86_vector_domain;
@@ -506,9 +506,9 @@ int hpet_assign_irq(struct irq_domain *d
 
 	init_irq_alloc_info(&info, NULL);
 	info.type = X86_IRQ_ALLOC_TYPE_HPET;
-	info.hpet_data = hc;
-	info.hpet_id = hpet_dev_id(domain);
-	info.hpet_index = dev_num;
+	info.data = hc;
+	info.devid = hpet_dev_id(domain);
+	info.hwirq = dev_num;
 
 	return irq_domain_alloc_irqs(domain, 1, NUMA_NO_NODE, &info);
 }
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -3511,7 +3511,7 @@ static int get_devid(struct irq_alloc_in
 		return get_ioapic_devid(info->ioapic_id);
 	case X86_IRQ_ALLOC_TYPE_HPET:
 	case X86_IRQ_ALLOC_TYPE_HPET_GET_PARENT:
-		return get_hpet_devid(info->hpet_id);
+		return get_hpet_devid(info->devid);
 	case X86_IRQ_ALLOC_TYPE_PCI_MSI:
 	case X86_IRQ_ALLOC_TYPE_PCI_MSIX:
 		return get_device_id(&info->msi_dev->dev);
--- a/drivers/iommu/intel/irq_remapping.c
+++ b/drivers/iommu/intel/irq_remapping.c
@@ -1115,7 +1115,7 @@ static struct irq_domain *intel_get_irq_
 	case X86_IRQ_ALLOC_TYPE_IOAPIC_GET_PARENT:
 		return map_ioapic_to_ir(info->ioapic_id);
 	case X86_IRQ_ALLOC_TYPE_HPET_GET_PARENT:
-		return map_hpet_to_ir(info->hpet_id);
+		return map_hpet_to_ir(info->devid);
 	case X86_IRQ_ALLOC_TYPE_PCI_MSI:
 	case X86_IRQ_ALLOC_TYPE_PCI_MSIX:
 		return map_dev_to_ir(info->msi_dev);
@@ -1285,7 +1285,7 @@ static void intel_irq_remapping_prepare_
 	case X86_IRQ_ALLOC_TYPE_PCI_MSI:
 	case X86_IRQ_ALLOC_TYPE_PCI_MSIX:
 		if (info->type == X86_IRQ_ALLOC_TYPE_HPET)
-			set_hpet_sid(irte, info->hpet_id);
+			set_hpet_sid(irte, info->devid);
 		else
 			set_msi_sid(irte, info->msi_dev);
 


