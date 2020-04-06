Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7BDEF19EEDF
	for <lists+linux-hyperv@lfdr.de>; Mon,  6 Apr 2020 02:17:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727946AbgDFARE (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 5 Apr 2020 20:17:04 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37431 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727967AbgDFARC (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 5 Apr 2020 20:17:02 -0400
Received: by mail-wr1-f65.google.com with SMTP id w10so15392490wrm.4;
        Sun, 05 Apr 2020 17:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eZuliAWcarJfF/v2dZTgX0LUFnmHL0tNJY8ionYvDiY=;
        b=urS9lL0XVTNdAi+ykSXUdblGgZD+Ps3YzLxHnOrG4F2yRoQoQY7RISuAIh1m89OgW0
         7G7HEQ5j92CZ2LBv8ede+cQCqK51PZWnb9teD359Dqi73SwiYr/PwhCTyiXwGk6pMosL
         wwnB87gbcY/yEWRBL7S/vZxWoHtUXi0jMDhuyh1HNMHMPXlIN+NSSRss/6haFv2n5NlH
         +bLjiOw8C7Xai8mtkKQA5nYzCNmNfHj1FQID3u1D6YF1oRie83+R1fT1EYfkb3z3xWwy
         tjjBdSirjcKhOU2m9ZzQ4wnPbuwzmrAJD17Dm7LakN5WmOv3pkTa/iCPvxfWZum1rQjE
         1NTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eZuliAWcarJfF/v2dZTgX0LUFnmHL0tNJY8ionYvDiY=;
        b=qo4giLPg90iW7/rf/Ar4Prz0bJLDtupys5us69DYGuTbn9kwt+1nzICJtapgnwxRye
         0xc8+j49MEHMaQEivJtwGKsDxHzFfmSZuGSo70jidcv+9I+TVyedcPMWqJfb+CVWVlC9
         eMEdMhB8tv/hKVn7DO86XdW71iuvNg1+6+wzG7CqOiD6rxHoJO0ykfeXUGoisfqlXVmC
         XbwA15q1/Nxu1KW/ANlGLV9wSOhSM0r9chlAZoRF2zdKpvHmi6Gs5POe1sYkZm61iidG
         L2o6zhqvQcv7/eCZVJAGPrCtdqK3IsQbMnd1tcznr0KLVvzsb7Pox400Lj35s9NbIrIY
         ltbg==
X-Gm-Message-State: AGi0Pual66V9ZH2HXzr52i8/zV4BkLI/Ikl5vgtzlYm27xqACwhbgvNO
        OJloIVv45c5KREFDAp1wudOW/+jAEkZkIQ==
X-Google-Smtp-Source: APiQypKXqFiRIWaQBUB9a25e0FGf9jY/lT8hDW2Z+j0jufnKnX4FduzruH1CLytKxIHAJmEu9fBqPg==
X-Received: by 2002:adf:fa4f:: with SMTP id y15mr9696244wrr.118.1586132219526;
        Sun, 05 Apr 2020 17:16:59 -0700 (PDT)
Received: from andrea.corp.microsoft.com ([86.61.236.197])
        by smtp.gmail.com with ESMTPSA id j9sm817432wrn.59.2020.04.05.17.16.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Apr 2020 17:16:59 -0700 (PDT)
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
Subject: [PATCH 08/11] Drivers: hv: vmbus: Remove the unused HV_LOCALIZED channel affinity logic
Date:   Mon,  6 Apr 2020 02:15:11 +0200
Message-Id: <20200406001514.19876-9-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200406001514.19876-1-parri.andrea@gmail.com>
References: <20200406001514.19876-1-parri.andrea@gmail.com>
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
index 46ea978e4222a..9041e5950e367 100644
--- a/drivers/hv/channel_mgmt.c
+++ b/drivers/hv/channel_mgmt.c
@@ -433,14 +433,6 @@ void hv_process_channel_removal(struct vmbus_channel *channel)
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
@@ -662,20 +654,21 @@ static DEFINE_SPINLOCK(bind_channel_to_cpu_lock);
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
@@ -693,31 +686,27 @@ static void init_vp_index(struct vmbus_channel *channel, u16 dev_type)
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
@@ -725,57 +714,13 @@ static void init_vp_index(struct vmbus_channel *channel, u16 dev_type)
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

