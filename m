Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0B3A3D6661
	for <lists+linux-hyperv@lfdr.de>; Mon, 26 Jul 2021 20:07:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232200AbhGZR05 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 26 Jul 2021 13:26:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231248AbhGZR04 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 26 Jul 2021 13:26:56 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36630C061765;
        Mon, 26 Jul 2021 11:07:24 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id m13so12963906iol.7;
        Mon, 26 Jul 2021 11:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/DAVMzxy/IYYUDYXRGPCeffz2GlNoI3MdFX4pa4Idb0=;
        b=ZZtSRtShVMZU3pPl9LYsw8iPqe5Y8FA+qIAFWyEkzo4dsU5i5n12K3ADJzrwUk7usd
         BJCbDfq7dIBnBZKZLWPcQ7e2zYtUEBka/210mx2H4yr6hADX1EUX/o7aTTqbAafQdiBc
         sPx/+nVxgOXmafoguWHhrgaQw9lRZF/ot4iphNvqFTKhf318aLD0MAevIBEauMyQGzY1
         Z1o9vmFgbH10wRUyGtTyZHLnOhcAWwAxHv5PWOEX6KpcMbTyzJeWIIOvBg7/NQS+7Q7R
         W+5AWlKOLprHYkYSj5e+FEzurg1qxpPjGdAgqUioXKXxK5buXi/toyplIhMYYNCgRS1f
         Logw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/DAVMzxy/IYYUDYXRGPCeffz2GlNoI3MdFX4pa4Idb0=;
        b=Flg7RZG5gxcv/YZPm/Fiapmu3OhGcsbAs+yqeaoirK/HlcoAm7v6TPuSiQgr5klSFX
         mBwjYXfE/x0zPfrcSGEZkah2rwk4wCCn1jCxZNKP4vYC20iZ+Z3sDqE3pq8fVgsS+pdZ
         BQf5t+IPghymZM/67eGSjjomggc7yhjH+UQBslYgmYRZM3S0OhELaKNMpJ1w5lZSh2Or
         h7V+GHsJHl6gELIkwNYbcE/nugECrr+0QQc1WCMffOWyCOQzzwVqfi901is7iewykkTh
         Y7vch18T9/Hf7Sv84N+V9kZSdue/4yxR5rZ0WIaHR5aibHWX8+1thYsgc3EyG9gfH4ZG
         3Yaw==
X-Gm-Message-State: AOAM532oj+mUOJTkl59v6uinp0aYb9UeCVUSqgu0WhVkLjcU9CaieU6Q
        zKtxDtKt5Xlfkg4CFt53ev0GcMXjGI5fPg==
X-Google-Smtp-Source: ABdhPJykjvEtW5pdvBTUspPqr67gxXVkkltMchn8/roCkdSLBULK21lTnVQg4wJ1D74TzKu1x3cQZw==
X-Received: by 2002:a6b:db18:: with SMTP id t24mr16003319ioc.163.1627322843651;
        Mon, 26 Jul 2021 11:07:23 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id s21sm336994iot.33.2021.07.26.11.07.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 11:07:23 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id 266A327C0068;
        Mon, 26 Jul 2021 14:07:22 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 26 Jul 2021 14:07:22 -0400
X-ME-Sender: <xms:2fn-YDCvbnkAGp4r4dTpqO5JpuRNTa_omU6_-zNwUa-KyTANOZYyEA>
    <xme:2fn-YJjTu434kRciLnD3gqBNb9Rax2ln9LU-NKWoteD-hwxB06ffo3_NFLijTwp-b
    M2GfzSDeLLz3BXlZA>
X-ME-Received: <xmr:2fn-YOn_k_DaQb8UVmpO52nuEoG1_cbbQWFzrreF6-YXf2jHluqQ24BgiM8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrgeehgdduudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhephedvveetfefgiedutedtfeevvddvleekjeeuffffleeguefhhfejteekieeu
    ueelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsg
    hoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieeg
    qddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigi
    hmvgdrnhgrmhgv
X-ME-Proxy: <xmx:2fn-YFy4nqTooVNGng8p_yfeqPzzMAMZey0lFnhu4vMjKTl2seTrdg>
    <xmx:2fn-YITrSqoBo9p5inyx6EUbwOYsAAymYGKoi9NHrqcvdBHvA1oMpw>
    <xmx:2fn-YIZ7FegVjSSm9HKMk1gE3cym4VgCFJ3NF2TRTBi8q8oThYAJ0g>
    <xmx:2vn-YJKge7WpGDVps6F2NNRn8KN_gfLChaxuRdEd4kDjzApTOQT4z8zvafM>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 Jul 2021 14:07:21 -0400 (EDT)
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>,
        Marc Zyngier <maz@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Mike Rapoport <rppt@kernel.org>
Subject: [PATCH v6 1/8] PCI: Introduce domain_nr in pci_host_bridge
Date:   Tue, 27 Jul 2021 02:06:50 +0800
Message-Id: <20210726180657.142727-2-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210726180657.142727-1-boqun.feng@gmail.com>
References: <20210726180657.142727-1-boqun.feng@gmail.com>
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
 include/linux/pci.h | 11 +++++++++++
 2 files changed, 16 insertions(+), 1 deletion(-)

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
index 540b377ca8f6..01aa201e1df0 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -526,6 +526,16 @@ static inline int pci_channel_offline(struct pci_dev *pdev)
 	return (pdev->error_state != pci_channel_io_normal);
 }
 
+/*
+ * Currently in ACPI spec, for each PCI host bridge, PCI Segment
+ * Group number is limited to a 16-bit value, therefore (int)-1 is
+ * not a valid PCI domain number, and can be used as a sentinel
+ * value indicating ->domain_nr is not set by the driver (and
+ * CONFIG_PCI_DOMAINS_GENERIC=y archs will set it with
+ * pci_bus_find_domain_nr()).
+ */
+#define PCI_DOMAIN_NR_NOT_SET (-1)
+
 struct pci_host_bridge {
 	struct device	dev;
 	struct pci_bus	*bus;		/* Root bus */
@@ -533,6 +543,7 @@ struct pci_host_bridge {
 	struct pci_ops	*child_ops;
 	void		*sysdata;
 	int		busnr;
+	int		domain_nr;
 	struct list_head windows;	/* resource_entry */
 	struct list_head dma_ranges;	/* dma ranges resource list */
 	u8 (*swizzle_irq)(struct pci_dev *, u8 *); /* Platform IRQ swizzler */
-- 
2.32.0

