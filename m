Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9C282C5C88
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Nov 2020 20:13:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405176AbgKZTMm (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 26 Nov 2020 14:12:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404315AbgKZTMm (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 26 Nov 2020 14:12:42 -0500
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6396C0613D4;
        Thu, 26 Nov 2020 11:12:41 -0800 (PST)
Received: by mail-ej1-x643.google.com with SMTP id a16so4346585ejj.5;
        Thu, 26 Nov 2020 11:12:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FMrud8LfXmkW9mwIIdAt7s5QAjUw/gu9L9W9jZkX4PE=;
        b=HwlzuKT/urMNSqVFEOX3kVrGWFAcuyBrvjz2h2R+5WLX3U4QeSLY+uKSWp1uFN6tRA
         EKcNoPnq0ZxR1KfKPTfZNwY2P/p2FtC2Lxm3XX/InQ/dLedknBP1JT3W/14JVNVxp4m8
         EfxWxRTlUmw5oRRmadbyv+QQYhdTZlBovVix5Tu5EOE1MT0G38rWftxEJYZTSkKt6sk+
         AZz3izf6HPvPaSdRvyXCYcYpC7l3fVq3SXe5ZI0jltbUWGrnzn6qZEViSKDhFWLZJgMZ
         O8OY9nkWUvl70MFOAsLqTu9aG8Fu1gsy4nOTgcBjojoMtvM5KghOaZ9FNUaac88Idd3k
         Y4nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FMrud8LfXmkW9mwIIdAt7s5QAjUw/gu9L9W9jZkX4PE=;
        b=Kh5ndqYpLmJtYWgyOpL3jmatiyUe8dzLd1RnjQHKsvaeEasOHPOpqx6NqHPUMgiGG7
         D0h0iategV8L7ym/s7HfzDk5R3U43K4FEolyJiH2cdpKF5BR8kcdy4HWrUfboQ+76o+2
         ctSoPdDVvffNgm5pjhtbvVN+sICrucZHriqZKDCTVBsRtIsWNn9R8L28hSl+YRrHM4xT
         GYzqyJ+5FKAxJEaxZH8UhYO/i539LM2l6aMA3HmNvmo2wT3jww9KncADg26fjConWgc5
         CNP55PZ2axibUciP7rYARkU6l7VwzHt4BnTw2fQ+DglCb5HmVH3jnqVWgCeg/gEFU85H
         1ecw==
X-Gm-Message-State: AOAM5327yIBr2M/wlYUC0+D1uMDJEJ3mKXQY4jROHQzrP8UpzsyjFoRy
        8t6YrxOtt2ngAbua1urI6Kzhwce/OmyTfQ==
X-Google-Smtp-Source: ABdhPJxq31oUyd31FbvdxfpQ/P2XWaIW0lbgQX/52RbAulrQuuWj1Pp9pcDNjucZiNYmEiw4d9Joqw==
X-Received: by 2002:a17:906:b01:: with SMTP id u1mr3897225ejg.427.1606417959971;
        Thu, 26 Nov 2020 11:12:39 -0800 (PST)
Received: from localhost.localdomain (host-82-51-6-75.retail.telecomitalia.it. [82.51.6.75])
        by smtp.gmail.com with ESMTPSA id b15sm3786041edv.85.2020.11.26.11.12.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2020 11:12:39 -0800 (PST)
From:   "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org
Cc:     "K . Y . Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>
Subject: [PATCH] Drivers: hv: vmbus: Introduce the CHANNELMSG_MODIFYCHANNEL_RESPONSE message type
Date:   Thu, 26 Nov 2020 20:12:10 +0100
Message-Id: <20201126191210.13115-1-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Quoting from commit 7527810573436f ("Drivers: hv: vmbus: Introduce
the CHANNELMSG_MODIFYCHANNEL message type"),

  "[...] Hyper-V can *not* currently ACK CHANNELMSG_MODIFYCHANNEL
   messages with the promise that (after the ACK is sent) the
   channel won't send any more interrupts to the "old" CPU.

   The peculiarity of the CHANNELMSG_MODIFYCHANNEL messages is
   problematic if the user want to take a CPU offline, since we
   don't want to take a CPU offline (and, potentially, "lose"
   channel interrupts on such CPU) if the host is still processing
   a CHANNELMSG_MODIFYCHANNEL message associated to that CPU."

Introduce the CHANNELMSG_MODIFYCHANNEL_RESPONSE(24) message type,
which embodies the type of the CHANNELMSG_MODIFYCHANNEL ACK.

Signed-off-by: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
---
 drivers/hv/channel.c      | 108 ++++++++++++++++++++++++++++++++------
 drivers/hv/channel_mgmt.c |  42 +++++++++++++++
 drivers/hv/connection.c   |   3 +-
 drivers/hv/hv.c           |  52 ++++++++++++++++++
 drivers/hv/hv_trace.h     |  15 ++++++
 drivers/hv/vmbus_drv.c    |   4 +-
 include/linux/hyperv.h    |  13 ++++-
 7 files changed, 218 insertions(+), 19 deletions(-)

diff --git a/drivers/hv/channel.c b/drivers/hv/channel.c
index fbdda9938039a..6801d89a20051 100644
--- a/drivers/hv/channel.c
+++ b/drivers/hv/channel.c
@@ -209,31 +209,107 @@ int vmbus_send_tl_connect_request(const guid_t *shv_guest_servie_id,
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
+	if (channel->rescind) {
+		ret = -ENODEV;
+		goto free_info;
+	}
+
+	ret = vmbus_post_msg(msg, sizeof(struct vmbus_channel_modifychannel), true);
+	trace_vmbus_send_modifychannel(msg, ret);
+	if (ret != 0)
+		goto clean_msglist;
+
+	/*
+	 * Release channel_mutex; otherwise, vmbus_onoffer_rescind() could block on
+	 * the mutex and be unable to signal the completion.
+	 */
+	mutex_unlock(&vmbus_connection.channel_mutex);
+	wait_for_completion(&info->waitevent);
+	mutex_lock(&vmbus_connection.channel_mutex);
+
+	spin_lock_irqsave(&vmbus_connection.channelmsg_lock, flags);
+	list_del(&info->msglistentry);
+	spin_unlock_irqrestore(&vmbus_connection.channelmsg_lock, flags);
+
+	if (channel->rescind) {
+		ret = -ENODEV;
+		goto free_info;
+	}
+
+	if (info->response.modify_response.status) {
+		kfree(info);
+		return -EAGAIN;
+	}
+
+	kfree(info);
+	return 0;
+
+clean_msglist:
+	spin_lock_irqsave(&vmbus_connection.channelmsg_lock, flags);
+	list_del(&info->msglistentry);
+	spin_unlock_irqrestore(&vmbus_connection.channelmsg_lock, flags);
+free_info:
+	kfree(info);
+	return ret;
+}
+
 /*
  * Set/change the vCPU (@target_vp) the channel (@child_relid) will interrupt.
  *
  * CHANNELMSG_MODIFYCHANNEL messages are aynchronous.  Also, Hyper-V does not
- * ACK such messages.  IOW we can't know when the host will stop interrupting
- * the "old" vCPU and start interrupting the "new" vCPU for the given channel.
+ * ACK such messages before VERSION_WIN10_V5_3.  Without ACK, we can not know
+ * when the host will stop interrupting the "old" vCPU and start interrupting
+ * the "new" vCPU for the given channel.
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
index 1d44bb635bb84..8fcb66d623ba4 100644
--- a/drivers/hv/channel_mgmt.c
+++ b/drivers/hv/channel_mgmt.c
@@ -1200,6 +1200,46 @@ static void vmbus_onopen_result(struct vmbus_channel_message_header *hdr)
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
+				       sizeof(struct vmbus_channel_modifychannel_response));
+				complete(&msginfo->waitevent);
+				break;
+			}
+		}
+	}
+	spin_unlock_irqrestore(&vmbus_connection.channelmsg_lock, flags);
+}
+
 /*
  * vmbus_ongpadl_created - GPADL created handler.
  *
@@ -1366,6 +1406,8 @@ channel_message_table[CHANNELMSG_COUNT] = {
 	{ CHANNELMSG_TL_CONNECT_REQUEST,	0, NULL, 0},
 	{ CHANNELMSG_MODIFYCHANNEL,		0, NULL, 0},
 	{ CHANNELMSG_TL_CONNECT_RESULT,		0, NULL, 0},
+	{ CHANNELMSG_MODIFYCHANNEL_RESPONSE,	1, vmbus_onmodifychannel_response,
+		sizeof(struct vmbus_channel_modifychannel_response)},
 };
 
 /*
diff --git a/drivers/hv/connection.c b/drivers/hv/connection.c
index 11170d9a2e1a5..cdf41c504d914 100644
--- a/drivers/hv/connection.c
+++ b/drivers/hv/connection.c
@@ -45,6 +45,7 @@ EXPORT_SYMBOL_GPL(vmbus_proto_version);
  * Table of VMBus versions listed from newest to oldest.
  */
 static __u32 vmbus_versions[] = {
+	VERSION_WIN10_V5_3,
 	VERSION_WIN10_V5_2,
 	VERSION_WIN10_V5_1,
 	VERSION_WIN10_V5,
@@ -60,7 +61,7 @@ static __u32 vmbus_versions[] = {
  * Maximal VMBus protocol version guests can negotiate.  Useful to cap the
  * VMBus version for testing and debugging purpose.
  */
-static uint max_version = VERSION_WIN10_V5_2;
+static uint max_version = VERSION_WIN10_V5_3;
 
 module_param(max_version, uint, S_IRUGO);
 MODULE_PARM_DESC(max_version,
diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
index 0cde10fe0e71f..35f240f4c833e 100644
--- a/drivers/hv/hv.c
+++ b/drivers/hv/hv.c
@@ -16,6 +16,7 @@
 #include <linux/version.h>
 #include <linux/random.h>
 #include <linux/clockchips.h>
+#include <linux/delay.h>
 #include <clocksource/hyperv_timer.h>
 #include <asm/mshyperv.h>
 #include "hyperv_vmbus.h"
@@ -237,6 +238,40 @@ void hv_synic_disable_regs(unsigned int cpu)
 	hv_set_synic_state(sctrl.as_uint64);
 }
 
+#define HV_MAX_TRIES 3
+/*
+ * Scan the event flags page of 'this' CPU looking for any bit that is set.  If we find one
+ * bit set, then wait for a few milliseconds.  Repeat these steps for a maximum of 3 times.
+ * Return 'true', if there is still any set bit after this operation; 'false', otherwise.
+ */
+static bool hv_synic_event_pending(void)
+{
+	struct hv_per_cpu_context *hv_cpu = this_cpu_ptr(hv_context.cpu_context);
+	union hv_synic_event_flags *event =
+		(union hv_synic_event_flags *)hv_cpu->synic_event_page + VMBUS_MESSAGE_SINT;
+	unsigned long *recv_int_page = event->flags;
+	bool pending;
+	u32 relid;
+	int tries = 0;
+
+retry:
+	pending = false;
+	for_each_set_bit(relid, recv_int_page, HV_EVENT_FLAGS_COUNT) {
+		/* Special case - VMBus channel protocol messages */
+		if (relid == 0)
+			continue;
+		if (sync_test_bit(relid, recv_int_page)) {
+			pending = true;
+			break;
+		}
+	}
+	if (pending && tries++ < HV_MAX_TRIES) {
+		usleep_range(10000, 20000);
+		goto retry;
+	}
+	return pending;
+}
+
 int hv_synic_cleanup(unsigned int cpu)
 {
 	struct vmbus_channel *channel, *sc;
@@ -276,6 +311,23 @@ int hv_synic_cleanup(unsigned int cpu)
 	if (channel_found && vmbus_connection.conn_state == CONNECTED)
 		return -EBUSY;
 
+	if (vmbus_proto_version >= VERSION_WIN10_V5_3) {
+		/*
+		 * channel_found == false means that any channels that were previously
+		 * assigned to the CPU have been reassigned elsewhere.  Since we have
+		 * received a ModifyChannel ACK from Hyper-V for all such reassignments,
+		 * we know that Hyper-V won't set any new bits in the event flags page.
+		 * However, there may be existing bits set in this page that have not
+		 * been processed by vmbus_chan_sched().  We scan the event flags page
+		 * looking for any bits that are set and waiting (with a timeout) for
+		 * vmbus_chan_sched() to process such bits.  If bits are still set after
+		 * this operation (and VMBus is connected), we fail the CPU offlining
+		 * operation.
+		 */
+		if (hv_synic_event_pending() && vmbus_connection.conn_state == CONNECTED)
+			return -EBUSY;
+	}
+
 	hv_stimer_legacy_cleanup(cpu);
 
 	hv_synic_disable_regs(cpu);
diff --git a/drivers/hv/hv_trace.h b/drivers/hv/hv_trace.h
index 6063bb21bb137..3e83c24856dbe 100644
--- a/drivers/hv/hv_trace.h
+++ b/drivers/hv/hv_trace.h
@@ -86,6 +86,21 @@ TRACE_EVENT(vmbus_onopen_result,
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
 TRACE_EVENT(vmbus_ongpadl_created,
 	    TP_PROTO(const struct vmbus_channel_gpadl_created *gpadlcreated),
 	    TP_ARGS(gpadlcreated),
diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 4fad3e6745e53..3e1cd5e8f769e 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -1767,13 +1767,15 @@ static ssize_t target_cpu_store(struct vmbus_channel *channel,
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
index 1ce131f29f3b4..808acf4c3fe61 100644
--- a/include/linux/hyperv.h
+++ b/include/linux/hyperv.h
@@ -234,6 +234,7 @@ static inline u32 hv_get_avail_to_write_percent(
  * 5 . 0  (Newer Windows 10)
  * 5 . 1  (Windows 10 RS4)
  * 5 . 2  (Windows Server 2019, RS5)
+ * 5 . 3  (Windows Server 2021) // FIXME: use proper version number/name
  */
 
 #define VERSION_WS2008  ((0 << 16) | (13))
@@ -245,6 +246,7 @@ static inline u32 hv_get_avail_to_write_percent(
 #define VERSION_WIN10_V5 ((5 << 16) | (0))
 #define VERSION_WIN10_V5_1 ((5 << 16) | (1))
 #define VERSION_WIN10_V5_2 ((5 << 16) | (2))
+#define VERSION_WIN10_V5_3 ((5 << 16) | (3))
 
 /* Make maximum size of pipe payload of 16K */
 #define MAX_PIPE_DATA_PAYLOAD		(sizeof(u8) * 16384)
@@ -475,6 +477,7 @@ enum vmbus_channel_message_type {
 	CHANNELMSG_TL_CONNECT_REQUEST		= 21,
 	CHANNELMSG_MODIFYCHANNEL		= 22,
 	CHANNELMSG_TL_CONNECT_RESULT		= 23,
+	CHANNELMSG_MODIFYCHANNEL_RESPONSE	= 24,
 	CHANNELMSG_COUNT
 };
 
@@ -588,6 +591,13 @@ struct vmbus_channel_open_result {
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
@@ -720,6 +730,7 @@ struct vmbus_channel_msginfo {
 		struct vmbus_channel_gpadl_torndown gpadl_torndown;
 		struct vmbus_channel_gpadl_created gpadl_created;
 		struct vmbus_channel_version_response version_response;
+		struct vmbus_channel_modifychannel_response modify_response;
 	} response;
 
 	u32 msgsize;
@@ -1562,7 +1573,7 @@ extern __u32 vmbus_proto_version;
 
 int vmbus_send_tl_connect_request(const guid_t *shv_guest_servie_id,
 				  const guid_t *shv_host_servie_id);
-int vmbus_send_modifychannel(u32 child_relid, u32 target_vp);
+int vmbus_send_modifychannel(struct vmbus_channel *channel, u32 target_vp);
 void vmbus_set_event(struct vmbus_channel *channel);
 
 /* Get the start of the ring buffer. */
-- 
2.25.1

