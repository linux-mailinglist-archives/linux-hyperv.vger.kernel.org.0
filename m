Return-Path: <linux-hyperv+bounces-8831-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kIbXOR8Hj2ltHQEAu9opvQ
	(envelope-from <linux-hyperv+bounces-8831-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Feb 2026 12:12:31 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EBBC135908
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Feb 2026 12:12:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 47FE931058E3
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Feb 2026 11:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7193A360728;
	Fri, 13 Feb 2026 11:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uRNBf6WU"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB7235A938;
	Fri, 13 Feb 2026 11:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770980460; cv=none; b=ucbXDgj9G0Z3Mb4wyyFroO+YXC0CmLFBlEh0RIuMNhwfxoqNL6mdXDWg8qnY1LpZ8g1TECaKg23Mnc586ni2lj+sxQ0GmnTxA/YibuVl5SXE9rDUIzcrTdXojF+dC+UPkD6EBU0tAtSEueOHIgRPozbmii9hutvnu0OdiRZi8mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770980460; c=relaxed/simple;
	bh=TXN66+61USoueF/YJO1qmTespgeOREpM5eWqChYgcOM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WuxjklvmUJ6a1Ipj4lSkoHF5KCd2GsmrGOeBHseBA7gxdVzkLsHiDC01M6FGiRA4xZVjkEsAN58vfcb7knFJNDReCBacPvDcrALMm695akyzV4gpC3qW6maASfD4PB+IMC4QhQWUpZWcCZXrnWcPmHmDSLJfoTCYIao4xy5w3EE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uRNBf6WU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B152C116C6;
	Fri, 13 Feb 2026 11:00:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770980460;
	bh=TXN66+61USoueF/YJO1qmTespgeOREpM5eWqChYgcOM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uRNBf6WULIHJ9gua3TQfmU5Qf9S6KLJq2/4trstsDBUtXYD3gCkMb0iHAFzWF9XLH
	 7bSh+ozvuVcSj5Sum5daGYPH1oyVEGTwkX/fpTZKOFqRFOeYBTSxTWHpXyGwH68/Ke
	 jZIEyQ44KSK/4bLFxCtlb45tG/ot0Qt5Nv398NohopTM97sbD0VrllEztC/Ytb/x/x
	 QV2jbBGNZTLb5ql2NfvWFicoeVRATeSKBLi2RhbXJhkHpumLwDrSF9Ok3Mw8COTVex
	 0BFkgAH4tqg/cEgGsy2WARRAO8A5PdRd5FI3WUMJ1+0bn4t5LlipwGjVYi3JATY0/G
	 pr3cRMxpLMLJg==
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
Subject: [PATCH rdma-next 34/50] RDMA/irdma: Remove resize support for kernel CQs
Date: Fri, 13 Feb 2026 12:58:10 +0200
Message-ID: <20260213-refactor-umem-v1-34-f3be85847922@nvidia.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
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
	TAGGED_FROM(0.00)[bounces-8831-lists,linux-hyperv=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,kmem_buf.va:url,kmem_buf.pa:url]
X-Rspamd-Queue-Id: 5EBBC135908
X-Rspamd-Action: no action

From: Leon Romanovsky <leonro@nvidia.com>

The CQ resize operation is a uverbs-only interface and is not required for
kernel-created CQs. Drop this unused functionality.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/irdma/verbs.c | 88 +++++++++----------------------------
 1 file changed, 21 insertions(+), 67 deletions(-)

diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
index f727d1922a84..d5442aebf1ac 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -2015,6 +2015,9 @@ static int irdma_destroy_cq(struct ib_cq *ib_cq, struct ib_udata *udata)
 static int irdma_resize_cq(struct ib_cq *ibcq, int entries,
 			   struct ib_udata *udata)
 {
+	struct irdma_resize_cq_req req = {};
+	struct irdma_ucontext *ucontext = rdma_udata_to_drv_context(
+		udata, struct irdma_ucontext, ibucontext);
 #define IRDMA_RESIZE_CQ_MIN_REQ_LEN offsetofend(struct irdma_resize_cq_req, user_cq_buffer)
 	struct irdma_cq *iwcq = to_iwcq(ibcq);
 	struct irdma_sc_dev *dev = iwcq->sc_cq.dev;
@@ -2029,7 +2032,6 @@ static int irdma_resize_cq(struct ib_cq *ibcq, int entries,
 	struct irdma_pci_f *rf;
 	struct irdma_cq_buf *cq_buf = NULL;
 	unsigned long flags;
-	u8 cqe_size;
 	int ret;
 
 	iwdev = to_iwdev(ibcq->device);
@@ -2039,81 +2041,39 @@ static int irdma_resize_cq(struct ib_cq *ibcq, int entries,
 	    IRDMA_FEATURE_CQ_RESIZE))
 		return -EOPNOTSUPP;
 
-	if (udata && udata->inlen < IRDMA_RESIZE_CQ_MIN_REQ_LEN)
+	if (udata->inlen < IRDMA_RESIZE_CQ_MIN_REQ_LEN)
 		return -EINVAL;
 
 	if (entries > rf->max_cqe)
 		return -EINVAL;
 
-	if (!iwcq->user_mode) {
-		entries += 2;
-
-		if (!iwcq->sc_cq.cq_uk.avoid_mem_cflct &&
-		    dev->hw_attrs.uk_attrs.hw_rev >= IRDMA_GEN_2)
-			entries *= 2;
-
-		if (entries & 1)
-			entries += 1; /* cq size must be an even number */
-
-		cqe_size = iwcq->sc_cq.cq_uk.avoid_mem_cflct ? 64 : 32;
-		if (entries * cqe_size == IRDMA_HW_PAGE_SIZE)
-			entries += 2;
-	}
-
 	info.cq_size = max(entries, 4);
 
 	if (info.cq_size == iwcq->sc_cq.cq_uk.cq_size - 1)
 		return 0;
 
-	if (udata) {
-		struct irdma_resize_cq_req req = {};
-		struct irdma_ucontext *ucontext =
-			rdma_udata_to_drv_context(udata, struct irdma_ucontext,
-						  ibucontext);
-
-		/* CQ resize not supported with legacy GEN_1 libi40iw */
-		if (ucontext->legacy_mode)
-			return -EOPNOTSUPP;
+	/* CQ resize not supported with legacy GEN_1 libi40iw */
+	if (ucontext->legacy_mode)
+		return -EOPNOTSUPP;
 
-		if (ib_copy_from_udata(&req, udata,
-				       min(sizeof(req), udata->inlen)))
-			return -EINVAL;
+	if (ib_copy_from_udata(&req, udata, min(sizeof(req), udata->inlen)))
+		return -EINVAL;
 
-		spin_lock_irqsave(&ucontext->cq_reg_mem_list_lock, flags);
-		iwpbl_buf = irdma_get_pbl((unsigned long)req.user_cq_buffer,
-					  &ucontext->cq_reg_mem_list);
-		spin_unlock_irqrestore(&ucontext->cq_reg_mem_list_lock, flags);
+	spin_lock_irqsave(&ucontext->cq_reg_mem_list_lock, flags);
+	iwpbl_buf = irdma_get_pbl((unsigned long)req.user_cq_buffer,
+				  &ucontext->cq_reg_mem_list);
+	spin_unlock_irqrestore(&ucontext->cq_reg_mem_list_lock, flags);
 
-		if (!iwpbl_buf)
-			return -ENOMEM;
+	if (!iwpbl_buf)
+		return -ENOMEM;
 
-		cqmr_buf = &iwpbl_buf->cq_mr;
-		if (iwpbl_buf->pbl_allocated) {
-			info.virtual_map = true;
-			info.pbl_chunk_size = 1;
-			info.first_pm_pbl_idx = cqmr_buf->cq_pbl.idx;
-		} else {
-			info.cq_pa = cqmr_buf->cq_pbl.addr;
-		}
+	cqmr_buf = &iwpbl_buf->cq_mr;
+	if (iwpbl_buf->pbl_allocated) {
+		info.virtual_map = true;
+		info.pbl_chunk_size = 1;
+		info.first_pm_pbl_idx = cqmr_buf->cq_pbl.idx;
 	} else {
-		/* Kmode CQ resize */
-		int rsize;
-
-		rsize = info.cq_size * sizeof(struct irdma_cqe);
-		kmem_buf.size = ALIGN(round_up(rsize, 256), 256);
-		kmem_buf.va = dma_alloc_coherent(dev->hw->device,
-						 kmem_buf.size, &kmem_buf.pa,
-						 GFP_KERNEL);
-		if (!kmem_buf.va)
-			return -ENOMEM;
-
-		info.cq_base = kmem_buf.va;
-		info.cq_pa = kmem_buf.pa;
-		cq_buf = kzalloc(sizeof(*cq_buf), GFP_KERNEL);
-		if (!cq_buf) {
-			ret = -ENOMEM;
-			goto error;
-		}
+		info.cq_pa = cqmr_buf->cq_pbl.addr;
 	}
 
 	cqp_request = irdma_alloc_and_get_cqp_request(&rf->cqp, true);
@@ -2154,13 +2114,7 @@ static int irdma_resize_cq(struct ib_cq *ibcq, int entries,
 
 	return 0;
 error:
-	if (!udata) {
-		dma_free_coherent(dev->hw->device, kmem_buf.size, kmem_buf.va,
-				  kmem_buf.pa);
-		kmem_buf.va = NULL;
-	}
 	kfree(cq_buf);
-
 	return ret;
 }
 

-- 
2.52.0


