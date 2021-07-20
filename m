Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A07A43CFB4E
	for <lists+linux-hyperv@lfdr.de>; Tue, 20 Jul 2021 15:53:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239153AbhGTNNM (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 20 Jul 2021 09:13:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239031AbhGTNGf (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 20 Jul 2021 09:06:35 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30C1FC0613E9;
        Tue, 20 Jul 2021 06:46:42 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id u7so23934356ion.3;
        Tue, 20 Jul 2021 06:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MjtB63O8D6JZEGLQ/GVfQXEaFWYKcg+D2+varZhpuDo=;
        b=dRiBWdPlS7gD/26YIVIlibyr6MUQmkqIbQCg1O2ad3Vlm1Om6UllVH7PyPSZ961ksi
         2LfJUiHW3vw6ft+7UMAoqN7E0JLgPy+fOqV8w+JVfJDS62LYUBCkJ7gAprk9oB2CHH15
         ZR+uh1KTSvRUwRDYgLfmTTbo/k1mIvhMwWmJNyQjhn7incwqHGSBJHtUuRS3+GwmNO4t
         mt48VNGmfIb/Re4tYVBroDo9IjwS1zKZjq/oeeXUHlZZGdE3AaPxknrYe+Y/hytxc7Go
         LUjHk5FnQLT4k99VK7G1ylZsOSjqLJV4W2RYeedEL5URLS1E4I+QQMA49Te6jlwmWktr
         jAiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MjtB63O8D6JZEGLQ/GVfQXEaFWYKcg+D2+varZhpuDo=;
        b=b5feXPxzQ/Tnn+bTcvm51fcLtSTpCOxMcQSYVXt6pnv826V+PhkNdkjXRm7L7OPKXm
         GvjQRw5M4pmUQWd8cHvKiFLsKv4ueunR9h+ZRqLrCqcKP57RMF+U4j+YC4JjVy8GYcRn
         sNTz6nBD7TzPMVylCzUu2BveXNdAMwRU6ntscC0tHD8UqBvj+1pUieeczByBVDswPK1W
         PBqQoHkMEHUFLL+7LI9ikFR1nSiU1ISfqs8Ta4ObkCrOhoJ41o0IQ43H+4aiyBGtwpIm
         8aC8nrnC83QgTNR2ATiUy23387f6Gz8mPkZRz5MYA8/4Tv9491wLMWwlLYiH4oifB1+2
         JJow==
X-Gm-Message-State: AOAM5300gSR2k4u6PJ3q8EyFO/kgAhsSZbW5YKqZ3nnMFyCi4bWfkKt4
        /y3OoBRc///ybP0kfe4DRIo=
X-Google-Smtp-Source: ABdhPJzbgEejJohfrCjPWGfeFan9hbOBjdY9WcEs2PV1eNg5yhhrAdS5FuSUc6+qbEvGTVjdjCB2Nw==
X-Received: by 2002:a02:93a3:: with SMTP id z32mr27012095jah.33.1626788801697;
        Tue, 20 Jul 2021 06:46:41 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id 20sm5096218ily.40.2021.07.20.06.46.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 06:46:41 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailauth.nyi.internal (Postfix) with ESMTP id 70D2227C0054;
        Tue, 20 Jul 2021 09:46:40 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Tue, 20 Jul 2021 09:46:40 -0400
X-ME-Sender: <xms:v9P2YEIC7FhQKo8Sz5kqJuJqK_rhHRzQcvue9TjpCMHjSH2ikENh0g>
    <xme:v9P2YEJeUn_csbuHhZSIdgXFPOMgR9qdT54nnpRIOnz-xfm-1SqRpzQCMnhx4iMok
    eI9azHYi5WwR98WpQ>
X-ME-Received: <xmr:v9P2YEvG-U59q697QJ6Xah4wzD4DOHpAJ_rYrQ9Tvm2dBLw0pBk3dlTD-Ug>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrfedvgdeijecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtth
    gvrhhnpeehvdevteefgfeiudettdefvedvvdelkeejueffffelgeeuhffhjeetkeeiueeu
    leenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsoh
    hquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedq
    udejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmh
    gvrdhnrghmvg
X-ME-Proxy: <xmx:v9P2YBY8iCR7NirCgdjmafxnabi0WPLZO5B8dnS-uH8ZRI72BUm_gw>
    <xmx:v9P2YLYdiaiK21Bu6YdD1XHTi9sd1oQnG0I803NvLQALH7SHMR2LIQ>
    <xmx:v9P2YNDGwau5eNX3vtTjVBjrv1nRZ0-LHgMqaOrzMb-SLDPhWBhwIQ>
    <xmx:wNP2YISnfYlwe8OpDVG1DGUcSMaYFNJIdHj3wg54eaD3I7Fq-P_jAMEf_Oc>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 Jul 2021 09:46:39 -0400 (EDT)
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
Subject: [RFC v5 8/8] PCI: hv: Turn on the host bridge probing on ARM64
Date:   Tue, 20 Jul 2021 21:44:29 +0800
Message-Id: <20210720134429.511541-9-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210720134429.511541-1-boqun.feng@gmail.com>
References: <20210720134429.511541-1-boqun.feng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Now we have everything we need, just provide a proper sysdata type for
the bus to use on ARM64 and everything else works.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 drivers/pci/controller/pci-hyperv.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index e6276aaa4659..62dbe98d1fe1 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -40,6 +40,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/pci.h>
+#include <linux/pci-ecam.h>
 #include <linux/delay.h>
 #include <linux/semaphore.h>
 #include <linux/irqdomain.h>
@@ -448,7 +449,11 @@ enum hv_pcibus_state {
 };
 
 struct hv_pcibus_device {
+#ifdef CONFIG_X86
 	struct pci_sysdata sysdata;
+#elif defined(CONFIG_ARM64)
+	struct pci_config_window sysdata;
+#endif
 	struct pci_host_bridge *bridge;
 	struct fwnode_handle *fwnode;
 	/* Protocol version negotiated with the host */
@@ -3075,7 +3080,9 @@ static int hv_pci_probe(struct hv_device *hdev,
 			 dom_req, dom);
 
 	hbus->bridge->domain_nr = dom;
+#ifdef CONFIG_X86
 	hbus->sysdata.domain = dom;
+#endif
 
 	hbus->hdev = hdev;
 	INIT_LIST_HEAD(&hbus->children);
-- 
2.30.2

