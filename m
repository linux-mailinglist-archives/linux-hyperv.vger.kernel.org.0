Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34DAF252E56
	for <lists+linux-hyperv@lfdr.de>; Wed, 26 Aug 2020 14:12:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729884AbgHZMLO (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 26 Aug 2020 08:11:14 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:57542 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729394AbgHZMBd (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 26 Aug 2020 08:01:33 -0400
Message-Id: <20200826112333.139387358@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598443286;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=+WzR5MCuCex7ytf6rjsXfS+TP5lRyvSEuqbO3kY2ypY=;
        b=AFAYy1AZODdBAXiQF7D/2Af8hjoA4F8whD1dpfxhZK0wDTkBf3sx/VW4O7HKpqAFQF6LfQ
        XqAnO4Jday9Dy+ZAnDZuaZIcexHC5k39FSw5iwposD/R9Hh5EubsWwJv9/VREawRgyHgD0
        CJrI9TXEVoVnmeZEEdDR73bytPy2vid/IRs7h2lro8AX8dn3PHz6Up96z37+dXPCe9s8FO
        Jbf8kKTgVcXc0g9b3oirnxBiTzC21Iy1eeEsFbcC6bnLXB7fls4O14ynXejBtmZBynS/cT
        nqFa+ajT5XGYIQYNicdr9NM1gu9bnuAyf5ubP6NEsBw3LzgzK18Bvd4eQmq+Dg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598443286;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=+WzR5MCuCex7ytf6rjsXfS+TP5lRyvSEuqbO3kY2ypY=;
        b=u2ouyFH0DTUgP45ogWuZh8vqAlI+1eKXuHYVXRV5MEZcJUmzJuBp+ygWAV3omQ2ec9yiFP
        sQTZJqjSD3yBN0Dw==
Date:   Wed, 26 Aug 2020 13:16:53 +0200
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
Subject: [patch V2 25/46] PCI/MSI: Provide pci_dev_has_special_msi_domain() helper
References: <20200826111628.794979401@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

Provide a helper function to check whether a PCI device is handled by a
non-standard PCI/MSI domain. This will be used to exclude such devices
which hang of a special bus, e.g. VMD, to be excluded from the irq domain
override in irq remapping.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/msi.c   |   22 ++++++++++++++++++++++
 include/linux/msi.h |    1 +
 2 files changed, 23 insertions(+)

--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -1553,4 +1553,26 @@ struct irq_domain *pci_msi_get_device_do
 					     DOMAIN_BUS_PCI_MSI);
 	return dom;
 }
+
+/**
+ * pci_dev_has_special_msi_domain - Check whether the device is handled by
+ *				    a non-standard PCI-MSI domain
+ * @pdev:	The PCI device to check.
+ *
+ * Returns: True if the device irqdomain or the bus irqdomain is
+ * non-standard PCI/MSI.
+ */
+bool pci_dev_has_special_msi_domain(struct pci_dev *pdev)
+{
+	struct irq_domain *dom = dev_get_msi_domain(&pdev->dev);
+
+	if (!dom)
+		dom = dev_get_msi_domain(&pdev->bus->dev);
+
+	if (!dom)
+		return true;
+
+	return dom->bus_token != DOMAIN_BUS_PCI_MSI;
+}
+
 #endif /* CONFIG_PCI_MSI_IRQ_DOMAIN */
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -374,6 +374,7 @@ int pci_msi_domain_check_cap(struct irq_
 			     struct msi_domain_info *info, struct device *dev);
 u32 pci_msi_domain_get_msi_rid(struct irq_domain *domain, struct pci_dev *pdev);
 struct irq_domain *pci_msi_get_device_domain(struct pci_dev *pdev);
+bool pci_dev_has_special_msi_domain(struct pci_dev *pdev);
 #else
 static inline struct irq_domain *pci_msi_get_device_domain(struct pci_dev *pdev)
 {

