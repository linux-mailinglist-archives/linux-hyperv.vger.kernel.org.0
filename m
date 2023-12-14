Return-Path: <linux-hyperv+bounces-1329-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD7C18124C1
	for <lists+linux-hyperv@lfdr.de>; Thu, 14 Dec 2023 02:52:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D2561F2186D
	for <lists+linux-hyperv@lfdr.de>; Thu, 14 Dec 2023 01:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24FE7A52;
	Thu, 14 Dec 2023 01:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxonhyperv.com header.i=@linuxonhyperv.com header.b="SEIyFnli"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id DF8B1D5;
	Wed, 13 Dec 2023 17:51:54 -0800 (PST)
Received: by linux.microsoft.com (Postfix, from userid 1004)
	id 7691420B74C0; Wed, 13 Dec 2023 17:51:54 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7691420B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxonhyperv.com;
	s=default; t=1702518714;
	bh=kFG2UJA7zqgwhnAvb8WqdQxi8BRc3fmUEAvO+u1bgXo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SEIyFnlis48TeVn0WT7B/HPi2fqTnDpe+H9JxDuhfcf1vivnnlvAKNbeXUXHumcf8
	 +KvAeKR7lAMQ/sTzhrF+X6N5aM9G++WCGMd9ROwehjlJpEUqkcqYVF3Js8ceroKq07
	 oB9173ia/Ya+Qwflo/9mGt4kEt9iQ7Zrn6aTjzJc=
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
Subject: [Patch v3 1/3] RDMA/mana_ib: register RDMA device with GDMA
Date: Wed, 13 Dec 2023 17:51:42 -0800
Message-Id: <1702518704-15886-2-git-send-email-longli@linuxonhyperv.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1702518704-15886-1-git-send-email-longli@linuxonhyperv.com>
References: <1702518704-15886-1-git-send-email-longli@linuxonhyperv.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

From: Long Li <longli@microsoft.com>

Software client needs to register with the RDMA management interface on
the SoC to access more features, including querying device capabilities
and RC queue pair.

Signed-off-by: Long Li <longli@microsoft.com>
---
 drivers/infiniband/hw/mana/device.c           | 24 +++++++++++++++----
 drivers/infiniband/hw/mana/main.c             |  4 ++--
 drivers/infiniband/hw/mana/qp.c               | 15 ++++++------
 .../net/ethernet/microsoft/mana/gdma_main.c   |  5 ++++
 include/net/mana/gdma.h                       |  4 ++++
 5 files changed, 38 insertions(+), 14 deletions(-)

