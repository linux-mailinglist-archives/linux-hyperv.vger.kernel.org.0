Return-Path: <linux-hyperv+bounces-1185-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2454802D91
	for <lists+linux-hyperv@lfdr.de>; Mon,  4 Dec 2023 09:51:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E2E5280C88
	for <lists+linux-hyperv@lfdr.de>; Mon,  4 Dec 2023 08:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1524FBE8;
	Mon,  4 Dec 2023 08:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="FG72TTRU"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2981911F;
	Mon,  4 Dec 2023 00:50:53 -0800 (PST)
Received: by linux.microsoft.com (Postfix, from userid 1099)
	id 5F36D20B74C0; Mon,  4 Dec 2023 00:50:52 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5F36D20B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1701679852;
	bh=+82ZmFRWEGviEskvJhBjDw/CYlrBPi2B0lQ9asHWocA=;
	h=From:To:Cc:Subject:Date:From;
	b=FG72TTRUO8BK7F1aqqE2fnikQCMuZI4qTS0WgkBu4sSkEAW7yIXTzXy58+I+LBTMg
	 kkJKNVQUYwaUGWbUXEG3eVxLzPlSl5g2cR6R7R/aUrH39vl87fQSIIf0fb9NBflrZC
	 mzKhFP068KZ3yBveHtZl2aXbvLv1fLkEtkkui8kg=
From: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	longli@microsoft.com,
	yury.norov@gmail.com,
	leon@kernel.org,
	cai.huoqing@linux.dev,
	ssengar@linux.microsoft.com,
	vkuznets@redhat.com,
	tglx@linutronix.de,
	linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org
Cc: sch^Crabarti@microsoft.com,
	paulros@microsoft.com,
	Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
Subject: [PATCH V4 net-next] net: mana: Assigning IRQ affinity on HT cores
Date: Mon,  4 Dec 2023 00:50:41 -0800
Message-Id: <1701679841-9359-1-git-send-email-schakrabarti@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Existing MANA design assigns IRQ to every CPU, including sibling
hyper-threads. This may cause multiple IRQs to be active simultaneously
in the same core and may reduce the network performance with RSS.

Improve the performance by assigning IRQ to non sibling CPUs in local
NUMA node.

Signed-off-by: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
---
V3 -> V4:
* Used for_each_numa_hop_mask() macro and simplified the code.
Thanks to Yury Norov for the suggestion.
* Added code to assign hwc irq separately in mana_gd_setup_irqs.

V2 -> V3:
* Created a helper function to get the next NUMA with CPU.
* Added some error checks for unsuccessful memory allocation.
* Fixed some comments on the code.

V1 -> V2:
* Simplified the code by removing filter_mask_list and using avail_cpus.
* Addressed infinite loop issue when there are numa nodes with no CPUs.
* Addressed uses of local numa node instead of 0 to start.
* Removed uses of BUG_ON.
* Placed cpus_read_lock in parent function to avoid num_online_cpus
  to get changed before function finishes the affinity assignment.
---
 .../net/ethernet/microsoft/mana/gdma_main.c   | 70 +++++++++++++++++--
 1 file changed, 63 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/net/ethernet/microsoft/mana/gdma_main.c
index 6367de0c2c2e..2194a53cce10 100644
--- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
+++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
@@ -1243,15 +1243,57 @@ void mana_gd_free_res_map(struct gdma_resource *r)
 	r->size = 0;
 }
 
