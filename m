Return-Path: <linux-hyperv+bounces-8817-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WOmiApcEj2lJHQEAu9opvQ
	(envelope-from <linux-hyperv+bounces-8817-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Feb 2026 12:01:43 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 24B3313556D
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Feb 2026 12:01:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 14B973032E7A
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Feb 2026 11:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E06C35770A;
	Fri, 13 Feb 2026 11:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rzcBqSz1"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB52352C2C;
	Fri, 13 Feb 2026 11:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770980407; cv=none; b=F7qIZxSvUEs+czO2g6MwOGzUtWfe2vOG9vKC6aBG/hgxQvqro0Et0XoGFR7wQ5mqsblXpxa3sPv52M6K/leC9AN+FgHErsQ+TFsWtkQVUYYbWlASPXnQFzbDqaE9OgiloGKH9DWRjUVrfyizOq+Co9e/tY7DsHDVl+HnZfUnhgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770980407; c=relaxed/simple;
	bh=4C3Qyv6Y1h2iqjB9LkmzvU5Mldz+78igtPuIUQbWB/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FUyOaQQQf/MHuE/Itcq0+31+yi+6Y/+/Ho24RQjjlW1z/QjZHjM/ynTndb4sapDHeNQMVbJnkC3SRS3Wk3phdDPeDx2S7QmCuF+By3ViZ9qj5x5YThwaXCZC7b/0sJQNVEeetKGmjOL/ovwZmszRA3XqGQHs8QjuvzfzBjEksJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rzcBqSz1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED93EC116C6;
	Fri, 13 Feb 2026 11:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770980407;
	bh=4C3Qyv6Y1h2iqjB9LkmzvU5Mldz+78igtPuIUQbWB/Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rzcBqSz17HLUPTCJr8NIiz9NprNkarmm9i6d24BpVFY0k5XV9hEF+M68lG58bQJYt
	 sWGjvl29MJXzRMfojliNhO5VL2teZYTJwXA4kILaTPwuwAHkdK8ouocdpdZvezrpB7
	 1JKZf27lpafCUvg1MKR6M357HKxB5zElwgk1dVErDSkmKGOhbbm/T9G0rZU4AREc+C
	 qp2i27WwA1mvoAMS1CxEcuI0/tuB5ddi/SGnyyNeLPCymZawa6efRq2gE06ZfwemfD
	 hZrgPf+bYwdn93kbgprDR7QEDyiLlzbKvNEs503O7VPWC6VTAewopz9IZ4E+MV4JMj
	 5dx3HJPGn+BCA==
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
Subject: [PATCH rdma-next 20/50] RDMA/qedr: Convert to modern CQ interface
Date: Fri, 13 Feb 2026 12:57:56 +0200
Message-ID: <20260213-refactor-umem-v1-20-f3be85847922@nvidia.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
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
	TAGGED_FROM(0.00)[bounces-8817-lists,linux-hyperv=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,nvidia.com:mid,nvidia.com:email]
X-Rspamd-Queue-Id: 24B3313556D
X-Rspamd-Action: no action

From: Leon Romanovsky <leonro@nvidia.com>

Allow users to supply their own umem.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/qedr/main.c  |   1 +
 drivers/infiniband/hw/qedr/verbs.c | 323 +++++++++++++++++++++----------------
 drivers/infiniband/hw/qedr/verbs.h |   2 +
 3 files changed, 188 insertions(+), 138 deletions(-)

diff --git a/drivers/infiniband/hw/qedr/main.c b/drivers/infiniband/hw/qedr/main.c
index ecdfeff3d44f..c6ca95983492 100644
--- a/drivers/infiniband/hw/qedr/main.c
+++ b/drivers/infiniband/hw/qedr/main.c
@@ -199,6 +199,7 @@ static const struct ib_device_ops qedr_dev_ops = {
 	.alloc_ucontext = qedr_alloc_ucontext,
 	.create_ah = qedr_create_ah,
 	.create_cq = qedr_create_cq,
+	.create_user_cq = qedr_create_user_cq,
 	.create_qp = qedr_create_qp,
 	.create_srq = qedr_create_srq,
 	.dealloc_pd = qedr_dealloc_pd,
diff --git a/drivers/infiniband/hw/qedr/verbs.c b/drivers/infiniband/hw/qedr/verbs.c
index cb06c5d894b8..10010ccf63b3 100644
--- a/drivers/infiniband/hw/qedr/verbs.c
+++ b/drivers/infiniband/hw/qedr/verbs.c
@@ -789,52 +789,33 @@ static int qedr_init_user_db_rec(struct ib_udata *udata,
 
 static inline int qedr_init_user_queue(struct ib_udata *udata,
 				       struct qedr_dev *dev,
-				       struct qedr_userq *q, u64 buf_addr,
-				       size_t buf_len, bool requires_db_rec,
-				       int access,
+				       struct qedr_userq *q,
+				       bool requires_db_rec,
 				       int alloc_and_init)
 {
 	u32 fw_pages;
 	int rc;
 
-	q->buf_addr = buf_addr;
-	q->buf_len = buf_len;
-	q->umem = ib_umem_get(&dev->ibdev, q->buf_addr, q->buf_len, access);
-	if (IS_ERR(q->umem)) {
-		DP_ERR(dev, "create user queue: failed ib_umem_get, got %ld\n",
-		       PTR_ERR(q->umem));
-		return PTR_ERR(q->umem);
-	}
-
 	fw_pages = ib_umem_num_dma_blocks(q->umem, 1 << FW_PAGE_SHIFT);
 	rc = qedr_prepare_pbl_tbl(dev, &q->pbl_info, fw_pages, 0);
 	if (rc)
-		goto err0;
+		return rc;
 
 	if (alloc_and_init) {
 		q->pbl_tbl = qedr_alloc_pbl_tbl(dev, &q->pbl_info, GFP_KERNEL);
-		if (IS_ERR(q->pbl_tbl)) {
-			rc = PTR_ERR(q->pbl_tbl);
-			goto err0;
-		}
+		if (IS_ERR(q->pbl_tbl))
+			return PTR_ERR(q->pbl_tbl);
+
 		qedr_populate_pbls(dev, q->umem, q->pbl_tbl, &q->pbl_info,
 				   FW_PAGE_SHIFT);
 	} else {
 		q->pbl_tbl = kzalloc(sizeof(*q->pbl_tbl), GFP_KERNEL);
-		if (!q->pbl_tbl) {
-			rc = -ENOMEM;
-			goto err0;
-		}
+		if (!q->pbl_tbl)
+			return -ENOMEM;
 	}
 
 	/* mmap the user address used to store doorbell data for recovery */
 	return qedr_init_user_db_rec(udata, dev, q, requires_db_rec);
-
-err0:
-	ib_umem_release(q->umem);
-	q->umem = NULL;
-
-	return rc;
 }
 
 static inline void qedr_init_cq_params(struct qedr_cq *cq,
@@ -899,8 +880,8 @@ int qedr_arm_cq(struct ib_cq *ibcq, enum ib_cq_notify_flags flags)
 	return 0;
 }
 
-int qedr_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
-		   struct uverbs_attr_bundle *attrs)
+int qedr_create_user_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
+			struct uverbs_attr_bundle *attrs)
 {
 	struct ib_udata *udata = &attrs->driver_udata;
 	struct ib_device *ibdev = ibcq->device;
@@ -908,6 +889,104 @@ int qedr_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 		udata, struct qedr_ucontext, ibucontext);
 	struct qed_rdma_destroy_cq_out_params destroy_oparams;
 	struct qed_rdma_destroy_cq_in_params destroy_iparams;
+	struct qedr_dev *dev = get_qedr_dev(ibdev);
+	struct qed_rdma_create_cq_in_params params;
+	struct qedr_create_cq_ureq ureq = {};
+	int vector = attr->comp_vector;
+	int entries = attr->cqe;
+	struct qedr_cq *cq = get_qedr_cq(ibcq);
+	int chain_entries;
+	u32 db_offset;
+	int page_cnt;
+	u64 pbl_ptr;
+	u16 icid;
+	int rc;
+
+	DP_DEBUG(dev, QEDR_MSG_INIT,
+		 "create_cq: called from User Lib. entries=%d, vector=%d\n",
+		 entries, vector);
+
+	if (attr->flags)
+		return -EOPNOTSUPP;
+
+	if (attr->cqe > QEDR_MAX_CQES)
+		return -EINVAL;
+
+	chain_entries = qedr_align_cq_entries(entries);
+	chain_entries = min_t(int, chain_entries, QEDR_MAX_CQES);
+
+	/* calc db offset. user will add DPI base, kernel will add db addr */
+	db_offset = DB_ADDR_SHIFT(DQ_PWM_OFFSET_UCM_RDMA_CQ_CONS_32BIT);
+
+	if (ib_copy_from_udata(&ureq, udata, min(sizeof(ureq), udata->inlen)))
+		return -EINVAL;
+
+	cq->cq_type = QEDR_CQ_TYPE_USER;
+
+	cq->q.buf_addr = ureq.addr;
+	cq->q.buf_len = ureq.len;
+	if (!ibcq->umem)
+		ibcq->umem = ib_umem_get(&dev->ibdev, ureq.addr, ureq.len,
+					 IB_ACCESS_LOCAL_WRITE);
+	if (IS_ERR(ibcq->umem))
+		return PTR_ERR(ibcq->umem);
+	cq->q.umem = ibcq->umem;
+
+	rc = qedr_init_user_queue(udata, dev, &cq->q, true, 1);
+	if (rc)
+		return rc;
+
+	pbl_ptr = cq->q.pbl_tbl->pa;
+	page_cnt = cq->q.pbl_info.num_pbes;
+
+	cq->ibcq.cqe = chain_entries;
+	cq->q.db_addr = ctx->dpi_addr + db_offset;
+
+	qedr_init_cq_params(cq, ctx, dev, vector, chain_entries, page_cnt,
+			    pbl_ptr, &params);
+
+	rc = dev->ops->rdma_create_cq(dev->rdma_ctx, &params, &icid);
+	if (rc)
+		goto err1;
+
+	cq->icid = icid;
+	cq->sig = QEDR_CQ_MAGIC_NUMBER;
+	spin_lock_init(&cq->cq_lock);
+
+	rc = qedr_copy_cq_uresp(dev, cq, udata, db_offset);
+	if (rc)
+		goto err2;
+
+	rc = qedr_db_recovery_add(dev, cq->q.db_addr,
+				  &cq->q.db_rec_data->db_data,
+				  DB_REC_WIDTH_64B,
+				  DB_REC_USER);
+	if (rc)
+		goto err2;
+
+	DP_DEBUG(dev, QEDR_MSG_CQ,
+		 "create cq: icid=0x%0x, addr=%p, size(entries)=0x%0x\n",
+		 cq->icid, cq, params.cq_size);
+
+	return 0;
+
+err2:
+	destroy_iparams.icid = cq->icid;
+	dev->ops->rdma_destroy_cq(dev->rdma_ctx, &destroy_iparams,
+				  &destroy_oparams);
+err1:
+	qedr_free_pbl(dev, &cq->q.pbl_info, cq->q.pbl_tbl);
+	if (cq->q.db_mmap_entry)
+		rdma_user_mmap_entry_remove(cq->q.db_mmap_entry);
+	return rc;
+}
+
+int qedr_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
+		   struct uverbs_attr_bundle *attrs)
+{
+	struct ib_device *ibdev = ibcq->device;
+	struct qed_rdma_destroy_cq_out_params destroy_oparams;
+	struct qed_rdma_destroy_cq_in_params destroy_iparams;
 	struct qed_chain_init_params chain_params = {
 		.mode		= QED_CHAIN_MODE_PBL,
 		.intended_use	= QED_CHAIN_USE_TO_CONSUME,
@@ -916,7 +995,6 @@ int qedr_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 	};
 	struct qedr_dev *dev = get_qedr_dev(ibdev);
 	struct qed_rdma_create_cq_in_params params;
-	struct qedr_create_cq_ureq ureq = {};
 	int vector = attr->comp_vector;
 	int entries = attr->cqe;
 	struct qedr_cq *cq = get_qedr_cq(ibcq);
@@ -928,18 +1006,14 @@ int qedr_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 	int rc;
 
 	DP_DEBUG(dev, QEDR_MSG_INIT,
-		 "create_cq: called from %s. entries=%d, vector=%d\n",
-		 udata ? "User Lib" : "Kernel", entries, vector);
+		 "create_cq: called from Kernel. entries=%d, vector=%d\n",
+		 entries, vector);
 
 	if (attr->flags)
 		return -EOPNOTSUPP;
 
