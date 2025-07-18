Return-Path: <linux-hyperv+bounces-6301-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FFA9B0AAE3
	for <lists+linux-hyperv@lfdr.de>; Fri, 18 Jul 2025 21:58:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22B69A47836
	for <lists+linux-hyperv@lfdr.de>; Fri, 18 Jul 2025 19:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8C522036ED;
	Fri, 18 Jul 2025 19:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FCUv/1BJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BvfVgMR/"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A0E820101D;
	Fri, 18 Jul 2025 19:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752868693; cv=none; b=uKMcZRpcsdkXmc0NI/72Rr6JiPbgYy8NBf2YM0GklGpop+meWDBcLCV+oz+MCFQbZtjteRxwF6k0QVCv50ykMff2ZGCZqjoq4tEq+Kgoh+MR8ZwsQduApdeBpBt352WJDYO+Mcp9SKSrUMoLEcfl+qu4oMnTlDdMeKt+Rr/cdsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752868693; c=relaxed/simple;
	bh=j+x01lZeY33lylpNUBKrXmr5DViprZvLIHdaHIKojVM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Hlg18dNHIMLhOtiS0HULh4LwhSR7SQHuV/jiA6sOfB37BuV7lUtoFQjnq5kS0fEImRxvswAm6JpoptfCO3G3Ta/+tEgI5+/ztJToudW6/guYcKq4hNPuLFB5uxQcoh4LYytjSdl4Pq8RIRR14iMmByMaOFJDIsYTC/+kulDszU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FCUv/1BJ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BvfVgMR/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752868690;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b7QAwdVL+79NV9ecblpnNODvIuZUoG5ItDj3RISptN8=;
	b=FCUv/1BJzik77ZgYSENKhWjjzDWpjZidM48i2+7KwRtlplGXfAGK9OgVikH+P+vLva+VNL
	WUdcrleEE4nxn5fiAl2ZqVd9M42+BUIMQXRnlrl48791Le/4nFgWCCmAo8xExr4z338AwM
	jYOcofC2pUMZIiApuOgVeWelN8M0M46L3Q5jNN2WBMGRdi6eELC7rXyQ2tNziVxfxrqrSu
	iFsoYh0v1wQXgR//rZ56sLasdfiziL1Q1gge3ZFspW4u+KDz3+19lLrDX4yDW0AH4Eu31k
	dpvde5DoFILPIOktzyIKqajaeFlmYErDcjSZZ+7agAF9MmImgWkERaM3T33rew==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752868690;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b7QAwdVL+79NV9ecblpnNODvIuZUoG5ItDj3RISptN8=;
	b=BvfVgMR/o44YuDoCHXcyUJKzcgvJjS7OBmfK7XDmGwo4SnsfWNmV+h74dU2YHGsuxys4nQ
	eIfwrpLLm8PlkYAg==
To: "K . Y . Srinivasan" <kys@microsoft.com>,
	Nuno Das Neves <nunodasneves@linux.microsoft.com>,
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
Subject: [PATCH v3 1/1] x86/hyperv: Switch to msi_create_parent_irq_domain()
Date: Fri, 18 Jul 2025 21:57:50 +0200
Message-Id: <45df1cc0088057cbf60cb84d8e9f9ff09f12f670.1752868165.git.namcao@linutronix.de>
In-Reply-To: <cover.1752868165.git.namcao@linutronix.de>
References: <cover.1752868165.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Move away from the legacy MSI domain setup, switch to use
msi_create_parent_irq_domain().

While doing the conversion, I noticed that hv_irq_compose_msi_msg() is
doing more than it is supposed to (composing message content). The
interrupt allocation bits should be moved into hv_msi_domain_alloc().
However, I have no hardware to test this change, therefore I leave a TODO
note.

Signed-off-by: Nam Cao <namcao@linutronix.de>
---
 arch/x86/hyperv/irqdomain.c | 111 ++++++++++++++++++++++++------------
 drivers/hv/Kconfig          |   1 +
 2 files changed, 77 insertions(+), 35 deletions(-)

diff --git a/arch/x86/hyperv/irqdomain.c b/arch/x86/hyperv/irqdomain.c
index 090f5ac9f492..c3ba12b1bc07 100644
--- a/arch/x86/hyperv/irqdomain.c
+++ b/arch/x86/hyperv/irqdomain.c
@@ -11,6 +11,7 @@
 #include <linux/pci.h>
 #include <linux/irq.h>
 #include <linux/export.h>
+#include <linux/irqchip/irq-msi-lib.h>
 #include <asm/mshyperv.h>
=20
 static int hv_map_interrupt(union hv_device_id device_id, bool level,
@@ -289,59 +290,99 @@ static void hv_teardown_msi_irq(struct pci_dev *dev, =
struct irq_data *irqd)
 	(void)hv_unmap_msi_interrupt(dev, &old_entry);
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
+	/*
+	 * TODO: The allocation bits of hv_irq_compose_msi_msg(), i.e. everything=
 except
+	 * entry_to_msi_msg() should be in here.
+	 */
+
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
index 57623ca7f350..9afffedce290 100644
--- a/drivers/hv/Kconfig
+++ b/drivers/hv/Kconfig
@@ -10,6 +10,7 @@ config HYPERV
 	select X86_HV_CALLBACK_VECTOR if X86
 	select OF_EARLY_FLATTREE if OF
 	select SYSFB if EFI && !HYPERV_VTL_MODE
+	select IRQ_MSI_LIB if X86
 	help
 	  Select this option to run Linux as a Hyper-V client operating
 	  system.
--=20
2.49.0


