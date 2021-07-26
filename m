Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 084413D666F
	for <lists+linux-hyperv@lfdr.de>; Mon, 26 Jul 2021 20:07:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233240AbhGZR1J (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 26 Jul 2021 13:27:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232922AbhGZR1C (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 26 Jul 2021 13:27:02 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60B31C0613C1;
        Mon, 26 Jul 2021 11:07:30 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id j21so13003217ioo.6;
        Mon, 26 Jul 2021 11:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BKnYIljYr328ZulqWfxspol6sVJsE3IO6EjcczLUtpo=;
        b=pX7rlM6GUHNhhHEyiZzWNV2XqI30x9vSAqXrtHl2nHY8pbp7dMsW7WWjyBC1J7b63A
         /SrFGJFS2td9+cgI8G4TmejkeXXdj8UZ8Tp0eR0yoB9ctMBG1iAXFJjMvI8PEktB+EHA
         edvZR0kkAI1JJU4Wb//FkNzGzg3HV9RjHhNvVGgSbGJLHZ31KYZZ1FU71bPu7GLid24k
         kW3CvwXLLmq8QK5PC+6qGnXSiXjWYOWQz8fbkTMAPG7GzRR78+wfLaYT4r1kDyuHxqe8
         GBvJQK5A3Ffa1MMP75v4s/+OYV061ni+hjc+Pc/bTGrnG1dpU1h2ZxCGTCny2GTZKqVp
         vZTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BKnYIljYr328ZulqWfxspol6sVJsE3IO6EjcczLUtpo=;
        b=SCanAAeq8vtGM1mRtcx774ec8iVN6pm8HlbGzEaPA5aNqfJUmQ3vaFQeSvGVpfv33K
         eqLOQXuOsIBsvkiZfu+CyhD0PDyC2/mg7mm8nfybT69XGU14jk60DmCIbx/2bdnT4vKU
         LhyWMUcyoRglYYN91OCWcgrzwaEEEqm6VYz/fo7zjlll24rGaGWtGlANIwcB208AE+2i
         856nnQ6t62q5wT1wHHpcuMhQy1OJYCOiqEXZ79snAHQMt6uBdchJDYLW0A1HYq+cnD//
         yzlu4ten3j4BCQ1gNL7g0B5tZWHs/+NpxAOLqGFa7d8G3keJCgjhAFOZzxGUDg5/x0IO
         fmhQ==
X-Gm-Message-State: AOAM533RzIv6lrGpIY2ioZDKKFsxC+gYkMBuGr9aJgnQlAioqqUJ+eLN
        8eVHzQuNoZdLFg22v+R+Xbg=
X-Google-Smtp-Source: ABdhPJyGwT6K4xCYTa1+mA3eODO7pnAlMAube8Sg+6Ainm9/jy9B1/ByuhGCqg19qPiV7LnvSxWg9Q==
X-Received: by 2002:a02:9648:: with SMTP id c66mr18075440jai.73.1627322849866;
        Mon, 26 Jul 2021 11:07:29 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id v10sm304163iox.35.2021.07.26.11.07.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 11:07:29 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailauth.nyi.internal (Postfix) with ESMTP id 70B3627C0068;
        Mon, 26 Jul 2021 14:07:28 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 26 Jul 2021 14:07:28 -0400
X-ME-Sender: <xms:4Pn-YKiL9mOULJvV7GCn09CdNoQyhepC3WqqqclmLRXXnQz6wBqqSQ>
    <xme:4Pn-YLCCSMgHIZUUI6jEPIc_PfY4aZXUSd4w3tmJqcOEA0E7UPdnbh43v-BSpCTio
    gurb2E_hsXd0ZbVAA>
X-ME-Received: <xmr:4Pn-YCEd6n3he00I3sTdPNdxKY6XRn3d7BduQfmyB3HNQtNohsIv80vIe-w>
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
X-ME-Proxy: <xmx:4Pn-YDR5KbDRm0iopk3QlHMsRZiNFPA4_hGgi3jOubn6tYxRXYb65w>
    <xmx:4Pn-YHwXwVTmFewjdmUKQsPynQ2O_yd3sJl13PMJt8_RDzR0895T8w>
    <xmx:4Pn-YB4Eh0BbMQgsQ-kNWMTuvGCkZsvJGKty5BMVTyA8bpy5O5XQaA>
    <xmx:4Pn-YIoBUa0quyFvBrBK2ofJJ4pimNF3QjXeAdmjB8Mc-icx4YMSkE7DiRY>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 Jul 2021 14:07:27 -0400 (EDT)
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
Subject: [PATCH v6 6/8] PCI: hv: Set ->domain_nr of pci_host_bridge at probing time
Date:   Tue, 27 Jul 2021 02:06:55 +0800
Message-Id: <20210726180657.142727-7-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210726180657.142727-1-boqun.feng@gmail.com>
References: <20210726180657.142727-1-boqun.feng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

No functional change, just store and maintain the PCI domain number in
the ->domain_nr of pci_host_bridge. Note that we still need to keep
the copy of domain number in x86-specific pci_sysdata, because x86 is
not a PCI_DOMAINS_GENERIC=y architecture, so the ->domain_nr of
pci_host_bridge doesn't work for it yet.

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
2.32.0

