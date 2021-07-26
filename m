Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB9453D6669
	for <lists+linux-hyperv@lfdr.de>; Mon, 26 Jul 2021 20:07:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232824AbhGZR1A (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 26 Jul 2021 13:27:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231248AbhGZR07 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 26 Jul 2021 13:26:59 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1F42C061757;
        Mon, 26 Jul 2021 11:07:27 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id m13so12964205iol.7;
        Mon, 26 Jul 2021 11:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=drzvjYjf9v4fqS1iU+Dz/o3PJvwLUgUtNuIzGT8WydQ=;
        b=dYH2Rpw/sGNj8TqMiLdymjdVY0FzhPA2uRtfUYyplAfZJUPu2kQNs9ZE5ukJ7zwrqI
         spKKtLHkqgweKrKQJkL33rVdZmel/h2nL+DpEXiEFU+tQ6VzbXyussz3pEKylFicPeXV
         63B2VUJf1ckMqk4adXnYjxg5pWrY8Y2nalAejKBp+M2C1bchiqbIoo3V1NwZWKC23Qa0
         K/q+U4zfKlC4q3xXgy4R4SOgZSxlHJLWpmJUkuBWCcYlT3/y0zgYT59W06F4n06bvQQH
         MDpf1W68m5KMPyJTtCSMU7STejgPaLwpkCl8qbSCQuIYAEw1qdXGLp9BVlmyxW6H5L46
         dSvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=drzvjYjf9v4fqS1iU+Dz/o3PJvwLUgUtNuIzGT8WydQ=;
        b=PGlVJzWPd5lK5qv87Z87Yd+Tax8AZBBHc2THWncxe7NNkHcR29HRjkRjruEe86hlTt
         byo3u16rlHfv6HipoPY40lmJSrx0ekvhWQxU0AqLDTlVGSOzHporT3U7MSgG4ZE3FQue
         PE4GJxsuVlEeRnbTN+/5pJ9hNIJKO2p4g7hWMp7FttXF3kEutkFD7dRbv3ercBkg3CNi
         VeeD81VQU/pW/Ri79qBKmn6k3e4e4waNYqGo+NpTIWHdnJmAQUa8ou1hEjR8C2y1MdPq
         CD0haTjRmHTxsN961l1EPy0gkH89edkgN+6g2h+P7ErnujSmkPwQyB1vvpmRcQAxqBlX
         YVKQ==
X-Gm-Message-State: AOAM533qpfFFUGKZlHsHnt/tJg2Ce08yRUA/iyUALyObQR8Ryq+wbdmT
        byO3BnQPQP9TygjjIdOhBBc=
X-Google-Smtp-Source: ABdhPJwYZr8saZ1l0/26xD/I+LMdt9FzRCWubyN+UOi7ghTOrLlNcA6F9VTgZcmh0ysNN5b21EezDQ==
X-Received: by 2002:a6b:1685:: with SMTP id 127mr15950564iow.135.1627322847362;
        Mon, 26 Jul 2021 11:07:27 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id a1sm264889ilp.1.2021.07.26.11.07.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 11:07:26 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailauth.nyi.internal (Postfix) with ESMTP id ED4CE27C0068;
        Mon, 26 Jul 2021 14:07:25 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 26 Jul 2021 14:07:25 -0400
X-ME-Sender: <xms:3fn-YE49uM0G8gJEHzakDXl8rW0vUMFqvzJM7rAlGh3u8dHdKTsAdg>
    <xme:3fn-YF5KZI5-pteCbqXs8bFmPcPBNsX4rV2oMTBObIxC0ty8bDQ1qNkcjnueSQx88
    75Nxoj7rYu-ez6Biw>
X-ME-Received: <xmr:3fn-YDd2jMXDZovNA4_Ka2vUQvoSfo2Ea05I1okS3pnAmnEfA-8aPdSyLeI>
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
X-ME-Proxy: <xmx:3fn-YJIrm0AJtfi5HXSp5TZFfcXQ0ukjs9fldsmSSvdi0-8eE6AwAQ>
    <xmx:3fn-YIJ9Eu7yBxTqOl8BCHDTmDIe9WU4YW5lsFhEQ3IhwwNoELSRHw>
    <xmx:3fn-YKzYYOtzlAMk7GGr-a65b5sfVv49rGsWJdv4IkesnqziMxwsDA>
    <xmx:3fn-YNCf_LNgcQOEilZUfNcHoC7ziRbbg-79qGkD9l18xHs8ZjVzO4Dw4WM>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 Jul 2021 14:07:25 -0400 (EDT)
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
Subject: [PATCH v6 4/8] arm64: PCI: Support root bridge preparation for Hyper-V
Date:   Tue, 27 Jul 2021 02:06:53 +0800
Message-Id: <20210726180657.142727-5-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210726180657.142727-1-boqun.feng@gmail.com>
References: <20210726180657.142727-1-boqun.feng@gmail.com>
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

Use a NULL pointer as the ACPI device if there is no corresponding ACPI
device, and this is fine because: 1) ACPI_COMPANION_SET() can work with
the second parameter being NULL, 2) semantically, if a NULL pointer is
set via ACPI_COMPANION_SET(), ACPI_COMPANION() (the read API for this
field) will return NULL, and since ACPI_COMPANION() may return NULL, so
users must have handled the cases where it returns NULL, and 3) since
there is no corresponding ACPI device, it would be wrong to use any
other value here.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 arch/arm64/kernel/pci.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/pci.c b/arch/arm64/kernel/pci.c
index 5148ae242780..2276689b5411 100644
--- a/arch/arm64/kernel/pci.c
+++ b/arch/arm64/kernel/pci.c
@@ -90,7 +90,17 @@ int pcibios_root_bridge_prepare(struct pci_host_bridge *bridge)
 		return 0;
 
 	cfg = bridge->bus->sysdata;
-	adev = to_acpi_device(cfg->parent);
+
+	/*
+	 * On Hyper-V there is no corresponding ACPI device for a root bridge,
+	 * therefore ->parent is set as NULL by the driver. And set 'adev' as
+	 * NULL in this case because there is no proper ACPI device.
+	 */
+	if (!cfg->parent)
+		adev = NULL;
+	else
+		adev = to_acpi_device(cfg->parent);
+
 	bus_dev = &bridge->bus->dev;
 
 	ACPI_COMPANION_SET(&bridge->dev, adev);
-- 
2.32.0

