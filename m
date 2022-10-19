Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B3D9604330
	for <lists+linux-hyperv@lfdr.de>; Wed, 19 Oct 2022 13:30:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbiJSLaL (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 19 Oct 2022 07:30:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230384AbiJSL3n (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 19 Oct 2022 07:29:43 -0400
Received: from relay.virtuozzo.com (relay.virtuozzo.com [130.117.225.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC789170DDC;
        Wed, 19 Oct 2022 04:03:45 -0700 (PDT)
Received: from dev011.ch-qa.sw.ru ([172.29.1.16])
        by relay.virtuozzo.com with esmtp (Exim 4.95)
        (envelope-from <alexander.atanasov@virtuozzo.com>)
        id 1ol5lg-00B8K8-NM;
        Wed, 19 Oct 2022 11:56:35 +0200
From:   Alexander Atanasov <alexander.atanasov@virtuozzo.com>
To:     "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>
Cc:     kernel@openvz.org,
        Alexander Atanasov <alexander.atanasov@virtuozzo.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v5 7/8] drivers: hyperv: balloon - report inflated memory
Date:   Wed, 19 Oct 2022 12:56:19 +0300
Message-Id: <20221019095620.124909-8-alexander.atanasov@virtuozzo.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221019095620.124909-1-alexander.atanasov@virtuozzo.com>
References: <20221019095620.124909-1-alexander.atanasov@virtuozzo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Update the inflated memory in the mm core on change.

Signed-off-by: Alexander Atanasov <alexander.atanasov@virtuozzo.com>
---
 drivers/hv/hv_balloon.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/hv/hv_balloon.c b/drivers/hv/hv_balloon.c
index fdf6decacf06..280622ee0e9b 100644
--- a/drivers/hv/hv_balloon.c
+++ b/drivers/hv/hv_balloon.c
@@ -24,6 +24,7 @@
 #include <linux/notifier.h>
 #include <linux/percpu_counter.h>
 #include <linux/page_reporting.h>
+#include <linux/balloon.h>
 
 #include <linux/hyperv.h>
 #include <asm/hyperv-tlfs.h>
@@ -1280,6 +1281,14 @@ static unsigned int alloc_balloon_pages(struct hv_dynmem_device *dm,
 	return i * alloc_unit;
 }
 
+static void report_ballooned_pages(struct hv_dynmem_device *dm)
+{
+	u32 actual = dm->num_pages_ballooned;
+	long inflated_kb = actual << (HV_HYP_PAGE_SHIFT - 10);
+
+	balloon_set_inflated_total(inflated_kb);
+}
+
 static void balloon_up(struct work_struct *dummy)
 {
 	unsigned int num_pages = dm_device.balloon_wrk.num_pages;
@@ -1368,6 +1377,7 @@ static void balloon_up(struct work_struct *dummy)
 		}
 	}
 
+	report_ballooned_pages(&dm_device);
 }
 
 static void balloon_down(struct hv_dynmem_device *dm,
@@ -1387,6 +1397,8 @@ static void balloon_down(struct hv_dynmem_device *dm,
 	pr_debug("Freed %u ballooned pages.\n",
 		prev_pages_ballooned - dm->num_pages_ballooned);
 
+	report_ballooned_pages(dm);
+
 	if (req->more_pages == 1)
 		return;
 
-- 
2.31.1

