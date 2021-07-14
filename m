Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 233533C82EA
	for <lists+linux-hyperv@lfdr.de>; Wed, 14 Jul 2021 12:29:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239149AbhGNKcd (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 14 Jul 2021 06:32:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239129AbhGNKcb (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 14 Jul 2021 06:32:31 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 591FBC061762;
        Wed, 14 Jul 2021 03:29:40 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id 201so1025615qkj.13;
        Wed, 14 Jul 2021 03:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MjtB63O8D6JZEGLQ/GVfQXEaFWYKcg+D2+varZhpuDo=;
        b=LjjPBgmN78m+5VJLZrewYnBR6ZZfRjNoneQMnEhrS8cFOWElmH+4HuwQyWnXuPcXM4
         iCQwcyvT8BTPK1FIFjkX52293Yp8b8UTC53P7nmMTZucD4LUpG6KNwp7kJZP+UKbiGN8
         cIJ3gfHHwxtUE+YIMpsvMIu3d8CBccf9I4+iSwJtLLi2LXaJoFW6Am4STjGjCYTmTQVJ
         ex0DYEh8X6fT+fn8hymR2j63fp3x5bt/66pSU0O5DzwskWcacPErIy3HFb6C+B5iKVPf
         GJu6F1XpFIgumjfo5l7D2WP+EcMFIf3RBEWclTmwg60T7Rub9TZo+swD06lSfT7kBgM5
         BOpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MjtB63O8D6JZEGLQ/GVfQXEaFWYKcg+D2+varZhpuDo=;
        b=eTwfpBuyLUbS2d5grrCR4OD2/B08nQ8e61oSDc2LGZcrB4NcTf+2+2fZ3GpX/MIUJ7
         bdqF5p+3eUBtA/WsUZD+s+KCEjRmOHg+dn9X9yBc7R91z5uQEhUTCsV+xk6LiLcXMFf4
         r/ixRyUQpqpgsbmHUDDMJ0Mys7ALHC2cNheSBHENA9BRr/Z3+Wbe/bC6aQw7ccP+pdEJ
         sY6Lrx3N80mvZHUtj+kMXMG912LdMO+ft4y9/QJs+DEcYCwe3tOu0tKo6/5J4GhfBPQF
         ht8tP+tPP6lAgHqryA5yFDo0TajO6IWdXT+nOpyUz2aECopEJDpasO3PQ3oTcIFGsN+z
         +ZvA==
X-Gm-Message-State: AOAM5323PDrDft8QddnE7o3ZUDTdOGPVl36efqFa0rvRIdeHXnnDyFey
        lXuZcQHiYUgZvblf8ll6fbc=
X-Google-Smtp-Source: ABdhPJyIQ4bAu5TuRkSktzpUaxKE9S5Kn2Eipv5skl92L4xZ/DaDosYBF1hPBKslEuM4tJ2Q72EAww==
X-Received: by 2002:ae9:e002:: with SMTP id m2mr9208764qkk.474.1626258578690;
        Wed, 14 Jul 2021 03:29:38 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id k6sm614543qtg.78.2021.07.14.03.29.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 03:29:38 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailauth.nyi.internal (Postfix) with ESMTP id 72D4F27C005A;
        Wed, 14 Jul 2021 06:29:37 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 14 Jul 2021 06:29:37 -0400
X-ME-Sender: <xms:kbzuYDViUfRItF8rPHX6vN-ic8is2MZWkqlW_bXywEo6Jrl5nibUHA>
    <xme:kbzuYLmKtOvCqIwXhLl7WmY7BRuDXzVGcOtzlADRJROXPgcIOJ_l96vDq5blR8aqw
    _RDQJ-v01JDLI7LCA>
X-ME-Received: <xmr:kbzuYPaebdiUUw5n5lWFDeq_0BaIMtRcnlA5PPyhn0NVJs_UvQZdSwB1zyhIpQ>
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
X-ME-Proxy: <xmx:kbzuYOUeKcfcythj7uzBsnvXkLUEruYwgfH4En_JWPMTrEvtmu6WNA>
    <xmx:kbzuYNmpowsRfbNGzZYYya4v1-pWzunrJO3_SZu8H_YdkyzURBIj_g>
    <xmx:kbzuYLfjOkJu3TxOJ-WO9o8n2Gd9uk_XjmlMWDILc9wDbtzmWKmIEw>
    <xmx:kbzuYMfbLHVurHIjUzOYJ7AwOxYUVtcmfbpkSyZ0kzUgFCJevzVTAAMMzEQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 Jul 2021 06:29:37 -0400 (EDT)
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
Subject: [RFC v4 7/7] PCI: hv: Turn on the host bridge probing on ARM64
Date:   Wed, 14 Jul 2021 18:27:37 +0800
Message-Id: <20210714102737.198432-8-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210714102737.198432-1-boqun.feng@gmail.com>
References: <20210714102737.198432-1-boqun.feng@gmail.com>
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

