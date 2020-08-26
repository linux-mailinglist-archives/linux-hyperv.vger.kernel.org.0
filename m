Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7407252E2F
	for <lists+linux-hyperv@lfdr.de>; Wed, 26 Aug 2020 14:10:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729738AbgHZMKX (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 26 Aug 2020 08:10:23 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:57670 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729405AbgHZMBg (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 26 Aug 2020 08:01:36 -0400
Message-Id: <20200826112333.806328762@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598443294;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=asFOSA32T62YaRCSzrTor6aeI57DpOL3CUuGKRRZsEk=;
        b=nW2KeZ1gqPVv2gyaRKq8TR1UkwXl0haOMGUN03QRISdwQmfCn7UJwXCHQXWSfPgpIa+WE5
        dFV5V8IpWj0OJ5/D7iaEmAAzia9sMireqBKNTgfwBW0x32c8WcLBFqyY4C3zXLZl0pKZ9S
        kbvZoHvciBXwqW1PY4VzXjvXqcmQjVynrEJnQe4+Vy7Tv8omIDJ2tjEuvictoUTMcGSKpF
        bwvwqQcGDIe6TqfooJCNM+0WtHU0xfoqHLKxazezkBOMG3xzacun6q8a4wPa4LcFbmUIkZ
        D9Eyz1ErgNGXpUdNgnbQSGl0sWAvf10vqBSj5tjVkoI6kOyIqsXE1tw+oQQTwQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598443294;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=asFOSA32T62YaRCSzrTor6aeI57DpOL3CUuGKRRZsEk=;
        b=rGD9yaPSSC0dyJal0i0gvsXCtRDpI7ulC+ReNWLDGiw7Ztg5ZQgzYmYvFhwrOM19cmby/R
        4PQn9wIN97sJZqAg==
Date:   Wed, 26 Aug 2020 13:17:00 +0200
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
Subject: [patch V2 32/46] iommm/amd: Store irq domain in struct device
References: <20200826111628.794979401@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

As the next step to make X86 utilize the direct MSI irq domain operations
store the irq domain pointer in the device struct when a device is probed.

It only overrides the irqdomain of devices which are handled by a regular
PCI/MSI irq domain which protects PCI devices behind special busses like
VMD which have their own irq domain.

No functional change.

It just avoids the redirection through arch_*_msi_irqs() and allows the
PCI/MSI core to directly invoke the irq domain alloc/free functions instead
of having to look up the irq domain for every single MSI interupt.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 drivers/iommu/amd/iommu.c |   17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -729,7 +729,21 @@ static void iommu_poll_ga_log(struct amd
 		}
 	}
 }
-#endif /* CONFIG_IRQ_REMAP */
+
+static void
+amd_iommu_set_pci_msi_domain(struct device *dev, struct amd_iommu *iommu)
+{
+	if (!irq_remapping_enabled || !dev_is_pci(dev) ||
+	    pci_dev_has_special_msi_domain(to_pci_dev(dev)))
+		return;
+
+	dev_set_msi_domain(dev, iommu->msi_domain);
+}
+
+#else /* CONFIG_IRQ_REMAP */
+static inline void
+amd_iommu_set_pci_msi_domain(struct device *dev, struct amd_iommu *iommu) { }
+#endif /* !CONFIG_IRQ_REMAP */
 
 #define AMD_IOMMU_INT_MASK	\
 	(MMIO_STATUS_EVT_INT_MASK | \
@@ -2157,6 +2171,7 @@ static struct iommu_device *amd_iommu_pr
 		iommu_dev = ERR_PTR(ret);
 		iommu_ignore_device(dev);
 	} else {
+		amd_iommu_set_pci_msi_domain(dev, iommu);
 		iommu_dev = &iommu->iommu;
 	}
 


