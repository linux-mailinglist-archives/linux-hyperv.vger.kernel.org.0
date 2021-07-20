Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B83A3CFB48
	for <lists+linux-hyperv@lfdr.de>; Tue, 20 Jul 2021 15:53:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239028AbhGTNNF (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 20 Jul 2021 09:13:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238998AbhGTNGf (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 20 Jul 2021 09:06:35 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E421C061762;
        Tue, 20 Jul 2021 06:46:31 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id s5so12168739ild.5;
        Tue, 20 Jul 2021 06:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pwmv0O8lOsgWW/flC9kaMbPuEr0P62is7sO0/K/VTeo=;
        b=s8Z/moUNgaDkmZ6n82NKaBiSKW8KE8WjOCzY8qzna/rJ9X94+gI5ySxVsZcJI3hN7F
         u1b3Q3sJ4dI/NXlCQ6RJVHmIciRatKOxeWnHdbyuj+ZVAdYNgEo87XVRDj3G2CDmodqA
         UhaIFZyFAYtoLb7L0lKAm7OSYzF9CGMrmZ5KoZbzSXMBE6a/1XkP3/31WGO4n3c7hvkn
         s28YaOTCSbaD2vlCmzKpMbVnCoAVRaDiUfNxdbfH01MoVCq2wJEifL2LQbfs8X6X1cOO
         bG9QM90vpWIGLwYgakHsCDz+cNptg3v6a3hTzFOuX2XWjJxFuYXeO7NbGTKfXqf3guk0
         FnWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pwmv0O8lOsgWW/flC9kaMbPuEr0P62is7sO0/K/VTeo=;
        b=oz7J29LQvBmn/HV/gJ3cQimeZd6uze5LJpVAeHsTX8kWG6T9XaUs4ktrlF0WGUYsZZ
         sVcTqglFYEXnZHYRbx6APxv5FA+5FAULkt4F24OHJ8A/AhZUnnv+p+RTB5+ZwaJEb709
         eCaVYJN8C3cfYZC0i5UDG1TJpks/gzWyLPV6H3WYHf2bHRKIRW9uA4e0J4dSe5ApAkG/
         cOGM7ElsqGWA4xhuK/CiofAinKdE+eygRIbEXFLxS49WvCmI+WQQiW6fi0RKivA4bYHr
         2w+fdOodqxzkEKHiEtKL1ujrjEWzq5K3LRbATqIbihvPwdbSOfrtN9VdezfZYLMT5W8D
         TUfw==
X-Gm-Message-State: AOAM530RwGB5KtVLY596VZXijX90OSg7f+Bc0oFF6OiwrMu1zg6tQU3a
        9V6+Qe26khuetzrRIXpJRvE=
X-Google-Smtp-Source: ABdhPJyJ4d9z0IYkxozKBochgBSkt6cYHQ9pFlJt9HNMRyPjs1gPxEVoo3zh/8IJ78KsLGtnzuQkbA==
X-Received: by 2002:a92:3302:: with SMTP id a2mr20961978ilf.62.1626788791000;
        Tue, 20 Jul 2021 06:46:31 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id o12sm11540852ilg.10.2021.07.20.06.46.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 06:46:30 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id B846127C005A;
        Tue, 20 Jul 2021 09:46:29 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Tue, 20 Jul 2021 09:46:29 -0400
X-ME-Sender: <xms:tdP2YOREcMgJAmsen1zmw3aI-Ex8lmrfDNs-vyUcNwQmb3tLUiqBxg>
    <xme:tdP2YDxJ2LfZKPerY2dbE9veoUuLZE1llA7SrqX1UbJS6QhrBIs0dvwxW4E7II6Gr
    nmw9X5eQauCA3vJOQ>
X-ME-Received: <xmr:tdP2YL1ukxsk3Fb4-nwxRR8vbRWAQ0TG0heccl_V81pRMXpMgN5SVn20mz0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrfedvgdeikecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtth
    gvrhhnpeehvdevteefgfeiudettdefvedvvdelkeejueffffelgeeuhffhjeetkeeiueeu
    leenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsoh
    hquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedq
    udejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmh
    gvrdhnrghmvg
X-ME-Proxy: <xmx:tdP2YKBgY3TuS08zJ240SDZ3dS63WjFv1U3HvE4jNNlZBQQ2QsIcIg>
    <xmx:tdP2YHio4-bGYGocfG-8JnuvmR4wbSKA6cR0DLRkT0OiUXRGh5d_Zw>
    <xmx:tdP2YGon0bffPLZpmPbCHIPnejPTFTGEVYIJVgd6Cbp5OrGOAgGIdA>
    <xmx:tdP2YAZNJFI2oVs487QkfrFlKhR-4ST5nfQp9UWXNQYGRcjDlaIa5aUXMbc>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 Jul 2021 09:46:29 -0400 (EDT)
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
Subject: [RFC v5 1/8] PCI: Introduce domain_nr in pci_host_bridge
Date:   Tue, 20 Jul 2021 21:44:22 +0800
Message-Id: <20210720134429.511541-2-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210720134429.511541-1-boqun.feng@gmail.com>
References: <20210720134429.511541-1-boqun.feng@gmail.com>
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
index 540b377ca8f6..2c413a64d168 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -526,6 +526,15 @@ static inline int pci_channel_offline(struct pci_dev *pdev)
 	return (pdev->error_state != pci_channel_io_normal);
 }
 
+/*
+* Currently in ACPI spec, for each PCI host bridge, PCI Segment Group number is
+* limited to a 16-bit value, therefore (int)-1 is not a valid PCI domain number,
+* and can be used as a sentinel value indicating >domain_nr is not set by the
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

