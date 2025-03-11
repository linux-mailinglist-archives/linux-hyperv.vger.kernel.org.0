Return-Path: <linux-hyperv+bounces-4407-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02271A5D1B8
	for <lists+linux-hyperv@lfdr.de>; Tue, 11 Mar 2025 22:27:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F24B1799E5
	for <lists+linux-hyperv@lfdr.de>; Tue, 11 Mar 2025 21:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E566263881;
	Tue, 11 Mar 2025 21:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="latzbhgG";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Xgj+mC5C"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100581805A;
	Tue, 11 Mar 2025 21:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741728417; cv=none; b=N3tutqtO+2ntvg96CWk0UXIOMYksWlWWJbO9X8iwUYNbXJwEioVaDvNse3Zg7CUMJh4M+iHpIURb3qlZOf6BD5+l7VFLlR6TWE648S4uoAGWF9HjrzjQrN5mb9o14eybhbjixfGXagcgsT8b/D5vt7wDcOlSLZOYHKJL2dV3Se8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741728417; c=relaxed/simple;
	bh=NMbzZZmA1i+JmQhRUzWV1G3eR1b1qBmuVPuMcIPBt6Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Qq34Gqf3/AWBsFNWg4ugQqTVituQ8i5zxiWaIVESW9Mp3dTwBBaQBf+Y1/tah3//bsPSnhBp9jieViOV2YSAi5nRRWd+BoEKZH26+ss3VvTJ8ZJpIQH4/v+tftFJVoKzt8oOo3SsuhjxxXBhZNDrlV7yGBkiylxXxCxFn1IeWt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=latzbhgG; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Xgj+mC5C; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741728412;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+yVVFBNBZSf8tirkPPgeUJsEVo6IoGMOsQOtRlOY68E=;
	b=latzbhgGyaICtLvl+JQq9jS2YLNJJoHwDk1my+/neDTO+ZWqOwvhn1iQ7ksiTxQbN5HxvB
	sAl/HLIicTQ/qzkbaJ0Kf5FzqYe3ie/I8Keic37YViZgRtW+yQwBQ/CIBS7xt+94I5VeiO
	fxrlLbC+2p4CNImGtS+TBo0JBRUtDbkEhnUB95W5D0jZ2pSVLuCJmHPdNR9YhYYTyLYzjY
	zdwRq75MgN5loMcbJBHT/ypg50SzpF6/o5mfvd3Ukagg02zFwo2nJm5dzH4VAqvOMBAfAV
	RN8cHBIQJXK16vuMWC4wBXfUrpFlvec9P8xgzd3HqDAhJbRdZm8VTVfRBCU3JA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741728412;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+yVVFBNBZSf8tirkPPgeUJsEVo6IoGMOsQOtRlOY68E=;
	b=Xgj+mC5Cv5Uld5sMem/y27pGVgeYKW94jPtPa0eUPyBWJjq8JuhjMGgYiLF6QoWVUp4tM9
	PBTJ+EVQG73amfCg==
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Marc Zyngier <maz@kernel.org>,
 Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>, Santosh
 Shilimkar <ssantosh@kernel.org>, Jon Mason <jdmason@kudzu.us>, Dave Jiang
 <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>,
 ntb@lists.linux.dev, Bjorn Helgaas <bhelgaas@google.com>,
 linux-pci@vger.kernel.org, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu
 <wei.liu@kernel.org>, linux-hyperv@vger.kernel.org, Wei Huang
 <wei.huang2@amd.com>, Manivannan Sadhasivam
 <manivannan.sadhasivam@linaro.org>, "James E.J. Bottomley"
 <James.Bottomley@HansenPartnership.com>, "Martin K. Petersen"
 <martin.petersen@oracle.com>, linux-scsi@vger.kernel.org, Dan Williams
 <dan.j.williams@intel.com>
Subject: Re: [patch 02/10] genirq/msi: Use lock guards for MSI descriptor
 locking
In-Reply-To: <20250311180017.00003fcc@huawei.com>
References: <20250309083453.900516105@linutronix.de>
 <20250309084110.267883135@linutronix.de>
 <20250311180017.00003fcc@huawei.com>
Date: Tue, 11 Mar 2025 22:26:52 +0100
Message-ID: <87senjz2ar.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Mar 11 2025 at 18:00, Jonathan Cameron wrote:
> On Sun,  9 Mar 2025 09:41:44 +0100 (CET)
> Thomas Gleixner <tglx@linutronix.de> wrote:

