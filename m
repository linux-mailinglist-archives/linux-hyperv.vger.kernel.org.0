Return-Path: <linux-hyperv+bounces-8813-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sI9wGOsEj2ltHQEAu9opvQ
	(envelope-from <linux-hyperv+bounces-8813-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Feb 2026 12:03:07 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D65461355F8
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Feb 2026 12:03:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4339330AA529
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Feb 2026 10:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8135B3563C7;
	Fri, 13 Feb 2026 10:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EXoNAZfl"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA193542C3;
	Fri, 13 Feb 2026 10:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770980392; cv=none; b=hiD7RzV6Bi9LRSXy6RUFnRBnj4nYaXVv7CQekrpkFpelcIR8oK/DB+fDebs6b9YXfIS4/Hx6HQfSGyl9LO4YCkc/c6DuoTIeDqQdUQWBWoowhdqYlXEBpooQYwUJmLr7jOQHPABUD8TapJAvrns9VSV9YFTzcridDdgmcG02/to=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770980392; c=relaxed/simple;
	bh=ZborabYXJjoUYEGPeI/iufICv6OuWGf8T6x7aVLTvRw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sWrhUV+OodYHz8OQrY2tqIBTY8ZIFZJCFUD/13HZhNVdi6JsWTIXLUZ5BdKG2Y5evX4g1SHsUG/jdOWn2sO1cmipQJLFAjrSGqr0BYQbbbIFfJDw09K8qnM77l0Tv0OePVR6ltmZOtJUWQwa3qMJ+SGxIylCZoLkKwNmwqioxTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EXoNAZfl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F307C116C6;
	Fri, 13 Feb 2026 10:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770980392;
	bh=ZborabYXJjoUYEGPeI/iufICv6OuWGf8T6x7aVLTvRw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EXoNAZfl47tvar57MNO96L49geh3mELr/AR1xtxBTN4faHv84M3uHCXipxcfEvG/0
	 CdFyJtywtaGyzS3Jc5VZAr22CHfA14KRmkyWyGY+bKmdHcFGwl/DruIyORxUcG1KJr
	 UroayRN9ypjZ/62ww8NPzcFRSDadeKpOIRhLEyVWDX4eMc1VC+asGipiTR0acuRcIz
	 Hza/znWMTnxEM8yynVzBmzVbT3t6/jwg1BrdByZPBnfbjDiiuGARx2hpVD7CgE65/Q
	 0a/SAW+D7X5T6shUxZpgBU/AC8JtzyC2L7/hlhLlY38P1JRnk1XY1mjTSpORpk26rg
	 7AcByv5nDRzVg==
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
Subject: [PATCH rdma-next 15/50] RDMA/bnxt_re: Convert to modern CQ interface
Date: Fri, 13 Feb 2026 12:57:51 +0200
Message-ID: <20260213-refactor-umem-v1-15-f3be85847922@nvidia.com>
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
	TAGGED_FROM(0.00)[bounces-8813-lists,linux-hyperv=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D65461355F8
X-Rspamd-Action: no action

From: Leon Romanovsky <leonro@nvidia.com>

Allow users to supply their own umem.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/bnxt_re/ib_verbs.c | 172 ++++++++++++++++++++-----------
 drivers/infiniband/hw/bnxt_re/ib_verbs.h |   4 +-
 drivers/infiniband/hw/bnxt_re/main.c     |   1 +
 3 files changed, 113 insertions(+), 64 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index c146f43ae875..b8516d8b8426 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -3134,22 +3134,20 @@ int bnxt_re_destroy_cq(struct ib_cq *ib_cq, struct ib_udata *udata)
 	nq = cq->qplib_cq.nq;
 	cctx = rdev->chip_ctx;
 
-	if (cctx->modes.toggle_bits & BNXT_QPLIB_CQ_TOGGLE_BIT) {
-		free_page((unsigned long)cq->uctx_cq_page);
+	free_page((unsigned long)cq->uctx_cq_page);
+	if (cctx->modes.toggle_bits & BNXT_QPLIB_CQ_TOGGLE_BIT)
 		hash_del(&cq->hash_entry);
-	}
-	bnxt_qplib_destroy_cq(&rdev->qplib_res, &cq->qplib_cq);
 
+	bnxt_qplib_destroy_cq(&rdev->qplib_res, &cq->qplib_cq);
 	bnxt_re_put_nq(rdev, nq);
-	ib_umem_release(cq->umem);
-
 	atomic_dec(&rdev->stats.res.cq_count);
 	kfree(cq->cql);
 	return 0;
 }
 
-int bnxt_re_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
-		      struct uverbs_attr_bundle *attrs)
+int bnxt_re_create_user_cq(struct ib_cq *ibcq,
+			   const struct ib_cq_init_attr *attr,
+			   struct uverbs_attr_bundle *attrs)
 {
 	struct bnxt_re_cq *cq = container_of(ibcq, struct bnxt_re_cq, ib_cq);
 	struct bnxt_re_dev *rdev = to_bnxt_re_dev(ibcq->device, ibdev);
@@ -3158,6 +3156,8 @@ int bnxt_re_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 		rdma_udata_to_drv_context(udata, struct bnxt_re_ucontext, ib_uctx);
 	struct bnxt_qplib_dev_attr *dev_attr = rdev->dev_attr;
 	struct bnxt_qplib_chip_ctx *cctx;
+	struct bnxt_re_cq_resp resp = {};
+	struct bnxt_re_cq_req req;
 	int cqe = attr->cqe;
 	int rc, entries;
 	u32 active_cqs;
@@ -3166,7 +3166,7 @@ int bnxt_re_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 		return -EOPNOTSUPP;
 
 	/* Validate CQ fields */
-	if (cqe < 1 || cqe > dev_attr->max_cq_wqes) {
+	if (attr->cqe > dev_attr->max_cq_wqes) {
 		ibdev_err(&rdev->ibdev, "Failed to create CQ -max exceeded");
 		return -EINVAL;
 	}
@@ -3181,33 +3181,107 @@ int bnxt_re_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 
 	cq->qplib_cq.sg_info.pgsize = PAGE_SIZE;
 	cq->qplib_cq.sg_info.pgshft = PAGE_SHIFT;
-	if (udata) {
-		struct bnxt_re_cq_req req;
-		if (ib_copy_from_udata(&req, udata, sizeof(req))) {
-			rc = -EFAULT;
-			goto fail;
-		}
 
-		cq->umem = ib_umem_get(&rdev->ibdev, req.cq_va,
-				       entries * sizeof(struct cq_base),
-				       IB_ACCESS_LOCAL_WRITE);
-		if (IS_ERR(cq->umem)) {
-			rc = PTR_ERR(cq->umem);
-			goto fail;
-		}
-		cq->qplib_cq.sg_info.umem = cq->umem;
-		cq->qplib_cq.dpi = &uctx->dpi;
-	} else {
-		cq->max_cql = min_t(u32, entries, MAX_CQL_PER_POLL);
-		cq->cql = kcalloc(cq->max_cql, sizeof(struct bnxt_qplib_cqe),
-				  GFP_KERNEL);
-		if (!cq->cql) {
+	if (ib_copy_from_udata(&req, udata, sizeof(req)))
+		return -EFAULT;
+
+	if (!ibcq->umem)
+		ibcq->umem = ib_umem_get(&rdev->ibdev, req.cq_va,
+					 entries * sizeof(struct cq_base),
+					 IB_ACCESS_LOCAL_WRITE);
+	if (IS_ERR(ibcq->umem))
+		return PTR_ERR(ibcq->umem);
+
+	cq->qplib_cq.sg_info.umem = cq->ib_cq.umem;
+	cq->qplib_cq.dpi = &uctx->dpi;
+
+	cq->qplib_cq.max_wqe = entries;
+	cq->qplib_cq.coalescing = &rdev->cq_coalescing;
+	cq->qplib_cq.nq = bnxt_re_get_nq(rdev);
+	cq->qplib_cq.cnq_hw_ring_id = cq->qplib_cq.nq->ring_id;
+
+	rc = bnxt_qplib_create_cq(&rdev->qplib_res, &cq->qplib_cq);
+	if (rc)
+		goto create_cq;
+
+	cq->ib_cq.cqe = entries;
+	cq->cq_period = cq->qplib_cq.period;
+
+	active_cqs = atomic_inc_return(&rdev->stats.res.cq_count);
+	if (active_cqs > rdev->stats.res.cq_watermark)
+		rdev->stats.res.cq_watermark = active_cqs;
+	spin_lock_init(&cq->cq_lock);
+
+	if (cctx->modes.toggle_bits & BNXT_QPLIB_CQ_TOGGLE_BIT) {
+		/* Allocate a page */
+		cq->uctx_cq_page = (void *)get_zeroed_page(GFP_KERNEL);
+		if (!cq->uctx_cq_page) {
 			rc = -ENOMEM;
-			goto fail;
+			goto c2fail;
 		}
+		hash_add(rdev->cq_hash, &cq->hash_entry, cq->qplib_cq.id);
+		resp.comp_mask |= BNXT_RE_CQ_TOGGLE_PAGE_SUPPORT;
+	}
+	resp.cqid = cq->qplib_cq.id;
+	resp.tail = cq->qplib_cq.hwq.cons;
+	resp.phase = cq->qplib_cq.period;
+	rc = ib_copy_to_udata(udata, &resp, min(sizeof(resp), udata->outlen));
+	if (rc) {
+		ibdev_err(&rdev->ibdev, "Failed to copy CQ udata");
+		goto free_mem;
+	}
 
-		cq->qplib_cq.dpi = &rdev->dpi_privileged;
+	return 0;
+
+free_mem:
+	if (cctx->modes.toggle_bits & BNXT_QPLIB_CQ_TOGGLE_BIT)
+		hash_del(&cq->hash_entry);
+	free_page((unsigned long)cq->uctx_cq_page);
+c2fail:
+	atomic_dec(&rdev->stats.res.cq_count);
+	bnxt_qplib_destroy_cq(&rdev->qplib_res, &cq->qplib_cq);
+	/* UMEM is released by ib_core */
+create_cq:
+	bnxt_re_put_nq(rdev, cq->qplib_cq.nq);
+	return rc;
+}
+
+int bnxt_re_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
+		      struct uverbs_attr_bundle *attrs)
+{
+	struct bnxt_re_cq *cq = container_of(ibcq, struct bnxt_re_cq, ib_cq);
+	struct bnxt_re_dev *rdev = to_bnxt_re_dev(ibcq->device, ibdev);
+	struct bnxt_qplib_dev_attr *dev_attr = rdev->dev_attr;
+	int cqe = attr->cqe;
+	int rc, entries;
+	u32 active_cqs;
+
+	if (attr->flags)
+		return -EOPNOTSUPP;
+
+	/* Validate CQ fields */
+	if (attr->cqe > dev_attr->max_cq_wqes) {
+		ibdev_err(&rdev->ibdev, "Failed to create CQ -max exceeded");
+		return -EINVAL;
 	}
+
+	cq->rdev = rdev;
+	cq->qplib_cq.cq_handle = (u64)(unsigned long)(&cq->qplib_cq);
+
+	entries = bnxt_re_init_depth(cqe + 1, NULL);
+	if (entries > dev_attr->max_cq_wqes + 1)
+		entries = dev_attr->max_cq_wqes + 1;
+
+	cq->qplib_cq.sg_info.pgsize = PAGE_SIZE;
+	cq->qplib_cq.sg_info.pgshft = PAGE_SHIFT;
+
+	cq->max_cql = min_t(u32, entries, MAX_CQL_PER_POLL);
+	cq->cql = kcalloc(cq->max_cql, sizeof(struct bnxt_qplib_cqe),
+			  GFP_KERNEL);
+	if (!cq->cql)
+		return -ENOMEM;
+
+	cq->qplib_cq.dpi = &rdev->dpi_privileged;
 	cq->qplib_cq.max_wqe = entries;
 	cq->qplib_cq.coalescing = &rdev->cq_coalescing;
 	cq->qplib_cq.nq = bnxt_re_get_nq(rdev);
@@ -3227,38 +3301,10 @@ int bnxt_re_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 		rdev->stats.res.cq_watermark = active_cqs;
 	spin_lock_init(&cq->cq_lock);
 
-	if (udata) {
-		struct bnxt_re_cq_resp resp = {};
-
-		if (cctx->modes.toggle_bits & BNXT_QPLIB_CQ_TOGGLE_BIT) {
-			hash_add(rdev->cq_hash, &cq->hash_entry, cq->qplib_cq.id);
-			/* Allocate a page */
-			cq->uctx_cq_page = (void *)get_zeroed_page(GFP_KERNEL);
-			if (!cq->uctx_cq_page) {
-				rc = -ENOMEM;
-				goto c2fail;
-			}
-			resp.comp_mask |= BNXT_RE_CQ_TOGGLE_PAGE_SUPPORT;
-		}
-		resp.cqid = cq->qplib_cq.id;
-		resp.tail = cq->qplib_cq.hwq.cons;
-		resp.phase = cq->qplib_cq.period;
-		resp.rsvd = 0;
-		rc = ib_copy_to_udata(udata, &resp, min(sizeof(resp), udata->outlen));
-		if (rc) {
-			ibdev_err(&rdev->ibdev, "Failed to copy CQ udata");
-			bnxt_qplib_destroy_cq(&rdev->qplib_res, &cq->qplib_cq);
-			goto free_mem;
-		}
-	}
-
 	return 0;
 
-free_mem:
-	free_page((unsigned long)cq->uctx_cq_page);
-c2fail:
-	ib_umem_release(cq->umem);
 fail:
+	bnxt_re_put_nq(rdev, cq->qplib_cq.nq);
 	kfree(cq->cql);
 	return rc;
 }
@@ -3271,8 +3317,8 @@ static void bnxt_re_resize_cq_complete(struct bnxt_re_cq *cq)
 
 	cq->qplib_cq.max_wqe = cq->resize_cqe;
 	if (cq->resize_umem) {
-		ib_umem_release(cq->umem);
-		cq->umem = cq->resize_umem;
+		ib_umem_release(cq->ib_cq.umem);
+		cq->ib_cq.umem = cq->resize_umem;
 		cq->resize_umem = NULL;
 		cq->resize_cqe = 0;
 	}
@@ -3872,7 +3918,7 @@ int bnxt_re_poll_cq(struct ib_cq *ib_cq, int num_entries, struct ib_wc *wc)
 	/* User CQ; the only processing we do is to
 	 * complete any pending CQ resize operation.
 	 */
-	if (cq->umem) {
+	if (cq->ib_cq.umem) {
 		if (cq->resize_umem)
 			bnxt_re_resize_cq_complete(cq);
 		return 0;
diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.h b/drivers/infiniband/hw/bnxt_re/ib_verbs.h
index 76ba9ab04d5c..cac3e10b73f6 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.h
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.h
@@ -108,7 +108,6 @@ struct bnxt_re_cq {
 	struct bnxt_qplib_cqe	*cql;
 #define MAX_CQL_PER_POLL	1024
 	u32			max_cql;
-	struct ib_umem		*umem;
 	struct ib_umem		*resize_umem;
 	int			resize_cqe;
 	void			*uctx_cq_page;
@@ -247,6 +246,9 @@ int bnxt_re_post_recv(struct ib_qp *qp, const struct ib_recv_wr *recv_wr,
 		      const struct ib_recv_wr **bad_recv_wr);
 int bnxt_re_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 		      struct uverbs_attr_bundle *attrs);
+int bnxt_re_create_user_cq(struct ib_cq *ibcq,
+			   const struct ib_cq_init_attr *attr,
+			   struct uverbs_attr_bundle *attrs);
 int bnxt_re_resize_cq(struct ib_cq *ibcq, int cqe, struct ib_udata *udata);
 int bnxt_re_destroy_cq(struct ib_cq *cq, struct ib_udata *udata);
 int bnxt_re_poll_cq(struct ib_cq *cq, int num_entries, struct ib_wc *wc);
diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index 73003ad25ee8..368c1fd8172e 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -1334,6 +1334,7 @@ static const struct ib_device_ops bnxt_re_dev_ops = {
 	.alloc_ucontext = bnxt_re_alloc_ucontext,
 	.create_ah = bnxt_re_create_ah,
 	.create_cq = bnxt_re_create_cq,
+	.create_user_cq = bnxt_re_create_user_cq,
 	.create_qp = bnxt_re_create_qp,
 	.create_srq = bnxt_re_create_srq,
 	.create_user_ah = bnxt_re_create_ah,

-- 
2.52.0


