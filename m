Return-Path: <linux-hyperv+bounces-1298-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB59580A34D
	for <lists+linux-hyperv@lfdr.de>; Fri,  8 Dec 2023 13:35:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91DAD2818A3
	for <lists+linux-hyperv@lfdr.de>; Fri,  8 Dec 2023 12:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04235125B1;
	Fri,  8 Dec 2023 12:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="FIAXYAdb"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id AABDD1985;
	Fri,  8 Dec 2023 04:35:14 -0800 (PST)
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id 09A8220B74C0;
	Fri,  8 Dec 2023 04:35:14 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 09A8220B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1702038914;
	bh=7mA0Nk9JABJbzejc00vimgy7KH2zEY/kLfO3nzNRrOU=;
	h=From:To:Cc:Subject:Date:From;
	b=FIAXYAdbbG7wXaKNZ9umrETLQ81Gi/K/zSK47IYj1vgWGJ5wPChtLP5AXt23/FtWY
	 Eed/zyw783mRLv952yR/g0zTgvi2jm0zK+97NfdWxtx/r//fSeEYv89DQ8v0jy0xvl
	 zz/u6tAppPcxRi7D9M5NaAdHiXObeQokUStsOePs=
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
Subject: [PATCH] net: mana: add msix index sharing between EQs
Date: Fri,  8 Dec 2023 04:35:05 -0800
Message-Id: <1702038905-29520-1-git-send-email-kotaranov@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

From: Konstantin Taranov <kotaranov@microsoft.com>

This patch allows to assign and poll more than 1 EQ on the same msix index.
It is achieved by introducing a list of attached EQs in each IRQ context.
This patch export symbols for creating EQs from other MANA kernel modules.

Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>
---
 .../net/ethernet/microsoft/mana/gdma_main.c   | 55 ++++++++++++++-----
 .../net/ethernet/microsoft/mana/hw_channel.c  |  1 +
 drivers/net/ethernet/microsoft/mana/mana_en.c |  1 +
 include/net/mana/gdma.h                       |  4 +-
 4 files changed, 45 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/net/ethernet/microsoft/mana/gdma_main.c
index 6367de0..82a4534 100644
--- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
+++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
@@ -401,6 +401,9 @@ static void mana_gd_process_eq_events(void *arg)
 	u32 head, num_eqe;
 	int i;
 
+	if (eq->id == INVALID_QUEUE_ID)
+		return;
+
 	gc = eq->gdma_dev->gdma_context;
 
 	num_eqe = eq->queue_size / GDMA_EQE_SIZE;
