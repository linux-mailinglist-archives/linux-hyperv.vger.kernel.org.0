Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DCF171933FD
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Mar 2020 23:57:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727738AbgCYW4o (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 25 Mar 2020 18:56:44 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34575 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727697AbgCYW4o (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 25 Mar 2020 18:56:44 -0400
Received: by mail-wr1-f65.google.com with SMTP id 65so5643445wrl.1;
        Wed, 25 Mar 2020 15:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hLBzTI870tyJo2xhEeYNSV5PWYP/wK0k7a+dy5LksCc=;
        b=tYq/EvjqKN8KuOhVBKIDvwedd9y8tlCE+grc5VtkoBUmgcyrVQQzbJAm13DZxhGDPV
         7Qs6UnD8k75GGVW2Ief2gBFpioc1liaN2W7PGURzGtjOOptTipBJqDgA3L9E0gVmfNP4
         2kUkgzx0bkWY0jmM1l1OFVNbj8mbxTufWyqnkBUr6huDfgSv2DVG0Z7kdXez+uzC5OhZ
         Tg7XJyTAdnribIp8XLsDhJTjab72D1Xxz2La9kux0azg6r6exDZ/z5UXbXnx/m7u5LTB
         ZxXPT/cW04VfebQQb8c/y1IrhlXIRPEfJkNdo/pN47kcKAlfkyjLInalJGwnJ1XFnGcC
         AEow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hLBzTI870tyJo2xhEeYNSV5PWYP/wK0k7a+dy5LksCc=;
        b=JxBcqVkRSvfagNRjnbjrBzL0jsvUL2Z0JS/BtVkUrd0zQlhrRRGCzUgvQgBHs8/XYs
         9mG2owggGcvAYqfndnr02sN6kWuPGDjr36hz2eR7SgAbjU8ZupzDQVOdTtG5YAdEZnkQ
         POnxVskaSpm9A6cyoiO5q6yFpIWgRvKVY3p7FHFrrR58TaHrKDNWzw+5zWbLSp2Etzw7
         /urK9gEQ+Vzw67nE4X38JX4CPXTM7GGjge+4mqdJECtipKyhTDMAabdhYiFBsVonw0a1
         0T2tctAr2szIhvMsWz+bXYNdgzwTa9QQa9sDxZ3NuCn8oJ6riReN6CIpfNkbm6l2hWXB
         DH8Q==
X-Gm-Message-State: ANhLgQ2P+q3dthd6nrii6pZhZ8b9MgHpoSfYp8Z0ijlNT6NYd/J25B6g
        zfbIAMQdQ3/Ps2hVDKgOiBG8eaWQNSwlqA+3
X-Google-Smtp-Source: ADFU+vsy5gMCLz6pITNKhJPmsS63ImQkqBms+CRGPfCq8n//bu4NeGbiUir7Q4gx+4Frq+7WlVW7jw==
X-Received: by 2002:adf:9321:: with SMTP id 30mr5691823wro.330.1585177000559;
        Wed, 25 Mar 2020 15:56:40 -0700 (PDT)
Received: from andrea.corp.microsoft.com ([86.61.236.197])
        by smtp.gmail.com with ESMTPSA id q72sm790278wme.31.2020.03.25.15.56.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2020 15:56:40 -0700 (PDT)
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
Subject: [RFC PATCH 09/11] Drivers: hv: vmbus: Synchronize init_vp_index() vs. CPU hotplug
Date:   Wed, 25 Mar 2020 23:55:03 +0100
Message-Id: <20200325225505.23998-10-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200325225505.23998-1-parri.andrea@gmail.com>
References: <20200325225505.23998-1-parri.andrea@gmail.com>
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
index 8f34494bb53fb..34672dc2fc935 100644
--- a/drivers/hv/channel_mgmt.c
+++ b/drivers/hv/channel_mgmt.c
@@ -18,6 +18,7 @@
 #include <linux/module.h>
 #include <linux/completion.h>
 #include <linux/delay.h>
+#include <linux/cpu.h>
 #include <linux/hyperv.h>
 #include <asm/mshyperv.h>
 
@@ -445,13 +446,8 @@ static void vmbus_add_channel_work(struct work_struct *work)
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
@@ -483,7 +479,7 @@ static void vmbus_add_channel_work(struct work_struct *work)
 	if (!newchannel->device_obj)
 		goto err_deq_chan;
 
-	newchannel->device_obj->device_id = dev_type;
+	newchannel->device_obj->device_id = hv_get_dev_type(newchannel);
 	/*
 	 * Add the new device to the bus. This will kick off device-driver
 	 * binding which eventually invokes the device driver's AddDevice()
@@ -539,6 +535,25 @@ static void vmbus_process_offer(struct vmbus_channel *newchannel)
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
@@ -635,7 +650,7 @@ static DEFINE_SPINLOCK(bind_channel_to_cpu_lock);
  * channel interrupt load by binding a channel to VCPU.
  *
  * For pre-win8 hosts or non-performance critical channels we assign the
- * first CPU in the first NUMA node.
+ * VMBUS_CONNECT_CPU.
  *
  * Starting with win8, performance critical channels will be distributed
  * evenly among all the available NUMA nodes.  Once the node is assigned,
@@ -654,17 +669,22 @@ static void init_vp_index(struct vmbus_channel *channel, u16 dev_type)
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
@@ -702,6 +722,7 @@ static void init_vp_index(struct vmbus_channel *channel, u16 dev_type)
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

