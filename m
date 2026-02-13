Return-Path: <linux-hyperv+bounces-8823-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UC7yAgYFj2lJHQEAu9opvQ
	(envelope-from <linux-hyperv+bounces-8823-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Feb 2026 12:03:34 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 35C38135625
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Feb 2026 12:03:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BC76C30409F1
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Feb 2026 11:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1466535BDBF;
	Fri, 13 Feb 2026 11:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oGxmmSU6"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E29E635BDB4;
	Fri, 13 Feb 2026 11:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770980431; cv=none; b=KjconfMflw/LnS4eE1CGC6/kj+vDuA6nfjJdhhCz31LZ9EwUDKoV5s39NILKPoEOrjHff5CpOzCgV/NEZIQhyB+7PFl2MJURU0/UHDxl0zCW5lXVH6cUnPtqeJKj4k6pq7RS6I0yloEoFMD2MLeuqAyxGESbLkORP4khGulkEvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770980431; c=relaxed/simple;
	bh=Ak3RmCVq6jtpD2K0Q8PWZX2hCkziroyuibiIfLhK4qA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GOV/QSGVh3kjAdU5wdeJfGybAUjgOarEHXA6J2J/Qzd7uZeT5klWeix/IDU16t7M2Dmrd1Znc7LSHkn0/LLMnd/oetCXzOhozlHX7+fcUC1Y7Lj6l3OMs7pGr4kbYJsYilAgmVKsXmOkf7GbXkI0nw0oJmBpGOn/AIDZckUFzaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oGxmmSU6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEE85C16AAE;
	Fri, 13 Feb 2026 11:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770980430;
	bh=Ak3RmCVq6jtpD2K0Q8PWZX2hCkziroyuibiIfLhK4qA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oGxmmSU6isRSNDBomgG5ajckBArUA7EwDs5ppPEPXkdoQKC52wPUf2z8Wpf6ZgCSQ
	 xANqp56bWpVa2408k5MS3aXmOV/DPa5WKkzu+YQR5ZRta1i5zinnjhW5FWRNxpGTLG
	 8WWN/n7wwQu415CoBHNYsZf6wOWsNXMW5zpvhvNTMYGNik+7VpM7dU3sRdcGBhbkmu
	 ujx6f9k5pv4C9mYqufOO7Fkdw7wWhVz1qEU/j8puOhlxqPizXrEQmktYRyAOrmr8Nq
	 Eb41g9nJMKcfwNzK/eEY1YVuFLxVRQex1IsRvGVtrFe8UZjXqkkJLwk31gV0DUIMCo
	 Td0bo5lTnsqQw==
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
Subject: [PATCH rdma-next 22/50] RDMA/ocrdma: Split user and kernel CQ creation paths
Date: Fri, 13 Feb 2026 12:57:58 +0200
Message-ID: <20260213-refactor-umem-v1-22-f3be85847922@nvidia.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
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
	TAGGED_FROM(0.00)[bounces-8823-lists,linux-hyperv=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,nvidia.com:mid,nvidia.com:email]
X-Rspamd-Queue-Id: 35C38135625
X-Rspamd-Action: no action

From: Leon Romanovsky <leonro@nvidia.com>

Separate the CQ creation logic into distinct kernel and user flows.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/ocrdma/ocrdma_main.c  |  1 +
 drivers/infiniband/hw/ocrdma/ocrdma_verbs.c | 56 +++++++++++++++++++----------
 drivers/infiniband/hw/ocrdma/ocrdma_verbs.h |  3 ++
 3 files changed, 42 insertions(+), 18 deletions(-)

diff --git a/drivers/infiniband/hw/ocrdma/ocrdma_main.c b/drivers/infiniband/hw/ocrdma/ocrdma_main.c
index 5d4b3bc16493..0d89c5ec9a7a 100644
--- a/drivers/infiniband/hw/ocrdma/ocrdma_main.c
+++ b/drivers/infiniband/hw/ocrdma/ocrdma_main.c
@@ -141,6 +141,7 @@ static const struct ib_device_ops ocrdma_dev_ops = {
 	.create_cq = ocrdma_create_cq,
 	.create_qp = ocrdma_create_qp,
 	.create_user_ah = ocrdma_create_ah,
+	.create_user_cq = ocrdma_create_user_cq,
 	.dealloc_pd = ocrdma_dealloc_pd,
 	.dealloc_ucontext = ocrdma_dealloc_ucontext,
 	.dereg_mr = ocrdma_dereg_mr,
diff --git a/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c b/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
index bf9211d8d130..034d8b937a77 100644
--- a/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
+++ b/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
@@ -966,8 +966,9 @@ static int ocrdma_copy_cq_uresp(struct ocrdma_dev *dev, struct ocrdma_cq *cq,
 	return status;
 }
 
-int ocrdma_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
-		     struct uverbs_attr_bundle *attrs)
+int ocrdma_create_user_cq(struct ib_cq *ibcq,
+			  const struct ib_cq_init_attr *attr,
+			  struct uverbs_attr_bundle *attrs)
 {
 	struct ib_udata *udata = &attrs->driver_udata;
 	struct ib_device *ibdev = ibcq->device;
@@ -976,36 +977,29 @@ int ocrdma_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 	struct ocrdma_dev *dev = get_ocrdma_dev(ibdev);
 	struct ocrdma_ucontext *uctx = rdma_udata_to_drv_context(
 		udata, struct ocrdma_ucontext, ibucontext);
-	u16 pd_id = 0;
 	int status;
 	struct ocrdma_create_cq_ureq ureq;
 
-	if (attr->flags)
+	if (attr->flags || ibcq->umem)
 		return -EOPNOTSUPP;
 
-	if (udata) {
-		if (ib_copy_from_udata(&ureq, udata, sizeof(ureq)))
-			return -EFAULT;
-	} else
-		ureq.dpp_cq = 0;
+	if (ib_copy_from_udata(&ureq, udata, sizeof(ureq)))
+		return -EFAULT;
 
 	spin_lock_init(&cq->cq_lock);
 	spin_lock_init(&cq->comp_handler_lock);
 	INIT_LIST_HEAD(&cq->sq_head);
 	INIT_LIST_HEAD(&cq->rq_head);
 
-	if (udata)
-		pd_id = uctx->cntxt_pd->id;
-
-	status = ocrdma_mbx_create_cq(dev, cq, entries, ureq.dpp_cq, pd_id);
+	status = ocrdma_mbx_create_cq(dev, cq, entries, ureq.dpp_cq,
+				      uctx->cntxt_pd->id);
 	if (status)
 		return status;
 
-	if (udata) {
-		status = ocrdma_copy_cq_uresp(dev, cq, udata);
-		if (status)
-			goto ctx_err;
-	}
+	status = ocrdma_copy_cq_uresp(dev, cq, udata);
+	if (status)
+		goto ctx_err;
+
 	cq->phase = OCRDMA_CQE_VALID;
 	dev->cq_tbl[cq->id] = cq;
 	return 0;
@@ -1015,6 +1009,32 @@ int ocrdma_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 	return status;
 }
 
+int ocrdma_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
+		     struct uverbs_attr_bundle *attrs)
+{
+	struct ib_device *ibdev = ibcq->device;
+	int entries = attr->cqe;
+	struct ocrdma_cq *cq = get_ocrdma_cq(ibcq);
+	struct ocrdma_dev *dev = get_ocrdma_dev(ibdev);
+	int status;
+
+	if (attr->flags)
+		return -EOPNOTSUPP;
+
+	spin_lock_init(&cq->cq_lock);
+	spin_lock_init(&cq->comp_handler_lock);
+	INIT_LIST_HEAD(&cq->sq_head);
+	INIT_LIST_HEAD(&cq->rq_head);
+
+	status = ocrdma_mbx_create_cq(dev, cq, entries, 0, 0);
+	if (status)
+		return status;
+
+	cq->phase = OCRDMA_CQE_VALID;
+	dev->cq_tbl[cq->id] = cq;
+	return 0;
+}
+
 int ocrdma_resize_cq(struct ib_cq *ibcq, int new_cnt,
 		     struct ib_udata *udata)
 {
diff --git a/drivers/infiniband/hw/ocrdma/ocrdma_verbs.h b/drivers/infiniband/hw/ocrdma/ocrdma_verbs.h
index 6c5c3755b8a9..4a572608fd9f 100644
--- a/drivers/infiniband/hw/ocrdma/ocrdma_verbs.h
+++ b/drivers/infiniband/hw/ocrdma/ocrdma_verbs.h
@@ -71,6 +71,9 @@ int ocrdma_dealloc_pd(struct ib_pd *pd, struct ib_udata *udata);
 
 int ocrdma_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 		     struct uverbs_attr_bundle *attrs);
+int ocrdma_create_user_cq(struct ib_cq *ibcq,
+			  const struct ib_cq_init_attr *attr,
+			  struct uverbs_attr_bundle *attrs);
 int ocrdma_resize_cq(struct ib_cq *, int cqe, struct ib_udata *);
 int ocrdma_destroy_cq(struct ib_cq *ibcq, struct ib_udata *udata);
 

-- 
2.52.0


