Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD4113C82E6
	for <lists+linux-hyperv@lfdr.de>; Wed, 14 Jul 2021 12:29:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239130AbhGNKcb (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 14 Jul 2021 06:32:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239137AbhGNKc3 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 14 Jul 2021 06:32:29 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 656C7C061767;
        Wed, 14 Jul 2021 03:29:38 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id e14so1037342qkl.9;
        Wed, 14 Jul 2021 03:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5lYVAl5pvq321nWlC1xJtj8cB/i93LY8ECKiLgnJmb4=;
        b=s8JxMXmb/W9eRMVaIAJ9wNgmb/nC+3S3ecleRWZgrGL+r5XajGrzo5CLpSu9H6wDDm
         AZFxknJ67wYkeI4qDWwld0xIOq1td/eiditnYv1hXSG+WgVmZJCJ57Ccj356jsiKA86s
         DL6FNaUGD5rBs7FXa3ODgkXzGijtd9O0bZRieOsdlai6vhxHCkmCPFd1Q0pXFeo0XyUa
         67zCOug4sx7ac3XNOXupx4Pmqodslj2MftWmJrXaLPNdQBt9KXJV4Ibr1YhE6Wzkj8dN
         pV4MC2M0hw00Jhs2NBbsNXNaxzXuEp4T2hjcImyoeUC5pKg2BQ42ZTcUoD0zf9HG5ul7
         vbfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5lYVAl5pvq321nWlC1xJtj8cB/i93LY8ECKiLgnJmb4=;
        b=fLpM9rEdyNul7xXawOOc9Uq2I0YHQtd8MevCqeqsFs92Loiohy3T9FV4NN6PvpHVCO
         8vfzqUbXUk17s7lx/mWtWtGd5ABVtMNv8hJqdtN7fxXych0e7qOoUseFEtn8IAR6Xpk6
         weMCVKWglj1zJVaTQ6xYaWMWY6Hm+lQgarFc+XMIWtd7FbV35BJyp96PyFgNMkJBWr97
         FNWZpr9m4qVnNh6cT+1ARJFvaRkAj/xko2PKrR/L2vYjBPemLuX5LxdDvUd0WvemLUvW
         RwmL+Qzb78DCh4fYTVou4QZTTOH0q3Z0+6aHvayl53CzhJq31LaH1QdiQyT89LLeUCcv
         nksw==
X-Gm-Message-State: AOAM532BTofRrGQjNtle1wErN59KleD4aA18c8B0dd7V6oJbfq9prabv
        ceEiVToRkL3ixZvtou8ZxkI=
X-Google-Smtp-Source: ABdhPJyYvT4ycgzf/g3XR+yoby5oMMU39KT+li/UNG+QT7wrtx7qA1oPBJ2qkMEUv5eS3TcngvjFiw==
X-Received: by 2002:a37:4685:: with SMTP id t127mr9210826qka.384.1626258577660;
        Wed, 14 Jul 2021 03:29:37 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id m187sm791699qkd.131.2021.07.14.03.29.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 03:29:37 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id 4999327C0054;
        Wed, 14 Jul 2021 06:29:36 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Wed, 14 Jul 2021 06:29:36 -0400
X-ME-Sender: <xms:kLzuYBmZvB0YqGEU-HLoWqExntX_qsvqmr5_x0Y_9ZjPikRiZbGEBw>
    <xme:kLzuYM3B2zNTc1BNE49-Jy0rJ16APwVisSuj6UO6BsDsxnTPcnQza_8t9AqlCOsMK
    A-0_ZQG44IIJnLSYg>
X-ME-Received: <xmr:kLzuYHoKDOvivYBRElpGVgkBBIUptVg6CZPVn2nyLJx1X0zdcJIvuW22AkXgKg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudekgddvkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtth
    gvrhhnpeehvdevteefgfeiudettdefvedvvdelkeejueffffelgeeuhffhjeetkeeiueeu
    leenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpegsoh
    hquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedq
    udejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmh
    gvrdhnrghmvg
X-ME-Proxy: <xmx:kLzuYBl-5Z5ehzV3u2WAB-Z_GZzHsEPwwsYTo3fqRUWUFZFJvZiWHQ>
    <xmx:kLzuYP3qUADxDeVDHJt7nQZq63TNT2tx6o_AphBuOZXf8V2HURlysw>
    <xmx:kLzuYAv4tV0c4XPUpKTBBHawwVaNCi73E8XGjMGGeUU5uMdvqPe5kw>
    <xmx:kLzuYGtOr5xcD4_1mCNA6stDELhR3l4Grns9qNpOoUuH8x-_ReHedaoZMc4>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 Jul 2021 06:29:35 -0400 (EDT)
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
Subject: [RFC v4 6/7] PCI: hv: Set up msi domain at bridge probing time
Date:   Wed, 14 Jul 2021 18:27:36 +0800
Message-Id: <20210714102737.198432-7-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210714102737.198432-1-boqun.feng@gmail.com>
References: <20210714102737.198432-1-boqun.feng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Since PCI_HYPERV depends on PCI_MSI_IRQ_DOMAIN which selects
GENERIC_MSI_IRQ_DOMAIN, we can use dev_set_msi_domain() to set up the
msi irq domain at probing time, and this works for both x86 and ARM64.

Therefore use it as the preparation for ARM64 Hyper-V PCI support.

As a result, no longer need to maintain ->fwnode in x86 specific
pci_sysdata, and make hv_pcibus_device own it instead.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 drivers/pci/controller/pci-hyperv.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index 5741b1dd3c14..e6276aaa4659 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -450,6 +450,7 @@ enum hv_pcibus_state {
 struct hv_pcibus_device {
 	struct pci_sysdata sysdata;
 	struct pci_host_bridge *bridge;
+	struct fwnode_handle *fwnode;
 	/* Protocol version negotiated with the host */
 	enum pci_protocol_version_t protocol_version;
 	enum hv_pcibus_state state;
@@ -1565,7 +1566,7 @@ static int hv_pcie_init_irq_domain(struct hv_pcibus_device *hbus)
 	hbus->msi_info.handler = handle_edge_irq;
 	hbus->msi_info.handler_name = "edge";
 	hbus->msi_info.data = hbus;
-	hbus->irq_domain = pci_msi_create_irq_domain(hbus->sysdata.fwnode,
+	hbus->irq_domain = pci_msi_create_irq_domain(hbus->fwnode,
 						     &hbus->msi_info,
 						     x86_vector_domain);
 	if (!hbus->irq_domain) {
@@ -1574,6 +1575,8 @@ static int hv_pcie_init_irq_domain(struct hv_pcibus_device *hbus)
 		return -ENODEV;
 	}
 
+	dev_set_msi_domain(&hbus->bridge->dev, hbus->irq_domain);
+
 	return 0;
 }
 
@@ -3118,9 +3121,9 @@ static int hv_pci_probe(struct hv_device *hdev,
 		goto unmap;
 	}
 
-	hbus->sysdata.fwnode = irq_domain_alloc_named_fwnode(name);
+	hbus->fwnode = irq_domain_alloc_named_fwnode(name);
 	kfree(name);
-	if (!hbus->sysdata.fwnode) {
+	if (!hbus->fwnode) {
 		ret = -ENOMEM;
 		goto unmap;
 	}
@@ -3198,7 +3201,7 @@ static int hv_pci_probe(struct hv_device *hdev,
 free_irq_domain:
 	irq_domain_remove(hbus->irq_domain);
 free_fwnode:
-	irq_domain_free_fwnode(hbus->sysdata.fwnode);
+	irq_domain_free_fwnode(hbus->fwnode);
 unmap:
 	iounmap(hbus->cfg_addr);
 free_config:
@@ -3314,7 +3317,7 @@ static int hv_pci_remove(struct hv_device *hdev)
 	hv_free_config_window(hbus);
 	hv_pci_free_bridge_windows(hbus);
 	irq_domain_remove(hbus->irq_domain);
-	irq_domain_free_fwnode(hbus->sysdata.fwnode);
+	irq_domain_free_fwnode(hbus->fwnode);
 
 	hv_put_dom_num(hbus->bridge->domain_nr);
 
-- 
2.30.2

