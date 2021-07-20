Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 196183CFB23
	for <lists+linux-hyperv@lfdr.de>; Tue, 20 Jul 2021 15:48:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239149AbhGTNH6 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 20 Jul 2021 09:07:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239057AbhGTNGg (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 20 Jul 2021 09:06:36 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0193CC061767;
        Tue, 20 Jul 2021 06:46:35 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id l5so24021971iok.7;
        Tue, 20 Jul 2021 06:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KHaue8/q0L/XgtITbxmFTSs2meF6bSyeVDHAyfwq3qQ=;
        b=EUs+7cDYQ2twuXBGcgJ3ID54nrlxwVRhd2/fJu+QbiO784ZQobUF+WYU5yGivOZIr5
         Fe+Nt9tAF10wZb4Irfro//jmDtlX83g8lUuzbYzvfFQPoHZC2JidrWui4H2Izf9wbwNg
         S2cN2xTbiFxrq8mwfHLkjowKF2yt0zd6zP+RmmW7aB+IkWEa4gAa7HJdBGnKJS8Uo89U
         l2A9ooAKaVksbatALCJSaimnH95rgu56IFMfYXxtaYiOjiGNQimbe9fvHMMD+HJNWigK
         dBvDpkAnStfFNuBemWOJ+EQ/O34aK6kfhcnuV/ocmaa7sCHBNJGwEesG18jZKtSD41H1
         i7sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KHaue8/q0L/XgtITbxmFTSs2meF6bSyeVDHAyfwq3qQ=;
        b=R9xdAELYqy+ToYUTS/O5BNyZF92mhW9JXtgD05/PuUQZu25gl4CSaA7QPWER89sVsc
         hIll9GY6r7TzraxyVdw/WpXoSB0gCVm2VGsTi909la7/byyPLU8K09lOGz+tdKnCWRBN
         ZWgQ3oeqjvogGXVpVjP5xiR77gz2L7XHSfyG/DVB40GN1AEFvHBRI8QQaWSLAfepxi7C
         mAEkE0JmgwfmGQRFp1/YYstfxQ2Ppb5ITqebWi5xEelu7Ft/d/tUC3Obh7SPKfxeS+LN
         U8bSsOJomZ8jp5HKDA8/SRK8ow1h0EbIK3T2lt/nMqUF268QVNjuinS4gdeN5VwsZewP
         hhrQ==
X-Gm-Message-State: AOAM530fCqb02Sr0wV0Lh7bTZUa+34Nt/TgUHhoVSydN0pbnWSqjzZ+U
        U14VKpuzHWndQr1rhmU3XP4YEayhuTsm+Q==
X-Google-Smtp-Source: ABdhPJw+oXm9AEsLFIoRyHMm+CxOfL8zZA7wUOGTA3d9buaMX1aXsUIyODDeHj9Gnn0IhiyrjH4bpg==
X-Received: by 2002:a02:cc19:: with SMTP id n25mr26569885jap.140.1626788795137;
        Tue, 20 Jul 2021 06:46:35 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id u10sm7576791iop.15.2021.07.20.06.46.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 06:46:34 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailauth.nyi.internal (Postfix) with ESMTP id C28C427C005A;
        Tue, 20 Jul 2021 09:46:33 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Tue, 20 Jul 2021 09:46:33 -0400
X-ME-Sender: <xms:udP2YARpfw46bzdw4GbIguYHxcd7fscLicS7OaWkRopvQRVLi3X1pA>
    <xme:udP2YNxqPzTDXwmmKYWhAR4bye15vHwMGJlNPeKjw703jIlLInwtmf0DPU1QmGRKp
    Vus-T3RoAMGa3Kcnw>
X-ME-Received: <xmr:udP2YN1_MnvTKDTcFfrG07vdVXgNcoDc_DPDcecQ8cR4YTPLY5R5EBMHkik>
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
X-ME-Proxy: <xmx:udP2YEBrAJ6sx8FcmP6Yu31o91n8LTrLWZ9ipZjEdwLsoljdE2ivxg>
    <xmx:udP2YJjuzEHdREvjynTjlT4XMxk0eVviXbP670uJf6O60u-MJsZs7A>
    <xmx:udP2YArDpGfsuAFQbsSBlOG66dstt8AapKcDceLw4OM-JPKhFwgnkw>
    <xmx:udP2YCb_stVgTvtuz6WryxyjhSFA0sb04DpFXn52NPLd-8DXE5WbZigx9Z8>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 Jul 2021 09:46:33 -0400 (EDT)
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
Subject: [RFC v5 3/8] arm64: PCI: Restructure pcibios_root_bridge_prepare()
Date:   Tue, 20 Jul 2021 21:44:24 +0800
Message-Id: <20210720134429.511541-4-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210720134429.511541-1-boqun.feng@gmail.com>
References: <20210720134429.511541-1-boqun.feng@gmail.com>
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
2.30.2

