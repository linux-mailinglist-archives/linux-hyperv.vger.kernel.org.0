Return-Path: <linux-hyperv+bounces-1914-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63C5C8975AF
	for <lists+linux-hyperv@lfdr.de>; Wed,  3 Apr 2024 18:56:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFFC11F299AF
	for <lists+linux-hyperv@lfdr.de>; Wed,  3 Apr 2024 16:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B549152532;
	Wed,  3 Apr 2024 16:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="AI03hNcU"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 842CC152199;
	Wed,  3 Apr 2024 16:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712163352; cv=none; b=dY9HxOu4DBJqbZsdjzDej0I65GrLcPjOksaKEyXv/v2zKdYDECoAlm+s8sEQfAEORII9UHUWJXfX8ayghVFrIknd6MLHkBJvi1qv5cXxBJUDdb419qD6b/UfVW8cqyRMv2jSYeJPLUumzHCII75prD6KzFHUVweXzuF9o0JeDUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712163352; c=relaxed/simple;
	bh=gYY0WwqQ8uFY9p2X2CfhfsndFydjbUCKCfj8iM4W1D0=;
	h=From:To:Cc:Subject:Date:Message-Id; b=Hvo5lliY0jeAW4PNTnB1z5XdKh5B/OJy7rfPnQgK5eBOkx136Y/VZxZdoWt/0yAQX1YrgOFebhNolA0yJlQaj0a2Pf7xlM47VxPxGDviZqx7+t8d+dCsw3VyklWWj3mih4gd2/jnghszkO9GO32dM+X3Jqu7z8WHUx1TYm+vJoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=AI03hNcU; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from apais-vm1.0synte4vioeebbvidf5q0vz2ua.xx.internal.cloudapp.net (unknown [52.183.86.224])
	by linux.microsoft.com (Postfix) with ESMTPSA id 26DEF20E8CB5;
	Wed,  3 Apr 2024 09:55:50 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 26DEF20E8CB5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1712163350;
	bh=LgG2vbtVW7mqgHs8YSWwfAEi6r6VGoVHPBHTa0bkXuk=;
	h=From:To:Cc:Subject:Date:From;
	b=AI03hNcUDCF1+YCKH559xNOocA5uMP17nP9CTEwXMlMdDNLWCJbVHaNNwOgroX3JL
	 O3lX1AzDtyZzbGskDgqg2maGmjMIB5wOiLcQua1bz02hyGkDW12IjnVCqDenD0KoOj
	 8NWZuVUERrzznalDblcO+VFU7EcuevtN/kbPRH/4=
From: Allen Pais <apais@linux.microsoft.com>
To: linux-kernel@vger.kernel.org
Cc: tj@kernel.org,
	keescook@chromium.org,
	kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	linux-hyperv@vger.kernel.org
Subject: [PATCH v2 1/2] hyperv: Convert from tasklet to BH workqueue
Date: Wed,  3 Apr 2024 16:55:41 +0000
Message-Id: <20240403165542.21738-1-apais@linux.microsoft.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

The only generic interface to execute asynchronously in the BH context is
tasklet; however, it's marked deprecated and has some design flaws. To
replace tasklets, BH workqueue support was recently added. A BH workqueue
behaves similarly to regular workqueues except that the queued work items
are executed in the BH context.

