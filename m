Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB09E1933FF
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Mar 2020 23:57:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727491AbgCYW4s (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 25 Mar 2020 18:56:48 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38437 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727751AbgCYW4s (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 25 Mar 2020 18:56:48 -0400
Received: by mail-wr1-f65.google.com with SMTP id s1so5607051wrv.5;
        Wed, 25 Mar 2020 15:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oVYtYG/cfa/erwJ/gL1Hydo8eogqGObbH1h/pbPwt/8=;
        b=pa7Qfqv2hQJmqDGlJabR+PVCole9j/cbfUXWadSUlzo8xtD0VSlD4SinaieuAlCa6l
         BIyAxIvZsfy5ZUQNkPdz+bfBN17fTZNRM1h+6LndSZy8Z9w+PnjSuU+SOobnqAPSIVH4
         8Z+5ADqsKCjQbuIpUjJq/0JTD+dGYsXbdz14LbkwcPubSr/B1Hz7IXJVk00h5eXZmzYp
         Y/VNGkzKrlQfZ+PD2IwiqblXX6WkZbFkeDjRt2Gp1J2a3lJdZxD2sbMhKwtZGE5BV8Wo
         cZHoOIH5ByFt3ms+EWVHYAnJrkuYArvhx/r+mjIaO4az2vviZwDQu0n+2CkuipItilEX
         5zaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oVYtYG/cfa/erwJ/gL1Hydo8eogqGObbH1h/pbPwt/8=;
        b=JUdk1kJ5KtSeUpuI7wPqnfsPDQcO+9j6m7Q56agOk4wfYmyVNYP+wOyxvxgFQLuFb5
         jLgwzWDx7mXVQqLynlns1UNYv+QXyrlJ3MU2ZK+XUUpiUahDyqhD+GBZbVbEt6STHBfP
         3skrbwqllLvoFSac/MUIOJ4maKoc3iGOpuAxtReIdz6is2ehZjnXpTVxjviK+I2QMxEW
         j4vg7VdkxbHAtFjp8/0Ik4jH4iiqKsd14KWCzlACUWIPbnrZGqLWUkdRq/yj9lRUk8Ww
         nBkh1v/uXpQBBF8t3wq/M/nYykJo/ETOVNHMtaBQnielzvNoELB2X4RATosUNFGbhmcx
         yKTw==
X-Gm-Message-State: ANhLgQ1/x4MZO/2PhBfeqRwdzJ+QqIzG2iodWJpzEsMZmA+CeZXv994q
        7EBAOmXQz7NOEK2TZYMCQFP2q0QnQTnqFoP5
X-Google-Smtp-Source: ADFU+vusZsrsq4iU+q3TOTH6VjjKoBt7TKAPUFQT/xJpssjSF1ShgIhfjmeOvTJMHrScKNXRZQ4SGA==
X-Received: by 2002:a5d:46ca:: with SMTP id g10mr5689847wrs.290.1585177004065;
        Wed, 25 Mar 2020 15:56:44 -0700 (PDT)
Received: from andrea.corp.microsoft.com ([86.61.236.197])
        by smtp.gmail.com with ESMTPSA id q72sm790278wme.31.2020.03.25.15.56.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2020 15:56:43 -0700 (PDT)
From:   "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     "K . Y . Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, linux-hyperv@vger.kernel.org,
        Michael Kelley <mikelley@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>
Subject: [RFC PATCH 10/11] Drivers: hv: vmbus: Introduce the CHANNELMSG_MODIFYCHANNEL message type
Date:   Wed, 25 Mar 2020 23:55:04 +0100
Message-Id: <20200325225505.23998-11-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200325225505.23998-1-parri.andrea@gmail.com>
References: <20200325225505.23998-1-parri.andrea@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

VMBus version 4.1 and later support the CHANNELMSG_MODIFYCHANNEL(22)
message type which can be used to request Hyper-V to change the vCPU
that a channel will interrupt.

Introduce the CHANNELMSG_MODIFYCHANNEL message type, and define the
vmbus_send_modifychannel() function to send CHANNELMSG_MODIFYCHANNEL
requests to the host via a hypercall.  The function is then used to
define a sysfs "store" operation, which allows to change the (v)CPU
the channel will interrupt by using the sysfs interface.  The feature
can be used for load balancing or other purposes.

One interesting catch here is that Hyper-V can *not* currently ACK
CHANNELMSG_MODIFYCHANNEL messages with the promise that (after the ACK
is sent) the channel won't send any more interrupts to the "old" CPU.

The peculiarity of the CHANNELMSG_MODIFYCHANNEL messages is problematic
if the user want to take a CPU offline, since we don't want to take a
CPU offline (and, potentially, "lose" channel interrupts on such CPU)
if the host is still processing a CHANNELMSG_MODIFYCHANNEL message
associated to that CPU.

It is worth mentioning, however, that we have been unable to observe
the above mentioned "race": in all our tests, CHANNELMSG_MODIFYCHANNEL
requests appeared *as if* they were processed synchronously by the host.

Suggested-by: Michael Kelley <mikelley@microsoft.com>
Signed-off-by: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
---
 drivers/hv/channel.c      |  28 ++++++++++
 drivers/hv/channel_mgmt.c |   2 +-
 drivers/hv/hv_trace.h     |  19 +++++++
 drivers/hv/vmbus_drv.c    | 108 +++++++++++++++++++++++++++++++++++++-
 include/linux/hyperv.h    |  10 +++-
 5 files changed, 163 insertions(+), 4 deletions(-)

diff --git a/drivers/hv/channel.c b/drivers/hv/channel.c
index 132e476f87b2e..90070b337c10d 100644
--- a/drivers/hv/channel.c
+++ b/drivers/hv/channel.c
@@ -289,6 +289,34 @@ int vmbus_send_tl_connect_request(const guid_t *shv_guest_servie_id,
 }
 EXPORT_SYMBOL_GPL(vmbus_send_tl_connect_request);
 
+/*
+ * Set/change the vCPU (@target_vp) the channel (@child_relid) will interrupt.
+ *
+ * CHANNELMSG_MODIFYCHANNEL messages are aynchronous.  Also, Hyper-V does not
+ * ACK such messages.  IOW we can't know when the host will stop interrupting
+ * the "old" vCPU and start interrupting the "new" vCPU for the given channel.
+ *
+ * The CHANNELMSG_MODIFYCHANNEL message type is supported since VMBus version
+ * VERSION_WIN10_V4_1.
+ */
+int vmbus_send_modifychannel(u32 child_relid, u32 target_vp)
+{
+	struct vmbus_channel_modifychannel conn_msg;
+	int ret;
+
+	memset(&conn_msg, 0, sizeof(conn_msg));
+	conn_msg.header.msgtype = CHANNELMSG_MODIFYCHANNEL;
+	conn_msg.child_relid = child_relid;
+	conn_msg.target_vp = target_vp;
+
+	ret = vmbus_post_msg(&conn_msg, sizeof(conn_msg), true);
+
+	trace_vmbus_send_modifychannel(&conn_msg, ret);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(vmbus_send_modifychannel);
+
 /*
  * create_gpadl_header - Creates a gpadl for the specified buffer
  */
diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
index 34672dc2fc935..818a9d8bf649e 100644
--- a/drivers/hv/channel_mgmt.c
+++ b/drivers/hv/channel_mgmt.c
@@ -1353,7 +1353,7 @@ channel_message_table[CHANNELMSG_COUNT] = {
 	{ CHANNELMSG_19,			0, NULL },
 	{ CHANNELMSG_20,			0, NULL },
 	{ CHANNELMSG_TL_CONNECT_REQUEST,	0, NULL },
-	{ CHANNELMSG_22,			0, NULL },
+	{ CHANNELMSG_MODIFYCHANNEL,		0, NULL },
 	{ CHANNELMSG_TL_CONNECT_RESULT,		0, NULL },
 };
 
diff --git a/drivers/hv/hv_trace.h b/drivers/hv/hv_trace.h
index e70783e33680f..a43bc76c2d5d0 100644
--- a/drivers/hv/hv_trace.h
+++ b/drivers/hv/hv_trace.h
@@ -296,6 +296,25 @@ TRACE_EVENT(vmbus_send_tl_connect_request,
 		    )
 	);
 
+TRACE_EVENT(vmbus_send_modifychannel,
+	    TP_PROTO(const struct vmbus_channel_modifychannel *msg,
+		     int ret),
+	    TP_ARGS(msg, ret),
+	    TP_STRUCT__entry(
+		    __field(u32, child_relid)
+		    __field(u32, target_vp)
+		    __field(int, ret)
+		    ),
+	    TP_fast_assign(
+		    __entry->child_relid = msg->child_relid;
+		    __entry->target_vp = msg->target_vp;
+		    __entry->ret = ret;
+		    ),
+	    TP_printk("binding child_relid 0x%x to target_vp 0x%x, ret %d",
+		      __entry->child_relid, __entry->target_vp, __entry->ret
+		    )
+	);
+
 DECLARE_EVENT_CLASS(vmbus_channel,
 	TP_PROTO(const struct vmbus_channel *channel),
 	TP_ARGS(channel),
diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index ebe2716f583d2..84d2f22c569aa 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -1550,8 +1550,24 @@ static ssize_t vmbus_chan_attr_show(struct kobject *kobj,
 	return attribute->show(chan, buf);
 }
 
+static ssize_t vmbus_chan_attr_store(struct kobject *kobj,
+				     struct attribute *attr, const char *buf,
+				     size_t count)
+{
+	const struct vmbus_chan_attribute *attribute
+		= container_of(attr, struct vmbus_chan_attribute, attr);
+	struct vmbus_channel *chan
+		= container_of(kobj, struct vmbus_channel, kobj);
+
+	if (!attribute->store)
+		return -EIO;
+
+	return attribute->store(chan, buf, count);
+}
+
 static const struct sysfs_ops vmbus_chan_sysfs_ops = {
 	.show = vmbus_chan_attr_show,
+	.store = vmbus_chan_attr_store,
 };
 
 static ssize_t out_mask_show(struct vmbus_channel *channel, char *buf)
@@ -1622,11 +1638,99 @@ static ssize_t write_avail_show(struct vmbus_channel *channel, char *buf)
 }
 static VMBUS_CHAN_ATTR_RO(write_avail);
 
-static ssize_t show_target_cpu(struct vmbus_channel *channel, char *buf)
+static ssize_t target_cpu_show(struct vmbus_channel *channel, char *buf)
 {
 	return sprintf(buf, "%u\n", channel->target_cpu);
 }
-static VMBUS_CHAN_ATTR(cpu, S_IRUGO, show_target_cpu, NULL);
+static ssize_t target_cpu_store(struct vmbus_channel *channel,
+				const char *buf, size_t count)
+{
+	ssize_t ret = count;
+	u32 target_cpu;
+
+	if (vmbus_proto_version < VERSION_WIN10_V4_1)
+		return -EIO;
+
+	if (sscanf(buf, "%uu", &target_cpu) != 1)
+		return -EIO;
+
+	/* Validate target_cpu for the cpumask_test_cpu() operation below. */
+	if (target_cpu >= nr_cpumask_bits)
+		return -EINVAL;
+
+	/* No CPUs should come up or down during this. */
+	cpus_read_lock();
+
+	if (!cpumask_test_cpu(target_cpu, cpu_online_mask)) {
+		cpus_read_unlock();
+		return -EINVAL;
+	}
+
+	/*
+	 * Synchronizes target_cpu_store() and channel closure:
+	 *
+	 * { Initially: state = CHANNEL_OPENED }
+	 *
+	 * CPU1				CPU2
+	 *
+	 * [target_cpu_store()]		[vmbus_disconnect_ring()]
+	 *
+	 * LOCK channel_mutex		LOCK channel_mutex
+	 * LOAD r1 = state		LOAD r2 = state
+	 * IF (r1 == CHANNEL_OPENED)	IF (r2 == CHANNEL_OPENED)
+	 *   SEND MODIFYCHANNEL		  STORE state = CHANNEL_OPEN
+	 *   [...]			  SEND CLOSECHANNEL
+	 * UNLOCK channel_mutex		UNLOCK channel_mutex
+	 *
+	 * Forbids: r1 == r2 == CHANNEL_OPENED (i.e., CPU1's LOCK precedes
+	 * 		CPU2's LOCK) && CPU2's SEND precedes CPU1's SEND
+	 *
+	 * Note.  The host processes the channel messages "sequentially", in
+	 * the order in which they are received on a per-partition basis.
+	 */
+	mutex_lock(&vmbus_connection.channel_mutex);
+
+	/*
+	 * Hyper-V will ignore MODIFYCHANNEL messages for "non-open" channels;
+	 * avoid sending the message and fail here for such channels.
+	 */
+	if (channel->state != CHANNEL_OPENED_STATE) {
+		ret = -EIO;
+		goto cpu_store_unlock;
+	}
+
+	if (channel->target_cpu == target_cpu)
+		goto cpu_store_unlock;
+
+	if (vmbus_send_modifychannel(channel->offermsg.child_relid,
+				     hv_cpu_number_to_vp_number(target_cpu))) {
+		ret = -EIO;
+		goto cpu_store_unlock;
+	}
+
+	/*
+	 * Warning.  At this point, there is *no* guarantee that the host will
+	 * have successfully processed the vmbus_send_modifychannel() request.
+	 * See the header comment of vmbus_send_modifychannel() for more info.
+	 *
+	 * Lags in the processing of the above vmbus_send_modifychannel() can
+	 * result in missed interrupts if the "old" target CPU is taken offline
+	 * before Hyper-V starts sending interrupts to the "new" target CPU.
+	 * But apart from this offlining scenario, the code tolerates such
+	 * lags.  It will function correctly even if a channel interrupt comes
+	 * in on a CPU that is different from the channel target_cpu value.
+	 */
+
+	channel->target_cpu = target_cpu;
+	channel->target_vp = hv_cpu_number_to_vp_number(target_cpu);
+	channel->numa_node = cpu_to_node(target_cpu);
+
+cpu_store_unlock:
+	mutex_unlock(&vmbus_connection.channel_mutex);
+	cpus_read_unlock();
+	return ret;
+}
+static VMBUS_CHAN_ATTR(cpu, 0644, target_cpu_show, target_cpu_store);
 
 static ssize_t channel_pending_show(struct vmbus_channel *channel,
 				    char *buf)
diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
index f8e7c22d41a1a..edfcd42319ef3 100644
--- a/include/linux/hyperv.h
+++ b/include/linux/hyperv.h
@@ -425,7 +425,7 @@ enum vmbus_channel_message_type {
 	CHANNELMSG_19				= 19,
 	CHANNELMSG_20				= 20,
 	CHANNELMSG_TL_CONNECT_REQUEST		= 21,
-	CHANNELMSG_22				= 22,
+	CHANNELMSG_MODIFYCHANNEL		= 22,
 	CHANNELMSG_TL_CONNECT_RESULT		= 23,
 	CHANNELMSG_COUNT
 };
@@ -620,6 +620,13 @@ struct vmbus_channel_tl_connect_request {
 	guid_t host_service_id;
 } __packed;
 
+/* Modify Channel parameters, cf. vmbus_send_modifychannel() */
+struct vmbus_channel_modifychannel {
+	struct vmbus_channel_message_header header;
+	u32 child_relid;
+	u32 target_vp;
+} __packed;
+
 struct vmbus_channel_version_response {
 	struct vmbus_channel_message_header header;
 	u8 version_supported;
@@ -1505,6 +1512,7 @@ extern __u32 vmbus_proto_version;
 
 int vmbus_send_tl_connect_request(const guid_t *shv_guest_servie_id,
 				  const guid_t *shv_host_servie_id);
+int vmbus_send_modifychannel(u32 child_relid, u32 target_vp);
 void vmbus_set_event(struct vmbus_channel *channel);
 
 /* Get the start of the ring buffer. */
-- 
2.24.0

