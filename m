Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F165E1E32AF
	for <lists+linux-hyperv@lfdr.de>; Wed, 27 May 2020 00:33:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392189AbgEZWdF (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 26 May 2020 18:33:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390326AbgEZWdD (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 26 May 2020 18:33:03 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E109C061A0F;
        Tue, 26 May 2020 15:33:02 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id l21so25599095eji.4;
        Tue, 26 May 2020 15:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4fLNoLe2ED2PwkbP9EETYiR91dszKPUPF2CxpIFrnaQ=;
        b=imrWtAKbTvq1T9t7ufBjd+I31uVqQU/KiWYmJI52FlMz0eWtM0NTXjbsuPV1sJQCZ1
         ZLoQZNhAQg8w1FKM2B0BE+fpVcxBbtVH1nsEZVvaLmRsqvFwHYUv3xjUllhWsSzgurCo
         lr9U6s58ooD49uwQG0uocK3yLuiZZjwucPOSglFiCNn0mXlzyuWzpOYV2Y0epcfB32yO
         iBg6xdPZKEU74sikMnN3aZyhGBFM+KQVj/1Jh2DltTQOmOUc9cFi3EdlNCTEHgxfRPXb
         3Y5VPmpIJ3pbT9kxTI4XU+Ow42YTYBvVsggQmBX2G+0x2mZe7kFR+qsOmqB628aIQWIP
         294Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4fLNoLe2ED2PwkbP9EETYiR91dszKPUPF2CxpIFrnaQ=;
        b=ii1EMqEGITavNfDawodnVq9O5DaMP/dFUqxJTIaQAet7Yv5DwgIBQwxPuwMEomf6Mw
         vtxoMcMguVSY8f7EGRHzC3jQBwiUaaUxSjlcGnOsgl0AG6s4dW5IgIGHiLLkt7XeLQRL
         kaExdyE3ddwS/udwcjR5YoArVf8C/nzN+IC1JbCMa3p3iCWUyw0/HGARMxTxRLpziMda
         jiizghIljVKplgOJw3JQrxgsX4xZ7QRrSjnuJmCT+C1WIazasyyxut/FCH38bobH8lsW
         AYLO8JXgwqSUUvifabuKGK/6LFPcWTD3AR0VRzs2ySA93RyVTNiW5qHaDXY7kVxubSQn
         oRVw==
X-Gm-Message-State: AOAM531rulD0I5X2S4tKqEbMPadLZWwHTr36fydRgsQxoAeYI7FqDwoD
        aqWGfyvxQAlPFr6WUjLtHLFMABZ0/hD0nA==
X-Google-Smtp-Source: ABdhPJwQKWm5PFNrlkJaCiLqyHIYDAICPFshStGdlBKHF4VCEvIcYmnsVivSSgbQeVvUCS/ELM49Pw==
X-Received: by 2002:a17:906:f2d9:: with SMTP id gz25mr3245325ejb.467.1590532380315;
        Tue, 26 May 2020 15:33:00 -0700 (PDT)
Received: from localhost.localdomain (ip-62-245-103-65.net.upcbroadband.cz. [62.245.103.65])
        by smtp.gmail.com with ESMTPSA id cd17sm68288ejb.115.2020.05.26.15.32.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2020 15:32:59 -0700 (PDT)
From:   "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>
To:     linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "K . Y . Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Nuno Das Neves <nuno.das@microsoft.com>,
        "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>
Subject: [RFC PATCH 1/2] Drivers: hv: vmbus: Re-balance channel interrupts across CPUs at CPU hotplug
Date:   Wed, 27 May 2020 00:32:17 +0200
Message-Id: <20200526223218.184057-2-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200526223218.184057-1-parri.andrea@gmail.com>
References: <20200526223218.184057-1-parri.andrea@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

CPU hot removals and additions present an opportunity for (re-)balancing
the channel interrupts across the available CPUs.  Current code does not
balance the interrupts at CPU hotplug; furthermore/consequently, the hot
removal path currently fails (to remove the specified CPU) whenever some
interrupt is bound to the CPU to be removed and the VMBus is connected.

Address such issues by implementing vmbus_balance_vp_indexes_at_cpuhp():
invoke this primitive to balance the channel interrupts across available
CPUs at CPU hotplug operations.  In the hot removal path, such primitive
will (try to) move/balance interrupts out of the to-be-removed CPU so as
to meet the user request to hot remove the CPU.

The balancing algorithm distributes the channel interrupts evenly across
the available CPUs and NUMA nodes; to do so, it introduces and maintains
per-device and per-connection channel statistics/counts to keep track of
the (current) assignments of the channels to the CPUs/nodes.  By design,
only "performance"-critical channels/devices are "balanced".

The proposed algorithm relies on the (recently introduced) capability to
reassign a channel interrupt to a CPU (cf., the CHANNELMSG_MODIFYCHANNEL
message type).  As such, the new balancing process is effective starting
with VMBus version 4.1 (no changes in semantics or behavior are intended
for VMBus versions lower than 4.1).

Suggested-by: Nuno Das Neves <nuno.das@microsoft.com>
Signed-off-by: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
---
 drivers/hv/channel.c      |  38 +++++++
 drivers/hv/channel_mgmt.c | 219 ++++++++++++++++++++++++++++++++++++++
 drivers/hv/connection.c   |  23 ++--
 drivers/hv/hv.c           |  62 ++++++-----
 drivers/hv/hyperv_vmbus.h |  72 +++++++++++++
 drivers/hv/vmbus_drv.c    |  45 +++-----
 include/linux/hyperv.h    |  22 +++-
 kernel/cpu.c              |   1 +
 8 files changed, 416 insertions(+), 66 deletions(-)

diff --git a/drivers/hv/channel.c b/drivers/hv/channel.c
index 90070b337c10d..2974aa9dc956c 100644
--- a/drivers/hv/channel.c
+++ b/drivers/hv/channel.c
@@ -18,6 +18,7 @@
 #include <linux/uio.h>
 #include <linux/interrupt.h>
 #include <asm/page.h>
+#include <asm/mshyperv.h>
 
 #include "hyperv_vmbus.h"
 
@@ -317,6 +318,43 @@ int vmbus_send_modifychannel(u32 child_relid, u32 target_vp)
 }
 EXPORT_SYMBOL_GPL(vmbus_send_modifychannel);
 
+bool vmbus_modifychannel(struct vmbus_channel *channel,
+			 u32 origin_cpu, u32 target_cpu)
+{
+	if (vmbus_send_modifychannel(channel->offermsg.child_relid,
+				     hv_cpu_number_to_vp_number(target_cpu)))
+		return false;
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
+	/* See init_vp_index(). */
+	if (hv_is_perf_channel(channel))
+		hv_update_alloced_cpus(origin_cpu, target_cpu);
+
+	/* Currently set only for storvsc channels. */
+	if (channel->change_target_cpu_callback) {
+		(*channel->change_target_cpu_callback)(channel,
+				origin_cpu, target_cpu);
+	}
+
+	return true;
+}
+
 /*
  * create_gpadl_header - Creates a gpadl for the specified buffer
  */
diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
index 417a95e5094dd..c158f86787940 100644
--- a/drivers/hv/channel_mgmt.c
+++ b/drivers/hv/channel_mgmt.c
@@ -497,10 +497,14 @@ static void vmbus_add_channel_work(struct work_struct *work)
 	/*
 	 * Start the process of binding the primary channel to the driver
 	 */
+
+	/* See vmbus_balance_vp_indexes_at_cpuhp(). */
+	mutex_lock(&vmbus_connection.channel_mutex);
 	newchannel->device_obj = vmbus_device_create(
 		&newchannel->offermsg.offer.if_type,
 		&newchannel->offermsg.offer.if_instance,
 		newchannel);
+	mutex_unlock(&vmbus_connection.channel_mutex);
 	if (!newchannel->device_obj)
 		goto err_deq_chan;
 
@@ -515,6 +519,8 @@ static void vmbus_add_channel_work(struct work_struct *work)
 	if (ret != 0) {
 		pr_err("unable to add child device object (relid %d)\n",
 			newchannel->offermsg.child_relid);
+		if (hv_is_perf_channel(newchannel))
+			free_chn_counts(&newchannel->device_obj->chn_cnt);
 		kfree(newchannel->device_obj);
 		goto err_deq_chan;
 	}
@@ -667,6 +673,219 @@ static void vmbus_process_offer(struct vmbus_channel *newchannel)
 	queue_work(wq, &newchannel->add_channel_work);
 }
 
