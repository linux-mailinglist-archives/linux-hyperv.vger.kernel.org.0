Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 216B23716ED
	for <lists+linux-hyperv@lfdr.de>; Mon,  3 May 2021 16:47:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbhECOsg (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 3 May 2021 10:48:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbhECOsg (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 3 May 2021 10:48:36 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC09CC06174A;
        Mon,  3 May 2021 07:47:41 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id k127so5229838qkc.6;
        Mon, 03 May 2021 07:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1FSEhDRBQeVQjstn1rh+EE8wSzHzDFWAgXa30qx5G9M=;
        b=fug6smugDkskCRhinWaiLtXji0LdsCSMENxrHWEDPVUB8cETbNLSJt71Mqohm5tm90
         d/A8W+KELZX2BTkHtlxh1bSBfAcOKMgS5/eehT3vAW6yms3LoU8SDA3wHoUdEYwOXQ/u
         hEQgfZZt9c2QKF0CaxHfL5lZFIVU/T0RxMFfMLMXXrfLJwfbbsU8xadgUGPIkSSlU32/
         iJFe9qV0Z5t83f185ChRQUD/6ySb0G7Vl8+A2ELP/dYkxRQnQzCARXpJZ8anEyDSAk8h
         zPeLrwd7U5Exz4nyWEe6NgQMdXqsl6a5g31nOIa59h5XzuHfI2WAEH94SyHQWAWLNy8Z
         WEHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1FSEhDRBQeVQjstn1rh+EE8wSzHzDFWAgXa30qx5G9M=;
        b=czKGTD0imiEyaPGmDnrF7hiFFmcOi2J8PH/hVL6l76NuONoPIcXKtZMLNE3u+7Mi+X
         GYceVYltxNMbjL8TU7dr/lTvgZ75UkZTD5Tr/XerC7hBmELslQ0FuHEcNj3te/zuk6QL
         eog4QoNGwW/tly3OpSyoLg77eIAiA+EW17/hDju6YxPIkZOAx91nKHEGwjjwJJUbE0NH
         8Yc0/NxGhiHCVeygU/OwFh2Hx8K02wf1Ua8I6BW7UH+dC55xZlDN4Kdc2QN1N09K2ngO
         KPIp5We6ZP3kdG6gt38Sei3e18jMl9V7Z4txbVLauuIi5OMVZHHQJiHJtjUwidg6cFMq
         hopQ==
X-Gm-Message-State: AOAM533gw+FsykUpC+HEckSQTmCfPi5zCFwlZA+d02bSEi4tfcAiEnvE
        irhrrHK2AYqatqHwXdA+8wU=
X-Google-Smtp-Source: ABdhPJx62G3wY4pYdtLDRjmUo8hJHBJuEW481c96AunDZIukoWSkSAUgwuT5KHNy7p8rk2UTj2nZSQ==
X-Received: by 2002:ae9:f302:: with SMTP id p2mr18993638qkg.103.1620053261145;
        Mon, 03 May 2021 07:47:41 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id o189sm8645068qkd.60.2021.05.03.07.47.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 May 2021 07:47:40 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailauth.nyi.internal (Postfix) with ESMTP id 191D727C0054;
        Mon,  3 May 2021 10:47:40 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 03 May 2021 10:47:40 -0400
X-ME-Sender: <xms:Cg2QYG9QNPiekyx7zsohFNFTzUZ_Ym98EsfP-MEWO4JT6KsmCjPaiQ>
    <xme:Cg2QYGsV1F7jZ1cDrLpfsEYzK-i_zyQbjDsA2zvUhKsayykQltCnlAxiwXs4G3JWm
    Tpkk00QBS7ZcjP2-g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdefgedgkedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhephedvveetfefgiedutedtfeevvddvleekjeeuffffleeguefhhfejteekieeu
    ueelnecukfhppedufedurddutdejrddurddvheegnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgv
    rhhsohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfh
    gvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:Cg2QYMCYj2vnK-XJS6nIRA4DP2nX92JgJ3wQJf3znywGSCb4Nmqbmw>
    <xmx:Cg2QYOf1Q2VOqlnQP8b-yp3J5tWKJtDB_kBwzJ4ZcZmuzUxXihghTg>
    <xmx:Cg2QYLMBFWxFK115jIOzHXWxAzRuWVJw_1P1kLv8NYd5LmTFi2fZFA>
    <xmx:DA2QYFV7r3Ghdg3XclrUbWc-HW9dCnB2XLgsW6JC8I8HZM7t81725byid1tvDX_x>
Received: from localhost (unknown [131.107.1.254])
        by mail.messagingengine.com (Postfix) with ESMTPA;
        Mon,  3 May 2021 10:47:37 -0400 (EDT)
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>,
        Marc Zyngier <maz@kernel.org>
Cc:     Russell King <linux@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Mike Rapoport <rppt@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jon Derrick <jonathan.derrick@intel.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-hyperv@vger.kernel.org
Subject: [RFC v2 1/7] PCI: Introduce pci_host_bridge::domain_nr
Date:   Mon,  3 May 2021 22:46:29 +0800
Message-Id: <20210503144635.2297386-2-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210503144635.2297386-1-boqun.feng@gmail.com>
References: <20210503144635.2297386-1-boqun.feng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Currently we retrieve the PCI domain number of the host bridge from the
bus sysdata (or pci_config_window if PCI_DOMAINS_GENERIC=y). Actually
we have the information at PCI host bridge probing time, and it makes
sense that we store it into pci_host_bridge. One benefit of doing so is
the requirement for supporting PCI on Hyper-V for ARM64, because the
host bridge of Hyper-V doesnt' have pci_config_window, whereas ARM64 is
a PCI_DOMAINS_GENERIC=y arch, so we cannot retrieve the PCI domain
number from pci_config_window on ARM64 Hyper-V guest.

As the preparation for ARM64 Hyper-V PCI support, we introduce the
domain_nr in pci_host_bridge, and set it properly at probing time, then
for PCI_DOMAINS_GENERIC=y archs, bus domain numbers are set by the
bridge domain_nr.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 arch/arm/kernel/bios32.c              |  2 ++
 arch/arm/mach-dove/pcie.c             |  2 ++
 arch/arm/mach-mv78xx0/pcie.c          |  2 ++
 arch/arm/mach-orion5x/pci.c           |  2 ++
 arch/arm64/kernel/pci.c               |  3 +--
 arch/mips/pci/pci-legacy.c            |  2 ++
 arch/mips/pci/pci-xtalk-bridge.c      |  2 ++
 drivers/pci/controller/pci-ftpci100.c |  2 ++
 drivers/pci/controller/pci-mvebu.c    |  2 ++
 drivers/pci/pci.c                     |  4 ++--
 drivers/pci/probe.c                   |  7 ++++++-
 include/linux/pci.h                   | 11 ++++++++---
 12 files changed, 33 insertions(+), 8 deletions(-)

diff --git a/arch/arm/kernel/bios32.c b/arch/arm/kernel/bios32.c
index e7ef2b5bea9c..4942cd681e41 100644
--- a/arch/arm/kernel/bios32.c
+++ b/arch/arm/kernel/bios32.c
@@ -471,6 +471,8 @@ static void pcibios_init_hw(struct device *parent, struct hw_pci *hw,
 				bridge->sysdata = sys;
 				bridge->busnr = sys->busnr;
 				bridge->ops = hw->ops;
+				if (IS_ENABLED(CONFIG_PCI_DOMAINS_GENERIC))
+					bridge->domain_nr = pci_bus_find_domain_nr(sys, parent);
 
 				ret = pci_scan_root_bus_bridge(bridge);
 			}
diff --git a/arch/arm/mach-dove/pcie.c b/arch/arm/mach-dove/pcie.c
index ee91ac6b5ebf..92eb8484b49b 100644
--- a/arch/arm/mach-dove/pcie.c
+++ b/arch/arm/mach-dove/pcie.c
@@ -167,6 +167,8 @@ dove_pcie_scan_bus(int nr, struct pci_host_bridge *bridge)
 	bridge->sysdata = sys;
 	bridge->busnr = sys->busnr;
 	bridge->ops = &pcie_ops;
+	if (IS_ENABLED(CONFIG_PCI_DOMAINS_GENERIC))
+		bridge->domain_nr = pci_bus_find_domain_nr(sys, NULL);
 
 	return pci_scan_root_bus_bridge(bridge);
 }
diff --git a/arch/arm/mach-mv78xx0/pcie.c b/arch/arm/mach-mv78xx0/pcie.c
index 636d84b40466..6703d394bcde 100644
--- a/arch/arm/mach-mv78xx0/pcie.c
+++ b/arch/arm/mach-mv78xx0/pcie.c
@@ -208,6 +208,8 @@ static int __init mv78xx0_pcie_scan_bus(int nr, struct pci_host_bridge *bridge)
 	bridge->sysdata = sys;
 	bridge->busnr = sys->busnr;
 	bridge->ops = &pcie_ops;
+	if (IS_ENABLED(CONFIG_PCI_DOMAINS_GENERIC))
+		bridge->domain_nr = pci_bus_find_domain_nr(sys, NULL);
 
 	return pci_scan_root_bus_bridge(bridge);
 }
