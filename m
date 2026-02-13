Return-Path: <linux-hyperv+bounces-8818-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0JBEHoQFj2ltHQEAu9opvQ
	(envelope-from <linux-hyperv+bounces-8818-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Feb 2026 12:05:40 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A0C31356C2
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Feb 2026 12:05:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 81F42310EF50
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Feb 2026 11:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA7E03590C7;
	Fri, 13 Feb 2026 11:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XEGQDWfk"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83D613587A2;
	Fri, 13 Feb 2026 11:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770980411; cv=none; b=CtRbzMxBOJeaKAP+p2zWuLUq/d0eE7SJKWw8mS4Sq+V0YqJjWxpEXLNE2x8++8QwpGFv+k0FMtt7aP7gn9vUam8q6xu52cNfEcDadcHYVoa286yVq+5Q0bSt6gXzifAh8V6uLRCruEN3hCw4ZYI/mH6RY8fN6BQ4HSgRntRHHZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770980411; c=relaxed/simple;
	bh=s78Zi7UXsBRgLKBAZ5n7fQmfZPeu1Dtkh9uqA8RaVzw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WXSK668oICNKuOS1XnJ5YhXTzLec0CnJjo5syTXVbr21TfXRUJtEn6Rw53CCIcRmcXhSpYSkW0ZVUIe4dKIBbVq0mH68gHcDxobzsRMu1ZbwYUWbW3XAN6rhwJicsBIkdKsDiaxFFmaqdOh7Aw2W8p2tAZ8DmZ4MQCQUIYyGpcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XEGQDWfk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96048C116C6;
	Fri, 13 Feb 2026 11:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770980411;
	bh=s78Zi7UXsBRgLKBAZ5n7fQmfZPeu1Dtkh9uqA8RaVzw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XEGQDWfkcO/J4lqcTytbrozdtN2QImw6fX8TX2+VVw+kgh7Ul6sUjT3/+tn20G+xZ
	 fGKgofiPyxNhood8LIOuMLXzh6K7QpUVj3vzDaEttTjAbEv38H+jVR7vqBWaEr6GPb
	 NymVNsDTkKf+SacdhWRGWN5XKCwIS83otzgDKZBVjqoyRf3slF+8eWmLvqlCDHJwTF
	 X8Rr+e7IF8oUYxc8Ocpdx1FcD9oiyCK6qYeho3amuxruHBXlyFsYepuIgti+IPy47a
	 ZduKb9WTwNUsX5ytKvTPOMYS472HqhXZoXNYYEH0VpcAQUNt8slETwCACophh7VagA
	 lBlOoAg2OE6Xw==
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
Subject: [PATCH rdma-next 21/50] RDMA/vmw_pvrdma: Provide a modern CQ creation interface
Date: Fri, 13 Feb 2026 12:57:57 +0200
Message-ID: <20260213-refactor-umem-v1-21-f3be85847922@nvidia.com>
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
	TAGGED_FROM(0.00)[bounces-8818-lists,linux-hyperv=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0A0C31356C2
X-Rspamd-Action: no action

From: Leon Romanovsky <leonro@nvidia.com>

The uverbs CQ creation UAPI allows users to supply their own umem for a CQ.
Update vmw_pvrdma to support this workflow while preserving support for creating
umem through the legacy interface.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_cq.c    | 171 ++++++++++++++++--------
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_main.c  |   1 +
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.h |   3 +
 3 files changed, 121 insertions(+), 54 deletions(-)

diff --git a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_cq.c b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_cq.c
index b3df6eb9b8ef..c43c363565c1 100644
--- a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_cq.c
+++ b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_cq.c
@@ -90,16 +90,9 @@ int pvrdma_req_notify_cq(struct ib_cq *ibcq,
 	return has_data;
 }
 
-/**
- * pvrdma_create_cq - create completion queue
- * @ibcq: Allocated CQ
- * @attr: completion queue attributes
- * @attrs: bundle
- *
- * @return: 0 on success
- */
-int pvrdma_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
-		     struct uverbs_attr_bundle *attrs)
+int pvrdma_create_user_cq(struct ib_cq *ibcq,
+			  const struct ib_cq_init_attr *attr,
+			  struct uverbs_attr_bundle *attrs)
 {
 	struct ib_udata *udata = &attrs->driver_udata;
 	struct ib_device *ibdev = ibcq->device;
@@ -123,58 +116,48 @@ int pvrdma_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 	if (attr->flags)
 		return -EOPNOTSUPP;
 
-	entries = roundup_pow_of_two(entries);
-	if (entries < 1 || entries > dev->dsr->caps.max_cqe)
+	if (attr->cqe > dev->dsr->caps.max_cqe)
 		return -EINVAL;
 
+	entries = roundup_pow_of_two(entries);
+
 	if (!atomic_add_unless(&dev->num_cqs, 1, dev->dsr->caps.max_cq))
 		return -ENOMEM;
 
 	cq->ibcq.cqe = entries;
-	cq->is_kernel = !udata;
-
-	if (!cq->is_kernel) {
-		if (ib_copy_from_udata(&ucmd, udata, sizeof(ucmd))) {
-			ret = -EFAULT;
-			goto err_cq;
-		}
-
-		cq->umem = ib_umem_get(ibdev, ucmd.buf_addr, ucmd.buf_size,
-				       IB_ACCESS_LOCAL_WRITE);
-		if (IS_ERR(cq->umem)) {
-			ret = PTR_ERR(cq->umem);
-			goto err_cq;
-		}
+	cq->is_kernel = false;
 
-		npages = ib_umem_num_dma_blocks(cq->umem, PAGE_SIZE);
-	} else {
-		/* One extra page for shared ring state */
-		npages = 1 + (entries * sizeof(struct pvrdma_cqe) +
-			      PAGE_SIZE - 1) / PAGE_SIZE;
+	if (ib_copy_from_udata(&ucmd, udata, sizeof(ucmd))) {
+		ret = -EFAULT;
+		goto err_cq;
+	}
 
-		/* Skip header page. */
-		cq->offset = PAGE_SIZE;
+	if (!ibcq->umem)
+		ibcq->umem = ib_umem_get(ibdev, ucmd.buf_addr, ucmd.buf_size,
+					 IB_ACCESS_LOCAL_WRITE);
+	if (IS_ERR(ibcq->umem)) {
+		ret = PTR_ERR(ibcq->umem);
+		goto err_cq;
 	}
 
+	npages = ib_umem_num_dma_blocks(cq->umem, PAGE_SIZE);
+
 	if (npages < 0 || npages > PVRDMA_PAGE_DIR_MAX_PAGES) {
 		dev_warn(&dev->pdev->dev,
 			 "overflow pages in completion queue\n");
 		ret = -EINVAL;
-		goto err_umem;
+		goto err_cq;
 	}
 
-	ret = pvrdma_page_dir_init(dev, &cq->pdir, npages, cq->is_kernel);
+	ret = pvrdma_page_dir_init(dev, &cq->pdir, npages, false);
 	if (ret) {
 		dev_warn(&dev->pdev->dev,
 			 "could not allocate page directory\n");
-		goto err_umem;
+		goto err_cq;
 	}
 
 	/* Ring state is always the first page. Set in library for user cq. */
-	if (cq->is_kernel)
-		cq->ring_state = cq->pdir.pages[0];
-	else
-		pvrdma_page_dir_insert_umem(&cq->pdir, cq->umem, 0);
+	pvrdma_page_dir_insert_umem(&cq->pdir, cq->umem, 0);
 
 	refcount_set(&cq->refcnt, 1);
 	init_completion(&cq->free);
@@ -183,7 +166,7 @@ int pvrdma_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 	memset(cmd, 0, sizeof(*cmd));
 	cmd->hdr.cmd = PVRDMA_CMD_CREATE_CQ;
 	cmd->nchunks = npages;
-	cmd->ctx_handle = context ? context->ctx_handle : 0;
+	cmd->ctx_handle = context->ctx_handle;
 	cmd->cqe = entries;
 	cmd->pdir_dma = cq->pdir.dir_dma;
 	ret = pvrdma_cmd_post(dev, &req, &rsp, PVRDMA_CMD_CREATE_CQ_RESP);
@@ -200,24 +183,106 @@ int pvrdma_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 	dev->cq_tbl[cq->cq_handle % dev->dsr->caps.max_cq] = cq;
 	spin_unlock_irqrestore(&dev->cq_tbl_lock, flags);
 
-	if (!cq->is_kernel) {
-		cq->uar = &context->uar;
+	cq->uar = &context->uar;
 
-		/* Copy udata back. */
-		if (ib_copy_to_udata(udata, &cq_resp, sizeof(cq_resp))) {
-			dev_warn(&dev->pdev->dev,
-				 "failed to copy back udata\n");
-			pvrdma_destroy_cq(&cq->ibcq, udata);
-			return -EINVAL;
-		}
+	/* Copy udata back. */
+	if (ib_copy_to_udata(udata, &cq_resp, sizeof(cq_resp))) {
+		dev_warn(&dev->pdev->dev,
+			 "failed to copy back udata\n");
+		pvrdma_destroy_cq(&cq->ibcq, udata);
+		return -EINVAL;
 	}
 
 	return 0;
 
 err_page_dir:
 	pvrdma_page_dir_cleanup(dev, &cq->pdir);
-err_umem:
-	ib_umem_release(cq->umem);
+err_cq:
+	atomic_dec(&dev->num_cqs);
+	return ret;
+}
+
+int pvrdma_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
+		     struct uverbs_attr_bundle *attrs)
+{
+	struct ib_device *ibdev = ibcq->device;
+	int entries = attr->cqe;
+	struct pvrdma_dev *dev = to_vdev(ibdev);
+	struct pvrdma_cq *cq = to_vcq(ibcq);
+	int ret;
+	int npages;
+	unsigned long flags;
+	union pvrdma_cmd_req req;
+	union pvrdma_cmd_resp rsp;
+	struct pvrdma_cmd_create_cq *cmd = &req.create_cq;
+	struct pvrdma_cmd_create_cq_resp *resp = &rsp.create_cq_resp;
+
+	BUILD_BUG_ON(sizeof(struct pvrdma_cqe) != 64);
+
+	if (attr->flags)
+		return -EOPNOTSUPP;
+
+	if (attr->cqe > dev->dsr->caps.max_cqe)
+		return -EINVAL;
+	entries = roundup_pow_of_two(entries);
+
+	if (!atomic_add_unless(&dev->num_cqs, 1, dev->dsr->caps.max_cq))
+		return -ENOMEM;
+
+	cq->ibcq.cqe = entries;
+	cq->is_kernel = true;
+
+	/* One extra page for shared ring state */
+	npages = 1 + (entries * sizeof(struct pvrdma_cqe) +
+		      PAGE_SIZE - 1) / PAGE_SIZE;
+
+	/* Skip header page. */
+	cq->offset = PAGE_SIZE;
+
+	if (npages < 0 || npages > PVRDMA_PAGE_DIR_MAX_PAGES) {
+		dev_warn(&dev->pdev->dev,
+			 "overflow pages in completion queue\n");
+		ret = -EINVAL;
+		goto err_cq;
+	}
+
+	ret = pvrdma_page_dir_init(dev, &cq->pdir, npages, true);
+	if (ret) {
+		dev_warn(&dev->pdev->dev,
+			 "could not allocate page directory\n");
+		goto err_cq;
+	}
+
+	/* Ring state is always the first page. Set in library for user cq. */
+	cq->ring_state = cq->pdir.pages[0];
+
+	refcount_set(&cq->refcnt, 1);
+	init_completion(&cq->free);
+	spin_lock_init(&cq->cq_lock);
+
+	memset(cmd, 0, sizeof(*cmd));
+	cmd->hdr.cmd = PVRDMA_CMD_CREATE_CQ;
+	cmd->nchunks = npages;
+	cmd->ctx_handle = 0;
+	cmd->cqe = entries;
+	cmd->pdir_dma = cq->pdir.dir_dma;
+	ret = pvrdma_cmd_post(dev, &req, &rsp, PVRDMA_CMD_CREATE_CQ_RESP);
+	if (ret < 0) {
+		dev_warn(&dev->pdev->dev,
+			 "could not create completion queue, error: %d\n", ret);
+		goto err_page_dir;
+	}
+
+	cq->ibcq.cqe = resp->cqe;
+	cq->cq_handle = resp->cq_handle;
+	spin_lock_irqsave(&dev->cq_tbl_lock, flags);
+	dev->cq_tbl[cq->cq_handle % dev->dsr->caps.max_cq] = cq;
+	spin_unlock_irqrestore(&dev->cq_tbl_lock, flags);
+
+	return 0;
+
+err_page_dir:
+	pvrdma_page_dir_cleanup(dev, &cq->pdir);
 err_cq:
 	atomic_dec(&dev->num_cqs);
 	return ret;
@@ -229,8 +294,6 @@ static void pvrdma_free_cq(struct pvrdma_dev *dev, struct pvrdma_cq *cq)
 		complete(&cq->free);
 	wait_for_completion(&cq->free);
 
-	ib_umem_release(cq->umem);
-
 	pvrdma_page_dir_cleanup(dev, &cq->pdir);
 }
 
diff --git a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_main.c b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_main.c
index 1664d1d7d969..3f5b94a1e517 100644
--- a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_main.c
+++ b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_main.c
@@ -194,6 +194,7 @@ static const struct ib_device_ops pvrdma_dev_ops = {
 	.alloc_ucontext = pvrdma_alloc_ucontext,
 	.create_ah = pvrdma_create_ah,
 	.create_cq = pvrdma_create_cq,
+	.create_user_cq = pvrdma_create_user_cq,
 	.create_qp = pvrdma_create_qp,
 	.dealloc_pd = pvrdma_dealloc_pd,
 	.dealloc_ucontext = pvrdma_dealloc_ucontext,
diff --git a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.h b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.h
index 603e5a9311eb..18910d336744 100644
--- a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.h
+++ b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.h
@@ -375,6 +375,9 @@ int pvrdma_map_mr_sg(struct ib_mr *ibmr, struct scatterlist *sg,
 		     int sg_nents, unsigned int *sg_offset);
 int pvrdma_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 		     struct uverbs_attr_bundle *attrs);
+int pvrdma_create_user_cq(struct ib_cq *ibcq,
+			  const struct ib_cq_init_attr *attr,
+			  struct uverbs_attr_bundle *attrs);
 int pvrdma_destroy_cq(struct ib_cq *cq, struct ib_udata *udata);
 int pvrdma_poll_cq(struct ib_cq *ibcq, int num_entries, struct ib_wc *wc);
 int pvrdma_req_notify_cq(struct ib_cq *cq, enum ib_cq_notify_flags flags);

-- 
2.52.0


