Return-Path: <linux-hyperv+bounces-8802-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qD5EB2gEj2lJHQEAu9opvQ
	(envelope-from <linux-hyperv+bounces-8802-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Feb 2026 12:00:56 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BB9713552F
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Feb 2026 12:00:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4CFFA311F64E
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Feb 2026 10:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 267DE352921;
	Fri, 13 Feb 2026 10:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VE9qRNFT"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B3B21D3D6;
	Fri, 13 Feb 2026 10:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770980351; cv=none; b=oL27bC4X4ea9zU3+mqSYlUawPXm0YH0H5np6SrXo3LN5sDiOuFchgHWdODr+3BFCuhz1tVd1Thw/xxB/q9jgLMguxUzaXpI34OprSYDuHWM175iJw6Xr5xkLZwQs5eYyxvJT9HSN+nRLQZQ+ZBeGt+h2QRq7kaU47AMTigjxzig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770980351; c=relaxed/simple;
	bh=OblW+k4fZ/66WbbBaEPhF+RvNjNrCx26cYnmaaoJlyo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X+6rz2iqHBPPs8FPOvX4esgcLv4/6SAvAV/QfeAkInPUXbYthVyoUAY5dA1qUbXgd56bZ89wKxSlKAXgNfViDJ991zWSaSwLB2ZzNIdY4Kv/QsxFh1AnvNnRv0xCAZZm07LOjMtjQYJv0VaIMVIX7ZwSkSeyrqTd4zTskEd/24c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VE9qRNFT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6717C4AF09;
	Fri, 13 Feb 2026 10:59:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770980350;
	bh=OblW+k4fZ/66WbbBaEPhF+RvNjNrCx26cYnmaaoJlyo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VE9qRNFTgKqNZxAWqgts3u0Oj9GyWzzwKwS4rb4Jyz/bmJ30iaFcg6mCBXZhUc9AV
	 HYS3Z/jGKr9zLsCojzZWshilBKiJWjDWUoB4LQGVWWRXvWZlqliXEcWgMOTFTnVIry
	 OvV5ks927WIWQsRPFQ873T7gi1TcO+tzHRTwPc1qrum6TYPAJ5Z4FDqvBn/9K0JCyx
	 qwmaLcZSLgTzFvKZx3DVqk4achkA7mMAdzGO25DRdSRsS2/rbdm9EPlUbY6zOX6s/v
	 ZIbIYSAXML5oEgPL5e9q1L0TmwCrS8EfInQ+AyR9gTRmvjge7ZQACl5b0ee7gYwNUi
	 70X+9g5zbgXBA==
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
Subject: [PATCH rdma-next 05/50] RDMA/core: Manage CQ umem in core code
Date: Fri, 13 Feb 2026 12:57:41 +0200
Message-ID: <20260213-refactor-umem-v1-5-f3be85847922@nvidia.com>
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
	TAGGED_FROM(0.00)[bounces-8802-lists,linux-hyperv=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7BB9713552F
X-Rspamd-Action: no action

From: Leon Romanovsky <leonro@nvidia.com>

In the current implementation, CQ umem is handled both by ib_core and
the driver. ib_core sometimes creates and destroys it, while the driver
also destroys it.

Store the umem in struct ib_cq and ensure that only ib_core manages
its lifetime, relying solely on its internal reference counter.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/umem.c                |  2 +-
 drivers/infiniband/core/uverbs_cmd.c          |  1 +
 drivers/infiniband/core/uverbs_std_types_cq.c |  7 ++++++-
 drivers/infiniband/core/verbs.c               |  2 ++
 drivers/infiniband/hw/efa/efa_verbs.c         | 24 +++++++++++-------------
 include/rdma/ib_verbs.h                       |  1 +
 6 files changed, 22 insertions(+), 15 deletions(-)

diff --git a/drivers/infiniband/core/umem.c b/drivers/infiniband/core/umem.c
index 8137031c2a65..fc70b918f3f0 100644
--- a/drivers/infiniband/core/umem.c
+++ b/drivers/infiniband/core/umem.c
@@ -283,7 +283,7 @@ EXPORT_SYMBOL(ib_umem_get);
  */
 void ib_umem_release(struct ib_umem *umem)
 {
-	if (!umem)
+	if (IS_ERR_OR_NULL(umem))
 		return;
 	if (umem->is_dmabuf)
 		return ib_umem_dmabuf_release(to_ib_umem_dmabuf(umem));
diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
index f4616deeca54..fb19395b9f2a 100644
--- a/drivers/infiniband/core/uverbs_cmd.c
+++ b/drivers/infiniband/core/uverbs_cmd.c
@@ -1085,6 +1085,7 @@ static int create_cq(struct uverbs_attr_bundle *attrs,
 	return uverbs_response(attrs, &resp, sizeof(resp));
 
 err_free:
+	ib_umem_release(cq->umem);
 	rdma_restrack_put(&cq->res);
 	kfree(cq);
 err_file:
diff --git a/drivers/infiniband/core/uverbs_std_types_cq.c b/drivers/infiniband/core/uverbs_std_types_cq.c
index fab5d914029d..05809f9ff0f6 100644
--- a/drivers/infiniband/core/uverbs_std_types_cq.c
+++ b/drivers/infiniband/core/uverbs_std_types_cq.c
@@ -186,6 +186,11 @@ static int UVERBS_HANDLER(UVERBS_METHOD_CQ_CREATE)(
 	cq->comp_handler  = ib_uverbs_comp_handler;
 	cq->event_handler = ib_uverbs_cq_event_handler;
 	cq->cq_context    = ev_file ? &ev_file->ev_queue : NULL;
+	/*
+	 * If UMEM is not provided here, legacy drivers will set it during
+	 * CQ creation based on their internal udata.
+	 */
+	cq->umem = umem;
 	atomic_set(&cq->usecnt, 0);
 
 	rdma_restrack_new(&cq->res, RDMA_RESTRACK_CQ);
@@ -206,7 +211,7 @@ static int UVERBS_HANDLER(UVERBS_METHOD_CQ_CREATE)(
 	return ret;
 
 err_free:
-	ib_umem_release(umem);
+	ib_umem_release(cq->umem);
 	rdma_restrack_put(&cq->res);
 	kfree(cq);
 err_event_file:
diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
index 47a97797d7be..ad48d2458a3f 100644
--- a/drivers/infiniband/core/verbs.c
+++ b/drivers/infiniband/core/verbs.c
@@ -49,6 +49,7 @@
 #include <rdma/ib_verbs.h>
 #include <rdma/ib_cache.h>
 #include <rdma/ib_addr.h>
+#include <rdma/ib_umem.h>
 #include <rdma/rw.h>
 #include <rdma/lag.h>
 
@@ -2249,6 +2250,7 @@ int ib_destroy_cq_user(struct ib_cq *cq, struct ib_udata *udata)
 	if (ret)
 		return ret;
 
+	ib_umem_release(cq->umem);
 	rdma_restrack_del(&cq->res);
 	kfree(cq);
 	return ret;
diff --git a/drivers/infiniband/hw/efa/efa_verbs.c b/drivers/infiniband/hw/efa/efa_verbs.c
index 19e3033d4ff7..ae9b98b4b528 100644
--- a/drivers/infiniband/hw/efa/efa_verbs.c
+++ b/drivers/infiniband/hw/efa/efa_verbs.c
@@ -1083,15 +1083,14 @@ int efa_destroy_cq(struct ib_cq *ibcq, struct ib_udata *udata)
 		  cq->cq_idx, cq->cpu_addr, cq->size, &cq->dma_addr);
 
 	efa_destroy_cq_idx(dev, cq->cq_idx);
-	efa_cq_user_mmap_entries_remove(cq);
+	if (cq->cpu_addr)
+		efa_cq_user_mmap_entries_remove(cq);
 	if (cq->eq) {
 		xa_erase(&dev->cqs_xa, cq->cq_idx);
 		synchronize_irq(cq->eq->irq.irqn);
 	}
 
-	if (cq->umem)
-		ib_umem_release(cq->umem);
-	else
+	if (cq->cpu_addr)
 		efa_free_mapped(dev, cq->cpu_addr, cq->dma_addr, cq->size, DMA_FROM_DEVICE);
 	return 0;
 }
@@ -1212,22 +1211,20 @@ int efa_create_cq_umem(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 	cq->ucontext = ucontext;
 	cq->size = PAGE_ALIGN(cmd.cq_entry_size * entries * cmd.num_sub_cqs);
 
-	if (umem) {
-		if (umem->length < cq->size) {
+	if (ibcq->umem) {
+		if (ibcq->umem->length < cq->size) {
 			ibdev_dbg(&dev->ibdev, "External memory too small\n");
 			err = -EINVAL;
 			goto err_out;
 		}
 
-		if (!ib_umem_is_contiguous(umem)) {
+		if (!ib_umem_is_contiguous(ibcq->umem)) {
 			ibdev_dbg(&dev->ibdev, "Non contiguous CQ unsupported\n");
 			err = -EINVAL;
 			goto err_out;
 		}
 
-		cq->cpu_addr = NULL;
-		cq->dma_addr = ib_umem_start_dma_addr(umem);
-		cq->umem = umem;
+		cq->dma_addr = ib_umem_start_dma_addr(ibcq->umem);
 	} else {
 		cq->cpu_addr = efa_zalloc_mapped(dev, &cq->dma_addr, cq->size,
 						 DMA_FROM_DEVICE);
@@ -1259,7 +1256,7 @@ int efa_create_cq_umem(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 	cq->ibcq.cqe = result.actual_depth;
 	WARN_ON_ONCE(entries != result.actual_depth);
 
-	if (!umem)
+	if (cq->cpu_addr)
 		err = cq_mmap_entries_setup(dev, cq, &resp, result.db_valid);
 
 	if (err) {
@@ -1296,11 +1293,12 @@ int efa_create_cq_umem(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 	if (cq->eq)
 		xa_erase(&dev->cqs_xa, cq->cq_idx);
 err_remove_mmap:
-	efa_cq_user_mmap_entries_remove(cq);
+	if (cq->cpu_addr)
+		efa_cq_user_mmap_entries_remove(cq);
 err_destroy_cq:
 	efa_destroy_cq_idx(dev, cq->cq_idx);
 err_free_mapped:
-	if (!umem)
+	if (cq->cpu_addr)
 		efa_free_mapped(dev, cq->cpu_addr, cq->dma_addr, cq->size,
 				DMA_FROM_DEVICE);
 err_out:
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index e1ec5a6c74e6..b1e34fd2ed5f 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -1649,6 +1649,7 @@ struct ib_cq {
 	u8 interrupt:1;
 	u8 shared:1;
 	unsigned int comp_vector;
+	struct ib_umem *umem;
 
 	/*
 	 * Implementation details of the RDMA core, don't use in drivers:

-- 
2.52.0


