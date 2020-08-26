Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76915252D88
	for <lists+linux-hyperv@lfdr.de>; Wed, 26 Aug 2020 14:02:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729454AbgHZMCe (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 26 Aug 2020 08:02:34 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:58436 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729425AbgHZMB5 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 26 Aug 2020 08:01:57 -0400
Message-Id: <20200826112335.092521442@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598443311;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=b69SWJ3Ur45XxM77SmSu/tsjVczGdpPRTUPeP/VD4Ik=;
        b=sGq7w5VvBLEz68W/6n3xv/ju+gIZDsclrMN42Kbt+Lek2xpknqP50K1/N3zLQ3qy/tSs8i
        5FUrDzJiUCLsdEJZ4ovTq/PJQFLtIf/MfxmxW+nu6cwW9IfZO+2nncmzTnjpEbrV3MH6tj
        9b3brF3GgBQbP9y2bmXgCU8M4zoc2GmpJnNPYPngl4Q3CAXCKlffOoU2TbmM1e7rBtgxG5
        I955rjrk1V8U3FHUiSZO6UvjD62oqONm2qhsAdvpgboUJlslC/n2D3AmOJoiDXEw8WOFvk
        k66LV22FAJnV0xR9tR25lKLopG2+yp6AUrfyM0um/WMR7J6qyoLFz+U0tt9W2Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598443311;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=b69SWJ3Ur45XxM77SmSu/tsjVczGdpPRTUPeP/VD4Ik=;
        b=wIUepu9R9BwJrfL5hHLBQrW187phV08auxKlkm3THVUKZ6T3NRDo7Cxcy1mizpDRZnSQiD
        b3u1CTDbJZZ/EOBg==
Date:   Wed, 26 Aug 2020 13:17:13 +0200
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
Subject: [patch V2 45/46] irqdomain/msi: Provide msi_alloc/free_store() callbacks
References: <20200826111628.794979401@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

For devices which don't have a standard storage for MSI messages like the
upcoming IMS (Interrupt Message Storm) it's required to allocate storage
space before allocating interrupts and after freeing them.

This could be achieved with the existing callbacks, but that would be
awkward because they operate on msi_alloc_info_t which is not uniform
accross architectures. Also these callbacks are invoked per interrupt but
the allocation might have bulk requirements depending on the device.

As such devices can operate on different architectures it is simpler to
have seperate callbacks which operate on struct device. The resulting
storage information has to be stored in struct msi_desc so the underlying
irq chip implementation can retrieve it for the relevant operations.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 include/linux/msi.h |    8 ++++++++
 kernel/irq/msi.c    |   11 +++++++++++
 2 files changed, 19 insertions(+)

--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -279,6 +279,10 @@ struct msi_domain_info;
  *			function.
  * @domain_free_irqs:	Optional function to override the default free
  *			function.
+ * @msi_alloc_store:	Optional callback to allocate storage in a device
+ *			specific non-standard MSI store
+ * @msi_alloc_free:	Optional callback to free storage in a device
+ *			specific non-standard MSI store
  *
  * @get_hwirq, @msi_init and @msi_free are callbacks used by
  * msi_create_irq_domain() and related interfaces
@@ -328,6 +332,10 @@ struct msi_domain_ops {
 					     struct device *dev, int nvec);
 	void		(*domain_free_irqs)(struct irq_domain *domain,
 					    struct device *dev);
+	int		(*msi_alloc_store)(struct irq_domain *domain,
+					   struct device *dev, int nvec);
+	void		(*msi_free_store)(struct irq_domain *domain,
+					    struct device *dev);
 };
 
 /**
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -434,6 +434,12 @@ int __msi_domain_alloc_irqs(struct irq_d
 	if (ret)
 		return ret;
 
+	if (ops->msi_alloc_store) {
+		ret = ops->msi_alloc_store(domain, dev, nvec);
+		if (ret)
+			return ret;
+	}
+
 	for_each_msi_entry(desc, dev) {
 		ops->set_desc(&arg, desc);
 
@@ -533,6 +539,8 @@ int msi_domain_alloc_irqs(struct irq_dom
 
 void __msi_domain_free_irqs(struct irq_domain *domain, struct device *dev)
 {
+	struct msi_domain_info *info = domain->host_data;
+	struct msi_domain_ops *ops = info->ops;
 	struct msi_desc *desc;
 
 	for_each_msi_entry(desc, dev) {
@@ -546,6 +554,9 @@ void __msi_domain_free_irqs(struct irq_d
 			desc->irq = 0;
 		}
 	}
+
+	if (ops->msi_free_store)
+		ops->msi_free_store(domain, dev);
 }
 
 /**

