Return-Path: <linux-hyperv+bounces-3736-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B9C1DA171D4
	for <lists+linux-hyperv@lfdr.de>; Mon, 20 Jan 2025 18:29:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3800416AC43
	for <lists+linux-hyperv@lfdr.de>; Mon, 20 Jan 2025 17:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D4661F152A;
	Mon, 20 Jan 2025 17:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Qx6i2upy"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE7F31EEA5F;
	Mon, 20 Jan 2025 17:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737394056; cv=none; b=gUzXUiIVaupj8nkNIo9T9piJ7ipfVEz3O+1nkLca8SOAr8eLUtUq6r0JQ8o/PsMRoLpTx29cEaAHX1F8M2ON07Xj9VeGp3H30xC3TLRoXhCcR3hpLaZhLBtKaDsxioUFGoq6DAKI+5rUysNbu4AasLPOP7OCie8WE+6CWS02oWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737394056; c=relaxed/simple;
	bh=4fLh5UQLHHRmshMGYyFWJWzr1+9w8Xu9aDzghOzWYeg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=r3w2cJhMGsnYFn1oklgXpUqZn7m5T7blIpRY3IEOtcN15QgUeL9zGU0NRyWYzazmjfyHNao5uj+77BMy6ixDihhaEbcztFHx5m+HmXvzFluwyigUJ/wh8V2j26Q0NjA41NHzgQ+i91OgRxkAyWTy+UnHCpqnyotlga0BEGjDnAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Qx6i2upy; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id CA292205A9D2;
	Mon, 20 Jan 2025 09:27:26 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com CA292205A9D2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1737394046;
	bh=qG1FpShzw+bS0gWcYNpI4AfTFBUrXB/OO4d9mh8iM8U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Qx6i2upycnTod6pTogBkRnOqQqAqE6M+/aPimcrkpXT4xOibikTa+DoDGz+IMvUMh
	 +mubUIyb80AzkrCQ+/aLgsF+9sujto7XiSJiCwMzCcvttPQYHp7x8ceLYgrm0VtdBe
	 vPf56TNdZZIrCLyxujZLvRXAYA93qCRv+pwF+WSc=
From: Konstantin Taranov <kotaranov@linux.microsoft.com>
To: kotaranov@microsoft.com,
	shirazsaleem@microsoft.com,
	pabeni@redhat.com,
	haiyangz@microsoft.com,
	kys@microsoft.com,
	edumazet@google.com,
	kuba@kernel.org,
	davem@davemloft.net,
	decui@microsoft.com,
	wei.liu@kernel.org,
	sharmaajay@microsoft.com,
	longli@microsoft.com,
	jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-hyperv@vger.kernel.org
Subject: [PATCH rdma-next 12/13] RDMA/mana_ib: polling of CQs for GSI/UD
Date: Mon, 20 Jan 2025 09:27:18 -0800
Message-Id: <1737394039-28772-13-git-send-email-kotaranov@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1737394039-28772-1-git-send-email-kotaranov@linux.microsoft.com>
References: <1737394039-28772-1-git-send-email-kotaranov@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

From: Konstantin Taranov <kotaranov@microsoft.com>

Add polling for the kernel CQs.
Process completion events for UD/GSI QPs.

Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>
Reviewed-by: Shiraz Saleem <shirazsaleem@microsoft.com>
---
 drivers/infiniband/hw/mana/cq.c               | 135 ++++++++++++++++++
 drivers/infiniband/hw/mana/device.c           |   1 +
 drivers/infiniband/hw/mana/mana_ib.h          |  32 +++++
 drivers/infiniband/hw/mana/qp.c               |  33 +++++
 .../net/ethernet/microsoft/mana/gdma_main.c   |   1 +
 5 files changed, 202 insertions(+)

diff --git a/drivers/infiniband/hw/mana/cq.c b/drivers/infiniband/hw/mana/cq.c
index 82f1462..5c325ef 100644
--- a/drivers/infiniband/hw/mana/cq.c
+++ b/drivers/infiniband/hw/mana/cq.c
@@ -90,6 +90,10 @@ int mana_ib_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 		}
 	}
 
+	spin_lock_init(&cq->cq_lock);
+	INIT_LIST_HEAD(&cq->list_send_qp);
+	INIT_LIST_HEAD(&cq->list_recv_qp);
+
 	return 0;
 
 err_remove_cq_cb:
