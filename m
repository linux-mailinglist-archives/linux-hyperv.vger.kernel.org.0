Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7431576403C
	for <lists+linux-hyperv@lfdr.de>; Wed, 26 Jul 2023 22:08:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231675AbjGZUIf (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 26 Jul 2023 16:08:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231245AbjGZUIb (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 26 Jul 2023 16:08:31 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 071512703;
        Wed, 26 Jul 2023 13:08:29 -0700 (PDT)
Received: by linux.microsoft.com (Postfix, from userid 1174)
        id 967042383123; Wed, 26 Jul 2023 13:08:28 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 967042383123
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxonhyperv.com;
        s=default; t=1690402108;
        bh=PwwJfLB03F8EZKJX5ZJOsl+GO9Urq8QBa84Mq4fm+wc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d3Jge8vtq8EzaAKIg0DuSLbI3owLetSnSH5IucptQq7H0x9mUCML5b9mXYw0zHHo3
         cEopp4LMPrQUqplJ195lEKFh0Woku/MJ8HNZ6Ih/uEyN/hiBZ0RpXDxnFuZ1wfdga2
         IVUDOmeyd2SFnXQ3WzVV+Kef5EMHsZgnuHDsE97o=
From:   sharmaajay@linuxonhyperv.com
To:     Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        Dexuan Cui <decui@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     linux-rdma@vger.kernel.org, linux-hyperv@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ajay Sharma <sharmaajay@microsoft.com>
Subject: [Patch v3 3/4] RDMA/mana_ib : Create adapter and Add error eq
Date:   Wed, 26 Jul 2023 13:08:23 -0700
Message-Id: <1690402104-29518-4-git-send-email-sharmaajay@linuxonhyperv.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1690402104-29518-1-git-send-email-sharmaajay@linuxonhyperv.com>
References: <1690402104-29518-1-git-send-email-sharmaajay@linuxonhyperv.com>
X-Spam-Status: No, score=-11.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Ajay Sharma <sharmaajay@microsoft.com>

Create adapter object as nice container for VF resources.
Add error eq needed for adapter creation and later used
for notification from Management SW. The management
software uses this channel to send messages or error
notifications back to the Client.

Signed-off-by: Ajay Sharma <sharmaajay@microsoft.com>
---
 drivers/infiniband/hw/mana/device.c           |  22 ++-
 drivers/infiniband/hw/mana/main.c             |  95 ++++++++++++
 drivers/infiniband/hw/mana/mana_ib.h          |  33 ++++
 .../net/ethernet/microsoft/mana/gdma_main.c   | 146 ++++++++++--------
 drivers/net/ethernet/microsoft/mana/mana_en.c |   3 +
 include/net/mana/gdma.h                       |  13 +-
 6 files changed, 242 insertions(+), 70 deletions(-)

diff --git a/drivers/infiniband/hw/mana/device.c b/drivers/infiniband/hw/mana/device.c
index ea4c8c8fc10d..4077e440657a 100644
--- a/drivers/infiniband/hw/mana/device.c
+++ b/drivers/infiniband/hw/mana/device.c
@@ -68,7 +68,7 @@ static int mana_ib_probe(struct auxiliary_device *adev,
 	ibdev_dbg(&mib_dev->ib_dev, "mdev=%p id=%d num_ports=%d\n", mdev,
 		  mdev->dev_id.as_uint32, mib_dev->ib_dev.phys_port_cnt);
 
-	mib_dev->gdma_dev = mdev;
+	mib_dev->gc = mdev->gdma_context;
 	mib_dev->ib_dev.node_type = RDMA_NODE_IB_CA;
 
 	/*
@@ -85,15 +85,31 @@ static int mana_ib_probe(struct auxiliary_device *adev,
 		goto free_ib_device;
 	}
 
+	ret = mana_ib_create_error_eq(mib_dev);
+	if (ret) {
+		ibdev_err(&mib_dev->ib_dev, "Failed to allocate err eq");
+		goto deregister_device;
+	}
+
+	ret = mana_ib_create_adapter(mib_dev);
+	if (ret) {
+		ibdev_err(&mib_dev->ib_dev, "Failed to create adapter");
+		goto free_error_eq;
+	}
+
 	ret = ib_register_device(&mib_dev->ib_dev, "mana_%d",
 				 mdev->gdma_context->dev);
 	if (ret)
-		goto deregister_device;
+		goto destroy_adapter;
 
 	dev_set_drvdata(&adev->dev, mib_dev);
 
 	return 0;
 
+destroy_adapter:
+	mana_ib_destroy_adapter(mib_dev);
+free_error_eq:
+	mana_gd_destroy_queue(mib_dev->gc, mib_dev->fatal_err_eq);
 deregister_device:
 	mana_gd_deregister_device(&mib_dev->gc->mana_ib);
 free_ib_device:
@@ -105,6 +121,8 @@ static void mana_ib_remove(struct auxiliary_device *adev)
 {
 	struct mana_ib_dev *mib_dev = dev_get_drvdata(&adev->dev);
 
+	mana_gd_destroy_queue(mib_dev->gc, mib_dev->fatal_err_eq);
+	mana_ib_destroy_adapter(mib_dev);
 	mana_gd_deregister_device(&mib_dev->gc->mana_ib);
 	ib_unregister_device(&mib_dev->ib_dev);
 	ib_dealloc_device(&mib_dev->ib_dev);
diff --git a/drivers/infiniband/hw/mana/main.c b/drivers/infiniband/hw/mana/main.c
index 2c4e3c496644..1b1a8670d0fa 100644
--- a/drivers/infiniband/hw/mana/main.c
+++ b/drivers/infiniband/hw/mana/main.c
@@ -504,3 +504,98 @@ int mana_ib_query_gid(struct ib_device *ibdev, u32 port, int index,
 void mana_ib_disassociate_ucontext(struct ib_ucontext *ibcontext)
 {
 }
+
+int mana_ib_destroy_adapter(struct mana_ib_dev *mib_dev)
+{
+	struct mana_ib_destroy_adapter_resp resp = {};
+	struct mana_ib_destroy_adapter_req req = {};
+	struct gdma_context *gc;
+	int err;
+
+	gc = mib_dev->gc;
+
+	mana_gd_init_req_hdr(&req.hdr, MANA_IB_DESTROY_ADAPTER, sizeof(req),
+			     sizeof(resp));
+	req.adapter = mib_dev->adapter_handle;
+	req.hdr.dev_id = gc->mana_ib.dev_id;
+
+	err = mana_gd_send_request(gc, sizeof(req), &req, sizeof(resp), &resp);
+
+	if (err) {
+		ibdev_err(&mib_dev->ib_dev, "Failed to destroy adapter err %d", err);
+		return err;
+	}
+
+	return 0;
+}
+
+int mana_ib_create_adapter(struct mana_ib_dev *mib_dev)
+{
+	struct mana_ib_create_adapter_resp resp = {};
+	struct mana_ib_create_adapter_req req = {};
+	struct gdma_context *gc;
+	int err;
+
+	gc = mib_dev->gc;
+
+	mana_gd_init_req_hdr(&req.hdr, MANA_IB_CREATE_ADAPTER, sizeof(req),
+			     sizeof(resp));
+	req.notify_eq_id = mib_dev->fatal_err_eq->id;
+	req.hdr.dev_id = gc->mana_ib.dev_id;
+
+	err = mana_gd_send_request(gc, sizeof(req), &req, sizeof(resp), &resp);
+
+	if (err) {
+		ibdev_err(&mib_dev->ib_dev, "Failed to create adapter err %d",
+			  err);
+		return err;
+	}
+
+	mib_dev->adapter_handle = resp.adapter;
+
+	return 0;
+}
+
+static void mana_ib_soc_event_handler(void *ctx, struct gdma_queue *queue,
+				      struct gdma_event *event)
+{
+	struct mana_ib_dev *mib_dev = (struct mana_ib_dev *)ctx;
+
+	switch (event->type) {
+	case GDMA_EQE_SOC_EVENT_NOTIFICATION:
+		ibdev_info(&mib_dev->ib_dev, "Received SOC Notification");
+		break;
+	case GDMA_EQE_SOC_EVENT_TEST:
+		ibdev_info(&mib_dev->ib_dev, "Received SoC Test");
+		break;
+	default:
+		ibdev_dbg(&mib_dev->ib_dev, "Received unsolicited evt %d",
+			  event->type);
+	}
+}
+
+int mana_ib_create_error_eq(struct mana_ib_dev *mib_dev)
+{
+	struct gdma_queue_spec spec = {};
+	int err;
+
+	spec.type = GDMA_EQ;
+	spec.monitor_avl_buf = false;
+	spec.queue_size = EQ_SIZE;
+	spec.eq.callback = mana_ib_soc_event_handler;
+	spec.eq.context = mib_dev;
+	spec.eq.log2_throttle_limit = LOG2_EQ_THROTTLE;
+	spec.eq.msix_allocated = true;
+	spec.eq.msix_index = 0;
+	spec.doorbell = mib_dev->gc->mana_ib.doorbell;
+	spec.pdid = mib_dev->gc->mana_ib.pdid;
+
+	err = mana_gd_create_mana_eq(&mib_dev->gc->mana_ib, &spec,
+				     &mib_dev->fatal_err_eq);
+	if (err)
+		return err;
+
+	mib_dev->fatal_err_eq->eq.disable_needed = true;
+
+	return 0;
+}
diff --git a/drivers/infiniband/hw/mana/mana_ib.h b/drivers/infiniband/hw/mana/mana_ib.h
index 3a2ba6b96f15..8a652bccd978 100644
--- a/drivers/infiniband/hw/mana/mana_ib.h
+++ b/drivers/infiniband/hw/mana/mana_ib.h
@@ -31,6 +31,8 @@ struct mana_ib_dev {
 	struct ib_device ib_dev;
 	struct gdma_dev *gdma_dev;
 	struct gdma_context *gc;
+	struct gdma_queue *fatal_err_eq;
+	mana_handle_t adapter_handle;
 };
 
 struct mana_ib_wq {
@@ -93,6 +95,31 @@ struct mana_ib_rwq_ind_table {
 	struct ib_rwq_ind_table ib_ind_table;
 };
 
+enum mana_ib_command_code {
+	MANA_IB_CREATE_ADAPTER  = 0x30002,
+	MANA_IB_DESTROY_ADAPTER = 0x30003,
+};
+
+struct mana_ib_create_adapter_req {
+	struct gdma_req_hdr hdr;
+	u32 notify_eq_id;
+	u32 reserved;
+}; /*HW Data */
+
+struct mana_ib_create_adapter_resp {
+	struct gdma_resp_hdr hdr;
+	mana_handle_t adapter;
+}; /* HW Data */
+
+struct mana_ib_destroy_adapter_req {
+	struct gdma_req_hdr hdr;
+	mana_handle_t adapter;
+}; /*HW Data */
+
+struct mana_ib_destroy_adapter_resp {
+	struct gdma_resp_hdr hdr;
+}; /* HW Data */
+
 int mana_ib_gd_create_dma_region(struct mana_ib_dev *mib_dev,
 				 struct ib_umem *umem,
 				 mana_handle_t *gdma_region);
@@ -161,4 +188,10 @@ int mana_ib_query_gid(struct ib_device *ibdev, u32 port, int index,
 
 void mana_ib_disassociate_ucontext(struct ib_ucontext *ibcontext);
 
+int mana_ib_create_error_eq(struct mana_ib_dev *mib_dev);
+
+int mana_ib_create_adapter(struct mana_ib_dev *mib_dev);
+
+int mana_ib_destroy_adapter(struct mana_ib_dev *mib_dev);
+
 #endif
diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/net/ethernet/microsoft/mana/gdma_main.c
index 9fa7a2d6c2b2..55e194c9d84e 100644
--- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
+++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
@@ -185,7 +185,8 @@ void mana_gd_free_memory(struct gdma_mem_info *gmi)
 }
 
 static int mana_gd_create_hw_eq(struct gdma_context *gc,
-				struct gdma_queue *queue)
+				struct gdma_queue *queue,
+				u32 doorbell, u32 pdid)
 {
 	struct gdma_create_queue_resp resp = {};
 	struct gdma_create_queue_req req = {};
@@ -199,8 +200,8 @@ static int mana_gd_create_hw_eq(struct gdma_context *gc,
 
 	req.hdr.dev_id = queue->gdma_dev->dev_id;
 	req.type = queue->type;
-	req.pdid = queue->gdma_dev->pdid;
-	req.doolbell_id = queue->gdma_dev->doorbell;
+	req.pdid = pdid;
+	req.doolbell_id = doorbell;
 	req.gdma_region = queue->mem_info.dma_region_handle;
 	req.queue_size = queue->queue_size;
 	req.log2_throttle_limit = queue->eq.log2_throttle_limit;
@@ -371,53 +372,51 @@ static void mana_gd_process_eqe(struct gdma_queue *eq)
 	}
 }
 
-static void mana_gd_process_eq_events(void *arg)
+static void mana_gd_process_eq_events(struct list_head *eq_list)
 {
 	u32 owner_bits, new_bits, old_bits;
 	union gdma_eqe_info eqe_info;
 	struct gdma_eqe *eq_eqe_ptr;
-	struct gdma_queue *eq = arg;
+	struct gdma_queue *eq;
 	struct gdma_context *gc;
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
@@ -435,44 +434,47 @@ static int mana_gd_register_irq(struct gdma_queue *queue,
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
+	struct list_head *p, *n;
+	struct gdma_queue *eq;
 	unsigned long flags;
 
 	gc = gd->gdma_context;
@@ -483,14 +485,23 @@ static void mana_gd_deregiser_irq(struct gdma_queue *queue)
 	if (WARN_ON(msix_index >= gc->num_msix_usable))
 		return;
 
+	spin_lock_irqsave(&r->lock, flags);
+
 	gic = &gc->irq_contexts[msix_index];
-	gic->handler = NULL;
-	gic->arg = NULL;
+	list_for_each_safe(p, n, &gic->eq_list) {
+		eq = list_entry(p, struct gdma_queue, entry);
+		if (queue == eq) {
+			list_del(&eq->entry);
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
 
@@ -553,7 +564,7 @@ static void mana_gd_destroy_eq(struct gdma_context *gc, bool flush_evenets,
 			dev_warn(gc->dev, "Failed to flush EQ: %d\n", err);
 	}
 
-	mana_gd_deregiser_irq(queue);
+	mana_gd_deregister_irq(queue);
 
 	if (queue->eq.disable_needed)
 		mana_gd_disable_queue(queue);
@@ -568,7 +579,7 @@ static int mana_gd_create_eq(struct gdma_dev *gd,
 	u32 log2_num_entries;
 	int err;
 
-	queue->eq.msix_index = INVALID_PCI_MSIX_INDEX;
+	queue->eq.msix_index = spec->eq.msix_index;
 
 	log2_num_entries = ilog2(queue->queue_size / GDMA_EQE_SIZE);
 
@@ -590,7 +601,8 @@ static int mana_gd_create_eq(struct gdma_dev *gd,
 	queue->eq.log2_throttle_limit = spec->eq.log2_throttle_limit ?: 1;
 
 	if (create_hwq) {
-		err = mana_gd_create_hw_eq(gc, queue);
+		err = mana_gd_create_hw_eq(gc, queue,
+					   spec->doorbell, spec->pdid);
 		if (err)
 			goto out;
 
@@ -800,6 +812,7 @@ int mana_gd_create_mana_eq(struct gdma_dev *gd,
 	kfree(queue);
 	return err;
 }
+EXPORT_SYMBOL(mana_gd_create_mana_eq);
 
 int mana_gd_create_mana_wq_cq(struct gdma_dev *gd,
 			      const struct gdma_queue_spec *spec,
@@ -876,6 +889,7 @@ void mana_gd_destroy_queue(struct gdma_context *gc, struct gdma_queue *queue)
 	mana_gd_free_memory(gmi);
 	kfree(queue);
 }
+EXPORT_SYMBOL(mana_gd_destroy_queue);
 
 int mana_gd_verify_vf_version(struct pci_dev *pdev)
 {
@@ -1193,7 +1207,7 @@ static irqreturn_t mana_gd_intr(int irq, void *arg)
 	struct gdma_irq_context *gic = arg;
 
 	if (gic->handler)
-		gic->handler(gic->arg);
+		gic->handler(&gic->eq_list);
 
 	return IRQ_HANDLED;
 }
@@ -1246,7 +1260,7 @@ static int mana_gd_setup_irqs(struct pci_dev *pdev)
 	for (i = 0; i < nvec; i++) {
 		gic = &gc->irq_contexts[i];
 		gic->handler = NULL;
-		gic->arg = NULL;
+		INIT_LIST_HEAD(&gic->eq_list);
 
 		if (!i)
 			snprintf(gic->name, MANA_IRQ_NAME_SZ, "mana_hwc@pci:%s",
diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index a499e460594b..d2ba7de8b512 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -1167,6 +1167,9 @@ static int mana_create_eq(struct mana_context *ac)
 	spec.eq.callback = NULL;
 	spec.eq.context = ac->eqs;
 	spec.eq.log2_throttle_limit = LOG2_EQ_THROTTLE;
+	spec.eq.msix_allocated = false;
+	spec.doorbell = gd->doorbell;
+	spec.pdid = gd->pdid;
 
 	for (i = 0; i < gc->max_num_queues; i++) {
 		err = mana_gd_create_mana_eq(gd, &spec, &ac->eqs[i].eq);
diff --git a/include/net/mana/gdma.h b/include/net/mana/gdma.h
index e2b212dd722b..aee8e8fa1ea6 100644
--- a/include/net/mana/gdma.h
+++ b/include/net/mana/gdma.h
@@ -57,6 +57,10 @@ enum gdma_eqe_type {
 	GDMA_EQE_HWC_INIT_EQ_ID_DB	= 129,
 	GDMA_EQE_HWC_INIT_DATA		= 130,
 	GDMA_EQE_HWC_INIT_DONE		= 131,
+
+	/* IB NiC  Events start at 176*/
+	GDMA_EQE_SOC_EVENT_NOTIFICATION = 176,
+	GDMA_EQE_SOC_EVENT_TEST,
 };
 
 enum {
@@ -291,6 +295,7 @@ struct gdma_queue {
 
 	u32 head;
 	u32 tail;
+	struct list_head entry;
 
 	/* Extra fields specific to EQ/CQ. */
 	union {
@@ -318,6 +323,8 @@ struct gdma_queue_spec {
 	enum gdma_queue_type type;
 	bool monitor_avl_buf;
 	unsigned int queue_size;
+	u32 doorbell;
+	u32 pdid;
 
 	/* Extra fields specific to EQ/CQ. */
 	union {
@@ -326,6 +333,8 @@ struct gdma_queue_spec {
 			void *context;
 
 			unsigned long log2_throttle_limit;
+			bool msix_allocated;
+			unsigned int msix_index;
 		} eq;
 
 		struct {
@@ -341,8 +350,8 @@ struct gdma_queue_spec {
 #define MANA_IRQ_NAME_SZ 32
 
 struct gdma_irq_context {
-	void (*handler)(void *arg);
-	void *arg;
+	void (*handler)(struct list_head *arg);
+	struct list_head eq_list;
 	char name[MANA_IRQ_NAME_SZ];
 };
 
-- 
2.25.1

