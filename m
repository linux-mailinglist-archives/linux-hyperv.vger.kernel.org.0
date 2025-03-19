Return-Path: <linux-hyperv+bounces-4614-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9207EA68A5D
	for <lists+linux-hyperv@lfdr.de>; Wed, 19 Mar 2025 12:00:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CA493BF3E3
	for <lists+linux-hyperv@lfdr.de>; Wed, 19 Mar 2025 10:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 239042586F6;
	Wed, 19 Mar 2025 10:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RFRzkeWR";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KFl+VRg8"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75358257AF8;
	Wed, 19 Mar 2025 10:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742381823; cv=none; b=Uxqek66zsxxjuKiFs5I1xCQhpMkVXMdOBUszYkm2rg8GTUIdubiXsjjtdLhSEAt21msKwHatxQP1CYnvlidsywkcTrzy/rSaqW5w4GzheKmFkwvzBEj642EWo/5vbaRKhiU0ch83RG8VmrYwmsVqWuR8zdAFYR0xvMWsJe9GDck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742381823; c=relaxed/simple;
	bh=E6ojSlXDDpZwhps4bcq+Z1kJm8Jbl9Yz/9TMVcfaEXI=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=VOC9dwByKKeimdXZ/ZtamwZ3WLewVKXTcjgLfRHk27lpvQEotB/khkATGHLMQ3hponZPBFJCnUJ5pgMq2aBHq5chvI8212GscnC2pHlnH6IHK8XET4Xf/evzPkokxckItLv/pd0d3OWfWu3dKxJesZMUi6OY4ZopqA0F3PVu3YI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RFRzkeWR; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KFl+VRg8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250319105506.744271447@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742381819;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=zEd2EPU9vSb5Rk/swNEbuNZK8DTDHgjmBk10fmc/doE=;
	b=RFRzkeWR+8zvWHDUaf1TYazFLDRiHEe6U8g9+kWOT1JYvBsPsa6OGa4S+0sK3kEQ9ZDf4V
	Wy/6we42WIs+D5+0qJpuL1aT+LjMAisogUnObTXLITt1A6OWdrHeQmiznUhWdzIO6U6PXk
	1gu7L3keUYzfkbu3JLa6jniSU/C9ltRKncv/QK0Sjbjal9mCdc3M0bJFc/v0Opy9lJEQo4
	ukgrCQqoy1poIoJhIIQNqC/DaJH76L+I1WzxdCBYT+gHXahP8qTIekAjUZWDXS5H/g55o2
	GI2sllG3jmjQuUVRNsRedhl3bl9LOG1ek9woJY3V/QJltI1MtHSmB3S8bzC5pQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742381819;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=zEd2EPU9vSb5Rk/swNEbuNZK8DTDHgjmBk10fmc/doE=;
	b=KFl+VRg81tUYV77YxrIf/MMUm4DPgTuCfAM12XmU342QMGG8hQcm3O2OXdDPRlKuSqjPS7
	fp9s8xoYcgQNwLAA==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Marc Zyngier <maz@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Wei Huang <wei.huang2@amd.com>,
 linux-pci@vger.kernel.org,
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
 Haiyang Zhang <haiyangz@microsoft.com>,
 linux-hyperv@vger.kernel.org,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 linux-scsi@vger.kernel.org,
 Jonathan Cameron <Jonathan.Cameron@huwei.com>
Subject: [patch V4 12/14] PCI/TPH: Replace the broken MSI-X control word
 update
References: <20250319104921.201434198@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Wed, 19 Mar 2025 11:56:58 +0100 (CET)

The driver walks the MSI descriptors to test whether a descriptor exists
for a given index. That's just abuse of the MSI internals.

The same test can be done with a single function call by looking up whether
there is a Linux interrupt number assigned at the index.

What's worse is that the function is completely unserialized against
modifications of the MSI-X control by operations issued from the interrupt
core. It also brings the PCI/MSI-X internal cached control word out of
sync.

Remove the trainwreck and invoke the function provided by the PCI/MSI core
to update it.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Cc: Wei Huang <wei.huang2@amd.com>
Cc: linux-pci@vger.kernel.org



---
 drivers/pci/tph.c |   44 +-------------------------------------------
 1 file changed, 1 insertion(+), 43 deletions(-)

--- a/drivers/pci/tph.c
+++ b/drivers/pci/tph.c
@@ -204,48 +204,6 @@ static u8 get_rp_completer_type(struct p
 	return FIELD_GET(PCI_EXP_DEVCAP2_TPH_COMP_MASK, reg);
 }
 
-/* Write ST to MSI-X vector control reg - Return 0 if OK, otherwise -errno */
-static int write_tag_to_msix(struct pci_dev *pdev, int msix_idx, u16 tag)
-{
-#ifdef CONFIG_PCI_MSI
-	struct msi_desc *msi_desc = NULL;
-	void __iomem *vec_ctrl;
-	u32 val;
-	int err = 0;
-
-	msi_lock_descs(&pdev->dev);
-
-	/* Find the msi_desc entry with matching msix_idx */
-	msi_for_each_desc(msi_desc, &pdev->dev, MSI_DESC_ASSOCIATED) {
-		if (msi_desc->msi_index == msix_idx)
-			break;
-	}
-
-	if (!msi_desc) {
-		err = -ENXIO;
-		goto err_out;
-	}
-
-	/* Get the vector control register (offset 0xc) pointed by msix_idx */
-	vec_ctrl = pdev->msix_base + msix_idx * PCI_MSIX_ENTRY_SIZE;
-	vec_ctrl += PCI_MSIX_ENTRY_VECTOR_CTRL;
-
-	val = readl(vec_ctrl);
-	val &= ~PCI_MSIX_ENTRY_CTRL_ST;
-	val |= FIELD_PREP(PCI_MSIX_ENTRY_CTRL_ST, tag);
-	writel(val, vec_ctrl);
-
-	/* Read back to flush the update */
-	val = readl(vec_ctrl);
-
-err_out:
-	msi_unlock_descs(&pdev->dev);
-	return err;
-#else
-	return -ENODEV;
-#endif
-}
-
 /* Write tag to ST table - Return 0 if OK, otherwise -errno */
 static int write_tag_to_st_table(struct pci_dev *pdev, int index, u16 tag)
 {
@@ -346,7 +304,7 @@ int pcie_tph_set_st_entry(struct pci_dev
 
 	switch (loc) {
 	case PCI_TPH_LOC_MSIX:
-		err = write_tag_to_msix(pdev, index, tag);
+		err = pci_msix_write_tph_tag(pdev, index, tag);
 		break;
 	case PCI_TPH_LOC_CAP:
 		err = write_tag_to_st_table(pdev, index, tag);








