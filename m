Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31E073A1AF5
	for <lists+linux-hyperv@lfdr.de>; Wed,  9 Jun 2021 18:32:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233905AbhFIQeZ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 9 Jun 2021 12:34:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233840AbhFIQeW (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 9 Jun 2021 12:34:22 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70141C061574;
        Wed,  9 Jun 2021 09:32:21 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id b14so8352080iow.13;
        Wed, 09 Jun 2021 09:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=42JnOdJokx7Och02Cf7RNqk0hUjrnHJDOmXKi7hmkA8=;
        b=qVgFnwbgVuXAbOztSYWDdMoeeu0L/eObqpS83NcZ3O06eQW1qMsIqueSHDcNCFi6EN
         cm2HGCjcGZ0ISxb78qDHCgs8Rr2dz9G0I2w6rC6S8iH9ue+bEKZInmQEkHrjiMM0XpKt
         ca8q98omXJxG0s5vEuGVGzKj5MGcXKN3KqiCRvcqjEoa+oUns9adsp/PcaxlmRdZT5+j
         74vABjFXwVzD841MI27xuKPLZMlXOESx96O/cwU6eYbX302LkSD3/1PgtBhFPNiULbfT
         XTjdExQDfwbK/7JpJgoGSTxOG3J0rof7qeevWC2qKwEaCpZrPQKUlVs341GIJ/oOa2i3
         GM3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=42JnOdJokx7Och02Cf7RNqk0hUjrnHJDOmXKi7hmkA8=;
        b=F1Q2AY5Hn1SrM/AQ0UZDsBldV9hTE4sDNa4Ra9naJC6uXL3Po530EK/wVDoxHqxH/R
         r8LEGfknrDR6/+iSr/5JA7udkksP6hzfN6oTJXSMHPQrnIgeJ36CT12YPZJ/+rrBL7ZL
         d5Aws8tOk+WFVwEOA5hGzk3+oB9UJaywD/Lb/xhUicioN5zFbcWp428IVPcfAjvQOUj5
         6Opp7ck1MZGBrRb6QxAUl6Kcg8QS9d1Pp7+Cm1Sxkj8wYbDttLyyPopNwl1gLW92craa
         v9LLrE7lmG9dHObXfh+Ua8kgDgClwnWCW9QjQrf77PjMynjTLL3DPJxyzA5tVBT21XKT
         peXQ==
X-Gm-Message-State: AOAM530Mgzyf9hdwuRBzIO9xrGxRr/SQ0DQ3xGInxedqMfZ5f1rWzrQd
        MvxvtjV+/0qhf6OUY6xM/KQ=
X-Google-Smtp-Source: ABdhPJxcqj+WXs35mm8AkaAEN9mW9wi2tCnnEiv6kQtMaPkhaByp9p8TEuHPogLCtJsdOOJ4C8aL1Q==
X-Received: by 2002:a05:6638:2202:: with SMTP id l2mr485439jas.98.1623256340420;
        Wed, 09 Jun 2021 09:32:20 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id w11sm255942ilv.14.2021.06.09.09.32.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jun 2021 09:32:20 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailauth.nyi.internal (Postfix) with ESMTP id E22C827C005B;
        Wed,  9 Jun 2021 12:32:18 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 09 Jun 2021 12:32:18 -0400
X-ME-Sender: <xms:Eu3AYJY-SKimUobzPE-v2ahMh2ckPnLveaOKLu7Yu-Jgyh50csgMLQ>
    <xme:Eu3AYAaGO52op0zsU291eweRLzLLfGnoCgVBpsri52QNO0n69T7y9U0HYlQGAa03A
    RQCThFRfXVZFZFVtg>
X-ME-Received: <xmr:Eu3AYL_MqSVKEnWqmpVUKQBhixxhnNzWyl3tTUHG-TZRtLAZOzpmp3aVIVs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfeduuddguddtvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeehvdevteefgfeiudettdefvedvvdelkeejueffffelgeeuhffhjeetkeei
    ueeuleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdei
    gedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfih
    igmhgvrdhnrghmvg
X-ME-Proxy: <xmx:Eu3AYHozNz6x2zVNqNrV85JELCINKBjYUwRuE-U1cIidf6epF77h2g>
    <xmx:Eu3AYEpLfJI-DAUxFv8aG2yCaF6vOMLFx-rImqGFQGoTEVSLMQhJTQ>
    <xmx:Eu3AYNQmrx9nXacaJVcvvLZ2Lm6ymTGkp9iEA05p5B0nTjdW5WmMFQ>
    <xmx:Eu3AYAbggQRiQ2tF0YyEZi7r3VNUUq2w4NlWpx1PMJ3JefJ5-9hYv-TXqFY>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Jun 2021 12:32:17 -0400 (EDT)
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
Subject: [RFC v3 1/7] PCI: Introduce domain_nr in pci_host_bridge
Date:   Thu, 10 Jun 2021 00:32:05 +0800
Message-Id: <20210609163211.3467449-2-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210609163211.3467449-1-boqun.feng@gmail.com>
References: <20210609163211.3467449-1-boqun.feng@gmail.com>
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
 drivers/pci/probe.c |  4 +++-
 include/linux/pci.h | 10 ++++++++++
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 275204646c68..d2753097a1b0 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -594,6 +594,7 @@ static void pci_init_host_bridge(struct pci_host_bridge *bridge)
 	bridge->native_pme = 1;
 	bridge->native_ltr = 1;
 	bridge->native_dpc = 1;
+	bridge->domain_nr = PCI_DOMAIN_NR_NOT_SET;
 
 	device_initialize(&bridge->dev);
 }
@@ -898,7 +899,8 @@ static int pci_register_host_bridge(struct pci_host_bridge *bridge)
 	bus->ops = bridge->ops;
 	bus->number = bus->busn_res.start = bridge->busnr;
 #ifdef CONFIG_PCI_DOMAINS_GENERIC
-	bus->domain_nr = pci_bus_find_domain_nr(bus, parent);
+	if (bridge->domain_nr == PCI_DOMAIN_NR_NOT_SET)
+		bus->domain_nr = pci_bus_find_domain_nr(bus, parent);
 #endif
 
 	b = pci_find_bus(pci_domain_nr(bus), bridge->busnr);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 24306504226a..d85d41b5abbd 100644
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

