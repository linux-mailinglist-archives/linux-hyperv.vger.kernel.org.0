Return-Path: <linux-hyperv+bounces-5444-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40765AB1043
	for <lists+linux-hyperv@lfdr.de>; Fri,  9 May 2025 12:16:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52311A05B04
	for <lists+linux-hyperv@lfdr.de>; Fri,  9 May 2025 10:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 994A128F957;
	Fri,  9 May 2025 10:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="SBTI+6qT"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7678C28F51D;
	Fri,  9 May 2025 10:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746785642; cv=none; b=NYyj3dSbLhL7O4K/Mw021M8OcafcFyxX5k0IV4OXE4jAZEJIM7G+Jp/aNvq6YBe8732nCsbWyLj+5fD75corWxj+Tr6ntd/49XYxCCj2i8b1ZOeW8SjeRjiGrMYo9ZhuoYyZNZnEtA21zQbN7ukZ8OfNMP5zvL+YPbOaLPsBKeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746785642; c=relaxed/simple;
	bh=dj2bntkdl7xEPsU3O8kNrVVqiaY9ql9KfTEsUCfgmbQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=D5zuVj1Zn6vgiL6/HloNpDrO3s8RNRDJELlUIkoja9Gltw4VByjlILPA3fsedwarG4ziR74nPRrfjj0PXiZpiMseK/FBbcPKHtmml2HhG9mq80CtoqundJvBPbcQL57+fNZO/6YkqiRDi3CugEeE7Wa6VtQ5BuDQE4dDwmWYvKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=SBTI+6qT; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1134)
	id 091A92098462; Fri,  9 May 2025 03:13:59 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 091A92098462
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1746785639;
	bh=j0hv02lMNf3ygxb/Gu2IuZyCzEMjtz+gbRdiT+OLPPg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SBTI+6qThlS97fRCryGco2kspD3TzuiKHPkm152kXMIQstFup7tonhUeWdp8Wi8aj
	 xUNjTJoXgr07lzcMF02GNOND9ijoXfFJq6Bup6omNO6Yw6pGDpEifn/mO82NORbeAm
	 M92uanuJVaxYNsY8rO++MsuOlwiXB0gCOx27044w=
From: Shradha Gupta <shradhagupta@linux.microsoft.com>
To: Dexuan Cui <decui@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	Simon Horman <horms@kernel.org>,
	Leon Romanovsky <leon@kernel.org>,
	Maxim Levitsky <mlevitsk@redhat.com>,
	Erni Sri Satya Vennela <ernis@linux.microsoft.com>,
	Peter Zijlstra <peterz@infradead.org>
Cc: Shradha Gupta <shradhagupta@linux.microsoft.com>,
	linux-hyperv@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nipun Gupta <nipun.gupta@amd.com>,
	Yury Norov <yury.norov@gmail.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Jonathan Cameron <Jonathan.Cameron@huwei.com>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Kevin Tian <kevin.tian@intel.com>,
	Long Li <longli@microsoft.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Rob Herring <robh@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=EF=BF=BD=7EDski?= <kw@linux.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	Paul Rosswurm <paulros@microsoft.com>,
	Shradha Gupta <shradhagupta@microsoft.com>
Subject: [PATCH v3 4/4] net: mana: Allocate MSI-X vectors dynamically
Date: Fri,  9 May 2025 03:13:57 -0700
Message-Id: <1746785637-4881-1-git-send-email-shradhagupta@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1746785566-4337-1-git-send-email-shradhagupta@linux.microsoft.com>
References: <1746785566-4337-1-git-send-email-shradhagupta@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Currently, the MANA driver allocates MSI-X vectors statically based on
MANA_MAX_NUM_QUEUES and num_online_cpus() values and in some cases ends
up allocating more vectors than it needs. This is because, by this time
we do not have a HW channel and do not know how many IRQs should be
allocated.

To avoid this, we allocate 1 MSI-X vector during the creation of HWC and
after getting the value supported by hardware, dynamically add the
remaining MSI-X vectors.

Signed-off-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
---
 Changes in v3:
 * implemented irq_contexts as xarrays rather than list
 * split the patch to create a perparation patch around irq_setup()
 * add log when IRQ allocation/setup for remaining IRQs fails
