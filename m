Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBED13C82DB
	for <lists+linux-hyperv@lfdr.de>; Wed, 14 Jul 2021 12:29:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239073AbhGNKcY (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 14 Jul 2021 06:32:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238955AbhGNKcX (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 14 Jul 2021 06:32:23 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D5C9C06175F;
        Wed, 14 Jul 2021 03:29:32 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id i4so730045qvq.10;
        Wed, 14 Jul 2021 03:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/fGg5V2/WWvYjmH/4IzypywJVMzS/+h8ThxfSKBSBo8=;
        b=Hyq4B0JgGtK+cTEItZ+JcSJ0feILF5MgKLiVDQZ8elGKtLXwDKDxW43XvOgh3C9KkE
         dERgA/jTfjPE7MlSrMFGe+HJaJpzGDnIrk9QVTcmI3y5eRH0h0e+HaYXvqx3E+Ed478V
         WaRolC1SwVIYaC18pVa71Nrb1ZJpWY0fFmIvBT7O5hyTbf13w8sB07I0DZqM2pUTkBzX
         8/OdDSc3f/AyTZdxXReS8tEPfUxoau2CB8GA2oL36J0bK8gIAac24+cOYA0Vb0/ZS7YN
         +m102LtTxcwXNpSuCLwBD5GqAMqOuZomFv5cndpV7gedEXPGVRkpCdzWgmWz6EhF5bD+
         469Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/fGg5V2/WWvYjmH/4IzypywJVMzS/+h8ThxfSKBSBo8=;
        b=Mh/pWr5Q695qxSVp74FuW1sFEhXLztKeVxuEKcCZJ5Z2w+49difg6nZSoVTbWwK1Ni
         /Y/vs2de2iNKRTHgonOwE3lS/CXyWLNRcyjkXcFZiWPGLE7F5IPtn/hCh2uKetnjuZ3y
         imUBtwereG5KguprbCluyPOhfkiyTnkzLRyEF8+0SSTk5uBsU7ojaiB8xEhX85e+cUUw
         3+lYYjbZHHMfARUhgWPNKhiH5ubAeIr0au9anTqx95b4gmgnzW/nZ6FvI8BIUktPvD+p
         w8EnFuFQl/EmRRKw/Jg67c8AFG4KdGfD/obvFSh2VmhaW7qd0LygWuow2d3Zz4wjHymb
         JAQA==
X-Gm-Message-State: AOAM533fkYyxEbVIfeRk+BWE0EckmmkJbGEpNbI8iRToearigG/kB43M
        HmIMC+GyV5ZQ8YpfbKp36+E=
X-Google-Smtp-Source: ABdhPJwGLribwp3KISABcdJ6bLGA2MLluBizBxgco0MDkPJpZOt5oKA++XJ1aB5cHAg8VEMmFtsXxw==
X-Received: by 2002:a05:6214:20ac:: with SMTP id 12mr9888649qvd.7.1626258571341;
        Wed, 14 Jul 2021 03:29:31 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id bm42sm815350qkb.97.2021.07.14.03.29.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 03:29:30 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id E187E27C0054;
        Wed, 14 Jul 2021 06:29:29 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Wed, 14 Jul 2021 06:29:29 -0400
X-ME-Sender: <xms:iLzuYOMyAGoTdyOFnXUrbKiK83z30fmG1a94PjR4AKI_lgOjBN1G6w>
    <xme:iLzuYM-4B1tc49wKyMSMYmukN7L1QP7ZFIkwhznVYfpNVNVFWad1ZbT_8RR1Szin9
    PwbhTtKokeUSA0CjA>
X-ME-Received: <xmr:iLzuYFQCiIp9L_G92aRKibDqDEgDhakDmO6t5unAInGPDhnSqV5qQi86GKy0gw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudekgddvkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtth
    gvrhhnpeehvdevteefgfeiudettdefvedvvdelkeejueffffelgeeuhffhjeetkeeiueeu
    leenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsoh
    hquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedq
    udejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmh
    gvrdhnrghmvg
X-ME-Proxy: <xmx:iLzuYOvhU3AcGMGukLAP92YP0QlRElO8SEfHQIawIuES1CrjYuvq8w>
    <xmx:iLzuYGcXmHuG-5M8sRQ2MwqFrt-S2MsID4jah-vSKEegu46N4dpt0w>
    <xmx:iLzuYC0do6qfB-l0Bx1TBpPbUIDmvnJWWbTXnb8-qmbO0aK_Q3V4rQ>
    <xmx:ibzuYJUcD35pGNhsrhj-a3-bpXTYyGcxMkfSiuJ7W5LdpNN_xDlBteuULC8>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 Jul 2021 06:29:28 -0400 (EDT)
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>,
        Marc Zyngier <maz@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Mike Rapoport <rppt@kernel.org>
Subject: [RFC v4 1/7] PCI: Introduce domain_nr in pci_host_bridge
Date:   Wed, 14 Jul 2021 18:27:31 +0800
Message-Id: <20210714102737.198432-2-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210714102737.198432-1-boqun.feng@gmail.com>
References: <20210714102737.198432-1-boqun.feng@gmail.com>
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
host bridge of Hyper-V doesn't have pci_config_window, whereas ARM64 is
a PCI_DOMAINS_GENERIC=y arch, so we cannot retrieve the PCI domain
number from pci_config_window on ARM64 Hyper-V guest.

As the preparation for ARM64 Hyper-V PCI support, we introduce the
domain_nr in pci_host_bridge and a sentinel value to allow drivers to
set domain numbers properly at probing time. Currently
CONFIG_PCI_DOMAINS_GENERIC=y archs are only users of this
newly-introduced field.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 drivers/pci/probe.c |  6 +++++-
 include/linux/pci.h | 10 ++++++++++
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 79177ac37880..60c50d4f156f 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -594,6 +594,7 @@ static void pci_init_host_bridge(struct pci_host_bridge *bridge)
 	bridge->native_pme = 1;
 	bridge->native_ltr = 1;
 	bridge->native_dpc = 1;
+	bridge->domain_nr = PCI_DOMAIN_NR_NOT_SET;
 
 	device_initialize(&bridge->dev);
 }
@@ -898,7 +899,10 @@ static int pci_register_host_bridge(struct pci_host_bridge *bridge)
 	bus->ops = bridge->ops;
 	bus->number = bus->busn_res.start = bridge->busnr;
 #ifdef CONFIG_PCI_DOMAINS_GENERIC
-	bus->domain_nr = pci_bus_find_domain_nr(bus, parent);
+	if (bridge->domain_nr == PCI_DOMAIN_NR_NOT_SET)
+		bus->domain_nr = pci_bus_find_domain_nr(bus, parent);
+	else
+		bus->domain_nr = bridge->domain_nr;
 #endif
 
 	b = pci_find_bus(pci_domain_nr(bus), bridge->busnr);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 540b377ca8f6..952bb7d46576 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -526,6 +526,15 @@ static inline int pci_channel_offline(struct pci_dev *pdev)
 	return (pdev->error_state != pci_channel_io_normal);
 }
 
+/*
+ * PCI Conventional has at most 256 PCI bus segments and PCI Express has at
+ * most 65536 "PCI Segments Groups", therefore -1 is not a valid PCI domain
+ * number, and can be used as a sentinel value indicating ->domain_nr is not
+ * set by the driver (and CONFIG_PCI_DOMAINS_GENERIC=y can set it in generic
+ * code).
+ */
+#define PCI_DOMAIN_NR_NOT_SET (-1)
+
 struct pci_host_bridge {
 	struct device	dev;
 	struct pci_bus	*bus;		/* Root bus */
@@ -533,6 +542,7 @@ struct pci_host_bridge {
 	struct pci_ops	*child_ops;
 	void		*sysdata;
 	int		busnr;
+	int		domain_nr;
 	struct list_head windows;	/* resource_entry */
 	struct list_head dma_ranges;	/* dma ranges resource list */
 	u8 (*swizzle_irq)(struct pci_dev *, u8 *); /* Platform IRQ swizzler */
-- 
2.30.2

