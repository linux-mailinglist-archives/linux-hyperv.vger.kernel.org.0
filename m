Return-Path: <linux-hyperv+bounces-8841-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mPotCEIHj2ltHQEAu9opvQ
	(envelope-from <linux-hyperv+bounces-8841-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Feb 2026 12:13:06 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9547E13592C
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Feb 2026 12:13:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 306523229831
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Feb 2026 11:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2599F3624C9;
	Fri, 13 Feb 2026 11:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FZ8DtDI2"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0281A35CB8F;
	Fri, 13 Feb 2026 11:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770980498; cv=none; b=Nd75e5zxKZzP5AJMKIiepCs7yQL7TOl2OhmXL8m7UvpsI7xXOj9QA2jnqgCTUnsTBO6XbSZsD9NxuUYyyFKIFFYtTY3Z0apMU6Pcm47KF7i5yzKk5tfiT0NkBq58TXmlkBTcT8Leax+VKLB1srGldF/EbMhJp2bzqQF5UrzXGC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770980498; c=relaxed/simple;
	bh=nO84O8+Swl46SlnmJk6vunGfz6wVTx+9J08tVJ2Gd6E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qwko73rVCC46TyX9/kQe4QD+AZ6v9cE+E5pPXsEWpacSlBa2mHqpde2VItreI9nr6yMiRrgm2XLzUSnX4VJ1ASbzy/mQEsWjR4+/btpa4c4uoHOqbQ65kWO29/0DyZkQsCaGOAf4PzCYb2MOlJ1z8JPMiVg49mXp3gHcCJAG+Po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FZ8DtDI2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1314FC116C6;
	Fri, 13 Feb 2026 11:01:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770980497;
	bh=nO84O8+Swl46SlnmJk6vunGfz6wVTx+9J08tVJ2Gd6E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FZ8DtDI20irrSCHqb65clf8FZhIq94vlLost8Z22pPDPyQRmrKPeF4RAKPSr51Nk9
	 zMirU7Y/7d/eD3JFDjewZbsG+K8JBKxOjSu00hhwUT+HEAlEngFVjABOWZOPD0Shwj
	 8jQ6JxjBIPR/PzhPoVaz0KnVUkRLGGN0STcQ1WcFje5vwWoZnTMdjkLNGWvRoUW+rm
	 u+XHe0i+RXIljs2HsfsKk3jkS2ZRjZjsb16Qtu/0PuxCyyHHVdQ6TxKLFuCfWSD2ib
	 Q1PFHdJPHjpWqi5YPEqYb5GU6weJFDKvL02Oe6+ESQqdBkisb214NFoS1ctuXN2ssQ
	 2JEnHvXxmuFbg==
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
Subject: [PATCH rdma-next 40/50] RDMA: Properly propagate the number of CQEs as unsigned int
Date: Fri, 13 Feb 2026 12:58:16 +0200
Message-ID: <20260213-refactor-umem-v1-40-f3be85847922@nvidia.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
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
	TAGGED_FROM(0.00)[bounces-8841-lists,linux-hyperv=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:mid,nvidia.com:email]
X-Rspamd-Queue-Id: 9547E13592C
X-Rspamd-Action: no action

From: Leon Romanovsky <leonro@nvidia.com>

Instead of checking whether the number of CQEs is negative or zero, fix the
.resize_user_cq() declaration to use unsigned int. This better reflects the
expected value range. The sanity check is then handled correctly in
ib_uvbers.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/uverbs_cmd.c         |  3 +++
 drivers/infiniband/hw/bnxt_re/ib_verbs.c     |  8 +++----
 drivers/infiniband/hw/bnxt_re/ib_verbs.h     |  3 ++-
 drivers/infiniband/hw/irdma/verbs.c          |  2 +-
 drivers/infiniband/hw/mlx4/cq.c              |  5 +++--
 drivers/infiniband/hw/mlx4/mlx4_ib.h         |  3 ++-
 drivers/infiniband/hw/mlx5/cq.c              | 10 +++------
 drivers/infiniband/hw/mlx5/mlx5_ib.h         |  3 ++-
 drivers/infiniband/hw/mthca/mthca_provider.c |  5 +++--
 drivers/infiniband/hw/ocrdma/ocrdma_verbs.c  | 12 +++++------
 drivers/infiniband/hw/ocrdma/ocrdma_verbs.h  |  3 ++-
 drivers/infiniband/sw/rdmavt/cq.c            | 10 ++-------
 drivers/infiniband/sw/rdmavt/cq.h            |  2 +-
 drivers/infiniband/sw/rxe/rxe_cq.c           | 31 ----------------------------
 drivers/infiniband/sw/rxe/rxe_loc.h          |  3 ---
 drivers/infiniband/sw/rxe/rxe_verbs.c        |  9 ++++----
 include/rdma/ib_verbs.h                      |  2 +-
 17 files changed, 38 insertions(+), 76 deletions(-)

diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
index 57697738fd25..b4b0c7c92fb1 100644
--- a/drivers/infiniband/core/uverbs_cmd.c
+++ b/drivers/infiniband/core/uverbs_cmd.c
@@ -1147,6 +1147,9 @@ static int ib_uverbs_resize_cq(struct uverbs_attr_bundle *attrs)
 	if (ret)
 		return ret;
 
+	if (!cmd.cqe)
+		return -EINVAL;
+
 	cq = uobj_get_obj_read(cq, UVERBS_OBJECT_CQ, cmd.cq_handle, attrs);
 	if (IS_ERR(cq))
 		return PTR_ERR(cq);
diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index 16bb586d68c7..d652018c19b3 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -3324,7 +3324,8 @@ static void bnxt_re_resize_cq_complete(struct bnxt_re_cq *cq)
 	}
 }
 
