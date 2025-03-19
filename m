Return-Path: <linux-hyperv+bounces-4604-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C4B6A68A25
	for <lists+linux-hyperv@lfdr.de>; Wed, 19 Mar 2025 11:57:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60C753BFCD9
	for <lists+linux-hyperv@lfdr.de>; Wed, 19 Mar 2025 10:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9B58255226;
	Wed, 19 Mar 2025 10:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PhNtYbze";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cfWWzZAl"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE1EC254AF0;
	Wed, 19 Mar 2025 10:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742381803; cv=none; b=TQQecc0UWM9DoO9Zl1yBeEkXpGKUweU6U+wCDNKM5fUqn85RXoeXtpoeG4FG2TLcKAn6YONr1qJAn6lhLui/b9436BllKygvVRqcb29P4NGt/Dd0J0Skw0MmCoW+fJATnt7kX3L7jnvPfMnEHQOgQeOuIS/YsRS3kAZAOVH7VEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742381803; c=relaxed/simple;
	bh=XKzwz2VVe0mCfyZF4/PFvWd0QKKoyMr9Yxg740T5G7U=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=lsAzx6DHZzRNrVMgyVqwSDbaeiekt+TVu2gyIo/LeKq4KYMS42rF5315F+0GyEiSNgSIT8GZenAkbbKh6TAEj0vpxFekHByQdbutDIul8xJ08PSMLlex1/kzLW1oxgxxbqzHTs4w/mm109lwSAYUUgUwKb9Ic37nHse7LfR42iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PhNtYbze; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cfWWzZAl; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250319105506.144672678@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742381800;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=kq5hU59K/rHOOCm+QaVXkTyIqJ3TlxLoh0GIAo2/3MA=;
	b=PhNtYbzeTQS2yz1CkqdW8VPD0i/H9sHZBcJhgq+9X7N6GmF0we6nO2Nh8OjkFsZeWik6D6
	GDiiGkYtMKlTnbZZ3ijk1pkC/SLXtaTKc1U3OwBOrbTc+xvernVX80XBVzQDxi1of3pL0t
	xjjJYSjIXEWi5z9Za0rD9rqvmSIs4ibMM1UMTTzCXH5O5koLnP+5c7kuQmR52wOv4+gjGw
	zZoBMoK64w9j8M+JlxDcDpH66DCXtO0+oaldKpEnV7kAzW1Rvfbm42B66vT1Jy5Vvk/4XW
	Qth/9/pC7Zzif7DhxXVSpftn/UXPQwspkapnuY18mmBbPuNaIX/uwcNECYJqsw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742381800;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=kq5hU59K/rHOOCm+QaVXkTyIqJ3TlxLoh0GIAo2/3MA=;
	b=cfWWzZAlnAhEqExmnf2S00axn/DLVl80M6oIUk8+ZI/DwnnIWpPjCYW3KvW681t/qPhFsU
	Y3ZdSKUkiRW9wgBg==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Marc Zyngier <maz@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Nishanth Menon <nm@ti.com>,
 Dhruva Gole <d-gole@ti.com>,
 Tero Kristo <kristo@kernel.org>,
 Santosh Shilimkar <ssantosh@kernel.org>,
 Logan Gunthorpe <logang@deltatee.com>,
 Dave Jiang <dave.jiang@intel.com>,
 Jon Mason <jdmason@kudzu.us>,
 Allen Hubbe <allenbh@gmail.com>,
 ntb@lists.linux.dev,
 Michael Kelley <mhklinux@outlook.com>,
 Wei Liu <wei.liu@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Haiyang Zhang <haiyangz@microsoft.com>,
 linux-hyperv@vger.kernel.org,
 linux-pci@vger.kernel.org,
 Wei Huang <wei.huang2@amd.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 linux-scsi@vger.kernel.org,
 Jonathan Cameron <Jonathan.Cameron@huwei.com>
Subject: [patch V4 02/14] genirq/msi: Use lock guards for MSI descriptor
 locking
References: <20250319104921.201434198@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Wed, 19 Mar 2025 11:56:39 +0100 (CET)

Provide a lock guard for MSI descriptor locking and update the core code
accordingly.

No functional change intended.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>


---
V2: Remove the gotos - Jonathan
---
 include/linux/irqdomain.h |    2 
 include/linux/msi.h       |    3 +
 kernel/irq/msi.c          |  109 ++++++++++++++++------------------------------
 3 files changed, 45 insertions(+), 69 deletions(-)

--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -281,6 +281,8 @@ static inline struct fwnode_handle *irq_
 
 void irq_domain_free_fwnode(struct fwnode_handle *fwnode);
 
