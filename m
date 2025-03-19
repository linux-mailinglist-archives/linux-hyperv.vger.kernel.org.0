Return-Path: <linux-hyperv+bounces-4611-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F359A68A4A
	for <lists+linux-hyperv@lfdr.de>; Wed, 19 Mar 2025 11:59:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0494423DB1
	for <lists+linux-hyperv@lfdr.de>; Wed, 19 Mar 2025 10:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18A3125742B;
	Wed, 19 Mar 2025 10:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pMLNt4dY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aI2vjARS"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E66256C98;
	Wed, 19 Mar 2025 10:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742381819; cv=none; b=YSpU4sV7MQL3X717RW5R0O7c6N0+Tcvi1vamV2vY3umabp8h3qDowBPZdD3joX+FKAcwN6t/EEgiTLGMwcFeJ5VC3CdtN/IAz23IizxpX7a2GLiGVQXzKNoHYyoneIX0jWXmMmprlxybZn8HCsTXJidyOqe7ygxocSr/g6wsg4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742381819; c=relaxed/simple;
	bh=Yku/Dk38vOmdf/tGUWDs7VYaf6oF5NAwKcemJLCATBA=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=XffX6bOBfhHMTh+4pqcwtiWRtI6fiAvggSbSfZvzBJBxVBPuJ10+iBZpO88y4Q2wk1O4JyzueCHuoNxB1j8xnBQFzPCQq/HG/oB+EU68tRvyORe6DL7fVvGM8eeJs8c7eIrrl0nDOUDOVwqkpmQ+T1H5Xa8u0mL6FyCQE4HHBr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pMLNt4dY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aI2vjARS; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250319105506.564105011@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742381814;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=WN2Id7Ic7+jh+7crblGSxwRPR1jdNZ1jmqlHS+u0MqA=;
	b=pMLNt4dY/Q52H70ecXsmMPj7z8+X4gMHQhWOE2R/aN+exlVZANNpTbZRrA/CuIGq8Dw/H3
	5hkAxRaSH7Homfy8JEBc26oJQM1HD3Cms89ZtwMW+AUK+2UcmAPUnRfIMH+ytcV6jkjfbl
	dtHzzCA+AnOoVyxhqPIjGIwzKboQPfSpOZJJRJiuoD/UL1dkdYJytUlQWxTSiY0iN2G69f
	8Bi6NkfKhYrqYOX06fTG2XSveL4CcjQ2nkWmnm961pXzxflSmvE4F7v92C8gQOY1S2LiV7
	t/RKWa0tfQ2E+QuCr9ZQ7SzIR9gHisox/TyPPwNZEIf+1pZqnGctSIKqDnl3tg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742381814;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=WN2Id7Ic7+jh+7crblGSxwRPR1jdNZ1jmqlHS+u0MqA=;
	b=aI2vjARSZWWsVfBDHjbWorZRVdVYNQ3JL1TNiIjd4chDhAMywTAUd/hynu84kznQWMDysA
	3bU7iZ/ooC6VDhAQ==
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
Subject: [patch V4 09/14] PCI/MSI: Switch msix_capability_init() to
 guard(msi_desc_lock)
References: <20250319104921.201434198@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Wed, 19 Mar 2025 11:56:54 +0100 (CET)

Split the lock protected functionality of msix_capability_init() out into a
helper function and use guard(msi_desc_lock) to replace the lock/unlock
pair.

Simplify the error path in the helper function by utilizing a custom
cleanup to get rid of the remaining gotos.

No functional change intended.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V4: Split out from the previous combo patch
---
 drivers/pci/msi/msi.c |   36 ++++++++++++++++++++----------------
 1 file changed, 20 insertions(+), 16 deletions(-)

--- a/drivers/pci/msi/msi.c
+++ b/drivers/pci/msi/msi.c
@@ -663,35 +663,39 @@ static void msix_mask_all(void __iomem *
 		writel(ctrl, base + PCI_MSIX_ENTRY_VECTOR_CTRL);
 }
 
-static int msix_setup_interrupts(struct pci_dev *dev, struct msix_entry *entries,
-				 int nvec, struct irq_affinity *affd)
+DEFINE_FREE(free_msi_irqs, struct pci_dev *, if (_T) pci_free_msi_irqs(_T));
+
+static int __msix_setup_interrupts(struct pci_dev *__dev, struct msix_entry *entries,
+				   int nvec, struct irq_affinity_desc *masks)
 {
-	struct irq_affinity_desc *masks __free(kfree) =
-		affd ? irq_create_affinity_masks(nvec, affd) : NULL;
-	int ret;
+	struct pci_dev *dev __free(free_msi_irqs) = __dev;
 
-	msi_lock_descs(&dev->dev);
-	ret = msix_setup_msi_descs(dev, entries, nvec, masks);
+	int ret = msix_setup_msi_descs(dev, entries, nvec, masks);
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
 
+	retain_ptr(dev);
 	msix_update_entries(dev, entries);
-	goto out_unlock;
+	return 0;
+}
+
+static int msix_setup_interrupts(struct pci_dev *dev, struct msix_entry *entries,
+				 int nvec, struct irq_affinity *affd)
+{
+	struct irq_affinity_desc *masks __free(kfree) =
+		affd ? irq_create_affinity_masks(nvec, affd) : NULL;
 
-out_free:
-	pci_free_msi_irqs(dev);
-out_unlock:
-	msi_unlock_descs(&dev->dev);
-	return ret;
+	guard(msi_descs_lock)(&dev->dev);
+	return __msix_setup_interrupts(dev, entries, nvec, masks);
 }
 
 /**


