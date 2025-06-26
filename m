Return-Path: <linux-hyperv+bounces-6022-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0F12AEA196
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Jun 2025 16:58:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15DDB3B6025
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Jun 2025 14:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA7192F2350;
	Thu, 26 Jun 2025 14:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RlTKpMxp";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PJDuAZfu"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B452F0E5D;
	Thu, 26 Jun 2025 14:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750949338; cv=none; b=jlB5Vp+zyGHjRC+PcT1vc9nzfrgmEfeV1TnuhbeFYi+fbJ+LNaE2ZF+iWjyH2K9WSd9GiWubZcTVlTLcN63a8jX3VC4w2FM2XNQpAPvNIbJUVhgdV/h3oO+qQb+bkGvNhAdRyWtZsMKIp1oj1feMvP7C27wa5ZqqmJqj9AP1HOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750949338; c=relaxed/simple;
	bh=yDJ3ha73iX5NE7GtyOKFDNVF2hSnSGaMH3lv8anhTXU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FRjbL9+radeYmL79vPSc6AZEznTs74nOKOqRqtkSbwhyzGfJYfXI1hHtwSSH+tjsiK5SnT4MPLGx2uRasgFpwS+JraduR8BmF/g62sVEoKFnBAls61V76oPlx3qufvp/8h81ervxpxJT5sssdBIsgHCMRGPuf3PwSjit+EY2j4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RlTKpMxp; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PJDuAZfu; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750949334;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rk3H9RFUvmNY5RjaBgBDpAsPmWU5zFd/wV/8KHcc9Jo=;
	b=RlTKpMxpW+z/7WVrkiJLnaoM+T8aKE7F9Fxvdo4ZiVh+UwdjxDnea2IT+M5+yQRLqIewev
	sJU/BI4rqcxBcntnPbX3PmMDEAWXWUiXdyyBrPdUsspyDfqvdfInE4/j7YOBc+Gza8VGAj
	d+nZhlc/U/9ekHNN3JyfP5c5meZ4eMZPsejf14KhqdDy6HlTLUyBBDP+NleBfX4yCwfbn8
	MjUJss2vs5mWkIlQDqn5qjKFyD27MeUVQGHuiS06M+wAzHqnRHmVYCp9LOM8cTUcJaYUK5
	FsqoQohWIApoUBswBwQ5NNi2Z7TLM+ss9v+5vJLu3OK5xF5o8VggDgM81qf1nQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750949334;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rk3H9RFUvmNY5RjaBgBDpAsPmWU5zFd/wV/8KHcc9Jo=;
	b=PJDuAZfuBgWAnsvNtnV4iMVqFsZvxtIfRFTbFJ3+oao6m90FOulpO3WQMdJFoFhXE6NATR
	O57SQu4FvAsl51Bw==
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
Subject: [PATCH 16/16] PCI: vmd: Switch to msi_create_parent_irq_domain()
Date: Thu, 26 Jun 2025 16:48:06 +0200
Message-Id: <de3f1d737831b251e9cd2cbf9e4c732a5bbba13a.1750858083.git.namcao@linutronix.de>
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
Cc: Nirmal Patel <nirmal.patel@linux.intel.com>
Cc: Jonathan Derrick <jonathan.derrick@linux.dev>
---
 drivers/pci/controller/Kconfig |   1 +
 drivers/pci/controller/vmd.c   | 160 +++++++++++++++++----------------
 2 files changed, 82 insertions(+), 79 deletions(-)

diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
index 8f56ffd029ba2..41748d083b933 100644
--- a/drivers/pci/controller/Kconfig
+++ b/drivers/pci/controller/Kconfig
@@ -156,6 +156,7 @@ config PCI_IXP4XX
 config VMD
 	depends on PCI_MSI && X86_64 && !UML
 	tristate "Intel Volume Management Device Driver"
+	select IRQ_MSI_LIB
 	help
 	  Adds support for the Intel Volume Management Device (VMD). VMD is a
 	  secondary PCI host bridge that allows PCI Express root ports,
diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index d9b893bf4e456..38693a9487d9b 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -7,6 +7,7 @@
 #include <linux/device.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
+#include <linux/irqchip/irq-msi-lib.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/msi.h>
@@ -174,9 +175,6 @@ static void vmd_compose_msi_msg(struct irq_data *data, =
struct msi_msg *msg)
 	msg->arch_addr_lo.destid_0_7 =3D index_from_irqs(vmd, irq);
 }
=20
-/*
- * We rely on MSI_FLAG_USE_DEF_CHIP_OPS to set the IRQ mask/unmask ops.
- */
 static void vmd_irq_enable(struct irq_data *data)
 {
 	struct vmd_irq *vmdirq =3D data->chip_data;
@@ -186,7 +184,11 @@ static void vmd_irq_enable(struct irq_data *data)
 		list_add_tail_rcu(&vmdirq->node, &vmdirq->irq->irq_list);
 		vmdirq->enabled =3D true;
 	}
+}
=20
+static void vmd_pci_msi_enable(struct irq_data *data)
+{
+	vmd_irq_enable(data->parent_data);
 	data->chip->irq_unmask(data);
 }
