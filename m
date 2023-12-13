Return-Path: <linux-hyperv+bounces-1327-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49FD9810DCB
	for <lists+linux-hyperv@lfdr.de>; Wed, 13 Dec 2023 11:02:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F28492812FE
	for <lists+linux-hyperv@lfdr.de>; Wed, 13 Dec 2023 10:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48D47219FA;
	Wed, 13 Dec 2023 10:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="BEIll5Vo"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id B1B3E83;
	Wed, 13 Dec 2023 02:01:54 -0800 (PST)
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id D9FAC20B74C0;
	Wed, 13 Dec 2023 02:01:53 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D9FAC20B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1702461713;
	bh=W76rnqlsU93altV/2qDWt6+X+GwQAHiWQz5/saK9YpA=;
	h=From:To:Cc:Subject:Date:From;
	b=BEIll5Vo3uXoX3e04Vuj3HajXdbhmOkMB/PmrDnLfOK5t3VQbVawsSsp0xoJ//UvQ
	 qtSxCc3FMfwaXE3qOD6NiJhmwsxq+E+kOIvulaCUV2qY509ZEGGQKsDMlUFdFcMW/V
	 IPwH7SI3iR3BqrIJQuN4cexjtEGvKFGVbiyykiQE=
From: Konstantin Taranov <kotaranov@linux.microsoft.com>
To: kotaranov@microsoft.com,
	kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	kuba@kernel.org,
	leon@kernel.org,
	decui@microsoft.com,
	edumazet@google.com,
	cai.huoqing@linux.dev,
	pabeni@redhat.com,
	davem@davemloft.net,
	longli@microsoft.com
Cc: linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org
Subject: [PATCH for-next v2] net: mana: add msix index sharing between EQs
Date: Wed, 13 Dec 2023 02:01:47 -0800
Message-Id: <1702461707-2692-1-git-send-email-kotaranov@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

From: Konstantin Taranov <kotaranov@microsoft.com>

This patch allows to assign and poll more than one EQ on the same
msix index.
It is achieved by introducing a list of attached EQs in each IRQ context.
It also removes the existing msix_index map that tried to ensure that there
is only one EQ at each msix_index.
This patch exports symbols for creating EQs from other MANA kernel modules.

Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>
---
V1 -> V2: removed msix_index map and improved thread-safety of rcu lists
---
 .../net/ethernet/microsoft/mana/gdma_main.c   | 76 +++++++++----------
 .../net/ethernet/microsoft/mana/hw_channel.c  |  1 +
 drivers/net/ethernet/microsoft/mana/mana_en.c |  1 +
 include/net/mana/gdma.h                       |  7 +-
 4 files changed, 43 insertions(+), 42 deletions(-)

diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/net/ethernet/microsoft/mana/gdma_main.c
index 6367de0..a686301 100644
--- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
+++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
@@ -414,8 +414,12 @@ static void mana_gd_process_eq_events(void *arg)
 
 		old_bits = (eq->head / num_eqe - 1) & GDMA_EQE_OWNER_MASK;
 		/* No more entries */