@@ -414,8 +417,12 @@ static void mana_gd_process_eq_events(void *arg)
 
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
@@ -457,12 +464,16 @@ static int mana_gd_register_irq(struct gdma_queue *queue,
 
 	spin_lock_irqsave(&r->lock, flags);
 
-	msi_index = find_first_zero_bit(r->map, r->size);
+	if (queue->eq.msix_index == INVALID_PCI_MSIX_INDEX)
+		queue->eq.msix_index = find_first_zero_bit(r->map, r->size);
+
+	msi_index = queue->eq.msix_index;
+
 	if (msi_index >= r->size || msi_index >= gc->num_msix_usable) {
 		err = -ENOSPC;
+		queue->eq.msix_index = INVALID_PCI_MSIX_INDEX;
 	} else {
 		bitmap_set(r->map, msi_index, 1);
-		queue->eq.msix_index = msi_index;
 	}
 
 	spin_unlock_irqrestore(&r->lock, flags);
@@ -476,9 +487,7 @@ static int mana_gd_register_irq(struct gdma_queue *queue,
 
 	gic = &gc->irq_contexts[msi_index];
 
-	WARN_ON(gic->handler || gic->arg);
-
-	gic->arg = queue;
+	list_add_rcu(&queue->entry, &gic->eq_list);
 
 	gic->handler = mana_gd_process_eq_events;
 
@@ -493,6 +502,7 @@ static void mana_gd_deregiser_irq(struct gdma_queue *queue)
 	struct gdma_resource *r;
 	unsigned int msix_index;
 	unsigned long flags;
+	struct gdma_queue *eq;
 
 	gc = gd->gdma_context;
 	r = &gc->msix_resource;
@@ -502,12 +512,19 @@ static void mana_gd_deregiser_irq(struct gdma_queue *queue)
 	if (WARN_ON(msix_index >= gc->num_msix_usable))
 		return;
 
-	gic = &gc->irq_contexts[msix_index];
-	gic->handler = NULL;
-	gic->arg = NULL;
-
 	spin_lock_irqsave(&r->lock, flags);
-	bitmap_clear(r->map, msix_index, 1);
+	gic = &gc->irq_contexts[msix_index];
+	list_for_each_entry_rcu(eq, &gic->eq_list, entry) {
+		if (queue == eq) {
+			list_del_rcu(&eq->entry);
+			synchronize_rcu();
+			break;
+		}
+	}
+	if (list_empty(&gic->eq_list)) {
+		gic->handler = NULL;
+		bitmap_clear(r->map, msix_index, 1);
+	}
 	spin_unlock_irqrestore(&r->lock, flags);
 
 	queue->eq.msix_index = INVALID_PCI_MSIX_INDEX;
@@ -587,7 +604,8 @@ static int mana_gd_create_eq(struct gdma_dev *gd,
 	u32 log2_num_entries;
 	int err;
 
-	queue->eq.msix_index = INVALID_PCI_MSIX_INDEX;
+	queue->eq.msix_index = spec->eq.msix_index;
+	queue->id = INVALID_QUEUE_ID;
 
 	log2_num_entries = ilog2(queue->queue_size / GDMA_EQE_SIZE);
 
@@ -819,6 +837,7 @@ free_q:
 	kfree(queue);
 	return err;
 }
+EXPORT_SYMBOL_NS(mana_gd_create_mana_eq, NET_MANA);
 
 int mana_gd_create_mana_wq_cq(struct gdma_dev *gd,
 			      const struct gdma_queue_spec *spec,
@@ -895,6 +914,7 @@ void mana_gd_destroy_queue(struct gdma_context *gc, struct gdma_queue *queue)
 	mana_gd_free_memory(gmi);
 	kfree(queue);
 }
+EXPORT_SYMBOL_NS(mana_gd_destroy_queue, NET_MANA);
 
 int mana_gd_verify_vf_version(struct pci_dev *pdev)
 {
@@ -1217,9 +1237,14 @@ int mana_gd_poll_cq(struct gdma_queue *cq, struct gdma_comp *comp, int num_cqe)
 static irqreturn_t mana_gd_intr(int irq, void *arg)
 {
 	struct gdma_irq_context *gic = arg;
+	struct list_head *eq_list = &gic->eq_list;
+	struct gdma_queue *eq;
 
-	if (gic->handler)
-		gic->handler(gic->arg);
+	if (gic->handler) {
+		list_for_each_entry_rcu(eq, eq_list, entry) {
+			gic->handler(eq);
+		}
+	}
 
 	return IRQ_HANDLED;
 }
@@ -1272,7 +1297,7 @@ static int mana_gd_setup_irqs(struct pci_dev *pdev)
 	for (i = 0; i < nvec; i++) {
 		gic = &gc->irq_contexts[i];
 		gic->handler = NULL;
-		gic->arg = NULL;
+		INIT_LIST_HEAD(&gic->eq_list);
 
 		if (!i)
 			snprintf(gic->name, MANA_IRQ_NAME_SZ, "mana_hwc@pci:%s",
diff --git a/drivers/net/ethernet/microsoft/mana/hw_channel.c b/drivers/net/ethernet/microsoft/mana/hw_channel.c
index 9d1cd3b..0a5fc39 100644
--- a/drivers/net/ethernet/microsoft/mana/hw_channel.c
+++ b/drivers/net/ethernet/microsoft/mana/hw_channel.c
@@ -300,6 +300,7 @@ static int mana_hwc_create_gdma_eq(struct hw_channel_context *hwc,
 	spec.eq.context = ctx;
 	spec.eq.callback = cb;
 	spec.eq.log2_throttle_limit = DEFAULT_LOG2_THROTTLING_FOR_ERROR_EQ;
+	spec.eq.msix_index = INVALID_PCI_MSIX_INDEX;
 
 	return mana_gd_create_hwc_queue(hwc->gdma_dev, &spec, queue);
 }
diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index fc3d290..8718c04 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -1242,6 +1242,7 @@ static int mana_create_eq(struct mana_context *ac)
 	spec.eq.callback = NULL;
 	spec.eq.context = ac->eqs;
 	spec.eq.log2_throttle_limit = LOG2_EQ_THROTTLE;
+	spec.eq.msix_index = INVALID_PCI_MSIX_INDEX;
 
 	for (i = 0; i < gc->max_num_queues; i++) {
 		err = mana_gd_create_mana_eq(gd, &spec, &ac->eqs[i].eq);
diff --git a/include/net/mana/gdma.h b/include/net/mana/gdma.h
index 88b6ef7..8d6569d 100644
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
@@ -344,7 +346,7 @@ struct gdma_queue_spec {
 
 struct gdma_irq_context {
 	void (*handler)(void *arg);
-	void *arg;
+	struct list_head eq_list;
 	char name[MANA_IRQ_NAME_SZ];
 };
 
-- 
2.43.0


