Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB8A049F757
	for <lists+linux-hyperv@lfdr.de>; Fri, 28 Jan 2022 11:34:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbiA1KeY (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 28 Jan 2022 05:34:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:55520 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230169AbiA1KeX (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 28 Jan 2022 05:34:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643366063;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ssNWzWYQq5ulBpYKTXBDf9uY7HzCQZkgOj2RtjbT3GI=;
        b=MxTGGvwqOCV9NEfFhVzzwY2Jlrm2xkRygL0TZAkPtPep+b/SyS/ahMTiKdkBDAUtpp6r21
        Pn/C6tYIyjHzyp8KkMAoTGYNPzcGvZ/gg9lRNbYEoaSSz26oAFb3IGoWewH/KBn3PxniAG
        Z1V45JZ6qRoTBxV4MQIBp84yIuYRWkE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-203-BB7bz3bqOyCToReajncOHg-1; Fri, 28 Jan 2022 05:34:19 -0500
X-MC-Unique: BB7bz3bqOyCToReajncOHg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6ABED83DD20;
        Fri, 28 Jan 2022 10:34:18 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.40.193.77])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E85EF7B6D5;
        Fri, 28 Jan 2022 10:34:15 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     linux-hyperv@vger.kernel.org, Wei Liu <wei.liu@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Michael Kelley <mikelley@microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>
Subject: [PATCH 1/2] Drivers: hv: Rename 'alloced' to 'allocated'
Date:   Fri, 28 Jan 2022 11:34:11 +0100
Message-Id: <20220128103412.3033736-2-vkuznets@redhat.com>
In-Reply-To: <20220128103412.3033736-1-vkuznets@redhat.com>
References: <20220128103412.3033736-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

'Alloced' is not a real word and only saves us two letters, let's
use 'allocated' instead.

No functional change intended.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 drivers/hv/channel_mgmt.c | 18 +++++++++---------
 drivers/hv/hyperv_vmbus.h | 14 +++++++-------
 drivers/hv/vmbus_drv.c    |  2 +-
 3 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
index 60375879612f..52cf6ae525e9 100644
--- a/drivers/hv/channel_mgmt.c
+++ b/drivers/hv/channel_mgmt.c
@@ -459,7 +459,7 @@ void hv_process_channel_removal(struct vmbus_channel *channel)
 	 * init_vp_index() can (re-)use the CPU.
 	 */
 	if (hv_is_perf_channel(channel))
-		hv_clear_alloced_cpu(channel->target_cpu);
+		hv_clear_allocated_cpu(channel->target_cpu);
 
 	/*
 	 * Upon suspend, an in-use hv_sock channel is marked as "rescinded" and
@@ -728,7 +728,7 @@ static void init_vp_index(struct vmbus_channel *channel)
 	bool perf_chn = hv_is_perf_channel(channel);
 	u32 i, ncpu = num_online_cpus();
 	cpumask_var_t available_mask;
-	struct cpumask *alloced_mask;
+	struct cpumask *allocated_mask;
 	u32 target_cpu;
 	int numa_node;
 
@@ -745,7 +745,7 @@ static void init_vp_index(struct vmbus_channel *channel)
 		 */
 		channel->target_cpu = VMBUS_CONNECT_CPU;
 		if (perf_chn)
-			hv_set_alloced_cpu(VMBUS_CONNECT_CPU);
+			hv_set_allocated_cpu(VMBUS_CONNECT_CPU);
 		return;
 	}
 
@@ -760,22 +760,22 @@ static void init_vp_index(struct vmbus_channel *channel)
 				continue;
 			break;
 		}
-		alloced_mask = &hv_context.hv_numa_map[numa_node];
+		allocated_mask = &hv_context.hv_numa_map[numa_node];
 
-		if (cpumask_weight(alloced_mask) ==
+		if (cpumask_weight(allocated_mask) ==
 		    cpumask_weight(cpumask_of_node(numa_node))) {
 			/*
 			 * We have cycled through all the CPUs in the node;
-			 * reset the alloced map.
+			 * reset the allocated map.
 			 */
-			cpumask_clear(alloced_mask);
+			cpumask_clear(allocated_mask);
 		}
 
-		cpumask_xor(available_mask, alloced_mask,
+		cpumask_xor(available_mask, allocated_mask,
 			    cpumask_of_node(numa_node));
 
 		target_cpu = cpumask_first(available_mask);
-		cpumask_set_cpu(target_cpu, alloced_mask);
+		cpumask_set_cpu(target_cpu, allocated_mask);
 
 		if (channel->offermsg.offer.sub_channel_index >= ncpu ||
 		    i > ncpu || !hv_cpuself_used(target_cpu, channel))
diff --git a/drivers/hv/hyperv_vmbus.h b/drivers/hv/hyperv_vmbus.h
index 3a1f007b678a..6b45c22bb717 100644
--- a/drivers/hv/hyperv_vmbus.h
+++ b/drivers/hv/hyperv_vmbus.h
@@ -405,7 +405,7 @@ static inline bool hv_is_perf_channel(struct vmbus_channel *channel)
 	return vmbus_devs[channel->device_id].perf_device;
 }
 
-static inline bool hv_is_alloced_cpu(unsigned int cpu)
+static inline bool hv_is_allocated_cpu(unsigned int cpu)
 {
 	struct vmbus_channel *channel, *sc;
 
@@ -427,23 +427,23 @@ static inline bool hv_is_alloced_cpu(unsigned int cpu)
 	return false;
 }
 
-static inline void hv_set_alloced_cpu(unsigned int cpu)
+static inline void hv_set_allocated_cpu(unsigned int cpu)
 {
 	cpumask_set_cpu(cpu, &hv_context.hv_numa_map[cpu_to_node(cpu)]);
 }
 
-static inline void hv_clear_alloced_cpu(unsigned int cpu)
+static inline void hv_clear_allocated_cpu(unsigned int cpu)
 {
-	if (hv_is_alloced_cpu(cpu))
+	if (hv_is_allocated_cpu(cpu))
 		return;
 	cpumask_clear_cpu(cpu, &hv_context.hv_numa_map[cpu_to_node(cpu)]);
 }
 
-static inline void hv_update_alloced_cpus(unsigned int old_cpu,
+static inline void hv_update_allocated_cpus(unsigned int old_cpu,
 					  unsigned int new_cpu)
 {
-	hv_set_alloced_cpu(new_cpu);
-	hv_clear_alloced_cpu(old_cpu);
+	hv_set_allocated_cpu(new_cpu);
+	hv_clear_allocated_cpu(old_cpu);
 }
 
 #ifdef CONFIG_HYPERV_TESTING
diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 17bf55fe3169..1d75a35116aa 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -1874,7 +1874,7 @@ static ssize_t target_cpu_store(struct vmbus_channel *channel,
 
 	/* See init_vp_index(). */
 	if (hv_is_perf_channel(channel))
-		hv_update_alloced_cpus(origin_cpu, target_cpu);
+		hv_update_allocated_cpus(origin_cpu, target_cpu);
 
 	/* Currently set only for storvsc channels. */
 	if (channel->change_target_cpu_callback) {
-- 
2.34.1

