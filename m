Return-Path: <linux-hyperv+bounces-6009-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16731AEA174
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Jun 2025 16:55:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 910891C456FD
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Jun 2025 14:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 168AF2ED161;
	Thu, 26 Jun 2025 14:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tDOj/lpl";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Fs1qyOFC"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E3F2E4274;
	Thu, 26 Jun 2025 14:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750949322; cv=none; b=hUUU+2t2tDr0W71IlLNltB6p8+SH0vP0gus0/wfTfTpdnG8sPUxRsJpP6ptb4CiEb7LU1MWMEHoS0dVRof3FmIncTaihEQkKRZpXe8c0Vt5ut/mu+6Y9RFAFihR/D1P3FfVL9PvF1Zbuxz59TVrm0VyDA4XBXbPts7AC8y+xYBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750949322; c=relaxed/simple;
	bh=Mb1eaFjXKnOsO2erYJLRPs3qQ+1SszR41uaqB7pkaiY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iWRjryglOyzUw/shn/4ONlOJF0Q5hWm32tgJ61XwrAh23T27CWuuQJwIQxgnujtGikWWyoreWmpP8etiKdp4jarr8DNKol2g3jN4tQTVjUcy0y5vjLEopPfgthD/18f0+0Am0+ttOIV/ihUisVeT75Ss3OZEDAZbY/VunWsa12c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tDOj/lpl; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Fs1qyOFC; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750949318;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5RiH2QS4+1kCH8P95Q5VgmocNwT6Na4BdF5l0zDeYZM=;
	b=tDOj/lplDvXLQGSlcKSnXAtVHXB9przJdn05VEr4AodvNu6nn7G+m/LLtbdiTsXdtNO37V
	Hc0CO3zx7V+e2nBt5wrqARZDEJSVXe0d/8iGpdPKDf/zck8p7UirSpNcaztpYi4qwOUyqI
	9IZ2dR/ypgSsvEXBVhgbhaPpq/yIMu2CuThyjRJ1SKMSWhy4UvbUWajsMO6xmLX3Ff0BHS
	CWxZYxxYgRn1cRwMvl7oAdocIvKe4qHfiG1qVCxBEfhHwAuDKcfVaATY1eAh7znXVLVnaS
	DK/NhDhRduxobloFua8AFbqQcrAvLZlv1BvmtqNyPVz3dY7ijOk0YZ4+vjTo9Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750949318;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5RiH2QS4+1kCH8P95Q5VgmocNwT6Na4BdF5l0zDeYZM=;
	b=Fs1qyOFCKC/4WHcF4TxHZZsJqfAyeWlS6E7B7hehsQ7zY4wQA+CIjWqHRq49AU4OJACbTh
	Y2v2Jw5yalA0OiCg==
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
Subject: [PATCH 03/16] PCI: aardvark: Switch to msi_create_parent_irq_domain()
Date: Thu, 26 Jun 2025 16:47:53 +0200
Message-Id: <68b2f9387bbe4f08bcd428bfab83ad1219fb8d80.1750858083.git.namcao@linutronix.de>
In-Reply-To: <cover.1750858083.git.namcao@linutronix.de>
References: <cover.1750858083.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Move away from the legacy MSI domain setup, switch to use
msi_create_parent_irq_domain().

Signed-off-by: Nam Cao <namcao@linutronix.de>
---
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc: "Pali Roh=C3=A1r" <pali@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
---
 drivers/pci/controller/Kconfig        |  1 +
 drivers/pci/controller/pci-aardvark.c | 59 +++++++++++----------------
 2 files changed, 24 insertions(+), 36 deletions(-)

diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
index 886f6f43a895f..91a2d4ffc3ac4 100644
--- a/drivers/pci/controller/Kconfig
+++ b/drivers/pci/controller/Kconfig
@@ -13,6 +13,7 @@ config PCI_AARDVARK
 	depends on OF
 	depends on PCI_MSI
 	select PCI_BRIDGE_EMUL
+	select IRQ_MSI_LIB
 	help
 	 Add support for Aardvark 64bit PCIe Host Controller. This
 	 controller is part of the South Bridge of the Marvel Armada
diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller=
/pci-aardvark.c
index 7bac64533b143..e34bea1ff0ac6 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -13,6 +13,7 @@
 #include <linux/gpio/consumer.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
+#include <linux/irqchip/irq-msi-lib.h>
 #include <linux/irqdomain.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
