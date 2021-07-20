Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 887633CFB58
	for <lists+linux-hyperv@lfdr.de>; Tue, 20 Jul 2021 15:54:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239284AbhGTNN3 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 20 Jul 2021 09:13:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239053AbhGTNGg (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 20 Jul 2021 09:06:36 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 466F7C0613E7;
        Tue, 20 Jul 2021 06:46:39 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id p3so19159300ilg.8;
        Tue, 20 Jul 2021 06:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=b0FLz1UQCL56QaMKdjohK7SVRTIsmP51WikzyAy5H0Q=;
        b=H3vtUYIiNFlHO5r0FklILVcfSa6f6KG+ZPlk+RER2u729Rkhx2Wp5YvDPFrIRRodf7
         Pk83aUF4gMd4dVJLCetVIaBnhMQ9SlllT2WQG/u/p9kuIT12rxJr32Q9sY/rOcYaicDe
         fRAuwvls4N9YYEC5xU7mqKj87pWpeKGXgivoxqy/sukIeqwpSpH0hFMf6josmn4PQPUe
         xyxsf3bx4tHEzHY/c8J3sxMi8eztHELTas6B9LTwxRFLye95nCE+JLx5sNeZWKI1i9IY
         YLXOWmJrFVO2f9S+tb9Yvd7zFqW9mdIxIfBthH0cWpfeeJUVCNop9sApSPdUFoHCosH7
         WbPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=b0FLz1UQCL56QaMKdjohK7SVRTIsmP51WikzyAy5H0Q=;
        b=AaArP+Jb9B9s8kudMyakYtp/tqZhp9Ye5ItqmWrDwCywV5Kx5hFXYuxHcUa9XFT/yU
         HdwFn0DBS6rERIFlaXGu1j0kA0ggv7EDikOplPuVHb56mzz3tZNVZGoshiCvM9yIpgfn
         xdZLG4gjtQB1XwFMsnnXKBb2a42rdzSfWwyX2MILjXhAGhfmSDagipdxzMnoTWEFKrUi
         TU8CyOtLeb0kPJT1wU7KtvMs8oatATtt9DCH53nTlJ/xgdBMJDTSFNECxYN2o2UWfg1/
         ajtKDpIQrSuHkURZB8iZ7QyyiMPYMv4YKl/RxSBq9gFl4jqZo4NaRw5wzjBUZcrdb/it
         QseA==
X-Gm-Message-State: AOAM532xvkoyq56mIX9Td4j+BucYlq5rIOKkanwP4U8jK2kRHQKrVbjK
        xB35toS9MKYlT04qixwTQHn8tdFgNuI5yQ==
X-Google-Smtp-Source: ABdhPJy5CImQkXiVntCMK6iH+BUxmTEX8/WIeOsxz1bnXR2msi2fn6lT9+qI00BFkTTP5kuo992mXw==
X-Received: by 2002:a92:db4b:: with SMTP id w11mr21475974ilq.297.1626788798859;
        Tue, 20 Jul 2021 06:46:38 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id x2sm5305102iob.45.2021.07.20.06.46.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 06:46:38 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailauth.nyi.internal (Postfix) with ESMTP id 8293127C0054;
        Tue, 20 Jul 2021 09:46:37 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 20 Jul 2021 09:46:37 -0400
X-ME-Sender: <xms:vdP2YGrAuVmZzJdMs7YDDwj_Tfo1s94AeywEOh9JJVwdv5-VxglQWQ>
    <xme:vdP2YEpFpKwGDn4Tla2vcbbKSKXQlczTBWmSWRTARRVTge6xkcK1bQ2FUJjjIxSuI
    yjwwjT6oMfoLkYRbw>
X-ME-Received: <xmr:vdP2YLNUyhuM4yW5La17F1wYvrON_ZWJ51c5F0yJeSdXGavcLi7UGJp3cgQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrfedvgdeijecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtth
    gvrhhnpeehvdevteefgfeiudettdefvedvvdelkeejueffffelgeeuhffhjeetkeeiueeu
    leenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpegsoh
    hquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedq
    udejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmh
    gvrdhnrghmvg
X-ME-Proxy: <xmx:vdP2YF5OJjFOAxoHZ11_r3AAK4jkOCiL2SFHAPsj79HTXJ-nFCewjQ>
    <xmx:vdP2YF6Wo1azUi8bzWYIE_3kMJoWQvL62foVLScUv5LperaBQo_xTw>
    <xmx:vdP2YFgWToAV8Vty7B_zwcgTZb0Mq1jAcmirhdmqNkxHRrG0zifxKg>
    <xmx:vdP2YCxHhDBaaBBuzVhr6myqRPESysGL16bkOKDVs7jZN9jRIYxSwgPAW_I>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 Jul 2021 09:46:37 -0400 (EDT)
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
Subject: [RFC v5 6/8] PCI: hv: Set ->domain_nr of pci_host_bridge at probing time
Date:   Tue, 20 Jul 2021 21:44:27 +0800
Message-Id: <20210720134429.511541-7-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210720134429.511541-1-boqun.feng@gmail.com>
References: <20210720134429.511541-1-boqun.feng@gmail.com>
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
2.30.2

