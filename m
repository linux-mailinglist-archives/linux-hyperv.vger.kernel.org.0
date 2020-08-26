Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4BC7252E3C
	for <lists+linux-hyperv@lfdr.de>; Wed, 26 Aug 2020 14:11:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729724AbgHZMKW (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 26 Aug 2020 08:10:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729334AbgHZMBk (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 26 Aug 2020 08:01:40 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23F2BC061796;
        Wed, 26 Aug 2020 05:01:33 -0700 (PDT)
Message-Id: <20200826112333.526797548@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598443291;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=bK7ZqVQ6iMkx1gqgQjuQHJCX2QxvMSr2QyxB/xDUg4Q=;
        b=QsDwGGbWaMG2wwc117O54sbOpk8efms0M3Nr4YA0eNjQM3hv9UKze8X/XR5zxvkuuZi3nR
        LWFMkYzhq4JiIIISrU0dWXqCSoOWOZOwUDbSrw3uO5lurbM6aLUbiJMf7AaMUbkDUPRqr/
        gdec9aaEtSjX0JqeohnxPSC5mF1dHkgqjI1Ety8ChEAIBQx3iHlx8S/y5b+H/bkXdbZuDd
        Y4+Bfd7s3Cs1t7hfNelEX0T+KhVWPQVMy6aGdKaKw2XY+71IbY4wQE2KbCUKcBNTpaRaDb
        EavmVH18LUcAILyq4F81jTwxO/GWo30HaTwbVIVhpsYsAXdIJnf7Ejv0u7sXTg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598443291;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=bK7ZqVQ6iMkx1gqgQjuQHJCX2QxvMSr2QyxB/xDUg4Q=;
        b=HEnQTgsbWzmNFS64UHrIApl6jg+KplQGavsM2VXZa8ffOFUDwsCwo+67VrHOs/L/kiaCH0
        wlYSvrN8HSX1M+AQ==
Date:   Wed, 26 Aug 2020 13:16:57 +0200
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
Subject: [patch V2 29/46] irqdomain/msi: Allow to override
 msi_domain_alloc/free_irqs()
References: <20200826111628.794979401@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

To support MSI irq domains which do not fit at all into the regular MSI
irqdomain scheme, like the XEN MSI interrupt management for PV/HVM/DOM0,
it's necessary to allow to override the alloc/free implementation.

This is a preperatory step to switch X86 away from arch_*_msi_irqs() and
store the irq domain pointer right in struct device.

No functional change for existing MSI irq domain users.

Aside of the evil XEN wrapper this is also useful for special MSI domains
which need to do extra alloc/free work before/after calling the generic
core function. Work like allocating/freeing MSI descriptors, MSI storage
space etc.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 include/linux/msi.h |   27 ++++++++++++++++++++
 kernel/irq/msi.c    |   70 +++++++++++++++++++++++++++++++++++-----------------
 2 files changed, 75 insertions(+), 22 deletions(-)

--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -241,6 +241,10 @@ struct msi_domain_info;
  * @msi_finish:		Optional callback to finalize the allocation
  * @set_desc:		Set the msi descriptor for an interrupt
  * @handle_error:	Optional error handler if the allocation fails
+ * @domain_alloc_irqs:	Optional function to override the default allocation
+ *			function.
+ * @domain_free_irqs:	Optional function to override the default free
+ *			function.
  *
  * @get_hwirq, @msi_init and @msi_free are callbacks used by
  * msi_create_irq_domain() and related interfaces
@@ -248,6 +252,22 @@ struct msi_domain_info;
  * @msi_check, @msi_prepare, @msi_finish, @set_desc and @handle_error
  * are callbacks used by msi_domain_alloc_irqs() and related
  * interfaces which are based on msi_desc.
+ *
+ * @domain_alloc_irqs, @domain_free_irqs can be used to override the
+ * default allocation/free functions (__msi_domain_alloc/free_irqs). This
+ * is initially for a wrapper around XENs seperate MSI universe which can't
+ * be wrapped into the regular irq domains concepts by mere mortals.  This
+ * allows to universally use msi_domain_alloc/free_irqs without having to
+ * special case XEN all over the place.
+ *
+ * Contrary to other operations @domain_alloc_irqs and @domain_free_irqs
+ * are set to the default implementation if NULL and even when
+ * MSI_FLAG_USE_DEF_DOM_OPS is not set to avoid breaking existing users and
+ * because these callbacks are obviously mandatory.
+ *
+ * This is NOT meant to be abused, but it can be useful to build wrappers
+ * for specialized MSI irq domains which need extra work before and after
+ * calling __msi_domain_alloc_irqs()/__msi_domain_free_irqs().
  */
 struct msi_domain_ops {
 	irq_hw_number_t	(*get_hwirq)(struct msi_domain_info *info,
@@ -270,6 +290,10 @@ struct msi_domain_ops {
 				    struct msi_desc *desc);
 	int		(*handle_error)(struct irq_domain *domain,
 					struct msi_desc *desc, int error);
+	int		(*domain_alloc_irqs)(struct irq_domain *domain,
+					     struct device *dev, int nvec);
+	void		(*domain_free_irqs)(struct irq_domain *domain,
+					    struct device *dev);
 };
 
 /**
@@ -327,8 +351,11 @@ int msi_domain_set_affinity(struct irq_d
 struct irq_domain *msi_create_irq_domain(struct fwnode_handle *fwnode,
 					 struct msi_domain_info *info,
 					 struct irq_domain *parent);
+int __msi_domain_alloc_irqs(struct irq_domain *domain, struct device *dev,
+			    int nvec);
 int msi_domain_alloc_irqs(struct irq_domain *domain, struct device *dev,
 			  int nvec);
+void __msi_domain_free_irqs(struct irq_domain *domain, struct device *dev);
 void msi_domain_free_irqs(struct irq_domain *domain, struct device *dev);
 struct msi_domain_info *msi_get_domain_info(struct irq_domain *domain);
 
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -229,11 +229,13 @@ static int msi_domain_ops_check(struct i
 }
 
 static struct msi_domain_ops msi_domain_ops_default = {
-	.get_hwirq	= msi_domain_ops_get_hwirq,
-	.msi_init	= msi_domain_ops_init,
-	.msi_check	= msi_domain_ops_check,
-	.msi_prepare	= msi_domain_ops_prepare,
-	.set_desc	= msi_domain_ops_set_desc,
+	.get_hwirq		= msi_domain_ops_get_hwirq,
+	.msi_init		= msi_domain_ops_init,
+	.msi_check		= msi_domain_ops_check,
+	.msi_prepare		= msi_domain_ops_prepare,
+	.set_desc		= msi_domain_ops_set_desc,
+	.domain_alloc_irqs	= __msi_domain_alloc_irqs,
+	.domain_free_irqs	= __msi_domain_free_irqs,
 };
 
 static void msi_domain_update_dom_ops(struct msi_domain_info *info)
@@ -245,6 +247,14 @@ static void msi_domain_update_dom_ops(st
 		return;
 	}
 
+	if (ops->domain_alloc_irqs == NULL)
+		ops->domain_alloc_irqs = msi_domain_ops_default.domain_alloc_irqs;
+	if (ops->domain_free_irqs == NULL)
+		ops->domain_free_irqs = msi_domain_ops_default.domain_free_irqs;
+
+	if (!(info->flags & MSI_FLAG_USE_DEF_DOM_OPS))
+		return;
+
 	if (ops->get_hwirq == NULL)
 		ops->get_hwirq = msi_domain_ops_default.get_hwirq;
 	if (ops->msi_init == NULL)
@@ -278,8 +288,7 @@ struct irq_domain *msi_create_irq_domain
 {
 	struct irq_domain *domain;
 
-	if (info->flags & MSI_FLAG_USE_DEF_DOM_OPS)
-		msi_domain_update_dom_ops(info);
+	msi_domain_update_dom_ops(info);
 	if (info->flags & MSI_FLAG_USE_DEF_CHIP_OPS)
 		msi_domain_update_chip_ops(info);
 
@@ -386,17 +395,8 @@ static bool msi_check_reservation_mode(s
 	return desc->msi_attrib.is_msix || desc->msi_attrib.maskbit;
 }
 
-/**
- * msi_domain_alloc_irqs - Allocate interrupts from a MSI interrupt domain
- * @domain:	The domain to allocate from
- * @dev:	Pointer to device struct of the device for which the interrupts
- *		are allocated
- * @nvec:	The number of interrupts to allocate
- *
- * Returns 0 on success or an error code.
- */
-int msi_domain_alloc_irqs(struct irq_domain *domain, struct device *dev,
-			  int nvec)
+int __msi_domain_alloc_irqs(struct irq_domain *domain, struct device *dev,
+			    int nvec)
 {
 	struct msi_domain_info *info = domain->host_data;
 	struct msi_domain_ops *ops = info->ops;
@@ -490,12 +490,24 @@ int msi_domain_alloc_irqs(struct irq_dom
 }
 
 /**
- * msi_domain_free_irqs - Free interrupts from a MSI interrupt @domain associated tp @dev
- * @domain:	The domain to managing the interrupts
+ * msi_domain_alloc_irqs - Allocate interrupts from a MSI interrupt domain
+ * @domain:	The domain to allocate from
  * @dev:	Pointer to device struct of the device for which the interrupts
- *		are free
+ *		are allocated
+ * @nvec:	The number of interrupts to allocate
+ *
+ * Returns 0 on success or an error code.
  */
-void msi_domain_free_irqs(struct irq_domain *domain, struct device *dev)
+int msi_domain_alloc_irqs(struct irq_domain *domain, struct device *dev,
+			  int nvec)
+{
+	struct msi_domain_info *info = domain->host_data;
+	struct msi_domain_ops *ops = info->ops;
+
+	return ops->domain_alloc_irqs(domain, dev, nvec);
+}
+
+void __msi_domain_free_irqs(struct irq_domain *domain, struct device *dev)
 {
 	struct msi_desc *desc;
 
@@ -513,6 +525,20 @@ void msi_domain_free_irqs(struct irq_dom
 }
 
 /**
+ * __msi_domain_free_irqs - Free interrupts from a MSI interrupt @domain associated tp @dev
+ * @domain:	The domain to managing the interrupts
+ * @dev:	Pointer to device struct of the device for which the interrupts
+ *		are free
+ */
+void msi_domain_free_irqs(struct irq_domain *domain, struct device *dev)
+{
+	struct msi_domain_info *info = domain->host_data;
+	struct msi_domain_ops *ops = info->ops;
+
+	return ops->domain_free_irqs(domain, dev);
+}
+
+/**
  * msi_get_domain_info - Get the MSI interrupt domain info for @domain
  * @domain:	The interrupt domain to retrieve data from
  *


