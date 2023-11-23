Return-Path: <linux-hyperv+bounces-1034-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAE247F56CA
	for <lists+linux-hyperv@lfdr.de>; Thu, 23 Nov 2023 04:10:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6105C2814B3
	for <lists+linux-hyperv@lfdr.de>; Thu, 23 Nov 2023 03:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10BF979DF;
	Thu, 23 Nov 2023 03:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxonhyperv.com header.i=@linuxonhyperv.com header.b="mQtLgvoy"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id C13EB1B6;
	Wed, 22 Nov 2023 19:10:21 -0800 (PST)
Received: by linux.microsoft.com (Postfix, from userid 1004)
	id 5FF6020B74C1; Wed, 22 Nov 2023 19:10:21 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5FF6020B74C1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxonhyperv.com;
	s=default; t=1700709021;
	bh=fCIFn3GJFLoQMuBZv93aVsFVYpHzIMQe/aK7neaJcik=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mQtLgvoy45/c7jBbvKhY7meyZuxzwh7z+W6JYXNROSgyw5lfc9fVzbhOgdl5QKcpJ
	 rUKVtz732kYqT9BvFWT06x5roQ6MSPNc1OOaSuBJd7XSAx9xQkRsjG3bIcCckwFgc/
	 OIld9g3MZDPZSl6OC2a2Oc+/1PIrGuS+qNQ7Q2sc=
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
Subject: [Patch v1 1/4] RDMA/mana_ib: register RDMA device with GDMA
Date: Wed, 22 Nov 2023 19:10:07 -0800
Message-Id: <1700709010-22042-2-git-send-email-longli@linuxonhyperv.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1700709010-22042-1-git-send-email-longli@linuxonhyperv.com>
References: <1700709010-22042-1-git-send-email-longli@linuxonhyperv.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

From: Long Li <longli@microsoft.com>

MANA hardware supports RC queue pairs over RoCE. Software needs to register
with the RDMA management interface on the SoC to access this feature.

Signed-off-by: Long Li <longli@microsoft.com>
---
 drivers/infiniband/hw/mana/device.c           | 25 ++++++++++++++++---
 drivers/infiniband/hw/mana/main.c             |  4 +--
 drivers/infiniband/hw/mana/qp.c               | 15 +++++------
 .../net/ethernet/microsoft/mana/gdma_main.c   |  5 ++++
 include/net/mana/gdma.h                       |  4 +++
 5 files changed, 41 insertions(+), 12 deletions(-)

diff --git a/drivers/infiniband/hw/mana/device.c b/drivers/infiniband/hw/mana/device.c
index d4541b8707e4..ee29ddf36cf3 100644
--- a/drivers/infiniband/hw/mana/device.c
+++ b/drivers/infiniband/hw/mana/device.c
@@ -68,7 +68,6 @@ static int mana_ib_probe(struct auxiliary_device *adev,
 	ibdev_dbg(&dev->ib_dev, "mdev=%p id=%d num_ports=%d\n", mdev,
 		  mdev->dev_id.as_uint32, dev->ib_dev.phys_port_cnt);
 
-	dev->gdma_dev = mdev;
 	dev->ib_dev.node_type = RDMA_NODE_IB_CA;
 
 	/*
@@ -78,16 +77,33 @@ static int mana_ib_probe(struct auxiliary_device *adev,
 	dev->ib_dev.num_comp_vectors = 1;
 	dev->ib_dev.dev.parent = mdev->gdma_context->dev;
 
-	ret = ib_register_device(&dev->ib_dev, "mana_%d",
-				 mdev->gdma_context->dev);
+	ret = mana_gd_register_device(&mdev->gdma_context->mana_ib);
+	if (ret) {
+		ibdev_err(&dev->ib_dev, "Failed to register device, ret %d",
+			  ret);
+		goto free_ib_device;
+	}
+	dev->gdma_dev = &mdev->gdma_context->mana_ib;
+
 	if (ret) {
 		ib_dealloc_device(&dev->ib_dev);
 		return ret;
 	}
 
+	ret = ib_register_device(&dev->ib_dev, "mana_%d",
+				 mdev->gdma_context->dev);
+	if (ret)
+		goto destroy_adapter;
+
 	dev_set_drvdata(&adev->dev, dev);
 
 	return 0;
+
+destroy_adapter:
+	mana_gd_deregister_device(dev->gdma_dev);
+free_ib_device:
+	ib_dealloc_device(&dev->ib_dev);
+	return ret;
 }
 
 static void mana_ib_remove(struct auxiliary_device *adev)
@@ -95,6 +111,9 @@ static void mana_ib_remove(struct auxiliary_device *adev)
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
index 6367de0c2c2e..02e50ed632ee 100644
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
+EXPORT_SYMBOL(mana_gd_register_device);
 
 int mana_gd_deregister_device(struct gdma_dev *gd)
 {
@@ -1001,6 +1005,7 @@ int mana_gd_deregister_device(struct gdma_dev *gd)
 
 	return err;
 }
+EXPORT_SYMBOL(mana_gd_deregister_device);
 
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
2.34.1


