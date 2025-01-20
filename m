Return-Path: <linux-hyperv+bounces-3731-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB4CCA171CC
	for <lists+linux-hyperv@lfdr.de>; Mon, 20 Jan 2025 18:29:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4678A1882394
	for <lists+linux-hyperv@lfdr.de>; Mon, 20 Jan 2025 17:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D84541F0E5C;
	Mon, 20 Jan 2025 17:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="FMtvP/yy"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D0721EE02E;
	Mon, 20 Jan 2025 17:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737394055; cv=none; b=u959xDx//RcVoPstFncFplwAlO2CctVFBdyNZStwd0T8BPY7F7tplpuQEhxj+SZnplywl8hGjCxEnKxtG/KKfYbYkLmJiGibPzprQONBo3VfQJxhF1TbsTEb8X3ZkN5+KDkXRNiKU4cfEBIh65JZTTp8Edjzy9BbZkyebhTJSQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737394055; c=relaxed/simple;
	bh=1IiNEMTDtR0CIk33y0Fc3QKGlKRNyCCGLsY0I4bKD+k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=rm+6imkETBUvB4/GH3rXjZ/IXWCxDX7nnTgtzXwk57uRoMz+HW3VtRbC9zEmPVRUXekccAJpL3vvkP0TttcRQJp+fnHMePdoFhJQ6RD16P+UKNBMMvoaBaNm/lTK/Gtc2qsKCrnme3SDVSgsVaPoixd68J5PyXvCkIuCvmb+qDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=FMtvP/yy; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id 2DA57205A9CC;
	Mon, 20 Jan 2025 09:27:26 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2DA57205A9CC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1737394046;
	bh=+yA6wBqPF+AfxsdmaPnw8UBe05ambvgA1wmDZdhNGJk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FMtvP/yyXWxmM0OOpLLQRRT/aHKYA44DO0mQXTShQzGadl+zPSZAuLdibnVlGVAv5
	 Gw1maGgyNQltZmOUmEJ5VFMoQ1j5v6jg+/5IeufjqdSXzpq8HHbIvGaZjO3luapT/H
	 s5DdQvPF2S1WVSd8UPaT/DdgIJ4cgEvXKUytxXDw=
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
Subject: [PATCH rdma-next 06/13] RDMA/mana_ib: UD/GSI QP creation for kernel
Date: Mon, 20 Jan 2025 09:27:12 -0800
Message-Id: <1737394039-28772-7-git-send-email-kotaranov@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1737394039-28772-1-git-send-email-kotaranov@linux.microsoft.com>
References: <1737394039-28772-1-git-send-email-kotaranov@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

From: Konstantin Taranov <kotaranov@microsoft.com>

Implement UD/GSI QPs for the kernel.
Allow create/modify/destroy for such QPs.

Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>
Reviewed-by: Shiraz Saleem <shirazsaleem@microsoft.com>
---
 drivers/infiniband/hw/mana/qp.c | 115 ++++++++++++++++++++++++++++++++
 1 file changed, 115 insertions(+)

diff --git a/drivers/infiniband/hw/mana/qp.c b/drivers/infiniband/hw/mana/qp.c
index 73d67c8..fea45be 100644
--- a/drivers/infiniband/hw/mana/qp.c
+++ b/drivers/infiniband/hw/mana/qp.c
@@ -398,6 +398,52 @@ err_free_vport:
 	return err;
 }
 
+static u32 mana_ib_wqe_size(u32 sge, u32 oob_size)
+{
+	u32 wqe_size = sge * sizeof(struct gdma_sge) + sizeof(struct gdma_wqe) + oob_size;
+
+	return ALIGN(wqe_size, GDMA_WQE_BU_SIZE);
+}
+
+static u32 mana_ib_queue_size(struct ib_qp_init_attr *attr, u32 queue_type)
+{
+	u32 queue_size;
+
+	switch (attr->qp_type) {
+	case IB_QPT_UD:
+	case IB_QPT_GSI:
+		if (queue_type == MANA_UD_SEND_QUEUE)
+			queue_size = attr->cap.max_send_wr *
+				mana_ib_wqe_size(attr->cap.max_send_sge, INLINE_OOB_LARGE_SIZE);
+		else
+			queue_size = attr->cap.max_recv_wr *
+				mana_ib_wqe_size(attr->cap.max_recv_sge, INLINE_OOB_SMALL_SIZE);
+		break;
+	default:
+		return 0;
+	}
+
+	return MANA_PAGE_ALIGN(roundup_pow_of_two(queue_size));
+}
+
+static enum gdma_queue_type mana_ib_queue_type(struct ib_qp_init_attr *attr, u32 queue_type)
+{
+	enum gdma_queue_type type;
+
+	switch (attr->qp_type) {
+	case IB_QPT_UD:
+	case IB_QPT_GSI:
+		if (queue_type == MANA_UD_SEND_QUEUE)
+			type = GDMA_SQ;
+		else
+			type = GDMA_RQ;
+		break;
+	default:
+		type = GDMA_INVALID_QUEUE;
+	}
+	return type;
+}
+
 static int mana_table_store_qp(struct mana_ib_dev *mdev, struct mana_ib_qp *qp)
 {
 	refcount_set(&qp->refcount, 1);
@@ -490,6 +536,51 @@ destroy_queues:
 	return err;
 }
 
