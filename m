Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FF893716FA
	for <lists+linux-hyperv@lfdr.de>; Mon,  3 May 2021 16:48:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbhECOsu (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 3 May 2021 10:48:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbhECOso (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 3 May 2021 10:48:44 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFAF3C061763;
        Mon,  3 May 2021 07:47:50 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id jm10so2669315qvb.5;
        Mon, 03 May 2021 07:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QWGd3JZfCgq7eTKfJP0e8l8aGD/9nEGlQMt+hKKZY8A=;
        b=pSkfiyb0wtubGvLMi2eXrfzDkJ5X9eLg/4Me5N9YOiME/jPpHKHSwGwsXH1+X1BcSb
         HlcPE2vOJFcg7orkh4S9K5GSwhd/ytSDy00syRcCCUuZYivKJFufAE/XWV1FFrf1jpeF
         mvjia0KQQmZcP/goMIGJknd325xKQCRhCUfJe3RmXEhAwNwRDxTmpJilBF4B3IXCF5+y
         wsq/KrzAA0bp2cXTqsVihNVSS66srFWnf6k73SF2VwwpNIVQfQVL9ilYFvzz8vWEk5Xg
         odwKKCYTmR32q4yH9WhxmerI/HiVkYMllNfDrTvVcP2inTA2602GZAfDPkF0xsq3KH5F
         4WDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QWGd3JZfCgq7eTKfJP0e8l8aGD/9nEGlQMt+hKKZY8A=;
        b=I+e1fm/Lfo3S3ljp5trE6fwo57QgfNS+3tn0cVEpbzydiklcqFfIBWwLB7d+Dh/3x6
         kjhTjOIJnlf6/jXn8o18lCAOQyTyl3OnA4CBgdMh6hro+ZjI8PIQbnYeNKbPXzJ353Gi
         UcqyMWoYumWdDZIM2Tqn2OSZiFzGcZmnIrWS361Jrx0bakGnXmM5t7eVJcYaiUwjRDuC
         5HrdwBshyJfXOEhQPitOpM/Ip+oiIKAW6rc9YNNBoT1DhTZvzmvv4phL7l97nVRlkQ6o
         K+ZA34bWBj8M7kE50PxtPQfj2O8olNHXF1oxjak2FAdrauMZEEdcPftw7YPSX7BngQiX
         qdMg==
X-Gm-Message-State: AOAM531vPl41/watcMS/whLwJhOG6yrMVt+QL3eecWZdqC8HzmAbUa9H
        7TuPxR724k66YIrnBNTlzdA=
X-Google-Smtp-Source: ABdhPJxGkDhQ4Z7gX1EcIbTfincvhtJ+ymk7z9TCLM44IZ4v0r18q4U9mIVYSELaANxcDuZJOCoJ4g==
X-Received: by 2002:a0c:ea86:: with SMTP id d6mr16429735qvp.5.1620053270101;
        Mon, 03 May 2021 07:47:50 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id o12sm5247623qtq.96.2021.05.03.07.47.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 May 2021 07:47:49 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailauth.nyi.internal (Postfix) with ESMTP id D923D27C0054;
        Mon,  3 May 2021 10:47:48 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 03 May 2021 10:47:48 -0400
X-ME-Sender: <xms:FA2QYA-uxhkAancjlNJsjaWinJJWDIc1vylVsu4iriaRr3rjpJaN4w>
    <xme:FA2QYIuywzkMGMVHeC7c-Y6ckiBen-u4Ua05FScaVwbPRBUkl76ZZZ_KeXHZpa7va
    I11QJx2NlsAb97ppQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdefgedgkedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhephedvveetfefgiedutedtfeevvddvleekjeeuffffleeguefhhfejteekieeu
    ueelnecukfhppedufedurddutdejrddurddvheegnecuvehluhhsthgvrhfuihiivgepud
    enucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgv
    rhhsohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfh
    gvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:FA2QYGA_QIQr5iws015R2m2m59-iwN4QNVuAjqtwE91qTOzgYVXowg>
    <xmx:FA2QYAeorvnoT91XAhkJTKHbXpoPEbiUPGJxcvoEQsf84EtnNF-S6Q>
    <xmx:FA2QYFOZC2_krBC-zBHM_AbTYoJzATSMxOJC07xa-b0C5TDtEZaNaA>
    <xmx:FA2QYHW9_biAoooqVVir-KPcPz18n2Xh20ikBBV_-ZyYSipm2NQGaFa8SxvN5BTJ>
Received: from localhost (unknown [131.107.1.254])
        by mail.messagingengine.com (Postfix) with ESMTPA;
        Mon,  3 May 2021 10:47:48 -0400 (EDT)
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>,
        Marc Zyngier <maz@kernel.org>
Cc:     Russell King <linux@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Mike Rapoport <rppt@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jon Derrick <jonathan.derrick@intel.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-hyperv@vger.kernel.org
Subject: [RFC v2 5/7] PCI: hv: Set up msi domain at bridge probing time
Date:   Mon,  3 May 2021 22:46:33 +0800
Message-Id: <20210503144635.2297386-6-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210503144635.2297386-1-boqun.feng@gmail.com>
References: <20210503144635.2297386-1-boqun.feng@gmail.com>
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
index 05b73d5dfe9d..4ec7839d0adf 100644
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
@@ -1571,7 +1572,7 @@ static int hv_pcie_init_irq_domain(struct hv_pcibus_device *hbus)
 	hbus->msi_info.handler = handle_edge_irq;
 	hbus->msi_info.handler_name = "edge";
 	hbus->msi_info.data = hbus;
-	hbus->irq_domain = pci_msi_create_irq_domain(hbus->sysdata.fwnode,
+	hbus->irq_domain = pci_msi_create_irq_domain(hbus->fwnode,
 						     &hbus->msi_info,
 						     x86_vector_domain);
 	if (!hbus->irq_domain) {
@@ -1580,6 +1581,8 @@ static int hv_pcie_init_irq_domain(struct hv_pcibus_device *hbus)
 		return -ENODEV;
 	}
 
+	dev_set_msi_domain(&hbus->bridge->dev, hbus->irq_domain);
+
 	return 0;
 }
 
@@ -3147,9 +3150,9 @@ static int hv_pci_probe(struct hv_device *hdev,
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
@@ -3227,7 +3230,7 @@ static int hv_pci_probe(struct hv_device *hdev,
 free_irq_domain:
 	irq_domain_remove(hbus->irq_domain);
 free_fwnode:
-	irq_domain_free_fwnode(hbus->sysdata.fwnode);
+	irq_domain_free_fwnode(hbus->fwnode);
 unmap:
 	iounmap(hbus->cfg_addr);
 free_config:
@@ -3325,7 +3328,7 @@ static int hv_pci_remove(struct hv_device *hdev)
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

