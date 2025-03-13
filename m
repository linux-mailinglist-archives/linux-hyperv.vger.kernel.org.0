Return-Path: <linux-hyperv+bounces-4476-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18770A5F54C
	for <lists+linux-hyperv@lfdr.de>; Thu, 13 Mar 2025 14:06:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 776B93BF908
	for <lists+linux-hyperv@lfdr.de>; Thu, 13 Mar 2025 13:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31EFE268FC7;
	Thu, 13 Mar 2025 13:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fY2fJFVQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="F0g6U9v3"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B6B268C60;
	Thu, 13 Mar 2025 13:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741871032; cv=none; b=gXgcYSNYFnG8pTi+8kHy/KbxUiImwYKoUUp7MFKD6CIxO4nGrH/RKwbY/R6QNELFOKfqbfVNn7RsScoOiqwFJaO8bOcpULm7+hl6ucT3Wug5hWiAuFSt+zpBlVCV9MD18fb8CHpawXRePtF2r8gOXuyPfv2RwmYBhuqRuAI7chk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741871032; c=relaxed/simple;
	bh=GVWgBVz76iiyTkBIsI+YrrMsy1toetdlK1fgPEkZEQ8=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=iVXkOp9ajYqrGhN3tr5Ew0Hci6F+8nQ7CmVny1XeTTwShOBGlbFCg0dA6P1CttFbipZHMkssgAOjYK9Pkjm8IRXvU3I4j7DSGqV1vfo5Hhcdf8nVPuGqBt5qSWVIHpPAMFf9pj8i5KH7O099jnmpLxl/zAO0Irn+QUjXHtLHOuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fY2fJFVQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=F0g6U9v3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250313130321.822790423@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741871028;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=JBW9gq+Dmwfzny4pdCzH+bh7Q9MJFTAgc8xClBz3MXs=;
	b=fY2fJFVQ7bdDaCzEK5BeQ26F//oyqcbCmwLbqxOjP3Ua/AGAHuGZhvCsHOyS+z/ggaVlDu
	dzTrSrIayKv8HKINVndBu5jtcBmjHEeF6oB8vnvnWy96lCy08p7MZTgWpbdGrk9fn0Uy72
	RCZ3/zxWW9r6pOW6HN1tKutmfCVwPw7NfuUK18d0l/PJkj5/shIhl2YsMCKHKPlU718I7E
	wEWmyJgRRAfx6PY46fZvBxm6X4qA5m/Jp+/3otrXwfekVr4mZwDVW6n9VXc9X3xoVzWo1+
	oXNJjkRJt/1VhFDOBZjYMgqmz7L58Sb4VuDND3Zqd3eKovH02LnlCZZIaGt4wg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741871028;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=JBW9gq+Dmwfzny4pdCzH+bh7Q9MJFTAgc8xClBz3MXs=;
	b=F0g6U9v33Dmv6/N876MVdoaRL/B8WwcFvKCHrwpO9A2IDervForozvVXvP5ssvfiz4U7Ve
	A3vcLPyTTtn8R5Dg==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Marc Zyngier <maz@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Wei Huang <wei.huang2@amd.com>,
 linux-pci@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>,
 Nishanth Menon <nm@ti.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
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
Subject: [patch V2 07/10] PCI/MSI: Provide a sane mechanism for TPH
References: <20250313130212.450198939@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Thu, 13 Mar 2025 14:03:48 +0100 (CET)

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




