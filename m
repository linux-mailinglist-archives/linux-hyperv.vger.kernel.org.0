Return-Path: <linux-hyperv+bounces-12-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A2EE797C55
	for <lists+linux-hyperv@lfdr.de>; Thu,  7 Sep 2023 20:51:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB5C728171F
	for <lists+linux-hyperv@lfdr.de>; Thu,  7 Sep 2023 18:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA6FB14000;
	Thu,  7 Sep 2023 18:51:09 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90B813FF3;
	Thu,  7 Sep 2023 18:51:09 +0000 (UTC)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id AECC31FFE;
	Thu,  7 Sep 2023 11:50:36 -0700 (PDT)
Received: by linux.microsoft.com (Postfix, from userid 1174)
	id 42386212B5BC; Thu,  7 Sep 2023 09:52:50 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 42386212B5BC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxonhyperv.com;
	s=default; t=1694105570;
	bh=4zQMQP97jZOnWxiO8SrNZy/IXpzjUCMzd8MtskOqFr4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hJuEq3wZYTifPv4qQ3rFFyhahGw7uXYhbGBpHQkUQ4VSMBVB2R51yjczdch5Gg+iW
	 y6onyUrJUs/hglqRFdnOAQqZmw5kA4XC8nO4G5+0hirkSdqpHcSZUPL3cUhs4aZdtP
	 FKabnH53JYKnYBZX1plCfkARZAlg3gE5yFOtRyY0=
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
Subject: [Patch v5 5/5] RDMA/mana_ib : Send event to qp
Date: Thu,  7 Sep 2023 09:52:39 -0700
Message-Id: <1694105559-9465-6-git-send-email-sharmaajay@linuxonhyperv.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1694105559-9465-1-git-send-email-sharmaajay@linuxonhyperv.com>
References: <1694105559-9465-1-git-send-email-sharmaajay@linuxonhyperv.com>
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

Send the QP fatal error event to only the
context that created the qp.

Signed-off-by: Ajay Sharma <sharmaajay@microsoft.com>
---
 drivers/infiniband/hw/mana/device.c  |  9 +++++++++
 drivers/infiniband/hw/mana/main.c    |  9 ++++++---
 drivers/infiniband/hw/mana/mana_ib.h | 18 +++++++++---------
 drivers/infiniband/hw/mana/qp.c      |  2 ++
 4 files changed, 26 insertions(+), 12 deletions(-)

diff --git a/drivers/infiniband/hw/mana/device.c b/drivers/infiniband/hw/mana/device.c
index e15da43c73a0..563b5a1e79d2 100644
--- a/drivers/infiniband/hw/mana/device.c
+++ b/drivers/infiniband/hw/mana/device.c
@@ -101,6 +101,14 @@ static int mana_ib_probe(struct auxiliary_device *adev,
 	if (ret)
 		ibdev_dbg(&mib_dev->ib_dev, "Failed to get caps, use defaults");
 
+	mib_dev->rq_to_qp_lookup_table = kzalloc(sizeof(struct mana_ib_qp*) *
+					  mib_dev->adapter_caps.max_qp_count,
+					  GFP_KERNEL);
+	if (!mib_dev->rq_to_qp_lookup_table) {
+		ibdev_err(&mib_dev->ib_dev, "Failed to allocate rq lookup table");
+		goto free_error_eq;
+	}
+
 	ret = ib_register_device(&mib_dev->ib_dev, "mana_%d",
 				 mdev->gdma_context->dev);
 	if (ret)
@@ -112,6 +120,7 @@ static int mana_ib_probe(struct auxiliary_device *adev,
 
 destroy_adapter:
 	mana_ib_destroy_adapter(mib_dev);
+	kfree(mib_dev->rq_to_qp_lookup_table);
 free_error_eq:
 	mana_gd_destroy_queue(mib_dev->gc, mib_dev->fatal_err_eq);
 deregister_device:
diff --git a/drivers/infiniband/hw/mana/main.c b/drivers/infiniband/hw/mana/main.c
index 82923475267d..517a2a4f0d76 100644
--- a/drivers/infiniband/hw/mana/main.c
+++ b/drivers/infiniband/hw/mana/main.c
@@ -556,13 +556,16 @@ static void mana_ib_critical_event_handler(void *ctx, struct gdma_queue *queue,
 {
 	struct mana_ib_dev *mib_dev = (struct mana_ib_dev *)ctx;
 	struct ib_event mib_event;
+	struct mana_ib_qp *qp;
+	u64 rq_id;
 	switch (event->type) {
 	case GDMA_EQE_SOC_EVENT_NOTIFICATION:
+		rq_id = event->details[0] & 0xFFFFFF;
+		qp = mib_dev->rq_to_qp_lookup_table[rq_id];
 		mib_event.event = IB_EVENT_QP_FATAL;
 		mib_event.device = &mib_dev->ib_dev;
-		mib_event.element.qp =
-				(struct ib_qp*)(event->details[0] & 0xFFFFFF);
-		ib_dispatch_event(&mib_event);
+		if (qp && qp->ibqp.event_handler)
+			qp->ibqp.event_handler(&mib_event, qp->ibqp.qp_context);
 		ibdev_dbg(&mib_dev->ib_dev, "Received critical notification");
 		break;
 	default:
diff --git a/drivers/infiniband/hw/mana/mana_ib.h b/drivers/infiniband/hw/mana/mana_ib.h
index 6b9406738cb2..d796b0ed0288 100644
--- a/drivers/infiniband/hw/mana/mana_ib.h
+++ b/drivers/infiniband/hw/mana/mana_ib.h
@@ -48,15 +48,6 @@ struct mana_ib_adapter_caps {
 	u32 max_inline_data_size;
 };
 
-struct mana_ib_dev {
-	struct ib_device ib_dev;
-	struct gdma_dev *gdma_dev;
-	struct gdma_context *gc;
-	struct gdma_queue *fatal_err_eq;
-	mana_handle_t adapter_handle;
-	struct mana_ib_adapter_caps adapter_caps;
-};
-
 struct mana_ib_wq {
 	struct ib_wq ibwq;
 	struct ib_umem *umem;
@@ -113,6 +104,15 @@ struct mana_ib_ucontext {
 	u32 doorbell;
 };
 
+struct mana_ib_dev {
+	struct ib_device ib_dev;
+	struct gdma_dev *gdma_dev;
+	struct gdma_context *gc;
+	struct gdma_queue *fatal_err_eq;
+	mana_handle_t adapter_handle;
+	struct mana_ib_adapter_caps adapter_caps;
+	struct mana_ib_qp **rq_to_qp_lookup_table;
+};
 struct mana_ib_rwq_ind_table {
 	struct ib_rwq_ind_table ib_ind_table;
 };
diff --git a/drivers/infiniband/hw/mana/qp.c b/drivers/infiniband/hw/mana/qp.c
index ef3275ac92a0..bad72c0e8265 100644
--- a/drivers/infiniband/hw/mana/qp.c
+++ b/drivers/infiniband/hw/mana/qp.c
@@ -210,6 +210,8 @@ static int mana_ib_create_qp_rss(struct ib_qp *ibqp, struct ib_pd *pd,
 		wq->id = wq_spec.queue_index;
 		cq->id = cq_spec.queue_index;
 
+		mib_dev->rq_to_qp_lookup_table[wq->id] = qp;
+
 		ibdev_dbg(&mib_dev->ib_dev,
 			  "ret %d rx_object 0x%llx wq id %llu cq id %llu\n",
 			  ret, wq->rx_object, wq->id, cq->id);
-- 
2.25.1


