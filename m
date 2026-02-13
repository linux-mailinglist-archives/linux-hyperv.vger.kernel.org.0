Return-Path: <linux-hyperv+bounces-8845-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eHkaF/4Gj2ltHQEAu9opvQ
	(envelope-from <linux-hyperv+bounces-8845-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Feb 2026 12:11:58 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B87C51358D6
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Feb 2026 12:11:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7E5B931D69FE
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Feb 2026 11:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B81EF36403F;
	Fri, 13 Feb 2026 11:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nF7BXsVi"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B7E35DCE3;
	Fri, 13 Feb 2026 11:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770980513; cv=none; b=l94pLufKy7uIlNdnVOltGCzlP8RYXah9HHET1WpMIhXyYzr0enDJNC35ZTeK7WTgnJeLpcTLWgcABoVGVx/BtXbvKkXWp3P5vcLR3RltiG9A1vPMeRNvNYOHBunzf9qmLaLBa/c3gN0rFE708NmvR6fvTyHBdSV43Ybz3iniv/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770980513; c=relaxed/simple;
	bh=1roDOuzFaVAi0uAanyZBBm5keeCeS16zySE/Gbe4n7M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AKzq31n4BXXGgsUCV3wxYwa+MxStEydYjv5a1VTzAnvRhpMNYSsBStPmOmZ9TsIsiFoRJkWsDd1fTxWrMwr4ETXizBABKmKR/LFsCtm0d1BpFoCB20J6eqzBYeilNg8HyulryEZ5Z0k5K760pCqPiPhC1ZIm8UcEDqHzMxWPIJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nF7BXsVi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97558C116C6;
	Fri, 13 Feb 2026 11:01:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770980513;
	bh=1roDOuzFaVAi0uAanyZBBm5keeCeS16zySE/Gbe4n7M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nF7BXsVi9ZkQlLmjgJwjaAQ9hAKWIVnVuUu+Xg1CKWGVeQteyqV2VoCgXAusaEFEy
	 2142N5IxycG+Ywh57jwVYsNL/e6YRPcZd6tseyKDvHrduspXdNfxlazxglKR/DY2Uz
	 w6rKub6ENw/Ka0v1/IjBSTP6Z4yoI4EJQJfA36IzodS4E6+d3QVL0jCuQwY1ZsYnqr
	 5TlHfZ7Acr0ovlXKOAlH3/m4capxkhuS8jVw/75f3g6QZuWOoSDIkFlCQrSaTdGGFi
	 Twix9uVGpVMa/gf9O6KALMe1fOnax4KOw5YcTP7tM5zMVjiyl2z6yHd9t6mL9/AVbk
	 SyP/yuWm+QNbw==
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
Subject: [PATCH rdma-next 44/50] RDMA/bnxt_re: Reduce CQ memory footprint
Date: Fri, 13 Feb 2026 12:58:20 +0200
Message-ID: <20260213-refactor-umem-v1-44-f3be85847922@nvidia.com>
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
	TAGGED_FROM(0.00)[bounces-8845-lists,linux-hyperv=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B87C51358D6
X-Rspamd-Action: no action

From: Leon Romanovsky <leonro@nvidia.com>

There is no need to store resize_cqe and resize_umem in CQ object.
Let's remove them.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/bnxt_re/ib_verbs.c | 37 +++++++++++---------------------
 drivers/infiniband/hw/bnxt_re/ib_verbs.h |  2 --
 2 files changed, 13 insertions(+), 26 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index d544a4fb1e96..9a8bdb52097f 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -3320,6 +3320,8 @@ int bnxt_re_resize_cq(struct ib_cq *ibcq, unsigned int cqe,
 	struct bnxt_re_resize_cq_req req;
 	struct bnxt_re_dev *rdev;
 	struct bnxt_re_cq *cq;
+	struct ib_umem *umem;
+
 	int rc, entries;
 
 	cq =  container_of(ibcq, struct bnxt_re_cq, ib_cq);
@@ -3336,26 +3338,18 @@ int bnxt_re_resize_cq(struct ib_cq *ibcq, unsigned int cqe,
 		entries = dev_attr->max_cq_wqes + 1;
 
 	/* uverbs consumer */
-	if (ib_copy_from_udata(&req, udata, sizeof(req))) {
-		rc = -EFAULT;
-		goto fail;
-	}
+	if (ib_copy_from_udata(&req, udata, sizeof(req)))
+		return -EFAULT;
 
-	cq->resize_umem = ib_umem_get(&rdev->ibdev, req.cq_va,
-				      entries * sizeof(struct cq_base),
-				      IB_ACCESS_LOCAL_WRITE);
-	if (IS_ERR(cq->resize_umem)) {
-		rc = PTR_ERR(cq->resize_umem);
-		ibdev_err(&rdev->ibdev, "%s: ib_umem_get failed! rc = %pe\n",
-			  __func__, cq->resize_umem);
-		cq->resize_umem = NULL;
-		return rc;
-	}
-	cq->resize_cqe = entries;
+	umem = ib_umem_get(&rdev->ibdev, req.cq_va,
+			   entries * sizeof(struct cq_base),
+			   IB_ACCESS_LOCAL_WRITE);
+	if (IS_ERR(umem))
+		return PTR_ERR(umem);
 	memcpy(&sg_info, &cq->qplib_cq.sg_info, sizeof(sg_info));
 	orig_dpi = cq->qplib_cq.dpi;
 
-	cq->qplib_cq.sg_info.umem = cq->resize_umem;
+	cq->qplib_cq.sg_info.umem = umem;
 	cq->qplib_cq.sg_info.pgsize = PAGE_SIZE;
 	cq->qplib_cq.sg_info.pgshft = PAGE_SHIFT;
 	cq->qplib_cq.dpi = &uctx->dpi;
@@ -3369,21 +3363,16 @@ int bnxt_re_resize_cq(struct ib_cq *ibcq, unsigned int cqe,
 
 	bnxt_qplib_resize_cq_complete(&rdev->qplib_res, &cq->qplib_cq);
 
-	cq->qplib_cq.max_wqe = cq->resize_cqe;
+	cq->qplib_cq.max_wqe = entries;
 	ib_umem_release(cq->ib_cq.umem);
-	cq->ib_cq.umem = cq->resize_umem;
-	cq->resize_umem = NULL;
-	cq->resize_cqe = 0;
-
+	cq->ib_cq.umem = umem;
 	cq->ib_cq.cqe = entries;
 	atomic_inc(&rdev->stats.res.resize_count);
 
 	return 0;
 
 fail:
-	ib_umem_release(cq->resize_umem);
-	cq->resize_umem = NULL;
-	cq->resize_cqe = 0;
+	ib_umem_release(umem);
 	memcpy(&cq->qplib_cq.sg_info, &sg_info, sizeof(sg_info));
 	cq->qplib_cq.dpi = orig_dpi;
 	return rc;
diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.h b/drivers/infiniband/hw/bnxt_re/ib_verbs.h
index 7890d6ebad90..ee7ccaa2ed4c 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.h
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.h
@@ -108,8 +108,6 @@ struct bnxt_re_cq {
 	struct bnxt_qplib_cqe	*cql;
 #define MAX_CQL_PER_POLL	1024
 	u32			max_cql;
-	struct ib_umem		*resize_umem;
-	int			resize_cqe;
 	void			*uctx_cq_page;
 	struct hlist_node	hash_entry;
 };

-- 
2.52.0


