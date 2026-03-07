Return-Path: <linux-hyperv+bounces-9189-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4GpsFniEq2n/dgEAu9opvQ
	(envelope-from <linux-hyperv+bounces-9189-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Sat, 07 Mar 2026 02:50:48 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DB9502297E6
	for <lists+linux-hyperv@lfdr.de>; Sat, 07 Mar 2026 02:50:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 48CC3307AFF0
	for <lists+linux-hyperv@lfdr.de>; Sat,  7 Mar 2026 01:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6977A339B3D;
	Sat,  7 Mar 2026 01:47:39 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 020F7331221;
	Sat,  7 Mar 2026 01:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772848059; cv=none; b=pf9EDA8NebGWcNg7x5jzAZxRETc6DhpzIAwkZUzEJZtg8+u+QJCxrevU4Gjev4GNISHWseE+ARI8IDm5VAoFqhSQiR8Cawvn5ps+/Cg3fiDg2dwiBv4K/sMopxBrPhTO9baMu3asnxMI/tazh4mB4mo3PHLCrsihPVmtF6HY220=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772848059; c=relaxed/simple;
	bh=pWYTHJCNKqq1+GiUUCUl5igXga4xOTfXNYFerUaA9k4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ulvOslDfpXPU+MmPZK6hzLTXDJLpB/ftZhkzRa4KtgIVrFZ0+tpaMjoZ98smfdGe+/jfOMaGEEoy3+ceNREwfmRBkOCph4g0IF1EOTIx6PHe1Giq8sEkPauTBy/8p6r7/sfHldAl9aJsLKHTLhkTltQhRQQtcDdzR2ijOo/LO7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1202)
	id D1B5620B6F05; Fri,  6 Mar 2026 17:47:36 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D1B5620B6F05
From: Long Li <longli@microsoft.com>
To: Long Li <longli@microsoft.com>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	"K . Y . Srinivasan" <kys@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>
Cc: Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH rdma-next 7/8] RDMA/mana_ib: Notify service reset events to RDMA devices
Date: Fri,  6 Mar 2026 17:47:21 -0800
Message-ID: <20260307014723.556523-8-longli@microsoft.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260307014723.556523-1-longli@microsoft.com>
References: <20260307014723.556523-1-longli@microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: DB9502297E6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.04 / 15.00];
	DMARC_POLICY_REJECT(2.00)[microsoft.com : SPF not aligned (relaxed), No valid DKIM,reject];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-9189-lists,linux-hyperv=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[18];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.176];
	FROM_NEQ_ENVFROM(0.00)[longli@microsoft.com,linux-hyperv@vger.kernel.org];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

Register reset_notify and resume_notify callbacks so the RDMA driver
is informed when the MANA service undergoes a reset cycle.

On reset notification:
  - Acquire reset_rwsem write lock to serialize with resource creation
  - Walk every tracked ucontext and invalidate firmware handles for
    all PD, CQ, WQ, QP, and MR resources (set to INVALID_MANA_HANDLE)
  - Dispatch IB_EVENT_PORT_ERR to each affected ucontext so userspace
    (e.g. DPDK) learns about the reset

On resume notification:
  - Release reset_rwsem write lock, unblocking new resource creation

Resource creation paths (alloc_pd, create_cq, create_wq, create_qp for
RAW_PACKET, reg_user_mr) acquire reset_rwsem read lock to ensure handles
are not invalidated while being set up.

Signed-off-by: Long Li <longli@microsoft.com>
---
 drivers/infiniband/hw/mana/cq.c               |  15 ++-
 drivers/infiniband/hw/mana/device.c           | 103 ++++++++++++++++++
 drivers/infiniband/hw/mana/main.c             |   9 ++
 drivers/infiniband/hw/mana/mana_ib.h          |   2 +
 drivers/infiniband/hw/mana/mr.c               |   4 +
 drivers/infiniband/hw/mana/qp.c               |   5 +
 drivers/infiniband/hw/mana/wq.c               |   4 +
 drivers/net/ethernet/microsoft/mana/mana_en.c |  14 ++-
 include/net/mana/gdma.h                       |   6 +
 9 files changed, 155 insertions(+), 7 deletions(-)

diff --git a/drivers/infiniband/hw/mana/cq.c b/drivers/infiniband/hw/mana/cq.c
index 89cf60987ff5..b054684b8de7 100644
--- a/drivers/infiniband/hw/mana/cq.c
+++ b/drivers/infiniband/hw/mana/cq.c
@@ -41,13 +41,17 @@ int mana_ib_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 			ibdev_dbg(ibdev, "CQE %d exceeding limit\n", attr->cqe);
 			return -EINVAL;
 		}