---
 Changes in v2:
 * Use string 'MSI-X vectors' instead of 'pci vectors'
 * make skip-cpu a bool instead of int
 * rearrange the comment arout skip_cpu variable appropriately
 * update the capability bit for driver indicating dynamic IRQ allocation
 * enforced max line length to 80
 * enforced RCT convention
 * initialized gic to NULL, for when there is a possibility of gic
   not being populated correctly
---
 .../net/ethernet/microsoft/mana/gdma_main.c   | 248 +++++++++++++++---
 include/net/mana/gdma.h                       |   8 +-
 2 files changed, 211 insertions(+), 45 deletions(-)

diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/net/ethernet/microsoft/mana/gdma_main.c
index 2de42ce43373..f07cebffc30d 100644
--- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
+++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
@@ -6,6 +6,8 @@
 #include <linux/pci.h>
 #include <linux/utsname.h>
 #include <linux/version.h>
+#include <linux/msi.h>
+#include <linux/irqdomain.h>
 
 #include <net/mana/mana.h>
 
@@ -80,8 +82,15 @@ static int mana_gd_query_max_resources(struct pci_dev *pdev)
 		return err ? err : -EPROTO;
 	}
 
-	if (gc->num_msix_usable > resp.max_msix)
-		gc->num_msix_usable = resp.max_msix;
+	if (!pci_msix_can_alloc_dyn(pdev)) {
+		if (gc->num_msix_usable > resp.max_msix)
+			gc->num_msix_usable = resp.max_msix;
+	} else {
+		/* If dynamic allocation is enabled we have already allocated
+		 * hwc msi
+		 */
+		gc->num_msix_usable = min(resp.max_msix, num_online_cpus() + 1);
+	}
 
 	if (gc->num_msix_usable <= 1)
 		return -ENOSPC;
@@ -482,7 +491,9 @@ static int mana_gd_register_irq(struct gdma_queue *queue,
 	}
 
 	queue->eq.msix_index = msi_index;
-	gic = &gc->irq_contexts[msi_index];
+	gic = xa_load(&gc->irq_contexts, msi_index);
+	if (!gic)
+		return -EINVAL;
 
 	spin_lock_irqsave(&gic->lock, flags);
 	list_add_rcu(&queue->entry, &gic->eq_list);
@@ -507,7 +518,10 @@ static void mana_gd_deregiser_irq(struct gdma_queue *queue)
 	if (WARN_ON(msix_index >= gc->num_msix_usable))
 		return;
 
