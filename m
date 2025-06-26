Return-Path: <linux-hyperv+bounces-6008-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40BFAAEA138
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Jun 2025 16:50:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D7D17AE129
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Jun 2025 14:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 546A52EBDED;
	Thu, 26 Jun 2025 14:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gnteCw5z";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="D0ZICz2j"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 701002EACE3;
	Thu, 26 Jun 2025 14:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750949321; cv=none; b=spKqk+q2nb9/3epqaTAYJZlHT02Wk5OD66OTB39F04ERfGbsRIyLUXvlk6QQKXn+s/FVtAjYB3HybpomNsGo9r4KkkSNmgyZeLEJ7ouCX/BtYDUZshmbOZrQ8g/pT6IoyBwdWRtT6hpmvvzrvrUfk3VOYgQDhkbpRUXf6Xn8phM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750949321; c=relaxed/simple;
	bh=wdxA05uMnJ5Nx9bpFKxpSs1sNQro9QbVkbkJcxFogLk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CXNDG/NQL9MbQVzI3Nk4Y6guychlWrYvffgbESIKP/1TN90zIq8OQvNHXO0F/zx5o4je6BzD/Tg2bsRzKpLF6chHbuM1S7OKaYqwb3j8yRE/+eMwYNE8rVClDgM260axCdKkmbsxcDZ6IHHd9H7XAXuUs3J0Pw2J2nX8PFDfH+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gnteCw5z; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=D0ZICz2j; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750949316;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TkdF6/WXSmyR6CP6BJIFb/N9JSNeGtF+c34gsRTZKi8=;
	b=gnteCw5zFdeHMYffbKs77Zh69GwMGsOSTdZ3KTKu9bnHHvg+UI8TTjsm1bM0viMJiDShza
	aHSj4YaO1m6v4p7i1grgwE7fBRLx4CCeQzmf6kbNyandbo4Zpgr9w3CjbswZG7THLUxxMU
	tHn47VGd8jdzENxHRsPOTUapQa1MzSs2OhJ/iX+WNW0T/hIzVFzypEYSMn3KyF4s4d2J2J
	9dzWuvnTDAxDp1AeJ0V8EdSG9guGrdSmpWYPNv+A7ZGvsMwlbntqFf4aYaYXiM1SpODFCB
	yTAYrXae2mcm/lgTtdI/H+hpVSPFsMfE8s8QwVjy+2Kc6uAwGToVodrJOPTXWQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750949316;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TkdF6/WXSmyR6CP6BJIFb/N9JSNeGtF+c34gsRTZKi8=;
	b=D0ZICz2jEObaXwCZyRm2f01Xzfxg6p3k/Gbe8jfG6SpDkTSuNsxPtcOUYG5dc4prMVSEf6
	Qh6SMuDMEIiXt6Dw==
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
	Jingoo Han <jingoohan1@gmail.com>
Subject: [PATCH 01/16] PCI: dwc: Switch to msi_create_parent_irq_domain()
Date: Thu, 26 Jun 2025 16:47:51 +0200
Message-Id: <04d4a96046490e50139826c16423954e033cdf89.1750858083.git.namcao@linutronix.de>
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
Cc: Jingoo Han <jingoohan1@gmail.com>
---
 drivers/pci/controller/dwc/Kconfig            |  1 +
 .../pci/controller/dwc/pcie-designware-host.c | 68 +++++++------------
 drivers/pci/controller/dwc/pcie-designware.h  |  1 -
 3 files changed, 25 insertions(+), 45 deletions(-)

diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dw=
c/Kconfig
index bb95877b2c6c4..8a63e9bc0c039 100644
--- a/drivers/pci/controller/dwc/Kconfig
+++ b/drivers/pci/controller/dwc/Kconfig
@@ -19,6 +19,7 @@ config PCIE_DW_DEBUGFS
 config PCIE_DW_HOST
 	bool
 	select PCIE_DW
+	select IRQ_MSI_LIB
=20
 config PCIE_DW_EP
 	bool
diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pc=
i/controller/dwc/pcie-designware-host.c
index 906277f9ffaf7..a953e07a68aff 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -10,6 +10,7 @@
=20
 #include <linux/iopoll.h>
 #include <linux/irqchip/chained_irq.h>
+#include <linux/irqchip/irq-msi-lib.h>
 #include <linux/irqdomain.h>
 #include <linux/msi.h>
 #include <linux/of_address.h>
@@ -23,35 +24,21 @@
 static struct pci_ops dw_pcie_ops;
 static struct pci_ops dw_child_pcie_ops;
