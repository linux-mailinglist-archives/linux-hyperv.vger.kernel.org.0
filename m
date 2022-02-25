Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 896644C3B88
	for <lists+linux-hyperv@lfdr.de>; Fri, 25 Feb 2022 03:18:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236350AbiBYCSm (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 24 Feb 2022 21:18:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbiBYCSl (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 24 Feb 2022 21:18:41 -0500
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FE3BB821C;
        Thu, 24 Feb 2022 18:18:07 -0800 (PST)
Received: by mail-il1-x133.google.com with SMTP id c14so3263335ilm.4;
        Thu, 24 Feb 2022 18:18:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TaBnimEUks+YBboFsRAqkbt7mL3+UjNt0Rk4Ti3hnZw=;
        b=OrleMbLmanQaioY+qhKMd6Tifev70Hg1dGZn/0Y2GDANmnwgkdbqIkWL2gpRE6hbo7
         /ZZA5rShFvMv1NLhWM9MtW1yuf2Oa6rN9+pQctB74dMLjLY7me+95oKlcSVpvGqec7GC
         1QnPIniVzt+Itbw3K9lySvZZGZVAiOCyrfgVn5bksFW+GeMBZLPTJhZxMq+zmL2/S5sh
         LVn4JFiSS5OUTs7TCfc2+T5w6uP0SLzduluoZxH1UtNP+sh5qL1IzqvdY2en0pWB+P3S
         5ukIMwdFL4wXybjAdS05BXozOttop9Gwe2uemnq/hAjv3VuNKp52eEzpli4xsMfCP1oM
         XDPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TaBnimEUks+YBboFsRAqkbt7mL3+UjNt0Rk4Ti3hnZw=;
        b=bf/Ap6Ojjcy0V55FOIK7lGzRiA6VlkOuV9jdTep8UoB0NZpkWGPVWkgzytHhTNMQ3C
         IvU3tneQQY0itb5uAqTZrdU8cj0V9wH+aSUoD5/+V2lkzzDzFXy8PoGmteuzXFEyoqY9
         D00+/m5LL8+pLq31Qdivlr7z8IVtcglvFiMI1Wn+RphKDzO4QSGv9mtazVG+tyXHbfu2
         bqRBOMgbjU8dL/Cye2MyaUTdpYqJ6JTizi6EJ4dJGuNhdTc2XZviKZS5rFyKXnGkaNsX
         0KPH0CYOmmwQ9NRnNEAMHQ6gZXMCNGEruxbsqe6WQYH80hmZmjg20Ns18y3yrFautGH1
         uL+Q==
X-Gm-Message-State: AOAM532jPYXat/dmXZyDE5KRTNtAPwIhtW93SmqehEGk8XIr3EvMcEAB
        idZgGUji551SXaTdKXbvwHg=
X-Google-Smtp-Source: ABdhPJz5Aj56MoGoeytWvwgHKNPLVkRL2FCQLnyxZ4j5gnrcD0h6Qiu+FMIWcxDArZV2fAsT9qF2nA==
X-Received: by 2002:a05:6e02:1baf:b0:2c2:46eb:a074 with SMTP id n15-20020a056e021baf00b002c246eba074mr4310648ili.263.1645755486613;
        Thu, 24 Feb 2022 18:18:06 -0800 (PST)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id p12-20020a92d28c000000b002c29f97824dsm814799ilp.48.2022.02.24.18.18.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 18:18:05 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailauth.nyi.internal (Postfix) with ESMTP id 019BD27C0054;
        Thu, 24 Feb 2022 21:18:03 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 24 Feb 2022 21:18:04 -0500
X-ME-Sender: <xms:WzwYYtsGySr2zsWB2FSphWqCdR06c87cnP8b8B9SQXv59VDems_51w>
    <xme:WzwYYmfJmlcXDC120B1zWZlqCxfyLiNiRPe8OzXqPvFQtdilDygz62XK_t8zOaR3e
    BjlinLP0HnpzklQyg>
X-ME-Received: <xmr:WzwYYgyjLlJdgPT8xwLvFnChK6JbTdzfgPksTNr_4plftD_QIgKdvp4GJEgPjg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrleefgdefkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtth
    gvrhhnpeehvdevteefgfeiudettdefvedvvdelkeejueffffelgeeuhffhjeetkeeiueeu
    leenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsoh
    hquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedq
    udejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmh
    gvrdhnrghmvg
X-ME-Proxy: <xmx:WzwYYkOgS-D0-BpD6dxD1PW8h5JDZ9fcOYHlAEGaP6RjS5TZFy5MCg>
    <xmx:WzwYYt8yN4Y6Q0s9LNhX1WEuYy_WQGpKYg_FwKUf1AUOag3Nq9g6Ew>
    <xmx:WzwYYkWfr4Xuj2231FfmWDyi9iMZa6CUJ2RCccC3P3hm0LKlrzMOlw>
    <xmx:WzwYYsZX5WWYXdP9FHuzuI-Okh2hTge-snADt4PBHDNHRbnzZjVfXkdha0w>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 24 Feb 2022 21:18:02 -0500 (EST)
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Wei Liu <wei.liu@kernel.org>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        linux-hyperv@vger.kernel.org,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        David Hildenbrand <david@redhat.com>,
        linux-kernel@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>
Subject: [RFC v1.1] Drivers: hv: balloon: Disable balloon and hot-add accordingly
Date:   Fri, 25 Feb 2022 10:17:14 +0800
Message-Id: <20220225021714.3815691-1-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220223131548.2234326-3-boqun.feng@gmail.com>
References: <20220223131548.2234326-3-boqun.feng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Currently there are known potential issues for balloon and hot-add on
ARM64:

*	Unballoon requests from Hyper-V should only unballoon ranges
	that are guest page size aligned, otherwise guests cannot handle
	because it's impossible to partially free a page.

*	Memory hot-add requests from Hyper-V should provide the NUMA
	node id of the added ranges or ARM64 should have a functional
	memory_add_physaddr_to_nid(), otherwise the node id is missing
	for add_memory().

These issues require discussions on design and implementation. In the
meanwhile, post_status() is working and essiential to guest monitoring.
Therefore instead of the entire hv_balloon driver, the balloon and
hot-add are disabled accordingly for now. Once the issues are fixed,
they can be re-enable in these cases.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
v1 --> v1.1:

*	Use HV_HYP_PAGE_SIZE instead of hard coding 4096 as suggested by
	Michael.

*	Explicitly print out the disable message if a function is
	disabled as suggested by Michael.

 drivers/hv/hv_balloon.c | 36 ++++++++++++++++++++++++++++++++++--
 1 file changed, 34 insertions(+), 2 deletions(-)

diff --git a/drivers/hv/hv_balloon.c b/drivers/hv/hv_balloon.c
index 062156b88a87..eee7402cfc02 100644
--- a/drivers/hv/hv_balloon.c
+++ b/drivers/hv/hv_balloon.c
@@ -1660,6 +1660,38 @@ static void disable_page_reporting(void)
 	}
 }
 