+static int mana_ib_create_ud_qp(struct ib_qp *ibqp, struct ib_pd *ibpd,
+				struct ib_qp_init_attr *attr, struct ib_udata *udata)
+{
+	struct mana_ib_dev *mdev = container_of(ibpd->device, struct mana_ib_dev, ib_dev);
+	struct mana_ib_qp *qp = container_of(ibqp, struct mana_ib_qp, ibqp);
+	struct gdma_context *gc = mdev_to_gc(mdev);
+	u32 doorbell, queue_size;
+	int i, err;
+
+	if (udata) {
+		ibdev_dbg(&mdev->ib_dev, "User-level UD QPs are not supported, %d\n", err);
+		return -EINVAL;
+	}
+
+	for (i = 0; i < MANA_UD_QUEUE_TYPE_MAX; ++i) {
+		queue_size = mana_ib_queue_size(attr, i);
+		err = mana_ib_create_kernel_queue(mdev, queue_size, mana_ib_queue_type(attr, i),
+						  &qp->ud_qp.queues[i]);
+		if (err) {
+			ibdev_err(&mdev->ib_dev, "Failed to create queue %d, err %d\n",
+				  i, err);
+			goto destroy_queues;
+		}
+	}
+	doorbell = gc->mana_ib.doorbell;
+
+	err = mana_ib_gd_create_ud_qp(mdev, qp, attr, doorbell, attr->qp_type);
+	if (err) {
+		ibdev_err(&mdev->ib_dev, "Failed to create ud qp  %d\n", err);
+		goto destroy_queues;
+	}
+	qp->ibqp.qp_num = qp->ud_qp.queues[MANA_UD_RECV_QUEUE].id;
+	qp->port = attr->port_num;
+
+	for (i = 0; i < MANA_UD_QUEUE_TYPE_MAX; ++i)
+		qp->ud_qp.queues[i].kmem->id = qp->ud_qp.queues[i].id;
+
+	return 0;
+
+destroy_queues:
+	while (i-- > 0)
+		mana_ib_destroy_queue(mdev, &qp->ud_qp.queues[i]);
+	return err;
+}
+
 int mana_ib_create_qp(struct ib_qp *ibqp, struct ib_qp_init_attr *attr,
 		      struct ib_udata *udata)
 {
@@ -503,6 +594,9 @@ int mana_ib_create_qp(struct ib_qp *ibqp, struct ib_qp_init_attr *attr,
 		return mana_ib_create_qp_raw(ibqp, ibqp->pd, attr, udata);
 	case IB_QPT_RC:
 		return mana_ib_create_rc_qp(ibqp, ibqp->pd, attr, udata);
+	case IB_QPT_UD:
+	case IB_QPT_GSI:
+		return mana_ib_create_ud_qp(ibqp, ibqp->pd, attr, udata);
 	default:
 		ibdev_dbg(ibqp->device, "Creating QP type %u not supported\n",
 			  attr->qp_type);
@@ -579,6 +673,8 @@ int mana_ib_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr,
 {
 	switch (ibqp->qp_type) {
 	case IB_QPT_RC:
+	case IB_QPT_UD:
+	case IB_QPT_GSI:
 		return mana_ib_gd_modify_qp(ibqp, attr, attr_mask, udata);
 	default:
 		ibdev_dbg(ibqp->device, "Modify QP type %u not supported", ibqp->qp_type);
@@ -652,6 +748,22 @@ static int mana_ib_destroy_rc_qp(struct mana_ib_qp *qp, struct ib_udata *udata)
 	return 0;
 }
 
+static int mana_ib_destroy_ud_qp(struct mana_ib_qp *qp, struct ib_udata *udata)
+{
+	struct mana_ib_dev *mdev =
+		container_of(qp->ibqp.device, struct mana_ib_dev, ib_dev);
+	int i;
+
+	/* Ignore return code as there is not much we can do about it.
+	 * The error message is printed inside.
+	 */
+	mana_ib_gd_destroy_ud_qp(mdev, qp);
+	for (i = 0; i < MANA_UD_QUEUE_TYPE_MAX; ++i)
+		mana_ib_destroy_queue(mdev, &qp->ud_qp.queues[i]);
+
+	return 0;
+}
+
 int mana_ib_destroy_qp(struct ib_qp *ibqp, struct ib_udata *udata)
 {
 	struct mana_ib_qp *qp = container_of(ibqp, struct mana_ib_qp, ibqp);
@@ -665,6 +777,9 @@ int mana_ib_destroy_qp(struct ib_qp *ibqp, struct ib_udata *udata)
 		return mana_ib_destroy_qp_raw(qp, udata);
 	case IB_QPT_RC:
 		return mana_ib_destroy_rc_qp(qp, udata);
+	case IB_QPT_UD:
+	case IB_QPT_GSI:
+		return mana_ib_destroy_ud_qp(qp, udata);
 	default:
 		ibdev_dbg(ibqp->device, "Unexpected QP type %u\n",
 			  ibqp->qp_type);
-- 
2.43.0


