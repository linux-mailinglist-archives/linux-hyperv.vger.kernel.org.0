Return-Path: <linux-hyperv+bounces-4304-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 879F0A581DB
	for <lists+linux-hyperv@lfdr.de>; Sun,  9 Mar 2025 09:42:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5B3716922F
	for <lists+linux-hyperv@lfdr.de>; Sun,  9 Mar 2025 08:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93B7919ABAC;
	Sun,  9 Mar 2025 08:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vRLNzW24";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jacMLK20"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A23D31925BF;
	Sun,  9 Mar 2025 08:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741509706; cv=none; b=PBDTCUkI3veoHGJFObieoBh08WXf82lrMzSb34X2lou3QX7ywvRWeoolx0jVJzLft7pTNu3+4UbCTwmvkqAN+kzit8SzeKaPb0rpNKPfGTSv741AgjneeALbs5xFyIWzv5jAdWu3FWCdNyN/Y1XNm06li1RL++KOtRNbivz+7II=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741509706; c=relaxed/simple;
	bh=jGrSz3q2PeovBJ75uquLx2u7rWcyV5mNW9o+5ursyaY=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=EXFT2vWG6Vzw9BL1pWHz4Wds7NYBPa1Z2KjNH3O0ofRJ80xIVOhYww1kjOxfgFage+EXZ0sz6bfVFeCjtBYtdNX+zUxa4g+U7bMKC0M0FDr1fo1OaxX67FE1GNFq5J9eqrE6YZs4JBnFRzsU7MUKIvbGAfwGrShiqWWuUFvB0SE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vRLNzW24; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jacMLK20; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250309084110.204054172@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741509703;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=fFdeRnRhAOgqTfFMwz0jdJKn3mPpSCAhnyTgDYsDt9s=;
	b=vRLNzW24aeS98cJexbJM+M4R+Mn9apIOepOvhp96T23WvAEWhqyZPnlvLnGQbO/Nm5S8t5
	EUp24WHUPN16hDK4PFryDy4e3dE73i3bBfjL/9rB7NRA5gR9CJ9IqdZ6L6UxlyQ7lAzl7k
	h3ws22FxOOtLbeQuKIx65PpGV/2Fg8ptfj2oZlnosQzSaqnEc+h8vkHV9luXnBtOnF5pIj
	xrfLSxjJsWQHmRPALB3hL6CkfPtk/exd1y/JsIAQUYOPAeqJDra8AOMr8+DrVp7hDOCRfy
	z07/+syNRnYeWgyN44SFBOt7Q6N4/iGFGkbDg/e6rBMhIDznwCgpq2C//4PZnQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741509703;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=fFdeRnRhAOgqTfFMwz0jdJKn3mPpSCAhnyTgDYsDt9s=;
	b=jacMLK20w0fuI5BleSJ94pud3jGuvlqvXCP+V95Vl9nBUvF7MsKHG485jWD1RoFdzw643J
	nBQn83bXJkB64rCA==
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
Subject: [patch 01/10] genirq/msi: Make a few functions static
References: <20250309083453.900516105@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Sun,  9 Mar 2025 09:41:42 +0100 (CET)

None of these functions are used outside of the MSI core.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/msi.h |    5 -----
 kernel/irq/msi.c    |   40 +++++++---------------------------------
 2 files changed, 7 insertions(+), 38 deletions(-)

--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -81,7 +81,6 @@ struct device_attribute;
 struct irq_domain;
 struct irq_affinity_desc;
 
-void __get_cached_msi_msg(struct msi_desc *entry, struct msi_msg *msg);
 #ifdef CONFIG_GENERIC_MSI_IRQ
 void get_cached_msi_msg(unsigned int irq, struct msi_msg *msg);
 #else
