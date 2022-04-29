Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5754951457C
	for <lists+linux-hyperv@lfdr.de>; Fri, 29 Apr 2022 11:36:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233639AbiD2Jjx (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 29 Apr 2022 05:39:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230502AbiD2Jjx (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 29 Apr 2022 05:39:53 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0BC857EA3D;
        Fri, 29 Apr 2022 02:36:36 -0700 (PDT)
Received: by linux.microsoft.com (Postfix, from userid 1134)
        id B955C20E9BED; Fri, 29 Apr 2022 02:36:35 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B955C20E9BED
Date:   Fri, 29 Apr 2022 02:36:35 -0700
From:   Shradha Gupta <shradhagupta@microsoft.com>
To:     "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] hv: hv_balloon: Fixed an issue in the earor handling code if
 probe failed
Message-ID: <20220429093635.GA4945@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-11.7 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

If the balloon_probe() function fails, we do some cleanup and similar
functions are called again when after this a balloon_remove()
call is made. This fix makes sure that the cleanup is not called
twice. Also made sure if dm_state is DM_INIT_ERROR, the clean up is
already done properly.

Signed-off-by: Shradha Gupta <shradhagupta@microsoft.com>
---
 drivers/hv/hv_balloon.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/hv/hv_balloon.c b/drivers/hv/hv_balloon.c
index eee7402cfc02..7c62c1c3ffc7 100644
--- a/drivers/hv/hv_balloon.c
+++ b/drivers/hv/hv_balloon.c
@@ -1841,8 +1841,13 @@ static int balloon_probe(struct hv_device *dev,
 	hv_set_drvdata(dev, &dm_device);
 
 	ret = balloon_connect_vsp(dev);
-	if (ret != 0)
+	if (ret != 0) {
+#ifdef CONFIG_MEMORY_HOTPLUG
+		unregister_memory_notifier(&hv_memory_nb);
+		restore_online_page_callback(&hv_online_page);
+#endif
 		return ret;
+	}
 
 	enable_page_reporting();
 	dm_device.state = DM_INITIALIZED;
@@ -1882,12 +1887,14 @@ static int balloon_remove(struct hv_device *dev)
 	cancel_work_sync(&dm->ha_wrk.wrk);
 
 	kthread_stop(dm->thread);
-	disable_page_reporting();
-	vmbus_close(dev->channel);
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
 	spin_lock_irqsave(&dm_device.ha_lock, flags);
 	list_for_each_entry_safe(has, tmp, &dm->ha_region_list, list) {
 		list_for_each_entry_safe(gap, tmp_gap, &has->gap_list, list) {
-- 
2.17.1


