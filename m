Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 255ED3D6662
	for <lists+linux-hyperv@lfdr.de>; Mon, 26 Jul 2021 20:07:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232364AbhGZR06 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 26 Jul 2021 13:26:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232184AbhGZR05 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 26 Jul 2021 13:26:57 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AA2EC061757;
        Mon, 26 Jul 2021 11:07:25 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id a13so13018116iol.5;
        Mon, 26 Jul 2021 11:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1c0YHVVpshurDZxktAEbB6eItllT1ZgLTMwS/SNq12o=;
        b=UnIOIAZJUrGAXTOWCzN1UMMXXj4Y+n9S8YfEiw78eH1knvpO26QeIHGpvc3ECp5DOF
         8uFGupNy4Wwsg0x+/ouySrZe0aBowIqg/ox/4WA35/M1jo1waN6vPTgCGCA2FPF2TM9U
         BegLQx4FJeSJLM5qabXk5tFna9jem6KfDr75kkriVy7afRUuRMfXHBT7CcQWNTlJicl2
         MQTDYvBQT2qI0Ho+aAWgx6w+5gFNu0CZpbpEZ4QxRSerh94eVqP3kN6jfIWDY57d6WMe
         aUxnaaehoZaeKFGOKDH9nrQKqqtMLCRoM1VocV05psPd2OCpgOiqqE57kcdXchYulY1W
         SN3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1c0YHVVpshurDZxktAEbB6eItllT1ZgLTMwS/SNq12o=;
        b=Ofp9F5/ox21vh/E3fIY+uW+WVge2tB8uBp3LW0exd7Vv32tRCJ3gC5RdXaAOBSedf6
         A7DLCEYqCIPnsxi7Rab1id/aWi3QmGLS6WjHwBigzmri04dLM8WN/fDHAlczTEeHaftX
         HCngvGHBLyOQxMSqW/d0W/NG+WKPu3wAIi60brfK42YeaQKqIG+ECOx/GXr2uEANP+CW
         xkRbUsbZXLPBy0WluxyOqnJNfN7Sfc5Lqfeo06WSnN2ppilizmfpJudhMuEhp4bN1Jay
         9o5Ddrfy+3m5tiUySbBvxgAlen4hCVb6kcbQ8OKMeRYxXvhBYwF7ahBanFo6FKNDgUvJ
         3fLg==
X-Gm-Message-State: AOAM531x0hIk84ZyYYs/x06EKFyKVQshN+ebTON/MIhV/ivKEvCT4vRY
        jxUDmTB5Uz6kXSYA7Q2z1Hw=
X-Google-Smtp-Source: ABdhPJy4DVeG+yNbFIVzEGfn5ZuDU5SR1maRI+Tc0qIy+0mRktuOsYlJdQSPYbAsLFUj8MH+a7Jl7g==
X-Received: by 2002:a5e:924a:: with SMTP id z10mr15688350iop.35.1627322844639;
        Mon, 26 Jul 2021 11:07:24 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id j20sm316369ile.17.2021.07.26.11.07.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 11:07:24 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailauth.nyi.internal (Postfix) with ESMTP id 4F23427C0066;
        Mon, 26 Jul 2021 14:07:23 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 26 Jul 2021 14:07:23 -0400
X-ME-Sender: <xms:2_n-YFmypnAZ8qoWOgU_hIrmN9GW6Nhvc-l5nO4W4daL5oLBOthofQ>
    <xme:2_n-YA0COJvSzqbHfPRXe4WD5P5oYPj75_ko1HEXFuSlqotNRrqVutARmgBw9dXCU
    C9n9E8WpokMwZIJfw>
X-ME-Received: <xmr:2_n-YLrlDIotehi7tgqkijXY1vb-LRQd41Th5lJWzCY3FSwoGf9SAxp4pOI>
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
X-ME-Proxy: <xmx:2_n-YFlYPrZnnNDLGKLkekasXJj_xz9xJ4SrkB7bw9G9rZ9aMiCGZQ>
    <xmx:2_n-YD1YO3i-USfMa12jpbay65WrEGnlZJJR5PXW9bF74tSsqS0KVA>
    <xmx:2_n-YEv8rUFBpxR38VPLN7fdHY5VTbMpRVl1iK_TVKCaO8JekQvr_Q>
    <xmx:2_n-YKvzYdHOd1hhbPBp0eMUY0jahwGOgXqfZjsvf1f7a46CDoUYgdjE5Zo>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 Jul 2021 14:07:22 -0400 (EDT)
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
Subject: [PATCH v6 2/8] PCI: Support populating MSI domains of root buses via bridges
Date:   Tue, 27 Jul 2021 02:06:51 +0800
Message-Id: <20210726180657.142727-3-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210726180657.142727-1-boqun.feng@gmail.com>
References: <20210726180657.142727-1-boqun.feng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Currently, at probing time, the MSI domains of root buses are populated
if either the information of MSI domain is available from firmware (DT
or ACPI), or arch-specific sysdata is used to pass the fwnode of the MSI
domain. These two conditions don't cover all, e.g. Hyper-V virtual PCI
on ARM64, which doesn't have the MSI information in the firmware and
couldn't use arch-specific sysdata because running on an architecture
with PCI_DOMAINS_GENERIC=y.

To support populating MSI domains of the root buses at the probing when
neither of the above condition is true, the ->msi_domain of the
corresponding bridge device is used: in pci_host_bridge_msi_domain(),
which should return the MSI domain of the root bus, the ->msi_domain of
the corresponding bridge is fetched first as a potential value of the
MSI domain of the root bus.

In order to use the approach to populate MSI domains, the driver needs
to dev_set_msi_domain() on the bridge before calling
pci_register_host_bridge(), and makes sure GENERIC_MSI_IRQ_DOMAIN=y.

Another advantage of this new approach is providing an arch-independent
way to populate MSI domains, which allows sharing the driver code as
much as possible between architectures.

Originally-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 drivers/pci/probe.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 60c50d4f156f..ea7f2a57e2f5 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -829,11 +829,15 @@ static struct irq_domain *pci_host_bridge_msi_domain(struct pci_bus *bus)
 {
 	struct irq_domain *d;
 
+	/* If the host bridge driver sets a MSI domain of the bridge, use it */
+	d = dev_get_msi_domain(bus->bridge);
+
 	/*
 	 * Any firmware interface that can resolve the msi_domain
 	 * should be called from here.
 	 */
-	d = pci_host_bridge_of_msi_domain(bus);
+	if (!d)
+		d = pci_host_bridge_of_msi_domain(bus);
 	if (!d)
 		d = pci_host_bridge_acpi_msi_domain(bus);
 
-- 
2.32.0

