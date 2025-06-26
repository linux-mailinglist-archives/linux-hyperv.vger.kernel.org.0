Return-Path: <linux-hyperv+bounces-6020-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B869BAEA19D
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Jun 2025 16:59:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40AF01890278
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Jun 2025 14:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 143752F0E4C;
	Thu, 26 Jun 2025 14:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WeCmGG3U";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kVqC7t1p"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E5812F0E25;
	Thu, 26 Jun 2025 14:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750949336; cv=none; b=oJRplaAevuWrXTJgmo/p+aANFJsX5a3fxLGzMmslvyayPPoghEKcjLDJS94/M90/0izVYEQIvY6LUdcq7dM2dGsGl5seDEhn1YoTuUlkmRRYy+uVHwb6H32xjztCCy8N+Y+DHxIYNy+bPRwk3QB7kmoRS83+nQ9cM+Vmji9ENDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750949336; c=relaxed/simple;
	bh=fFfA0t24jwp8wash1jXiQsG0/47Cix3I5096mGywGZ4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nde8TrLHHHMiwsGt2MfWP/Zj1QZpXAHi4l7Ulp1KrP2eOWjPuvjFRW5796vERhvo8LPsxwJKpKeDPsFI4lJCL9aGS1vQ3TkRKoKbNe080owxUa3oAF4EpIz+tfCdcmzvqRH0r6LME2MYNplPI6+7VpVzHB6m5qekX2aG2JQrREQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WeCmGG3U; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kVqC7t1p; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750949332;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=af4jMPSbDsFEHwjALYDiqXkbkCSoSYM8oqrwc3Yb4UI=;
	b=WeCmGG3U2DLxocSHfjcV4NZ2JJYBdtIv+oRB+MXVUFdnT66ZgjZ/k4CY9TwtH9f/WOHlTq
	WnE6bIIgmNW79zVHnYRfHGn2PlpQA4fyzo/JRLT+D6OOnpLD9AdfmMgP/N6QADFOB1+nJ9
	+QHHxej+KC+JgE5iHZJAyb+EHL6gKJkqabr/ySiX2HiVKCWgCwiEtwd0KQVPnY/JnYGGRB
	HSL1c8XiECK7t4LQwPaGOJF3G9yEYysX0H0uGw3ATSnmAzjC2XIZ8FQd+/cNcZxM2rV8My
	1CT1G5Z0q/5kiI3gFbH0Az+JPqi0tVIe4jYYZGcq7+fOxikm9bSVci6H+AjBtg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750949332;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=af4jMPSbDsFEHwjALYDiqXkbkCSoSYM8oqrwc3Yb4UI=;
	b=kVqC7t1pY9/9/KhXWAcXyalMa5FqUatWRMUY2OF9h47DoMwkImw8X+w85LmsD9CqGiJaE1
	19k5BH0VgwqOKvDw==
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
Subject: [PATCH 14/16] PCI: hv: Switch to msi_create_parent_irq_domain()
Date: Thu, 26 Jun 2025 16:48:04 +0200
Message-Id: <024f0122314198fe0a42fef01af53e8953a687ec.1750858083.git.namcao@linutronix.de>
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
Cc: K. Y. Srinivasan <kys@microsoft.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>
Cc: Wei Liu <wei.liu@kernel.org>
Cc: Dexuan Cui <decui@microsoft.com>
Cc: linux-hyperv@vger.kernel.org
---
 drivers/pci/Kconfig                 |  1 +
 drivers/pci/controller/pci-hyperv.c | 98 +++++++++++++++++++++++------
 2 files changed, 80 insertions(+), 19 deletions(-)

diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
index 9c0e4aaf4e8cb..9a249c65aedcd 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -223,6 +223,7 @@ config PCI_HYPERV
 	tristate "Hyper-V PCI Frontend"
 	depends on ((X86 && X86_64) || ARM64) && HYPERV && PCI_MSI && SYSFS
 	select PCI_HYPERV_INTERFACE