-	if (entries > QEDR_MAX_CQES) {
-		DP_ERR(dev,
-		       "create cq: the number of entries %d is too high. Must be equal or below %d.\n",
-		       entries, QEDR_MAX_CQES);
+	if (attr->cqe > QEDR_MAX_CQES)
 		return -EINVAL;
-	}
 
 	chain_entries = qedr_align_cq_entries(entries);
 	chain_entries = min_t(int, chain_entries, QEDR_MAX_CQES);
@@ -948,47 +1022,18 @@ int qedr_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 	/* calc db offset. user will add DPI base, kernel will add db addr */
 	db_offset = DB_ADDR_SHIFT(DQ_PWM_OFFSET_UCM_RDMA_CQ_CONS_32BIT);
 
-	if (udata) {
-		if (ib_copy_from_udata(&ureq, udata, min(sizeof(ureq),
-							 udata->inlen))) {
-			DP_ERR(dev,
-			       "create cq: problem copying data from user space\n");
-			goto err0;
-		}
+	cq->cq_type = QEDR_CQ_TYPE_KERNEL;
 
-		if (!ureq.len) {
-			DP_ERR(dev,
-			       "create cq: cannot create a cq with 0 entries\n");
-			goto err0;
-		}
-
-		cq->cq_type = QEDR_CQ_TYPE_USER;
-
-		rc = qedr_init_user_queue(udata, dev, &cq->q, ureq.addr,
-					  ureq.len, true, IB_ACCESS_LOCAL_WRITE,
-					  1);
-		if (rc)
-			goto err0;
-
-		pbl_ptr = cq->q.pbl_tbl->pa;
-		page_cnt = cq->q.pbl_info.num_pbes;
-
-		cq->ibcq.cqe = chain_entries;
-		cq->q.db_addr = ctx->dpi_addr + db_offset;
-	} else {
-		cq->cq_type = QEDR_CQ_TYPE_KERNEL;
+	rc = dev->ops->common->chain_alloc(dev->cdev, &cq->pbl,
+					   &chain_params);
+	if (rc)
+		return rc;
 
-		rc = dev->ops->common->chain_alloc(dev->cdev, &cq->pbl,
-						   &chain_params);
-		if (rc)
-			goto err0;
+	page_cnt = qed_chain_get_page_cnt(&cq->pbl);
+	pbl_ptr = qed_chain_get_pbl_phys(&cq->pbl);
+	cq->ibcq.cqe = cq->pbl.capacity;
 
-		page_cnt = qed_chain_get_page_cnt(&cq->pbl);
-		pbl_ptr = qed_chain_get_pbl_phys(&cq->pbl);
-		cq->ibcq.cqe = cq->pbl.capacity;
-	}
-
-	qedr_init_cq_params(cq, ctx, dev, vector, chain_entries, page_cnt,
+	qedr_init_cq_params(cq, NULL, dev, vector, chain_entries, page_cnt,
 			    pbl_ptr, &params);
 
 	rc = dev->ops->rdma_create_cq(dev->rdma_ctx, &params, &icid);
@@ -999,37 +1044,23 @@ int qedr_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 	cq->sig = QEDR_CQ_MAGIC_NUMBER;
 	spin_lock_init(&cq->cq_lock);
 
-	if (udata) {
-		rc = qedr_copy_cq_uresp(dev, cq, udata, db_offset);
-		if (rc)
-			goto err2;
-
-		rc = qedr_db_recovery_add(dev, cq->q.db_addr,
-					  &cq->q.db_rec_data->db_data,
-					  DB_REC_WIDTH_64B,
-					  DB_REC_USER);
-		if (rc)
-			goto err2;
+	/* Generate doorbell address. */
+	cq->db.data.icid = cq->icid;
+	cq->db_addr = dev->db_addr + db_offset;
+	cq->db.data.params = DB_AGG_CMD_MAX <<
+	    RDMA_PWM_VAL32_DATA_AGG_CMD_SHIFT;
 
-	} else {
-		/* Generate doorbell address. */
-		cq->db.data.icid = cq->icid;
-		cq->db_addr = dev->db_addr + db_offset;
-		cq->db.data.params = DB_AGG_CMD_MAX <<
-		    RDMA_PWM_VAL32_DATA_AGG_CMD_SHIFT;
-
-		/* point to the very last element, passing it we will toggle */
-		cq->toggle_cqe = qed_chain_get_last_elem(&cq->pbl);
-		cq->pbl_toggle = RDMA_CQE_REQUESTER_TOGGLE_BIT_MASK;
-		cq->latest_cqe = NULL;
-		consume_cqe(cq);
-		cq->cq_cons = qed_chain_get_cons_idx_u32(&cq->pbl);
+	/* point to the very last element, passing it we will toggle */
+	cq->toggle_cqe = qed_chain_get_last_elem(&cq->pbl);
+	cq->pbl_toggle = RDMA_CQE_REQUESTER_TOGGLE_BIT_MASK;
+	cq->latest_cqe = NULL;
+	consume_cqe(cq);
+	cq->cq_cons = qed_chain_get_cons_idx_u32(&cq->pbl);
 
-		rc = qedr_db_recovery_add(dev, cq->db_addr, &cq->db.data,
-					  DB_REC_WIDTH_64B, DB_REC_KERNEL);
-		if (rc)
-			goto err2;
-	}
+	rc = qedr_db_recovery_add(dev, cq->db_addr, &cq->db.data,
+				  DB_REC_WIDTH_64B, DB_REC_KERNEL);
+	if (rc)
+		goto err2;
 
 	DP_DEBUG(dev, QEDR_MSG_CQ,
 		 "create cq: icid=0x%0x, addr=%p, size(entries)=0x%0x\n",
@@ -1042,16 +1073,8 @@ int qedr_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 	dev->ops->rdma_destroy_cq(dev->rdma_ctx, &destroy_iparams,
 				  &destroy_oparams);
 err1:
-	if (udata) {
-		qedr_free_pbl(dev, &cq->q.pbl_info, cq->q.pbl_tbl);
-		ib_umem_release(cq->q.umem);
-		if (cq->q.db_mmap_entry)
-			rdma_user_mmap_entry_remove(cq->q.db_mmap_entry);
-	} else {
-		dev->ops->common->chain_free(dev->cdev, &cq->pbl);
-	}
-err0:
-	return -EINVAL;
+	dev->ops->common->chain_free(dev->cdev, &cq->pbl);
+	return rc;
 }
 
 #define QEDR_DESTROY_CQ_MAX_ITERATIONS		(10)
@@ -1081,7 +1104,6 @@ int qedr_destroy_cq(struct ib_cq *ibcq, struct ib_udata *udata)
 
 	if (udata) {
 		qedr_free_pbl(dev, &cq->q.pbl_info, cq->q.pbl_tbl);
-		ib_umem_release(cq->q.umem);
 
 		if (cq->q.db_rec_data) {
 			qedr_db_recovery_del(dev, cq->q.db_addr,
@@ -1472,26 +1494,33 @@ static int qedr_init_srq_user_params(struct ib_udata *udata,
 	struct scatterlist *sg;
 	int rc;
 
-	rc = qedr_init_user_queue(udata, srq->dev, &srq->usrq, ureq->srq_addr,
-				  ureq->srq_len, false, access, 1);
+	srq->usrq.buf_addr = ureq->srq_addr;
+	srq->usrq.buf_len = ureq->srq_len;
+	srq->usrq.umem = ib_umem_get(&srq->dev->ibdev, ureq->srq_addr,
+				     ureq->srq_len, access);
+	if (IS_ERR(srq->usrq.umem))
+		return PTR_ERR(srq->usrq.umem);
+
+	rc = qedr_init_user_queue(udata, srq->dev, &srq->usrq, false, 1);
 	if (rc)
-		return rc;
+		goto err_umem;
 
 	srq->prod_umem = ib_umem_get(srq->ibsrq.device, ureq->prod_pair_addr,
 				     sizeof(struct rdma_srq_producers), access);
 	if (IS_ERR(srq->prod_umem)) {
+		rc = PTR_ERR(srq->prod_umem);
 		qedr_free_pbl(srq->dev, &srq->usrq.pbl_info, srq->usrq.pbl_tbl);
-		ib_umem_release(srq->usrq.umem);
-		DP_ERR(srq->dev,
-		       "create srq: failed ib_umem_get for producer, got %ld\n",
-		       PTR_ERR(srq->prod_umem));
-		return PTR_ERR(srq->prod_umem);
+		goto err_umem;
 	}
 
 	sg = srq->prod_umem->sgt_append.sgt.sgl;
 	srq->hw_srq.phy_prod_pair_addr = sg_dma_address(sg);
 
 	return 0;
+
+err_umem:
+	ib_umem_release(srq->usrq.umem);
+	return rc;
 }
 
 static int qedr_alloc_srq_kernel_params(struct qedr_srq *srq,
@@ -1870,27 +1899,34 @@ static int qedr_create_user_qp(struct qedr_dev *dev,
 
 	if (qedr_qp_has_sq(qp)) {
 		/* SQ - read access only (0) */
-		rc = qedr_init_user_queue(udata, dev, &qp->usq, ureq.sq_addr,
-					  ureq.sq_len, true, 0, alloc_and_init);
+		qp->usq.buf_addr = ureq.sq_addr;
+		qp->usq.buf_len = ureq.sq_len;
+		qp->usq.umem = ib_umem_get(&dev->ibdev, ureq.sq_addr,
+					   ureq.sq_len, 0);
+		if (IS_ERR(qp->usq.umem))
+			return PTR_ERR(qp->usq.umem);
+
+		rc = qedr_init_user_queue(udata, dev, &qp->usq, true,
+					  alloc_and_init);
 		if (rc)
-			return rc;
+			goto err_sq_umem;
 	}
 
 	if (qedr_qp_has_rq(qp)) {
 		/* RQ - read access only (0) */
-		rc = qedr_init_user_queue(udata, dev, &qp->urq, ureq.rq_addr,
-					  ureq.rq_len, true, 0, alloc_and_init);
-		if (rc) {
-			ib_umem_release(qp->usq.umem);
-			qp->usq.umem = NULL;
-			if (rdma_protocol_roce(&dev->ibdev, 1)) {
-				qedr_free_pbl(dev, &qp->usq.pbl_info,
-					      qp->usq.pbl_tbl);
-			} else {
-				kfree(qp->usq.pbl_tbl);
-			}
-			return rc;
+		qp->urq.buf_addr = ureq.rq_addr;
+		qp->urq.buf_len = ureq.rq_len;
+		qp->urq.umem = ib_umem_get(&dev->ibdev, ureq.rq_addr,
+					   ureq.rq_len, 0);
+		if (IS_ERR(qp->urq.umem)) {
+			rc = PTR_ERR(qp->urq.umem);
+			goto err_rq_umem;
 		}
+
+		rc = qedr_init_user_queue(udata, dev, &qp->urq, true,
+					  alloc_and_init);
+		if (rc)
+			goto err_rq_umem2;
 	}
 
 	memset(&in_params, 0, sizeof(in_params));
@@ -1989,6 +2025,17 @@ static int qedr_create_user_qp(struct qedr_dev *dev,
 err1:
 	qedr_cleanup_user(dev, ctx, qp);
 	return rc;
+
+err_rq_umem2:
+	ib_umem_release(qp->urq.umem);
+err_rq_umem:
+	if (rdma_protocol_roce(&dev->ibdev, 1))
+		qedr_free_pbl(dev, &qp->usq.pbl_info, qp->usq.pbl_tbl);
+	else
+		kfree(qp->usq.pbl_tbl);
+err_sq_umem:
+	ib_umem_release(qp->usq.umem);
+	return rc;
 }
 
 static int qedr_set_iwarp_db_info(struct qedr_dev *dev, struct qedr_qp *qp)
diff --git a/drivers/infiniband/hw/qedr/verbs.h b/drivers/infiniband/hw/qedr/verbs.h
index 62420a15101b..292d77df562d 100644
--- a/drivers/infiniband/hw/qedr/verbs.h
+++ b/drivers/infiniband/hw/qedr/verbs.h
@@ -53,6 +53,8 @@ int qedr_alloc_xrcd(struct ib_xrcd *ibxrcd, struct ib_udata *udata);
 int qedr_dealloc_xrcd(struct ib_xrcd *ibxrcd, struct ib_udata *udata);
 int qedr_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 		   struct uverbs_attr_bundle *attrs);
+int qedr_create_user_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
+			struct uverbs_attr_bundle *attrs);
 int qedr_destroy_cq(struct ib_cq *ibcq, struct ib_udata *udata);
 int qedr_arm_cq(struct ib_cq *ibcq, enum ib_cq_notify_flags flags);
 int qedr_create_qp(struct ib_qp *qp, struct ib_qp_init_attr *attrs,

-- 
2.52.0


