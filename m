Return-Path: <linux-hyperv+bounces-1475-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ECB6883FE38
	for <lists+linux-hyperv@lfdr.de>; Mon, 29 Jan 2024 07:22:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64BE91F2111B
	for <lists+linux-hyperv@lfdr.de>; Mon, 29 Jan 2024 06:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BB4C4F1EB;
	Mon, 29 Jan 2024 06:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="k9AeTemi"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8C904CDE5;
	Mon, 29 Jan 2024 06:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706509295; cv=none; b=USEOFITGEwQU9B72fT7mNh6Nj8pvczRJXGjuxhku1Is07iIEzE7S+oyS1zaHuMx8p6os754yFwJHug+EgEjmSjEThquujSGzsPGGygmG34Uvvd+BXn+VZD7eX4O8rcNRq38bRls5kF0ZyvvxQs47R33oYVk0vn7wrz8NFoD30CE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706509295; c=relaxed/simple;
	bh=v9MDEJ1+0pMadpqw+Z8wm+0v+LwPNN7gls1lvIH64rw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=iSNhJ/O8uqXVuTaK3LkNm1EvslPDDzTBAkzYBmGxJ+CYVR8UjfjjbolyS1q00r6+ku/Uw+5/LzSMEaH3TNXTrykVJFLdcNXqoCDAyCtPzgPoB71LzGo5+J7wurPMSpjKFHFHrZN3bTB6HGCiaVUUYsg9/q8qYx/wHkVBXjHA50M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=k9AeTemi; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1099)
	id 48A0520E67C9; Sun, 28 Jan 2024 22:21:33 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 48A0520E67C9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1706509293;
	bh=1onNjZrx6dF0bIPOiAkazIzuK6UO0uUICqgy/1VAkLg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k9AeTemifJNcjNJk8+YBWpbkfIcUzKMQv3UJvACAgGqLSwxj39hanEgh+lzmuYYOu
	 xZ/ixO2ed3yOJhsQ4MaSQg/uqsS+yQm++RwYyeLj8/EA+/tLCmCJhmfB+FoI4baoJP
	 EuV3yNyATGCbdxtK7fRrZcR7J/T/10TEowtLdcUg=
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
Subject: [PATCH 4/4 V3 net-next] net: mana: Assigning IRQ affinity on HT cores
Date: Sun, 28 Jan 2024 22:21:07 -0800
Message-Id: <1706509267-17754-5-git-send-email-schakrabarti@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1706509267-17754-1-git-send-email-schakrabarti@linux.microsoft.com>
References: <1706509267-17754-1-git-send-email-schakrabarti@linux.microsoft.com>
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
The change will improve the performance for the system
with high number of CPU, where number of CPUs in a node is more than
64 CPUs. Nodes with 64 CPUs or less than 64 CPUs will not be affected
by this change.

The performance study was done using ntttcp tool in Azure.
The node had 2 nodes with 32 cores each, total 128 vCPU and number of channels
were 32 for 32 RX rings.

The below table shows a comparison between existing design and new
design:

IRQ   node-num    core-num   CPU        performance(%)
1      0 | 0       0 | 0     0 | 0-1     0
2      0 | 0       0 | 1     1 | 2-3     3
3      0 | 0       1 | 2     2 | 4-5     10
4      0 | 0       1 | 3     3 | 6-7     15
5      0 | 0       2 | 4     4 | 8-9     15
...
...
25     0 | 0       12| 24    24| 48-49   12
...
32     0 | 0       15| 31    31| 62-63   12
33     0 | 0       16| 0     32| 0-1     10
...
64     0 | 0       31| 31    63| 62-63   0

Signed-off-by: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
---
 .../net/ethernet/microsoft/mana/gdma_main.c   | 61 +++++++++++++++----
 1 file changed, 50 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/net/ethernet/microsoft/mana/gdma_main.c
index 05a0ac054823..1332db9a08eb 100644
--- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
+++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
@@ -1249,7 +1249,7 @@ void mana_gd_free_res_map(struct gdma_resource *r)
 	r->size = 0;
 }
 
-static __maybe_unused int irq_setup(unsigned int *irqs, unsigned int len, int node)
+static int irq_setup(unsigned int *irqs, unsigned int len, int node)
 {
 	const struct cpumask *next, *prev = cpu_none_mask;
 	cpumask_var_t cpus __free(free_cpumask_var);
@@ -1280,13 +1280,16 @@ static __maybe_unused int irq_setup(unsigned int *irqs, unsigned int len, int no
 
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
 
@@ -1294,8 +1297,18 @@ static int mana_gd_setup_irqs(struct pci_dev *pdev)
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
@@ -1323,17 +1336,41 @@ static int mana_gd_setup_irqs(struct pci_dev *pdev)
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
+
 	gc->max_num_msix = nvec;
 	gc->num_msix_usable = nvec;
-
+	cpus_read_unlock();
 	return 0;
 
 free_irq:
@@ -1346,8 +1383,10 @@ static int mana_gd_setup_irqs(struct pci_dev *pdev)
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


