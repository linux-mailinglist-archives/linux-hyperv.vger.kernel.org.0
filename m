Return-Path: <linux-hyperv+bounces-3727-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8986A171B9
	for <lists+linux-hyperv@lfdr.de>; Mon, 20 Jan 2025 18:28:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F72C188A547
	for <lists+linux-hyperv@lfdr.de>; Mon, 20 Jan 2025 17:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2A141EEA3B;
	Mon, 20 Jan 2025 17:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="LSNcLu+f"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 292F41E9B29;
	Mon, 20 Jan 2025 17:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737394053; cv=none; b=ZFzGjdwEC2p/dfoEhkdfPQ9eA3zSKudCV30iBRvFDa+FU2P8n67K5rBO0lwb6vVAeI+fR+dM3J4WKytlYlQwmnrvXEd2dRjDispDlj9RAnZp5WjrxNWYMsLmyUdQBKZuiFy9S69qdfEo+6GEM5wBUHNsFnx1RGgkDKHt3ldruec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737394053; c=relaxed/simple;
	bh=QXz5/Y6hz2MMtJtqke/JlcpxcZwq0xYNx0qtQmUdmXg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=DMr2CD9NzsRpXGlQCpM55tP1sXKjQEHF7kMsxc24zb70HqLnJl7f0ieI25bWVmPeXR+n6XsrjxIEk1UcBQYGmr62VaMwnCMDRArQXLbvPiWEWQOW5/XXsxjaCjNxD8dlOMCQQwwHUUlwWtdtAjjEXSMawlAJSS1oppw3BQ8XRR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=LSNcLu+f; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id EE6CC205A9CA;
	Mon, 20 Jan 2025 09:27:25 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com EE6CC205A9CA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1737394046;
	bh=P9wezFJ3hB/T/3jqSgNKGvJNhir6BKvPXhoSRpMtuVs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LSNcLu+f29+aojhq+5gyUQodGrLxH966VD+0QAYl9qRlyBpYkQtVr8Fb5dWR0+Rgr
	 iIRu3ZyUPi93S2Ep5vRaolu8ZzIXM43iVjEFCIMV0DafPIlIU1BexE4lBGps0+8aDi
	 p6IwCo6yoyL6WjH0sd0RdaehR5xnMhGMUvGSwdsA=
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
Subject: [PATCH rdma-next 04/13] RDMA/mana_ib: create kernel-level CQs
Date: Mon, 20 Jan 2025 09:27:10 -0800
Message-Id: <1737394039-28772-5-git-send-email-kotaranov@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1737394039-28772-1-git-send-email-kotaranov@linux.microsoft.com>
References: <1737394039-28772-1-git-send-email-kotaranov@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

From: Konstantin Taranov <kotaranov@microsoft.com>

Implement creation of CQs for the kernel.

Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>
Reviewed-by: Shiraz Saleem <shirazsaleem@microsoft.com>
---
 drivers/infiniband/hw/mana/cq.c | 80 +++++++++++++++++++++------------
 1 file changed, 52 insertions(+), 28 deletions(-)

diff --git a/drivers/infiniband/hw/mana/cq.c b/drivers/infiniband/hw/mana/cq.c
index f04a679..d26d82d 100644
--- a/drivers/infiniband/hw/mana/cq.c
+++ b/drivers/infiniband/hw/mana/cq.c
@@ -15,42 +15,57 @@ int mana_ib_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 	struct ib_device *ibdev = ibcq->device;
 	struct mana_ib_create_cq ucmd = {};
 	struct mana_ib_dev *mdev;
+	struct gdma_context *gc;
 	bool is_rnic_cq;
 	u32 doorbell;
+	u32 buf_size;
 	int err;
 
 	mdev = container_of(ibdev, struct mana_ib_dev, ib_dev);
+	gc = mdev_to_gc(mdev);
 
 	cq->comp_vector = attr->comp_vector % ibdev->num_comp_vectors;
 	cq->cq_handle = INVALID_MANA_HANDLE;
 
