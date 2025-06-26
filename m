Return-Path: <linux-hyperv+bounces-6004-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 316CAAEA127
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Jun 2025 16:48:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D9F17A9022
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Jun 2025 14:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 581D22EACF0;
	Thu, 26 Jun 2025 14:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UpBfTdyR";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uI0GPAPG"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 927862EACFE;
	Thu, 26 Jun 2025 14:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750949265; cv=none; b=WbMYSpI8iCsYBdAS7+5HYgJb80/5A9yM20UIKl24jb2A25sK3SSUShPkZQjSXMI4Y2SakJT0h7YlxKzNQI/cEKD+bn9bYJttqzQj2wBpY/eImWd5LMLQkeufdjy/XzAARiPDq9GRUYGvq0V2ujIeN1ewCenYFkwefou1qEcqYE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750949265; c=relaxed/simple;
	bh=TQTYJ+YerfUfgHVQxss0vGl926Rs+23iYYsL13p+hXc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SS/6lhlxkz1ZMsYLubG69vYI/4Rq/X2aRLS2qPF1Kw4HsnOhc2QArJrtLZzHksE4pJLJXHW7lLsL+rirf9q5PIE0Pv8jHIdbu2PyoQSdLEqnYDWsyDm6k9ESMP/cJfXgGjjN9o7davL1byylNFUS9ANYYQgjjYzxubsHp1pdaEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UpBfTdyR; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uI0GPAPG; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750949261;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WhA6zeUgIaWEOAl9LmE1+i921uT1E1slHb5VC0hbxvU=;
	b=UpBfTdyRkQotM3RIntlSAx8ZCaWOyvb2ZfxkZAychsx1RodDPTj7kmF9dtB5GXR1E0R/Wf
	tLwOufqEU87PoKfTorAPYIRPlHxOG/KZ4kUHat87GyV8jB+nTmLLTF+dJ9xKgAZN9kFIqN
	1yjp6lAgUpT/UNUYK3bhgjeKjxDDszLO3lw1zSvMksOsHnQIDRhh5lKJVFJsws2XMcvtiJ
	pY6U190gkbCMY+Q9743d3e92S2CHguoI5PspURlyueapnZLG0GtLnvADukutENPImcPsGJ
	cKtYKObLOtbHhzc9douplDEvQ41iB07Pd9Pc7SU1eflqBPBgHgnDLM8pgglUXw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750949261;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WhA6zeUgIaWEOAl9LmE1+i921uT1E1slHb5VC0hbxvU=;
	b=uI0GPAPGaOOQsppp3eHoy+Ymjn0kFM8sMryh5N2jOromXaHl9GQVTQ8m1qa4gqzDSeitRW
	hNLv88Mrh69fjqBQ==
To: "K . Y . Srinivasan" <kys@microsoft.com>,
	Marc Zyngier <maz@kernel.org>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>
Subject: [PATCH 1/1] x86/hyperv: Switch to msi_create_parent_irq_domain()
Date: Thu, 26 Jun 2025 16:47:26 +0200
Message-Id: <0eafade05acb51022242635750cd4990f3adb0ac.1750947640.git.namcao@linutronix.de>
In-Reply-To: <cover.1750947640.git.namcao@linutronix.de>
References: <cover.1750947640.git.namcao@linutronix.de>
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
 arch/x86/hyperv/irqdomain.c | 107 ++++++++++++++++++++++++------------
 drivers/hv/Kconfig          |   1 +
 2 files changed, 73 insertions(+), 35 deletions(-)

diff --git a/arch/x86/hyperv/irqdomain.c b/arch/x86/hyperv/irqdomain.c
index 31f0d29cbc5e3..924400c31d368 100644
--- a/arch/x86/hyperv/irqdomain.c
+++ b/arch/x86/hyperv/irqdomain.c
@@ -10,6 +10,7 @@
=20
 #include <linux/pci.h>
 #include <linux/irq.h>
+#include <linux/irqchip/irq-msi-lib.h>
 #include <asm/mshyperv.h>
=20
 static int hv_map_interrupt(union hv_device_id device_id, bool level,
@@ -276,59 +277,95 @@ static void hv_teardown_msi_irq(struct pci_dev *dev, =
struct irq_data *irqd)
 		hv_status_err(status, "\n");
 }
=20
-static void hv_msi_free_irq(struct irq_domain *domain,
-			    struct msi_domain_info *info, unsigned int virq)
-{
-	struct irq_data *irqd =3D irq_get_irq_data(virq);
-	struct msi_desc *desc;
-
-	if (!irqd)
-		return;
-
-	desc =3D irq_data_get_msi_desc(irqd);
-	if (!desc || !desc->irq || WARN_ON_ONCE(!dev_is_pci(desc->dev)))
-		return;
-
-	hv_teardown_msi_irq(to_pci_dev(desc->dev), irqd);
-}
-
 /*
  * IRQ Chip for MSI PCI/PCI-X/PCI-Express Devices,
  * which implement the MSI or MSI-X Capability Structure.
  */
 static struct irq_chip hv_pci_msi_controller =3D {
 	.name			=3D "HV-PCI-MSI",
-	.irq_unmask		=3D pci_msi_unmask_irq,
-	.irq_mask		=3D pci_msi_mask_irq,
 	.irq_ack		=3D irq_chip_ack_parent,
-	.irq_retrigger		=3D irq_chip_retrigger_hierarchy,
 	.irq_compose_msi_msg	=3D hv_irq_compose_msi_msg,
-	.irq_set_affinity	=3D msi_domain_set_affinity,
-	.flags			=3D IRQCHIP_SKIP_SET_WAKE | IRQCHIP_MOVE_DEFERRED,
+	.irq_set_affinity	=3D irq_chip_set_affinity_parent,
 };
