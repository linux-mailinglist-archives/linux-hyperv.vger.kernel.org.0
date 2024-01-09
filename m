Return-Path: <linux-hyperv+bounces-1397-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B053828453
	for <lists+linux-hyperv@lfdr.de>; Tue,  9 Jan 2024 11:53:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09D3B287C94
	for <lists+linux-hyperv@lfdr.de>; Tue,  9 Jan 2024 10:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B4AB38DF8;
	Tue,  9 Jan 2024 10:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="YNAZu+v3"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25AE1381D6;
	Tue,  9 Jan 2024 10:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1099)
	id F252120B3CC2; Tue,  9 Jan 2024 02:51:35 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com F252120B3CC2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1704797496;
	bh=BjA1llB0tV0DNKtNQwDzCat1URmop7G8PpQu5Aagoj4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YNAZu+v3p4jhxsCl+dNOLV5ZCD7oKcv0KmwZforvUJgtpnAVrwmY5zXCykrDI7SM0
	 5qPsJwpcp8fMmt2KGvayIzMFDV2Je6kTsr9GFsBfsvnoLfUusVmBcZFAMofUQCNBcX
	 JnjYnZxDIfX/8zx/JP/KF/Zn1HLvqXAK+xcEjDPQ=
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
Subject: [PATCH 4/4 net-next] net: mana: Assigning IRQ affinity on HT cores
Date: Tue,  9 Jan 2024 02:51:18 -0800
Message-Id: <1704797478-32377-5-git-send-email-schakrabarti@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1704797478-32377-1-git-send-email-schakrabarti@linux.microsoft.com>
References: <1704797478-32377-1-git-send-email-schakrabarti@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Existing MANA design assigns IRQ to every CPU, including sibling
hyper-threads. This may cause multiple IRQs to be active simultaneously
in the same core and may reduce the network performance.

Improve the performance by assigning IRQ to non sibling CPUs in local
NUMA node. The performance improvement we are getting using ntttcp with
following patch is around 15 percent against existing design and
approximately 11 percent, when trying to assign one IRQ in each core
across NUMA nodes, if enough cores are present.

Signed-off-by: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
---
 .../net/ethernet/microsoft/mana/gdma_main.c   | 58 +++++++++++++++----
 1 file changed, 48 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/net/ethernet/microsoft/mana/gdma_main.c
index 6a967d6be01e..6715d6939bc7 100644
--- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
+++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
@@ -1274,13 +1274,16 @@ static __maybe_unused int irq_setup(unsigned int *irqs, unsigned int len, int no
 
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
 
@@ -1288,8 +1291,18 @@ static int mana_gd_setup_irqs(struct pci_dev *pdev)
 	max_irqs = max_queues_per_port + 1;
 
 	nvec = pci_alloc_irq_vectors(pdev, 2, max_irqs, PCI_IRQ_MSIX);
-	if (nvec < 0)
+	if (nvec < 0) {
+		cpus_read_unlock();
 		return nvec;
+	}
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
@@ -1316,21 +1329,44 @@ static int mana_gd_setup_irqs(struct pci_dev *pdev)
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
@@ -1343,8 +1379,10 @@ static int mana_gd_setup_irqs(struct pci_dev *pdev)
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


