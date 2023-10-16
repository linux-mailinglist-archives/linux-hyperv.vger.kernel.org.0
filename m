Return-Path: <linux-hyperv+bounces-534-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2792B7CB653
	for <lists+linux-hyperv@lfdr.de>; Tue, 17 Oct 2023 00:12:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0F81281752
	for <lists+linux-hyperv@lfdr.de>; Mon, 16 Oct 2023 22:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8573E3AC01;
	Mon, 16 Oct 2023 22:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxonhyperv.com header.i=@linuxonhyperv.com header.b="sIglcy3J"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD58038BAE;
	Mon, 16 Oct 2023 22:12:09 +0000 (UTC)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2B6E6A2;
	Mon, 16 Oct 2023 15:12:08 -0700 (PDT)
Received: by linux.microsoft.com (Postfix, from userid 1174)
	id BA57A20B74C4; Mon, 16 Oct 2023 15:12:07 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com BA57A20B74C4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxonhyperv.com;
	s=default; t=1697494327;
	bh=JfH/kT2Zb63F1nSVS8CfDX2oQ7h5+bWcSsUa4Ir4xSY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sIglcy3J+68SZwlqLnhDqI6Pr4bZCyIym5P+dlb8wkQFojvb/B6OggLV74P/NfBMp
	 AMvZ96Xt+D9Um2gVHtIQUSgzLtLy8fXrhR/3TYeqDgOQvmfu5JjPFJMRirQnyBWaY2
	 O7rMr4rCk1LG06fzpvWfTI1uFHAiu4DIn+G1802I=
From: sharmaajay@linuxonhyperv.com
To: Long Li <longli@microsoft.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: linux-rdma@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ajay Sharma <sharmaajay@microsoft.com>
Subject: [Patch v7 4/5] RDMA/mana_ib: Query adapter capabilities
Date: Mon, 16 Oct 2023 15:12:01 -0700
Message-Id: <1697494322-26814-5-git-send-email-sharmaajay@linuxonhyperv.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1697494322-26814-1-git-send-email-sharmaajay@linuxonhyperv.com>
References: <1697494322-26814-1-git-send-email-sharmaajay@linuxonhyperv.com>
X-Spam-Status: No, score=-9.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_SPF_WL
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

From: Ajay Sharma <sharmaajay@microsoft.com>

Query the adapter capabilities to expose to
other clients and VF. This checks against
the user supplied values and protects against
overflows.

Signed-off-by: Ajay Sharma <sharmaajay@microsoft.com>
---
 drivers/infiniband/hw/mana/device.c  |  4 ++
 drivers/infiniband/hw/mana/main.c    | 67 ++++++++++++++++++++++------
 drivers/infiniband/hw/mana/mana_ib.h | 53 +++++++++++++++++++++-
 3 files changed, 110 insertions(+), 14 deletions(-)

diff --git a/drivers/infiniband/hw/mana/device.c b/drivers/infiniband/hw/mana/device.c
index 4077e440657a..e15da43c73a0 100644
--- a/drivers/infiniband/hw/mana/device.c
+++ b/drivers/infiniband/hw/mana/device.c
@@ -97,6 +97,10 @@ static int mana_ib_probe(struct auxiliary_device *adev,
 		goto free_error_eq;
 	}
 
+	ret = mana_ib_query_adapter_caps(mib_dev);
+	if (ret)
+		ibdev_dbg(&mib_dev->ib_dev, "Failed to get caps, use defaults");
+
 	ret = ib_register_device(&mib_dev->ib_dev, "mana_%d",
 				 mdev->gdma_context->dev);
 	if (ret)
diff --git a/drivers/infiniband/hw/mana/main.c b/drivers/infiniband/hw/mana/main.c
index 5b5d7abe79ac..82923475267d 100644
--- a/drivers/infiniband/hw/mana/main.c
+++ b/drivers/infiniband/hw/mana/main.c
@@ -469,20 +469,15 @@ int mana_ib_get_port_immutable(struct ib_device *ibdev, u32 port_num,
 int mana_ib_query_device(struct ib_device *ibdev, struct ib_device_attr *props,
 			 struct ib_udata *uhw)
 {
-	props->max_qp = MANA_MAX_NUM_QUEUES;
-	props->max_qp_wr = MAX_SEND_BUFFERS_PER_QUEUE;
+	struct mana_ib_dev *mib_dev = container_of(ibdev,
+			struct mana_ib_dev, ib_dev);
 
-	/*
-	 * max_cqe could be potentially much bigger.
-	 * As this version of driver only support RAW QP, set it to the same
-	 * value as max_qp_wr
-	 */
-	props->max_cqe = MAX_SEND_BUFFERS_PER_QUEUE;
-
-	props->max_mr_size = MANA_IB_MAX_MR_SIZE;
-	props->max_mr = MANA_IB_MAX_MR;
-	props->max_send_sge = MAX_TX_WQE_SGL_ENTRIES;
-	props->max_recv_sge = MAX_RX_WQE_SGL_ENTRIES;
+	props->max_qp = mib_dev->adapter_caps.max_qp_count;
+	props->max_qp_wr = mib_dev->adapter_caps.max_requester_sq_size;
+	props->max_cqe = mib_dev->adapter_caps.max_requester_sq_size;
+	props->max_mr = mib_dev->adapter_caps.max_mr_count;
+	props->max_send_sge = mib_dev->adapter_caps.max_send_wqe_size;
+	props->max_recv_sge = mib_dev->adapter_caps.max_recv_wqe_size;
 
 	return 0;
 }
@@ -601,3 +596,49 @@ int mana_ib_create_error_eq(struct mana_ib_dev *mib_dev)
 
 	return 0;
 }
