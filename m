Return-Path: <linux-hyperv+bounces-8808-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ANUfKW4Ej2lJHQEAu9opvQ
	(envelope-from <linux-hyperv+bounces-8808-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Feb 2026 12:01:02 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DBD3135546
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Feb 2026 12:01:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DD3F2307BAB8
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Feb 2026 10:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2371355020;
	Fri, 13 Feb 2026 10:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q72EEKBc"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0FA32C924;
	Fri, 13 Feb 2026 10:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770980373; cv=none; b=CGeTkmcq5kJI0VG0wB2V9zI9Lf0UQEK8cbDRmrYlgIFbu1oZmf6W9KnZejcVfNhYhyb4V2v8y0zRFBpNDzTMweiZ4jzhVdlW4PdKBtTLHO9scxipAiLs0DZubH99E3abIDpV9fQ7G9MmAGaYCZqqTzZcK9K2wx9P7GkTuIh/8vE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770980373; c=relaxed/simple;
	bh=60pBjLgyboHd3chw+dOmTg8slowfyyIq1cBDoIGl9YQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Gh5tDKzcnBggCcAf3tA2DbVtyXKGrC4DQa1cxVlM6xL5Wh/SvMPtTp7h946vSNFWpLZsxHLiWVZ2XApsbc01Mgu3PwOqR6Uuv/X8Zy3Y25wvcUgkEmyRW0VDRnBCXLl6iDt5HyGlxRD1yuuGFhxmqMXBP6mEaE69Z39U2gIJHEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q72EEKBc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56216C116C6;
	Fri, 13 Feb 2026 10:59:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770980373;
	bh=60pBjLgyboHd3chw+dOmTg8slowfyyIq1cBDoIGl9YQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q72EEKBcADy6oOsvCnhYXIRmuV8O5u/uD5csUGS1ZSsCCecFJqx2ybun50/nzbDKw
	 0yB9TAjOVHrAnPh3SBcK+j1VB1ufYh32oHgVVI5oowKtwcidPP5KR15apM3NP0JAwh
	 Tp5AoKo5OzX5ImYDMreAfmHSg/WbLUCeCa8NufXMvxlZRiGjUt5lVEnJCpm6y2Cw2W
	 we/pcBDFUZxpAcilARq/rrPHF/lSpy7l0YX+XLlRxLHqZtzOnSOaPAxldReJrDEAfM
	 w1aWGUGpnMWYIGcYl+bvvoI3XVH/hbaecyKSehc9uJ4CWohq4vr0M9xjamN86BpZg8
	 l5VQBJemJ9MPw==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	Selvin Xavier <selvin.xavier@broadcom.com>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Potnuri Bharat Teja <bharat@chelsio.com>,
	Michael Margolin <mrgolin@amazon.com>,
	Gal Pressman <gal.pressman@linux.dev>,
	Yossi Leybovich <sleybo@amazon.com>,
	Cheng Xu <chengyou@linux.alibaba.com>,
	Kai Shen <kaishen@linux.alibaba.com>,
	Chengchang Tang <tangchengchang@huawei.com>,
	Junxian Huang <huangjunxian6@hisilicon.com>,
	Abhijit Gangurde <abhijit.gangurde@amd.com>,
	Allen Hubbe <allen.hubbe@amd.com>,
	Krzysztof Czurylo <krzysztof.czurylo@intel.com>,
	Tatyana Nikolova <tatyana.e.nikolova@intel.com>,
	Long Li <longli@microsoft.com>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Michal Kalderon <mkalderon@marvell.com>,
	Bryan Tan <bryan-bt.tan@broadcom.com>,
	Vishnu Dasa <vishnu.dasa@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Christian Benvenuti <benve@cisco.com>,
	Nelson Escobar <neescoba@cisco.com>,
	Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
	Bernard Metzler <bernard.metzler@linux.dev>,
	Zhu Yanjun <zyjzyj2000@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-hyperv@vger.kernel.org
Subject: [PATCH rdma-next 11/50] RDMA/mlx5: Provide a modern CQ creation interface
Date: Fri, 13 Feb 2026 12:57:47 +0200
Message-ID: <20260213-refactor-umem-v1-11-f3be85847922@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260213-refactor-umem-v1-0-f3be85847922@nvidia.com>
References: <20260213-refactor-umem-v1-0-f3be85847922@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.15-dev-47773
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[ziepe.ca,kernel.org,broadcom.com,chelsio.com,amazon.com,linux.dev,linux.alibaba.com,huawei.com,hisilicon.com,amd.com,intel.com,microsoft.com,nvidia.com,marvell.com,cisco.com,cornelisnetworks.com,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[31];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-8808-lists,linux-hyperv=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1DBD3135546
X-Rspamd-Action: no action

From: Leon Romanovsky <leonro@nvidia.com>

The uverbs CQ creation UAPI allows users to supply their own umem for a CQ.
Update mlx5 to support this workflow while preserving support for creating
umem through the legacy interface.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/cq.c      | 154 +++++++++++++++++++++++------------
 drivers/infiniband/hw/mlx5/main.c    |   1 +
 drivers/infiniband/hw/mlx5/mlx5_ib.h |   3 +
 3 files changed, 107 insertions(+), 51 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/cq.c b/drivers/infiniband/hw/mlx5/cq.c
index 1b4290166e87..52a435efd0de 100644
--- a/drivers/infiniband/hw/mlx5/cq.c
+++ b/drivers/infiniband/hw/mlx5/cq.c
@@ -749,16 +749,15 @@ static int create_cq_user(struct mlx5_ib_dev *dev, struct ib_udata *udata,
 
 	*cqe_size = ucmd.cqe_size;
 
-	cq->buf.umem =
-		ib_umem_get(&dev->ib_dev, ucmd.buf_addr,
-			    entries * ucmd.cqe_size, IB_ACCESS_LOCAL_WRITE);
-	if (IS_ERR(cq->buf.umem)) {
-		err = PTR_ERR(cq->buf.umem);
-		return err;
-	}
+	if (!cq->ibcq.umem)
+		cq->ibcq.umem = ib_umem_get(&dev->ib_dev, ucmd.buf_addr,
+					    entries * ucmd.cqe_size,
+					    IB_ACCESS_LOCAL_WRITE);
+	if (IS_ERR(cq->ibcq.umem))
+		return PTR_ERR(cq->ibcq.umem);
 
 	page_size = mlx5_umem_find_best_cq_quantized_pgoff(
-		cq->buf.umem, cqc, log_page_size, MLX5_ADAPTER_PAGE_SHIFT,
+		cq->ibcq.umem, cqc, log_page_size, MLX5_ADAPTER_PAGE_SHIFT,
 		page_offset, 64, &page_offset_quantized);
 	if (!page_size) {
 		err = -EINVAL;
@@ -769,12 +768,12 @@ static int create_cq_user(struct mlx5_ib_dev *dev, struct ib_udata *udata,
 	if (err)
 		goto err_umem;
 
-	ncont = ib_umem_num_dma_blocks(cq->buf.umem, page_size);
+	ncont = ib_umem_num_dma_blocks(cq->ibcq.umem, page_size);
 	mlx5_ib_dbg(
 		dev,
 		"addr 0x%llx, size %u, npages %zu, page_size %lu, ncont %d\n",
 		ucmd.buf_addr, entries * ucmd.cqe_size,
-		ib_umem_num_pages(cq->buf.umem), page_size, ncont);
+		ib_umem_num_pages(cq->ibcq.umem), page_size, ncont);
 
 	*inlen = MLX5_ST_SZ_BYTES(create_cq_in) +
 		 MLX5_FLD_SZ_BYTES(create_cq_in, pas[0]) * ncont;
@@ -785,7 +784,7 @@ static int create_cq_user(struct mlx5_ib_dev *dev, struct ib_udata *udata,
 	}
 
 	pas = (__be64 *)MLX5_ADDR_OF(create_cq_in, *cqb, pas);
-	mlx5_ib_populate_pas(cq->buf.umem, page_size, pas, 0);
+	mlx5_ib_populate_pas(cq->ibcq.umem, page_size, pas, 0);
 
 	cqc = MLX5_ADDR_OF(create_cq_in, *cqb, cq_context);
 	MLX5_SET(cqc, cqc, log_page_size,
@@ -858,7 +857,7 @@ static int create_cq_user(struct mlx5_ib_dev *dev, struct ib_udata *udata,
 	mlx5_ib_db_unmap_user(context, &cq->db);
 
 err_umem:
-	ib_umem_release(cq->buf.umem);
+	/* UMEM is released by ib_core */
 	return err;
 }
 
@@ -868,7 +867,6 @@ static void destroy_cq_user(struct mlx5_ib_cq *cq, struct ib_udata *udata)
 		udata, struct mlx5_ib_ucontext, ibucontext);
 
 	mlx5_ib_db_unmap_user(context, &cq->db);
-	ib_umem_release(cq->buf.umem);
 }
 
 static void init_cq_frag_buf(struct mlx5_ib_cq_buf *buf)
@@ -949,8 +947,9 @@ static void notify_soft_wc_handler(struct work_struct *work)
 	cq->ibcq.comp_handler(&cq->ibcq, cq->ibcq.cq_context);
 }
 
-int mlx5_ib_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
-		      struct uverbs_attr_bundle *attrs)
+int mlx5_ib_create_user_cq(struct ib_cq *ibcq,
+			   const struct ib_cq_init_attr *attr,
+			   struct uverbs_attr_bundle *attrs)
 {
 	struct ib_udata *udata = &attrs->driver_udata;
 	struct ib_device *ibdev = ibcq->device;
@@ -967,8 +966,7 @@ int mlx5_ib_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 	int eqn;
 	int err;
 
-	if (entries < 0 ||
-	    (entries > (1 << MLX5_CAP_GEN(dev->mdev, log_max_cq_sz))))
+	if (attr->cqe > (1 << MLX5_CAP_GEN(dev->mdev, log_max_cq_sz)))
 		return -EINVAL;
 
 	if (check_cq_create_flags(attr->flags))
@@ -981,27 +979,15 @@ int mlx5_ib_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 	cq->ibcq.cqe = entries - 1;
 	mutex_init(&cq->resize_mutex);
 	spin_lock_init(&cq->lock);
-	cq->resize_buf = NULL;
-	cq->resize_umem = NULL;
 	if (attr->flags & IB_UVERBS_CQ_FLAGS_TIMESTAMP_COMPLETION)
 		cq->private_flags |= MLX5_IB_CQ_PR_TIMESTAMP_COMPLETION;
 	INIT_LIST_HEAD(&cq->list_send_qp);
 	INIT_LIST_HEAD(&cq->list_recv_qp);
 
-	if (udata) {
-		err = create_cq_user(dev, udata, cq, entries, &cqb, &cqe_size,
-				     &index, &inlen, attrs);
-		if (err)
-			return err;
-	} else {
-		cqe_size = cache_line_size() == 128 ? 128 : 64;
-		err = create_cq_kernel(dev, cq, entries, cqe_size, &cqb,
-				       &index, &inlen);
-		if (err)
-			return err;
-
-		INIT_WORK(&cq->notify_work, notify_soft_wc_handler);
-	}
+	err = create_cq_user(dev, udata, cq, entries, &cqb, &cqe_size, &index,
+			     &inlen, attrs);
+	if (err)
+		return err;
 
 	err = mlx5_comp_eqn_get(dev->mdev, vector, &eqn);
 	if (err)
@@ -1021,12 +1007,8 @@ int mlx5_ib_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 	if (attr->flags & IB_UVERBS_CQ_FLAGS_IGNORE_OVERRUN)
 		MLX5_SET(cqc, cqc, oi, 1);
 
-	if (udata) {
-		cq->mcq.comp = mlx5_add_cq_to_tasklet;
-		cq->mcq.tasklet_ctx.comp = mlx5_ib_cq_comp;
-	} else {
-		cq->mcq.comp  = mlx5_ib_cq_comp;
-	}
+	cq->mcq.comp = mlx5_add_cq_to_tasklet;
+	cq->mcq.tasklet_ctx.comp = mlx5_ib_cq_comp;
 
 	err = mlx5_core_create_cq(dev->mdev, &cq->mcq, cqb, inlen, out, sizeof(out));
 	if (err)
@@ -1037,12 +1019,10 @@ int mlx5_ib_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 
 	INIT_LIST_HEAD(&cq->wc_list);
 
-	if (udata)
-		if (ib_copy_to_udata(udata, &cq->mcq.cqn, sizeof(__u32))) {
-			err = -EFAULT;
-			goto err_cmd;
-		}
-
+	if (ib_copy_to_udata(udata, &cq->mcq.cqn, sizeof(__u32))) {
+		err = -EFAULT;
+		goto err_cmd;
+	}
 
 	kvfree(cqb);
 	return 0;
@@ -1052,10 +1032,82 @@ int mlx5_ib_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 
 err_cqb:
 	kvfree(cqb);
-	if (udata)
-		destroy_cq_user(cq, udata);
-	else
-		destroy_cq_kernel(dev, cq);
+	destroy_cq_user(cq, udata);
+	return err;
+}
+
+
+int mlx5_ib_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
+		      struct uverbs_attr_bundle *attrs)
+{
+	struct ib_device *ibdev = ibcq->device;
+	int entries = attr->cqe;
+	int vector = attr->comp_vector;
+	struct mlx5_ib_dev *dev = to_mdev(ibdev);
+	struct mlx5_ib_cq *cq = to_mcq(ibcq);
+	u32 out[MLX5_ST_SZ_DW(create_cq_out)];
+	int index;
+	int inlen;
+	u32 *cqb = NULL;
+	void *cqc;
+	int cqe_size;
+	int eqn;
+	int err;
+
+	if (attr->cqe > (1 << MLX5_CAP_GEN(dev->mdev, log_max_cq_sz)))
+		return -EINVAL;
+
+	entries = roundup_pow_of_two(entries + 1);
+	if (entries > (1 << MLX5_CAP_GEN(dev->mdev, log_max_cq_sz)))
+		return -EINVAL;
+
+	cq->ibcq.cqe = entries - 1;
+	mutex_init(&cq->resize_mutex);
+	spin_lock_init(&cq->lock);
+	INIT_LIST_HEAD(&cq->list_send_qp);
+	INIT_LIST_HEAD(&cq->list_recv_qp);
+
+	cqe_size = cache_line_size() == 128 ? 128 : 64;
+	err = create_cq_kernel(dev, cq, entries, cqe_size, &cqb, &index,
+			       &inlen);
+	if (err)
+		return err;
+
+	INIT_WORK(&cq->notify_work, notify_soft_wc_handler);
+
+	err = mlx5_comp_eqn_get(dev->mdev, vector, &eqn);
+	if (err)
+		goto err_cqb;
+
+	cq->cqe_size = cqe_size;
+
+	cqc = MLX5_ADDR_OF(create_cq_in, cqb, cq_context);
+	MLX5_SET(cqc, cqc, cqe_sz,
+		 cqe_sz_to_mlx_sz(cqe_size,
+				  cq->private_flags &
+				  MLX5_IB_CQ_PR_FLAGS_CQE_128_PAD));
+	MLX5_SET(cqc, cqc, log_cq_size, ilog2(entries));
+	MLX5_SET(cqc, cqc, uar_page, index);
+	MLX5_SET(cqc, cqc, c_eqn_or_apu_element, eqn);
+	MLX5_SET64(cqc, cqc, dbr_addr, cq->db.dma);
+
+	cq->mcq.comp = mlx5_ib_cq_comp;
+
+	err = mlx5_core_create_cq(dev->mdev, &cq->mcq, cqb, inlen, out,
+				  sizeof(out));
+	if (err)
+		goto err_cqb;
+
+	mlx5_ib_dbg(dev, "cqn 0x%x\n", cq->mcq.cqn);
+	cq->mcq.event = mlx5_ib_cq_event;
+
+	INIT_LIST_HEAD(&cq->wc_list);
+	kvfree(cqb);
+	return 0;
+
+err_cqb:
+	kvfree(cqb);
+	destroy_cq_kernel(dev, cq);
 	return err;
 }
 
