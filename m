Return-Path: <linux-hyperv+bounces-5442-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4078DAB1025
	for <lists+linux-hyperv@lfdr.de>; Fri,  9 May 2025 12:14:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 632349E2F16
	for <lists+linux-hyperv@lfdr.de>; Fri,  9 May 2025 10:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 971E428EA61;
	Fri,  9 May 2025 10:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="BefuLuEY"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ABCA28EA44;
	Fri,  9 May 2025 10:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746785606; cv=none; b=D/jLvQfKDn++qupEdBweWgY6IB+Tg7eS9N+SnALJdMz5Y3+M0WBxq3Xv0mZE0qoWDppJ1etqSdcQeddwSLSKr4uq+qOWVLFHTb3zr27F9KEay7dkLVOMrRMspJXvEqz3njx+GdinIAYFrfuzkA9ncOF87hG+ZOFVlSGR30xuo/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746785606; c=relaxed/simple;
	bh=eheSknn2THWCqMhu/QSVH4frT7M4Uuq3n5+Qbd+NYcE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=TPSwD/x1Wue15Ft1l6NGd7NT1DOhUkCkuDc2kbJEBUDMYG4Tozynsxyx1uOL6Z/WxnBN5KAPjxqwbz0vFVbWhQs8IDnAHkstxAdSVRXmvYRN6hfxgFbJM8t7WVBSa2HVl1Iyz7vkAMP1yDvX/P100kA4pVX2rMwxef4fLjX4Hd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=BefuLuEY; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1134)
	id B079E2111571; Fri,  9 May 2025 03:13:24 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B079E2111571
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1746785604;
	bh=km0lQIF3NA+f3D6n5s967/qB/wGbEZ8pGu9m1a7cwt0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BefuLuEY7t1KJ8cb7O5BZ3ssurzZrp2ed+2ZhNgirvLSygKKshwV9fHIzgd2Y3G5q
	 D2vScBhsEM0ykCLMtJVyDTcqrCD04Dxgk/8DWvEc3fg2WJ6yXG7Sk1FcKSn+VmzNP/
	 NH1M0tvhB3MmqZ+FE6JkkEYa5Movp5B15Qu7NTm4=
From: Shradha Gupta <shradhagupta@linux.microsoft.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Rob Herring <robh@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=EF=BF=BD=7EDski?= <kw@linux.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>
Cc: Shradha Gupta <shradhagupta@linux.microsoft.com>,
	linux-hyperv@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nipun Gupta <nipun.gupta@amd.com>,
	Yury Norov <yury.norov@gmail.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Jonathan Cameron <Jonathan.Cameron@huwei.com>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Kevin Tian <kevin.tian@intel.com>,
	Long Li <longli@microsoft.com>,
	Thomas Gleixner <tglx@linutronix.de>,
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
Subject: [PATCH v3 2/4] PCI: hv: Allow dynamic MSI-X vector allocation
Date: Fri,  9 May 2025 03:13:22 -0700
Message-Id: <1746785602-4600-1-git-send-email-shradhagupta@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1746785566-4337-1-git-send-email-shradhagupta@linux.microsoft.com>
References: <1746785566-4337-1-git-send-email-shradhagupta@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Allow dynamic MSI-X vector allocation for pci_hyperv PCI controller
by adding support for the flag MSI_FLAG_PCI_MSIX_ALLOC_DYN and using
pci_msix_prepare_desc() to prepare the MSI-X descriptors.

Feature support added for both x86 and ARM64

Signed-off-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
---
 Changes in v3:
 * Add arm64 support
---
 Changes in v2:
 * split the patch to keep changes in PCI and pci_hyperv controller
   seperate
 * replace strings "pci vectors" by "MSI-X vectors"
---
 drivers/pci/controller/pci-hyperv.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index ac27bda5ba26..8c8882cb0ad2 100644
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
+#define hv_msix_prepare_desc	pci_msix_prepare_desc
 
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
-- 
2.34.1


