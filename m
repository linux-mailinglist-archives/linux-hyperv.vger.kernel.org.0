Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77B4456D0B0
	for <lists+linux-hyperv@lfdr.de>; Sun, 10 Jul 2022 20:15:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229495AbiGJSPA (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 10 Jul 2022 14:15:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiGJSO7 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 10 Jul 2022 14:14:59 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C5E0D6252;
        Sun, 10 Jul 2022 11:14:58 -0700 (PDT)
Received: by linux.microsoft.com (Postfix, from userid 1134)
        id 51B5B204C41B; Sun, 10 Jul 2022 11:14:58 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 51B5B204C41B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1657476898;
        bh=nGGZGIK6XLCZSbEZ1/OXjmDPFwgUs7UXTafZHcI4weA=;
        h=Date:From:To:Cc:Subject:From;
        b=L2rBPxAIXmzEDtfVlcnmfOW1ImTkmiS9MkWSYI+VZlgAa5TyiEgoaE6X0WZptftvF
         UBd+8VelYU6+oYokZWk5lmHrjY/oDJey35+sHnVD1u6qrlSawb9jBC4BLnFYCJ3gLm
         w3jAC5LN5/jHfqQc6hkU4FjjZMMkwOekZVsuy64I=
Date:   Sun, 10 Jul 2022 11:14:58 -0700
From:   Shradha Gupta <shradhagupta@linux.microsoft.com>
To:     linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Shradha Gupta <shradhagupta@microsoft.com>,
        Praveen Kumar <kumarpraveen@microsoft.com>
Subject: [PATCH v2] Drivers: hv: vm_bus: Handle vmbus rescind calls after
 vmbus is suspended
Message-ID: <20220710181458.GA20827@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Add a flag to indicate that the vmbus is suspended so we should ignore
any offer message. Add a new work_queue for rescind msg, so we could drain
it along with other offer work_queues upon suspension.
It was observed that in some hibernation related scenario testing, after
vmbus_bus_suspend() we get rescind offer message for the vmbus. This would
lead to processing of a rescind message for a channel that has already been
suspended.

Signed-off-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
---

Changes in v2:
* Rename the ignore_offer_rescind_msg flag to ignore_any_offer_msg, to
  indicate that the flag can cause any offer message to be dropped.
* Remove redundent tasklet_enable(), tasklet_disable() calls around
  ignore_any_offer_msg flag when value is changed from true to false.
* Add comment about tasklet_enable() providing memory barrier.
* In vmbus_bus_suspend() after we drain all workqueues, remove the code
  to wait for any offer_in_progress

---
 drivers/hv/connection.c   | 11 +++++++++++
 drivers/hv/hyperv_vmbus.h |  7 +++++++
 drivers/hv/vmbus_drv.c    | 29 +++++++++++++++++++++--------
 3 files changed, 39 insertions(+), 8 deletions(-)

diff --git a/drivers/hv/connection.c b/drivers/hv/connection.c
index 6218bbf6863a..eca7afd366d6 100644
--- a/drivers/hv/connection.c
+++ b/drivers/hv/connection.c
@@ -171,6 +171,14 @@ int vmbus_connect(void)
 		goto cleanup;
 	}
 