@@ -1390,8 +1442,8 @@ int mlx5_ib_resize_cq(struct ib_cq *ibcq, int entries, struct ib_udata *udata)
 
 	if (udata) {
 		cq->ibcq.cqe = entries - 1;
-		ib_umem_release(cq->buf.umem);
-		cq->buf.umem = cq->resize_umem;
+		ib_umem_release(cq->ibcq.umem);
+		cq->ibcq.umem = cq->resize_umem;
 		cq->resize_umem = NULL;
 	} else {
 		struct mlx5_ib_cq_buf tbuf;
diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index eba023b7af0f..4f49f65e2c16 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -4447,6 +4447,7 @@ static const struct ib_device_ops mlx5_ib_dev_ops = {
 	.check_mr_status = mlx5_ib_check_mr_status,
 	.create_ah = mlx5_ib_create_ah,
 	.create_cq = mlx5_ib_create_cq,
+	.create_user_cq = mlx5_ib_create_user_cq,
 	.create_qp = mlx5_ib_create_qp,
 	.create_srq = mlx5_ib_create_srq,
 	.create_user_ah = mlx5_ib_create_ah,
diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index ce3372aea48b..2556e326afde 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -1371,6 +1371,9 @@ int mlx5_ib_read_wqe_srq(struct mlx5_ib_srq *srq, int wqe_index, void *buffer,
 			 size_t buflen, size_t *bc);
 int mlx5_ib_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 		      struct uverbs_attr_bundle *attrs);
+int mlx5_ib_create_user_cq(struct ib_cq *ibcq,
+			   const struct ib_cq_init_attr *attr,
+			   struct uverbs_attr_bundle *attrs);
 int mlx5_ib_destroy_cq(struct ib_cq *cq, struct ib_udata *udata);
 int mlx5_ib_poll_cq(struct ib_cq *ibcq, int num_entries, struct ib_wc *wc);
 int mlx5_ib_pre_destroy_cq(struct ib_cq *cq);

-- 
2.52.0


