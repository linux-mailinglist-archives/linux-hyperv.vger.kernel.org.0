Return-Path: <linux-hyperv+bounces-4613-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA85FA68A57
	for <lists+linux-hyperv@lfdr.de>; Wed, 19 Mar 2025 12:00:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6203E42499C
	for <lists+linux-hyperv@lfdr.de>; Wed, 19 Mar 2025 10:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13BD92580CE;
	Wed, 19 Mar 2025 10:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LayUfAC8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="N59EZzs+"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647E325744B;
	Wed, 19 Mar 2025 10:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742381821; cv=none; b=s4Rh9imOvkD8Ju7gZac6KmBUczT7msRhWJwv4+6YDsy7G1XhbPtFQHhkuK0MUjk9+Hi5BeRR1634ctxUjsTKZMCteDXXYJbIO6Lw5wZERS0KrpgTrqoDdQTpd9fKSVYMKnTAa4cWaYQW5wxKvroc9ZOyd1leyuqdSUcMTnLiWIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742381821; c=relaxed/simple;
	bh=mhAnBDj7UNsieeEd6fsH6UA7xKJJMUAH06pexnkc/co=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=CxbqSYsMJa/VSGvRrHR9eTPAXKZWup5DxGPQXBIjTeP4kGHWFUiWsmNsDCkW/7EFvzV4CWAMwPkrw80bCRrTUrddgoPr+PR9H/BngP6Ob7+c+T4XpkPb66kjzWm76TecSKClfS5cjvEIhVzSpJzyfOJ//9RIcZ3Pc28kZ/4LPw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LayUfAC8; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=N59EZzs+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250319105506.683663807@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742381817;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=7zYQHI6wysqOBWW3wWAAB2qCkqNkFBqgyapk6h+Eg7M=;
	b=LayUfAC8Hp3RHy5046WRS03AqnGIlHtVmyxnYeWvYS0ujlqp8JifuGGROP8YFU1WkVGuf5
	YBw6/pdwXud1O8wqYoCrJmmKXpKwJX22RP87w8yCaPVoQiOoPM8QADwBQK4PmIRVJ9Opic
	jbpG/NPNszmVjDfmLtzDnx6wNgGpa2Oy0/rA9e7MyYD0UCaF4uaszDV4zi3qLyIaGrzMXa
	bd7rB4VMIaRkmXQANC/tC3baN4TtDXWpI82GAQdtbM7gBKcJ7NLcWt6bpaOdGxorHyYI7i
	SiEE9pZfhkuGz5dG/tlW9T/NprwcEx6kY5yX1deThqTSzBr3APesYmkbAcGUCQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742381817;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=7zYQHI6wysqOBWW3wWAAB2qCkqNkFBqgyapk6h+Eg7M=;
	b=N59EZzs+hpCJoTriuz/M3Lwke4VB2gJZxyTR5M16Qiwwvqwke9pkIGwCaeTX587IRYY1Et
	zA+WQY9vnnXgiQDA==
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
Subject: [patch V4 11/14] PCI/MSI: Provide a sane mechanism for TPH
References: <20250319104921.201434198@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Wed, 19 Mar 2025 11:56:57 +0100 (CET)

The PCI/TPH driver fiddles with the MSI-X control word of an active
interrupt completely unserialized against concurrent operations issued
from the interrupt core. It also brings the PCI/MSI-X internal cached
control word out of sync.

Provide a function, which has the required serialization and keeps the
control word cache in sync.

Unfortunately this requires to look up and lock the interrupt descriptor,
which should be only done in the interrupt core code. But confining this
particular oddity in the PCI/MSI core is the lesser of all evil. A
interrupt core implementation would require a larger pile of infrastructure
and indirections for dubious value.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Cc: Wei Huang <wei.huang2@amd.com>
Cc: linux-pci@vger.kernel.org



---
 drivers/pci/msi/msi.c |   47 +++++++++++++++++++++++++++++++++++++++++++++++
 drivers/pci/pci.h     |    9 +++++++++
 2 files changed, 56 insertions(+)

--- a/drivers/pci/msi/msi.c
+++ b/drivers/pci/msi/msi.c
@@ -910,6 +910,53 @@ void pci_free_msi_irqs(struct pci_dev *d
 	}
 }
 
+#ifdef CONFIG_PCIE_TPH
+/**
+ * pci_msix_write_tph_tag - Update the TPH tag for a given MSI-X vector
+ * @pdev:	The PCIe device to update
+ * @index:	The MSI-X index to update
+ * @tag:	The tag to write
+ *
+ * Returns: 0 on success, error code on failure
+ */
+int pci_msix_write_tph_tag(struct pci_dev *pdev, unsigned int index, u16 tag)
+{
+	struct msi_desc *msi_desc;
+	struct irq_desc *irq_desc;
+	unsigned int virq;
+
+	if (!pdev->msix_enabled)
+		return -ENXIO;
+
+	guard(msi_descs_lock)(&pdev->dev);
+	virq = msi_get_virq(&pdev->dev, index);
+	if (!virq)
+		return -ENXIO;
+	/*
+	 * This is a horrible hack, but short of implementing a PCI
+	 * specific interrupt chip callback and a huge pile of
+	 * infrastructure, this is the minor nuissance. It provides the
+	 * protection against concurrent operations on this entry and keeps
+	 * the control word cache in sync.
+	 */
+	irq_desc = irq_to_desc(virq);
+	if (!irq_desc)
+		return -ENXIO;
+
+	guard(raw_spinlock_irq)(&irq_desc->lock);
+	msi_desc = irq_data_get_msi_desc(&irq_desc->irq_data);
+	if (!msi_desc || msi_desc->pci.msi_attrib.is_virtual)
+		return -ENXIO;
+
+	msi_desc->pci.msix_ctrl &= ~PCI_MSIX_ENTRY_CTRL_ST;
+	msi_desc->pci.msix_ctrl |= FIELD_PREP(PCI_MSIX_ENTRY_CTRL_ST, tag);
+	pci_msix_write_vector_ctrl(msi_desc, msi_desc->pci.msix_ctrl);
+	/* Flush the write */
+	readl(pci_msix_desc_addr(msi_desc));
+	return 0;
+}
+#endif
+
 /* Misc. infrastructure */
 
 struct pci_dev *msi_desc_to_pci_dev(struct msi_desc *desc)
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -989,6 +989,15 @@ int pcim_request_region_exclusive(struct
 				  const char *name);
 void pcim_release_region(struct pci_dev *pdev, int bar);
 
+#ifdef CONFIG_PCI_MSI
+int pci_msix_write_tph_tag(struct pci_dev *pdev, unsigned int index, u16 tag);
+#else
+static inline int pci_msix_write_tph_tag(struct pci_dev *pdev, unsigned int index, u16 tag)
+{
+	return -ENODEV;
+}
+#endif
+
 /*
  * Config Address for PCI Configuration Mechanism #1
  *








