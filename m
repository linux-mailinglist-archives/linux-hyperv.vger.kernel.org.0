Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0784A76298E
	for <lists+linux-hyperv@lfdr.de>; Wed, 26 Jul 2023 05:57:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231293AbjGZD5K (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 25 Jul 2023 23:57:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjGZD5I (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 25 Jul 2023 23:57:08 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5E4B11BF2;
        Tue, 25 Jul 2023 20:57:05 -0700 (PDT)
Received: by linux.microsoft.com (Postfix, from userid 1174)
        id EB9242380B1B; Tue, 25 Jul 2023 20:57:04 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com EB9242380B1B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxonhyperv.com;
        s=default; t=1690343824;
        bh=HoeYoKwXvM6Uf3Xlbr6F6t3JYSXOl1BNGBJKm5DH+ds=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ko9uQFFL7x8THtzYiTadi1e/cx0TIt1QxhEFtFtluK0G/aP4gAdnz1fRhu23VtBJw
         cqHuxv/inWG2KmXBxvf26AMIjWgJHCNFMDSvfDn80zqf39Mv9pMz7+ysd5xSe6rs5A
         cqM1Z/6NSPrNUTKQh6y14Cfa8rfmb8+8Ho/Litt8=
From:   sharmaajay@linuxonhyperv.com
To:     Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        Dexuan Cui <decui@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     linux-rdma@vger.kernel.org, linux-hyperv@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ajay Sharma <sharmaajay@microsoft.com>
Subject: [Patch v2 1/5] RDMA/mana-ib : Rename all mana_ib_dev type variables to mib_dev
Date:   Tue, 25 Jul 2023 20:56:56 -0700
Message-Id: <1690343820-20188-2-git-send-email-sharmaajay@linuxonhyperv.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1690343820-20188-1-git-send-email-sharmaajay@linuxonhyperv.com>
References: <1690343820-20188-1-git-send-email-sharmaajay@linuxonhyperv.com>
X-Spam-Status: No, score=-9.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED,USER_IN_DEF_SPF_WL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Ajay Sharma <sharmaajay@microsoft.com>

Renaming all mana_ib_dev type variables to mib_dev to have
clean separation between eth dev and ibdev variables.

Signed-off-by: Ajay Sharma <sharmaajay@microsoft.com>
---
 drivers/infiniband/hw/mana/cq.c      | 12 ++--
 drivers/infiniband/hw/mana/device.c  | 34 +++++------
 drivers/infiniband/hw/mana/main.c    | 87 ++++++++++++++--------------
 drivers/infiniband/hw/mana/mana_ib.h |  9 +--
 drivers/infiniband/hw/mana/mr.c      | 29 +++++-----
 drivers/infiniband/hw/mana/qp.c      | 82 +++++++++++++-------------
 drivers/infiniband/hw/mana/wq.c      | 21 +++----
 7 files changed, 140 insertions(+), 134 deletions(-)

diff --git a/drivers/infiniband/hw/mana/cq.c b/drivers/infiniband/hw/mana/cq.c
index d141cab8a1e6..1aed4e6360ba 100644
--- a/drivers/infiniband/hw/mana/cq.c
+++ b/drivers/infiniband/hw/mana/cq.c
@@ -11,10 +11,10 @@ int mana_ib_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 	struct mana_ib_cq *cq = container_of(ibcq, struct mana_ib_cq, ibcq);
 	struct ib_device *ibdev = ibcq->device;
 	struct mana_ib_create_cq ucmd = {};
-	struct mana_ib_dev *mdev;
+	struct mana_ib_dev *mib_dev;
 	int err;
 
-	mdev = container_of(ibdev, struct mana_ib_dev, ib_dev);
+	mib_dev = container_of(ibdev, struct mana_ib_dev, ib_dev);
 
 	if (udata->inlen < sizeof(ucmd))
 		return -EINVAL;
@@ -41,7 +41,7 @@ int mana_ib_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 		return err;
 	}
 
-	err = mana_ib_gd_create_dma_region(mdev, cq->umem, &cq->gdma_region);
+	err = mana_ib_gd_create_dma_region(mib_dev, cq->umem, &cq->gdma_region);
 	if (err) {
 		ibdev_dbg(ibdev,
 			  "Failed to create dma region for create cq, %d\n",
@@ -68,11 +68,11 @@ int mana_ib_destroy_cq(struct ib_cq *ibcq, struct ib_udata *udata)
 {
 	struct mana_ib_cq *cq = container_of(ibcq, struct mana_ib_cq, ibcq);
 	struct ib_device *ibdev = ibcq->device;
-	struct mana_ib_dev *mdev;
+	struct mana_ib_dev *mib_dev;
 
-	mdev = container_of(ibdev, struct mana_ib_dev, ib_dev);
+	mib_dev = container_of(ibdev, struct mana_ib_dev, ib_dev);
 
-	mana_ib_gd_destroy_dma_region(mdev, cq->gdma_region);
+	mana_ib_gd_destroy_dma_region(mib_dev, cq->gdma_region);
 	ib_umem_release(cq->umem);
 
 	return 0;
diff --git a/drivers/infiniband/hw/mana/device.c b/drivers/infiniband/hw/mana/device.c
index d4541b8707e4..083f27246ba8 100644
--- a/drivers/infiniband/hw/mana/device.c
+++ b/drivers/infiniband/hw/mana/device.c
@@ -51,51 +51,51 @@ static int mana_ib_probe(struct auxiliary_device *adev,
 {
 	struct mana_adev *madev = container_of(adev, struct mana_adev, adev);
 	struct gdma_dev *mdev = madev->mdev;
+	struct mana_ib_dev *mib_dev;
 	struct mana_context *mc;
-	struct mana_ib_dev *dev;
 	int ret;
 
 	mc = mdev->driver_data;
 
-	dev = ib_alloc_device(mana_ib_dev, ib_dev);
-	if (!dev)
+	mib_dev = ib_alloc_device(mana_ib_dev, ib_dev);
+	if (!mib_dev)
 		return -ENOMEM;
 
-	ib_set_device_ops(&dev->ib_dev, &mana_ib_dev_ops);
+	ib_set_device_ops(&mib_dev->ib_dev, &mana_ib_dev_ops);
 
-	dev->ib_dev.phys_port_cnt = mc->num_ports;
+	mib_dev->ib_dev.phys_port_cnt = mc->num_ports;
 
-	ibdev_dbg(&dev->ib_dev, "mdev=%p id=%d num_ports=%d\n", mdev,
-		  mdev->dev_id.as_uint32, dev->ib_dev.phys_port_cnt);
+	ibdev_dbg(&mib_dev->ib_dev, "mdev=%p id=%d num_ports=%d\n", mdev,
+		  mdev->dev_id.as_uint32, mib_dev->ib_dev.phys_port_cnt);
 
-	dev->gdma_dev = mdev;
-	dev->ib_dev.node_type = RDMA_NODE_IB_CA;
+	mib_dev->gdma_dev = mdev;
+	mib_dev->ib_dev.node_type = RDMA_NODE_IB_CA;
 
 	/*
 	 * num_comp_vectors needs to set to the max MSIX index
 	 * when interrupts and event queues are implemented
 	 */
-	dev->ib_dev.num_comp_vectors = 1;
-	dev->ib_dev.dev.parent = mdev->gdma_context->dev;
+	mib_dev->ib_dev.num_comp_vectors = 1;
+	mib_dev->ib_dev.dev.parent = mdev->gdma_context->dev;
 
-	ret = ib_register_device(&dev->ib_dev, "mana_%d",
+	ret = ib_register_device(&mib_dev->ib_dev, "mana_%d",
 				 mdev->gdma_context->dev);
 	if (ret) {
-		ib_dealloc_device(&dev->ib_dev);
+		ib_dealloc_device(&mib_dev->ib_dev);
 		return ret;
 	}
 
-	dev_set_drvdata(&adev->dev, dev);
+	dev_set_drvdata(&adev->dev, mib_dev);
 
 	return 0;
 }
 
 static void mana_ib_remove(struct auxiliary_device *adev)
 {
-	struct mana_ib_dev *dev = dev_get_drvdata(&adev->dev);
+	struct mana_ib_dev *mib_dev = dev_get_drvdata(&adev->dev);
 
-	ib_unregister_device(&dev->ib_dev);
-	ib_dealloc_device(&dev->ib_dev);
+	ib_unregister_device(&mib_dev->ib_dev);
+	ib_dealloc_device(&mib_dev->ib_dev);
 }
 
 static const struct auxiliary_device_id mana_id_table[] = {
diff --git a/drivers/infiniband/hw/mana/main.c b/drivers/infiniband/hw/mana/main.c
index 7be4c3adb4e2..189e774cdab6 100644
--- a/drivers/infiniband/hw/mana/main.c
+++ b/drivers/infiniband/hw/mana/main.c
@@ -5,10 +5,10 @@
 
 #include "mana_ib.h"
 
-void mana_ib_uncfg_vport(struct mana_ib_dev *dev, struct mana_ib_pd *pd,
+void mana_ib_uncfg_vport(struct mana_ib_dev *mib_dev, struct mana_ib_pd *pd,
 			 u32 port)
 {
-	struct gdma_dev *gd = dev->gdma_dev;
+	struct gdma_dev *gd = mib_dev->gdma_dev;
 	struct mana_port_context *mpc;
 	struct net_device *ndev;
 	struct mana_context *mc;
@@ -28,10 +28,11 @@ void mana_ib_uncfg_vport(struct mana_ib_dev *dev, struct mana_ib_pd *pd,
 	mutex_unlock(&pd->vport_mutex);
 }
 
-int mana_ib_cfg_vport(struct mana_ib_dev *dev, u32 port, struct mana_ib_pd *pd,
+int mana_ib_cfg_vport(struct mana_ib_dev *mib_dev, u32 port,
+		      struct mana_ib_pd *pd,
 		      u32 doorbell_id)
 {
-	struct gdma_dev *mdev = dev->gdma_dev;
+	struct gdma_dev *mdev = mib_dev->gdma_dev;
 	struct mana_port_context *mpc;
 	struct mana_context *mc;
 	struct net_device *ndev;
@@ -45,7 +46,7 @@ int mana_ib_cfg_vport(struct mana_ib_dev *dev, u32 port, struct mana_ib_pd *pd,
 
 	pd->vport_use_count++;
 	if (pd->vport_use_count > 1) {
-		ibdev_dbg(&dev->ib_dev,
+		ibdev_dbg(&mib_dev->ib_dev,
 			  "Skip as this PD is already configured vport\n");
 		mutex_unlock(&pd->vport_mutex);
 		return 0;
@@ -56,7 +57,8 @@ int mana_ib_cfg_vport(struct mana_ib_dev *dev, u32 port, struct mana_ib_pd *pd,
 		pd->vport_use_count--;
 		mutex_unlock(&pd->vport_mutex);
 
-		ibdev_dbg(&dev->ib_dev, "Failed to configure vPort %d\n", err);
+		ibdev_dbg(&mib_dev->ib_dev, "Failed to configure vPort %d\n",
+			  err);
 		return err;
 	}
 
@@ -65,7 +67,7 @@ int mana_ib_cfg_vport(struct mana_ib_dev *dev, u32 port, struct mana_ib_pd *pd,
 	pd->tx_shortform_allowed = mpc->tx_shortform_allowed;
 	pd->tx_vp_offset = mpc->tx_vp_offset;
 
-	ibdev_dbg(&dev->ib_dev, "vport handle %llx pdid %x doorbell_id %x\n",
+	ibdev_dbg(&mib_dev->ib_dev, "vport handle %llx pdid %x doorbell_id %x\n",
 		  mpc->port_handle, pd->pdn, doorbell_id);
 
 	return 0;
@@ -78,12 +80,12 @@ int mana_ib_alloc_pd(struct ib_pd *ibpd, struct ib_udata *udata)
 	struct gdma_create_pd_resp resp = {};
 	struct gdma_create_pd_req req = {};
 	enum gdma_pd_flags flags = 0;
-	struct mana_ib_dev *dev;
+	struct mana_ib_dev *mib_dev;
 	struct gdma_dev *mdev;
 	int err;
 
-	dev = container_of(ibdev, struct mana_ib_dev, ib_dev);
-	mdev = dev->gdma_dev;
+	mib_dev = container_of(ibdev, struct mana_ib_dev, ib_dev);
+	mdev = mib_dev->gdma_dev;
 
 	mana_gd_init_req_hdr(&req.hdr, GDMA_CREATE_PD, sizeof(req),
 			     sizeof(resp));
@@ -93,7 +95,7 @@ int mana_ib_alloc_pd(struct ib_pd *ibpd, struct ib_udata *udata)
 				   sizeof(resp), &resp);
 
 	if (err || resp.hdr.status) {
-		ibdev_dbg(&dev->ib_dev,
+		ibdev_dbg(&mib_dev->ib_dev,
 			  "Failed to get pd_id err %d status %u\n", err,
 			  resp.hdr.status);
 		if (!err)
@@ -104,7 +106,7 @@ int mana_ib_alloc_pd(struct ib_pd *ibpd, struct ib_udata *udata)
 
 	pd->pd_handle = resp.pd_handle;
 	pd->pdn = resp.pd_id;
-	ibdev_dbg(&dev->ib_dev, "pd_handle 0x%llx pd_id %d\n",
+	ibdev_dbg(&mib_dev->ib_dev, "pd_handle 0x%llx pd_id %d\n",
 		  pd->pd_handle, pd->pdn);
 
 	mutex_init(&pd->vport_mutex);
@@ -118,12 +120,12 @@ int mana_ib_dealloc_pd(struct ib_pd *ibpd, struct ib_udata *udata)
 	struct ib_device *ibdev = ibpd->device;
 	struct gdma_destory_pd_resp resp = {};
 	struct gdma_destroy_pd_req req = {};
-	struct mana_ib_dev *dev;
+	struct mana_ib_dev *mib_dev;
 	struct gdma_dev *mdev;
 	int err;
 
-	dev = container_of(ibdev, struct mana_ib_dev, ib_dev);
-	mdev = dev->gdma_dev;
+	mib_dev = container_of(ibdev, struct mana_ib_dev, ib_dev);
+	mdev = mib_dev->gdma_dev;
 
 	mana_gd_init_req_hdr(&req.hdr, GDMA_DESTROY_PD, sizeof(req),
 			     sizeof(resp));
@@ -133,7 +135,7 @@ int mana_ib_dealloc_pd(struct ib_pd *ibpd, struct ib_udata *udata)
 				   sizeof(resp), &resp);
 
 	if (err || resp.hdr.status) {
-		ibdev_dbg(&dev->ib_dev,
+		ibdev_dbg(&mib_dev->ib_dev,
 			  "Failed to destroy pd_handle 0x%llx err %d status %u",
 			  pd->pd_handle, err, resp.hdr.status);
 		if (!err)
@@ -204,14 +206,14 @@ int mana_ib_alloc_ucontext(struct ib_ucontext *ibcontext,
 	struct mana_ib_ucontext *ucontext =
 		container_of(ibcontext, struct mana_ib_ucontext, ibucontext);
 	struct ib_device *ibdev = ibcontext->device;
-	struct mana_ib_dev *mdev;
+	struct mana_ib_dev *mib_dev;
 	struct gdma_context *gc;
 	struct gdma_dev *dev;
 	int doorbell_page;
 	int ret;
 
-	mdev = container_of(ibdev, struct mana_ib_dev, ib_dev);
-	dev = mdev->gdma_dev;
+	mib_dev = container_of(ibdev, struct mana_ib_dev, ib_dev);
+	dev = mib_dev->gdma_dev;
 	gc = dev->gdma_context;
 
 	/* Allocate a doorbell page index */
@@ -233,12 +235,12 @@ void mana_ib_dealloc_ucontext(struct ib_ucontext *ibcontext)
 	struct mana_ib_ucontext *mana_ucontext =
 		container_of(ibcontext, struct mana_ib_ucontext, ibucontext);
 	struct ib_device *ibdev = ibcontext->device;
-	struct mana_ib_dev *mdev;
+	struct mana_ib_dev *mib_dev;
 	struct gdma_context *gc;
 	int ret;
 
-	mdev = container_of(ibdev, struct mana_ib_dev, ib_dev);
-	gc = mdev->gdma_dev->gdma_context;
+	mib_dev = container_of(ibdev, struct mana_ib_dev, ib_dev);
+	gc = mib_dev->gdma_dev->gdma_context;
 
 	ret = mana_gd_destroy_doorbell_page(gc, mana_ucontext->doorbell);
 	if (ret)
@@ -246,7 +248,7 @@ void mana_ib_dealloc_ucontext(struct ib_ucontext *ibcontext)
 }
 
 static int
-mana_ib_gd_first_dma_region(struct mana_ib_dev *dev,
+mana_ib_gd_first_dma_region(struct mana_ib_dev *mib_dev,
 			    struct gdma_context *gc,
 			    struct gdma_create_dma_region_req *create_req,
 			    size_t num_pages, mana_handle_t *gdma_region,
@@ -263,7 +265,7 @@ mana_ib_gd_first_dma_region(struct mana_ib_dev *dev,
 	err = mana_gd_send_request(gc, create_req_msg_size, create_req,
 				   sizeof(create_resp), &create_resp);
 	if (err || create_resp.hdr.status != expected_status) {
-		ibdev_dbg(&dev->ib_dev,
+		ibdev_dbg(&mib_dev->ib_dev,
 			  "Failed to create DMA region: %d, 0x%x\n",
 			  err, create_resp.hdr.status);
 		if (!err)
@@ -273,14 +275,14 @@ mana_ib_gd_first_dma_region(struct mana_ib_dev *dev,
 	}
 
 	*gdma_region = create_resp.dma_region_handle;
-	ibdev_dbg(&dev->ib_dev, "Created DMA region handle 0x%llx\n",
+	ibdev_dbg(&mib_dev->ib_dev, "Created DMA region handle 0x%llx\n",
 		  *gdma_region);
 
 	return 0;
 }
 
 static int
-mana_ib_gd_add_dma_region(struct mana_ib_dev *dev, struct gdma_context *gc,
+mana_ib_gd_add_dma_region(struct mana_ib_dev *mib_dev, struct gdma_context *gc,
 			  struct gdma_dma_region_add_pages_req *add_req,
 			  unsigned int num_pages, u32 expected_status)
 {
@@ -296,7 +298,7 @@ mana_ib_gd_add_dma_region(struct mana_ib_dev *dev, struct gdma_context *gc,
 	err = mana_gd_send_request(gc, add_req_msg_size, add_req,
 				   sizeof(add_resp), &add_resp);
 	if (err || add_resp.hdr.status != expected_status) {
-		ibdev_dbg(&dev->ib_dev,
+		ibdev_dbg(&mib_dev->ib_dev,
 			  "Failed to create DMA region: %d, 0x%x\n",
 			  err, add_resp.hdr.status);
 
@@ -309,7 +311,8 @@ mana_ib_gd_add_dma_region(struct mana_ib_dev *dev, struct gdma_context *gc,
 	return 0;
 }
 
-int mana_ib_gd_create_dma_region(struct mana_ib_dev *dev, struct ib_umem *umem,
+int mana_ib_gd_create_dma_region(struct mana_ib_dev *mib_dev,
+				 struct ib_umem *umem,
 				 mana_handle_t *gdma_region)
 {
 	struct gdma_dma_region_add_pages_req *add_req = NULL;
@@ -329,14 +332,14 @@ int mana_ib_gd_create_dma_region(struct mana_ib_dev *dev, struct ib_umem *umem,
 	void *request_buf;
 	int err;
 
-	mdev = dev->gdma_dev;
+	mdev = mib_dev->gdma_dev;
 	gc = mdev->gdma_context;
 	hwc = gc->hwc.driver_data;
 
 	/* Hardware requires dma region to align to chosen page size */
 	page_sz = ib_umem_find_best_pgsz(umem, PAGE_SZ_BM, 0);
 	if (!page_sz) {
-		ibdev_dbg(&dev->ib_dev, "failed to find page size.\n");
+		ibdev_dbg(&mib_dev->ib_dev, "failed to find page size.\n");
 		return -ENOMEM;
 	}
 	num_pages_total = ib_umem_num_dma_blocks(umem, page_sz);
@@ -362,13 +365,13 @@ int mana_ib_gd_create_dma_region(struct mana_ib_dev *dev, struct ib_umem *umem,
 	create_req->gdma_page_type = order_base_2(page_sz) - PAGE_SHIFT;
 	create_req->page_count = num_pages_total;
 
-	ibdev_dbg(&dev->ib_dev, "size_dma_region %lu num_pages_total %lu\n",
+	ibdev_dbg(&mib_dev->ib_dev, "size_dma_region %lu num_pages_total %lu\n",
 		  umem->length, num_pages_total);
 
-	ibdev_dbg(&dev->ib_dev, "page_sz %lu offset_in_page %u\n",
+	ibdev_dbg(&mib_dev->ib_dev, "page_sz %lu offset_in_page %u\n",
 		  page_sz, create_req->offset_in_page);
 
-	ibdev_dbg(&dev->ib_dev, "num_pages_to_handle %lu, gdma_page_type %u",
+	ibdev_dbg(&mib_dev->ib_dev, "num_pages_to_handle %lu, gdma_page_type %u",
 		  num_pages_to_handle, create_req->gdma_page_type);
 
 	page_addr_list = create_req->page_addr_list;
@@ -385,7 +388,7 @@ int mana_ib_gd_create_dma_region(struct mana_ib_dev *dev, struct ib_umem *umem,
 
 		if (!num_pages_processed) {
 			/* First create message */
-			err = mana_ib_gd_first_dma_region(dev, gc, create_req,
+			err = mana_ib_gd_first_dma_region(mib_dev, gc, create_req,
 							  tail, gdma_region,
 							  expected_status);
 			if (err)
@@ -400,7 +403,7 @@ int mana_ib_gd_create_dma_region(struct mana_ib_dev *dev, struct ib_umem *umem,
 			page_addr_list = add_req->page_addr_list;
 		} else {
 			/* Subsequent create messages */
-			err = mana_ib_gd_add_dma_region(dev, gc, add_req, tail,
+			err = mana_ib_gd_add_dma_region(mib_dev, gc, add_req, tail,
 							expected_status);
 			if (err)
 				break;
@@ -417,20 +420,20 @@ int mana_ib_gd_create_dma_region(struct mana_ib_dev *dev, struct ib_umem *umem,
 	}
 
 	if (err)
-		mana_ib_gd_destroy_dma_region(dev, *gdma_region);
+		mana_ib_gd_destroy_dma_region(mib_dev, *gdma_region);
 
 out:
 	kfree(request_buf);
 	return err;
 }
 
-int mana_ib_gd_destroy_dma_region(struct mana_ib_dev *dev, u64 gdma_region)
+int mana_ib_gd_destroy_dma_region(struct mana_ib_dev *mib_dev, u64 gdma_region)
 {
-	struct gdma_dev *mdev = dev->gdma_dev;
+	struct gdma_dev *mdev = mib_dev->gdma_dev;
 	struct gdma_context *gc;
 
 	gc = mdev->gdma_context;
-	ibdev_dbg(&dev->ib_dev, "destroy dma region 0x%llx\n", gdma_region);
+	ibdev_dbg(&mib_dev->ib_dev, "destroy dma region 0x%llx\n", gdma_region);
 
 	return mana_gd_destroy_dma_region(gc, gdma_region);
 }
@@ -440,14 +443,14 @@ int mana_ib_mmap(struct ib_ucontext *ibcontext, struct vm_area_struct *vma)
 	struct mana_ib_ucontext *mana_ucontext =
 		container_of(ibcontext, struct mana_ib_ucontext, ibucontext);
 	struct ib_device *ibdev = ibcontext->device;
-	struct mana_ib_dev *mdev;
+	struct mana_ib_dev *mib_dev;
 	struct gdma_context *gc;
 	phys_addr_t pfn;
 	pgprot_t prot;
 	int ret;
 
-	mdev = container_of(ibdev, struct mana_ib_dev, ib_dev);
-	gc = mdev->gdma_dev->gdma_context;
+	mib_dev = container_of(ibdev, struct mana_ib_dev, ib_dev);
+	gc = mib_dev->gdma_dev->gdma_context;
 
 	if (vma->vm_pgoff != 0) {
 		ibdev_dbg(ibdev, "Unexpected vm_pgoff %lu\n", vma->vm_pgoff);
diff --git a/drivers/infiniband/hw/mana/mana_ib.h b/drivers/infiniband/hw/mana/mana_ib.h
index 502cc8672eef..ee4efd0af278 100644
--- a/drivers/infiniband/hw/mana/mana_ib.h
+++ b/drivers/infiniband/hw/mana/mana_ib.h
@@ -92,10 +92,11 @@ struct mana_ib_rwq_ind_table {
 	struct ib_rwq_ind_table ib_ind_table;
 };
 
-int mana_ib_gd_create_dma_region(struct mana_ib_dev *dev, struct ib_umem *umem,
+int mana_ib_gd_create_dma_region(struct mana_ib_dev *mib_dev,
+				 struct ib_umem *umem,
 				 mana_handle_t *gdma_region);
 
-int mana_ib_gd_destroy_dma_region(struct mana_ib_dev *dev,
+int mana_ib_gd_destroy_dma_region(struct mana_ib_dev *mib_dev,
 				  mana_handle_t gdma_region);
 
 struct ib_wq *mana_ib_create_wq(struct ib_pd *pd,
@@ -129,9 +130,9 @@ int mana_ib_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr,
 
 int mana_ib_destroy_qp(struct ib_qp *ibqp, struct ib_udata *udata);
 
-int mana_ib_cfg_vport(struct mana_ib_dev *dev, u32 port_id,
+int mana_ib_cfg_vport(struct mana_ib_dev *mib_dev, u32 port_id,
 		      struct mana_ib_pd *pd, u32 doorbell_id);
-void mana_ib_uncfg_vport(struct mana_ib_dev *dev, struct mana_ib_pd *pd,
+void mana_ib_uncfg_vport(struct mana_ib_dev *mib_dev, struct mana_ib_pd *pd,
 			 u32 port);
 
 int mana_ib_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
diff --git a/drivers/infiniband/hw/mana/mr.c b/drivers/infiniband/hw/mana/mr.c
index 351207c60eb6..f6a53906204d 100644
--- a/drivers/infiniband/hw/mana/mr.c
+++ b/drivers/infiniband/hw/mana/mr.c
@@ -25,12 +25,13 @@ mana_ib_verbs_to_gdma_access_flags(int access_flags)
 	return flags;
 }
 
-static int mana_ib_gd_create_mr(struct mana_ib_dev *dev, struct mana_ib_mr *mr,
+static int mana_ib_gd_create_mr(struct mana_ib_dev *mib_dev,
+				struct mana_ib_mr *mr,
 				struct gdma_create_mr_params *mr_params)
 {
+	struct gdma_dev *mdev = mib_dev->gdma_dev;
 	struct gdma_create_mr_response resp = {};
 	struct gdma_create_mr_request req = {};
-	struct gdma_dev *mdev = dev->gdma_dev;
 	struct gdma_context *gc;
 	int err;
 
@@ -49,7 +50,7 @@ static int mana_ib_gd_create_mr(struct mana_ib_dev *dev, struct mana_ib_mr *mr,
 		break;
 
 	default:
-		ibdev_dbg(&dev->ib_dev,
+		ibdev_dbg(&mib_dev->ib_dev,
 			  "invalid param (GDMA_MR_TYPE) passed, type %d\n",
 			  req.mr_type);
 		return -EINVAL;
@@ -58,7 +59,7 @@ static int mana_ib_gd_create_mr(struct mana_ib_dev *dev, struct mana_ib_mr *mr,
 	err = mana_gd_send_request(gc, sizeof(req), &req, sizeof(resp), &resp);
 
 	if (err || resp.hdr.status) {
-		ibdev_dbg(&dev->ib_dev, "Failed to create mr %d, %u", err,
+		ibdev_dbg(&mib_dev->ib_dev, "Failed to create mr %d, %u", err,
 			  resp.hdr.status);
 		if (!err)
 			err = -EPROTO;
@@ -73,11 +74,11 @@ static int mana_ib_gd_create_mr(struct mana_ib_dev *dev, struct mana_ib_mr *mr,
 	return 0;
 }
 
-static int mana_ib_gd_destroy_mr(struct mana_ib_dev *dev, u64 mr_handle)
+static int mana_ib_gd_destroy_mr(struct mana_ib_dev *mib_dev, u64 mr_handle)
 {
 	struct gdma_destroy_mr_response resp = {};
+	struct gdma_dev *mdev = mib_dev->gdma_dev;
 	struct gdma_destroy_mr_request req = {};
-	struct gdma_dev *mdev = dev->gdma_dev;
 	struct gdma_context *gc;
 	int err;
 
@@ -107,12 +108,12 @@ struct ib_mr *mana_ib_reg_user_mr(struct ib_pd *ibpd, u64 start, u64 length,
 	struct mana_ib_pd *pd = container_of(ibpd, struct mana_ib_pd, ibpd);
 	struct gdma_create_mr_params mr_params = {};
 	struct ib_device *ibdev = ibpd->device;
-	struct mana_ib_dev *dev;
+	struct mana_ib_dev *mib_dev;
 	struct mana_ib_mr *mr;
 	u64 dma_region_handle;
 	int err;
 
-	dev = container_of(ibdev, struct mana_ib_dev, ib_dev);
+	mib_dev = container_of(ibdev, struct mana_ib_dev, ib_dev);
 
 	ibdev_dbg(ibdev,
 		  "start 0x%llx, iova 0x%llx length 0x%llx access_flags 0x%x",
@@ -133,7 +134,7 @@ struct ib_mr *mana_ib_reg_user_mr(struct ib_pd *ibpd, u64 start, u64 length,
 		goto err_free;
 	}
 
-	err = mana_ib_gd_create_dma_region(dev, mr->umem, &dma_region_handle);
+	err = mana_ib_gd_create_dma_region(mib_dev, mr->umem, &dma_region_handle);
 	if (err) {
 		ibdev_dbg(ibdev, "Failed create dma region for user-mr, %d\n",
 			  err);
@@ -151,7 +152,7 @@ struct ib_mr *mana_ib_reg_user_mr(struct ib_pd *ibpd, u64 start, u64 length,
 	mr_params.gva.access_flags =
 		mana_ib_verbs_to_gdma_access_flags(access_flags);
 
-	err = mana_ib_gd_create_mr(dev, mr, &mr_params);
+	err = mana_ib_gd_create_mr(mib_dev, mr, &mr_params);
 	if (err)
 		goto err_dma_region;
 
@@ -164,7 +165,7 @@ struct ib_mr *mana_ib_reg_user_mr(struct ib_pd *ibpd, u64 start, u64 length,
 	return &mr->ibmr;
 
 err_dma_region:
-	mana_gd_destroy_dma_region(dev->gdma_dev->gdma_context,
+	mana_gd_destroy_dma_region(mib_dev->gdma_dev->gdma_context,
 				   dma_region_handle);
 
 err_umem:
@@ -179,12 +180,12 @@ int mana_ib_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata)
 {
 	struct mana_ib_mr *mr = container_of(ibmr, struct mana_ib_mr, ibmr);
 	struct ib_device *ibdev = ibmr->device;
-	struct mana_ib_dev *dev;
+	struct mana_ib_dev *mib_dev;
 	int err;
 
-	dev = container_of(ibdev, struct mana_ib_dev, ib_dev);
+	mib_dev = container_of(ibdev, struct mana_ib_dev, ib_dev);
 
-	err = mana_ib_gd_destroy_mr(dev, mr->mr_handle);
+	err = mana_ib_gd_destroy_mr(mib_dev, mr->mr_handle);
 	if (err)
 		return err;
 
diff --git a/drivers/infiniband/hw/mana/qp.c b/drivers/infiniband/hw/mana/qp.c
index 4b3b5b274e84..2e3a57123ed7 100644
--- a/drivers/infiniband/hw/mana/qp.c
+++ b/drivers/infiniband/hw/mana/qp.c
@@ -5,7 +5,7 @@
 
 #include "mana_ib.h"
 
-static int mana_ib_cfg_vport_steering(struct mana_ib_dev *dev,
+static int mana_ib_cfg_vport_steering(struct mana_ib_dev *mib_dev,
 				      struct net_device *ndev,
 				      mana_handle_t default_rxobj,
 				      mana_handle_t ind_table[],
@@ -21,7 +21,7 @@ static int mana_ib_cfg_vport_steering(struct mana_ib_dev *dev,
 	u32 req_buf_size;
 	int i, err;
 
-	mdev = dev->gdma_dev;
+	mdev = mib_dev->gdma_dev;
 	gc = mdev->gdma_context;
 
 	req_buf_size =
@@ -55,10 +55,10 @@ static int mana_ib_cfg_vport_steering(struct mana_ib_dev *dev,
 	 * MANA_INDIRECT_TABLE_SIZE entries. Adjust the verb
 	 * ind_table to MANA_INDIRECT_TABLE_SIZE if required
 	 */
-	ibdev_dbg(&dev->ib_dev, "ind table size %u\n", 1 << log_ind_tbl_size);
+	ibdev_dbg(&mib_dev->ib_dev, "ind table size %u\n", 1 << log_ind_tbl_size);
 	for (i = 0; i < MANA_INDIRECT_TABLE_SIZE; i++) {
 		req_indir_tab[i] = ind_table[i % (1 << log_ind_tbl_size)];
-		ibdev_dbg(&dev->ib_dev, "index %u handle 0x%llx\n", i,
+		ibdev_dbg(&mib_dev->ib_dev, "index %u handle 0x%llx\n", i,
 			  req_indir_tab[i]);
 	}
 
@@ -68,7 +68,7 @@ static int mana_ib_cfg_vport_steering(struct mana_ib_dev *dev,
 	else
 		netdev_rss_key_fill(req->hashkey, MANA_HASH_KEY_SIZE);
 
-	ibdev_dbg(&dev->ib_dev, "vport handle %llu default_rxobj 0x%llx\n",
+	ibdev_dbg(&mib_dev->ib_dev, "vport handle %llu default_rxobj 0x%llx\n",
 		  req->vport, default_rxobj);
 
 	err = mana_gd_send_request(gc, req_buf_size, req, sizeof(resp), &resp);
@@ -97,12 +97,12 @@ static int mana_ib_create_qp_rss(struct ib_qp *ibqp, struct ib_pd *pd,
 				 struct ib_udata *udata)
 {
 	struct mana_ib_qp *qp = container_of(ibqp, struct mana_ib_qp, ibqp);
-	struct mana_ib_dev *mdev =
+	struct mana_ib_dev *mib_dev =
 		container_of(pd->device, struct mana_ib_dev, ib_dev);
 	struct ib_rwq_ind_table *ind_tbl = attr->rwq_ind_tbl;
 	struct mana_ib_create_qp_rss_resp resp = {};
 	struct mana_ib_create_qp_rss ucmd = {};
-	struct gdma_dev *gd = mdev->gdma_dev;
+	struct gdma_dev *gd = mib_dev->gdma_dev;
 	mana_handle_t *mana_ind_table;
 	struct mana_port_context *mpc;
 	struct mana_context *mc;
@@ -123,21 +123,21 @@ static int mana_ib_create_qp_rss(struct ib_qp *ibqp, struct ib_pd *pd,
 
 	ret = ib_copy_from_udata(&ucmd, udata, min(sizeof(ucmd), udata->inlen));
 	if (ret) {
-		ibdev_dbg(&mdev->ib_dev,
+		ibdev_dbg(&mib_dev->ib_dev,
 			  "Failed copy from udata for create rss-qp, err %d\n",
 			  ret);
 		return ret;
 	}
 
 	if (attr->cap.max_recv_wr > MAX_SEND_BUFFERS_PER_QUEUE) {
-		ibdev_dbg(&mdev->ib_dev,
+		ibdev_dbg(&mib_dev->ib_dev,
 			  "Requested max_recv_wr %d exceeding limit\n",
 			  attr->cap.max_recv_wr);
 		return -EINVAL;
 	}
 
 	if (attr->cap.max_recv_sge > MAX_RX_WQE_SGL_ENTRIES) {
-		ibdev_dbg(&mdev->ib_dev,
+		ibdev_dbg(&mib_dev->ib_dev,
 			  "Requested max_recv_sge %d exceeding limit\n",
 			  attr->cap.max_recv_sge);
 		return -EINVAL;
@@ -145,14 +145,14 @@ static int mana_ib_create_qp_rss(struct ib_qp *ibqp, struct ib_pd *pd,
 
 	ind_tbl_size = 1 << ind_tbl->log_ind_tbl_size;
 	if (ind_tbl_size > MANA_INDIRECT_TABLE_SIZE) {
-		ibdev_dbg(&mdev->ib_dev,
+		ibdev_dbg(&mib_dev->ib_dev,
 			  "Indirect table size %d exceeding limit\n",
 			  ind_tbl_size);
 		return -EINVAL;
 	}
 
 	if (ucmd.rx_hash_function != MANA_IB_RX_HASH_FUNC_TOEPLITZ) {
-		ibdev_dbg(&mdev->ib_dev,
+		ibdev_dbg(&mib_dev->ib_dev,
 			  "RX Hash function is not supported, %d\n",
 			  ucmd.rx_hash_function);
 		return -EINVAL;
@@ -161,14 +161,14 @@ static int mana_ib_create_qp_rss(struct ib_qp *ibqp, struct ib_pd *pd,
 	/* IB ports start with 1, MANA start with 0 */
 	port = ucmd.port;
 	if (port < 1 || port > mc->num_ports) {
-		ibdev_dbg(&mdev->ib_dev, "Invalid port %u in creating qp\n",
+		ibdev_dbg(&mib_dev->ib_dev, "Invalid port %u in creating qp\n",
 			  port);
 		return -EINVAL;
 	}
 	ndev = mc->ports[port - 1];
 	mpc = netdev_priv(ndev);
 
-	ibdev_dbg(&mdev->ib_dev, "rx_hash_function %d port %d\n",
+	ibdev_dbg(&mib_dev->ib_dev, "rx_hash_function %d port %d\n",
 		  ucmd.rx_hash_function, port);
 
 	mana_ind_table = kcalloc(ind_tbl_size, sizeof(mana_handle_t),
@@ -210,7 +210,7 @@ static int mana_ib_create_qp_rss(struct ib_qp *ibqp, struct ib_pd *pd,
 		wq->id = wq_spec.queue_index;
 		cq->id = cq_spec.queue_index;
 
-		ibdev_dbg(&mdev->ib_dev,
+		ibdev_dbg(&mib_dev->ib_dev,
 			  "ret %d rx_object 0x%llx wq id %llu cq id %llu\n",
 			  ret, wq->rx_object, wq->id, cq->id);
 
@@ -221,7 +221,7 @@ static int mana_ib_create_qp_rss(struct ib_qp *ibqp, struct ib_pd *pd,
 	}
 	resp.num_entries = i;
 
-	ret = mana_ib_cfg_vport_steering(mdev, ndev, wq->rx_object,
+	ret = mana_ib_cfg_vport_steering(mib_dev, ndev, wq->rx_object,
 					 mana_ind_table,
 					 ind_tbl->log_ind_tbl_size,
 					 ucmd.rx_hash_key_len,
@@ -231,7 +231,7 @@ static int mana_ib_create_qp_rss(struct ib_qp *ibqp, struct ib_pd *pd,
 
 	ret = ib_copy_to_udata(udata, &resp, sizeof(resp));
 	if (ret) {
-		ibdev_dbg(&mdev->ib_dev,
+		ibdev_dbg(&mib_dev->ib_dev,
 			  "Failed to copy to udata create rss-qp, %d\n",
 			  ret);
 		goto fail;
@@ -259,7 +259,7 @@ static int mana_ib_create_qp_raw(struct ib_qp *ibqp, struct ib_pd *ibpd,
 {
 	struct mana_ib_pd *pd = container_of(ibpd, struct mana_ib_pd, ibpd);
 	struct mana_ib_qp *qp = container_of(ibqp, struct mana_ib_qp, ibqp);
-	struct mana_ib_dev *mdev =
+	struct mana_ib_dev *mib_dev =
 		container_of(ibpd->device, struct mana_ib_dev, ib_dev);
 	struct mana_ib_cq *send_cq =
 		container_of(attr->send_cq, struct mana_ib_cq, ibcq);
@@ -267,7 +267,7 @@ static int mana_ib_create_qp_raw(struct ib_qp *ibqp, struct ib_pd *ibpd,
 		rdma_udata_to_drv_context(udata, struct mana_ib_ucontext,
 					  ibucontext);
 	struct mana_ib_create_qp_resp resp = {};
-	struct gdma_dev *gd = mdev->gdma_dev;
+	struct gdma_dev *gd = mib_dev->gdma_dev;
 	struct mana_ib_create_qp ucmd = {};
 	struct mana_obj_spec wq_spec = {};
 	struct mana_obj_spec cq_spec = {};
@@ -285,7 +285,7 @@ static int mana_ib_create_qp_raw(struct ib_qp *ibqp, struct ib_pd *ibpd,
 
 	err = ib_copy_from_udata(&ucmd, udata, min(sizeof(ucmd), udata->inlen));
 	if (err) {
-		ibdev_dbg(&mdev->ib_dev,
+		ibdev_dbg(&mib_dev->ib_dev,
 			  "Failed to copy from udata create qp-raw, %d\n", err);
 		return err;
 	}
@@ -296,14 +296,14 @@ static int mana_ib_create_qp_raw(struct ib_qp *ibqp, struct ib_pd *ibpd,
 		return -EINVAL;
 
 	if (attr->cap.max_send_wr > MAX_SEND_BUFFERS_PER_QUEUE) {
-		ibdev_dbg(&mdev->ib_dev,
+		ibdev_dbg(&mib_dev->ib_dev,
 			  "Requested max_send_wr %d exceeding limit\n",
 			  attr->cap.max_send_wr);
 		return -EINVAL;
 	}
 
 	if (attr->cap.max_send_sge > MAX_TX_WQE_SGL_ENTRIES) {
-		ibdev_dbg(&mdev->ib_dev,
+		ibdev_dbg(&mib_dev->ib_dev,
 			  "Requested max_send_sge %d exceeding limit\n",
 			  attr->cap.max_send_sge);
 		return -EINVAL;
@@ -311,38 +311,38 @@ static int mana_ib_create_qp_raw(struct ib_qp *ibqp, struct ib_pd *ibpd,
 
 	ndev = mc->ports[port - 1];
 	mpc = netdev_priv(ndev);
-	ibdev_dbg(&mdev->ib_dev, "port %u ndev %p mpc %p\n", port, ndev, mpc);
+	ibdev_dbg(&mib_dev->ib_dev, "port %u ndev %p mpc %p\n", port, ndev, mpc);
 
-	err = mana_ib_cfg_vport(mdev, port - 1, pd, mana_ucontext->doorbell);
+	err = mana_ib_cfg_vport(mib_dev, port - 1, pd, mana_ucontext->doorbell);
 	if (err)
 		return -ENODEV;
 
 	qp->port = port;
 
-	ibdev_dbg(&mdev->ib_dev, "ucmd sq_buf_addr 0x%llx port %u\n",
+	ibdev_dbg(&mib_dev->ib_dev, "ucmd sq_buf_addr 0x%llx port %u\n",
 		  ucmd.sq_buf_addr, ucmd.port);
 
 	umem = ib_umem_get(ibpd->device, ucmd.sq_buf_addr, ucmd.sq_buf_size,
 			   IB_ACCESS_LOCAL_WRITE);
 	if (IS_ERR(umem)) {
 		err = PTR_ERR(umem);
-		ibdev_dbg(&mdev->ib_dev,
+		ibdev_dbg(&mib_dev->ib_dev,
 			  "Failed to get umem for create qp-raw, err %d\n",
 			  err);
 		goto err_free_vport;
 	}
 	qp->sq_umem = umem;
 
-	err = mana_ib_gd_create_dma_region(mdev, qp->sq_umem,
+	err = mana_ib_gd_create_dma_region(mib_dev, qp->sq_umem,
 					   &qp->sq_gdma_region);
 	if (err) {
-		ibdev_dbg(&mdev->ib_dev,
+		ibdev_dbg(&mib_dev->ib_dev,
 			  "Failed to create dma region for create qp-raw, %d\n",
 			  err);
 		goto err_release_umem;
 	}
 
-	ibdev_dbg(&mdev->ib_dev,
+	ibdev_dbg(&mib_dev->ib_dev,
 		  "mana_ib_gd_create_dma_region ret %d gdma_region 0x%llx\n",
 		  err, qp->sq_gdma_region);
 
@@ -358,7 +358,7 @@ static int mana_ib_create_qp_raw(struct ib_qp *ibqp, struct ib_pd *ibpd,
 	err = mana_create_wq_obj(mpc, mpc->port_handle, GDMA_SQ, &wq_spec,
 				 &cq_spec, &qp->tx_object);
 	if (err) {
-		ibdev_dbg(&mdev->ib_dev,
+		ibdev_dbg(&mib_dev->ib_dev,
 			  "Failed to create wq for create raw-qp, err %d\n",
 			  err);
 		goto err_destroy_dma_region;
@@ -371,7 +371,7 @@ static int mana_ib_create_qp_raw(struct ib_qp *ibqp, struct ib_pd *ibpd,
 	qp->sq_id = wq_spec.queue_index;
 	send_cq->id = cq_spec.queue_index;
 
-	ibdev_dbg(&mdev->ib_dev,
+	ibdev_dbg(&mib_dev->ib_dev,
 		  "ret %d qp->tx_object 0x%llx sq id %llu cq id %llu\n", err,
 		  qp->tx_object, qp->sq_id, send_cq->id);
 
@@ -381,7 +381,7 @@ static int mana_ib_create_qp_raw(struct ib_qp *ibqp, struct ib_pd *ibpd,
 
 	err = ib_copy_to_udata(udata, &resp, sizeof(resp));
 	if (err) {
-		ibdev_dbg(&mdev->ib_dev,
+		ibdev_dbg(&mib_dev->ib_dev,
 			  "Failed copy udata for create qp-raw, %d\n",
 			  err);
 		goto err_destroy_wq_obj;
@@ -393,13 +393,13 @@ static int mana_ib_create_qp_raw(struct ib_qp *ibqp, struct ib_pd *ibpd,
 	mana_destroy_wq_obj(mpc, GDMA_SQ, qp->tx_object);
 
 err_destroy_dma_region:
-	mana_ib_gd_destroy_dma_region(mdev, qp->sq_gdma_region);
+	mana_ib_gd_destroy_dma_region(mib_dev, qp->sq_gdma_region);
 
 err_release_umem:
 	ib_umem_release(umem);
 
 err_free_vport:
-	mana_ib_uncfg_vport(mdev, pd, port - 1);
+	mana_ib_uncfg_vport(mib_dev, pd, port - 1);
 
 	return err;
 }
@@ -435,9 +435,9 @@ static int mana_ib_destroy_qp_rss(struct mana_ib_qp *qp,
 				  struct ib_rwq_ind_table *ind_tbl,
 				  struct ib_udata *udata)
 {
-	struct mana_ib_dev *mdev =
+	struct mana_ib_dev *mib_dev =
 		container_of(qp->ibqp.device, struct mana_ib_dev, ib_dev);
-	struct gdma_dev *gd = mdev->gdma_dev;
+	struct gdma_dev *gd = mib_dev->gdma_dev;
 	struct mana_port_context *mpc;
 	struct mana_context *mc;
 	struct net_device *ndev;
@@ -452,7 +452,7 @@ static int mana_ib_destroy_qp_rss(struct mana_ib_qp *qp,
 	for (i = 0; i < (1 << ind_tbl->log_ind_tbl_size); i++) {
 		ibwq = ind_tbl->ind_tbl[i];
 		wq = container_of(ibwq, struct mana_ib_wq, ibwq);
-		ibdev_dbg(&mdev->ib_dev, "destroying wq->rx_object %llu\n",
+		ibdev_dbg(&mib_dev->ib_dev, "destroying wq->rx_object %llu\n",
 			  wq->rx_object);
 		mana_destroy_wq_obj(mpc, GDMA_RQ, wq->rx_object);
 	}
@@ -462,9 +462,9 @@ static int mana_ib_destroy_qp_rss(struct mana_ib_qp *qp,
 
 static int mana_ib_destroy_qp_raw(struct mana_ib_qp *qp, struct ib_udata *udata)
 {
-	struct mana_ib_dev *mdev =
+	struct mana_ib_dev *mib_dev =
 		container_of(qp->ibqp.device, struct mana_ib_dev, ib_dev);
-	struct gdma_dev *gd = mdev->gdma_dev;
+	struct gdma_dev *gd = mib_dev->gdma_dev;
 	struct ib_pd *ibpd = qp->ibqp.pd;
 	struct mana_port_context *mpc;
 	struct mana_context *mc;
@@ -479,11 +479,11 @@ static int mana_ib_destroy_qp_raw(struct mana_ib_qp *qp, struct ib_udata *udata)
 	mana_destroy_wq_obj(mpc, GDMA_SQ, qp->tx_object);
 
 	if (qp->sq_umem) {
-		mana_ib_gd_destroy_dma_region(mdev, qp->sq_gdma_region);
+		mana_ib_gd_destroy_dma_region(mib_dev, qp->sq_gdma_region);
 		ib_umem_release(qp->sq_umem);
 	}
 
-	mana_ib_uncfg_vport(mdev, pd, qp->port - 1);
+	mana_ib_uncfg_vport(mib_dev, pd, qp->port - 1);
 
 	return 0;
 }
diff --git a/drivers/infiniband/hw/mana/wq.c b/drivers/infiniband/hw/mana/wq.c
index 372d361510e0..56bc2b8b6690 100644
--- a/drivers/infiniband/hw/mana/wq.c
+++ b/drivers/infiniband/hw/mana/wq.c
@@ -9,7 +9,7 @@ struct ib_wq *mana_ib_create_wq(struct ib_pd *pd,
 				struct ib_wq_init_attr *init_attr,
 				struct ib_udata *udata)
 {
-	struct mana_ib_dev *mdev =
+	struct mana_ib_dev *mib_dev =
 		container_of(pd->device, struct mana_ib_dev, ib_dev);
 	struct mana_ib_create_wq ucmd = {};
 	struct mana_ib_wq *wq;
@@ -21,7 +21,7 @@ struct ib_wq *mana_ib_create_wq(struct ib_pd *pd,
 
 	err = ib_copy_from_udata(&ucmd, udata, min(sizeof(ucmd), udata->inlen));
 	if (err) {
-		ibdev_dbg(&mdev->ib_dev,
+		ibdev_dbg(&mib_dev->ib_dev,
 			  "Failed to copy from udata for create wq, %d\n", err);
 		return ERR_PTR(err);
 	}
@@ -30,13 +30,14 @@ struct ib_wq *mana_ib_create_wq(struct ib_pd *pd,
 	if (!wq)
 		return ERR_PTR(-ENOMEM);
 
-	ibdev_dbg(&mdev->ib_dev, "ucmd wq_buf_addr 0x%llx\n", ucmd.wq_buf_addr);
+	ibdev_dbg(&mib_dev->ib_dev, "ucmd wq_buf_addr 0x%llx\n",
+		  ucmd.wq_buf_addr);
 
 	umem = ib_umem_get(pd->device, ucmd.wq_buf_addr, ucmd.wq_buf_size,
 			   IB_ACCESS_LOCAL_WRITE);
 	if (IS_ERR(umem)) {
 		err = PTR_ERR(umem);
-		ibdev_dbg(&mdev->ib_dev,
+		ibdev_dbg(&mib_dev->ib_dev,
 			  "Failed to get umem for create wq, err %d\n", err);
 		goto err_free_wq;
 	}
@@ -46,15 +47,15 @@ struct ib_wq *mana_ib_create_wq(struct ib_pd *pd,
 	wq->wq_buf_size = ucmd.wq_buf_size;
 	wq->rx_object = INVALID_MANA_HANDLE;
 
-	err = mana_ib_gd_create_dma_region(mdev, wq->umem, &wq->gdma_region);
+	err = mana_ib_gd_create_dma_region(mib_dev, wq->umem, &wq->gdma_region);
 	if (err) {
-		ibdev_dbg(&mdev->ib_dev,
+		ibdev_dbg(&mib_dev->ib_dev,
 			  "Failed to create dma region for create wq, %d\n",
 			  err);
 		goto err_release_umem;
 	}
 
-	ibdev_dbg(&mdev->ib_dev,
+	ibdev_dbg(&mib_dev->ib_dev,
 		  "mana_ib_gd_create_dma_region ret %d gdma_region 0x%llx\n",
 		  err, wq->gdma_region);
 
@@ -82,11 +83,11 @@ int mana_ib_destroy_wq(struct ib_wq *ibwq, struct ib_udata *udata)
 {
 	struct mana_ib_wq *wq = container_of(ibwq, struct mana_ib_wq, ibwq);
 	struct ib_device *ib_dev = ibwq->device;
-	struct mana_ib_dev *mdev;
+	struct mana_ib_dev *mib_dev;
 
-	mdev = container_of(ib_dev, struct mana_ib_dev, ib_dev);
+	mib_dev = container_of(ib_dev, struct mana_ib_dev, ib_dev);
 
-	mana_ib_gd_destroy_dma_region(mdev, wq->gdma_region);
+	mana_ib_gd_destroy_dma_region(mib_dev, wq->gdma_region);
 	ib_umem_release(wq->umem);
 
 	kfree(wq);
-- 
2.25.1

