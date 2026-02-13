Return-Path: <linux-hyperv+bounces-8836-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cIxUDrEGj2ltHQEAu9opvQ
	(envelope-from <linux-hyperv+bounces-8836-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Feb 2026 12:10:41 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 91D69135847
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Feb 2026 12:10:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9009D32110FF
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Feb 2026 11:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FE4136165D;
	Fri, 13 Feb 2026 11:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RCv3PXeU"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE843563EE;
	Fri, 13 Feb 2026 11:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770980478; cv=none; b=pubf+QqGLsrl6EI8IddqIkFB7hFBGg7bqdZ6MRNoGkgdHjFufWZg/Q7pBTVUOWo+vFaQdHDuYgVoyZYRNC2tCIcW41Ao3i4km1TCWt9hFrl7fxMlbqM8UjKpDyez8ufRopTX+/5OyC+rwgQxS+Th9Cs2PxzLlYu+wCUGeeWHcoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770980478; c=relaxed/simple;
	bh=otPh1I/moTb9nYti+CCiEiHRtjR31X2ZuYeuBozpQr8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HWixkQl+IXAQVur3v33pY5oKJh1emzYamVwgVptxidj96L4/i4OYwo5lPfO/NKtbA6u6yN09O1vPngHJ1l1Bsq4umcnOdqX3hXT5KW+2k50+UswEZK6pLP2m79ImznbFw2Agx0kpuaY+AXAZ8Cnv05Tw9HcrooCPAkjrLplxQG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RCv3PXeU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E292CC16AAE;
	Fri, 13 Feb 2026 11:01:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770980478;
	bh=otPh1I/moTb9nYti+CCiEiHRtjR31X2ZuYeuBozpQr8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RCv3PXeUjsvB/W0lgk2GT75S3jP2cqDXxgyQuXD9KtyVdMXL4cq55Eqn/aRbfmKgz
	 nKHhVE4uMcUk42KrBI9FzBdIs0/c4f9ZKuppi9bMvrI1ZrygD09Nl+137278SoHYvD
	 56AQEviOEzGwDjmPOrHKAaHLvv2HTkO78d/KEr/RlUydfZieLPn9M/VD3ppALIOGte
	 i7fdym+PHX+VK8TdjGyyw0mlfAnL0+sKsqK/g6ub8cN5HzfNCcM0Jz5N9vVmbqNeZx
	 Op1bZvjNnUhEAMu3LXI+YmI2P9YpltgW4hECBbhxKTFuXG8vesesi0JWu3EJnVL1z+
	 dAsf7bzNjqrOw==
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
Subject: =?utf-8?q?=5BPATCH_rdma-next_39/50=5D_RDMA/rxe=3A_Remove_unused_?= =?utf-8?q?kernel=E2=80=91side_CQ_resize_support?=
Date: Fri, 13 Feb 2026 12:58:15 +0200
Message-ID: <20260213-refactor-umem-v1-39-f3be85847922@nvidia.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
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
	TAGGED_FROM(0.00)[bounces-8836-lists,linux-hyperv=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 91D69135847
X-Rspamd-Action: no action

From: Leon Romanovsky <leonro@nvidia.com>

CQ resizing is only used by uverbs; the kernel‑side CQ resize path has
no users and can be removed.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/sw/rxe/rxe_verbs.c | 27 +++++++--------------------
 1 file changed, 7 insertions(+), 20 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index 72e3019ed1cb..bc7c77ff3d90 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -1146,32 +1146,19 @@ static int rxe_resize_cq(struct ib_cq *ibcq, int cqe, struct ib_udata *udata)
 	struct rxe_resize_cq_resp __user *uresp = NULL;
 	int err;
 
-	if (udata) {
-		if (udata->outlen < sizeof(*uresp)) {
-			err = -EINVAL;
-			rxe_dbg_cq(cq, "malformed udata\n");
-			goto err_out;
-		}
-		uresp = udata->outbuf;
-	}
+	if (udata->outlen < sizeof(*uresp))
+		return -EINVAL;
+	uresp = udata->outbuf;
 
 	err = rxe_cq_chk_attr(rxe, cq, cqe, 0);
-	if (err) {
-		rxe_dbg_cq(cq, "bad attr, err = %d\n", err);
-		goto err_out;
-	}
+	if (err)
+		return err;
 
 	err = rxe_cq_resize_queue(cq, cqe, uresp, udata);
-	if (err) {
-		rxe_dbg_cq(cq, "resize cq failed, err = %d\n", err);
-		goto err_out;
-	}
+	if (err)
+		return err;
 
 	return 0;
-
-err_out:
-	rxe_err_cq(cq, "returned err = %d\n", err);
-	return err;
 }
 
 static int rxe_poll_cq(struct ib_cq *ibcq, int num_entries, struct ib_wc *wc)

-- 
2.52.0