diff --git a/arch/arm/mach-orion5x/pci.c b/arch/arm/mach-orion5x/pci.c
index 76951bfbacf5..6257fbd4e705 100644
--- a/arch/arm/mach-orion5x/pci.c
+++ b/arch/arm/mach-orion5x/pci.c
@@ -563,6 +563,8 @@ int __init orion5x_pci_sys_scan_bus(int nr, struct pci_host_bridge *bridge)
 	bridge->dev.parent = NULL;
 	bridge->sysdata = sys;
 	bridge->busnr = sys->busnr;
+	if (IS_ENABLED(CONFIG_PCI_DOMAINS_GENERIC))
+		bridge->domain_nr = pci_bus_find_domain_nr(sys, NULL);
 
 	if (nr == 0) {
 		bridge->ops = &pcie_ops;
diff --git a/arch/arm64/kernel/pci.c b/arch/arm64/kernel/pci.c
index 1006ed2d7c60..e9a6eeb6a694 100644
--- a/arch/arm64/kernel/pci.c
+++ b/arch/arm64/kernel/pci.c
@@ -71,9 +71,8 @@ struct acpi_pci_generic_root_info {
 	struct pci_config_window	*cfg;	/* config space mapping */
 };
 
-int acpi_pci_bus_find_domain_nr(struct pci_bus *bus)
+int acpi_pci_bus_find_domain_nr(struct pci_config_window *cfg)
 {
-	struct pci_config_window *cfg = bus->sysdata;
 	struct acpi_device *adev = to_acpi_device(cfg->parent);
 	struct acpi_pci_root *root = acpi_driver_data(adev);
 
diff --git a/arch/mips/pci/pci-legacy.c b/arch/mips/pci/pci-legacy.c
index 39052de915f3..84ad482be22d 100644
--- a/arch/mips/pci/pci-legacy.c
+++ b/arch/mips/pci/pci-legacy.c
@@ -97,6 +97,8 @@ static void pcibios_scanbus(struct pci_controller *hose)
 	bridge->ops = hose->pci_ops;
 	bridge->swizzle_irq = pci_common_swizzle;
 	bridge->map_irq = pcibios_map_irq;
+	if (IS_ENABLED(CONFIG_PCI_DOMAINS_GENERIC))
+		bridge->domain_nr = pci_bus_find_domain_nr(hose, NULL);
 	ret = pci_scan_root_bus_bridge(bridge);
 	if (ret) {
 		pci_free_host_bridge(bridge);
diff --git a/arch/mips/pci/pci-xtalk-bridge.c b/arch/mips/pci/pci-xtalk-bridge.c
index 50f7d42cca5a..23355ab720be 100644
--- a/arch/mips/pci/pci-xtalk-bridge.c
+++ b/arch/mips/pci/pci-xtalk-bridge.c
@@ -712,6 +712,8 @@ static int bridge_probe(struct platform_device *pdev)
 	host->ops = &bridge_pci_ops;
 	host->map_irq = bridge_map_irq;
 	host->swizzle_irq = pci_common_swizzle;
+	if (IS_ENABLED(CONFIG_PCI_DOMAINS_GENERIC))
+		host->domain_nr = pci_bus_find_domain_nr(bc, dev);
 
 	err = pci_scan_root_bus_bridge(host);
 	if (err < 0)
diff --git a/drivers/pci/controller/pci-ftpci100.c b/drivers/pci/controller/pci-ftpci100.c
index da3cd216da00..cf6eec7f90e1 100644
--- a/drivers/pci/controller/pci-ftpci100.c
+++ b/drivers/pci/controller/pci-ftpci100.c
@@ -439,6 +439,8 @@ static int faraday_pci_probe(struct platform_device *pdev)
 	host->ops = &faraday_pci_ops;
 	p = pci_host_bridge_priv(host);
 	host->sysdata = p;
+	if (IS_ENABLED(CONFIG_PCI_DOMAINS_GENERIC))
+		host->domain_nr = pci_bus_find_domain_nr(p, dev);
 	p->dev = dev;
 
 	/* Retrieve and enable optional clocks */
diff --git a/drivers/pci/controller/pci-mvebu.c b/drivers/pci/controller/pci-mvebu.c
index ed13e81cd691..b329ed2f0956 100644
--- a/drivers/pci/controller/pci-mvebu.c
+++ b/drivers/pci/controller/pci-mvebu.c
@@ -1122,6 +1122,8 @@ static int mvebu_pcie_probe(struct platform_device *pdev)
 	bridge->sysdata = pcie;
 	bridge->ops = &mvebu_pcie_ops;
 	bridge->align_resource = mvebu_pcie_align_resource;
+	if (IS_ENABLED(CONFIG_PCI_DOMAINS_GENERIC))
+		bridge->domain_nr = pci_bus_find_domain_nr(pcie, dev);
 
 	return mvebu_pci_host_probe(bridge);
 }
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 16a17215f633..a249dbf78c34 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -6505,10 +6505,10 @@ static int of_pci_bus_find_domain_nr(struct device *parent)
 	return domain;
 }
 
-int pci_bus_find_domain_nr(struct pci_bus *bus, struct device *parent)
+int pci_bus_find_domain_nr(void *sysdata, struct device *parent)
 {
 	return acpi_disabled ? of_pci_bus_find_domain_nr(parent) :
-			       acpi_pci_bus_find_domain_nr(bus);
+			       acpi_pci_bus_find_domain_nr(sysdata);
 }
 #endif
 
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 953f15abc850..5e71cc5e1b6c 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -899,7 +899,7 @@ static int pci_register_host_bridge(struct pci_host_bridge *bridge)
 	bus->ops = bridge->ops;
 	bus->number = bus->busn_res.start = bridge->busnr;
 #ifdef CONFIG_PCI_DOMAINS_GENERIC
-	bus->domain_nr = pci_bus_find_domain_nr(bus, parent);
+	bus->domain_nr = bridge->domain_nr;
 #endif
 
 	b = pci_find_bus(pci_domain_nr(bus), bridge->busnr);
@@ -2974,6 +2974,8 @@ struct pci_bus *pci_create_root_bus(struct device *parent, int bus,
 	bridge->sysdata = sysdata;
 	bridge->busnr = bus;
 	bridge->ops = ops;
+	if (IS_ENABLED(CONFIG_PCI_DOMAINS_GENERIC))
+		bridge->domain_nr = pci_bus_find_domain_nr(sysdata, parent);
 
 	error = pci_register_host_bridge(bridge);
 	if (error < 0)
@@ -2992,6 +2994,9 @@ int pci_host_probe(struct pci_host_bridge *bridge)
 	struct pci_bus *bus, *child;
 	int ret;
 
+	if (IS_ENABLED(CONFIG_PCI_DOMAINS_GENERIC))
+		bridge->domain_nr = pci_bus_find_domain_nr(bridge->sysdata, bridge->dev.parent);
+
 	ret = pci_scan_root_bus_bridge(bridge);
 	if (ret < 0) {
 		dev_err(bridge->dev.parent, "Scanning root bridge failed");
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 86c799c97b77..5bbd8417d219 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -534,6 +534,7 @@ struct pci_host_bridge {
 	struct pci_ops	*child_ops;
 	void		*sysdata;
 	int		busnr;
+	int		domain_nr;
 	struct list_head windows;	/* resource_entry */
 	struct list_head dma_ranges;	/* dma ranges resource list */
 	u8 (*swizzle_irq)(struct pci_dev *, u8 *); /* Platform IRQ swizzler */
@@ -1637,13 +1638,17 @@ static inline int pci_domain_nr(struct pci_bus *bus)
 {
 	return bus->domain_nr;
 }
+struct pci_config_window;
 #ifdef CONFIG_ACPI
-int acpi_pci_bus_find_domain_nr(struct pci_bus *bus);
+int acpi_pci_bus_find_domain_nr(struct pci_config_window *cfg);
 #else
-static inline int acpi_pci_bus_find_domain_nr(struct pci_bus *bus)
+static inline int acpi_pci_bus_find_domain_nr(struct pci_config_window *cfg)
 { return 0; }
 #endif
-int pci_bus_find_domain_nr(struct pci_bus *bus, struct device *parent);
+int pci_bus_find_domain_nr(void *sysdata, struct device *parent);
+#else
+static inline int pci_bus_find_domain_nr(void *sysdata, struct device *parent)
+{ return 0; }
 #endif
 
 /* Some architectures require additional setup to direct VGA traffic */
-- 
2.30.2

