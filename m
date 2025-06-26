Return-Path: <linux-hyperv+bounces-6013-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0445AEA17B
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Jun 2025 16:56:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69CB56A4BF6
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Jun 2025 14:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9C652EF280;
	Thu, 26 Jun 2025 14:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qb4mxWe3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aGPLl3Px"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09FE52EE606;
	Thu, 26 Jun 2025 14:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750949326; cv=none; b=j/SaD56Y0+7Y40jsVbKlI+ClXCCq7KNLlGiGp8d4N5+fpfW2gk8mJglvSNzip/wesAugfJs4x0xfvjtdXXHqYE8Bvm9UGRJGosnMGTIc4zp8DINnH2vWpRuoVf6d7o/J99EnuLXT2hD3tBrocdV1/l0umu+wMrJVKBnHSj1rXdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750949326; c=relaxed/simple;
	bh=K9L1Gl7WP0u17oqDgtDJ6nkc8b/I8MFrDogzDM2B43A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=URcTAXsV2MrLfr3xAnUSAp0e++OAFQHQBfAZoxf1VVyABbqEjRyTQdrYW3eSrZxvcoYHnrmKphKb42+LJlJ962m2wXBHoQXBzFyvvRuf5OdPOryVGDZdHHvuXYTx8acNt6JkSpdzW9owp6f3njV8eLKAW1yBkBS2ZEWzogj1PwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qb4mxWe3; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aGPLl3Px; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750949323;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MwVxsIaDgcFb+O8/af0/YU761G/v/g4E9Y+QGYc/05U=;
	b=qb4mxWe3WWY08sLg1q5wCvmQqGknTCw6CVCGuomI60FtWYtsrD13i1SBsvhjDS+vdF70Iz
	t4BEILq9XogEB8X6qnKiZ+oME6d0NPDqMm2JiHj1CbV12UYEPqhDCWxWDfHjwHH4VHIvmh
	muimG5KiLq4qUj2r28VqdWFCdgASDnZ8ohbCAqdghuYNWm4AWnv0uu0KUXc5C7ssA1Gnup
	ry3Bgg5zD73qv/oaNCVmUQd7omyHEtYfn+3S3Dd3atDNhnzezlS9mwS1y6Reit2xXjjIJI
	2EzCJIhiAWzQ4K/XfkTOIeouSsyLnlmqZK69DAnA/ldV6R5C+Q5isfu0LRnZEA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750949323;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MwVxsIaDgcFb+O8/af0/YU761G/v/g4E9Y+QGYc/05U=;
	b=aGPLl3PxbrjaVlsRxncYQgHcAWiO2kv/pPWxTNJj/NXLkyLfMoDzOUoEdFGtiCiA9kmVOO
	paVWXxmki0g6fuDA==
To: Marc Zyngier <maz@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>,
	Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	=?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
	"K . Y . Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Joyce Ooi <joyce.ooi@intel.com>,
	Jim Quinlan <jim2101024@gmail.com>,
	Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Jianjun Wang <jianjun.wang@mediatek.com>,
	Marek Vasut <marek.vasut+renesas@gmail.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Michal Simek <michal.simek@amd.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Nirmal Patel <nirmal.patel@linux.intel.com>,
	Jonathan Derrick <jonathan.derrick@linux.dev>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-hyperv@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-renesas-soc@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>
Subject: [PATCH 07/16] PCI: mediatek-gen3: Switch to msi_create_parent_irq_domain()
Date: Thu, 26 Jun 2025 16:47:57 +0200
Message-Id: <bfbd2e375269071b69e1aa85e629ee4b7c99518f.1750858083.git.namcao@linutronix.de>
In-Reply-To: <cover.1750858083.git.namcao@linutronix.de>
References: <cover.1750858083.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Move away from the legacy MSI domain setup, switch to use
msi_create_parent_irq_domain().

Signed-off-by: Nam Cao <namcao@linutronix.de>
---
Cc: Ryder Lee <ryder.lee@mediatek.com>
Cc: Jianjun Wang <jianjun.wang@mediatek.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-mediatek@lists.infradead.org
Cc: linux-arm-kernel@lists.infradead.org
---
 drivers/pci/controller/Kconfig              |  1 +
 drivers/pci/controller/pcie-mediatek-gen3.c | 67 ++++++++-------------
 2 files changed, 26 insertions(+), 42 deletions(-)

diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
index 375a019f35bd9..ec32c343a751d 100644
--- a/drivers/pci/controller/Kconfig
+++ b/drivers/pci/controller/Kconfig
@@ -203,6 +203,7 @@ config PCIE_MEDIATEK_GEN3
 	tristate "MediaTek Gen3 PCIe controller"
 	depends on ARCH_AIROHA || ARCH_MEDIATEK || COMPILE_TEST
 	depends on PCI_MSI
+	select IRQ_MSI_LIB
 	help
 	  Adds support for PCIe Gen3 MAC controller for MediaTek SoCs.
 	  This PCIe controller is compatible with Gen3, Gen2 and Gen1 speed,
diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/cont=
roller/pcie-mediatek-gen3.c
index 5464b4ae5c20c..97147f43e41c5 100644
--- a/drivers/pci/controller/pcie-mediatek-gen3.c
+++ b/drivers/pci/controller/pcie-mediatek-gen3.c
@@ -12,6 +12,7 @@
 #include <linux/delay.h>
 #include <linux/iopoll.h>
 #include <linux/irq.h>
