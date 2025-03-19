Return-Path: <linux-hyperv+bounces-4609-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B7F5A68A3B
	for <lists+linux-hyperv@lfdr.de>; Wed, 19 Mar 2025 11:58:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72E2D1625B7
	for <lists+linux-hyperv@lfdr.de>; Wed, 19 Mar 2025 10:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95FA4256C93;
	Wed, 19 Mar 2025 10:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xW0waZFT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bIZQnm5e"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC1B256C70;
	Wed, 19 Mar 2025 10:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742381815; cv=none; b=mconUFIo2iDWjsnYqh2nCFl7D585uH1JBZFUM9vwkc+niijO1roJ2dRc8xUqthxezeAkcyl1ZpDs6thsKESjxaExUq2WtQZNxYCoOz+w9br3i59zGZqL0fwD4nsP/Dd8O284/RCT4XzS2XebkUiW0ILAqAsYhLMFUO81IZrBd/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742381815; c=relaxed/simple;
	bh=0S6JBtftfWBjmYP+nFzM28W31kvZAZS+nbE4Ex10PHs=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=Wf/anke42qKv3++XfW5vdNMPRZ7KC3U+m5GHl1n+LR0zqKGQLYLBnFIHv1aYrohyw//i6WL9pPXNJHLAIB0I3AyWsZ6RqxRyCOEttp2k9iAw3S0do9BSMOvVQcchFes5DvIHHMa3QUeQIXjSLQs25LdYJVYOcRQIFPcyoZxRXU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xW0waZFT; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bIZQnm5e; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250319105506.444764312@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742381811;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=M3ZLyKNabp56RBqfhxFCqK7uWgjrNSEEvNrMzTPxxsE=;
	b=xW0waZFTl+vn2skuaRY82JwU6tGma4gtARdDiogSCFSBqR+MvCXAVJpNv+QChA70y/fTQs
	m1Edqe0ChWbeEvns9SkELJmr4hvXV2Z2xx/KV3ivWASs9qMMyfhf4HDy0GDwNAJTZ44+UZ
	QqUlSXfJ0lp88yj7ZFf3VfMuQ6DoPkkTMG0t48yqW0AKZZqhf8bMu6vUcyBEozaqrK05C6
	Kh1w1u2GzZqqW/o+RxAt3yfW0zvhPMoGtWjKL4D3+hJD50n9+NyPGYeKED8ggwx6X9wP+R
	jd8Dz0tdtOwYQehKPMfmp0nDTf+n9A96bn7E3OYBeRg4sCDuDNv7+2jWwQTPEg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742381811;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=M3ZLyKNabp56RBqfhxFCqK7uWgjrNSEEvNrMzTPxxsE=;
	b=bIZQnm5eUNLCJTSvqssztPjZ4819Gx/Vyp/ijes+SDGzwzLkIwUvMGudPHerXgoSZYTUaf
	qfrcUXBXksmoB4Cw==
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
Subject: [patch V4 07/14] PCI/MSI: Use __free() for affinity masks
References: <20250319104921.201434198@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Wed, 19 Mar 2025 11:56:50 +0100 (CET)

Let cleanup handle the freeing of the affinity mask. That prepares for
switching the MSI descriptor locking to a guard().

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V4: Split out of the previous combo patch
---
 drivers/pci/msi/msi.c |   13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

--- a/drivers/pci/msi/msi.c
+++ b/drivers/pci/msi/msi.c
@@ -351,7 +351,6 @@ static int msi_verify_entries(struct pci
 static int msi_capability_init(struct pci_dev *dev, int nvec,
 			       struct irq_affinity *affd)
 {
-	struct irq_affinity_desc *masks = NULL;
 	struct msi_desc *entry, desc;
 	int ret;
 
@@ -362,8 +361,8 @@ static int msi_capability_init(struct pc
 	/* Disable MSI during setup in the hardware to erase stale state */
 	pci_msi_set_enable(dev, 0);
 
-	if (affd)
-		masks = irq_create_affinity_masks(nvec, affd);
+	struct irq_affinity_desc *masks __free(kfree) =
+		affd ? irq_create_affinity_masks(nvec, affd) : NULL;
 
 	msi_lock_descs(&dev->dev);
 	ret = msi_setup_msi_desc(dev, nvec, masks);
@@ -403,7 +402,6 @@ static int msi_capability_init(struct pc
 	pci_free_msi_irqs(dev);
 unlock:
 	msi_unlock_descs(&dev->dev);
-	kfree(masks);
 	return ret;
 }
 
@@ -664,12 +662,10 @@ static void msix_mask_all(void __iomem *
 static int msix_setup_interrupts(struct pci_dev *dev, struct msix_entry *entries,
 				 int nvec, struct irq_affinity *affd)
 {
-	struct irq_affinity_desc *masks = NULL;
+	struct irq_affinity_desc *masks __free(kfree) =
+		affd ? irq_create_affinity_masks(nvec, affd) : NULL;
 	int ret;
 
-	if (affd)
-		masks = irq_create_affinity_masks(nvec, affd);
-
 	msi_lock_descs(&dev->dev);
 	ret = msix_setup_msi_descs(dev, entries, nvec, masks);
 	if (ret)
@@ -691,7 +687,6 @@ static int msix_setup_interrupts(struct
 	pci_free_msi_irqs(dev);
 out_unlock:
 	msi_unlock_descs(&dev->dev);
-	kfree(masks);
 	return ret;
 }
 


