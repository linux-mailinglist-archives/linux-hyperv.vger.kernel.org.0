Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CE361DEE13
	for <lists+linux-hyperv@lfdr.de>; Fri, 22 May 2020 19:19:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730471AbgEVRTz (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 22 May 2020 13:19:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730306AbgEVRTy (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 22 May 2020 13:19:54 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D674C061A0E;
        Fri, 22 May 2020 10:19:54 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id h16so9812586eds.5;
        Fri, 22 May 2020 10:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Aoh+Ec/CI4chxiSL7+Rra3JQMmPukxQpEq6asXFfw10=;
        b=Mj2T++QHKXMz27D+x7hfwxzmJ3JtguixUu+RFOJJf5ElFTwQCbpanUKtl3ESWA7h09
         WpI4XvPzfVS8kwnUQfEpO/TRrmfXcfcPj641BajI+buVADNUXgnwUnI0+V41lQVhxPfe
         4Pp2pIGZ8YVuaL8WiP5XBoKnUodROazJcO6S0HvicMG+7/0HkRvwrSybqkhljE/ENLTV
         xzeT31JrUdc0vBVomeMkReS3PcWHj9m/tPAlnTII0Y9+T/PAdfzbXnEN37KUVEiYHoRj
         Bm8uio+mBBBv5KBko8sCkGUI6MXlFNy6xXY4wAzqvLNZa+i7OXpDpe1t6PbQ1e36fpI/
         9CPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Aoh+Ec/CI4chxiSL7+Rra3JQMmPukxQpEq6asXFfw10=;
        b=GhJ0qmdrrQaFDaCClH9gzCWJE41X/bzoJY+8i87d8hgzgsbC76AycYKJVdmMP8knpu
         TWRQZu1dZ1JcS5LdrmcjU7/8hTniSBUk7SuPtk1OnC40T5dxmpd537daRbkEbcWyZn1/
         YzEmQZHyH9N7R28WKOm4akJ0+9FEWIR4u2w8HQpQ47GPRTPoLi2Y+srKZiiSAJ6Yjvfg
         V0byVb8h5WVPJCxdpRRtSQZcl2umfE8pVkIEoMnTihMY1EIO+XCQqQV7v8bc+pj8vk1A
         azzdPfHX9aJhUsn9Nh8p0Vqof1Kh2d9XUibRvDLD1/goRnSBMt3ysdLq1P7xhQ74ASdN
         PSag==
X-Gm-Message-State: AOAM530rxY4DvLioziEyui3EpkGjCnkod8cVxq9gpbzYLmYNpYDL8rqG
        s3LwaGG/6D7RuDTodVmjm3yW2oU1IT5qqNTU
X-Google-Smtp-Source: ABdhPJwpeUwpS4aTyByPrF9EKczKv8/rU2t4jwnVVLvtvIsp1YJ6QEsK9Z7OwwUVYOx2AC3rOz7nDQ==
X-Received: by 2002:aa7:d44a:: with SMTP id q10mr3935036edr.386.1590167992808;
        Fri, 22 May 2020 10:19:52 -0700 (PDT)
Received: from localhost.localdomain (ip-62-245-103-65.net.upcbroadband.cz. [62.245.103.65])
        by smtp.gmail.com with ESMTPSA id ay6sm7483094edb.29.2020.05.22.10.19.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2020 10:19:52 -0700 (PDT)
From:   "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>
To:     linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "K . Y . Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>
Subject: [PATCH 1/2] Drivers: hv: vmbus: Resolve race between init_vp_index() and CPU hotplug
Date:   Fri, 22 May 2020 19:19:00 +0200
Message-Id: <20200522171901.204127-2-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200522171901.204127-1-parri.andrea@gmail.com>
References: <20200522171901.204127-1-parri.andrea@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

vmbus_process_offer() does two things (among others):

 1) first, it sets the channel's target CPU with cpu_hotplug_lock;
 2) it then adds the channel to the channel list(s) with channel_mutex.

Since cpu_hotplug_lock is released before (2), the channel's target CPU
(as designated in (1)) can be deemed "free" by hv_synic_cleanup() and go
offline before the channel is added to the list.

Fix the race condition by "extending" the cpu_hotplug_lock critical
section to include (2) (and (1)), nesting the channel_mutex critical
section within the cpu_hotplug_lock critical section as done elsewhere
(hv_synic_cleanup(), target_cpu_store()) in the hyperv drivers code.

Move even further by extending the channel_mutex critical section to
include (1) (and (2)): this change allows to remove (the now redundant)
bind_channel_to_cpu_lock, and generally simplifies the handling of the
target CPUs (that are now always modified with channel_mutex held).

