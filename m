Return-Path: <linux-hyperv+bounces-6012-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E15EEAEA177
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Jun 2025 16:55:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 817685A6EF5
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Jun 2025 14:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F41EF2EE965;
	Thu, 26 Jun 2025 14:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nAcwHyaS";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jTJGcSNK"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F1B2EE280;
	Thu, 26 Jun 2025 14:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750949325; cv=none; b=SBki/5HfoRM7me9G1lrJr0612h3Mj244/MFXSxhBYGKHNcVSlYvb6fGTEsotNXYs9F9sjcfS/y8dvE4P2deM0bRnkEUMTs6lPDunWy2GJ2A9hcKpaMUSybZTrhGwUmPWz7uy5Dtc3snxwwHJro9yQFnb6qviiaTcY+CR/w1CGn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750949325; c=relaxed/simple;
	bh=S6GLCN/3IjZwj/UzWJRZug0f+xbVl11IJhy15Cnm8Sg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QEoeLXDrVTBwcw9XUwfBJRe+t9AVkdnSFPFhDv3abog2j3ZdTQBc70z5GKmjD3D00bsR6lq13D/NJO6Tr6C+c3ylGX3CcAdQG6qvMSVZ7HpGffZsJrjOephJlwyzxqEi7YQAZ3HhA3RgnoTzkm3+1WKYo8zFfzVSxaCTB8lZL0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nAcwHyaS; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jTJGcSNK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750949322;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C1HFdhwqd5DC6x8p3yCFzDP+yibNrfGuiCrnn0yz6t0=;
	b=nAcwHyaSN7nhBtD3lVXi6SlAK9Z0rKWn5zhGfVT6S7Fh3m9j14eeUWihriCspaY4jFk61c
	kn2ZAhYqva6qMParMQynIJrLB2fkyzHpeXgrxriK8hgkbK85MyZluRYhI35cnh8jrdwKVc
	qKBzPkZTPzC+/hylZc6YzsCqO/3QzRfrotYTHjFvN/wkt0LyLIlwu9fBn+kkk/M670es88
	z/ioGfJnxur6VKZie0ILYugjqvJwWjho3FvrVQl7eIR7m72HpnC8L7mjToCscML0VrfezZ
	7EnDbFFvMCw44S649jKQzgxjvpQ0j0dJ934nzEUrCeA0BH41DCPMl859e+wwaw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750949322;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C1HFdhwqd5DC6x8p3yCFzDP+yibNrfGuiCrnn0yz6t0=;
	b=jTJGcSNKw/2f2IkZrgSgkpUrKrbs8MVtkmvUc2qvgUskXQRgX2dhgD0FYSNtv0hr+TOjO+
	PkkQUPYCny+aD2Ag==
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
Subject: [PATCH 06/16] PCI: iproc: Switch to msi_create_parent_irq_domain()
Date: Thu, 26 Jun 2025 16:47:56 +0200
Message-Id: <53946d74caf1fd134a1820eac82c3cf64d48779f.1750858083.git.namcao@linutronix.de>
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
Cc: Ray Jui <rjui@broadcom.com>
Cc: Scott Branden <sbranden@broadcom.com>
Cc: Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom=
.com>
Cc: linux-arm-kernel@lists.infradead.org
---
 drivers/pci/controller/Kconfig          |  1 +
 drivers/pci/controller/pcie-iproc-msi.c | 45 ++++++++++++-------------
 2 files changed, 22 insertions(+), 24 deletions(-)

diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
index 0f6cec244d4fa..375a019f35bd9 100644
--- a/drivers/pci/controller/Kconfig
+++ b/drivers/pci/controller/Kconfig
@@ -101,6 +101,7 @@ config PCIE_IPROC_MSI
 	bool "Broadcom iProc PCIe MSI support"
 	depends on PCIE_IPROC_PLATFORM || PCIE_IPROC_BCMA
 	depends on PCI_MSI
+	select IRQ_MSI_LIB
 	default ARCH_BCM_IPROC
 	help
 	  Say Y here if you want to enable MSI support for Broadcom's iProc
diff --git a/drivers/pci/controller/pcie-iproc-msi.c b/drivers/pci/controll=
er/pcie-iproc-msi.c
index d2cb4c4f821af..d0c7f004217fb 100644
--- a/drivers/pci/controller/pcie-iproc-msi.c
+++ b/drivers/pci/controller/pcie-iproc-msi.c
@@ -5,6 +5,7 @@
=20
 #include <linux/interrupt.h>
 #include <linux/irqchip/chained_irq.h>
