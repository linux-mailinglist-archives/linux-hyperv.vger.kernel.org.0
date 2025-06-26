Return-Path: <linux-hyperv+bounces-6014-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB0B0AEA17D
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Jun 2025 16:56:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BFE16A5857
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Jun 2025 14:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A0172EF656;
	Thu, 26 Jun 2025 14:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="z/Jr2XO7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vAY4S6Qh"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF2D2EE992;
	Thu, 26 Jun 2025 14:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750949328; cv=none; b=I3vDEHbisZFDBC7Wc3UjTL+UP5aWfeiUY9yhSvl3hqG07jXBhtwXUzWJSYmoFiYoSHb6xsKkYP47jHZyWnqbTYHCjPRWRxzTM7hk0ebyU6cVbjqWRwbiJeQT78bGLp3nW70/JWZo0cYHOAH9qnK7AOZtZmL2Momqua0SC7lo1eI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750949328; c=relaxed/simple;
	bh=lrklnrT96EGX3MaETe5+RdWaz8DS3ZcfPitUJdjyvYI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Plojy7dal04hCTFCP3OuolKD5yFey9H2n/ezZuNiNydfu+vinPf8eXg7WWoRl2Wk98uo/vPPF+VNifDBMPT4I6s5IHAakH61ZF37igUFkzvnssftPIGRpv+ynXtRrWyeCMvvfq18EYDxTAS0MJe/7iIRbmh1JY0V+4YCWga8qTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=z/Jr2XO7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vAY4S6Qh; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750949324;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PL2qDWi3pt7sgP22kM6CYykFBDUpgVDZeges0uU0BWA=;
	b=z/Jr2XO7BH0ySGAekOpV+Cf8qRhZAAawlGtbgTrrAiEou5jG0DZxpORVM92PSY3nSA2x7X
	5qjS/Z/Az1R9A34yKlykCxNry/5U+biU6CCaE7z6d2Qa/t4/8XGRa5RYqd1pVnZzg7FJ38
	En1TcwCIyakV1bTvGQw1CPdrAAX13vBRWMqPWlnLwMtqh6kgzAytcz9IvMODN7YgF5LTuq
	gneWVOXk9FFUakQzpksCsCCHwXypevrIhJekA7pkTLS8XfHHZUTQTXNvcQbAbKfeD0pnLR
	iDVOkIUngpMqjq99TyDMfB/Acc564mfiEWOK/274ghetLyXEMN8Q7LC4HcYeIg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750949324;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PL2qDWi3pt7sgP22kM6CYykFBDUpgVDZeges0uU0BWA=;
	b=vAY4S6QhgCs+vVJiGpYBNhIKc1zpRX32BQp9RA/DpPxZ5vdCkp90MV7E+IwFf8eTkSsO5K
	yKOfwPjryMkQQhAQ==
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
Subject: [PATCH 08/16] PCI: mediatek: Switch to msi_create_parent_irq_domain()
Date: Thu, 26 Jun 2025 16:47:58 +0200
Message-Id: <76f6e6ce6021607cd0fdfd79fef7d2eb69d9f361.1750858083.git.namcao@linutronix.de>
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
 drivers/pci/controller/Kconfig         |  1 +
 drivers/pci/controller/pcie-mediatek.c | 46 ++++++++++++--------------
 2 files changed, 23 insertions(+), 24 deletions(-)

diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
index ec32c343a751d..65289a171333c 100644
--- a/drivers/pci/controller/Kconfig
+++ b/drivers/pci/controller/Kconfig
@@ -195,6 +195,7 @@ config PCIE_MEDIATEK
 	depends on ARCH_AIROHA || ARCH_MEDIATEK || COMPILE_TEST
 	depends on OF
 	depends on PCI_MSI
+	select IRQ_MSI_LIB
 	help
 	  Say Y here if you want to enable PCIe controller support on
 	  MediaTek SoCs.
diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controlle=
r/pcie-mediatek.c
index e1934aa06c8d5..3ac5d14dd543e 100644
--- a/drivers/pci/controller/pcie-mediatek.c
+++ b/drivers/pci/controller/pcie-mediatek.c
@@ -12,6 +12,7 @@
 #include <linux/iopoll.h>
 #include <linux/irq.h>
 #include <linux/irqchip/chained_irq.h>
+#include <linux/irqchip/irq-msi-lib.h>
 #include <linux/irqdomain.h>
 #include <linux/kernel.h>
 #include <linux/mfd/syscon.h>
