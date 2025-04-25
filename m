Return-Path: <linux-hyperv+bounces-5135-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 932F4A9C64B
	for <lists+linux-hyperv@lfdr.de>; Fri, 25 Apr 2025 12:55:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C7BE1BA3430
	for <lists+linux-hyperv@lfdr.de>; Fri, 25 Apr 2025 10:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 385E624293C;
	Fri, 25 Apr 2025 10:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="PBl4NX38"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4E8623F291;
	Fri, 25 Apr 2025 10:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745578463; cv=none; b=Td5NMK+WM8T8pC6L9drG1cm+laowe+dwz2DBXyIQfVwy6i/b65fi7Cu3pD1EoKXJR+BrE11RTP7Q40w2nQ6zrZJfQqQjyb8xB6vaH7N8u/Gf/bfDRibV7tLP6wddjNazOlghQcI4xvkicVMFmRviSdVDJ6tChjJAPTO53pC7IUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745578463; c=relaxed/simple;
	bh=xm/l0LBXRRC3O+XjK4qdRF0SDIkwF7Yuz+CMVMni0+E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=gT2+OJzBd7VNNt+mbfleOTrES8EaPzONWWY+3N6kz79+0SkH1JHrLwKc+SZohYhAlod3wW+LU5WOnOEMvRoziNPvDQGKpaG/tG21a0fnj+xc+hBa7x9LkSmLoCqAdSphFaA4UcR7bYWeyCCrx71iSTHinhJfzfBTXX2lrSeqhpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=PBl4NX38; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1134)
	id 5A42B2020957; Fri, 25 Apr 2025 03:54:21 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5A42B2020957
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1745578461;
	bh=Q1I1rZep87fjsOhFJmwl3GYR2qXH5ffLe7tbt73M3+c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PBl4NX38aGWJEZIBAbWLLX82b6xYx74arlGwbYrsu4r2sLrfwhz9kw4NfIow2gEGh
	 hnIgzrIdDV41f4d0RGtiJBwHYjOy57YVErcUko8U7Lrm5Fid46II907cdbl6DogX7x
	 bggjIc6fZNctz14qf7Z81+pAPgFJSRuy3g6iHl+M=
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
Subject: [PATCH v2 2/3] PCI: hv: Allow dynamic MSI-X vector allocation
Date: Fri, 25 Apr 2025 03:54:19 -0700
Message-Id: <1745578459-15084-1-git-send-email-shradhagupta@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1745578407-14689-1-git-send-email-shradhagupta@linux.microsoft.com>
References: <1745578407-14689-1-git-send-email-shradhagupta@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Allow dynamic MSI-X vector allocation for pci_hyperv PCI controller
by adding support for the flag MSI_FLAG_PCI_MSIX_ALLOC_DYN and using
pci_msix_prepare_desc() to prepare the descriptors.

Signed-off-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
---
 Changes in v2:
 * split the patch to keep changes in PCI and pci_hyperv controller
   seperate
 * replace strings "pci vectors" by "MSI-X vectors"
---
 drivers/pci/controller/pci-hyperv.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

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
-- 
2.34.1


