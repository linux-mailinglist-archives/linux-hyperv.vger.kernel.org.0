Return-Path: <linux-hyperv+bounces-9190-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0K8MI6OEq2kudwEAu9opvQ
	(envelope-from <linux-hyperv+bounces-9190-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Sat, 07 Mar 2026 02:51:31 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 09DA922980A
	for <lists+linux-hyperv@lfdr.de>; Sat, 07 Mar 2026 02:51:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7059F3109C80
	for <lists+linux-hyperv@lfdr.de>; Sat,  7 Mar 2026 01:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E77A33A71A;
	Sat,  7 Mar 2026 01:47:39 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BE0A332612;
	Sat,  7 Mar 2026 01:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772848059; cv=none; b=RWgLn1RKtmkCIk/9ehKq6BGp4g0UH+vEiCAXxFtQRSzKlUI+ZdLgDyO6rSkHqhpk3Q1dLh1p7v+HEKTDFXsUFzVt9xjhrtSrg/PIHhJ13JVp3sJL2o2TDci+PWAjYU7ZV1myKN0wxolJ8atq5x6tS0a4rbpxldCagZBXAPnsUxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772848059; c=relaxed/simple;
	bh=xcDte7rRDknX365WIhKJshHQ92tBG5T6BHy4SirFks8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h5LjRD7HdT0C3az84AGlS4Y5uT2gqpoBpYPT/DF10uqwjs/DEWGJpmRPfOh+KRoN/yJC2v0Xh9pYWgfVEmHETijmG8sGD+fFfdawgDfZcmExwHhQRQCRfoiu4voC3l4cL+nqLiGuQSlVs0VFd2lpU3+pfbWsPG51t2Xi9hKtIK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1202)
	id 7DFE020B6F03; Fri,  6 Mar 2026 17:47:37 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7DFE020B6F03
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
Subject: [PATCH rdma-next 8/8] RDMA/mana_ib: Skip firmware commands for invalidated handles
Date: Fri,  6 Mar 2026 17:47:22 -0800
Message-ID: <20260307014723.556523-9-longli@microsoft.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260307014723.556523-1-longli@microsoft.com>
References: <20260307014723.556523-1-longli@microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 09DA922980A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.54 / 15.00];
	DMARC_POLICY_REJECT(2.00)[microsoft.com : SPF not aligned (relaxed), No valid DKIM,reject];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-9190-lists,linux-hyperv=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.692];
	FROM_NEQ_ENVFROM(0.00)[longli@microsoft.com,linux-hyperv@vger.kernel.org];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

After a service reset, firmware handles for PD, CQ, WQ, QP, and MR
are set to INVALID_MANA_HANDLE by the reset notification path.

Check for INVALID_MANA_HANDLE in each destroy callback before issuing
firmware destroy commands. When a handle is invalid, skip the firmware
call and proceed directly to kernel resource cleanup (umem, queues,
memory). This avoids sending stale handles to firmware after reset.

Affected callbacks:
  - mana_ib_dealloc_pd: skip mana_ib_gd_destroy_pd
  - mana_ib_destroy_cq: skip mana_ib_gd_destroy_cq and queue destroy
  - mana_ib_destroy_wq: skip mana_ib_destroy_queue
  - mana_ib_destroy_qp_rss: skip mana_destroy_wq_obj per WQ
  - mana_ib_destroy_qp_raw: skip mana_destroy_wq_obj
  - mana_ib_dereg_mr: skip mana_ib_gd_destroy_mr

Signed-off-by: Long Li <longli@microsoft.com>
---
 drivers/infiniband/hw/mana/cq.c   | 10 ++++++----
 drivers/infiniband/hw/mana/main.c | 12 +++++++++---
 drivers/infiniband/hw/mana/mr.c   |  8 +++++---
 drivers/infiniband/hw/mana/qp.c   |  9 ++++++---
 4 files changed, 26 insertions(+), 13 deletions(-)

diff --git a/drivers/infiniband/hw/mana/cq.c b/drivers/infiniband/hw/mana/cq.c
index b054684b8de7..315301bccb97 100644
--- a/drivers/infiniband/hw/mana/cq.c
+++ b/drivers/infiniband/hw/mana/cq.c
@@ -143,10 +143,12 @@ int mana_ib_destroy_cq(struct ib_cq *ibcq, struct ib_udata *udata)
 
 	mana_ib_remove_cq_cb(mdev, cq);
 