-	if (udata->inlen < offsetof(struct mana_ib_create_cq, flags))
-		return -EINVAL;
+	if (udata) {
+		if (udata->inlen < offsetof(struct mana_ib_create_cq, flags))
+			return -EINVAL;
 
-	err = ib_copy_from_udata(&ucmd, udata, min(sizeof(ucmd), udata->inlen));
-	if (err) {
-		ibdev_dbg(ibdev,
-			  "Failed to copy from udata for create cq, %d\n", err);
-		return err;
-	}
+		err = ib_copy_from_udata(&ucmd, udata, min(sizeof(ucmd), udata->inlen));
+		if (err) {
+			ibdev_dbg(ibdev, "Failed to copy from udata for create cq, %d\n", err);
+			return err;
+		}
 
-	is_rnic_cq = !!(ucmd.flags & MANA_IB_CREATE_RNIC_CQ);
+		is_rnic_cq = !!(ucmd.flags & MANA_IB_CREATE_RNIC_CQ);
 
-	if (!is_rnic_cq && attr->cqe > mdev->adapter_caps.max_qp_wr) {
-		ibdev_dbg(ibdev, "CQE %d exceeding limit\n", attr->cqe);
-		return -EINVAL;
-	}
+		if (!is_rnic_cq && attr->cqe > mdev->adapter_caps.max_qp_wr) {
+			ibdev_dbg(ibdev, "CQE %d exceeding limit\n", attr->cqe);
+			return -EINVAL;
+		}
 
-	cq->cqe = attr->cqe;
-	err = mana_ib_create_queue(mdev, ucmd.buf_addr, cq->cqe * COMP_ENTRY_SIZE, &cq->queue);
-	if (err) {
-		ibdev_dbg(ibdev, "Failed to create queue for create cq, %d\n", err);
-		return err;
-	}
+		cq->cqe = attr->cqe;
+		err = mana_ib_create_queue(mdev, ucmd.buf_addr, cq->cqe * COMP_ENTRY_SIZE,
+					   &cq->queue);
+		if (err) {
+			ibdev_dbg(ibdev, "Failed to create queue for create cq, %d\n", err);
+			return err;
+		}
 
-	mana_ucontext = rdma_udata_to_drv_context(udata, struct mana_ib_ucontext,
-						  ibucontext);
-	doorbell = mana_ucontext->doorbell;
+		mana_ucontext = rdma_udata_to_drv_context(udata, struct mana_ib_ucontext,
+							  ibucontext);
+		doorbell = mana_ucontext->doorbell;
+	} else {
+		is_rnic_cq = true;
+		buf_size = MANA_PAGE_ALIGN(roundup_pow_of_two(attr->cqe * COMP_ENTRY_SIZE));
+		cq->cqe = buf_size / COMP_ENTRY_SIZE;
+		err = mana_ib_create_kernel_queue(mdev, buf_size, GDMA_CQ, &cq->queue);
+		if (err) {
+			ibdev_dbg(ibdev, "Failed to create kernel queue for create cq, %d\n", err);
+			return err;
+		}
+		doorbell = gc->mana_ib.doorbell;
+	}
 
 	if (is_rnic_cq) {
 		err = mana_ib_gd_create_cq(mdev, cq, doorbell);
@@ -66,11 +81,13 @@ int mana_ib_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 		}
 	}
 
-	resp.cqid = cq->queue.id;
-	err = ib_copy_to_udata(udata, &resp, min(sizeof(resp), udata->outlen));
-	if (err) {
-		ibdev_dbg(&mdev->ib_dev, "Failed to copy to udata, %d\n", err);
-		goto err_remove_cq_cb;
+	if (udata) {
+		resp.cqid = cq->queue.id;
+		err = ib_copy_to_udata(udata, &resp, min(sizeof(resp), udata->outlen));
+		if (err) {
+			ibdev_dbg(&mdev->ib_dev, "Failed to copy to udata, %d\n", err);
+			goto err_remove_cq_cb;
+		}
 	}
 
 	return 0;
@@ -122,7 +139,10 @@ int mana_ib_install_cq_cb(struct mana_ib_dev *mdev, struct mana_ib_cq *cq)
 		return -EINVAL;
 	/* Create CQ table entry */
 	WARN_ON(gc->cq_table[cq->queue.id]);
-	gdma_cq = kzalloc(sizeof(*gdma_cq), GFP_KERNEL);
+	if (cq->queue.kmem)
+		gdma_cq = cq->queue.kmem;
+	else
+		gdma_cq = kzalloc(sizeof(*gdma_cq), GFP_KERNEL);
 	if (!gdma_cq)
 		return -ENOMEM;
 
@@ -141,6 +161,10 @@ void mana_ib_remove_cq_cb(struct mana_ib_dev *mdev, struct mana_ib_cq *cq)
 	if (cq->queue.id >= gc->max_num_cqs || cq->queue.id == INVALID_QUEUE_ID)
 		return;
 
+	if (cq->queue.kmem)
+	/* Then it will be cleaned and removed by the mana */
+		return;
+
 	kfree(gc->cq_table[cq->queue.id]);
 	gc->cq_table[cq->queue.id] = NULL;
 }
-- 
2.43.0


