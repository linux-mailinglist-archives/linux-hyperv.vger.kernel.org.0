Return-Path: <linux-hyperv+bounces-8810-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IEQeHkMFj2ltHQEAu9opvQ
	(envelope-from <linux-hyperv+bounces-8810-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Feb 2026 12:04:35 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D8730135679
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Feb 2026 12:04:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A277630BB630
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Feb 2026 10:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FB76352921;
	Fri, 13 Feb 2026 10:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DDmXI31W"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B4FB21D3D6;
	Fri, 13 Feb 2026 10:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770980381; cv=none; b=aKIRVLvWSxLwFe5xQVA3cRAbIH6y8Ck/sYXJiY039duDpeoM8HzF+el4Bybxm+DDgfiLPNHAaBe5KsrCI8v0lX1Dmr28G/j+ki7mNc38CT1zYr/L5Jq5IPiJCtBFAShKNnZD2j4REcmp1PXIz96hrzWzfjVqK1ThEpYZQjU7jYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770980381; c=relaxed/simple;
	bh=DEbhTn6F1UX1TVdzezjFp62nwdCYX6NjcS4gjHmKhtM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TGjuC7G/0vHetR4+8rkN8TI84EO2C80q2fqsPxvIxXbnvRZT9fHlouzDAVVMgi7Wn+uO14PcnFKqEavYelVH7uAurtD6e3YlkI8GFlgch9XObCDAbKqEJ19nkmCnktDh+yFB1KcxKkfxCQOlRnyYpd35erlhp7cOjNeN/Bk8fqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DDmXI31W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB03CC116C6;
	Fri, 13 Feb 2026 10:59:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770980381;
	bh=DEbhTn6F1UX1TVdzezjFp62nwdCYX6NjcS4gjHmKhtM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DDmXI31WWgbZ8pUEXO/805G1YKrgTEuot9/XK3KnN1ugHGmzERuFkN68ZqUyjMhxt
	 gv7lgafxmY5HahAeHE8mxQNCeZel2efnz13xB6ux3vXZCxbBto+OgQnOKPudyjkaBa
	 nyFK72PVOkJjjXiqaFOwmJjGi/daUl4IY+kiWRdYIgl/JLUG3SAhXTyhtaWN95o4LT
	 1Ej3drJ3xgLHJ82HINrxtA7Ep5BjppiaEzodK7VJQ4FHCvR/j5ATnSvcLrFWUXxHje
	 KxPB4MM622PSV4LSaMHqM7GZknTA37rzX12KwWByr0MRpklJwPuOQTV+Zu6URMdn4s
	 UsVUlb0BqIG2A==
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
Subject: [PATCH rdma-next 13/50] RDMA/mlx4: Introduce a modern CQ creation interface
Date: Fri, 13 Feb 2026 12:57:49 +0200
Message-ID: <20260213-refactor-umem-v1-13-f3be85847922@nvidia.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
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
	TAGGED_FROM(0.00)[bounces-8810-lists,linux-hyperv=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D8730135679
X-Rspamd-Action: no action

From: Leon Romanovsky <leonro@nvidia.com>

The uverbs CQ creation UAPI allows users to supply their own umem when
creating a CQ. Update mlx4 to support this model while preserving compatibility
with the legacy interface that allocates umem internally.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx4/cq.c      | 191 ++++++++++++++++++++---------------
 drivers/infiniband/hw/mlx4/main.c    |   1 +
 drivers/infiniband/hw/mlx4/mlx4_ib.h |   4 +-
 3 files changed, 111 insertions(+), 85 deletions(-)

diff --git a/drivers/infiniband/hw/mlx4/cq.c b/drivers/infiniband/hw/mlx4/cq.c
index 94e9ff45725a..4bee08317620 100644
--- a/drivers/infiniband/hw/mlx4/cq.c
+++ b/drivers/infiniband/hw/mlx4/cq.c
@@ -136,8 +136,9 @@ static void mlx4_ib_free_cq_buf(struct mlx4_ib_dev *dev, struct mlx4_ib_cq_buf *
 }
 
 #define CQ_CREATE_FLAGS_SUPPORTED IB_UVERBS_CQ_FLAGS_TIMESTAMP_COMPLETION
-int mlx4_ib_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
-		      struct uverbs_attr_bundle *attrs)
+int mlx4_ib_create_user_cq(struct ib_cq *ibcq,
+			   const struct ib_cq_init_attr *attr,
+			   struct uverbs_attr_bundle *attrs)
 {
 	struct ib_udata *udata = &attrs->driver_udata;
 	struct ib_device *ibdev = ibcq->device;
@@ -145,13 +146,16 @@ int mlx4_ib_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 	int vector = attr->comp_vector;
 	struct mlx4_ib_dev *dev = to_mdev(ibdev);
 	struct mlx4_ib_cq *cq = to_mcq(ibcq);
-	struct mlx4_uar *uar;
+	struct mlx4_ib_create_cq ucmd;
+	int cqe_size = dev->dev->caps.cqe_size;
 	void *buf_addr;
+	int shift;
+	int n;
 	int err;
 	struct mlx4_ib_ucontext *context = rdma_udata_to_drv_context(
 		udata, struct mlx4_ib_ucontext, ibucontext);
 
-	if (entries < 1 || entries > dev->dev->caps.max_cqes)
+	if (attr->cqe > dev->dev->caps.max_cqes)
 		return -EINVAL;
 
 	if (attr->flags & ~CQ_CREATE_FLAGS_SUPPORTED)
@@ -161,95 +165,63 @@ int mlx4_ib_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 	cq->ibcq.cqe = entries - 1;
 	mutex_init(&cq->resize_mutex);
 	spin_lock_init(&cq->lock);
-	cq->resize_buf = NULL;
-	cq->resize_umem = NULL;
 	cq->create_flags = attr->flags;
 	INIT_LIST_HEAD(&cq->send_qp_list);
 	INIT_LIST_HEAD(&cq->recv_qp_list);
 
-	if (udata) {
-		struct mlx4_ib_create_cq ucmd;
-		int cqe_size = dev->dev->caps.cqe_size;
-		int shift;
-		int n;
-
-		if (ib_copy_from_udata(&ucmd, udata, sizeof ucmd)) {
-			err = -EFAULT;
-			goto err_cq;
-		}
-
-		buf_addr = (void *)(unsigned long)ucmd.buf_addr;
-
-		cq->umem = ib_umem_get(&dev->ib_dev, ucmd.buf_addr,
-				       entries * cqe_size,
-				       IB_ACCESS_LOCAL_WRITE);
-		if (IS_ERR(cq->umem)) {
-			err = PTR_ERR(cq->umem);
-			goto err_cq;
-		}
-
-		shift = mlx4_ib_umem_calc_optimal_mtt_size(cq->umem, 0, &n);
-		if (shift < 0) {
-			err = shift;
-			goto err_umem;
-		}
-
-		err = mlx4_mtt_init(dev->dev, n, shift, &cq->buf.mtt);
-		if (err)
-			goto err_umem;
-
-		err = mlx4_ib_umem_write_mtt(dev, &cq->buf.mtt, cq->umem);
-		if (err)
-			goto err_mtt;
+	if (ib_copy_from_udata(&ucmd, udata, sizeof(ucmd))) {
+		err = -EFAULT;
+		goto err_cq;
+	}
 
-		err = mlx4_ib_db_map_user(udata, ucmd.db_addr, &cq->db);
-		if (err)
-			goto err_mtt;
+	buf_addr = (void *)(unsigned long)ucmd.buf_addr;
 
-		uar = &context->uar;
-		cq->mcq.usage = MLX4_RES_USAGE_USER_VERBS;
-	} else {
-		err = mlx4_db_alloc(dev->dev, &cq->db, 1);
-		if (err)
-			goto err_cq;
+	if (!ibcq->umem)
+		ibcq->umem = ib_umem_get(&dev->ib_dev, ucmd.buf_addr,
+					 entries * cqe_size,
+					 IB_ACCESS_LOCAL_WRITE);
+	if (IS_ERR(ibcq->umem)) {
+		err = PTR_ERR(ibcq->umem);
+		goto err_cq;
+	}
 
-		cq->mcq.set_ci_db  = cq->db.db;
-		cq->mcq.arm_db     = cq->db.db + 1;
-		*cq->mcq.set_ci_db = 0;
-		*cq->mcq.arm_db    = 0;
+	shift = mlx4_ib_umem_calc_optimal_mtt_size(cq->ibcq.umem, 0, &n);
+	if (shift < 0) {
+		err = shift;
+		goto err_cq;
+	}
 
-		err = mlx4_ib_alloc_cq_buf(dev, &cq->buf, entries);
-		if (err)
-			goto err_db;
+	err = mlx4_mtt_init(dev->dev, n, shift, &cq->buf.mtt);
+	if (err)
+		goto err_cq;
 
-		buf_addr = &cq->buf.buf;
+	err = mlx4_ib_umem_write_mtt(dev, &cq->buf.mtt, cq->ibcq.umem);
+	if (err)
+		goto err_mtt;
 
-		uar = &dev->priv_uar;
-		cq->mcq.usage = MLX4_RES_USAGE_DRIVER;
-	}
+	err = mlx4_ib_db_map_user(udata, ucmd.db_addr, &cq->db);
+	if (err)
+		goto err_mtt;
 
 	if (dev->eq_table)
 		vector = dev->eq_table[vector % ibdev->num_comp_vectors];
 
-	err = mlx4_cq_alloc(dev->dev, entries, &cq->buf.mtt, uar, cq->db.dma,
-			    &cq->mcq, vector, 0,
+	err = mlx4_cq_alloc(dev->dev, entries, &cq->buf.mtt, &context->uar,
+			    cq->db.dma, &cq->mcq, vector, 0,
 			    !!(cq->create_flags &
 			       IB_UVERBS_CQ_FLAGS_TIMESTAMP_COMPLETION),
-			    buf_addr, !!udata);
+			    buf_addr, true);
 	if (err)
 		goto err_dbmap;
 
-	if (udata)
-		cq->mcq.tasklet_ctx.comp = mlx4_ib_cq_comp;
-	else
-		cq->mcq.comp = mlx4_ib_cq_comp;
+	cq->mcq.tasklet_ctx.comp = mlx4_ib_cq_comp;
 	cq->mcq.event = mlx4_ib_cq_event;
+	cq->mcq.usage = MLX4_RES_USAGE_USER_VERBS;
 
-	if (udata)
-		if (ib_copy_to_udata(udata, &cq->mcq.cqn, sizeof (__u32))) {
-			err = -EFAULT;
-			goto err_cq_free;
-		}
+	if (ib_copy_to_udata(udata, &cq->mcq.cqn, sizeof(__u32))) {
+		err = -EFAULT;
+		goto err_cq_free;
+	}
 
 	return 0;
 
@@ -257,21 +229,72 @@ int mlx4_ib_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 	mlx4_cq_free(dev->dev, &cq->mcq);
 
 err_dbmap:
-	if (udata)
-		mlx4_ib_db_unmap_user(context, &cq->db);
+	mlx4_ib_db_unmap_user(context, &cq->db);
 
 err_mtt:
 	mlx4_mtt_cleanup(dev->dev, &cq->buf.mtt);
+	/* UMEM is released by ib_core */
 
-err_umem:
-	ib_umem_release(cq->umem);
-	if (!udata)
-		mlx4_ib_free_cq_buf(dev, &cq->buf, cq->ibcq.cqe);
+err_cq:
+	return err;
+}
+
+int mlx4_ib_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
+		      struct uverbs_attr_bundle *attrs)
+{
+	struct ib_device *ibdev = ibcq->device;
+	int entries = attr->cqe;
+	int vector = attr->comp_vector;
+	struct mlx4_ib_dev *dev = to_mdev(ibdev);
+	struct mlx4_ib_cq *cq = to_mcq(ibcq);
+	void *buf_addr;
+	int err;
+
+	if (attr->cqe > dev->dev->caps.max_cqes)
+		return -EINVAL;
+
+	entries      = roundup_pow_of_two(entries + 1);
+	cq->ibcq.cqe = entries - 1;
+	mutex_init(&cq->resize_mutex);
+	spin_lock_init(&cq->lock);
+	INIT_LIST_HEAD(&cq->send_qp_list);
+	INIT_LIST_HEAD(&cq->recv_qp_list);
+
+	err = mlx4_db_alloc(dev->dev, &cq->db, 1);
+	if (err)
+		return err;
+
+	cq->mcq.set_ci_db  = cq->db.db;
+	cq->mcq.arm_db     = cq->db.db + 1;
+	*cq->mcq.set_ci_db = 0;
+	*cq->mcq.arm_db    = 0;
+
+	err = mlx4_ib_alloc_cq_buf(dev, &cq->buf, entries);
+	if (err)
+		goto err_db;
+
+	buf_addr = &cq->buf.buf;
+
+	if (dev->eq_table)
+		vector = dev->eq_table[vector % ibdev->num_comp_vectors];
+
+	err = mlx4_cq_alloc(dev->dev, entries, &cq->buf.mtt, &dev->priv_uar,
+			    cq->db.dma, &cq->mcq, vector, 0, 0,
+			    buf_addr, false);
+	if (err)
+		goto err_buf;
+
+	cq->mcq.comp = mlx4_ib_cq_comp;
+	cq->mcq.event = mlx4_ib_cq_event;
+	cq->mcq.usage = MLX4_RES_USAGE_DRIVER;
+
+	return 0;
+
+err_buf:
+	mlx4_ib_free_cq_buf(dev, &cq->buf, cq->ibcq.cqe);
 
 err_db:
-	if (!udata)
-		mlx4_db_free(dev->dev, &cq->db);
-err_cq:
+	mlx4_db_free(dev->dev, &cq->db);
 	return err;
 }
 
