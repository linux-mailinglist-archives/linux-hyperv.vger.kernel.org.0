Return-Path: <linux-hyperv+bounces-1033-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 127F97F56CB
	for <lists+linux-hyperv@lfdr.de>; Thu, 23 Nov 2023 04:10:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7CC5AB21101
	for <lists+linux-hyperv@lfdr.de>; Thu, 23 Nov 2023 03:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5A8D612D;
	Thu, 23 Nov 2023 03:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxonhyperv.com header.i=@linuxonhyperv.com header.b="YvYrDBNx"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 807261BF;
	Wed, 22 Nov 2023 19:10:23 -0800 (PST)
Received: by linux.microsoft.com (Postfix, from userid 1004)
	id 15FA020B74C3; Wed, 22 Nov 2023 19:10:23 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 15FA020B74C3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxonhyperv.com;
	s=default; t=1700709023;
	bh=xQ3ukOJ7UAMLtXOhtejHTA9H2LOb0GWntyVyLe1Zgwk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YvYrDBNxlA+Y7BRxm67Df5yz8aKeEi3dO5140JpcvsPSqRhApWQIpPgxcezhUZ56i
	 pD07Ox+JhpLu7mYXOFkAdSySEsPg/JL0Ma2XDQ/CLyRYqHSOXMLGB+vdHRtMvKOBQX
	 4qozkANc4LALqBPURkMf4+n2sRx6BKwo/AFSIy/k=
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
Subject: [Patch v1 3/4] RDMA/mana_ib: create RDMA adapter handle
Date: Wed, 22 Nov 2023 19:10:09 -0800
Message-Id: <1700709010-22042-4-git-send-email-longli@linuxonhyperv.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1700709010-22042-1-git-send-email-longli@linuxonhyperv.com>
References: <1700709010-22042-1-git-send-email-longli@linuxonhyperv.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

From: Long Li <longli@microsoft.com>

Create the RDMA device handle with the SoC using the management EQ created
earlier.

Signed-off-by: Long Li <longli@microsoft.com>
---
 drivers/infiniband/hw/mana/device.c  | 10 ++++--
 drivers/infiniband/hw/mana/main.c    | 51 ++++++++++++++++++++++++++++
 drivers/infiniband/hw/mana/mana_ib.h | 30 ++++++++++++++++
 3 files changed, 88 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/mana/device.c b/drivers/infiniband/hw/mana/device.c
index 3da4763e1a0c..5e5aa75230c2 100644
--- a/drivers/infiniband/hw/mana/device.c
+++ b/drivers/infiniband/hw/mana/device.c
@@ -93,9 +93,10 @@ static int mana_ib_probe(struct auxiliary_device *adev,
 		goto deregister_device;
 	}
 