@@ -180,7 +181,6 @@ struct mtk_pcie_soc {
  * @irq: GIC irq
  * @irq_domain: legacy INTx IRQ domain
  * @inner_domain: inner IRQ domain
- * @msi_domain: MSI IRQ domain
  * @lock: protect the msi_irq_in_use bitmap
  * @msi_irq_in_use: bit map for assigned MSI IRQ
  */
@@ -200,7 +200,6 @@ struct mtk_pcie_port {
 	int irq;
 	struct irq_domain *irq_domain;
 	struct irq_domain *inner_domain;
-	struct irq_domain *msi_domain;
 	struct mutex lock;
 	DECLARE_BITMAP(msi_irq_in_use, MTK_MSI_IRQS_NUM);
 };
@@ -470,17 +469,20 @@ static const struct irq_domain_ops msi_domain_ops =3D=
 {
 	.free	=3D mtk_pcie_irq_domain_free,
 };
=20
-static struct irq_chip mtk_msi_irq_chip =3D {
-	.name		=3D "MTK PCIe MSI",
-	.irq_ack	=3D irq_chip_ack_parent,
-	.irq_mask	=3D pci_msi_mask_irq,
-	.irq_unmask	=3D pci_msi_unmask_irq,
-};
+#define MTK_MSI_FLAGS_REQUIRED (MSI_FLAG_USE_DEF_DOM_OPS	| \
+				MSI_FLAG_USE_DEF_CHIP_OPS	| \
+				MSI_FLAG_NO_AFFINITY)
+
+#define MTK_MSI_FLAGS_SUPPORTED (MSI_GENERIC_FLAGS_MASK		| \
+				 MSI_FLAG_PCI_MSIX)
=20
-static struct msi_domain_info mtk_msi_domain_info =3D {
-	.flags	=3D MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
-		  MSI_FLAG_NO_AFFINITY | MSI_FLAG_PCI_MSIX,
-	.chip	=3D &mtk_msi_irq_chip,
+static const struct msi_parent_ops mtk_msi_parent_ops =3D {
+	.required_flags		=3D MTK_MSI_FLAGS_REQUIRED,
+	.supported_flags	=3D MTK_MSI_FLAGS_SUPPORTED,
+	.bus_select_token	=3D DOMAIN_BUS_PCI_MSI,
+	.chip_flags		=3D MSI_CHIP_FLAG_SET_ACK,
+	.prefix			=3D "MTK-",
+	.init_dev_msi_info	=3D msi_lib_init_dev_msi_info,
 };
=20
 static int mtk_pcie_allocate_msi_domains(struct mtk_pcie_port *port)
@@ -489,21 +491,19 @@ static int mtk_pcie_allocate_msi_domains(struct mtk_p=
cie_port *port)
=20
 	mutex_init(&port->lock);
=20
-	port->inner_domain =3D irq_domain_create_linear(fwnode, MTK_MSI_IRQS_NUM,
-						      &msi_domain_ops, port);
+	struct irq_domain_info info =3D {
+		.fwnode		=3D fwnode,
+		.ops		=3D &msi_domain_ops,
+		.host_data	=3D port,
+		.size		=3D MTK_MSI_IRQS_NUM,
+	};
+
+	port->inner_domain =3D msi_create_parent_irq_domain(&info, &mtk_msi_paren=
t_ops);
 	if (!port->inner_domain) {
 		dev_err(port->pcie->dev, "failed to create IRQ domain\n");
 		return -ENOMEM;
 	}
=20
-	port->msi_domain =3D pci_msi_create_irq_domain(fwnode, &mtk_msi_domain_in=
fo,
-						     port->inner_domain);
-	if (!port->msi_domain) {
-		dev_err(port->pcie->dev, "failed to create MSI domain\n");
-		irq_domain_remove(port->inner_domain);
-		return -ENOMEM;
-	}
-
 	return 0;
 }
=20
@@ -532,8 +532,6 @@ static void mtk_pcie_irq_teardown(struct mtk_pcie *pcie)
 			irq_domain_remove(port->irq_domain);
=20
 		if (IS_ENABLED(CONFIG_PCI_MSI)) {
-			if (port->msi_domain)
-				irq_domain_remove(port->msi_domain);
 			if (port->inner_domain)
 				irq_domain_remove(port->inner_domain);
 		}
--=20
2.39.5


