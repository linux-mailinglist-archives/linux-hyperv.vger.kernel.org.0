Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F359E3D6666
	for <lists+linux-hyperv@lfdr.de>; Mon, 26 Jul 2021 20:07:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232730AbhGZR07 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 26 Jul 2021 13:26:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232359AbhGZR06 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 26 Jul 2021 13:26:58 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE4E5C061757;
        Mon, 26 Jul 2021 11:07:26 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id f11so13003668ioj.3;
        Mon, 26 Jul 2021 11:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LHrsItUFYAp+yhbZpF5x7FyTurt+NzbD/q2wgRgWa4g=;
        b=AcYJCK4IAtJVVb1NLiTC/jhNqsHskratKVULEK2AcYvaJf08IOpPv6Q3bVRBWPGu8h
         5cMcNV8R/3CwKyZGVTHBgxaNDz3c5SulIWjB2hmBMQFZwhS9pSXAVFHPrTQLeWTukOjr
         k6qAZaVrwxYPPmfs2CuAuSm3WAGCaOXlI+LQ3tLklMbdOP7YIzuQ/KsnV/Hhz//SD6qx
         Y7H7D9A+TJqjKpzAWAh7s/J+HFJu/v/UCUAlOi0RwLSJerNNTCd73EAXtP/tmSr1PbG6
         f0Ht+C3pIdgxhLkbMMJ60tKdyfpqtkTTzAqBNjvMShIYyCsovnJAVdSZ7Nw0Go/ye1Iv
         ToyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LHrsItUFYAp+yhbZpF5x7FyTurt+NzbD/q2wgRgWa4g=;
        b=E7G7uuLqzrU/GTzzGoA7tOJDlM84r83vXw12D/kl+2J8SZPfCJ3A5rlJFeV/myqgtz
         Mga/cufNKJr1I6/u00onQeicTRM8Bhjvz5tu3Cdpsx0Dqu1f77ws6j7kGzEqdmf1cFz3
         nI1AgS5RKA8sPlgaQGLRKTZPq5Zfds6gsm6+tYFYylToNAxWLaQ7r10i7Qxqpb03nTyy
         mj+9vne2QKjXok1gl/soT0O/WfZWdINQG1atpafFwyJYnC0a6s9Pe18n8p2aZRbO6zBL
         hzFxGyWZUsmoKT2/Gw6OpS7QtmKQ8z7affpH/hP+3eOhVE6wCdFtjnY4/IrMPJkQf28r
         Ppfw==
X-Gm-Message-State: AOAM5310/cOjVGUgg+v4TEuNQdF1hKUOjKTK94+sl8W3bPpEBcm8wRtO
        Y1GfyZ0oO2BIAhk5Yx2uADk=
X-Google-Smtp-Source: ABdhPJyyjproPpnhdk5Y+TcJ2Ft2rCFKihz1P0YZ7etQvYq41fU7f2wjmMJyy3cRbHKH9jcLhAD+kQ==
X-Received: by 2002:a05:6638:148e:: with SMTP id j14mr17993794jak.136.1627322846198;
        Mon, 26 Jul 2021 11:07:26 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id y14sm286275ilq.6.2021.07.26.11.07.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 11:07:25 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailauth.nyi.internal (Postfix) with ESMTP id B689327C0066;
        Mon, 26 Jul 2021 14:07:24 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 26 Jul 2021 14:07:24 -0400
X-ME-Sender: <xms:3Pn-YBlpETOvUYtzNkLFI0gZrUAVJ4vXnYOU9XKkN52_3EnU7BWs0A>
    <xme:3Pn-YM1R2Dt341V251ypyYfHt-yJ7ZWLv9mzXOtAxE_nQ5dcvdfOcWJKRCJEh7Qt7
    Qsg6uxSTyi5Ec3sgQ>
X-ME-Received: <xmr:3Pn-YHpa9fqJOz-lo8PrhS103Vsm3c6K3m8FwSKtw6XZVEotCfPgWDDCM8Q>
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
X-ME-Proxy: <xmx:3Pn-YBmOHMMV0ZVxlmDpDtB74_X7f6DIIJgndWxctvRCk32_zptFVA>
    <xmx:3Pn-YP26IqRCdnl5uTRcQuJWJB7pSpiIMW2VE8_yDGlDnlDQl_7guw>
    <xmx:3Pn-YAuI614pFUJbeWC8s-ffTCqTyOk5UXi_i6mHMFF4nFKeW5fTgg>
    <xmx:3Pn-YGsef2H8ZcwZxxlxZP-VzF2rQncuhCBd8iWqsGbkS4sEqz6v3E8C1HA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 Jul 2021 14:07:24 -0400 (EDT)
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
Subject: [PATCH v6 3/8] arm64: PCI: Restructure pcibios_root_bridge_prepare()
Date:   Tue, 27 Jul 2021 02:06:52 +0800
Message-Id: <20210726180657.142727-4-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210726180657.142727-1-boqun.feng@gmail.com>
References: <20210726180657.142727-1-boqun.feng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Restructure the pcibios_root_bridge_prepare() as the preparation for
supporting cases when no real ACPI device is related to the PCI host
bridge.

No functional change.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 arch/arm64/kernel/pci.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/kernel/pci.c b/arch/arm64/kernel/pci.c
index 1006ed2d7c60..5148ae242780 100644
--- a/arch/arm64/kernel/pci.c
+++ b/arch/arm64/kernel/pci.c
@@ -82,14 +82,19 @@ int acpi_pci_bus_find_domain_nr(struct pci_bus *bus)
 
 int pcibios_root_bridge_prepare(struct pci_host_bridge *bridge)
 {
-	if (!acpi_disabled) {
-		struct pci_config_window *cfg = bridge->bus->sysdata;
-		struct acpi_device *adev = to_acpi_device(cfg->parent);
-		struct device *bus_dev = &bridge->bus->dev;
+	struct pci_config_window *cfg;
+	struct acpi_device *adev;
+	struct device *bus_dev;
 
-		ACPI_COMPANION_SET(&bridge->dev, adev);
-		set_dev_node(bus_dev, acpi_get_node(acpi_device_handle(adev)));
-	}
+	if (acpi_disabled)
+		return 0;
+
+	cfg = bridge->bus->sysdata;
+	adev = to_acpi_device(cfg->parent);
+	bus_dev = &bridge->bus->dev;
+
+	ACPI_COMPANION_SET(&bridge->dev, adev);
+	set_dev_node(bus_dev, acpi_get_node(acpi_device_handle(adev)));
 
 	return 0;
 }
-- 
2.32.0

