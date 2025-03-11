Return-Path: <linux-hyperv+bounces-4408-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FB39A5D1EC
	for <lists+linux-hyperv@lfdr.de>; Tue, 11 Mar 2025 22:45:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 256E03B1530
	for <lists+linux-hyperv@lfdr.de>; Tue, 11 Mar 2025 21:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7AA322CBD3;
	Tue, 11 Mar 2025 21:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZCM5RdD6";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0tn05P+/"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FFEF22A1CD;
	Tue, 11 Mar 2025 21:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741729548; cv=none; b=ptO2D8blygTjAzjHsvEI/r9BoD5gzlF+K4YT7AJgt9vGAzIEuj1kpRLFGoaDyHpQ5f24CSnIdWA3yhP3hkkxo3G+bH8QSwxblBJIyI1ZSaJ6PF/hn73APg9FC0QXvcKfAyjs0qmDdA/Z18kAdXQ6Ay91QJ48VhpxsH8zyZl8Wok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741729548; c=relaxed/simple;
	bh=KdwnFgazTOlEUUpfswtvuAmPmqCiafpW6cQd/XfAcsI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RCLrSqUARDeUou5VyVAHWNS8CzsTCYn/8lc3zgMIEOveQkD/kHizo4489ut7HtULm22+RnoBDu3YjFYegrDsaaPi7pquv0SzebmTl1C0kG+R+4dyOp5D34H2spdV0KtvLt1oFYNoG19nJKhzykk+4LyAzVL46XfCbaMhccebdUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZCM5RdD6; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0tn05P+/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741729545;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GbLxnYEkh+uuZQU6ekQIoI6Bdh306BbbZFiZNHD5ix0=;
	b=ZCM5RdD6C5Mwv3W05htRYbcC8103FrHDDF+55t9hhAL7UpCj8pzCXk+kMhpQO/Vom9X91J
	huw7GuM0H/yn4Ir6PTddThNXe1oNFoPFs/EM7A1RGoCt6DZKwD7dO0IAc7kNOA/0/oZAxp
	s/wchwubHYIi+y4C0AVERN4xzwZpkhalqYgnC0VxlAZjWYeycPUKyLWQgkYKKhXYUHGqu5
	Dz/DoPxqJkcuwhh9/G6fBRMr3JTAqZ+96cAYrmlcDveuL41veJYJDhTrnOJIL0wWvRahpd
	Y/L0oHHMVJF+JX/YgkMZ3e2qHOHVwvY5/uo/tI9DFP3e7dnzuBs9StLDsjDjfA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741729545;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GbLxnYEkh+uuZQU6ekQIoI6Bdh306BbbZFiZNHD5ix0=;
	b=0tn05P+/99JbK5GPkWo9nBabKzsQZ7WtennjSeYOGTRbXvEgKPAKfq+6ez6IaefY/Pjmyv
	IKjKiKrJqioRAtDQ==
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Marc Zyngier <maz@kernel.org>, Bjorn
 Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, Nishanth Menon
 <nm@ti.com>, Tero Kristo <kristo@kernel.org>, Santosh Shilimkar
 <ssantosh@kernel.org>, Jon Mason <jdmason@kudzu.us>, Dave Jiang
 <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>,
 ntb@lists.linux.dev, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu
 <wei.liu@kernel.org>, linux-hyperv@vger.kernel.org, Wei Huang
 <wei.huang2@amd.com>, Manivannan Sadhasivam
 <manivannan.sadhasivam@linaro.org>, "James E.J. Bottomley"
 <James.Bottomley@HansenPartnership.com>, "Martin K. Petersen"
 <martin.petersen@oracle.com>, linux-scsi@vger.kernel.org
Subject: Re: [patch 05/10] PCI/MSI: Switch to MSI descriptor locking to guard()
In-Reply-To: <20250311181018.0000477f@huawei.com>
References: <20250309083453.900516105@linutronix.de>
 <20250309084110.458224773@linutronix.de>
 <20250311181018.0000477f@huawei.com>