+static void filter_on_cpus(cpumask_var_t cpu_msk,
+			   struct vmbus_channel_counts *chn_cnt)
+{
+	unsigned int min_cnt = MAX_CHANNEL_RELIDS;
+	unsigned int cpu;
+
+	for_each_cpu(cpu, cpu_msk) {
+		unsigned int cnt = chn_cnt->cpu[cpu];
+
+		if (cnt < min_cnt)
+			min_cnt = cnt;
+	}
+
+	for_each_cpu(cpu, cpu_msk) {
+		if (chn_cnt->cpu[cpu] > min_cnt)
+			cpumask_clear_cpu(cpu, cpu_msk);
+	}
+}
+
+static void filter_on_nodes(cpumask_var_t cpu_msk,
+			    struct vmbus_channel_counts *chn_cnt)
+{
+	unsigned int min_cnt = MAX_CHANNEL_RELIDS;
+	unsigned int cpu;
+
+	for_each_cpu(cpu, cpu_msk) {
+		unsigned int node = cpu_to_node(cpu);
+		unsigned int cnt = chn_cnt->node[node];
+
+		if (cnt < min_cnt)
+			min_cnt = cnt;
+
+		cpu = cpumask_last(cpumask_of_node(node));
+	}
+
+	for_each_cpu(cpu, cpu_msk) {
+		unsigned int node = cpu_to_node(cpu);
+		const struct cpumask *msk_node = cpumask_of_node(node);
+
+		if (chn_cnt->node[node] > min_cnt)
+			cpumask_andnot(cpu_msk, cpu_msk, msk_node);
+
+		cpu = cpumask_last(msk_node);
+	}
+}
+
+static inline void __filter_vp_index(struct vmbus_channel_counts *chn_cnt,
+				     cpumask_var_t cpu_msk)
+{
+	filter_on_cpus(cpu_msk, chn_cnt);
+	filter_on_nodes(cpu_msk, chn_cnt);
+}
+
+static void filter_vp_index(struct hv_device *hv_dev, cpumask_var_t cpu_msk)
+{
+	/*
+	 * The selection of the target CPUs is performed in two domains,
+	 * the device domain and the connection domain.  At each domain,
+	 * in turn, invalid CPUs are filtered out at two levels, the CPU
+	 * level and the NUMA-node level: CPUs corresponding to channel
+	 * counts *greater* than the minimum channel count for the given
+	 * level/domain are cleared in the mask of candidate target CPUs.
+	 */
+
+	__filter_vp_index(&hv_dev->chn_cnt, cpu_msk);
+	__filter_vp_index(&vmbus_connection.chn_cnt, cpu_msk);
+}
+
+static void balance_vp_index(struct vmbus_channel *chn,
+			     struct hv_device *hv_dev, cpumask_var_t cpu_msk)
+{
+	u32 cur_cpu = chn->target_cpu, tgt_cpu = cur_cpu;
+
+	if (chn->state != CHANNEL_OPENED_STATE) {
+		/*
+		 * The channel may never have been opened or it may be in
+		 * a closed/closing state; if so, do not touch the target
+		 * CPU of this channel.
+		 */
+		goto update_chn_cnts;
+	}
+
+	/*
+	 * The channel was open, and it will remain open until we release
+	 * channel_mutex, cf. the use of channel_mutex and channel->state
+	 * in vmbus_disconnect_ring() -> vmbus_close_internal().
+	 */
+
+	if (!hv_is_perf_channel(chn)) {
+		/*
+		 * Only used by the CPU hot removal path, remark that
+		 * the connect CPU can not go offline.
+		 */
+		tgt_cpu = VMBUS_CONNECT_CPU;
+		goto modify_vp_index;
+	}
+
+	/*
+	 * Retrieve the new "candidate" target CPUs for this channel
+	 * /device; see the inline comments in filter_vp_index() for
+	 * a high-level description of this algorithm.
+	 */
+	filter_vp_index(hv_dev, cpu_msk);
+
+	/*
+	 * (Try to) preserve the channel's CPU and NUMA node affinities
+	 * respectively:
+	 */
+
+	if (cpumask_test_cpu(cur_cpu, cpu_msk))
+		goto update_chn_cnts;
+
+	/*
+	 * If we reach here, a modification of the channel's target CPU
+	 * is "needed".
+	 */
+
+	tgt_cpu = cpumask_first_and(cpumask_of_node(cpu_to_node(cur_cpu)),
+				    cpu_msk);
+	if (tgt_cpu < nr_cpu_ids)
+		goto modify_vp_index;
+
+	/*
+	 * It was not possible to preserve this channel's CPU and NUMA
+	 * node affinities; pick the "first" candidate target CPU (the
+	 * CPU mask can not be empty).
+	 */
+	tgt_cpu = cpumask_first(cpu_msk);
+
+modify_vp_index:
+	if (!vmbus_modifychannel(chn, cur_cpu, tgt_cpu))
+		tgt_cpu = cur_cpu;
+
+update_chn_cnts:
+	/* Do not account for non-"perf" channels in chn_cnt. */
+	if (!hv_is_perf_channel(chn))
+		return;
+
+	inc_chn_counts(&hv_dev->chn_cnt, tgt_cpu);
+	inc_chn_counts(&vmbus_connection.chn_cnt, tgt_cpu);
+}
+
+void vmbus_balance_vp_indexes_at_cpuhp(unsigned int cpu, bool add)
+{
+	struct vmbus_channel *chn, *sc;
+	cpumask_var_t cpu_msk;
+
+	lockdep_assert_cpus_held();
+	lockdep_assert_held(&vmbus_connection.channel_mutex);
+
+	WARN_ON(!cpumask_test_cpu(cpu, cpu_online_mask));
+
+	/* See the header comment for vmbus_send_modifychannel(). */
+	if (vmbus_proto_version < VERSION_WIN10_V4_1)
+		return;
+
+	if (!alloc_cpumask_var(&cpu_msk, GFP_KERNEL))
+		return;
+
+	reset_chn_counts(&vmbus_connection.chn_cnt);
+
+	list_for_each_entry(chn, &vmbus_connection.chn_list, listentry) {
+		struct hv_device *dev = chn->device_obj;
+
+		/*
+		 * The device may not have been allocated/assigned to
+		 * the primary channel yet; if so, do not balance the
+		 * channels associated to this device.  If dev != NULL,
+		 * the synchronization on channel_mutex ensures that
+		 * the device's chn_cnt has been (properly) allocated
+		 * *and* initialized, cf. vmbus_add_channel_work().
+		 */
+		if (dev == NULL)
+			continue;
+
+		/*
+		 * By design, non-"perf" channels do not take part in
+		 * the balancing process.
+		 *
+		 * The user may have assigned some non-"perf" channel
+		 * to this CPU.  To satisfy the user's request to hot
+		 * remove the CPU, we will re-assign such channels to
+		 * the connect CPU; cf. balance_vp_index().
+		 */
+		if (!hv_is_perf_channel(chn)) {
+			if (add)
+				continue;
+			/*
+			 * Assume that the non-"perf" channel has no
+			 * sub-channels.
+			 */
+			if (chn->target_cpu != cpu)
+				continue;
+		} else {
+			reset_chn_counts(&dev->chn_cnt);
+		}
+
+		cpumask_copy(cpu_msk, cpu_online_mask);
+		if (!add)
+			cpumask_clear_cpu(cpu, cpu_msk);
+		balance_vp_index(chn, dev, cpu_msk);
+
+		list_for_each_entry(sc, &chn->sc_list, sc_list) {
+			cpumask_copy(cpu_msk, cpu_online_mask);
+			if (!add)
+				cpumask_clear_cpu(cpu, cpu_msk);
+			balance_vp_index(sc, dev, cpu_msk);
+		}
+	}
+
+	free_cpumask_var(cpu_msk);
+}
+
 /*
  * We use this state to statically distribute the channel interrupt load.
  */
