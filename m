Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A44B3D6671
	for <lists+linux-hyperv@lfdr.de>; Mon, 26 Jul 2021 20:07:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232563AbhGZR1K (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 26 Jul 2021 13:27:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232932AbhGZR1C (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 26 Jul 2021 13:27:02 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BD41C061757;
        Mon, 26 Jul 2021 11:07:31 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id a13so13018630iol.5;
        Mon, 26 Jul 2021 11:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ns44FNukMo+K/GdbdwIRO17eOlRJPmgD6DOGKw8j/qk=;
        b=KBQcL16JQFKel+e1lKltZyyZ85WqvV7RF47MQftglKAfWwn8y8HDR/cc6z+DFalZ1j
         t/kljDx6yrPLGs/PKFk+i6B9xFl6QQkUX/w3r7rjFW4sdf5RjP/0GE6IWy/pG0hcrGgB
         NU+p3enGgnaKJz4wMZldQVbtbl9sdqV7O74v+LokzJC0j5IhzSWWRjU1Ur6zO84AbtEy
         SFkObNeqFgyksXMd719sQ4o1HQqP8jSJVSPtS1Fz0558iQxsPw8FAAF0oRqjGqE6ipGR
         QijR+LU8GGClflxTbSXdI4pB8Yi9tqcdwVzsCDBLC7rurBlsZaMNNtp8fKasohm5PmNK
         UfvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ns44FNukMo+K/GdbdwIRO17eOlRJPmgD6DOGKw8j/qk=;
        b=mou9hxYYIq29yKM9BTd9IfOQsZ6h6I0Au6v8FiHxxqCG24dnXBOeTYk5Rq94TsRUbF
         EUqsLvl1Y1/YEcRUDqDMx1pW0kOr0+7gyouUWgtO/HPRuq2zsN1CidS/jTQ6ArmJLfv+
         5IK9MfywLDx6O1b1ZLp4gxsCRutehHkwIJi2sshxgpx3HTy3soGkkjfwU41KbPXmW2bG
         8VYuFYUODura5LZVhZQCP+BZO/tBDPdFHAtu10wxOQfaN2qaY77PqX85EPeZG9a3y70T
         Elu6ocVGbNd45bBG24tsZsxPT2z+EDxHbFsy/QZZOt2KUjkbmg+77G0MyiqndiZ+P4Wf
         d1GA==
X-Gm-Message-State: AOAM531kk5UYHQSwEfTqgg8T/vHN83ourNTCfRbiRqqPAVnh2AWYeC43
        8IpCCMeOIh+hKZD2wwwl14Y=
X-Google-Smtp-Source: ABdhPJwiDFVYlhdrrPutkRS+DeyESaY7ATEBTs6wA/UCBtjvRPyO4hZfEHkOY7xsCRZfP3Kri+wCag==
X-Received: by 2002:a02:c906:: with SMTP id t6mr17878623jao.117.1627322851025;
        Mon, 26 Jul 2021 11:07:31 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id x9sm392322iol.2.2021.07.26.11.07.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 11:07:30 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailauth.nyi.internal (Postfix) with ESMTP id B6BA427C0066;
        Mon, 26 Jul 2021 14:07:29 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 26 Jul 2021 14:07:29 -0400
X-ME-Sender: <xms:4fn-YCBMCPa03Y4z8bksyXEnUBE5a3UIDZ-e6YUhJj8jI9-70KTqPw>
    <xme:4fn-YMhFY2tYw902JsHYAIo6mjNBHQrxSWTN9lLvKLYE2Y4UoxtIWqe153txJFIat
    aobafkqU_0G7x80hg>
X-ME-Received: <xmr:4fn-YFm-tqWZ5VjJ3bghBfOzqViUsDZ0ggyNQF0-2-VKKwS9LoM56o9rIyU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrgeehgdduudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhephedvveetfefgiedutedtfeevvddvleekjeeuffffleeguefhhfejteekieeu
    ueelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsg
    hoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieeg
    qddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigi
    hmvgdrnhgrmhgv
X-ME-Proxy: <xmx:4fn-YAxuwqrb0Woeb7mSUXffeSZAWdebc30eNbEbPZjUWGAhcKW_rg>
    <xmx:4fn-YHRn-3p4fRx2tVuODDzHjIFK2JiWa4b04S7IoEMvXE1O7dpgEQ>
    <xmx:4fn-YLbg07PtyxonBeDkwDYIrN_eQa0xxxYNgHszJoXn8Z8xxl5qpA>
    <xmx:4fn-YIIGPOJhjIwyv067W7aqzZ8FxgIrTiBf5X45lroNl-GMVAIlbJRVMmk>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 Jul 2021 14:07:29 -0400 (EDT)
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
Subject: [PATCH v6 7/8] PCI: hv: Set up MSI domain at bridge probing time
Date:   Tue, 27 Jul 2021 02:06:56 +0800
Message-Id: <20210726180657.142727-8-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210726180657.142727-1-boqun.feng@gmail.com>
References: <20210726180657.142727-1-boqun.feng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Since PCI_HYPERV depends on PCI_MSI_IRQ_DOMAIN which selects
GENERIC_MSI_IRQ_DOMAIN, we can use dev_set_msi_domain() to set up the
MSI domain at probing time, and this works for both x86 and ARM64.

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
2.32.0

