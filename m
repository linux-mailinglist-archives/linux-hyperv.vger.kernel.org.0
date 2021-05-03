Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BEE43716FE
	for <lists+linux-hyperv@lfdr.de>; Mon,  3 May 2021 16:48:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbhECOsv (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 3 May 2021 10:48:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbhECOsp (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 3 May 2021 10:48:45 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FADCC06174A;
        Mon,  3 May 2021 07:47:52 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id 197so4943787qkl.12;
        Mon, 03 May 2021 07:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=09mjDqOchQ3sXLyBszDvLfbZqoTTMTmDKqqwf4ikQZc=;
        b=pmMsJxnVey9c4E53pvhRKlEYMcqliE6+RrOBshRD/M+ZTyjc9fmHmwm3wnJBOjHAVJ
         IoxAfwILIF79HKEN8ZOeXsjhpImJXJx9xAvNnbGNIdv5Nq2kN0ADIg4bGzHlh3+gZ+Tx
         T9CCEtfurLhqW9KOJi1N6hSgscu43eSoJP79Pn2aNmHU9GF18BFDSSPrLPdyt6+ix51l
         YHpIvMj8z0WuXZ/QS2tn/T3KIqlSySHLDlYmahJHqw8RF9mIpUdNF/sCvCNL6tuHqYCQ
         n3seNl+bmEIbXff96WBJCTnIYErxDfKUPQUJD3nLd9mp+sDlNzMoguHdj1ZN9v5wmSrL
         CheA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=09mjDqOchQ3sXLyBszDvLfbZqoTTMTmDKqqwf4ikQZc=;
        b=MSp22esGPYinSuGwYa/scIwbVK43kPGI/ljfrbyP53ivgP6R7Djqs3WzniklLNjJwP
         O89upGna4XvREb5Q6+oMTzC0XtA0ZzuvbDwEIMOJqdmXekhp1cG2UV1Y35jRX4ZZ2kv8
         m74cx6oNJsFNjEzVAK7LNYp27MXUHdM8m0FfnVzHRqFrGQHhs7kAYRJ6pUtYjVUAvdld
         aL8J+S2KZ5e8v4LIcNtA+pPcYbDalWKAbP2dTiZtYtPcMLRj7ctEaWvWedwNGj9l3pEi
         f9dQOIr6xKxP6Dmt5w2I9jolzZBaq4u0d4LiumLVY5JPDQ9yOoCdAbCGzrCd/28bl8Go
         1idA==
X-Gm-Message-State: AOAM530FGbKU/u3h7sF0xL6i9GOpHkXmpPB9Oj1mD77wlFZFA3jiy6ci
        LufB3t/Ijpawqz5Ogc/cfjM=
X-Google-Smtp-Source: ABdhPJwHMaknaOV1erqRimblxefA4bDS+Fyjtw1hIZw24oH0fma3iXqpy4sVMOm+4vJaCAJAJZ0QQw==
X-Received: by 2002:a37:8084:: with SMTP id b126mr19407096qkd.175.1620053271518;
        Mon, 03 May 2021 07:47:51 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id a10sm4472qtm.16.2021.05.03.07.47.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 May 2021 07:47:51 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailauth.nyi.internal (Postfix) with ESMTP id 3989B27C005A;
        Mon,  3 May 2021 10:47:50 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 03 May 2021 10:47:50 -0400
X-ME-Sender: <xms:Fg2QYNbNJDnOZ716HMZsATda9-bDg24qjFh1m5ow4pMHKJ5JkYTkAg>
    <xme:Fg2QYEYE2AJWR-Eu8y__g2W2eiyqoGYCzLR2d9BePDVxKZeMvEn_No_LyJ4rDuz7y
    e_JMarhc8GRzTQHzA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdefgedgkedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhephedvveetfefgiedutedtfeevvddvleekjeeuffffleeguefhhfejteekieeu
    ueelnecukfhppedufedurddutdejrddurddvheegnecuvehluhhsthgvrhfuihiivgepud
    enucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgv
    rhhsohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfh
    gvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:Fg2QYP8NueX2Ri-1sniuK2SMR24usJ4-7I-QMNKafe1pFK4rgFwo8w>
    <xmx:Fg2QYLp7VWBHJjTwBi9ekvXCqV6L_XIDGcDtOamjuJoX--9rFUepeg>
    <xmx:Fg2QYIqOSmnwoBDnQR7x_2ACYRGvI4l_3Y5pnDnidXFarNZdiRbsiA>
    <xmx:Fg2QYKhmT7aGpuRxJounbMDBHj3g6-krzp5XSpccz-gcx_DNLm7uPcMoSBRWIuiM>
Received: from localhost (unknown [131.107.1.254])
        by mail.messagingengine.com (Postfix) with ESMTPA;
        Mon,  3 May 2021 10:47:49 -0400 (EDT)
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
Subject: [RFC v2 6/7] PCI: arm64: Allow pci_config_window::parent to be NULL
Date:   Mon,  3 May 2021 22:46:34 +0800
Message-Id: <20210503144635.2297386-7-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210503144635.2297386-1-boqun.feng@gmail.com>
References: <20210503144635.2297386-1-boqun.feng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

This is purely a hack, for ARM64 Hyper-V guest, there is no
corresponding ACPI device for the root bridge, so the best we can
provide is an all-zeroed pci_config_window, and in this case make
pcibios_root_bridge_prepare() act as the ACPI device is NULL.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 arch/arm64/kernel/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/pci.c b/arch/arm64/kernel/pci.c
index e9a6eeb6a694..f159df903ccb 100644
--- a/arch/arm64/kernel/pci.c
+++ b/arch/arm64/kernel/pci.c
@@ -83,7 +83,7 @@ int pcibios_root_bridge_prepare(struct pci_host_bridge *bridge)
 {
 	if (!acpi_disabled) {
 		struct pci_config_window *cfg = bridge->bus->sysdata;
-		struct acpi_device *adev = to_acpi_device(cfg->parent);
+		struct acpi_device *adev = cfg->parent ? to_acpi_device(cfg->parent) : NULL;
 		struct device *bus_dev = &bridge->bus->dev;
 
 		ACPI_COMPANION_SET(&bridge->dev, adev);
-- 
2.30.2

