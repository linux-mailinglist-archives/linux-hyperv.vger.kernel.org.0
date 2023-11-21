Return-Path: <linux-hyperv+bounces-1000-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 598367F2FE2
	for <lists+linux-hyperv@lfdr.de>; Tue, 21 Nov 2023 14:54:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E8151F244EF
	for <lists+linux-hyperv@lfdr.de>; Tue, 21 Nov 2023 13:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E57053818;
	Tue, 21 Nov 2023 13:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="F4nAeQAd"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1554CD6A;
	Tue, 21 Nov 2023 05:54:39 -0800 (PST)
Received: by linux.microsoft.com (Postfix, from userid 1099)
	id 72E1520B74C0; Tue, 21 Nov 2023 05:54:38 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 72E1520B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1700574878;
	bh=4d/Tj40I/q17k+/4xRhGk5Qv/cyNpSEcakEe1Oqoli0=;
	h=From:To:Cc:Subject:Date:From;
	b=F4nAeQAd5kyOcVSyw99btyLgSRxMu13uOqYGPWIWoERH9t4JBazZb6wjLfuc1OScB
	 eRMnIe0A3w5npnpV3XgO2YfH+R++1Yyq8bQ7RJAz//olGn/UoXNdnhCeRSE4v6QM2R
	 5UxTz7+VHkfPQ3jesFSw1IKiQfkJfCUNzj+utm/Q=
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
	sharmaajay@microsoft.com,
	leon@kernel.org,
	cai.huoqing@linux.dev,
	ssengar@linux.microsoft.com,
	vkuznets@redhat.com,
	tglx@linutronix.de,
	linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org
Cc: schakrabarti@microsoft.com,
	paulros@microsoft.com,
	Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
Subject: [PATCH V2 net-next] net: mana: Assigning IRQ affinity on HT cores
Date: Tue, 21 Nov 2023 05:54:37 -0800
Message-Id: <1700574877-6037-1-git-send-email-schakrabarti@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Existing MANA design assigns IRQ to every CPUs, including sibling hyper-threads
in a core. This causes multiple IRQs to work on same CPU and may reduce the network
performance with RSS.

Improve the performance by adhering the configuration for RSS, which assigns IRQ
on HT cores.

Signed-off-by: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
---
V1 -> V2:
* Simplified the code by removing filter_mask_list and using avail_cpus.
* Addressed infinite loop issue when there are numa nodes with no CPUs.
* Addressed uses of local numa node instead of 0 to start.
* Removed uses of BUG_ON.
* Placed cpus_read_lock in parent function to avoid num_online_cpus
  to get changed before function finishes the affinity assignment.
---
 .../net/ethernet/microsoft/mana/gdma_main.c   | 134 ++++++++++++++++--
 1 file changed, 123 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/net/ethernet/microsoft/mana/gdma_main.c
index 6367de0c2c2e..8177502ffbd9 100644
--- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
+++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
@@ -1243,15 +1243,120 @@ void mana_gd_free_res_map(struct gdma_resource *r)
 	r->size = 0;
 }
 
