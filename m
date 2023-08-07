Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0230A77353F
	for <lists+linux-hyperv@lfdr.de>; Tue,  8 Aug 2023 01:56:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbjHGX4K (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 7 Aug 2023 19:56:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjHGX4J (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 7 Aug 2023 19:56:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5113799;
        Mon,  7 Aug 2023 16:56:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D2AA8622F5;
        Mon,  7 Aug 2023 23:56:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 29AA5C433C8;
        Mon,  7 Aug 2023 23:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691452567;
        bh=y80wZe7XnryliTmOr1rJlWPCIteBKCaC95t6Ntbzzpk=;
        h=From:Date:Subject:To:Cc:Reply-To:From;
        b=tyNgPL2OJZpwcH9g50H1gmo7cMwOEyiZsUbQESjPHdsoOzKevmGQBx116J5SltprR
         oQB/PuXGT/NKodcMWPPkeSSIXhhetBM5drDsYbftXi8DrOnAkBTyy0s7vB3I3fl2Xz
         M7eVymbaqLaLNmIxh6kWAEltsHxrkgoSiMQXYaLhp0gC5xCwfh1GXGoT10Sz7qgCeW
         HfFD2A6WyEw5p/2FeGQXyXwsZh75HFl1PvzLR8xRyIBk0doCIg36h3+1jOoBScatio
         PHB1x+zA8uUcl0w9DHdwYYB+9U1DT5jHxIrWm6RwUmug6VulW0GRrmWUxlzNBF3yCn
         lqtwC6qN7Zv9Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.lore.kernel.org (Postfix) with ESMTP id 0305CC001DB;
        Mon,  7 Aug 2023 23:56:06 +0000 (UTC)
From:   Mitchell Levy via B4 Relay 
        <devnull+levymitchell0.gmail.com@kernel.org>
Date:   Mon, 07 Aug 2023 23:55:47 +0000
Subject: [PATCH v2] hv_balloon: Update the balloon driver to use the SBRM
 API
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230807-sbrm-hyperv-v2-1-9d2ac15305bd@gmail.com>
X-B4-Tracking: v=1; b=H4sIAIKE0WQC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyjHQUlJIzE
 vPSU3UzU4B8JSMDI2MDCwNz3eKkolzdjMqC1KIy3TQzQwNjwzRDS5O0FCWgjoKi1LTMCrBp0bG
 1tQB9jYGqXQAAAA==
To:     "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>
Cc:     linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        mikelley@microsoft.com, peterz@infradead.org,
        Boqun Feng <boqun.feng@gmail.com>,
        "Mitchell Levy (Microsoft)" <levymitchell0@gmail.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1691452566; l=7813;
 i=levymitchell0@gmail.com; s=20230725; h=from:subject:message-id;
 bh=qH667BeI+YacELlrdyYKeSaj+DTDq6h6BdMkt//SEmI=;
 b=Fs3VVour8GZIOKMwjFGRXC6gps6Wl3IttieNphHdnaElyQ2U6hptqgNrftOHk6HApzo5w2bpv
 Bq3PBltGMFrDGASv2ZZiWtRpKlz7MRyGtsIcdAmWCE23anBl5ofMITJ
X-Developer-Key: i=levymitchell0@gmail.com; a=ed25519;
 pk=o3BLKQtTK7QMnUiW3/7p5JcITesvc3qL/w+Tz19oYeE=
X-Endpoint-Received: by B4 Relay for levymitchell0@gmail.com/20230725 with auth_id=69
X-Original-From: Mitchell Levy <levymitchell0@gmail.com>
Reply-To: <levymitchell0@gmail.com>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Mitchell Levy <levymitchell0@gmail.com>

This patch is intended as a proof-of-concept for the new SBRM
machinery[1]. For some brief background, the idea behind SBRM is using
the __cleanup__ attribute to automatically unlock locks (or otherwise
release resources) when they go out of scope, similar to C++ style RAII.
This promises some benefits such as making code simpler (particularly
where you have lots of goto fail; type constructs) as well as reducing
the surface area for certain kinds of bugs.

The changes in this patch should not result in any difference in how the
code actually runs (i.e., it's purely an exercise in this new syntax
sugar). In one instance SBRM was not appropriate, so I left that part
alone, but all other locking/unlocking is handled automatically in this
patch.

[1] https://lore.kernel.org/all/20230626125726.GU4253@hirez.programming.kicks-ass.net/

Suggested-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: "Mitchell Levy (Microsoft)" <levymitchell0@gmail.com>
Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
---
Changes from v1 to v2:
- Fixed some formatting errors
---
 drivers/hv/hv_balloon.c | 82 +++++++++++++++++++++++--------------------------
 1 file changed, 38 insertions(+), 44 deletions(-)

diff --git a/drivers/hv/hv_balloon.c b/drivers/hv/hv_balloon.c
index 0d7a3ba66396..e000fa3b9f97 100644
--- a/drivers/hv/hv_balloon.c
+++ b/drivers/hv/hv_balloon.c
@@ -8,6 +8,7 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
+#include <linux/cleanup.h>
 #include <linux/kernel.h>
 #include <linux/jiffies.h>
 #include <linux/mman.h>
@@ -646,7 +647,7 @@ static int hv_memory_notifier(struct notifier_block *nb, unsigned long val,
 			      void *v)
 {
 	struct memory_notify *mem = (struct memory_notify *)v;
-	unsigned long flags, pfn_count;
+	unsigned long pfn_count;
 
 	switch (val) {
 	case MEM_ONLINE:
@@ -655,21 +656,22 @@ static int hv_memory_notifier(struct notifier_block *nb, unsigned long val,
 		break;
 
 	case MEM_OFFLINE:
-		spin_lock_irqsave(&dm_device.ha_lock, flags);
-		pfn_count = hv_page_offline_check(mem->start_pfn,
-						  mem->nr_pages);
-		if (pfn_count <= dm_device.num_pages_onlined) {
-			dm_device.num_pages_onlined -= pfn_count;
-		} else {
-			/*
-			 * We're offlining more pages than we managed to online.
-			 * This is unexpected. In any case don't let
-			 * num_pages_onlined wrap around zero.
-			 */
-			WARN_ON_ONCE(1);
-			dm_device.num_pages_onlined = 0;
+		scoped_guard(spinlock_irqsave, &dm_device.ha_lock) {
+			pfn_count = hv_page_offline_check(mem->start_pfn,
+							  mem->nr_pages);
+			if (pfn_count <= dm_device.num_pages_onlined) {
+				dm_device.num_pages_onlined -= pfn_count;
+			} else {
+				/*
+				 * We're offlining more pages than we
+				 * managed to online. This is
+				 * unexpected. In any case don't let
+				 * num_pages_onlined wrap around zero.
+				 */
+				WARN_ON_ONCE(1);
+				dm_device.num_pages_onlined = 0;
+			}
 		}
-		spin_unlock_irqrestore(&dm_device.ha_lock, flags);
 		break;
 	case MEM_GOING_ONLINE:
 	case MEM_GOING_OFFLINE:
@@ -721,24 +723,23 @@ static void hv_mem_hot_add(unsigned long start, unsigned long size,
 	unsigned long start_pfn;
 	unsigned long processed_pfn;
 	unsigned long total_pfn = pfn_count;
-	unsigned long flags;
 
 	for (i = 0; i < (size/HA_CHUNK); i++) {
 		start_pfn = start + (i * HA_CHUNK);
 
-		spin_lock_irqsave(&dm_device.ha_lock, flags);
-		has->ha_end_pfn +=  HA_CHUNK;
+		scoped_guard(spinlock_irqsave, &dm_device.ha_lock) {
+			has->ha_end_pfn +=  HA_CHUNK;
 
-		if (total_pfn > HA_CHUNK) {
-			processed_pfn = HA_CHUNK;
-			total_pfn -= HA_CHUNK;
-		} else {
-			processed_pfn = total_pfn;
-			total_pfn = 0;
-		}
+			if (total_pfn > HA_CHUNK) {
+				processed_pfn = HA_CHUNK;
+				total_pfn -= HA_CHUNK;
+			} else {
+				processed_pfn = total_pfn;
+				total_pfn = 0;
+			}
 
-		has->covered_end_pfn +=  processed_pfn;
-		spin_unlock_irqrestore(&dm_device.ha_lock, flags);
+			has->covered_end_pfn +=  processed_pfn;
+		}
 
 		reinit_completion(&dm_device.ol_waitevent);
 
@@ -758,10 +759,10 @@ static void hv_mem_hot_add(unsigned long start, unsigned long size,
 				 */
 				do_hot_add = false;
 			}
-			spin_lock_irqsave(&dm_device.ha_lock, flags);
-			has->ha_end_pfn -= HA_CHUNK;
-			has->covered_end_pfn -=  processed_pfn;
-			spin_unlock_irqrestore(&dm_device.ha_lock, flags);
+			scoped_guard(spinlock_irqsave, &dm_device.ha_lock) {
+				has->ha_end_pfn -= HA_CHUNK;
+				has->covered_end_pfn -=  processed_pfn;
+			}
 			break;
 		}
 
@@ -781,10 +782,9 @@ static void hv_mem_hot_add(unsigned long start, unsigned long size,
 static void hv_online_page(struct page *pg, unsigned int order)
 {
 	struct hv_hotadd_state *has;
-	unsigned long flags;
 	unsigned long pfn = page_to_pfn(pg);
 
-	spin_lock_irqsave(&dm_device.ha_lock, flags);
+	guard(spinlock_irqsave)(&dm_device.ha_lock);
 	list_for_each_entry(has, &dm_device.ha_region_list, list) {
 		/* The page belongs to a different HAS. */
 		if ((pfn < has->start_pfn) ||
@@ -794,7 +794,6 @@ static void hv_online_page(struct page *pg, unsigned int order)
 		hv_bring_pgs_online(has, pfn, 1UL << order);
 		break;
 	}
-	spin_unlock_irqrestore(&dm_device.ha_lock, flags);
 }
 
 static int pfn_covered(unsigned long start_pfn, unsigned long pfn_cnt)
@@ -803,9 +802,8 @@ static int pfn_covered(unsigned long start_pfn, unsigned long pfn_cnt)
 	struct hv_hotadd_gap *gap;
 	unsigned long residual, new_inc;
 	int ret = 0;
-	unsigned long flags;
 
-	spin_lock_irqsave(&dm_device.ha_lock, flags);
+	guard(spinlock_irqsave)(&dm_device.ha_lock);
 	list_for_each_entry(has, &dm_device.ha_region_list, list) {
 		/*
 		 * If the pfn range we are dealing with is not in the current
@@ -852,7 +850,6 @@ static int pfn_covered(unsigned long start_pfn, unsigned long pfn_cnt)
 		ret = 1;
 		break;
 	}
-	spin_unlock_irqrestore(&dm_device.ha_lock, flags);
 
 	return ret;
 }
@@ -947,7 +944,6 @@ static unsigned long process_hot_add(unsigned long pg_start,
 {
 	struct hv_hotadd_state *ha_region = NULL;
 	int covered;
-	unsigned long flags;
 
 	if (pfn_cnt == 0)
 		return 0;
@@ -979,9 +975,9 @@ static unsigned long process_hot_add(unsigned long pg_start,
 		ha_region->covered_end_pfn = pg_start;
 		ha_region->end_pfn = rg_start + rg_size;
 
-		spin_lock_irqsave(&dm_device.ha_lock, flags);
-		list_add_tail(&ha_region->list, &dm_device.ha_region_list);
-		spin_unlock_irqrestore(&dm_device.ha_lock, flags);
+		scoped_guard(spinlock_irqsave, &dm_device.ha_lock) {
+			list_add_tail(&ha_region->list, &dm_device.ha_region_list);
+		}
 	}
 
 do_pg_range:
@@ -2047,7 +2043,6 @@ static void balloon_remove(struct hv_device *dev)
 	struct hv_dynmem_device *dm = hv_get_drvdata(dev);
 	struct hv_hotadd_state *has, *tmp;
 	struct hv_hotadd_gap *gap, *tmp_gap;
-	unsigned long flags;
 
 	if (dm->num_pages_ballooned != 0)
 		pr_warn("Ballooned pages: %d\n", dm->num_pages_ballooned);
@@ -2073,7 +2068,7 @@ static void balloon_remove(struct hv_device *dev)
 #endif
 	}
 
-	spin_lock_irqsave(&dm_device.ha_lock, flags);
+	guard(spinlock_irqsave)(&dm_device.ha_lock);
 	list_for_each_entry_safe(has, tmp, &dm->ha_region_list, list) {
 		list_for_each_entry_safe(gap, tmp_gap, &has->gap_list, list) {
 			list_del(&gap->list);
@@ -2082,7 +2077,6 @@ static void balloon_remove(struct hv_device *dev)
 		list_del(&has->list);
 		kfree(has);
 	}
-	spin_unlock_irqrestore(&dm_device.ha_lock, flags);
 }
 
 static int balloon_suspend(struct hv_device *hv_dev)

---
base-commit: 14f9643dc90adea074a0ffb7a17d337eafc6a5cc
change-id: 20230807-sbrm-hyperv-f61031f194fd

Best regards,
-- 
Mitchell Levy <levymitchell0@gmail.com>

