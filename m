Return-Path: <linux-hyperv+bounces-1293-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 307FA80A02C
	for <lists+linux-hyperv@lfdr.de>; Fri,  8 Dec 2023 11:02:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA5C1B20B2F
	for <lists+linux-hyperv@lfdr.de>; Fri,  8 Dec 2023 10:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 831BF12B9D;
	Fri,  8 Dec 2023 10:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="b76OthSm"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0F7E5D5B;
	Fri,  8 Dec 2023 02:02:40 -0800 (PST)
Received: by linux.microsoft.com (Postfix, from userid 1099)
	id E473F20B74C0; Fri,  8 Dec 2023 02:02:38 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E473F20B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1702029758;
	bh=bC0rZPUj3vdJkI+4wJKSoDBmkdXIOKDY9tHt0bJ5YcM=;
	h=From:To:Cc:Subject:Date:From;
	b=b76OthSm/w/9rCAyVWtY2zPWMN2U/BUue3Vv1sIOluxb3aK0za+esDZ+NuwOYvc1E
	 5deAKd+RE7PEQ5EH09pP4IyHiT+UhGmsiqD1BJYjjve7c2OdUTj0bsvlosi88i5MV8
	 55z8pbrbuCRq7XxNRNiNFoGgJpIQPwcdbimD/VWI=
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
Cc: schakrabarti@microsoft.com,
	paulros@microsoft.com,
	Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
Subject: [PATCH V5 net-next] net: mana: Assigning IRQ affinity on HT cores
Date: Fri,  8 Dec 2023 02:02:34 -0800
Message-Id: <1702029754-6520-1-git-send-email-schakrabarti@linux.microsoft.com>
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
NUMA node. The performance improvement we are getting using ntttcp with
following patch is around 15 percent with existing design and approximately
11 percent, when trying to assign one IRQ in each core across NUMA nodes,
if enough cores are present.

Suggested-by: Yury Norov <yury.norov@gmali.com>
Signed-off-by: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
---
V4 -> V5:
* Fixed use of for_each_numa_hop_mask in irq_setup, by using
visited_cpus to mask previous node mask.
* Changed the way IRQ0 is gettng assigned, to assign it a
separate CPU if possible rather than assigning it to a already
assigned CPU.
* Added Suggested-by tag.

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
 .../net/ethernet/microsoft/mana/gdma_main.c   | 92 +++++++++++++++++--
 1 file changed, 83 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/net/ethernet/microsoft/mana/gdma_main.c
index 6367de0c2c2e..18e8908c5d29 100644
--- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
+++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
@@ -1243,15 +1243,56 @@ void mana_gd_free_res_map(struct gdma_resource *r)
 	r->size = 0;
 }
 
+static int irq_setup(int *irqs, int nvec, int start_numa_node)
+{
+	int w, cnt, cpu, err = 0, i = 0;
+	int next_node = start_numa_node;
+	const struct cpumask *next, *prev = cpu_none_mask;
+	cpumask_var_t curr, cpus;
+
+	if (!zalloc_cpumask_var(&curr, GFP_KERNEL)) {
+		err = -ENOMEM;
+		return err;
+	}
+	if (!zalloc_cpumask_var(&cpus, GFP_KERNEL)) {
+		err = -ENOMEM;
+		return err;
+	}
+
+	rcu_read_lock();
+	for_each_numa_hop_mask(next, next_node) {
+		cpumask_andnot(curr, next, prev);
+		for (w = cpumask_weight(curr), cnt = 0; cnt < w; ) {
+			cpumask_copy(cpus, curr);
+			for_each_cpu(cpu, cpus) {
+				irq_set_affinity_and_hint(irqs[i], topology_sibling_cpumask(cpu));
+				if (++i == nvec)
+					goto done;
+				cpumask_andnot(cpus, cpus, topology_sibling_cpumask(cpu));
+				++cnt;
+			}
+		}
+		prev = next;
+	}
+done:
+	rcu_read_unlock();
+	free_cpumask_var(curr);
+	free_cpumask_var(cpus);
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
+	int start_irq_index = 1;
+	int nvec, *irqs, irq;
 	int err, i = 0, j;
 
+	cpus_read_lock();
+	max_queues_per_port = num_online_cpus();
 	if (max_queues_per_port > MANA_MAX_NUM_QUEUES)
 		max_queues_per_port = MANA_MAX_NUM_QUEUES;
 
@@ -1261,6 +1302,14 @@ static int mana_gd_setup_irqs(struct pci_dev *pdev)
 	nvec = pci_alloc_irq_vectors(pdev, 2, max_irqs, PCI_IRQ_MSIX);
 	if (nvec < 0)
 		return nvec;
+	if (nvec <= num_online_cpus())
+		start_irq_index = 0;
+
+	irqs = kmalloc_array((nvec - start_irq_index), sizeof(int), GFP_KERNEL);
+	if (!irqs) {
+		err = -ENOMEM;
+		goto free_irq_vector;
+	}
 
 	gc->irq_contexts = kcalloc(nvec, sizeof(struct gdma_irq_context),
 				   GFP_KERNEL);
@@ -1287,21 +1336,44 @@ static int mana_gd_setup_irqs(struct pci_dev *pdev)
 			goto free_irq;
 		}
 
-		err = request_irq(irq, mana_gd_intr, 0, gic->name, gic);
-		if (err)
-			goto free_irq;
-
-		cpu = cpumask_local_spread(i, gc->numa_node);
-		irq_set_affinity_and_hint(irq, cpumask_of(cpu));
+		if (!i) {
+			err = request_irq(irq, mana_gd_intr, 0, gic->name, gic);
+			if (err)
+				goto free_irq;
+
+			/* If number of IRQ is one extra than number of online CPUs,
+			 * then we need to assign IRQ0 (hwc irq) and IRQ1 to
+			 * same CPU.
+			 * Else we will use different CPUs for IRQ0 and IRQ1.
+			 * Also we are using cpumask_local_spread instead of
+			 * cpumask_first for the node, because the node can be
+			 * mem only.
+			 */
+			if (start_irq_index) {
+				cpu = cpumask_local_spread(i, gc->numa_node);
+				irq_set_affinity_and_hint(irq, cpumask_of(cpu));
+			} else {
+				irqs[start_irq_index] = irq;
+			}
+		} else {
+			irqs[i - start_irq_index] = irq;
+			err = request_irq(irqs[i - start_irq_index], mana_gd_intr, 0,
+					  gic->name, gic);
+			if (err)
+				goto free_irq;
+		}
 	}
 
+	err = irq_setup(irqs, (nvec - start_irq_index), gc->numa_node);
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
@@ -1314,8 +1386,10 @@ static int mana_gd_setup_irqs(struct pci_dev *pdev)
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


