Return-Path: <linux-hyperv+bounces-4612-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63CD7A68A44
	for <lists+linux-hyperv@lfdr.de>; Wed, 19 Mar 2025 11:58:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18F54188BDFA
	for <lists+linux-hyperv@lfdr.de>; Wed, 19 Mar 2025 10:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40530254AFF;
	Wed, 19 Mar 2025 10:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bG/x4mi2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7TQdxDza"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D092571C8;
	Wed, 19 Mar 2025 10:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742381819; cv=none; b=BAtTunhu0ocJ3pQaEzmNrgKeJCY5zqlO7CVQ9+vZuOG4ZDz1viQEZ7h1WJSOK5peEEsUBq4N2nAz7BYsQ7tXIOkTyLrodAa3hOIx4vUmWKwRzlAdtnazMzG09GFmDOPcOoK+VF6zFx0B3xMdXqNLtWUWvWG327ZkQ/7CbbZqQzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742381819; c=relaxed/simple;
	bh=hLSVkCmZq3sAZQvJDN0JoJ4G2z0ZgsLWhv3mMKL51JQ=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=cSGx3wD3CkU5IeJzRM/Ugowlswl3ZcByt69AoILl+CYNHOf0C8mfqEv/w5mKPMaNGriPBT9L/bM1hCk7YG/PDJipACfEJajokQ6A+7GmkDoDGfSnIfjy7jxrlr7W9xss5lFGDt5EBV2dxK47OyAHFqzigX8CPYsvd2L41qu9vvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bG/x4mi2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=7TQdxDza; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250319105506.624838146@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742381816;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=lVkhyqvX8Nx1WTN8VogxCpaEgAaZaZZ4hHPvZ1Nkv+M=;
	b=bG/x4mi2j7PLAIOEvQEIL2uiNI408Vb7y2bQPxAftORe42XzRMX2KgPF/MuRTfSxZAs4ZF
	UShesZf5jdlmDVZ9AGRd2edZFHcufYGs/INhHHvRtyMwwk72+ul/6ON+fX6HJMHG7Ti4J0
	3+GtWq4cnFTwzgyOJkwOUU5fhOF/dsC3mRGaRoVxe2NX1aloDj359jry+kWsbFbCXNkEB2
	Q6m8t5X6HlxTpoVflc590xSOblsHBoNGv4YAkVmnrraYATo3UD8y4URqJRJqJQYpH7e5Sc
	3xFlWbuDjbPpwbjQYMMQ9kIVwasuC1/ksGRnsYDz518c0n0CYMbreahdlxp4Cw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742381816;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=lVkhyqvX8Nx1WTN8VogxCpaEgAaZaZZ4hHPvZ1Nkv+M=;
	b=7TQdxDzaZCmPNGySoOuULAIYOJhzDnT5up1+rHQR7uH7KkMSNdSTDaxjRdMYLbMItKzS3e
	UZt6RZphCDEK24Ag==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Marc Zyngier <maz@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Michael Kelley <mhklinux@outlook.com>,
 Wei Liu <wei.liu@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Haiyang Zhang <haiyangz@microsoft.com>,
 linux-hyperv@vger.kernel.org,
 linux-pci@vger.kernel.org,
 Nishanth Menon <nm@ti.com>,
 Dhruva Gole <d-gole@ti.com>,
 Tero Kristo <kristo@kernel.org>,
 Santosh Shilimkar <ssantosh@kernel.org>,
 Logan Gunthorpe <logang@deltatee.com>,
 Dave Jiang <dave.jiang@intel.com>,
 Jon Mason <jdmason@kudzu.us>,
 Allen Hubbe <allenbh@gmail.com>,
 ntb@lists.linux.dev,
 Wei Huang <wei.huang2@amd.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 linux-scsi@vger.kernel.org,
 Jonathan Cameron <Jonathan.Cameron@huwei.com>
Subject: [patch V4 10/14] PCI: hv: Switch MSI descriptor locking to guard()
References: <20250319104921.201434198@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Wed, 19 Mar 2025 11:56:55 +0100 (CET)

Convert the code to use the new guard(msi_descs_lock).

No functional change intended.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Michael Kelley <mhklinux@outlook.com>
Acked-by: Wei Liu <wei.liu@kernel.org>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>
Cc: linux-hyperv@vger.kernel.org
Cc: linux-pci@vger.kernel.org


---
 drivers/pci/controller/pci-hyperv.c |   14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -3976,24 +3976,18 @@ static int hv_pci_restore_msi_msg(struct
 {
 	struct irq_data *irq_data;
 	struct msi_desc *entry;
-	int ret = 0;
 
 	if (!pdev->msi_enabled && !pdev->msix_enabled)
 		return 0;
 
-	msi_lock_descs(&pdev->dev);
+	guard(msi_descs_lock)(&pdev->dev);
 	msi_for_each_desc(entry, &pdev->dev, MSI_DESC_ASSOCIATED) {
 		irq_data = irq_get_irq_data(entry->irq);
-		if (WARN_ON_ONCE(!irq_data)) {
-			ret = -EINVAL;
-			break;
-		}
-
+		if (WARN_ON_ONCE(!irq_data))
+			return -EINVAL;
 		hv_compose_msi_msg(irq_data, &entry->msg);
 	}
-	msi_unlock_descs(&pdev->dev);
-
-	return ret;
+	return 0;
 }
 
 /*