+static int ballooning_enabled(void)
+{
+	/*
+	 * Disable ballooning if the page size is not 4k (HV_HYP_PAGE_SIZE),
+	 * since currently it's unclear to us whether an unballoon request can
+	 * make sure all page ranges are guest page size aligned.
+	 */
+	if (PAGE_SIZE != HV_HYP_PAGE_SIZE) {
+		pr_info("Ballooning disabled because page size is not 4096 bytes\n");
+		return 0;
+	}
+
+	return 1;
+}
+
+static int hot_add_enabled(void)
+{
+	/*
+	 * Disable hot add on ARM64, because we currently rely on
+	 * memory_add_physaddr_to_nid() to get a node id of a hot add range,
+	 * however ARM64's memory_add_physaddr_to_nid() always return 0 and
+	 * DM_MEM_HOT_ADD_REQUEST doesn't have the NUMA node information for
+	 * add_memory().
+	 */
+	if (IS_ENABLED(CONFIG_ARM64)) {
+		pr_info("Memory hot add disabled on ARM64\n");
+		return 0;
+	}
+
+	return 1;
+}
+
 static int balloon_connect_vsp(struct hv_device *dev)
 {
 	struct dm_version_request version_req;
@@ -1731,8 +1763,8 @@ static int balloon_connect_vsp(struct hv_device *dev)
 	 * currently still requires the bits to be set, so we have to add code
 	 * to fail the host's hot-add and balloon up/down requests, if any.
 	 */
-	cap_msg.caps.cap_bits.balloon = 1;
-	cap_msg.caps.cap_bits.hot_add = 1;
+	cap_msg.caps.cap_bits.balloon = ballooning_enabled();
+	cap_msg.caps.cap_bits.hot_add = hot_add_enabled();
 
 	/*
 	 * Specify our alignment requirements as it relates
-- 
2.33.0