+DEFINE_FREE(irq_domain_free_fwnode, struct fwnode_handle *, if (_T) irq_domain_free_fwnode(_T))
+
 struct irq_domain_chip_generic_info;
 
 /**
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -227,6 +227,9 @@ int msi_setup_device_data(struct device
 void msi_lock_descs(struct device *dev);
 void msi_unlock_descs(struct device *dev);
 
+DEFINE_LOCK_GUARD_1(msi_descs_lock, struct device, msi_lock_descs(_T->lock),
+		    msi_unlock_descs(_T->lock));
+
 struct msi_desc *msi_domain_first_desc(struct device *dev, unsigned int domid,
 				       enum msi_desc_filter filter);
 
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -443,7 +443,6 @@ EXPORT_SYMBOL_GPL(msi_next_desc);
 unsigned int msi_domain_get_virq(struct device *dev, unsigned int domid, unsigned int index)
 {
 	struct msi_desc *desc;
-	unsigned int ret = 0;
 	bool pcimsi = false;
 	struct xarray *xa;
 
@@ -457,7 +456,7 @@ unsigned int msi_domain_get_virq(struct
 	if (dev_is_pci(dev) && domid == MSI_DEFAULT_DOMAIN)
 		pcimsi = to_pci_dev(dev)->msi_enabled;
 
-	msi_lock_descs(dev);
+	guard(msi_descs_lock)(dev);
 	xa = &dev->msi.data->__domains[domid].store;
 	desc = xa_load(xa, pcimsi ? 0 : index);
 	if (desc && desc->irq) {
@@ -466,16 +465,12 @@ unsigned int msi_domain_get_virq(struct
 		 * PCI-MSIX and platform MSI use a descriptor per
 		 * interrupt.
 		 */
-		if (pcimsi) {
-			if (index < desc->nvec_used)
-				ret = desc->irq + index;
-		} else {
-			ret = desc->irq;
-		}
+		if (!pcimsi)
+			return desc->irq;
+		if (index < desc->nvec_used)
+			return desc->irq + index;
 	}
-
-	msi_unlock_descs(dev);
-	return ret;
+	return 0;
 }
 EXPORT_SYMBOL_GPL(msi_domain_get_virq);
 
