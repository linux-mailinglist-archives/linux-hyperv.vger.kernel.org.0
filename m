Return-Path: <linux-hyperv+bounces-6007-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 365F1AEA166
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Jun 2025 16:54:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1DF83A5DE5
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Jun 2025 14:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 401C52EB5C0;
	Thu, 26 Jun 2025 14:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ohoigcr0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nkf0SgAB"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 700882E975D;
	Thu, 26 Jun 2025 14:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750949321; cv=none; b=qiqVDSy1jEYHx83WMBDibUCgsTxcjPByj5Fn6DFh5jwmtLNirJGeWAysbKMQ/l+MPBpffyBXF2UQ12k+kdm2cCcQm6CiRFyOZSFPHva00oREKh+zy3JHginFpbBMqqUWz0ZYaC7gjcspuDTspGTuURDoCYnzr8G05mS0bSUtBiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750949321; c=relaxed/simple;
	bh=FbcDaMkikWnEBmRtCQsmflmkQmw0WVr+FimUSTUWA4U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SGbwd6Ugrtw68lwitsaSnX/q5PV3qJ0sufWcfJLIXqfbkM6x83JTmSXcqzPQtLKXnyYQwsAVBs6YJkD7lk9oaY3h3Q2P9Cd9vUYekpwwyXc4lbB9huKw8B7NaxPb1g0l84K7XYEd5Oq7SBMBjO31JnDfudbWowtAc90OePZmrS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ohoigcr0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nkf0SgAB; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750949317;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ditblTcZWn/hLq3noPG8h3VqVahq3cequ10qfherkGM=;
	b=Ohoigcr0rb5pIx6qw0y2lxsaVeMYasJkG7wk+QvCsLxMRJfBAaWb3cAZ/7c8tDoK4SDkDS
	8Je0WQcU77U+hwqrifMlEDpY9a2GOk/k9tlq8SImqU0h7Ml3Q3NKmW8M43v+X2X9NT1TL8
	d9EyC+Knu01unLHE0weQED2TeRC/ayeUHFVbq3z4EcjwmRcfKzcVT4RpsjoYOtf/R0VKmC
	Z2J2gwNf8f+nQpJkB1Zuj3kD6lasz12E7h+krIiHy9+ixJPWuJZwZywEteMCfkXBuWaMxR
	iYTmiGtGDAVHiflhzfyD4/olxsD9Qw6OhfCgtZjagG570GLFnicUpokwd8+LSA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750949317;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ditblTcZWn/hLq3noPG8h3VqVahq3cequ10qfherkGM=;
	b=nkf0SgABGViiBC0OgUJ6GiesPE6qRlOssUq/2xMsJRb5rWHbuFX2bGmaEXOFg0zU4ifu1j
	tvPVEy1w3HxMyeBA==
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
Subject: [PATCH 02/16] PCI: mobiveil: Switch to msi_create_parent_irq_domain()
Date: Thu, 26 Jun 2025 16:47:52 +0200
Message-Id: <af46c15c47a7716f7e0c50d0f7391509c95b49c2.1750858083.git.namcao@linutronix.de>
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
Cc: Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>
Cc: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
---
 drivers/pci/controller/mobiveil/Kconfig       |  1 +
 .../controller/mobiveil/pcie-mobiveil-host.c  | 42 ++++++++++---------
 .../pci/controller/mobiveil/pcie-mobiveil.h   |  1 -
 3 files changed, 23 insertions(+), 21 deletions(-)

diff --git a/drivers/pci/controller/mobiveil/Kconfig b/drivers/pci/controll=
er/mobiveil/Kconfig
index 58ce034f701ab..c50c4625937f8 100644
--- a/drivers/pci/controller/mobiveil/Kconfig
+++ b/drivers/pci/controller/mobiveil/Kconfig
@@ -9,6 +9,7 @@ config PCIE_MOBIVEIL
 config PCIE_MOBIVEIL_HOST
 	bool
 	depends on PCI_MSI
+	select IRQ_MSI_LIB
 	select PCIE_MOBIVEIL
=20
 config PCIE_LAYERSCAPE_GEN4