+	select IRQ_MSI_LIB
 	help
 	  The PCI device frontend driver allows the kernel to import arbitrary
 	  PCI devices from a PCI backend to support PCI driver domains.
diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/p=
ci-hyperv.c
index ef5d655a0052c..3a24fadddb83b 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -44,6 +44,7 @@
 #include <linux/delay.h>
 #include <linux/semaphore.h>
 #include <linux/irq.h>
+#include <linux/irqchip/irq-msi-lib.h>
 #include <linux/msi.h>
 #include <linux/hyperv.h>
 #include <linux/refcount.h>
@@ -508,7 +509,6 @@ struct hv_pcibus_device {
 	struct list_head children;
 	struct list_head dr_list;
=20
-	struct msi_domain_info msi_info;
 	struct irq_domain *irq_domain;
=20
 	struct workqueue_struct *wq;
@@ -1687,7 +1687,7 @@ static void hv_msi_free(struct irq_domain *domain, st=
ruct msi_domain_info *info,
 	struct msi_desc *msi =3D irq_data_get_msi_desc(irq_data);
=20
 	pdev =3D msi_desc_to_pci_dev(msi);
-	hbus =3D info->data;
+	hbus =3D domain->host_data;
 	int_desc =3D irq_data_get_irq_chip_data(irq_data);
 	if (!int_desc)
 		return;
@@ -1705,7 +1705,6 @@ static void hv_msi_free(struct irq_domain *domain, st=
ruct msi_domain_info *info,
=20
 static void hv_irq_mask(struct irq_data *data)
 {
-	pci_msi_mask_irq(data);
 	if (data->parent_data->chip->irq_mask)
 		irq_chip_mask_parent(data);
 }
@@ -1716,7 +1715,6 @@ static void hv_irq_unmask(struct irq_data *data)
=20
 	if (data->parent_data->chip->irq_unmask)
 		irq_chip_unmask_parent(data);
-	pci_msi_unmask_irq(data);
 }
=20
 struct compose_comp_ctxt {
@@ -2101,6 +2099,44 @@ static void hv_compose_msi_msg(struct irq_data *data=
, struct msi_msg *msg)
 	msg->data =3D 0;
 }
=20
+static bool hv_pcie_init_dev_msi_info(struct device *dev, struct irq_domai=
n *domain,
+				      struct irq_domain *real_parent, struct msi_domain_info *info)
+{
+	struct irq_chip *chip =3D info->chip;
+
+	if (!msi_lib_init_dev_msi_info(dev, domain, real_parent, info))
+		return false;
+
+	info->ops->msi_prepare =3D hv_msi_prepare;
+
+	chip->irq_set_affinity =3D irq_chip_set_affinity_parent;
+
+	if (IS_ENABLED(CONFIG_X86))
+		chip->flags |=3D IRQCHIP_MOVE_DEFERRED;
+
+	return true;
+}
+
+#define HV_PCIE_MSI_FLAGS_REQUIRED (MSI_FLAG_USE_DEF_DOM_OPS		| \
+				    MSI_FLAG_USE_DEF_CHIP_OPS		| \
+				    MSI_FLAG_PCI_MSI_MASK_PARENT)
+#define HV_PCIE_MSI_FLAGS_SUPPORTED (MSI_FLAG_MULTI_PCI_MSI		| \
+				     MSI_FLAG_PCI_MSIX			| \
+				     MSI_GENERIC_FLAGS_MASK)
+
+static const struct msi_parent_ops hv_pcie_msi_parent_ops =3D {
+	.required_flags		=3D HV_PCIE_MSI_FLAGS_REQUIRED,
+	.supported_flags	=3D HV_PCIE_MSI_FLAGS_SUPPORTED,
+	.bus_select_token	=3D DOMAIN_BUS_PCI_MSI,
+#ifdef CONFIG_X86
+	.chip_flags		=3D MSI_CHIP_FLAG_SET_ACK,
+#elif defined(CONFIG_ARM64)
+	.chip_flags		=3D MSI_CHIP_FLAG_SET_EOI,
+#endif
+	.prefix			=3D "HV-",
+	.init_dev_msi_info	=3D hv_pcie_init_dev_msi_info,
+};
+
 /* HW Interrupt Chip Descriptor */
 static struct irq_chip hv_msi_irq_chip =3D {
 	.name			=3D "Hyper-V PCIe MSI",
@@ -2108,7 +2144,6 @@ static struct irq_chip hv_msi_irq_chip =3D {
 	.irq_set_affinity	=3D irq_chip_set_affinity_parent,
 #ifdef CONFIG_X86
 	.irq_ack		=3D irq_chip_ack_parent,
-	.flags			=3D IRQCHIP_MOVE_DEFERRED,
 #elif defined(CONFIG_ARM64)
 	.irq_eoi		=3D irq_chip_eoi_parent,
 #endif
@@ -2116,9 +2151,37 @@ static struct irq_chip hv_msi_irq_chip =3D {
 	.irq_unmask		=3D hv_irq_unmask,
 };
=20
-static struct msi_domain_ops hv_msi_ops =3D {
-	.msi_prepare	=3D hv_msi_prepare,
-	.msi_free	=3D hv_msi_free,
+static int hv_pcie_domain_alloc(struct irq_domain *d, unsigned int virq, u=
nsigned int nr_irqs,
+			       void *arg)
+{
+	/* TODO: move the content of hv_compose_msi_msg() in here */
+	int ret;
+
+	ret =3D irq_domain_alloc_irqs_parent(d, virq, nr_irqs, arg);
+	if (ret < 0)
+		return ret;
+
+	for (int i =3D 0; i < nr_irqs; i++) {
+		irq_domain_set_info(d, virq + i, 0, &hv_msi_irq_chip, NULL, FLOW_HANDLER=
, NULL,
+				    FLOW_NAME);
+	}
+
+	return 0;
+}
+
+static void hv_pcie_domain_free(struct irq_domain *d, unsigned int virq, u=
nsigned int nr_irqs)
+{
+	struct msi_domain_info *info =3D d->host_data;
+
+	for (int i =3D 0; i < nr_irqs; i++)
+		hv_msi_free(d, info, virq + i);
+
+	irq_domain_free_irqs_top(d, virq, nr_irqs);
+}
+
+static const struct irq_domain_ops hv_pcie_domain_ops =3D {
+	.alloc	=3D hv_pcie_domain_alloc,
+	.free	=3D hv_pcie_domain_free,
 };
=20
 /**
@@ -2136,17 +2199,14 @@ static struct msi_domain_ops hv_msi_ops =3D {
  */
 static int hv_pcie_init_irq_domain(struct hv_pcibus_device *hbus)
 {
-	hbus->msi_info.chip =3D &hv_msi_irq_chip;
-	hbus->msi_info.ops =3D &hv_msi_ops;
-	hbus->msi_info.flags =3D (MSI_FLAG_USE_DEF_DOM_OPS |
-		MSI_FLAG_USE_DEF_CHIP_OPS | MSI_FLAG_MULTI_PCI_MSI |
-		MSI_FLAG_PCI_MSIX);
-	hbus->msi_info.handler =3D FLOW_HANDLER;
-	hbus->msi_info.handler_name =3D FLOW_NAME;
-	hbus->msi_info.data =3D hbus;
-	hbus->irq_domain =3D pci_msi_create_irq_domain(hbus->fwnode,
-						     &hbus->msi_info,
-						     hv_pci_get_root_domain());
+	struct irq_domain_info info =3D {
+		.fwnode		=3D hbus->fwnode,
+		.ops		=3D &hv_pcie_domain_ops,
+		.host_data	=3D hbus,
+		.parent		=3D hv_pci_get_root_domain(),
+	};
+
+	hbus->irq_domain =3D msi_create_parent_irq_domain(&info, &hv_pcie_msi_par=
ent_ops);
 	if (!hbus->irq_domain) {
 		dev_err(&hbus->hdev->device,
 			"Failed to build an MSI IRQ domain\n");
--=20
2.39.5


