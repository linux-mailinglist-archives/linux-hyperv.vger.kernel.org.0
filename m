Return-Path: <linux-hyperv+bounces-1331-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE3CB8124C9
	for <lists+linux-hyperv@lfdr.de>; Thu, 14 Dec 2023 02:52:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57D671F21A26
	for <lists+linux-hyperv@lfdr.de>; Thu, 14 Dec 2023 01:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E18C9803;
	Thu, 14 Dec 2023 01:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxonhyperv.com header.i=@linuxonhyperv.com header.b="YbMJ56a7"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 37659D5;
	Wed, 13 Dec 2023 17:51:58 -0800 (PST)
Received: by linux.microsoft.com (Postfix, from userid 1004)
	id BF40820B74C2; Wed, 13 Dec 2023 17:51:57 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com BF40820B74C2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxonhyperv.com;
	s=default; t=1702518717;
	bh=9DmiYK6vtk0UEVfpM1tbiCZ5HYhsJr5J6AvvsY08cw4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YbMJ56a78S73TMrA0MoZnjg+RRB7vAjF43gAYd6W4b3QxRfcYp5DaKMA+gGSAdydF
	 30mAKg63OeH/1GPDLedLlseC+9e/Ea9lTaodMwnGwq3bbb4QkZJm1UHbfRh+10oV/e
	 /szJyUYgQ3H4afvWloanYfZPbxxSfbOFAYo796eU=
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
Subject: [Patch v3 3/3] RDMA/mana_ib: Add CQ interrupt support for RAW QP
Date: Wed, 13 Dec 2023 17:51:44 -0800
Message-Id: <1702518704-15886-4-git-send-email-longli@linuxonhyperv.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1702518704-15886-1-git-send-email-longli@linuxonhyperv.com>
References: <1702518704-15886-1-git-send-email-longli@linuxonhyperv.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

From: Long Li <longli@microsoft.com>

At probing time, the MANA core code allocates EQs for supporting interrupts
on Ethernet queues. The same interrupt mechanisum is used by RAW QP.

Use the same EQs for delivering interrupts on the CQ for the RAW QP.

Signed-off-by: Long Li <longli@microsoft.com>
---
Change in v3:
Removed unused varaible mana_ucontext in mana_ib_create_qp_rss().
Simplified error handling in mana_ib_create_qp_rss() on failure to allocate queues for rss table.

 drivers/infiniband/hw/mana/cq.c      | 32 +++++++++++-
 drivers/infiniband/hw/mana/mana_ib.h |  3 ++
 drivers/infiniband/hw/mana/qp.c      | 73 ++++++++++++++++++++++++++--
 3 files changed, 102 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/hw/mana/cq.c b/drivers/infiniband/hw/mana/cq.c
index 09a2c263e39b..83ebd070535a 100644
--- a/drivers/infiniband/hw/mana/cq.c
+++ b/drivers/infiniband/hw/mana/cq.c
@@ -12,13 +12,20 @@ int mana_ib_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 	struct ib_device *ibdev = ibcq->device;
 	struct mana_ib_create_cq ucmd = {};
 	struct mana_ib_dev *mdev;
+	struct gdma_context *gc;
 	int err;
 
 	mdev = container_of(ibdev, struct mana_ib_dev, ib_dev);
+	gc = mdev->gdma_dev->gdma_context;
 
 	if (udata->inlen < sizeof(ucmd))
 		return -EINVAL;
 
