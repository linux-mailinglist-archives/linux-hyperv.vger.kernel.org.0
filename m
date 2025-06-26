Return-Path: <linux-hyperv+bounces-6019-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C364AAEA18F
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Jun 2025 16:58:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C78103A3F97
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Jun 2025 14:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E7F02F0E30;
	Thu, 26 Jun 2025 14:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jS5Tbfif";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="J5+6Hx4D"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 172BE2F0C5A;
	Thu, 26 Jun 2025 14:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750949334; cv=none; b=dc3RzqIxN0l6yyvHMx87E/nXVghgumw1ThRjb+WCxN7hvMIurOBI8nIX4USsfaUDRgPBK9DT8HNPjq6CRdyG3eX/h9SqADL18XI4TfRuYtuPVw76v3WMHjOts55LEU8vyp+IE9rZ4W9/+6sX76tPBEFwZXIdlu65OdMuer9mtHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750949334; c=relaxed/simple;
	bh=NYHRB/RoJ7oHAMmRL0JxEnMjemauG55ZaCTPCEc9f00=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kvfwhYRVUXvLXReR39FOuKTu/h+8LNwZlk++MT53hkbXSfQMwm7TP9S8pIRH+d7OTf2EXFeWk17sAiy5gKeBFmyfFvuuS26Pefy8Ua20ixVtCyfAtX1SH39s6ujaM0s7p5N+EgaQATITsOj83BeydwDeIpaDu8ROW9/xV+249mQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jS5Tbfif; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=J5+6Hx4D; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750949331;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HuMVdg23Oax31eHAYNJWO0f1sJw7nfFbv3FXtJpw6XA=;
	b=jS5Tbfifv93Qru5YKGT/U+gezPnJHb1x+nNDHqcQfHTx3E/Xs61fNnDux7/ZZvlY7RMI0w
	uSo5MV5Kk0A3HCyKQYX1WCTKHGXa0h7wHSPkD3gTavvst3umEuyw1ni092MhQv+kgEC2jL
	fJzng7LspGRbHG0/1suxZndjLQeQT+rqEnz3YDXjwfDoL9L1uauLkeobqTRmo8qUV7SJV+
	K5TlYR111v8aRuzsyBUUUgmp0qXQaE6IEbdRgwRc4tRR8PQ+pqrfYDt9AwXMEZMxCeEktA
	W5OmIJC31+aMKNDFXn56e10TjCREXKxQYgylCo7spE9BSemzEw22Nw/Hyv4ylg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750949331;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HuMVdg23Oax31eHAYNJWO0f1sJw7nfFbv3FXtJpw6XA=;
	b=J5+6Hx4DqMJtrLH7epLeuB/YrIrxmarnZbHXYwq68x+t+NWfBllEiTdEWkArCOxQZpkf2B
	ft3Uj6iPbReoL6CA==
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
Subject: [PATCH 13/16] PCI: plda: Switch to msi_create_parent_irq_domain()
Date: Thu, 26 Jun 2025 16:48:03 +0200
Message-Id: <1279fe6500a1d8135d8f5feb2f055df008746c88.1750858083.git.namcao@linutronix.de>
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
Cc: Daire McNamara <daire.mcnamara@microchip.com>
---
 drivers/pci/controller/plda/Kconfig          |  1 +
 drivers/pci/controller/plda/pcie-plda-host.c | 44 ++++++++++----------
 drivers/pci/controller/plda/pcie-plda.h      |  1 -
 3 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/drivers/pci/controller/plda/Kconfig b/drivers/pci/controller/p=
lda/Kconfig
index c0e14146d7e45..62120101139cb 100644
--- a/drivers/pci/controller/plda/Kconfig
+++ b/drivers/pci/controller/plda/Kconfig
@@ -5,6 +5,7 @@ menu "PLDA-based PCIe controllers"
=20
 config PCIE_PLDA_HOST
 	bool
+	select IRQ_MSI_LIB
=20
 config PCIE_MICROCHIP_HOST
 	tristate "Microchip AXI PCIe controller"
diff --git a/drivers/pci/controller/plda/pcie-plda-host.c b/drivers/pci/con=
troller/plda/pcie-plda-host.c
index 3abedf723215c..92866840875e3 100644
--- a/drivers/pci/controller/plda/pcie-plda-host.c
+++ b/drivers/pci/controller/plda/pcie-plda-host.c
@@ -11,6 +11,7 @@
 #include <linux/align.h>
 #include <linux/bitfield.h>
 #include <linux/irqchip/chained_irq.h>
