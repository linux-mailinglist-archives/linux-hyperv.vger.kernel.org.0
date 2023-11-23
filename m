Return-Path: <linux-hyperv+bounces-1036-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 392DF7F56D4
	for <lists+linux-hyperv@lfdr.de>; Thu, 23 Nov 2023 04:10:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3112B2123D
	for <lists+linux-hyperv@lfdr.de>; Thu, 23 Nov 2023 03:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22DE68828;
	Thu, 23 Nov 2023 03:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxonhyperv.com header.i=@linuxonhyperv.com header.b="iAFN63n9"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 57A23D48;
	Wed, 22 Nov 2023 19:10:24 -0800 (PST)
Received: by linux.microsoft.com (Postfix, from userid 1004)
	id E4D7020B74C4; Wed, 22 Nov 2023 19:10:23 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E4D7020B74C4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxonhyperv.com;
	s=default; t=1700709023;
	bh=zge+TQFwXGx9zNXcHD09zsfe5McbZNNhO/IEkAckKVM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iAFN63n9SE1RgVIab3JOrK9ll9qHaKIFkOz8tMFxWp5qDGZ71cWZNOmRwkCZtwU4p
	 g4xt8dsaR53C75JBszyExnLp4fmqRQaVt18Gou3A5SMDCQu6VUbjtTO/rvF9foc92P
	 qwEYH83jEIwPXG5OOQkt3vDC26G3laTw4DSzG0SU=
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
Subject: [Patch v1 4/4] RDMA/mana_ib: query device capabilities
Date: Wed, 22 Nov 2023 19:10:10 -0800
Message-Id: <1700709010-22042-5-git-send-email-longli@linuxonhyperv.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1700709010-22042-1-git-send-email-longli@linuxonhyperv.com>
References: <1700709010-22042-1-git-send-email-longli@linuxonhyperv.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

From: Long Li <longli@microsoft.com>

With RDMA device handle created, use it to query on hardware capabilities
and cache this information for future query requests to the driver.

Signed-off-by: Long Li <longli@microsoft.com>
---
 drivers/infiniband/hw/mana/cq.c      |  2 +-
 drivers/infiniband/hw/mana/device.c  |  6 +++
 drivers/infiniband/hw/mana/main.c    | 59 +++++++++++++++++++++++-----
 drivers/infiniband/hw/mana/mana_ib.h | 51 ++++++++++++++++++++++++
 drivers/infiniband/hw/mana/qp.c      |  6 ++-
 include/net/mana/gdma.h              |  1 +
 6 files changed, 112 insertions(+), 13 deletions(-)

diff --git a/drivers/infiniband/hw/mana/cq.c b/drivers/infiniband/hw/mana/cq.c
index d141cab8a1e6..71064f17c235 100644
--- a/drivers/infiniband/hw/mana/cq.c
+++ b/drivers/infiniband/hw/mana/cq.c
@@ -26,7 +26,7 @@ int mana_ib_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 		return err;
 	}
 
