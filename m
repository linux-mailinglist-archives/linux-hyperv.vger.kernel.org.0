Return-Path: <linux-hyperv+bounces-8830-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GJq0KhEGj2l5HQEAu9opvQ
	(envelope-from <linux-hyperv+bounces-8830-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Feb 2026 12:08:01 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 26A4B13578A
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Feb 2026 12:08:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E2BC3318F71A
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Feb 2026 11:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37159359FAA;
	Fri, 13 Feb 2026 11:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EPYdIPJB"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 130E635A92B;
	Fri, 13 Feb 2026 11:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770980457; cv=none; b=WMlLNdWstPmtq7vKa9RsA2WVIDosrjRXmnNKtulgVggxanUccC3Tr3xGOyo/2QcW6YwCDRZcYXqfYimMN8LHNzKfG9h6MUX4x9mfrAtcRIYbM9sCvpM4AwmYedL4xjrpiNeeKnfhaQJKo+63Wqlb/JflLv+TTYkXE6V/9gQf9ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770980457; c=relaxed/simple;
	bh=BLfJ8z/WpaD4K6sejQn96Wb7dREUsgFWZySiBeQGF9s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qpa5zaxzACKHYxkb1kmWHtcS6jen3hm1ajtqNgcc3dC5mZPerQFIrCFv5SdEBzvKoiw14UkKhUu+TVtrwwzeqGaktNLwkxcjOoyqD7GV3YTR0rmGr/nEyz4ewxaPzQ8fquNFnQVRtwmj+HQqIZKkSAbNwbJ578m1W9yaK11xu/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EPYdIPJB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E58A7C116C6;
	Fri, 13 Feb 2026 11:00:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770980456;
	bh=BLfJ8z/WpaD4K6sejQn96Wb7dREUsgFWZySiBeQGF9s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EPYdIPJBMbg5urgKDzfQeMyEA2s+G6InhG9YxUmme1Z1gXjttYwTpANTnGCF81Rvb
	 kQqFo4Zp6YYsbhlY9LpC4/e/bML7aH4u25piPRXi5+y/IJLgnuRnqu50l5MTo2vsue
	 FZg+m3AtEe3I5kqFSEpqr0LG2Ao0vRJ0oVca427aSsyLQj//08Oj/SgQbNhAv0ssDK
	 Ye4fjm1ts5N1dfq1tnFSc+Biz1ZO9F9CTu1nb1wiEiIR3KZgjU/qhJfIngnSF1okww
	 VdNW9Ib7zFUpQ5C0ptbPDGjWo1htRv0utxrKnqqI8TIaGaSbZyJWwdom4GFkH2J0oR
	 oNFagAdf3tmRw==
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
Subject: [PATCH rdma-next 33/50] RDMA/bnxt_re: Drop support for resizing kernel CQs
Date: Fri, 13 Feb 2026 12:58:09 +0200
Message-ID: <20260213-refactor-umem-v1-33-f3be85847922@nvidia.com>
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
	TAGGED_FROM(0.00)[bounces-8830-lists,linux-hyperv=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 26A4B13578A
X-Rspamd-Action: no action

From: Leon Romanovsky <leonro@nvidia.com>

There are no ULP callers that use the CQ resize functionality, so remove it.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/bnxt_re/ib_verbs.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index b8516d8b8426..16bb586d68c7 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -3338,10 +3338,6 @@ int bnxt_re_resize_cq(struct ib_cq *ibcq, int cqe, struct ib_udata *udata)
 	cq =  container_of(ibcq, struct bnxt_re_cq, ib_cq);
 	rdev = cq->rdev;
 	dev_attr = rdev->dev_attr;
-	if (!ibcq->uobject) {
-		ibdev_err(&rdev->ibdev, "Kernel CQ Resize not supported");
-		return -EOPNOTSUPP;
-	}
 
 	if (cq->resize_umem) {
 		ibdev_err(&rdev->ibdev, "Resize CQ %#x failed - Busy",
@@ -3375,7 +3371,7 @@ int bnxt_re_resize_cq(struct ib_cq *ibcq, int cqe, struct ib_udata *udata)
 		ibdev_err(&rdev->ibdev, "%s: ib_umem_get failed! rc = %pe\n",
 			  __func__, cq->resize_umem);
 		cq->resize_umem = NULL;
-		goto fail;
+		return rc;
 	}
 	cq->resize_cqe = entries;
 	memcpy(&sg_info, &cq->qplib_cq.sg_info, sizeof(sg_info));
@@ -3399,13 +3395,11 @@ int bnxt_re_resize_cq(struct ib_cq *ibcq, int cqe, struct ib_udata *udata)
 	return 0;
 
 fail:
-	if (cq->resize_umem) {
-		ib_umem_release(cq->resize_umem);
-		cq->resize_umem = NULL;
-		cq->resize_cqe = 0;
-		memcpy(&cq->qplib_cq.sg_info, &sg_info, sizeof(sg_info));
-		cq->qplib_cq.dpi = orig_dpi;
-	}
+	ib_umem_release(cq->resize_umem);
+	cq->resize_umem = NULL;
+	cq->resize_cqe = 0;
+	memcpy(&cq->qplib_cq.sg_info, &sg_info, sizeof(sg_info));
+	cq->qplib_cq.dpi = orig_dpi;
 	return rc;
 }
 

-- 
2.52.0


