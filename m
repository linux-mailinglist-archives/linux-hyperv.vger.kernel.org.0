Return-Path: <linux-hyperv+bounces-6015-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C6E8AEA16A
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Jun 2025 16:55:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB92D176980
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Jun 2025 14:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13A822EF673;
	Thu, 26 Jun 2025 14:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OoYu8rv3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qNEyVvI5"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B1F12EBDC5;
	Thu, 26 Jun 2025 14:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750949329; cv=none; b=NVkfSdOxpr6w7tH6mf20YPDQSlLMT15LIK4plYAkhpeAc1svEcP/n8xtyZOafiMYFDLOTrke6zpNFsDiZqEVR2RrMJXuWo54Ry5zSUM8y7/p/OgQArCDCyTbSkvio7LyKykGIo3oyO81MmbPPZymyTRtCdPqW2EevcHFkGVqPJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750949329; c=relaxed/simple;
	bh=okE/Fz1McZVtRORK5MwPhing6ZYz2Iy4bP3rNzOs+yM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Dcfp90Y5dYcy1WAoDTL9BUAvHEQT7aHGrNWH+UPuCGbACuORsSzOK8tnypDV0kRdeNJqAptDyRYmibpR3aHzlJvr/mE6ois2vNFvHFBs2KzXji1aCwoLv0UrDLPhq1g5Z4MtqEUjijkS+GT4rItQmVrVnaA4U7dp1bZw4BwTKK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OoYu8rv3; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qNEyVvI5; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750949326;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lX+GL/mG9RSpXIbAIV8/nBgAmDvnZs8ggahXv/ElRgQ=;
	b=OoYu8rv3JfM135IJX00YiZmy+0T1/QCYkjEqLxh4mhHsarXg6mIPDN1V/OQHzMcKpB+259
	x6q5xQN7Xw5q0zQx9vPXpsc5QBAFBpyFSOxqsPROsHUb+tbE9I8AT/uN3DVQreli3DR1vm
	WuMAlP6l4gf7c5nibi01KTyw7uJLo701yqQq2uODvmMRFE4bHQdfXDlYs1ppAlBe0T7BlV
	aysnK516amS8t5ysVUH78LghGHDVptfGYHX487F41N8Giece8B2Xd5TqNwROXFQlISRy3U
	ujJEwPk0GudVi40OwWjp5qlvt4Qn68SpbkREKsAqyJWJNjYy2ZTRTSKNnSGAWw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750949326;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lX+GL/mG9RSpXIbAIV8/nBgAmDvnZs8ggahXv/ElRgQ=;
	b=qNEyVvI5FJd2MbE/+B7tQBrMp8qdz/32D0lZZbva4a0DiqZ6geSfBbVB3Tek06KFTV8G1o
	omudrJp7AAjPUwDQ==
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
Cc: Nam Cao <namcao@linutronix.de>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>
Subject: [PATCH 09/16] PCI: rcar-host: Switch to msi_create_parent_irq_domain()
Date: Thu, 26 Jun 2025 16:47:59 +0200
Message-Id: <ab4005db0a829549be1f348f6c27be50a2118b5e.1750858083.git.namcao@linutronix.de>
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
Cc: Marek Vasut <marek.vasut+renesas@gmail.com>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-renesas-soc@vger.kernel.org
---
 drivers/pci/controller/Kconfig          |  1 +
 drivers/pci/controller/pcie-rcar-host.c | 69 +++++++++----------------
 2 files changed, 26 insertions(+), 44 deletions(-)

diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
index 65289a171333c..8b9492e9ae693 100644
--- a/drivers/pci/controller/Kconfig
+++ b/drivers/pci/controller/Kconfig
@@ -243,6 +243,7 @@ config PCIE_RCAR_HOST
 	bool "Renesas R-Car PCIe controller (host mode)"
 	depends on ARCH_RENESAS || COMPILE_TEST
 	depends on PCI_MSI
+	select IRQ_MSI_LIB
 	help
 	  Say Y here if you want PCIe controller support on R-Car SoCs in host
 	  mode.
diff --git a/drivers/pci/controller/pcie-rcar-host.c b/drivers/pci/controll=
er/pcie-rcar-host.c
index c32b803a47c7c..ad2bda635d47f 100644
--- a/drivers/pci/controller/pcie-rcar-host.c
+++ b/drivers/pci/controller/pcie-rcar-host.c
@@ -17,6 +17,7 @@
 #include <linux/delay.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
+#include <linux/irqchip/irq-msi-lib.h>
 #include <linux/irqdomain.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
