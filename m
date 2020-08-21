Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 729F024CAA0
	for <lists+linux-hyperv@lfdr.de>; Fri, 21 Aug 2020 04:21:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727987AbgHUCUK (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 20 Aug 2020 22:20:10 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:52488 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727781AbgHUCQr (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 20 Aug 2020 22:16:47 -0400
Message-Id: <20200821002945.900916572@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1597976205;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=oPLGYXskeh4/rvO1snnuNNIL8qDSVSv9t9JMacNnWYI=;
        b=C0DH7n71olL6OaMb6xCv5gAfA57y0QmW2I4o08cPmj0GOAOhOCaKnWIpKlOZm113g1QECQ
        MB4bck5wvdWs0pANVDcsAl+HOWRmntG9RJb6qJszHXuxYJv8/kUGPFXWYw8GMktd51/rFg
        XjdiTuWZw55z6IYYXYh8d7HPkihKPpkK9Q1cTO4GuytPsArOoJK/zZB9Wyv9rMl5XhjKRe
        mL1DBryNveNqFUgUCvc0WifpQskm8RT28ojrmG3wfiiw+HxioOsIZCkx1S7nvUCc4t/Smb
        +iJa6iuJUDKzAkLaigcCOQmypYCHfpq/3fSMYVM/XRTwddtOG7QIR93snAshRw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1597976205;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=oPLGYXskeh4/rvO1snnuNNIL8qDSVSv9t9JMacNnWYI=;
        b=ozcMcI+ZbXw6YII64CpI8GaIQ1ifio0XwKEr5Vos+W3E9/tR8I879FwYP0xpqYlyXK+5b2
        /x0IpmfwMOH4fYCg==
Date:   Fri, 21 Aug 2020 02:24:30 +0200
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
Subject: [patch RFC 06/38] iommu/amd: Consolidate irq domain getter
References: <20200821002424.119492231@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline;
 filename="iommu-amd--Condolidate-irq-domain-getter.patch"
Content-transfer-encoding: 8-bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

The irq domain request mode is now indicated in irq_alloc_info::type.

Consolidate the two getter functions into one.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux-foundation.org
---
 drivers/iommu/amd/iommu.c |   65 ++++++++++++++--------------------------------
 1 file changed, 21 insertions(+), 44 deletions(-)

--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -3505,77 +3505,54 @@ static void irte_ga_clear_allocated(stru
 
 static int get_devid(struct irq_alloc_info *info)
 {
-	int devid = -1;
-
 	switch (info->type) {
 	case X86_IRQ_ALLOC_TYPE_IOAPIC:
-		devid     = get_ioapic_devid(info->ioapic_id);
-		break;
+	case X86_IRQ_ALLOC_TYPE_IOAPIC_GET_PARENT:
+		return get_ioapic_devid(info->ioapic_id);
 	case X86_IRQ_ALLOC_TYPE_HPET:
-		devid     = get_hpet_devid(info->hpet_id);
-		break;
+	case X86_IRQ_ALLOC_TYPE_HPET_GET_PARENT:
+		return get_hpet_devid(info->hpet_id);
 	case X86_IRQ_ALLOC_TYPE_PCI_MSI:
 	case X86_IRQ_ALLOC_TYPE_PCI_MSIX:
-		devid = get_device_id(&info->msi_dev->dev);
-		break;
+		return get_device_id(&info->msi_dev->dev);
 	default:
-		BUG_ON(1);
-		break;
+		WARN_ON_ONCE(1);
+		return -1;
 	}
-
-	return devid;
 }
 
-static struct irq_domain *get_ir_irq_domain(struct irq_alloc_info *info)
+static struct irq_domain *get_irq_domain_for_devid(struct irq_alloc_info *info,
+						   int devid)
 {
-	struct amd_iommu *iommu;
-	int devid;
+	struct amd_iommu *iommu = amd_iommu_rlookup_table[devid];
 
-	if (!info)
+	if (!iommu)
 		return NULL;
 
 	switch (info->type) {
 	case X86_IRQ_ALLOC_TYPE_IOAPIC_GET_PARENT:
 	case X86_IRQ_ALLOC_TYPE_HPET_GET_PARENT:
-		break;
+		return iommu->ir_domain;
+	case X86_IRQ_ALLOC_TYPE_PCI_MSI:
+	case X86_IRQ_ALLOC_TYPE_PCI_MSIX:
+		return iommu->msi_domain;
 	default:
+		WARN_ON_ONCE(1);
 		return NULL;
 	}
-
-	devid = get_devid(info);
-	if (devid >= 0) {
-		iommu = amd_iommu_rlookup_table[devid];
-		if (iommu)
-			return iommu->ir_domain;
-	}
-
-	return NULL;
 }
 
 static struct irq_domain *get_irq_domain(struct irq_alloc_info *info)
 {
-	struct amd_iommu *iommu;
 	int devid;
 
 	if (!info)
 		return NULL;
 
-	switch (info->type) {
-	case X86_IRQ_ALLOC_TYPE_PCI_MSI:
-	case X86_IRQ_ALLOC_TYPE_PCI_MSIX:
-		devid = get_device_id(&info->msi_dev->dev);
-		if (devid < 0)
-			return NULL;
-
-		iommu = amd_iommu_rlookup_table[devid];
-		if (iommu)
-			return iommu->msi_domain;
-		break;
-	default:
-		break;
-	}
-
-	return NULL;
+	devid = get_devid(info);
+	if (devid < 0)
+		return NULL;
+	return get_irq_domain_for_devid(info, devid);
 }
 
 struct irq_remap_ops amd_iommu_irq_ops = {
@@ -3584,7 +3561,7 @@ struct irq_remap_ops amd_iommu_irq_ops =
 	.disable		= amd_iommu_disable,
 	.reenable		= amd_iommu_reenable,
 	.enable_faulting	= amd_iommu_enable_faulting,
-	.get_ir_irq_domain	= get_ir_irq_domain,
+	.get_ir_irq_domain	= get_irq_domain,
 	.get_irq_domain		= get_irq_domain,
 };
 