=20
-static void dw_msi_ack_irq(struct irq_data *d)
-{
-	irq_chip_ack_parent(d);
-}
-
-static void dw_msi_mask_irq(struct irq_data *d)
-{
-	pci_msi_mask_irq(d);
-	irq_chip_mask_parent(d);
-}
-
-static void dw_msi_unmask_irq(struct irq_data *d)
-{
-	pci_msi_unmask_irq(d);
-	irq_chip_unmask_parent(d);
-}
-
-static struct irq_chip dw_pcie_msi_irq_chip =3D {
-	.name =3D "PCI-MSI",
-	.irq_ack =3D dw_msi_ack_irq,
-	.irq_mask =3D dw_msi_mask_irq,
-	.irq_unmask =3D dw_msi_unmask_irq,
-};
-
-static struct msi_domain_info dw_pcie_msi_domain_info =3D {
-	.flags	=3D MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
-		  MSI_FLAG_NO_AFFINITY | MSI_FLAG_PCI_MSIX |
-		  MSI_FLAG_MULTI_PCI_MSI,
-	.chip	=3D &dw_pcie_msi_irq_chip,
+#define DW_PCIE_MSI_FLAGS_REQUIRED (MSI_FLAG_USE_DEF_DOM_OPS		| \
+				    MSI_FLAG_USE_DEF_CHIP_OPS		| \
+				    MSI_FLAG_NO_AFFINITY		| \
+				    MSI_FLAG_PCI_MSI_MASK_PARENT)
+#define DW_PCIE_MSI_FLAGS_SUPPORTED (MSI_FLAG_MULTI_PCI_MSI		| \
+				     MSI_FLAG_PCI_MSIX			| \
+				     MSI_GENERIC_FLAGS_MASK)
+
+static const struct msi_parent_ops dw_pcie_msi_parent_ops =3D {
+	.required_flags		=3D DW_PCIE_MSI_FLAGS_REQUIRED,
+	.supported_flags	=3D DW_PCIE_MSI_FLAGS_SUPPORTED,
+	.bus_select_token	=3D DOMAIN_BUS_PCI_MSI,
+	.chip_flags		=3D MSI_CHIP_FLAG_SET_ACK,
+	.prefix			=3D "DW-",
+	.init_dev_msi_info	=3D msi_lib_init_dev_msi_info,
 };
=20
 /* MSI int handler */
@@ -228,25 +215,19 @@ int dw_pcie_allocate_domains(struct dw_pcie_rp *pp)
 {
 	struct dw_pcie *pci =3D to_dw_pcie_from_pp(pp);
 	struct fwnode_handle *fwnode =3D of_fwnode_handle(pci->dev->of_node);
-
-	pp->irq_domain =3D irq_domain_create_linear(fwnode, pp->num_vectors,
-					       &dw_pcie_msi_domain_ops, pp);
+	struct irq_domain_info info =3D {
+		.fwnode		=3D fwnode,
+		.ops		=3D &dw_pcie_msi_domain_ops,
+		.size		=3D pp->num_vectors,
+		.host_data	=3D pp,
+	};
+
+	pp->irq_domain =3D msi_create_parent_irq_domain(&info, &dw_pcie_msi_paren=
t_ops);
 	if (!pp->irq_domain) {
 		dev_err(pci->dev, "Failed to create IRQ domain\n");
 		return -ENOMEM;
 	}
=20
-	irq_domain_update_bus_token(pp->irq_domain, DOMAIN_BUS_NEXUS);
-
-	pp->msi_domain =3D pci_msi_create_irq_domain(fwnode,
-						   &dw_pcie_msi_domain_info,
-						   pp->irq_domain);
-	if (!pp->msi_domain) {
-		dev_err(pci->dev, "Failed to create MSI domain\n");
-		irq_domain_remove(pp->irq_domain);
-		return -ENOMEM;
-	}
-
 	return 0;
 }
=20
@@ -260,7 +241,6 @@ static void dw_pcie_free_msi(struct dw_pcie_rp *pp)
 							 NULL, NULL);
 	}
=20
-	irq_domain_remove(pp->msi_domain);
 	irq_domain_remove(pp->irq_domain);
 }
=20
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/con=
troller/dwc/pcie-designware.h
index ce9e18554e426..d9daee4ce220d 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -417,7 +417,6 @@ struct dw_pcie_rp {
 	const struct dw_pcie_host_ops *ops;
 	int			msi_irq[MAX_MSI_CTRLS];
 	struct irq_domain	*irq_domain;
-	struct irq_domain	*msi_domain;
 	dma_addr_t		msi_data;
 	struct irq_chip		*msi_irq_chip;
 	u32			num_vectors;
--=20
2.39.5