This patch converts drivers/hv/* from tasklet to BH workqueue.

Based on the work done by Tejun Heo <tj@kernel.org>
Branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git for-6.10

Signed-off-by: Allen Pais <allen.lkml@gmail.com>
---
 drivers/hv/channel.c      |  8 ++++----
 drivers/hv/channel_mgmt.c |  5 ++---
 drivers/hv/connection.c   |  9 +++++----
 drivers/hv/hv.c           |  3 +--
 drivers/hv/hv_balloon.c   |  4 ++--
 drivers/hv/hv_fcopy.c     |  8 ++++----
 drivers/hv/hv_kvp.c       |  8 ++++----
 drivers/hv/hv_snapshot.c  |  8 ++++----
 drivers/hv/hyperv_vmbus.h |  9 +++++----
 drivers/hv/vmbus_drv.c    | 20 +++++++++++---------
 include/linux/hyperv.h    |  2 +-
 11 files changed, 43 insertions(+), 41 deletions(-)

diff --git a/drivers/hv/channel.c b/drivers/hv/channel.c
index adbf674355b2..876d78eb4dce 100644
--- a/drivers/hv/channel.c
+++ b/drivers/hv/channel.c
@@ -859,7 +859,7 @@ void vmbus_reset_channel_cb(struct vmbus_channel *channel)
 	unsigned long flags;
 
 	/*
-	 * vmbus_on_event(), running in the per-channel tasklet, can race
+	 * vmbus_on_event(), running in the per-channel work, can race
 	 * with vmbus_close_internal() in the case of SMP guest, e.g., when
 	 * the former is accessing channel->inbound.ring_buffer, the latter
 	 * could be freeing the ring_buffer pages, so here we must stop it
@@ -871,7 +871,7 @@ void vmbus_reset_channel_cb(struct vmbus_channel *channel)
 	 * and that the channel ring buffer is no longer being accessed, cf.
 	 * the calls to napi_disable() in netvsc_device_remove().
 	 */
-	tasklet_disable(&channel->callback_event);
+	disable_work_sync(&channel->callback_event);
 
 	/* See the inline comments in vmbus_chan_sched(). */
 	spin_lock_irqsave(&channel->sched_lock, flags);
@@ -880,8 +880,8 @@ void vmbus_reset_channel_cb(struct vmbus_channel *channel)
 
 	channel->sc_creation_callback = NULL;
 
-	/* Re-enable tasklet for use on re-open */
-	tasklet_enable(&channel->callback_event);
+	/* Re-enable work for use on re-open */
+	enable_and_queue_work(system_bh_wq, &channel->callback_event);
 }
 
 static int vmbus_close_internal(struct vmbus_channel *channel)
diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
index 2f4d09ce027a..58397071a0de 100644
--- a/drivers/hv/channel_mgmt.c
+++ b/drivers/hv/channel_mgmt.c
@@ -353,8 +353,7 @@ static struct vmbus_channel *alloc_channel(void)
 
 	INIT_LIST_HEAD(&channel->sc_list);
 
-	tasklet_init(&channel->callback_event,
-		     vmbus_on_event, (unsigned long)channel);
+	INIT_WORK(&channel->callback_event, vmbus_on_event);
 
 	hv_ringbuffer_pre_init(channel);
 