+	}
+
+	down_read(&mdev->reset_rwsem);
 
+	if (udata) {
 		cq->cqe = attr->cqe;
 		err = mana_ib_create_queue(mdev, ucmd.buf_addr, cq->cqe * COMP_ENTRY_SIZE,
 					   &cq->queue);
 		if (err) {
 			ibdev_dbg(ibdev, "Failed to create queue for create cq, %d\n", err);
-			return err;
+			goto err_unlock;
 		}
 
 		mana_ucontext = rdma_udata_to_drv_context(udata, struct mana_ib_ucontext,
@@ -56,14 +60,15 @@ int mana_ib_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 	} else {
 		if (attr->cqe > U32_MAX / COMP_ENTRY_SIZE / 2 + 1) {
 			ibdev_dbg(ibdev, "CQE %d exceeding limit\n", attr->cqe);
-			return -EINVAL;
+			err = -EINVAL;
+			goto err_unlock;
 		}
 		buf_size = MANA_PAGE_ALIGN(roundup_pow_of_two(attr->cqe * COMP_ENTRY_SIZE));
 		cq->cqe = buf_size / COMP_ENTRY_SIZE;
 		err = mana_ib_create_kernel_queue(mdev, buf_size, GDMA_CQ, &cq->queue);
 		if (err) {
 			ibdev_dbg(ibdev, "Failed to create kernel queue for create cq, %d\n", err);
-			return err;
+			goto err_unlock;
 		}
 		doorbell = mdev->gdma_dev->doorbell;
 	}
@@ -105,6 +110,7 @@ int mana_ib_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 		mutex_unlock(&mana_ucontext->lock);
 	}
 
+	up_read(&mdev->reset_rwsem);
 	return 0;
 
 err_remove_cq_cb:
@@ -113,7 +119,8 @@ int mana_ib_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 	mana_ib_gd_destroy_cq(mdev, cq);
 err_destroy_queue:
 	mana_ib_destroy_queue(mdev, &cq->queue);
-
+err_unlock:
+	up_read(&mdev->reset_rwsem);
 	return err;
 }
 
diff --git a/drivers/infiniband/hw/mana/device.c b/drivers/infiniband/hw/mana/device.c
index 149e8d4d5b8e..081be31563ca 100644
--- a/drivers/infiniband/hw/mana/device.c
+++ b/drivers/infiniband/hw/mana/device.c
@@ -103,6 +103,7 @@ static int mana_ib_netdev_event(struct notifier_block *this,
 					netdev_put(ndev, &dev->dev_tracker);
 
 				return NOTIFY_OK;
+
 			default:
 				return NOTIFY_DONE;
 			}
@@ -110,6 +111,93 @@ static int mana_ib_netdev_event(struct notifier_block *this,
 	return NOTIFY_DONE;
 }
 
