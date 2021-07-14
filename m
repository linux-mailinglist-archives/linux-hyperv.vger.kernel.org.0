Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F6B53C82E4
	for <lists+linux-hyperv@lfdr.de>; Wed, 14 Jul 2021 12:29:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239144AbhGNKcb (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 14 Jul 2021 06:32:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238728AbhGNKc3 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 14 Jul 2021 06:32:29 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 377E1C061766;
        Wed, 14 Jul 2021 03:29:37 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id g8so1463935qth.10;
        Wed, 14 Jul 2021 03:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=whrqx7S/6ArEqBZa1UoQwNLZIIZFAIXLGfuEnNJo6+E=;
        b=GWCio3dmCWMxhi0Hlb6ME6Vnx1TNNM4BffNZVN464KPAkLW7GVAOqEdHG1qhct5fbE
         cF2LiZQf0bIoQ56Zd0ut46zjF2jvEnJAAhwV0SjVVmZHc/pxhoMO7uXSOAj+ltoK32uw
         bZq85a4CCnOuKRbq2QZRIk0rrvF+Ah7mLRgdx5GPz8FFkbMBPJ9o6Mabe/dsN36hhxGG
         QmjuwWIzMKdMcAPXumFv6a0XI5mv28W9W+Tu+HXJxeaW3zXXyrFHip/lGJ6cdGvtiTv1
         sREOPUCxdyL/uY7hVEgMxKzN73+UQ12XwAwXddTY04BYgsZ2e3vq33iZiswYsmZkwa1o
         jcgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=whrqx7S/6ArEqBZa1UoQwNLZIIZFAIXLGfuEnNJo6+E=;
        b=pNNzxfufvUN0r2SC21NcE0e1ERP8sIvDKkLpOuy4r18IDarW+wXyqEs5FshDTbVAtH
         E/Uv+RHVjKMFYFLPAaGxD5vXjsWfF/sc1GxehODNU1dx7p9WY0IoGjWjIlVIGetW9idq
         Equj4NC8n0SLDHPuJ+N8VO/3a0zDEQGsk99crTIL3m/hePmSdPVWjGZsk8M3q5h1gXo5
         yaIcRMAltmH6z7dxxIDmmYbp7XdaRoTUfKoskN2trFSMCyHGGuM6qRuM2TOc172q6Sjn
         bRqNPcv7qzds76kBXaa7oFdrjKbH/VImbOKglHxssZfGDumxRxQ640Sele0xW5NDzV4C
         hLig==
X-Gm-Message-State: AOAM530QLtyFpc2GY+uGMNAYM1zaLcKT6fOXJRMnB7Oy18tiMN9oxde5
        as+sFb0HSjDYoDa60yU0T/s=
X-Google-Smtp-Source: ABdhPJwlf04xGZajypUy8gTnChPsSNYLZwPxkvXTnSa2OFm2z8oRT063aRVBIcD6a3Tmd47utX/qkA==
X-Received: by 2002:ac8:7d04:: with SMTP id g4mr8855257qtb.384.1626258576433;
        Wed, 14 Jul 2021 03:29:36 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id h10sm822245qka.83.2021.07.14.03.29.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 03:29:35 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailauth.nyi.internal (Postfix) with ESMTP id 1D69327C005B;
        Wed, 14 Jul 2021 06:29:35 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 14 Jul 2021 06:29:35 -0400
X-ME-Sender: <xms:j7zuYGWQpKAeQgtJxrbwRENJa8bbmOzqRoBuPO6yDJ0IyEvjV3qcYg>
    <xme:j7zuYClV3jrrzBtrlCvZ1_REhIsvgONLBg4slOJ0zfXkLU1G_cTzvn-6OuZXL2zk5
    noYtJV3w5GwB9NrGQ>
X-ME-Received: <xmr:j7zuYKZwWdivIoAryQnhq2MRQmFlO776R4jMMiDVeI2wodylCaS3nOrkQoNdTQ>
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
X-ME-Proxy: <xmx:j7zuYNWGNYttQkg3hnbuIpOYFx5U1foG08mp2D9OHKyiNwz6-y2WzQ>
    <xmx:j7zuYAmLjZsuTkTMEtVl-qiIneBDrNRJ_gJN0ElKVMWkMpStZlIe9Q>
    <xmx:j7zuYCflYOGc8X8wtW2X34bCmqadLXVcwWUxTrc-aWbmTbfbhKvOEg>
    <xmx:j7zuYPfeQwVyCITC-raX9qlJpaJvCQ5XIL57PFhzRBJK2kGPR0_o9Oug8Ng>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 Jul 2021 06:29:34 -0400 (EDT)
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
Subject: [RFC v4 5/7] PCI: hv: Use pci_host_bridge::domain_nr for PCI domain
Date:   Wed, 14 Jul 2021 18:27:35 +0800
Message-Id: <20210714102737.198432-6-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210714102737.198432-1-boqun.feng@gmail.com>
References: <20210714102737.198432-1-boqun.feng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

No functional change, just store and maintain the PCI domain number in
the generic pci_host_bridge instead of x86 specific pci_sysdata.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 drivers/pci/controller/pci-hyperv.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index 8d42da5dd1d4..5741b1dd3c14 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -2299,7 +2299,7 @@ static void hv_eject_device_work(struct work_struct *work)
 	 * because hbus->bridge->bus may not exist yet.
 	 */
 	wslot = wslot_to_devfn(hpdev->desc.win_slot.slot);
-	pdev = pci_get_domain_bus_and_slot(hbus->sysdata.domain, 0, wslot);
+	pdev = pci_get_domain_bus_and_slot(hbus->bridge->domain_nr, 0, wslot);
 	if (pdev) {
 		pci_lock_rescan_remove();
 		pci_stop_and_remove_bus_device(pdev);
@@ -3071,6 +3071,7 @@ static int hv_pci_probe(struct hv_device *hdev,
 			 "PCI dom# 0x%hx has collision, using 0x%hx",
 			 dom_req, dom);
 
+	hbus->bridge->domain_nr = dom;
 	hbus->sysdata.domain = dom;
 
 	hbus->hdev = hdev;
@@ -3080,7 +3081,7 @@ static int hv_pci_probe(struct hv_device *hdev,
 	spin_lock_init(&hbus->device_list_lock);
 	spin_lock_init(&hbus->retarget_msi_interrupt_lock);
 	hbus->wq = alloc_ordered_workqueue("hv_pci_%x", 0,
-					   hbus->sysdata.domain);
+					   hbus->bridge->domain_nr);
 	if (!hbus->wq) {
 		ret = -ENOMEM;
 		goto free_dom;
@@ -3207,7 +3208,7 @@ static int hv_pci_probe(struct hv_device *hdev,
 destroy_wq:
 	destroy_workqueue(hbus->wq);
 free_dom:
-	hv_put_dom_num(hbus->sysdata.domain);
+	hv_put_dom_num(hbus->bridge->domain_nr);
 free_bus:
 	kfree(hbus);
 	return ret;
@@ -3315,7 +3316,7 @@ static int hv_pci_remove(struct hv_device *hdev)
 	irq_domain_remove(hbus->irq_domain);
 	irq_domain_free_fwnode(hbus->sysdata.fwnode);
 
-	hv_put_dom_num(hbus->sysdata.domain);
+	hv_put_dom_num(hbus->bridge->domain_nr);
 
 	kfree(hbus);
 	return ret;
-- 
2.30.2

