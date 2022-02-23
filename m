Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EAD24C13D4
	for <lists+linux-hyperv@lfdr.de>; Wed, 23 Feb 2022 14:16:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240815AbiBWNQl (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 23 Feb 2022 08:16:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239584AbiBWNQk (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 23 Feb 2022 08:16:40 -0500
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE1DEAA011;
        Wed, 23 Feb 2022 05:16:12 -0800 (PST)
Received: by mail-il1-x12d.google.com with SMTP id e11so15233818ils.3;
        Wed, 23 Feb 2022 05:16:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1RzvBknQsRqqFRqcBakDx7UnpeR3xK8Ei9AhGVZI0ro=;
        b=G6Bnf7AHCROwEduRmTJpAWS9Qs+PY7gpP0j4HkIDKDSSruS4Udl+Ybt1wsqgqtm6Ir
         9jlZkaVXo4jjrHCXNRRx4gjEW8NtXCP7RFWT/wVsKMsJV4DgELU45ClHTAM8aE2t/o4v
         YdekMvguj+IS6fvQGgay0ORbNuZ3j2ZQ0q9ewReFJ10kay2w3psbJOG1+ByUQeID+53z
         Uz8FFsmlwzLg0kWEpMBqfidJ3c/GsOG4GE4hO4Bk2lvouUmWGGXk119XM+dRkRdVN1Cu
         WPkqo2aBCBKc/Hto0+QcyyIJ7iGqvncCE06D4SeBuDpqKKCjhn+Ztugchc54J2jhcuR/
         zP3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1RzvBknQsRqqFRqcBakDx7UnpeR3xK8Ei9AhGVZI0ro=;
        b=UdB9TI4ZEnsFOt0b8JrK/mj8ae/DXDVfUythFBcEb1/hsL49aO7UlYldxq4+/U2IQx
         O2SrkgRdtoM15rCKqTMN9WRUmdajJY2gRm3mBH7frjQGA2kvvyQ0CHc6gGuORWEJJTag
         EyxEumPFUHtD/dXxqi9Bt32Hkz/WlwYCSdzIoFafPPYR/khG3y+3Luy2aX4zPNKmKycZ
         cpsZ3u1PG6Ph6Uwqq1tPTOCBlNWYtiDr8YHpwKxCLfTsIH85u2vgLxp6BtzRSfKTG1mI
         3BwNjcof/XuVF0yuxtg07dyI7c70u1sPCdz2V+ZdL/s9vJUSkalBrOMrAOAIp2jRtrbW
         Lgvg==
X-Gm-Message-State: AOAM532t1yj97NajmsdIkQFUg5mx0AHD6fwJZ7dKV5D+71bO/xDbJSsm
        wzqpNDq47PbSKZGLzk2fiSY=
X-Google-Smtp-Source: ABdhPJy2O+qKFfwngzHjfql/fo37iyjOgVhqqnh81ArwtuP/wOB/M/nPUEoWoPWoIuBmoTvQHcW2dA==
X-Received: by 2002:a05:6e02:1708:b0:2c2:7258:3e72 with SMTP id u8-20020a056e02170800b002c272583e72mr4364160ill.267.1645622172368;
        Wed, 23 Feb 2022 05:16:12 -0800 (PST)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id u15sm12712168ill.75.2022.02.23.05.16.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 05:16:11 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailauth.nyi.internal (Postfix) with ESMTP id 4999727C0054;
        Wed, 23 Feb 2022 08:16:10 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Wed, 23 Feb 2022 08:16:10 -0500
X-ME-Sender: <xms:mjMWYsNC9ET0-jiYMpUzrd1PZ0CTXj9oV679xr0GmCQ-_N-SOnzUlA>
    <xme:mjMWYi-7tb1bDxP176Dx679wG9f98FCHRrPZvb7CjXVTZM5IU1FOU48RY0uv8icVA
    OIuXfWO4WXfqAkVDA>
X-ME-Received: <xmr:mjMWYjRFQVUKbP6NRkiEznlBZE7Kkp1MZBpFI8GGIJM7kAhjOtuQ5m2bdQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrledtgdeglecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtth
    gvrhhnpeehvdevteefgfeiudettdefvedvvdelkeejueffffelgeeuhffhjeetkeeiueeu
    leenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsoh
    hquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedq
    udejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmh
    gvrdhnrghmvg
X-ME-Proxy: <xmx:mjMWYkubyhnP0Q42o-kcjY3hsg3IEI6CFbHnsTwr-9lFhNr9L1ezeg>
    <xmx:mjMWYkdFMXKQz-exq_jsdcmsnC-b2Uy3o8-2CdefS7iUMdlxwMcphQ>
    <xmx:mjMWYo3lktO3f7sJEwffua3lB8ILC28v_2z9IL016vzEFzqlyZ0NQA>
    <xmx:mjMWYs4kubwvypDH2VOpmGIaC9bf8D17lTF_mBkXOutQ2OsnNp4mf9gZW0o>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Feb 2022 08:16:08 -0500 (EST)
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
Subject: [RFC 1/2] Drivers: hv: balloon: Support status report for larger page sizes
Date:   Wed, 23 Feb 2022 21:15:47 +0800
Message-Id: <20220223131548.2234326-2-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220223131548.2234326-1-boqun.feng@gmail.com>
References: <20220223131548.2234326-1-boqun.feng@gmail.com>
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

DM_STATUS_REPORT expects the numbers of pages in the unit of 4k pages
(HV_HYP_PAGE) instead of guest pages, so to make it work when guest page
sizes are larger than 4k, convert the numbers of guest pages into the
numbers of HV_HYP_PAGEs.

Note that the numbers of guest pages are still used for tracing because
tracing is internal to the guest kernel.

Reported-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 drivers/hv/hv_balloon.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/hv/hv_balloon.c b/drivers/hv/hv_balloon.c
index f2d05bff4245..062156b88a87 100644
--- a/drivers/hv/hv_balloon.c
+++ b/drivers/hv/hv_balloon.c
@@ -17,6 +17,7 @@
 #include <linux/slab.h>
 #include <linux/kthread.h>
 #include <linux/completion.h>
+#include <linux/count_zeros.h>
 #include <linux/memory_hotplug.h>
 #include <linux/memory.h>
 #include <linux/notifier.h>
@@ -1130,6 +1131,7 @@ static void post_status(struct hv_dynmem_device *dm)
 	struct dm_status status;
 	unsigned long now = jiffies;
 	unsigned long last_post = last_post_time;
+	unsigned long num_pages_avail, num_pages_committed;
 
 	if (pressure_report_delay > 0) {
 		--pressure_report_delay;
@@ -1154,16 +1156,21 @@ static void post_status(struct hv_dynmem_device *dm)
 	 * num_pages_onlined) as committed to the host, otherwise it can try
 	 * asking us to balloon them out.
 	 */
-	status.num_avail = si_mem_available();
-	status.num_committed = vm_memory_committed() +
+	num_pages_avail = si_mem_available();
+	num_pages_committed = vm_memory_committed() +
 		dm->num_pages_ballooned +
 		(dm->num_pages_added > dm->num_pages_onlined ?
 		 dm->num_pages_added - dm->num_pages_onlined : 0) +
 		compute_balloon_floor();
 
-	trace_balloon_status(status.num_avail, status.num_committed,
+	trace_balloon_status(num_pages_avail, num_pages_committed,
 			     vm_memory_committed(), dm->num_pages_ballooned,
 			     dm->num_pages_added, dm->num_pages_onlined);
+
+	/* Convert numbers of pages into numbers of HV_HYP_PAGEs. */
+	status.num_avail = num_pages_avail * NR_HV_HYP_PAGES_IN_PAGE;
+	status.num_committed = num_pages_committed * NR_HV_HYP_PAGES_IN_PAGE;
+
 	/*
 	 * If our transaction ID is no longer current, just don't
 	 * send the status. This can happen if we were interrupted
-- 
2.35.1

