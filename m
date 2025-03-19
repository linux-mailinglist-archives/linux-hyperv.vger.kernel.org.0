Return-Path: <linux-hyperv+bounces-4610-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D055AA68A3C
	for <lists+linux-hyperv@lfdr.de>; Wed, 19 Mar 2025 11:58:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56B7719C4BA4
	for <lists+linux-hyperv@lfdr.de>; Wed, 19 Mar 2025 10:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E50232571B0;
	Wed, 19 Mar 2025 10:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Zdl4LTHT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nrxZP5By"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B4E02571A7;
	Wed, 19 Mar 2025 10:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742381817; cv=none; b=nyb1p71PIsJpNC4GqkkS8ffagx99weVuuvgdaSTIyx0JuEQJ9VAwddP7ltRn9GjrV5avuKYJPNUv7jAgryLBqLqO8t1sLD5qJxgWAJ6cYvQddPJTaiAMjPNmIaDYknuonWC6PhJO/F1ktIc2au65m5K4fR/AheFLosAh4/CaAlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742381817; c=relaxed/simple;
	bh=HaoLq0D3RvhTFwiLdtEXdAhf531e3qdaeTOQWLUWAoc=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=AbLueEc6VrxO2ppEx20/mNjyf+25u7iT57IjHUIsSrKTpcPg34p5ERqEixnw7A/o+SJC+YnnqQx+k/QdXl7hPHWfFqi1epc2Siv2nvi5T0cCkzDduGzRWJjFh3pRgrToMBfVUZvFLkmlhChKJTtbwJ2Z9ZU/mUGFtmtnMQnJF3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Zdl4LTHT; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nrxZP5By; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250319105506.504992208@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742381813;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=lBkrdbLZXVbEAH8J9x7p9bDWZWgworS88LcdnKmFb84=;
	b=Zdl4LTHTBFbnFX7IwjtsU1uMOk+lhulCfGrWhqzI2/b1oGarL1aiWpFeojjf0b5v6UQvVP
	YOW9YfUC/Ujl2YcpZbbFiYN0ngNgGXUgPEugTZXdWxz+S/ElofSnTLNwpc/pk5qXTJvyvy
	lgQKDJKo7iOOH7MLwLk4v/GUq9RcwUW5JXBU+spfJ6oQqSBuObIkiREyZmf3qcIF/ScOGs
	REvrGY0aw7/Oq1ykHvWiFn/6evsqKp2NCaJW6giYa/Q0M1g5nRk5xYBnqAphTXiy822sQc
	JrisJPqlCK/CPFa4TJpaM/0yRqnCg62D5YkJc5ozYNwrbzfO+nub6EI3PUW7xA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742381813;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=lBkrdbLZXVbEAH8J9x7p9bDWZWgworS88LcdnKmFb84=;
	b=nrxZP5Byd7khrEeUZ7PYH2gA7bnf9yccHSfbcXLhhpp0EXohMHKKgI+k5kt3pJjJhr45us
	8cscixW3nh/ufKAw==
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
Subject: [patch V4 08/14] PCI/MSI: Switch msi_capability_init() to
 guard(msi_desc_lock)
References: <20250319104921.201434198@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Wed, 19 Mar 2025 11:56:53 +0100 (CET)

Split the lock protected functionality of msi_capability_init() out into a
helper function and use guard(msi_desc_lock) to replace the lock/unlock
pair.

No functional change intended.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V4: Split out from the previous combo patch
---
 drivers/pci/msi/msi.c |   68 ++++++++++++++++++++++++++------------------------
 1 file changed, 36 insertions(+), 32 deletions(-)

--- a/drivers/pci/msi/msi.c
+++ b/drivers/pci/msi/msi.c
@@ -336,38 +336,13 @@ static int msi_verify_entries(struct pci
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
+	int ret = msi_setup_msi_desc(dev, nvec, masks);
 	struct msi_desc *entry, desc;
-	int ret;
-
-	/* Reject multi-MSI early on irq domain enabled architectures */
-	if (nvec > 1 && !pci_msi_domain_supports(dev, MSI_FLAG_MULTI_PCI_MSI, ALLOW_LEGACY))
-		return 1;
-
-	/* Disable MSI during setup in the hardware to erase stale state */
-	pci_msi_set_enable(dev, 0);
 
-	struct irq_affinity_desc *masks __free(kfree) =
-		affd ? irq_create_affinity_masks(nvec, affd) : NULL;
-
-	msi_lock_descs(&dev->dev);
-	ret = msi_setup_msi_desc(dev, nvec, masks);
 	if (ret)
-		goto unlock;
+		return ret;
 
 	/* All MSIs are unmasked by default; mask them all */
 	entry = msi_first_desc(&dev->dev, MSI_DESC_ALL);
@@ -395,16 +370,45 @@ static int msi_capability_init(struct pc
 
 	pcibios_free_irq(dev);
 	dev->irq = entry->irq;
-	goto unlock;
-
+	return 0;
 err:
 	pci_msi_unmask(&desc, msi_multi_mask(&desc));
 	pci_free_msi_irqs(dev);
-unlock:
-	msi_unlock_descs(&dev->dev);
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


