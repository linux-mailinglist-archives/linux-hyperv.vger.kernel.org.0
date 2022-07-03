Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31BB2564577
	for <lists+linux-hyperv@lfdr.de>; Sun,  3 Jul 2022 08:53:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbiGCGxf (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 3 Jul 2022 02:53:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230371AbiGCGxd (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 3 Jul 2022 02:53:33 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C507763CC;
        Sat,  2 Jul 2022 23:53:32 -0700 (PDT)
Received: by linux.microsoft.com (Postfix, from userid 1134)
        id 79A5520DDC6B; Sat,  2 Jul 2022 23:53:32 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 79A5520DDC6B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1656831212;
        bh=Ds8aTmSA5eFOAoyA6JIxktueUDXHcv/AD5IKl0Ss9sg=;
        h=Date:From:To:Cc:Subject:From;
        b=HtPlXrlmnUwcXxEuyTk7jcc+0ruRZHZO6T+JshgFHQMgMtaJITGV5GXoBg+9FK0KY
         FUp8OHJeSFs/SD1QFQ05s5YD+64oMeQsQf3A30+SfOuLbAYs0bxxiogHcLPiE55Swv
         CzoFcUWeuqePMdLhjVLIjvKwArfvcY06w0MdQb5M=
Date:   Sat, 2 Jul 2022 23:53:32 -0700
From:   Shradha Gupta <shradhagupta@linux.microsoft.com>
To:     linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Shradha Gupta <shradhagupta@microsoft.com>
Subject: [PATCH] Drivers: hv: vm_bus: Handle vmbus rescind calls after vmbus
 is suspended
Message-ID: <20220703065332.GA23943@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
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

Add a flag to indicate that the vmbus is suspended so we should ignore the
rescind offer message. Add a new work_queue for rescind msg, so we could 
drain it in vmbus_suspend processing. This should help avoid any rescind 
offer msg processing if ignore_offer_rescind_msg flag is set to true.
It was observed in some hibernation related scenario testing that after
KVP_vmbus suspend, we get another rescind offer message for the vmbus. This
led to rescind message processing after vm_suspend and we would end up with
a warning and stack dumps

Signed-off-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
---
 drivers/hv/connection.c   | 11 +++++++++++
 drivers/hv/hyperv_vmbus.h |  7 +++++++
 drivers/hv/vmbus_drv.c    | 24 +++++++++++++++++++++++-
 3 files changed, 41 insertions(+), 1 deletion(-)

diff --git a/drivers/hv/connection.c b/drivers/hv/connection.c
index 6218bbf6863a..88a0fd8e80c0 100644
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
+	vmbus_connection.ignore_offer_rescind_msg = false;
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
index 4f5b824b16cf..ff8707284554 100644
--- a/drivers/hv/hyperv_vmbus.h
+++ b/drivers/hv/hyperv_vmbus.h
@@ -262,6 +262,13 @@ struct vmbus_connection {
 	struct workqueue_struct *handle_primary_chan_wq;
 	struct workqueue_struct *handle_sub_chan_wq;
 
+	/*
+	 * On suspension of the vmbus, the accumulated rescind message
+	 * must be dropped.
+	 */
+	bool ignore_offer_rescind_msg;
+	struct workqueue_struct *rescind_work_queue;
+
 	/*
 	 * The number of sub-channels and hv_sock channels that should be
 	 * cleaned up upon suspend: sub-channels will be re-created upon
diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 547ae334e5cd..46bd867f11ba 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -1160,7 +1160,9 @@ void vmbus_on_msg_dpc(unsigned long data)
 			 * work queue: the RESCIND handler can not start to
 			 * run before the OFFER handler finishes.
 			 */
-			schedule_work(&ctx->work);
+			if (vmbus_connection.ignore_offer_rescind_msg)
+				break;
+			queue_work(vmbus_connection.rescind_work_queue, &ctx->work);
 			break;
 
 		case CHANNELMSG_OFFERCHANNEL:
@@ -1186,6 +1188,8 @@ void vmbus_on_msg_dpc(unsigned long data)
 			 * to the CPUs which will execute the offer & rescind
 			 * works by the time these works will start execution.
 			 */
+			if (vmbus_connection.ignore_offer_rescind_msg)
+				break;
 			atomic_inc(&vmbus_connection.offer_in_progress);
 			fallthrough;
 
@@ -2446,8 +2450,20 @@ static int vmbus_acpi_add(struct acpi_device *device)
 #ifdef CONFIG_PM_SLEEP
 static int vmbus_bus_suspend(struct device *dev)
 {
+	struct hv_per_cpu_context *hv_cpu = per_cpu_ptr(
+			hv_context.cpu_context, VMBUS_CONNECT_CPU);
 	struct vmbus_channel *channel, *sc;
 
+	tasklet_disable(&hv_cpu->msg_dpc);
+	vmbus_connection.ignore_offer_rescind_msg = true;
+	tasklet_enable(&hv_cpu->msg_dpc);
+
+	/* Drain all the workqueues as we are in suspend */
+	drain_workqueue(vmbus_connection.rescind_work_queue);
+	drain_workqueue(vmbus_connection.work_queue);
+	drain_workqueue(vmbus_connection.handle_primary_chan_wq);
+	drain_workqueue(vmbus_connection.handle_sub_chan_wq);
+
 	while (atomic_read(&vmbus_connection.offer_in_progress) != 0) {
 		/*
 		 * We wait here until the completion of any channel
@@ -2527,10 +2543,16 @@ static int vmbus_bus_suspend(struct device *dev)
 
 static int vmbus_bus_resume(struct device *dev)
 {
+	struct hv_per_cpu_context *hv_cpu = per_cpu_ptr(
+			hv_context.cpu_context, VMBUS_CONNECT_CPU);
 	struct vmbus_channel_msginfo *msginfo;
 	size_t msgsize;
 	int ret;
 
+	tasklet_disable(&hv_cpu->msg_dpc);
+	vmbus_connection.ignore_offer_rescind_msg = false;
+	tasklet_enable(&hv_cpu->msg_dpc);
+
 	/*
 	 * We only use the 'vmbus_proto_version', which was in use before
 	 * hibernation, to re-negotiate with the host.
-- 
2.17.1