=20
-static struct msi_domain_ops pci_msi_domain_ops =3D {
-	.msi_free		=3D hv_msi_free_irq,
-	.msi_prepare		=3D pci_msi_prepare,
+static bool hv_init_dev_msi_info(struct device *dev, struct irq_domain *do=
main,
+				 struct irq_domain *real_parent, struct msi_domain_info *info)
+{
+	struct irq_chip *chip =3D info->chip;
+
+	if (!msi_lib_init_dev_msi_info(dev, domain, real_parent, info))
+		return false;
+
+	chip->flags |=3D IRQCHIP_SKIP_SET_WAKE | IRQCHIP_MOVE_DEFERRED;
+
+	info->ops->msi_prepare =3D pci_msi_prepare;
+
+	return true;
+}
+
+#define HV_MSI_FLAGS_SUPPORTED	(MSI_GENERIC_FLAGS_MASK | MSI_FLAG_PCI_MSIX)
+#define HV_MSI_FLAGS_REQUIRED	(MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF=
_CHIP_OPS)
+
+static struct msi_parent_ops hv_msi_parent_ops =3D {
+	.supported_flags	=3D HV_MSI_FLAGS_SUPPORTED,
+	.required_flags		=3D HV_MSI_FLAGS_REQUIRED,
+	.bus_select_token	=3D DOMAIN_BUS_NEXUS,
+	.bus_select_mask	=3D MATCH_PCI_MSI,
+	.chip_flags		=3D MSI_CHIP_FLAG_SET_ACK,
+	.prefix			=3D "HV-",
+	.init_dev_msi_info	=3D hv_init_dev_msi_info,
 };
=20
-static struct msi_domain_info hv_pci_msi_domain_info =3D {
-	.flags		=3D MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
-			  MSI_FLAG_PCI_MSIX,
-	.ops		=3D &pci_msi_domain_ops,
-	.chip		=3D &hv_pci_msi_controller,
-	.handler	=3D handle_edge_irq,
-	.handler_name	=3D "edge",
+static int hv_msi_domain_alloc(struct irq_domain *d, unsigned int virq, un=
signed int nr_irqs,
+			       void *arg)
+{
+	/* TODO: move the content of hv_irq_compose_msi_msg() in here */
+	int ret;
+
+	ret =3D irq_domain_alloc_irqs_parent(d, virq, nr_irqs, arg);
+	if (ret)
+		return ret;
+
+	for (int i =3D 0; i < nr_irqs; ++i) {
+		irq_domain_set_info(d, virq + i, 0, &hv_pci_msi_controller, NULL,
+				    handle_edge_irq, NULL, "edge");
+	}
+	return 0;
+}
+
+static void hv_msi_domain_free(struct irq_domain *d, unsigned int virq, un=
signed int nr_irqs)
+{
+	for (int i =3D 0; i < nr_irqs; ++i) {
+		struct irq_data *irqd =3D irq_domain_get_irq_data(d, virq);
+		struct msi_desc *desc;
+
+		desc =3D irq_data_get_msi_desc(irqd);
+		if (!desc || !desc->irq || WARN_ON_ONCE(!dev_is_pci(desc->dev)))
+			continue;
+
+		hv_teardown_msi_irq(to_pci_dev(desc->dev), irqd);
+	}
+	irq_domain_free_irqs_top(d, virq, nr_irqs);
+}
+
+static const struct irq_domain_ops hv_msi_domain_ops =3D {
+	.select	=3D msi_lib_irq_domain_select,
+	.alloc	=3D hv_msi_domain_alloc,
+	.free	=3D hv_msi_domain_free,
 };
=20
 struct irq_domain * __init hv_create_pci_msi_domain(void)
 {
 	struct irq_domain *d =3D NULL;
-	struct fwnode_handle *fn;
=20
-	fn =3D irq_domain_alloc_named_fwnode("HV-PCI-MSI");
-	if (fn)
-		d =3D pci_msi_create_irq_domain(fn, &hv_pci_msi_domain_info, x86_vector_=
domain);
+	struct irq_domain_info info =3D {
+		.fwnode		=3D irq_domain_alloc_named_fwnode("HV-PCI-MSI"),
+		.ops		=3D &hv_msi_domain_ops,
+		.parent		=3D x86_vector_domain,
+	};
+
+	if (info.fwnode)
+		d =3D msi_create_parent_irq_domain(&info, &hv_msi_parent_ops);
=20
 	/* No point in going further if we can't get an irq domain */
 	BUG_ON(!d);
diff --git a/drivers/hv/Kconfig b/drivers/hv/Kconfig
index 1cd188b73b743..e62a0f8b34198 100644
--- a/drivers/hv/Kconfig
+++ b/drivers/hv/Kconfig
@@ -10,6 +10,7 @@ config HYPERV
 	select X86_HV_CALLBACK_VECTOR if X86
 	select OF_EARLY_FLATTREE if OF
 	select SYSFB if !HYPERV_VTL_MODE
+	select IRQ_MSI_LIB if X86
 	help
 	  Select this option to run Linux as a Hyper-V client operating
 	  system.
--=20
2.39.5


