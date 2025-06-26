Return-Path: <linux-hyperv+bounces-6017-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 691C7AEA183
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Jun 2025 16:57:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B12523B3A40
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Jun 2025 14:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45E422F0050;
	Thu, 26 Jun 2025 14:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="H8giNEu/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ESyNPhNO"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B4342EFD86;
	Thu, 26 Jun 2025 14:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750949332; cv=none; b=sGjAXwhU4aAjlGLWradrcC4exc0yBVtK7PUC7nlhAYsIDKQMLCgqKAxfTg7fLXuvTNuiqEghglGHpbkopHuYFDSZNrRWhvP5V0ECXuK+/cIBfNRmvlGVDJ2oZFjIKhMuFSzFW4FEqDVMDnG3qbWD+amncxLBdb+S+i0Vc5GWA4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750949332; c=relaxed/simple;
	bh=fx8JANi2q4Q8EbX6sgv5Qfo0mEy5f6B6awTbzCBJwvM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ea8oBpm2AfqEr6m0h82WxM1d4/e7aAXjnzOsEPcOXEeRaTLGRxgZjcXlbH5P3CHXEEU6mrihrDPaWKVZmbKTNYJUyeHsA+nbFlPGtyyYx0GrC+cXwdI8JDQv8oTdMvN5aFZxlHZ8bT1ELKe2/G7X2heylf1H3zpB51RJ9/ZkhZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=H8giNEu/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ESyNPhNO; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750949328;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3+g8SPUov2wifU1QhFfv4IwPGImz+A+TfnYXt6pSi+Q=;
	b=H8giNEu/dcqnp89pk+8fjIcrbCfR5PNcRNovF1I3TknT+z0fyKYUMXgPDEnD03vcN7hUUJ
	8cBO9hqrZ4IcMgQ0u+58XIAV3INYBHGWy9IJSNCy7JcRsqLOsGE5e9ok8VHzRv4wdpwJQw
	ZQmGqlEdyD5P8LozMImg5hLyAdbDnMKeLc086e7oKSjgcg21Nw+HSgN8Qk5qNS9R+ACDX+
	/uy5rtXLLMNkb9X6ZKWFxK9CL53Pd+os9AFcja42aGs3QsrNYjGn/Rfuyg/PYNUjXakcER
	BUJ9UEdyGtPej3PA4Y4XDivzDkXKGwOvx4T9d+9aUZVHsDdeW7MuXrORPYqdfg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750949328;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3+g8SPUov2wifU1QhFfv4IwPGImz+A+TfnYXt6pSi+Q=;
	b=ESyNPhNOvvh9/+CcFrVHIi30xlMa63Olqw/GhyrVxRyizpYy+LsueczDdIfbFTl2LDm0w2
	Nsp6eRGeYkOgjCDA==
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
Subject: [PATCH 11/16] PCI: xilinx-nwl: Switch to msi_create_parent_irq_domain()
Date: Thu, 26 Jun 2025 16:48:01 +0200
Message-Id: <5ac6e216bf2eaa438c8854baf2ff3e5cf0b2284f.1750858083.git.namcao@linutronix.de>
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
 drivers/pci/controller/Kconfig           |  1 +
 drivers/pci/controller/pcie-xilinx-nwl.c | 45 ++++++++++++------------
 2 files changed, 24 insertions(+), 22 deletions(-)

diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
index c9b6180239732..118ff622fa69e 100644
--- a/drivers/pci/controller/Kconfig
+++ b/drivers/pci/controller/Kconfig
@@ -342,6 +342,7 @@ config PCIE_XILINX_NWL
 	bool "Xilinx NWL PCIe controller"
 	depends on ARCH_ZYNQMP || COMPILE_TEST
 	depends on PCI_MSI
+	select IRQ_MSI_LIB
 	help
 	 Say 'Y' here if you want kernel support for Xilinx
 	 NWL PCIe controller. The controller can act as Root Port