+#include <linux/irqchip/irq-msi-lib.h>
 #include <linux/irqdomain.h>
 #include <linux/msi.h>
 #include <linux/pci_regs.h>
@@ -134,17 +135,19 @@ static const struct irq_domain_ops msi_domain_ops =3D=
 {
 	.free	=3D plda_irq_msi_domain_free,
 };
=20
-static struct irq_chip plda_msi_irq_chip =3D {
-	.name =3D "PLDA PCIe MSI",
-	.irq_ack =3D irq_chip_ack_parent,
-	.irq_mask =3D pci_msi_mask_irq,
-	.irq_unmask =3D pci_msi_unmask_irq,
-};
-
-static struct msi_domain_info plda_msi_domain_info =3D {
-	.flags =3D MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
-		 MSI_FLAG_NO_AFFINITY | MSI_FLAG_PCI_MSIX,
-	.chip =3D &plda_msi_irq_chip,
+#define PLDA_MSI_FLAGS_REQUIRED (MSI_FLAG_USE_DEF_DOM_OPS	| \
+				 MSI_FLAG_USE_DEF_CHIP_OPS	| \
+				 MSI_FLAG_NO_AFFINITY)
+#define PLDA_MSI_FLAGS_SUPPORTED (MSI_GENERIC_FLAGS_MASK	| \
+				  MSI_FLAG_PCI_MSIX)
+
+static const struct msi_parent_ops plda_msi_parent_ops =3D {
+	.required_flags		=3D PLDA_MSI_FLAGS_REQUIRED,
+	.supported_flags	=3D PLDA_MSI_FLAGS_SUPPORTED,
+	.chip_flags		=3D MSI_CHIP_FLAG_SET_ACK,
+	.bus_select_token	=3D DOMAIN_BUS_PCI_MSI,
+	.prefix			=3D "PLDA-",
+	.init_dev_msi_info	=3D msi_lib_init_dev_msi_info,
 };
=20
 static int plda_allocate_msi_domains(struct plda_pcie_rp *port)
@@ -155,21 +158,19 @@ static int plda_allocate_msi_domains(struct plda_pcie=
_rp *port)
=20
 	mutex_init(&port->msi.lock);
=20
-	msi->dev_domain =3D irq_domain_create_linear(NULL, msi->num_vectors, &msi=
_domain_ops, port);
+	struct irq_domain_info info =3D {
+		.fwnode		=3D fwnode,
+		.ops		=3D &msi_domain_ops,
+		.host_data	=3D port,
+		.size		=3D msi->num_vectors,
+	};
+
+	msi->dev_domain =3D msi_create_parent_irq_domain(&info, &plda_msi_parent_=
ops);
 	if (!msi->dev_domain) {
 		dev_err(dev, "failed to create IRQ domain\n");
 		return -ENOMEM;
 	}
=20
-	msi->msi_domain =3D pci_msi_create_irq_domain(fwnode,
-						    &plda_msi_domain_info,
-						    msi->dev_domain);
-	if (!msi->msi_domain) {
-		dev_err(dev, "failed to create MSI domain\n");
-		irq_domain_remove(msi->dev_domain);
-		return -ENOMEM;
-	}
-
 	return 0;
 }
=20
@@ -563,7 +564,6 @@ static void plda_pcie_irq_domain_deinit(struct plda_pci=
e_rp *pcie)
 	irq_set_chained_handler_and_data(pcie->msi_irq, NULL, NULL);
 	irq_set_chained_handler_and_data(pcie->intx_irq, NULL, NULL);
=20
-	irq_domain_remove(pcie->msi.msi_domain);
 	irq_domain_remove(pcie->msi.dev_domain);
=20
 	irq_domain_remove(pcie->intx_domain);
diff --git a/drivers/pci/controller/plda/pcie-plda.h b/drivers/pci/controll=
er/plda/pcie-plda.h
index 61ece26065ea0..6b8665df7bf0f 100644
--- a/drivers/pci/controller/plda/pcie-plda.h
+++ b/drivers/pci/controller/plda/pcie-plda.h
@@ -164,7 +164,6 @@ struct plda_pcie_host_ops {
=20
 struct plda_msi {
 	struct mutex lock;		/* Protect used bitmap */
-	struct irq_domain *msi_domain;
 	struct irq_domain *dev_domain;
 	u32 num_vectors;
 	u64 vector_phy;
--=20
2.39.5