Date: Tue, 11 Mar 2025 22:45:44 +0100
Message-ID: <87plinz1fb.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Mar 11 2025 at 18:10, Jonathan Cameron wrote:
> On Sun,  9 Mar 2025 09:41:49 +0100 (CET)
> Thomas Gleixner <tglx@linutronix.de> wrote:
>
> This one runs into some of the stuff that the docs say
> to not do.  I don't there there are bugs in here as such
> but it gets harder to reason about and fragile in the long
> run.  Easy enough to avoid though - see inline.

Right. Updated variant below.

Thanks,

        tglx
---
--- a/drivers/pci/msi/api.c
+++ b/drivers/pci/msi/api.c
@@ -53,10 +53,9 @@ void pci_disable_msi(struct pci_dev *dev
 	if (!pci_msi_enabled() || !dev || !dev->msi_enabled)
 		return;
 
-	msi_lock_descs(&dev->dev);
+	guard(msi_descs_lock)(&dev->dev);
 	pci_msi_shutdown(dev);
 	pci_free_msi_irqs(dev);
-	msi_unlock_descs(&dev->dev);
 }
 EXPORT_SYMBOL(pci_disable_msi);
 
@@ -196,10 +195,9 @@ void pci_disable_msix(struct pci_dev *de
 	if (!pci_msi_enabled() || !dev || !dev->msix_enabled)
 		return;
 
-	msi_lock_descs(&dev->dev);
+	guard(msi_descs_lock)(&dev->dev);
 	pci_msix_shutdown(dev);
 	pci_free_msi_irqs(dev);
-	msi_unlock_descs(&dev->dev);
 }
 EXPORT_SYMBOL(pci_disable_msix);
 
--- a/drivers/pci/msi/msi.c
+++ b/drivers/pci/msi/msi.c
@@ -336,41 +336,11 @@ static int msi_verify_entries(struct pci
 	return !entry ? 0 : -EIO;
 }
 
