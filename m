Return-Path: <linux-hyperv+bounces-14-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64DF5797C5D
	for <lists+linux-hyperv@lfdr.de>; Thu,  7 Sep 2023 20:52:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18BA92815B4
	for <lists+linux-hyperv@lfdr.de>; Thu,  7 Sep 2023 18:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABF8813FF7;
	Thu,  7 Sep 2023 18:51:11 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9343514267;
	Thu,  7 Sep 2023 18:51:11 +0000 (UTC)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 176B32100;
	Thu,  7 Sep 2023 11:50:37 -0700 (PDT)
Received: by linux.microsoft.com (Postfix, from userid 1174)
	id C2F3F212B5B9; Thu,  7 Sep 2023 09:52:47 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C2F3F212B5B9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxonhyperv.com;
	s=default; t=1694105567;
	bh=NkCMp454GTUcOtiLH5kTM0L3OzT2pp424P12IBewYiE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GF9vNqoMNntgFhodCEuhAK+OUOH2Ilc/y1/218kZIsuukJx0yLZzzl/Pflg4cIwFu
	 XgXXxs08qkb4XyS5+125gRpPLDyA203lOhrGK3WDMVmowG1RgCyC1A0Hlo2I4Sue5X
	 0jnuCMvy6iJQGRtrrx/1C/qrPyvftSYZOb+D7e+E=
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
Subject: [Patch v5 2/5] RDMA/mana_ib : Register Mana IB  device with Management SW
Date: Thu,  7 Sep 2023 09:52:36 -0700
Message-Id: <1694105559-9465-3-git-send-email-sharmaajay@linuxonhyperv.com>
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

Each of the MANA infiniband devices must be registered
with the management software to request services/resources.
Register the Mana IB device with Management
which would later help get an adapter handle.

Signed-off-by: Ajay Sharma <sharmaajay@microsoft.com>
---
 drivers/infiniband/hw/mana/device.c           | 20 +++++--
 drivers/infiniband/hw/mana/main.c             | 58 ++++++-------------
 drivers/infiniband/hw/mana/mana_ib.h          |  1 +
 drivers/infiniband/hw/mana/mr.c               | 17 ++----
 drivers/infiniband/hw/mana/qp.c               |  8 +--
 .../net/ethernet/microsoft/mana/gdma_main.c   |  5 ++
 include/net/mana/gdma.h                       |  3 +
 7 files changed, 54 insertions(+), 58 deletions(-)

diff --git a/drivers/infiniband/hw/mana/device.c b/drivers/infiniband/hw/mana/device.c
index 083f27246ba8..ea4c8c8fc10d 100644
--- a/drivers/infiniband/hw/mana/device.c
+++ b/drivers/infiniband/hw/mana/device.c
@@ -78,22 +78,34 @@ static int mana_ib_probe(struct auxiliary_device *adev,
 	mib_dev->ib_dev.num_comp_vectors = 1;
 	mib_dev->ib_dev.dev.parent = mdev->gdma_context->dev;
 
-	ret = ib_register_device(&mib_dev->ib_dev, "mana_%d",
-				 mdev->gdma_context->dev);
+	ret = mana_gd_register_device(&mib_dev->gc->mana_ib);
 	if (ret) {
-		ib_dealloc_device(&mib_dev->ib_dev);
-		return ret;
+		ibdev_err(&mib_dev->ib_dev, "Failed to register device, ret %d",
+			  ret);
+		goto free_ib_device;
 	}
 
+	ret = ib_register_device(&mib_dev->ib_dev, "mana_%d",
+				 mdev->gdma_context->dev);
+	if (ret)
+		goto deregister_device;
+
 	dev_set_drvdata(&adev->dev, mib_dev);
 
 	return 0;
+
+deregister_device:
+	mana_gd_deregister_device(&mib_dev->gc->mana_ib);
+free_ib_device:
+	ib_dealloc_device(&mib_dev->ib_dev);
+	return ret;
 }
 
 static void mana_ib_remove(struct auxiliary_device *adev)
 {
 	struct mana_ib_dev *mib_dev = dev_get_drvdata(&adev->dev);
 
+	mana_gd_deregister_device(&mib_dev->gc->mana_ib);
 	ib_unregister_device(&mib_dev->ib_dev);
 	ib_dealloc_device(&mib_dev->ib_dev);
 }
