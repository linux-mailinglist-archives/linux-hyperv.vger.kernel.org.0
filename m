Return-Path: <linux-hyperv+bounces-3733-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58930A171DF
	for <lists+linux-hyperv@lfdr.de>; Mon, 20 Jan 2025 18:30:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCD623ABBFB
	for <lists+linux-hyperv@lfdr.de>; Mon, 20 Jan 2025 17:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 582241F1500;
	Mon, 20 Jan 2025 17:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="ZEw2w4s7"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 037611EF088;
	Mon, 20 Jan 2025 17:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737394056; cv=none; b=cSQAxH/By+nqhjfQulPURIiFBA5agpH7d6hwsb9yPZO6VyQJoFv3eZWku0bRQ2BfdhEo828L/MHo8iCvxr8FqcP+8K95VPmSVrGwFj4EZD53BrsbCP8l8rLS0ST/ObzwuCWwQNTqe3MPrlmD8uoSfbtqbrba2MMW/47D2jvNuck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737394056; c=relaxed/simple;
	bh=WkiMm3lFH1pTe01iiv7pQM4f6V/4Z7SqdYkzxQH42v0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=UxDXfNny5hbW/KZk+294R92wWQBeWanjxdA40gsEzNUk6uE74FCJGovPlv3KIkbC0l9RySgaEYW8EGSfK3ztZbkMPC7aJODyGAGyTKru54biDRxPsfZ9cXHLwRqIXmBvlWbNDXZoz9z4eQRsps3f/1TG9Bw1G1EpGgmtxKnW3Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=ZEw2w4s7; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id AF136205A9D1;
	Mon, 20 Jan 2025 09:27:26 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com AF136205A9D1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1737394046;
	bh=okH7zLBhlX21Cgxu6Zluh9+f+V33w5PzpfJYQsoa+A0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZEw2w4s70h8xfXrRPQpK58iPRoXYttmks9wXMOw/VrGeozXwOd40mLFZ3Ay8DuY4h
	 Pid8XRqU6G/qNZHQ1FfyrAUbq/KB90scLWHv/LsouPmKSRg3IEFVtfV8lnLmNPZ+5X
	 am0txtCS1zcnNmmK9vQCWot4X+jUPXEZXVxcVQVY=
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
Subject: [PATCH rdma-next 11/13] RDMA/mana_ib: extend mana QP table
Date: Mon, 20 Jan 2025 09:27:17 -0800
Message-Id: <1737394039-28772-12-git-send-email-kotaranov@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1737394039-28772-1-git-send-email-kotaranov@linux.microsoft.com>
References: <1737394039-28772-1-git-send-email-kotaranov@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

From: Konstantin Taranov <kotaranov@microsoft.com>

Enable mana QP table to store UD/GSI QPs.
For send queues, set the most significant bit to one,
as send and receive WQs can have the same ID in mana.

Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>
Reviewed-by: Shiraz Saleem <shirazsaleem@microsoft.com>
---
 drivers/infiniband/hw/mana/main.c    |  2 +-
 drivers/infiniband/hw/mana/mana_ib.h |  8 ++-
 drivers/infiniband/hw/mana/qp.c      | 78 ++++++++++++++++++++++++++--
 3 files changed, 83 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/hw/mana/main.c b/drivers/infiniband/hw/mana/main.c