=20
@@ -194,8 +196,6 @@ static void vmd_irq_disable(struct irq_data *data)
 {
 	struct vmd_irq *vmdirq =3D data->chip_data;
=20
-	data->chip->irq_mask(data);
-
 	scoped_guard(raw_spinlock_irqsave, &list_lock) {
 		if (vmdirq->enabled) {
 			list_del_rcu(&vmdirq->node);
@@ -204,19 +204,17 @@ static void vmd_irq_disable(struct irq_data *data)
 	}
 }
=20
+static void vmd_pci_msi_disable(struct irq_data *data)
+{
+	data->chip->irq_mask(data);
+	vmd_irq_disable(data->parent_data);
+}
+
 static struct irq_chip vmd_msi_controller =3D {
 	.name			=3D "VMD-MSI",
-	.irq_enable		=3D vmd_irq_enable,
-	.irq_disable		=3D vmd_irq_disable,
 	.irq_compose_msi_msg	=3D vmd_compose_msi_msg,
 };
=20
-static irq_hw_number_t vmd_get_hwirq(struct msi_domain_info *info,
-				     msi_alloc_info_t *arg)
-{
-	return 0;
-}
-
 /*
  * XXX: We can be even smarter selecting the best IRQ once we solve the
  * affinity problem.
@@ -250,100 +248,110 @@ static struct vmd_irq_list *vmd_next_irq(struct vmd=
_dev *vmd, struct msi_desc *d
 	return &vmd->irqs[best];
 }
=20
-static int vmd_msi_init(struct irq_domain *domain, struct msi_domain_info =
*info,
-			unsigned int virq, irq_hw_number_t hwirq,
-			msi_alloc_info_t *arg)
+static void vmd_msi_free(struct irq_domain *domain, unsigned int virq, uns=
igned int nr_irqs);
+
+static int vmd_msi_alloc(struct irq_domain *domain, unsigned int virq, uns=
igned int nr_irqs,
+			 void *arg)
 {
-	struct msi_desc *desc =3D arg->desc;
-	struct vmd_dev *vmd =3D vmd_from_bus(msi_desc_to_pci_dev(desc)->bus);
-	struct vmd_irq *vmdirq =3D kzalloc(sizeof(*vmdirq), GFP_KERNEL);
+	struct msi_desc *desc =3D ((msi_alloc_info_t *)arg)->desc;
+	struct vmd_dev *vmd =3D domain->host_data;
+	struct vmd_irq *vmdirq;
=20
-	if (!vmdirq)
-		return -ENOMEM;
+	for (int i =3D 0; i < nr_irqs; ++i) {
+		vmdirq =3D kzalloc(sizeof(*vmdirq), GFP_KERNEL);
+		if (!vmdirq) {
+			vmd_msi_free(domain, virq, i);
+			return -ENOMEM;
+		}
=20
-	INIT_LIST_HEAD(&vmdirq->node);
-	vmdirq->irq =3D vmd_next_irq(vmd, desc);
-	vmdirq->virq =3D virq;
+		INIT_LIST_HEAD(&vmdirq->node);
+		vmdirq->irq =3D vmd_next_irq(vmd, desc);
+		vmdirq->virq =3D virq + i;
+
+		irq_domain_set_info(domain, virq + i, vmdirq->irq->virq, &vmd_msi_contro=
ller,
+				    vmdirq, handle_untracked_irq, vmd, NULL);
+	}
=20
-	irq_domain_set_info(domain, virq, vmdirq->irq->virq, info->chip, vmdirq,
-			    handle_untracked_irq, vmd, NULL);
 	return 0;
 }
=20
-static void vmd_msi_free(struct irq_domain *domain,
-			struct msi_domain_info *info, unsigned int virq)
+static void vmd_msi_free(struct irq_domain *domain, unsigned int virq, uns=
igned int nr_irqs)
 {
 	struct vmd_irq *vmdirq =3D irq_get_chip_data(virq);
=20
-	synchronize_srcu(&vmdirq->irq->srcu);
+	for (int i =3D 0; i < nr_irqs; ++i) {
+		synchronize_srcu(&vmdirq->irq->srcu);
=20
-	/* XXX: Potential optimization to rebalance */
-	scoped_guard(raw_spinlock_irq, &list_lock)
-		vmdirq->irq->count--;
+		/* XXX: Potential optimization to rebalance */
+		scoped_guard(raw_spinlock_irq, &list_lock)
+			vmdirq->irq->count--;
=20
-	kfree(vmdirq);
+		kfree(vmdirq);
+	}
 }