-/**
- * msi_capability_init - configure device's MSI capability structure
- * @dev: pointer to the pci_dev data structure of MSI device function
- * @nvec: number of interrupts to allocate
- * @affd: description of automatic IRQ affinity assignments (may be %NULL)
- *
- * Setup the MSI capability structure of the device with the requested
- * number of interrupts.  A return value of zero indicates the successful
- * setup of an entry with the new MSI IRQ.  A negative return value indicates
- * an error, and a positive return value indicates the number of interrupts
- * which could have been allocated.
- */
-static int msi_capability_init(struct pci_dev *dev, int nvec,
-			       struct irq_affinity *affd)
+static int __msi_capability_init(struct pci_dev *dev, int nvec, struct irq_affinity_desc *masks)
 {
-	struct irq_affinity_desc *masks = NULL;
+	int ret = msi_setup_msi_desc(dev, nvec, masks);
 	struct msi_desc *entry, desc;
-	int ret;
-
-	/* Reject multi-MSI early on irq domain enabled architectures */
-	if (nvec > 1 && !pci_msi_domain_supports(dev, MSI_FLAG_MULTI_PCI_MSI, ALLOW_LEGACY))
-		return 1;
-
-	/*
-	 * Disable MSI during setup in the hardware, but mark it enabled
-	 * so that setup code can evaluate it.
-	 */
-	pci_msi_set_enable(dev, 0);
-	dev->msi_enabled = 1;
-
-	if (affd)
-		masks = irq_create_affinity_masks(nvec, affd);
 
-	msi_lock_descs(&dev->dev);
-	ret = msi_setup_msi_desc(dev, nvec, masks);
 	if (ret)
 		goto fail;
 
@@ -399,19 +369,48 @@ static int msi_capability_init(struct pc
 
 	pcibios_free_irq(dev);
 	dev->irq = entry->irq;
-	goto unlock;
-
+	return 0;
 err:
 	pci_msi_unmask(&desc, msi_multi_mask(&desc));
 	pci_free_msi_irqs(dev);
 fail:
 	dev->msi_enabled = 0;
-unlock:
-	msi_unlock_descs(&dev->dev);
-	kfree(masks);
 	return ret;
 }
 
+/**
+ * msi_capability_init - configure device's MSI capability structure
+ * @dev: pointer to the pci_dev data structure of MSI device function
+ * @nvec: number of interrupts to allocate
+ * @affd: description of automatic IRQ affinity assignments (may be %NULL)
+ *
+ * Setup the MSI capability structure of the device with the requested
+ * number of interrupts.  A return value of zero indicates the successful
+ * setup of an entry with the new MSI IRQ.  A negative return value indicates
+ * an error, and a positive return value indicates the number of interrupts
+ * which could have been allocated.
+ */
+static int msi_capability_init(struct pci_dev *dev, int nvec,
+			       struct irq_affinity *affd)
+{
+	/* Reject multi-MSI early on irq domain enabled architectures */
+	if (nvec > 1 && !pci_msi_domain_supports(dev, MSI_FLAG_MULTI_PCI_MSI, ALLOW_LEGACY))
+		return 1;
+
+	/*
+	 * Disable MSI during setup in the hardware, but mark it enabled
+	 * so that setup code can evaluate it.
+	 */
+	pci_msi_set_enable(dev, 0);
+	dev->msi_enabled = 1;
+
+	struct irq_affinity_desc *masks __free(kfree) =
+		affd ? irq_create_affinity_masks(nvec, affd) : NULL;
+
+	guard(msi_descs_lock)(&dev->dev);
+	return __msi_capability_init(dev, nvec, masks);
+}
+
 int __pci_enable_msi_range(struct pci_dev *dev, int minvec, int maxvec,
 			   struct irq_affinity *affd)
 {
@@ -666,37 +665,37 @@ static void msix_mask_all(void __iomem *
 		writel(ctrl, base + PCI_MSIX_ENTRY_VECTOR_CTRL);
 }
 
-static int msix_setup_interrupts(struct pci_dev *dev, struct msix_entry *entries,
-				 int nvec, struct irq_affinity *affd)
+static int __msix_setup_interrupts(struct pci_dev *dev, struct msix_entry *entries,
+				   int nvec, struct irq_affinity_desc *masks)
 {
-	struct irq_affinity_desc *masks = NULL;
-	int ret;
+	int ret = msix_setup_msi_descs(dev, entries, nvec, masks);
 
-	if (affd)
-		masks = irq_create_affinity_masks(nvec, affd);
-
-	msi_lock_descs(&dev->dev);
-	ret = msix_setup_msi_descs(dev, entries, nvec, masks);
 	if (ret)
-		goto out_free;
+		return ret;
 
 	ret = pci_msi_setup_msi_irqs(dev, nvec, PCI_CAP_ID_MSIX);
 	if (ret)
-		goto out_free;
+		return ret;
 
 	/* Check if all MSI entries honor device restrictions */
 	ret = msi_verify_entries(dev);
 	if (ret)
-		goto out_free;
+		return ret;
 
 	msix_update_entries(dev, entries);
-	goto out_unlock;
+	return 0;
+}
 
-out_free:
-	pci_free_msi_irqs(dev);
-out_unlock:
-	msi_unlock_descs(&dev->dev);
-	kfree(masks);
+static int msix_setup_interrupts(struct pci_dev *dev, struct msix_entry *entries,
+				 int nvec, struct irq_affinity *affd)
+{
+	struct irq_affinity_desc *masks __free(kfree) =
+		affd ? irq_create_affinity_masks(nvec, affd) : NULL;
+
+	guard(msi_descs_lock)(&dev->dev);
+	int ret = __msix_setup_interrupts(dev, entries, nvec, masks);
+	if (ret)
+		pci_free_msi_irqs(dev);
 	return ret;
 }
 
@@ -871,13 +870,13 @@ void __pci_restore_msix_state(struct pci
 
 	write_msg = arch_restore_msi_irqs(dev);
 
-	msi_lock_descs(&dev->dev);
-	msi_for_each_desc(entry, &dev->dev, MSI_DESC_ALL) {
-		if (write_msg)
-			__pci_write_msi_msg(entry, &entry->msg);
-		pci_msix_write_vector_ctrl(entry, entry->pci.msix_ctrl);
+	scoped_guard (msi_descs_lock, &dev->dev) {
+		msi_for_each_desc(entry, &dev->dev, MSI_DESC_ALL) {
+			if (write_msg)
+				__pci_write_msi_msg(entry, &entry->msg);
+			pci_msix_write_vector_ctrl(entry, entry->pci.msix_ctrl);
+		}
 	}
-	msi_unlock_descs(&dev->dev);
 
 	pci_msix_clear_and_set_ctrl(dev, PCI_MSIX_FLAGS_MASKALL, 0);
 }

