Return-Path: <linux-hyperv+bounces-3728-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D898A171C0
	for <lists+linux-hyperv@lfdr.de>; Mon, 20 Jan 2025 18:28:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8865518844EA
	for <lists+linux-hyperv@lfdr.de>; Mon, 20 Jan 2025 17:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCC771F03D0;
	Mon, 20 Jan 2025 17:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="i6nEMFkt"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F0FF1EE014;
	Mon, 20 Jan 2025 17:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737394054; cv=none; b=eW+TP4Q33lNc73dpmpppobPyfv34iLf+GaaWgpVd7d73SmS0qSvHBpw6nVfajVqnljIwYypm5IgPUBxSRkn0hCfoB9HeLPHXZBciuGgK/9LoQ3Iivsm/QFDMi0RfhV7GyDwnLnbHE0uEOuhSFh9rQbAFZMEHgSa3YSXqzlUVlNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737394054; c=relaxed/simple;
	bh=4rOaSNwFNkuSA0YqJyiF6u1r+Z1gpC+Pi4Bsoc70oAc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=b9LRSf6nj2K0A/rYIW8p44+Doi2P43AfZzKbd1j18ftOATgf4xeB3yJjvLBIjDZQjlQ1leRCyUZWVbwYDvqlRjmeCEqKzUgAVLyaOLwkzsPNFhH+8CsHw78GaD9j7GEajVwDBE7GDixlZnffSCUZd4EXjFJZ93MGIdBrm9E4xeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=i6nEMFkt; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id 145FF205A9CB;
	Mon, 20 Jan 2025 09:27:26 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 145FF205A9CB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1737394046;
	bh=PE5zeG/zFarNbY/Oa5jiQLAhl13zDYbSVMNFPVROx+0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i6nEMFktw3zhIuStWtgZdGDSy+T1ZtTvIY5gqtulK39wcsezp3UkOn3Q/SebsrWLu
	 xrkTKt9Y+nmxGZ1dx3ekxMRusQiz+3Hs0mq1HqSmfUAAu+EtSi9YHluLhT3wsJ+Az+
	 MSs3qjc28r0Udl+zCpyALqKUZe/9YUteyWH9FkJo=
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
Subject: [PATCH rdma-next 05/13] RDMA/mana_ib: Create and destroy UD/GSI QP
Date: Mon, 20 Jan 2025 09:27:11 -0800
Message-Id: <1737394039-28772-6-git-send-email-kotaranov@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1737394039-28772-1-git-send-email-kotaranov@linux.microsoft.com>
References: <1737394039-28772-1-git-send-email-kotaranov@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

From: Konstantin Taranov <kotaranov@microsoft.com>

Implement HW requests to create and destroy UD/GSI QPs.
An UD/GSI QP has send and receive queues.

Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>
Reviewed-by: Shiraz Saleem <shirazsaleem@microsoft.com>
---
 drivers/infiniband/hw/mana/main.c    | 58 ++++++++++++++++++++++++++++
 drivers/infiniband/hw/mana/mana_ib.h | 49 +++++++++++++++++++++++
 2 files changed, 107 insertions(+)

diff --git a/drivers/infiniband/hw/mana/main.c b/drivers/infiniband/hw/mana/main.c
index f2f6bb3..b0c55cb 100644
--- a/drivers/infiniband/hw/mana/main.c
+++ b/drivers/infiniband/hw/mana/main.c
@@ -1013,3 +1013,61 @@ int mana_ib_gd_destroy_rc_qp(struct mana_ib_dev *mdev, struct mana_ib_qp *qp)
 	}
 	return 0;
 }
+
+int mana_ib_gd_create_ud_qp(struct mana_ib_dev *mdev, struct mana_ib_qp *qp,
+			    struct ib_qp_init_attr *attr, u32 doorbell, u32 type)
+{
+	struct mana_ib_cq *send_cq = container_of(qp->ibqp.send_cq, struct mana_ib_cq, ibcq);
+	struct mana_ib_cq *recv_cq = container_of(qp->ibqp.recv_cq, struct mana_ib_cq, ibcq);
+	struct mana_ib_pd *pd = container_of(qp->ibqp.pd, struct mana_ib_pd, ibpd);
+	struct gdma_context *gc = mdev_to_gc(mdev);
+	struct mana_rnic_create_udqp_resp resp = {};
+	struct mana_rnic_create_udqp_req req = {};
+	int err, i;
+
+	mana_gd_init_req_hdr(&req.hdr, MANA_IB_CREATE_UD_QP, sizeof(req), sizeof(resp));
+	req.hdr.dev_id = gc->mana_ib.dev_id;
+	req.adapter = mdev->adapter_handle;
+	req.pd_handle = pd->pd_handle;
+	req.send_cq_handle = send_cq->cq_handle;
+	req.recv_cq_handle = recv_cq->cq_handle;
+	for (i = 0; i < MANA_UD_QUEUE_TYPE_MAX; i++)
+		req.dma_region[i] = qp->ud_qp.queues[i].gdma_region;
+	req.doorbell_page = doorbell;
+	req.max_send_wr = attr->cap.max_send_wr;
+	req.max_recv_wr = attr->cap.max_recv_wr;
+	req.max_send_sge = attr->cap.max_send_sge;
+	req.max_recv_sge = attr->cap.max_recv_sge;
+	req.qp_type = type;
+	err = mana_gd_send_request(gc, sizeof(req), &req, sizeof(resp), &resp);
+	if (err) {
+		ibdev_err(&mdev->ib_dev, "Failed to create ud qp err %d", err);
+		return err;
+	}
+	qp->qp_handle = resp.qp_handle;
+	for (i = 0; i < MANA_UD_QUEUE_TYPE_MAX; i++) {
+		qp->ud_qp.queues[i].id = resp.queue_ids[i];
+		/* The GDMA regions are now owned by the RNIC QP handle */
+		qp->ud_qp.queues[i].gdma_region = GDMA_INVALID_DMA_REGION;
+	}
+	return 0;
+}
+
+int mana_ib_gd_destroy_ud_qp(struct mana_ib_dev *mdev, struct mana_ib_qp *qp)
+{
+	struct mana_rnic_destroy_udqp_resp resp = {0};
+	struct mana_rnic_destroy_udqp_req req = {0};
+	struct gdma_context *gc = mdev_to_gc(mdev);
+	int err;
+
+	mana_gd_init_req_hdr(&req.hdr, MANA_IB_DESTROY_UD_QP, sizeof(req), sizeof(resp));
+	req.hdr.dev_id = gc->mana_ib.dev_id;
+	req.adapter = mdev->adapter_handle;
+	req.qp_handle = qp->qp_handle;
+	err = mana_gd_send_request(gc, sizeof(req), &req, sizeof(resp), &resp);
+	if (err) {
+		ibdev_err(&mdev->ib_dev, "Failed to destroy ud qp err %d", err);
+		return err;
+	}
+	return 0;
+}
diff --git a/drivers/infiniband/hw/mana/mana_ib.h b/drivers/infiniband/hw/mana/mana_ib.h
index 79ebd95..5e470f1 100644
--- a/drivers/infiniband/hw/mana/mana_ib.h
+++ b/drivers/infiniband/hw/mana/mana_ib.h
@@ -115,6 +115,17 @@ struct mana_ib_rc_qp {
 	struct mana_ib_queue queues[MANA_RC_QUEUE_TYPE_MAX];
 };
 
