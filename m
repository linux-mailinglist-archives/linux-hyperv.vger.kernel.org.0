Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF34A3716F7
	for <lists+linux-hyperv@lfdr.de>; Mon,  3 May 2021 16:47:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbhECOst (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 3 May 2021 10:48:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbhECOsn (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 3 May 2021 10:48:43 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B64ADC06138B;
        Mon,  3 May 2021 07:47:49 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id q5so2667504qvv.6;
        Mon, 03 May 2021 07:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZaynnOWtz1Te8wfxtYrLIk63miL/F4a1HGn3nv7Urqg=;
        b=f/kTbAKtjUtsRiWLTilOvljJRnbusQs75pq0RiLwmv7SAWfvilihFauytr+8eYpRCG
         p6Bw1dlvN0JUvKcbDHNfaePTMO5t9yoSHT5fr1g3FRqFF7a+Nvfy2R4kRxpi4zTCM7Jb
         1J4kYadymJVE2oeMq8x52ToZBDd12wtbZ1j7YFETYif+mAjM/hBh9MiK0L96l54wxrb6
         +MbWQij5LBdaoflS3wtkvlwgXY812BAd3U+OqfV3Fsgwgk51Ct2OuV3SkOWsW+tbdebt
         OzzHccXeu5s/Wbd9exI0FgfL04jPmRmoEk6j+d/v/2uxwktFzhj5g7oFhx+wdcG7AcEU
         /TlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZaynnOWtz1Te8wfxtYrLIk63miL/F4a1HGn3nv7Urqg=;
        b=qF+UY4GMMTjVnEF2Oe+QHVmjpAu19w/u318vyN0FpvgUAyJlpQnNIwrpuGxPGrkvPy
         VgHbQbyZUI6BqYKAVFCQO/i+UZeY5wT9FcfftMAYckznyzwFTtvaC/Iz0BQW8At7h9nx
         SpAV+2XGELkhbkcaFf3bDt9/gguaBn5YJPbDmQx30VlZQnHCvUsyJt0aNEsr+QXwcpRh
         6nHdJJ4YZ2CLKXNMdG7ZV94Er9Y7rfjaHgeopMSyHTJiapFIfUKMATe2+1hu+P6etJ4H
         kLemlBtu0TnTHOFeGiscaC+yeBsy0nWLvTPsFONnu+Me4S5Gl5icxvAC+IXWB1oFeGif
         WJmg==
X-Gm-Message-State: AOAM533N41z5ejZ4J7AaF9Pmb4ha29QzRcuxbI+kP1inUtPyWtX/WFYk
        1GWRXlDW/QZWmz4kfYK8gdQ=
X-Google-Smtp-Source: ABdhPJzZoxPhUl5k38exLjHPsVAjKcwCE/twF8waDy9XYOrkcwBv7GeAm9ddoUSKZURoSAmsT/SChg==
X-Received: by 2002:a05:6214:486:: with SMTP id ay6mr19861358qvb.18.1620053268704;
        Mon, 03 May 2021 07:47:48 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id r81sm8757152qka.82.2021.05.03.07.47.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 May 2021 07:47:48 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailauth.nyi.internal (Postfix) with ESMTP id 8210527C0054;
        Mon,  3 May 2021 10:47:47 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 03 May 2021 10:47:47 -0400
X-ME-Sender: <xms:EA2QYDAnq2pkhnc2rNTAJ2eop5_jOj6kV5drxpFTe0Fbnvo4p5J17Q>
    <xme:EA2QYJjrSjglaCSQSEoIqVep1Nzq6hpoRlMZdtqv1i6pJUmbfzVJYzkebavDyoSwx
    AsBDOSTTLW_WQaVow>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdefgedgkedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhephedvveetfefgiedutedtfeevvddvleekjeeuffffleeguefhhfejteekieeu
    ueelnecukfhppedufedurddutdejrddurddvheegnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgv
    rhhsohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfh
    gvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:EA2QYOk3ET9Zik0x2d0hFCuPPDsXcp5WH6R8YMUe3Y5LmAL6oUohoA>
    <xmx:EA2QYFyQPzDNB2FXJd-B-yaXI2KM3tnVCyY_ZcJc0OmbTuW7R2K4vg>
    <xmx:EA2QYITj1r81TOp_Ikoc6c_fIGBe99pIp93EDw7kC_i_ntV8ede1ug>
    <xmx:Ew2QYEp02rKFhc6WqBpJjBAa-quOoPLDVqx9OiyiGnR0uf_fV0KCYgbcDG_v3wiJ>
Received: from localhost (unknown [131.107.1.254])
        by mail.messagingengine.com (Postfix) with ESMTPA;
        Mon,  3 May 2021 10:47:44 -0400 (EDT)
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
Subject: [RFC v2 4/7] PCI: hv: Use pci_host_bridge::domain_nr for PCI domain
Date:   Mon,  3 May 2021 22:46:32 +0800
Message-Id: <20210503144635.2297386-5-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210503144635.2297386-1-boqun.feng@gmail.com>
References: <20210503144635.2297386-1-boqun.feng@gmail.com>
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
index 27b922b4bb7b..05b73d5dfe9d 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -2312,7 +2312,7 @@ static void hv_eject_device_work(struct work_struct *work)
 	 * because hbus->bridge->bus may not exist yet.
 	 */
 	wslot = wslot_to_devfn(hpdev->desc.win_slot.slot);
-	pdev = pci_get_domain_bus_and_slot(hbus->sysdata.domain, 0, wslot);
+	pdev = pci_get_domain_bus_and_slot(hbus->bridge->domain_nr, 0, wslot);
 	if (pdev) {
 		pci_lock_rescan_remove();
 		pci_stop_and_remove_bus_device(pdev);
@@ -3098,6 +3098,7 @@ static int hv_pci_probe(struct hv_device *hdev,
 			 "PCI dom# 0x%hx has collision, using 0x%hx",
 			 dom_req, dom);
 
+	hbus->bridge->domain_nr = dom;
 	hbus->sysdata.domain = dom;
 
 	hbus->hdev = hdev;
@@ -3109,7 +3110,7 @@ static int hv_pci_probe(struct hv_device *hdev,
 	spin_lock_init(&hbus->retarget_msi_interrupt_lock);
 	init_completion(&hbus->remove_event);
 	hbus->wq = alloc_ordered_workqueue("hv_pci_%x", 0,
-					   hbus->sysdata.domain);
+					   hbus->bridge->domain_nr);
 	if (!hbus->wq) {
 		ret = -ENOMEM;
 		goto free_dom;
@@ -3236,7 +3237,7 @@ static int hv_pci_probe(struct hv_device *hdev,
 destroy_wq:
 	destroy_workqueue(hbus->wq);
 free_dom:
-	hv_put_dom_num(hbus->sysdata.domain);
+	hv_put_dom_num(hbus->bridge->domain_nr);
 free_bus:
 	kfree(hbus);
 	return ret;
@@ -3329,7 +3330,7 @@ static int hv_pci_remove(struct hv_device *hdev)
 	wait_for_completion(&hbus->remove_event);
 	destroy_workqueue(hbus->wq);
 
-	hv_put_dom_num(hbus->sysdata.domain);
+	hv_put_dom_num(hbus->bridge->domain_nr);
 
 	kfree(hbus);
 	return ret;
-- 
2.30.2

