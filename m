Return-Path: <linux-hyperv+bounces-6010-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 044FCAEA15D
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Jun 2025 16:54:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68D1A175178
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Jun 2025 14:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5927D2ED878;
	Thu, 26 Jun 2025 14:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="m9B/zQqo";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hAk5Bat7"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F5B92ECD26;
	Thu, 26 Jun 2025 14:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750949323; cv=none; b=oS7RX9BTob3Rvb6LfFutX9+9wkTFtW+L5RDvFJkU4HQXnYmJfRGDNamjUi3ekd0oZVv7p9XGCeFpsJK4zMvUoc72aXWFKHfsPgefFxjCsv09oCn2QRsUMdwAWzJiP9ewIVH3iMZ9WfwOFyFdVL+AcnU9moJxUAhgi57HNxLgIuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750949323; c=relaxed/simple;
	bh=j133otE5nDwrUk3UVML2kCpXp+mWB9vLicwv9u3zqHU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=R7tEjEz3TfEp7QS5KPlfb6nvBQ23+9gJtm2ykol21vHZCNaVA3FfssMDJNBN31RjGXurINSGsXQyWf1qSaWMK9Bwb1+iHV2yumN02eZyJdZmjnNQlHH5MS0eWyLsfqJHVjsH3y7UnOfuRK6fCAUFIHgU7puudf5mkEBT5D36TPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=m9B/zQqo; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hAk5Bat7; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750949320;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gjHYyX3StyvYFxHeeqv/LYhiKdcq0Fz4Fnl5MOMRvT4=;
	b=m9B/zQqoyh5OBIBfLP767Uycgc3B4wnxtGmVa6xloyiaZ+mfrE6gby4HFL52ljwLh4tDWm
	DuLAA2eczy5Far/kIBkR5EHqzsu8lj0MS76mWPOzmYu7rTfL3yunnYV2mckuK/3+luKPZt
	F6eTk+CEdC9fIF0MU/Os7QyArf7sWT5O6V3EZcPQeD8KtQD4W4urK/+ID3i93Gs+G0zKeg
	syVY60Q3PIK/N9DmWuvWiRtsoOlbEC0VELDvPmA7zWrIVfoQNJHjHP123T5K/SI0ILGT/f
	3J8cYj3Ph4CEmR7FQFaY4cV5CDlgjtj651hqzYpGRAAXylALFbcVPoWRcK7UHg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750949320;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gjHYyX3StyvYFxHeeqv/LYhiKdcq0Fz4Fnl5MOMRvT4=;
	b=hAk5Bat7znOJgAYspbl3b19fM6NZsoIgSKXAdTlOLzvTuSu67AxxQv37acwFp+sYwpfb2W
	IfKyFmv+H5BVmLDw==
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
Subject: [PATCH 04/16] PCI: altera-msi: Switch to msi_create_parent_irq_domain()
Date: Thu, 26 Jun 2025 16:47:54 +0200
Message-Id: <0a88da04bb82bd588828a7889e9d58c515ea5dbb.1750858083.git.namcao@linutronix.de>
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
Cc: Joyce Ooi <joyce.ooi@intel.com>
---
 drivers/pci/controller/Kconfig           |  1 +
 drivers/pci/controller/pcie-altera-msi.c | 44 +++++++++++-------------
 2 files changed, 22 insertions(+), 23 deletions(-)

diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
index 91a2d4ffc3ac4..012c18c67d9c6 100644
--- a/drivers/pci/controller/Kconfig
+++ b/drivers/pci/controller/Kconfig
@@ -30,6 +30,7 @@ config PCIE_ALTERA_MSI
 	tristate "Altera PCIe MSI feature"
 	depends on PCIE_ALTERA
 	depends on PCI_MSI
+	select IRQ_MSI_LIB
 	help
 	  Say Y here if you want PCIe MSI support for the Altera FPGA.
 	  This MSI driver supports Altera MSI to GIC controller IP.
diff --git a/drivers/pci/controller/pcie-altera-msi.c b/drivers/pci/control=
ler/pcie-altera-msi.c
index a43f21eb8fbb9..2e48acd632c57 100644
--- a/drivers/pci/controller/pcie-altera-msi.c
+++ b/drivers/pci/controller/pcie-altera-msi.c
@@ -9,6 +9,7 @@
=20
 #include <linux/interrupt.h>
 #include <linux/irqchip/chained_irq.h>
