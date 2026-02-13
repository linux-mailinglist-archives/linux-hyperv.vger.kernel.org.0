Return-Path: <linux-hyperv+bounces-8814-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yDD+MGEFj2ltHQEAu9opvQ
	(envelope-from <linux-hyperv+bounces-8814-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Feb 2026 12:05:05 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 481EE135697
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Feb 2026 12:05:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1862531DBA41
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Feb 2026 11:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65E7D3570B6;
	Fri, 13 Feb 2026 10:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hbc+73oB"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41267356A1F;
	Fri, 13 Feb 2026 10:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770980396; cv=none; b=S6wxp1wRiyCr93Wdw8MfolOiFcZYpheBHMfOlZxX28GNnJbwTgU+/hAhvbNIBGREZboJz+j7irgwlU2EMkqp6KjzBMWmwG+EJ0rrJQ3yXEcd0gsr0106kcScfj5pZcworU6EwA0WVLigmZEzLwU3cjvTOt8tzPuHT7CW+7E/dVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770980396; c=relaxed/simple;
	bh=uCqkDM6MRpkhJ5KrDUZXo/iZqDu91ZV3NReLY1r+Hh0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K17zeVUUxk2L5kryLU9nuJznHmhHJCz9tgygOjMVgaisFlDvj/lZ0dcz26u2FViz7Y0sHYa4F/erk1umIL1mG834zbTbssYJDNJGO4WOgEiysXDGOZXsm3MRYLy5YYIMP+3/TNztkrWDDteumAyXeyk6gudiz2D+4C7YrYn3Xg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hbc+73oB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AB3AC19423;
	Fri, 13 Feb 2026 10:59:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770980395;
	bh=uCqkDM6MRpkhJ5KrDUZXo/iZqDu91ZV3NReLY1r+Hh0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Hbc+73oB3BKQQD9ONRcDM9VW1dC7YNTfBBmMnZpdWy4m5sUJP0BJlAmpvtCOKRko5
	 wJSn7fjBP6POSnlInNlDo0D0+t7TFQeYkWiTCRe4wtsJHfYECDOu+B0NBWTyz4cO1r
	 Ooq04DLiXDtZ7BPPdwblJhqOZEi0cBL1xkg+nsX5E7gIyOw0/VbLwR/+llqH+Y2LSU
	 j7GxnEYxiC7Omg5iuhuUPVWwANh6YjuSh8eB88euVgV44XfXJka69sFwiXhn5jnc3U
	 BpoFO5oRijYhBOK1mF9jItB0sOxA+lI8Os5gMu5/H7KWJDxvqHGhwXWExHtkksA3jU
	 kfQRG1jIKBr+w==
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
Subject: [PATCH rdma-next 16/50] RDMA/cxgb4: Separate kernel and user CQ creation paths
Date: Fri, 13 Feb 2026 12:57:52 +0200
Message-ID: <20260213-refactor-umem-v1-16-f3be85847922@nvidia.com>
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
	TAGGED_FROM(0.00)[bounces-8814-lists,linux-hyperv=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 481EE135697
X-Rspamd-Action: no action

From: Leon Romanovsky <leonro@nvidia.com>

Split the create CQ logic to clearly distinguish kernel and user flows.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/cxgb4/cq.c       | 218 ++++++++++++++++++++++-----------
 drivers/infiniband/hw/cxgb4/iw_cxgb4.h |   2 +
 drivers/infiniband/hw/cxgb4/provider.c |   1 +
 3 files changed, 152 insertions(+), 69 deletions(-)

diff --git a/drivers/infiniband/hw/cxgb4/cq.c b/drivers/infiniband/hw/cxgb4/cq.c
index 14ced7b667fa..d263cca47432 100644
--- a/drivers/infiniband/hw/cxgb4/cq.c
+++ b/drivers/infiniband/hw/cxgb4/cq.c
@@ -994,8 +994,8 @@ int c4iw_destroy_cq(struct ib_cq *ib_cq, struct ib_udata *udata)
 	return 0;
 }
 
-int c4iw_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
-		   struct uverbs_attr_bundle *attrs)
+int c4iw_create_user_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
+			struct uverbs_attr_bundle *attrs)
 {
 	struct ib_udata *udata = &attrs->driver_udata;
 	struct ib_device *ibdev = ibcq->device;
@@ -1012,25 +1012,21 @@ int c4iw_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 		udata, struct c4iw_ucontext, ibucontext);
 
 	pr_debug("ib_dev %p entries %d\n", ibdev, entries);
