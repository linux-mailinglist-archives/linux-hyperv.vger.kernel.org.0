Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59D253E94AB
	for <lists+linux-hyperv@lfdr.de>; Wed, 11 Aug 2021 17:36:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233364AbhHKPhI (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 11 Aug 2021 11:37:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233220AbhHKPhF (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 11 Aug 2021 11:37:05 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9379C061765;
        Wed, 11 Aug 2021 08:36:41 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id n17so2656679ioc.7;
        Wed, 11 Aug 2021 08:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wRFXDsRsZFP+swHvW0it2ljd9zsnjdp5Y+aRBZEgtII=;
        b=j5aHS3h3ClzuSFzHjW1f232qNdqNbr8RGmFfs1lj042PPgg1xQq48+wOSbQ6ijMk1k
         0P8EFECxSVN6ir2xkYjqEWGSvKwYEwyesE0KZccKhWYE2JTCq9YwgUTJHRfy1dWG5XNx
         5MgVnHvDXCsAK9L7G/zrejy+Q0uxWntknVdsx9iWGHecdzRCrdoc3zBBkHDgrXwV8jUo
         hDx2uSgwQrnf1mApyxjC04Sr4HFSDJFgf1MjBGveh8iPShD1Lt2iaY62cHA+N+INnYrJ
         swT1HASYf58Zn/+R/k4cWRkhZnW4J2DWEBlE6bmuDIfKNouocM7r7+zkjHHvhoAbmJYC
         4Q1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wRFXDsRsZFP+swHvW0it2ljd9zsnjdp5Y+aRBZEgtII=;
        b=cWtc0cefgmuqOmDZ+gQi9l36SjmP1/efFiX6PgXb5G4BYfLbdUCpeDhT8Y9/Pdjw06
         7fCAjzVGwDHPhkBrJlGsRGhpyC47JmmbGK//PmkQqPLbfdLZHhgEUbiDAYY9DhYfyh5d
         8ESp/W1ShgEzKeAY/93zy1osgMkm6HI7vUOun3NiazWw+Gagwl3dOSGq5FmEcwrkwNGK
         Cl+D0p2JSwMRA7OXRPJMWPakv2XrnBO9GZ3fYVQwMJFZCvCDeKt8UmeBV4QYhMHCHkGD
         bUFgdYGQrjyHssJ5evvdxu9EMjwkRauUPvhDemNE+lJnHu7EnvgZEtroq862nnjmqKrM
         bwMQ==
X-Gm-Message-State: AOAM530GoJ8lTE2Hk31sQs3bMUexEEA1cjIvynzYFIMIn55AcFj+ldtY
        wEPZ5IVJEwwHu8aazG/xVTw=
X-Google-Smtp-Source: ABdhPJyewK+8jlT5DsfKdoU00MeBnHa8omGalrNwdkPuKHZw2jePTbG33EdqpOUGziPz18+svZ0UTQ==
X-Received: by 2002:a02:7711:: with SMTP id g17mr476718jac.132.1628696201381;
        Wed, 11 Aug 2021 08:36:41 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id w16sm13438214ilh.21.2021.08.11.08.36.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Aug 2021 08:36:41 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailauth.nyi.internal (Postfix) with ESMTP id 0357327C005A;
        Wed, 11 Aug 2021 11:36:40 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 11 Aug 2021 11:36:40 -0400
X-ME-Sender: <xms:h-4TYYBdt4bVUxRegAU3KvPfDO1mMy3K8uLAwwVOkRLC2cwrfSJGUw>
    <xme:h-4TYajrCZTZRpYFOHmr0fKFhDbmWUX1A2GkD9-bcyeh2Q_7WGsxwytbALnm1QI9c
    D9nEYq87hqHE4w2pA>
X-ME-Received: <xmr:h-4TYbmeMtgiHK8RXE8Y_W9V9EtouCuC6DC-F-mF9JEV7yRiRtZ3_ZogA1I>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrkedugdeltdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtth
    gvrhhnpeehvdevteefgfeiudettdefvedvvdelkeejueffffelgeeuhffhjeetkeeiueeu
    leenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsoh
    hquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedq
    udejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmh
    gvrdhnrghmvg
X-ME-Proxy: <xmx:h-4TYew2l40zgHzb8qh2rubXJ-nvgeKWTm7kqgZfyDn5f4B9dqHM-w>
    <xmx:h-4TYdQujqrPbNrxKrvv48IG6w7o8dpx0CZAH_4PDwyGszxj5OMkzA>
    <xmx:h-4TYZYE8-BGpKJ5BQnHZcWYZumvDGxx2YsWdH8H4ogzDj2RfG0rww>
    <xmx:iO4TYeTTvFT7a1MDm2E3iUqUfMZYoQML4ecW7Vf2MsdbiVE8HuNqG3eSopo>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Aug 2021 11:36:39 -0400 (EDT)
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
Subject: [RFC 4/5] arm64: PCI: Retrieve ACPI device information directly from host bridges
Date:   Wed, 11 Aug 2021 23:36:18 +0800
Message-Id: <20210811153619.88922-5-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210811153619.88922-1-boqun.feng@gmail.com>
References: <20210811153619.88922-1-boqun.feng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Now since we store the corresponding ACPI device pointer in the
->private of pci_host_bridge, use it instead of the sysdata to retrieve
the ACPI device information. Doing this decouples the dependency on the
pci_config_window structure in Hyper-V virtual PCI, because passing a
NULL pointer as the ACPI device is the soly reason of the dependency.

The decoupling avoids adding pci_config_window in hv_pcibus_dev and also
makes the code cleaner.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 arch/arm64/kernel/pci.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/arch/arm64/kernel/pci.c b/arch/arm64/kernel/pci.c
index 2276689b5411..783971749eb7 100644
--- a/arch/arm64/kernel/pci.c
+++ b/arch/arm64/kernel/pci.c
@@ -82,25 +82,13 @@ int acpi_pci_bus_find_domain_nr(struct pci_bus *bus)
 
 int pcibios_root_bridge_prepare(struct pci_host_bridge *bridge)
 {
-	struct pci_config_window *cfg;
 	struct acpi_device *adev;
 	struct device *bus_dev;
 
 	if (acpi_disabled)
 		return 0;
 
-	cfg = bridge->bus->sysdata;
-
-	/*
-	 * On Hyper-V there is no corresponding ACPI device for a root bridge,
-	 * therefore ->parent is set as NULL by the driver. And set 'adev' as
-	 * NULL in this case because there is no proper ACPI device.
-	 */
-	if (!cfg->parent)
-		adev = NULL;
-	else
-		adev = to_acpi_device(cfg->parent);
-
+	adev = acpi_pci_root_device(bridge);
 	bus_dev = &bridge->bus->dev;
 
 	ACPI_COMPANION_SET(&bridge->dev, adev);
-- 
2.32.0