@@ -445,8 +468,8 @@ int mlx4_ib_resize_cq(struct ib_cq *ibcq, int entries, struct ib_udata *udata)
 	if (ibcq->uobject) {
 		cq->buf      = cq->resize_buf->buf;
 		cq->ibcq.cqe = cq->resize_buf->cqe;
-		ib_umem_release(cq->umem);
-		cq->umem     = cq->resize_umem;
+		ib_umem_release(cq->ibcq.umem);
+		cq->ibcq.umem     = cq->resize_umem;
 
 		kfree(cq->resize_buf);
 		cq->resize_buf = NULL;
@@ -506,11 +529,11 @@ int mlx4_ib_destroy_cq(struct ib_cq *cq, struct ib_udata *udata)
 				struct mlx4_ib_ucontext,
 				ibucontext),
 			&mcq->db);
+		/* UMEM is released by ib_core */
 	} else {
 		mlx4_ib_free_cq_buf(dev, &mcq->buf, cq->cqe);
 		mlx4_db_free(dev->dev, &mcq->db);
 	}
-	ib_umem_release(mcq->umem);
 	return 0;
 }
 
diff --git a/drivers/infiniband/hw/mlx4/main.c b/drivers/infiniband/hw/mlx4/main.c
index dd35e03402ab..fc05e7a1a870 100644
--- a/drivers/infiniband/hw/mlx4/main.c
+++ b/drivers/infiniband/hw/mlx4/main.c
@@ -2527,6 +2527,7 @@ static const struct ib_device_ops mlx4_ib_dev_ops = {
 	.attach_mcast = mlx4_ib_mcg_attach,
 	.create_ah = mlx4_ib_create_ah,
 	.create_cq = mlx4_ib_create_cq,
+	.create_user_cq = mlx4_ib_create_user_cq,
 	.create_qp = mlx4_ib_create_qp,
 	.create_srq = mlx4_ib_create_srq,
 	.dealloc_pd = mlx4_ib_dealloc_pd,
diff --git a/drivers/infiniband/hw/mlx4/mlx4_ib.h b/drivers/infiniband/hw/mlx4/mlx4_ib.h
index 5df5b955114e..96563c0836ce 100644
--- a/drivers/infiniband/hw/mlx4/mlx4_ib.h
+++ b/drivers/infiniband/hw/mlx4/mlx4_ib.h
@@ -121,7 +121,6 @@ struct mlx4_ib_cq {
 	struct mlx4_db		db;
 	spinlock_t		lock;
 	struct mutex		resize_mutex;
-	struct ib_umem	       *umem;
 	struct ib_umem	       *resize_umem;
 	int			create_flags;
 	/* List of qps that it serves.*/
@@ -772,6 +771,9 @@ int mlx4_ib_modify_cq(struct ib_cq *cq, u16 cq_count, u16 cq_period);
 int mlx4_ib_resize_cq(struct ib_cq *ibcq, int entries, struct ib_udata *udata);
 int mlx4_ib_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 		      struct uverbs_attr_bundle *attrs);
+int mlx4_ib_create_user_cq(struct ib_cq *ibcq,
+			   const struct ib_cq_init_attr *attr,
+			   struct uverbs_attr_bundle *attrs);
 int mlx4_ib_destroy_cq(struct ib_cq *cq, struct ib_udata *udata);
 int mlx4_ib_poll_cq(struct ib_cq *ibcq, int num_entries, struct ib_wc *wc);
 int mlx4_ib_arm_cq(struct ib_cq *cq, enum ib_cq_notify_flags flags);

-- 
2.52.0