-	if (attr->flags)
+	if (attr->flags || ibcq->umem)
 		return -EOPNOTSUPP;
 
-	if (entries < 1 || entries > ibdev->attrs.max_cqe)
+	if (attr->cqe > ibdev->attrs.max_cqe)
 		return -EINVAL;
 
 	if (vector >= rhp->rdev.lldi.nciq)
 		return -EINVAL;
 
-	if (udata) {
-		if (udata->inlen < sizeof(ucmd))
-			ucontext->is_32b_cqe = 1;
-	}
+	if (udata->inlen < sizeof(ucmd))
+		ucontext->is_32b_cqe = 1;
 
 	chp->wr_waitp = c4iw_alloc_wr_wait(GFP_KERNEL);
-	if (!chp->wr_waitp) {
-		ret = -ENOMEM;
-		goto err_free_chp;
-	}
+	if (!chp->wr_waitp)
+		return -ENOMEM;
 	c4iw_init_wr_wait(chp->wr_waitp);
 
 	wr_len = sizeof(struct fw_ri_res_wr) + sizeof(struct fw_ri_res);
@@ -1063,22 +1059,19 @@ int c4iw_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 	if (hwentries < 64)
 		hwentries = 64;
 
-	memsize = hwentries * ((ucontext && ucontext->is_32b_cqe) ?
+	memsize = hwentries * (ucontext->is_32b_cqe ?
 			(sizeof(*chp->cq.queue) / 2) : sizeof(*chp->cq.queue));
 
 	/*
 	 * memsize must be a multiple of the page size if its a user cq.
 	 */
-	if (udata)
-		memsize = roundup(memsize, PAGE_SIZE);
+	memsize = roundup(memsize, PAGE_SIZE);
 
 	chp->cq.size = hwentries;
 	chp->cq.memsize = memsize;
 	chp->cq.vector = vector;
 
-	ret = create_cq(&rhp->rdev, &chp->cq,
-			ucontext ? &ucontext->uctx : &rhp->rdev.uctx,
-			chp->wr_waitp);
+	ret = create_cq(&rhp->rdev, &chp->cq, &ucontext->uctx, chp->wr_waitp);
 	if (ret)
 		goto err_free_skb;
 
@@ -1093,54 +1086,52 @@ int c4iw_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 	if (ret)
 		goto err_destroy_cq;
 
-	if (ucontext) {
-		ret = -ENOMEM;
-		mm = kmalloc(sizeof(*mm), GFP_KERNEL);
-		if (!mm)
-			goto err_remove_handle;
-		mm2 = kmalloc(sizeof(*mm2), GFP_KERNEL);
-		if (!mm2)
-			goto err_free_mm;
-
-		memset(&uresp, 0, sizeof(uresp));
-		uresp.qid_mask = rhp->rdev.cqmask;
-		uresp.cqid = chp->cq.cqid;
-		uresp.size = chp->cq.size;
-		uresp.memsize = chp->cq.memsize;
-		spin_lock(&ucontext->mmap_lock);
-		uresp.key = ucontext->key;
-		ucontext->key += PAGE_SIZE;
-		uresp.gts_key = ucontext->key;
-		ucontext->key += PAGE_SIZE;
-		/* communicate to the userspace that
-		 * kernel driver supports 64B CQE
-		 */
-		uresp.flags |= C4IW_64B_CQE;
-
-		spin_unlock(&ucontext->mmap_lock);
-		ret = ib_copy_to_udata(udata, &uresp,
-				       ucontext->is_32b_cqe ?
-				       sizeof(uresp) - sizeof(uresp.flags) :
-				       sizeof(uresp));
-		if (ret)
-			goto err_free_mm2;
-
-		mm->key = uresp.key;
-		mm->addr = 0;
-		mm->vaddr = chp->cq.queue;
-		mm->dma_addr = chp->cq.dma_addr;
-		mm->len = chp->cq.memsize;
-		insert_flag_to_mmap(&rhp->rdev, mm, mm->addr);
-		insert_mmap(ucontext, mm);
-
-		mm2->key = uresp.gts_key;
-		mm2->addr = chp->cq.bar2_pa;
-		mm2->len = PAGE_SIZE;
-		mm2->vaddr = NULL;
-		mm2->dma_addr = 0;
-		insert_flag_to_mmap(&rhp->rdev, mm2, mm2->addr);
-		insert_mmap(ucontext, mm2);
-	}
+	ret = -ENOMEM;
+	mm = kmalloc(sizeof(*mm), GFP_KERNEL);
+	if (!mm)
+		goto err_remove_handle;
+	mm2 = kmalloc(sizeof(*mm2), GFP_KERNEL);
+	if (!mm2)
+		goto err_free_mm;
+
+	memset(&uresp, 0, sizeof(uresp));
+	uresp.qid_mask = rhp->rdev.cqmask;
+	uresp.cqid = chp->cq.cqid;
+	uresp.size = chp->cq.size;
+	uresp.memsize = chp->cq.memsize;
+	spin_lock(&ucontext->mmap_lock);
+	uresp.key = ucontext->key;
+	ucontext->key += PAGE_SIZE;
+	uresp.gts_key = ucontext->key;
+	ucontext->key += PAGE_SIZE;
+	/* communicate to the userspace that
+	 * kernel driver supports 64B CQE
+	 */
+	uresp.flags |= C4IW_64B_CQE;
+
+	spin_unlock(&ucontext->mmap_lock);
+	ret = ib_copy_to_udata(udata, &uresp,
+			       ucontext->is_32b_cqe ?
+			       sizeof(uresp) - sizeof(uresp.flags) :
+			       sizeof(uresp));
+	if (ret)
+		goto err_free_mm2;
+
+	mm->key = uresp.key;
+	mm->addr = 0;
+	mm->vaddr = chp->cq.queue;
+	mm->dma_addr = chp->cq.dma_addr;
+	mm->len = chp->cq.memsize;
+	insert_flag_to_mmap(&rhp->rdev, mm, mm->addr);
+	insert_mmap(ucontext, mm);
+
+	mm2->key = uresp.gts_key;
+	mm2->addr = chp->cq.bar2_pa;
+	mm2->len = PAGE_SIZE;
+	mm2->vaddr = NULL;
+	mm2->dma_addr = 0;
+	insert_flag_to_mmap(&rhp->rdev, mm2, mm2->addr);
+	insert_mmap(ucontext, mm2);
 
 	pr_debug("cqid 0x%0x chp %p size %u memsize %zu, dma_addr %pad\n",
 		 chp->cq.cqid, chp, chp->cq.size, chp->cq.memsize,
@@ -1153,14 +1144,103 @@ int c4iw_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 err_remove_handle:
 	xa_erase_irq(&rhp->cqs, chp->cq.cqid);
 err_destroy_cq:
-	destroy_cq(&chp->rhp->rdev, &chp->cq,
-		   ucontext ? &ucontext->uctx : &rhp->rdev.uctx,
+	destroy_cq(&chp->rhp->rdev, &chp->cq, &ucontext->uctx,
+		   chp->destroy_skb, chp->wr_waitp);
+err_free_skb:
+	kfree_skb(chp->destroy_skb);
+err_free_wr_wait:
+	c4iw_put_wr_wait(chp->wr_waitp);
+	return ret;
+}
+
+int c4iw_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
+		   struct uverbs_attr_bundle *attrs)
+{
+	struct ib_device *ibdev = ibcq->device;
+	int entries = attr->cqe;
+	int vector = attr->comp_vector;
+	struct c4iw_dev *rhp = to_c4iw_dev(ibcq->device);
+	struct c4iw_cq *chp = to_c4iw_cq(ibcq);
+	int ret, wr_len;
+	size_t memsize, hwentries;
+
+	pr_debug("ib_dev %p entries %d\n", ibdev, entries);
+	if (attr->flags)
+		return -EOPNOTSUPP;
+
+	if (attr->cqe > ibdev->attrs.max_cqe)
+		return -EINVAL;
+
+	if (vector >= rhp->rdev.lldi.nciq)
+		return -EINVAL;
+
+	chp->wr_waitp = c4iw_alloc_wr_wait(GFP_KERNEL);
+	if (!chp->wr_waitp)
+		return -ENOMEM;
+	c4iw_init_wr_wait(chp->wr_waitp);
+
+	wr_len = sizeof(struct fw_ri_res_wr) + sizeof(struct fw_ri_res);
+	chp->destroy_skb = alloc_skb(wr_len, GFP_KERNEL);
+	if (!chp->destroy_skb) {
+		ret = -ENOMEM;
+		goto err_free_wr_wait;
+	}
+
+	/* account for the status page. */
+	entries++;
+
+	/* IQ needs one extra entry to differentiate full vs empty. */
+	entries++;
+
+	/*
+	 * entries must be multiple of 16 for HW.
+	 */
+	entries = roundup(entries, 16);
+
+	/*
+	 * Make actual HW queue 2x to avoid cdix_inc overflows.
+	 */
+	hwentries = min(entries * 2, rhp->rdev.hw_queue.t4_max_iq_size);
+
+	/*
+	 * Make HW queue at least 64 entries so GTS updates aren't too
+	 * frequent.
+	 */
+	if (hwentries < 64)
+		hwentries = 64;
+
+	memsize = hwentries * sizeof(*chp->cq.queue);
+
+	chp->cq.size = hwentries;
+	chp->cq.memsize = memsize;
+	chp->cq.vector = vector;
+
+	ret = create_cq(&rhp->rdev, &chp->cq, &rhp->rdev.uctx, chp->wr_waitp);
+	if (ret)
+		goto err_free_skb;
+
+	chp->rhp = rhp;
+	chp->cq.size--;				/* status page */
+	chp->ibcq.cqe = entries - 2;
+	spin_lock_init(&chp->lock);
+	spin_lock_init(&chp->comp_handler_lock);
+	refcount_set(&chp->refcnt, 1);
+	init_completion(&chp->cq_rel_comp);
+	ret = xa_insert_irq(&rhp->cqs, chp->cq.cqid, chp, GFP_KERNEL);
+	if (ret)
+		goto err_destroy_cq;
+
+	pr_debug("cqid 0x%0x chp %p size %u memsize %zu, dma_addr %pad\n",
+		 chp->cq.cqid, chp, chp->cq.size, chp->cq.memsize,
+		 &chp->cq.dma_addr);
+	return 0;
+err_destroy_cq:
+	destroy_cq(&chp->rhp->rdev, &chp->cq, &rhp->rdev.uctx,
 		   chp->destroy_skb, chp->wr_waitp);
 err_free_skb:
 	kfree_skb(chp->destroy_skb);
 err_free_wr_wait:
 	c4iw_put_wr_wait(chp->wr_waitp);
-err_free_chp:
 	return ret;
 }
 
diff --git a/drivers/infiniband/hw/cxgb4/iw_cxgb4.h b/drivers/infiniband/hw/cxgb4/iw_cxgb4.h
index e17c1252536b..b8e3ee2a0c84 100644
--- a/drivers/infiniband/hw/cxgb4/iw_cxgb4.h
+++ b/drivers/infiniband/hw/cxgb4/iw_cxgb4.h
@@ -1014,6 +1014,8 @@ int c4iw_destroy_cq(struct ib_cq *ib_cq, struct ib_udata *udata);
 void c4iw_cq_rem_ref(struct c4iw_cq *chp);
 int c4iw_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 		   struct uverbs_attr_bundle *attrs);
+int c4iw_create_user_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
+			struct uverbs_attr_bundle *attrs);
 int c4iw_arm_cq(struct ib_cq *ibcq, enum ib_cq_notify_flags flags);
 int c4iw_modify_srq(struct ib_srq *ib_srq, struct ib_srq_attr *attr,
 		    enum ib_srq_attr_mask srq_attr_mask,
diff --git a/drivers/infiniband/hw/cxgb4/provider.c b/drivers/infiniband/hw/cxgb4/provider.c
index e059f92d90fd..b9c183d1389d 100644
--- a/drivers/infiniband/hw/cxgb4/provider.c
+++ b/drivers/infiniband/hw/cxgb4/provider.c
@@ -461,6 +461,7 @@ static const struct ib_device_ops c4iw_dev_ops = {
 	.alloc_pd = c4iw_allocate_pd,
 	.alloc_ucontext = c4iw_alloc_ucontext,
 	.create_cq = c4iw_create_cq,
+	.create_user_cq = c4iw_create_user_cq,
 	.create_qp = c4iw_create_qp,
 	.create_srq = c4iw_create_srq,
 	.dealloc_pd = c4iw_deallocate_pd,

-- 
2.52.0


