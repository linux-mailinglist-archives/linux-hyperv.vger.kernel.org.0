Return-Path: <linux-hyperv+bounces-8839-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8IKDHWkHj2maHQEAu9opvQ
	(envelope-from <linux-hyperv+bounces-8839-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Feb 2026 12:13:45 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1296C13595A
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Feb 2026 12:13:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6217231AA9BE
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Feb 2026 11:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E407E35C1B4;
	Fri, 13 Feb 2026 11:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cl/xECrF"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8DB21FF21;
	Fri, 13 Feb 2026 11:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770980490; cv=none; b=OhI8LYzmZU94L+DQWIwKunlwFrTwVCkQoyxITv5tMtDc9jlxoECCehjdymlhC0rgDgc3vNso9Ghvd9ohpsaeqhjAv8kpfFesJL8hnQLiXn/q1zGNJPmOGeseqzhhBb1yMfaWyhmaRCO/SGEKx/v7Pmwt3vtE/w16BvJaSoEmkyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770980490; c=relaxed/simple;
	bh=RKz91Km/bw5jaUIlB06o1jODkQWcQw0bXu5KVJqakUA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Aps+waWs9THEU/VUn0rB7ccg4eces7h/8ACnJh8jX2v6eFQOIPmrHzcJycgbnuXOaZ2a1Vo8vDTRMsheirIf94JSRK1Zzlm0qjcyn+h4wJ0boHc+gMdFjmXaJscef+7WrtyFvIisOZOfhDboXIFt1sUYJni2w1UngI6M7a2H6OY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cl/xECrF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50AD4C116C6;
	Fri, 13 Feb 2026 11:01:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770980490;
	bh=RKz91Km/bw5jaUIlB06o1jODkQWcQw0bXu5KVJqakUA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Cl/xECrF4FnYkfZmeA+TMUMF+Zatw9ml8W0xI37eRz/EgRHIr+ZRzjlHDCfLlY+9i
	 o/rNTWNDEkzczt5ktzRcv3xlhDW7hz2D/bnvuBkgkwscyQA97cdIurkjgkLJsd1PT0
	 6N3bkPO5Vxu/DH7ybxgeItrQbJLZMnAePoBAYxjU66Gq8Bcr5jyjUw51IOhYFNkMud
	 QfMVTnQMcCrBnKTyWugjuBunqTVR3qk8d2aKIIY+zLGn3X7sI6iD0UmsSUALoGp5xC
	 tzbhRNDkBEDY4CTM4Blt/mv0nEXJzfA0+WDPM538ycKgHc7KwjaWY86OEg2IG0OqkY
	 hGGhgEg/R6lTw==
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
Subject: [PATCH rdma-next 42/50] RDMA/bnxt_re: Complete CQ resize in a single step
Date: Fri, 13 Feb 2026 12:58:18 +0200
Message-ID: <20260213-refactor-umem-v1-42-f3be85847922@nvidia.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
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
	TAGGED_FROM(0.00)[bounces-8839-lists,linux-hyperv=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1296C13595A
X-Rspamd-Action: no action

From: Leon Romanovsky <leonro@nvidia.com>

There is no need to defer the CQ resize operation, as it is intended to
be completed in one pass. The current bnxt_re_resize_cq() implementation
does not handle concurrent CQ resize requests, and this will be addressed
in the following patches.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/bnxt_re/ib_verbs.c | 33 +++++++++-----------------------
 1 file changed, 9 insertions(+), 24 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index d652018c19b3..2aecfbbb7eaf 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -3309,20 +3309,6 @@ int bnxt_re_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 	return rc;
 }
 
-static void bnxt_re_resize_cq_complete(struct bnxt_re_cq *cq)
-{
-	struct bnxt_re_dev *rdev = cq->rdev;
-
-	bnxt_qplib_resize_cq_complete(&rdev->qplib_res, &cq->qplib_cq);
-
-	cq->qplib_cq.max_wqe = cq->resize_cqe;
-	if (cq->resize_umem) {
-		ib_umem_release(cq->ib_cq.umem);
-		cq->ib_cq.umem = cq->resize_umem;
-		cq->resize_umem = NULL;
-		cq->resize_cqe = 0;
-	}
-}
 
 int bnxt_re_resize_cq(struct ib_cq *ibcq, unsigned int cqe,
 		      struct ib_udata *udata)
@@ -3387,7 +3373,15 @@ int bnxt_re_resize_cq(struct ib_cq *ibcq, unsigned int cqe,
 		goto fail;
 	}
 
-	cq->ib_cq.cqe = cq->resize_cqe;
+	bnxt_qplib_resize_cq_complete(&rdev->qplib_res, &cq->qplib_cq);
+
+	cq->qplib_cq.max_wqe = cq->resize_cqe;
+	ib_umem_release(cq->ib_cq.umem);
+	cq->ib_cq.umem = cq->resize_umem;
+	cq->resize_umem = NULL;
+	cq->resize_cqe = 0;
+
+	cq->ib_cq.cqe = entries;
 	atomic_inc(&rdev->stats.res.resize_count);
 
 	return 0;
@@ -3907,15 +3901,6 @@ int bnxt_re_poll_cq(struct ib_cq *ib_cq, int num_entries, struct ib_wc *wc)
 	struct bnxt_re_sqp_entries *sqp_entry = NULL;
 	unsigned long flags;
 
-	/* User CQ; the only processing we do is to
-	 * complete any pending CQ resize operation.
-	 */
-	if (cq->ib_cq.umem) {
-		if (cq->resize_umem)
-			bnxt_re_resize_cq_complete(cq);
-		return 0;
-	}
-
 	spin_lock_irqsave(&cq->cq_lock, flags);
 	budget = min_t(u32, num_entries, cq->max_cql);
 	num_entries = budget;

-- 
2.52.0


