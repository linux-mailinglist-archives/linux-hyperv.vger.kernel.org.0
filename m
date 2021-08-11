Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFD783E94A2
	for <lists+linux-hyperv@lfdr.de>; Wed, 11 Aug 2021 17:36:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233208AbhHKPhC (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 11 Aug 2021 11:37:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233189AbhHKPhB (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 11 Aug 2021 11:37:01 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B868C061765;
        Wed, 11 Aug 2021 08:36:37 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id a4so3248099ilj.12;
        Wed, 11 Aug 2021 08:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GWLHS7/8sRUtmPBUfizlYA1mSy1P6fTX/Paccfguq6M=;
        b=qcNIH8Msq5OiNc+L3Z12ZCE8w4EtGd20JL38KwwamTSNTSTMC3eqGwkenBJAWDayAK
         nqm0sz6epxb9sWaCbqn+N7LA0kHi15vojXcwMD3qAQNU0GBY7jUSv/6onB95VYDkLp/y
         sghqlkytM26c+cPSX0otKUN4wcrCkIwtQ61pf7sOlDRKuyrUSAL0jwIEWi224YLcx8I9
         TalWA6dpPTmMh3cVQ/mcz8PxKTKJsCdomhx5gm8u0uXReyo+4almtLtZ+NI6cDUAjyd1
         V2CR5diJMvIGg8IA/Pw3UD7Fh9p1mjqyGBqbLGxeO7VbuffW/yUgeiAhSLxE4xxL1i6o
         TNrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GWLHS7/8sRUtmPBUfizlYA1mSy1P6fTX/Paccfguq6M=;
        b=P4vFB0d8syu0VmD7w5vwrcakDN1pSriCyAfMKl4j2NIQKud6GKxcW7jCfwgDBuEnzc
         05dw//gcfAeG3E3rZKPb5OeHIW9LwE9crYJpdVIKOLmAY/uYOxjXZ5tzy6pXR21RVh9l
         yym7Ed4EGrzp1MH04m/2ehkXg3huzhivNotPzk2KNYNgbqmdSjhuOWTZonOJbjZRxNWf
         J0FidO4jUbzCv0n+89MXRC1yJ/u43YZ5oIpviO3IfHQ5CqyMl3YNDGWyGJVSbMYRxsxf
         GZR00lBbarzTzC24QHRR1utKdUchmTnhoT9RlCQmpCgiLqsv2b9l1X9ZnLzLjocCuoNN
         jYog==
X-Gm-Message-State: AOAM530VGO2f2DYeG9J5dxxm672KUqZPeGQhg1/9mIMC0Ac1htbCnsss
        shUl00IRWR7GgPZMT8xTuyg=
X-Google-Smtp-Source: ABdhPJw7CZTvEfUfPqm/j+ddaSI2a9I3c0fRLtrRijCPdrvAwL2rCz2j6pNCSqyitNsKHlsE4XcAPQ==
X-Received: by 2002:a92:4453:: with SMTP id a19mr335155ilm.221.1628696196604;
        Wed, 11 Aug 2021 08:36:36 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id h8sm5899493ile.39.2021.08.11.08.36.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Aug 2021 08:36:36 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailauth.nyi.internal (Postfix) with ESMTP id 422DF27C005A;
        Wed, 11 Aug 2021 11:36:35 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 11 Aug 2021 11:36:35 -0400
X-ME-Sender: <xms:g-4TYb-zSMgBO_vPoDQj-oujYHkPUD45Bg6pVrbOWeYDHrsn6ylIbA>
    <xme:g-4TYXs-fDarG14ksKEIY34V4XOlic36-le5D9e52OErHYmv5ln7GHeA6fUSyiEiL
    BwkhYhOwPzFod1ppw>
X-ME-Received: <xmr:g-4TYZB0zQ23GAWRBOVS83Ib4Z0hXDW_HKM0VUlCtDFJp4iQ7XLf2aD5MDw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrkedugdeltdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtth
    gvrhhnpeehvdevteefgfeiudettdefvedvvdelkeejueffffelgeeuhffhjeetkeeiueeu
    leenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsoh
    hquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedq
    udejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmh
    gvrdhnrghmvg
X-ME-Proxy: <xmx:g-4TYXdt1xDJGbBiVS0DAtr-4mRzR_-V3kA2WlogJXRwQlinXgBCjA>
    <xmx:g-4TYQNKChBRz7ZvzF42OyEWSERBD3ulDv1wNLZO962ntRtdvg_HJw>
    <xmx:g-4TYZnRimiddGuHuuCNbRDIrYWGmlfv-FSRixO3u-VpqLJj0e6V0Q>
    <xmx:g-4TYctJditQpUvP_epS_vJc0KiLNFqGVE54QYdwaI3lluExlGu15qXve0s>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Aug 2021 11:36:34 -0400 (EDT)
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-hyperv@vger.kernel.org,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Marc Zyngier <maz@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Subject: [RFC 1/5] PCI: Introduce pci_create_root_bus_priv()
Date:   Wed, 11 Aug 2021 23:36:15 +0800
Message-Id: <20210811153619.88922-2-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210811153619.88922-1-boqun.feng@gmail.com>
References: <20210811153619.88922-1-boqun.feng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

In order to allow root bus creation to populate the ->private of the
pci_host_bridge at the same, pci_create_root_bus_priv() is introduced.
The new function will be used to support passing the corresponding ACPI
device as the ->private field when creating the PCI root bus.

No functional change.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 drivers/pci/probe.c | 15 ++++++++++++---
 include/linux/pci.h |  3 +++
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index ea7f2a57e2f5..8f5fea2a7bd9 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2991,13 +2991,14 @@ void __weak pcibios_remove_bus(struct pci_bus *bus)
 {
 }
 
-struct pci_bus *pci_create_root_bus(struct device *parent, int bus,
-		struct pci_ops *ops, void *sysdata, struct list_head *resources)
+struct pci_bus *pci_create_root_bus_priv(struct device *parent, int bus,
+		struct pci_ops *ops, void *sysdata, struct list_head *resources,
+		void *private, size_t priv_size)
 {
 	int error;
 	struct pci_host_bridge *bridge;
 
-	bridge = pci_alloc_host_bridge(0);
+	bridge = pci_alloc_host_bridge(priv_size);
 	if (!bridge)
 		return NULL;
 
@@ -3008,6 +3009,9 @@ struct pci_bus *pci_create_root_bus(struct device *parent, int bus,
 	bridge->busnr = bus;
 	bridge->ops = ops;
 
+	if (priv_size)
+		memcpy(bridge->private, private, priv_size);
+
 	error = pci_register_host_bridge(bridge);
 	if (error < 0)
 		goto err_out;
@@ -3018,6 +3022,11 @@ struct pci_bus *pci_create_root_bus(struct device *parent, int bus,
 	put_device(&bridge->dev);
 	return NULL;
 }
+struct pci_bus *pci_create_root_bus(struct device *parent, int bus,
+		struct pci_ops *ops, void *sysdata, struct list_head *resources)
+{
+	return pci_create_root_bus_priv(parent, bus, ops, sysdata, resources, NULL, 0);
+}
 EXPORT_SYMBOL_GPL(pci_create_root_bus);
 
 int pci_host_probe(struct pci_host_bridge *bridge)
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 01aa201e1df0..119356312979 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1041,6 +1041,9 @@ void pcibios_scan_specific_bus(int busn);
 struct pci_bus *pci_find_bus(int domain, int busnr);
 void pci_bus_add_devices(const struct pci_bus *bus);
 struct pci_bus *pci_scan_bus(int bus, struct pci_ops *ops, void *sysdata);
+struct pci_bus *pci_create_root_bus_priv(struct device *parent, int bus,
+		struct pci_ops *ops, void *sysdata, struct list_head *resources,
+		void *private, size_t priv_size);
 struct pci_bus *pci_create_root_bus(struct device *parent, int bus,
 				    struct pci_ops *ops, void *sysdata,
 				    struct list_head *resources);
-- 
2.32.0

