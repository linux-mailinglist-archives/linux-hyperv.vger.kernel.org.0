Return-Path: <linux-hyperv+bounces-6018-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A419AEA188
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Jun 2025 16:57:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA2F23BA582
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Jun 2025 14:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9B7B2F0C71;
	Thu, 26 Jun 2025 14:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BWsAMIEX";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0Ttl4EGH"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB8E52F0040;
	Thu, 26 Jun 2025 14:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750949333; cv=none; b=HjptqER+aP0sfZN1Gs+NviHfRfi8pQZa/WNNJTx0Be5kpAHWFJTF0VyvxyogrOFnEf05pdT94O+B0zfiJGWuQR/r9qMj3/2IIiqHjJbfrRNsPKFmqTB4fUDvaZRjTCuRrJptRpf5xhEgwsnid0OlkU6/kvFXpPSaih/2l/NnnS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750949333; c=relaxed/simple;
	bh=kBHBJcZULxETLid4CMAxJ0XPxNUqEgwOhe+01bEdVfI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mDxxtQH4cgjLu/3plxYiCVb1v16McAqStprvSrw+2bA19IzMDgJSCUQ3llc1/jUZXd5Y1wd/97Z3R+RgYkzLUu9Yzm9Jy/6LFy6fIhbPij5Ddt98rNefgeB8fklimz4GtdXWYxpk6zDNau4+2DaUXEoZYuSRmHvc63S+0Gef9C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BWsAMIEX; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0Ttl4EGH; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750949330;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SPz0UIb8BdeNoBLp9wXX3nXPR2tzO5DgNka4xGkq1eY=;
	b=BWsAMIEXKbV+RPUr+v+3p2AIgPozHRs9rxEJ/uL4qAPO5E2ddQ9zGl0hsOCtN0pvLN107y
	gd6e837WWtX5KLhGd/zc3erryZhJxnd7PtAhad7Lt41iWAnh71VslEr6Tvo4zulUNBXCC6
	C+vJK0/8LQioGA12Lss+Dv6W6z3O/BfMi2YCknp7+gOftIpNi8E2DopNTSbe4beHaNoxUE
	n9bi+8FE6DCjJ5me/CQbmgh0uG9X/yKv5ikswyuhuNAJI2BVyEruUoSpi6KeLiIwEpFbgC
	4ms2DgGmSceOvKeyNN5p6TCwDuaV3NUTdcqI4LrFQ9Pm6CL+bt7ourPJBmCZWw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750949330;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SPz0UIb8BdeNoBLp9wXX3nXPR2tzO5DgNka4xGkq1eY=;
	b=0Ttl4EGH6cdzgLzfg6Rist2/M7znNrcwcdYiO/cbmM5BmXZyzQww4BqMxKD3jx4SGxt4RQ
	mF5uRGyoiseCdiAg==
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
Subject: [PATCH 12/16] PCI: xilinx: Switch to msi_create_parent_irq_domain()
Date: Thu, 26 Jun 2025 16:48:02 +0200
Message-Id: <b1353c797ce53714c22823de3bd2ae3d09fcd84f.1750858083.git.namcao@linutronix.de>
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
Cc: Michal Simek <michal.simek@amd.com>
Cc: linux-arm-kernel@lists.infradead.org
---
 drivers/pci/controller/Kconfig       |  1 +
 drivers/pci/controller/pcie-xilinx.c | 55 ++++++++++++++++------------
 2 files changed, 32 insertions(+), 24 deletions(-)

diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
index 118ff622fa69e..8f56ffd029ba2 100644
--- a/drivers/pci/controller/Kconfig
+++ b/drivers/pci/controller/Kconfig
@@ -322,6 +322,7 @@ config PCIE_XILINX
 	bool "Xilinx AXI PCIe controller"
 	depends on OF
 	depends on PCI_MSI
+	select IRQ_MSI_LIB
 	help
 	  Say 'Y' here if you want kernel to support the Xilinx AXI PCIe
 	  Host Bridge driver.
diff --git a/drivers/pci/controller/pcie-xilinx.c b/drivers/pci/controller/=
pcie-xilinx.c
index e36aa874bae92..ddc2ab6c48b9b 100644
--- a/drivers/pci/controller/pcie-xilinx.c
+++ b/drivers/pci/controller/pcie-xilinx.c
@@ -12,6 +12,7 @@
=20
 #include <linux/interrupt.h>
 #include <linux/irq.h>