-	if (attr->cqe > MAX_SEND_BUFFERS_PER_QUEUE) {
+	if (attr->cqe > mdev->adapter_caps.max_requester_sq_size) {
 		ibdev_dbg(ibdev, "CQE %d exceeding limit\n", attr->cqe);
 		return -EINVAL;
 	}
diff --git a/drivers/infiniband/hw/mana/device.c b/drivers/infiniband/hw/mana/device.c
index 5e5aa75230c2..06f53df072bb 100644
--- a/drivers/infiniband/hw/mana/device.c
+++ b/drivers/infiniband/hw/mana/device.c
@@ -99,6 +99,12 @@ static int mana_ib_probe(struct auxiliary_device *adev,
 		goto free_error_eq;
 	}
 
+	ret = mana_ib_query_adapter_caps(dev);
+	if (ret) {
+		ibdev_dbg(&dev->ib_dev, "Failed to get device caps");
+		goto destroy_adapter;
+	}
+
 	ret = ib_register_device(&dev->ib_dev, "mana_%d",
 				 mdev->gdma_context->dev);
 	if (ret)
diff --git a/drivers/infiniband/hw/mana/main.c b/drivers/infiniband/hw/mana/main.c
index 4f4343d14041..bf27fa395a67 100644
--- a/drivers/infiniband/hw/mana/main.c
+++ b/drivers/infiniband/hw/mana/main.c
@@ -486,18 +486,14 @@ int mana_ib_get_port_immutable(struct ib_device *ibdev, u32 port_num,
 int mana_ib_query_device(struct ib_device *ibdev, struct ib_device_attr *props,
 			 struct ib_udata *uhw)
 {
-	props->max_qp = MANA_MAX_NUM_QUEUES;
-	props->max_qp_wr = MAX_SEND_BUFFERS_PER_QUEUE;
-
-	/*
-	 * max_cqe could be potentially much bigger.
-	 * As this version of driver only support RAW QP, set it to the same
-	 * value as max_qp_wr
-	 */
-	props->max_cqe = MAX_SEND_BUFFERS_PER_QUEUE;
+	struct mana_ib_dev *dev = container_of(ibdev,
+			struct mana_ib_dev, ib_dev);
 
+	props->max_qp = dev->adapter_caps.max_qp_count;
+	props->max_qp_wr = dev->adapter_caps.max_requester_sq_size;
+	props->max_cqe = dev->adapter_caps.max_requester_sq_size;
+	props->max_mr = dev->adapter_caps.max_mr_count;
 	props->max_mr_size = MANA_IB_MAX_MR_SIZE;
-	props->max_mr = MANA_IB_MAX_MR;
 	props->max_send_sge = MAX_TX_WQE_SGL_ENTRIES;
 	props->max_recv_sge = MAX_RX_WQE_SGL_ENTRIES;
 
@@ -624,3 +620,46 @@ int mana_ib_create_error_eq(struct mana_ib_dev *dev)
 
 	return 0;
 }
+
+int mana_ib_query_adapter_caps(struct mana_ib_dev *dev)
+{
+	struct mana_ib_query_adapter_caps_resp resp = {};
+	struct mana_ib_query_adapter_caps_req req = {};
+	struct mana_ib_adapter_caps *caps = &dev->adapter_caps;
+	int err;
+
+	mana_gd_init_req_hdr(&req.hdr, MANA_IB_GET_ADAPTER_CAP, sizeof(req),
+			     sizeof(resp));
+	req.hdr.resp.msg_version = GDMA_MESSAGE_V3;
+	req.hdr.dev_id = dev->gdma_dev->dev_id;
+
+	err = mana_gd_send_request(dev->gdma_dev->gdma_context, sizeof(req),
+				   &req, sizeof(resp), &resp);
+
+	if (err) {
+		ibdev_err(&dev->ib_dev,
+			  "Failed to query adapter caps err %d", err);
+		return err;
+	}
+
+	caps->max_sq_id = resp.max_sq_id;
+	caps->max_rq_id = resp.max_rq_id;
+	caps->max_cq_id = resp.max_cq_id;
+	caps->max_qp_count = resp.max_qp_count;
+	caps->max_cq_count = resp.max_cq_count;
+	caps->max_mr_count = resp.max_mr_count;
+	caps->max_pd_count = resp.max_pd_count;
+	caps->max_inbound_read_limit = resp.max_inbound_read_limit;
+	caps->max_outbound_read_limit = resp.max_outbound_read_limit;
+	caps->mw_count = resp.mw_count;
+	caps->max_srq_count = resp.max_srq_count;
+	caps->max_requester_sq_size = resp.max_requester_sq_size;
+	caps->max_responder_sq_size = resp.max_responder_sq_size;
+	caps->max_requester_rq_size = resp.max_requester_rq_size;
+	caps->max_responder_rq_size = resp.max_responder_rq_size;
+	caps->max_inline_data_size = resp.max_inline_data_size;
+	caps->max_send_wqe_size = MAX_TX_WQE_SGL_ENTRIES;
+	caps->max_recv_wqe_size = MAX_RX_WQE_SGL_ENTRIES;
+
+	return 0;
+}
diff --git a/drivers/infiniband/hw/mana/mana_ib.h b/drivers/infiniband/hw/mana/mana_ib.h
index 4286caf0d67c..d7a56b075fbc 100644
--- a/drivers/infiniband/hw/mana/mana_ib.h
+++ b/drivers/infiniband/hw/mana/mana_ib.h
@@ -27,11 +27,33 @@
  */
 #define MANA_IB_MAX_MR		0xFFFFFFu
 
+struct mana_ib_adapter_caps {
+	u32 max_sq_id;
+	u32 max_rq_id;
+	u32 max_cq_id;
+	u32 max_qp_count;
+	u32 max_cq_count;
+	u32 max_mr_count;
+	u32 max_pd_count;
+	u32 max_inbound_read_limit;
+	u32 max_outbound_read_limit;
+	u32 mw_count;
+	u32 max_srq_count;
+	u32 max_requester_sq_size;
+	u32 max_responder_sq_size;
+	u32 max_requester_rq_size;
+	u32 max_responder_rq_size;
+	u32 max_send_wqe_size;
+	u32 max_recv_wqe_size;
+	u32 max_inline_data_size;
+};
+
 struct mana_ib_dev {
 	struct ib_device ib_dev;
 	struct gdma_dev *gdma_dev;
 	struct gdma_queue *fatal_err_eq;
 	mana_handle_t adapter_handle;
+	struct mana_ib_adapter_caps adapter_caps;
 	struct xarray rq_to_qp_lookup_table;
 };
 
@@ -96,6 +118,7 @@ struct mana_ib_rwq_ind_table {
 };
 
 enum mana_ib_command_code {
+	MANA_IB_GET_ADAPTER_CAP = 0x30001,
 	MANA_IB_CREATE_ADAPTER  = 0x30002,
 	MANA_IB_DESTROY_ADAPTER = 0x30003,
 };
@@ -120,6 +143,32 @@ struct mana_ib_destroy_adapter_resp {
 	struct gdma_resp_hdr hdr;
 }; /* HW Data */
 
+struct mana_ib_query_adapter_caps_req {
+	struct gdma_req_hdr hdr;
+}; /*HW Data */
+
+struct mana_ib_query_adapter_caps_resp {
+	struct gdma_resp_hdr hdr;
+	u32 max_sq_id;
+	u32 max_rq_id;
+	u32 max_cq_id;
+	u32 max_qp_count;
+	u32 max_cq_count;
+	u32 max_mr_count;
+	u32 max_pd_count;
+	u32 max_inbound_read_limit;
+	u32 max_outbound_read_limit;
+	u32 mw_count;
+	u32 max_srq_count;
+	u32 max_requester_sq_size;
+	u32 max_responder_sq_size;
+	u32 max_requester_rq_size;
+	u32 max_responder_rq_size;
+	u32 max_send_wqe_size;
+	u32 max_recv_wqe_size;
+	u32 max_inline_data_size;
+}; /* HW Data */
+
 int mana_ib_gd_create_dma_region(struct mana_ib_dev *dev, struct ib_umem *umem,
 				 mana_handle_t *gdma_region);
 
@@ -193,4 +242,6 @@ int mana_ib_create_adapter(struct mana_ib_dev *mdev);
 
 int mana_ib_destroy_adapter(struct mana_ib_dev *mdev);
 
+int mana_ib_query_adapter_caps(struct mana_ib_dev *mdev);
+
 #endif
diff --git a/drivers/infiniband/hw/mana/qp.c b/drivers/infiniband/hw/mana/qp.c
index 7ff9c8364551..7211e93d999c 100644
--- a/drivers/infiniband/hw/mana/qp.c
+++ b/drivers/infiniband/hw/mana/qp.c
@@ -130,7 +130,8 @@ static int mana_ib_create_qp_rss(struct ib_qp *ibqp, struct ib_pd *pd,
 		return ret;
 	}
 
-	if (attr->cap.max_recv_wr > MAX_SEND_BUFFERS_PER_QUEUE) {
+	if (attr->cap.max_recv_wr >
+			mdev->adapter_caps.max_requester_sq_size) {
 		ibdev_dbg(&mdev->ib_dev,
 			  "Requested max_recv_wr %d exceeding limit\n",
 			  attr->cap.max_recv_wr);
@@ -302,7 +303,8 @@ static int mana_ib_create_qp_raw(struct ib_qp *ibqp, struct ib_pd *ibpd,
 	if (port < 1 || port > mc->num_ports)
 		return -EINVAL;
 
-	if (attr->cap.max_send_wr > MAX_SEND_BUFFERS_PER_QUEUE) {
+	if (attr->cap.max_send_wr >
+			mdev->adapter_caps.max_requester_sq_size) {
 		ibdev_dbg(&mdev->ib_dev,
 			  "Requested max_send_wr %d exceeding limit\n",
 			  attr->cap.max_send_wr);
diff --git a/include/net/mana/gdma.h b/include/net/mana/gdma.h
index e32c75639557..c1850ec7faae 100644
--- a/include/net/mana/gdma.h
+++ b/include/net/mana/gdma.h
@@ -155,6 +155,7 @@ struct gdma_general_req {
 
 #define GDMA_MESSAGE_V1 1
 #define GDMA_MESSAGE_V2 2
+#define GDMA_MESSAGE_V3 3
 
 struct gdma_general_resp {
 	struct gdma_resp_hdr hdr;
-- 
2.34.1