+#include <linux/irqchip/irq-msi-lib.h>
 #include <linux/irqdomain.h>
 #include <linux/init.h>
 #include <linux/module.h>
@@ -29,7 +30,6 @@ struct altera_msi {
 	DECLARE_BITMAP(used, MAX_MSI_VECTORS);
 	struct mutex		lock;	/* protect "used" bitmap */
 	struct platform_device	*pdev;
-	struct irq_domain	*msi_domain;
 	struct irq_domain	*inner_domain;
 	void __iomem		*csr_base;
 	void __iomem		*vector_base;
@@ -74,18 +74,20 @@ static void altera_msi_isr(struct irq_desc *desc)
 	chained_irq_exit(chip, desc);
 }
=20
-static struct irq_chip altera_msi_irq_chip =3D {
-	.name =3D "Altera PCIe MSI",
-	.irq_mask =3D pci_msi_mask_irq,
-	.irq_unmask =3D pci_msi_unmask_irq,
-};
+#define ALTERA_MSI_FLAGS_REQUIRED (MSI_FLAG_USE_DEF_DOM_OPS		| \
+				   MSI_FLAG_USE_DEF_CHIP_OPS		| \
+				   MSI_FLAG_NO_AFFINITY)
=20
-static struct msi_domain_info altera_msi_domain_info =3D {
-	.flags	=3D MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
-		  MSI_FLAG_NO_AFFINITY | MSI_FLAG_PCI_MSIX,
-	.chip	=3D &altera_msi_irq_chip,
-};
+#define ALTERA_MSI_FLAGS_SUPPORTED (MSI_GENERIC_FLAGS_MASK		| \
+				    MSI_FLAG_PCI_MSIX)
=20
+static const struct msi_parent_ops altera_msi_parent_ops =3D {
+	.required_flags		=3D ALTERA_MSI_FLAGS_REQUIRED,
+	.supported_flags	=3D ALTERA_MSI_FLAGS_SUPPORTED,
+	.bus_select_token	=3D DOMAIN_BUS_PCI_MSI,
+	.prefix			=3D "Altera-",
+	.init_dev_msi_info	=3D msi_lib_init_dev_msi_info,
+};
 static void altera_compose_msi_msg(struct irq_data *data, struct msi_msg *=
msg)
 {
 	struct altera_msi *msi =3D irq_data_get_irq_chip_data(data);
@@ -165,19 +167,16 @@ static const struct irq_domain_ops msi_domain_ops =3D=
 {
 static int altera_allocate_domains(struct altera_msi *msi)
 {
 	struct fwnode_handle *fwnode =3D of_fwnode_handle(msi->pdev->dev.of_node);
-
-	msi->inner_domain =3D irq_domain_create_linear(NULL, msi->num_of_vectors,
-					     &msi_domain_ops, msi);
+	struct irq_domain_info info =3D {
+		.fwnode		=3D fwnode,
+		.ops		=3D &msi_domain_ops,
+		.host_data	=3D msi,
+		.size		=3D msi->num_of_vectors,
+	};
+
+	msi->inner_domain =3D msi_create_parent_irq_domain(&info, &altera_msi_par=
ent_ops);
 	if (!msi->inner_domain) {
-		dev_err(&msi->pdev->dev, "failed to create IRQ domain\n");
-		return -ENOMEM;
-	}
-
-	msi->msi_domain =3D pci_msi_create_irq_domain(fwnode,
-				&altera_msi_domain_info, msi->inner_domain);
-	if (!msi->msi_domain) {
 		dev_err(&msi->pdev->dev, "failed to create MSI domain\n");
-		irq_domain_remove(msi->inner_domain);
 		return -ENOMEM;
 	}
=20
@@ -186,7 +185,6 @@ static int altera_allocate_domains(struct altera_msi *m=
si)
=20
 static void altera_free_domains(struct altera_msi *msi)
 {
-	irq_domain_remove(msi->msi_domain);
 	irq_domain_remove(msi->inner_domain);
 }
=20
--=20
2.39.5


