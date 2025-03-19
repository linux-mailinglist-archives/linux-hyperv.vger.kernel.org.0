Return-Path: <linux-hyperv+bounces-4608-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83C5AA68A46
	for <lists+linux-hyperv@lfdr.de>; Wed, 19 Mar 2025 11:59:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE7B3881D76
	for <lists+linux-hyperv@lfdr.de>; Wed, 19 Mar 2025 10:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 811DA2566D4;
	Wed, 19 Mar 2025 10:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2oroJln3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qMJ9OS56"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0DFF2561CD;
	Wed, 19 Mar 2025 10:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742381812; cv=none; b=cPKvRowB2PMPxVvThU7zTlosZCkvPylLAxr7S+h/DOOT95X2NR9iasZ56pDrYU9vY1np9PFMnWw5z2j8nYWRzxb0KjWTfGW/E9zf8MQRqe2XWzUGZO8PKsQ2s1TnKtWzrJsyfvyzeKuPBsMrMOcCrBL0NZHaAwxfie8KyMlIffE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742381812; c=relaxed/simple;
	bh=TjGlI7+wBN100sMulKKh11WVPqLPLW/s15CV7f3Awe0=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=cxbNEh5uBpQt04UC2MDixgCCGhvXoV88LCbDWYx8fBEvIc5X6ybJfQaQI0KCMvZ6ZXKYvOYqRFi0VTf/7tmxvQIw4D4AfxbM8ETo3dhuIO1rCLJs8rMGrzvoD2lAzqa+CUvrsVT8rZqQfBwXuxZiESmcug+/ZUHUos8h9K5sMDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2oroJln3; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qMJ9OS56; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250319105506.383222333@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742381809;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=2BkahZrPHwQRrSPKUbWuUmaZoNw9hAG/NP71MuXaP0M=;
	b=2oroJln3EJhZ9XjeIk+klr3MPY/WGK+IG6Hm3gIFDRIi4Pg7bwCZnLc9Vu+cDcl1hxlwvK
	zbkHUQrXNAoI42bcqZrrzhTUfqNfKiBEGuOt18pBtM8LJNsredNWZRSIV5RX9Tjx5b4Ovb
	989OUpprIUJqUjGAGVnJq2olMKwSwbILQ4ne03iw5HuMClLlTNikrBh1NHZLf5Tas16CAa
	7JCf0Schbfs4WYZkxXLmUECINbBrVvVNbkM/iJviVwaz4N6ey4XhKNyNXV0UoeXjxwwbWZ
	gdh7hzfnunuTuM/lYD4nnGweAcvrYt7Nepo9MvULFT45rnwiLrzDJcSN/MnJEQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742381809;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=2BkahZrPHwQRrSPKUbWuUmaZoNw9hAG/NP71MuXaP0M=;
	b=qMJ9OS56CUB9YGywm4vS48tVf8wNFqmSXYU6uPLokURE4s/hFRwZIBvLuXVfskKHWrJout
	5jl2Kxlsnmaw2hDw==
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
Subject: [patch V4 06/14] PCI/MSI: Set pci_dev::msi_enabled late
References: <20250319104921.201434198@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Wed, 19 Mar 2025 11:56:49 +0100 (CET)

The comment claiming that pci_dev::msi_enabled has to be set across setup
is a leftover from ancient code versions. Nothing in the setup code
requires the flag to be set anymore.

Set it in the success path and remove the extra goto label.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V4: New patch
---
 drivers/pci/msi/msi.c |   11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

--- a/drivers/pci/msi/msi.c
+++ b/drivers/pci/msi/msi.c
@@ -359,12 +359,8 @@ static int msi_capability_init(struct pc
 	if (nvec > 1 && !pci_msi_domain_supports(dev, MSI_FLAG_MULTI_PCI_MSI, ALLOW_LEGACY))
 		return 1;
 
-	/*
-	 * Disable MSI during setup in the hardware, but mark it enabled
-	 * so that setup code can evaluate it.
-	 */
+	/* Disable MSI during setup in the hardware to erase stale state */
 	pci_msi_set_enable(dev, 0);
-	dev->msi_enabled = 1;
 
 	if (affd)
 		masks = irq_create_affinity_masks(nvec, affd);
@@ -372,7 +368,7 @@ static int msi_capability_init(struct pc
 	msi_lock_descs(&dev->dev);
 	ret = msi_setup_msi_desc(dev, nvec, masks);
 	if (ret)
-		goto fail;
+		goto unlock;
 
 	/* All MSIs are unmasked by default; mask them all */
 	entry = msi_first_desc(&dev->dev, MSI_DESC_ALL);
@@ -394,6 +390,7 @@ static int msi_capability_init(struct pc
 		goto err;
 
 	/* Set MSI enabled bits	*/
+	dev->msi_enabled = 1;
 	pci_intx_for_msi(dev, 0);
 	pci_msi_set_enable(dev, 1);
 
@@ -404,8 +401,6 @@ static int msi_capability_init(struct pc
 err:
 	pci_msi_unmask(&desc, msi_multi_mask(&desc));
 	pci_free_msi_irqs(dev);
-fail:
-	dev->msi_enabled = 0;
 unlock:
 	msi_unlock_descs(&dev->dev);
 	kfree(masks);


