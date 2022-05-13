Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03A63525FCB
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 May 2022 12:39:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350739AbiEMKUm (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 13 May 2022 06:20:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233183AbiEMKUl (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 13 May 2022 06:20:41 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4997633A16;
        Fri, 13 May 2022 03:20:40 -0700 (PDT)
Received: by linux.microsoft.com (Postfix, from userid 1134)
        id EEB4B20ECB9D; Fri, 13 May 2022 03:20:39 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com EEB4B20ECB9D
Date:   Fri, 13 May 2022 03:20:39 -0700
From:   Shradha Gupta <shradhagupta@microsoft.com>
To:     linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org
Subject: [PATCH] hv_balloon: Fix balloon_probe() and balloon_remove() error
 handling
Message-ID: <20220513102039.GA20318@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-11.7 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

<haiyangz@microsoft.com>, Stephen Hemminger <sthemmin@microsoft.com>,
Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>

Add missing cleanup in balloon_probe() if the call to
balloon_connect_vsp() fails.  Also correctly handle cleanup in
balloon_remove() when dm_state is DM_INIT_ERROR because
balloon_resume() failed.

Signed-off-by: Shradha Gupta <shradhagupta@microsoft.com>
---
 drivers/hv/hv_balloon.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/hv/hv_balloon.c b/drivers/hv/hv_balloon.c
index eee7402cfc02..98fcfb516bbc 100644
--- a/drivers/hv/hv_balloon.c
+++ b/drivers/hv/hv_balloon.c
@@ -1842,7 +1842,7 @@ static int balloon_probe(struct hv_device *dev,
 
 	ret = balloon_connect_vsp(dev);
 	if (ret != 0)
-		return ret;
+		goto connect_error;
 
 	enable_page_reporting();
 	dm_device.state = DM_INITIALIZED;
@@ -1861,6 +1861,7 @@ static int balloon_probe(struct hv_device *dev,
 	dm_device.thread  = NULL;
 	disable_page_reporting();
 	vmbus_close(dev->channel);
+connect_error:
 #ifdef CONFIG_MEMORY_HOTPLUG
 	unregister_memory_notifier(&hv_memory_nb);
 	restore_online_page_callback(&hv_online_page);
@@ -1882,12 +1883,21 @@ static int balloon_remove(struct hv_device *dev)
 	cancel_work_sync(&dm->ha_wrk.wrk);
 
 	kthread_stop(dm->thread);
-	disable_page_reporting();
-	vmbus_close(dev->channel);
+
+	/*
+	 * This is to handle the case when balloon_resume()
+	 * call has failed and some cleanup has been done as
+	 * a part of the error handling.
+	 */
+	if (dm_device.state != DM_INIT_ERROR) {
+		disable_page_reporting();
+		vmbus_close(dev->channel);
 #ifdef CONFIG_MEMORY_HOTPLUG
-	unregister_memory_notifier(&hv_memory_nb);
-	restore_online_page_callback(&hv_online_page);
+		unregister_memory_notifier(&hv_memory_nb);
+		restore_online_page_callback(&hv_online_page);
 #endif
+	}
+
 	spin_lock_irqsave(&dm_device.ha_lock, flags);
 	list_for_each_entry_safe(has, tmp, &dm->ha_region_list, list) {
 		list_for_each_entry_safe(gap, tmp_gap, &has->gap_list, list) {
@@ -1948,6 +1958,7 @@ static int balloon_resume(struct hv_device *dev)
 	vmbus_close(dev->channel);
 out:
 	dm_device.state = DM_INIT_ERROR;
+	disable_page_reporting();
 #ifdef CONFIG_MEMORY_HOTPLUG
 	unregister_memory_notifier(&hv_memory_nb);
 	restore_online_page_callback(&hv_online_page);
-- 
2.17.1

