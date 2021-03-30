Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8FA634EBAD
	for <lists+linux-hyperv@lfdr.de>; Tue, 30 Mar 2021 17:12:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232285AbhC3PMY (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 30 Mar 2021 11:12:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:59990 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232257AbhC3PL7 (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 30 Mar 2021 11:11:59 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C438D61987;
        Tue, 30 Mar 2021 15:11:58 +0000 (UTC)
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1lRG29-004i6i-3I; Tue, 30 Mar 2021 16:11:57 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Thierry Reding <treding@nvidia.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh@kernel.org>, Will Deacon <will@kernel.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Bharat Kumar Gogada <bharatku@xilinx.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-hyperv@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org, kernel-team@android.com
Subject: [PATCH v3 07/14] PCI/MSI: Drop use of msi_controller from core code
Date:   Tue, 30 Mar 2021 16:11:38 +0100
Message-Id: <20210330151145.997953-8-maz@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210330151145.997953-1-maz@kernel.org>
References: <20210330151145.997953-1-maz@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: lorenzo.pieralisi@arm.com, bhelgaas@google.com, frank-w@public-files.de, treding@nvidia.com, tglx@linutronix.de, robh@kernel.org, will@kernel.org, kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com, mikelley@microsoft.com, wei.liu@kernel.org, thierry.reding@gmail.com, jonathanh@nvidia.com, ryder.lee@mediatek.com, marek.vasut+renesas@gmail.com, yoshihiro.shimoda.uh@renesas.com, michal.simek@xilinx.com, paul.walmsley@sifive.com, bharatku@xilinx.com, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-hyperv@vger.kernel.org, linux-tegra@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-renesas-soc@vger.kernel.org, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

As there is no driver using msi_controller, we can now safely
remove its use from the PCI probe code.

Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/pci/msi.c   | 23 +----------------------
 drivers/pci/probe.c |  2 --
 include/linux/pci.h |  2 --
 3 files changed, 1 insertion(+), 26 deletions(-)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index 3162f88fe940..79b5a995bd02 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -64,39 +64,18 @@ static void pci_msi_teardown_msi_irqs(struct pci_dev *dev)
 /* Arch hooks */
 int __weak arch_setup_msi_irq(struct pci_dev *dev, struct msi_desc *desc)
 {
-	struct msi_controller *chip = dev->bus->msi;
-	int err;
-
-	if (!chip || !chip->setup_irq)
-		return -EINVAL;
-
-	err = chip->setup_irq(chip, dev, desc);
-	if (err < 0)
-		return err;
-
-	irq_set_chip_data(desc->irq, chip);
-
-	return 0;
+	return -EINVAL;
 }
 
 void __weak arch_teardown_msi_irq(unsigned int irq)
 {
-	struct msi_controller *chip = irq_get_chip_data(irq);
-
-	if (!chip || !chip->teardown_irq)
-		return;
-
-	chip->teardown_irq(chip, irq);
 }
 
 int __weak arch_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
 {
-	struct msi_controller *chip = dev->bus->msi;
 	struct msi_desc *entry;
 	int ret;
 
-	if (chip && chip->setup_irqs)
-		return chip->setup_irqs(chip, dev, nvec, type);
 	/*
 	 * If an architecture wants to support multiple MSI, it needs to
 	 * override arch_setup_msi_irqs()
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 953f15abc850..fb04fc81a8bd 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -895,7 +895,6 @@ static int pci_register_host_bridge(struct pci_host_bridge *bridge)
 	/* Temporarily move resources off the list */
 	list_splice_init(&bridge->windows, &resources);
 	bus->sysdata = bridge->sysdata;
-	bus->msi = bridge->msi;
 	bus->ops = bridge->ops;
 	bus->number = bus->busn_res.start = bridge->busnr;
 #ifdef CONFIG_PCI_DOMAINS_GENERIC
@@ -1053,7 +1052,6 @@ static struct pci_bus *pci_alloc_child_bus(struct pci_bus *parent,
 		return NULL;
 
 	child->parent = parent;
-	child->msi = parent->msi;
 	child->sysdata = parent->sysdata;
 	child->bus_flags = parent->bus_flags;
 
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 86c799c97b77..ebf557e59d87 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -540,7 +540,6 @@ struct pci_host_bridge {
 	int (*map_irq)(const struct pci_dev *, u8, u8);
 	void (*release_fn)(struct pci_host_bridge *);
 	void		*release_data;
-	struct msi_controller *msi;
 	unsigned int	ignore_reset_delay:1;	/* For entire hierarchy */
 	unsigned int	no_ext_tags:1;		/* No Extended Tags */
 	unsigned int	native_aer:1;		/* OS may use PCIe AER */
@@ -621,7 +620,6 @@ struct pci_bus {
 	struct resource busn_res;	/* Bus numbers routed to this bus */
 
 	struct pci_ops	*ops;		/* Configuration access functions */
-	struct msi_controller *msi;	/* MSI controller */
 	void		*sysdata;	/* Hook for sys-specific extension */
 	struct proc_dir_entry *procdir;	/* Directory entry in /proc/bus/pci */
 
-- 
2.29.2

