Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 77E3A19EEE0
	for <lists+linux-hyperv@lfdr.de>; Mon,  6 Apr 2020 02:17:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728097AbgDFARM (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 5 Apr 2020 20:17:12 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37432 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728070AbgDFARE (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 5 Apr 2020 20:17:04 -0400
Received: by mail-wr1-f65.google.com with SMTP id w10so15392531wrm.4;
        Sun, 05 Apr 2020 17:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=68VyQPQisMup9xpkI1E9yTSymdvfN6wADz3YZ/tUUOA=;
        b=uBzpcRiNtFwXZlzxFs9+M9kZy9Zfx8qDj0cZObXotSbiXN1+HJ/q3czNMTyEzPIXNj
         H6/F5L11o/1UyaoorB19Tg7/HvnSw7DMefkzjTdzXnUBGSCAe0sUYV5hcxfnF9bPIMU5
         C19j6lL7irp/WjRZGnGm1T7q83/ezQzWTplO5gQtyKIqVknpsCn9Hg0MCxq/myADCz8k
         zgiGGeHv1Hcb6YKiFIYkVa7K7wL+SmTRoNCa/1b/NEKMOnTnup6dT9vud1+z3z3whZIO
         yuAWgB3SO2P0r6lJKVNMCVC/3kmoDLTvub7omnefs4erU5OyQmEykMz143gbxraZX4mr
         8vfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=68VyQPQisMup9xpkI1E9yTSymdvfN6wADz3YZ/tUUOA=;
        b=SdrRYb0VAloAQ50KH9suGYVyYziePOKP094bX9M7e1bEHk69mPnfKdneFHzp2kf8yW
         fybA853jYMaR6vDeBFsM1D8ocJtOf3p+BiE9WU9QtiosuwyAF2p4wcz69+RIx9RzF+LR
         XUgAV0Ls5EQBPeX9Q3JQw1BDYbDyS4snbqXVzyOoGjF2Pmp5n9rEZda7XwVPoC9Rh1R+
         GfVWRDOGMuBUxXamHL7oRA32h3n5NPOJseZNk9FxrfLrGppGYb0yeqDah80zJ2HIpICa
         fxieqi7r9lXGDtJTbtcC68L0SbMMcmRDYF+qyFOpidtF4/SZduQH4VSjz4MZ8M2AMvOI
         M+Zw==
X-Gm-Message-State: AGi0PuadcZI2m3nWx3HPgs7GalKdG3Sw0L1hZWjlFga3fZTKdYD9Fh16
        erwDkxrJQODFb1lSkvN81ZrvDHXT3L+Okg==
X-Google-Smtp-Source: APiQypLzSaFr2w94MliWZ/6zyGOJV15+9Jq/9iPnwr61BLd9jBMqDuMbh1lWC3F/rCLcJCp05yMTqA==
X-Received: by 2002:adf:f78a:: with SMTP id q10mr3559818wrp.132.1586132221615;
        Sun, 05 Apr 2020 17:17:01 -0700 (PDT)
Received: from andrea.corp.microsoft.com ([86.61.236.197])
        by smtp.gmail.com with ESMTPSA id j9sm817432wrn.59.2020.04.05.17.17.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Apr 2020 17:17:01 -0700 (PDT)
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
Subject: [PATCH 09/11] Drivers: hv: vmbus: Synchronize init_vp_index() vs. CPU hotplug
Date:   Mon,  6 Apr 2020 02:15:12 +0200
Message-Id: <20200406001514.19876-10-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200406001514.19876-1-parri.andrea@gmail.com>
References: <20200406001514.19876-1-parri.andrea@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

init_vp_index() may access the cpu_online_mask mask via its calls of
cpumask_of_node().  Make sure to protect these accesses with a
cpus_read_lock() critical section.

Also, remove some (hardcoded) instances of CPU(0) from init_vp_index()
and replace them with VMBUS_CONNECT_CPU.  The connect CPU can not go
offline, since Hyper-V does not provide a way to change it.

Finally, order the accesses of target_cpu from init_vp_index() and
hv_synic_cleanup() by relying on the channel_mutex; this is achieved
by moving the call of init_vp_index() into vmbus_process_offer().

Signed-off-by: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
---
 drivers/hv/channel_mgmt.c | 47 ++++++++++++++++++++++++++++-----------
 drivers/hv/hv.c           |  7 +++---
 2 files changed, 38 insertions(+), 16 deletions(-)

diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
index 9041e5950e367..3785beead503d 100644
--- a/drivers/hv/channel_mgmt.c
+++ b/drivers/hv/channel_mgmt.c
@@ -18,6 +18,7 @@
 #include <linux/module.h>
 #include <linux/completion.h>
 #include <linux/delay.h>
+#include <linux/cpu.h>
 #include <linux/hyperv.h>
 #include <asm/mshyperv.h>
 
@@ -466,13 +467,8 @@ static void vmbus_add_channel_work(struct work_struct *work)
 		container_of(work, struct vmbus_channel, add_channel_work);
 	struct vmbus_channel *primary_channel = newchannel->primary_channel;
 	unsigned long flags;
-	u16 dev_type;
 	int ret;
 
-	dev_type = hv_get_dev_type(newchannel);
-
-	init_vp_index(newchannel, dev_type);
-
 	/*
 	 * This state is used to indicate a successful open
 	 * so that when we do close the channel normally, we
@@ -504,7 +500,7 @@ static void vmbus_add_channel_work(struct work_struct *work)
 	if (!newchannel->device_obj)
 		goto err_deq_chan;
 
-	newchannel->device_obj->device_id = dev_type;
+	newchannel->device_obj->device_id = hv_get_dev_type(newchannel);
 	/*
 	 * Add the new device to the bus. This will kick off device-driver
 	 * binding which eventually invokes the device driver's AddDevice()
@@ -560,6 +556,25 @@ static void vmbus_process_offer(struct vmbus_channel *newchannel)
 	unsigned long flags;
 	bool fnew = true;
 
+	/*
+	 * Initialize the target_CPU before inserting the channel in
+	 * the chn_list and sc_list lists, within the channel_mutex
+	 * critical section:
+	 *
+	 * CPU1				CPU2
+	 *
+	 * [vmbus_process_offer()]	[hv_syninc_cleanup()]
+	 *
+	 * STORE target_cpu		LOCK channel_mutex
+	 * LOCK channel_mutex		SEARCH chn_list
+	 * INSERT chn_list		LOAD target_cpu
+	 * UNLOCK channel_mutex		UNLOCK channel_mutex
+	 *
+	 * Forbids: CPU2's SEARCH from seeing CPU1's INSERT &&
+	 * 		CPU2's LOAD from *not* seing CPU1's STORE
+	 */
+	init_vp_index(newchannel, hv_get_dev_type(newchannel));
+
 	mutex_lock(&vmbus_connection.channel_mutex);
 
 	/* Remember the channels that should be cleaned up upon suspend. */
@@ -656,7 +671,7 @@ static DEFINE_SPINLOCK(bind_channel_to_cpu_lock);
  * channel interrupt load by binding a channel to VCPU.
  *
  * For pre-win8 hosts or non-performance critical channels we assign the
- * first CPU in the first NUMA node.
+ * VMBUS_CONNECT_CPU.
  *
  * Starting with win8, performance critical channels will be distributed
  * evenly among all the available NUMA nodes.  Once the node is assigned,
@@ -675,17 +690,22 @@ static void init_vp_index(struct vmbus_channel *channel, u16 dev_type)
 	    !alloc_cpumask_var(&available_mask, GFP_KERNEL)) {
 		/*
 		 * Prior to win8, all channel interrupts are
-		 * delivered on cpu 0.
+		 * delivered on VMBUS_CONNECT_CPU.
 		 * Also if the channel is not a performance critical
-		 * channel, bind it to cpu 0.
-		 * In case alloc_cpumask_var() fails, bind it to cpu 0.
+		 * channel, bind it to VMBUS_CONNECT_CPU.
+		 * In case alloc_cpumask_var() fails, bind it to
+		 * VMBUS_CONNECT_CPU.
 		 */
-		channel->numa_node = 0;
-		channel->target_cpu = 0;
-		channel->target_vp = hv_cpu_number_to_vp_number(0);
+		channel->numa_node = cpu_to_node(VMBUS_CONNECT_CPU);
+		channel->target_cpu = VMBUS_CONNECT_CPU;
+		channel->target_vp =
+			hv_cpu_number_to_vp_number(VMBUS_CONNECT_CPU);
 		return;
 	}
 
+	/* No CPUs can come up or down during this. */
+	cpus_read_lock();
+
 	/*
 	 * Serializes the accesses to the global variable next_numa_node_id.
 	 * See also the header comment of the spin lock declaration.
@@ -723,6 +743,7 @@ static void init_vp_index(struct vmbus_channel *channel, u16 dev_type)
 	channel->target_vp = hv_cpu_number_to_vp_number(target_cpu);
 
 	spin_unlock(&bind_channel_to_cpu_lock);
+	cpus_read_unlock();
 
 	free_cpumask_var(available_mask);
 }
diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
index 17bf1f229152b..188b42b07f07b 100644
--- a/drivers/hv/hv.c
+++ b/drivers/hv/hv.c
@@ -256,9 +256,10 @@ int hv_synic_cleanup(unsigned int cpu)
 
 	/*
 	 * Search for channels which are bound to the CPU we're about to
-	 * cleanup. In case we find one and vmbus is still connected we need to
-	 * fail, this will effectively prevent CPU offlining. There is no way
-	 * we can re-bind channels to different CPUs for now.
+	 * cleanup.  In case we find one and vmbus is still connected, we
+	 * fail; this will effectively prevent CPU offlining.
+	 *
+	 * TODO: Re-bind the channels to different CPUs.
 	 */
 	mutex_lock(&vmbus_connection.channel_mutex);
 	list_for_each_entry(channel, &vmbus_connection.chn_list, listentry) {
-- 
2.24.0