index b0c55cb..114e391 100644
--- a/drivers/infiniband/hw/mana/main.c
+++ b/drivers/infiniband/hw/mana/main.c
@@ -704,7 +704,7 @@ mana_ib_event_handler(void *ctx, struct gdma_queue *q, struct gdma_event *event)
 	switch (event->type) {
 	case GDMA_EQE_RNIC_QP_FATAL:
 		qpn = event->details[0];
-		qp = mana_get_qp_ref(mdev, qpn);
+		qp = mana_get_qp_ref(mdev, qpn, false);
 		if (!qp)
 			break;
 		if (qp->ibqp.event_handler) {
diff --git a/drivers/infiniband/hw/mana/mana_ib.h b/drivers/infiniband/hw/mana/mana_ib.h
index bd34ad6..5e4ca55 100644
--- a/drivers/infiniband/hw/mana/mana_ib.h
+++ b/drivers/infiniband/hw/mana/mana_ib.h
@@ -23,6 +23,9 @@
 /* MANA doesn't have any limit for MR size */
 #define MANA_IB_MAX_MR_SIZE	U64_MAX
 
+/* Send queue ID mask */
+#define MANA_SENDQ_MASK	BIT(31)
+
 /*
  * The hardware limit of number of MRs is greater than maximum number of MRs
  * that can possibly represent in 24 bits
@@ -438,11 +441,14 @@ static inline struct gdma_context *mdev_to_gc(struct mana_ib_dev *mdev)
 }
 
 static inline struct mana_ib_qp *mana_get_qp_ref(struct mana_ib_dev *mdev,
-						 uint32_t qid)
+						 u32 qid, bool is_sq)
 {
 	struct mana_ib_qp *qp;
 	unsigned long flag;
 
+	if (is_sq)
+		qid |= MANA_SENDQ_MASK;
+
 	xa_lock_irqsave(&mdev->qp_table_wq, flag);
 	qp = xa_load(&mdev->qp_table_wq, qid);
 	if (qp)
diff --git a/drivers/infiniband/hw/mana/qp.c b/drivers/infiniband/hw/mana/qp.c
index 051ea03..2528046 100644
--- a/drivers/infiniband/hw/mana/qp.c
+++ b/drivers/infiniband/hw/mana/qp.c
@@ -444,18 +444,82 @@ static enum gdma_queue_type mana_ib_queue_type(struct ib_qp_init_attr *attr, u32
 	return type;
 }
 
+static int mana_table_store_rc_qp(struct mana_ib_dev *mdev, struct mana_ib_qp *qp)
+{
+	return xa_insert_irq(&mdev->qp_table_wq, qp->ibqp.qp_num, qp,
+			     GFP_KERNEL);
+}
+
+static void mana_table_remove_rc_qp(struct mana_ib_dev *mdev, struct mana_ib_qp *qp)
+{
+	xa_erase_irq(&mdev->qp_table_wq, qp->ibqp.qp_num);
+}
+
+static int mana_table_store_ud_qp(struct mana_ib_dev *mdev, struct mana_ib_qp *qp)
+{
+	u32 qids = qp->ud_qp.queues[MANA_UD_SEND_QUEUE].id | MANA_SENDQ_MASK;
+	u32 qidr = qp->ud_qp.queues[MANA_UD_RECV_QUEUE].id;
+	int err;
+
+	err = xa_insert_irq(&mdev->qp_table_wq, qids, qp, GFP_KERNEL);
+	if (err)
+		return err;
+
+	err = xa_insert_irq(&mdev->qp_table_wq, qidr, qp, GFP_KERNEL);
+	if (err)
+		goto remove_sq;
+
+	return 0;
+
+remove_sq:
+	xa_erase_irq(&mdev->qp_table_wq, qids);
+	return err;
+}
+
+static void mana_table_remove_ud_qp(struct mana_ib_dev *mdev, struct mana_ib_qp *qp)
+{
+	u32 qids = qp->ud_qp.queues[MANA_UD_SEND_QUEUE].id | MANA_SENDQ_MASK;
+	u32 qidr = qp->ud_qp.queues[MANA_UD_RECV_QUEUE].id;
+
+	xa_erase_irq(&mdev->qp_table_wq, qids);
+	xa_erase_irq(&mdev->qp_table_wq, qidr);
+}
+
 static int mana_table_store_qp(struct mana_ib_dev *mdev, struct mana_ib_qp *qp)
 {
 	refcount_set(&qp->refcount, 1);
 	init_completion(&qp->free);
-	return xa_insert_irq(&mdev->qp_table_wq, qp->ibqp.qp_num, qp,
-			     GFP_KERNEL);
+
+	switch (qp->ibqp.qp_type) {
+	case IB_QPT_RC:
+		return mana_table_store_rc_qp(mdev, qp);
+	case IB_QPT_UD:
+	case IB_QPT_GSI:
+		return mana_table_store_ud_qp(mdev, qp);
+	default:
+		ibdev_dbg(&mdev->ib_dev, "Unknown QP type for storing in mana table, %d\n",
+			  qp->ibqp.qp_type);
+	}
+
+	return -EINVAL;
 }
 
 static void mana_table_remove_qp(struct mana_ib_dev *mdev,
 				 struct mana_ib_qp *qp)
 {
-	xa_erase_irq(&mdev->qp_table_wq, qp->ibqp.qp_num);
+	switch (qp->ibqp.qp_type) {
+	case IB_QPT_RC:
+		mana_table_remove_rc_qp(mdev, qp);
+		break;
+	case IB_QPT_UD:
+	case IB_QPT_GSI:
+		mana_table_remove_ud_qp(mdev, qp);
+		break;
+	default:
+		ibdev_dbg(&mdev->ib_dev, "Unknown QP type for removing from mana table, %d\n",
+			  qp->ibqp.qp_type);
+		return;
+	}
 	mana_put_qp_ref(qp);
 	wait_for_completion(&qp->free);
 }
@@ -586,8 +650,14 @@ static int mana_ib_create_ud_qp(struct ib_qp *ibqp, struct ib_pd *ibpd,
 	for (i = 0; i < MANA_UD_QUEUE_TYPE_MAX; ++i)
 		qp->ud_qp.queues[i].kmem->id = qp->ud_qp.queues[i].id;
 
+	err = mana_table_store_qp(mdev, qp);
+	if (err)
+		goto destroy_qp;
+
 	return 0;
 
+destroy_qp:
+	mana_ib_gd_destroy_ud_qp(mdev, qp);
 destroy_shadow_queues:
 	destroy_shadow_queue(&qp->shadow_rq);
 	destroy_shadow_queue(&qp->shadow_sq);
@@ -770,6 +840,8 @@ static int mana_ib_destroy_ud_qp(struct mana_ib_qp *qp, struct ib_udata *udata)
 		container_of(qp->ibqp.device, struct mana_ib_dev, ib_dev);
 	int i;
 
+	mana_table_remove_qp(mdev, qp);
+
 	destroy_shadow_queue(&qp->shadow_rq);
 	destroy_shadow_queue(&qp->shadow_sq);
 
-- 
2.43.0


