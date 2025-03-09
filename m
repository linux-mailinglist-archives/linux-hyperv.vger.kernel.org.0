Return-Path: <linux-hyperv+bounces-4305-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B072A581E4
	for <lists+linux-hyperv@lfdr.de>; Sun,  9 Mar 2025 09:42:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 059D83A7049
	for <lists+linux-hyperv@lfdr.de>; Sun,  9 Mar 2025 08:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0F661A2643;
	Sun,  9 Mar 2025 08:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="g30MpAv4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uxPbO57Y"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 038707602D;
	Sun,  9 Mar 2025 08:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741509708; cv=none; b=MD6YEGR31KAeGFBk2uFt7iSqeTDTRR4RjXc1iB6JxpdwgU4dzXYcUYBB/Gs+CGH+5bhLML6208qEhLRqLbswJ2rVe8cWnPpHZgblZj4dI/1mER6NcwY9eb6zvsx0EFFX943g1UhB+KSebPSKWEZYJRuy1GeAPenjN2U293VMLdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741509708; c=relaxed/simple;
	bh=yhTutmLbPuDD8e9KZsQhCeBQ50tI0xIMIrtFLbsE5uE=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=JQ6lxGbXBKyvYt45qX1AeAuPtD6RWllYtvNchzEz/sr1HnAi2lyLksSVfn2a887r5UjORjJsV8FrSNQXiHfyTXw3eh8TwQtXhiRWRYFJK9fhfpWJOJPHLQ2Y4yy65TsAFTv9mrgzgoymeoGJM/Pbm1moGtAtW48k6lN8KPqTBFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=g30MpAv4; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uxPbO57Y; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250309084110.267883135@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741509705;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=5HgbCO3GucDQ3f+ypesBfas/LZzcvGRvpju3GSWRDNo=;
	b=g30MpAv49hltvf1O8aqxFhvdsDTpygJGwVpHVz9uT4EN5+nzw2fy+eJ6SFyed65cLjQ5oP
	D7/OUvaaeK0Nfi9IjTBf0xdAu3KNvv6CSpkg54dfajRMwZm9eVuyeVDe18v1gpaut7tpNY
	ifstLDrR7+OrIl7s8/cqovfDmEyzWUadnM4EyxR5hLuhRy9OoJP6OD6hTG94febMLvoLHN
	bnAzXVMB8+4p6/+xVu11uYIaqUnMu7zJUUs8vUhDBWRlFI3HDowzmO3Dw3cR/Zs1n+BoOm
	jzqAKMiZmkHn/V90A9ACVEj7dXyEA/+TtlxWfhAa9YUko4u7/H7ejfv8rqHsoQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741509705;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=5HgbCO3GucDQ3f+ypesBfas/LZzcvGRvpju3GSWRDNo=;
	b=uxPbO57YJDZOyJ3+EZf70esTx6uaG70a5Tj7b7HTPQ+QAJ6dkYb1J4w0GI62Hdu+Zb8k1v
	f+aa4Xte2S7xp7Bg==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Marc Zyngier <maz@kernel.org>,
 Nishanth Menon <nm@ti.com>,
 Tero Kristo <kristo@kernel.org>,
 Santosh Shilimkar <ssantosh@kernel.org>,
 Jon Mason <jdmason@kudzu.us>,
 Dave Jiang <dave.jiang@intel.com>,
 Allen Hubbe <allenbh@gmail.com>,
 ntb@lists.linux.dev,
 Bjorn Helgaas <bhelgaas@google.com>,
 linux-pci@vger.kernel.org,
 Haiyang Zhang <haiyangz@microsoft.com>,
 Wei Liu <wei.liu@kernel.org>,
 linux-hyperv@vger.kernel.org,
 Wei Huang <wei.huang2@amd.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 linux-scsi@vger.kernel.org
Subject: [patch 02/10] genirq/msi: Use lock guards for MSI descriptor locking
References: <20250309083453.900516105@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Sun,  9 Mar 2025 09:41:44 +0100 (CET)

Provide a lock guard for MSI descriptor locking and update the core code
accordingly.

No functional change intended.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/msi.h |    3 +
 kernel/irq/msi.c    |  104 +++++++++++++++++++---------------------------------
 2 files changed, 42 insertions(+), 65 deletions(-)

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
 
@@ -1037,25 +1032,23 @@ bool msi_create_device_irq_domain(struct
 	if (msi_setup_device_data(dev))
 		goto free_fwnode;
 
-	msi_lock_descs(dev);
-
-	if (WARN_ON_ONCE(msi_get_device_domain(dev, domid)))
-		goto fail;
-
-	if (!pops->init_dev_msi_info(dev, parent, parent, &bundle->info))
-		goto fail;
-
-	domain = __msi_create_irq_domain(fwnode, &bundle->info, IRQ_DOMAIN_FLAG_MSI_DEVICE, parent);
-	if (!domain)
-		goto fail;
-
-	domain->dev = dev;
-	dev->msi.data->__domains[domid].domain = domain;
-	msi_unlock_descs(dev);
-	return true;
+	scoped_guard(msi_descs_lock, dev) {
+		if (WARN_ON_ONCE(msi_get_device_domain(dev, domid)))
+			goto free_fwnode;
+
+		if (!pops->init_dev_msi_info(dev, parent, parent, &bundle->info))
+			goto free_fwnode;
+
+		domain = __msi_create_irq_domain(fwnode, &bundle->info, IRQ_DOMAIN_FLAG_MSI_DEVICE,
+						 parent);
+		if (!domain)
+			goto free_fwnode;
+
+		domain->dev = dev;
+		dev->msi.data->__domains[domid].domain = domain;
+		return true;
+	}
 
-fail:
-	msi_unlock_descs(dev);
 free_fwnode:
 	irq_domain_free_fwnode(fwnalloced);
 free_bundle:
@@ -1074,12 +1067,10 @@ void msi_remove_device_irq_domain(struct
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
@@ -1088,9 +1079,6 @@ void msi_remove_device_irq_domain(struct
 	irq_domain_remove(domain);
 	irq_domain_free_fwnode(fwnode);
 	kfree(container_of(info, struct msi_domain_template, info));
-
-unlock:
-	msi_unlock_descs(dev);
 }
 
 /**
@@ -1106,16 +1094,14 @@ bool msi_match_device_irq_domain(struct
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
@@ -1365,12 +1351,9 @@ int msi_domain_alloc_irqs_range(struct d
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
 
@@ -1474,12 +1457,8 @@ struct msi_map msi_domain_alloc_irq_at(s
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
@@ -1516,13 +1495,11 @@ int msi_device_domain_alloc_wired(struct
 
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
 
@@ -1615,9 +1592,8 @@ static void msi_domain_free_irqs_range_l
 void msi_domain_free_irqs_range(struct device *dev, unsigned int domid,
 				unsigned int first, unsigned int last)
 {
-	msi_lock_descs(dev);
+	guard(msi_descs_lock)(dev);
 	msi_domain_free_irqs_range_locked(dev, domid, first, last);
-	msi_unlock_descs(dev);
 }
 EXPORT_SYMBOL_GPL(msi_domain_free_irqs_all);
 
@@ -1647,9 +1623,8 @@ void msi_domain_free_irqs_all_locked(str
  */
 void msi_domain_free_irqs_all(struct device *dev, unsigned int domid)
 {
-	msi_lock_descs(dev);
+	guard(msi_descs_lock)(dev);
 	msi_domain_free_irqs_all_locked(dev, domid);
-	msi_unlock_descs(dev);
 }
 
 /**
@@ -1668,12 +1643,11 @@ void msi_device_domain_free_wired(struct
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