@@ -278,7 +279,6 @@ struct advk_pcie {
 	struct irq_domain *irq_domain;
 	struct irq_chip irq_chip;
 	raw_spinlock_t irq_lock;
-	struct irq_domain *msi_domain;
 	struct irq_domain *msi_inner_domain;
 	raw_spinlock_t msi_irq_lock;
 	DECLARE_BITMAP(msi_used, MSI_IRQ_NUM);
@@ -1332,18 +1332,6 @@ static void advk_msi_irq_unmask(struct irq_data *d)
 	raw_spin_unlock_irqrestore(&pcie->msi_irq_lock, flags);
 }
=20
-static void advk_msi_top_irq_mask(struct irq_data *d)
-{
-	pci_msi_mask_irq(d);
-	irq_chip_mask_parent(d);
-}
-
-static void advk_msi_top_irq_unmask(struct irq_data *d)
-{
-	pci_msi_unmask_irq(d);
-	irq_chip_unmask_parent(d);
-}
-
 static struct irq_chip advk_msi_bottom_irq_chip =3D {
 	.name			=3D "MSI",
 	.irq_compose_msi_msg	=3D advk_msi_irq_compose_msi_msg,
@@ -1436,17 +1424,20 @@ static const struct irq_domain_ops advk_pcie_irq_do=
main_ops =3D {
 	.xlate =3D irq_domain_xlate_onecell,
 };
=20
-static struct irq_chip advk_msi_irq_chip =3D {
-	.name		=3D "advk-MSI",
-	.irq_mask	=3D advk_msi_top_irq_mask,
-	.irq_unmask	=3D advk_msi_top_irq_unmask,
-};
-
-static struct msi_domain_info advk_msi_domain_info =3D {
-	.flags	=3D MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
-		  MSI_FLAG_NO_AFFINITY | MSI_FLAG_MULTI_PCI_MSI |
-		  MSI_FLAG_PCI_MSIX,
-	.chip	=3D &advk_msi_irq_chip,
+#define ADVK_MSI_FLAGS_REQUIRED (MSI_FLAG_USE_DEF_DOM_OPS	| \
+				 MSI_FLAG_USE_DEF_CHIP_OPS	| \
+				 MSI_FLAG_PCI_MSI_MASK_PARENT	| \
+				 MSI_FLAG_NO_AFFINITY)
+#define ADVK_MSI_FLAGS_SUPPORTED (MSI_GENERIC_FLAGS_MASK	| \
+				  MSI_FLAG_PCI_MSIX		| \
+				  MSI_FLAG_MULTI_PCI_MSI)
+
+static const struct msi_parent_ops advk_msi_parent_ops =3D {
+	.required_flags		=3D ADVK_MSI_FLAGS_REQUIRED,
+	.supported_flags	=3D ADVK_MSI_FLAGS_SUPPORTED,
+	.bus_select_token	=3D DOMAIN_BUS_PCI_MSI,
+	.prefix			=3D "advk-",
+	.init_dev_msi_info	=3D msi_lib_init_dev_msi_info,
 };
=20
 static int advk_pcie_init_msi_irq_domain(struct advk_pcie *pcie)
@@ -1456,26 +1447,22 @@ static int advk_pcie_init_msi_irq_domain(struct adv=
k_pcie *pcie)
 	raw_spin_lock_init(&pcie->msi_irq_lock);
 	mutex_init(&pcie->msi_used_lock);
=20
-	pcie->msi_inner_domain =3D irq_domain_create_linear(NULL, MSI_IRQ_NUM,
-							  &advk_msi_domain_ops, pcie);
-	if (!pcie->msi_inner_domain)
-		return -ENOMEM;
+	struct irq_domain_info info =3D {
+		.fwnode		=3D dev_fwnode(dev),
+		.ops		=3D &advk_msi_domain_ops,
+		.host_data	=3D pcie,
+		.size		=3D MSI_IRQ_NUM,
+	};
=20
-	pcie->msi_domain =3D
-		pci_msi_create_irq_domain(dev_fwnode(dev),
-					  &advk_msi_domain_info,
-					  pcie->msi_inner_domain);
-	if (!pcie->msi_domain) {
-		irq_domain_remove(pcie->msi_inner_domain);
+	pcie->msi_inner_domain =3D msi_create_parent_irq_domain(&info, &advk_msi_=
parent_ops);
+	if (!pcie->msi_inner_domain)
 		return -ENOMEM;
-	}
=20
 	return 0;
 }
=20
 static void advk_pcie_remove_msi_irq_domain(struct advk_pcie *pcie)
 {
-	irq_domain_remove(pcie->msi_domain);
 	irq_domain_remove(pcie->msi_inner_domain);
 }
=20
--=20
2.39.5


