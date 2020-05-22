Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C173B1DEE15
	for <lists+linux-hyperv@lfdr.de>; Fri, 22 May 2020 19:20:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730471AbgEVRUK (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 22 May 2020 13:20:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730306AbgEVRUJ (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 22 May 2020 13:20:09 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CDFCC061A0E;
        Fri, 22 May 2020 10:20:09 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id n24so13877876ejd.0;
        Fri, 22 May 2020 10:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+WWewBL9ydH6Fsx0AHmYYCMfZ5CbSII+R3IY8ej8qNA=;
        b=lXdsGjofKzotXGIguO7nq5rfG3tXDXlHWErQJnaGvCfTc+994KreBhakZ99U80XL9T
         62gijwja7Pb+dDVboc0SpaVcP3C/1qqmxIvRG/Yqf37X1TXmEQIoIMUUITw9bHunCuij
         TfGav6KsZ2/0q/LM7YnU7n/I9Oft464Y518n0uzYhF2d5BdT1pjACjm7KilHITSSEbs2
         jqnndTI6Oa1hkmIYwlfM8SUvHvX16gFkRzL2JzXnvcB61nwaBJooSvsHAWqJ8TvVYSyD
         GdHWfN5VZXDltJfxajGsqyCkn4HC0DNHFoRPet3sTSFoky2iBbcKu7ACQcCRu5ydaY0H
         MmRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+WWewBL9ydH6Fsx0AHmYYCMfZ5CbSII+R3IY8ej8qNA=;
        b=ELSmEmBHYaU6pflKkTrCR2BaehlfVAm5oZ6mpUPKNb8UxWVbFovBXUgKkeJJqx/V1f
         hmZyF/UJBeTlpNVUwtJ1RsVxr77eppedQVWLxJSHER1KSRsXLFuddpzAS0/KbxtHo1Rq
         Ri7+GxqlgmcvPsZDRXlHiz/aKEP07tPdFsQtIrk4qgNGJsE5YHh8/4QgDEb8sppAtd5i
         aplBny2O1U7eRXZn04SgGk3cl2OJpLS/uGpmeFbJ9MQoQHlGi8h2GqtDzy36wymd/lgf
         Y23TqePd/55Z6zlLgGUdROzkmFM/0iukdTJEmlYApkmK8KZHgk9ubKWojq7GVjPjlUM7
         i2eg==
X-Gm-Message-State: AOAM530rmQGj2y56hYQ5Wo+JS6yFWEinVGxoU16zwba5uwW7im13nAmj
        k6bDRMHA6hlKqR//+FP1m75lKgLdc+kBKks0
X-Google-Smtp-Source: ABdhPJwoW2gTCmbRH6Zzxx135VOJH1aMtHP2nGQzlf7fy2jfLTU1qdjJ2tPxDqmsiBC9OU5xbt5G8w==
X-Received: by 2002:a17:906:934d:: with SMTP id p13mr8793255ejw.452.1590168007104;
        Fri, 22 May 2020 10:20:07 -0700 (PDT)
Received: from localhost.localdomain (ip-62-245-103-65.net.upcbroadband.cz. [62.245.103.65])
        by smtp.gmail.com with ESMTPSA id ay6sm7483094edb.29.2020.05.22.10.20.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2020 10:20:06 -0700 (PDT)
From:   "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>
To:     linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "K . Y . Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>
Subject: [PATCH 2/2] Drivers: hv: vmbus: Resolve more races involving init_vp_index()
Date:   Fri, 22 May 2020 19:19:01 +0200
Message-Id: <20200522171901.204127-3-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200522171901.204127-1-parri.andrea@gmail.com>
References: <20200522171901.204127-1-parri.andrea@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

init_vp_index() uses the (per-node) hv_numa_map[] masks to record the
CPUs allocated for channel interrupts at a given time, and distribute
the performance-critical channels across the available CPUs: in part.,
the mask of "candidate" target CPUs in a given NUMA node, for a newly
offered channel, is determined by XOR-ing the node's CPU mask and the
node's hv_numa_map.  This operation/mechanism assumes that no offline
CPUs is set in the hv_numa_map mask, an assumption that does not hold
since such mask is currently not updated when a channel is removed or
assigned to a different CPU.

To address the issues described above, this adds hooks in the channel
removal path (hv_process_channel_removal()) and in target_cpu_store()
in order to clear, resp. to update, the hv_numa_map[] masks as needed.
This also adds a (missed) update of the masks in init_vp_index() (cf.,
e.g., the memory-allocation failure path in this function).

Like in the case of init_vp_index(), such hooks require to determine
if the given channel is performance critical.  init_vp_index() does
this by parsing the channel's offer, it can not rely on the device
data structure (device_obj) to retrieve such information because the
device data structure has not been allocated/linked with the channel
by the time that init_vp_index() executes.  A similar situation may
hold in hv_is_alloced_cpu() (defined below); the adopted approach is
to "cache" the device type of the channel, as computed by parsing the
channel's offer, in the channel structure itself.

Fixes: 7527810573436f ("Drivers: hv: vmbus: Introduce the CHANNELMSG_MODIFYCHANNEL message type")
Signed-off-by: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
---
 drivers/hv/channel_mgmt.c | 22 +++++++++++++-----
 drivers/hv/hyperv_vmbus.h | 48 +++++++++++++++++++++++++++++++++++++++
 drivers/hv/vmbus_drv.c    | 19 +++++++++++-----
 include/linux/hyperv.h    |  7 ++++++
 4 files changed, 84 insertions(+), 12 deletions(-)

diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
index 89eaacf069a80..417a95e5094dd 100644
--- a/drivers/hv/channel_mgmt.c
+++ b/drivers/hv/channel_mgmt.c
@@ -24,9 +24,9 @@
 
 #include "hyperv_vmbus.h"
 
-static void init_vp_index(struct vmbus_channel *channel, u16 dev_type);
+static void init_vp_index(struct vmbus_channel *channel);
 
-static const struct vmbus_device vmbus_devs[] = {
+const struct vmbus_device vmbus_devs[] = {
 	/* IDE */
 	{ .dev_type = HV_IDE,
 	  HV_IDE_GUID,
@@ -431,6 +431,13 @@ void hv_process_channel_removal(struct vmbus_channel *channel)
 		spin_unlock_irqrestore(&primary_channel->lock, flags);
 	}
 
+	/*
+	 * If this is a "perf" channel, updates the hv_numa_map[] masks so that
+	 * init_vp_index() can (re-)use the CPU.
+	 */
+	if (hv_is_perf_channel(channel))
+		hv_clear_alloced_cpu(channel->target_cpu);
+
 	/*
 	 * Upon suspend, an in-use hv_sock channel is marked as "rescinded" and
 	 * the relid is invalidated; after hibernation, when the user-space app
@@ -497,7 +504,7 @@ static void vmbus_add_channel_work(struct work_struct *work)
 	if (!newchannel->device_obj)
 		goto err_deq_chan;
 
-	newchannel->device_obj->device_id = hv_get_dev_type(newchannel);
+	newchannel->device_obj->device_id = newchannel->device_id;
 	/*
 	 * Add the new device to the bus. This will kick off device-driver
 	 * binding which eventually invokes the device driver's AddDevice()
@@ -580,7 +587,7 @@ static void vmbus_process_offer(struct vmbus_channel *newchannel)
 	 */
 	mutex_lock(&vmbus_connection.channel_mutex);
 
-	init_vp_index(newchannel, hv_get_dev_type(newchannel));
+	init_vp_index(newchannel);
 
 	/* Remember the channels that should be cleaned up upon suspend. */
 	if (is_hvsock_channel(newchannel) || is_sub_channel(newchannel))
@@ -676,9 +683,9 @@ static int next_numa_node_id;
  * evenly among all the available NUMA nodes.  Once the node is assigned,
  * we will assign the CPU based on a simple round robin scheme.
  */
-static void init_vp_index(struct vmbus_channel *channel, u16 dev_type)
+static void init_vp_index(struct vmbus_channel *channel)
 {
-	bool perf_chn = vmbus_devs[dev_type].perf_device;
+	bool perf_chn = hv_is_perf_channel(channel);
 	cpumask_var_t available_mask;
 	struct cpumask *alloced_mask;
 	u32 target_cpu;
@@ -699,6 +706,8 @@ static void init_vp_index(struct vmbus_channel *channel, u16 dev_type)
 		channel->target_cpu = VMBUS_CONNECT_CPU;
 		channel->target_vp =
 			hv_cpu_number_to_vp_number(VMBUS_CONNECT_CPU);
+		if (perf_chn)
+			hv_set_alloced_cpu(VMBUS_CONNECT_CPU);
 		return;
 	}
 
@@ -862,6 +871,7 @@ static void vmbus_setup_channel_state(struct vmbus_channel *channel,
 	       sizeof(struct vmbus_channel_offer_channel));
 	channel->monitor_grp = (u8)offer->monitorid / 32;
 	channel->monitor_bit = (u8)offer->monitorid % 32;
+	channel->device_id = hv_get_dev_type(channel);
 }
 
 /*
diff --git a/drivers/hv/hyperv_vmbus.h b/drivers/hv/hyperv_vmbus.h
index 5e5cebe5d048f..40e2b9f91163c 100644
--- a/drivers/hv/hyperv_vmbus.h
+++ b/drivers/hv/hyperv_vmbus.h
@@ -395,6 +395,54 @@ enum delay {
 	MESSAGE_DELAY   = 1,
 };
 
+extern const struct vmbus_device vmbus_devs[];
+
+static inline bool hv_is_perf_channel(struct vmbus_channel *channel)
+{
+	return vmbus_devs[channel->device_id].perf_device;
+}
+
+static inline bool hv_is_alloced_cpu(unsigned int cpu)
+{
+	struct vmbus_channel *channel, *sc;
+
+	lockdep_assert_held(&vmbus_connection.channel_mutex);
+	/*
+	 * List additions/deletions as well as updates of the target CPUs are
+	 * protected by channel_mutex.
+	 */
+	list_for_each_entry(channel, &vmbus_connection.chn_list, listentry) {
+		if (!hv_is_perf_channel(channel))
+			continue;
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
+static inline void hv_set_alloced_cpu(unsigned int cpu)
+{
+	cpumask_set_cpu(cpu, &hv_context.hv_numa_map[cpu_to_node(cpu)]);
+}
+
+static inline void hv_clear_alloced_cpu(unsigned int cpu)
+{
+	if (hv_is_alloced_cpu(cpu))
+		return;
+	cpumask_clear_cpu(cpu, &hv_context.hv_numa_map[cpu_to_node(cpu)]);
+}
+
+static inline void hv_update_alloced_cpus(unsigned int old_cpu,
+					  unsigned int new_cpu)
+{
+	hv_set_alloced_cpu(new_cpu);
+	hv_clear_alloced_cpu(old_cpu);
+}
+
 #ifdef CONFIG_HYPERV_TESTING
 
 int hv_debug_add_dev_dir(struct hv_device *dev);
diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index c2a4a7c0b99a0..47747755d2e1d 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -1687,8 +1687,8 @@ static ssize_t target_cpu_show(struct vmbus_channel *channel, char *buf)
 static ssize_t target_cpu_store(struct vmbus_channel *channel,
 				const char *buf, size_t count)
 {
+	u32 target_cpu, origin_cpu;
 	ssize_t ret = count;
-	u32 target_cpu;
 
 	if (vmbus_proto_version < VERSION_WIN10_V4_1)
 		return -EIO;
@@ -1741,7 +1741,8 @@ static ssize_t target_cpu_store(struct vmbus_channel *channel,
 		goto cpu_store_unlock;
 	}
 
-	if (channel->target_cpu == target_cpu)
+	origin_cpu = channel->target_cpu;
+	if (target_cpu == origin_cpu)
 		goto cpu_store_unlock;
 
 	if (vmbus_send_modifychannel(channel->offermsg.child_relid,
@@ -1763,14 +1764,20 @@ static ssize_t target_cpu_store(struct vmbus_channel *channel,
 	 * in on a CPU that is different from the channel target_cpu value.
 	 */
 
-	if (channel->change_target_cpu_callback)
-		(*channel->change_target_cpu_callback)(channel,
-				channel->target_cpu, target_cpu);
-
 	channel->target_cpu = target_cpu;
 	channel->target_vp = hv_cpu_number_to_vp_number(target_cpu);
 	channel->numa_node = cpu_to_node(target_cpu);
 
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
 cpu_store_unlock:
 	mutex_unlock(&vmbus_connection.channel_mutex);
 	cpus_read_unlock();
diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
index d783847d8cb46..40df3103e890b 100644
--- a/include/linux/hyperv.h
+++ b/include/linux/hyperv.h
@@ -901,6 +901,13 @@ struct vmbus_channel {
 
 	bool probe_done;
 
+	/*
+	 * Cache the device ID here for easy access; this is useful, in
+	 * particular, in situations where the channel's device_obj has
+	 * not been allocated/initialized yet.
+	 */
+	u16 device_id;
+
 	/*
 	 * We must offload the handling of the primary/sub channels
 	 * from the single-threaded vmbus_connection.work_queue to
-- 
2.25.1