+#include <linux/irqchip/irq-msi-lib.h>
 #include <linux/irqchip/chained_irq.h>
 #include <linux/irqdomain.h>
 #include <linux/kernel.h>
@@ -187,7 +188,6 @@ struct mtk_msi_set {
  * @saved_irq_state: IRQ enable state saved at suspend time
  * @irq_lock: lock protecting IRQ register access
  * @intx_domain: legacy INTx IRQ domain
- * @msi_domain: MSI IRQ domain
  * @msi_bottom_domain: MSI IRQ bottom domain
  * @msi_sets: MSI sets information
  * @lock: lock protecting IRQ bit map
@@ -210,7 +210,6 @@ struct mtk_gen3_pcie {
 	u32 saved_irq_state;
 	raw_spinlock_t irq_lock;
 	struct irq_domain *intx_domain;
-	struct irq_domain *msi_domain;
 	struct irq_domain *msi_bottom_domain;
 	struct mtk_msi_set msi_sets[PCIE_MSI_SET_NUM];
 	struct mutex lock;
@@ -526,30 +525,22 @@ static int mtk_pcie_startup_port(struct mtk_gen3_pcie=
 *pcie)
 	return 0;
 }
=20
-static void mtk_pcie_msi_irq_mask(struct irq_data *data)
-{
-	pci_msi_mask_irq(data);
-	irq_chip_mask_parent(data);
-}
-
-static void mtk_pcie_msi_irq_unmask(struct irq_data *data)
-{
-	pci_msi_unmask_irq(data);
-	irq_chip_unmask_parent(data);
-}
-
-static struct irq_chip mtk_msi_irq_chip =3D {
-	.irq_ack =3D irq_chip_ack_parent,
-	.irq_mask =3D mtk_pcie_msi_irq_mask,
-	.irq_unmask =3D mtk_pcie_msi_irq_unmask,
-	.name =3D "MSI",
-};
-
-static struct msi_domain_info mtk_msi_domain_info =3D {
-	.flags	=3D MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
-		  MSI_FLAG_NO_AFFINITY | MSI_FLAG_PCI_MSIX |
-		  MSI_FLAG_MULTI_PCI_MSI,
-	.chip	=3D &mtk_msi_irq_chip,
+#define MTK_MSI_FLAGS_REQUIRED (MSI_FLAG_USE_DEF_DOM_OPS	| \
+				MSI_FLAG_USE_DEF_CHIP_OPS	| \
+				MSI_FLAG_NO_AFFINITY		| \
+				MSI_FLAG_PCI_MSI_MASK_PARENT)
+
+#define MTK_MSI_FLAGS_SUPPORTED (MSI_GENERIC_FLAGS_MASK		| \
+				 MSI_FLAG_PCI_MSIX		| \
+				 MSI_FLAG_MULTI_PCI_MSI)
+
+static const struct msi_parent_ops mtk_msi_parent_ops =3D {
+	.required_flags		=3D MTK_MSI_FLAGS_REQUIRED,
+	.supported_flags	=3D MTK_MSI_FLAGS_SUPPORTED,
+	.bus_select_token	=3D DOMAIN_BUS_PCI_MSI,
+	.chip_flags		=3D MSI_CHIP_FLAG_SET_ACK,
+	.prefix			=3D "MTK3-",
+	.init_dev_msi_info	=3D msi_lib_init_dev_msi_info,
 };
=20
 static void mtk_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
@@ -756,28 +747,23 @@ static int mtk_pcie_init_irq_domains(struct mtk_gen3_=
pcie *pcie)
 	/* Setup MSI */
 	mutex_init(&pcie->lock);
=20
-	pcie->msi_bottom_domain =3D irq_domain_create_linear(dev_fwnode(dev), PCI=
E_MSI_IRQS_NUM,
-							   &mtk_msi_bottom_domain_ops, pcie);
+	struct irq_domain_info info =3D {
+		.fwnode		=3D dev_fwnode(dev),
+		.ops		=3D &mtk_msi_bottom_domain_ops,
+		.host_data	=3D pcie,
+		.size		=3D PCIE_MSI_IRQS_NUM,
+	};
+
+	pcie->msi_bottom_domain =3D msi_create_parent_irq_domain(&info, &mtk_msi_=
parent_ops);
 	if (!pcie->msi_bottom_domain) {
 		dev_err(dev, "failed to create MSI bottom domain\n");
 		ret =3D -ENODEV;
 		goto err_msi_bottom_domain;
 	}
=20
-	pcie->msi_domain =3D pci_msi_create_irq_domain(dev->fwnode,
-						     &mtk_msi_domain_info,
-						     pcie->msi_bottom_domain);
-	if (!pcie->msi_domain) {
-		dev_err(dev, "failed to create MSI domain\n");
-		ret =3D -ENODEV;
-		goto err_msi_domain;
-	}
-
 	of_node_put(intc_node);
 	return 0;
=20
-err_msi_domain:
-	irq_domain_remove(pcie->msi_bottom_domain);
 err_msi_bottom_domain:
 	irq_domain_remove(pcie->intx_domain);
 out_put_node:
@@ -792,9 +778,6 @@ static void mtk_pcie_irq_teardown(struct mtk_gen3_pcie =
*pcie)
 	if (pcie->intx_domain)
 		irq_domain_remove(pcie->intx_domain);
=20
-	if (pcie->msi_domain)
-		irq_domain_remove(pcie->msi_domain);
-
 	if (pcie->msi_bottom_domain)
 		irq_domain_remove(pcie->msi_bottom_domain);
=20
--=20
2.39.5


