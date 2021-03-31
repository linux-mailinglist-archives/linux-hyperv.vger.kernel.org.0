Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8E58344F37
	for <lists+linux-hyperv@lfdr.de>; Mon, 22 Mar 2021 19:54:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232224AbhCVSyI (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 22 Mar 2021 14:54:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:37434 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231240AbhCVSxm (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 22 Mar 2021 14:53:42 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 12060619A1;
        Mon, 22 Mar 2021 18:53:42 +0000 (UTC)
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1lOPZS-0038p5-4Z; Mon, 22 Mar 2021 18:46:34 +0000
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
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-hyperv@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org, kernel-team@android.com
Subject: [PATCH v2 11/15] PCI: mediatek: Advertise lack of MSI handling
Date:   Mon, 22 Mar 2021 18:46:10 +0000
Message-Id: <20210322184614.802565-12-maz@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210322184614.802565-1-maz@kernel.org>
References: <20210322184614.802565-1-maz@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: lorenzo.pieralisi@arm.com, bhelgaas@google.com, frank-w@public-files.de, treding@nvidia.com, tglx@linutronix.de, robh@kernel.org, will@kernel.org, kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com, mikelley@microsoft.com, wei.liu@kernel.org, thierry.reding@gmail.com, jonathanh@nvidia.com, ryder.lee@mediatek.com, marek.vasut+renesas@gmail.com, yoshihiro.shimoda.uh@renesas.com, michal.simek@xilinx.com, paul.walmsley@sifive.com, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-hyperv@vger.kernel.org, linux-tegra@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-renesas-soc@vger.kernel.org, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

Some Mediatek host bridges cannot handle MSIs, which is sad.
This also results in an ugly warning at device probe time,
as the core PCI code wasn't told that MSIs were not available.

Advertise this fact to the rest of the core PCI code by
using the 'no_msi' attribute.

Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Reported-by: Frank Wunderlich <frank-w@public-files.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
[maz: commit message]
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/pci/controller/pcie-mediatek.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
index 23548b517e4b..ba28abdd1362 100644
--- a/drivers/pci/controller/pcie-mediatek.c
+++ b/drivers/pci/controller/pcie-mediatek.c
@@ -143,6 +143,7 @@ struct mtk_pcie_port;
  * struct mtk_pcie_soc - differentiate between host generations
  * @need_fix_class_id: whether this host's class ID needed to be fixed or not
  * @need_fix_device_id: whether this host's device ID needed to be fixed or not
+ * @no_msi: Bridge has no MSI support
  * @device_id: device ID which this host need to be fixed
  * @ops: pointer to configuration access functions
  * @startup: pointer to controller setting functions
@@ -151,6 +152,7 @@ struct mtk_pcie_port;
 struct mtk_pcie_soc {
 	bool need_fix_class_id;
 	bool need_fix_device_id;
+	bool no_msi;
 	unsigned int device_id;
 	struct pci_ops *ops;
 	int (*startup)(struct mtk_pcie_port *port);
@@ -1087,6 +1089,7 @@ static int mtk_pcie_probe(struct platform_device *pdev)
 
 	host->ops = pcie->soc->ops;
 	host->sysdata = pcie;
+	host->no_msi = pcie->soc->no_msi;
 
 	err = pci_host_probe(host);
 	if (err)
@@ -1176,6 +1179,7 @@ static const struct dev_pm_ops mtk_pcie_pm_ops = {
 };
 
 static const struct mtk_pcie_soc mtk_pcie_soc_v1 = {
+	.no_msi = true,
 	.ops = &mtk_pcie_ops,
 	.startup = mtk_pcie_startup_port,
 };
-- 
2.29.2