Fixes: d570aec0f2154e ("Drivers: hv: vmbus: Synchronize init_vp_index() vs. CPU hotplug")
Signed-off-by: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
---
 drivers/hv/channel_mgmt.c | 46 +++++++++++++++------------------------
 1 file changed, 18 insertions(+), 28 deletions(-)

diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
index fde806d6525b0..89eaacf069a80 100644
--- a/drivers/hv/channel_mgmt.c
+++ b/drivers/hv/channel_mgmt.c
@@ -554,26 +554,34 @@ static void vmbus_process_offer(struct vmbus_channel *newchannel)
 	bool fnew = true;
 
 	/*
-	 * Initialize the target_CPU before inserting the channel in
-	 * the chn_list and sc_list lists, within the channel_mutex
-	 * critical section:
+	 * Synchronize vmbus_process_offer() and CPU hotplugging:
 	 *
 	 * CPU1				CPU2
 	 *
-	 * [vmbus_process_offer()]	[hv_syninc_cleanup()]
+	 * [vmbus_process_offer()]	[Hot removal of the CPU]
 	 *
-	 * STORE target_cpu		LOCK channel_mutex
-	 * LOCK channel_mutex		SEARCH chn_list
-	 * INSERT chn_list		LOAD target_cpu
-	 * UNLOCK channel_mutex		UNLOCK channel_mutex
+	 * CPU_READ_LOCK		CPUS_WRITE_LOCK
+	 * LOAD cpu_online_mask		SEARCH chn_list
+	 * STORE target_cpu		LOAD target_cpu
+	 * INSERT chn_list		STORE cpu_online_mask
+	 * CPUS_READ_UNLOCK		CPUS_WRITE_UNLOCK
+	 *
+	 * Forbids: CPU1's LOAD from *not* seing CPU2's STORE &&
+	 * 		CPU2's SEARCH from *not* seeing CPU1's INSERT
 	 *
 	 * Forbids: CPU2's SEARCH from seeing CPU1's INSERT &&
 	 * 		CPU2's LOAD from *not* seing CPU1's STORE
 	 */
-	init_vp_index(newchannel, hv_get_dev_type(newchannel));
+	cpus_read_lock();
 
+	/*
+	 * Serializes the modifications of the chn_list list as well as
+	 * the accesses to next_numa_node_id in init_vp_index().
+	 */
 	mutex_lock(&vmbus_connection.channel_mutex);
 
+	init_vp_index(newchannel, hv_get_dev_type(newchannel));
+
 	/* Remember the channels that should be cleaned up upon suspend. */
 	if (is_hvsock_channel(newchannel) || is_sub_channel(newchannel))
 		atomic_inc(&vmbus_connection.nr_chan_close_on_suspend);
@@ -623,6 +631,7 @@ static void vmbus_process_offer(struct vmbus_channel *newchannel)
 	vmbus_channel_map_relid(newchannel);
 
 	mutex_unlock(&vmbus_connection.channel_mutex);
+	cpus_read_unlock();
 
 	/*
 	 * vmbus_process_offer() mustn't call channel->sc_creation_callback()
@@ -655,13 +664,6 @@ static void vmbus_process_offer(struct vmbus_channel *newchannel)
  * We use this state to statically distribute the channel interrupt load.
  */
 static int next_numa_node_id;
-/*
- * init_vp_index() accesses global variables like next_numa_node_id, and
- * it can run concurrently for primary channels and sub-channels: see
- * vmbus_process_offer(), so we need the lock to protect the global
- * variables.
- */
-static DEFINE_SPINLOCK(bind_channel_to_cpu_lock);
 
 /*
  * Starting with Win8, we can statically distribute the incoming
@@ -700,15 +702,6 @@ static void init_vp_index(struct vmbus_channel *channel, u16 dev_type)
 		return;
 	}
 
-	/* No CPUs can come up or down during this. */
-	cpus_read_lock();
-
-	/*
-	 * Serializes the accesses to the global variable next_numa_node_id.
-	 * See also the header comment of the spin lock declaration.
-	 */
-	spin_lock(&bind_channel_to_cpu_lock);
-
 	while (true) {
 		numa_node = next_numa_node_id++;
 		if (numa_node == nr_node_ids) {
@@ -739,9 +732,6 @@ static void init_vp_index(struct vmbus_channel *channel, u16 dev_type)
 	channel->target_cpu = target_cpu;
 	channel->target_vp = hv_cpu_number_to_vp_number(target_cpu);
 
-	spin_unlock(&bind_channel_to_cpu_lock);
-	cpus_read_unlock();
-
 	free_cpumask_var(available_mask);
 }
 
-- 
2.25.1

