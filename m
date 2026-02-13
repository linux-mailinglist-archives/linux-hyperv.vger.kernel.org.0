Return-Path: <linux-hyperv+bounces-8822-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KCKGArAGj2ltHQEAu9opvQ
	(envelope-from <linux-hyperv+bounces-8822-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Feb 2026 12:10:40 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7705A135840
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Feb 2026 12:10:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A6530314AB49
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Feb 2026 11:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 346F1359F87;
	Fri, 13 Feb 2026 11:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z60BlmFK"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 104D8354AEC;
	Fri, 13 Feb 2026 11:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770980427; cv=none; b=lkOZH4juwgGEAJYcKxSAY4MoPau93zg0253O0v6nSrJ8acZNOo8L2lT/y8iXOnDDSysNn8AXfCIf+BIM6y+wNcWf/ZPSsaP1uHgTgZ0n+C3GDe0qK43GloYzHw6nWshUQklggpy7lDaFIVFc6rO6HHNAut5uPwLyfNbcdBUYWWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770980427; c=relaxed/simple;
	bh=ie+0JBki2/glNSETQLy2aDTa3dexDvCcQEZRepXCc4s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IbiCR9Vbt/I5V9H7R9wY1UPKqPJ+uuRya9GRgaf7EsbcHRfYjHe/ub7/2rLjcUNwiRKE2V+ls7HOV1vr5DKGf4CLvowa4/5ccvabC1uwLt+ROXZokakEqW7qTLdVtOZofez6YJp5nVTH8nUd07GFbpesiwQvAjFTn/MyCcB7KDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z60BlmFK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE252C116C6;
	Fri, 13 Feb 2026 11:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770980426;
	bh=ie+0JBki2/glNSETQLy2aDTa3dexDvCcQEZRepXCc4s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z60BlmFKZA9KLWlKIWXibTo03BEI4Znra/QFK5qLMmskd3vMcQO/KSDf0M6cjr+UL
	 4879MvwQ7Rx3shHZT3TgbusodoiXCOWwMPV2uhdCM56aST0UBZ3RpGUdmAWsL3KqNJ
	 OUR0SJn3g3a1jjGl+k+Ts+jJyPfwnymUDiswuNq5MyW3eezF2FTz1VpnGCqmg5UL9k
	 xkr3JHLTq45C4lO78eb/0XYlfB8eTzbyfbiR4bA0WCr63b5gB/wZOBxqmwcjuO9Isc
	 BmBgPnY5VqJaM2yhdmsSMRWD/yt4gLqSOox4oq392oFf+u8W8oNeWlk4S9hkXruRO+
	 HrxYW+//q5Svg==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	Selvin Xavier <selvin.xavier@broadcom.com>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Potnuri Bharat Teja <bharat@chelsio.com>,
	Michael Margolin <mrgolin@amazon.com>,
	Gal Pressman <gal.pressman@linux.dev>,
	Yossi Leybovich <sleybo@amazon.com>,
	Cheng Xu <chengyou@linux.alibaba.com>,
	Kai Shen <kaishen@linux.alibaba.com>,
	Chengchang Tang <tangchengchang@huawei.com>,
	Junxian Huang <huangjunxian6@hisilicon.com>,
	Abhijit Gangurde <abhijit.gangurde@amd.com>,
	Allen Hubbe <allen.hubbe@amd.com>,
	Krzysztof Czurylo <krzysztof.czurylo@intel.com>,
	Tatyana Nikolova <tatyana.e.nikolova@intel.com>,
	Long Li <longli@microsoft.com>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Michal Kalderon <mkalderon@marvell.com>,
	Bryan Tan <bryan-bt.tan@broadcom.com>,
	Vishnu Dasa <vishnu.dasa@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Christian Benvenuti <benve@cisco.com>,
	Nelson Escobar <neescoba@cisco.com>,
	Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
	Bernard Metzler <bernard.metzler@linux.dev>,
	Zhu Yanjun <zyjzyj2000@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-hyperv@vger.kernel.org
Subject: [PATCH rdma-next 25/50] RDMA/mana: Provide a modern CQ creation interface
Date: Fri, 13 Feb 2026 12:58:01 +0200
Message-ID: <20260213-refactor-umem-v1-25-f3be85847922@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260213-refactor-umem-v1-0-f3be85847922@nvidia.com>
References: <20260213-refactor-umem-v1-0-f3be85847922@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.15-dev-47773
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[ziepe.ca,kernel.org,broadcom.com,chelsio.com,amazon.com,linux.dev,linux.alibaba.com,huawei.com,hisilicon.com,amd.com,intel.com,microsoft.com,nvidia.com,marvell.com,cisco.com,cornelisnetworks.com,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[31];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-8822-lists,linux-hyperv=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:mid,nvidia.com:email]
X-Rspamd-Queue-Id: 7705A135840
X-Rspamd-Action: no action

From: Leon Romanovsky <leonro@nvidia.com>

The uverbs CQ creation UAPI allows users to supply their own umem for a CQ.
Update mana to support this workflow while preserving support for creating
umem through the legacy interface.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mana/cq.c      | 128 +++++++++++++++++++++++------------
 drivers/infiniband/hw/mana/device.c  |   1 +
 drivers/infiniband/hw/mana/main.c    |  25 +++----
 drivers/infiniband/hw/mana/mana_ib.h |   4 +-
 drivers/infiniband/hw/mana/qp.c      |  42 ++++++++++--
 drivers/infiniband/hw/mana/wq.c      |  14 +++-
 6 files changed, 147 insertions(+), 67 deletions(-)

diff --git a/drivers/infiniband/hw/mana/cq.c b/drivers/infiniband/hw/mana/cq.c
index 2dce1b677115..605122ecf9f9 100644
--- a/drivers/infiniband/hw/mana/cq.c
+++ b/drivers/infiniband/hw/mana/cq.c
@@ -5,8 +5,8 @@
 
 #include "mana_ib.h"
 
-int mana_ib_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
-		      struct uverbs_attr_bundle *attrs)
+int mana_ib_create_user_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
+			   struct uverbs_attr_bundle *attrs)
 {
 	struct ib_udata *udata = &attrs->driver_udata;
 	struct mana_ib_cq *cq = container_of(ibcq, struct mana_ib_cq, ibcq);
@@ -17,7 +17,6 @@ int mana_ib_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 	struct mana_ib_dev *mdev;
 	bool is_rnic_cq;
 	u32 doorbell;
-	u32 buf_size;
 	int err;
 
 	mdev = container_of(ibdev, struct mana_ib_dev, ib_dev);
@@ -26,44 +25,100 @@ int mana_ib_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 	cq->cq_handle = INVALID_MANA_HANDLE;
 	is_rnic_cq = mana_ib_is_rnic(mdev);
 
-	if (udata) {
-		if (udata->inlen < offsetof(struct mana_ib_create_cq, flags))
-			return -EINVAL;
+	if (udata->inlen < offsetof(struct mana_ib_create_cq, flags))
+		return -EINVAL;
 
-		err = ib_copy_from_udata(&ucmd, udata, min(sizeof(ucmd), udata->inlen));
-		if (err) {
-			ibdev_dbg(ibdev, "Failed to copy from udata for create cq, %d\n", err);
-			return err;
-		}
+	err = ib_copy_from_udata(&ucmd, udata, min(sizeof(ucmd), udata->inlen));
+	if (err) {
+		ibdev_dbg(ibdev, "Failed to copy from udata for create cq, %d\n", err);
+		return err;
+	}
 
-		if ((!is_rnic_cq && attr->cqe > mdev->adapter_caps.max_qp_wr) ||
-		    attr->cqe > U32_MAX / COMP_ENTRY_SIZE) {
-			ibdev_dbg(ibdev, "CQE %d exceeding limit\n", attr->cqe);
-			return -EINVAL;
-		}
+	if ((!is_rnic_cq && attr->cqe > mdev->adapter_caps.max_qp_wr) ||
+	    attr->cqe > U32_MAX / COMP_ENTRY_SIZE) {
+		ibdev_dbg(ibdev, "CQE %d exceeding limit\n", attr->cqe);
+		return -EINVAL;
+	}
+
+	cq->cqe = attr->cqe;
+	if (!ibcq->umem)
+		ibcq->umem = ib_umem_get(ibdev, ucmd.buf_addr,
+				     cq->cqe * COMP_ENTRY_SIZE,
+				     IB_ACCESS_LOCAL_WRITE);
+	if (IS_ERR(ibcq->umem))
+		return PTR_ERR(ibcq->umem);
+	cq->queue.umem = ibcq->umem;
+
+	err = mana_ib_create_queue(mdev, &cq->queue);
+	if (err)
+		return err;
 
-		cq->cqe = attr->cqe;
-		err = mana_ib_create_queue(mdev, ucmd.buf_addr, cq->cqe * COMP_ENTRY_SIZE,
-					   &cq->queue);
+	mana_ucontext = rdma_udata_to_drv_context(udata, struct mana_ib_ucontext,
+						  ibucontext);
+	doorbell = mana_ucontext->doorbell;
+
+	if (is_rnic_cq) {
+		err = mana_ib_gd_create_cq(mdev, cq, doorbell);
 		if (err) {
-			ibdev_dbg(ibdev, "Failed to create queue for create cq, %d\n", err);
-			return err;
+			ibdev_dbg(ibdev, "Failed to create RNIC cq, %d\n", err);
+			goto err_destroy_queue;
 		}
 
-		mana_ucontext = rdma_udata_to_drv_context(udata, struct mana_ib_ucontext,
-							  ibucontext);
-		doorbell = mana_ucontext->doorbell;
-	} else {
-		buf_size = MANA_PAGE_ALIGN(roundup_pow_of_two(attr->cqe * COMP_ENTRY_SIZE));
-		cq->cqe = buf_size / COMP_ENTRY_SIZE;
-		err = mana_ib_create_kernel_queue(mdev, buf_size, GDMA_CQ, &cq->queue);
+		err = mana_ib_install_cq_cb(mdev, cq);
 		if (err) {
-			ibdev_dbg(ibdev, "Failed to create kernel queue for create cq, %d\n", err);
-			return err;
+			ibdev_dbg(ibdev, "Failed to install cq callback, %d\n", err);
+			goto err_destroy_rnic_cq;
 		}
-		doorbell = mdev->gdma_dev->doorbell;
 	}
 
+	resp.cqid = cq->queue.id;
+	err = ib_copy_to_udata(udata, &resp, min(sizeof(resp), udata->outlen));
+	if (err) {
+		ibdev_dbg(&mdev->ib_dev, "Failed to copy to udata, %d\n", err);
+		goto err_remove_cq_cb;
+	}
+
+	spin_lock_init(&cq->cq_lock);
+	INIT_LIST_HEAD(&cq->list_send_qp);
+	INIT_LIST_HEAD(&cq->list_recv_qp);
+
+	return 0;
+
+err_remove_cq_cb:
+	mana_ib_remove_cq_cb(mdev, cq);
+err_destroy_rnic_cq:
+	mana_ib_gd_destroy_cq(mdev, cq);
+err_destroy_queue:
+	mana_ib_destroy_queue(mdev, &cq->queue);
+	return err;
+}
+
+int mana_ib_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
+		      struct uverbs_attr_bundle *attrs)
+{
+	struct mana_ib_cq *cq = container_of(ibcq, struct mana_ib_cq, ibcq);
+	struct ib_device *ibdev = ibcq->device;
+	struct mana_ib_dev *mdev;
+	bool is_rnic_cq;
+	u32 doorbell;
+	u32 buf_size;
+	int err;
+
+	mdev = container_of(ibdev, struct mana_ib_dev, ib_dev);
+
+	cq->comp_vector = attr->comp_vector % ibdev->num_comp_vectors;
+	cq->cq_handle = INVALID_MANA_HANDLE;
+	is_rnic_cq = mana_ib_is_rnic(mdev);
+
+	buf_size = MANA_PAGE_ALIGN(roundup_pow_of_two(attr->cqe * COMP_ENTRY_SIZE));
+	cq->cqe = buf_size / COMP_ENTRY_SIZE;
+	err = mana_ib_create_kernel_queue(mdev, buf_size, GDMA_CQ, &cq->queue);
+	if (err) {
+		ibdev_dbg(ibdev, "Failed to create kernel queue for create cq, %d\n", err);
+		return err;
+	}
+	doorbell = mdev->gdma_dev->doorbell;
+
 	if (is_rnic_cq) {
 		err = mana_ib_gd_create_cq(mdev, cq, doorbell);
 		if (err) {
@@ -78,23 +133,12 @@ int mana_ib_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 		}
 	}
 
-	if (udata) {
-		resp.cqid = cq->queue.id;
-		err = ib_copy_to_udata(udata, &resp, min(sizeof(resp), udata->outlen));
-		if (err) {
-			ibdev_dbg(&mdev->ib_dev, "Failed to copy to udata, %d\n", err);
-			goto err_remove_cq_cb;
-		}
-	}
-
 	spin_lock_init(&cq->cq_lock);
 	INIT_LIST_HEAD(&cq->list_send_qp);
 	INIT_LIST_HEAD(&cq->list_recv_qp);
 
 	return 0;
 
-err_remove_cq_cb:
-	mana_ib_remove_cq_cb(mdev, cq);
 err_destroy_rnic_cq:
 	mana_ib_gd_destroy_cq(mdev, cq);
 err_destroy_queue:
diff --git a/drivers/infiniband/hw/mana/device.c b/drivers/infiniband/hw/mana/device.c
index ccc2279ca63c..c5c5fe051424 100644
--- a/drivers/infiniband/hw/mana/device.c
+++ b/drivers/infiniband/hw/mana/device.c
@@ -21,6 +21,7 @@ static const struct ib_device_ops mana_ib_dev_ops = {
 	.alloc_ucontext = mana_ib_alloc_ucontext,
 	.create_ah = mana_ib_create_ah,
 	.create_cq = mana_ib_create_cq,
+	.create_user_cq = mana_ib_create_user_cq,
 	.create_qp = mana_ib_create_qp,
 	.create_rwq_ind_table = mana_ib_create_rwq_ind_table,
 	.create_wq = mana_ib_create_wq,
diff --git a/drivers/infiniband/hw/mana/main.c b/drivers/infiniband/hw/mana/main.c
index fac159f7128d..a871b8287dc9 100644
--- a/drivers/infiniband/hw/mana/main.c
+++ b/drivers/infiniband/hw/mana/main.c
@@ -261,35 +261,26 @@ int mana_ib_create_kernel_queue(struct mana_ib_dev *mdev, u32 size, enum gdma_qu
 	return 0;
 }
 
-int mana_ib_create_queue(struct mana_ib_dev *mdev, u64 addr, u32 size,
+int mana_ib_create_queue(struct mana_ib_dev *mdev,
 			 struct mana_ib_queue *queue)
 {
-	struct ib_umem *umem;
 	int err;
 
-	queue->umem = NULL;
 	queue->id = INVALID_QUEUE_ID;
 	queue->gdma_region = GDMA_INVALID_DMA_REGION;
 
-	umem = ib_umem_get(&mdev->ib_dev, addr, size, IB_ACCESS_LOCAL_WRITE);
-	if (IS_ERR(umem)) {
-		ibdev_dbg(&mdev->ib_dev, "Failed to get umem, %pe\n", umem);
-		return PTR_ERR(umem);
-	}
-
-	err = mana_ib_create_zero_offset_dma_region(mdev, umem, &queue->gdma_region);
+	err = mana_ib_create_zero_offset_dma_region(mdev, queue->umem,
+						    &queue->gdma_region);
 	if (err) {
-		ibdev_dbg(&mdev->ib_dev, "Failed to create dma region, %d\n", err);
-		goto free_umem;
+		ibdev_dbg(&mdev->ib_dev, "Failed to create dma region, %d\n",
+			  err);
+		return err;
 	}
-	queue->umem = umem;
 
-	ibdev_dbg(&mdev->ib_dev, "created dma region 0x%llx\n", queue->gdma_region);
+	ibdev_dbg(&mdev->ib_dev, "created dma region 0x%llx\n",
+		  queue->gdma_region);
 
 	return 0;
-free_umem:
-	ib_umem_release(umem);
-	return err;
 }
 
 void mana_ib_destroy_queue(struct mana_ib_dev *mdev, struct mana_ib_queue *queue)
diff --git a/drivers/infiniband/hw/mana/mana_ib.h b/drivers/infiniband/hw/mana/mana_ib.h
index a7c8c0fd7019..3bc7c88dc136 100644
--- a/drivers/infiniband/hw/mana/mana_ib.h
+++ b/drivers/infiniband/hw/mana/mana_ib.h
@@ -624,7 +624,7 @@ int mana_ib_gd_destroy_dma_region(struct mana_ib_dev *dev,
 
 int mana_ib_create_kernel_queue(struct mana_ib_dev *mdev, u32 size, enum gdma_queue_type type,
 				struct mana_ib_queue *queue);
-int mana_ib_create_queue(struct mana_ib_dev *mdev, u64 addr, u32 size,
+int mana_ib_create_queue(struct mana_ib_dev *mdev,
 			 struct mana_ib_queue *queue);
 void mana_ib_destroy_queue(struct mana_ib_dev *mdev, struct mana_ib_queue *queue);
 
@@ -667,6 +667,8 @@ void mana_ib_uncfg_vport(struct mana_ib_dev *dev, struct mana_ib_pd *pd,
 
 int mana_ib_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 		      struct uverbs_attr_bundle *attrs);
+int mana_ib_create_user_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
+			   struct uverbs_attr_bundle *attrs);
 
 int mana_ib_destroy_cq(struct ib_cq *ibcq, struct ib_udata *udata);
 
diff --git a/drivers/infiniband/hw/mana/qp.c b/drivers/infiniband/hw/mana/qp.c
index 48c1f4977f21..b08dbc675741 100644
--- a/drivers/infiniband/hw/mana/qp.c
+++ b/drivers/infiniband/hw/mana/qp.c
@@ -326,11 +326,20 @@ static int mana_ib_create_qp_raw(struct ib_qp *ibqp, struct ib_pd *ibpd,
 	ibdev_dbg(&mdev->ib_dev, "ucmd sq_buf_addr 0x%llx port %u\n",
 		  ucmd.sq_buf_addr, ucmd.port);
 
-	err = mana_ib_create_queue(mdev, ucmd.sq_buf_addr, ucmd.sq_buf_size, &qp->raw_sq);
+	qp->raw_sq.umem = ib_umem_get(&mdev->ib_dev, ucmd.sq_buf_addr,
+				      ucmd.sq_buf_size, IB_ACCESS_LOCAL_WRITE);
+	if (IS_ERR(qp->raw_sq.umem)) {
+		err = PTR_ERR(qp->raw_sq.umem);
+		ibdev_dbg(&mdev->ib_dev,
+			  "Failed to get umem for qp-raw, err %d\n", err);
+		goto err_free_vport;
+	}
+
+	err = mana_ib_create_queue(mdev, &qp->raw_sq);
 	if (err) {
 		ibdev_dbg(&mdev->ib_dev,
 			  "Failed to create queue for create qp-raw, err %d\n", err);
-		goto err_free_vport;
+		goto err_release_umem;
 	}
 
 	/* Create a WQ on the same port handle used by the Ethernet */
@@ -391,6 +400,10 @@ static int mana_ib_create_qp_raw(struct ib_qp *ibqp, struct ib_pd *ibpd,
 
 err_destroy_queue:
 	mana_ib_destroy_queue(mdev, &qp->raw_sq);
+	return err;
+
+err_release_umem:
+	ib_umem_release(qp->raw_sq.umem);
 
 err_free_vport:
 	mana_ib_uncfg_vport(mdev, pd, port);
@@ -553,13 +566,25 @@ static int mana_ib_create_rc_qp(struct ib_qp *ibqp, struct ib_pd *ibpd,
 		if (i == MANA_RC_SEND_QUEUE_FMR) {
 			qp->rc_qp.queues[i].id = INVALID_QUEUE_ID;
 			qp->rc_qp.queues[i].gdma_region = GDMA_INVALID_DMA_REGION;
+			qp->rc_qp.queues[i].umem = NULL;
 			continue;
 		}
-		err = mana_ib_create_queue(mdev, ucmd.queue_buf[j], ucmd.queue_size[j],
-					   &qp->rc_qp.queues[i]);
+		qp->rc_qp.queues[i].umem = ib_umem_get(&mdev->ib_dev,
+						       ucmd.queue_buf[j],
+						       ucmd.queue_size[j],
+						       IB_ACCESS_LOCAL_WRITE);
+		if (IS_ERR(qp->rc_qp.queues[i].umem)) {
+			err = PTR_ERR(qp->rc_qp.queues[i].umem);
+			ibdev_err(&mdev->ib_dev, "Failed to get umem for queue %d, err %d\n",
+				  i, err);
+			goto release_umems;
+		}
+
+		err = mana_ib_create_queue(mdev, &qp->rc_qp.queues[i]);
 		if (err) {
 			ibdev_err(&mdev->ib_dev, "Failed to create queue %d, err %d\n", i, err);
-			goto destroy_queues;
+			ib_umem_release(qp->rc_qp.queues[i].umem);
+			goto release_umems;
 		}
 		j++;
 	}
@@ -598,6 +623,13 @@ static int mana_ib_create_rc_qp(struct ib_qp *ibqp, struct ib_pd *ibpd,
 	while (i-- > 0)
 		mana_ib_destroy_queue(mdev, &qp->rc_qp.queues[i]);
 	return err;
+
+release_umems:
+	while (i-- > 0) {
+		if (i != MANA_RC_SEND_QUEUE_FMR)
+			ib_umem_release(qp->rc_qp.queues[i].umem);
+	}
+	return err;
 }
 
 static void mana_add_qp_to_cqs(struct mana_ib_qp *qp)
diff --git a/drivers/infiniband/hw/mana/wq.c b/drivers/infiniband/hw/mana/wq.c
index f959f4b9244f..be474aa8bdfc 100644
--- a/drivers/infiniband/hw/mana/wq.c
+++ b/drivers/infiniband/hw/mana/wq.c
@@ -31,11 +31,19 @@ struct ib_wq *mana_ib_create_wq(struct ib_pd *pd,
 
 	ibdev_dbg(&mdev->ib_dev, "ucmd wq_buf_addr 0x%llx\n", ucmd.wq_buf_addr);
 
-	err = mana_ib_create_queue(mdev, ucmd.wq_buf_addr, ucmd.wq_buf_size, &wq->queue);
+	wq->queue.umem = ib_umem_get(&mdev->ib_dev, ucmd.wq_buf_addr,
+				     ucmd.wq_buf_size, IB_ACCESS_LOCAL_WRITE);
+	if (IS_ERR(wq->queue.umem)) {
+		err = PTR_ERR(wq->queue.umem);
+		ibdev_dbg(&mdev->ib_dev, "Failed to get umem for create wq, %d\n", err);
+		goto err_free_wq;
+	}
+
+	err = mana_ib_create_queue(mdev, &wq->queue);
 	if (err) {
 		ibdev_dbg(&mdev->ib_dev,
 			  "Failed to create queue for create wq, %d\n", err);
-		goto err_free_wq;
+		goto err_release_umem;
 	}
 
 	wq->wqe = init_attr->max_wr;
@@ -43,6 +51,8 @@ struct ib_wq *mana_ib_create_wq(struct ib_pd *pd,
 	wq->rx_object = INVALID_MANA_HANDLE;
 	return &wq->ibwq;
 
+err_release_umem:
+	ib_umem_release(wq->queue.umem);
 err_free_wq:
 	kfree(wq);
 

-- 
2.52.0


