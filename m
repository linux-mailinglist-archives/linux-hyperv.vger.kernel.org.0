Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0427C19EEDD
	for <lists+linux-hyperv@lfdr.de>; Mon,  6 Apr 2020 02:17:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728081AbgDFARH (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 5 Apr 2020 20:17:07 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37154 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728075AbgDFARH (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 5 Apr 2020 20:17:07 -0400
Received: by mail-wm1-f67.google.com with SMTP id j19so13981350wmi.2;
        Sun, 05 Apr 2020 17:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LH7H3+ka8T1Y6zrP24bJF5mFlnklpOcoesuSwUlh98c=;
        b=co2v32Wgi+shaEZO9BlsiWKmqsVPKLGR0m3x8UhvG4Ub2FwW4G0M8RmCMfSsJI/R9k
         5A76Cs1b14MgCgSGhe1I8/zkkr1Kr4JRu6x1PYbCkkGcJ+ZcQgsR3UOd8+eTVi7epOS/
         N6rNkuV/i9WgZ4UYvSlx/rfF9u1TKMlasNWQ+lWYAs5tI+oKTDAgDF1K0SI6KxpyC2+n
         16MnFQlDeUXUMklMH3LIdLIt+xhd6DfkG1RFa6r0xBFimU9o6XKKcwy2xXJ3fZJOnXOj
         eQzn9+pA0EPlUMVeYeJ3hSUirtmw3hDvUrZD6pLVlHQ50QkhRxJgfENBC0gyo0gWwTOy
         xCow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LH7H3+ka8T1Y6zrP24bJF5mFlnklpOcoesuSwUlh98c=;
        b=lN9U5VYQCnWGM7pytM6UrqrEgOS+0Jw5hxbVCh+wV4F/AMQx+eNVostdApydsgj06g
         1XFK7iQTIVN2PRsCOiyMXixsI0JY+yzkRhW47gvMu/bvb49t57Rw9ZGpejt/pn7WplKZ
         C4k6jZfSDgB3G88vHnHJIaZgCZZVPDTbA6bwsQ9X2y4mhP/uV+iaWudgcYQ5CEeLEjeI
         5fRKw9noscX0LK+a7Igyt/LLu6Jy6vW4z1xoz4fysaCBKzMMtfBsHneRNnNsksr6UAEM
         eLfSNMpz6Am6aT8FYNd9Q6rn/gNK5OhbGjAZtUv0XLEsV9PIFZluGHb/6jYeYDqLTjQ4
         x/zQ==
X-Gm-Message-State: AGi0Pub4GQuRN16PuA96PePNtPq/Df6jMoWTrboW4zQ7l2IIX+XQkDu9
        g6KFWSCXD2CmsreA3AY5mliB2Ama5LCTZA==
X-Google-Smtp-Source: APiQypLiFzJOHKG9vsgg8d0aQNDsYBoONmIh/sHBJOXd6TYPrsxk6aODpHDfqtP3UrVyPaswYtkmfQ==
X-Received: by 2002:a1c:f619:: with SMTP id w25mr19447433wmc.59.1586132224531;
        Sun, 05 Apr 2020 17:17:04 -0700 (PDT)
Received: from andrea.corp.microsoft.com ([86.61.236.197])
        by smtp.gmail.com with ESMTPSA id j9sm817432wrn.59.2020.04.05.17.17.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Apr 2020 17:17:04 -0700 (PDT)
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
Subject: [PATCH 10/11] Drivers: hv: vmbus: Introduce the CHANNELMSG_MODIFYCHANNEL message type
Date:   Mon,  6 Apr 2020 02:15:13 +0200
Message-Id: <20200406001514.19876-11-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200406001514.19876-1-parri.andrea@gmail.com>
References: <20200406001514.19876-1-parri.andrea@gmail.com>
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
index 3785beead503d..1058c814ab06e 100644
--- a/drivers/hv/channel_mgmt.c
+++ b/drivers/hv/channel_mgmt.c
@@ -1377,7 +1377,7 @@ channel_message_table[CHANNELMSG_COUNT] = {
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
index 18bd1c0e09a83..0f204640c50c2 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -1579,8 +1579,24 @@ static ssize_t vmbus_chan_attr_show(struct kobject *kobj,
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
@@ -1651,11 +1667,99 @@ static ssize_t write_avail_show(struct vmbus_channel *channel, char *buf)
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