+	if (attr->comp_vector > gc->max_num_queues)
+		return -EINVAL;
+
+	cq->comp_vector = attr->comp_vector;
+
 	err = ib_copy_from_udata(&ucmd, udata, min(sizeof(ucmd), udata->inlen));
 	if (err) {
 		ibdev_dbg(ibdev,
@@ -56,6 +63,7 @@ int mana_ib_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 	/*
 	 * The CQ ID is not known at this time. The ID is generated at create_qp
 	 */
+	cq->id = INVALID_QUEUE_ID;
 
 	return 0;
 
@@ -69,11 +77,33 @@ int mana_ib_destroy_cq(struct ib_cq *ibcq, struct ib_udata *udata)
 	struct mana_ib_cq *cq = container_of(ibcq, struct mana_ib_cq, ibcq);
 	struct ib_device *ibdev = ibcq->device;
 	struct mana_ib_dev *mdev;
+	struct gdma_context *gc;
+	int err;
 
 	mdev = container_of(ibdev, struct mana_ib_dev, ib_dev);
+	gc = mdev->gdma_dev->gdma_context;
+
+	err = mana_ib_gd_destroy_dma_region(mdev, cq->gdma_region);
+	if (err) {
+		ibdev_dbg(ibdev,
+			  "Failed to destroy dma region, %d\n", err);
+		return err;
+	}
+
+	if (cq->id != INVALID_QUEUE_ID) {
+		kfree(gc->cq_table[cq->id]);
+		gc->cq_table[cq->id] = NULL;
+	}
 
-	mana_ib_gd_destroy_dma_region(mdev, cq->gdma_region);
 	ib_umem_release(cq->umem);
 
 	return 0;
 }
+
+void mana_ib_cq_handler(void *ctx, struct gdma_queue *gdma_cq)
+{
+	struct mana_ib_cq *cq = ctx;
+
+	if (cq->ibcq.comp_handler)
+		cq->ibcq.comp_handler(&cq->ibcq, cq->ibcq.cq_context);
+}
diff --git a/drivers/infiniband/hw/mana/mana_ib.h b/drivers/infiniband/hw/mana/mana_ib.h
index 7cb3d8ee4292..53bb4905afd5 100644
--- a/drivers/infiniband/hw/mana/mana_ib.h
+++ b/drivers/infiniband/hw/mana/mana_ib.h
@@ -86,6 +86,7 @@ struct mana_ib_cq {
 	int cqe;
 	u64 gdma_region;
 	u64 id;
+	u32 comp_vector;
 };
 
 struct mana_ib_qp {
@@ -209,4 +210,6 @@ int mana_ib_query_gid(struct ib_device *ibdev, u32 port, int index,
 void mana_ib_disassociate_ucontext(struct ib_ucontext *ibcontext);
 
 int mana_ib_query_adapter_caps(struct mana_ib_dev *mdev);
+
+void mana_ib_cq_handler(void *ctx, struct gdma_queue *gdma_cq);
 #endif
diff --git a/drivers/infiniband/hw/mana/qp.c b/drivers/infiniband/hw/mana/qp.c
index 4667b18ec1dd..19998082a376 100644
--- a/drivers/infiniband/hw/mana/qp.c
+++ b/drivers/infiniband/hw/mana/qp.c
@@ -102,21 +102,26 @@ static int mana_ib_create_qp_rss(struct ib_qp *ibqp, struct ib_pd *pd,
 	struct ib_rwq_ind_table *ind_tbl = attr->rwq_ind_tbl;
 	struct mana_ib_create_qp_rss_resp resp = {};
 	struct mana_ib_create_qp_rss ucmd = {};
+	struct gdma_queue **gdma_cq_allocated;
 	mana_handle_t *mana_ind_table;
 	struct mana_port_context *mpc;
+	struct gdma_queue *gdma_cq;
 	unsigned int ind_tbl_size;
 	struct mana_context *mc;
 	struct net_device *ndev;
+	struct gdma_context *gc;
 	struct mana_ib_cq *cq;
 	struct mana_ib_wq *wq;
 	struct gdma_dev *gd;
+	struct mana_eq *eq;
 	struct ib_cq *ibcq;
 	struct ib_wq *ibwq;
 	int i = 0;
 	u32 port;
 	int ret;
 
-	gd = &mdev->gdma_dev->gdma_context->mana;
+	gc = mdev->gdma_dev->gdma_context;
+	gd = &gc->mana;
 	mc = gd->driver_data;
 
 	if (!udata || udata->inlen < sizeof(ucmd))
@@ -179,6 +184,13 @@ static int mana_ib_create_qp_rss(struct ib_qp *ibqp, struct ib_pd *pd,
 		goto fail;
 	}
 
+	gdma_cq_allocated = kcalloc(ind_tbl_size, sizeof(*gdma_cq_allocated),
+				    GFP_KERNEL);
+	if (!gdma_cq_allocated) {
+		ret = -ENOMEM;
+		goto fail;
+	}
+
 	qp->port = port;
 
 	for (i = 0; i < ind_tbl_size; i++) {
@@ -197,12 +209,16 @@ static int mana_ib_create_qp_rss(struct ib_qp *ibqp, struct ib_pd *pd,
 		cq_spec.gdma_region = cq->gdma_region;
 		cq_spec.queue_size = cq->cqe * COMP_ENTRY_SIZE;
 		cq_spec.modr_ctx_id = 0;
-		cq_spec.attached_eq = GDMA_CQ_NO_EQ;
+		eq = &mc->eqs[cq->comp_vector % gc->max_num_queues];
+		cq_spec.attached_eq = eq->eq->id;
 
 		ret = mana_create_wq_obj(mpc, mpc->port_handle, GDMA_RQ,
 					 &wq_spec, &cq_spec, &wq->rx_object);
-		if (ret)
+		if (ret) {
+			/* Do cleanup starting with index i-1 */
+			i--;
 			goto fail;
+		}
 
 		/* The GDMA regions are now owned by the WQ object */
 		wq->gdma_region = GDMA_INVALID_DMA_REGION;
@@ -219,6 +235,21 @@ static int mana_ib_create_qp_rss(struct ib_qp *ibqp, struct ib_pd *pd,
 		resp.entries[i].wqid = wq->id;
 
 		mana_ind_table[i] = wq->rx_object;
+
+		/* Create CQ table entry */
+		WARN_ON(gc->cq_table[cq->id]);
+		gdma_cq = kzalloc(sizeof(*gdma_cq), GFP_KERNEL);
+		if (!gdma_cq) {
+			ret = -ENOMEM;
+			goto fail;
+		}
+		gdma_cq_allocated[i] = gdma_cq;
+
+		gdma_cq->cq.context = cq;
+		gdma_cq->type = GDMA_CQ;
+		gdma_cq->cq.callback = mana_ib_cq_handler;
+		gdma_cq->id = cq->id;
+		gc->cq_table[cq->id] = gdma_cq;
 	}
 	resp.num_entries = i;
 
@@ -238,6 +269,7 @@ static int mana_ib_create_qp_rss(struct ib_qp *ibqp, struct ib_pd *pd,
 		goto fail;
 	}
 
+	kfree(gdma_cq_allocated);
 	kfree(mana_ind_table);
 
 	return 0;
@@ -245,10 +277,17 @@ static int mana_ib_create_qp_rss(struct ib_qp *ibqp, struct ib_pd *pd,
 fail:
 	while (i-- > 0) {
 		ibwq = ind_tbl->ind_tbl[i];
+		ibcq = ibwq->cq;
 		wq = container_of(ibwq, struct mana_ib_wq, ibwq);
+		cq = container_of(ibcq, struct mana_ib_cq, ibcq);
+
+		gc->cq_table[cq->id] = NULL;
+		kfree(gdma_cq_allocated[i]);
+
 		mana_destroy_wq_obj(mpc, GDMA_RQ, wq->rx_object);
 	}
 
+	kfree(gdma_cq_allocated);
 	kfree(mana_ind_table);
 
 	return ret;
@@ -270,14 +309,17 @@ static int mana_ib_create_qp_raw(struct ib_qp *ibqp, struct ib_pd *ibpd,
 	struct gdma_dev *gd = &mdev->gdma_dev->gdma_context->mana;
 	struct mana_ib_create_qp_resp resp = {};
 	struct mana_ib_create_qp ucmd = {};
+	struct gdma_queue *gdma_cq = NULL;
 	struct mana_obj_spec wq_spec = {};
 	struct mana_obj_spec cq_spec = {};
 	struct mana_port_context *mpc;
 	struct mana_context *mc;
 	struct net_device *ndev;
 	struct ib_umem *umem;
-	int err;
+	struct mana_eq *eq;
+	int eq_vec;
 	u32 port;
+	int err;
 
 	mc = gd->driver_data;
 
@@ -354,7 +396,9 @@ static int mana_ib_create_qp_raw(struct ib_qp *ibqp, struct ib_pd *ibpd,
 	cq_spec.gdma_region = send_cq->gdma_region;
 	cq_spec.queue_size = send_cq->cqe * COMP_ENTRY_SIZE;
 	cq_spec.modr_ctx_id = 0;
-	cq_spec.attached_eq = GDMA_CQ_NO_EQ;
+	eq_vec = send_cq->comp_vector % gd->gdma_context->max_num_queues;
+	eq = &mc->eqs[eq_vec];
+	cq_spec.attached_eq = eq->eq->id;
 
 	err = mana_create_wq_obj(mpc, mpc->port_handle, GDMA_SQ, &wq_spec,
 				 &cq_spec, &qp->tx_object);
@@ -372,6 +416,20 @@ static int mana_ib_create_qp_raw(struct ib_qp *ibqp, struct ib_pd *ibpd,
 	qp->sq_id = wq_spec.queue_index;
 	send_cq->id = cq_spec.queue_index;
 
+	/* Create CQ table entry */
+	WARN_ON(gd->gdma_context->cq_table[send_cq->id]);
+	gdma_cq = kzalloc(sizeof(*gdma_cq), GFP_KERNEL);
+	if (!gdma_cq) {
+		err = -ENOMEM;
+		goto err_destroy_wq_obj;
+	}
+
+	gdma_cq->cq.context = send_cq;
+	gdma_cq->type = GDMA_CQ;
+	gdma_cq->cq.callback = mana_ib_cq_handler;
+	gdma_cq->id = send_cq->id;
+	gd->gdma_context->cq_table[send_cq->id] = gdma_cq;
+
 	ibdev_dbg(&mdev->ib_dev,
 		  "ret %d qp->tx_object 0x%llx sq id %llu cq id %llu\n", err,
 		  qp->tx_object, qp->sq_id, send_cq->id);
@@ -391,6 +449,11 @@ static int mana_ib_create_qp_raw(struct ib_qp *ibqp, struct ib_pd *ibpd,
 	return 0;
 
 err_destroy_wq_obj:
+	if (gdma_cq) {
+		kfree(gdma_cq);
+		gd->gdma_context->cq_table[send_cq->id] = NULL;
+	}
+
 	mana_destroy_wq_obj(mpc, GDMA_SQ, qp->tx_object);
 
 err_destroy_dma_region:
-- 
2.25.1


