Return-Path: <linux-hyperv+bounces-5441-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AF6AAB101E
	for <lists+linux-hyperv@lfdr.de>; Fri,  9 May 2025 12:14:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D58CA3B376B
	for <lists+linux-hyperv@lfdr.de>; Fri,  9 May 2025 10:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 161F928EA44;
	Fri,  9 May 2025 10:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="TsGDuRn5"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7878428E5E4;
	Fri,  9 May 2025 10:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746785592; cv=none; b=Gfs1CCVsUEPUZirbSD76vpDsNnts95JSxWnx04SMWI8TS4J5WLcQRNJaOxqxX70XJnUTo+JjxvDMA7MfQzSP0odE0b88vER9tHPA+Zs7j7DF4235Fg5QqFx28yCs58Q2QDNyzszxh6NGO9KiQPrDfRHs4P3/jgpoG8EbUxx7zDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746785592; c=relaxed/simple;
	bh=q15WeObahKJHHfymajlCTXtEDne8pMoDfBNA+7AhkEU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=pIISrTEpAQMNFCcwNUyauXvXxcU/vPuLZsJwkzY1hTxdtwMl/PaqhcH+RAwaaT975VU7UrpJiaHtOfxjR+qERSqkXWn4EFj3oe8EBRg9CXpF4aw/2Hb+iGbGq7QCVWs9C5O7rG+Yeead+p0pJJTdKyuqxAMorG72S/I+gnnJVhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=TsGDuRn5; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1134)
	id 13A102098462; Fri,  9 May 2025 03:13:10 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 13A102098462
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1746785590;
	bh=ck7OlH3iLM2zajPne9r3rXRVKyZNS5D+OnC1eJ41hxs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TsGDuRn5Hb7+OUimyftXQz+zWa71E06UcCg8Tl/Pk/wg+b3AJkHuYAvt/TGQ5NHtO
	 0Q+kTBpYBorhzOOIE3aS1xbrC3RwFq9YsXtfF1MZ6F6N6VAo5Hsf8nzHH1Ni82X4Fv
	 SMbdTMcTDexIZq8eRLzDC4NC/0OlP07nnljp4uIE=
From: Shradha Gupta <shradhagupta@linux.microsoft.com>
To: Jason Gunthorpe <jgg@ziepe.ca>,
	Jonathan Cameron <Jonathan.Cameron@huwei.com>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Shradha Gupta <shradhagupta@linux.microsoft.com>,
	linux-hyperv@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nipun Gupta <nipun.gupta@amd.com>,
	Yury Norov <yury.norov@gmail.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Long Li <longli@microsoft.com>,
	Rob Herring <robh@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=EF=BF=BD=7EDski?= <kw@linux.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	Simon Horman <horms@kernel.org>,
	Leon Romanovsky <leon@kernel.org>,
	Maxim Levitsky <mlevitsk@redhat.com>,
	Erni Sri Satya Vennela <ernis@linux.microsoft.com>,
	Peter Zijlstra <peterz@infradead.org>,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	Paul Rosswurm <paulros@microsoft.com>,
	Shradha Gupta <shradhagupta@microsoft.com>
Subject: [PATCH v3 1/4] PCI/MSI: Export pci_msix_prepare_desc() for dynamic MSI-X allocations
Date: Fri,  9 May 2025 03:13:07 -0700
Message-Id: <1746785587-4494-1-git-send-email-shradhagupta@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1746785566-4337-1-git-send-email-shradhagupta@linux.microsoft.com>
References: <1746785566-4337-1-git-send-email-shradhagupta@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

For supporting dynamic MSI-X vector allocation by PCI controllers, enabling
the flag MSI_FLAG_PCI_MSIX_ALLOC_DYN is not enough, msix_prepare_msi_desc()
to prepare the MSI descriptor is also needed.

Export pci_msix_prepare_desc() to allow PCI controllers to support dynamic
MSI-X vector allocation.

Signed-off-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
---
 Changes in v3
 * Improved the patch description by removing abbreviations 
---
 drivers/pci/msi/irqdomain.c | 5 +++--
 include/linux/msi.h         | 2 ++
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/msi/irqdomain.c b/drivers/pci/msi/irqdomain.c
index d7ba8795d60f..43129aa6d6c7 100644
--- a/drivers/pci/msi/irqdomain.c
+++ b/drivers/pci/msi/irqdomain.c
@@ -222,13 +222,14 @@ static void pci_irq_unmask_msix(struct irq_data *data)
 	pci_msix_unmask(irq_data_get_msi_desc(data));
 }
 
-static void pci_msix_prepare_desc(struct irq_domain *domain, msi_alloc_info_t *arg,
-				  struct msi_desc *desc)
+void pci_msix_prepare_desc(struct irq_domain *domain, msi_alloc_info_t *arg,
+			   struct msi_desc *desc)
 {
 	/* Don't fiddle with preallocated MSI descriptors */
 	if (!desc->pci.mask_base)
 		msix_prepare_msi_desc(to_pci_dev(desc->dev), desc);
 }
+EXPORT_SYMBOL_GPL(pci_msix_prepare_desc);
 
 static const struct msi_domain_template pci_msix_template = {
 	.chip = {
diff --git a/include/linux/msi.h b/include/linux/msi.h
index 86e42742fd0f..d5864d5e75c2 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -691,6 +691,8 @@ struct irq_domain *pci_msi_create_irq_domain(struct fwnode_handle *fwnode,
 					     struct irq_domain *parent);
 u32 pci_msi_domain_get_msi_rid(struct irq_domain *domain, struct pci_dev *pdev);
 struct irq_domain *pci_msi_get_device_domain(struct pci_dev *pdev);
+void pci_msix_prepare_desc(struct irq_domain *domain, msi_alloc_info_t *arg,
+			   struct msi_desc *desc);
 #else /* CONFIG_PCI_MSI */
 static inline struct irq_domain *pci_msi_get_device_domain(struct pci_dev *pdev)
 {
-- 
2.34.1


