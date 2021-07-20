Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D43D13CFB49
	for <lists+linux-hyperv@lfdr.de>; Tue, 20 Jul 2021 15:53:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238933AbhGTNNK (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 20 Jul 2021 09:13:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239017AbhGTNGf (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 20 Jul 2021 09:06:35 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA35AC061768;
        Tue, 20 Jul 2021 06:46:36 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id o8so19179592ilf.4;
        Tue, 20 Jul 2021 06:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2l8LjoE1uOwDr72/zLLZTqmL1EazEamG/E8cAH7MR/4=;
        b=ajtns35Hl78+1NkA8OLkrxH68UpjGJpRlhocpJiDyrPbIuCE+Fk88T15LW08SJbo7f
         Hs2oZMp/weamcSU/VBHogx3cK5M3ZQHOLJtgVOr4fWy7vEw/MLQbX41/plFyh8Tqpu53
         j0mcbP1SeSrw78RVy7QPhbYKf0S9ZPHyUwxKmRS1biWti+jrXEu0y2bTYEhqqJAuYeMK
         9/a2enqhvdzo0v8GrQU5si9Ug7A9hYUJK3IT5qfbRIwApA56c379jd/6blSjWAr2hBa4
         Y32NwJH+5yPYPr6NDxysobobvJ/Gake7iJjUYzeYjqF/48bBW1r56PMvqaUdOTGFYM09
         MVaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2l8LjoE1uOwDr72/zLLZTqmL1EazEamG/E8cAH7MR/4=;
        b=kBPjiFPw6HXVLCkvqZYNbCbmEKrHetyvq6u4NuLSwJFwMnL8C8yBRAHd6YLpOt2T3u
         gPwcSJuHHV0XWHJg3tIH0yhJloJ9FVOn+QyvC0JmwiLvmXQQUgY/bMs0rQdfTalNswbQ
         6qmmZt30ayKI+eRAyNZOOGhgL7nItctn9ElBDCHsUR5s1J78CeTofN+pTbEVn0XzCKDx
         2i8B5W5DngYZ5JlzDOIXJ4tT26tV3+PTNWu8FayHYJNTBGGHXff/+E6N0vcH+y33soxG
         4aOLU6lW4a0GQEzUeQBxct38HASIUclHCXhJvysI3yL+BXx2W6FcRHhiD2+gYON9ZnYc
         He8g==
X-Gm-Message-State: AOAM5335tgi+K0aAFeEp5p2lRcK7PQqTfRs97H02yVvTzEsmJ6uC5TxI
        dTCDLtYZz6iVJ1SRI49Wwjs=
X-Google-Smtp-Source: ABdhPJy5ZlVtS2IpZV+E+tOkjNyl6ikMUUAhFR+jcPbGFJGtQfIDSPtenYJW7ZQP80qXkGRFquPENg==
X-Received: by 2002:a92:1906:: with SMTP id 6mr20466375ilz.273.1626788796357;
        Tue, 20 Jul 2021 06:46:36 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id o13sm11445110ilq.58.2021.07.20.06.46.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 06:46:36 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailauth.nyi.internal (Postfix) with ESMTP id 1865E27C0054;
        Tue, 20 Jul 2021 09:46:35 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 20 Jul 2021 09:46:35 -0400
X-ME-Sender: <xms:utP2YD3-Etabcze_SSFlGF6NjcGMc2Jlch_Srub4lMtvWEca9HeFpg>
    <xme:utP2YCEqs8QCKhOmdiVNwTS3yXAnmwrxu-AKBnfTIymb2UcAfWvp3bEoc2E9dOcC9
    BNXdNbhCw9OvLRRdQ>
X-ME-Received: <xmr:utP2YD7u7iOSEiYZzb61aR9Xmm_sBX5P0RIPoX5V1YJi6ZkgzvZjcy-enYE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrfedvgdeijecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtth
    gvrhhnpeehvdevteefgfeiudettdefvedvvdelkeejueffffelgeeuhffhjeetkeeiueeu
    leenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsoh
    hquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedq
    udejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmh
    gvrdhnrghmvg
X-ME-Proxy: <xmx:utP2YI2Q0qBdR4omOy_VAwucrib0vw-FDQru-hk29Hil_PsboTjLow>
    <xmx:utP2YGH-xWsP7ymsg3wwE-TRmjhCpWH65MPyKAkoA3O7tPouJhyH1A>
    <xmx:utP2YJ8RK-axthuANf83JZt2h8mj_FW3Gdi_quJOsxG6Y-7eO--2qA>
    <xmx:u9P2YE-rdA2J7pNHcinNDj8OT3OajJAAZpGQHjpGya_L_EdDiFGLNp9w8uQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 Jul 2021 09:46:34 -0400 (EDT)
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
Subject: [RFC v5 4/8] arm64: PCI: Support root bridge preparation for Hyper-V
Date:   Tue, 20 Jul 2021 21:44:25 +0800
Message-Id: <20210720134429.511541-5-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210720134429.511541-1-boqun.feng@gmail.com>
References: <20210720134429.511541-1-boqun.feng@gmail.com>
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
2.30.2

