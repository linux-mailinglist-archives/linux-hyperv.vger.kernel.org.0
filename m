Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 289BE24CAA6
	for <lists+linux-hyperv@lfdr.de>; Fri, 21 Aug 2020 04:21:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728381AbgHUCUL (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 20 Aug 2020 22:20:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727125AbgHUCQq (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 20 Aug 2020 22:16:46 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1DE0C061386;
        Thu, 20 Aug 2020 19:16:44 -0700 (PDT)
Message-Id: <20200821002945.695825784@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1597976203;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=n+9JzjgCW829xt57cBjdIpc/3IF3JudgknsVK2IiGtk=;
        b=hduGjMZbM0/qwLquCj86fWVEcSBPc0Iv1xA1asxyvWI+3WaJk/FZv3obiS9pdKi2N4Xi55
        g2B24e5RBCG7WKFAQnorS3FWxwuVXn4z6S30wQ9GCVD8rtp+77IWCQCGVnhsf3znLjLhSM
        aQmZw2lG8elAmC//IGUjNVWAb+xaLL0KKz9IZ14ZS5Czuz7wC08nu5Y+pBKinVQ49JiyCU
        CXbMGhzaoeBIvlaaHMr23nvutvRUEOUuFrM649Lo5JGWcrMEOw972tIYLaoecwN/uLHyl2
        R6g+Wh1VCvbaQYIhXKJhJnK8aiSLIDvD0enema4nF0KLI5Yj7n1BELeKwzCgbA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1597976203;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=n+9JzjgCW829xt57cBjdIpc/3IF3JudgknsVK2IiGtk=;
        b=54vZUbSCVLbmLl/kEHzdwLB30JzHXmmLwe5GfkEeAMeKUbcsXnsiboZQzVlzf/vQeQ28JW
        WkKbSmHVLKTXoHDw==
Date:   Fri, 21 Aug 2020 02:24:28 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Joerg Roedel <joro@8bytes.org>,
        linux-hyperv@vger.kernel.org, iommu@lists.linux-foundation.org,
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
Subject: [patch RFC 04/38] x86/irq: Add allocation type for parent domain retrieval
References: <20200821002424.119492231@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline;
 filename="x86-irq--Add-allocation-flag-for-domain-retrieval.patch"
Content-transfer-encoding: 8-bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

irq_remapping_ir_irq_domain() is used to retrieve the remapping parent
domain for an allocation type. irq_remapping_irq_domain() is for retrieving
the actual device domain for allocating interrupts for a device.

The two functions are similar and can be unified by using explicit modes
for parent irq domain retrieval.

Add X86_IRQ_ALLOC_TYPE_IOAPIC/HPET_GET_PARENT and use it in the iommu
implementations. Drop the parent domain retrieval for PCI_MSI/X as that is
unused.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: x86@kernel.org
Cc: linux-hyperv@vger.kernel.org
Cc: iommu@lists.linux-foundation.org
Cc: Haiyang Zhang <haiyangz@microsoft.com>
Cc: Jon Derrick <jonathan.derrick@intel.com>
Cc: Lu Baolu <baolu.lu@linux.intel.com>
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

