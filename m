Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E0E234EC29
	for <lists+linux-hyperv@lfdr.de>; Tue, 30 Mar 2021 17:24:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232395AbhC3PYM (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 30 Mar 2021 11:24:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:35276 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232274AbhC3PXl (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 30 Mar 2021 11:23:41 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8D05D619D9;
        Tue, 30 Mar 2021 15:23:40 +0000 (UTC)
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1lRG2C-004i6i-0w; Tue, 30 Mar 2021 16:12:00 +0100
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
Subject: [PATCH v3 10/14] PCI/MSI: Let PCI host bridges declare their reliance on MSI domains
Date:   Tue, 30 Mar 2021 16:11:41 +0100
Message-Id: <20210330151145.997953-11-maz@kernel.org>
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

There is a whole class of host bridges that cannot know whether
MSIs will be provided or not, as they rely on other blocks
to provide the MSI functionnality, using MSI domains.  This is
the case for example on systems that use the ARM GIC architecture.

Introduce a new attribute ('msi_domain') indicating that implicit
dependency, and use this property to set the NO_MSI flag when
no MSI domain is found at probe time.

Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/pci/probe.c | 2 ++
 include/linux/pci.h | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index fb04fc81a8bd..aa6fba35f5d1 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -925,6 +925,8 @@ static int pci_register_host_bridge(struct pci_host_bridge *bridge)
 	device_enable_async_suspend(bus->bridge);
 	pci_set_bus_of_node(bus);
 	pci_set_bus_msi_domain(bus);
+	if (bridge->msi_domain && !dev_get_msi_domain(&bus->dev))
+		bus->bus_flags |= PCI_BUS_FLAGS_NO_MSI;
 
 	if (!parent)
 		set_dev_node(bus->bridge, pcibus_to_node(bus));
diff --git a/include/linux/pci.h b/include/linux/pci.h
index ebf557e59d87..ede0aef2cfd4 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -550,6 +550,7 @@ struct pci_host_bridge {
 	unsigned int	native_dpc:1;		/* OS may use PCIe DPC */
 	unsigned int	preserve_config:1;	/* Preserve FW resource setup */
 	unsigned int	size_windows:1;		/* Enable root bus sizing */
+	unsigned int	msi_domain:1;		/* Bridge wants MSI domain */
 
 	/* Resource alignment requirements */
 	resource_size_t (*align_resource)(struct pci_dev *dev,
-- 
2.29.2