-int bnxt_re_resize_cq(struct ib_cq *ibcq, int cqe, struct ib_udata *udata)
+int bnxt_re_resize_cq(struct ib_cq *ibcq, unsigned int cqe,
+		      struct ib_udata *udata)
 {
 	struct bnxt_qplib_sg_info sg_info = {};
 	struct bnxt_qplib_dpi *orig_dpi = NULL;
@@ -3346,11 +3347,8 @@ int bnxt_re_resize_cq(struct ib_cq *ibcq, int cqe, struct ib_udata *udata)
 	}
 
 	/* Check the requested cq depth out of supported depth */
-	if (cqe < 1 || cqe > dev_attr->max_cq_wqes) {
-		ibdev_err(&rdev->ibdev, "Resize CQ %#x failed - out of range cqe %d",
-			  cq->qplib_cq.id, cqe);
+	if (cqe > dev_attr->max_cq_wqes)
 		return -EINVAL;
-	}
 
 	uctx = rdma_udata_to_drv_context(udata, struct bnxt_re_ucontext, ib_uctx);
 	entries = bnxt_re_init_depth(cqe + 1, uctx);
diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.h b/drivers/infiniband/hw/bnxt_re/ib_verbs.h
index cac3e10b73f6..7890d6ebad90 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.h
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.h
@@ -249,7 +249,8 @@ int bnxt_re_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 int bnxt_re_create_user_cq(struct ib_cq *ibcq,
 			   const struct ib_cq_init_attr *attr,
 			   struct uverbs_attr_bundle *attrs);
-int bnxt_re_resize_cq(struct ib_cq *ibcq, int cqe, struct ib_udata *udata);
+int bnxt_re_resize_cq(struct ib_cq *ibcq, unsigned int cqe,
+		      struct ib_udata *udata);
 int bnxt_re_destroy_cq(struct ib_cq *cq, struct ib_udata *udata);
 int bnxt_re_poll_cq(struct ib_cq *cq, int num_entries, struct ib_wc *wc);
 int bnxt_re_req_notify_cq(struct ib_cq *cq, enum ib_cq_notify_flags flags);
diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
index d5442aebf1ac..f20f53ecd869 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -2012,7 +2012,7 @@ static int irdma_destroy_cq(struct ib_cq *ib_cq, struct ib_udata *udata)
  * @entries: desired cq size
  * @udata: user data
  */
-static int irdma_resize_cq(struct ib_cq *ibcq, int entries,
+static int irdma_resize_cq(struct ib_cq *ibcq, unsigned int entries,
 			   struct ib_udata *udata)
 {
 	struct irdma_resize_cq_req req = {};
diff --git a/drivers/infiniband/hw/mlx4/cq.c b/drivers/infiniband/hw/mlx4/cq.c
index 05fad06b89c2..f4595afced45 100644
--- a/drivers/infiniband/hw/mlx4/cq.c
+++ b/drivers/infiniband/hw/mlx4/cq.c
@@ -351,14 +351,15 @@ static int mlx4_alloc_resize_umem(struct mlx4_ib_dev *dev, struct mlx4_ib_cq *cq
 	return err;
 }
 
-int mlx4_ib_resize_cq(struct ib_cq *ibcq, int entries, struct ib_udata *udata)
+int mlx4_ib_resize_cq(struct ib_cq *ibcq, unsigned int entries,
+		      struct ib_udata *udata)
 {
 	struct mlx4_ib_dev *dev = to_mdev(ibcq->device);
 	struct mlx4_ib_cq *cq = to_mcq(ibcq);
 	struct mlx4_mtt mtt;
 	int err;
 
-	if (entries < 1 || entries > dev->dev->caps.max_cqes)
+	if (entries > dev->dev->caps.max_cqes)
 		return -EINVAL;
 
 	entries = roundup_pow_of_two(entries + 1);
diff --git a/drivers/infiniband/hw/mlx4/mlx4_ib.h b/drivers/infiniband/hw/mlx4/mlx4_ib.h
index 6a7ed5225c7d..5a799d6df93e 100644
--- a/drivers/infiniband/hw/mlx4/mlx4_ib.h
+++ b/drivers/infiniband/hw/mlx4/mlx4_ib.h
@@ -767,7 +767,8 @@ struct ib_mr *mlx4_ib_alloc_mr(struct ib_pd *pd, enum ib_mr_type mr_type,
 int mlx4_ib_map_mr_sg(struct ib_mr *ibmr, struct scatterlist *sg, int sg_nents,
 		      unsigned int *sg_offset);
 int mlx4_ib_modify_cq(struct ib_cq *cq, u16 cq_count, u16 cq_period);
-int mlx4_ib_resize_cq(struct ib_cq *ibcq, int entries, struct ib_udata *udata);
+int mlx4_ib_resize_cq(struct ib_cq *ibcq, unsigned int entries,
+		      struct ib_udata *udata);
 int mlx4_ib_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 		      struct uverbs_attr_bundle *attrs);
 int mlx4_ib_create_user_cq(struct ib_cq *ibcq,
diff --git a/drivers/infiniband/hw/mlx5/cq.c b/drivers/infiniband/hw/mlx5/cq.c
index ce20af01cde0..78c3494517d7 100644
--- a/drivers/infiniband/hw/mlx5/cq.c
+++ b/drivers/infiniband/hw/mlx5/cq.c
@@ -1253,7 +1253,8 @@ static int resize_user(struct mlx5_ib_dev *dev, struct mlx5_ib_cq *cq,
 	return 0;
 }
 
-int mlx5_ib_resize_cq(struct ib_cq *ibcq, int entries, struct ib_udata *udata)
+int mlx5_ib_resize_cq(struct ib_cq *ibcq, unsigned int entries,
+		      struct ib_udata *udata)
 {
 	struct mlx5_ib_dev *dev = to_mdev(ibcq->device);
 	struct mlx5_ib_cq *cq = to_mcq(ibcq);
@@ -1273,13 +1274,8 @@ int mlx5_ib_resize_cq(struct ib_cq *ibcq, int entries, struct ib_udata *udata)
 		return -ENOSYS;
 	}
 
-	if (entries < 1 ||
-	    entries > (1 << MLX5_CAP_GEN(dev->mdev, log_max_cq_sz))) {
-		mlx5_ib_warn(dev, "wrong entries number %d, max %d\n",
-			     entries,
-			     1 << MLX5_CAP_GEN(dev->mdev, log_max_cq_sz));
+	if (entries > (1 << MLX5_CAP_GEN(dev->mdev, log_max_cq_sz)))
 		return -EINVAL;
-	}
 
 	entries = roundup_pow_of_two(entries + 1);
 	if (entries > (1 << MLX5_CAP_GEN(dev->mdev, log_max_cq_sz)) + 1)
diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index 2556e326afde..e99a647ed62d 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -1380,7 +1380,8 @@ int mlx5_ib_pre_destroy_cq(struct ib_cq *cq);
 void mlx5_ib_post_destroy_cq(struct ib_cq *cq);
 int mlx5_ib_arm_cq(struct ib_cq *ibcq, enum ib_cq_notify_flags flags);
 int mlx5_ib_modify_cq(struct ib_cq *cq, u16 cq_count, u16 cq_period);
-int mlx5_ib_resize_cq(struct ib_cq *ibcq, int entries, struct ib_udata *udata);
+int mlx5_ib_resize_cq(struct ib_cq *ibcq, unsigned int entries,
+		      struct ib_udata *udata);
 struct ib_mr *mlx5_ib_get_dma_mr(struct ib_pd *pd, int acc);
 struct ib_mr *mlx5_ib_reg_user_mr(struct ib_pd *pd, u64 start, u64 length,
 				  u64 virt_addr, int access_flags,
diff --git a/drivers/infiniband/hw/mthca/mthca_provider.c b/drivers/infiniband/hw/mthca/mthca_provider.c
index fd306a229318..85de004547ab 100644
--- a/drivers/infiniband/hw/mthca/mthca_provider.c
+++ b/drivers/infiniband/hw/mthca/mthca_provider.c
@@ -668,7 +668,8 @@ static int mthca_create_cq(struct ib_cq *ibcq,
 	return 0;
 }
 
-static int mthca_resize_cq(struct ib_cq *ibcq, int entries, struct ib_udata *udata)
+static int mthca_resize_cq(struct ib_cq *ibcq, unsigned int entries,
+			   struct ib_udata *udata)
 {
 	struct mthca_dev *dev = to_mdev(ibcq->device);
 	struct mthca_cq *cq = to_mcq(ibcq);
@@ -676,7 +677,7 @@ static int mthca_resize_cq(struct ib_cq *ibcq, int entries, struct ib_udata *uda
 	u32 lkey;
 	int ret;
 
-	if (entries < 1 || entries > dev->limits.max_cqes)
+	if (entries > dev->limits.max_cqes)
 		return -EINVAL;
 
 	mutex_lock(&cq->mutex);
diff --git a/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c b/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
index 034d8b937a77..8445780c398f 100644
--- a/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
+++ b/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
@@ -1035,18 +1035,16 @@ int ocrdma_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 	return 0;
 }
 
-int ocrdma_resize_cq(struct ib_cq *ibcq, int new_cnt,
+int ocrdma_resize_cq(struct ib_cq *ibcq, unsigned int new_cnt,
 		     struct ib_udata *udata)
 {
-	int status = 0;
 	struct ocrdma_cq *cq = get_ocrdma_cq(ibcq);
 
-	if (new_cnt < 1 || new_cnt > cq->max_hw_cqe) {
-		status = -EINVAL;
-		return status;
-	}
+	if (new_cnt > cq->max_hw_cqe)
+		return -EINVAL;
+
 	ibcq->cqe = new_cnt;
-	return status;
+	return 0;
 }
 
 static void ocrdma_flush_cq(struct ocrdma_cq *cq)
diff --git a/drivers/infiniband/hw/ocrdma/ocrdma_verbs.h b/drivers/infiniband/hw/ocrdma/ocrdma_verbs.h
index 4a572608fd9f..bbc08f88c046 100644
--- a/drivers/infiniband/hw/ocrdma/ocrdma_verbs.h
+++ b/drivers/infiniband/hw/ocrdma/ocrdma_verbs.h
@@ -74,7 +74,8 @@ int ocrdma_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 int ocrdma_create_user_cq(struct ib_cq *ibcq,
 			  const struct ib_cq_init_attr *attr,
 			  struct uverbs_attr_bundle *attrs);
-int ocrdma_resize_cq(struct ib_cq *, int cqe, struct ib_udata *);
+int ocrdma_resize_cq(struct ib_cq *ibcq, unsigned int cqe,
+		     struct ib_udata *udata);
 int ocrdma_destroy_cq(struct ib_cq *ibcq, struct ib_udata *udata);
 
 int ocrdma_create_qp(struct ib_qp *qp, struct ib_qp_init_attr *attrs,
diff --git a/drivers/infiniband/sw/rdmavt/cq.c b/drivers/infiniband/sw/rdmavt/cq.c
index 1ae5d8c86acb..7be79274bafb 100644
--- a/drivers/infiniband/sw/rdmavt/cq.c
+++ b/drivers/infiniband/sw/rdmavt/cq.c
@@ -393,13 +393,7 @@ int rvt_req_notify_cq(struct ib_cq *ibcq, enum ib_cq_notify_flags notify_flags)
 	return ret;
 }
 
-/*
- * rvt_resize_cq - change the size of the CQ
- * @ibcq: the completion queue
- *
- * Return: 0 for success.
- */
-int rvt_resize_cq(struct ib_cq *ibcq, int cqe, struct ib_udata *udata)
+int rvt_resize_cq(struct ib_cq *ibcq, unsigned int cqe, struct ib_udata *udata)
 {
 	struct rvt_cq *cq = ibcq_to_rvtcq(ibcq);
 	u32 head, tail, n;
@@ -410,7 +404,7 @@ int rvt_resize_cq(struct ib_cq *ibcq, int cqe, struct ib_udata *udata)
 	struct rvt_cq_wc *old_u_wc = NULL;
 	__u64 offset = 0;
 
-	if (cqe < 1 || cqe > rdi->dparms.props.max_cqe)
+	if (cqe > rdi->dparms.props.max_cqe)
 		return -EINVAL;
 
 	if (udata->outlen < sizeof(__u64))
diff --git a/drivers/infiniband/sw/rdmavt/cq.h b/drivers/infiniband/sw/rdmavt/cq.h
index 14ee2705c443..3827c0e6a0fb 100644
--- a/drivers/infiniband/sw/rdmavt/cq.h
+++ b/drivers/infiniband/sw/rdmavt/cq.h
@@ -15,7 +15,7 @@ int rvt_create_user_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 		       struct uverbs_attr_bundle *attrs);
 int rvt_destroy_cq(struct ib_cq *ibcq, struct ib_udata *udata);
 int rvt_req_notify_cq(struct ib_cq *ibcq, enum ib_cq_notify_flags notify_flags);
-int rvt_resize_cq(struct ib_cq *ibcq, int cqe, struct ib_udata *udata);
+int rvt_resize_cq(struct ib_cq *ibcq, unsigned int cqe, struct ib_udata *udata);
 int rvt_poll_cq(struct ib_cq *ibcq, int num_entries, struct ib_wc *entry);
 int rvt_driver_cq_init(void);
 void rvt_cq_exit(void);
diff --git a/drivers/infiniband/sw/rxe/rxe_cq.c b/drivers/infiniband/sw/rxe/rxe_cq.c
index fffd144d509e..eaf7802a5cbe 100644
--- a/drivers/infiniband/sw/rxe/rxe_cq.c
+++ b/drivers/infiniband/sw/rxe/rxe_cq.c
@@ -8,37 +8,6 @@
 #include "rxe_loc.h"
 #include "rxe_queue.h"
 
-int rxe_cq_chk_attr(struct rxe_dev *rxe, struct rxe_cq *cq,
-		    int cqe, int comp_vector)
-{
-	int count;
-
-	if (cqe <= 0) {
-		rxe_dbg_dev(rxe, "cqe(%d) <= 0\n", cqe);
-		goto err1;
-	}
-
-	if (cqe > rxe->attr.max_cqe) {
-		rxe_dbg_dev(rxe, "cqe(%d) > max_cqe(%d)\n",
-				cqe, rxe->attr.max_cqe);
-		goto err1;
-	}
-
-	if (cq) {
-		count = queue_count(cq->queue, QUEUE_TYPE_TO_CLIENT);
-		if (cqe < count) {
-			rxe_dbg_cq(cq, "cqe(%d) < current # elements in queue (%d)\n",
-					cqe, count);
-			goto err1;
-		}
-	}
-
-	return 0;
-
-err1:
-	return -EINVAL;
-}
-
 int rxe_cq_from_init(struct rxe_dev *rxe, struct rxe_cq *cq, int cqe,
 		     int comp_vector, struct ib_udata *udata,
 		     struct rxe_create_cq_resp __user *uresp)
diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
index 7992290886e1..e095c12699cb 100644
--- a/drivers/infiniband/sw/rxe/rxe_loc.h
+++ b/drivers/infiniband/sw/rxe/rxe_loc.h
@@ -18,9 +18,6 @@ void rxe_av_fill_ip_info(struct rxe_av *av, struct rdma_ah_attr *attr);
 struct rxe_av *rxe_get_av(struct rxe_pkt_info *pkt, struct rxe_ah **ahp);
 
 /* rxe_cq.c */
-int rxe_cq_chk_attr(struct rxe_dev *rxe, struct rxe_cq *cq,
-		    int cqe, int comp_vector);
-
 int rxe_cq_from_init(struct rxe_dev *rxe, struct rxe_cq *cq, int cqe,
 		     int comp_vector, struct ib_udata *udata,
 		     struct rxe_create_cq_resp __user *uresp);
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index bc7c77ff3d90..f57b4ba22a4f 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -1139,7 +1139,8 @@ static int rxe_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 	return err;
 }
 
-static int rxe_resize_cq(struct ib_cq *ibcq, int cqe, struct ib_udata *udata)
+static int rxe_resize_cq(struct ib_cq *ibcq, unsigned int cqe,
+			 struct ib_udata *udata)
 {
 	struct rxe_cq *cq = to_rcq(ibcq);
 	struct rxe_dev *rxe = to_rdev(ibcq->device);
@@ -1150,9 +1151,9 @@ static int rxe_resize_cq(struct ib_cq *ibcq, int cqe, struct ib_udata *udata)
 		return -EINVAL;
 	uresp = udata->outbuf;
 
-	err = rxe_cq_chk_attr(rxe, cq, cqe, 0);
-	if (err)
-		return err;
+	if (cqe > rxe->attr.max_cqe ||
+	    cqe < queue_count(cq->queue, QUEUE_TYPE_TO_CLIENT))
+		return -EINVAL;
 
 	err = rxe_cq_resize_queue(cq, cqe, uresp, udata);
 	if (err)
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 94bb3cc4c67a..7d32d02c35e3 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -2534,7 +2534,7 @@ struct ib_device_ops {
 			      struct uverbs_attr_bundle *attrs);
 	int (*modify_cq)(struct ib_cq *cq, u16 cq_count, u16 cq_period);
 	int (*destroy_cq)(struct ib_cq *cq, struct ib_udata *udata);
-	int (*resize_user_cq)(struct ib_cq *cq, int cqe,
+	int (*resize_user_cq)(struct ib_cq *cq, unsigned int cqe,
 			      struct ib_udata *udata);
 	/*
 	 * pre_destroy_cq - Prevent a cq from generating any new work

-- 
2.52.0