@@ -993,9 +988,8 @@ bool msi_create_device_irq_domain(struct
 				  void *chip_data)
 {
 	struct irq_domain *domain, *parent = dev->msi.domain;
-	struct fwnode_handle *fwnode, *fwnalloced = NULL;
-	struct msi_domain_template *bundle;
 	const struct msi_parent_ops *pops;
+	struct fwnode_handle *fwnode;
 
 	if (!irq_domain_is_msi_parent(parent))
 		return false;
@@ -1003,7 +997,8 @@ bool msi_create_device_irq_domain(struct
 	if (domid >= MSI_MAX_DEVICE_IRQDOMAINS)
 		return false;
 
-	bundle = kmemdup(template, sizeof(*bundle), GFP_KERNEL);
+	struct msi_domain_template *bundle __free(kfree) =
+		kmemdup(template, sizeof(*bundle), GFP_KERNEL);
 	if (!bundle)
 		return false;
 
@@ -1026,41 +1021,36 @@ bool msi_create_device_irq_domain(struct
 	 * node as they are not guaranteed to have a fwnode. They are never
 	 * looked up and always handled in the context of the device.
 	 */
-	if (bundle->info.flags & MSI_FLAG_USE_DEV_FWNODE)
-		fwnode = dev->fwnode;
+	struct fwnode_handle *fwnode_alloced __free(irq_domain_free_fwnode) = NULL;
+
+	if (!(bundle->info.flags & MSI_FLAG_USE_DEV_FWNODE))
+		fwnode = fwnode_alloced = irq_domain_alloc_named_fwnode(bundle->name);
 	else
-		fwnode = fwnalloced = irq_domain_alloc_named_fwnode(bundle->name);
+		fwnode = dev->fwnode;
 
 	if (!fwnode)
-		goto free_bundle;
+		return false;
 
 	if (msi_setup_device_data(dev))
-		goto free_fwnode;
-
-	msi_lock_descs(dev);
+		return false;
 
+	guard(msi_descs_lock)(dev);
 	if (WARN_ON_ONCE(msi_get_device_domain(dev, domid)))
-		goto fail;
+		return false;
 
 	if (!pops->init_dev_msi_info(dev, parent, parent, &bundle->info))
-		goto fail;
+		return false;
 
 	domain = __msi_create_irq_domain(fwnode, &bundle->info, IRQ_DOMAIN_FLAG_MSI_DEVICE, parent);
 	if (!domain)
-		goto fail;
+		return false;
 
+	/* @bundle and @fwnode_alloced are now in use. Prevent cleanup */
+	retain_ptr(bundle);
+	retain_ptr(fwnode_alloced);
 	domain->dev = dev;
 	dev->msi.data->__domains[domid].domain = domain;
-	msi_unlock_descs(dev);
 	return true;
-
-fail:
-	msi_unlock_descs(dev);
-free_fwnode:
-	irq_domain_free_fwnode(fwnalloced);
-free_bundle:
-	kfree(bundle);
-	return false;
 }
 
 /**
@@ -1074,12 +1064,10 @@ void msi_remove_device_irq_domain(struct
 	struct msi_domain_info *info;
 	struct irq_domain *domain;
 
-	msi_lock_descs(dev);
-
+	guard(msi_descs_lock)(dev);
 	domain = msi_get_device_domain(dev, domid);
-
 	if (!domain || !irq_domain_is_msi_device(domain))
-		goto unlock;
+		return;
 
 	dev->msi.data->__domains[domid].domain = NULL;
 	info = domain->host_data;
@@ -1088,9 +1076,6 @@ void msi_remove_device_irq_domain(struct
 	irq_domain_remove(domain);
 	irq_domain_free_fwnode(fwnode);
 	kfree(container_of(info, struct msi_domain_template, info));
-
-unlock:
-	msi_unlock_descs(dev);
 }
 
 /**
@@ -1106,16 +1091,14 @@ bool msi_match_device_irq_domain(struct
 {
 	struct msi_domain_info *info;
 	struct irq_domain *domain;
-	bool ret = false;
 
-	msi_lock_descs(dev);
+	guard(msi_descs_lock)(dev);
 	domain = msi_get_device_domain(dev, domid);
 	if (domain && irq_domain_is_msi_device(domain)) {
 		info = domain->host_data;
-		ret = info->bus_token == bus_token;
+		return info->bus_token == bus_token;
 	}
-	msi_unlock_descs(dev);
-	return ret;
+	return false;
 }
 
 static int msi_domain_prepare_irqs(struct irq_domain *domain, struct device *dev,
@@ -1365,12 +1348,9 @@ int msi_domain_alloc_irqs_range(struct d
 		.last	= last,
 		.nirqs	= last + 1 - first,
 	};
-	int ret;
 
-	msi_lock_descs(dev);
-	ret = msi_domain_alloc_locked(dev, &ctrl);
-	msi_unlock_descs(dev);
-	return ret;
+	guard(msi_descs_lock)(dev);
+	return msi_domain_alloc_locked(dev, &ctrl);
 }
 EXPORT_SYMBOL_GPL(msi_domain_alloc_irqs_range);
 
@@ -1474,12 +1454,8 @@ struct msi_map msi_domain_alloc_irq_at(s
 				       const struct irq_affinity_desc *affdesc,
 				       union msi_instance_cookie *icookie)
 {
-	struct msi_map map;
-
-	msi_lock_descs(dev);
-	map = __msi_domain_alloc_irq_at(dev, domid, index, affdesc, icookie);
-	msi_unlock_descs(dev);
-	return map;
+	guard(msi_descs_lock)(dev);
+	return __msi_domain_alloc_irq_at(dev, domid, index, affdesc, icookie);
 }
 
 /**
@@ -1516,13 +1492,11 @@ int msi_device_domain_alloc_wired(struct
 
 	icookie.value = ((u64)type << 32) | hwirq;
 
-	msi_lock_descs(dev);
+	guard(msi_descs_lock)(dev);
 	if (WARN_ON_ONCE(msi_get_device_domain(dev, domid) != domain))
 		map.index = -EINVAL;
 	else
 		map = __msi_domain_alloc_irq_at(dev, domid, MSI_ANY_INDEX, NULL, &icookie);
-	msi_unlock_descs(dev);
-
 	return map.index >= 0 ? map.virq : map.index;
 }
 
@@ -1615,9 +1589,8 @@ static void msi_domain_free_irqs_range_l
 void msi_domain_free_irqs_range(struct device *dev, unsigned int domid,
 				unsigned int first, unsigned int last)
 {
-	msi_lock_descs(dev);
+	guard(msi_descs_lock)(dev);
 	msi_domain_free_irqs_range_locked(dev, domid, first, last);
-	msi_unlock_descs(dev);
 }
 EXPORT_SYMBOL_GPL(msi_domain_free_irqs_all);
 
@@ -1647,9 +1620,8 @@ void msi_domain_free_irqs_all_locked(str
  */
 void msi_domain_free_irqs_all(struct device *dev, unsigned int domid)
 {
-	msi_lock_descs(dev);
+	guard(msi_descs_lock)(dev);
 	msi_domain_free_irqs_all_locked(dev, domid);
-	msi_unlock_descs(dev);
 }
 
 /**
@@ -1668,12 +1640,11 @@ void msi_device_domain_free_wired(struct
 	if (WARN_ON_ONCE(!dev || !desc || domain->bus_token != DOMAIN_BUS_WIRED_TO_MSI))
 		return;
 
-	msi_lock_descs(dev);
-	if (!WARN_ON_ONCE(msi_get_device_domain(dev, MSI_DEFAULT_DOMAIN) != domain)) {
-		msi_domain_free_irqs_range_locked(dev, MSI_DEFAULT_DOMAIN, desc->msi_index,
-						  desc->msi_index);
-	}
-	msi_unlock_descs(dev);
+	guard(msi_descs_lock)(dev);
+	if (WARN_ON_ONCE(msi_get_device_domain(dev, MSI_DEFAULT_DOMAIN) != domain))
+		return;
+	msi_domain_free_irqs_range_locked(dev, MSI_DEFAULT_DOMAIN, desc->msi_index,
+					  desc->msi_index);
 }
 
 /**




