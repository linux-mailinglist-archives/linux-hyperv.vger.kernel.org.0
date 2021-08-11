Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63C1D3E94A8
	for <lists+linux-hyperv@lfdr.de>; Wed, 11 Aug 2021 17:36:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233309AbhHKPhG (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 11 Aug 2021 11:37:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233248AbhHKPhE (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 11 Aug 2021 11:37:04 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 845F7C0613D5;
        Wed, 11 Aug 2021 08:36:40 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id c3so3315023ilh.3;
        Wed, 11 Aug 2021 08:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=m+WerKLNTuUcJjz5ppPIhMIuAZu9yrWomJykGHOMdQE=;
        b=Xw6bPBKjGySndzPoxC/HBXcfij6Ej8gsr8XCwc/zUlawabtn9idGbjPtC5CiRKkBTI
         IA8wyHhBi1Eb/DNR66nHkc+bGlSqJ1oMU4yomnzFoL0dLvsgp9EijGkpycy+ME8ywYAU
         9miztcb3otIBCm1rnSjISWjbUkHjtO5Zh2zXHk64EhOOR4+ZoIniFCi6Vzp+VeQwPEFF
         0swypePmtrL4wWMaRNBmi/e63ZXF5YQpxE0eYKmevPTTY0pWT9oCPylMLKRBiOT3TNq1
         9Jbxxt1ehFQEq3YrJUL7/RrF9dIgres10UXUChxe2NvXIyryaSik9xOkU7x4vyd0R6Yz
         cr1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=m+WerKLNTuUcJjz5ppPIhMIuAZu9yrWomJykGHOMdQE=;
        b=PJ6KQ1a8g1oDOyv6OHsFsUocjdzpWKt+2QUVpYBsgGOaAva71E+z67DdBzuhAEFp01
         C2GKXz3Kxdw8Khh905spuORcWhQtMTaLZGjbLZ9ovu/tszK44gSbJm7VbtAGRwoYWk86
         tSbci4C9Fh8wTZAUZj+rGP5ZntM/hy4+BPpc4ajVnjlffC3J18+ixXdqClLYL3zBJalv
         0AAYf+9pqTUaIEALh+8/h8r8sleI+/DYVnSZl4baROLP85WZJ9Gugd8tbRXICTYq+ukE
         4hwpAc9KNZ7qHth2lMPC4d9qMUTCo94jDf2fzCTZjgRvlqpwn2OkhJLt7v5fnpSN2OAd
         3SOA==
X-Gm-Message-State: AOAM531hMIF0XEONkVXJORK03mf59s6CKCxnM3knUhe5wj/Uj9aVvY5R
        59Tijx9xErqmiONQ3Kxy1jA=
X-Google-Smtp-Source: ABdhPJwG2Q43Tufl+2zOtEvKna7XTvih3Y7p27iDvAbAfAT9elYx46qIz2mqI+h/bG7cZprSEiAaxg==
X-Received: by 2002:a05:6e02:13f0:: with SMTP id w16mr276304ilj.268.1628696200058;
        Wed, 11 Aug 2021 08:36:40 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id t15sm12914887iln.77.2021.08.11.08.36.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Aug 2021 08:36:39 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailauth.nyi.internal (Postfix) with ESMTP id BCAAA27C0054;
        Wed, 11 Aug 2021 11:36:38 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 11 Aug 2021 11:36:38 -0400
X-ME-Sender: <xms:he4TYYu_fkfWkZ1sy9OtFgmUVMfiW-OJ3rytMff_hgLViVA7TCIKTA>
    <xme:he4TYVeMKLd8PPat7GNzlZpuax9FMGeC7P1D9M4qfkvgdwPMakM9qFl6WaGhwnqg0
    Wb1hYMxBVOX8X0TPg>
X-ME-Received: <xmr:he4TYTxD7jOVcdCQ_gZ1YkGpXN0MK4S-b-qsR5AFUk0LY8g-35lS5bp4l7A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrkedugdeklecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtth
    gvrhhnpeehvdevteefgfeiudettdefvedvvdelkeejueffffelgeeuhffhjeetkeeiueeu
    leenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsoh
    hquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedq
    udejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmh
    gvrdhnrghmvg
X-ME-Proxy: <xmx:he4TYbP0DXUPZ2rLB-eC_riltFQkOP6AaPMFqVsvSNH4FIYA7UxeOw>
    <xmx:he4TYY_GEWxUvhvq8zDauKaLZNJRSSOZVAYpzlPlpk6Akx5ndco20g>
    <xmx:he4TYTWhsIp172WT4bdecVCNZicWTcCMFhk2fE6z2YAMPC2Tg2PVSw>
    <xmx:hu4TYbcrq1OJ_K9ttEqRoQgIOJRIjiWEK81s8nvd0tIsx9d0ne2TkkR3GkQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Aug 2021 11:36:37 -0400 (EDT)
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
Subject: [RFC 3/5] PCI: hv: Set NULL as the ACPI device for the PCI host bridge
Date:   Wed, 11 Aug 2021 23:36:17 +0800
Message-Id: <20210811153619.88922-4-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210811153619.88922-1-boqun.feng@gmail.com>
References: <20210811153619.88922-1-boqun.feng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

A PCI host bridge of Hyper-V doesn't have the corresponding ACPI device,
therefore a NULL pointer needs to be set as the ->private of
pci_host_bridge since for platforms with ACPI ->private is used to store
the ACPI device information for the host bridges.

And since kzalloc() is used to allocate pci_host_bridge, as a result,
what is needed is just setting the correct size of ->private, kzalloc()
will zero the field as if set a NULL pointer to it.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 drivers/pci/controller/pci-hyperv.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index 62dbe98d1fe1..fd3792b5edcc 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -3021,7 +3021,12 @@ static int hv_pci_probe(struct hv_device *hdev,
 	 */
 	BUILD_BUG_ON(sizeof(*hbus) > HV_HYP_PAGE_SIZE);
 
-	bridge = devm_pci_alloc_host_bridge(&hdev->device, 0);
+	/*
+	 * devm_pci_alloc_host_bridge() use kzalloc(), and we want to set
+	 * ->private as a NULL pointer, therefore no need to set ->private after
+	 * allocation.
+	 */
+	bridge = devm_pci_alloc_host_bridge(&hdev->device, sizeof(struct acpi_device *));
 	if (!bridge)
 		return -ENOMEM;
 
-- 
2.32.0

