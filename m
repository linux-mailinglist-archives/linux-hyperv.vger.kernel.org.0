Return-Path: <linux-hyperv+bounces-4942-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ACB31A907D6
	for <lists+linux-hyperv@lfdr.de>; Wed, 16 Apr 2025 17:36:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72D36447972
	for <lists+linux-hyperv@lfdr.de>; Wed, 16 Apr 2025 15:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2CEE2046B3;
	Wed, 16 Apr 2025 15:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="dtR/kVP1"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B9E51D515B;
	Wed, 16 Apr 2025 15:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744817769; cv=none; b=dY1my7I+hWb9cIlNS7A6FUJuuAmAAt57gVImkshWCAOakMqtsmwStx9vvAo0YSdVQFpj/6FZABn7uSgIMO6C61PTlQD6SEI4sarlr9uGbs+CkXOIhbeyIfKV/r1rFbBcWEqQHJ9PWOptVdjjYK2GWtMJL4UaxtJZg+joMCpNJ+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744817769; c=relaxed/simple;
	bh=GtSVdtZ/V1+iYr56K8Yvc3x9XkXY1q8WIepuojgDlrw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=f5eTv1jXplRhSMvLuiGMsIULthsdofWNWt4iJgpxjJDoobXHjfjx+xP/RhvFxPyXsBZMqEe32eonK56xXhB7/bgt+9kxzYvm++/c1Fv3DGzWF85CbupIJqlZ119ac/N2dlUMFKd3iqvYqeTdMhfOGf0a4rnF1qlw8LJUt2cTBQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=dtR/kVP1; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1134)
	id 12D292052501; Wed, 16 Apr 2025 08:36:08 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 12D292052501
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1744817768;
	bh=fPxUGRlol3w7Yog3p/+opsa8SopsGuKCNyGO7607kXU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dtR/kVP1xEXf4C7LsYu4syx8T5MELk9SoXhCGRQiMJjzA4jte8Gdjht5ov4iVbBGN
	 hn0thBDjK+4jlM6SPgxe8+4pbMeetcnu+yDMakFB9bhMOXu2VrLDICgT7YvcMkBgzV
	 ailmTV3YlD1VVA6LPhKdNj+jwg38g9/E9VlnaqPk=
From: Shradha Gupta <shradhagupta@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nipun Gupta <nipun.gupta@amd.com>,
	Yury Norov <yury.norov@gmail.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Jonathan Cameron <Jonathan.Cameron@huwei.com>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Shradha Gupta <shradhagupta@linux.microsoft.com>,
	Shivamurthy Shastri <shivamurthy.shastri@linutronix.de>,
	Kevin Tian <kevin.tian@intel.com>,
	Long Li <longli@microsoft.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Rob Herring <robh@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
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
	Paul Rosswurm <paulros@microsoft.com>
Cc: Shradha Gupta <shradhagupta@microsoft.com>
Subject: [PATCH 1/2] PCI: hv: enable pci_hyperv to allow dynamic vector allocation
Date: Wed, 16 Apr 2025 08:36:06 -0700
Message-Id: <1744817766-3134-1-git-send-email-shradhagupta@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1744817747-2920-1-git-send-email-shradhagupta@linux.microsoft.com>
References: <1744817747-2920-1-git-send-email-shradhagupta@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

For supporting dynamic MSI vector allocation by pci controllers, enabling
the flag MSI_FLAG_PCI_MSIX_ALLOC_DYN is not enough, msix_prepare_msi_desc()
to prepare the desc is needed. Export pci_msix_prepare_desc() to allow pci
controllers like pci-hyperv to support dynamic MSI vector allocation.
Also, add the flag MSI_FLAG_PCI_MSIX_ALLOC_DYN and use
pci_msix_prepare_desc() in pci_hyperv controller

Signed-off-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
Reviewed-by: Long Li <longli@microsoft.com>
---
 drivers/pci/controller/pci-hyperv.c | 7 +++++--
 drivers/pci/msi/irqdomain.c         | 5 +++--
 include/linux/msi.h                 | 2 ++
 3 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index ac27bda5ba26..f2fa6bdb6bb8 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -598,7 +598,8 @@ static unsigned int hv_msi_get_int_vector(struct irq_data *data)
 	return cfg->vector;
 }
 
-#define hv_msi_prepare		pci_msi_prepare
+#define hv_msi_prepare			pci_msi_prepare
+#define hv_msix_prepare_desc		pci_msix_prepare_desc
 
 /**
  * hv_arch_irq_unmask() - "Unmask" the IRQ by setting its current
@@ -727,6 +728,7 @@ static void hv_arch_irq_unmask(struct irq_data *data)
 #define FLOW_HANDLER		NULL
 #define FLOW_NAME		NULL
 #define hv_msi_prepare		NULL
+#define hv_msix_prepare_desc	NULL
 
 struct hv_pci_chip_data {
 	DECLARE_BITMAP(spi_map, HV_PCI_MSI_SPI_NR);
@@ -2063,6 +2065,7 @@ static struct irq_chip hv_msi_irq_chip = {
 static struct msi_domain_ops hv_msi_ops = {
 	.msi_prepare	= hv_msi_prepare,
 	.msi_free	= hv_msi_free,
+	.prepare_desc	= hv_msix_prepare_desc,
 };
 
 /**
@@ -2084,7 +2087,7 @@ static int hv_pcie_init_irq_domain(struct hv_pcibus_device *hbus)
 	hbus->msi_info.ops = &hv_msi_ops;
 	hbus->msi_info.flags = (MSI_FLAG_USE_DEF_DOM_OPS |
 		MSI_FLAG_USE_DEF_CHIP_OPS | MSI_FLAG_MULTI_PCI_MSI |
-		MSI_FLAG_PCI_MSIX);
+		MSI_FLAG_PCI_MSIX | MSI_FLAG_PCI_MSIX_ALLOC_DYN);
 	hbus->msi_info.handler = FLOW_HANDLER;
 	hbus->msi_info.handler_name = FLOW_NAME;
 	hbus->msi_info.data = hbus;
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


