Return-Path: <linux-hyperv+bounces-4308-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66306A581F3
	for <lists+linux-hyperv@lfdr.de>; Sun,  9 Mar 2025 09:43:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EA13188CB84
	for <lists+linux-hyperv@lfdr.de>; Sun,  9 Mar 2025 08:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5EFE1AE005;
	Sun,  9 Mar 2025 08:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CGP7fktP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="w6pJqxYI"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB471ABED7;
	Sun,  9 Mar 2025 08:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741509713; cv=none; b=Qx8HVU8e+AylBU3xciTSyAwPwjZOSjJ12idu4Zw8gxvxxqXv2nxaVA12KHFFqE42SOXG3GnMmaQJ7eGT1EHM+OXNUDH/iJLER0VskY/8olufLoNa0J12V7j1ZCNw4hpi5kNqv7JEtkWvAlS3oVnSIFgM+epD4VK6AtRo2G1yXoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741509713; c=relaxed/simple;
	bh=t73ZIS0zDQ92hXUrOpkUBInvZr9WcsjDhaQgNkUS2JI=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=PP5sDRVNXJZQC/T/dQA7hGch1m6AafPEg6rWU8Q1CKt6AdUSBD4Lgz91nOhYDrJZJQijJeSazjaFy3+RrZrD8edBIN/UyFYzzXgUmdULVn7ksNXJp5XWIRyiVUpvK/kb9JoPy4IPrNWUaEYLRQLciNTT7YybimnrUoALjJZ1xuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CGP7fktP; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=w6pJqxYI; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250309084110.458224773@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741509710;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=hMPRSE2yqluKJvNyKUEzx8EXim9v5XNoKvqZd87YCug=;
	b=CGP7fktPRgXbVx8YfCdZwmahOqAPWuPufE/0GhS/GAP6MqzZtpD0Xng5rdOOOnDgqAwh23
	2zNd1vJ/Jr73/ha+sofhlHAhZOEIAyL/n97Xhh/u+PLm4j8vTLt22tuNyMR8jAm+TK7DTL
	YHJu5Il0dOIrNIgSrBHv3BK4kmV3/jm0iOvQC0vyJqq/KIhvaBQIbXm1H4HDTKp7icq/Sr
	CzVrSRcY6IQN+ueaxznA4o5VljIkaFwNOBt1nSlvzsXG9S7DfJqCXcWFsW0ddeREln0NE1
	RdnX8oc7UW8sBMQaulDlEXqm52uAexuFKMoUHVtJ/OBAl0wFy5JxZ0nPIzuzMQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741509710;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=hMPRSE2yqluKJvNyKUEzx8EXim9v5XNoKvqZd87YCug=;
	b=w6pJqxYIYl9SGBEVVmmqHGtzrMTqpswDtAYu7XKFhv8Heog9scrCRKtdGlVEUM6WkuJSJd
	RwzmopPSKvAVRHDA==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Marc Zyngier <maz@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 linux-pci@vger.kernel.org,
 Nishanth Menon <nm@ti.com>,
 Tero Kristo <kristo@kernel.org>,
 Santosh Shilimkar <ssantosh@kernel.org>,
 Jon Mason <jdmason@kudzu.us>,
 Dave Jiang <dave.jiang@intel.com>,
 Allen Hubbe <allenbh@gmail.com>,
 ntb@lists.linux.dev,
 Haiyang Zhang <haiyangz@microsoft.com>,
 Wei Liu <wei.liu@kernel.org>,
 linux-hyperv@vger.kernel.org,
 Wei Huang <wei.huang2@amd.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 linux-scsi@vger.kernel.org
Subject: [patch 05/10] PCI/MSI: Switch to MSI descriptor locking to guard()
References: <20250309083453.900516105@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Sun,  9 Mar 2025 09:41:49 +0100 (CET)

Convert the code to use the new guard(msi_descs_lock).

No functional change intended.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
---
 drivers/pci/msi/api.c |    6 ++----
 drivers/pci/msi/msi.c |   30 ++++++++++++------------------
 2 files changed, 14 insertions(+), 22 deletions(-)

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
@@ -351,7 +351,7 @@ static int msi_verify_entries(struct pci
 static int msi_capability_init(struct pci_dev *dev, int nvec,
 			       struct irq_affinity *affd)
 {
-	struct irq_affinity_desc *masks = NULL;
+	struct irq_affinity_desc *masks __free(kfree) = NULL;
 	struct msi_desc *entry, desc;
 	int ret;
 
@@ -369,7 +369,7 @@ static int msi_capability_init(struct pc
 	if (affd)
 		masks = irq_create_affinity_masks(nvec, affd);
 
-	msi_lock_descs(&dev->dev);
+	guard(msi_descs_lock)(&dev->dev);
 	ret = msi_setup_msi_desc(dev, nvec, masks);
 	if (ret)
 		goto fail;
@@ -399,16 +399,13 @@ static int msi_capability_init(struct pc
 
 	pcibios_free_irq(dev);
 	dev->irq = entry->irq;
-	goto unlock;
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
 
@@ -669,13 +666,13 @@ static void msix_mask_all(void __iomem *
 static int msix_setup_interrupts(struct pci_dev *dev, struct msix_entry *entries,
 				 int nvec, struct irq_affinity *affd)
 {
-	struct irq_affinity_desc *masks = NULL;
+	struct irq_affinity_desc *masks __free(kfree) = NULL;
 	int ret;
 
 	if (affd)
 		masks = irq_create_affinity_masks(nvec, affd);
 
-	msi_lock_descs(&dev->dev);
+	guard(msi_descs_lock)(&dev->dev);
 	ret = msix_setup_msi_descs(dev, entries, nvec, masks);
 	if (ret)
 		goto out_free;
@@ -690,13 +687,10 @@ static int msix_setup_interrupts(struct
 		goto out_free;
 
 	msix_update_entries(dev, entries);
-	goto out_unlock;
+	return 0;
 
 out_free:
 	pci_free_msi_irqs(dev);
-out_unlock:
-	msi_unlock_descs(&dev->dev);
-	kfree(masks);
 	return ret;
 }
 
@@ -871,13 +865,13 @@ void __pci_restore_msix_state(struct pci
 
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


