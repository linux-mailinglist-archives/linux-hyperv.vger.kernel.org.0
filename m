Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E604535A3B
	for <lists+linux-hyperv@lfdr.de>; Fri, 27 May 2022 09:22:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239354AbiE0HWW (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 27 May 2022 03:22:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238882AbiE0HWW (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 27 May 2022 03:22:22 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 33C7056C29;
        Fri, 27 May 2022 00:22:21 -0700 (PDT)
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
        by linux.microsoft.com (Postfix) with ESMTPSA id D530120B56AF;
        Fri, 27 May 2022 00:22:20 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D530120B56AF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1653636140;
        bh=PlZcd/dODcl1W11F7uDMCkDb/HUQUqELj/xwFcJVQyQ=;
        h=From:To:Subject:Date:From;
        b=CPVHsBvOkUsDWmysmw+HU6g7EV6BFEU9MDPHj5TF3iG3A36N5GIRuTxtoDzKWykcF
         NOZdxITAn5eeOeUP1mlA4S0yG3LTbGtXBomezb8EuSu/0UADcKcDIjgQzIIilUDN33
         krbNcu3lklng2hSoBSJnVU8opyxcbYwF2xmlUYhk=
From:   Saurabh Sengar <ssengar@linux.microsoft.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, decui@microsoft.com,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        ssengar@microsoft.com, mikelley@microsoft.com
Subject: [PATCH v2] Drivers: hv: vmbus: Don't assign VMbus channel interrupts to isolated CPUs
Date:   Fri, 27 May 2022 00:22:16 -0700
Message-Id: <1653636136-19643-1-git-send-email-ssengar@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

When initially assigning a VMbus channel interrupt to a CPU, don’t choose
a managed IRQ isolated CPU (as specified on the kernel boot line with
parameter 'isolcpus=managed_irq,<#cpu>'). Also, when using sysfs to change
the CPU that a VMbus channel will interrupt, don't allow changing to a
managed IRQ isolated CPU.

Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
---
v2: * better commit message
    * Added back empty line, removed by mistake
    * Removed error print for sysfs error

 drivers/hv/channel_mgmt.c | 18 ++++++++++++------
 drivers/hv/vmbus_drv.c    |  4 ++++
 2 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
index 97d8f56..e1fe029 100644
--- a/drivers/hv/channel_mgmt.c
+++ b/drivers/hv/channel_mgmt.c
@@ -21,6 +21,7 @@
 #include <linux/cpu.h>
 #include <linux/hyperv.h>
 #include <asm/mshyperv.h>
+#include <linux/sched/isolation.h>
 
 #include "hyperv_vmbus.h"
 
@@ -728,16 +729,20 @@ static void init_vp_index(struct vmbus_channel *channel)
 	u32 i, ncpu = num_online_cpus();
 	cpumask_var_t available_mask;
 	struct cpumask *allocated_mask;
+	const struct cpumask *hk_mask = housekeeping_cpumask(HK_TYPE_MANAGED_IRQ);
 	u32 target_cpu;
 	int numa_node;
 
 	if (!perf_chn ||
-	    !alloc_cpumask_var(&available_mask, GFP_KERNEL)) {
+	    !alloc_cpumask_var(&available_mask, GFP_KERNEL) ||
+	    cpumask_empty(hk_mask)) {
 		/*
 		 * If the channel is not a performance critical
 		 * channel, bind it to VMBUS_CONNECT_CPU.
 		 * In case alloc_cpumask_var() fails, bind it to
 		 * VMBUS_CONNECT_CPU.
+		 * If all the cpus are isolated, bind it to
+		 * VMBUS_CONNECT_CPU.
 		 */
 		channel->target_cpu = VMBUS_CONNECT_CPU;
 		if (perf_chn)
@@ -758,17 +763,19 @@ static void init_vp_index(struct vmbus_channel *channel)
 		}
 		allocated_mask = &hv_context.hv_numa_map[numa_node];
 
-		if (cpumask_equal(allocated_mask, cpumask_of_node(numa_node))) {
+retry:
+		cpumask_xor(available_mask, allocated_mask, cpumask_of_node(numa_node));
+		cpumask_and(available_mask, available_mask, hk_mask);
+
+		if (cpumask_empty(available_mask)) {
 			/*
 			 * We have cycled through all the CPUs in the node;
 			 * reset the allocated map.
 			 */
 			cpumask_clear(allocated_mask);
+			goto retry;
 		}
 
-		cpumask_xor(available_mask, allocated_mask,
-			    cpumask_of_node(numa_node));
-
 		target_cpu = cpumask_first(available_mask);
 		cpumask_set_cpu(target_cpu, allocated_mask);
 
@@ -778,7 +785,6 @@ static void init_vp_index(struct vmbus_channel *channel)
 	}
 
 	channel->target_cpu = target_cpu;
-
 	free_cpumask_var(available_mask);
 }
 
diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 714d549..547ae33 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -21,6 +21,7 @@
 #include <linux/kernel_stat.h>
 #include <linux/clockchips.h>
 #include <linux/cpu.h>
+#include <linux/sched/isolation.h>
 #include <linux/sched/task_stack.h>
 
 #include <linux/delay.h>
@@ -1770,6 +1771,9 @@ static ssize_t target_cpu_store(struct vmbus_channel *channel,
 	if (target_cpu >= nr_cpumask_bits)
 		return -EINVAL;
 
+	if (!cpumask_test_cpu(target_cpu, housekeeping_cpumask(HK_TYPE_MANAGED_IRQ)))
+		return -EINVAL;
+
 	/* No CPUs should come up or down during this. */
 	cpus_read_lock();
 
-- 
1.8.3.1