=20
-static int vmd_msi_prepare(struct irq_domain *domain, struct device *dev,
-			   int nvec, msi_alloc_info_t *arg)
+static const struct irq_domain_ops vmd_msi_domain_ops =3D {
+	.alloc		=3D vmd_msi_alloc,
+	.free		=3D vmd_msi_free,
+};
+
+static bool vmd_init_dev_msi_info(struct device *dev, struct irq_domain *d=
omain,
+				  struct irq_domain *real_parent, struct msi_domain_info *info)
 {
-	struct pci_dev *pdev =3D to_pci_dev(dev);
-	struct vmd_dev *vmd =3D vmd_from_bus(pdev->bus);
+	if (WARN_ON_ONCE(info->bus_token !=3D DOMAIN_BUS_PCI_DEVICE_MSIX))
+		return false;
=20
-	if (nvec > vmd->msix_count)
-		return vmd->msix_count;
+	if (!msi_lib_init_dev_msi_info(dev, domain, real_parent, info))
+		return false;
=20
-	memset(arg, 0, sizeof(*arg));
-	return 0;
+	info->chip->irq_enable		=3D vmd_pci_msi_enable;
+	info->chip->irq_disable		=3D vmd_pci_msi_disable;
+	return true;
 }
=20
-static void vmd_set_desc(msi_alloc_info_t *arg, struct msi_desc *desc)
-{
-	arg->desc =3D desc;
-}
+#define VMD_MSI_FLAGS_SUPPORTED		(MSI_GENERIC_FLAGS_MASK | MSI_FLAG_PCI_MS=
IX)
+#define VMD_MSI_FLAGS_REQUIRED		(MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_NO_AF=
FINITY)
=20
-static struct msi_domain_ops vmd_msi_domain_ops =3D {
-	.get_hwirq	=3D vmd_get_hwirq,
-	.msi_init	=3D vmd_msi_init,
-	.msi_free	=3D vmd_msi_free,
-	.msi_prepare	=3D vmd_msi_prepare,
-	.set_desc	=3D vmd_set_desc,
+static const struct msi_parent_ops vmd_msi_parent_ops =3D {
+	.supported_flags	=3D VMD_MSI_FLAGS_SUPPORTED,
+	.required_flags		=3D VMD_MSI_FLAGS_REQUIRED,
+	.bus_select_token	=3D DOMAIN_BUS_VMD_MSI,
+	.bus_select_mask	=3D MATCH_PCI_MSI,
+	.prefix			=3D "VMD-",
+	.init_dev_msi_info	=3D vmd_init_dev_msi_info,
 };
=20
-static struct msi_domain_info vmd_msi_domain_info =3D {
-	.flags		=3D MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
-			  MSI_FLAG_NO_AFFINITY | MSI_FLAG_PCI_MSIX,
-	.ops		=3D &vmd_msi_domain_ops,
-	.chip		=3D &vmd_msi_controller,
-};
-
-static void vmd_set_msi_remapping(struct vmd_dev *vmd, bool enable)
-{
-	u16 reg;
-
-	pci_read_config_word(vmd->dev, PCI_REG_VMCONFIG, &reg);
-	reg =3D enable ? (reg & ~VMCONFIG_MSI_REMAP) :
-		       (reg | VMCONFIG_MSI_REMAP);
-	pci_write_config_word(vmd->dev, PCI_REG_VMCONFIG, reg);
-}
-
 static int vmd_create_irq_domain(struct vmd_dev *vmd)
 {
-	struct fwnode_handle *fn;
+	struct irq_domain_info info =3D {
+		.size		=3D vmd->msix_count,
+		.ops		=3D &vmd_msi_domain_ops,
+		.host_data	=3D vmd,
+	};
=20
-	fn =3D irq_domain_alloc_named_id_fwnode("VMD-MSI", vmd->sysdata.domain);
-	if (!fn)
+	info.fwnode =3D irq_domain_alloc_named_id_fwnode("VMD-MSI", vmd->sysdata.=
domain);
+	if (!info.fwnode)
 		return -ENODEV;
=20
-	vmd->irq_domain =3D pci_msi_create_irq_domain(fn, &vmd_msi_domain_info, N=
ULL);
+	vmd->irq_domain =3D msi_create_parent_irq_domain(&info, &vmd_msi_parent_o=
ps);
 	if (!vmd->irq_domain) {
-		irq_domain_free_fwnode(fn);
+		irq_domain_free_fwnode(info.fwnode);
 		return -ENODEV;
 	}
=20
 	return 0;
 }
=20
+static void vmd_set_msi_remapping(struct vmd_dev *vmd, bool enable)
+{
+	u16 reg;
+
+	pci_read_config_word(vmd->dev, PCI_REG_VMCONFIG, &reg);
+	reg =3D enable ? (reg & ~VMCONFIG_MSI_REMAP) :
+		       (reg | VMCONFIG_MSI_REMAP);
+	pci_write_config_word(vmd->dev, PCI_REG_VMCONFIG, reg);
+}
+
 static void vmd_remove_irq_domain(struct vmd_dev *vmd)
 {
 	/*
@@ -874,12 +882,6 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsi=
gned long features)
 		ret =3D vmd_create_irq_domain(vmd);
 		if (ret)
 			return ret;
-
-		/*
-		 * Override the IRQ domain bus token so the domain can be
-		 * distinguished from a regular PCI/MSI domain.
-		 */
-		irq_domain_update_bus_token(vmd->irq_domain, DOMAIN_BUS_VMD_MSI);
 	} else {
 		vmd_set_msi_remapping(vmd, false);
 	}
--=20
2.39.5


