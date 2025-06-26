Return-Path: <linux-hyperv+bounces-6016-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC60DAEA17F
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Jun 2025 16:57:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7E6D6A674B
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Jun 2025 14:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DC982EF9D5;
	Thu, 26 Jun 2025 14:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MBG2XPkq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ywRcYRgi"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B512EF660;
	Thu, 26 Jun 2025 14:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750949330; cv=none; b=X/irWxVsJslxSYHILQTYTLrsAq8rEqd7nMYI5rwyF3TJG5sjHh/2AcrtoGRZSzB00XJIMaZqgTwFg6cqMiP/N7+LtCTCsfj94XL+vhxNQ9zisPMAYZd/52MTu5t0SvLsyzI0aKxc/YSrQzkSlSl+fvUAmL+vPGaZAFDRAFg8w7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750949330; c=relaxed/simple;
	bh=MeYTNl0+MUh2L9V4JTiTVQHUB12AJPKagM6B0Zbhac0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WtLbGAAE3aZuIIWXZdIl8Qi9xzrpmjsPx4f/ZEWmvr7UgigPE+RkOHNbE9XWEFXzF3y4SXvgrqsdEuMoA59mTmp+LeI11XjfrSTxdKK1jiFAdNERqx0ZD5p9iQoyfFivKDZMfQ9mdz97NQ26OQPruMVmleCgoe7RI8RzhcUFhZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MBG2XPkq; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ywRcYRgi; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750949327;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0YvHDwNtH7JCA3yTrFzmAWls6d21ROaLNNWeeQE+7RU=;
	b=MBG2XPkqXhhV2bLEtvA59slqHsgL7Z6rDDVkc2MF41m6pMdBsalBsUVGypGVk6xk0oeHKE
	/UlgPT+GhSsHHaPCLSnDknWCIwbYyhh0D/e1TNgXuYj9gG+0RddQiPTLg158aREKPzD9ag
	+Qh8B8eqiWYkaASefNKq5P3fIcu/CgNoy787GdV8ED3KxVMSd4DplKL7kTzL3TDciQ96bD
	mo4VCR/IwN8gePoeCi9P34lMKwB6EN1MHDyz4lUqzGFVjBJSiKUgKCeOOzxOPBRZNfSbuG
	ylBTTDuKMse1QgFOYm+3IKrLZWZf3IZqo1YEREKnI9DnLhf6doM9oIQFSPaCaw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750949327;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0YvHDwNtH7JCA3yTrFzmAWls6d21ROaLNNWeeQE+7RU=;
	b=ywRcYRgi4BovomyW3re9LbWaX7/U7UaVTaE37xI22kuAvFl70TGmO4KI3Xcfns1A6RMaJX
	7yCNwbjRBJSEP+CQ==
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
Subject: [PATCH 10/16] PCI: xilinx-xdma: Switch to msi_create_parent_irq_domain()
Date: Thu, 26 Jun 2025 16:48:00 +0200
Message-Id: <b4620dc1808f217a69d0ae50700ffa12ffd657eb.1750858083.git.namcao@linutronix.de>
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
 drivers/pci/controller/Kconfig              |  1 +
 drivers/pci/controller/pcie-xilinx-dma-pl.c | 48 +++++++++------------
 2 files changed, 22 insertions(+), 27 deletions(-)

diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
index 8b9492e9ae693..c9b6180239732 100644
--- a/drivers/pci/controller/Kconfig
+++ b/drivers/pci/controller/Kconfig
@@ -331,6 +331,7 @@ config PCIE_XILINX_DMA_PL
 	depends on ARCH_ZYNQMP || COMPILE_TEST
 	depends on PCI_MSI
 	select PCI_HOST_COMMON
+	select IRQ_MSI_LIB
 	help
 	  Say 'Y' here if you want kernel support for the Xilinx PL DMA
 	  PCIe host bridge. The controller is a Soft IP which can act as
diff --git a/drivers/pci/controller/pcie-xilinx-dma-pl.c b/drivers/pci/cont=
roller/pcie-xilinx-dma-pl.c
index dc9690a535e16..fbc379fd118b4 100644
--- a/drivers/pci/controller/pcie-xilinx-dma-pl.c
+++ b/drivers/pci/controller/pcie-xilinx-dma-pl.c
@@ -7,6 +7,7 @@
 #include <linux/bitfield.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
