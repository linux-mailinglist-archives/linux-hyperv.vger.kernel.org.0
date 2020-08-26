Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 209E3252E75
	for <lists+linux-hyperv@lfdr.de>; Wed, 26 Aug 2020 14:14:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729381AbgHZMNv (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 26 Aug 2020 08:13:51 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:57542 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729378AbgHZMBU (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 26 Aug 2020 08:01:20 -0400
Message-Id: <20200826112331.436350257@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598443265;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=LUY6bepF5eim7BkWUhA3OwSWPbqokviVOoRM/Igptr8=;
        b=ioAWTpDPlTteMzT1FEkboO63d5kq9hA1V+HXhkkXU/cJBtUIqlh0H5GJpaONmKMx01dkVC
        cXLH8uDJKuqu6WJN8NqpjxKLQ6DEzsr/wu1O3AMNEwnJ5AdtrDNTmWChZFw14rroM9UORX
        vhBrWXM5j4b7/5Ch5voZC1EAQlIHqUEk9621/7pwq0qdtyFz0spYN49aYibIQfgNfbpdXU
        JL41HRyN1Bfw3dcGoXYrhckaLb6Pep/MNBZc7m/tQUuXU+f+dJOGhpUabTpO/wPeLP+Dxv
        1O5ykMdao0srwY8Q42I8uveNL0+DGF4vu2tGBhJNCzTvz9KOy3lOJOy2NK6CpA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598443265;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=LUY6bepF5eim7BkWUhA3OwSWPbqokviVOoRM/Igptr8=;
        b=0eV1hNfWxwm4e+VS9L+QCLBWyodY+aOtuxJmr2j4yW1nKHrZNOrCVU4B114C71sSnoFFD4
        eFjXZ9OCOIEXjbBQ==
Date:   Wed, 26 Aug 2020 13:16:36 +0200
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
Subject: [patch V2 08/46] x86/irq: Add allocation type for parent domain retrieval
References: <20200826111628.794979401@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

irq_remapping_ir_irq_domain() is used to retrieve the remapping parent
domain for an allocation type. irq_remapping_irq_domain() is for retrieving
the actual device domain for allocating interrupts for a device.

The two functions are similar and can be unified by using explicit modes
for parent irq domain retrieval.

Add X86_IRQ_ALLOC_TYPE_IOAPIC/HPET_GET_PARENT and use it in the iommu
implementations. Drop the parent domain retrieval for PCI_MSI/X as that is
unused.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 arch/x86/include/asm/hw_irq.h       |    2 ++
 arch/x86/kernel/apic/io_apic.c      |    2 +-
 arch/x86/kernel/apic/msi.c          |    2 +-
 drivers/iommu/amd/iommu.c           |    8 ++++++++
 drivers/iommu/hyperv-iommu.c        |    2 +-
 drivers/iommu/intel/irq_remapping.c |    8 ++------
 6 files changed, 15 insertions(+), 9 deletions(-)

--- a/arch/x86/include/asm/hw_irq.h
+++ b/arch/x86/include/asm/hw_irq.h
@@ -40,6 +40,8 @@ enum irq_alloc_type {
 	X86_IRQ_ALLOC_TYPE_PCI_MSIX,
 	X86_IRQ_ALLOC_TYPE_DMAR,
 	X86_IRQ_ALLOC_TYPE_UV,
+	X86_IRQ_ALLOC_TYPE_IOAPIC_GET_PARENT,
+	X86_IRQ_ALLOC_TYPE_HPET_GET_PARENT,
 };
 
 struct irq_alloc_info {
--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -2296,7 +2296,7 @@ static int mp_irqdomain_create(int ioapi
 		return 0;
 
 	init_irq_alloc_info(&info, NULL);
-	info.type = X86_IRQ_ALLOC_TYPE_IOAPIC;
+	info.type = X86_IRQ_ALLOC_TYPE_IOAPIC_GET_PARENT;
 	info.ioapic_id = mpc_ioapic_id(ioapic);
 	parent = irq_remapping_get_ir_irq_domain(&info);
 	if (!parent)
--- a/arch/x86/kernel/apic/msi.c
+++ b/arch/x86/kernel/apic/msi.c
@@ -476,7 +476,7 @@ struct irq_domain *hpet_create_irq_domai
 	domain_info->data = (void *)(long)hpet_id;
 
 	init_irq_alloc_info(&info, NULL);
-	info.type = X86_IRQ_ALLOC_TYPE_HPET;
+	info.type = X86_IRQ_ALLOC_TYPE_HPET_GET_PARENT;
 	info.hpet_id = hpet_id;
 	parent = irq_remapping_get_ir_irq_domain(&info);
 	if (parent == NULL)
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -3534,6 +3534,14 @@ static struct irq_domain *get_ir_irq_dom
 	if (!info)
 		return NULL;
 
+	switch (info->type) {
+	case X86_IRQ_ALLOC_TYPE_IOAPIC_GET_PARENT:
+	case X86_IRQ_ALLOC_TYPE_HPET_GET_PARENT:
+		break;
+	default:
+		return NULL;
+	}
+
 	devid = get_devid(info);
 	if (devid >= 0) {
 		iommu = amd_iommu_rlookup_table[devid];
--- a/drivers/iommu/hyperv-iommu.c
+++ b/drivers/iommu/hyperv-iommu.c
@@ -184,7 +184,7 @@ static int __init hyperv_enable_irq_rema
 
 static struct irq_domain *hyperv_get_ir_irq_domain(struct irq_alloc_info *info)
 {
-	if (info->type == X86_IRQ_ALLOC_TYPE_IOAPIC)
+	if (info->type == X86_IRQ_ALLOC_TYPE_IOAPIC_GET_PARENT)
 		return ioapic_ir_domain;
 	else
 		return NULL;
--- a/drivers/iommu/intel/irq_remapping.c
+++ b/drivers/iommu/intel/irq_remapping.c
@@ -1109,16 +1109,12 @@ static struct irq_domain *intel_get_ir_i
 		return NULL;
 
 	switch (info->type) {
-	case X86_IRQ_ALLOC_TYPE_IOAPIC:
+	case X86_IRQ_ALLOC_TYPE_IOAPIC_GET_PARENT:
 		iommu = map_ioapic_to_ir(info->ioapic_id);
 		break;
-	case X86_IRQ_ALLOC_TYPE_HPET:
+	case X86_IRQ_ALLOC_TYPE_HPET_GET_PARENT:
 		iommu = map_hpet_to_ir(info->hpet_id);
 		break;
-	case X86_IRQ_ALLOC_TYPE_PCI_MSI:
-	case X86_IRQ_ALLOC_TYPE_PCI_MSIX:
-		iommu = map_dev_to_ir(info->msi_dev);
-		break;
 	default:
 		BUG_ON(1);
 		break;