+static int irq_setup(int *irqs, int nvec, int start_numa_node)
+{
+	int i = 0, cpu, err = 0;
+	const struct cpumask *node_cpumask;
+	unsigned int  next_node = start_numa_node;
+	cpumask_var_t visited_cpus, node_cpumask_temp;
+
+	if (!zalloc_cpumask_var(&visited_cpus, GFP_KERNEL)) {
+		err = ENOMEM;
+		return err;
+	}
+	if (!zalloc_cpumask_var(&node_cpumask_temp, GFP_KERNEL)) {
+		err = -ENOMEM;
+		return err;
+	}
+	rcu_read_lock();
+	for_each_numa_hop_mask(node_cpumask, next_node) {
+		cpumask_copy(node_cpumask_temp, node_cpumask);
+		for_each_cpu(cpu, node_cpumask_temp) {
+			cpumask_andnot(node_cpumask_temp, node_cpumask_temp,
+				       topology_sibling_cpumask(cpu));
+			irq_set_affinity_and_hint(irqs[i], cpumask_of(cpu));
+			if (++i == nvec)
+				goto free_mask;
+			cpumask_set_cpu(cpu, visited_cpus);
+			if (cpumask_empty(node_cpumask_temp)) {
+				cpumask_copy(node_cpumask_temp, node_cpumask);
+				cpumask_andnot(node_cpumask_temp, node_cpumask_temp,
+					       visited_cpus);
+				cpu = 0;
+			}
+		}
+	}
+free_mask:
+	rcu_read_unlock();
+	free_cpumask_var(visited_cpus);
+	free_cpumask_var(node_cpumask_temp);
+	return err;
+}
+
 static int mana_gd_setup_irqs(struct pci_dev *pdev)
 {
-	unsigned int max_queues_per_port = num_online_cpus();
 	struct gdma_context *gc = pci_get_drvdata(pdev);
+	unsigned int max_queues_per_port;
 	struct gdma_irq_context *gic;
 	unsigned int max_irqs, cpu;
-	int nvec, irq;
+	int nvec, *irqs, irq;
 	int err, i = 0, j;
 
+	cpus_read_lock();
+	max_queues_per_port = num_online_cpus();
 	if (max_queues_per_port > MANA_MAX_NUM_QUEUES)
 		max_queues_per_port = MANA_MAX_NUM_QUEUES;
 
@@ -1261,6 +1303,11 @@ static int mana_gd_setup_irqs(struct pci_dev *pdev)
 	nvec = pci_alloc_irq_vectors(pdev, 2, max_irqs, PCI_IRQ_MSIX);
 	if (nvec < 0)
 		return nvec;
+	irqs = kmalloc_array(max_queues_per_port, sizeof(int), GFP_KERNEL);
+	if (!irqs) {
+		err = -ENOMEM;
+		goto free_irq_vector;
+	}
 
 	gc->irq_contexts = kcalloc(nvec, sizeof(struct gdma_irq_context),
 				   GFP_KERNEL);
@@ -1287,21 +1334,28 @@ static int mana_gd_setup_irqs(struct pci_dev *pdev)
 			goto free_irq;
 		}
 
-		err = request_irq(irq, mana_gd_intr, 0, gic->name, gic);
+		if (!i) {
+			err = request_irq(irq, mana_gd_intr, 0, gic->name, gic);
+			cpu = cpumask_local_spread(i, gc->numa_node);
+			irq_set_affinity_and_hint(irq, cpumask_of(cpu));
+		} else {
+			irqs[i - 1] = irq;
+			err = request_irq(irqs[i - 1], mana_gd_intr, 0, gic->name, gic);
+		}
 		if (err)
 			goto free_irq;
-
-		cpu = cpumask_local_spread(i, gc->numa_node);
-		irq_set_affinity_and_hint(irq, cpumask_of(cpu));
 	}
 
+	err = irq_setup(irqs, max_queues_per_port, gc->numa_node);
+	if (err)
+		goto free_irq;
 	err = mana_gd_alloc_res_map(nvec, &gc->msix_resource);
 	if (err)
 		goto free_irq;
 
 	gc->max_num_msix = nvec;
 	gc->num_msix_usable = nvec;
-
+	cpus_read_unlock();
 	return 0;
 
 free_irq:
@@ -1314,8 +1368,10 @@ static int mana_gd_setup_irqs(struct pci_dev *pdev)
 	}
 
 	kfree(gc->irq_contexts);
+	kfree(irqs);
 	gc->irq_contexts = NULL;
 free_irq_vector:
+	cpus_read_unlock();
 	pci_free_irq_vectors(pdev);
 	return err;
 }
-- 
2.34.1


