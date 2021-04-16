Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95AE3362263
	for <lists+linux-hyperv@lfdr.de>; Fri, 16 Apr 2021 16:36:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236583AbhDPOfo (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 16 Apr 2021 10:35:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239096AbhDPOfn (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 16 Apr 2021 10:35:43 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A77C2C061574;
        Fri, 16 Apr 2021 07:35:18 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id sd23so33821121ejb.12;
        Fri, 16 Apr 2021 07:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Yd/CdqA82YIly+p6BA9jgmoq8xgZ1EGPdLeRfN429TQ=;
        b=i9colqOh3IR+hVi/KsBnbUfDfIoQYTL9qLky3u756ARlsja7dOUxBijIfLR9/1qq13
         lzwoAIs/C2mkFTW6vIEoCuAdTdqj+HrW1G3LWN9W9wS3JmAnoHJPke1AnzZHEG8FjQCy
         q4ri0DQY5VJFHe/zC/+EOetuinIC5+v7gjxconRzJmSFqALosuTK7qF9pU1CI+ij1AP1
         V9DaYhoIhNhAZTV1bN5re0KbjN0qreIUlidLsMecjHbOa7bYbDFC+doqZWVeiH/3YLNx
         kmBlC4sUNw5FhhPlXX5JJFqltrBIExRMwB6MqawPHvdwGpmlvEA+moXIJgJr1RM5kFt7
         BwsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Yd/CdqA82YIly+p6BA9jgmoq8xgZ1EGPdLeRfN429TQ=;
        b=T5xFNHkjOjiAAvyTho6EZDY2N6SUf9bGv1BhxnUTyeKGBkKDAPgnx4e5r4EIdcqfvo
         /DsJpyr5wq20eyhFQhbpEi1Z3U7QDYuPNAgLQPGNwiXQhz1R8SZmu/Z74+uW0VvIugYd
         igW+hxcSnNEYNIf2HDyMCbK18US/q1v/yLVLzL1sR6HgqUmELc0rGjC0YOrPteXt5fOO
         5BEqYXr1FA9IzAso65qaeBUS2xzS65uMngAcW6l6hTxdwapA0fFPSDzihqt7i6eLxQ4k
         86ySqnIYqo0TjxRP5veEcavJ67JatvHwPSii5TzjWH4tjzVBfkGqLs7Yhp4eh89bbw5A
         1vuA==
X-Gm-Message-State: AOAM533J+POVnmAiDwfz5MBozdJky6UgJoQai5kt+u7yO3+Xg5KxLmQi
        Le0r++RgExW6NP54IuP8m9KM6BoLNG26cg==
X-Google-Smtp-Source: ABdhPJwETKITS6+qsGsWfOWYRM3MUQ8XIGWJDOFikbYSvjj98CBwj3gUDjC0XABxgoLk3df7flmSSw==
X-Received: by 2002:a17:906:d795:: with SMTP id pj21mr8560825ejb.102.1618583716976;
        Fri, 16 Apr 2021 07:35:16 -0700 (PDT)
Received: from anparri.mshome.net (mob-176-243-167-64.net.vodafone.it. [176.243.167.64])
        by smtp.gmail.com with ESMTPSA id x4sm5399472edd.58.2021.04.16.07.35.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 07:35:16 -0700 (PDT)
From:   "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, linux-hyperv@vger.kernel.org,
        mikelley@microsoft.com,
        "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>
Subject: [PATCH v3 2/3] Drivers: hv: vmbus: Drivers: hv: vmbus: Introduce CHANNELMSG_MODIFYCHANNEL_RESPONSE
Date:   Fri, 16 Apr 2021 16:34:48 +0200
Message-Id: <20210416143449.16185-3-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210416143449.16185-1-parri.andrea@gmail.com>
References: <20210416143449.16185-1-parri.andrea@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Introduce the CHANNELMSG_MODIFYCHANNEL_RESPONSE message type, and code
to receive and process such a message.

Signed-off-by: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
---
 drivers/hv/channel.c      | 99 ++++++++++++++++++++++++++++++++-------
 drivers/hv/channel_mgmt.c | 42 +++++++++++++++++
 drivers/hv/hv_trace.h     | 15 ++++++
 drivers/hv/vmbus_drv.c    |  4 +-
 include/linux/hyperv.h    | 11 ++++-
 5 files changed, 152 insertions(+), 19 deletions(-)

diff --git a/drivers/hv/channel.c b/drivers/hv/channel.c
index db30be8f9ccea..aa4ef75d8dee2 100644
--- a/drivers/hv/channel.c
+++ b/drivers/hv/channel.c
@@ -209,31 +209,96 @@ int vmbus_send_tl_connect_request(const guid_t *shv_guest_servie_id,
 }
 EXPORT_SYMBOL_GPL(vmbus_send_tl_connect_request);
 
+static int send_modifychannel_without_ack(struct vmbus_channel *channel, u32 target_vp)
+{
+	struct vmbus_channel_modifychannel msg;
+	int ret;
+
+	memset(&msg, 0, sizeof(msg));
+	msg.header.msgtype = CHANNELMSG_MODIFYCHANNEL;
+	msg.child_relid = channel->offermsg.child_relid;
+	msg.target_vp = target_vp;
+
+	ret = vmbus_post_msg(&msg, sizeof(msg), true);
+	trace_vmbus_send_modifychannel(&msg, ret);
+
+	return ret;
+}
+
+static int send_modifychannel_with_ack(struct vmbus_channel *channel, u32 target_vp)
+{
+	struct vmbus_channel_modifychannel *msg;
+	struct vmbus_channel_msginfo *info;
+	unsigned long flags;
+	int ret;
+
+	info = kzalloc(sizeof(struct vmbus_channel_msginfo) +
+				sizeof(struct vmbus_channel_modifychannel),
+		       GFP_KERNEL);
+	if (!info)
+		return -ENOMEM;
+
+	init_completion(&info->waitevent);
+	info->waiting_channel = channel;
+
+	msg = (struct vmbus_channel_modifychannel *)info->msg;
+	msg->header.msgtype = CHANNELMSG_MODIFYCHANNEL;
+	msg->child_relid = channel->offermsg.child_relid;
+	msg->target_vp = target_vp;
+
+	spin_lock_irqsave(&vmbus_connection.channelmsg_lock, flags);
+	list_add_tail(&info->msglistentry, &vmbus_connection.chn_msg_list);
+	spin_unlock_irqrestore(&vmbus_connection.channelmsg_lock, flags);
+
+	ret = vmbus_post_msg(msg, sizeof(*msg), true);
+	trace_vmbus_send_modifychannel(msg, ret);
+	if (ret != 0) {
+		spin_lock_irqsave(&vmbus_connection.channelmsg_lock, flags);
+		list_del(&info->msglistentry);
+		spin_unlock_irqrestore(&vmbus_connection.channelmsg_lock, flags);
+		goto free_info;
+	}
+
+	/*
+	 * Release channel_mutex; otherwise, vmbus_onoffer_rescind() could block on
+	 * the mutex and be unable to signal the completion.
+	 *
+	 * See the caller target_cpu_store() for information about the usage of the
+	 * mutex.
+	 */
+	mutex_unlock(&vmbus_connection.channel_mutex);
+	wait_for_completion(&info->waitevent);
+	mutex_lock(&vmbus_connection.channel_mutex);
+
+	spin_lock_irqsave(&vmbus_connection.channelmsg_lock, flags);
+	list_del(&info->msglistentry);
+	spin_unlock_irqrestore(&vmbus_connection.channelmsg_lock, flags);
+
+	if (info->response.modify_response.status)
+		ret = -EAGAIN;
+
+free_info:
+	kfree(info);
+	return ret;
+}
+
 /*
  * Set/change the vCPU (@target_vp) the channel (@child_relid) will interrupt.
  *
- * CHANNELMSG_MODIFYCHANNEL messages are aynchronous.  Also, Hyper-V does not
- * ACK such messages.  IOW we can't know when the host will stop interrupting
- * the "old" vCPU and start interrupting the "new" vCPU for the given channel.
+ * CHANNELMSG_MODIFYCHANNEL messages are aynchronous.  When VMbus version 5.3
+ * or later is negotiated, Hyper-V always sends an ACK in response to such a
+ * message.  For VMbus version 5.2 and earlier, it never sends an ACK.  With-
+ * out an ACK, we can not know when the host will stop interrupting the "old"
+ * vCPU and start interrupting the "new" vCPU for the given channel.
  *
  * The CHANNELMSG_MODIFYCHANNEL message type is supported since VMBus version
  * VERSION_WIN10_V4_1.
  */
-int vmbus_send_modifychannel(u32 child_relid, u32 target_vp)
+int vmbus_send_modifychannel(struct vmbus_channel *channel, u32 target_vp)
 {
-	struct vmbus_channel_modifychannel conn_msg;
-	int ret;
-
-	memset(&conn_msg, 0, sizeof(conn_msg));
-	conn_msg.header.msgtype = CHANNELMSG_MODIFYCHANNEL;
-	conn_msg.child_relid = child_relid;
-	conn_msg.target_vp = target_vp;
-
-	ret = vmbus_post_msg(&conn_msg, sizeof(conn_msg), true);
-
-	trace_vmbus_send_modifychannel(&conn_msg, ret);
-
-	return ret;
+	if (vmbus_proto_version >= VERSION_WIN10_V5_3)
+		return send_modifychannel_with_ack(channel, target_vp);
+	return send_modifychannel_without_ack(channel, target_vp);
 }
 EXPORT_SYMBOL_GPL(vmbus_send_modifychannel);
 
diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
index f3cf4af01e102..4c9e45d1f462c 100644
--- a/drivers/hv/channel_mgmt.c
+++ b/drivers/hv/channel_mgmt.c
@@ -1311,6 +1311,46 @@ static void vmbus_ongpadl_created(struct vmbus_channel_message_header *hdr)
 	spin_unlock_irqrestore(&vmbus_connection.channelmsg_lock, flags);
 }
 
+/*
+ * vmbus_onmodifychannel_response - Modify Channel response handler.
+ *
+ * This is invoked when we received a response to our channel modify request.
+ * Find the matching request, copy the response and signal the requesting thread.
+ */
+static void vmbus_onmodifychannel_response(struct vmbus_channel_message_header *hdr)
+{
+	struct vmbus_channel_modifychannel_response *response;
+	struct vmbus_channel_msginfo *msginfo;
+	unsigned long flags;
+
+	response = (struct vmbus_channel_modifychannel_response *)hdr;
+
+	trace_vmbus_onmodifychannel_response(response);
+
+	/*
+	 * Find the modify msg, copy the response and signal/unblock the wait event.
+	 */
+	spin_lock_irqsave(&vmbus_connection.channelmsg_lock, flags);
+
+	list_for_each_entry(msginfo, &vmbus_connection.chn_msg_list, msglistentry) {
+		struct vmbus_channel_message_header *responseheader =
+				(struct vmbus_channel_message_header *)msginfo->msg;
+
+		if (responseheader->msgtype == CHANNELMSG_MODIFYCHANNEL) {
+			struct vmbus_channel_modifychannel *modifymsg;
+
+			modifymsg = (struct vmbus_channel_modifychannel *)msginfo->msg;
+			if (modifymsg->child_relid == response->child_relid) {
+				memcpy(&msginfo->response.modify_response, response,
+				       sizeof(*response));
+				complete(&msginfo->waitevent);
+				break;
+			}
+		}
+	}
+	spin_unlock_irqrestore(&vmbus_connection.channelmsg_lock, flags);
+}
+
 /*
  * vmbus_ongpadl_torndown - GPADL torndown handler.
  *
@@ -1428,6 +1468,8 @@ channel_message_table[CHANNELMSG_COUNT] = {
 	{ CHANNELMSG_TL_CONNECT_REQUEST,	0, NULL, 0},
 	{ CHANNELMSG_MODIFYCHANNEL,		0, NULL, 0},
 	{ CHANNELMSG_TL_CONNECT_RESULT,		0, NULL, 0},
+	{ CHANNELMSG_MODIFYCHANNEL_RESPONSE,	1, vmbus_onmodifychannel_response,
+		sizeof(struct vmbus_channel_modifychannel_response)},
 };
 
 /*
diff --git a/drivers/hv/hv_trace.h b/drivers/hv/hv_trace.h
index 6063bb21bb137..c02a1719e92f2 100644
--- a/drivers/hv/hv_trace.h
+++ b/drivers/hv/hv_trace.h
@@ -103,6 +103,21 @@ TRACE_EVENT(vmbus_ongpadl_created,
 		    )
 	);
 
+TRACE_EVENT(vmbus_onmodifychannel_response,
+	    TP_PROTO(const struct vmbus_channel_modifychannel_response *response),
+	    TP_ARGS(response),
+	    TP_STRUCT__entry(
+		    __field(u32, child_relid)
+		    __field(u32, status)
+		    ),
+	    TP_fast_assign(__entry->child_relid = response->child_relid;
+			   __entry->status = response->status;
+		    ),
+	    TP_printk("child_relid 0x%x, status %d",
+		      __entry->child_relid,  __entry->status
+		    )
+	);
+
 TRACE_EVENT(vmbus_ongpadl_torndown,
 	    TP_PROTO(const struct vmbus_channel_gpadl_torndown *gpadltorndown),
 	    TP_ARGS(gpadltorndown),
diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 51c40d5e3c8ac..b12d6827b222b 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -1848,13 +1848,15 @@ static ssize_t target_cpu_store(struct vmbus_channel *channel,
 	if (target_cpu == origin_cpu)
 		goto cpu_store_unlock;
 
-	if (vmbus_send_modifychannel(channel->offermsg.child_relid,
+	if (vmbus_send_modifychannel(channel,
 				     hv_cpu_number_to_vp_number(target_cpu))) {
 		ret = -EIO;
 		goto cpu_store_unlock;
 	}
 
 	/*
+	 * For version before VERSION_WIN10_V5_3, the following warning holds:
+	 *
 	 * Warning.  At this point, there is *no* guarantee that the host will
 	 * have successfully processed the vmbus_send_modifychannel() request.
 	 * See the header comment of vmbus_send_modifychannel() for more info.
diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
index 3ce36bbb398e9..9c2373a1cb2d1 100644
--- a/include/linux/hyperv.h
+++ b/include/linux/hyperv.h
@@ -477,6 +477,7 @@ enum vmbus_channel_message_type {
 	CHANNELMSG_TL_CONNECT_REQUEST		= 21,
 	CHANNELMSG_MODIFYCHANNEL		= 22,
 	CHANNELMSG_TL_CONNECT_RESULT		= 23,
+	CHANNELMSG_MODIFYCHANNEL_RESPONSE	= 24,
 	CHANNELMSG_COUNT
 };
 
@@ -590,6 +591,13 @@ struct vmbus_channel_open_result {
 	u32 status;
 } __packed;
 
+/* Modify Channel Result parameters */
+struct vmbus_channel_modifychannel_response {
+	struct vmbus_channel_message_header header;
+	u32 child_relid;
+	u32 status;
+} __packed;
+
 /* Close channel parameters; */
 struct vmbus_channel_close_channel {
 	struct vmbus_channel_message_header header;
@@ -722,6 +730,7 @@ struct vmbus_channel_msginfo {
 		struct vmbus_channel_gpadl_torndown gpadl_torndown;
 		struct vmbus_channel_gpadl_created gpadl_created;
 		struct vmbus_channel_version_response version_response;
+		struct vmbus_channel_modifychannel_response modify_response;
 	} response;
 
 	u32 msgsize;
@@ -1596,7 +1605,7 @@ extern __u32 vmbus_proto_version;
 
 int vmbus_send_tl_connect_request(const guid_t *shv_guest_servie_id,
 				  const guid_t *shv_host_servie_id);
-int vmbus_send_modifychannel(u32 child_relid, u32 target_vp);
+int vmbus_send_modifychannel(struct vmbus_channel *channel, u32 target_vp);
 void vmbus_set_event(struct vmbus_channel *channel);
 
 /* Get the start of the ring buffer. */
-- 
2.25.1

