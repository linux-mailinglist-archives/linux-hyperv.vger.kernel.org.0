Return-Path: <linux-hyperv+bounces-4607-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 296C9A68A32
	for <lists+linux-hyperv@lfdr.de>; Wed, 19 Mar 2025 11:57:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0693B19C4C5E
	for <lists+linux-hyperv@lfdr.de>; Wed, 19 Mar 2025 10:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89D852561BA;
	Wed, 19 Mar 2025 10:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="I8JlWdus";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5NutwKoT"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F17BA254874;
	Wed, 19 Mar 2025 10:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742381810; cv=none; b=OcweDmaWCc2/ZuUlsPmE35tu9b9nCYkfaOjrqhhs8h/Sn/ga80uH0Q8r7ItZ2T4kVIEz4iucogzIb/XYpicKjWJiwOVj0Xqr1wwkFaQlurGKvc7RC43yZprvlEkaxhXm2npDsR2cSOenBjwhGDAjwP9gCaBLsC9qoU3jS+RMhOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742381810; c=relaxed/simple;
	bh=eZxa/kj9RNTSaRSLG6juKNzrX6ldOaWxsWzud0IlPTY=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=ept1QkArc5MVdpFdJuJaBu/5YTLEMsylL5moChryzWdCBG0EhiGKm1UwA9ggk47yltY9pAvuzdz2rUac8lPRqDe97hHUiL+Cw4moy7vjXc7h4ggFXZac6Z80PHrtpz3Ep3ZVBO4CnUh2GZP5mzdObdGZYZssrIQV6Ber5WGzoT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=I8JlWdus; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=5NutwKoT; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250319105506.322536126@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742381807;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=zKgxDJTeWwx2nPph9Hc2qhKbbX8Dd6/qYocNy9HMAB8=;
	b=I8JlWdusEos8QurcjCkq6u+QlFvHyzvniLe7U1+C4YkR2i1rB2eNbI9nPKlHw2E67mSo3O
	DwVgMpBKShfMdLI4MIO/Y8W3Zaq+gEXav/YYDfdp9F4SU2YVe0BHygP1/V949fZLMTtldD
	W1T+q1eiiUw2IEd0tG4PqvAEAP2nHtm2Mkd2QUqcEAjMcYOUeXsPSFWAhsgbONShepIceP
	XlC5BgKx9CxXOIxWHOuiw8mO43qF07FYWcKsWknz6NcYk0isO413hqBsiwLMm7gAsjnoIJ
	tMk9U2SKxmLfcnPbbnL49xk9y8Nv1lEMICGvCaA5OCEWI4eqjrAN7DA1AosHHw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742381807;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=zKgxDJTeWwx2nPph9Hc2qhKbbX8Dd6/qYocNy9HMAB8=;
	b=5NutwKoTEimBlWWihYmwJuRHauBT15FrCz5l45R9kBEHCkTxjycmpoQawSaYncAlnYgPCx
	ImeJSRr+Pc4OlfCg==
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
Subject: [patch V4 05/14] PCI/MSI: Use guard(msi_desc_lock) where applicable
References: <20250319104921.201434198@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Wed, 19 Mar 2025 11:56:47 +0100 (CET)

Convert the trivial cases of msi_desc_lock/unlock() pairs.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V4: Split out from the previous combo patch
---
 drivers/pci/msi/api.c |    6 ++----
 drivers/pci/msi/msi.c |   12 ++++++------
 2 files changed, 8 insertions(+), 10 deletions(-)

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
@@ -871,13 +871,13 @@ void __pci_restore_msix_state(struct pci
 
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


