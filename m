Return-Path: <linux-hyperv+bounces-4313-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CAAF1A58217
	for <lists+linux-hyperv@lfdr.de>; Sun,  9 Mar 2025 09:44:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 685CD188BEC1
	for <lists+linux-hyperv@lfdr.de>; Sun,  9 Mar 2025 08:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53FC41C07D5;
	Sun,  9 Mar 2025 08:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wxP7VCEs";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="w6qQRwoP"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 856321BD9D5;
	Sun,  9 Mar 2025 08:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741509722; cv=none; b=of5FjE0DUry6zPAnwya6m40Uzy77uygRPgwtFQQU2AhwNIlePU6OQKdWdZGafu5oHc8GznMx4mFBLigBcnNMpO2TPrfb+62AfVHDRwS/DO+BTpyLqASpFye5RIWzvuxLEthFIsk2EzR5y/otugtjmDUGs43BmNjE5evJciVqDEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741509722; c=relaxed/simple;
	bh=P/rOGxNdXnldR+DeNhNviepPjE0vHadq42YajFsXEPI=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=F0I74/LY9CdMZyKe6n/KUHdNlrmFvV7Ya6IL75o0szVYAgH+dKbgpR3UkYfdxB9Tt+M/xDXb0owKdAn6jV0La25InPIdOAGMLjtp1e6VrY8PcRu5Ofl9Z1Yt/zoyF9ZgfMgS3oKTrV3t+SdCmlqFEaO+DOS9LIJftBCOhyk40DA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wxP7VCEs; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=w6qQRwoP; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250309084110.776899075@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741509718;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=WHx/ZLek9rTZSicxLe9SDvZcHmq8PvF1xQqeIkgVlJw=;
	b=wxP7VCEshsYUESaCV8USQtjLjj6uS1/7X5MZRe5ZyWPF55UU81dofZPadr8v6N5axfKkff
	LIN+KN/ywin+I8BzvCYH+Vyvpqx7cwUQb4TMQ0ErTacaI4tu4NUOrR8Rj2DhYD5AryavYz
	wCG6KsV+kfzmSf5JPHxPMihqCQ3Alfs2R6rKPqnCrU/76FlrvSg7ZCrgDWaiv0/62vuKSt
	1ysHeb/4pBFE+eGJpPDZ8SE4zWaSOQxn3Mxu1ejKhUZhRP8wA4sgEz5pbek8OHLFaDsaI3
	9kQP+7/J1qr86Oza/9FgHci7kxSxo5XmZSvSFIjygEcTUw5XDYDFSKGRzU/17A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741509718;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=WHx/ZLek9rTZSicxLe9SDvZcHmq8PvF1xQqeIkgVlJw=;
	b=w6qQRwoP8mQzKYqMlJRnRJWkeR1oSOl+lHl64JVZ/Jy2LWAQISDvY8GuXZJs6hC6ppHUuF
	9w5QnPI10aHh6hAQ==
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
Subject: [patch 10/10] genirq/msi: Rename msi_[un]lock_descs()
References: <20250309083453.900516105@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Sun,  9 Mar 2025 09:41:58 +0100 (CET)

Now that all abuse is gone and the legit users are converted to
guard(msi_descs_lock), rename the lock functions and document them as
internal.

No functional chance.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/msi.h |    8 ++++----
 kernel/irq/msi.c    |   16 ++++++++++------
 2 files changed, 14 insertions(+), 10 deletions(-)

--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -224,11 +224,11 @@ struct msi_dev_domain {
 
 int msi_setup_device_data(struct device *dev);
 
-void msi_lock_descs(struct device *dev);
-void msi_unlock_descs(struct device *dev);
+void __msi_lock_descs(struct device *dev);
+void __msi_unlock_descs(struct device *dev);
 
-DEFINE_LOCK_GUARD_1(msi_descs_lock, struct device, msi_lock_descs(_T->lock),
-		    msi_unlock_descs(_T->lock));
+DEFINE_LOCK_GUARD_1(msi_descs_lock, struct device, __msi_lock_descs(_T->lock),
+		    __msi_unlock_descs(_T->lock));
 
 struct msi_desc *msi_domain_first_desc(struct device *dev, unsigned int domid,
 				       enum msi_desc_filter filter);
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -337,26 +337,30 @@ int msi_setup_device_data(struct device
 }
 
 /**
- * msi_lock_descs - Lock the MSI descriptor storage of a device
+ * __msi_lock_descs - Lock the MSI descriptor storage of a device
  * @dev:	Device to operate on
+ *
+ * Internal function for guard(msi_descs_lock). Don't use in code.
  */
-void msi_lock_descs(struct device *dev)
+void __msi_lock_descs(struct device *dev)
 {
 	mutex_lock(&dev->msi.data->mutex);
 }
-EXPORT_SYMBOL_GPL(msi_lock_descs);
+EXPORT_SYMBOL_GPL(__msi_lock_descs);
 
 /**
- * msi_unlock_descs - Unlock the MSI descriptor storage of a device
+ * __msi_unlock_descs - Unlock the MSI descriptor storage of a device
  * @dev:	Device to operate on
+ *
+ * Internal function for guard(msi_descs_lock). Don't use in code.
  */
-void msi_unlock_descs(struct device *dev)
+void __msi_unlock_descs(struct device *dev)
 {
 	/* Invalidate the index which was cached by the iterator */
 	dev->msi.data->__iter_idx = MSI_XA_MAX_INDEX;
 	mutex_unlock(&dev->msi.data->mutex);
 }
-EXPORT_SYMBOL_GPL(msi_unlock_descs);
+EXPORT_SYMBOL_GPL(__msi_unlock_descs);
 
 static struct msi_desc *msi_find_desc(struct msi_device_data *md, unsigned int domid,
 				      enum msi_desc_filter filter)


