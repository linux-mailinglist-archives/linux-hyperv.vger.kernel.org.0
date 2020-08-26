Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A26A252D78
	for <lists+linux-hyperv@lfdr.de>; Wed, 26 Aug 2020 14:01:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729427AbgHZMBy (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 26 Aug 2020 08:01:54 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:57906 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729395AbgHZMBe (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 26 Aug 2020 08:01:34 -0400
Message-Id: <20200826112331.530546013@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598443266;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=u1yYqnSZZDMMoV9tW/nQF0JmP98FzCrk6ksyf7BvRgs=;
        b=kcbYH/xLrUAPJ6fWejOeJmxHcJDtKvq9rSmjVFfexK1fGAerVZEcPvhUq/Yew/wTSQUxQA
        nYDgNz2x9gVWr9YdEQXXW0/VcVXT6+SYH6p8Pyg8LMws06CpAnLkPedYCmO3f2I9OLqFZC
        16SjJaTyVMLuhEx4zWaHmggPOa/fosS1Fq7g8m+hzqpJbS1dA17hIkTlOSEM+4V1C3Wna4
        KXGIFDSYKSWp2EXIYFP8vuYyh2bqmw9EgsOEgcMI4J/Dvpl40jcQyeoFMFpF2CAHjFrcVJ
        TwP8ELN56HifujjCfZXWP2+C1SEu5/OwFOCAvmXbM99ahdOwcMZQk1h/7bsxwg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598443266;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=u1yYqnSZZDMMoV9tW/nQF0JmP98FzCrk6ksyf7BvRgs=;
        b=iI5qSUQDjqoguOE0M0yhLqFGsfgkjHhT91vZR8ljMovSZDUawcj8oW/wubtZ3EtOdx3Jc7
        jK0U+RgVJOpYeYAg==
Date:   Wed, 26 Aug 2020 13:16:37 +0200
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
Subject: [patch V2 09/46] iommu/vt-d: Consolidate irq domain getter
References: <20200826111628.794979401@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

The irq domain request mode is now indicated in irq_alloc_info::type.

Consolidate the two getter functions into one.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 drivers/iommu/intel/irq_remapping.c |   67 ++++++++++++------------------------
 1 file changed, 24 insertions(+), 43 deletions(-)

--- a/drivers/iommu/intel/irq_remapping.c
+++ b/drivers/iommu/intel/irq_remapping.c
@@ -204,35 +204,40 @@ static int modify_irte(struct irq_2_iomm
 	return rc;
 }
 
-static struct intel_iommu *map_hpet_to_ir(u8 hpet_id)
+static struct irq_domain *map_hpet_to_ir(u8 hpet_id)
 {
 	int i;
 
-	for (i = 0; i < MAX_HPET_TBS; i++)
+	for (i = 0; i < MAX_HPET_TBS; i++) {
 		if (ir_hpet[i].id == hpet_id && ir_hpet[i].iommu)
-			return ir_hpet[i].iommu;
+			return ir_hpet[i].iommu->ir_domain;
+	}
 	return NULL;
 }
 
-static struct intel_iommu *map_ioapic_to_ir(int apic)
+static struct intel_iommu *map_ioapic_to_iommu(int apic)
 {
 	int i;
 
-	for (i = 0; i < MAX_IO_APICS; i++)
+	for (i = 0; i < MAX_IO_APICS; i++) {
 		if (ir_ioapic[i].id == apic && ir_ioapic[i].iommu)
 			return ir_ioapic[i].iommu;
+	}
 	return NULL;
 }
 
-static struct intel_iommu *map_dev_to_ir(struct pci_dev *dev)
+static struct irq_domain *map_ioapic_to_ir(int apic)
 {
-	struct dmar_drhd_unit *drhd;
+	struct intel_iommu *iommu = map_ioapic_to_iommu(apic);
 
-	drhd = dmar_find_matched_drhd_unit(dev);
-	if (!drhd)
-		return NULL;
+	return iommu ? iommu->ir_domain : NULL;
+}
+
+static struct irq_domain *map_dev_to_ir(struct pci_dev *dev)
+{
+	struct dmar_drhd_unit *drhd = dmar_find_matched_drhd_unit(dev);
 
-	return drhd->iommu;
+	return drhd ? drhd->iommu->ir_msi_domain : NULL;
 }
 
 static int clear_entries(struct irq_2_iommu *irq_iommu)
@@ -996,7 +1001,7 @@ static int __init parse_ioapics_under_ir
 
 	for (ioapic_idx = 0; ioapic_idx < nr_ioapics; ioapic_idx++) {
 		int ioapic_id = mpc_ioapic_id(ioapic_idx);
-		if (!map_ioapic_to_ir(ioapic_id)) {
+		if (!map_ioapic_to_iommu(ioapic_id)) {
 			pr_err(FW_BUG "ioapic %d has no mapping iommu, "
 			       "interrupt remapping will be disabled\n",
 			       ioapic_id);
@@ -1101,47 +1106,23 @@ static void prepare_irte(struct irte *ir
 	irte->redir_hint = 1;
 }
 
-static struct irq_domain *intel_get_ir_irq_domain(struct irq_alloc_info *info)
+static struct irq_domain *intel_get_irq_domain(struct irq_alloc_info *info)
 {
-	struct intel_iommu *iommu = NULL;
-
 	if (!info)
 		return NULL;
 
 	switch (info->type) {
 	case X86_IRQ_ALLOC_TYPE_IOAPIC_GET_PARENT:
-		iommu = map_ioapic_to_ir(info->ioapic_id);
-		break;
+		return map_ioapic_to_ir(info->ioapic_id);
 	case X86_IRQ_ALLOC_TYPE_HPET_GET_PARENT:
-		iommu = map_hpet_to_ir(info->hpet_id);
-		break;
-	default:
-		BUG_ON(1);
-		break;
-	}
-
-	return iommu ? iommu->ir_domain : NULL;
-}
-
-static struct irq_domain *intel_get_irq_domain(struct irq_alloc_info *info)
-{
-	struct intel_iommu *iommu;
-
-	if (!info)
-		return NULL;
-
-	switch (info->type) {
+		return map_hpet_to_ir(info->hpet_id);
 	case X86_IRQ_ALLOC_TYPE_PCI_MSI:
 	case X86_IRQ_ALLOC_TYPE_PCI_MSIX:
-		iommu = map_dev_to_ir(info->msi_dev);
-		if (iommu)
-			return iommu->ir_msi_domain;
-		break;
+		return map_dev_to_ir(info->msi_dev);
 	default:
-		break;
+		WARN_ON_ONCE(1);
+		return NULL;
 	}
-
-	return NULL;
 }
 
 struct irq_remap_ops intel_irq_remap_ops = {
@@ -1150,7 +1131,7 @@ struct irq_remap_ops intel_irq_remap_ops
 	.disable		= disable_irq_remapping,
 	.reenable		= reenable_irq_remapping,
 	.enable_faulting	= enable_drhd_fault_handling,
-	.get_ir_irq_domain	= intel_get_ir_irq_domain,
+	.get_ir_irq_domain	= intel_get_irq_domain,
 	.get_irq_domain		= intel_get_irq_domain,
 };
 


