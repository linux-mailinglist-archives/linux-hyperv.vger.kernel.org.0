Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F30224CA6E
	for <lists+linux-hyperv@lfdr.de>; Fri, 21 Aug 2020 04:18:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728193AbgHUCSl (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 20 Aug 2020 22:18:41 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:52488 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727912AbgHUCRO (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 20 Aug 2020 22:17:14 -0400
Message-Id: <20200821002947.976983300@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1597976231;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=SGz3jtzA9Q1y95hnVuLxxhCEaendeRp/03jNV4aYAm8=;
        b=N2+U2u4I8yJg8VF+uL4FQq9guu91mSkYx2sWqM85NBILITb3QcvFgm3DFxyihU8cdO6L2r
        tjLGN4ImjBGwPeuIZo27Ukf2dhXy/slZLMN6IOkVCA2U0KMUQrtgLJy8hFf3CWnR8A6uYW
        t8Xgtgt7favibCuGa/mRXiQLNak7Xxj6xhZkiFkDTWwNRR0WIAnA6TMAGlUKDPc9uZoeM3
        dCXAofwGcByhVxrZT++YN5qD88X6DPgym6vieG2bSZeSDJHGp+nyRpxD4houiQjBvXz9DH
        gIJbh4Od3qhPa5HhYgTwFJo9kwDaUZ3hm5hVrna8JJwUYVfrgVppvdByPkSgmQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1597976231;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=SGz3jtzA9Q1y95hnVuLxxhCEaendeRp/03jNV4aYAm8=;
        b=ca4eWdnEIOSuKlOGPK+65FKofe5JXsumdjO2jo0sJX45NwsOG0Tk62i1rXRTSyUBmVAOfx
        wHjKYSP2PINyZoCA==
Date:   Fri, 21 Aug 2020 02:24:51 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux-foundation.org,
        Lu Baolu <baolu.lu@linux.intel.com>,
        linux-hyperv@vger.kernel.org,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Jon Derrick <jonathan.derrick@intel.com>,
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
Subject: [patch RFC 27/38] iommm/vt-d: Store irq domain in struct device
References: <20200821002424.119492231@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline;
 filename="iommm-vt-d--Store-irq-domain-in-struct-device.patch"
Content-transfer-encoding: 8-bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

As a first step to make X86 utilize the direct MSI irq domain operations
store the irq domain pointer in the device struct when a device is probed.

This is done from dmar_pci_bus_add_dev() because it has to work even when
DMA remapping is disabled. It only overrides the irqdomain of devices which
are handled by a regular PCI/MSI irq domain which protects PCI devices
behind special busses like VMD which have their own irq domain.

No functional change. It just avoids the redirection through
arch_*_msi_irqs() and allows the PCI/MSI core to directly invoke the irq
domain alloc/free functions instead of having to look up the irq domain for
every single MSI interupt.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux-foundation.org
Cc: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/dmar.c          |    3 +++
 drivers/iommu/intel/irq_remapping.c |   16 ++++++++++++++++
 include/linux/intel-iommu.h         |    5 +++++
 3 files changed, 24 insertions(+)

--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -316,6 +316,9 @@ static int dmar_pci_bus_add_dev(struct d
 	if (ret < 0 && dmar_dev_scope_status == 0)
 		dmar_dev_scope_status = ret;
 
+	if (ret >= 0)
+		intel_irq_remap_add_device(info);
+
 	return ret;
 }
 
--- a/drivers/iommu/intel/irq_remapping.c
+++ b/drivers/iommu/intel/irq_remapping.c
@@ -1086,6 +1086,22 @@ static int reenable_irq_remapping(int ei
 	return -1;
 }
 
+/*
+ * Store the MSI remapping domain pointer in the device if enabled.
+ *
+ * This is called from dmar_pci_bus_add_dev() so it works even when DMA
+ * remapping is disabled. Only update the pointer if the device is not
+ * already handled by a non default PCI/MSI interrupt domain. This protects
+ * e.g. VMD devices.
+ */
+void intel_irq_remap_add_device(struct dmar_pci_notify_info *info)
+{
+	if (!irq_remapping_enabled || pci_dev_has_special_msi_domain(info->dev))
+		return;
+
+	dev_set_msi_domain(&info->dev->dev, map_dev_to_ir(info->dev));
+}
+
 static void prepare_irte(struct irte *irte, int vector, unsigned int dest)
 {
 	memset(irte, 0, sizeof(*irte));
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -439,6 +439,11 @@ struct ir_table {
 	struct irte *base;
 	unsigned long *bitmap;
 };
+
+void intel_irq_remap_add_device(struct dmar_pci_notify_info *info);
+#else
+static inline void
+intel_irq_remap_add_device(struct dmar_pci_notify_info *info) { }
 #endif
 
 struct iommu_flush {

