Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C04703A1B08
	for <lists+linux-hyperv@lfdr.de>; Wed,  9 Jun 2021 18:33:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235181AbhFIQfc (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 9 Jun 2021 12:35:32 -0400
Received: from mail-io1-f44.google.com ([209.85.166.44]:36507 "EHLO
        mail-io1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235211AbhFIQfa (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 9 Jun 2021 12:35:30 -0400
Received: by mail-io1-f44.google.com with SMTP id s19so13669229ioc.3;
        Wed, 09 Jun 2021 09:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1VxZA1hOFGfFK+vjOpS6yCsaoNwIfiljMaf64AqSDfI=;
        b=FEur/cmKBsioloDLkauRtbBKVtl+caWc3kOqD3+wTib2WiNL7QNiXDLe0e2j50FZOh
         b1PKYz4nByqiO09xpfXkLeu95yW+tGKLegWwskgzsNdQZEwVVxAQ1W5hNxRxTpTzzIcL
         rvQuRgCouD1yjkavWd8IGGbbsIwLGS9yUg+jur11KCrqG9N8aqElmk1IW4OxyFyKkra/
         RUDuTMlwjcIyFaIULPNeDL9VW/8R1Ouzp/Gy7ZGsDtcg9Yfo6VEMaL+QrrD/R94VjF0B
         R8lrEVy3ehZE6E2CnQnCE27+hxXhSMPqjY1pJXd+uohFbZeQMJYyOUASIuVECp/Ssm1t
         N3pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1VxZA1hOFGfFK+vjOpS6yCsaoNwIfiljMaf64AqSDfI=;
        b=bFHTndGKYqLwTl8sW2ZbS5R49m4bI8gwbSuJuCyNCSsbFHoaupQfKalfVF1QfKEA6g
         uPycnesCO0HtlbxFMIuCXhIo5BSMg0oCXbh7UGgsk8dIpMnPw0CYEeFjl97+0/mrO4IA
         6IkAEQ3ratwJcUNNNz2YCWTr/1/z2Ig6LhvBQnPImzuPVkUmp4sbdvg+88FuZancjySd
         g4+kzGEF4vpi8tUwv0Syor+8vJ9ElnusT1Wy/P/Edt6gppEN4E7BZmwIRaEubEL7BEYc
         FrYqeuO5z5ayTJLW3bk11HuBeGe+JsFAInZdl9yr0oynFQow1k51VnlEbxW1abuFfFmo
         T2HA==
X-Gm-Message-State: AOAM532856TDav5/na5GCteXkwM3TOdiNSl4rU5XKAIIZWJyNvUEPsRT
        ghzDZJM91ZSYcJYs6bOPemE=
X-Google-Smtp-Source: ABdhPJwDNhbpuCkL/OdOC3pA3sAMZxtbTpMrWkq91DrOfhSQHKnVE0o5WXQ+N5F3mTOS6xBSbbjO0w==
X-Received: by 2002:a6b:7d0b:: with SMTP id c11mr274416ioq.8.1623256344068;
        Wed, 09 Jun 2021 09:32:24 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id x21sm234208ioa.36.2021.06.09.09.32.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jun 2021 09:32:23 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailauth.nyi.internal (Postfix) with ESMTP id A8F0427C005C;
        Wed,  9 Jun 2021 12:32:22 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 09 Jun 2021 12:32:22 -0400
X-ME-Sender: <xms:Fu3AYIKhN7t_yp6QEYs8UlBy1MGwkgvepkR35MgrQ82ndNNKuud0Iw>
    <xme:Fu3AYIKsmJm-gxWHXG44PQ0WgP5tA1Ce6Uh5lyXjGXmRTo8rPy7l8uMAkyrk9YSry
    Gfz-N_dDg6q48Uong>
X-ME-Received: <xmr:Fu3AYIuXNkx_JxPt28vCNZ37IxNBb_OJx0ODSrATz7uRTEtkXwanEZPkYgY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfeduuddguddtvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeehvdevteefgfeiudettdefvedvvdelkeejueffffelgeeuhffhjeetkeei
    ueeuleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdei
    gedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfih
    igmhgvrdhnrghmvg
X-ME-Proxy: <xmx:Fu3AYFbUbAKhdrmmRzzF4co2WvQgOMnSAO3DBh6TSvp9CmP7aPPXZg>
    <xmx:Fu3AYPZwp15-JpRgjZH8t6l6GccEDceYzvf0U3IgR2P16hs3W5qa9g>
    <xmx:Fu3AYBC5drTjblgTjVlInfQIuivY50tHJW66LmMLx0u3JkZfI_YmcQ>
    <xmx:Fu3AYAJRuSDCZDib1sOVuXKkmeMRJbNw7uCAwltLxUxjYV0t8xSKFxRjcQU>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Jun 2021 12:32:22 -0400 (EDT)
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
Subject: [RFC v3 4/7] PCI: hv: Use pci_host_bridge::domain_nr for PCI domain
Date:   Thu, 10 Jun 2021 00:32:08 +0800
Message-Id: <20210609163211.3467449-5-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210609163211.3467449-1-boqun.feng@gmail.com>
References: <20210609163211.3467449-1-boqun.feng@gmail.com>
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
index ee9f8e27e2e8..f9a644ae3b74 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -2309,7 +2309,7 @@ static void hv_eject_device_work(struct work_struct *work)
 	 * because hbus->bridge->bus may not exist yet.
 	 */
 	wslot = wslot_to_devfn(hpdev->desc.win_slot.slot);
-	pdev = pci_get_domain_bus_and_slot(hbus->sysdata.domain, 0, wslot);
+	pdev = pci_get_domain_bus_and_slot(hbus->bridge->domain_nr, 0, wslot);
 	if (pdev) {
 		pci_lock_rescan_remove();
 		pci_stop_and_remove_bus_device(pdev);
@@ -3095,6 +3095,7 @@ static int hv_pci_probe(struct hv_device *hdev,
 			 "PCI dom# 0x%hx has collision, using 0x%hx",
 			 dom_req, dom);
 
+	hbus->bridge->domain_nr = dom;
 	hbus->sysdata.domain = dom;
 
 	hbus->hdev = hdev;
@@ -3106,7 +3107,7 @@ static int hv_pci_probe(struct hv_device *hdev,
 	spin_lock_init(&hbus->retarget_msi_interrupt_lock);
 	init_completion(&hbus->remove_event);
 	hbus->wq = alloc_ordered_workqueue("hv_pci_%x", 0,
-					   hbus->sysdata.domain);
+					   hbus->bridge->domain_nr);
 	if (!hbus->wq) {
 		ret = -ENOMEM;
 		goto free_dom;
@@ -3233,7 +3234,7 @@ static int hv_pci_probe(struct hv_device *hdev,
 destroy_wq:
 	destroy_workqueue(hbus->wq);
 free_dom:
-	hv_put_dom_num(hbus->sysdata.domain);
+	hv_put_dom_num(hbus->bridge->domain_nr);
 free_bus:
 	kfree(hbus);
 	return ret;
@@ -3326,7 +3327,7 @@ static int hv_pci_remove(struct hv_device *hdev)
 	wait_for_completion(&hbus->remove_event);
 	destroy_workqueue(hbus->wq);
 
-	hv_put_dom_num(hbus->sysdata.domain);
+	hv_put_dom_num(hbus->bridge->domain_nr);
 
 	kfree(hbus);
 	return ret;
-- 
2.30.2

