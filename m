Return-Path: <linux-hyperv+bounces-8820-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UvBcJ8QFj2l5HQEAu9opvQ
	(envelope-from <linux-hyperv+bounces-8820-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Feb 2026 12:06:44 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 001EE135717
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Feb 2026 12:06:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1A0BE31EDCF2
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Feb 2026 11:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59DFA35A934;
	Fri, 13 Feb 2026 11:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fMLKpf/7"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362DA35A92E;
	Fri, 13 Feb 2026 11:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770980419; cv=none; b=OjpBJ3oTVbGJd5Zg7XA+Qa7qzmeZVkXm+bPQBukhVsX3Cc2LmTcKsgYXJBePWGdz/hcwyUfMfUA2eEYKxHKOyHEg8vFqRtD3RN6kV/VROS81IjpU6yuCl7q07mH/WM2Q51JIgNve+TgV3gqlpXufTnS/7Tpk1ZMvA6XnY0ansjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770980419; c=relaxed/simple;
	bh=wEJW/ElIiQ34G6JWKBLls/fM/jLLfH5WfW9UCF7m7dI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RfePdnDB5T2sIqf/Cv9aq1N3zfp93zyW1E5sJ4cUCG+Qu7l6d/QqT48iJ8daJA0wXWVwWOwvBl9E/uCHQ41g8TgqKXABdKHcaJ1q8GLbMOTMGyKYzdaObVQ26Bknp1fCkKgjx7T3Czi4ZvhLCecBnTFemE1xZbRPfqxMFnEi8Uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fMLKpf/7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 593EBC19423;
	Fri, 13 Feb 2026 11:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770980419;
	bh=wEJW/ElIiQ34G6JWKBLls/fM/jLLfH5WfW9UCF7m7dI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fMLKpf/7/DGGNTwjtT84VCiRUmzrundAgAKbLg3252wShyh+g9Z5RXK+TznVf0z8Q
	 f8FpqPC7svm1cGb/YHie37HkLtQpO9V5n6IvXJQ4VI4aew7iju07gFxqSIOtn4/LYK
	 /GSKzpKsTxNVoLIJr9gySv6MHZg5qAwLkYsDVhew98XJeNt7QQtxT3QGCXTKkhyq1f
	 rwsaUS6fD+4Dgf9KFUYr4NqnXeZ0Xy9UWbMoEVvkDuTCUP6M3wIapfSR5y0pBLOtUX
	 Jqb6Lmb6zE8ot6+treUWSO0PstkwWTG9ijxDDh3B+1GFrNu9ttt6KOwyIJ3tFdCkBD
	 eJ8z2CR+HKXPA==
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
Subject: [PATCH rdma-next 23/50] RDMA/irdma: Split user and kernel CQ creation paths
Date: Fri, 13 Feb 2026 12:57:59 +0200
Message-ID: <20260213-refactor-umem-v1-23-f3be85847922@nvidia.com>
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
	TAGGED_FROM(0.00)[bounces-8820-lists,linux-hyperv=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[info.dev:url,nvidia.com:mid,nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 001EE135717
X-Rspamd-Action: no action

From: Leon Romanovsky <leonro@nvidia.com>

Separate the CQ creation logic into distinct kernel and user flows.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/irdma/verbs.c | 310 +++++++++++++++++++++++-------------
 1 file changed, 195 insertions(+), 115 deletions(-)

diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
index cf8d19150574..f2b3cfe125af 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -2461,15 +2461,9 @@ static inline int cq_validate_flags(u32 flags, u8 hw_rev)
 	return flags & ~IB_UVERBS_CQ_FLAGS_TIMESTAMP_COMPLETION ? -EOPNOTSUPP : 0;
 }
 
-/**
- * irdma_create_cq - create cq
- * @ibcq: CQ allocated
- * @attr: attributes for cq
- * @attrs: uverbs attribute bundle
- */
-static int irdma_create_cq(struct ib_cq *ibcq,
-			   const struct ib_cq_init_attr *attr,
-			   struct uverbs_attr_bundle *attrs)
+static int irdma_create_user_cq(struct ib_cq *ibcq,
+				const struct ib_cq_init_attr *attr,
+				struct uverbs_attr_bundle *attrs)
 {
 #define IRDMA_CREATE_CQ_MIN_REQ_LEN offsetofend(struct irdma_create_cq_req, user_cq_buf)
 #define IRDMA_CREATE_CQ_MIN_RESP_LEN offsetofend(struct irdma_create_cq_resp, cq_size)
@@ -2489,14 +2483,22 @@ static int irdma_create_cq(struct ib_cq *ibcq,
 	int err_code;
 	int entries = attr->cqe;
 	bool cqe_64byte_ena;
-	u8 cqe_size;
+	struct irdma_ucontext *ucontext;
+	struct irdma_create_cq_req req = {};
+	struct irdma_cq_mr *cqmr;
+	struct irdma_pbl *iwpbl;
+	struct irdma_pbl *iwpbl_shadow;
+	struct irdma_cq_mr *cqmr_shadow;
+
+	if (ibcq->umem)
+		return -EOPNOTSUPP;
 
 	err_code = cq_validate_flags(attr->flags, dev->hw_attrs.uk_attrs.hw_rev);
 	if (err_code)
 		return err_code;
 
-	if (udata && (udata->inlen < IRDMA_CREATE_CQ_MIN_REQ_LEN ||
-		      udata->outlen < IRDMA_CREATE_CQ_MIN_RESP_LEN))
+	if (udata->inlen < IRDMA_CREATE_CQ_MIN_REQ_LEN ||
+	    udata->outlen < IRDMA_CREATE_CQ_MIN_RESP_LEN)
 		return -EINVAL;
 
 	err_code = irdma_alloc_rsrc(rf, rf->allocated_cqs, rf->max_cq, &cq_num,
@@ -2516,7 +2518,6 @@ static int irdma_create_cq(struct ib_cq *ibcq,
 	ukinfo->cq_id = cq_num;
 	cqe_64byte_ena = dev->hw_attrs.uk_attrs.feature_flags & IRDMA_FEATURE_64_BYTE_CQE ?
 			 true : false;
-	cqe_size = cqe_64byte_ena ? 64 : 32;
 	ukinfo->avoid_mem_cflct = cqe_64byte_ena;
 	iwcq->ibcq.cqe = info.cq_uk_init_info.cq_size;
 	if (attr->comp_vector < rf->ceqs_count)
@@ -2526,110 +2527,203 @@ static int irdma_create_cq(struct ib_cq *ibcq,
 	info.type = IRDMA_CQ_TYPE_IWARP;
 	info.vsi = &iwdev->vsi;
 
-	if (udata) {
-		struct irdma_ucontext *ucontext;
-		struct irdma_create_cq_req req = {};
-		struct irdma_cq_mr *cqmr;
-		struct irdma_pbl *iwpbl;
-		struct irdma_pbl *iwpbl_shadow;
-		struct irdma_cq_mr *cqmr_shadow;
-
-		iwcq->user_mode = true;
-		ucontext =
-			rdma_udata_to_drv_context(udata, struct irdma_ucontext,
-						  ibucontext);
-		if (ib_copy_from_udata(&req, udata,
-				       min(sizeof(req), udata->inlen))) {
-			err_code = -EFAULT;
-			goto cq_free_rsrc;
-		}
+	iwcq->user_mode = true;
+	ucontext =
+		rdma_udata_to_drv_context(udata, struct irdma_ucontext,
+					  ibucontext);
+	if (ib_copy_from_udata(&req, udata,
+			       min(sizeof(req), udata->inlen))) {
+		err_code = -EFAULT;
+		goto cq_free_rsrc;
+	}
 
+	spin_lock_irqsave(&ucontext->cq_reg_mem_list_lock, flags);
+	iwpbl = irdma_get_pbl((unsigned long)req.user_cq_buf,
+			      &ucontext->cq_reg_mem_list);
+	spin_unlock_irqrestore(&ucontext->cq_reg_mem_list_lock, flags);
+	if (!iwpbl) {
+		err_code = -EPROTO;
+		goto cq_free_rsrc;
+	}
+
+	cqmr = &iwpbl->cq_mr;
+
+	if (rf->sc_dev.hw_attrs.uk_attrs.feature_flags &
+	    IRDMA_FEATURE_CQ_RESIZE && !ucontext->legacy_mode) {
 		spin_lock_irqsave(&ucontext->cq_reg_mem_list_lock, flags);
-		iwpbl = irdma_get_pbl((unsigned long)req.user_cq_buf,
-				      &ucontext->cq_reg_mem_list);
+		iwpbl_shadow = irdma_get_pbl(
+				(unsigned long)req.user_shadow_area,
+				&ucontext->cq_reg_mem_list);
 		spin_unlock_irqrestore(&ucontext->cq_reg_mem_list_lock, flags);
-		if (!iwpbl) {
+
+		if (!iwpbl_shadow) {
 			err_code = -EPROTO;
 			goto cq_free_rsrc;
 		}
+		cqmr_shadow = &iwpbl_shadow->cq_mr;
+		info.shadow_area_pa = cqmr_shadow->cq_pbl.addr;
+		cqmr->split = true;
+	} else {
+		info.shadow_area_pa = cqmr->shadow;
+	}
+	if (iwpbl->pbl_allocated) {
+		info.virtual_map = true;
+		info.pbl_chunk_size = 1;
+		info.first_pm_pbl_idx = cqmr->cq_pbl.idx;
+	} else {
+		info.cq_base_pa = cqmr->cq_pbl.addr;
+	}
 
-		cqmr = &iwpbl->cq_mr;
+	info.shadow_read_threshold = min(info.cq_uk_init_info.cq_size / 2,
+					 (u32)IRDMA_MAX_CQ_READ_THRESH);
 
-		if (rf->sc_dev.hw_attrs.uk_attrs.feature_flags &
-		    IRDMA_FEATURE_CQ_RESIZE && !ucontext->legacy_mode) {
-			spin_lock_irqsave(&ucontext->cq_reg_mem_list_lock, flags);
-			iwpbl_shadow = irdma_get_pbl(
-					(unsigned long)req.user_shadow_area,
-					&ucontext->cq_reg_mem_list);
-			spin_unlock_irqrestore(&ucontext->cq_reg_mem_list_lock, flags);
+	if (irdma_sc_cq_init(cq, &info)) {
+		ibdev_dbg(&iwdev->ibdev, "VERBS: init cq fail\n");
+		err_code = -EPROTO;
+		goto cq_free_rsrc;
+	}
 
-			if (!iwpbl_shadow) {
-				err_code = -EPROTO;
-				goto cq_free_rsrc;
-			}
-			cqmr_shadow = &iwpbl_shadow->cq_mr;
-			info.shadow_area_pa = cqmr_shadow->cq_pbl.addr;
-			cqmr->split = true;
-		} else {
-			info.shadow_area_pa = cqmr->shadow;
-		}
-		if (iwpbl->pbl_allocated) {
-			info.virtual_map = true;
-			info.pbl_chunk_size = 1;
-			info.first_pm_pbl_idx = cqmr->cq_pbl.idx;
-		} else {
-			info.cq_base_pa = cqmr->cq_pbl.addr;
-		}
-	} else {
-		/* Kmode allocations */
-		int rsize;
+	cqp_request = irdma_alloc_and_get_cqp_request(&rf->cqp, true);
+	if (!cqp_request) {
+		err_code = -ENOMEM;
+		goto cq_free_rsrc;
+	}
 
-		if (entries < 1 || entries > rf->max_cqe) {
-			err_code = -EINVAL;
-			goto cq_free_rsrc;
-		}
+	cqp_info = &cqp_request->info;
+	cqp_info->cqp_cmd = IRDMA_OP_CQ_CREATE;
+	cqp_info->post_sq = 1;
+	cqp_info->in.u.cq_create.cq = cq;
+	cqp_info->in.u.cq_create.check_overflow = true;
+	cqp_info->in.u.cq_create.scratch = (uintptr_t)cqp_request;
+	err_code = irdma_handle_cqp_op(rf, cqp_request);
+	irdma_put_cqp_request(&rf->cqp, cqp_request);
+	if (err_code)
+		goto cq_free_rsrc;
 
-		entries += 2;
-		if (!cqe_64byte_ena && dev->hw_attrs.uk_attrs.hw_rev >= IRDMA_GEN_2)
-			entries *= 2;
+	struct irdma_create_cq_resp resp = {};
 
-		if (entries & 1)
-			entries += 1; /* cq size must be an even number */
+	resp.cq_id = info.cq_uk_init_info.cq_id;
+	resp.cq_size = info.cq_uk_init_info.cq_size;
+	if (ib_copy_to_udata(udata, &resp,
+			     min(sizeof(resp), udata->outlen))) {
+		ibdev_dbg(&iwdev->ibdev,
+			  "VERBS: copy to user data\n");
+		err_code = -EPROTO;
+		goto cq_destroy;
+	}
 
-		if (entries * cqe_size == IRDMA_HW_PAGE_SIZE)
-			entries += 2;
+	init_completion(&iwcq->free_cq);
 
-		ukinfo->cq_size = entries;
+	/* Populate table entry after CQ is fully created. */
+	smp_store_release(&rf->cq_table[cq_num], iwcq);
 
-		if (cqe_64byte_ena)
-			rsize = info.cq_uk_init_info.cq_size * sizeof(struct irdma_extended_cqe);
-		else
-			rsize = info.cq_uk_init_info.cq_size * sizeof(struct irdma_cqe);
-		iwcq->kmem.size = ALIGN(round_up(rsize, 256), 256);
-		iwcq->kmem.va = dma_alloc_coherent(dev->hw->device,
-						   iwcq->kmem.size,
-						   &iwcq->kmem.pa, GFP_KERNEL);
-		if (!iwcq->kmem.va) {
-			err_code = -ENOMEM;
-			goto cq_free_rsrc;
-		}
+	return 0;
+cq_destroy:
+	irdma_cq_wq_destroy(rf, cq);
+cq_free_rsrc:
+	irdma_cq_free_rsrc(rf, iwcq);
 
-		iwcq->kmem_shadow.size = ALIGN(IRDMA_SHADOW_AREA_SIZE << 3,
-					       64);
-		iwcq->kmem_shadow.va = dma_alloc_coherent(dev->hw->device,
-							  iwcq->kmem_shadow.size,
-							  &iwcq->kmem_shadow.pa,
-							  GFP_KERNEL);
-		if (!iwcq->kmem_shadow.va) {
-			err_code = -ENOMEM;
-			goto cq_free_rsrc;
-		}
-		info.shadow_area_pa = iwcq->kmem_shadow.pa;
-		ukinfo->shadow_area = iwcq->kmem_shadow.va;
-		ukinfo->cq_base = iwcq->kmem.va;
-		info.cq_base_pa = iwcq->kmem.pa;
+	return err_code;
+}
+
+static int irdma_create_cq(struct ib_cq *ibcq,
+			   const struct ib_cq_init_attr *attr,
+			   struct uverbs_attr_bundle *attrs)
+{
+	struct ib_device *ibdev = ibcq->device;
+	struct irdma_device *iwdev = to_iwdev(ibdev);
+	struct irdma_pci_f *rf = iwdev->rf;
+	struct irdma_cq *iwcq = to_iwcq(ibcq);
+	u32 cq_num = 0;
+	struct irdma_sc_cq *cq;
+	struct irdma_sc_dev *dev = &rf->sc_dev;
+	struct irdma_cq_init_info info = {};
+	struct irdma_cqp_request *cqp_request;
+	struct cqp_cmds_info *cqp_info;
+	struct irdma_cq_uk_init_info *ukinfo = &info.cq_uk_init_info;
+	int err_code;
+	int entries = attr->cqe;
+	bool cqe_64byte_ena;
+	u8 cqe_size;
+	int rsize;
+
+	err_code = cq_validate_flags(attr->flags, dev->hw_attrs.uk_attrs.hw_rev);
+	if (err_code)
+		return err_code;
+
+	err_code = irdma_alloc_rsrc(rf, rf->allocated_cqs, rf->max_cq, &cq_num,
+				    &rf->next_cq);
+	if (err_code)
+		return err_code;
+
+	cq = &iwcq->sc_cq;
+	cq->back_cq = iwcq;
+	refcount_set(&iwcq->refcnt, 1);
+	spin_lock_init(&iwcq->lock);
+	INIT_LIST_HEAD(&iwcq->resize_list);
+	INIT_LIST_HEAD(&iwcq->cmpl_generated);
+	iwcq->cq_num = cq_num;
+	info.dev = dev;
+	ukinfo->cq_size = max(entries, 4);
+	ukinfo->cq_id = cq_num;
+	cqe_64byte_ena = dev->hw_attrs.uk_attrs.feature_flags & IRDMA_FEATURE_64_BYTE_CQE ?
+			 true : false;
+	cqe_size = cqe_64byte_ena ? 64 : 32;
+	ukinfo->avoid_mem_cflct = cqe_64byte_ena;
+	iwcq->ibcq.cqe = info.cq_uk_init_info.cq_size;
+	if (attr->comp_vector < rf->ceqs_count)
+		info.ceq_id = attr->comp_vector;
+	info.ceq_id_valid = true;
+	info.ceqe_mask = 1;
+	info.type = IRDMA_CQ_TYPE_IWARP;
+	info.vsi = &iwdev->vsi;
+
+	/* Kmode allocations */
+	if (entries < 1 || entries > rf->max_cqe) {
+		err_code = -EINVAL;
+		goto cq_free_rsrc;
 	}
 
+	entries += 2;
+	if (!cqe_64byte_ena && dev->hw_attrs.uk_attrs.hw_rev >= IRDMA_GEN_2)
+		entries *= 2;
+
+	if (entries & 1)
+		entries += 1; /* cq size must be an even number */
+
+	if (entries * cqe_size == IRDMA_HW_PAGE_SIZE)
+		entries += 2;
+
+	ukinfo->cq_size = entries;
+
+	if (cqe_64byte_ena)
+		rsize = info.cq_uk_init_info.cq_size * sizeof(struct irdma_extended_cqe);
+	else
+		rsize = info.cq_uk_init_info.cq_size * sizeof(struct irdma_cqe);
+	iwcq->kmem.size = ALIGN(round_up(rsize, 256), 256);
+	iwcq->kmem.va = dma_alloc_coherent(dev->hw->device,
+					   iwcq->kmem.size,
+					   &iwcq->kmem.pa, GFP_KERNEL);
+	if (!iwcq->kmem.va) {
+		err_code = -ENOMEM;
+		goto cq_free_rsrc;
+	}
+
+	iwcq->kmem_shadow.size = ALIGN(IRDMA_SHADOW_AREA_SIZE << 3,
+				       64);
+	iwcq->kmem_shadow.va = dma_alloc_coherent(dev->hw->device,
+						  iwcq->kmem_shadow.size,
+						  &iwcq->kmem_shadow.pa,
+						  GFP_KERNEL);
+	if (!iwcq->kmem_shadow.va) {
+		err_code = -ENOMEM;
+		goto cq_free_rsrc;
+	}
+	info.shadow_area_pa = iwcq->kmem_shadow.pa;
+	ukinfo->shadow_area = iwcq->kmem_shadow.va;
+	ukinfo->cq_base = iwcq->kmem.va;
+	info.cq_base_pa = iwcq->kmem.pa;
+
 	info.shadow_read_threshold = min(info.cq_uk_init_info.cq_size / 2,
 					 (u32)IRDMA_MAX_CQ_READ_THRESH);
 
@@ -2656,28 +2750,13 @@ static int irdma_create_cq(struct ib_cq *ibcq,
 	if (err_code)
 		goto cq_free_rsrc;
 
-	if (udata) {
-		struct irdma_create_cq_resp resp = {};
-
-		resp.cq_id = info.cq_uk_init_info.cq_id;
-		resp.cq_size = info.cq_uk_init_info.cq_size;
-		if (ib_copy_to_udata(udata, &resp,
-				     min(sizeof(resp), udata->outlen))) {
-			ibdev_dbg(&iwdev->ibdev,
-				  "VERBS: copy to user data\n");
-			err_code = -EPROTO;
-			goto cq_destroy;
-		}
-	}
-
 	init_completion(&iwcq->free_cq);
 
 	/* Populate table entry after CQ is fully created. */
 	smp_store_release(&rf->cq_table[cq_num], iwcq);
 
 	return 0;
-cq_destroy:
-	irdma_cq_wq_destroy(rf, cq);
+
 cq_free_rsrc:
 	irdma_cq_free_rsrc(rf, iwcq);
 
@@ -5355,6 +5434,7 @@ static const struct ib_device_ops irdma_dev_ops = {
 	.alloc_pd = irdma_alloc_pd,
 	.alloc_ucontext = irdma_alloc_ucontext,
 	.create_cq = irdma_create_cq,
+	.create_user_cq = irdma_create_user_cq,
 	.create_qp = irdma_create_qp,
 	.dealloc_driver = irdma_ib_dealloc_device,
 	.dealloc_mw = irdma_dealloc_mw,

-- 
2.52.0