@@ -180,3 +184,134 @@ int mana_ib_arm_cq(struct ib_cq *ibcq, enum ib_cq_notify_flags flags)
 	mana_gd_ring_cq(gdma_cq, SET_ARM_BIT);
 	return 0;
 }
+
+static inline void handle_ud_sq_cqe(struct mana_ib_qp *qp, struct gdma_comp *cqe)
+{
+	struct mana_rdma_cqe *rdma_cqe = (struct mana_rdma_cqe *)cqe->cqe_data;
+	struct gdma_queue *wq = qp->ud_qp.queues[MANA_UD_SEND_QUEUE].kmem;
+	struct ud_sq_shadow_wqe *shadow_wqe;
+
+	shadow_wqe = shadow_queue_get_next_to_complete(&qp->shadow_sq);
+	if (!shadow_wqe)
+		return;
+
+	shadow_wqe->header.error_code = rdma_cqe->ud_send.vendor_error;
+
+	wq->tail += shadow_wqe->header.posted_wqe_size;
+	shadow_queue_advance_next_to_complete(&qp->shadow_sq);
+}
+
+static inline void handle_ud_rq_cqe(struct mana_ib_qp *qp, struct gdma_comp *cqe)
+{
+	struct mana_rdma_cqe *rdma_cqe = (struct mana_rdma_cqe *)cqe->cqe_data;
+	struct gdma_queue *wq = qp->ud_qp.queues[MANA_UD_RECV_QUEUE].kmem;
+	struct ud_rq_shadow_wqe *shadow_wqe;
+
+	shadow_wqe = shadow_queue_get_next_to_complete(&qp->shadow_rq);
+	if (!shadow_wqe)
+		return;
+
+	shadow_wqe->byte_len = rdma_cqe->ud_recv.msg_len;
+	shadow_wqe->src_qpn = rdma_cqe->ud_recv.src_qpn;
+	shadow_wqe->header.error_code = IB_WC_SUCCESS;
+
+	wq->tail += shadow_wqe->header.posted_wqe_size;
+	shadow_queue_advance_next_to_complete(&qp->shadow_rq);
+}
+
+static void mana_handle_cqe(struct mana_ib_dev *mdev, struct gdma_comp *cqe)
+{
+	struct mana_ib_qp *qp = mana_get_qp_ref(mdev, cqe->wq_num, cqe->is_sq);
+
+	if (!qp)
+		return;
+
+	if (qp->ibqp.qp_type == IB_QPT_GSI || qp->ibqp.qp_type == IB_QPT_UD) {
+		if (cqe->is_sq)
+			handle_ud_sq_cqe(qp, cqe);
+		else
+			handle_ud_rq_cqe(qp, cqe);
+	}
+
+	mana_put_qp_ref(qp);
+}
+
+static void fill_verbs_from_shadow_wqe(struct mana_ib_qp *qp, struct ib_wc *wc,
+				       const struct shadow_wqe_header *shadow_wqe)
+{
+	const struct ud_rq_shadow_wqe *ud_wqe = (const struct ud_rq_shadow_wqe *)shadow_wqe;
+
+	wc->wr_id = shadow_wqe->wr_id;
+	wc->status = shadow_wqe->error_code;
+	wc->opcode = shadow_wqe->opcode;
+	wc->vendor_err = shadow_wqe->error_code;
+	wc->wc_flags = 0;
+	wc->qp = &qp->ibqp;
+	wc->pkey_index = 0;
+
+	if (shadow_wqe->opcode == IB_WC_RECV) {
+		wc->byte_len = ud_wqe->byte_len;
+		wc->src_qp = ud_wqe->src_qpn;
+		wc->wc_flags |= IB_WC_GRH;
+	}
+}
+
+static int mana_process_completions(struct mana_ib_cq *cq, int nwc, struct ib_wc *wc)
+{
+	struct shadow_wqe_header *shadow_wqe;
+	struct mana_ib_qp *qp;
+	int wc_index = 0;
+
+	/* process send shadow queue completions  */
+	list_for_each_entry(qp, &cq->list_send_qp, cq_send_list) {
+		while ((shadow_wqe = shadow_queue_get_next_to_consume(&qp->shadow_sq))
+				!= NULL) {
+			if (wc_index >= nwc)
+				goto out;
+
+			fill_verbs_from_shadow_wqe(qp, &wc[wc_index], shadow_wqe);
+			shadow_queue_advance_consumer(&qp->shadow_sq);
+			wc_index++;
+		}
+	}
+
+	/* process recv shadow queue completions */
+	list_for_each_entry(qp, &cq->list_recv_qp, cq_recv_list) {
+		while ((shadow_wqe = shadow_queue_get_next_to_consume(&qp->shadow_rq))
+				!= NULL) {
+			if (wc_index >= nwc)
+				goto out;
+
+			fill_verbs_from_shadow_wqe(qp, &wc[wc_index], shadow_wqe);
+			shadow_queue_advance_consumer(&qp->shadow_rq);
+			wc_index++;
+		}
+	}
+
+out:
+	return wc_index;
+}
+
+int mana_ib_poll_cq(struct ib_cq *ibcq, int num_entries, struct ib_wc *wc)
+{
+	struct mana_ib_cq *cq = container_of(ibcq, struct mana_ib_cq, ibcq);
+	struct mana_ib_dev *mdev = container_of(ibcq->device, struct mana_ib_dev, ib_dev);
+	struct gdma_queue *queue = cq->queue.kmem;
+	struct gdma_comp gdma_cqe;
+	unsigned long flags;
+	int num_polled = 0;
+	int comp_read, i;
+
+	spin_lock_irqsave(&cq->cq_lock, flags);
+	for (i = 0; i < num_entries; i++) {
+		comp_read = mana_gd_poll_cq(queue, &gdma_cqe, 1);
+		if (comp_read < 1)
+			break;
+		mana_handle_cqe(mdev, &gdma_cqe);
+	}
+
+	num_polled = mana_process_completions(cq, num_entries, wc);
+	spin_unlock_irqrestore(&cq->cq_lock, flags);
+
+	return num_polled;
+}
diff --git a/drivers/infiniband/hw/mana/device.c b/drivers/infiniband/hw/mana/device.c
index 63e12c3..97502bc 100644
--- a/drivers/infiniband/hw/mana/device.c
+++ b/drivers/infiniband/hw/mana/device.c
@@ -40,6 +40,7 @@ static const struct ib_device_ops mana_ib_dev_ops = {
 	.mmap = mana_ib_mmap,
 	.modify_qp = mana_ib_modify_qp,
 	.modify_wq = mana_ib_modify_wq,
+	.poll_cq = mana_ib_poll_cq,
 	.post_recv = mana_ib_post_recv,
 	.post_send = mana_ib_post_send,
 	.query_device = mana_ib_query_device,
diff --git a/drivers/infiniband/hw/mana/mana_ib.h b/drivers/infiniband/hw/mana/mana_ib.h
index 5e4ca55..cd771af 100644
--- a/drivers/infiniband/hw/mana/mana_ib.h
+++ b/drivers/infiniband/hw/mana/mana_ib.h
@@ -127,6 +127,10 @@ struct mana_ib_mr {
 struct mana_ib_cq {
 	struct ib_cq ibcq;
 	struct mana_ib_queue queue;
+	/* protects CQ polling */
+	spinlock_t cq_lock;
+	struct list_head list_send_qp;
+	struct list_head list_recv_qp;
 	int cqe;
 	u32 comp_vector;
 	mana_handle_t  cq_handle;
@@ -169,6 +173,8 @@ struct mana_ib_qp {
 	/* The port on the IB device, starting with 1 */
 	u32 port;
 
+	struct list_head cq_send_list;
+	struct list_head cq_recv_list;
 	struct shadow_queue shadow_rq;
 	struct shadow_queue shadow_sq;
 
@@ -435,6 +441,31 @@ struct rdma_send_oob {
 	};
 }; /* HW DATA */
 
+struct mana_rdma_cqe {
+	union {
+		struct {
+			u8 cqe_type;
+			u8 data[GDMA_COMP_DATA_SIZE - 1];
+		};
+		struct {
+			u32 cqe_type		: 8;
+			u32 vendor_error	: 9;
+			u32 reserved1		: 15;
+			u32 sge_offset		: 5;
+			u32 tx_wqe_offset	: 27;
+		} ud_send;
+		struct {
+			u32 cqe_type		: 8;
+			u32 reserved1		: 24;
+			u32 msg_len;
+			u32 src_qpn		: 24;
+			u32 reserved2		: 8;
+			u32 imm_data;
+			u32 rx_wqe_offset;
+		} ud_recv;
+	};
+}; /* HW DATA */
+
 static inline struct gdma_context *mdev_to_gc(struct mana_ib_dev *mdev)
 {
 	return mdev->gdma_dev->gdma_context;
@@ -602,5 +633,6 @@ int mana_ib_post_recv(struct ib_qp *ibqp, const struct ib_recv_wr *wr,
 int mana_ib_post_send(struct ib_qp *ibqp, const struct ib_send_wr *wr,
 		      const struct ib_send_wr **bad_wr);
 
+int mana_ib_poll_cq(struct ib_cq *ibcq, int num_entries, struct ib_wc *wc);
 int mana_ib_arm_cq(struct ib_cq *ibcq, enum ib_cq_notify_flags flags);
 #endif
diff --git a/drivers/infiniband/hw/mana/qp.c b/drivers/infiniband/hw/mana/qp.c
index 2528046..b05e64b 100644
--- a/drivers/infiniband/hw/mana/qp.c
+++ b/drivers/infiniband/hw/mana/qp.c
@@ -600,6 +600,36 @@ destroy_queues:
 	return err;
 }
 
+static void mana_add_qp_to_cqs(struct mana_ib_qp *qp)
+{
+	struct mana_ib_cq *send_cq = container_of(qp->ibqp.send_cq, struct mana_ib_cq, ibcq);
+	struct mana_ib_cq *recv_cq = container_of(qp->ibqp.recv_cq, struct mana_ib_cq, ibcq);
+	unsigned long flags;
+
+	spin_lock_irqsave(&send_cq->cq_lock, flags);
+	list_add_tail(&qp->cq_send_list, &send_cq->list_send_qp);
+	spin_unlock_irqrestore(&send_cq->cq_lock, flags);
+
+	spin_lock_irqsave(&recv_cq->cq_lock, flags);
+	list_add_tail(&qp->cq_recv_list, &recv_cq->list_recv_qp);
+	spin_unlock_irqrestore(&recv_cq->cq_lock, flags);
+}
+
+static void mana_remove_qp_from_cqs(struct mana_ib_qp *qp)
+{
+	struct mana_ib_cq *send_cq = container_of(qp->ibqp.send_cq, struct mana_ib_cq, ibcq);
+	struct mana_ib_cq *recv_cq = container_of(qp->ibqp.recv_cq, struct mana_ib_cq, ibcq);
+	unsigned long flags;
+
+	spin_lock_irqsave(&send_cq->cq_lock, flags);
+	list_del(&qp->cq_send_list);
+	spin_unlock_irqrestore(&send_cq->cq_lock, flags);
+
+	spin_lock_irqsave(&recv_cq->cq_lock, flags);
+	list_del(&qp->cq_recv_list);
+	spin_unlock_irqrestore(&recv_cq->cq_lock, flags);
+}
+
 static int mana_ib_create_ud_qp(struct ib_qp *ibqp, struct ib_pd *ibpd,
 				struct ib_qp_init_attr *attr, struct ib_udata *udata)
 {
@@ -654,6 +684,8 @@ static int mana_ib_create_ud_qp(struct ib_qp *ibqp, struct ib_pd *ibpd,
 	if (err)
 		goto destroy_qp;
 
+	mana_add_qp_to_cqs(qp);
+
 	return 0;
 
 destroy_qp:
@@ -840,6 +872,7 @@ static int mana_ib_destroy_ud_qp(struct mana_ib_qp *qp, struct ib_udata *udata)
 		container_of(qp->ibqp.device, struct mana_ib_dev, ib_dev);
 	int i;
 
+	mana_remove_qp_from_cqs(qp);
 	mana_table_remove_qp(mdev, qp);
 
 	destroy_shadow_queue(&qp->shadow_rq);
diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/net/ethernet/microsoft/mana/gdma_main.c
index 823f7e7..2da15d9 100644
--- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
+++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
@@ -1222,6 +1222,7 @@ int mana_gd_poll_cq(struct gdma_queue *cq, struct gdma_comp *comp, int num_cqe)
 
 	return cqe_idx;
 }
+EXPORT_SYMBOL_NS(mana_gd_poll_cq, NET_MANA);
 
 static irqreturn_t mana_gd_intr(int irq, void *arg)
 {
-- 
2.43.0