diff --git a/drivers/hv/connection.c b/drivers/hv/connection.c
index 11170d9a2e1a5..7ec562fac8e58 100644
--- a/drivers/hv/connection.c
+++ b/drivers/hv/connection.c
@@ -183,6 +183,18 @@ int vmbus_connect(void)
 	spin_lock_init(&vmbus_connection.channelmsg_lock);
 
 	INIT_LIST_HEAD(&vmbus_connection.chn_list);
+
+	vmbus_connection.channels = kcalloc(MAX_CHANNEL_RELIDS,
+					    sizeof(struct vmbus_channel *),
+					    GFP_KERNEL);
+	if (vmbus_connection.channels == NULL) {
+		ret = -ENOMEM;
+		goto cleanup;
+	}
+
+	if (alloc_chn_counts(&vmbus_connection.chn_cnt))
+		goto cleanup;
+
 	mutex_init(&vmbus_connection.channel_mutex);
 
 	/*
@@ -248,14 +260,6 @@ int vmbus_connect(void)
 	pr_info("Vmbus version:%d.%d\n",
 		version >> 16, version & 0xFFFF);
 
-	vmbus_connection.channels = kcalloc(MAX_CHANNEL_RELIDS,
-					    sizeof(struct vmbus_channel *),
-					    GFP_KERNEL);
-	if (vmbus_connection.channels == NULL) {
-		ret = -ENOMEM;
-		goto cleanup;
-	}
-
 	kfree(msginfo);
 	return 0;
 
@@ -295,6 +299,9 @@ void vmbus_disconnect(void)
 	hv_free_hyperv_page((unsigned long)vmbus_connection.monitor_pages[1]);
 	vmbus_connection.monitor_pages[0] = NULL;
 	vmbus_connection.monitor_pages[1] = NULL;
+
+	free_chn_counts(&vmbus_connection.chn_cnt);
+	kfree(vmbus_connection.channels);
 }
 
 /*
diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
index 188b42b07f07b..e1cade3c3c967 100644
--- a/drivers/hv/hv.c
+++ b/drivers/hv/hv.c
@@ -198,6 +198,20 @@ void hv_synic_enable_regs(unsigned int cpu)
 
 int hv_synic_init(unsigned int cpu)
 {
+	/*
+	 * The CPU has been hot added: try to re-balance the channels
+	 * across the online CPUs (including "this" CPU), provided that
+	 * the VMBus is connected; in part., avoid the re-balancing at
+	 * the very first CPU initialization.
+	 *
+	 * See also inline comments in hv_synic_cleanup().
+	 */
+	if (vmbus_connection.conn_state == CONNECTED) {
+		mutex_lock(&vmbus_connection.channel_mutex);
+		vmbus_balance_vp_indexes_at_cpuhp(cpu, true);
+		mutex_unlock(&vmbus_connection.channel_mutex);
+	}
+
 	hv_synic_enable_regs(cpu);
 
 	hv_stimer_legacy_init(cpu, VMBUS_MESSAGE_SINT);