@@ -366,7 +365,7 @@ static struct vmbus_channel *alloc_channel(void)
  */
 static void free_channel(struct vmbus_channel *channel)
 {
-	tasklet_kill(&channel->callback_event);
+	cancel_work_sync(&channel->callback_event);
 	vmbus_remove_channel_attr_group(channel);
 
 	kobject_put(&channel->kobj);
diff --git a/drivers/hv/connection.c b/drivers/hv/connection.c
index 3cabeeabb1ca..f2a3394a8303 100644
--- a/drivers/hv/connection.c
+++ b/drivers/hv/connection.c
@@ -372,12 +372,13 @@ struct vmbus_channel *relid2channel(u32 relid)
  * 3. Once we return, enable signaling from the host. Once this
  *    state is set we check to see if additional packets are
  *    available to read. In this case we repeat the process.
- *    If this tasklet has been running for a long time
+ *    If this work has been running for a long time
  *    then reschedule ourselves.
  */
-void vmbus_on_event(unsigned long data)
+void vmbus_on_event(struct work_struct *t)
 {
-	struct vmbus_channel *channel = (void *) data;
+	struct vmbus_channel *channel = from_work(channel, t,
+						callback_event);
 	void (*callback_fn)(void *context);
 
 	trace_vmbus_on_event(channel);
@@ -401,7 +402,7 @@ void vmbus_on_event(unsigned long data)
 		return;
 
 	hv_begin_read(&channel->inbound);
-	tasklet_schedule(&channel->callback_event);
+	queue_work(system_bh_wq, &channel->callback_event);
 }
 
 /*
diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
index a8ad728354cb..2af92f08f9ce 100644
--- a/drivers/hv/hv.c
+++ b/drivers/hv/hv.c
@@ -119,8 +119,7 @@ int hv_synic_alloc(void)
 	for_each_present_cpu(cpu) {
 		hv_cpu = per_cpu_ptr(hv_context.cpu_context, cpu);
 
-		tasklet_init(&hv_cpu->msg_dpc,
-			     vmbus_on_msg_dpc, (unsigned long) hv_cpu);
+		INIT_WORK(&hv_cpu->msg_dpc, vmbus_on_msg_dpc);
 
 		if (ms_hyperv.paravisor_present && hv_isolation_type_tdx()) {
 			hv_cpu->post_msg_page = (void *)get_zeroed_page(GFP_ATOMIC);
diff --git a/drivers/hv/hv_balloon.c b/drivers/hv/hv_balloon.c
index e000fa3b9f97..c7efa2ff4cdf 100644
--- a/drivers/hv/hv_balloon.c
+++ b/drivers/hv/hv_balloon.c
@@ -2083,7 +2083,7 @@ static int balloon_suspend(struct hv_device *hv_dev)
 {
 	struct hv_dynmem_device *dm = hv_get_drvdata(hv_dev);
 
-	tasklet_disable(&hv_dev->channel->callback_event);
+	disable_work_sync(&hv_dev->channel->callback_event);
 
 	cancel_work_sync(&dm->balloon_wrk.wrk);
 	cancel_work_sync(&dm->ha_wrk.wrk);
@@ -2094,7 +2094,7 @@ static int balloon_suspend(struct hv_device *hv_dev)
 		vmbus_close(hv_dev->channel);
 	}
 
-	tasklet_enable(&hv_dev->channel->callback_event);
+	enable_and_queue_work(system_bh_wq, &hv_dev->channel->callback_event);
 
 	return 0;
 
diff --git a/drivers/hv/hv_fcopy.c b/drivers/hv/hv_fcopy.c
index 922d83eb7ddf..fd6799293c17 100644
--- a/drivers/hv/hv_fcopy.c
+++ b/drivers/hv/hv_fcopy.c
@@ -71,7 +71,7 @@ static void fcopy_poll_wrapper(void *channel)
 {
 	/* Transaction is finished, reset the state here to avoid races. */
 	fcopy_transaction.state = HVUTIL_READY;
-	tasklet_schedule(&((struct vmbus_channel *)channel)->callback_event);
+	queue_work(system_bh_wq, &((struct vmbus_channel *)channel)->callback_event);
 }
 
 static void fcopy_timeout_func(struct work_struct *dummy)
@@ -391,7 +391,7 @@ int hv_fcopy_pre_suspend(void)
 	if (!fcopy_msg)
 		return -ENOMEM;
 
-	tasklet_disable(&channel->callback_event);
+	disable_work_sync(&channel->callback_event);
 
 	fcopy_msg->operation = CANCEL_FCOPY;
 
@@ -404,7 +404,7 @@ int hv_fcopy_pre_suspend(void)
 
 	fcopy_transaction.state = HVUTIL_READY;
 
-	/* tasklet_enable() will be called in hv_fcopy_pre_resume(). */
+	/* enable_and_queue_work(system_bh_wq, ) will be called in hv_fcopy_pre_resume(). */
 	return 0;
 }
 
@@ -412,7 +412,7 @@ int hv_fcopy_pre_resume(void)
 {
 	struct vmbus_channel *channel = fcopy_transaction.recv_channel;
 
-	tasklet_enable(&channel->callback_event);
+	enable_and_queue_work(system_bh_wq, &channel->callback_event);
 
 	return 0;
 }
diff --git a/drivers/hv/hv_kvp.c b/drivers/hv/hv_kvp.c
index d35b60c06114..85b8fb4a3d2e 100644
--- a/drivers/hv/hv_kvp.c
+++ b/drivers/hv/hv_kvp.c
@@ -113,7 +113,7 @@ static void kvp_poll_wrapper(void *channel)
 {
 	/* Transaction is finished, reset the state here to avoid races. */
 	kvp_transaction.state = HVUTIL_READY;
-	tasklet_schedule(&((struct vmbus_channel *)channel)->callback_event);
+	queue_work(system_bh_wq, &((struct vmbus_channel *)channel)->callback_event);
 }
 
 static void kvp_register_done(void)