diff --git a/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c b/drivers=
/pci/controller/mobiveil/pcie-mobiveil-host.c
index cd44ddb698ea2..d17e887b6b61d 100644
--- a/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
+++ b/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
@@ -12,6 +12,7 @@
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
+#include <linux/irqchip/irq-msi-lib.h>
 #include <linux/irqchip/chained_irq.h>
 #include <linux/irqdomain.h>
 #include <linux/kernel.h>
@@ -353,16 +354,19 @@ static const struct irq_domain_ops intx_domain_ops =
=3D {
 	.map =3D mobiveil_pcie_intx_map,
 };
=20
-static struct irq_chip mobiveil_msi_irq_chip =3D {
-	.name =3D "Mobiveil PCIe MSI",
-	.irq_mask =3D pci_msi_mask_irq,
-	.irq_unmask =3D pci_msi_unmask_irq,
-};
+#define MOBIVEIL_MSI_FLAGS_REQUIRED (MSI_FLAG_USE_DEF_DOM_OPS		| \
+				     MSI_FLAG_USE_DEF_CHIP_OPS		| \
+				     MSI_FLAG_NO_AFFINITY)
+
+#define MOBIVEIL_MSI_FLAGS_SUPPORTED (MSI_GENERIC_FLAGS_MASK		| \
+				      MSI_FLAG_PCI_MSIX)
=20
-static struct msi_domain_info mobiveil_msi_domain_info =3D {
-	.flags	=3D MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
-		  MSI_FLAG_NO_AFFINITY | MSI_FLAG_PCI_MSIX,
-	.chip	=3D &mobiveil_msi_irq_chip,
+static const struct msi_parent_ops mobiveil_msi_parent_ops =3D {
+	.required_flags		=3D MOBIVEIL_MSI_FLAGS_REQUIRED,
+	.supported_flags	=3D MOBIVEIL_MSI_FLAGS_SUPPORTED,
+	.bus_select_token	=3D DOMAIN_BUS_PCI_MSI,
+	.prefix			=3D "Mobiveil-",
+	.init_dev_msi_info	=3D msi_lib_init_dev_msi_info,
 };
=20
 static void mobiveil_compose_msi_msg(struct irq_data *data, struct msi_msg=
 *msg)
@@ -439,19 +443,17 @@ static int mobiveil_allocate_msi_domains(struct mobiv=
eil_pcie *pcie)
 	struct mobiveil_msi *msi =3D &pcie->rp.msi;
=20
 	mutex_init(&msi->lock);
-	msi->dev_domain =3D irq_domain_create_linear(NULL, msi->num_of_vectors,
-						   &msi_domain_ops, pcie);
-	if (!msi->dev_domain) {
-		dev_err(dev, "failed to create IRQ domain\n");
-		return -ENOMEM;
-	}
=20
-	msi->msi_domain =3D pci_msi_create_irq_domain(fwnode,
-						    &mobiveil_msi_domain_info,
-						    msi->dev_domain);
-	if (!msi->msi_domain) {
+	struct irq_domain_info info =3D {
+		.fwnode		=3D fwnode,
+		.ops		=3D &msi_domain_ops,
+		.host_data	=3D pcie,
+		.size		=3D msi->num_of_vectors,
+	};
+
+	msi->dev_domain =3D msi_create_parent_irq_domain(&info, &mobiveil_msi_par=
ent_ops);
+	if (!msi->dev_domain) {
 		dev_err(dev, "failed to create MSI domain\n");
-		irq_domain_remove(msi->dev_domain);
 		return -ENOMEM;
 	}
=20
diff --git a/drivers/pci/controller/mobiveil/pcie-mobiveil.h b/drivers/pci/=
controller/mobiveil/pcie-mobiveil.h
index 662f17f9bf65c..7246de6a71768 100644
--- a/drivers/pci/controller/mobiveil/pcie-mobiveil.h
+++ b/drivers/pci/controller/mobiveil/pcie-mobiveil.h
@@ -135,7 +135,6 @@
=20
 struct mobiveil_msi {			/* MSI information */
 	struct mutex lock;		/* protect bitmap variable */
-	struct irq_domain *msi_domain;
 	struct irq_domain *dev_domain;
 	phys_addr_t msi_pages_phys;
 	int num_of_vectors;
--=20
2.39.5


