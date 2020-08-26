Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9765D252DFD
	for <lists+linux-hyperv@lfdr.de>; Wed, 26 Aug 2020 14:08:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729777AbgHZMIQ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 26 Aug 2020 08:08:16 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:57868 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729423AbgHZMBx (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 26 Aug 2020 08:01:53 -0400
Message-Id: <20200826112334.985197056@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598443309;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=BMT6qDj2uBUhNhaXmY2IZfaaybCNXAgFl59YZnlPXcU=;
        b=y2aaM3VTRpFprInazgsfdsQRk1PfHKEcBEufPY5JCHo6TjB1GrAUgauLTHxn1/0tIDz5pR
        eR8f7TDSOicZrqu4MAejG2lcgOjnVXjnECCL+ZYRb1FRR6tZLz+otnfi8jTdiWsgPArHGX
        zyXyHn+KDgPQC5fAwhXvedQ6r3SPMEMBDKykGGhjcVVn4qGlyu5KXtFZDYUrPTO5A/oL6c
        /6uq8IDJLdA0LntLvunkvoZ0uigb7efs0PL4gQEtfhZDalE9u9hK/gD/vsoWqKTNHBTr/X
        U9ZHxala/5z4vdwP0/i8KfmT2rVid9ujlG1443MP7tN5TUNuCd1i9Dt5OwbwTQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598443309;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=BMT6qDj2uBUhNhaXmY2IZfaaybCNXAgFl59YZnlPXcU=;
        b=IBdG0MXZRHj29jEIQrBByxhhiaBZGuqn44GRIBBkrL+TghYScK/n1yTADhJ7BzfxO+eqUc
        VJL3h52GlMGsf8AQ==
Date:   Wed, 26 Aug 2020 13:17:12 +0200
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
Subject: [patch V2 44/46] platform-msi: Add device MSI infrastructure
References: <20200826111628.794979401@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

Add device specific MSI domain infrastructure for devices which have their
own resource management and interrupt chip. These devices are not related
to PCI and contrary to platform MSI they do not share a common resource and
interrupt chip. They provide their own domain specific resource management
and interrupt chip.

This utilizes the new alloc/free override in a non evil way which avoids
having yet another set of specialized alloc/free functions. Just using
msi_domain_alloc/free_irqs() is sufficient

While initially it was suggested and tried to piggyback device MSI on
platform MSI, the better variant is to reimplement platform MSI on top of
device MSI.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 drivers/base/platform-msi.c |  131 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/irqdomain.h   |    1 
 include/linux/msi.h         |   24 ++++++++
 kernel/irq/Kconfig          |    4 +
 4 files changed, 160 insertions(+)

--- a/drivers/base/platform-msi.c
+++ b/drivers/base/platform-msi.c
@@ -412,3 +412,134 @@ int platform_msi_domain_alloc(struct irq
 
 	return err;
 }
+
+#ifdef CONFIG_DEVICE_MSI
+/*
+ * Device specific MSI domain infrastructure for devices which have their
+ * own resource management and interrupt chip. These devices are not
+ * related to PCI and contrary to platform MSI they do not share a common
+ * resource and interrupt chip. They provide their own domain specific
+ * resource management and interrupt chip.
+ */
+
+static void device_msi_free_msi_entries(struct device *dev)
+{
+	struct list_head *msi_list = dev_to_msi_list(dev);
+	struct msi_desc *entry, *tmp;
+
+	list_for_each_entry_safe(entry, tmp, msi_list, list) {
+		list_del(&entry->list);
+		free_msi_entry(entry);
+	}
+}
+
+/**
+ * device_msi_free_irqs - Free MSI interrupts assigned to  a device
+ * @dev:	Pointer to the device
+ *
+ * Frees the interrupt and the MSI descriptors.
+ */
+static void device_msi_free_irqs(struct irq_domain *domain, struct device *dev)
+{
+	__msi_domain_free_irqs(domain, dev);
+	device_msi_free_msi_entries(dev);
+}
+
+/**
+ * device_msi_alloc_irqs - Allocate MSI interrupts for a device
+ * @dev:	Pointer to the device
+ * @nvec:	Number of vectors
+ *
+ * Allocates the required number of MSI descriptors and the corresponding
+ * interrupt descriptors.
+ */
+static int device_msi_alloc_irqs(struct irq_domain *domain, struct device *dev, int nvec)
+{
+	int i, ret = -ENOMEM;
+
+	for (i = 0; i < nvec; i++) {
+		struct msi_desc *entry = alloc_msi_entry(dev, 1, NULL);
+
+		if (!entry)
+			goto fail;
+		list_add_tail(&entry->list, dev_to_msi_list(dev));
+	}
+
+	ret = __msi_domain_alloc_irqs(domain, dev, nvec);
+	if (!ret)
+		return 0;
+fail:
+	device_msi_free_msi_entries(dev);
+	return ret;
+}
+
+static void device_msi_update_dom_ops(struct msi_domain_info *info)
+{
+	if (!info->ops->domain_alloc_irqs)
+		info->ops->domain_alloc_irqs = device_msi_alloc_irqs;
+	if (!info->ops->domain_free_irqs)
+		info->ops->domain_free_irqs = device_msi_free_irqs;
+	if (!info->ops->msi_prepare)
+		info->ops->msi_prepare = arch_msi_prepare;
+}
+
+/**
+ * device_msi_create_msi_irq_domain - Create an irq domain for devices
+ * @fwnode:	Firmware node of the interrupt controller
+ * @info:	MSI domain info to configure the new domain
+ * @parent:	Parent domain
+ */
+struct irq_domain *device_msi_create_irq_domain(struct fwnode_handle *fn,
+						struct msi_domain_info *info,
+						struct irq_domain *parent)
+{
+	struct irq_domain *domain;
+
+	if (info->flags & MSI_FLAG_USE_DEF_CHIP_OPS)
+		platform_msi_update_chip_ops(info);
+
+	if (info->flags & MSI_FLAG_USE_DEF_DOM_OPS)
+		device_msi_update_dom_ops(info);
+
+	msi_domain_set_default_info_flags(info);
+
+	domain = msi_create_irq_domain(fn, info, parent);
+	if (domain)
+		irq_domain_update_bus_token(domain, DOMAIN_BUS_DEVICE_MSI);
+	return domain;
+}
+
+#ifdef CONFIG_PCI
+#include <linux/pci.h>
+
+/**
+ * pci_subdevice_msi_create_irq_domain - Create an irq domain for subdevices
+ * @pdev:	Pointer to PCI device for which the subdevice domain is created
+ * @info:	MSI domain info to configure the new domain
+ */
+struct irq_domain *pci_subdevice_msi_create_irq_domain(struct pci_dev *pdev,
+						       struct msi_domain_info *info)
+{
+	struct irq_domain *domain, *pdev_msi;
+	struct fwnode_handle *fn;
+
+	/*
+	 * Retrieve the MSI domain of the underlying PCI device's MSI
+	 * domain. The PCI device domain's parent domain is also the parent
+	 * domain of the new subdevice domain.
+	 */
+	pdev_msi = dev_get_msi_domain(&pdev->dev);
+	if (!pdev_msi)
+		return NULL;
+
+	fn = irq_domain_alloc_named_fwnode(dev_name(&pdev->dev));
+	if (!fn)
+		return NULL;
+	domain = device_msi_create_irq_domain(fn, info, pdev_msi->parent);
+	if (!domain)
+		irq_domain_free_fwnode(fn);
+	return domain;
+}
+EXPORT_SYMBOL_GPL(pci_subdevice_msi_create_irq_domain);
+#endif /* CONFIG_PCI */
+#endif /* CONFIG_DEVICE_MSI */
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -85,6 +85,7 @@ enum irq_domain_bus_token {
 	DOMAIN_BUS_TI_SCI_INTA_MSI,
 	DOMAIN_BUS_WAKEUP,
 	DOMAIN_BUS_VMD_MSI,
+	DOMAIN_BUS_DEVICE_MSI,
 };
 
 /**
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -56,6 +56,18 @@ struct ti_sci_inta_msi_desc {
 };
 
 /**
+ * device_msi_desc - Device MSI specific MSI descriptor data
+ * @priv:		Pointer to device specific private data
+ * @priv_iomem:		Pointer to device specific private io memory
+ * @hwirq:		The hardware irq number in the device domain
+ */
+struct device_msi_desc {
+	void		*priv;
+	void __iomem	*priv_iomem;
+	u16		hwirq;
+};
+
+/**
  * struct msi_desc - Descriptor structure for MSI based interrupts
  * @list:	List head for management
  * @irq:	The base interrupt number
@@ -127,6 +139,7 @@ struct msi_desc {
 		struct platform_msi_desc platform;
 		struct fsl_mc_msi_desc fsl_mc;
 		struct ti_sci_inta_msi_desc inta;
+		struct device_msi_desc device_msi;
 	};
 };
 
@@ -413,6 +426,17 @@ void *platform_msi_get_host_data(struct
 void msi_domain_set_default_info_flags(struct msi_domain_info *info);
 #endif /* CONFIG_GENERIC_MSI_IRQ_DOMAIN */
 
+#ifdef CONFIG_DEVICE_MSI
+struct irq_domain *device_msi_create_irq_domain(struct fwnode_handle *fn,
+						struct msi_domain_info *info,
+						struct irq_domain *parent);
+
+# ifdef CONFIG_PCI
+struct irq_domain *pci_subdevice_msi_create_irq_domain(struct pci_dev *pdev,
+						       struct msi_domain_info *info);
+# endif
+#endif /* CONFIG_DEVICE_MSI */
+
 #ifdef CONFIG_PCI_MSI_IRQ_DOMAIN
 void pci_msi_domain_write_msg(struct irq_data *irq_data, struct msi_msg *msg);
 struct irq_domain *pci_msi_create_irq_domain(struct fwnode_handle *fwnode,
--- a/kernel/irq/Kconfig
+++ b/kernel/irq/Kconfig
@@ -93,6 +93,10 @@ config GENERIC_MSI_IRQ_DOMAIN
 	select IRQ_DOMAIN_HIERARCHY
 	select GENERIC_MSI_IRQ
 
+config DEVICE_MSI
+	bool
+	select GENERIC_MSI_IRQ_DOMAIN
+
 config IRQ_MSI_IOMMU
 	bool
 

