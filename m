Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 429CA3D063E
	for <lists+linux-hyperv@lfdr.de>; Wed, 21 Jul 2021 02:56:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbhGUAPJ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 20 Jul 2021 20:15:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbhGUAPI (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 20 Jul 2021 20:15:08 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64012C061574;
        Tue, 20 Jul 2021 17:55:45 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id l5so535983iok.7;
        Tue, 20 Jul 2021 17:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uBnvgqOzx7tQtgqIk0QrRjQar8YPI2MeErYJ3ki7qPQ=;
        b=Q7m8XBnObca48gwtM237ZSo2IwP2GEv6hrXZSoVGBtWC8DMgbmXvbSeeOuG3qcwa9n
         SbsMx+bcaGR5VgjzY0rUIBzEsswVDnjC+mvkXimaU5CSAmZ2BxvxPxtkfpVsnLHnP47l
         Smxv6x/M5F0SzrIzRSq8xaoqEN0p+e/V1szOd9DTwGXWkQo1TrUgGWuRwWOG0sB+5P4K
         Ff8ynVYJUel6Vk1Mu2h9GaaSJ4JY0ZTBdHYmJ07CQZH6vaWeZ+1D51WqDgWjPzU+JGyR
         kubuxGY8KQWQKeFN8Y1PG+djau/+bUDfvYFZ07VE1oIqOfFNV4ZpD4BklYWpI1uJGD3f
         ZwIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uBnvgqOzx7tQtgqIk0QrRjQar8YPI2MeErYJ3ki7qPQ=;
        b=THdomSXqIbQBVNrnXUEVKUSy8MkFZGufsEAdqV9PxMw3CJISPoHCRQFjbcxk1XQufp
         Xz/OZyIbkDv9MjEfF3RhkopnwOz1z/hI4ig1iL/tod/TSrVgXbmKxC/GOPtJVT2euH/K
         UUXZSyhFbdqJCsXFDgQPW/dLHhKPFgA/DQH9HCFweoujIe5wyZA8DvkQZLrXlX0qEmoP
         A7O19tRtGisBp30RHE9bFBkXC6FKMHah/BU8U8JWTBBWyk4WpKjZhl44pwSw+ZRJRg/F
         GiXfmT08dt0CGhtggdQPYiBVxikSXz/vmXuqfCmklI14loyCZB4NtC+PyAnto/82+xVh
         lBuQ==
X-Gm-Message-State: AOAM532XVIUMxielJpoND6oxFw4ibV5VeJ7nrFdevVfRAIZ4FRvD2UGH
        bFwHwJsxW5PfNLPvc0yzwO8=
X-Google-Smtp-Source: ABdhPJyOMU2sMtSLrrQfyMVmnSnqBfjNhEWCyXSauqo1/vuGsZPP8HmxSe+n+X/mYNDo72pG+b3LpA==
X-Received: by 2002:a02:620a:: with SMTP id d10mr29289532jac.22.1626828944668;
        Tue, 20 Jul 2021 17:55:44 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id l18sm11949992ioc.13.2021.07.20.17.55.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 17:55:44 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id 0901927C0054;
        Tue, 20 Jul 2021 20:55:42 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Tue, 20 Jul 2021 20:55:43 -0400
X-ME-Sender: <xms:jXD3YB10x0wJYMJHeujmPTXK_V75G2EGjOrGaTmVwYshNxjfCzqvaQ>
    <xme:jXD3YIGa8FueHoySJu47ggHzzHll5051-LLwpCshg8wufsnmdDxfcri4-yXlVp1ud
    pXGEwEcyP3zeDGm1A>
X-ME-Received: <xmr:jXD3YB4HjpRvzUJW6SXARHbqqfODQemHCwvUBKbZ9jPZyYdBdP13iLSgcp1X-Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrfeefgdefvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtth
    gvrhhnpeehvdevteefgfeiudettdefvedvvdelkeejueffffelgeeuhffhjeetkeeiueeu
    leenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsoh
    hquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedq
    udejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmh
    gvrdhnrghmvg
X-ME-Proxy: <xmx:jXD3YO1nabPuCNiQJGwlBGVIBB3Q37Pm3FXjbAzEZg4ABsdYosyZIQ>
    <xmx:jXD3YEHy_6f_EpY4ZZwig1WK0lNL84MtmPZzRR36VJr9XDeqPdGHtA>
    <xmx:jXD3YP8nc64NgMJlilBDBPNxG5HpQrSAQNkOGd7cqfKcH-iw9yRgAQ>
    <xmx:jnD3YC_ziFVnouzTn5uS8iYMhXekUaqoPc68kBrtUUpBjcK4Voa8YLbgIBo>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 Jul 2021 20:55:41 -0400 (EDT)
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
Subject: [RFC v5.1 1/8] PCI: Introduce domain_nr in pci_host_bridge
Date:   Wed, 21 Jul 2021 08:53:36 +0800
Message-Id: <20210721005336.517760-1-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <0210720134429.511541-2-boqun.feng@gmail.com>
References: <0210720134429.511541-2-boqun.feng@gmail.com>
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
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
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
index 540b377ca8f6..ba61f4e144aa 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -526,6 +526,15 @@ static inline int pci_channel_offline(struct pci_dev *pdev)
 	return (pdev->error_state != pci_channel_io_normal);
 }
 
+/*
+* Currently in ACPI spec, for each PCI host bridge, PCI Segment Group number is
+* limited to a 16-bit value, therefore (int)-1 is not a valid PCI domain number,
+* and can be used as a sentinel value indicating ->domain_nr is not set by the
+* driver (and CONFIG_PCI_DOMAINS_GENERIC=y archs will set it with
+* pci_bus_find_domain_nr()).
+*/
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

