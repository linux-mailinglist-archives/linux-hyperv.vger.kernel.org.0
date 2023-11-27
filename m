Return-Path: <linux-hyperv+bounces-1055-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C9DE7F9C90
	for <lists+linux-hyperv@lfdr.de>; Mon, 27 Nov 2023 10:26:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF3931C209E5
	for <lists+linux-hyperv@lfdr.de>; Mon, 27 Nov 2023 09:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08DBA14019;
	Mon, 27 Nov 2023 09:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="YnKwzUy8"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id C0091DE;
	Mon, 27 Nov 2023 01:26:49 -0800 (PST)
Received: by linux.microsoft.com (Postfix, from userid 1099)
	id 0B1B520B74C0; Mon, 27 Nov 2023 01:26:49 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0B1B520B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1701077209;
	bh=CXa+pQAY5zM7MRK1gwoEZLNegN/qEAHbIjHkHfnfIeg=;
	h=From:To:Cc:Subject:Date:From;
	b=YnKwzUy8oaVpHGb0ARR8EKi1DCQwnqZ6lJbeiP2+EHyrhO2hhJyC1x4yKrOUYmwa6
	 ijWqQU1cKSddy901DfMlagZVBEWxskA38q47Dpt1ZVbz8UNG+cA4Ro8hx4fezMkGU6
	 JOQYO+36R8wR9XDClwk7CyO+1112eP4Le5l6Fy8k=
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
Subject: [PATCH V3 net-next] net: mana: Assigning IRQ affinity on HT cores
Date: Mon, 27 Nov 2023 01:26:47 -0800
Message-Id: <1701077207-15541-1-git-send-email-schakrabarti@linux.microsoft.com>
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
 .../net/ethernet/microsoft/mana/gdma_main.c   | 158 ++++++++++++++++--
 1 file changed, 147 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/net/ethernet/microsoft/mana/gdma_main.c
index 6367de0c2c2e..18b733c27130 100644
--- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
+++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
@@ -1243,15 +1243,144 @@ void mana_gd_free_res_map(struct gdma_resource *r)
 	r->size = 0;
 }
 
+static int get_node_with_cpu(int node, int *cpu_count)
+{
+	int next_node = node;
+	int node_cpu_count = nr_cpus_node(node);
+
+#if MAX_NUMNODES > 1
+	if (!node_cpu_count || *cpu_count == node_cpu_count) {
+		next_node = next_online_node(next_node);
+		while (next_node <= MAX_NUMNODES) {
+			if (next_node == MAX_NUMNODES)
+				next_node = first_online_node;
+			if (nr_cpus_node(next_node))
+				break;
+			next_node = next_online_node(next_node);
+		}
+		*cpu_count = 0;
+	}
+	return next_node;
+#endif
+	if (nr_cpus_node(next_node))
+		return next_node;
+	return NUMA_NO_NODE;
+}
+
+static int irq_setup(int *irqs, int nvec, int start_numa_node)
+{
+	int *core_id_list;
+	cpumask_var_t avail_cpus;
+	int i, cpu, cpu_first, core_count = 0, cpu_count = 0, err = 0;
+	int irq_start, cores = 0, numa_node = start_numa_node, real_start_node;
+
+	if (!nr_cpus_node(start_numa_node))
+		return -ENODEV;
+
+	if (!alloc_cpumask_var(&avail_cpus, GFP_KERNEL)) {
+		err = -ENOMEM;
+		goto free_irq;
+	}
+	cpumask_copy(avail_cpus, cpu_online_mask);
+	/* count the number of cores
+	 */
+	for_each_cpu(cpu, avail_cpus) {
+		cpumask_andnot(avail_cpus, avail_cpus, topology_sibling_cpumask(cpu));
+		cores++;
+	}
+	core_id_list = kcalloc(cores, sizeof(unsigned int), GFP_KERNEL);
+	if (!core_id_list) {
+		err = -ENOMEM;
+		goto free_irq;
+	}
+	cpumask_copy(avail_cpus, cpu_online_mask);
+	/* initialize core_id_list array */
+	for_each_cpu(cpu, avail_cpus) {
+		core_id_list[core_count] = cpu;
+		cpumask_andnot(avail_cpus, avail_cpus, topology_sibling_cpumask(cpu));
+		core_count++;
+	}
+
+	cpumask_copy(avail_cpus, cpu_online_mask);
+
+	/* if number of cpus are equal to max_queues per port, then
+	 * irqs[0] which is used for hardware channel communication,
+	 * is treated differently and is assigned to first CPU.
+	 */
+	if (nvec - 1 == num_online_cpus()) {
+		irq_start = 1;
+		cpu_first = cpumask_first(cpu_online_mask);
+		irq_set_affinity_and_hint(irqs[0], cpumask_of(cpu_first));
+	} else {
+		irq_start = 0;
+	}
+
+	/* reset the core_count to reuse.
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
+	numa_node = get_node_with_cpu(numa_node, &cpu_count);
+	real_start_node = numa_node;
+	for (i = irq_start; i < nvec; ) {
+		/* check if the numa node has cpu or not
+		 * to avoid infinite loop.
+		 */
+		cpu_first = cpumask_first_and(avail_cpus,
+					      topology_sibling_cpumask(core_id_list[core_count]));
+		if (cpu_first < nr_cpu_ids && cpu_to_node(cpu_first) == numa_node) {
+			irq_set_affinity_and_hint(irqs[i], cpumask_of(cpu_first));
+			cpumask_clear_cpu(cpu_first, avail_cpus);
+			cpu_count++;
+			i++;
+			/* Get the new numa node based on cpu_count
+			 */
+			numa_node = get_node_with_cpu(numa_node, &cpu_count);
+			if (numa_node == NUMA_NO_NODE) {
+				err = -ENODEV;
+				goto free_core_id_list;
+			}
+			/* wrap over if the numa_node is the starting node
+			 */
+			if (numa_node == real_start_node)
+				cpumask_copy(avail_cpus, cpu_online_mask);
+
+			/* change of numa node, changes cpu_count to 0, change the core count
+			 * to 0 based on that.
+			 */
+			if (!cpu_count) {
+				core_count = 0;
+				continue;
+			}
+		}
+		if (++core_count == cores)
+			core_count = 0;
+	}
+free_core_id_list:
+	kfree(core_id_list);
+free_irq:
+	free_cpumask_var(avail_cpus);
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
 
@@ -1261,6 +1390,11 @@ static int mana_gd_setup_irqs(struct pci_dev *pdev)
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
@@ -1281,27 +1415,27 @@ static int mana_gd_setup_irqs(struct pci_dev *pdev)
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
@@ -1314,8 +1448,10 @@ static int mana_gd_setup_irqs(struct pci_dev *pdev)
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


