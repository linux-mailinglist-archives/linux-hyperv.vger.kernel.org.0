Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1EF23C82DD
	for <lists+linux-hyperv@lfdr.de>; Wed, 14 Jul 2021 12:29:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239119AbhGNKcZ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 14 Jul 2021 06:32:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239096AbhGNKcY (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 14 Jul 2021 06:32:24 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F79FC061760;
        Wed, 14 Jul 2021 03:29:33 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id ay16so723277qvb.12;
        Wed, 14 Jul 2021 03:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AJUjK4/VFCQ/TP7J5j1RckVIjIlpsxzAZdtnL2G5Q9I=;
        b=nn0xpgZ2PBdAWYP+fMz5Wj1N11ZjtmR0VJ7ChNKx1A44qRNj03WxfjzYwdlKXoZUiv
         C+z8b7XusSAbzRz7ju2rDpWPOeDuVjXLp9i0LKGxoaHn4MfTu6oEF1WVZAnvlomiR2n9
         s/g4O5UenB8hxTvfv8pzeMsVD4SL4VecLlERF3XQlEsZrvFFdjde+oPlRXgS40RDQUgi
         wgNEuBYVY2+NjLtLTtSOZ67D2n8Gky50RcMFQPV1CyYbyydRww3BsLMX6uaQqwMn/n7Y
         5djxwhCjLoxBwhMeiNW2Jn7kla4dpX/122DPLfwWqMrL+Y/rrm35Y0Rj4XY8gnVLnoqU
         0BUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AJUjK4/VFCQ/TP7J5j1RckVIjIlpsxzAZdtnL2G5Q9I=;
        b=svn1zL3InaFxLBm1GuYZdZpldF9bEAJcHa/J6kjUJm6qVdi6G7MVOffYzhtSOM4spa
         XaZwouB13ve6n2dJnljxuPWCTfP+hxBCsTMxmXJXi7sIxg6PX21euDjuSYx9vE4kvZw+
         D+jIIdLVMrkrvIkmaYDEmmDOzzDO3l9JU2a5EwWeqc+GJkbQ7GNrjw4qoEie4ursEpZ/
         BKunQhzSUP90VoAjm9GgiR+ZMlwIIk0DYoBt91rqBsaag3Uce3EzfSweTLV9teZfdim4
         K5CmEh8IpC/GJUUhQ2BtvtkxON7dFWNn2q9E+eIKgMII0CTxetHqPAWdSI2JRKgqa3bR
         T4mA==
X-Gm-Message-State: AOAM532+O3/DLwk51jZ6+TNWHdOO5N8AZZ3A2744lLFxsC+q3TgwYQxJ
        TXhXgZSuHpfWVou4eG7vN88=
X-Google-Smtp-Source: ABdhPJzm+7agwprpp/QPPMKRTn9v3zu1l7XQ0J59ezVzkrjj6cvdedKqticWumi2f9eJbC7pXdiPTg==
X-Received: by 2002:a0c:d68f:: with SMTP id k15mr9971850qvi.14.1626258572392;
        Wed, 14 Jul 2021 03:29:32 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id n64sm819743qkd.79.2021.07.14.03.29.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 03:29:32 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailauth.nyi.internal (Postfix) with ESMTP id 2148B27C005A;
        Wed, 14 Jul 2021 06:29:31 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 14 Jul 2021 06:29:31 -0400
X-ME-Sender: <xms:irzuYG5sqlsNSxcgC5p5fBk6KV91DrPXhwTx_KUrMwRneQZNkMkXSA>
    <xme:irzuYP4aWcZjvwDUOpyK_O6IBCSrlrX0POcmzrjgTtDZMko5MmuYPLFUyjy0BJ5Kr
    q2tLG2aPMHbMt7NPA>
X-ME-Received: <xmr:irzuYFcKuZ8I9i13_MnJk57SB7NSyljDURw81Bj2OwtAoIW8oCeeR52eYULwHw>
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
X-ME-Proxy: <xmx:irzuYDL9KoAJKYAbjZQEpDx2k6p5Htrcl-473NEyikxbSXCdwRLexw>
    <xmx:irzuYKJ-JDR5KhDd1RQ8zAplb6IZKn7RtBZvWhljwABRQ9BGB_kXJw>
    <xmx:irzuYEwTjregfbpKydwRq-yeboFJwbKxI2rdeyNZfBMUxIP7KLqtJA>
    <xmx:i7zuYPAsbboot2miptM5cRWhIoiEGcTcZUuW_jOzojA3FT4XRY5Zn4k7rI8>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 Jul 2021 06:29:30 -0400 (EDT)
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
Subject: [RFC v4 2/7] PCI: Allow msi domain set-up at host probing time
Date:   Wed, 14 Jul 2021 18:27:32 +0800
Message-Id: <20210714102737.198432-3-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210714102737.198432-1-boqun.feng@gmail.com>
References: <20210714102737.198432-1-boqun.feng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

For GENERIC_MSI_IRQ_DOMAIN drivers, we can set up the msi domain via
dev_set_msi_domain() at probing time, and drivers can use this more
generic way to set up the msi domain for the host bridge.

This is the preparation for ARM64 Hyper-V PCI support.

Originally-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 drivers/pci/probe.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 60c50d4f156f..539b5139e376 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -829,11 +829,14 @@ static struct irq_domain *pci_host_bridge_msi_domain(struct pci_bus *bus)
 {
 	struct irq_domain *d;
 
+	/* Default set by host bridge driver */
+	d = dev_get_msi_domain(bus->bridge);
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
2.30.2