@@ -160,7 +160,7 @@ static void kvp_timeout_func(struct work_struct *dummy)
 
 static void kvp_host_handshake_func(struct work_struct *dummy)
 {
-	tasklet_schedule(&kvp_transaction.recv_channel->callback_event);
+	queue_work(system_bh_wq, &kvp_transaction.recv_channel->callback_event);
 }
 
 static int kvp_handle_handshake(struct hv_kvp_msg *msg)
@@ -786,7 +786,7 @@ int hv_kvp_pre_suspend(void)
 {
 	struct vmbus_channel *channel = kvp_transaction.recv_channel;
 
-	tasklet_disable(&channel->callback_event);
+	disable_work_sync(&channel->callback_event);
 
 	/*
 	 * If there is a pending transtion, it's unnecessary to tell the host
@@ -809,7 +809,7 @@ int hv_kvp_pre_resume(void)
 {
 	struct vmbus_channel *channel = kvp_transaction.recv_channel;
 
-	tasklet_enable(&channel->callback_event);
+	enable_and_queue_work(system_bh_wq, &channel->callback_event);
 
 	return 0;
 }
diff --git a/drivers/hv/hv_snapshot.c b/drivers/hv/hv_snapshot.c
index 0d2184be1691..46c2263d2591 100644
--- a/drivers/hv/hv_snapshot.c
+++ b/drivers/hv/hv_snapshot.c
@@ -83,7 +83,7 @@ static void vss_poll_wrapper(void *channel)
 {
 	/* Transaction is finished, reset the state here to avoid races. */
 	vss_transaction.state = HVUTIL_READY;
-	tasklet_schedule(&((struct vmbus_channel *)channel)->callback_event);
+	queue_work(system_bh_wq, &((struct vmbus_channel *)channel)->callback_event);
 }
 
 /*
@@ -421,7 +421,7 @@ int hv_vss_pre_suspend(void)
 	if (!vss_msg)
 		return -ENOMEM;
 
-	tasklet_disable(&channel->callback_event);
+	disable_work_sync(&channel->callback_event);
 
 	vss_msg->vss_hdr.operation = VSS_OP_THAW;
 
@@ -435,7 +435,7 @@ int hv_vss_pre_suspend(void)
 
 	vss_transaction.state = HVUTIL_READY;
 
-	/* tasklet_enable() will be called in hv_vss_pre_resume(). */
+	/* enable_and_queue_work() will be called in hv_vss_pre_resume(). */
 	return 0;
 }
 
@@ -443,7 +443,7 @@ int hv_vss_pre_resume(void)
 {
 	struct vmbus_channel *channel = vss_transaction.recv_channel;
 
-	tasklet_enable(&channel->callback_event);
+	enable_and_queue_work(system_bh_wq, &channel->callback_event);
 
 	return 0;
 }
diff --git a/drivers/hv/hyperv_vmbus.h b/drivers/hv/hyperv_vmbus.h
index f6b1e710f805..95ca570ac7af 100644
--- a/drivers/hv/hyperv_vmbus.h
+++ b/drivers/hv/hyperv_vmbus.h
@@ -19,6 +19,7 @@
 #include <linux/atomic.h>
 #include <linux/hyperv.h>
 #include <linux/interrupt.h>
+#include <linux/workqueue.h>
 
 #include "hv_trace.h"
 
