Return-Path: <linux-hyperv+bounces-4474-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 881C2A5F55C
	for <lists+linux-hyperv@lfdr.de>; Thu, 13 Mar 2025 14:07:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9F7619C4139
	for <lists+linux-hyperv@lfdr.de>; Thu, 13 Mar 2025 13:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 308F72686B0;
	Thu, 13 Mar 2025 13:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="e01Iv4Fk";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SFrML0FQ"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42440267700;
	Thu, 13 Mar 2025 13:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741871029; cv=none; b=haJNmL0TL1vjTdH4lLSgZxTtodaxzXE37l5zhI/ghszIiRicM2i0ookFi6qdQ2FC26N5O3pP64SXEGEBUfnqp3QN936iEnaoQhQboHiKaTokGh8lragDDpstHWno/YbrotP/ouldOAQHd/2DEfGAsZ3gz24HYTy2phvaFim8AAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741871029; c=relaxed/simple;
	bh=cx8watuVEcwW1z7vRSIXe+666/Fm5rLf1SxhxLsAvKk=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=MLibcc5kQbKaHQDPYPCroRSTfxNxJxZFIpSWXLSjRHMgaArqUrAFnhpYN55rbpyRbqRAVfEoSn/sgnLktEsb4AWUOJkuEAEj/9SsXpJ77No6GlUvB3ocWmLHYivPtA2sUb3aPKGwQXyxCcg/LhKPl2HM1Jw8V2fmDLuq1fO15Vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=e01Iv4Fk; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SFrML0FQ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250313130321.695027112@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741871025;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=dLiv+G0W8KNuVAfifTgpex2IB55icVGIsn+3LH/RJ0A=;
	b=e01Iv4FkOFkVzkMSq5Rtl/y5YuKc7B8fBpnYaxi9Cip+/81X4GdFBgv3XcpVRvF7onhyhD
	eR07tApeePo8zFjGd7JfJW0nvkM02X4pLTiLEw0F40QHgX+UhxK6zFq+RRZWgMWQ68kVCh
	rEslhH9HjVxEu81IZmahHvSz6HfncHqkbt7XfT72vhEloF1moADFqN+xDkMeItgrCOssla
	7aLRY+vKSX6f4jkxSaHEcpYz0m8vy6ulHkKETQkZi5bGxmo25axTbB7sItZErhFP1ArTRi
	OHs+M4QfoO8bhyjKP0pw6R/c8vJB6KLrwD+bcdCZOYMI0JxR0IV9dTRABWV5tQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741871025;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=dLiv+G0W8KNuVAfifTgpex2IB55icVGIsn+3LH/RJ0A=;
	b=SFrML0FQlaH4aRgr9uAJYi/rRz6FaWpQJ+Vrz2EbNWg+otECuLf8RMQhOnXobcV6J5NuoK
	yJBmxTatQZ1GmjAQ==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Marc Zyngier <maz@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 linux-pci@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>,
 Nishanth Menon <nm@ti.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
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
 Haiyang Zhang <haiyangz@microsoft.com>,
 linux-hyperv@vger.kernel.org,
 Wei Huang <wei.huang2@amd.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 linux-scsi@vger.kernel.org,
 Jonathan Cameron <Jonathan.Cameron@huwei.com>
Subject: [patch V2 05/10] PCI/MSI: Switch to MSI descriptor locking to guard()
References: <20250313130212.450198939@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Thu, 13 Mar 2025 14:03:44 +0100 (CET)

Convert the code to use the new guard(msi_descs_lock).

No functional change intended.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
---
V2: Remove the gotos - Jonathan
---
 drivers/pci/msi/api.c |    6 --
 drivers/pci/msi/msi.c |  121 ++++++++++++++++++++++++--------------------------
 2 files changed, 62 insertions(+), 65 deletions(-)

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


