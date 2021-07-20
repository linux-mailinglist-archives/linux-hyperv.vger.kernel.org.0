Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9880E3CFB22
	for <lists+linux-hyperv@lfdr.de>; Tue, 20 Jul 2021 15:48:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238685AbhGTNH4 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 20 Jul 2021 09:07:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239056AbhGTNGg (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 20 Jul 2021 09:06:36 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46772C0613E8;
        Tue, 20 Jul 2021 06:46:40 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id x10so23986966ion.9;
        Tue, 20 Jul 2021 06:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=thGMbJJZ1ZuhHFpa40ihsNvSFL+Lp/KJuygOWQUDDHk=;
        b=B3jHVJ684EyY62l1Ktt/FYbeUJEkstzc7G/JT+14006HJWgNy0Eplk1QYcQ7uxfakk
         ekgx71Q0/MMAxxhPeJs0dNkfgIvv/qRKQOo+VZoUwnPFviSWaGhBXDkcNjNczTQm49IB
         3i4KLR2/rZqRUFhc0AnjjXmtCelN0ppTvKvS9ev8TcwFiPtNIwPo6pf+EL2ncTTHsh6M
         4IpmBk8cTeiGM0i64WQled86nIixLTcvz6BOoSHmXTbMa5yxZBz4JITs81dZUdSesYNz
         QnxIbETLqIZZA0RJ9K1pf6ZzfR+bXwXCau8bAvs/JlGnsX5WSh4dCngSfe1w8DjrcYNY
         F+Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=thGMbJJZ1ZuhHFpa40ihsNvSFL+Lp/KJuygOWQUDDHk=;
        b=WJeCWVmk27+kUqaEyIUJNuzPLUvD9JXRfSklnIZU+i6QhjepAl9NugaCjNqES9H1m5
         WSKpq8ytzd6fOtWDeri2lYBUL8f8TrrliVwFSqJ55LLYvrOAwLpQWLVBD9BhjcMyctW3
         ThlZoAFGHd6GGgpWAuP7iFA3PcM+QjlXlUF28mqXwTzmeDo9Qi545xIxLi2hlUcnQ0x9
         NYfgt7TTSaNoIrjvGAZRnMa2z8y1kOE6WJVV82D4rznakQQchHjq+GK7nmN9FbkoEoaj
         LTPZ7XbyCC6tjVvvrckNnECHb09XCQhYPFQByoWNq4OoNn0CXMGh+zCmZHONNpdiPRsF
         /YwA==
X-Gm-Message-State: AOAM5327rm+2nCrs1Ei9Y6r/CT4yc8yANWIbJN60i576GMrTTWmmeAcH
        KsXqAVw7Ziax+xneXyGvEEQ=
X-Google-Smtp-Source: ABdhPJylVA1+R92dqNID8oGrh4/2MwKva9nl457AalJWCWLlYBql922UKD7Zb3NtxRxWBMC+x8Yluw==
X-Received: by 2002:a02:cc19:: with SMTP id n25mr26570131jap.140.1626788800118;
        Tue, 20 Jul 2021 06:46:40 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id t24sm12665726ioh.24.2021.07.20.06.46.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 06:46:39 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailauth.nyi.internal (Postfix) with ESMTP id BD11D27C005A;
        Tue, 20 Jul 2021 09:46:38 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 20 Jul 2021 09:46:38 -0400
X-ME-Sender: <xms:vtP2YKId4_HPKBlGZeos6K9uTFDq9dodvwmmmasd0gZ2qGwsDnAFTA>
    <xme:vtP2YCJGoR9MKAZVDe-ed4uYffu5FBzjjZr3bvMpkohWJE3AQRV_3ax54_8GhsLbu
    rsIH6HVFAO9EnzEtg>
X-ME-Received: <xmr:vtP2YKvAZXdJqnyWce_pA9qPP_z78doDAfYHlNw10HyC6G1fn7Kgrjx9Qvg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrfedvgdeikecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtth
    gvrhhnpeehvdevteefgfeiudettdefvedvvdelkeejueffffelgeeuhffhjeetkeeiueeu
    leenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpegsoh
    hquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedq
    udejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmh
    gvrdhnrghmvg
X-ME-Proxy: <xmx:vtP2YPYW9G36XbcALIarPtWn1O0gBCm8ZZeSxp1jTtYYek52Eq08vw>
    <xmx:vtP2YBaPmthV7geDso9bMWBjJHr84dO-spdU1ew88b8wg52BdyeF4w>
    <xmx:vtP2YLBMi5PYCRn4FPz-fZT-WfJEZ_BnxdEKSLEHOIPP00vMgz6S_g>
    <xmx:vtP2YOT8kRph40HvWghVCaUQr3Z8E7XqrB_ku_w1FiayUsrNxKBv8g0eMg4>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 Jul 2021 09:46:38 -0400 (EDT)
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
Subject: [RFC v5 7/8] PCI: hv: Set up MSI domain at bridge probing time
Date:   Tue, 20 Jul 2021 21:44:28 +0800
Message-Id: <20210720134429.511541-8-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210720134429.511541-1-boqun.feng@gmail.com>
References: <20210720134429.511541-1-boqun.feng@gmail.com>
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
2.30.2