+
+static void assign_caps(struct mana_ib_adapter_caps *caps,
+			struct mana_ib_query_adapter_caps_resp *resp)
+{
+	caps->max_sq_id = resp->max_sq_id;
+	caps->max_rq_id = resp->max_rq_id;
+	caps->max_cq_id = resp->max_cq_id;
+	caps->max_qp_count = resp->max_qp_count;
+	caps->max_cq_count = resp->max_cq_count;
+	caps->max_mr_count = resp->max_mr_count;
+	caps->max_pd_count = resp->max_pd_count;
+	caps->max_inbound_read_limit = resp->max_inbound_read_limit;
+	caps->max_outbound_read_limit = resp->max_outbound_read_limit;
+	caps->mw_count = resp->mw_count;
+	caps->max_srq_count = resp->max_srq_count;
+	caps->max_requester_sq_size = resp->max_requester_sq_size;
+	caps->max_responder_sq_size = resp->max_responder_sq_size;
+	caps->max_requester_rq_size = resp->max_requester_rq_size;
+	caps->max_responder_rq_size = resp->max_responder_rq_size;
+	caps->max_send_wqe_size = resp->max_send_wqe_size;
+	caps->max_recv_wqe_size = resp->max_recv_wqe_size;
+	caps->max_inline_data_size = resp->max_inline_data_size;
+}
+
+int mana_ib_query_adapter_caps(struct mana_ib_dev *mib_dev)
+{
+	struct mana_ib_query_adapter_caps_resp resp = {};
+	struct mana_ib_query_adapter_caps_req req = {};
+	int err;
+
+	mana_gd_init_req_hdr(&req.hdr, MANA_IB_GET_ADAPTER_CAP, sizeof(req),
+			     sizeof(resp));
+	req.hdr.resp.msg_version = MANA_IB_GET_ADAPTER_CAP_RESPONSE_V3;
+	req.hdr.dev_id = mib_dev->gc->mana_ib.dev_id;
+
+	err = mana_gd_send_request(mib_dev->gc, sizeof(req), &req,
+				   sizeof(resp), &resp);
+
+	if (err) {
+		ibdev_err(&mib_dev->ib_dev, "Failed to query adapter caps err %d", err);
+		return err;
+	}
+
+	assign_caps(&mib_dev->adapter_caps, &resp);
+	return 0;
+}
diff --git a/drivers/infiniband/hw/mana/mana_ib.h b/drivers/infiniband/hw/mana/mana_ib.h
index 8a652bccd978..6b9406738cb2 100644
--- a/drivers/infiniband/hw/mana/mana_ib.h
+++ b/drivers/infiniband/hw/mana/mana_ib.h
@@ -20,19 +20,41 @@
 
 /* MANA doesn't have any limit for MR size */
 #define MANA_IB_MAX_MR_SIZE	U64_MAX
-
+#define MANA_IB_GET_ADAPTER_CAP_RESPONSE_V3 3
 /*
  * The hardware limit of number of MRs is greater than maximum number of MRs
  * that can possibly represent in 24 bits
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
 	struct gdma_context *gc;
 	struct gdma_queue *fatal_err_eq;
 	mana_handle_t adapter_handle;
+	struct mana_ib_adapter_caps adapter_caps;
 };
 
 struct mana_ib_wq {
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
 int mana_ib_gd_create_dma_region(struct mana_ib_dev *mib_dev,
 				 struct ib_umem *umem,
 				 mana_handle_t *gdma_region);
@@ -194,4 +243,6 @@ int mana_ib_create_adapter(struct mana_ib_dev *mib_dev);
 
 int mana_ib_destroy_adapter(struct mana_ib_dev *mib_dev);
 
+int mana_ib_query_adapter_caps(struct mana_ib_dev *mib_dev);
+
 #endif
-- 
2.25.1