+	vmbus_connection.rescind_work_queue =
+		create_workqueue("hv_vmbus_rescind");
+	if (!vmbus_connection.rescind_work_queue) {
+		ret = -ENOMEM;
+		goto cleanup;
+	}
+	vmbus_connection.ignore_any_offer_msg = false;
+
 	vmbus_connection.handle_primary_chan_wq =
 		create_workqueue("hv_pri_chan");
 	if (!vmbus_connection.handle_primary_chan_wq) {
@@ -357,6 +365,9 @@ void vmbus_disconnect(void)
 	if (vmbus_connection.handle_primary_chan_wq)
 		destroy_workqueue(vmbus_connection.handle_primary_chan_wq);
 
+	if (vmbus_connection.rescind_work_queue)
+		destroy_workqueue(vmbus_connection.rescind_work_queue);
+
 	if (vmbus_connection.work_queue)
 		destroy_workqueue(vmbus_connection.work_queue);
 
diff --git a/drivers/hv/hyperv_vmbus.h b/drivers/hv/hyperv_vmbus.h
index 4f5b824b16cf..dc673edf053c 100644
--- a/drivers/hv/hyperv_vmbus.h
+++ b/drivers/hv/hyperv_vmbus.h
@@ -261,6 +261,13 @@ struct vmbus_connection {
 	struct workqueue_struct *work_queue;
 	struct workqueue_struct *handle_primary_chan_wq;
 	struct workqueue_struct *handle_sub_chan_wq;
+	struct workqueue_struct *rescind_work_queue;
+
+	/*
+	 * On suspension of the vmbus, the accumulated offer messages
+	 * must be dropped.
+	 */
+	bool ignore_any_offer_msg;
 
 	/*
 	 * The number of sub-channels and hv_sock channels that should be
diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 547ae334e5cd..4ba0eb2441cf 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -1160,7 +1160,9 @@ void vmbus_on_msg_dpc(unsigned long data)
 			 * work queue: the RESCIND handler can not start to
 			 * run before the OFFER handler finishes.
 			 */
-			schedule_work(&ctx->work);
+			if (vmbus_connection.ignore_any_offer_msg)
+				break;
+			queue_work(vmbus_connection.rescind_work_queue, &ctx->work);
 			break;
 
 		case CHANNELMSG_OFFERCHANNEL:
@@ -1186,6 +1188,8 @@ void vmbus_on_msg_dpc(unsigned long data)
 			 * to the CPUs which will execute the offer & rescind
 			 * works by the time these works will start execution.
 			 */
+			if (vmbus_connection.ignore_any_offer_msg)
+				break;
 			atomic_inc(&vmbus_connection.offer_in_progress);
 			fallthrough;
 
@@ -2446,15 +2450,20 @@ static int vmbus_acpi_add(struct acpi_device *device)
 #ifdef CONFIG_PM_SLEEP
 static int vmbus_bus_suspend(struct device *dev)
 {
+	struct hv_per_cpu_context *hv_cpu = per_cpu_ptr(
+			hv_context.cpu_context, VMBUS_CONNECT_CPU);
 	struct vmbus_channel *channel, *sc;
 
-	while (atomic_read(&vmbus_connection.offer_in_progress) != 0) {
-		/*
-		 * We wait here until the completion of any channel
-		 * offers that are currently in progress.
-		 */
-		usleep_range(1000, 2000);
-	}
+	tasklet_disable(&hv_cpu->msg_dpc);
+	vmbus_connection.ignore_any_offer_msg = true;
+	/* The tasklet_enable() takes care of providing a memory barrier */
+	tasklet_enable(&hv_cpu->msg_dpc);
+
+	/* Drain all the workqueues as we are in suspend */
+	drain_workqueue(vmbus_connection.rescind_work_queue);
+	drain_workqueue(vmbus_connection.work_queue);
+	drain_workqueue(vmbus_connection.handle_primary_chan_wq);
+	drain_workqueue(vmbus_connection.handle_sub_chan_wq);
 
 	mutex_lock(&vmbus_connection.channel_mutex);
 	list_for_each_entry(channel, &vmbus_connection.chn_list, listentry) {
@@ -2527,10 +2536,14 @@ static int vmbus_bus_suspend(struct device *dev)
 
 static int vmbus_bus_resume(struct device *dev)
 {
+	struct hv_per_cpu_context *hv_cpu = per_cpu_ptr(
+			hv_context.cpu_context, VMBUS_CONNECT_CPU);
 	struct vmbus_channel_msginfo *msginfo;
 	size_t msgsize;
 	int ret;
 
+	vmbus_connection.ignore_any_offer_msg = false;
+
 	/*
 	 * We only use the 'vmbus_proto_version', which was in use before
 	 * hibernation, to re-negotiate with the host.
-- 
2.17.1