diff --git a/drivers/infiniband/hw/mana/main.c b/drivers/infiniband/hw/mana/main.c
index 189e774cdab6..2c4e3c496644 100644
--- a/drivers/infiniband/hw/mana/main.c
+++ b/drivers/infiniband/hw/mana/main.c
@@ -8,7 +8,7 @@
 void mana_ib_uncfg_vport(struct mana_ib_dev *mib_dev, struct mana_ib_pd *pd,
 			 u32 port)
 {
-	struct gdma_dev *gd = mib_dev->gdma_dev;
+	struct gdma_dev *gd = &mib_dev->gc->mana;
 	struct mana_port_context *mpc;
 	struct net_device *ndev;
 	struct mana_context *mc;
@@ -32,7 +32,7 @@ int mana_ib_cfg_vport(struct mana_ib_dev *mib_dev, u32 port,
 		      struct mana_ib_pd *pd,
 		      u32 doorbell_id)
 {
-	struct gdma_dev *mdev = mib_dev->gdma_dev;
+	struct gdma_dev *mdev = &mib_dev->gc->mana;
 	struct mana_port_context *mpc;
 	struct mana_context *mc;
 	struct net_device *ndev;
@@ -81,17 +81,16 @@ int mana_ib_alloc_pd(struct ib_pd *ibpd, struct ib_udata *udata)
 	struct gdma_create_pd_req req = {};
 	enum gdma_pd_flags flags = 0;
 	struct mana_ib_dev *mib_dev;
-	struct gdma_dev *mdev;
+
 	int err;
 
 	mib_dev = container_of(ibdev, struct mana_ib_dev, ib_dev);
-	mdev = mib_dev->gdma_dev;
 
 	mana_gd_init_req_hdr(&req.hdr, GDMA_CREATE_PD, sizeof(req),
 			     sizeof(resp));
 
 	req.flags = flags;
-	err = mana_gd_send_request(mdev->gdma_context, sizeof(req), &req,
+	err = mana_gd_send_request(mib_dev->gc, sizeof(req), &req,
 				   sizeof(resp), &resp);
 
 	if (err || resp.hdr.status) {
@@ -121,17 +120,15 @@ int mana_ib_dealloc_pd(struct ib_pd *ibpd, struct ib_udata *udata)
 	struct gdma_destory_pd_resp resp = {};
 	struct gdma_destroy_pd_req req = {};
 	struct mana_ib_dev *mib_dev;
-	struct gdma_dev *mdev;
 	int err;
 
 	mib_dev = container_of(ibdev, struct mana_ib_dev, ib_dev);
-	mdev = mib_dev->gdma_dev;
 
 	mana_gd_init_req_hdr(&req.hdr, GDMA_DESTROY_PD, sizeof(req),
 			     sizeof(resp));
 
 	req.pd_handle = pd->pd_handle;
-	err = mana_gd_send_request(mdev->gdma_context, sizeof(req), &req,
+	err = mana_gd_send_request(mib_dev->gc, sizeof(req), &req,
 				   sizeof(resp), &resp);
 
 	if (err || resp.hdr.status) {
@@ -207,17 +204,13 @@ int mana_ib_alloc_ucontext(struct ib_ucontext *ibcontext,
 		container_of(ibcontext, struct mana_ib_ucontext, ibucontext);
 	struct ib_device *ibdev = ibcontext->device;
 	struct mana_ib_dev *mib_dev;
-	struct gdma_context *gc;
-	struct gdma_dev *dev;
 	int doorbell_page;
 	int ret;
 
 	mib_dev = container_of(ibdev, struct mana_ib_dev, ib_dev);
-	dev = mib_dev->gdma_dev;
-	gc = dev->gdma_context;
 
 	/* Allocate a doorbell page index */
-	ret = mana_gd_allocate_doorbell_page(gc, &doorbell_page);
+	ret = mana_gd_allocate_doorbell_page(mib_dev->gc, &doorbell_page);
 	if (ret) {
 		ibdev_dbg(ibdev, "Failed to allocate doorbell page %d\n", ret);
 		return ret;
@@ -236,20 +229,17 @@ void mana_ib_dealloc_ucontext(struct ib_ucontext *ibcontext)
 		container_of(ibcontext, struct mana_ib_ucontext, ibucontext);
 	struct ib_device *ibdev = ibcontext->device;
 	struct mana_ib_dev *mib_dev;
-	struct gdma_context *gc;
 	int ret;
 
 	mib_dev = container_of(ibdev, struct mana_ib_dev, ib_dev);
-	gc = mib_dev->gdma_dev->gdma_context;
 
-	ret = mana_gd_destroy_doorbell_page(gc, mana_ucontext->doorbell);
+	ret = mana_gd_destroy_doorbell_page(mib_dev->gc, mana_ucontext->doorbell);
 	if (ret)
 		ibdev_dbg(ibdev, "Failed to destroy doorbell page %d\n", ret);
 }
 
 static int
 mana_ib_gd_first_dma_region(struct mana_ib_dev *mib_dev,
-			    struct gdma_context *gc,
 			    struct gdma_create_dma_region_req *create_req,
 			    size_t num_pages, mana_handle_t *gdma_region,
 			    u32 expected_status)
@@ -262,7 +252,7 @@ mana_ib_gd_first_dma_region(struct mana_ib_dev *mib_dev,
 		struct_size(create_req, page_addr_list, num_pages);
 	create_req->page_addr_list_len = num_pages;
 
-	err = mana_gd_send_request(gc, create_req_msg_size, create_req,
+	err = mana_gd_send_request(mib_dev->gc, create_req_msg_size, create_req,
 				   sizeof(create_resp), &create_resp);
 	if (err || create_resp.hdr.status != expected_status) {
 		ibdev_dbg(&mib_dev->ib_dev,
@@ -282,7 +272,7 @@ mana_ib_gd_first_dma_region(struct mana_ib_dev *mib_dev,
 }
 
 static int
-mana_ib_gd_add_dma_region(struct mana_ib_dev *mib_dev, struct gdma_context *gc,
+mana_ib_gd_add_dma_region(struct mana_ib_dev *mib_dev,
 			  struct gdma_dma_region_add_pages_req *add_req,
 			  unsigned int num_pages, u32 expected_status)
 {
@@ -295,7 +285,7 @@ mana_ib_gd_add_dma_region(struct mana_ib_dev *mib_dev, struct gdma_context *gc,
 			     add_req_msg_size, sizeof(add_resp));
 	add_req->page_addr_list_len = num_pages;
 
-	err = mana_gd_send_request(gc, add_req_msg_size, add_req,
+	err = mana_gd_send_request(mib_dev->gc, add_req_msg_size, add_req,
 				   sizeof(add_resp), &add_resp);
 	if (err || add_resp.hdr.status != expected_status) {
 		ibdev_dbg(&mib_dev->ib_dev,
@@ -323,18 +313,14 @@ int mana_ib_gd_create_dma_region(struct mana_ib_dev *mib_dev,
 	struct ib_block_iter biter;
 	size_t max_pgs_add_cmd = 0;
 	size_t max_pgs_create_cmd;
-	struct gdma_context *gc;
 	size_t num_pages_total;
-	struct gdma_dev *mdev;
 	unsigned long page_sz;
 	unsigned int tail = 0;
 	u64 *page_addr_list;
 	void *request_buf;
 	int err;
 
-	mdev = mib_dev->gdma_dev;
-	gc = mdev->gdma_context;
-	hwc = gc->hwc.driver_data;
+	hwc = mib_dev->gc->hwc.driver_data;
 
 	/* Hardware requires dma region to align to chosen page size */
 	page_sz = ib_umem_find_best_pgsz(umem, PAGE_SZ_BM, 0);
@@ -388,7 +374,7 @@ int mana_ib_gd_create_dma_region(struct mana_ib_dev *mib_dev,
 
 		if (!num_pages_processed) {
 			/* First create message */
-			err = mana_ib_gd_first_dma_region(mib_dev, gc, create_req,
+			err = mana_ib_gd_first_dma_region(mib_dev, create_req,
 							  tail, gdma_region,
 							  expected_status);
 			if (err)
@@ -403,7 +389,7 @@ int mana_ib_gd_create_dma_region(struct mana_ib_dev *mib_dev,
 			page_addr_list = add_req->page_addr_list;
 		} else {
 			/* Subsequent create messages */
-			err = mana_ib_gd_add_dma_region(mib_dev, gc, add_req, tail,
+			err = mana_ib_gd_add_dma_region(mib_dev, add_req, tail,
 							expected_status);
 			if (err)
 				break;
@@ -429,13 +415,9 @@ int mana_ib_gd_create_dma_region(struct mana_ib_dev *mib_dev,
 
 int mana_ib_gd_destroy_dma_region(struct mana_ib_dev *mib_dev, u64 gdma_region)
 {
-	struct gdma_dev *mdev = mib_dev->gdma_dev;
-	struct gdma_context *gc;
-
-	gc = mdev->gdma_context;
 	ibdev_dbg(&mib_dev->ib_dev, "destroy dma region 0x%llx\n", gdma_region);
 
-	return mana_gd_destroy_dma_region(gc, gdma_region);
+	return mana_gd_destroy_dma_region(mib_dev->gc, gdma_region);
 }
 
 int mana_ib_mmap(struct ib_ucontext *ibcontext, struct vm_area_struct *vma)
@@ -444,13 +426,11 @@ int mana_ib_mmap(struct ib_ucontext *ibcontext, struct vm_area_struct *vma)
 		container_of(ibcontext, struct mana_ib_ucontext, ibucontext);
 	struct ib_device *ibdev = ibcontext->device;
 	struct mana_ib_dev *mib_dev;
-	struct gdma_context *gc;
 	phys_addr_t pfn;
 	pgprot_t prot;
 	int ret;
 
 	mib_dev = container_of(ibdev, struct mana_ib_dev, ib_dev);
-	gc = mib_dev->gdma_dev->gdma_context;
 
 	if (vma->vm_pgoff != 0) {
 		ibdev_dbg(ibdev, "Unexpected vm_pgoff %lu\n", vma->vm_pgoff);
@@ -458,18 +438,18 @@ int mana_ib_mmap(struct ib_ucontext *ibcontext, struct vm_area_struct *vma)
 	}
 
 	/* Map to the page indexed by ucontext->doorbell */
-	pfn = (gc->phys_db_page_base +
-	       gc->db_page_size * mana_ucontext->doorbell) >>
+	pfn = (mib_dev->gc->phys_db_page_base +
+	       mib_dev->gc->db_page_size * mana_ucontext->doorbell) >>
 	      PAGE_SHIFT;
 	prot = pgprot_writecombine(vma->vm_page_prot);
 
-	ret = rdma_user_mmap_io(ibcontext, vma, pfn, gc->db_page_size, prot,
-				NULL);
+	ret = rdma_user_mmap_io(ibcontext, vma, pfn, mib_dev->gc->db_page_size,
+				prot, NULL);
 	if (ret)
 		ibdev_dbg(ibdev, "can't rdma_user_mmap_io ret %d\n", ret);
 	else
 		ibdev_dbg(ibdev, "mapped I/O pfn 0x%llx page_size %u, ret %d\n",
-			  pfn, gc->db_page_size, ret);
+			  pfn, mib_dev->gc->db_page_size, ret);
 
 	return ret;
 }
diff --git a/drivers/infiniband/hw/mana/mana_ib.h b/drivers/infiniband/hw/mana/mana_ib.h
index ee4efd0af278..3a2ba6b96f15 100644
--- a/drivers/infiniband/hw/mana/mana_ib.h
+++ b/drivers/infiniband/hw/mana/mana_ib.h
@@ -30,6 +30,7 @@
 struct mana_ib_dev {
 	struct ib_device ib_dev;
 	struct gdma_dev *gdma_dev;
+	struct gdma_context *gc;
 };
 
 struct mana_ib_wq {
diff --git a/drivers/infiniband/hw/mana/mr.c b/drivers/infiniband/hw/mana/mr.c
index f6a53906204d..3106d1bce837 100644
--- a/drivers/infiniband/hw/mana/mr.c
+++ b/drivers/infiniband/hw/mana/mr.c
@@ -29,13 +29,10 @@ static int mana_ib_gd_create_mr(struct mana_ib_dev *mib_dev,
 				struct mana_ib_mr *mr,
 				struct gdma_create_mr_params *mr_params)
 {
-	struct gdma_dev *mdev = mib_dev->gdma_dev;
 	struct gdma_create_mr_response resp = {};
 	struct gdma_create_mr_request req = {};
-	struct gdma_context *gc;
 	int err;
 
-	gc = mdev->gdma_context;
 
 	mana_gd_init_req_hdr(&req.hdr, GDMA_CREATE_MR, sizeof(req),
 			     sizeof(resp));
@@ -56,7 +53,8 @@ static int mana_ib_gd_create_mr(struct mana_ib_dev *mib_dev,
 		return -EINVAL;
 	}
 
-	err = mana_gd_send_request(gc, sizeof(req), &req, sizeof(resp), &resp);
+	err = mana_gd_send_request(mib_dev->gc, sizeof(req), &req,
+				   sizeof(resp), &resp);
 
 	if (err || resp.hdr.status) {
 		ibdev_dbg(&mib_dev->ib_dev, "Failed to create mr %d, %u", err,
@@ -77,22 +75,19 @@ static int mana_ib_gd_create_mr(struct mana_ib_dev *mib_dev,
 static int mana_ib_gd_destroy_mr(struct mana_ib_dev *mib_dev, u64 mr_handle)
 {
 	struct gdma_destroy_mr_response resp = {};
-	struct gdma_dev *mdev = mib_dev->gdma_dev;
 	struct gdma_destroy_mr_request req = {};
-	struct gdma_context *gc;
 	int err;
 
-	gc = mdev->gdma_context;
-
 	mana_gd_init_req_hdr(&req.hdr, GDMA_DESTROY_MR, sizeof(req),
 			     sizeof(resp));
 
 	req.mr_handle = mr_handle;
 
-	err = mana_gd_send_request(gc, sizeof(req), &req, sizeof(resp), &resp);
+	err = mana_gd_send_request(mib_dev->gc, sizeof(req), &req,
+				   sizeof(resp), &resp);
 	if (err || resp.hdr.status) {
-		dev_err(gc->dev, "Failed to destroy MR: %d, 0x%x\n", err,
-			resp.hdr.status);
+		dev_err(mib_dev->gc->dev, "Failed to destroy MR: %d, 0x%x\n",
+			err, resp.hdr.status);
 		if (!err)
 			err = -EPROTO;
 		return err;
diff --git a/drivers/infiniband/hw/mana/qp.c b/drivers/infiniband/hw/mana/qp.c
index 3540bf5bb497..ef3275ac92a0 100644
--- a/drivers/infiniband/hw/mana/qp.c
+++ b/drivers/infiniband/hw/mana/qp.c
@@ -21,7 +21,7 @@ static int mana_ib_cfg_vport_steering(struct mana_ib_dev *mib_dev,
 	u32 req_buf_size;
 	int i, err;
 
-	mdev = mib_dev->gdma_dev;
+	mdev = &mib_dev->gc->mana;
 	gc = mdev->gdma_context;
 
 	req_buf_size =
@@ -267,7 +267,7 @@ static int mana_ib_create_qp_raw(struct ib_qp *ibqp, struct ib_pd *ibpd,
 		rdma_udata_to_drv_context(udata, struct mana_ib_ucontext,
 					  ibucontext);
 	struct mana_ib_create_qp_resp resp = {};
-	struct gdma_dev *gd = mib_dev->gdma_dev;
+	struct gdma_dev *gd = &mib_dev->gc->mana;
 	struct mana_ib_create_qp ucmd = {};
 	struct mana_obj_spec wq_spec = {};
 	struct mana_obj_spec cq_spec = {};
@@ -437,7 +437,7 @@ static int mana_ib_destroy_qp_rss(struct mana_ib_qp *qp,
 {
 	struct mana_ib_dev *mib_dev =
 		container_of(qp->ibqp.device, struct mana_ib_dev, ib_dev);
-	struct gdma_dev *gd = mib_dev->gdma_dev;
+	struct gdma_dev *gd = &mib_dev->gc->mana;
 	struct mana_port_context *mpc;
 	struct mana_context *mc;
 	struct net_device *ndev;
@@ -464,7 +464,7 @@ static int mana_ib_destroy_qp_raw(struct mana_ib_qp *qp, struct ib_udata *udata)
 {
 	struct mana_ib_dev *mib_dev =
 		container_of(qp->ibqp.device, struct mana_ib_dev, ib_dev);
-	struct gdma_dev *gd = mib_dev->gdma_dev;
+	struct gdma_dev *gd = &mib_dev->gc->mana;
 	struct ib_pd *ibpd = qp->ibqp.pd;
 	struct mana_port_context *mpc;
 	struct mana_context *mc;
diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/net/ethernet/microsoft/mana/gdma_main.c
index 8f3f78b68592..9fa7a2d6c2b2 100644
--- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
+++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
@@ -139,6 +139,9 @@ static int mana_gd_detect_devices(struct pci_dev *pdev)
 		if (dev_type == GDMA_DEVICE_MANA) {
 			gc->mana.gdma_context = gc;
 			gc->mana.dev_id = dev;
+		} else if (dev_type == GDMA_DEVICE_MANA_IB) {
+			gc->mana_ib.dev_id = dev;
+			gc->mana_ib.gdma_context = gc;
 		}
 	}
 
@@ -940,6 +943,7 @@ int mana_gd_register_device(struct gdma_dev *gd)
 
 	return 0;
 }
+EXPORT_SYMBOL(mana_gd_register_device);
 
 int mana_gd_deregister_device(struct gdma_dev *gd)
 {
@@ -970,6 +974,7 @@ int mana_gd_deregister_device(struct gdma_dev *gd)
 
 	return err;
 }
+EXPORT_SYMBOL(mana_gd_deregister_device);
 
 u32 mana_gd_wq_avail_space(struct gdma_queue *wq)
 {
diff --git a/include/net/mana/gdma.h b/include/net/mana/gdma.h
index 96c120160f15..e2b212dd722b 100644
--- a/include/net/mana/gdma.h
+++ b/include/net/mana/gdma.h
@@ -63,6 +63,7 @@ enum {
 	GDMA_DEVICE_NONE	= 0,
 	GDMA_DEVICE_HWC		= 1,
 	GDMA_DEVICE_MANA	= 2,
+	GDMA_DEVICE_MANA_IB	= 3,
 };
 
 struct gdma_resource {
@@ -384,6 +385,8 @@ struct gdma_context {
 
 	/* Azure network adapter */
 	struct gdma_dev		mana;
+	/* rdma device */
+	struct gdma_dev		mana_ib;
 };
 
 #define MAX_NUM_GDMA_DEVICES	4
-- 
2.25.1


