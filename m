Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF8561933FB
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Mar 2020 23:57:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727721AbgCYW4m (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 25 Mar 2020 18:56:42 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43646 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727705AbgCYW4m (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 25 Mar 2020 18:56:42 -0400
Received: by mail-wr1-f68.google.com with SMTP id b2so5543746wrj.10;
        Wed, 25 Mar 2020 15:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9eRddVGjZ9QS6CRQXETQabJAre8JiOTi1KDPoqB/i0k=;
        b=F2V0XBYvlGKceaAuUmI5DGe6qBWz1VAW4uvcP8iJ9iuwEQMPaS5TClzWQxJhhILS2B
         Z3eJCja1J4aITe7Phwyf05ytstmduNr+vuArmCJYcPfxwU+QTVEz95zobUy53YuO7Gyc
         rIyH/Rr0WxbGBVoPr/yyZx/rbNYn2sVvqnn5Ys7+6II0SbFgUHn3gTqggVmOJt8nww2G
         7dOcrSAu3tBS6DQZX457OTYerAaLaEVph5V/APqqmjIgnj2/da8xNqLrVE6g8oHMS14o
         vUWiZxh5Q4S0uixkWN7DxDz610vQfV6UFIXzazGTLt2JwJm9fzoIDCGOzO4OZozVpp0w
         tv8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9eRddVGjZ9QS6CRQXETQabJAre8JiOTi1KDPoqB/i0k=;
        b=g/ZBqSeylxqAsQeU1zMPmO7Ok2C70jhzq4gqB0RMxSS64T/fPOcfgAnq9x/uqCjdZe
         m0KClKxq1L3VlfuG6gWvshoe+5M0LK8QOsvY+4a++kbtr0IkGra9EsdDNhmgDd+nSYTj
         jqWtdgPBCd4tPAEUrBuMuVhbi5RyV6vBgF4ww8s2eznN0Nm6RQqYMcdsOOMExz4rVlgE
         1t0MGyei3Y2hObOJcgObIMEcbXVJ1/lP3/DkxAviryVC9KZ724/JdzadfovWfZSp+kXN
         ajCwAiE4P1s0HRkGA/UUC1CrjuOv516GuXZKMGLtL6G44hGI6DrCiX5zSlWUiaBkdeCV
         Cm5g==
X-Gm-Message-State: ANhLgQ1N6zhpguCs/lKLJnD21Jyow6JP04GFcwkmxVWRKvzZHGQILHYE
        V34Y9YutDu0WHPd81XxEP2FLbYdpvwUc7Jgb
X-Google-Smtp-Source: ADFU+vtlZr9AtThTSReUpdW6JNSytLuRzsV6OcKALd8dmI8MlL+ynTXf60fCebSrmnF0bF6Bq/eUjw==
X-Received: by 2002:adf:fa51:: with SMTP id y17mr1729342wrr.280.1585176998092;
        Wed, 25 Mar 2020 15:56:38 -0700 (PDT)
Received: from andrea.corp.microsoft.com ([86.61.236.197])
        by smtp.gmail.com with ESMTPSA id q72sm790278wme.31.2020.03.25.15.56.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2020 15:56:37 -0700 (PDT)
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
Subject: [RFC PATCH 08/11] Drivers: hv: vmbus: Remove the unused HV_LOCALIZED channel affinity logic
Date:   Wed, 25 Mar 2020 23:55:02 +0100
Message-Id: <20200325225505.23998-9-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200325225505.23998-1-parri.andrea@gmail.com>
References: <20200325225505.23998-1-parri.andrea@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

The logic is unused since commit 509879bdb30b8 ("Drivers: hv: Introduce
a policy for controlling channel affinity").

This logic assumes that a channel target_cpu doesn't change during the
lifetime of a channel, but this assumption is incompatible with the new
functionality that allows changing the vCPU a channel will interrupt.

Signed-off-by: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
---
 drivers/hv/channel_mgmt.c | 105 +++++++++-----------------------------
 include/linux/hyperv.h    |  27 ----------
 2 files changed, 25 insertions(+), 107 deletions(-)

diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
index c53f58ba06dcf..8f34494bb53fb 100644
--- a/drivers/hv/channel_mgmt.c
+++ b/drivers/hv/channel_mgmt.c
@@ -412,14 +412,6 @@ void hv_process_channel_removal(struct vmbus_channel *channel)
 		spin_unlock_irqrestore(&primary_channel->lock, flags);
 	}
 
-	/*
-	 * We need to free the bit for init_vp_index() to work in the case
-	 * of sub-channel, when we reload drivers like hv_netvsc.
-	 */
-	if (channel->affinity_policy == HV_LOCALIZED)
-		cpumask_clear_cpu(channel->target_cpu,
-				  &primary_channel->alloced_cpus_in_node);
-
 	/*
 	 * Upon suspend, an in-use hv_sock channel is marked as "rescinded" and
 	 * the relid is invalidated; after hibernation, when the user-space app
@@ -641,20 +633,21 @@ static DEFINE_SPINLOCK(bind_channel_to_cpu_lock);
 /*
  * Starting with Win8, we can statically distribute the incoming
  * channel interrupt load by binding a channel to VCPU.
- * We distribute the interrupt loads to one or more NUMA nodes based on
- * the channel's affinity_policy.
  *
  * For pre-win8 hosts or non-performance critical channels we assign the
  * first CPU in the first NUMA node.
+ *
+ * Starting with win8, performance critical channels will be distributed
+ * evenly among all the available NUMA nodes.  Once the node is assigned,
+ * we will assign the CPU based on a simple round robin scheme.
  */
 static void init_vp_index(struct vmbus_channel *channel, u16 dev_type)
 {
-	u32 cur_cpu;
 	bool perf_chn = vmbus_devs[dev_type].perf_device;
-	struct vmbus_channel *primary = channel->primary_channel;
-	int next_node;
 	cpumask_var_t available_mask;
 	struct cpumask *alloced_mask;
+	u32 target_cpu;
+	int numa_node;
 
 	if ((vmbus_proto_version == VERSION_WS2008) ||
 	    (vmbus_proto_version == VERSION_WIN7) || (!perf_chn) ||
@@ -672,31 +665,27 @@ static void init_vp_index(struct vmbus_channel *channel, u16 dev_type)
 		return;
 	}
 
-	spin_lock(&bind_channel_to_cpu_lock);
-
 	/*
-	 * Based on the channel affinity policy, we will assign the NUMA
-	 * nodes.
+	 * Serializes the accesses to the global variable next_numa_node_id.
+	 * See also the header comment of the spin lock declaration.
 	 */
+	spin_lock(&bind_channel_to_cpu_lock);
 
-	if ((channel->affinity_policy == HV_BALANCED) || (!primary)) {
-		while (true) {
-			next_node = next_numa_node_id++;
-			if (next_node == nr_node_ids) {
-				next_node = next_numa_node_id = 0;
-				continue;
-			}
-			if (cpumask_empty(cpumask_of_node(next_node)))
-				continue;
-			break;
+	while (true) {
+		numa_node = next_numa_node_id++;
+		if (numa_node == nr_node_ids) {
+			next_numa_node_id = 0;
+			continue;
 		}
-		channel->numa_node = next_node;
-		primary = channel;
+		if (cpumask_empty(cpumask_of_node(numa_node)))
+			continue;
+		break;
 	}
-	alloced_mask = &hv_context.hv_numa_map[primary->numa_node];
+	channel->numa_node = numa_node;
+	alloced_mask = &hv_context.hv_numa_map[numa_node];
 
 	if (cpumask_weight(alloced_mask) ==
-	    cpumask_weight(cpumask_of_node(primary->numa_node))) {
+	    cpumask_weight(cpumask_of_node(numa_node))) {
 		/*
 		 * We have cycled through all the CPUs in the node;
 		 * reset the alloced map.
@@ -704,57 +693,13 @@ static void init_vp_index(struct vmbus_channel *channel, u16 dev_type)
 		cpumask_clear(alloced_mask);
 	}
 
-	cpumask_xor(available_mask, alloced_mask,
-		    cpumask_of_node(primary->numa_node));
+	cpumask_xor(available_mask, alloced_mask, cpumask_of_node(numa_node));
 
-	cur_cpu = -1;
-
-	if (primary->affinity_policy == HV_LOCALIZED) {
-		/*
-		 * Normally Hyper-V host doesn't create more subchannels
-		 * than there are VCPUs on the node but it is possible when not
-		 * all present VCPUs on the node are initialized by guest.
-		 * Clear the alloced_cpus_in_node to start over.
-		 */
-		if (cpumask_equal(&primary->alloced_cpus_in_node,
-				  cpumask_of_node(primary->numa_node)))
-			cpumask_clear(&primary->alloced_cpus_in_node);
-	}
-
-	while (true) {
-		cur_cpu = cpumask_next(cur_cpu, available_mask);
-		if (cur_cpu >= nr_cpu_ids) {
-			cur_cpu = -1;
-			cpumask_copy(available_mask,
-				     cpumask_of_node(primary->numa_node));
-			continue;
-		}
-
-		if (primary->affinity_policy == HV_LOCALIZED) {
-			/*
-			 * NOTE: in the case of sub-channel, we clear the
-			 * sub-channel related bit(s) in
-			 * primary->alloced_cpus_in_node in
-			 * hv_process_channel_removal(), so when we
-			 * reload drivers like hv_netvsc in SMP guest, here
-			 * we're able to re-allocate
-			 * bit from primary->alloced_cpus_in_node.
-			 */
-			if (!cpumask_test_cpu(cur_cpu,
-					      &primary->alloced_cpus_in_node)) {
-				cpumask_set_cpu(cur_cpu,
-						&primary->alloced_cpus_in_node);
-				cpumask_set_cpu(cur_cpu, alloced_mask);
-				break;
-			}
-		} else {
-			cpumask_set_cpu(cur_cpu, alloced_mask);
-			break;
-		}
-	}
+	target_cpu = cpumask_first(available_mask);
+	cpumask_set_cpu(target_cpu, alloced_mask);
 
-	channel->target_cpu = cur_cpu;
-	channel->target_vp = hv_cpu_number_to_vp_number(cur_cpu);
+	channel->target_cpu = target_cpu;
+	channel->target_vp = hv_cpu_number_to_vp_number(target_cpu);
 
 	spin_unlock(&bind_channel_to_cpu_lock);
 
diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
index ce32ab186192f..f8e7c22d41a1a 100644
--- a/include/linux/hyperv.h
+++ b/include/linux/hyperv.h
@@ -689,11 +689,6 @@ union hv_connection_id {
 	} u;
 };
 
-enum hv_numa_policy {
-	HV_BALANCED = 0,
-	HV_LOCALIZED,
-};
-
 enum vmbus_device_type {
 	HV_IDE = 0,
 	HV_SCSI,
@@ -808,10 +803,6 @@ struct vmbus_channel {
 	u32 target_vp;
 	/* The corresponding CPUID in the guest */
 	u32 target_cpu;
-	/*
-	 * State to manage the CPU affiliation of channels.
-	 */
-	struct cpumask alloced_cpus_in_node;
 	int numa_node;
 	/*
 	 * Support for sub-channels. For high performance devices,
@@ -898,18 +889,6 @@ struct vmbus_channel {
 	 */
 	bool low_latency;
 
-	/*
-	 * NUMA distribution policy:
-	 * We support two policies:
-	 * 1) Balanced: Here all performance critical channels are
-	 *    distributed evenly amongst all the NUMA nodes.
-	 *    This policy will be the default policy.
-	 * 2) Localized: All channels of a given instance of a
-	 *    performance critical service will be assigned CPUs
-	 *    within a selected NUMA node.
-	 */
-	enum hv_numa_policy affinity_policy;
-
 	bool probe_done;
 
 	/*
@@ -965,12 +944,6 @@ static inline bool is_sub_channel(const struct vmbus_channel *c)
 	return c->offermsg.offer.sub_channel_index != 0;
 }
 
-static inline void set_channel_affinity_state(struct vmbus_channel *c,
-					      enum hv_numa_policy policy)
-{
-	c->affinity_policy = policy;
-}
-
 static inline void set_channel_read_mode(struct vmbus_channel *c,
 					enum hv_callback_mode mode)
 {
-- 
2.24.0