+#include <linux/irqchip/irq-msi-lib.h>
 #include <linux/irqdomain.h>
 #include <linux/msi.h>
 #include <linux/of_irq.h>
@@ -101,7 +102,6 @@ struct iproc_msi {
 	struct mutex bitmap_lock;
 	unsigned int nr_msi_vecs;
 	struct irq_domain *inner_domain;
-	struct irq_domain *msi_domain;
 	unsigned int nr_eq_region;
 	unsigned int nr_msi_region;
 	void *eq_cpu;
@@ -165,16 +165,18 @@ static inline unsigned int iproc_msi_eq_offset(struct=
 iproc_msi *msi, u32 eq)
 		return eq * EQ_LEN * sizeof(u32);
 }
=20
-static struct irq_chip iproc_msi_irq_chip =3D {
-	.name =3D "iProc-MSI",
+#define IPROC_MSI_FLAGS_REQUIRED (MSI_FLAG_USE_DEF_DOM_OPS	| \
+				  MSI_FLAG_USE_DEF_CHIP_OPS)
+#define IPROC_MSI_FLAGS_SUPPORTED (MSI_GENERIC_FLAGS_MASK	| \
+				   MSI_FLAG_PCI_MSIX)
+
+static struct msi_parent_ops iproc_msi_parent_ops =3D {
+	.required_flags		=3D IPROC_MSI_FLAGS_REQUIRED,
+	.supported_flags	=3D IPROC_MSI_FLAGS_SUPPORTED,
+	.bus_select_token	=3D DOMAIN_BUS_PCI_MSI,
+	.prefix			=3D "iProc-",
+	.init_dev_msi_info	=3D msi_lib_init_dev_msi_info,
 };
-
-static struct msi_domain_info iproc_msi_domain_info =3D {
-	.flags =3D MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
-		MSI_FLAG_PCI_MSIX,
-	.chip =3D &iproc_msi_irq_chip,
-};
-
 /*
  * In iProc PCIe core, each MSI group is serviced by a GIC interrupt and a
  * dedicated event queue.  Each MSI group can support up to 64 MSI vectors.
@@ -446,27 +448,22 @@ static void iproc_msi_disable(struct iproc_msi *msi)
 static int iproc_msi_alloc_domains(struct device_node *node,
 				   struct iproc_msi *msi)
 {
-	msi->inner_domain =3D irq_domain_create_linear(NULL, msi->nr_msi_vecs,
-						     &msi_domain_ops, msi);
+	struct irq_domain_info info =3D {
+		.fwnode		=3D of_fwnode_handle(node),
+		.ops		=3D &msi_domain_ops,
+		.host_data	=3D msi,
+		.size		=3D msi->nr_msi_vecs,
+	};
+
+	msi->inner_domain =3D msi_create_parent_irq_domain(&info, &iproc_msi_pare=
nt_ops);
 	if (!msi->inner_domain)
 		return -ENOMEM;
=20
-	msi->msi_domain =3D pci_msi_create_irq_domain(of_fwnode_handle(node),
-						    &iproc_msi_domain_info,
-						    msi->inner_domain);
-	if (!msi->msi_domain) {
-		irq_domain_remove(msi->inner_domain);
-		return -ENOMEM;
-	}
-
 	return 0;
 }
=20
 static void iproc_msi_free_domains(struct iproc_msi *msi)
 {
-	if (msi->msi_domain)
-		irq_domain_remove(msi->msi_domain);
-
 	if (msi->inner_domain)
 		irq_domain_remove(msi->inner_domain);
 }
@@ -542,7 +539,7 @@ int iproc_msi_init(struct iproc_pcie *pcie, struct devi=
ce_node *node)
 	msi->nr_cpus =3D num_possible_cpus();
=20
 	if (msi->nr_cpus =3D=3D 1)
-		iproc_msi_domain_info.flags |=3D  MSI_FLAG_MULTI_PCI_MSI;
+		iproc_msi_parent_ops.supported_flags |=3D MSI_FLAG_MULTI_PCI_MSI;
=20
 	msi->nr_irqs =3D of_irq_count(node);
 	if (!msi->nr_irqs) {
--=20
2.39.5