+/*
+ * Reset cleanup: invalidate firmware handles for all tracked user objects.
+ *
+ * Called during service reset BEFORE dispatching IB_EVENT_PORT_ERR to
+ * user-mode.
+ *
+ * Only invalidates FW handles — does NOT free kernel resources (umem, queues)
+ * or remove objects from lists. The IB core's destroy callbacks handle full
+ * resource teardown when user-space closes the uverbs FD or ib_unregister_device
+ * is called. The destroy callbacks skip FW commands when the handle is already
+ * INVALID_MANA_HANDLE.
+ *
+ * For CQs, also removes the CQ callback to prevent stale completions.
+ */
+static void mana_ib_reset_notify(void *ctx)
+{
+	struct mana_ib_dev *mdev = ctx;
+	struct mana_ib_ucontext *uctx;
+	struct mana_ib_qp *qp;
+	struct mana_ib_wq *wq;
+	struct mana_ib_cq *cq;
+	struct mana_ib_mr *mr;
+	struct mana_ib_pd *pd;
+	struct ib_event ibev;
+	int i;
+
+	down_write(&mdev->reset_rwsem);
+
+	ibdev_dbg(&mdev->ib_dev, "reset cleanup starting\n");
+
+	mutex_lock(&mdev->ucontext_lock);
+	list_for_each_entry(uctx, &mdev->ucontext_list, dev_list) {
+		mutex_lock(&uctx->lock);
+
+		list_for_each_entry(qp, &uctx->qp_list, ucontext_list)
+			qp->qp_handle = INVALID_MANA_HANDLE;
+
+		list_for_each_entry(wq, &uctx->wq_list, ucontext_list)
+			wq->rx_object = INVALID_MANA_HANDLE;
+
+		list_for_each_entry(cq, &uctx->cq_list, ucontext_list) {
+			mana_ib_remove_cq_cb(mdev, cq);
+			cq->cq_handle = INVALID_MANA_HANDLE;
+		}
+
+		list_for_each_entry(mr, &uctx->mr_list, ucontext_list)
+			mr->mr_handle = INVALID_MANA_HANDLE;
+
+		list_for_each_entry(pd, &uctx->pd_list, ucontext_list)
+			pd->pd_handle = INVALID_MANA_HANDLE;
+
+		uctx->doorbell = INVALID_DOORBELL;
+
+		mutex_unlock(&uctx->lock);
+	}
+	mutex_unlock(&mdev->ucontext_lock);
+
+	up_write(&mdev->reset_rwsem);
+
+	/* Revoke user doorbell mappings so userspace cannot ring
+	 * stale doorbells after firmware handles are invalidated.
+	 */
+	rdma_user_mmap_disassociate(&mdev->ib_dev);
+
+	/* Notify userspace (e.g. DPDK) that the port is down */
+	for (i = 0; i < mdev->ib_dev.phys_port_cnt; i++) {
+		ibev.device = &mdev->ib_dev;
+		ibev.element.port_num = i + 1;
+		ibev.event = IB_EVENT_PORT_ERR;
+		ib_dispatch_event(&ibev);
+	}
+}
+
+static void mana_ib_resume_notify(void *ctx)
+{
+	struct mana_ib_dev *dev = ctx;
+	struct ib_event ibev;
+	int i;
+
+	for (i = 0; i < dev->ib_dev.phys_port_cnt; i++) {
+		ibev.device = &dev->ib_dev;
+		ibev.element.port_num = i + 1;
+		ibev.event = IB_EVENT_PORT_ACTIVE;
+		ib_dispatch_event(&ibev);
+	}
+}
+
 static int mana_ib_probe(struct auxiliary_device *adev,
 			 const struct auxiliary_device_id *id)
 {
@@ -134,6 +222,7 @@ static int mana_ib_probe(struct auxiliary_device *adev,
 	xa_init_flags(&dev->qp_table_wq, XA_FLAGS_LOCK_IRQ);
 	mutex_init(&dev->ucontext_lock);
 	INIT_LIST_HEAD(&dev->ucontext_list);
+	init_rwsem(&dev->reset_rwsem);
 
 	if (mana_ib_is_rnic(dev)) {
 		dev->ib_dev.phys_port_cnt = 1;
@@ -216,6 +305,15 @@ static int mana_ib_probe(struct auxiliary_device *adev,
 
 	dev_set_drvdata(&adev->dev, dev);
 
+	/* ETH device persists across reset — use callback for cleanup.
+	 * RNIC device is removed/re-added, so its cleanup happens in remove.
+	 */
+	if (!mana_ib_is_rnic(dev)) {
+		mdev->reset_notify = mana_ib_reset_notify;
+		mdev->resume_notify = mana_ib_resume_notify;
+		mdev->reset_notify_ctx = dev;
+	}
+
 	return 0;
 
 deallocate_pool:
@@ -242,6 +340,11 @@ static void mana_ib_remove(struct auxiliary_device *adev)
 	if (mana_ib_is_rnic(dev))
 		mana_drain_gsi_sqs(dev);
 
+	if (!mana_ib_is_rnic(dev)) {
+		dev->gdma_dev->reset_notify = NULL;
+		dev->gdma_dev->resume_notify = NULL;
+		dev->gdma_dev->reset_notify_ctx = NULL;
+	}
 	ib_unregister_device(&dev->ib_dev);
 	dma_pool_destroy(dev->av_pool);
 	if (mana_ib_is_rnic(dev)) {
diff --git a/drivers/infiniband/hw/mana/main.c b/drivers/infiniband/hw/mana/main.c
index f739e6da5435..61ce30aa9cb2 100644
--- a/drivers/infiniband/hw/mana/main.c
+++ b/drivers/infiniband/hw/mana/main.c
@@ -81,6 +81,8 @@ int mana_ib_alloc_pd(struct ib_pd *ibpd, struct ib_udata *udata)
 	dev = container_of(ibdev, struct mana_ib_dev, ib_dev);
 	gc = mdev_to_gc(dev);
 
+	down_read(&dev->reset_rwsem);
+
 	mana_gd_init_req_hdr(&req.hdr, GDMA_CREATE_PD, sizeof(req),
 			     sizeof(resp));
 
@@ -98,6 +100,7 @@ int mana_ib_alloc_pd(struct ib_pd *ibpd, struct ib_udata *udata)
 		if (!err)
 			err = -EPROTO;
 
+		up_read(&dev->reset_rwsem);
 		return err;
 	}
 
@@ -118,6 +121,7 @@ int mana_ib_alloc_pd(struct ib_pd *ibpd, struct ib_udata *udata)
 		mutex_unlock(&mana_ucontext->lock);
 	}
 
+	up_read(&dev->reset_rwsem);
 	return 0;
 }
 
@@ -230,10 +234,13 @@ int mana_ib_alloc_ucontext(struct ib_ucontext *ibcontext,
 	mdev = container_of(ibdev, struct mana_ib_dev, ib_dev);
 	gc = mdev_to_gc(mdev);
 
+	down_read(&mdev->reset_rwsem);
+
 	/* Allocate a doorbell page index */
 	ret = mana_gd_allocate_doorbell_page(gc, &doorbell_page);
 	if (ret) {
 		ibdev_dbg(ibdev, "Failed to allocate doorbell page %d\n", ret);
+		up_read(&mdev->reset_rwsem);
 		return ret;
 	}
 
@@ -252,6 +259,8 @@ int mana_ib_alloc_ucontext(struct ib_ucontext *ibcontext,
 	list_add_tail(&ucontext->dev_list, &mdev->ucontext_list);
 	mutex_unlock(&mdev->ucontext_lock);
 
+	up_read(&mdev->reset_rwsem);
+
 	return 0;
 }
 
diff --git a/drivers/infiniband/hw/mana/mana_ib.h b/drivers/infiniband/hw/mana/mana_ib.h
index ce5c6c030fb2..29201cf3274c 100644
--- a/drivers/infiniband/hw/mana/mana_ib.h
+++ b/drivers/infiniband/hw/mana/mana_ib.h
@@ -86,6 +86,8 @@ struct mana_ib_dev {
 	/* Protects ucontext_list */
 	struct mutex ucontext_lock;
 	struct list_head ucontext_list;
+	/* Serializes resource create callbacks vs reset cleanup */
+	struct rw_semaphore reset_rwsem;
 };
 
 struct mana_ib_wq {
diff --git a/drivers/infiniband/hw/mana/mr.c b/drivers/infiniband/hw/mana/mr.c
index 559bb4f7c31d..7189ccd41576 100644
--- a/drivers/infiniband/hw/mana/mr.c
+++ b/drivers/infiniband/hw/mana/mr.c
@@ -141,6 +141,8 @@ struct ib_mr *mana_ib_reg_user_mr(struct ib_pd *ibpd, u64 start, u64 length,
 	if (!mr)
 		return ERR_PTR(-ENOMEM);
 
+	down_read(&dev->reset_rwsem);
+
 	mr->umem = ib_umem_get(ibdev, start, length, access_flags);
 	if (IS_ERR(mr->umem)) {
 		err = PTR_ERR(mr->umem);
@@ -195,6 +197,7 @@ struct ib_mr *mana_ib_reg_user_mr(struct ib_pd *ibpd, u64 start, u64 length,
 		mutex_unlock(&mana_ucontext->lock);
 	}
 
+	up_read(&dev->reset_rwsem);
 	return &mr->ibmr;
 
 err_dma_region:
@@ -204,6 +207,7 @@ struct ib_mr *mana_ib_reg_user_mr(struct ib_pd *ibpd, u64 start, u64 length,
 	ib_umem_release(mr->umem);
 
 err_free:
+	up_read(&dev->reset_rwsem);
 	kfree(mr);
 	return ERR_PTR(err);
 }
diff --git a/drivers/infiniband/hw/mana/qp.c b/drivers/infiniband/hw/mana/qp.c
index 315bc54d8ae6..d590aca9b93a 100644
--- a/drivers/infiniband/hw/mana/qp.c
+++ b/drivers/infiniband/hw/mana/qp.c
@@ -701,12 +701,16 @@ int mana_ib_create_qp(struct ib_qp *ibqp, struct ib_qp_init_attr *attr,
 		      struct ib_udata *udata)
 {
 	struct mana_ib_qp *qp = container_of(ibqp, struct mana_ib_qp, ibqp);
+	struct mana_ib_dev *mdev =
+		container_of(ibqp->device, struct mana_ib_dev, ib_dev);
 	int err;
 
 	INIT_LIST_HEAD(&qp->ucontext_list);
 
 	switch (attr->qp_type) {
 	case IB_QPT_RAW_PACKET:
+		down_read(&mdev->reset_rwsem);
+
 		/* When rwq_ind_tbl is used, it's for creating WQs for RSS */
 		if (attr->rwq_ind_tbl)
 			err = mana_ib_create_qp_rss(ibqp, ibqp->pd, attr,
@@ -724,6 +728,7 @@ int mana_ib_create_qp(struct ib_qp *ibqp, struct ib_qp_init_attr *attr,
 			mutex_unlock(&mana_ucontext->lock);
 		}
 
+		up_read(&mdev->reset_rwsem);
 		return err;
 	case IB_QPT_RC:
 		return mana_ib_create_rc_qp(ibqp, ibqp->pd, attr, udata);
diff --git a/drivers/infiniband/hw/mana/wq.c b/drivers/infiniband/hw/mana/wq.c
index 1af9869933aa..67b757cf30f9 100644
--- a/drivers/infiniband/hw/mana/wq.c
+++ b/drivers/infiniband/hw/mana/wq.c
@@ -31,6 +31,8 @@ struct ib_wq *mana_ib_create_wq(struct ib_pd *pd,
 
 	ibdev_dbg(&mdev->ib_dev, "ucmd wq_buf_addr 0x%llx\n", ucmd.wq_buf_addr);
 
+	down_read(&mdev->reset_rwsem);
+
 	err = mana_ib_create_queue(mdev, ucmd.wq_buf_addr, ucmd.wq_buf_size, &wq->queue);
 	if (err) {
 		ibdev_dbg(&mdev->ib_dev,
@@ -52,9 +54,11 @@ struct ib_wq *mana_ib_create_wq(struct ib_pd *pd,
 		mutex_unlock(&mana_ucontext->lock);
 	}
 
+	up_read(&mdev->reset_rwsem);
 	return &wq->ibwq;
 
 err_free_wq:
+	up_read(&mdev->reset_rwsem);
 	kfree(wq);
 
 	return ERR_PTR(err);
diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index ea71de39f996..3493b36426f7 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -3659,15 +3659,19 @@ int mana_probe(struct gdma_dev *gd, bool resuming)
 		}
 	}
 
-	err = add_adev(gd, "eth");
+	if (!resuming)
+		err = add_adev(gd, "eth");
 
 	INIT_DELAYED_WORK(&ac->gf_stats_work, mana_gf_stats_work_handler);
 	schedule_delayed_work(&ac->gf_stats_work, MANA_GF_STATS_PERIOD);
-
 out:
 	if (err) {
 		mana_remove(gd, false);
 	} else {
+		/* Notify IB layer that ports are back up after reset */
+		if (resuming && gd->resume_notify)
+			gd->resume_notify(gd->reset_notify_ctx);
+
 		dev_dbg(dev, "gd=%p, id=%u, num_ports=%d, type=%u, instance=%u\n",
 			gd, gd->dev_id.as_uint32, ac->num_ports,
 			gd->dev_id.type, gd->dev_id.instance);
@@ -3691,9 +3695,13 @@ void mana_remove(struct gdma_dev *gd, bool suspending)
 	cancel_delayed_work_sync(&ac->gf_stats_work);
 
 	/* adev currently doesn't support suspending, always remove it */
-	if (gd->adev)
+	if (gd->adev && !suspending)
 		remove_adev(gd);
 
+	/* Notify IB layer before tearing down net devices during reset */
+	if (suspending && gd->reset_notify)
+		gd->reset_notify(gd->reset_notify_ctx);
+
 	for (i = 0; i < ac->num_ports; i++) {
 		ndev = ac->ports[i];
 		if (!ndev) {
diff --git a/include/net/mana/gdma.h b/include/net/mana/gdma.h
index ec17004b10c0..9187c5b4d0d1 100644
--- a/include/net/mana/gdma.h
+++ b/include/net/mana/gdma.h
@@ -249,6 +249,12 @@ struct gdma_dev {
 	struct auxiliary_device *adev;
 	bool is_suspended;
 	bool rdma_teardown;
+
+	/* Called by mana_remove() during reset to notify IB layer */
+	void (*reset_notify)(void *ctx);
+	/* Called by mana_probe() during resume to notify IB layer */
+	void (*resume_notify)(void *ctx);
+	void *reset_notify_ctx;
 };
 
 /* MANA_PAGE_SIZE is the DMA unit */
-- 
2.43.0


