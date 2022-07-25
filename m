Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02DBD57FC8E
	for <lists+linux-hyperv@lfdr.de>; Mon, 25 Jul 2022 11:37:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233301AbiGYJhe (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 25 Jul 2022 05:37:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232340AbiGYJhe (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 25 Jul 2022 05:37:34 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4627B9FF3;
        Mon, 25 Jul 2022 02:37:33 -0700 (PDT)
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
        by linux.microsoft.com (Postfix) with ESMTPSA id E635D20FE02B;
        Mon, 25 Jul 2022 02:37:32 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E635D20FE02B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1658741852;
        bh=6KuO3lg0k3uiAOGDOvjAhWv7j6XUbuiAPwNtN8EgbzM=;
        h=From:To:Subject:Date:From;
        b=VQdheEs3/ZVsFIPjwql2MvNIvHJLSaXycChX/7GsYWqDPvaCI+rMaBWKHtaNo6EEp
         h16n5/9FUq2jKAwQhXoDZnD4SymZnAWBfXHh9Z79X63pQQDLwzeVBKovwNeN8xvEat
         7XT+/fu18FVptQVDsLqbTsld+kvkXjl75VLGAZTI=
From:   Saurabh Sengar <ssengar@linux.microsoft.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, decui@microsoft.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: [PATCH] Drivers: hv: vmbus: Optimize vmbus_on_event
Date:   Mon, 25 Jul 2022 02:37:28 -0700
Message-Id: <1658741848-4210-1-git-send-email-ssengar@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

In the vmbus_on_event loop, 2 jiffies timer will not serve the purpose if
callback_fn takes longer. For effective use move this check inside of
callback functions where needed. Out of all the VMbus drivers using
vmbus_on_event, only storvsc has a high packet volume, thus add this limit
only in storvsc callback for now.
There is no apparent benefit of loop itself because this tasklet will be
scheduled anyway again if there are packets left in ring buffer. This
patch removes this unnecessary loop as well.

Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
---
 drivers/hv/connection.c    | 33 ++++++++++++++-------------------
 drivers/scsi/storvsc_drv.c |  9 +++++++++
 2 files changed, 23 insertions(+), 19 deletions(-)

diff --git a/drivers/hv/connection.c b/drivers/hv/connection.c
index eca7afd..9dc27e5 100644
--- a/drivers/hv/connection.c
+++ b/drivers/hv/connection.c
@@ -431,34 +431,29 @@ struct vmbus_channel *relid2channel(u32 relid)
 void vmbus_on_event(unsigned long data)
 {
 	struct vmbus_channel *channel = (void *) data;
-	unsigned long time_limit = jiffies + 2;
+	void (*callback_fn)(void *context);
 
 	trace_vmbus_on_event(channel);
 
 	hv_debug_delay_test(channel, INTERRUPT_DELAY);
-	do {
-		void (*callback_fn)(void *);
 
-		/* A channel once created is persistent even when
-		 * there is no driver handling the device. An
-		 * unloading driver sets the onchannel_callback to NULL.
-		 */
-		callback_fn = READ_ONCE(channel->onchannel_callback);
-		if (unlikely(callback_fn == NULL))
-			return;
-
-		(*callback_fn)(channel->channel_callback_context);
+	/* A channel once created is persistent even when
+	 * there is no driver handling the device. An
+	 * unloading driver sets the onchannel_callback to NULL.
+	 */
+	callback_fn = READ_ONCE(channel->onchannel_callback);
+	if (unlikely(!callback_fn))
+		return;
 
-		if (channel->callback_mode != HV_CALL_BATCHED)
-			return;
+	(*callback_fn)(channel->channel_callback_context);
 
-		if (likely(hv_end_read(&channel->inbound) == 0))
-			return;
+	if (channel->callback_mode != HV_CALL_BATCHED)
+		return;
 
-		hv_begin_read(&channel->inbound);
-	} while (likely(time_before(jiffies, time_limit)));
+	if (likely(hv_end_read(&channel->inbound) == 0))
+		return;
 
-	/* The time limit (2 jiffies) has been reached */
+	hv_begin_read(&channel->inbound);
 	tasklet_schedule(&channel->callback_event);
 }
 
diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
index fe000da..c457e6b 100644
--- a/drivers/scsi/storvsc_drv.c
+++ b/drivers/scsi/storvsc_drv.c
@@ -60,6 +60,9 @@
 #define VMSTOR_PROTO_VERSION_WIN8_1	VMSTOR_PROTO_VERSION(6, 0)
 #define VMSTOR_PROTO_VERSION_WIN10	VMSTOR_PROTO_VERSION(6, 2)
 
+/* channel callback timeout in ms */
+#define CALLBACK_TIMEOUT               2
+
 /*  Packet structure describing virtual storage requests. */
 enum vstor_packet_operation {
 	VSTOR_OPERATION_COMPLETE_IO		= 1,
@@ -1204,6 +1207,7 @@ static void storvsc_on_channel_callback(void *context)
 	struct hv_device *device;
 	struct storvsc_device *stor_device;
 	struct Scsi_Host *shost;
+	unsigned long time_limit = jiffies + msecs_to_jiffies(CALLBACK_TIMEOUT);
 
 	if (channel->primary_channel != NULL)
 		device = channel->primary_channel->device_obj;
@@ -1224,6 +1228,11 @@ static void storvsc_on_channel_callback(void *context)
 		u32 minlen = rqst_id ? sizeof(struct vstor_packet) :
 			sizeof(enum vstor_packet_operation);
 
+		if (unlikely(time_after(jiffies, time_limit))) {
+			hv_pkt_iter_close(channel);
+			return;
+		}
+
 		if (pktlen < minlen) {
 			dev_err(&device->device,
 				"Invalid pkt: id=%llu, len=%u, minlen=%u\n",
-- 
1.8.3.1