diff --git a/drivers/infiniband/hw/mana/device.c b/drivers/infiniband/hw/mana/device.c
index d4541b8707e4..fe025e13a45c 100644
--- a/drivers/infiniband/hw/mana/device.c
+++ b/drivers/infiniband/hw/mana/device.c
@@ -68,7 +68,6 @@ static int mana_ib_probe(struct auxiliary_device *adev,
 	ibdev_dbg(&dev->ib_dev, "mdev=%p id=%d num_ports=%d\n", mdev,
 		  mdev->dev_id.as_uint32, dev->ib_dev.phys_port_cnt);
 
-	dev->gdma_dev = mdev;
 	dev->ib_dev.node_type = RDMA_NODE_IB_CA;
 
 	/*
@@ -78,16 +77,28 @@ static int mana_ib_probe(struct auxiliary_device *adev,
 	dev->ib_dev.num_comp_vectors = 1;
 	dev->ib_dev.dev.parent = mdev->gdma_context->dev;
 
-	ret = ib_register_device(&dev->ib_dev, "mana_%d",
-				 mdev->gdma_context->dev);
+	ret = mana_gd_register_device(&mdev->gdma_context->mana_ib);
 	if (ret) {
-		ib_dealloc_device(&dev->ib_dev);
-		return ret;
+		ibdev_err(&dev->ib_dev, "Failed to register device, ret %d",
+			  ret);
+		goto free_ib_device;
 	}
+	dev->gdma_dev = &mdev->gdma_context->mana_ib;
+
+	ret = ib_register_device(&dev->ib_dev, "mana_%d",
+				 mdev->gdma_context->dev);
+	if (ret)
+		goto deregister_device;
 
 	dev_set_drvdata(&adev->dev, dev);
 
 	return 0;
+
+deregister_device:
+	mana_gd_deregister_device(dev->gdma_dev);
+free_ib_device:
+	ib_dealloc_device(&dev->ib_dev);
+	return ret;
 }
 
 static void mana_ib_remove(struct auxiliary_device *adev)
@@ -95,6 +106,9 @@ static void mana_ib_remove(struct auxiliary_device *adev)
 	struct mana_ib_dev *dev = dev_get_drvdata(&adev->dev);
 
 	ib_unregister_device(&dev->ib_dev);
+
+	mana_gd_deregister_device(dev->gdma_dev);
+
 	ib_dealloc_device(&dev->ib_dev);
 }
 
diff --git a/drivers/infiniband/hw/mana/main.c b/drivers/infiniband/hw/mana/main.c
index 7be4c3adb4e2..53730306ed9b 100644
--- a/drivers/infiniband/hw/mana/main.c
+++ b/drivers/infiniband/hw/mana/main.c
@@ -8,7 +8,7 @@
 void mana_ib_uncfg_vport(struct mana_ib_dev *dev, struct mana_ib_pd *pd,
 			 u32 port)
 {
-	struct gdma_dev *gd = dev->gdma_dev;
+	struct gdma_dev *gd = &dev->gdma_dev->gdma_context->mana;
 	struct mana_port_context *mpc;
 	struct net_device *ndev;
 	struct mana_context *mc;
@@ -31,7 +31,7 @@ void mana_ib_uncfg_vport(struct mana_ib_dev *dev, struct mana_ib_pd *pd,
 int mana_ib_cfg_vport(struct mana_ib_dev *dev, u32 port, struct mana_ib_pd *pd,
 		      u32 doorbell_id)
 {
-	struct gdma_dev *mdev = dev->gdma_dev;
+	struct gdma_dev *mdev = &dev->gdma_dev->gdma_context->mana;
 	struct mana_port_context *mpc;
 	struct mana_context *mc;
 	struct net_device *ndev;
diff --git a/drivers/infiniband/hw/mana/qp.c b/drivers/infiniband/hw/mana/qp.c
index 4b3b5b274e84..ae45d28eef5e 100644
--- a/drivers/infiniband/hw/mana/qp.c
+++ b/drivers/infiniband/hw/mana/qp.c
@@ -21,8 +21,8 @@ static int mana_ib_cfg_vport_steering(struct mana_ib_dev *dev,
 	u32 req_buf_size;
 	int i, err;
 
-	mdev = dev->gdma_dev;
-	gc = mdev->gdma_context;
+	gc = dev->gdma_dev->gdma_context;
+	mdev = &gc->mana;
 
 	req_buf_size =
 		sizeof(*req) + sizeof(mana_handle_t) * MANA_INDIRECT_TABLE_SIZE;
@@ -102,20 +102,21 @@ static int mana_ib_create_qp_rss(struct ib_qp *ibqp, struct ib_pd *pd,
 	struct ib_rwq_ind_table *ind_tbl = attr->rwq_ind_tbl;
 	struct mana_ib_create_qp_rss_resp resp = {};
 	struct mana_ib_create_qp_rss ucmd = {};
-	struct gdma_dev *gd = mdev->gdma_dev;
 	mana_handle_t *mana_ind_table;
 	struct mana_port_context *mpc;
+	unsigned int ind_tbl_size;
 	struct mana_context *mc;
 	struct net_device *ndev;
 	struct mana_ib_cq *cq;
 	struct mana_ib_wq *wq;
-	unsigned int ind_tbl_size;
+	struct gdma_dev *gd;
 	struct ib_cq *ibcq;
 	struct ib_wq *ibwq;
 	int i = 0;
 	u32 port;
 	int ret;
 
+	gd = &mdev->gdma_dev->gdma_context->mana;
 	mc = gd->driver_data;
 
 	if (!udata || udata->inlen < sizeof(ucmd))
@@ -266,8 +267,8 @@ static int mana_ib_create_qp_raw(struct ib_qp *ibqp, struct ib_pd *ibpd,
 	struct mana_ib_ucontext *mana_ucontext =
 		rdma_udata_to_drv_context(udata, struct mana_ib_ucontext,
 					  ibucontext);
+	struct gdma_dev *gd = &mdev->gdma_dev->gdma_context->mana;
 	struct mana_ib_create_qp_resp resp = {};
-	struct gdma_dev *gd = mdev->gdma_dev;
 	struct mana_ib_create_qp ucmd = {};
 	struct mana_obj_spec wq_spec = {};
 	struct mana_obj_spec cq_spec = {};
@@ -437,7 +438,7 @@ static int mana_ib_destroy_qp_rss(struct mana_ib_qp *qp,
 {
 	struct mana_ib_dev *mdev =
 		container_of(qp->ibqp.device, struct mana_ib_dev, ib_dev);
-	struct gdma_dev *gd = mdev->gdma_dev;
+	struct gdma_dev *gd = &mdev->gdma_dev->gdma_context->mana;
 	struct mana_port_context *mpc;
 	struct mana_context *mc;
 	struct net_device *ndev;
@@ -464,7 +465,7 @@ static int mana_ib_destroy_qp_raw(struct mana_ib_qp *qp, struct ib_udata *udata)
 {
 	struct mana_ib_dev *mdev =
 		container_of(qp->ibqp.device, struct mana_ib_dev, ib_dev);
-	struct gdma_dev *gd = mdev->gdma_dev;
+	struct gdma_dev *gd = &mdev->gdma_dev->gdma_context->mana;
 	struct ib_pd *ibpd = qp->ibqp.pd;
 	struct mana_port_context *mpc;
 	struct mana_context *mc;
diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/net/ethernet/microsoft/mana/gdma_main.c
index 6367de0c2c2e..e6e71e3c357c 100644
--- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
+++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
@@ -158,6 +158,9 @@ static int mana_gd_detect_devices(struct pci_dev *pdev)
 		if (dev_type == GDMA_DEVICE_MANA) {
 			gc->mana.gdma_context = gc;
 			gc->mana.dev_id = dev;
+		} else if (dev_type == GDMA_DEVICE_MANA_IB) {
+			gc->mana_ib.dev_id = dev;
+			gc->mana_ib.gdma_context = gc;
 		}
 	}
 
@@ -971,6 +974,7 @@ int mana_gd_register_device(struct gdma_dev *gd)
 
 	return 0;
 }
+EXPORT_SYMBOL_NS(mana_gd_register_device, NET_MANA);
 
 int mana_gd_deregister_device(struct gdma_dev *gd)
 {
@@ -1001,6 +1005,7 @@ int mana_gd_deregister_device(struct gdma_dev *gd)
 
 	return err;
 }
+EXPORT_SYMBOL_NS(mana_gd_deregister_device, NET_MANA);
 
 u32 mana_gd_wq_avail_space(struct gdma_queue *wq)
 {
diff --git a/include/net/mana/gdma.h b/include/net/mana/gdma.h
index 88b6ef7ce1a6..000f0d7670f7 100644
--- a/include/net/mana/gdma.h
+++ b/include/net/mana/gdma.h
@@ -66,6 +66,7 @@ enum {
 	GDMA_DEVICE_NONE	= 0,
 	GDMA_DEVICE_HWC		= 1,
 	GDMA_DEVICE_MANA	= 2,
+	GDMA_DEVICE_MANA_IB	= 3,
 };
 
 struct gdma_resource {
@@ -387,6 +388,9 @@ struct gdma_context {
 
 	/* Azure network adapter */
 	struct gdma_dev		mana;
+
+	/* Azure RDMA adapter */
+	struct gdma_dev		mana_ib;
 };
 
 #define MAX_NUM_GDMA_DEVICES	4
-- 
2.25.1


