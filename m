Return-Path: <linux-hyperv+bounces-5867-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76F1BAD5816
	for <lists+linux-hyperv@lfdr.de>; Wed, 11 Jun 2025 16:10:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 141247A6F27
	for <lists+linux-hyperv@lfdr.de>; Wed, 11 Jun 2025 14:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E55D28C5CF;
	Wed, 11 Jun 2025 14:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="EstZh1wP"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 696B1241116;
	Wed, 11 Jun 2025 14:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749651005; cv=none; b=rvbRkVGnAthbpZS8vE6CTcW0JnEaO80+EiNN9kGk2hOtGrlBOuZJf5CyOGXbK0fTc0Fgxr3OZz+BIHhMn3MjSs+JGSfIVHXOeUPtCmpzLbwKZeKrkbwUb8ojIDOax0QAiDsD4ptl+XQk3iKvBfFKWGLJww0MqhiL83lZfsXQj8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749651005; c=relaxed/simple;
	bh=NuOIgHOZeWjWCkSYw3tlCHFH4owYCYqKWsMvszk25ik=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=GCGgFcMGl0M9+DgxAkFB7vCLZHvoHVYXGPiNYEzaLjBl147uco82QRzqIx3u39oNRsd4gWOsXCk2zjIcm3K48dz9sJPIbpRIoep9bGhH8/1o9+a6vNb5Yndj4cKEPHmh1h53kzX66KnGiUI/Ox2iSJZg3dIifG9oHjXT0WHkABA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=EstZh1wP; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1134)
	id 0EC3E203B878; Wed, 11 Jun 2025 07:10:03 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0EC3E203B878
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1749651003;
	bh=S+pNvKzZfljLl9bsYeab1r1/hk38gdzhLlV9de/BwkE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EstZh1wPD1OKOYZH/PRgJZEeG7Eud0yQgMaeSD/1KgNdhuCH3YXvd9SANw2YrupBI
	 4PSU/uLBdX1TRJKs5cEzfYF08/G0KR+J4vE3vXjDLv6ncoYBaqb7oZmw+FhBJetcdy
	 ZrSQBz1ThztGwCfk+7GeVdGHrhVn6dTVQduwfO48=
From: Shradha Gupta <shradhagupta@linux.microsoft.com>
To: Jason Gunthorpe <jgg@ziepe.ca>,
	Jonathan Cameron <Jonathan.Cameron@huwei.com>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Michael Kelley <mhklinux@outlook.com>
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
Subject: [PATCH v6 1/5] PCI/MSI: Export pci_msix_prepare_desc() for dynamic MSI-X allocations
Date: Wed, 11 Jun 2025 07:10:01 -0700
Message-Id: <1749651001-9436-1-git-send-email-shradhagupta@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1749650984-9193-1-git-send-email-shradhagupta@linux.microsoft.com>
References: <1749650984-9193-1-git-send-email-shradhagupta@linux.microsoft.com>
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
Reviewed-by: Saurabh Sengar <ssengar@linux.microsoft.com>
---
 drivers/pci/msi/irqdomain.c | 5 +++--
 include/linux/msi.h         | 2 ++
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/msi/irqdomain.c b/drivers/pci/msi/irqdomain.c
index c05152733993..765312c92d9b 100644
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
index 6863540f4b71..7f254bde5426 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -706,6 +706,8 @@ struct irq_domain *pci_msi_create_irq_domain(struct fwnode_handle *fwnode,
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


