Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAF06252E7D
	for <lists+linux-hyperv@lfdr.de>; Wed, 26 Aug 2020 14:14:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729951AbgHZMNf (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 26 Aug 2020 08:13:35 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:57606 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729381AbgHZMBX (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 26 Aug 2020 08:01:23 -0400
Message-Id: <20200826112331.741909337@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598443268;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=AgqtG7FWGG/aGAFBHu5WBpbnYbeqKy2fMcz2CwAcWys=;
        b=snoRszRWXNTq8lUaP7yhojk4htjebRsW3YGR8fE9Gmfx4qVobtdoAr26AWBP7qIQpliA4f
        7aFa2pBnsl9Ctw0m0pZ90ko8gj7NLGRIag9IPsjt0vCG9SfV5xYQm3iIZ3b4A+jj2KBP2r
        n7m7Z9h3VKo1mzE01T7/oJC/cA9cuTMdCMXitRoW+N/uLvRYqvOjNNtE0EnvBT57sOseIJ
        +ep5495Xm6M1vtZxqZoNXtIwPNaDD5YFbygXw/S7p52zaTUO8FgXMs/HT8CDB7PoJgBrCS
        PgBUXOPf4RweIoJl/JgGjSw0p2TonbjlkDh+/e7Po0YSgcxwAe3CB5qUgecnPw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598443268;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=AgqtG7FWGG/aGAFBHu5WBpbnYbeqKy2fMcz2CwAcWys=;
        b=nkWzhAcYABzUIpHke7RusnFIf+hrjRwwhuLGcmAEoC2SxHQAjUUdw1Le9FKphWcTohRd6/
        mLASKAi/R6fSbOCA==
Date:   Wed, 26 Aug 2020 13:16:39 +0200
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
Subject: [patch V2 11/46] iommu/irq_remapping: Consolidate irq domain lookup
References: <20200826111628.794979401@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

Now that the iommu implementations handle the X86_*_GET_PARENT_DOMAIN
types, consolidate the two getter functions.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 arch/x86/include/asm/irq_remapping.h |    8 --------
 arch/x86/kernel/apic/io_apic.c       |    2 +-
 arch/x86/kernel/apic/msi.c           |    2 +-
 drivers/iommu/amd/iommu.c            |    1 -
 drivers/iommu/hyperv-iommu.c         |    4 ++--
 drivers/iommu/intel/irq_remapping.c  |    1 -
 drivers/iommu/irq_remapping.c        |   23 +----------------------
 drivers/iommu/irq_remapping.h        |    5 +----
 8 files changed, 6 insertions(+), 40 deletions(-)

--- a/arch/x86/include/asm/irq_remapping.h
+++ b/arch/x86/include/asm/irq_remapping.h
@@ -45,8 +45,6 @@ extern int irq_remap_enable_fault_handli
 extern void panic_if_irq_remap(const char *msg);
 
 extern struct irq_domain *
-irq_remapping_get_ir_irq_domain(struct irq_alloc_info *info);
-extern struct irq_domain *
 irq_remapping_get_irq_domain(struct irq_alloc_info *info);
 
 /* Create PCI MSI/MSIx irqdomain, use @parent as the parent irqdomain. */
@@ -74,12 +72,6 @@ static inline void panic_if_irq_remap(co
 }
 
 static inline struct irq_domain *
-irq_remapping_get_ir_irq_domain(struct irq_alloc_info *info)
-{
-	return NULL;
-}
-
-static inline struct irq_domain *
 irq_remapping_get_irq_domain(struct irq_alloc_info *info)
 {
 	return NULL;
--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -2298,7 +2298,7 @@ static int mp_irqdomain_create(int ioapi
 	init_irq_alloc_info(&info, NULL);
 	info.type = X86_IRQ_ALLOC_TYPE_IOAPIC_GET_PARENT;
 	info.ioapic_id = mpc_ioapic_id(ioapic);
-	parent = irq_remapping_get_ir_irq_domain(&info);
+	parent = irq_remapping_get_irq_domain(&info);
 	if (!parent)
 		parent = x86_vector_domain;
 	else
--- a/arch/x86/kernel/apic/msi.c
+++ b/arch/x86/kernel/apic/msi.c
@@ -478,7 +478,7 @@ struct irq_domain *hpet_create_irq_domai
 	init_irq_alloc_info(&info, NULL);
 	info.type = X86_IRQ_ALLOC_TYPE_HPET_GET_PARENT;
 	info.hpet_id = hpet_id;
-	parent = irq_remapping_get_ir_irq_domain(&info);
+	parent = irq_remapping_get_irq_domain(&info);
 	if (parent == NULL)
 		parent = x86_vector_domain;
 	else
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -3561,7 +3561,6 @@ struct irq_remap_ops amd_iommu_irq_ops =
 	.disable		= amd_iommu_disable,
 	.reenable		= amd_iommu_reenable,
 	.enable_faulting	= amd_iommu_enable_faulting,
-	.get_ir_irq_domain	= get_irq_domain,
 	.get_irq_domain		= get_irq_domain,
 };
 
--- a/drivers/iommu/hyperv-iommu.c
+++ b/drivers/iommu/hyperv-iommu.c
@@ -182,7 +182,7 @@ static int __init hyperv_enable_irq_rema
 	return IRQ_REMAP_X2APIC_MODE;
 }
 
-static struct irq_domain *hyperv_get_ir_irq_domain(struct irq_alloc_info *info)
+static struct irq_domain *hyperv_get_irq_domain(struct irq_alloc_info *info)
 {
 	if (info->type == X86_IRQ_ALLOC_TYPE_IOAPIC_GET_PARENT)
 		return ioapic_ir_domain;
@@ -193,7 +193,7 @@ static struct irq_domain *hyperv_get_ir_
 struct irq_remap_ops hyperv_irq_remap_ops = {
 	.prepare		= hyperv_prepare_irq_remapping,
 	.enable			= hyperv_enable_irq_remapping,
-	.get_ir_irq_domain	= hyperv_get_ir_irq_domain,
+	.get_irq_domain		= hyperv_get_irq_domain,
 };
 
 #endif
--- a/drivers/iommu/intel/irq_remapping.c
+++ b/drivers/iommu/intel/irq_remapping.c
@@ -1131,7 +1131,6 @@ struct irq_remap_ops intel_irq_remap_ops
 	.disable		= disable_irq_remapping,
 	.reenable		= reenable_irq_remapping,
 	.enable_faulting	= enable_drhd_fault_handling,
-	.get_ir_irq_domain	= intel_get_irq_domain,
 	.get_irq_domain		= intel_get_irq_domain,
 };
 
--- a/drivers/iommu/irq_remapping.c
+++ b/drivers/iommu/irq_remapping.c
@@ -160,33 +160,12 @@ void panic_if_irq_remap(const char *msg)
 }
 
 /**
- * irq_remapping_get_ir_irq_domain - Get the irqdomain associated with the IOMMU
- *				     device serving request @info
- * @info: interrupt allocation information, used to identify the IOMMU device
- *
- * It's used to get parent irqdomain for HPET and IOAPIC irqdomains.
- * Returns pointer to IRQ domain, or NULL on failure.
- */
-struct irq_domain *
-irq_remapping_get_ir_irq_domain(struct irq_alloc_info *info)
-{
-	if (!remap_ops || !remap_ops->get_ir_irq_domain)
-		return NULL;
-
-	return remap_ops->get_ir_irq_domain(info);
-}
-
-/**
  * irq_remapping_get_irq_domain - Get the irqdomain serving the request @info
  * @info: interrupt allocation information, used to identify the IOMMU device
  *
- * There will be one PCI MSI/MSIX irqdomain associated with each interrupt
- * remapping device, so this interface is used to retrieve the PCI MSI/MSIX
- * irqdomain serving request @info.
  * Returns pointer to IRQ domain, or NULL on failure.
  */
-struct irq_domain *
-irq_remapping_get_irq_domain(struct irq_alloc_info *info)
+struct irq_domain *irq_remapping_get_irq_domain(struct irq_alloc_info *info)
 {
 	if (!remap_ops || !remap_ops->get_irq_domain)
 		return NULL;
--- a/drivers/iommu/irq_remapping.h
+++ b/drivers/iommu/irq_remapping.h
@@ -43,10 +43,7 @@ struct irq_remap_ops {
 	/* Enable fault handling */
 	int  (*enable_faulting)(void);
 
-	/* Get the irqdomain associated the IOMMU device */
-	struct irq_domain *(*get_ir_irq_domain)(struct irq_alloc_info *);
-
-	/* Get the MSI irqdomain associated with the IOMMU device */
+	/* Get the irqdomain associated to IOMMU device */
 	struct irq_domain *(*get_irq_domain)(struct irq_alloc_info *);
 };
 