+#include <linux/irqchip/irq-msi-lib.h>
 #include <linux/irqdomain.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
@@ -90,7 +91,6 @@ struct xilinx_pl_dma_variant {
 };
=20
 struct xilinx_msi {
-	struct irq_domain	*msi_domain;
 	unsigned long		*bitmap;
 	struct irq_domain	*dev_domain;
 	struct mutex		lock;		/* Protect bitmap variable */
@@ -373,20 +373,20 @@ static irqreturn_t xilinx_pl_dma_pcie_intr_handler(in=
t irq, void *dev_id)
 	return IRQ_HANDLED;
 }
=20
-static struct irq_chip xilinx_msi_irq_chip =3D {
-	.name =3D "pl_dma:PCIe MSI",
-	.irq_enable =3D pci_msi_unmask_irq,
-	.irq_disable =3D pci_msi_mask_irq,
-	.irq_mask =3D pci_msi_mask_irq,
-	.irq_unmask =3D pci_msi_unmask_irq,
-};
+#define XILINX_MSI_FLAGS_REQUIRED (MSI_FLAG_USE_DEF_DOM_OPS	| \
+				   MSI_FLAG_USE_DEF_CHIP_OPS	| \
+				   MSI_FLAG_NO_AFFINITY)
=20
-static struct msi_domain_info xilinx_msi_domain_info =3D {
-	.flags =3D MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
-		 MSI_FLAG_NO_AFFINITY | MSI_FLAG_MULTI_PCI_MSI,
-	.chip =3D &xilinx_msi_irq_chip,
-};
+#define XILINX_MSI_FLAGS_SUPPORTED (MSI_GENERIC_FLAGS_MASK	| \
+				    MSI_FLAG_MULTI_PCI_MSI)
=20
+static const struct msi_parent_ops xilinx_msi_parent_ops =3D {
+	.required_flags		=3D XILINX_MSI_FLAGS_REQUIRED,
+	.supported_flags	=3D XILINX_MSI_FLAGS_SUPPORTED,
+	.bus_select_token	=3D DOMAIN_BUS_PCI_MSI,
+	.prefix			=3D "pl_dma-",
+	.init_dev_msi_info	=3D msi_lib_init_dev_msi_info,
+};
 static void xilinx_compose_msi_msg(struct irq_data *data, struct msi_msg *=
msg)
 {
 	struct pl_dma_pcie *pcie =3D irq_data_get_irq_chip_data(data);
@@ -458,11 +458,6 @@ static void xilinx_pl_dma_pcie_free_irq_domains(struct=
 pl_dma_pcie *port)
 		irq_domain_remove(msi->dev_domain);
 		msi->dev_domain =3D NULL;
 	}
-
-	if (msi->msi_domain) {
-		irq_domain_remove(msi->msi_domain);
-		msi->msi_domain =3D NULL;
-	}
 }
=20
 static int xilinx_pl_dma_pcie_init_msi_irq_domain(struct pl_dma_pcie *port)
@@ -471,18 +466,17 @@ static int xilinx_pl_dma_pcie_init_msi_irq_domain(str=
uct pl_dma_pcie *port)
 	struct xilinx_msi *msi =3D &port->msi;
 	int size =3D BITS_TO_LONGS(XILINX_NUM_MSI_IRQS) * sizeof(long);
 	struct fwnode_handle *fwnode =3D of_fwnode_handle(port->dev->of_node);
-
-	msi->dev_domain =3D irq_domain_create_linear(NULL, XILINX_NUM_MSI_IRQS,
-						   &dev_msi_domain_ops, port);
+	struct irq_domain_info info =3D {
+		.fwnode		=3D fwnode,
+		.ops		=3D &dev_msi_domain_ops,
+		.host_data	=3D port,
+		.size		=3D XILINX_NUM_MSI_IRQS,
+	};
+
+	msi->dev_domain  =3D msi_create_parent_irq_domain(&info, &xilinx_msi_pare=
nt_ops);
 	if (!msi->dev_domain)
 		goto out;
=20
-	msi->msi_domain =3D pci_msi_create_irq_domain(fwnode,
-						    &xilinx_msi_domain_info,
-						    msi->dev_domain);
-	if (!msi->msi_domain)
-		goto out;
-
 	mutex_init(&msi->lock);
 	msi->bitmap =3D kzalloc(size, GFP_KERNEL);
 	if (!msi->bitmap)
--=20
2.39.5


