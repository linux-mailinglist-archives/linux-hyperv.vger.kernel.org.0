Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 519FA7627B6
	for <lists+linux-hyperv@lfdr.de>; Wed, 26 Jul 2023 02:23:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbjGZAXp (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 25 Jul 2023 20:23:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231236AbjGZAXp (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 25 Jul 2023 20:23:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BBC41A8;
        Tue, 25 Jul 2023 17:23:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B9E0F61935;
        Wed, 26 Jul 2023 00:23:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 138F5C433C7;
        Wed, 26 Jul 2023 00:23:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690331023;
        bh=n8uJXeLuOskMOSTFvxFIlIysin1FQNq5sN6Yig5KJJM=;
        h=From:Date:Subject:To:Cc:Reply-To:From;
        b=jV627cONptCuFZwZrq5vMcQjX1OSp8wmOlqA2sDDdyenGHxdLfdwB2aMp9XDV/aop
         d0Wrw0e6HefzRPJ3ilyrJ0FUdTb8HoBgFxiVCrYpo/2Aoai9p8pBKsJykRLeUDF5zc
         fEuCFpOBelgd15IZPGAF6m0UlebRcIM6/PWiBHmIPaGVB4grhhaieDtfxsVJjwzlZD
         r8xHatJFgEov/rQBko1xbzzMgJ2KxXDb2LHioK3YbIk7xe4wVVVJIp37nRl/fiy+B/
         OAHG4bRuQqrUChFU9ZnkDvO5GZ8NAEEkDCKKkSthM9bI54qIOCN8G7vbFnlB5dZo4B
         pCHf7GCE4YXEQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.lore.kernel.org (Postfix) with ESMTP id F3EF8EB64DD;
        Wed, 26 Jul 2023 00:23:42 +0000 (UTC)
From:   Mitchell Levy via B4 Relay 
        <devnull+levymitchell0.gmail.com@kernel.org>
Date:   Wed, 26 Jul 2023 00:23:31 +0000
Subject: [PATCH] hv_balloon: Update the balloon driver to use the SBRM API
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230726-master-v1-1-b2ce6a4538db@gmail.com>
X-B4-Tracking: v=1; b=H4sIAIJnwGQC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2MDcyNT3dzE4pLUIt2kpOQUSyMDU3NTiyQloOKCotS0zAqwQdGxtbUAcXR
 m81gAAAA=
To:     "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>
Cc:     linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        mikelly@microsoft.com, peterz@infradead.org,
        Boqun Feng <boqun.feng@gmail.com>,
        "Mitchell Levy (Microsoft)" <levymitchell0@gmail.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1690331022; l=7710;
 i=levymitchell0@gmail.com; s=20230725; h=from:subject:message-id;
 bh=84uGYvJcj5OV/bgfkKqlgiyUtrhDwWgEQj+Xrg0YrbI=;
 b=BD5lgOcxZEQ142ZfkGpO3DuyzHnugCgXqED3QlEpvQ8EGyB3Hb629rgO6ebbbP9C8XgIh4FC3
 uam7fNanBfgDV6LNQ6LINu2kpzcBU7M1DU1TzddZ3XXjORIkxVGdVRs
X-Developer-Key: i=levymitchell0@gmail.com; a=ed25519;
 pk=o3BLKQtTK7QMnUiW3/7p5JcITesvc3qL/w+Tz19oYeE=
X-Endpoint-Received: by B4 Relay for levymitchell0@gmail.com/20230725 with auth_id=69
X-Original-From: Mitchell Levy <levymitchell0@gmail.com>
Reply-To: <levymitchell0@gmail.com>
X-Spam-Status: No, score=0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Mitchell Levy <levymitchell0@gmail.com>



---
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

Link: https://lore.kernel.org/all/20230626125726.GU4253@hirez.programming.kicks-ass.net/ [1]

Suggested-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: "Mitchell Levy (Microsoft)" <levymitchell0@gmail.com>
---
 drivers/hv/hv_balloon.c | 82 +++++++++++++++++++++++--------------------------
 1 file changed, 38 insertions(+), 44 deletions(-)

diff --git a/drivers/hv/hv_balloon.c b/drivers/hv/hv_balloon.c
index dffcc894f117..2812601e84da 100644
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
base-commit: 3f01e9fed8454dcd89727016c3e5b2fbb8f8e50c
change-id: 20230725-master-bbcd9205758b

Best regards,
-- 
Mitchell Levy <levymitchell0@gmail.com>

