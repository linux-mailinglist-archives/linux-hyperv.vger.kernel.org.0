Return-Path: <linux-hyperv+bounces-104-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A9F17A25A8
	for <lists+linux-hyperv@lfdr.de>; Fri, 15 Sep 2023 20:26:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40F091C20A78
	for <lists+linux-hyperv@lfdr.de>; Fri, 15 Sep 2023 18:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB0DA19BD7;
	Fri, 15 Sep 2023 18:24:44 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E38E18E1F;
	Fri, 15 Sep 2023 18:24:42 +0000 (UTC)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id C11151FD7;
	Fri, 15 Sep 2023 11:24:39 -0700 (PDT)
Received: by linux.microsoft.com (Postfix, from userid 1174)
	id 60255212BE7C; Fri, 15 Sep 2023 11:24:39 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 60255212BE7C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxonhyperv.com;
	s=default; t=1694802279;
	bh=TGsvvgWpwhxqiST3JXUN8KZ0za3/WKQ/h15qpNdLHjA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mUYOEGki4l0DI/ZaWsQJSQfr+HuJwxaixKsemOd0tT3KrY5Z52yLZbtxyrZshZQoZ
	 pHCa6MCfbTbSJYuvCeKekobB8o0/RWBr72YuZI29G+yXYuLWOmL5eC+qkLzLWIhkek
	 4y/A2+SzHT8MgFApfAjMYGjym1aA4xiMFcqHacDM=
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
Subject: [Patch v6 5/5] RDMA/mana_ib : Send event to qp
Date: Fri, 15 Sep 2023 11:24:30 -0700
Message-Id: <1694802270-17452-6-git-send-email-sharmaajay@linuxonhyperv.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1694802270-17452-1-git-send-email-sharmaajay@linuxonhyperv.com>
References: <1694802270-17452-1-git-send-email-sharmaajay@linuxonhyperv.com>
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
 drivers/infiniband/hw/mana/device.c  |  4 ++++
 drivers/infiniband/hw/mana/main.c    | 11 ++++++++---
 drivers/infiniband/hw/mana/mana_ib.h | 18 +++++++++---------
 drivers/infiniband/hw/mana/qp.c      |  2 ++
 4 files changed, 23 insertions(+), 12 deletions(-)

diff --git a/drivers/infiniband/hw/mana/device.c b/drivers/infiniband/hw/mana/device.c
index e15da43c73a0..fcc8083e2783 100644
--- a/drivers/infiniband/hw/mana/device.c
+++ b/drivers/infiniband/hw/mana/device.c
@@ -101,6 +101,8 @@ static int mana_ib_probe(struct auxiliary_device *adev,
 	if (ret)
 		ibdev_dbg(&mib_dev->ib_dev, "Failed to get caps, use defaults");
 
+	xa_init(&mib_dev->rq_to_qp_lookup_table);
+
 	ret = ib_register_device(&mib_dev->ib_dev, "mana_%d",
 				 mdev->gdma_context->dev);
 	if (ret)
@@ -112,6 +114,7 @@ static int mana_ib_probe(struct auxiliary_device *adev,
 
 destroy_adapter:
 	mana_ib_destroy_adapter(mib_dev);
+	xa_destroy(&mib_dev->rq_to_qp_lookup_table);
 free_error_eq:
 	mana_gd_destroy_queue(mib_dev->gc, mib_dev->fatal_err_eq);
 deregister_device:
@@ -129,6 +132,7 @@ static void mana_ib_remove(struct auxiliary_device *adev)
 	mana_ib_destroy_adapter(mib_dev);
 	mana_gd_deregister_device(&mib_dev->gc->mana_ib);
 	ib_unregister_device(&mib_dev->ib_dev);
+	xa_destroy(&mib_dev->rq_to_qp_lookup_table);
 	ib_dealloc_device(&mib_dev->ib_dev);
 }
 
diff --git a/drivers/infiniband/hw/mana/main.c b/drivers/infiniband/hw/mana/main.c
index 82923475267d..29be8fd1ec7f 100644
--- a/drivers/infiniband/hw/mana/main.c
+++ b/drivers/infiniband/hw/mana/main.c
@@ -556,13 +556,18 @@ static void mana_ib_critical_event_handler(void *ctx, struct gdma_queue *queue,
 {
 	struct mana_ib_dev *mib_dev = (struct mana_ib_dev *)ctx;
 	struct ib_event mib_event;
+	struct mana_ib_qp *qp;
+	u64 rq_id;
 	switch (event->type) {
 	case GDMA_EQE_SOC_EVENT_NOTIFICATION:
+		rq_id = event->details[0] & 0xFFFFFF;
+		qp = xa_load(&mib_dev->rq_to_qp_lookup_table, rq_id);
 		mib_event.event = IB_EVENT_QP_FATAL;
 		mib_event.device = &mib_dev->ib_dev;
-		mib_event.element.qp =
-				(struct ib_qp*)(event->details[0] & 0xFFFFFF);
-		ib_dispatch_event(&mib_event);
+		if (qp && qp->ibqp.event_handler)
+			qp->ibqp.event_handler(&mib_event, qp->ibqp.qp_context);
+		else
+			ibdev_dbg(&mib_dev->ib_dev, "found no qp or event handler");
 		ibdev_dbg(&mib_dev->ib_dev, "Received critical notification");
 		break;
 	default:
diff --git a/drivers/infiniband/hw/mana/mana_ib.h b/drivers/infiniband/hw/mana/mana_ib.h
index 6b9406738cb2..243572b52336 100644
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
+	struct xarray rq_to_qp_lookup_table;
+};
 struct mana_ib_rwq_ind_table {
 	struct ib_rwq_ind_table ib_ind_table;
 };
diff --git a/drivers/infiniband/hw/mana/qp.c b/drivers/infiniband/hw/mana/qp.c
index ef3275ac92a0..19fae28985c3 100644
--- a/drivers/infiniband/hw/mana/qp.c
+++ b/drivers/infiniband/hw/mana/qp.c
@@ -210,6 +210,8 @@ static int mana_ib_create_qp_rss(struct ib_qp *ibqp, struct ib_pd *pd,
 		wq->id = wq_spec.queue_index;
 		cq->id = cq_spec.queue_index;
 
+		xa_store(&mib_dev->rq_to_qp_lookup_table, wq->id, qp, GFP_KERNEL);
+
 		ibdev_dbg(&mib_dev->ib_dev,
 			  "ret %d rx_object 0x%llx wq id %llu cq id %llu\n",
 			  ret, wq->rx_object, wq->id, cq->id);
-- 
2.25.1


