Return-Path: <linux-hyperv+bounces-6011-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EB4EAEA17C
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Jun 2025 16:56:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B58211C471D2
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Jun 2025 14:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB88E2EE5F4;
	Thu, 26 Jun 2025 14:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zluBDTwt";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="L3ryjEzH"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1290F2ED86E;
	Thu, 26 Jun 2025 14:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750949324; cv=none; b=b+bg7hlbv0TXDJQEEeCS5DREWFmVlf7H2Tnte+hZXGnX1adNGxScDeaAUF9STitezpd3/sa4uvP6IjJMW7DTfmj76moP0Y3AfmQTW63zjW8VZC7wV47L9U09fiVJPJqOf+1Al9dd9vxWd/AlJ39f4w9ZTBmzre4oCVZdrz/mx3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750949324; c=relaxed/simple;
	bh=RWUyPX3F3ajc1vsMHL7zg/KVMPz+KqvzvnXFly3v7LQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=R967ynafKBJD9Bp6sXlypL3ohFzIzb9mRp/fOkuG5yDWxU10Gi9wn27jtRdFCJ9ouI+PSwsoKF78hku07GbzDlQaLB8lB9VQlfsqWAaYuoA0XRvncWXY+iviNqKvxMhRY6moHpgmj6omFu6pl/fNaSMSSON+VvVq3eOc/sfoiKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zluBDTwt; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=L3ryjEzH; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750949321;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1q3Tm321i/YiQ6se2Mpi9k0xPo754ttwZNnI+BcgDcU=;
	b=zluBDTwt6+ishYDs9SSlZmcV9dCi6hA+fJ6WbNYmZiyxKbwjSaC9FqfUZ/NRDAq1qDUkLn
	UFKANEGPSr9E1lmOw70PXwdygjH4HnUBedZvByy25wneU2EJ7lU4samk0+M6aEADJ4mgCp
	0N0n2FF+ChUmszWYne6X9Ipp3eoAqOWOc0vO9sQjSiRMgVXgNc3RIAZpKnsGUeKQ/gPQ8j
	t5KxBjz1+n5AfPFJW4i6/88giRqx6l5+15ivX9cNcC2aozvdJA62zB3B/ujo90qoD0vr3U
	HtznROdQqzIGUSwJbdihXm1KcF+FvJVGh0Q7OMseF4tMg6cTi4NoQhgAi7XNfA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750949321;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1q3Tm321i/YiQ6se2Mpi9k0xPo754ttwZNnI+BcgDcU=;
	b=L3ryjEzHx3mCEBxmCpqToPKKpKrsbQ/NsR3iVqmuT/tsDIbKaDlWvRfjmaMLKpMKBv8sLt
	014YiGk1eHrZSHDg==
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
Subject: [PATCH 05/16] PCI: brcmstb: Switch to msi_create_parent_irq_domain()
Date: Thu, 26 Jun 2025 16:47:55 +0200
Message-Id: <fa72703e06c2ee2c7554082c7152913eb0dd294f.1750858083.git.namcao@linutronix.de>
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
Cc: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom=
.com>
Cc: Jim Quinlan <jim2101024@gmail.com>
Cc: Nicolas Saenz Julienne <nsaenz@kernel.org>
Cc: linux-rpi-kernel@lists.infradead.org
Cc: linux-arm-kernel@lists.infradead.org
---
 drivers/pci/controller/Kconfig        |  1 +
 drivers/pci/controller/pcie-brcmstb.c | 44 +++++++++++++--------------
 2 files changed, 23 insertions(+), 22 deletions(-)

diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
index 012c18c67d9c6..0f6cec244d4fa 100644
--- a/drivers/pci/controller/Kconfig
+++ b/drivers/pci/controller/Kconfig
@@ -64,6 +64,7 @@ config PCIE_BRCMSTB
 		   BMIPS_GENERIC || COMPILE_TEST
 	depends on OF
 	depends on PCI_MSI
+	select IRQ_MSI_LIB
 	default ARCH_BRCMSTB || BMIPS_GENERIC
 	help
 	  Say Y here to enable PCIe host controller support for
diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller=
/pcie-brcmstb.c
index 744df5bd39aea..8ea75aa13130e 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -12,6 +12,7 @@
 #include <linux/iopoll.h>
 #include <linux/ioport.h>
 #include <linux/irqchip/chained_irq.h>
+#include <linux/irqchip/irq-msi-lib.h>
 #include <linux/irqdomain.h>
 #include <linux/kernel.h>
 #include <linux/list.h>
@@ -269,7 +270,6 @@ struct brcm_msi {
 	struct device		*dev;
 	void __iomem		*base;
 	struct device_node	*np;
-	struct irq_domain	*msi_domain;
 	struct irq_domain	*inner_domain;
 	struct mutex		lock; /* guards the alloc/free operations */
 	u64			target_addr;
@@ -469,17 +469,20 @@ static void brcm_pcie_set_outbound_win(struct brcm_pc=
ie *pcie,
 	writel(tmp, pcie->base + PCIE_MEM_WIN0_LIMIT_HI(win));
 }
=20
-static struct irq_chip brcm_msi_irq_chip =3D {
-	.name            =3D "BRCM STB PCIe MSI",
-	.irq_ack         =3D irq_chip_ack_parent,
-	.irq_mask        =3D pci_msi_mask_irq,
-	.irq_unmask      =3D pci_msi_unmask_irq,
-};
+#define BRCM_MSI_FLAGS_REQUIRED (MSI_FLAG_USE_DEF_DOM_OPS	| \
+				 MSI_FLAG_USE_DEF_CHIP_OPS	| \
+				 MSI_FLAG_NO_AFFINITY)
+
+#define BRCM_MSI_FLAGS_SUPPORTED (MSI_GENERIC_FLAGS_MASK	| \
+				  MSI_FLAG_MULTI_PCI_MSI)
=20
-static struct msi_domain_info brcm_msi_domain_info =3D {
-	.flags	=3D MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
-		  MSI_FLAG_NO_AFFINITY | MSI_FLAG_MULTI_PCI_MSI,
-	.chip	=3D &brcm_msi_irq_chip,
+static const struct msi_parent_ops brcm_msi_parent_ops =3D {
+	.required_flags		=3D BRCM_MSI_FLAGS_REQUIRED,
+	.supported_flags	=3D BRCM_MSI_FLAGS_SUPPORTED,
+	.bus_select_token	=3D DOMAIN_BUS_PCI_MSI,
+	.chip_flags		=3D MSI_CHIP_FLAG_SET_ACK,
+	.prefix			=3D "BRCM-",
+	.init_dev_msi_info	=3D msi_lib_init_dev_msi_info,
 };
=20
 static void brcm_pcie_msi_isr(struct irq_desc *desc)
@@ -588,18 +591,16 @@ static int brcm_allocate_domains(struct brcm_msi *msi)
 	struct fwnode_handle *fwnode =3D of_fwnode_handle(msi->np);
 	struct device *dev =3D msi->dev;
=20
-	msi->inner_domain =3D irq_domain_create_linear(NULL, msi->nr, &msi_domain=
_ops, msi);
-	if (!msi->inner_domain) {
-		dev_err(dev, "failed to create IRQ domain\n");
-		return -ENOMEM;
-	}
+	struct irq_domain_info info =3D {
+		.fwnode		=3D fwnode,
+		.ops		=3D &msi_domain_ops,
+		.host_data	=3D msi,
+		.size		=3D msi->nr,
+	};
=20
-	msi->msi_domain =3D pci_msi_create_irq_domain(fwnode,
-						    &brcm_msi_domain_info,
-						    msi->inner_domain);
-	if (!msi->msi_domain) {
+	msi->inner_domain =3D msi_create_parent_irq_domain(&info, &brcm_msi_paren=
t_ops);
+	if (!msi->inner_domain) {
 		dev_err(dev, "failed to create MSI domain\n");
-		irq_domain_remove(msi->inner_domain);
 		return -ENOMEM;
 	}
=20
@@ -608,7 +609,6 @@ static int brcm_allocate_domains(struct brcm_msi *msi)
=20
 static void brcm_free_domains(struct brcm_msi *msi)
 {
-	irq_domain_remove(msi->msi_domain);
 	irq_domain_remove(msi->inner_domain);
 }
=20
--=20
2.39.5