@@ -597,30 +598,6 @@ static irqreturn_t rcar_pcie_msi_irq(int irq, void *da=
ta)
 	return IRQ_HANDLED;
 }
=20
-static void rcar_msi_top_irq_ack(struct irq_data *d)
-{
-	irq_chip_ack_parent(d);
-}
-
-static void rcar_msi_top_irq_mask(struct irq_data *d)
-{
-	pci_msi_mask_irq(d);
-	irq_chip_mask_parent(d);
-}
-
-static void rcar_msi_top_irq_unmask(struct irq_data *d)
-{
-	pci_msi_unmask_irq(d);
-	irq_chip_unmask_parent(d);
-}
-
-static struct irq_chip rcar_msi_top_chip =3D {
-	.name		=3D "PCIe MSI",
-	.irq_ack	=3D rcar_msi_top_irq_ack,
-	.irq_mask	=3D rcar_msi_top_irq_mask,
-	.irq_unmask	=3D rcar_msi_top_irq_unmask,
-};
-
 static void rcar_msi_irq_ack(struct irq_data *d)
 {
 	struct rcar_msi *msi =3D irq_data_get_irq_chip_data(d);
@@ -718,30 +695,37 @@ static const struct irq_domain_ops rcar_msi_domain_op=
s =3D {
 	.free	=3D rcar_msi_domain_free,
 };
=20
-static struct msi_domain_info rcar_msi_info =3D {
-	.flags	=3D MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
-		  MSI_FLAG_NO_AFFINITY | MSI_FLAG_MULTI_PCI_MSI,
-	.chip	=3D &rcar_msi_top_chip,
+#define RCAR_MSI_FLAGS_REQUIRED (MSI_FLAG_USE_DEF_DOM_OPS	| \
+				 MSI_FLAG_USE_DEF_CHIP_OPS	| \
+				 MSI_FLAG_PCI_MSI_MASK_PARENT	| \
+				 MSI_FLAG_NO_AFFINITY)
+
+#define RCAR_MSI_FLAGS_SUPPORTED (MSI_GENERIC_FLAGS_MASK	| \
+				  MSI_FLAG_MULTI_PCI_MSI)
+
+static const struct msi_parent_ops rcar_msi_parent_ops =3D {
+	.required_flags		=3D RCAR_MSI_FLAGS_REQUIRED,
+	.supported_flags	=3D RCAR_MSI_FLAGS_SUPPORTED,
+	.bus_select_token	=3D DOMAIN_BUS_PCI_MSI,
+	.chip_flags		=3D MSI_CHIP_FLAG_SET_ACK,
+	.prefix			=3D "RCAR-",
+	.init_dev_msi_info	=3D msi_lib_init_dev_msi_info,
 };
=20
 static int rcar_allocate_domains(struct rcar_msi *msi)
 {
 	struct rcar_pcie *pcie =3D &msi_to_host(msi)->pcie;
 	struct fwnode_handle *fwnode =3D dev_fwnode(pcie->dev);
-	struct irq_domain *parent;
-
-	parent =3D irq_domain_create_linear(fwnode, INT_PCI_MSI_NR,
-					  &rcar_msi_domain_ops, msi);
-	if (!parent) {
-		dev_err(pcie->dev, "failed to create IRQ domain\n");
-		return -ENOMEM;
-	}
-	irq_domain_update_bus_token(parent, DOMAIN_BUS_NEXUS);
-
-	msi->domain =3D pci_msi_create_irq_domain(fwnode, &rcar_msi_info, parent);
+	struct irq_domain_info info =3D {
+		.fwnode		=3D fwnode,
+		.ops		=3D &rcar_msi_domain_ops,
+		.host_data	=3D msi,
+		.size		=3D INT_PCI_MSI_NR,
+	};
+
+	msi->domain =3D msi_create_parent_irq_domain(&info, &rcar_msi_parent_ops);
 	if (!msi->domain) {
-		dev_err(pcie->dev, "failed to create MSI domain\n");
-		irq_domain_remove(parent);
+		dev_err(pcie->dev, "failed to create IRQ domain\n");
 		return -ENOMEM;
 	}
=20
@@ -750,10 +734,7 @@ static int rcar_allocate_domains(struct rcar_msi *msi)
=20
 static void rcar_free_domains(struct rcar_msi *msi)
 {
-	struct irq_domain *parent =3D msi->domain->parent;
-
 	irq_domain_remove(msi->domain);
-	irq_domain_remove(parent);
 }
=20
 static int rcar_pcie_enable_msi(struct rcar_pcie_host *host)
--=20
2.39.5