-	/* Ignore return code as there is not much we can do about it.
-	 * The error message is printed inside.
-	 */
-	mana_ib_gd_destroy_cq(mdev, cq);
+	if (cq->cq_handle != INVALID_MANA_HANDLE) {
+		/* Ignore return code as there is not much we can do about it.
+		 * The error message is printed inside.
+		 */
+		mana_ib_gd_destroy_cq(mdev, cq);
+	}
 
 	mana_ib_destroy_queue(mdev, &cq->queue);
 
diff --git a/drivers/infiniband/hw/mana/main.c b/drivers/infiniband/hw/mana/main.c
index 61ce30aa9cb2..d60205184dba 100644
--- a/drivers/infiniband/hw/mana/main.c
+++ b/drivers/infiniband/hw/mana/main.c
@@ -147,6 +147,9 @@ int mana_ib_dealloc_pd(struct ib_pd *ibpd, struct ib_udata *udata)
 		mutex_unlock(&mana_ucontext->lock);
 	}
 
+	if (pd->pd_handle == INVALID_MANA_HANDLE)
+		return 0;
+
 	mana_gd_init_req_hdr(&req.hdr, GDMA_DESTROY_PD, sizeof(req),
 			     sizeof(resp));
 
@@ -280,9 +283,12 @@ void mana_ib_dealloc_ucontext(struct ib_ucontext *ibcontext)
 	list_del_init(&mana_ucontext->dev_list);
 	mutex_unlock(&mdev->ucontext_lock);
 
-	ret = mana_gd_destroy_doorbell_page(gc, mana_ucontext->doorbell);
-	if (ret)
-		ibdev_dbg(ibdev, "Failed to destroy doorbell page %d\n", ret);
+	if (mana_ucontext->doorbell != INVALID_DOORBELL) {
+		ret = mana_gd_destroy_doorbell_page(gc, mana_ucontext->doorbell);
+		if (ret)
+			ibdev_dbg(ibdev, "Failed to destroy doorbell page %d\n",
+				  ret);
+	}
 }
 
 int mana_ib_create_kernel_queue(struct mana_ib_dev *mdev, u32 size, enum gdma_queue_type type,
diff --git a/drivers/infiniband/hw/mana/mr.c b/drivers/infiniband/hw/mana/mr.c
index 7189ccd41576..75bc2a9c366a 100644
--- a/drivers/infiniband/hw/mana/mr.c
+++ b/drivers/infiniband/hw/mana/mr.c
@@ -336,9 +336,11 @@ int mana_ib_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata)
 		mutex_unlock(&mana_ucontext->lock);
 	}
 
-	err = mana_ib_gd_destroy_mr(dev, mr->mr_handle);
-	if (err)
-		return err;
+	if (mr->mr_handle != INVALID_MANA_HANDLE) {
+		err = mana_ib_gd_destroy_mr(dev, mr->mr_handle);
+		if (err)
+			return err;
+	}
 
 	if (mr->umem)
 		ib_umem_release(mr->umem);
diff --git a/drivers/infiniband/hw/mana/qp.c b/drivers/infiniband/hw/mana/qp.c
index d590aca9b93a..76d59addb645 100644
--- a/drivers/infiniband/hw/mana/qp.c
+++ b/drivers/infiniband/hw/mana/qp.c
@@ -846,9 +846,11 @@ static int mana_ib_destroy_qp_rss(struct mana_ib_qp *qp,
 	for (i = 0; i < (1 << ind_tbl->log_ind_tbl_size); i++) {
 		ibwq = ind_tbl->ind_tbl[i];
 		wq = container_of(ibwq, struct mana_ib_wq, ibwq);
-		ibdev_dbg(&mdev->ib_dev, "destroying wq->rx_object %llu\n",
+		ibdev_dbg(&mdev->ib_dev,
+			  "destroying wq->rx_object %llu\n",
 			  wq->rx_object);
-		mana_destroy_wq_obj(mpc, GDMA_RQ, wq->rx_object);
+		if (wq->rx_object != INVALID_MANA_HANDLE)
+			mana_destroy_wq_obj(mpc, GDMA_RQ, wq->rx_object);
 	}
 
 	return 0;
@@ -867,7 +869,8 @@ static int mana_ib_destroy_qp_raw(struct mana_ib_qp *qp, struct ib_udata *udata)
 	mpc = netdev_priv(ndev);
 	pd = container_of(ibpd, struct mana_ib_pd, ibpd);
 
-	mana_destroy_wq_obj(mpc, GDMA_SQ, qp->qp_handle);
+	if (qp->qp_handle != INVALID_MANA_HANDLE)
+		mana_destroy_wq_obj(mpc, GDMA_SQ, qp->qp_handle);
 
 	mana_ib_destroy_queue(mdev, &qp->raw_sq);
 
-- 
2.43.0


