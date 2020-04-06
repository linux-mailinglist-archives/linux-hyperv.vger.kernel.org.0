Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC0B219EEE4
	for <lists+linux-hyperv@lfdr.de>; Mon,  6 Apr 2020 02:17:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727962AbgDFAQw (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 5 Apr 2020 20:16:52 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55535 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727254AbgDFAQu (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 5 Apr 2020 20:16:50 -0400
Received: by mail-wm1-f67.google.com with SMTP id r16so12944096wmg.5;
        Sun, 05 Apr 2020 17:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lRxHRtuWMl6Zmr/wNw5S1hljRUC0kCJ5bXXeFE7jDDo=;
        b=fVaBRei6HgEXFHZ/cALs0pQDFglmQPsgoMfy9UutKwDNTT/ffM2BMid/iL4Lef/kK8
         ADiWLK8eAQL9u9tUgozg9uO3ZXbYBmHzec5iZTLFlZUFnOaxF+BRkeEUz8ud/749E6yx
         NiGLGg/6kmspkYhTYXQXcaYj1pbTxrZkyTTQS2MbAlOWz2v1FxELH3a2iZPmIH4GA4e/
         +BBlJaItRgpIWArqJVp92S50XhZxZfPv0jIpjmUn/l6XoU/h73bR9WUNbKjmQ5w7vaxM
         wthYDFDD8auhCQLfUUEwTEZsUCWHd1zX9e7UPvohBs4GUyAfDojw6FBoDBGCd1Ya2iaw
         hN9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lRxHRtuWMl6Zmr/wNw5S1hljRUC0kCJ5bXXeFE7jDDo=;
        b=h0c2NTnHsopk+qYjQbgapJH0uZiLvhwLSoP+I+A5r0weGQ0h/bkZDzRArwxHsLGIVK
         XLn0085sa8PkZASGaoiE4zVU1TNz0MC846XGNBKTAV3Bn0uJfQmcrX+YXV1ZcilLYYj4
         Iqw1tx98XS3E0YVVyMGGUYMYjN4QON0dAXVXLl4f2AVpX79s+kFVDHau45Yb226YRyQZ
         1xOvNs2J3Tv8DsRGM5JpjMJjZYmXJ6D5Lyhq66qlyqVUw4oLeMxEMVLMq5Vms2MJkBmF
         iNND4Z1IuXkG47sCcnZJJGb54I9rJQxqv+GNA67ITYuyfMp2Apq0jrSc40mG7v8UGXEo
         3fMA==
X-Gm-Message-State: AGi0PuYsc/waJA+u68koO2KCRfRkHHTWuRB+jv99vylmrWqEQaHUaMLe
        ETkQOFey30bHwHzBxuiGHJlRL7FyV/DeGg==
X-Google-Smtp-Source: APiQypLDgViuGLgwFgAUCuQfQueXYBNSNW3rD/vF/s/tWpwtllEZaCVahar+msS2JC2itmgJxRSo5w==
X-Received: by 2002:a1c:408b:: with SMTP id n133mr18787983wma.182.1586132204903;
        Sun, 05 Apr 2020 17:16:44 -0700 (PDT)
Received: from andrea.corp.microsoft.com ([86.61.236.197])
        by smtp.gmail.com with ESMTPSA id j9sm817432wrn.59.2020.04.05.17.16.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Apr 2020 17:16:44 -0700 (PDT)
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
Subject: [PATCH 03/11] Drivers: hv: vmbus: Replace the per-CPU channel lists with a global array of channels
Date:   Mon,  6 Apr 2020 02:15:06 +0200
Message-Id: <20200406001514.19876-4-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200406001514.19876-1-parri.andrea@gmail.com>
References: <20200406001514.19876-1-parri.andrea@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

When Hyper-V sends an interrupt to the guest, the guest has to figure
out which channel the interrupt is associated with.  Hyper-V sets a bit
in a memory page that is shared with the guest, indicating a particular
"relid" that the interrupt is associated with.  The current Linux code
then uses a set of per-CPU linked lists to map a given "relid" to a
pointer to a channel structure.

This design introduces a synchronization problem if the CPU that Hyper-V
will interrupt for a certain channel is changed.  If the interrupt comes
on the "old CPU" and the channel was already moved to the per-CPU list
of the "new CPU", then the relid -> channel mapping will fail and the
interrupt is dropped.  Similarly, if the interrupt comes on the new CPU
but the channel was not moved to the per-CPU list of the new CPU, then
the mapping will fail and the interrupt is dropped.

Relids are integers ranging from 0 to 2047.  The mapping from relids to
channel structures can be done by setting up an array with 2048 entries,
each entry being a pointer to a channel structure (hence total size ~16K
bytes, which is not a problem).  The array is global, so there are no
per-CPU linked lists to update.  The array can be searched and updated
by loading from/storing to the array at the specified index.  With no
per-CPU data structures, the above mentioned synchronization problem is
avoided and the relid2channel() function gets simpler.

Suggested-by: Michael Kelley <mikelley@microsoft.com>
Signed-off-by: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
---
NOTE.  The inline comment in vmbus_channel_map_relid() follows the argument
discussed in the RFC [1].  An attempt has been made to make this argument
more 'explicit' (and, hopefully, more 'robust' against future changes) by
adding a full memory barrier in vmbus_channel_map_relid(): the barrier takes
the role of the 'implicit' full memory barriers from queue_work() and from
check_ready_for_resume_event() referred to in the RFC.

[1] https://lkml.kernel.org/r/20200403133826.GA25401@andrea

 drivers/hv/channel_mgmt.c | 179 ++++++++++++++++++++++++--------------
 drivers/hv/connection.c   |  38 +++-----
 drivers/hv/hv.c           |   2 -
 drivers/hv/hyperv_vmbus.h |  14 +--
 drivers/hv/vmbus_drv.c    |  48 ++++++----
 include/linux/hyperv.h    |   5 --
 6 files changed, 160 insertions(+), 126 deletions(-)

diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
index aed8db59a5ff8..8c179f6866ef7 100644
--- a/drivers/hv/channel_mgmt.c
+++ b/drivers/hv/channel_mgmt.c
@@ -319,7 +319,6 @@ static struct vmbus_channel *alloc_channel(void)
 	init_completion(&channel->rescind_event);
 
 	INIT_LIST_HEAD(&channel->sc_list);
-	INIT_LIST_HEAD(&channel->percpu_list);
 
 	tasklet_init(&channel->callback_event,
 		     vmbus_on_event, (unsigned long)channel);
@@ -340,23 +339,49 @@ static void free_channel(struct vmbus_channel *channel)
 	kobject_put(&channel->kobj);
 }
 
-static void percpu_channel_enq(void *arg)
+void vmbus_channel_map_relid(struct vmbus_channel *channel)
 {
-	struct vmbus_channel *channel = arg;
-	struct hv_per_cpu_context *hv_cpu
-		= this_cpu_ptr(hv_context.cpu_context);
-
-	list_add_tail_rcu(&channel->percpu_list, &hv_cpu->chan_list);
+	if (WARN_ON(channel->offermsg.child_relid >= MAX_CHANNEL_RELIDS))
+		return;
+	/*
+	 * The mapping of the channel's relid is visible from the CPUs that
+	 * execute vmbus_chan_sched() by the time that vmbus_chan_sched() will
+	 * execute:
+	 *
+	 *  (a) In the "normal (i.e., not resuming from hibernation)" path,
+	 *      the full barrier in smp_store_mb() guarantees that the store
+	 *      is propagated to all CPUs before the add_channel_work work
+	 *      is queued.  In turn, add_channel_work is queued before the
+	 *      channel's ring buffer is allocated/initialized and the
+	 *      OPENCHANNEL message for the channel is sent in vmbus_open().
+	 *      Hyper-V won't start sending the interrupts for the channel
+	 *      before the OPENCHANNEL message is acked.  The memory barrier
+	 *      in vmbus_chan_sched() -> sync_test_and_clear_bit() ensures
+	 *      that vmbus_chan_sched() must find the channel's relid in
+	 *      recv_int_page before retrieving the channel pointer from the
+	 *      array of channels.
+	 *
+	 *  (b) In the "resuming from hibernation" path, the smp_store_mb()
+	 *      guarantees that the store is propagated to all CPUs before
+	 *      the VMBus connection is marked as ready for the resume event
+	 *      (cf. check_ready_for_resume_event()).  The interrupt handler
+	 *      of the VMBus driver and vmbus_chan_sched() can not run before
+	 *      vmbus_bus_resume() has completed execution (cf. resume_noirq).
+	 */
+	smp_store_mb(
+		vmbus_connection.channels[channel->offermsg.child_relid],
+		channel);
 }
 
-static void percpu_channel_deq(void *arg)
+void vmbus_channel_unmap_relid(struct vmbus_channel *channel)
 {
-	struct vmbus_channel *channel = arg;
-
-	list_del_rcu(&channel->percpu_list);
+	if (WARN_ON(channel->offermsg.child_relid >= MAX_CHANNEL_RELIDS))
+		return;
+	WRITE_ONCE(
+		vmbus_connection.channels[channel->offermsg.child_relid],
+		NULL);
 }
 
-
 static void vmbus_release_relid(u32 relid)
 {
 	struct vmbus_channel_relid_released msg;
@@ -376,17 +401,25 @@ void hv_process_channel_removal(struct vmbus_channel *channel)
 	struct vmbus_channel *primary_channel;
 	unsigned long flags;
 
-	BUG_ON(!mutex_is_locked(&vmbus_connection.channel_mutex));
+	lockdep_assert_held(&vmbus_connection.channel_mutex);
 	BUG_ON(!channel->rescind);
 
-	if (channel->target_cpu != get_cpu()) {
-		put_cpu();
-		smp_call_function_single(channel->target_cpu,
-					 percpu_channel_deq, channel, true);
-	} else {
-		percpu_channel_deq(channel);
-		put_cpu();
-	}
+	/*
+	 * hv_process_channel_removal() could find INVALID_RELID only for
+	 * hv_sock channels.  See the inline comments in vmbus_onoffer().
+	 */
+	WARN_ON(channel->offermsg.child_relid == INVALID_RELID &&
+		!is_hvsock_channel(channel));
+
+	/*
+	 * Upon suspend, an in-use hv_sock channel is removed from the array of
+	 * channels and the relid is invalidated.  After hibernation, when the
+	 * user-space appplication destroys the channel, it's unnecessary and
+	 * unsafe to remove the channel from the array of channels.  See also
+	 * the inline comments before the call of vmbus_release_relid() below.
+	 */
+	if (channel->offermsg.child_relid != INVALID_RELID)
+		vmbus_channel_unmap_relid(channel);
 
 	if (channel->primary_channel == NULL) {
 		list_del(&channel->listentry);
@@ -447,16 +480,6 @@ static void vmbus_add_channel_work(struct work_struct *work)
 
 	init_vp_index(newchannel, dev_type);
 
-	if (newchannel->target_cpu != get_cpu()) {
-		put_cpu();
-		smp_call_function_single(newchannel->target_cpu,
-					 percpu_channel_enq,
-					 newchannel, true);
-	} else {
-		percpu_channel_enq(newchannel);
-		put_cpu();
-	}
-
 	/*
 	 * This state is used to indicate a successful open
 	 * so that when we do close the channel normally, we
@@ -523,17 +546,10 @@ static void vmbus_add_channel_work(struct work_struct *work)
 		spin_unlock_irqrestore(&primary_channel->lock, flags);
 	}
 
-	mutex_unlock(&vmbus_connection.channel_mutex);
+	/* vmbus_process_offer() has mapped the channel. */
+	vmbus_channel_unmap_relid(newchannel);
 
-	if (newchannel->target_cpu != get_cpu()) {
-		put_cpu();
-		smp_call_function_single(newchannel->target_cpu,
-					 percpu_channel_deq,
-					 newchannel, true);
-	} else {
-		percpu_channel_deq(newchannel);
-		put_cpu();
-	}
+	mutex_unlock(&vmbus_connection.channel_mutex);
 
 	vmbus_release_relid(newchannel->offermsg.child_relid);
 
@@ -599,6 +615,8 @@ static void vmbus_process_offer(struct vmbus_channel *newchannel)
 		spin_unlock_irqrestore(&channel->lock, flags);
 	}
 
+	vmbus_channel_map_relid(newchannel);
+
 	mutex_unlock(&vmbus_connection.channel_mutex);
 
 	/*
@@ -940,8 +958,6 @@ static void vmbus_onoffer(struct vmbus_channel_message_header *hdr)
 	oldchannel = find_primary_channel_by_offer(offer);
 
 	if (oldchannel != NULL) {
-		atomic_dec(&vmbus_connection.offer_in_progress);
-
 		/*
 		 * We're resuming from hibernation: all the sub-channel and
 		 * hv_sock channels we had before the hibernation should have
@@ -949,36 +965,65 @@ static void vmbus_onoffer(struct vmbus_channel_message_header *hdr)
 		 * primary channel that we had before the hibernation.
 		 */
 
+		/*
+		 * { Initially: channel relid = INVALID_RELID,
+		 *		channels[valid_relid] = NULL }
+		 *
+		 * CPU1					CPU2
+		 *
+		 * [vmbus_onoffer()]			[vmbus_device_release()]
+		 *
+		 * LOCK channel_mutex			LOCK channel_mutex
+		 * STORE channel relid = valid_relid	LOAD r1 = channel relid
+		 * MAP_RELID channel			if (r1 != INVALID_RELID)
+		 * UNLOCK channel_mutex			  UNMAP_RELID channel
+		 *					UNLOCK channel_mutex
+		 *
+		 * Forbids: r1 == valid_relid &&
+		 * 		channels[valid_relid] == channel
+		 *
+		 * Note.  r1 can be INVALID_RELID only for an hv_sock channel.
+		 * None of the hv_sock channels which were present before the
+		 * suspend are re-offered upon the resume.  See the WARN_ON()
+		 * in hv_process_channel_removal().
+		 */
+		mutex_lock(&vmbus_connection.channel_mutex);
+
+		atomic_dec(&vmbus_connection.offer_in_progress);
+
 		WARN_ON(oldchannel->offermsg.child_relid != INVALID_RELID);
 		/* Fix up the relid. */
 		oldchannel->offermsg.child_relid = offer->child_relid;
 
 		offer_sz = sizeof(*offer);
-		if (memcmp(offer, &oldchannel->offermsg, offer_sz) == 0) {
-			check_ready_for_resume_event();
-			return;
+		if (memcmp(offer, &oldchannel->offermsg, offer_sz) != 0) {
+			/*
+			 * This is not an error, since the host can also change
+			 * the other field(s) of the offer, e.g. on WS RS5
+			 * (Build 17763), the offer->connection_id of the
+			 * Mellanox VF vmbus device can change when the host
+			 * reoffers the device upon resume.
+			 */
+			pr_debug("vmbus offer changed: relid=%d\n",
+				 offer->child_relid);
+
+			print_hex_dump_debug("Old vmbus offer: ",
+					     DUMP_PREFIX_OFFSET, 16, 4,
+					     &oldchannel->offermsg, offer_sz,
+					     false);
+			print_hex_dump_debug("New vmbus offer: ",
+					     DUMP_PREFIX_OFFSET, 16, 4,
+					     offer, offer_sz, false);
+
+			/* Fix up the old channel. */
+			vmbus_setup_channel_state(oldchannel, offer);
 		}
 
-		/*
-		 * This is not an error, since the host can also change the
-		 * other field(s) of the offer, e.g. on WS RS5 (Build 17763),
-		 * the offer->connection_id of the Mellanox VF vmbus device
-		 * can change when the host reoffers the device upon resume.
-		 */
-		pr_debug("vmbus offer changed: relid=%d\n",
-			 offer->child_relid);
-
-		print_hex_dump_debug("Old vmbus offer: ", DUMP_PREFIX_OFFSET,
-				     16, 4, &oldchannel->offermsg, offer_sz,
-				     false);
-		print_hex_dump_debug("New vmbus offer: ", DUMP_PREFIX_OFFSET,
-				     16, 4, offer, offer_sz, false);
-
-		/* Fix up the old channel. */
-		vmbus_setup_channel_state(oldchannel, offer);
-
+		/* Add the channel back to the array of channels. */
+		vmbus_channel_map_relid(oldchannel);
 		check_ready_for_resume_event();
 
+		mutex_unlock(&vmbus_connection.channel_mutex);
 		return;
 	}
 
@@ -1036,14 +1081,14 @@ static void vmbus_onoffer_rescind(struct vmbus_channel_message_header *hdr)
 	 *
 	 * CPU1				CPU2
 	 *
-	 * [vmbus_process_offer()]	[vmbus_onoffer_rescind()]
+	 * [vmbus_onoffer()]		[vmbus_onoffer_rescind()]
 	 *
 	 * LOCK channel_mutex		WAIT_ON offer_in_progress == 0
 	 * DECREMENT offer_in_progress	LOCK channel_mutex
-	 * INSERT chn_list		SEARCH chn_list
+	 * STORE channels[]		LOAD channels[]
 	 * UNLOCK channel_mutex		UNLOCK channel_mutex
 	 *
-	 * Forbids: CPU2's SEARCH from *not* seeing CPU1's INSERT
+	 * Forbids: CPU2's LOAD from *not* seeing CPU1's STORE
 	 */
 
 	while (atomic_read(&vmbus_connection.offer_in_progress) != 0) {
diff --git a/drivers/hv/connection.c b/drivers/hv/connection.c
index f4bd306d2cef9..11170d9a2e1a5 100644
--- a/drivers/hv/connection.c
+++ b/drivers/hv/connection.c
@@ -248,6 +248,14 @@ int vmbus_connect(void)
 	pr_info("Vmbus version:%d.%d\n",
 		version >> 16, version & 0xFFFF);
 
+	vmbus_connection.channels = kcalloc(MAX_CHANNEL_RELIDS,
+					    sizeof(struct vmbus_channel *),
+					    GFP_KERNEL);
+	if (vmbus_connection.channels == NULL) {
+		ret = -ENOMEM;
+		goto cleanup;
+	}
+
 	kfree(msginfo);
 	return 0;
 
@@ -295,33 +303,9 @@ void vmbus_disconnect(void)
  */
 struct vmbus_channel *relid2channel(u32 relid)
 {
-	struct vmbus_channel *channel;
-	struct vmbus_channel *found_channel  = NULL;
-	struct list_head *cur, *tmp;
-	struct vmbus_channel *cur_sc;
-
-	BUG_ON(!mutex_is_locked(&vmbus_connection.channel_mutex));
-
-	list_for_each_entry(channel, &vmbus_connection.chn_list, listentry) {
-		if (channel->offermsg.child_relid == relid) {
-			found_channel = channel;
-			break;
-		} else if (!list_empty(&channel->sc_list)) {
-			/*
-			 * Deal with sub-channels.
-			 */
-			list_for_each_safe(cur, tmp, &channel->sc_list) {
-				cur_sc = list_entry(cur, struct vmbus_channel,
-							sc_list);
-				if (cur_sc->offermsg.child_relid == relid) {
-					found_channel = cur_sc;
-					break;
-				}
-			}
-		}
-	}
-
-	return found_channel;
+	if (WARN_ON(relid >= MAX_CHANNEL_RELIDS))
+		return NULL;
+	return READ_ONCE(vmbus_connection.channels[relid]);
 }
 
 /*
diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
index e2b3310454640..17bf1f229152b 100644
--- a/drivers/hv/hv.c
+++ b/drivers/hv/hv.c
@@ -117,8 +117,6 @@ int hv_synic_alloc(void)
 			pr_err("Unable to allocate post msg page\n");
 			goto err;
 		}
-
-		INIT_LIST_HEAD(&hv_cpu->chan_list);
 	}
 
 	return 0;
diff --git a/drivers/hv/hyperv_vmbus.h b/drivers/hv/hyperv_vmbus.h
index ce19a4c583884..41b7267da529a 100644
--- a/drivers/hv/hyperv_vmbus.h
+++ b/drivers/hv/hyperv_vmbus.h
@@ -132,12 +132,6 @@ struct hv_per_cpu_context {
 	 * basis.
 	 */
 	struct tasklet_struct msg_dpc;
-
-	/*
-	 * To optimize the mapping of relid to channel, maintain
-	 * per-cpu list of the channels based on their CPU affinity.
-	 */
-	struct list_head chan_list;
 };
 
 struct hv_context {
@@ -202,6 +196,8 @@ int hv_ringbuffer_read(struct vmbus_channel *channel,
 /* TODO: Need to make this configurable */
 #define MAX_NUM_CHANNELS_SUPPORTED	256
 
+#define MAX_CHANNEL_RELIDS					\
+	max(MAX_NUM_CHANNELS_SUPPORTED, HV_EVENT_FLAGS_COUNT)
 
 enum vmbus_connect_state {
 	DISCONNECTED,
@@ -251,6 +247,9 @@ struct vmbus_connection {
 	struct list_head chn_list;
 	struct mutex channel_mutex;
 
+	/* Array of channels */
+	struct vmbus_channel **channels;
+
 	/*
 	 * An offer message is handled first on the work_queue, and then
 	 * is further handled on handle_primary_chan_wq or
@@ -337,6 +336,9 @@ int vmbus_add_channel_kobj(struct hv_device *device_obj,
 
 void vmbus_remove_channel_attr_group(struct vmbus_channel *channel);
 
+void vmbus_channel_map_relid(struct vmbus_channel *channel);
+void vmbus_channel_unmap_relid(struct vmbus_channel *channel);
+
 struct vmbus_channel *relid2channel(u32 relid);
 
 void vmbus_free_channels(void);
diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 41ec0c95df33f..0e5a98ebe23b1 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -1225,33 +1225,39 @@ static void vmbus_chan_sched(struct hv_per_cpu_context *hv_cpu)
 		if (relid == 0)
 			continue;
 
+		/*
+		 * Pairs with the kfree_rcu() in vmbus_chan_release().
+		 * Guarantees that the channel data structure doesn't
+		 * get freed while the channel pointer below is being
+		 * dereferenced.
+		 */
 		rcu_read_lock();
 
 		/* Find channel based on relid */
-		list_for_each_entry_rcu(channel, &hv_cpu->chan_list, percpu_list) {
-			if (channel->offermsg.child_relid != relid)
-				continue;
+		channel = relid2channel(relid);
+		if (channel == NULL)
+			goto sched_unlock_rcu;
 
-			if (channel->rescind)
-				continue;
+		if (channel->rescind)
+			goto sched_unlock_rcu;
 
-			trace_vmbus_chan_sched(channel);
+		trace_vmbus_chan_sched(channel);
 
-			++channel->interrupts;
+		++channel->interrupts;
 
-			switch (channel->callback_mode) {
-			case HV_CALL_ISR:
-				vmbus_channel_isr(channel);
-				break;
+		switch (channel->callback_mode) {
+		case HV_CALL_ISR:
+			vmbus_channel_isr(channel);
+			break;
 
-			case HV_CALL_BATCHED:
-				hv_begin_read(&channel->inbound);
-				/* fallthrough */
-			case HV_CALL_DIRECT:
-				tasklet_schedule(&channel->callback_event);
-			}
+		case HV_CALL_BATCHED:
+			hv_begin_read(&channel->inbound);
+			fallthrough;
+		case HV_CALL_DIRECT:
+			tasklet_schedule(&channel->callback_event);
 		}
 
+sched_unlock_rcu:
 		rcu_read_unlock();
 	}
 }
@@ -2237,9 +2243,12 @@ static int vmbus_bus_suspend(struct device *dev)
 
 	list_for_each_entry(channel, &vmbus_connection.chn_list, listentry) {
 		/*
-		 * Invalidate the field. Upon resume, vmbus_onoffer() will fix
-		 * up the field, and the other fields (if necessary).
+		 * Remove the channel from the array of channels and invalidate
+		 * the channel's relid.  Upon resume, vmbus_onoffer() will fix
+		 * up the relid (and other fields, if necessary) and add the
+		 * channel back to the array.
 		 */
+		vmbus_channel_unmap_relid(channel);
 		channel->offermsg.child_relid = INVALID_RELID;
 
 		if (is_hvsock_channel(channel)) {
@@ -2475,6 +2484,7 @@ static void __exit vmbus_exit(void)
 	hv_debug_rm_all_dir();
 
 	vmbus_free_channels();
+	kfree(vmbus_connection.channels);
 
 	if (ms_hyperv.misc_features & HV_FEATURE_GUEST_CRASH_MSR_AVAILABLE) {
 		kmsg_dump_unregister(&hv_kmsg_dumper);
diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
index 692c89ccf5dfd..6c794fd5c903e 100644
--- a/include/linux/hyperv.h
+++ b/include/linux/hyperv.h
@@ -854,11 +854,6 @@ struct vmbus_channel {
 	 * Support per-channel state for use by vmbus drivers.
 	 */
 	void *per_channel_state;
-	/*
-	 * To support per-cpu lookup mapping of relid to channel,
-	 * link up channels based on their CPU affinity.
-	 */
-	struct list_head percpu_list;
 
 	/*
 	 * Defer freeing channel until after all cpu's have
-- 
2.24.0