+	ret = mana_ib_create_adapter(dev);
 	if (ret) {
-		ib_dealloc_device(&dev->ib_dev);
-		return ret;
+		ibdev_err(&dev->ib_dev, "Failed to create adapter");
+		goto free_error_eq;
 	}
 
 	ret = ib_register_device(&dev->ib_dev, "mana_%d",
@@ -108,8 +109,10 @@ static int mana_ib_probe(struct auxiliary_device *adev,
 	return 0;
 
 destroy_adapter:
-	mana_gd_destroy_queue(dev->gdma_dev->gdma_context, dev->fatal_err_eq);
+	mana_ib_destroy_adapter(dev);
+free_error_eq:
 	xa_destroy(&dev->rq_to_qp_lookup_table);
+	mana_gd_destroy_queue(dev->gdma_dev->gdma_context, dev->fatal_err_eq);
 deregister_device:
 	mana_gd_deregister_device(dev->gdma_dev);
 free_ib_device:
@@ -123,6 +126,7 @@ static void mana_ib_remove(struct auxiliary_device *adev)
 
 	ib_unregister_device(&dev->ib_dev);
 
+	mana_ib_destroy_adapter(dev);
 	mana_gd_destroy_queue(dev->gdma_dev->gdma_context, dev->fatal_err_eq);
 	xa_destroy(&dev->rq_to_qp_lookup_table);
 	mana_gd_deregister_device(dev->gdma_dev);
diff --git a/drivers/infiniband/hw/mana/main.c b/drivers/infiniband/hw/mana/main.c
index 032f926bf1ab..4f4343d14041 100644
--- a/drivers/infiniband/hw/mana/main.c
+++ b/drivers/infiniband/hw/mana/main.c
@@ -522,6 +522,57 @@ void mana_ib_disassociate_ucontext(struct ib_ucontext *ibcontext)
 {
 }
 
+int mana_ib_destroy_adapter(struct mana_ib_dev *dev)
+{
+	struct mana_ib_destroy_adapter_resp resp = {};
+	struct mana_ib_destroy_adapter_req req = {};
+	struct gdma_context *gc;
+	int err;
+
+	gc = dev->gdma_dev->gdma_context;
+
+	mana_gd_init_req_hdr(&req.hdr, MANA_IB_DESTROY_ADAPTER, sizeof(req),
+			     sizeof(resp));
+	req.adapter = dev->adapter_handle;
+	req.hdr.dev_id = gc->mana_ib.dev_id;
+
+	err = mana_gd_send_request(gc, sizeof(req), &req, sizeof(resp), &resp);
+
+	if (err) {
+		ibdev_err(&dev->ib_dev, "Failed to destroy adapter err %d", err);
+		return err;
+	}
+
+	return 0;
+}
+
+int mana_ib_create_adapter(struct mana_ib_dev *dev)
+{
+	struct mana_ib_create_adapter_resp resp = {};
+	struct mana_ib_create_adapter_req req = {};
+	struct gdma_context *gc;
+	int err;
+
+	gc = dev->gdma_dev->gdma_context;
+
+	mana_gd_init_req_hdr(&req.hdr, MANA_IB_CREATE_ADAPTER, sizeof(req),
+			     sizeof(resp));
+	req.notify_eq_id = dev->fatal_err_eq->id;
+	req.hdr.dev_id = gc->mana_ib.dev_id;
+
+	err = mana_gd_send_request(gc, sizeof(req), &req, sizeof(resp), &resp);
+
+	if (err) {
+		ibdev_err(&dev->ib_dev, "Failed to create adapter err %d",
+			  err);
+		return err;
+	}
+
+	dev->adapter_handle = resp.adapter;
+
+	return 0;
+}
+
 static void mana_ib_critical_event_handler(void *ctx, struct gdma_queue *queue,
 				      struct gdma_event *event)
 {
diff --git a/drivers/infiniband/hw/mana/mana_ib.h b/drivers/infiniband/hw/mana/mana_ib.h
index a5577c119def..4286caf0d67c 100644
--- a/drivers/infiniband/hw/mana/mana_ib.h
+++ b/drivers/infiniband/hw/mana/mana_ib.h
@@ -31,6 +31,7 @@ struct mana_ib_dev {
 	struct ib_device ib_dev;
 	struct gdma_dev *gdma_dev;
 	struct gdma_queue *fatal_err_eq;
+	mana_handle_t adapter_handle;
 	struct xarray rq_to_qp_lookup_table;
 };
 
@@ -94,6 +95,31 @@ struct mana_ib_rwq_ind_table {
 	struct ib_rwq_ind_table ib_ind_table;
 };
 
+enum mana_ib_command_code {
+	MANA_IB_CREATE_ADAPTER  = 0x30002,
+	MANA_IB_DESTROY_ADAPTER = 0x30003,
+};
+
+struct mana_ib_create_adapter_req {
+	struct gdma_req_hdr hdr;
+	u32 notify_eq_id;
+	u32 reserved;
+}; /*HW Data */
+
+struct mana_ib_create_adapter_resp {
+	struct gdma_resp_hdr hdr;
+	mana_handle_t adapter;
+}; /* HW Data */
+
+struct mana_ib_destroy_adapter_req {
+	struct gdma_req_hdr hdr;
+	mana_handle_t adapter;
+}; /*HW Data */
+
+struct mana_ib_destroy_adapter_resp {
+	struct gdma_resp_hdr hdr;
+}; /* HW Data */
+
 int mana_ib_gd_create_dma_region(struct mana_ib_dev *dev, struct ib_umem *umem,
 				 mana_handle_t *gdma_region);
 
@@ -163,4 +189,8 @@ void mana_ib_disassociate_ucontext(struct ib_ucontext *ibcontext);
 
 int mana_ib_create_error_eq(struct mana_ib_dev *mdev);
 
+int mana_ib_create_adapter(struct mana_ib_dev *mdev);
+
+int mana_ib_destroy_adapter(struct mana_ib_dev *mdev);
+
 #endif
-- 
2.34.1


