Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC09B3C82E0
	for <lists+linux-hyperv@lfdr.de>; Wed, 14 Jul 2021 12:29:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239138AbhGNKca (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 14 Jul 2021 06:32:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239125AbhGNKc1 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 14 Jul 2021 06:32:27 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D095C06175F;
        Wed, 14 Jul 2021 03:29:34 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id q190so1064576qkd.2;
        Wed, 14 Jul 2021 03:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UqyjVkUAYqc1/eTZgMpv0x/hxXPbVT++JlxQ92tBr34=;
        b=ZWCWXgx+7dmwPo4OlU5Ycf+vT61FlzINIrjFmXQr0H6HE38bQViGgQMvkSnwCSkCxK
         XrBkc5ntyVpVgEvkSucJspEpUI1HNIV0K9srHT6dVYMYGeaSWg7jqxwBMNWP/vqHGW/T
         zAxyCxL5q9atJ2pGMWnDHZDJbxK+6/TOTTqKJExuGcSkf6jpy//pkQAibuIXJu6h/m4s
         +MrIWJu6Iw5HjxXfuYO4tCyzX3Jd3G1G+VSwrmVum2FtpXsOGSkHGqBj2ilpkTg17Imd
         atyXH8NRoDYKfsY/zdVpPG4G3fD+tbB1/PQSTsrq5f7bBM/Sncs1KQkL/tSyeCkTSqd3
         zPVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UqyjVkUAYqc1/eTZgMpv0x/hxXPbVT++JlxQ92tBr34=;
        b=OEak4GCoB2k1Hqdzk44N1A+ts2i0rV17bnUrw0qSRxP3H2P8eKLFXRhq9/9kew5QDB
         YrlWYqXTXUYOn/iKyhDoQTKvITCgcqpCxR8BpSy8j8AbBO1Tw/RoLX1v30aopD+Ma+0T
         LICkfRVrA7XZWinEPrtQ+Vyfa0rmyep3uhibPlME7dSEi8ind1H7/FL+/1fa9Qh/Gtdu
         pfWjuKBzcUH/T0MkGlS5ArByCiq+GyfpvvkfOarfbxFp3PVXtS2fVMAcNdbBINfG3ecP
         W1BYXHJuGZ4xEnzTt655XDCrBqMRLe1514U7/ixP6GKjqTrwH5tGwe8W1+tNx5c4bi3u
         n5cA==
X-Gm-Message-State: AOAM5302UFAqix7briWQUiQ3eBUkGBHsXVK+S3A82YgAkcM1Ltwnb9qh
        Or1YcUzo9FrtiTPn1blQ0OA=
X-Google-Smtp-Source: ABdhPJwN5U+ard+Qki0SdR5UI3fX19xvr508fwYQN99FfmnkP5nmplSDAEKiW7ZIHP2YJeflC4AvnQ==
X-Received: by 2002:a37:8341:: with SMTP id f62mr8966045qkd.110.1626258573663;
        Wed, 14 Jul 2021 03:29:33 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id b25sm816798qkk.111.2021.07.14.03.29.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 03:29:33 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailauth.nyi.internal (Postfix) with ESMTP id 7DCDB27C0054;
        Wed, 14 Jul 2021 06:29:32 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 14 Jul 2021 06:29:32 -0400
X-ME-Sender: <xms:jLzuYKwkX7Mi8F_gAlSrWJEpFeZuAMRrSrE4s_Rby0CLShRFdo5mLw>
    <xme:jLzuYGRB-xjN4nFDlKMZovsBwfhVVoTUBmBgl6l31GMewI_wSY0oahkFifPzCkp-1
    MhCqUQ5Al0LkO7wzA>
X-ME-Received: <xmr:jLzuYMUHS1edsYSYZpoxg27pjB92OokUGVlcZ3m40bDUEUpiEDNMMDi8TzrZNA>
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
X-ME-Proxy: <xmx:jLzuYAi5bNjY-W_YQ-fJYcuFz_2jdxgThjTaMkZRN6m0YnLuCJ7YgQ>
    <xmx:jLzuYMC8K5Re_L5qIQS6rWrb87WUA57X9eaERAWPSxVsC0jNWF7SEQ>
    <xmx:jLzuYBJ6GmRGAwKqaPb5CRp1gyyzajF7UED_pt1jvGOQLsr-7JR60g>
    <xmx:jLzuYE6Ej6GExRn2wmj2MX3uPYDmMZRTCichFqr01KK3tWpHR1yAnpMCNAM>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 Jul 2021 06:29:31 -0400 (EDT)
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
Subject: [RFC v4 3/7] arm64: PCI: Support root bridge preparation for Hyper-V PCI
Date:   Wed, 14 Jul 2021 18:27:33 +0800
Message-Id: <20210714102737.198432-4-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210714102737.198432-1-boqun.feng@gmail.com>
References: <20210714102737.198432-1-boqun.feng@gmail.com>
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
 arch/arm64/kernel/pci.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/pci.c b/arch/arm64/kernel/pci.c
index 1006ed2d7c60..3b81ac42bc1f 100644
--- a/arch/arm64/kernel/pci.c
+++ b/arch/arm64/kernel/pci.c
@@ -84,7 +84,13 @@ int pcibios_root_bridge_prepare(struct pci_host_bridge *bridge)
 {
 	if (!acpi_disabled) {
 		struct pci_config_window *cfg = bridge->bus->sysdata;
-		struct acpi_device *adev = to_acpi_device(cfg->parent);
+		/*
+		 * On Hyper-V there is no corresponding APCI device for a root
+		 * bridge, therefore ->parent is set as NULL by the driver. And
+		 * set 'adev` as NULL in this case because there is no proper
+		 * ACPI device.
+		 */
+		struct acpi_device *adev = cfg->parent ? to_acpi_device(cfg->parent) : NULL;
 		struct device *bus_dev = &bridge->bus->dev;
 
 		ACPI_COMPANION_SET(&bridge->dev, adev);
-- 
2.30.2

