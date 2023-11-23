Return-Path: <linux-hyperv+bounces-1035-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 148177F56CD
	for <lists+linux-hyperv@lfdr.de>; Thu, 23 Nov 2023 04:10:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3772D1C20C51
	for <lists+linux-hyperv@lfdr.de>; Thu, 23 Nov 2023 03:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4923A8BEB;
	Thu, 23 Nov 2023 03:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxonhyperv.com header.i=@linuxonhyperv.com header.b="IAgyp0qN"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id AF9981BD;
	Wed, 22 Nov 2023 19:10:22 -0800 (PST)
Received: by linux.microsoft.com (Postfix, from userid 1004)
	id 4686620B74C2; Wed, 22 Nov 2023 19:10:22 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4686620B74C2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxonhyperv.com;
	s=default; t=1700709022;
	bh=r7cg3LEpjXHMbs6ZkeOp+TbHsor32SEuIoyU0GKim6M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IAgyp0qN1iod/BhS49hE2zsD8h+laSPBD5LMs6IijdLD+X5XV8CiPE140ntBzG4qP
	 +ZYcXIESwMwpA/uW0ICkwNNBT8kFXgt77cTwHzKnn/3SqJH9DRKsNV/eS7KOpva+oc
	 1m+xM+7fRFKUp/7Wl4a8bazqhMxFo8KnwLX1A2H0=
From: longli@linuxonhyperv.com
To: Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	Ajay Sharma <sharmaajay@microsoft.com>,
	Dexuan Cui <decui@microsoft.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: linux-rdma@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Long Li <longli@microsoft.com>
Subject: [Patch v1 2/4] RDMA/mana_ib: create and process EQ events
Date: Wed, 22 Nov 2023 19:10:08 -0800
Message-Id: <1700709010-22042-3-git-send-email-longli@linuxonhyperv.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1700709010-22042-1-git-send-email-longli@linuxonhyperv.com>
References: <1700709010-22042-1-git-send-email-longli@linuxonhyperv.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

From: Long Li <longli@microsoft.com>

Before the software can create an RDMA adapter handle with SoC, it needs to
create EQs for processing SoC events from RDMA device. Because MSI-X
vectors are shared between MANA Ethernet device and RDMA device, this
patch adds support to share EQs on MSI-X vectors and creates management
EQ for RDMA device.

Signed-off-by: Long Li <longli@microsoft.com>
---
 drivers/infiniband/hw/mana/device.c           |  13 ++
 drivers/infiniband/hw/mana/main.c             |  52 +++++++
 drivers/infiniband/hw/mana/mana_ib.h          |   4 +
 drivers/infiniband/hw/mana/qp.c               |  15 ++
 .../net/ethernet/microsoft/mana/gdma_main.c   | 147 ++++++++++--------
 drivers/net/ethernet/microsoft/mana/mana_en.c |   3 +
 include/net/mana/gdma.h                       |  14 +-
 7 files changed, 180 insertions(+), 68 deletions(-)

diff --git a/drivers/infiniband/hw/mana/device.c b/drivers/infiniband/hw/mana/device.c
index ee29ddf36cf3..3da4763e1a0c 100644
--- a/drivers/infiniband/hw/mana/device.c
+++ b/drivers/infiniband/hw/mana/device.c
@@ -85,6 +85,14 @@ static int mana_ib_probe(struct auxiliary_device *adev,
 	}
 	dev->gdma_dev = &mdev->gdma_context->mana_ib;
 
