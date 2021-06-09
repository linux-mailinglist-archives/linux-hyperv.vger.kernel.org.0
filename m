Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 865583A1AF9
	for <lists+linux-hyperv@lfdr.de>; Wed,  9 Jun 2021 18:32:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234249AbhFIQed (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 9 Jun 2021 12:34:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234202AbhFIQec (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 9 Jun 2021 12:34:32 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EA01C061760;
        Wed,  9 Jun 2021 09:32:27 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id j26so17064558ila.4;
        Wed, 09 Jun 2021 09:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ejFMapilAMOPPgo65R0NoskzTqCmBJQGTttVyFEof2s=;
        b=msxBvyiJQsbZYn9NVGTvjMwaHc6gfCHlPxwqAAetEsFg3aT1qqdvBeUI8ZS1GSyVOr
         fb3UQ0BD56z/9dZTq3kf8skbvHbiNXPtj76RLdJzgQbvf/qJ3b6GYZnYP9MOuHqTg98W
         +kOo1FVGNr+bo21YZYzwXMvunLzJGGoQ9AnJWHgl6YluBQ2ZAa8m6t4QcXSy8K70uzMN
         qKHmXEI+EWLi79TOw1zNhk1GxbWsKvUzqxt9DP3JFkRwgoppbKOwmm2otClEynJ+Mg3p
         Mdb4EzuQXRnr19TlALueNSBx20UNJNDryBSAZF2JYMl8oVhaJvbkvjl4inyKSAgPPlQZ
         rCiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ejFMapilAMOPPgo65R0NoskzTqCmBJQGTttVyFEof2s=;
        b=aDx0d+dwuXI4eh9H1Nq6nvl3jz+ovRHAOCmYkD2ZagrDUlMNJSoJ3dEWlzVIU/xqYu
         DM9Of3Nu1iI26cIki5A3+G8Zb95gQF8QROrosykfq7Zbm0neooZtre+6maFvgt0UOZob
         8/gqUkXOhn3cIYcU67wh/VYUO0PEAMrah2xce4U81Q5xJvcdqPNfBqKj9Sz0yQ/Nh0zq
         EdcHLJ6ObAYRFXzN2EkocXzWU+anRjbA+dwGNf1BgBmRqBPJYyMNNffut0BDTb+H9k8H
         goalOo7oWgs9aNCqmBUZuJ0NZ0wtIna2tPZlaX4PA9YKHWfBq8FmxivrVB/IRaNzI00K
         WBAA==
X-Gm-Message-State: AOAM533DSUHmEeovNpsyeBb5gUOCUZBJPZSkbpQhG3fpO+WSw0AMNjaw
        T9p0wZ9BIKt40rkh+Mc9HH0=
X-Google-Smtp-Source: ABdhPJyGfS687wl4KOUdiCz4Zzh820mpkXMSIFgCcRgiZpXFua5L069oVO9LWHjCOlyNwF69yurATw==
X-Received: by 2002:a05:6e02:b43:: with SMTP id f3mr439896ilu.22.1623256346695;
        Wed, 09 Jun 2021 09:32:26 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id i13sm262519ilr.16.2021.06.09.09.32.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jun 2021 09:32:26 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id 524A327C005B;
        Wed,  9 Jun 2021 12:32:25 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Wed, 09 Jun 2021 12:32:25 -0400
X-ME-Sender: <xms:GO3AYGDm3INFlRCiI83_K99y8sKEE6gi0aG6DXm-N9f5p6da_3Jmog>
    <xme:GO3AYAhzfoT1t-cZe096aVxq6W_To8PyJzr4t9-A7uGdtTpVTgVQ1N786yTV3cPyY
    Y-q4wn75vIkyKgRGg>
X-ME-Received: <xmr:GO3AYJmC8PcS3l_DCeQ4rFJdSSuZct9s_4EK9m8sN2wLILnkO0tkPp5pHmA>
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
X-ME-Proxy: <xmx:GO3AYEx9rP6Sp2ikvXBbIdbW-rAauqz-yRhhUkb9DQN8Kw97pP9D6A>
    <xmx:GO3AYLRlVw6berf7skW6RTIpLbhdktbTni8suXCqgBMQIBTeZWVVGw>
    <xmx:GO3AYPahbPscEt8oY19nfckwWrRizVfZgNn8ycaZIqRZsVpvGPxnNQ>
    <xmx:Ge3AYMj_0QMAffADY3pwxG7HwaCLeu2xkBp6C80nZBbVszifGFea5eKNpbA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Jun 2021 12:32:24 -0400 (EDT)
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
Subject: [RFC v3 6/7] arm64: PCI: Support root bridge preparation for Hyper-V PCI
Date:   Thu, 10 Jun 2021 00:32:10 +0800
Message-Id: <20210609163211.3467449-7-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210609163211.3467449-1-boqun.feng@gmail.com>
References: <20210609163211.3467449-1-boqun.feng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Currently at root bridge preparation, the corresponding ACPI device will
be set as the companion, however for a Hyper-V virtual PCI root bridge,
there is no corresponding ACPI device, because a Hyper-V virtual PCI
root bridge is discovered via VMBus rather than ACPI table. In order to
support this, we need to make pcibios_root_bridge_prepare() work with
cfg->parent being NULL.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 arch/arm64/kernel/pci.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/pci.c b/arch/arm64/kernel/pci.c
index 1006ed2d7c60..020bc268bf06 100644
--- a/arch/arm64/kernel/pci.c
+++ b/arch/arm64/kernel/pci.c
@@ -84,7 +84,12 @@ int pcibios_root_bridge_prepare(struct pci_host_bridge *bridge)
 {
 	if (!acpi_disabled) {
 		struct pci_config_window *cfg = bridge->bus->sysdata;
-		struct acpi_device *adev = to_acpi_device(cfg->parent);
+		/*
+		 * On Hyper-V, there is no corresponding APCI device for a root
+		 * bridge, therefore ->parent is set as NULL by the driver. Then
+		 * 'adev' should be NULL in this case.
+		 */
+		struct acpi_device *adev = cfg->parent ? to_acpi_device(cfg->parent) : NULL;
 		struct device *bus_dev = &bridge->bus->dev;
 
 		ACPI_COMPANION_SET(&bridge->dev, adev);
-- 
2.30.2