@@ -603,8 +602,6 @@ void msi_remove_device_irq_domain(struct
 bool msi_match_device_irq_domain(struct device *dev, unsigned int domid,
 				 enum irq_domain_bus_token bus_token);
 
-int msi_domain_alloc_irqs_range_locked(struct device *dev, unsigned int domid,
-				       unsigned int first, unsigned int last);
 int msi_domain_alloc_irqs_range(struct device *dev, unsigned int domid,
 				unsigned int first, unsigned int last);
 int msi_domain_alloc_irqs_all_locked(struct device *dev, unsigned int domid, int nirqs);
@@ -613,8 +610,6 @@ struct msi_map msi_domain_alloc_irq_at(s
 				       const struct irq_affinity_desc *affdesc,
 				       union msi_instance_cookie *cookie);
 
-void msi_domain_free_irqs_range_locked(struct device *dev, unsigned int domid,
-				       unsigned int first, unsigned int last);
 void msi_domain_free_irqs_range(struct device *dev, unsigned int domid,
 				unsigned int first, unsigned int last);
 void msi_domain_free_irqs_all_locked(struct device *dev, unsigned int domid);
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -270,16 +270,11 @@ static int msi_domain_add_simple_msi_des
 	return ret;
 }
 
-void __get_cached_msi_msg(struct msi_desc *entry, struct msi_msg *msg)
-{
-	*msg = entry->msg;
-}
-
 void get_cached_msi_msg(unsigned int irq, struct msi_msg *msg)
 {
 	struct msi_desc *entry = irq_get_msi_desc(irq);
 
-	__get_cached_msi_msg(entry, msg);
+	*msg = entry->msg;
 }
 EXPORT_SYMBOL_GPL(get_cached_msi_msg);
 
@@ -1352,21 +1347,17 @@ static int msi_domain_alloc_locked(struc
 }
 
 /**
- * msi_domain_alloc_irqs_range_locked - Allocate interrupts from a MSI interrupt domain
+ * msi_domain_alloc_irqs_range - Allocate interrupts from a MSI interrupt domain
  * @dev:	Pointer to device struct of the device for which the interrupts
  *		are allocated
  * @domid:	Id of the interrupt domain to operate on
  * @first:	First index to allocate (inclusive)
  * @last:	Last index to allocate (inclusive)
  *
- * Must be invoked from within a msi_lock_descs() / msi_unlock_descs()
- * pair. Use this for MSI irqdomains which implement their own descriptor
- * allocation/free.
- *
  * Return: %0 on success or an error code.
  */
-int msi_domain_alloc_irqs_range_locked(struct device *dev, unsigned int domid,
-				       unsigned int first, unsigned int last)
+int msi_domain_alloc_irqs_range(struct device *dev, unsigned int domid,
+				unsigned int first, unsigned int last)
 {
 	struct msi_ctrl ctrl = {
 		.domid	= domid,
@@ -1374,27 +1365,10 @@ int msi_domain_alloc_irqs_range_locked(s
 		.last	= last,
 		.nirqs	= last + 1 - first,
 	};
-
-	return msi_domain_alloc_locked(dev, &ctrl);
-}
-
-/**
- * msi_domain_alloc_irqs_range - Allocate interrupts from a MSI interrupt domain
- * @dev:	Pointer to device struct of the device for which the interrupts
- *		are allocated
- * @domid:	Id of the interrupt domain to operate on
- * @first:	First index to allocate (inclusive)
- * @last:	Last index to allocate (inclusive)
- *
- * Return: %0 on success or an error code.
- */
-int msi_domain_alloc_irqs_range(struct device *dev, unsigned int domid,
-				unsigned int first, unsigned int last)
-{
 	int ret;
 
 	msi_lock_descs(dev);
-	ret = msi_domain_alloc_irqs_range_locked(dev, domid, first, last);
+	ret = msi_domain_alloc_locked(dev, &ctrl);
 	msi_unlock_descs(dev);
 	return ret;
 }
@@ -1618,8 +1592,8 @@ static void msi_domain_free_locked(struc
  * @first:	First index to free (inclusive)
  * @last:	Last index to free (inclusive)
  */
-void msi_domain_free_irqs_range_locked(struct device *dev, unsigned int domid,
-				       unsigned int first, unsigned int last)
+static void msi_domain_free_irqs_range_locked(struct device *dev, unsigned int domid,
+					      unsigned int first, unsigned int last)
 {
 	struct msi_ctrl ctrl = {
 		.domid	= domid,