-	gic = &gc->irq_contexts[msix_index];
+	gic = xa_load(&gc->irq_contexts, msix_index);
+	if (!gic)
+		return;
+
 	spin_lock_irqsave(&gic->lock, flags);
 	list_for_each_entry_rcu(eq, &gic->eq_list, entry) {
 		if (queue == eq) {
@@ -1329,29 +1343,96 @@ static int irq_setup(unsigned int *irqs, unsigned int len, int node,
 	return 0;
 }
 
-static int mana_gd_setup_irqs(struct pci_dev *pdev)
+static int mana_gd_setup_dyn_irqs(struct pci_dev *pdev, int nvec)
 {
 	struct gdma_context *gc = pci_get_drvdata(pdev);
-	unsigned int max_queues_per_port;
 	struct gdma_irq_context *gic;
-	unsigned int max_irqs, cpu;
-	int start_irq_index = 1;
-	int nvec, *irqs, irq;
+	bool skip_first_cpu = false;
 	int err, i = 0, j;
+	int *irqs, irq;
 
 	cpus_read_lock();
-	max_queues_per_port = num_online_cpus();
-	if (max_queues_per_port > MANA_MAX_NUM_QUEUES)
-		max_queues_per_port = MANA_MAX_NUM_QUEUES;
 
-	/* Need 1 interrupt for the Hardware communication Channel (HWC) */
-	max_irqs = max_queues_per_port + 1;
+	irqs = kmalloc_array(nvec, sizeof(int), GFP_KERNEL);
+	if (!irqs) {
+		err = -ENOMEM;
+		goto free_irq_vector;
+	}
 
-	nvec = pci_alloc_irq_vectors(pdev, 2, max_irqs, PCI_IRQ_MSIX);
-	if (nvec < 0) {
-		cpus_read_unlock();
-		return nvec;
+	for (i = 0; i < nvec; i++) {
+		gic = kcalloc(1, sizeof(struct gdma_irq_context), GFP_KERNEL);
+		if (!gic) {
+			err = -ENOMEM;
+			goto free_irq;
+		}
+		gic->handler = mana_gd_process_eq_events;
+		INIT_LIST_HEAD(&gic->eq_list);
+		spin_lock_init(&gic->lock);
+
+		snprintf(gic->name, MANA_IRQ_NAME_SZ, "mana_q%d@pci:%s",
+			 i, pci_name(pdev));
+
+		/* one pci vector is already allocated for HWC */
+		irqs[i] = pci_irq_vector(pdev, i + 1);
+		if (irqs[i] < 0) {
+			err = irqs[i];
+			goto free_current_gic;
+		}
+
+		err = request_irq(irqs[i], mana_gd_intr, 0, gic->name, gic);
+		if (err)
+			goto free_current_gic;
+
+		xa_store(&gc->irq_contexts, i + 1, gic, GFP_KERNEL);
 	}
+
+	/*
+	 * When calling irq_setup() for dynamically added IRQs, if number of
+	 * CPUs is more than or equal to allocated MSI-X, we need to skip the
+	 * first CPU sibling group since they are already affinitized to HWC IRQ
+	 */
+	if (gc->num_msix_usable <= num_online_cpus())
+		skip_first_cpu = true;
+
+	err = irq_setup(irqs, nvec, gc->numa_node, skip_first_cpu);
+	if (err)
+		goto free_irq;
+
+	cpus_read_unlock();
+	kfree(irqs);
+	return 0;
+
+free_current_gic:
+	kfree(gic);
+free_irq:
+	for (j = i; j >= 0; j--) {
+		irq = pci_irq_vector(pdev, j);
+		gic = xa_load(&gc->irq_contexts, j);
+		if (!gic)
+			continue;
+
+		irq_update_affinity_hint(irq, NULL);
+		free_irq(irq, gic);
+		xa_erase(&gc->irq_contexts, j);
+		kfree(gic);
+	}
+	kfree(irqs);
+free_irq_vector:
+	cpus_read_unlock();
+	return err;
+}
+
+static int mana_gd_setup_irqs(struct pci_dev *pdev, int nvec)
+{
+	struct gdma_context *gc = pci_get_drvdata(pdev);
+	struct gdma_irq_context *gic;
+	int start_irq_index = 1;
+	unsigned int cpu;
+	int *irqs, irq;
+	int err, i = 0, j;
+
+	cpus_read_lock();
+
 	if (nvec <= num_online_cpus())
 		start_irq_index = 0;
 
@@ -1361,15 +1442,13 @@ static int mana_gd_setup_irqs(struct pci_dev *pdev)
 		goto free_irq_vector;
 	}
 
-	gc->irq_contexts = kcalloc(nvec, sizeof(struct gdma_irq_context),
-				   GFP_KERNEL);
-	if (!gc->irq_contexts) {
-		err = -ENOMEM;
-		goto free_irq_array;
-	}
-
 	for (i = 0; i < nvec; i++) {
-		gic = &gc->irq_contexts[i];
+		gic = kcalloc(1, sizeof(struct gdma_irq_context), GFP_KERNEL);
+		if (!gic) {
+			err = -ENOMEM;
+			goto free_irq;
+		}
+
 		gic->handler = mana_gd_process_eq_events;
 		INIT_LIST_HEAD(&gic->eq_list);
 		spin_lock_init(&gic->lock);
@@ -1384,13 +1463,13 @@ static int mana_gd_setup_irqs(struct pci_dev *pdev)
 		irq = pci_irq_vector(pdev, i);
 		if (irq < 0) {
 			err = irq;
-			goto free_irq;
+			goto free_current_gic;
 		}
 
 		if (!i) {
 			err = request_irq(irq, mana_gd_intr, 0, gic->name, gic);
 			if (err)
-				goto free_irq;
+				goto free_current_gic;
 
 			/* If number of IRQ is one extra than number of online CPUs,
 			 * then we need to assign IRQ0 (hwc irq) and IRQ1 to
@@ -1408,39 +1487,110 @@ static int mana_gd_setup_irqs(struct pci_dev *pdev)
 			}
 		} else {
 			irqs[i - start_irq_index] = irq;
-			err = request_irq(irqs[i - start_irq_index], mana_gd_intr, 0,
-					  gic->name, gic);
+			err = request_irq(irqs[i - start_irq_index],
+					  mana_gd_intr, 0, gic->name, gic);
 			if (err)
-				goto free_irq;
+				goto free_current_gic;
 		}
+
+		xa_store(&gc->irq_contexts, i, gic, GFP_KERNEL);
 	}
 
 	err = irq_setup(irqs, (nvec - start_irq_index), gc->numa_node, false);
 	if (err)
 		goto free_irq;
 
-	gc->max_num_msix = nvec;
-	gc->num_msix_usable = nvec;
 	cpus_read_unlock();
 	kfree(irqs);
 	return 0;
 
+free_current_gic:
+	kfree(gic);
 free_irq:
 	for (j = i - 1; j >= 0; j--) {
 		irq = pci_irq_vector(pdev, j);
-		gic = &gc->irq_contexts[j];
+		gic = xa_load(&gc->irq_contexts, j);
+		if (!gic)
+			continue;
 
 		irq_update_affinity_hint(irq, NULL);
 		free_irq(irq, gic);
+		xa_erase(&gc->irq_contexts, j);
+		kfree(gic);
 	}
 
-	kfree(gc->irq_contexts);
-	gc->irq_contexts = NULL;
-free_irq_array:
 	kfree(irqs);
 free_irq_vector:
+	xa_destroy(&gc->irq_contexts);
 	cpus_read_unlock();
-	pci_free_irq_vectors(pdev);
+	return err;
+}
+
+static int mana_gd_setup_hwc_irqs(struct pci_dev *pdev)
+{
+	struct gdma_context *gc = pci_get_drvdata(pdev);
+	unsigned int max_irqs, min_irqs;
+	int max_queues_per_port;
+	int nvec, err;
+
+	if (pci_msix_can_alloc_dyn(pdev)) {
+		max_irqs = 1;
+		min_irqs = 1;
+	} else {
+		max_queues_per_port = num_online_cpus();
+		if (max_queues_per_port > MANA_MAX_NUM_QUEUES)
+			max_queues_per_port = MANA_MAX_NUM_QUEUES;
+		/* Need 1 interrupt for HWC */
+		max_irqs = max_queues_per_port + 1;
+		min_irqs = 2;
+	}
+
+	nvec = pci_alloc_irq_vectors(pdev, min_irqs, max_irqs, PCI_IRQ_MSIX);
+	if (nvec < 0)
+		return nvec;
+
+	err = mana_gd_setup_irqs(pdev, nvec);
+	if (err) {
+		pci_free_irq_vectors(pdev);
+		return err;
+	}
+
+	gc->num_msix_usable = nvec;
+	gc->max_num_msix = nvec;
+
+	return err;
+}
+
+static int mana_gd_setup_remaining_irqs(struct pci_dev *pdev)
+{
+	struct gdma_context *gc = pci_get_drvdata(pdev);
+	int max_irqs, i, err = 0;
+	struct msi_map irq_map;
+
+	if (!pci_msix_can_alloc_dyn(pdev))
+		/* remain irqs are already allocated with HWC IRQ */
+		return 0;
+
+	/* allocate only remaining IRQs*/
+	max_irqs = gc->num_msix_usable - 1;
+
+	for (i = 1; i <= max_irqs; i++) {
+		irq_map = pci_msix_alloc_irq_at(pdev, i, NULL);
+		if (!irq_map.virq) {
+			err = irq_map.index;
+			/* caller will handle cleaning up all allocated
+			 * irqs, after HWC is destroyed
+			 */
+			return err;
+		}
+	}
+
+	err = mana_gd_setup_dyn_irqs(pdev, max_irqs);
+	if (err)
+		return err;
+
+	gc->max_num_msix = gc->max_num_msix + max_irqs;
+
 	return err;
 }
 
@@ -1458,19 +1608,22 @@ static void mana_gd_remove_irqs(struct pci_dev *pdev)
 		if (irq < 0)
 			continue;
 
-		gic = &gc->irq_contexts[i];
+		gic = xa_load(&gc->irq_contexts, i);
+		if (!gic)
+			continue;
 
 		/* Need to clear the hint before free_irq */
 		irq_update_affinity_hint(irq, NULL);
 		free_irq(irq, gic);
+		xa_erase(&gc->irq_contexts, i);
+		kfree(gic);
 	}
 
 	pci_free_irq_vectors(pdev);
 
 	gc->max_num_msix = 0;
 	gc->num_msix_usable = 0;
-	kfree(gc->irq_contexts);
-	gc->irq_contexts = NULL;
+	xa_destroy(&gc->irq_contexts);
 }
 
 static int mana_gd_setup(struct pci_dev *pdev)
@@ -1481,9 +1634,10 @@ static int mana_gd_setup(struct pci_dev *pdev)
 	mana_gd_init_registers(pdev);
 	mana_smc_init(&gc->shm_channel, gc->dev, gc->shm_base);
 
-	err = mana_gd_setup_irqs(pdev);
+	err = mana_gd_setup_hwc_irqs(pdev);
 	if (err) {
-		dev_err(gc->dev, "Failed to setup IRQs: %d\n", err);
+		dev_err(gc->dev, "Failed to setup IRQs for HWC creation: %d\n",
+			err);
 		return err;
 	}
 
@@ -1499,6 +1653,12 @@ static int mana_gd_setup(struct pci_dev *pdev)
 	if (err)
 		goto destroy_hwc;
 
+	err = mana_gd_setup_remaining_irqs(pdev);
+	if (err) {
+		dev_err(gc->dev, "Failed to setup remaining IRQs: %d", err);
+		goto destroy_hwc;
+	}
+
 	err = mana_gd_detect_devices(pdev);
 	if (err)
 		goto destroy_hwc;
@@ -1575,6 +1735,7 @@ static int mana_gd_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	gc->is_pf = mana_is_pf(pdev->device);
 	gc->bar0_va = bar0_va;
 	gc->dev = &pdev->dev;
+	xa_init(&gc->irq_contexts);
 
 	if (gc->is_pf)
 		gc->mana_pci_debugfs = debugfs_create_dir("0", mana_debugfs_root);
diff --git a/include/net/mana/gdma.h b/include/net/mana/gdma.h
index 228603bf03f2..f20d1d1ea5e8 100644
--- a/include/net/mana/gdma.h
+++ b/include/net/mana/gdma.h
@@ -373,7 +373,7 @@ struct gdma_context {
 	unsigned int		max_num_queues;
 	unsigned int		max_num_msix;
 	unsigned int		num_msix_usable;
-	struct gdma_irq_context	*irq_contexts;
+	struct xarray		irq_contexts;
 
 	/* L2 MTU */
 	u16 adapter_mtu;
@@ -558,12 +558,16 @@ enum {
 /* Driver can handle holes (zeros) in the device list */
 #define GDMA_DRV_CAP_FLAG_1_DEV_LIST_HOLES_SUP BIT(11)
 
+/* Driver supports dynamic MSI-X vector allocation */
+#define GDMA_DRV_CAP_FLAG_1_DYNAMIC_IRQ_ALLOC_SUPPORT BIT(13)
+
 #define GDMA_DRV_CAP_FLAGS1 \
 	(GDMA_DRV_CAP_FLAG_1_EQ_SHARING_MULTI_VPORT | \
 	 GDMA_DRV_CAP_FLAG_1_NAPI_WKDONE_FIX | \
 	 GDMA_DRV_CAP_FLAG_1_HWC_TIMEOUT_RECONFIG | \
 	 GDMA_DRV_CAP_FLAG_1_VARIABLE_INDIRECTION_TABLE_SUPPORT | \
-	 GDMA_DRV_CAP_FLAG_1_DEV_LIST_HOLES_SUP)
+	 GDMA_DRV_CAP_FLAG_1_DEV_LIST_HOLES_SUP | \
+	 GDMA_DRV_CAP_FLAG_1_DYNAMIC_IRQ_ALLOC_SUPPORT)
 
 #define GDMA_DRV_CAP_FLAGS2 0
 
-- 
2.34.1