-		if (owner_bits == old_bits)
+		if (owner_bits == old_bits) {
+			/* return here without ringing the doorbell */
+			if (i == 0)
+				return;
 			break;
+		}
 
 		new_bits = (eq->head / num_eqe) & GDMA_EQE_OWNER_MASK;
 		if (owner_bits != new_bits) {
@@ -445,42 +449,29 @@ static int mana_gd_register_irq(struct gdma_queue *queue,
 	struct gdma_dev *gd = queue->gdma_dev;
 	struct gdma_irq_context *gic;
 	struct gdma_context *gc;
-	struct gdma_resource *r;
 	unsigned int msi_index;
 	unsigned long flags;
 	struct device *dev;
 	int err = 0;
 
 	gc = gd->gdma_context;
-	r = &gc->msix_resource;
 	dev = gc->dev;
+	msi_index = spec->eq.msix_index;
 
-	spin_lock_irqsave(&r->lock, flags);
-
-	msi_index = find_first_zero_bit(r->map, r->size);
-	if (msi_index >= r->size || msi_index >= gc->num_msix_usable) {
+	if (msi_index >= gc->num_msix_usable) {
 		err = -ENOSPC;
-	} else {
-		bitmap_set(r->map, msi_index, 1);
-		queue->eq.msix_index = msi_index;
-	}
-
-	spin_unlock_irqrestore(&r->lock, flags);
-
-	if (err) {
-		dev_err(dev, "Register IRQ err:%d, msi:%u rsize:%u, nMSI:%u",
-			err, msi_index, r->size, gc->num_msix_usable);
+		dev_err(dev, "Register IRQ err:%d, msi:%u nMSI:%u",
+			err, msi_index, gc->num_msix_usable);
 
 		return err;
 	}
 
+	queue->eq.msix_index = msi_index;
 	gic = &gc->irq_contexts[msi_index];
 
-	WARN_ON(gic->handler || gic->arg);
-
-	gic->arg = queue;
-
-	gic->handler = mana_gd_process_eq_events;
+	spin_lock_irqsave(&gic->lock, flags);
+	list_add_rcu(&queue->entry, &gic->eq_list);
+	spin_unlock_irqrestore(&gic->lock, flags);
 
 	return 0;
 }
@@ -490,12 +481,11 @@ static void mana_gd_deregiser_irq(struct gdma_queue *queue)
 	struct gdma_dev *gd = queue->gdma_dev;
 	struct gdma_irq_context *gic;
 	struct gdma_context *gc;
-	struct gdma_resource *r;
 	unsigned int msix_index;
 	unsigned long flags;
+	struct gdma_queue *eq;
 
 	gc = gd->gdma_context;
-	r = &gc->msix_resource;
 
 	/* At most num_online_cpus() + 1 interrupts are used. */
 	msix_index = queue->eq.msix_index;
@@ -503,14 +493,17 @@ static void mana_gd_deregiser_irq(struct gdma_queue *queue)
 		return;
 
 	gic = &gc->irq_contexts[msix_index];
-	gic->handler = NULL;
-	gic->arg = NULL;
-
-	spin_lock_irqsave(&r->lock, flags);
-	bitmap_clear(r->map, msix_index, 1);
-	spin_unlock_irqrestore(&r->lock, flags);
+	spin_lock_irqsave(&gic->lock, flags);
+	list_for_each_entry_rcu(eq, &gic->eq_list, entry) {
+		if (queue == eq) {
+			list_del_rcu(&eq->entry);
+			break;
+		}
+	}
+	spin_unlock_irqrestore(&gic->lock, flags);
 
 	queue->eq.msix_index = INVALID_PCI_MSIX_INDEX;
+	synchronize_rcu();
 }
 
 int mana_gd_test_eq(struct gdma_context *gc, struct gdma_queue *eq)
@@ -588,6 +581,7 @@ static int mana_gd_create_eq(struct gdma_dev *gd,
 	int err;
 
 	queue->eq.msix_index = INVALID_PCI_MSIX_INDEX;
+	queue->id = INVALID_QUEUE_ID;
 
 	log2_num_entries = ilog2(queue->queue_size / GDMA_EQE_SIZE);
 
@@ -819,6 +813,7 @@ free_q:
 	kfree(queue);
 	return err;
 }
+EXPORT_SYMBOL_NS(mana_gd_create_mana_eq, NET_MANA);
 
 int mana_gd_create_mana_wq_cq(struct gdma_dev *gd,
 			      const struct gdma_queue_spec *spec,
@@ -895,6 +890,7 @@ void mana_gd_destroy_queue(struct gdma_context *gc, struct gdma_queue *queue)
 	mana_gd_free_memory(gmi);
 	kfree(queue);
 }
+EXPORT_SYMBOL_NS(mana_gd_destroy_queue, NET_MANA);
 
 int mana_gd_verify_vf_version(struct pci_dev *pdev)
 {
@@ -1217,9 +1213,14 @@ int mana_gd_poll_cq(struct gdma_queue *cq, struct gdma_comp *comp, int num_cqe)
 static irqreturn_t mana_gd_intr(int irq, void *arg)
 {
 	struct gdma_irq_context *gic = arg;
+	struct list_head *eq_list = &gic->eq_list;
+	struct gdma_queue *eq;
 
-	if (gic->handler)
-		gic->handler(gic->arg);
+	rcu_read_lock();
+	list_for_each_entry_rcu(eq, eq_list, entry) {
+		gic->handler(eq);
+	}
+	rcu_read_unlock();
 
 	return IRQ_HANDLED;
 }
@@ -1271,8 +1272,9 @@ static int mana_gd_setup_irqs(struct pci_dev *pdev)
 
 	for (i = 0; i < nvec; i++) {
 		gic = &gc->irq_contexts[i];
-		gic->handler = NULL;
-		gic->arg = NULL;
+		gic->handler = mana_gd_process_eq_events;
+		INIT_LIST_HEAD(&gic->eq_list);
+		spin_lock_init(&gic->lock);
 
 		if (!i)
 			snprintf(gic->name, MANA_IRQ_NAME_SZ, "mana_hwc@pci:%s",
@@ -1295,10 +1297,6 @@ static int mana_gd_setup_irqs(struct pci_dev *pdev)
 		irq_set_affinity_and_hint(irq, cpumask_of(cpu));
 	}
 
-	err = mana_gd_alloc_res_map(nvec, &gc->msix_resource);
-	if (err)
-		goto free_irq;
-
 	gc->max_num_msix = nvec;
 	gc->num_msix_usable = nvec;
 
@@ -1329,8 +1327,6 @@ static void mana_gd_remove_irqs(struct pci_dev *pdev)
 	if (gc->max_num_msix < 1)
 		return;
 
-	mana_gd_free_res_map(&gc->msix_resource);
-
 	for (i = 0; i < gc->max_num_msix; i++) {
 		irq = pci_irq_vector(pdev, i);
 		if (irq < 0)
diff --git a/drivers/net/ethernet/microsoft/mana/hw_channel.c b/drivers/net/ethernet/microsoft/mana/hw_channel.c
index 9d1cd3b..2729a2c 100644
--- a/drivers/net/ethernet/microsoft/mana/hw_channel.c
+++ b/drivers/net/ethernet/microsoft/mana/hw_channel.c
@@ -300,6 +300,7 @@ static int mana_hwc_create_gdma_eq(struct hw_channel_context *hwc,
 	spec.eq.context = ctx;
 	spec.eq.callback = cb;
 	spec.eq.log2_throttle_limit = DEFAULT_LOG2_THROTTLING_FOR_ERROR_EQ;
+	spec.eq.msix_index = 0;
 
 	return mana_gd_create_hwc_queue(hwc->gdma_dev, &spec, queue);
 }
diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index fc3d290..2c04bdb 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -1244,6 +1244,7 @@ static int mana_create_eq(struct mana_context *ac)
 	spec.eq.log2_throttle_limit = LOG2_EQ_THROTTLE;
 
 	for (i = 0; i < gc->max_num_queues; i++) {
+		spec.eq.msix_index = (i + 1) % gc->num_msix_usable;
 		err = mana_gd_create_mana_eq(gd, &spec, &ac->eqs[i].eq);
 		if (err)
 			goto out;
diff --git a/include/net/mana/gdma.h b/include/net/mana/gdma.h
index 88b6ef7..76f2fd2 100644
--- a/include/net/mana/gdma.h
+++ b/include/net/mana/gdma.h
@@ -293,6 +293,7 @@ struct gdma_queue {
 
 	u32 head;
 	u32 tail;
+	struct list_head entry;
 
 	/* Extra fields specific to EQ/CQ. */
 	union {
@@ -328,6 +329,7 @@ struct gdma_queue_spec {
 			void *context;
 
 			unsigned long log2_throttle_limit;
+			unsigned int msix_index;
 		} eq;
 
 		struct {
@@ -344,7 +346,9 @@ struct gdma_queue_spec {
 
 struct gdma_irq_context {
 	void (*handler)(void *arg);
-	void *arg;
+	/* Protect the eq_list */
+	spinlock_t lock;
+	struct list_head eq_list;
 	char name[MANA_IRQ_NAME_SZ];
 };
 
@@ -355,7 +359,6 @@ struct gdma_context {
 	unsigned int		max_num_queues;
 	unsigned int		max_num_msix;
 	unsigned int		num_msix_usable;
-	struct gdma_resource	msix_resource;
 	struct gdma_irq_context	*irq_contexts;
 
 	/* L2 MTU */
-- 
2.43.0