>>  
>> @@ -1037,25 +1032,23 @@ bool msi_create_device_irq_domain(struct
>>  	if (msi_setup_device_data(dev))
>
> Hmm. We might want to make the docs in cleanup.h more nuanced.
> They specifically say to not mix goto and auto cleanup, but 
> in the case of scoped_guard() unlikely almost any other case
> it should be fine.
>
>>  		goto free_fwnode;

I got rid of the gotos. It requires __free() for the two allocations.

Thanks,

        tglx
---
--- a/include/linux/cleanup.h
+++ b/include/linux/cleanup.h
@@ -216,6 +216,8 @@ const volatile void * __must_check_fn(co
 
 #define return_ptr(p)	return no_free_ptr(p)
 
+#define retain_ptr(p)				\
+	__get_and_null(p, NULL)
 
 /*
  * DEFINE_CLASS(name, type, exit, init, init_args...):
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
@@ -442,7 +442,6 @@ EXPORT_SYMBOL_GPL(msi_next_desc);
 unsigned int msi_domain_get_virq(struct device *dev, unsigned int domid, unsigned int index)
 {
 	struct msi_desc *desc;
-	unsigned int ret = 0;
 	bool pcimsi = false;
 	struct xarray *xa;
 
@@ -456,7 +455,7 @@ unsigned int msi_domain_get_virq(struct
 	if (dev_is_pci(dev) && domid == MSI_DEFAULT_DOMAIN)
 		pcimsi = to_pci_dev(dev)->msi_enabled;
 
-	msi_lock_descs(dev);
+	guard(msi_descs_lock)(dev);
 	xa = &dev->msi.data->__domains[domid].store;
 	desc = xa_load(xa, pcimsi ? 0 : index);
 	if (desc && desc->irq) {
@@ -465,16 +464,12 @@ unsigned int msi_domain_get_virq(struct
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
 
@@ -974,9 +969,8 @@ bool msi_create_device_irq_domain(struct
 				  void *chip_data)
 {
 	struct irq_domain *domain, *parent = dev->msi.domain;
-	struct fwnode_handle *fwnode, *fwnalloced = NULL;
-	struct msi_domain_template *bundle;
 	const struct msi_parent_ops *pops;
+	struct fwnode_handle *fwnode;
 
 	if (!irq_domain_is_msi_parent(parent))
 		return false;
@@ -984,7 +978,8 @@ bool msi_create_device_irq_domain(struct
 	if (domid >= MSI_MAX_DEVICE_IRQDOMAINS)
 		return false;
 
-	bundle = kmemdup(template, sizeof(*bundle), GFP_KERNEL);
+	struct msi_domain_template *bundle __free(kfree) =
+		bundle = kmemdup(template, sizeof(*bundle), GFP_KERNEL);
 	if (!bundle)
 		return false;
 
@@ -1007,41 +1002,36 @@ bool msi_create_device_irq_domain(struct
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
@@ -1055,12 +1045,10 @@ void msi_remove_device_irq_domain(struct
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
@@ -1069,9 +1057,6 @@ void msi_remove_device_irq_domain(struct
 	irq_domain_remove(domain);
 	irq_domain_free_fwnode(fwnode);
 	kfree(container_of(info, struct msi_domain_template, info));
-
-unlock:
-	msi_unlock_descs(dev);
 }
 
 /**
@@ -1087,16 +1072,14 @@ bool msi_match_device_irq_domain(struct
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
@@ -1346,12 +1329,9 @@ int msi_domain_alloc_irqs_range(struct d
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
 
@@ -1455,12 +1435,8 @@ struct msi_map msi_domain_alloc_irq_at(s
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
@@ -1497,13 +1473,11 @@ int msi_device_domain_alloc_wired(struct
 
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
 
@@ -1596,9 +1570,8 @@ static void msi_domain_free_irqs_range_l
 void msi_domain_free_irqs_range(struct device *dev, unsigned int domid,
 				unsigned int first, unsigned int last)
 {
-	msi_lock_descs(dev);
+	guard(msi_descs_lock)(dev);
 	msi_domain_free_irqs_range_locked(dev, domid, first, last);
-	msi_unlock_descs(dev);
 }
 EXPORT_SYMBOL_GPL(msi_domain_free_irqs_all);
 
@@ -1628,9 +1601,8 @@ void msi_domain_free_irqs_all_locked(str
  */
 void msi_domain_free_irqs_all(struct device *dev, unsigned int domid)
 {
-	msi_lock_descs(dev);
+	guard(msi_descs_lock)(dev);
 	msi_domain_free_irqs_all_locked(dev, domid);
-	msi_unlock_descs(dev);
 }
 
 /**
@@ -1649,12 +1621,11 @@ void msi_device_domain_free_wired(struct
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