+static int irq_setup(int *irqs, int nvec, int start_numa_node)
+{
+	unsigned int *core_id_list;
+	cpumask_var_t filter_mask, avail_cpus;
+	int i, core_count = 0, cpu_count = 0, err = 0, node_count = 0;
+	unsigned int cpu_first, cpu, irq_start, cores = 0, numa_node = start_numa_node;
+
+	if(!alloc_cpumask_var(&filter_mask, GFP_KERNEL)
+			     || !alloc_cpumask_var(&avail_cpus, GFP_KERNEL)) {
+		err = -ENOMEM;
+		goto free_irq;
+	}
+	cpumask_copy(filter_mask, cpu_online_mask);
+	cpumask_copy(avail_cpus, cpu_online_mask);
+	/* count the number of cores
+	 */
+	for_each_cpu(cpu, filter_mask) {
+		cpumask_andnot(filter_mask, filter_mask, topology_sibling_cpumask(cpu));
+		cores++;
+	}
+	core_id_list = kcalloc(cores, sizeof(unsigned int), GFP_KERNEL);
+	cpumask_copy(filter_mask, cpu_online_mask);
+	/* initialize core_id_list array */
+	for_each_cpu(cpu, filter_mask) {
+		core_id_list[core_count] = cpu;
+		cpumask_andnot(filter_mask, filter_mask, topology_sibling_cpumask(cpu));
+		core_count++;
+	}
+
+	/* if number of cpus are equal to max_queues per port, then
+	 * one extra interrupt for the hardware channel communication.
+	 */
+	if (nvec - 1 == num_online_cpus()) {
+		irq_start = 1;
+		cpu_first = cpumask_first(cpu_online_mask);
+		irq_set_affinity_and_hint(irqs[0], cpumask_of(cpu_first));
+	} else {
+		irq_start = 0;
+	}
+
+	/* reset the core_count and num_node to 0.
+	 */
+	core_count = 0;
+
+	/* for each interrupt find the cpu of a particular
+	 * sibling set and if it belongs to the specific numa
+	 * then assign irq to it and clear the cpu bit from
+	 * the corresponding avail_cpus.
+	 * Increase the cpu_count for that node.
+	 * Once all cpus for a numa node is assigned, then
+	 * move to different numa node and continue the same.
+	 */
+	for (i = irq_start; i < nvec; ) {
+
+		/* check if the numa node has cpu or not
+		 * to avoid infinite loop.
+		 */
+		if (cpumask_empty(cpumask_of_node(numa_node))) {
+			numa_node++;
+			if (++node_count == num_online_nodes()) {
+				err = -EAGAIN;
+				goto free_irq;
+			}
+		}
+		cpu_first = cpumask_first_and(avail_cpus,
+					     topology_sibling_cpumask(core_id_list[core_count]));
+		if (cpu_first < nr_cpu_ids && cpu_to_node(cpu_first) == numa_node) {
+			irq_set_affinity_and_hint(irqs[i], cpumask_of(cpu_first));
+			cpumask_clear_cpu(cpu_first, avail_cpus);
+			cpu_count = cpu_count + 1;
+			i = i + 1;
+
+			/* checking if all the cpus are used from the
+			 * particular node.
+			 */
+			if (cpu_count == nr_cpus_node(numa_node)) {
+				numa_node = numa_node + 1;
+				if (numa_node == num_online_nodes())
+					numa_node = 0;
+
+				/* wrap around once numa nodes
+				 * are traversed.
+				 */
+				if (numa_node == start_numa_node) {
+					node_count = 0;
+					cpumask_copy(avail_cpus, cpu_online_mask);
+				}
+				cpu_count = 0;
+				core_count = 0;
+				continue;
+			}
+		}
+		if (++core_count == cores)
+			core_count = 0;
+	}
+free_irq:
+	free_cpumask_var(filter_mask);
+	free_cpumask_var(avail_cpus);
+	if (core_id_list)
+		kfree(core_id_list);
+	return err;
+}
+
 static int mana_gd_setup_irqs(struct pci_dev *pdev)
 {
-	unsigned int max_queues_per_port = num_online_cpus();
+	unsigned int max_queues_per_port;
 	struct gdma_context *gc = pci_get_drvdata(pdev);
 	struct gdma_irq_context *gic;
-	unsigned int max_irqs, cpu;
-	int nvec, irq;
+	unsigned int max_irqs;
+	int nvec, *irqs, irq;
 	int err, i = 0, j;
 
+	cpus_read_lock();
+	max_queues_per_port = num_online_cpus();
 	if (max_queues_per_port > MANA_MAX_NUM_QUEUES)
 		max_queues_per_port = MANA_MAX_NUM_QUEUES;
 
@@ -1261,6 +1366,11 @@ static int mana_gd_setup_irqs(struct pci_dev *pdev)
 	nvec = pci_alloc_irq_vectors(pdev, 2, max_irqs, PCI_IRQ_MSIX);
 	if (nvec < 0)
 		return nvec;
+	irqs = kmalloc_array(nvec, sizeof(int), GFP_KERNEL);
+	if (!irqs) {
+		err = -ENOMEM;
+		goto free_irq_vector;
+	}
 
 	gc->irq_contexts = kcalloc(nvec, sizeof(struct gdma_irq_context),
 				   GFP_KERNEL);
@@ -1281,27 +1391,27 @@ static int mana_gd_setup_irqs(struct pci_dev *pdev)
 			snprintf(gic->name, MANA_IRQ_NAME_SZ, "mana_q%d@pci:%s",
 				 i - 1, pci_name(pdev));
 
-		irq = pci_irq_vector(pdev, i);
-		if (irq < 0) {
-			err = irq;
+		irqs[i] = pci_irq_vector(pdev, i);
+		if (irqs[i] < 0) {
+			err = irqs[i];
 			goto free_irq;
 		}
 
-		err = request_irq(irq, mana_gd_intr, 0, gic->name, gic);
+		err = request_irq(irqs[i], mana_gd_intr, 0, gic->name, gic);
 		if (err)
 			goto free_irq;
-
-		cpu = cpumask_local_spread(i, gc->numa_node);
-		irq_set_affinity_and_hint(irq, cpumask_of(cpu));
 	}
 
+	err = irq_setup(irqs, nvec, gc->numa_node);
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
@@ -1314,8 +1424,10 @@ static int mana_gd_setup_irqs(struct pci_dev *pdev)
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