+	xa_init(&dev->rq_to_qp_lookup_table);
+
+	ret = mana_ib_create_error_eq(dev);
+	if (ret) {
+		ibdev_err(&dev->ib_dev, "Failed to allocate err eq");
+		goto deregister_device;
+	}
+
 	if (ret) {
 		ib_dealloc_device(&dev->ib_dev);
 		return ret;
@@ -100,6 +108,9 @@ static int mana_ib_probe(struct auxiliary_device *adev,
 	return 0;
 
 destroy_adapter:
+	mana_gd_destroy_queue(dev->gdma_dev->gdma_context, dev->fatal_err_eq);
+	xa_destroy(&dev->rq_to_qp_lookup_table);
+deregister_device:
 	mana_gd_deregister_device(dev->gdma_dev);
 free_ib_device:
 	ib_dealloc_device(&dev->ib_dev);
@@ -112,6 +123,8 @@ static void mana_ib_remove(struct auxiliary_device *adev)
 
 	ib_unregister_device(&dev->ib_dev);
 
+	mana_gd_destroy_queue(dev->gdma_dev->gdma_context, dev->fatal_err_eq);
+	xa_destroy(&dev->rq_to_qp_lookup_table);
 	mana_gd_deregister_device(dev->gdma_dev);
 
 	ib_dealloc_device(&dev->ib_dev);
diff --git a/drivers/infiniband/hw/mana/main.c b/drivers/infiniband/hw/mana/main.c
index 53730306ed9b..032f926bf1ab 100644
--- a/drivers/infiniband/hw/mana/main.c
+++ b/drivers/infiniband/hw/mana/main.c
@@ -521,3 +521,55 @@ int mana_ib_query_gid(struct ib_device *ibdev, u32 port, int index,
 void mana_ib_disassociate_ucontext(struct ib_ucontext *ibcontext)
 {
 }
+
+static void mana_ib_critical_event_handler(void *ctx, struct gdma_queue *queue,
+				      struct gdma_event *event)
+{
+	struct mana_ib_dev *dev = (struct mana_ib_dev *)ctx;
+	struct ib_event mib_event;
+	struct mana_ib_qp *qp;
+	u64 rq_id;
+
+	switch (event->type) {
+	case GDMA_EQE_SOC_EVENT_NOTIFICATION:
+		rq_id = event->details[0] & 0xFFFFFF;
+		qp = xa_load(&dev->rq_to_qp_lookup_table, rq_id);
+		mib_event.event = IB_EVENT_QP_FATAL;
+		mib_event.device = &dev->ib_dev;
+		if (qp && qp->ibqp.event_handler)
+			qp->ibqp.event_handler(&mib_event, qp->ibqp.qp_context);
+		else
+			ibdev_dbg(&dev->ib_dev, "found no qp or event handler");
+		ibdev_dbg(&dev->ib_dev, "Received critical notification");
+		break;
+	default:
+		ibdev_dbg(&dev->ib_dev, "Received unsolicited evt %d",
+			  event->type);
+	}
+}
+
+int mana_ib_create_error_eq(struct mana_ib_dev *dev)
+{
+	struct gdma_queue_spec spec = {};
+	int err;
+
+	spec.type = GDMA_EQ;
+	spec.monitor_avl_buf = false;
+	spec.queue_size = EQ_SIZE;
+	spec.eq.callback = mana_ib_critical_event_handler;
+	spec.eq.context = dev;
+	spec.eq.log2_throttle_limit = LOG2_EQ_THROTTLE;
+	spec.eq.msix_allocated = true;
+	spec.eq.msix_index = 0;
+	spec.doorbell = dev->gdma_dev->doorbell;
+	spec.pdid = dev->gdma_dev->pdid;
+
+	err = mana_gd_create_mana_eq(dev->gdma_dev, &spec,
+				     &dev->fatal_err_eq);
+	if (err)
+		return err;
+
+	dev->fatal_err_eq->eq.disable_needed = true;
+
+	return 0;
+}
diff --git a/drivers/infiniband/hw/mana/mana_ib.h b/drivers/infiniband/hw/mana/mana_ib.h
index 502cc8672eef..a5577c119def 100644
--- a/drivers/infiniband/hw/mana/mana_ib.h
+++ b/drivers/infiniband/hw/mana/mana_ib.h
@@ -30,6 +30,8 @@
 struct mana_ib_dev {
 	struct ib_device ib_dev;
 	struct gdma_dev *gdma_dev;
+	struct gdma_queue *fatal_err_eq;
+	struct xarray rq_to_qp_lookup_table;
 };
 
 struct mana_ib_wq {
@@ -159,4 +161,6 @@ int mana_ib_query_gid(struct ib_device *ibdev, u32 port, int index,
 
 void mana_ib_disassociate_ucontext(struct ib_ucontext *ibcontext);
 
+int mana_ib_create_error_eq(struct mana_ib_dev *mdev);
+
 #endif
diff --git a/drivers/infiniband/hw/mana/qp.c b/drivers/infiniband/hw/mana/qp.c
index ae45d28eef5e..7ff9c8364551 100644
--- a/drivers/infiniband/hw/mana/qp.c
+++ b/drivers/infiniband/hw/mana/qp.c
@@ -211,6 +211,11 @@ static int mana_ib_create_qp_rss(struct ib_qp *ibqp, struct ib_pd *pd,
 		wq->id = wq_spec.queue_index;
 		cq->id = cq_spec.queue_index;
 
+		ret = xa_err(xa_store(&mdev->rq_to_qp_lookup_table,
+				      wq->id, qp, GFP_KERNEL));
+		if (ret)
+			goto fail;
+
 		ibdev_dbg(&mdev->ib_dev,
 			  "ret %d rx_object 0x%llx wq id %llu cq id %llu\n",
 			  ret, wq->rx_object, wq->id, cq->id);
@@ -246,6 +251,7 @@ static int mana_ib_create_qp_rss(struct ib_qp *ibqp, struct ib_pd *pd,
 	while (i-- > 0) {
 		ibwq = ind_tbl->ind_tbl[i];
 		wq = container_of(ibwq, struct mana_ib_wq, ibwq);
+		xa_erase(&mdev->rq_to_qp_lookup_table, wq->id);
 		mana_destroy_wq_obj(mpc, GDMA_RQ, wq->rx_object);
 	}
 
@@ -372,6 +378,11 @@ static int mana_ib_create_qp_raw(struct ib_qp *ibqp, struct ib_pd *ibpd,
 	qp->sq_id = wq_spec.queue_index;
 	send_cq->id = cq_spec.queue_index;
 
+	err = xa_err(xa_store(&mdev->rq_to_qp_lookup_table,
+			      qp->sq_id, qp, GFP_KERNEL));
+	if (err)
+		goto err_destroy_wq_obj;
+
 	ibdev_dbg(&mdev->ib_dev,
 		  "ret %d qp->tx_object 0x%llx sq id %llu cq id %llu\n", err,
 		  qp->tx_object, qp->sq_id, send_cq->id);
@@ -388,9 +399,11 @@ static int mana_ib_create_qp_raw(struct ib_qp *ibqp, struct ib_pd *ibpd,
 		goto err_destroy_wq_obj;
 	}
 
+
 	return 0;
 
 err_destroy_wq_obj:
+	xa_erase(&mdev->rq_to_qp_lookup_table, qp->sq_id);
 	mana_destroy_wq_obj(mpc, GDMA_SQ, qp->tx_object);
 
 err_destroy_dma_region:
@@ -455,6 +468,7 @@ static int mana_ib_destroy_qp_rss(struct mana_ib_qp *qp,
 		wq = container_of(ibwq, struct mana_ib_wq, ibwq);
 		ibdev_dbg(&mdev->ib_dev, "destroying wq->rx_object %llu\n",
 			  wq->rx_object);
+		xa_erase(&mdev->rq_to_qp_lookup_table, wq->id);
 		mana_destroy_wq_obj(mpc, GDMA_RQ, wq->rx_object);
 	}
 
@@ -477,6 +491,7 @@ static int mana_ib_destroy_qp_raw(struct mana_ib_qp *qp, struct ib_udata *udata)
 	mpc = netdev_priv(ndev);
 	pd = container_of(ibpd, struct mana_ib_pd, ibpd);
 
+	xa_erase(&mdev->rq_to_qp_lookup_table, qp->sq_id);
 	mana_destroy_wq_obj(mpc, GDMA_SQ, qp->tx_object);
 
 	if (qp->sq_umem) {
diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/net/ethernet/microsoft/mana/gdma_main.c
index 02e50ed632ee..f368056d0b0b 100644
--- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
+++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
@@ -204,7 +204,8 @@ void mana_gd_free_memory(struct gdma_mem_info *gmi)
 }
 
 static int mana_gd_create_hw_eq(struct gdma_context *gc,
-				struct gdma_queue *queue)
+				struct gdma_queue *queue,
+				u32 doorbell, u32 pdid)
 {
 	struct gdma_create_queue_resp resp = {};
 	struct gdma_create_queue_req req = {};
@@ -218,8 +219,8 @@ static int mana_gd_create_hw_eq(struct gdma_context *gc,
 
 	req.hdr.dev_id = queue->gdma_dev->dev_id;
 	req.type = queue->type;
-	req.pdid = queue->gdma_dev->pdid;
-	req.doolbell_id = queue->gdma_dev->doorbell;
+	req.pdid = pdid;
+	req.doolbell_id = doorbell;
 	req.gdma_region = queue->mem_info.dma_region_handle;
 	req.queue_size = queue->queue_size;
 	req.log2_throttle_limit = queue->eq.log2_throttle_limit;
@@ -393,53 +394,51 @@ static void mana_gd_process_eqe(struct gdma_queue *eq)
 	}
 }
 
-static void mana_gd_process_eq_events(void *arg)
+static void mana_gd_process_eq_events(struct list_head *eq_list)
 {
 	u32 owner_bits, new_bits, old_bits;
 	union gdma_eqe_info eqe_info;
 	struct gdma_eqe *eq_eqe_ptr;
-	struct gdma_queue *eq = arg;
 	struct gdma_context *gc;
+	struct gdma_queue *eq;
 	struct gdma_eqe *eqe;
 	u32 head, num_eqe;
 	int i;
 
-	gc = eq->gdma_dev->gdma_context;
-
-	num_eqe = eq->queue_size / GDMA_EQE_SIZE;
-	eq_eqe_ptr = eq->queue_mem_ptr;
-
-	/* Process up to 5 EQEs at a time, and update the HW head. */
-	for (i = 0; i < 5; i++) {
-		eqe = &eq_eqe_ptr[eq->head % num_eqe];
-		eqe_info.as_uint32 = eqe->eqe_info;
-		owner_bits = eqe_info.owner_bits;
-
-		old_bits = (eq->head / num_eqe - 1) & GDMA_EQE_OWNER_MASK;
-		/* No more entries */
-		if (owner_bits == old_bits)
-			break;
-
-		new_bits = (eq->head / num_eqe) & GDMA_EQE_OWNER_MASK;
-		if (owner_bits != new_bits) {
-			dev_err(gc->dev, "EQ %d: overflow detected\n", eq->id);
-			break;
+	list_for_each_entry_rcu(eq, eq_list, entry) {
+		gc = eq->gdma_dev->gdma_context;
+
+		num_eqe = eq->queue_size / GDMA_EQE_SIZE;
+		eq_eqe_ptr = eq->queue_mem_ptr;
+		/* Process up to 5 EQEs at a time, and update the HW head. */
+		for (i = 0; i < 5; i++) {
+			eqe = &eq_eqe_ptr[eq->head % num_eqe];
+			eqe_info.as_uint32 = eqe->eqe_info;
+			owner_bits = eqe_info.owner_bits;
+
+			old_bits = (eq->head / num_eqe - 1) & GDMA_EQE_OWNER_MASK;
+			/* No more entries */
+			if (owner_bits == old_bits)
+				break;
+
+			new_bits = (eq->head / num_eqe) & GDMA_EQE_OWNER_MASK;
+			if (owner_bits != new_bits) {
+				dev_err(gc->dev, "EQ %d: overflow detected\n",
+					eq->id);
+				break;
+			}
+			/* Per GDMA spec, rmb is necessary after checking owner_bits, before
+			 * reading eqe.
+			 */
+			rmb();
+			mana_gd_process_eqe(eq);
+			eq->head++;
 		}
 
-		/* Per GDMA spec, rmb is necessary after checking owner_bits, before
-		 * reading eqe.
-		 */
-		rmb();
-
-		mana_gd_process_eqe(eq);
-
-		eq->head++;
+		head = eq->head % (num_eqe << GDMA_EQE_OWNER_BITS);
+		mana_gd_ring_doorbell(gc, eq->gdma_dev->doorbell, eq->type,
+				      eq->id, head, SET_ARM_BIT);
 	}
-
-	head = eq->head % (num_eqe << GDMA_EQE_OWNER_BITS);
-
-	mana_gd_ring_doorbell(gc, eq->gdma_dev->doorbell, eq->type, eq->id,
-			      head, SET_ARM_BIT);
 }
 
 static int mana_gd_register_irq(struct gdma_queue *queue,
@@ -457,45 +456,48 @@ static int mana_gd_register_irq(struct gdma_queue *queue,
 	gc = gd->gdma_context;
 	r = &gc->msix_resource;
 	dev = gc->dev;
+	msi_index = spec->eq.msix_index;
 
 	spin_lock_irqsave(&r->lock, flags);
 
-	msi_index = find_first_zero_bit(r->map, r->size);
-	if (msi_index >= r->size || msi_index >= gc->num_msix_usable) {
-		err = -ENOSPC;
-	} else {
-		bitmap_set(r->map, msi_index, 1);
-		queue->eq.msix_index = msi_index;
-	}
-
-	spin_unlock_irqrestore(&r->lock, flags);
+	if (!spec->eq.msix_allocated) {
+		msi_index = find_first_zero_bit(r->map, r->size);
 
-	if (err) {
-		dev_err(dev, "Register IRQ err:%d, msi:%u rsize:%u, nMSI:%u",
-			err, msi_index, r->size, gc->num_msix_usable);
+		if (msi_index >= r->size ||
+		    msi_index >= gc->num_msix_usable)
+			err = -ENOSPC;
+		else
+			bitmap_set(r->map, msi_index, 1);
 
-		return err;
+		if (err) {
+			dev_err(dev, "Register IRQ err:%d, msi:%u rsize:%u, nMSI:%u",
+				err, msi_index, r->size, gc->num_msix_usable);
+				goto out;
+		}
 	}
 
+	queue->eq.msix_index = msi_index;
 	gic = &gc->irq_contexts[msi_index];
 
-	WARN_ON(gic->handler || gic->arg);
-
-	gic->arg = queue;
+	list_add_rcu(&queue->entry, &gic->eq_list);
 
 	gic->handler = mana_gd_process_eq_events;
 
-	return 0;
+out:
+	spin_unlock_irqrestore(&r->lock, flags);
+	return err;
 }
 
-static void mana_gd_deregiser_irq(struct gdma_queue *queue)
+static void mana_gd_deregister_irq(struct gdma_queue *queue)
 {
 	struct gdma_dev *gd = queue->gdma_dev;
 	struct gdma_irq_context *gic;
 	struct gdma_context *gc;
 	struct gdma_resource *r;
 	unsigned int msix_index;
+	struct gdma_queue *eq;
 	unsigned long flags;
+	struct list_head *p;
 
 	gc = gd->gdma_context;
 	r = &gc->msix_resource;
@@ -505,14 +507,24 @@ static void mana_gd_deregiser_irq(struct gdma_queue *queue)
 	if (WARN_ON(msix_index >= gc->num_msix_usable))
 		return;
 
+	spin_lock_irqsave(&r->lock, flags);
+
 	gic = &gc->irq_contexts[msix_index];
-	gic->handler = NULL;
-	gic->arg = NULL;
+	list_for_each_rcu(p, &gic->eq_list) {
+		eq = list_entry(p, struct gdma_queue, entry);
+		if (queue == eq) {
+			list_del(&eq->entry);
+			synchronize_rcu();
+			break;
+		}
+	}
 
-	spin_lock_irqsave(&r->lock, flags);
-	bitmap_clear(r->map, msix_index, 1);
-	spin_unlock_irqrestore(&r->lock, flags);
+	if (list_empty(&gic->eq_list)) {
+		gic->handler = NULL;
+		bitmap_clear(r->map, msix_index, 1);
+	}
 
+	spin_unlock_irqrestore(&r->lock, flags);
 	queue->eq.msix_index = INVALID_PCI_MSIX_INDEX;
 }
 
@@ -575,7 +587,7 @@ static void mana_gd_destroy_eq(struct gdma_context *gc, bool flush_evenets,
 			dev_warn(gc->dev, "Failed to flush EQ: %d\n", err);
 	}
 
-	mana_gd_deregiser_irq(queue);
+	mana_gd_deregister_irq(queue);
 
 	if (queue->eq.disable_needed)
 		mana_gd_disable_queue(queue);
@@ -590,7 +602,7 @@ static int mana_gd_create_eq(struct gdma_dev *gd,
 	u32 log2_num_entries;
 	int err;
 
-	queue->eq.msix_index = INVALID_PCI_MSIX_INDEX;
+	queue->eq.msix_index = spec->eq.msix_index;
 
 	log2_num_entries = ilog2(queue->queue_size / GDMA_EQE_SIZE);
 
@@ -612,7 +624,8 @@ static int mana_gd_create_eq(struct gdma_dev *gd,
 	queue->eq.log2_throttle_limit = spec->eq.log2_throttle_limit ?: 1;
 
 	if (create_hwq) {
-		err = mana_gd_create_hw_eq(gc, queue);
+		err = mana_gd_create_hw_eq(gc, queue,
+					   spec->doorbell, spec->pdid);
 		if (err)
 			goto out;
 
@@ -822,6 +835,7 @@ int mana_gd_create_mana_eq(struct gdma_dev *gd,
 	kfree(queue);
 	return err;
 }
+EXPORT_SYMBOL(mana_gd_create_mana_eq);
 
 int mana_gd_create_mana_wq_cq(struct gdma_dev *gd,
 			      const struct gdma_queue_spec *spec,
@@ -898,6 +912,7 @@ void mana_gd_destroy_queue(struct gdma_context *gc, struct gdma_queue *queue)
 	mana_gd_free_memory(gmi);
 	kfree(queue);
 }
+EXPORT_SYMBOL(mana_gd_destroy_queue);
 
 int mana_gd_verify_vf_version(struct pci_dev *pdev)
 {
@@ -1224,7 +1239,7 @@ static irqreturn_t mana_gd_intr(int irq, void *arg)
 	struct gdma_irq_context *gic = arg;
 
 	if (gic->handler)
-		gic->handler(gic->arg);
+		gic->handler(&gic->eq_list);
 
 	return IRQ_HANDLED;
 }
@@ -1277,7 +1292,7 @@ static int mana_gd_setup_irqs(struct pci_dev *pdev)
 	for (i = 0; i < nvec; i++) {
 		gic = &gc->irq_contexts[i];
 		gic->handler = NULL;
-		gic->arg = NULL;
+		INIT_LIST_HEAD(&gic->eq_list);
 
 		if (!i)
 			snprintf(gic->name, MANA_IRQ_NAME_SZ, "mana_hwc@pci:%s",
diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index fc3d2903a80f..abf63f405940 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -1242,6 +1242,9 @@ static int mana_create_eq(struct mana_context *ac)
 	spec.eq.callback = NULL;
 	spec.eq.context = ac->eqs;
 	spec.eq.log2_throttle_limit = LOG2_EQ_THROTTLE;
+	spec.eq.msix_allocated = false;
+	spec.doorbell = gd->doorbell;
+	spec.pdid = gd->pdid;
 
 	for (i = 0; i < gc->max_num_queues; i++) {
 		err = mana_gd_create_mana_eq(gd, &spec, &ac->eqs[i].eq);
diff --git a/include/net/mana/gdma.h b/include/net/mana/gdma.h
index 000f0d7670f7..e32c75639557 100644
--- a/include/net/mana/gdma.h
+++ b/include/net/mana/gdma.h
@@ -60,6 +60,11 @@ enum gdma_eqe_type {
 	GDMA_EQE_HWC_INIT_DONE		= 131,
 	GDMA_EQE_HWC_SOC_RECONFIG	= 132,
 	GDMA_EQE_HWC_SOC_RECONFIG_DATA	= 133,
+
+	/* RDMA SOC Events */
+	GDMA_EQE_SOC_EVENT_NOTIFICATION = 176,
+	GDMA_EQE_SOC_EVENT_TEST = 177,
+
 };
 
 enum {
@@ -294,6 +299,7 @@ struct gdma_queue {
 
 	u32 head;
 	u32 tail;
+	struct list_head entry;
 
 	/* Extra fields specific to EQ/CQ. */
 	union {
@@ -321,6 +327,8 @@ struct gdma_queue_spec {
 	enum gdma_queue_type type;
 	bool monitor_avl_buf;
 	unsigned int queue_size;
+	u32 doorbell;
+	u32 pdid;
 
 	/* Extra fields specific to EQ/CQ. */
 	union {
@@ -329,6 +337,8 @@ struct gdma_queue_spec {
 			void *context;
 
 			unsigned long log2_throttle_limit;
+			bool msix_allocated;
+			unsigned int msix_index;
 		} eq;
 
 		struct {
@@ -344,8 +354,8 @@ struct gdma_queue_spec {
 #define MANA_IRQ_NAME_SZ 32
 
 struct gdma_irq_context {
-	void (*handler)(void *arg);
-	void *arg;
+	void (*handler)(struct list_head *arg);
+	struct list_head eq_list;
 	char name[MANA_IRQ_NAME_SZ];
 };
 
-- 
2.34.1


