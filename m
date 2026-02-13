Return-Path: <linux-hyperv+bounces-8816-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EAf3MoIEj2lJHQEAu9opvQ
	(envelope-from <linux-hyperv+bounces-8816-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Feb 2026 12:01:22 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 01C06135565
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Feb 2026 12:01:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BE74930409EE
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Feb 2026 11:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FB983563E5;
	Fri, 13 Feb 2026 11:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FUFtQUL9"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C08F3559F8;
	Fri, 13 Feb 2026 11:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770980404; cv=none; b=jxFDZ66bTNz69Kd+28stA8ZPpjn2L4vdZ/JMHaWWeQ+SlSiyZgYFrvKX65XSvdxyjmPk9YlXvkNGwNGvMTLV3KfFStgLml7qIRyH7oTzm7n5yto3EcnDNUpR6RUrU6dNg/lG9NEn0XlVQltmVxhwIAcl8HwzDWQFxNx9wgZk4v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770980404; c=relaxed/simple;
	bh=hn7YzjvK8jxXt9+ur6KEPT/X9OAdVySLRDWe9dlWIoU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uSZiw0/6Lj8yKrfwz2tAxyIYf/E1DAlm31fgs7v/L0hrrJo7QrLMHZgICAHldqVaO+XtSuTngChAUs+IZr3wMUvPb8cBqnkwr1qIpmM7/0zbMCM0TqrmebmLMFYUIVrzErbyJNUDflaEWga6ysNWAgJtezV2ToD3+6EjSd2u2HU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FUFtQUL9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D54CC19423;
	Fri, 13 Feb 2026 11:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770980404;
	bh=hn7YzjvK8jxXt9+ur6KEPT/X9OAdVySLRDWe9dlWIoU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FUFtQUL9JdM3h8II8cr+oS/z4A3tqdTDCJQg9NkOOBhopVK1gyJOFlNPMRUAx99lq
	 mBkEuUBhinWZcAUITdRxLb9jvbW2D/RdyUNskf/H5u3Fcxe+H9ErtrhkqoWT/Nzcqj
	 MKHuQUkz+kOxu5SD3xiTvVBNtTpkknBNqJyD2pBB6iMxY9CgsA9sesktV8XZp/x5W8
	 37U3HqWnHjd7/YtOWvHbcIkbxmqZjJcopIrBu8TV2C91uxLk3h9I+O6Gqe0cIEHkrr
	 fyzug4yNYCJrwTK75XV464doH3PK2gdITx/ObI04grdqx5/QvOiO8rkxPQk6Xyd3I9
	 CsdggKu1iR+Pg==
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
Subject: [PATCH rdma-next 18/50] RDMA/erdma: Separate user and kernel CQ creation paths
Date: Fri, 13 Feb 2026 12:57:54 +0200
Message-ID: <20260213-refactor-umem-v1-18-f3be85847922@nvidia.com>
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
	TAGGED_FROM(0.00)[bounces-8816-lists,linux-hyperv=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,nvidia.com:mid,nvidia.com:email]
X-Rspamd-Queue-Id: 01C06135565
X-Rspamd-Action: no action

From: Leon Romanovsky <leonro@nvidia.com>

Split CQ creation into distinct kernel and user flows. The erdma driver,
inherited from mlx4, uses a problematic pattern that shares and caches
umem in erdma_map_user_dbrecords(). This design blocks the driver from
supporting generic umem sources (VMA, dmabuf, memfd, and others).

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/erdma/erdma_main.c  |  1 +
 drivers/infiniband/hw/erdma/erdma_verbs.c | 97 ++++++++++++++++++++-----------
 drivers/infiniband/hw/erdma/erdma_verbs.h |  2 +
 3 files changed, 67 insertions(+), 33 deletions(-)

diff --git a/drivers/infiniband/hw/erdma/erdma_main.c b/drivers/infiniband/hw/erdma/erdma_main.c
index f35b30235018..1b6426e89d80 100644
--- a/drivers/infiniband/hw/erdma/erdma_main.c
+++ b/drivers/infiniband/hw/erdma/erdma_main.c
@@ -505,6 +505,7 @@ static const struct ib_device_ops erdma_device_ops = {
 	.alloc_pd = erdma_alloc_pd,
 	.alloc_ucontext = erdma_alloc_ucontext,
 	.create_cq = erdma_create_cq,
+	.create_user_cq = erdma_create_user_cq,
 	.create_qp = erdma_create_qp,
 	.dealloc_pd = erdma_dealloc_pd,
 	.dealloc_ucontext = erdma_dealloc_ucontext,
diff --git a/drivers/infiniband/hw/erdma/erdma_verbs.c b/drivers/infiniband/hw/erdma/erdma_verbs.c
index 058edc42de58..6f809907fec5 100644
--- a/drivers/infiniband/hw/erdma/erdma_verbs.c
+++ b/drivers/infiniband/hw/erdma/erdma_verbs.c
@@ -1952,8 +1952,8 @@ static int erdma_init_kernel_cq(struct erdma_cq *cq)
 	return -ENOMEM;
 }
 
-int erdma_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
-		    struct uverbs_attr_bundle *attrs)
+int erdma_create_user_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
+			 struct uverbs_attr_bundle *attrs)
 {
 	struct ib_udata *udata = &attrs->driver_udata;
 	struct erdma_cq *cq = to_ecq(ibcq);
@@ -1962,6 +1962,11 @@ int erdma_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 	int ret;
 	struct erdma_ucontext *ctx = rdma_udata_to_drv_context(
 		udata, struct erdma_ucontext, ibucontext);
+	struct erdma_ureq_create_cq ureq;
+	struct erdma_uresp_create_cq uresp;
+
+	if (ibcq->umem)
+		return -EOPNOTSUPP;
 
 	if (depth > dev->attrs.max_cqe)
 		return -EINVAL;
@@ -1977,31 +1982,22 @@ int erdma_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 	if (ret < 0)
 		return ret;
 
-	if (!rdma_is_kernel_res(&ibcq->res)) {
-		struct erdma_ureq_create_cq ureq;
-		struct erdma_uresp_create_cq uresp;
-
-		ret = ib_copy_from_udata(&ureq, udata,
-					 min(udata->inlen, sizeof(ureq)));
-		if (ret)
-			goto err_out_xa;
+	ret = ib_copy_from_udata(&ureq, udata,
+				 min(udata->inlen, sizeof(ureq)));
+	if (ret)
+		goto err_out_xa;
 
-		ret = erdma_init_user_cq(ctx, cq, &ureq);
-		if (ret)
-			goto err_out_xa;
+	ret = erdma_init_user_cq(ctx, cq, &ureq);
+	if (ret)
+		goto err_out_xa;
 
-		uresp.cq_id = cq->cqn;
-		uresp.num_cqe = depth;
+	uresp.cq_id = cq->cqn;
+	uresp.num_cqe = depth;
 
-		ret = ib_copy_to_udata(udata, &uresp,
-				       min(sizeof(uresp), udata->outlen));
-		if (ret)
-			goto err_free_res;
-	} else {
-		ret = erdma_init_kernel_cq(cq);
-		if (ret)
-			goto err_out_xa;
-	}
+	ret = ib_copy_to_udata(udata, &uresp,
+			       min(sizeof(uresp), udata->outlen));
+	if (ret)
+		goto err_free_res;
 
 	ret = create_cq_cmd(ctx, cq);
 	if (ret)
@@ -2010,19 +2006,54 @@ int erdma_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 	return 0;
 
 err_free_res:
-	if (!rdma_is_kernel_res(&ibcq->res)) {
-		erdma_unmap_user_dbrecords(ctx, &cq->user_cq.user_dbr_page);
-		put_mtt_entries(dev, &cq->user_cq.qbuf_mem);
-	} else {
-		dma_free_coherent(&dev->pdev->dev, depth << CQE_SHIFT,
-				  cq->kern_cq.qbuf, cq->kern_cq.qbuf_dma_addr);
-		dma_pool_free(dev->db_pool, cq->kern_cq.dbrec,
-			      cq->kern_cq.dbrec_dma);
-	}
+	erdma_unmap_user_dbrecords(ctx, &cq->user_cq.user_dbr_page);
+	put_mtt_entries(dev, &cq->user_cq.qbuf_mem);
 
 err_out_xa:
 	xa_erase(&dev->cq_xa, cq->cqn);
+	return ret;
+}
+
+int erdma_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
+		    struct uverbs_attr_bundle *attrs)
+{
+	struct erdma_cq *cq = to_ecq(ibcq);
+	struct erdma_dev *dev = to_edev(ibcq->device);
+	unsigned int depth = attr->cqe;
+	int ret;
+
+	if (depth > dev->attrs.max_cqe)
+		return -EINVAL;
 
+	depth = roundup_pow_of_two(depth);
+	cq->ibcq.cqe = depth;
+	cq->depth = depth;
+	cq->assoc_eqn = attr->comp_vector + 1;
+
+	ret = xa_alloc_cyclic(&dev->cq_xa, &cq->cqn, cq,
+			      XA_LIMIT(1, dev->attrs.max_cq - 1),
+			      &dev->next_alloc_cqn, GFP_KERNEL);
+	if (ret < 0)
+		return ret;
+
+	ret = erdma_init_kernel_cq(cq);
+	if (ret)
+		goto err_out_xa;
+
+	ret = create_cq_cmd(NULL, cq);
+	if (ret)
+		goto err_free_res;
+
+	return 0;
+
+err_free_res:
+	dma_free_coherent(&dev->pdev->dev, depth << CQE_SHIFT,
+			  cq->kern_cq.qbuf, cq->kern_cq.qbuf_dma_addr);
+	dma_pool_free(dev->db_pool, cq->kern_cq.dbrec,
+		      cq->kern_cq.dbrec_dma);
+
+err_out_xa:
+	xa_erase(&dev->cq_xa, cq->cqn);
 	return ret;
 }
 
diff --git a/drivers/infiniband/hw/erdma/erdma_verbs.h b/drivers/infiniband/hw/erdma/erdma_verbs.h
index 7d8d3fe501d5..21a4fb404806 100644
--- a/drivers/infiniband/hw/erdma/erdma_verbs.h
+++ b/drivers/infiniband/hw/erdma/erdma_verbs.h
@@ -435,6 +435,8 @@ int erdma_get_port_immutable(struct ib_device *dev, u32 port,
 			     struct ib_port_immutable *ib_port_immutable);
 int erdma_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 		    struct uverbs_attr_bundle *attrs);
+int erdma_create_user_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
+			 struct uverbs_attr_bundle *attrs);
 int erdma_query_port(struct ib_device *dev, u32 port,
 		     struct ib_port_attr *attr);
 int erdma_query_gid(struct ib_device *dev, u32 port, int idx,

-- 
2.52.0