@@ -243,10 +257,6 @@ void hv_synic_disable_regs(unsigned int cpu)
 
 int hv_synic_cleanup(unsigned int cpu)
 {
-	struct vmbus_channel *channel, *sc;
-	bool channel_found = false;
-	unsigned long flags;
-
 	/*
 	 * Hyper-V does not provide a way to change the connect CPU once
 	 * it is set; we must prevent the connect CPU from going offline.
@@ -254,35 +264,37 @@ int hv_synic_cleanup(unsigned int cpu)
 	if (cpu == VMBUS_CONNECT_CPU)
 		return -EBUSY;
 
+	mutex_lock(&vmbus_connection.channel_mutex);
+	/*
+	 * The CPU is being hot removed: re-balance the channels across
+	 * the online CPUs but excluding "this" CPU.
+	 *
+	 * Note.  We do not roll back on failure; IOW, we may end up with
+	 * situations where the (re-)balancing process failed but some of
+	 * the channels have been re-assigned to different CPUs.
+	 *
+	 * Also, the balancing process makes no attempt to re-assign "non-
+	 * open" channels, that is, it only applies to channels which are
+	 * found in CHANNEL_OPENED_STATE.
+	 */
+	vmbus_balance_vp_indexes_at_cpuhp(cpu, false);
+
 	/*
 	 * Search for channels which are bound to the CPU we're about to
 	 * cleanup.  In case we find one and vmbus is still connected, we
 	 * fail; this will effectively prevent CPU offlining.
-	 *
-	 * TODO: Re-bind the channels to different CPUs.
 	 */
-	mutex_lock(&vmbus_connection.channel_mutex);
-	list_for_each_entry(channel, &vmbus_connection.chn_list, listentry) {
-		if (channel->target_cpu == cpu) {
-			channel_found = true;
-			break;
-		}
-		spin_lock_irqsave(&channel->lock, flags);
-		list_for_each_entry(sc, &channel->sc_list, sc_list) {
-			if (sc->target_cpu == cpu) {
-				channel_found = true;
-				break;
-			}
-		}
-		spin_unlock_irqrestore(&channel->lock, flags);
-		if (channel_found)
-			break;
+	if (hv_is_busy_cpu(cpu) && vmbus_connection.conn_state == CONNECTED) {
+		/*
+		 * The CPU was busy, and we are going to prevent it from
+		 * going offline; balance the channels accordingly.
+		 */
+		vmbus_balance_vp_indexes_at_cpuhp(cpu, true);
+		mutex_unlock(&vmbus_connection.channel_mutex);
+		return -EBUSY;
 	}
 	mutex_unlock(&vmbus_connection.channel_mutex);
 
-	if (channel_found && vmbus_connection.conn_state == CONNECTED)
-		return -EBUSY;
-
 	hv_stimer_legacy_cleanup(cpu);
 
 	hv_synic_disable_regs(cpu);
diff --git a/drivers/hv/hyperv_vmbus.h b/drivers/hv/hyperv_vmbus.h
index 40e2b9f91163c..b6d194caf69ed 100644
--- a/drivers/hv/hyperv_vmbus.h
+++ b/drivers/hv/hyperv_vmbus.h
@@ -18,6 +18,7 @@
 #include <linux/atomic.h>
 #include <linux/hyperv.h>
 #include <linux/interrupt.h>
+#include <linux/slab.h>
 
 #include "hv_trace.h"
 
@@ -250,6 +251,19 @@ struct vmbus_connection {
 	/* Array of channels */
 	struct vmbus_channel **channels;
 
+	/*
+	 * Channel counts used by the channel-interrupts balancing scheme:
+	 *
+	 *   - chn_cnt.cpu[cpu], the number of channel interrupts assigned
+	 *     to CPU #cpu;
+	 *
+	 *   - chn_cnt.node[node], the number of channel interrupts assigned
+	 *     to NUMA node #node.
+	 *
+	 * The counts refer to "open" *and "performance" channels only.
+	 */
+	struct vmbus_channel_counts chn_cnt;
+
 	/*
 	 * An offer message is handled first on the work_queue, and then
 	 * is further handled on handle_primary_chan_wq or
@@ -344,6 +358,8 @@ struct vmbus_channel *relid2channel(u32 relid);
 
 void vmbus_free_channels(void);
 
+void vmbus_balance_vp_indexes_at_cpuhp(unsigned int cpu, bool add);
+
 /* Connection interface */
 
 int vmbus_connect(void);
@@ -443,6 +459,62 @@ static inline void hv_update_alloced_cpus(unsigned int old_cpu,
 	hv_clear_alloced_cpu(old_cpu);
 }
 
+static inline bool hv_is_busy_cpu(unsigned int cpu)
+{
+	struct vmbus_channel *channel, *sc;
+
+	lockdep_assert_held(&vmbus_connection.channel_mutex);
+	/*
+	 * List additions/deletions as well as updates of the target CPUs are
+	 * protected by channel_mutex.
+	 */
+	list_for_each_entry(channel, &vmbus_connection.chn_list, listentry) {
+		if (channel->target_cpu == cpu)
+			return true;
+		list_for_each_entry(sc, &channel->sc_list, sc_list) {
+			if (sc->target_cpu == cpu)
+				return true;
+		}
+	}
+	return false;
+}
+
+static inline int alloc_chn_counts(struct vmbus_channel_counts *chn_cnt)
+{
+	chn_cnt->cpu = kcalloc(nr_cpu_ids, sizeof(unsigned int), GFP_KERNEL);
+	if (chn_cnt->cpu == NULL)
+		return -ENOMEM;
+
+	chn_cnt->node = kcalloc(nr_node_ids, sizeof(unsigned int), GFP_KERNEL);
+	if (chn_cnt->node == NULL)
+		return -ENOMEM;
+
+	return 0;
+}
+
+static inline void inc_chn_counts(struct vmbus_channel_counts *chn_cnt,
+				  unsigned int cpu)
+{
+	chn_cnt->cpu[cpu] += 1;
+	chn_cnt->node[cpu_to_node(cpu)] += 1;
+}
+
+static inline void reset_chn_counts(struct vmbus_channel_counts *chn_cnt)
+{
+	unsigned int i;
+
+	for_each_online_cpu(i)
+		chn_cnt->cpu[i] = 0;
+	for_each_online_node(i)
+		chn_cnt->node[i] = 0;
+}
+
+static inline void free_chn_counts(struct vmbus_channel_counts *chn_cnt)
+{
+	kfree(chn_cnt->cpu);
+	kfree(chn_cnt->node);
+}
+
 #ifdef CONFIG_HYPERV_TESTING
 
 int hv_debug_add_dev_dir(struct hv_device *dev);
diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 47747755d2e1d..a40b930fb86a5 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -980,6 +980,9 @@ static void vmbus_device_release(struct device *device)
 	mutex_lock(&vmbus_connection.channel_mutex);
 	hv_process_channel_removal(channel);
 	mutex_unlock(&vmbus_connection.channel_mutex);
+
+	if (hv_is_perf_channel(channel))
+		free_chn_counts(&hv_dev->chn_cnt);
 	kfree(hv_dev);
 }
 
@@ -1745,38 +1748,8 @@ static ssize_t target_cpu_store(struct vmbus_channel *channel,
 	if (target_cpu == origin_cpu)
 		goto cpu_store_unlock;
 
-	if (vmbus_send_modifychannel(channel->offermsg.child_relid,
-				     hv_cpu_number_to_vp_number(target_cpu))) {
+	if (!vmbus_modifychannel(channel, origin_cpu, target_cpu))
 		ret = -EIO;
-		goto cpu_store_unlock;
-	}
-
-	/*
-	 * Warning.  At this point, there is *no* guarantee that the host will
-	 * have successfully processed the vmbus_send_modifychannel() request.
-	 * See the header comment of vmbus_send_modifychannel() for more info.
-	 *
-	 * Lags in the processing of the above vmbus_send_modifychannel() can
-	 * result in missed interrupts if the "old" target CPU is taken offline
-	 * before Hyper-V starts sending interrupts to the "new" target CPU.
-	 * But apart from this offlining scenario, the code tolerates such
-	 * lags.  It will function correctly even if a channel interrupt comes
-	 * in on a CPU that is different from the channel target_cpu value.
-	 */
-
-	channel->target_cpu = target_cpu;
-	channel->target_vp = hv_cpu_number_to_vp_number(target_cpu);
-	channel->numa_node = cpu_to_node(target_cpu);
-
-	/* See init_vp_index(). */
-	if (hv_is_perf_channel(channel))
-		hv_update_alloced_cpus(origin_cpu, target_cpu);
-
-	/* Currently set only for storvsc channels. */
-	if (channel->change_target_cpu_callback) {
-		(*channel->change_target_cpu_callback)(channel,
-				origin_cpu, target_cpu);
-	}
 
 cpu_store_unlock:
 	mutex_unlock(&vmbus_connection.channel_mutex);
@@ -1972,6 +1945,15 @@ struct hv_device *vmbus_device_create(const guid_t *type,
 	guid_copy(&child_device_obj->dev_instance, instance);
 	child_device_obj->vendor_id = 0x1414; /* MSFT vendor ID */
 
+	if (!hv_is_perf_channel(channel))
+		return child_device_obj;
+
+	if (alloc_chn_counts(&child_device_obj->chn_cnt)) {
+		free_chn_counts(&child_device_obj->chn_cnt);
+		kfree(child_device_obj);
+		return NULL;
+	}
+
 	return child_device_obj;
 }
 
@@ -2616,7 +2598,6 @@ static void __exit vmbus_exit(void)
 	hv_debug_rm_all_dir();
 
 	vmbus_free_channels();
-	kfree(vmbus_connection.channels);
 
 	if (ms_hyperv.misc_features & HV_FEATURE_GUEST_CRASH_MSR_AVAILABLE) {
 		kmsg_dump_unregister(&hv_kmsg_dumper);
diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
index 40df3103e890b..0e9f695ea8f87 100644
--- a/include/linux/hyperv.h
+++ b/include/linux/hyperv.h
@@ -1175,6 +1175,12 @@ struct hv_driver {
 
 };
 
+/* For channel-interrupts balancing. */
+struct vmbus_channel_counts {
+	unsigned int *cpu;
+	unsigned int *node;
+};
+
 /* Base device object */
 struct hv_device {
 	/* the device type id of this device */
@@ -1191,9 +1197,21 @@ struct hv_device {
 	struct vmbus_channel *channel;
 	struct kset	     *channels_kset;
 
+	/*
+	 * Channel counts used by the channel-interrupts balancing scheme:
+	 *
+	 *   - chn_cnt.cpu[cpu], the number of channel interrupts of this
+	 *     device assigned to CPU #cpu;
+	 *
+	 *   - chn_cnt.node[node], the number of channel interrupts of this
+	 *     device assigned to NUMA node #node.
+	 *
+	 * The counts refer to "open" *and "performance" channels only.
+	 */
+	struct vmbus_channel_counts chn_cnt;
+
 	/* place holder to keep track of the dir for hv device in debugfs */
 	struct dentry *debug_dir;
-
 };
 
 
@@ -1523,6 +1541,8 @@ extern __u32 vmbus_proto_version;
 int vmbus_send_tl_connect_request(const guid_t *shv_guest_servie_id,
 				  const guid_t *shv_host_servie_id);
 int vmbus_send_modifychannel(u32 child_relid, u32 target_vp);
+bool vmbus_modifychannel(struct vmbus_channel *channel,
+			 u32 origin_cpu, u32 target_cpu);
 void vmbus_set_event(struct vmbus_channel *channel);
 
 /* Get the start of the ring buffer. */
diff --git a/kernel/cpu.c b/kernel/cpu.c
index 2371292f30b03..6853b1d3e3ce0 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -328,6 +328,7 @@ void lockdep_assert_cpus_held(void)
 
 	percpu_rwsem_assert_held(&cpu_hotplug_lock);
 }
+EXPORT_SYMBOL_GPL(lockdep_assert_cpus_held);
 
 static void lockdep_acquire_cpus_lock(void)
 {
-- 
2.25.1

