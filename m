Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 826FC3A1AF3
	for <lists+linux-hyperv@lfdr.de>; Wed,  9 Jun 2021 18:32:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232285AbhFIQeU (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 9 Jun 2021 12:34:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232165AbhFIQeU (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 9 Jun 2021 12:34:20 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 905E2C061760;
        Wed,  9 Jun 2021 09:32:25 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id l64so1741574ioa.7;
        Wed, 09 Jun 2021 09:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2QP+aooIgaNykddMTYMcLiVqjqY2nSO7f91rbFSftQ4=;
        b=mInlmwALviaiYQUx0afzCiTgkb1BiLfdzItjjT8qdPxWiKCDX3dCjGHRzO0Tt+HUFY
         BcGxAXmlc1CkORATdMGP3ICTSNP/KXm8xChX7xQzWLC1GLK/qqEnCj8Z9IDUxSrrfVcf
         s64aIlpzjyUJ8PvUMnAxHduxRYzCZMf2uRA4reJlq2wmw4y/9xSXDiB4ul+4+g8lbqyO
         C/9NpzgvkRWy1MsupRWxQcunEQpreUNdjd2z1ybVqbJKMtS4fS2HAAzBnLIwfSTAnPpX
         swwFSWafvo6+NCro9jsw2sV3K4ZWLfX90JxO82ihm7dAyyPfSof9ifx/EVSkQ++aWxnv
         SQ+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2QP+aooIgaNykddMTYMcLiVqjqY2nSO7f91rbFSftQ4=;
        b=U5uMqnDLr1SokEkhDI3cmy6cJaIfZ3JoUFa1p9PKttPiK2DQh9N4+mHlLdaMt5RTAl
         EydHErVajH4otaS8Rg5HkpjgRV79wRF/S8eOEYU+/Q9jG1e8RzqQIAQtJUySOjN5l+lh
         dUsWZ/So4s2uhe9h7W9yFE57UThFGwcDiGurkfnQW9mu5t4pmoRYMc1EexnJS9G70I1E
         pk4EohC1JNo0X57qQ52umotSjNjeb+99K7+ZGDSzZJ6R2lxRIAc7wyRkYTniIm8W/027
         Ag4L8RMQkT3P5XeGn2cf+NzqYc2Jz6h+mDredNOTcc71tgw6XZ1wietBTlyo1S7DPInU
         neNw==
X-Gm-Message-State: AOAM531q5dpK/fJLJtnU6b9CxFbTPMSazlYsIh7au8tKOwgNeUdHLbuy
        9UJHmnhq49/9HCcm0RiE5pc=
X-Google-Smtp-Source: ABdhPJy8E2PUp9QlOixOC91R/fd1nmvZB+codXg5z54MPEev8olrDFKgxrTKo1fnZuUktaWnMuSMzA==
X-Received: by 2002:a6b:5b06:: with SMTP id v6mr267414ioh.84.1623256345056;
        Wed, 09 Jun 2021 09:32:25 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id h20sm270056ilo.34.2021.06.09.09.32.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jun 2021 09:32:24 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailauth.nyi.internal (Postfix) with ESMTP id C4DEE27C005B;
        Wed,  9 Jun 2021 12:32:23 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 09 Jun 2021 12:32:23 -0400
X-ME-Sender: <xms:F-3AYGjy8BK7kmdkw429zGR9ou0VkLgKiRku9xYgGKRXYWf5VWxZ1Q>
    <xme:F-3AYHDCNnqimBGgJtvOKsdxBY_U1gZFu3Vu12jrxx-PCDY_uET8ZaatVUR6o615y
    jsjYEaVojS4DXKuvg>
X-ME-Received: <xmr:F-3AYOHBoZKKrwygxC1uWcKmq2fpDiH87EZLjzFjQrxAxKjOLzTc2cLMbs0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfeduuddguddtvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeehvdevteefgfeiudettdefvedvvdelkeejueffffelgeeuhffhjeetkeei
    ueeuleenucevlhhushhtvghrufhiiigvpeefnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdei
    gedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfih
    igmhgvrdhnrghmvg
X-ME-Proxy: <xmx:F-3AYPQeX-FYtqwbmy4y6H7iS_HhN2tGmtgHwncaulsjtrfGHm40eQ>
    <xmx:F-3AYDwqg8iAxKL4NuQbgywD-k78tBSjb1mR_WBnAaSk9BwHxbU8Rw>
    <xmx:F-3AYN5_AbBX9L66UL3pYAIei_SHahMTME5ABxHw8h0GQ6AK6duwNA>
    <xmx:F-3AYDC-q7kluMvnjkeySmHzc4_5ORVOOudKTo3oDI9djzNJhRuODszYTzo>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Jun 2021 12:32:23 -0400 (EDT)
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>, Clint Sbisa <csbisa@amazon.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Sunil Muthuswamy <sunilmut@microsoft.com>
Subject: [RFC v3 5/7] PCI: hv: Set up msi domain at bridge probing time
Date:   Thu, 10 Jun 2021 00:32:09 +0800
Message-Id: <20210609163211.3467449-6-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210609163211.3467449-1-boqun.feng@gmail.com>
References: <20210609163211.3467449-1-boqun.feng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Since PCI_HYPERV depends on PCI_MSI_IRQ_DOMAIN which selects
GENERIC_MSI_IRQ_DOMAIN, we can use dev_set_msi_domain() to set up the
msi irq domain at probing time, and this works for both x86 and ARM64.

Therefore use it as the preparation for ARM64 Hyper-V PCI support.

As a result, there is no need to set the pci_sysdata::fwnode which is
x86 specific. In addition, make hv_pcibus_device own the fwnode instead
of sysdata to make the code generic.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 drivers/pci/controller/pci-hyperv.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index f9a644ae3b74..16a779ab9ed4 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -451,6 +451,7 @@ enum hv_pcibus_state {
 struct hv_pcibus_device {
 	struct pci_sysdata sysdata;
 	struct pci_host_bridge *bridge;
+	struct fwnode_handle *fwnode;
 	/* Protocol version negotiated with the host */
 	enum pci_protocol_version_t protocol_version;
 	enum hv_pcibus_state state;
@@ -1570,7 +1571,7 @@ static int hv_pcie_init_irq_domain(struct hv_pcibus_device *hbus)
 	hbus->msi_info.handler = handle_edge_irq;
 	hbus->msi_info.handler_name = "edge";
 	hbus->msi_info.data = hbus;
-	hbus->irq_domain = pci_msi_create_irq_domain(hbus->sysdata.fwnode,
+	hbus->irq_domain = pci_msi_create_irq_domain(hbus->fwnode,
 						     &hbus->msi_info,
 						     x86_vector_domain);
 	if (!hbus->irq_domain) {
@@ -1579,6 +1580,8 @@ static int hv_pcie_init_irq_domain(struct hv_pcibus_device *hbus)
 		return -ENODEV;
 	}
 
+	dev_set_msi_domain(&hbus->bridge->dev, hbus->irq_domain);
+
 	return 0;
 }
 
@@ -3144,9 +3147,9 @@ static int hv_pci_probe(struct hv_device *hdev,
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
@@ -3224,7 +3227,7 @@ static int hv_pci_probe(struct hv_device *hdev,
 free_irq_domain:
 	irq_domain_remove(hbus->irq_domain);
 free_fwnode:
-	irq_domain_free_fwnode(hbus->sysdata.fwnode);
+	irq_domain_free_fwnode(hbus->fwnode);
 unmap:
 	iounmap(hbus->cfg_addr);
 free_config:
@@ -3322,7 +3325,7 @@ static int hv_pci_remove(struct hv_device *hdev)
 	hv_free_config_window(hbus);
 	hv_pci_free_bridge_windows(hbus);
 	irq_domain_remove(hbus->irq_domain);
-	irq_domain_free_fwnode(hbus->sysdata.fwnode);
+	irq_domain_free_fwnode(hbus->fwnode);
 	put_hvpcibus(hbus);
 	wait_for_completion(&hbus->remove_event);
 	destroy_workqueue(hbus->wq);
-- 
2.30.2