diff --git a/drivers/pci/controller/pcie-xilinx-nwl.c b/drivers/pci/control=
ler/pcie-xilinx-nwl.c
index c8b05477b7198..de76c836915f0 100644
--- a/drivers/pci/controller/pcie-xilinx-nwl.c
+++ b/drivers/pci/controller/pcie-xilinx-nwl.c
@@ -10,6 +10,7 @@
 #include <linux/delay.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
+#include <linux/irqchip/irq-msi-lib.h>
 #include <linux/irqdomain.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
@@ -145,7 +146,6 @@
 #define LINK_WAIT_USLEEP_MAX           100000
=20
 struct nwl_msi {			/* MSI information */
-	struct irq_domain *msi_domain;
 	DECLARE_BITMAP(bitmap, INT_PCI_MSI_NR);
 	struct irq_domain *dev_domain;
 	struct mutex lock;		/* protect bitmap variable */
@@ -418,19 +418,22 @@ static const struct irq_domain_ops intx_domain_ops =
=3D {
 };
=20
 #ifdef CONFIG_PCI_MSI
-static struct irq_chip nwl_msi_irq_chip =3D {
-	.name =3D "nwl_pcie:msi",
-	.irq_enable =3D pci_msi_unmask_irq,
-	.irq_disable =3D pci_msi_mask_irq,
-	.irq_mask =3D pci_msi_mask_irq,
-	.irq_unmask =3D pci_msi_unmask_irq,
-};
=20
-static struct msi_domain_info nwl_msi_domain_info =3D {
-	.flags =3D MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
-		 MSI_FLAG_NO_AFFINITY | MSI_FLAG_MULTI_PCI_MSI,
-	.chip =3D &nwl_msi_irq_chip,
+#define NWL_MSI_FLAGS_REQUIRED (MSI_FLAG_USE_DEF_DOM_OPS	| \
+				MSI_FLAG_USE_DEF_CHIP_OPS	| \
+				MSI_FLAG_NO_AFFINITY)
+
+#define NWL_MSI_FLAGS_SUPPORTED (MSI_GENERIC_FLAGS_MASK		| \
+				 MSI_FLAG_MULTI_PCI_MSI)
+
+static const struct msi_parent_ops nwl_msi_parent_ops =3D {
+	.required_flags		=3D NWL_MSI_FLAGS_REQUIRED,
+	.supported_flags	=3D NWL_MSI_FLAGS_SUPPORTED,
+	.bus_select_token	=3D DOMAIN_BUS_PCI_MSI,
+	.prefix			=3D "nwl-",
+	.init_dev_msi_info	=3D msi_lib_init_dev_msi_info,
 };
+
 #endif
=20
 static void nwl_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
@@ -497,20 +500,18 @@ static int nwl_pcie_init_msi_irq_domain(struct nwl_pc=
ie *pcie)
 	struct device *dev =3D pcie->dev;
 	struct fwnode_handle *fwnode =3D of_fwnode_handle(dev->of_node);
 	struct nwl_msi *msi =3D &pcie->msi;
-
-	msi->dev_domain =3D irq_domain_create_linear(NULL, INT_PCI_MSI_NR, &dev_m=
si_domain_ops, pcie);
+	struct irq_domain_info info =3D {
+		.fwnode		=3D fwnode,
+		.ops		=3D &dev_msi_domain_ops,
+		.host_data	=3D pcie,
+		.size		=3D INT_PCI_MSI_NR,
+	};
+
+	msi->dev_domain  =3D msi_create_parent_irq_domain(&info, &nwl_msi_parent_=
ops);
 	if (!msi->dev_domain) {
 		dev_err(dev, "failed to create dev IRQ domain\n");
 		return -ENOMEM;
 	}
-	msi->msi_domain =3D pci_msi_create_irq_domain(fwnode,
-						    &nwl_msi_domain_info,
-						    msi->dev_domain);
-	if (!msi->msi_domain) {
-		dev_err(dev, "failed to create msi IRQ domain\n");
-		irq_domain_remove(msi->dev_domain);
-		return -ENOMEM;
-	}
 #endif
 	return 0;
 }
--=20
2.39.5