+#include <linux/irqchip/irq-msi-lib.h>
 #include <linux/irqdomain.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
@@ -203,11 +204,6 @@ static void xilinx_msi_top_irq_ack(struct irq_data *d)
 	 */
 }
=20
-static struct irq_chip xilinx_msi_top_chip =3D {
-	.name		=3D "PCIe MSI",
-	.irq_ack	=3D xilinx_msi_top_irq_ack,
-};
-
 static void xilinx_compose_msi_msg(struct irq_data *data, struct msi_msg *=
msg)
 {
 	struct xilinx_pcie *pcie =3D irq_data_get_irq_chip_data(data);
@@ -264,29 +260,43 @@ static const struct irq_domain_ops xilinx_msi_domain_=
ops =3D {
 	.free	=3D xilinx_msi_domain_free,
 };
=20
-static struct msi_domain_info xilinx_msi_info =3D {
-	.flags	=3D MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
-		  MSI_FLAG_NO_AFFINITY,
-	.chip	=3D &xilinx_msi_top_chip,
+static bool xilinx_init_dev_msi_info(struct device *dev, struct irq_domain=
 *domain,
+				     struct irq_domain *real_parent, struct msi_domain_info *info)
+{
+	struct irq_chip *chip =3D info->chip;
+
+	if (!msi_lib_init_dev_msi_info(dev, domain, real_parent, info))
+		return false;
+
+	chip->irq_ack =3D xilinx_msi_top_irq_ack;
+	return true;
+}
+
+#define XILINX_MSI_FLAGS_REQUIRED (MSI_FLAG_USE_DEF_DOM_OPS	| \
+				   MSI_FLAG_USE_DEF_CHIP_OPS	| \
+				   MSI_FLAG_NO_AFFINITY)
+
+static const struct msi_parent_ops xilinx_msi_parent_ops =3D {
+	.required_flags		=3D XILINX_MSI_FLAGS_REQUIRED,
+	.supported_flags	=3D MSI_GENERIC_FLAGS_MASK,
+	.bus_select_token	=3D DOMAIN_BUS_PCI_MSI,
+	.prefix			=3D "xilinx-",
+	.init_dev_msi_info	=3D xilinx_init_dev_msi_info,
 };
=20
 static int xilinx_allocate_msi_domains(struct xilinx_pcie *pcie)
 {
 	struct fwnode_handle *fwnode =3D dev_fwnode(pcie->dev);
-	struct irq_domain *parent;
-
-	parent =3D irq_domain_create_linear(fwnode, XILINX_NUM_MSI_IRQS,
-					  &xilinx_msi_domain_ops, pcie);
-	if (!parent) {
-		dev_err(pcie->dev, "failed to create IRQ domain\n");
-		return -ENOMEM;
-	}
-	irq_domain_update_bus_token(parent, DOMAIN_BUS_NEXUS);
-
-	pcie->msi_domain =3D pci_msi_create_irq_domain(fwnode, &xilinx_msi_info, =
parent);
+	struct irq_domain_info info =3D {
+		.fwnode		=3D fwnode,
+		.ops		=3D &xilinx_msi_domain_ops,
+		.host_data	=3D pcie,
+		.size		=3D XILINX_NUM_MSI_IRQS,
+	};
+
+	pcie->msi_domain =3D msi_create_parent_irq_domain(&info, &xilinx_msi_pare=
nt_ops);
 	if (!pcie->msi_domain) {
 		dev_err(pcie->dev, "failed to create MSI domain\n");
-		irq_domain_remove(parent);
 		return -ENOMEM;
 	}
=20
@@ -295,10 +305,7 @@ static int xilinx_allocate_msi_domains(struct xilinx_p=
cie *pcie)
=20
 static void xilinx_free_msi_domains(struct xilinx_pcie *pcie)
 {
-	struct irq_domain *parent =3D pcie->msi_domain->parent;
-
 	irq_domain_remove(pcie->msi_domain);
-	irq_domain_remove(parent);
 }
=20
 /* INTx Functions */
--=20
2.39.5


