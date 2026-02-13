Return-Path: <linux-hyperv+bounces-8829-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EAc5KHAGj2ltHQEAu9opvQ
	(envelope-from <linux-hyperv+bounces-8829-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Feb 2026 12:09:36 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C45F1357FB
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Feb 2026 12:09:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 85A82316928B
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Feb 2026 11:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D284F35F8B4;
	Fri, 13 Feb 2026 11:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iNQ8039N"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF07335F8D1;
	Fri, 13 Feb 2026 11:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770980452; cv=none; b=GrJfdly1WKm0mhhHs8bpNk7bsdCepYBOxqgSFh3vWMzf3vah54pVYfIXfdMiU9rTBknwrxk7ketbRyCz8Kha5EhhaCcRRIl7tOMRnB4jddArl3zEtaivtWfyyhHQf0exVzPY+5DxOqPWWJuqP+c/KCINQaqBjpCg3Ra/8K730ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770980452; c=relaxed/simple;
	bh=50qG2y5fbQy5Qu3vQ5GMSNOhKd9VjZpb7hrkivZKUF0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pL36tesiLriiu98TO6+WopIjgGMCPEIP9Cm0wOivPlrTwjRGXNchdLqciV4UuzaetBnl94LDFS+0/EIR3MbKB5qBE8kf8688xAGvapBtuz/Yjsf27EtOsUyM2OdkbcdiJRZ0a5naPlWxlBEiA0HSzdBFCKwcDgZSqvYL05xpe1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iNQ8039N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF500C116C6;
	Fri, 13 Feb 2026 11:00:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770980452;
	bh=50qG2y5fbQy5Qu3vQ5GMSNOhKd9VjZpb7hrkivZKUF0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iNQ8039NrIVSCwVGb42NPQhWrtdZI6BEGf3kdgt10LNUfPlVvdrvC9aFbqux2814v
	 Q6Hx/eGuJUbiciVHJJTVC0PE7/HnQEptVYgGRlZRozvPdNglmd7EU3vi1uVioqsWXY
	 u72yd/ptaS/utW9GMMHForver2HIdD7Azzx7eq5emHS1mR9Q3UoTNoYOIzIVkIqm75
	 Ub3aELkOYY+EGfjiEjW523Dk6j8Q0Lc3Qid95/I3HGiy+lTPr2bZvnhvbfqyf/JLaT
	 uSk6JOLCyjIb3MnMZqo5CN0l3CcESnxh4cHPVMYgXLyWxlKAEdIdf2A8SvKh6ASM6T
	 cRCoNHtzUtMqg==
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
Subject: [PATCH rdma-next 29/50] RDMA/rxe: Split user and kernel CQ creation paths
Date: Fri, 13 Feb 2026 12:58:05 +0200
Message-ID: <20260213-refactor-umem-v1-29-f3be85847922@nvidia.com>
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
	TAGGED_FROM(0.00)[bounces-8829-lists,linux-hyperv=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4C45F1357FB
X-Rspamd-Action: no action

From: Leon Romanovsky <leonro@nvidia.com>

Separate the CQ creation logic into distinct kernel and user flows.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/sw/rxe/rxe_verbs.c | 81 ++++++++++++++++++++---------------
 1 file changed, 47 insertions(+), 34 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index 38d8c408320f..1e651bdd8622 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -1072,58 +1072,70 @@ static int rxe_post_recv(struct ib_qp *ibqp, const struct ib_recv_wr *wr,
 }
 
 /* cq */
-static int rxe_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
-			 struct uverbs_attr_bundle *attrs)
+static int rxe_create_user_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
+			      struct uverbs_attr_bundle *attrs)
 {
 	struct ib_udata *udata = &attrs->driver_udata;
 	struct ib_device *dev = ibcq->device;
 	struct rxe_dev *rxe = to_rdev(dev);
 	struct rxe_cq *cq = to_rcq(ibcq);
-	struct rxe_create_cq_resp __user *uresp = NULL;
-	int err, cleanup_err;
+	struct rxe_create_cq_resp __user *uresp;
+	int err;
 
-	if (udata) {
-		if (udata->outlen < sizeof(*uresp)) {
-			err = -EINVAL;
-			rxe_dbg_dev(rxe, "malformed udata, err = %d\n", err);
-			goto err_out;
-		}
-		uresp = udata->outbuf;
-	}
+	if (udata->outlen < sizeof(*uresp))
+		return -EINVAL;
 
-	if (attr->flags) {
-		err = -EOPNOTSUPP;
-		rxe_dbg_dev(rxe, "bad attr->flags, err = %d\n", err);
-		goto err_out;
-	}
+	uresp = udata->outbuf;
 
-	err = rxe_cq_chk_attr(rxe, NULL, attr->cqe, attr->comp_vector);
-	if (err) {
-		rxe_dbg_dev(rxe, "bad init attributes, err = %d\n", err);
-		goto err_out;
-	}
+	if (attr->flags || ibcq->umem)
+		return -EOPNOTSUPP;
+
+	if (attr->cqe > rxe->attr.max_cqe)
+		return -EINVAL;
 
 	err = rxe_add_to_pool(&rxe->cq_pool, cq);
-	if (err) {
-		rxe_dbg_dev(rxe, "unable to create cq, err = %d\n", err);
-		goto err_out;
-	}
+	if (err)
+		return err;
 
 	err = rxe_cq_from_init(rxe, cq, attr->cqe, attr->comp_vector, udata,
 			       uresp);
-	if (err) {
-		rxe_dbg_cq(cq, "create cq failed, err = %d\n", err);
+	if (err)
 		goto err_cleanup;
-	}
 
 	return 0;
 
 err_cleanup:
-	cleanup_err = rxe_cleanup(cq);
-	if (cleanup_err)
-		rxe_err_cq(cq, "cleanup failed, err = %d\n", cleanup_err);
-err_out:
-	rxe_err_dev(rxe, "returned err = %d\n", err);
+	rxe_cleanup(cq);
+	return err;
+}
+
+static int rxe_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
+			 struct uverbs_attr_bundle *attrs)
+{
+	struct ib_device *dev = ibcq->device;
+	struct rxe_dev *rxe = to_rdev(dev);
+	struct rxe_cq *cq = to_rcq(ibcq);
+	int err;
+
+	if (attr->flags)
+		return -EOPNOTSUPP;
+
+	if (attr->cqe > rxe->attr.max_cqe)
+		return -EINVAL;
+
+	err = rxe_add_to_pool(&rxe->cq_pool, cq);
+	if (err)
+		return err;
+
+	err = rxe_cq_from_init(rxe, cq, attr->cqe, attr->comp_vector, NULL,
+			       NULL);
+	if (err)
+		goto err_cleanup;
+
+	return 0;
+
+err_cleanup:
+	rxe_cleanup(cq);
 	return err;
 }
 
@@ -1478,6 +1490,7 @@ static const struct ib_device_ops rxe_dev_ops = {
 	.attach_mcast = rxe_attach_mcast,
 	.create_ah = rxe_create_ah,
 	.create_cq = rxe_create_cq,
+	.create_user_cq = rxe_create_user_cq,
 	.create_qp = rxe_create_qp,
 	.create_srq = rxe_create_srq,
 	.create_user_ah = rxe_create_ah,

-- 
2.52.0


