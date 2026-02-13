Return-Path: <linux-hyperv+bounces-8835-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MH4AHx8Gj2l5HQEAu9opvQ
	(envelope-from <linux-hyperv+bounces-8835-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Feb 2026 12:08:15 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DB9951357A1
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Feb 2026 12:08:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 841723188BF7
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Feb 2026 11:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8003D35B659;
	Fri, 13 Feb 2026 11:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jUwtD9ga"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C22E3563EE;
	Fri, 13 Feb 2026 11:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770980475; cv=none; b=Vb5v2OmpToSIgObGSLLXdqnNQuZPmMVjQekVmXlFr/VRoPn8Lbhy9oQ/fko9Fz7AG/2SV1ZwUPcTLh6fjyKFm30P6X1K1P9lswWCT4CPMO0fDbxJqjEGIFfcjfODP7+ZVLlTzlGcmti1M2igCVljFR/rXbbhgGsCFlhE6ll2iUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770980475; c=relaxed/simple;
	bh=1jkqZSV1Ct4otOnik6vCHukKvebi7PZqsIOIbFxFtZ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ARpqklF24Wkp1/PEPlH7+PnhCXZlbHTBOuAcqOjHYs60a8xiPxgGDxlZoP5ek3RPB2tpB/crXt7aItB66AkmktoSg31l+jUgNXBnI05vS4K+hqD8iBTTwJssyLvczbePtUYLxTr431bSr4ZCN4fSQuH3W10UxQOkWEokHSfriIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jUwtD9ga; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 590CBC116C6;
	Fri, 13 Feb 2026 11:01:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770980475;
	bh=1jkqZSV1Ct4otOnik6vCHukKvebi7PZqsIOIbFxFtZ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jUwtD9gaMvmuW/6fCeOcSBJhAkC0CtNqkpaqjnBx7ar3ZSrSKyuuwmyVCZSGJbasR
	 DedKmDUPSy47gEJJS2aF4FHwimmTIYBBrkr5s69iLU1L70sAnuo2Hibfd0PM77pnsU
	 mUHnhGJyI0G+cfCWI1sT47PZ96Dm+wWF+9JcemfAzEA3tdwpnsWjjMHw6N/5CTyAD3
	 7ueokcm7gA2L479cFZkCoR8hM2fxy10d70MSU4JAzqpk3YB8SLe31BYA2lcBG+Qi5J
	 rfpI1QGxtz8gm3uftukn53uTG0k1zAHEHk70TimVENKxO98vd2/t8rnJERI2oId3dR
	 zrQW8Wy0YRTyg==
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
Subject: [PATCH rdma-next 38/50] RDMA/rdmavt: Remove resize support for kernel CQs
Date: Fri, 13 Feb 2026 12:58:14 +0200
Message-ID: <20260213-refactor-umem-v1-38-f3be85847922@nvidia.com>
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
	TAGGED_FROM(0.00)[bounces-8835-lists,linux-hyperv=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DB9951357A1
X-Rspamd-Action: no action

From: Leon Romanovsky <leonro@nvidia.com>

The CQ resize operation is a uverbs-only interface and is not needed for
CQs created by the kernel. Remove this unused functionality.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/sw/rdmavt/cq.c | 70 ++++++++++++---------------------------
 1 file changed, 21 insertions(+), 49 deletions(-)

diff --git a/drivers/infiniband/sw/rdmavt/cq.c b/drivers/infiniband/sw/rdmavt/cq.c
index db86eb026bb3..1ae5d8c86acb 100644
--- a/drivers/infiniband/sw/rdmavt/cq.c
+++ b/drivers/infiniband/sw/rdmavt/cq.c
@@ -408,51 +408,36 @@ int rvt_resize_cq(struct ib_cq *ibcq, int cqe, struct ib_udata *udata)
 	struct rvt_dev_info *rdi = cq->rdi;
 	struct rvt_cq_wc *u_wc = NULL;
 	struct rvt_cq_wc *old_u_wc = NULL;
-	struct rvt_k_cq_wc *k_wc = NULL;
-	struct rvt_k_cq_wc *old_k_wc = NULL;
+	__u64 offset = 0;
 
 	if (cqe < 1 || cqe > rdi->dparms.props.max_cqe)
 		return -EINVAL;
 
+	if (udata->outlen < sizeof(__u64))
+		return -EINVAL;
+
 	/*
 	 * Need to use vmalloc() if we want to support large #s of entries.
 	 */
-	if (udata && udata->outlen >= sizeof(__u64)) {
-		sz = sizeof(struct ib_uverbs_wc) * (cqe + 1);
-		sz += sizeof(*u_wc);
-		u_wc = vmalloc_user(sz);
-		if (!u_wc)
-			return -ENOMEM;
-	} else {
-		sz = sizeof(struct ib_wc) * (cqe + 1);
-		sz += sizeof(*k_wc);
-		k_wc = vzalloc_node(sz, rdi->dparms.node);
-		if (!k_wc)
-			return -ENOMEM;
-	}
-	/* Check that we can write the offset to mmap. */
-	if (udata && udata->outlen >= sizeof(__u64)) {
-		__u64 offset = 0;
+	sz = sizeof(struct ib_uverbs_wc) * (cqe + 1);
+	sz += sizeof(*u_wc);
+	u_wc = vmalloc_user(sz);
+	if (!u_wc)
+		return -ENOMEM;
 
-		ret = ib_copy_to_udata(udata, &offset, sizeof(offset));
-		if (ret)
-			goto bail_free;
-	}
+	/* Check that we can write the offset to mmap. */
+	ret = ib_copy_to_udata(udata, &offset, sizeof(offset));
+	if (ret)
+		goto bail_free;
 
 	spin_lock_irq(&cq->lock);
 	/*
 	 * Make sure head and tail are sane since they
 	 * might be user writable.
 	 */
-	if (u_wc) {
-		old_u_wc = cq->queue;
-		head = RDMA_READ_UAPI_ATOMIC(old_u_wc->head);
-		tail = RDMA_READ_UAPI_ATOMIC(old_u_wc->tail);
-	} else {
-		old_k_wc = cq->kqueue;
-		head = old_k_wc->head;
-		tail = old_k_wc->tail;
-	}
+	old_u_wc = cq->queue;
+	head = RDMA_READ_UAPI_ATOMIC(old_u_wc->head);
+	tail = RDMA_READ_UAPI_ATOMIC(old_u_wc->tail);
 
 	if (head > (u32)cq->ibcq.cqe)
 		head = (u32)cq->ibcq.cqe;
@@ -467,31 +452,19 @@ int rvt_resize_cq(struct ib_cq *ibcq, int cqe, struct ib_udata *udata)
 		goto bail_unlock;
 	}
 	for (n = 0; tail != head; n++) {
-		if (u_wc)
-			u_wc->uqueue[n] = old_u_wc->uqueue[tail];
-		else
-			k_wc->kqueue[n] = old_k_wc->kqueue[tail];
+		u_wc->uqueue[n] = old_u_wc->uqueue[tail];
 		if (tail == (u32)cq->ibcq.cqe)
 			tail = 0;
 		else
 			tail++;
 	}
 	cq->ibcq.cqe = cqe;
-	if (u_wc) {
-		RDMA_WRITE_UAPI_ATOMIC(u_wc->head, n);
-		RDMA_WRITE_UAPI_ATOMIC(u_wc->tail, 0);
-		cq->queue = u_wc;
-	} else {
-		k_wc->head = n;
-		k_wc->tail = 0;
-		cq->kqueue = k_wc;
-	}
+	RDMA_WRITE_UAPI_ATOMIC(u_wc->head, n);
+	RDMA_WRITE_UAPI_ATOMIC(u_wc->tail, 0);
+	cq->queue = u_wc;
 	spin_unlock_irq(&cq->lock);
 
-	if (u_wc)
-		vfree(old_u_wc);
-	else
-		vfree(old_k_wc);
+	vfree(old_u_wc);
 
 	if (cq->ip) {
 		struct rvt_mmap_info *ip = cq->ip;
@@ -521,7 +494,6 @@ int rvt_resize_cq(struct ib_cq *ibcq, int cqe, struct ib_udata *udata)
 	spin_unlock_irq(&cq->lock);
 bail_free:
 	vfree(u_wc);
-	vfree(k_wc);
 
 	return ret;
 }

-- 
2.52.0


