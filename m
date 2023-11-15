Return-Path: <linux-hyperv+bounces-937-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86D937EC411
	for <lists+linux-hyperv@lfdr.de>; Wed, 15 Nov 2023 14:49:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A9AFB20AAA
	for <lists+linux-hyperv@lfdr.de>; Wed, 15 Nov 2023 13:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DE391EB3F;
	Wed, 15 Nov 2023 13:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="A3ku9EjR"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9533179AC;
	Wed, 15 Nov 2023 13:49:04 +0000 (UTC)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 396ECAC;
	Wed, 15 Nov 2023 05:49:03 -0800 (PST)
Received: by linux.microsoft.com (Postfix, from userid 1099)
	id A779420B74C1; Wed, 15 Nov 2023 05:49:02 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A779420B74C1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1700056142;
	bh=6bm+G+2Har0LNkfawvlVKFLAqfQ3KYMWeofqY6dFb2o=;
	h=From:To:Cc:Subject:Date:From;
	b=A3ku9EjRqyGx9ZmVJgN5tBccal2hOoVgWTxA4gsPfgo4V14RrsGMkp5wUovzA1a1p
	 hrzJPr3fIGjfPN4Z427qL8K/U6IMadBHXfaciuHRSzwa3qfh0R1H6oHixCHPiEURwO
	 2IJlAvMaj1IbFM8NCOSV3lOYfxCxE0YCtNaq393c=
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
Subject: [PATCH net-next] net: mana: Assigning IRQ affinity on HT cores
Date: Wed, 15 Nov 2023 05:48:45 -0800
Message-Id: <1700056125-29358-1-git-send-email-schakrabarti@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Existing MANA design assigns IRQ affinity to every sibling CPUs, which causes
IRQ coalescing and may reduce the network performance with RSS.

Improve the performance by adhering the configuration for RSS, which prioritise
IRQ affinity on HT cores.

Signed-off-by: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
---
 .../net/ethernet/microsoft/mana/gdma_main.c   | 126 ++++++++++++++++--
 1 file changed, 117 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/net/ethernet/microsoft/mana/gdma_main.c
index 6367de0c2c2e..839be819d46e 100644
--- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
+++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
@@ -1243,13 +1243,115 @@ void mana_gd_free_res_map(struct gdma_resource *r)
 	r->size = 0;
 }
 
+static void cpu_mask_set(cpumask_var_t *filter_mask, cpumask_var_t **filter_mask_list)
+{
+	unsigned int core_count = 0, cpu;
+	cpumask_var_t *filter_mask_list_tmp;
+
+	BUG_ON(!filter_mask || !filter_mask_list);
+	filter_mask_list_tmp = *filter_mask_list;
+	cpumask_copy(*filter_mask, cpu_online_mask);
+	/* for each core create a cpumask lookup table,
+	 * which stores all the corresponding siblings
+	 */
+	for_each_cpu(cpu, *filter_mask) {
+		BUG_ON(!alloc_cpumask_var(&filter_mask_list_tmp[core_count], GFP_KERNEL));
+		cpumask_or(filter_mask_list_tmp[core_count], filter_mask_list_tmp[core_count],
+			   topology_sibling_cpumask(cpu));
+		cpumask_andnot(*filter_mask, *filter_mask, topology_sibling_cpumask(cpu));
+		core_count++;
+	}
+}
+
+static int irq_setup(int *irqs, int nvec)
+{
+	cpumask_var_t filter_mask;
+	cpumask_var_t *filter_mask_list;
+	unsigned int cpu_first, cpu, irq_start, cores = 0;
+	int i, core_count = 0, numa_node, cpu_count = 0, err = 0;
+
+	BUG_ON(!alloc_cpumask_var(&filter_mask, GFP_KERNEL));
+	cpus_read_lock();
+	cpumask_copy(filter_mask, cpu_online_mask);
+	/* count the number of cores
+	 */
+	for_each_cpu(cpu, filter_mask) {
+		cpumask_andnot(filter_mask, filter_mask, topology_sibling_cpumask(cpu));
+		cores++;
+	}
+	filter_mask_list = kcalloc(cores, sizeof(cpumask_var_t), GFP_KERNEL);
+	if (!filter_mask_list) {
+		err = -ENOMEM;
+		goto free_irq;
+	}
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
+	/* reset the core_count and num_node to 0.
+	 */
+	core_count = 0;
+	numa_node = 0;
+	cpu_mask_set(&filter_mask, &filter_mask_list);
+	/* for each interrupt find the cpu of a particular
+	 * sibling set and if it belongs to the specific numa
+	 * then assign irq to it and clear the cpu bit from
+	 * the corresponding sibling list from filter_mask_list.
+	 * Increase the cpu_count for that node.
+	 * Once all cpus for a numa node is assigned, then
+	 * move to different numa node and continue the same.
+	 */
+	for (i = irq_start; i < nvec; ) {
+		cpu_first = cpumask_first(filter_mask_list[core_count]);
+		if (cpu_first < nr_cpu_ids && cpu_to_node(cpu_first) == numa_node) {
+			irq_set_affinity_and_hint(irqs[i], cpumask_of(cpu_first));
+			cpumask_clear_cpu(cpu_first, filter_mask_list[core_count]);
+			cpu_count = cpu_count + 1;
+			i = i + 1;
+			/* checking if all the cpus are used from the
+			 * particular node.
+			 */
+			if (cpu_count == nr_cpus_node(numa_node)) {
+				numa_node = numa_node + 1;
+				if (numa_node == num_online_nodes()) {
+					cpu_mask_set(&filter_mask, &filter_mask_list);
+					numa_node = 0;
+				}
+				cpu_count = 0;
+				core_count = 0;
+				continue;
+			}
+		}
+		if ((core_count + 1) % cores == 0)
+			core_count = 0;
+		else
+			core_count++;
+	}
+free_irq:
+	cpus_read_unlock();
+	if (filter_mask)
+		free_cpumask_var(filter_mask);
+	if (filter_mask_list) {
+		for (core_count = 0; core_count < cores; core_count++)
+			free_cpumask_var(filter_mask_list[core_count]);
+		kfree(filter_mask_list);
+	}
+	return err;
+}
+
 static int mana_gd_setup_irqs(struct pci_dev *pdev)
 {
 	unsigned int max_queues_per_port = num_online_cpus();
 	struct gdma_context *gc = pci_get_drvdata(pdev);
 	struct gdma_irq_context *gic;
-	unsigned int max_irqs, cpu;
-	int nvec, irq;
+	unsigned int max_irqs;
+	int nvec, *irqs, irq;
 	int err, i = 0, j;
 
 	if (max_queues_per_port > MANA_MAX_NUM_QUEUES)
@@ -1261,6 +1363,11 @@ static int mana_gd_setup_irqs(struct pci_dev *pdev)
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
@@ -1281,20 +1388,20 @@ static int mana_gd_setup_irqs(struct pci_dev *pdev)
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
 
+	err = irq_setup(irqs, nvec);
+	if (err)
+		goto free_irq;
 	err = mana_gd_alloc_res_map(nvec, &gc->msix_resource);
 	if (err)
 		goto free_irq;
@@ -1314,6 +1421,7 @@ static int mana_gd_setup_irqs(struct pci_dev *pdev)
 	}
 
 	kfree(gc->irq_contexts);
+	kfree(irqs);
 	gc->irq_contexts = NULL;
 free_irq_vector:
 	pci_free_irq_vectors(pdev);
-- 
2.34.1


