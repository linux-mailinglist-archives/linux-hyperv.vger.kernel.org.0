Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECA753421B0
	for <lists+linux-hyperv@lfdr.de>; Fri, 19 Mar 2021 17:21:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbhCSQUp (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 19 Mar 2021 12:20:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbhCSQUb (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 19 Mar 2021 12:20:31 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DEB1C06175F;
        Fri, 19 Mar 2021 09:20:31 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id q3so3435577qkq.12;
        Fri, 19 Mar 2021 09:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vZobaehjsix9ib7wNZYs6eoX+BnCULN5ePNCx8BS41w=;
        b=G4s5yy6ZMZogHHRpLeRiBVSj9jitvRqqejC74/eF0IfqEwqdvlTBIR7F+IA1ne6l7O
         GG8O2dzkDS+nvBUkWU/5Gv1NEfId3HoI9LNZ4AxVzLufnBYhR73rMHo4cTOzt+XngoUd
         XoOUggIAZay53/+P+zf27DOJUwBOUD9sVT11PHdv8v0zCPfMdVL+QvYHaFfjAIE3BzvF
         ylV/QkEHjtBhjR0hhbxHcEN9Khf4QW0o9CHjOcBODtgr7trRFVJWCKqLFQi9uDt5arXE
         KLzQr7ky8bHWQ9wklJTdRZPfcBi3E9inKgdQfIIIaRBhn22ewD60AZPgDwHCOsi8AuRP
         h5+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vZobaehjsix9ib7wNZYs6eoX+BnCULN5ePNCx8BS41w=;
        b=C3ndy5z8bTn/0zGS5m2G80yd6/LAcfkDktwMfVPdfmqq+m8wgVywyoe3Wf5HHQeytU
         Fx6/GEyjb4TxnxTtf9t83A5sciNIxgMJ30vm+RAS5VOkcMhwsX6YwCEIcN2NpIz293bb
         62kRippiAnZNDx5QwJzVxMECBLjlijrtY7vTkNsxBzRrQgdKX8OZvobMLT+5dlmc0pt3
         BdU6rjhXb3ZQbbkVxQC19TsLHbglejW4z/KtuRSdjosWFeEiqXiC1jIRBIbJCWO6Aj6E
         T8ptHPAJKfz3uImyNhI2KsTKptXz9MzlacK9TF+p4EKltuceKCO9PIV2zalWjb4GBJpA
         2dqw==
X-Gm-Message-State: AOAM531kMGPhqt/58HJtZ2Wqq8c3sbUow11275gcOW+lWgwNDd10gjZt
        i9VBrdhf5ycZx0sem1gCRDU=
X-Google-Smtp-Source: ABdhPJx9673J0fqzQ5fDU65ei6lqj2aCpCqV40IEph2kxix69v/fpBODeOC4oHx+FmsO/q/Asy34UA==
X-Received: by 2002:a37:9a07:: with SMTP id c7mr10264036qke.352.1616170830254;
        Fri, 19 Mar 2021 09:20:30 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id 79sm4962458qki.37.2021.03.19.09.20.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 09:20:28 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailauth.nyi.internal (Postfix) with ESMTP id 430EE27C0061;
        Fri, 19 Mar 2021 12:20:28 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Fri, 19 Mar 2021 12:20:28 -0400
X-ME-Sender: <xms:TM9UYNL_xT-OIZogUwujyJAanZv9oGWKKqY_L5z9iySUQkFxaouihg>
    <xme:TM9UYJK0skRiVetcNxZkdDe-JmGD4aTvmnZEWFbrF3WPv2kp0odaiUKbWZZCA2zjb
    WClsgfIPXzvYdM5Fw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrudefkedgkeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhephedvveetfefgiedutedtfeevvddvleekjeeuffffleeguefhhfejteekieeu
    ueelnecukfhppedufedurddutdejrddurddvheegnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgv
    rhhsohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfh
    gvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:TM9UYFtmSthQ61VUkwd60QbAzNHTtArj-NOof8pemCyJjQ3VanjEGA>
    <xmx:TM9UYObCanonspK5tnj5N-HtXwP2huAAqZ7ddR_w7WHGT0C49yg3pA>
    <xmx:TM9UYEZk22Z258n9RhAJkhaoYc3a_lx7x0tV3ysxB0hsBkfo_-TaAA>
    <xmx:TM9UYKzk6rOhrAFZ0jPAnX8bqH4FInnacel-a-gDS8xIKRDhQZsfFQVkreakkOhZ>
Received: from localhost (unknown [131.107.1.254])
        by mail.messagingengine.com (Postfix) with ESMTPA id 9820A240068;
        Fri, 19 Mar 2021 12:20:27 -0400 (EDT)
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>, Clint Sbisa <csbisa@amazon.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Sunil Muthuswamy <sunilmut@microsoft.com>
Subject: [RFC 1/2] arm64: PCI: Allow use arch-specific pci sysdata
Date:   Sat, 20 Mar 2021 00:19:55 +0800
Message-Id: <20210319161956.2838291-2-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210319161956.2838291-1-boqun.feng@gmail.com>
References: <20210319161956.2838291-1-boqun.feng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Currently, if an architecture selects CONFIG_PCI_DOMAINS_GENERIC, the
->sysdata in bus and bridge will be treated as struct pci_config_window,
which is created by generic ECAM using the data from acpi.

However, for a virtualized PCI bus, there might be no enough data in of
or acpi table to create a pci_config_window. This is similar to the case
where CONFIG_PCI_DOMAINS_GENERIC=n, IOW, architectures use their own
structure for sysdata, so no apci table lookup is required.

In order to enable Hyper-V's virtual PCI (which doesn't have acpi table
entry for PCI) on ARM64 (which selects CONFIG_PCI_DOMAINS_GENERIC), we
introduce arch-specific pci sysdata (similar to the one for x86) for
ARM64, and allow the core PCI code to detect the type of sysdata at the
runtime. The latter is achieved by adding a pci_ops::use_arch_sysdata
field.

Originally-by: Sunil Muthuswamy <sunilmut@microsoft.com>
Signed-off-by: Boqun Feng (Microsoft) <boqun.feng@gmail.com>
---
 arch/arm64/include/asm/pci.h | 29 +++++++++++++++++++++++++++++
 arch/arm64/kernel/pci.c      | 15 ++++++++++++---
 include/linux/pci.h          |  3 +++
 3 files changed, 44 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/pci.h b/arch/arm64/include/asm/pci.h
index b33ca260e3c9..dade061a0658 100644
--- a/arch/arm64/include/asm/pci.h
+++ b/arch/arm64/include/asm/pci.h
@@ -22,6 +22,16 @@
 
 extern int isa_dma_bridge_buggy;
 
+struct pci_sysdata {
+	int domain;	/* PCI domain */
+	int node;	/* NUMA Node */
+#ifdef CONFIG_ACPI
+	struct acpi_device *companion;	/* ACPI companion device */
+#endif
+#ifdef CONFIG_PCI_MSI_IRQ_DOMAIN
+	void *fwnode;			/* IRQ domain for MSI assignment */
+#endif
+};
 #ifdef CONFIG_PCI
 static inline int pci_get_legacy_ide_irq(struct pci_dev *dev, int channel)
 {
@@ -31,8 +41,27 @@ static inline int pci_get_legacy_ide_irq(struct pci_dev *dev, int channel)
 
 static inline int pci_proc_domain(struct pci_bus *bus)
 {
+	if (bus->ops->use_arch_sysdata)
+		return pci_domain_nr(bus);
 	return 1;
 }
+#ifdef CONFIG_PCI_MSI_IRQ_DOMAIN
+static inline void *_pci_root_bus_fwnode(struct pci_bus *bus)
+{
+	struct pci_sysdata *sd = bus->sysdata;
+
+	if (bus->ops->use_arch_sysdata)
+		return sd->fwnode;
+
+	/*
+	 * bus->sysdata is not struct pci_sysdata, fwnode should be able to
+	 * be queried from of/acpi.
+	 */
+	return NULL;
+}
+#define pci_root_bus_fwnode	_pci_root_bus_fwnode
+#endif /* CONFIG_PCI_MSI_IRQ_DOMAIN */
+
 #endif  /* CONFIG_PCI */
 
 #endif  /* __ASM_PCI_H */
diff --git a/arch/arm64/kernel/pci.c b/arch/arm64/kernel/pci.c
index 1006ed2d7c60..63d420d57e63 100644
--- a/arch/arm64/kernel/pci.c
+++ b/arch/arm64/kernel/pci.c
@@ -74,15 +74,24 @@ struct acpi_pci_generic_root_info {
 int acpi_pci_bus_find_domain_nr(struct pci_bus *bus)
 {
 	struct pci_config_window *cfg = bus->sysdata;
-	struct acpi_device *adev = to_acpi_device(cfg->parent);
-	struct acpi_pci_root *root = acpi_driver_data(adev);
+	struct pci_sysdata *sd = bus->sysdata;
+	struct acpi_device *adev;
+	struct acpi_pci_root *root;
+
+	/* struct pci_sysdata has domain nr in it */
+	if (bus->ops->use_arch_sysdata)
+		return sd->domain;
+
+	/* or pci_config_window is used as sysdata */
+	adev = to_acpi_device(cfg->parent);
+	root = acpi_driver_data(adev);
 
 	return root->segment;
 }
 
 int pcibios_root_bridge_prepare(struct pci_host_bridge *bridge)
 {
-	if (!acpi_disabled) {
+	if (!acpi_disabled && bridge->ops->use_arch_sysdata) {
 		struct pci_config_window *cfg = bridge->bus->sysdata;
 		struct acpi_device *adev = to_acpi_device(cfg->parent);
 		struct device *bus_dev = &bridge->bus->dev;
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 86c799c97b77..4036aac40361 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -740,6 +740,9 @@ struct pci_ops {
 	void __iomem *(*map_bus)(struct pci_bus *bus, unsigned int devfn, int where);
 	int (*read)(struct pci_bus *bus, unsigned int devfn, int where, int size, u32 *val);
 	int (*write)(struct pci_bus *bus, unsigned int devfn, int where, int size, u32 val);
+#ifdef CONFIG_PCI_DOMAINS_GENERIC
+	int use_arch_sysdata;	/* ->sysdata is arch-specific */
+#endif
 };
 
 /*
-- 
2.30.2