+enum mana_ud_queue_type {
+	MANA_UD_SEND_QUEUE = 0,
+	MANA_UD_RECV_QUEUE,
+	MANA_UD_QUEUE_TYPE_MAX,
+};
+
+struct mana_ib_ud_qp {
+	struct mana_ib_queue queues[MANA_UD_QUEUE_TYPE_MAX];
+	u32 sq_psn;
+};
+
 struct mana_ib_qp {
 	struct ib_qp ibqp;
 
@@ -122,6 +133,7 @@ struct mana_ib_qp {
 	union {
 		struct mana_ib_queue raw_sq;
 		struct mana_ib_rc_qp rc_qp;
+		struct mana_ib_ud_qp ud_qp;
 	};
 
 	/* The port on the IB device, starting with 1 */
@@ -146,6 +158,8 @@ enum mana_ib_command_code {
 	MANA_IB_DESTROY_ADAPTER = 0x30003,
 	MANA_IB_CONFIG_IP_ADDR	= 0x30004,
 	MANA_IB_CONFIG_MAC_ADDR	= 0x30005,
+	MANA_IB_CREATE_UD_QP	= 0x30006,
+	MANA_IB_DESTROY_UD_QP	= 0x30007,
 	MANA_IB_CREATE_CQ       = 0x30008,
 	MANA_IB_DESTROY_CQ      = 0x30009,
 	MANA_IB_CREATE_RC_QP    = 0x3000a,
@@ -297,6 +311,37 @@ struct mana_rnic_destroy_rc_qp_resp {
 	struct gdma_resp_hdr hdr;
 }; /* HW Data */
 
+struct mana_rnic_create_udqp_req {
+	struct gdma_req_hdr hdr;
+	mana_handle_t adapter;
+	mana_handle_t pd_handle;
+	mana_handle_t send_cq_handle;
+	mana_handle_t recv_cq_handle;
+	u64 dma_region[MANA_UD_QUEUE_TYPE_MAX];
+	u32 qp_type;
+	u32 doorbell_page;
+	u32 max_send_wr;
+	u32 max_recv_wr;
+	u32 max_send_sge;
+	u32 max_recv_sge;
+}; /* HW Data */
+
+struct mana_rnic_create_udqp_resp {
+	struct gdma_resp_hdr hdr;
+	mana_handle_t qp_handle;
+	u32 queue_ids[MANA_UD_QUEUE_TYPE_MAX];
+}; /* HW Data*/
+
+struct mana_rnic_destroy_udqp_req {
+	struct gdma_req_hdr hdr;
+	mana_handle_t adapter;
+	mana_handle_t qp_handle;
+}; /* HW Data */
+
+struct mana_rnic_destroy_udqp_resp {
+	struct gdma_resp_hdr hdr;
+}; /* HW Data */
+
 struct mana_ib_ah_attr {
 	u8 src_addr[16];
 	u8 dest_addr[16];
@@ -483,4 +528,8 @@ int mana_ib_gd_destroy_cq(struct mana_ib_dev *mdev, struct mana_ib_cq *cq);
 int mana_ib_gd_create_rc_qp(struct mana_ib_dev *mdev, struct mana_ib_qp *qp,
 			    struct ib_qp_init_attr *attr, u32 doorbell, u64 flags);
 int mana_ib_gd_destroy_rc_qp(struct mana_ib_dev *mdev, struct mana_ib_qp *qp);
+
+int mana_ib_gd_create_ud_qp(struct mana_ib_dev *mdev, struct mana_ib_qp *qp,
+			    struct ib_qp_init_attr *attr, u32 doorbell, u32 type);
+int mana_ib_gd_destroy_ud_qp(struct mana_ib_dev *mdev, struct mana_ib_qp *qp);
 #endif
-- 
2.43.0