@@ -136,10 +137,10 @@ struct hv_per_cpu_context {
 
 	/*
 	 * Starting with win8, we can take channel interrupts on any CPU;
-	 * we will manage the tasklet that handles events messages on a per CPU
+	 * we will manage the work that handles events messages on a per CPU
 	 * basis.
 	 */
-	struct tasklet_struct msg_dpc;
+	struct work_struct msg_dpc;
 };
 
 struct hv_context {
@@ -366,8 +367,8 @@ void vmbus_disconnect(void);
 
 int vmbus_post_msg(void *buffer, size_t buflen, bool can_sleep);
 
-void vmbus_on_event(unsigned long data);
-void vmbus_on_msg_dpc(unsigned long data);
+void vmbus_on_event(struct work_struct *t);
+void vmbus_on_msg_dpc(struct work_struct *t);
 
 int hv_kvp_init(struct hv_util_service *srv);
 void hv_kvp_deinit(void);
diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 4cb17603a828..28490068cacc 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -1025,9 +1025,9 @@ static void vmbus_onmessage_work(struct work_struct *work)
 	kfree(ctx);
 }
 
-void vmbus_on_msg_dpc(unsigned long data)
+void vmbus_on_msg_dpc(struct work_struct *t)
 {
-	struct hv_per_cpu_context *hv_cpu = (void *)data;
+	struct hv_per_cpu_context *hv_cpu = from_work(hv_cpu, t, msg_dpc);
 	void *page_addr = hv_cpu->synic_message_page;
 	struct hv_message msg_copy, *msg = (struct hv_message *)page_addr +
 				  VMBUS_MESSAGE_SINT;
@@ -1131,7 +1131,7 @@ void vmbus_on_msg_dpc(unsigned long data)
 			 * before sending the rescind message of the same
 			 * channel.  These messages are sent to the guest's
 			 * connect CPU; the guest then starts processing them
-			 * in the tasklet handler on this CPU:
+			 * in the work handler on this CPU:
 			 *
 			 * VMBUS_CONNECT_CPU
 			 *
@@ -1276,7 +1276,7 @@ static void vmbus_chan_sched(struct hv_per_cpu_context *hv_cpu)
 			hv_begin_read(&channel->inbound);
 			fallthrough;
 		case HV_CALL_DIRECT:
-			tasklet_schedule(&channel->callback_event);
+			queue_work(system_bh_wq, &channel->callback_event);
 		}
 
 sched_unlock:
@@ -1304,7 +1304,7 @@ static void vmbus_isr(void)
 			hv_stimer0_isr();
 			vmbus_signal_eom(msg, HVMSG_TIMER_EXPIRED);
 		} else
-			tasklet_schedule(&hv_cpu->msg_dpc);
+			queue_work(system_bh_wq, &hv_cpu->msg_dpc);
 	}
 
 	add_interrupt_randomness(vmbus_interrupt);
@@ -2371,10 +2371,12 @@ static int vmbus_bus_suspend(struct device *dev)
 			hv_context.cpu_context, VMBUS_CONNECT_CPU);
 	struct vmbus_channel *channel, *sc;
 
-	tasklet_disable(&hv_cpu->msg_dpc);
+	disable_work_sync(&hv_cpu->msg_dpc);
 	vmbus_connection.ignore_any_offer_msg = true;
-	/* The tasklet_enable() takes care of providing a memory barrier */
-	tasklet_enable(&hv_cpu->msg_dpc);
+	/* The enable_and_queue_work() takes care of
+	 * providing a memory barrier
+	 */
+	enable_and_queue_work(system_bh_wq, &hv_cpu->msg_dpc);
 
 	/* Drain all the workqueues as we are in suspend */
 	drain_workqueue(vmbus_connection.rescind_work_queue);
@@ -2692,7 +2694,7 @@ static void __exit vmbus_exit(void)
 		struct hv_per_cpu_context *hv_cpu
 			= per_cpu_ptr(hv_context.cpu_context, cpu);
 
-		tasklet_kill(&hv_cpu->msg_dpc);
+		cancel_work_sync(&hv_cpu->msg_dpc);
 	}
 	hv_debug_rm_all_dir();
 
diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
index 6ef0557b4bff..db3d85ea5ce6 100644
--- a/include/linux/hyperv.h
+++ b/include/linux/hyperv.h
@@ -882,7 +882,7 @@ struct vmbus_channel {
 	bool out_full_flag;
 
 	/* Channel callback's invoked in softirq context */
-	struct tasklet_struct callback_event;
+	struct work_struct callback_event;
 	void (*onchannel_callback)(void *context);
 	void *channel_callback_context;
 
-- 
2.17.1


