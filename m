Return-Path: <linux-hyperv+bounces-4547-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 019FCA65106
	for <lists+linux-hyperv@lfdr.de>; Mon, 17 Mar 2025 14:30:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14C807A4035
	for <lists+linux-hyperv@lfdr.de>; Mon, 17 Mar 2025 13:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 481D7243953;
	Mon, 17 Mar 2025 13:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mbOX4CP7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3JM0QmmW"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74D0B241C87;
	Mon, 17 Mar 2025 13:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742218173; cv=none; b=loTkViA7bjtWcBOJUZhMofQmitWT7aVzxAUre3WzKNUrwBZh6876KJowTcr5ip9nSufMqp5iCkFkgFC8aA3ZMiPOeLGlF4PdwhI4CgJZTMdC1QPqW2GHS7X/8PqOGgX59l+85/CJwfA80TpJRYxlifN73zvaTRmeA6d0wiiXxmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742218173; c=relaxed/simple;
	bh=xcaQ1WnuImEftvSdjIsQL5Zr2UJObjDBYpaP48Hg0CY=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=rkXpmTC6y1t1ynwUuwO1jUtJDN/Vhqd0mKu9U58MuS8f/fcxVnILQ5jV8uPbgsuuJYn9KrU5puXvODlab3HseDmZBLGgP3oHmRaerigSj3S9sjDriT67JbDs/yiyMM6dtK4QrXtRFFn+5m8AdH5vYzE6uh8eXr2frZfe9ivxWVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mbOX4CP7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3JM0QmmW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250317092946.137260005@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742218170;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=AcpTRZSWWsFoQkYWXkpRWk+2+ojMqUKmtLbTL950SRE=;
	b=mbOX4CP7Nn7eTypfyrwTIjKa6xVAgzVcPDro7GrIZd1KNHxcm7Fp8Khp8rNx4NrHhRMzoW
	Qf71OQXVlY8T+k/F2diBBXiuWs09me9almpkgPImMtn3KVxAdB+W1iao0EKaULohdBxSxH
	LpGYlmHKRzxtG850CmmkQALDwz/Fxc7135pwqkkV7ane8cubzL1vvX+qHEwCXFedk6PgL3
	Sj7Vh+5v3eBcnh7SFluOi0k9hfLnKlrhZldVfBod1updabgrEC9gXpOFSGkqDzg2gYeDa9
	lDP6mzwMqcpCI3+qj50oFR5xLYQcn7DwVd5uIhuJoV1pj3onV0ruXaRT6QdwzQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742218170;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=AcpTRZSWWsFoQkYWXkpRWk+2+ojMqUKmtLbTL950SRE=;
	b=3JM0QmmWphpbTOYSePe90IY8ofn5fR+T6+SzgNlaoW5Ud6tO5IWjGjtmSeDo0QWorQHwA2
	zWHI60Oeo6+kZtDA==
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
Subject: [patch V3 07/10] PCI/MSI: Provide a sane mechanism for TPH
References: <20250317092919.008573387@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Mon, 17 Mar 2025 14:29:29 +0100 (CET)

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






