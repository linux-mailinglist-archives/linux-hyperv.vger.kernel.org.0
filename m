Return-Path: <linux-hyperv+bounces-8819-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0CdALJwFj2ltHQEAu9opvQ
	(envelope-from <linux-hyperv+bounces-8819-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Feb 2026 12:06:04 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 33E151356D8
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Feb 2026 12:06:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 185F1312F4D7
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Feb 2026 11:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 653BF359718;
	Fri, 13 Feb 2026 11:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KHRERZpq"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D2234B661;
	Fri, 13 Feb 2026 11:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770980415; cv=none; b=mnTbH0NMrRr9Sf1CNsqsgrtwDvRNByaxyXmKT9JgrfXaYPDUUT0n1xLnpm/DSb55i3Npy2gGzzQtu3hIUOxnJX5lTKgPUZeAcyJOaCUqQoFCB6xMFAlk3bo2OoRWh2nB9q3Hjvcz/yAuZHggZEhhf3CpgwfhpEdZcqc20oUnxv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770980415; c=relaxed/simple;
	bh=a19PQ2D2C2DCb3hfZ+sOatc/4oV1zbjy3TOeGnf+Dj8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZB5PzdrQpMRjLpT69Hk5QM92T6ETHQNzqPH451SmezN0LMpheK2rl0wOodRTd4C9+slx0LvlFr6/R770vK5W5EGmaEk4XG1CwSZ4Chx51VE+Ld/sJg+kFuoEcQjvcmmy68RVxNqGWLGDkAeoiJNrKiFAdyChqiPWmIcPQwJ8+wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KHRERZpq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DC9CC16AAE;
	Fri, 13 Feb 2026 11:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770980415;
	bh=a19PQ2D2C2DCb3hfZ+sOatc/4oV1zbjy3TOeGnf+Dj8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KHRERZpq/kwOnJlNAtMLy4ABMFIGwIy5tc67If7UpWtDkSgv5sTONi3R4nhmT2JIK
	 iEmzfC47O8p/WdQGQzKSuBGmuLoLNGe32yGqNXuWZHsqCjfLROaUWepxVXv9aJ0IjM
	 u7ZbgPgUM3gSo8wZCpU+j7SmP+2BVJGdKLDbQCv1AVFiz8GhMcN71K2fUEu+VfODk/
	 Ry7cdQ3wthFxhPZh2BlaiYjanhFqlDTu8PMl51sRjtzI1ctNS0qx5eW/GPFJkpHnAk
	 0XV3jq633YSL8kRZ0UFRB/5ftBEhglJimbAoXP15VmvYmGaoKPn7TFCL57h725n8Gi
	 oz9535P/Opeqg==
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
Subject: [PATCH rdma-next 19/50] RDMA/ionic: Split user and kernel CQ creation paths
Date: Fri, 13 Feb 2026 12:57:55 +0200
Message-ID: <20260213-refactor-umem-v1-19-f3be85847922@nvidia.com>
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
	TAGGED_FROM(0.00)[bounces-8819-lists,linux-hyperv=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 33E151356D8
X-Rspamd-Action: no action

From: Leon Romanovsky <leonro@nvidia.com>

Separate the CQ creation logic into distinct kernel and user flows. The ionic
driver may allocate two umems per CQ, and the current layout prevents it from
supporting generic umem sources (VMA, dmabuf, memfd, and others).

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/ionic/ionic_controlpath.c | 88 +++++++++++++++++--------
 drivers/infiniband/hw/ionic/ionic_ibdev.c       |  1 +
 drivers/infiniband/hw/ionic/ionic_ibdev.h       |  2 +
 3 files changed, 64 insertions(+), 27 deletions(-)

diff --git a/drivers/infiniband/hw/ionic/ionic_controlpath.c b/drivers/infiniband/hw/ionic/ionic_controlpath.c
index ea12d9b8e125..5b8b6baaf5d4 100644
--- a/drivers/infiniband/hw/ionic/ionic_controlpath.c
+++ b/drivers/infiniband/hw/ionic/ionic_controlpath.c
@@ -89,7 +89,7 @@ int ionic_create_cq_common(struct ionic_vcq *vcq,
 
 	cq->vcq = vcq;
 
-	if (attr->cqe < 1 || attr->cqe + IONIC_CQ_GRACE > 0xffff) {
+	if (attr->cqe > 0xffff - IONIC_CQ_GRACE) {
 		rc = -EINVAL;
 		goto err_args;
 	}
@@ -1209,8 +1209,8 @@ static int ionic_destroy_cq_cmd(struct ionic_ibdev *dev, u32 cqid)
 	return ionic_admin_wait(dev, &wr, IONIC_ADMIN_F_TEARDOWN);
 }
 
-int ionic_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
-		    struct uverbs_attr_bundle *attrs)
+int ionic_create_user_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
+			 struct uverbs_attr_bundle *attrs)
 {
 	struct ionic_ibdev *dev = to_ionic_ibdev(ibcq->device);
 	struct ib_udata *udata = &attrs->driver_udata;
@@ -1222,21 +1222,18 @@ int ionic_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 	struct ionic_cq_req req;
 	int udma_idx = 0, rc;
 
-	if (udata) {
-		rc = ib_copy_from_udata(&req, udata, sizeof(req));
-		if (rc)
-			return rc;
-	}
+	if (ibcq->umem)
+		return -EOPNOTSUPP;
 
-	vcq->udma_mask = BIT(dev->lif_cfg.udma_count) - 1;
+	rc = ib_copy_from_udata(&req, udata, sizeof(req));
+	if (rc)
+		return rc;
 
-	if (udata)
-		vcq->udma_mask &= req.udma_mask;
+	vcq->udma_mask = BIT(dev->lif_cfg.udma_count) - 1;
+	vcq->udma_mask &= req.udma_mask;
 
-	if (!vcq->udma_mask) {
-		rc = -EINVAL;
-		goto err_init;
-	}
+	if (!vcq->udma_mask)
+		return -EINVAL;
 
 	for (; udma_idx < dev->lif_cfg.udma_count; ++udma_idx) {
 		if (!(vcq->udma_mask & BIT(udma_idx)))
@@ -1247,24 +1244,25 @@ int ionic_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 					    &resp.cqid[udma_idx],
 					    udma_idx);
 		if (rc)
-			goto err_init;
+			goto err_resp;
 
 		rc = ionic_create_cq_cmd(dev, ctx, &vcq->cq[udma_idx], &buf);
-		if (rc)
-			goto err_cmd;
+		if (rc) {
+			ionic_pgtbl_unbuf(dev, &buf);
+			ionic_destroy_cq_common(dev, &vcq->cq[udma_idx]);
+			goto err_resp;
+		}
 
 		ionic_pgtbl_unbuf(dev, &buf);
 	}
 
 	vcq->ibcq.cqe = attr->cqe;
 
-	if (udata) {
-		resp.udma_mask = vcq->udma_mask;
+	resp.udma_mask = vcq->udma_mask;
 
-		rc = ib_copy_to_udata(udata, &resp, sizeof(resp));
-		if (rc)
-			goto err_resp;
-	}
+	rc = ib_copy_to_udata(udata, &resp, sizeof(resp));
+	if (rc)
+		goto err_resp;
 
 	return 0;
 
@@ -1274,11 +1272,47 @@ int ionic_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 		if (!(vcq->udma_mask & BIT(udma_idx)))
 			continue;
 		ionic_destroy_cq_cmd(dev, vcq->cq[udma_idx].cqid);
-err_cmd:
 		ionic_pgtbl_unbuf(dev, &buf);
 		ionic_destroy_cq_common(dev, &vcq->cq[udma_idx]);
-err_init:
-		;
+	}
+
+	return rc;
+}
+
+int ionic_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
+		    struct uverbs_attr_bundle *attrs)
+{
+	struct ionic_ibdev *dev = to_ionic_ibdev(ibcq->device);
+	struct ionic_vcq *vcq = to_ionic_vcq(ibcq);
+	struct ionic_tbl_buf buf = {};
+	int udma_idx = 0, rc;
+
+	vcq->udma_mask = BIT(dev->lif_cfg.udma_count) - 1;
+	for (; udma_idx < dev->lif_cfg.udma_count; ++udma_idx) {
+		rc = ionic_create_cq_common(vcq, &buf, attr, NULL, NULL, NULL,
+					    NULL, udma_idx);
+		if (rc)
+			goto err_resp;
+
+		rc = ionic_create_cq_cmd(dev, NULL, &vcq->cq[udma_idx], &buf);
+		if (rc) {
+			ionic_pgtbl_unbuf(dev, &buf);
+			ionic_destroy_cq_common(dev, &vcq->cq[udma_idx]);
+			goto err_resp;
+		}
+
+		ionic_pgtbl_unbuf(dev, &buf);
+	}
+
+	vcq->ibcq.cqe = attr->cqe;
+
+	return 0;
+
+err_resp:
+	while (udma_idx--) {
+		ionic_destroy_cq_cmd(dev, vcq->cq[udma_idx].cqid);
+		ionic_pgtbl_unbuf(dev, &buf);
+		ionic_destroy_cq_common(dev, &vcq->cq[udma_idx]);
 	}
 
 	return rc;
diff --git a/drivers/infiniband/hw/ionic/ionic_ibdev.c b/drivers/infiniband/hw/ionic/ionic_ibdev.c
index 164046d00e5d..32321a8996d6 100644
--- a/drivers/infiniband/hw/ionic/ionic_ibdev.c
+++ b/drivers/infiniband/hw/ionic/ionic_ibdev.c
@@ -229,6 +229,7 @@ static const struct ib_device_ops ionic_dev_ops = {
 	.alloc_mw = ionic_alloc_mw,
 	.dealloc_mw = ionic_dealloc_mw,
 	.create_cq = ionic_create_cq,
+	.create_user_cq = ionic_create_user_cq,
 	.destroy_cq = ionic_destroy_cq,
 	.create_qp = ionic_create_qp,
 	.modify_qp = ionic_modify_qp,
diff --git a/drivers/infiniband/hw/ionic/ionic_ibdev.h b/drivers/infiniband/hw/ionic/ionic_ibdev.h
index 63828240d659..0bcb8be6fb62 100644
--- a/drivers/infiniband/hw/ionic/ionic_ibdev.h
+++ b/drivers/infiniband/hw/ionic/ionic_ibdev.h
@@ -482,6 +482,8 @@ int ionic_alloc_mw(struct ib_mw *ibmw, struct ib_udata *udata);
 int ionic_dealloc_mw(struct ib_mw *ibmw);
 int ionic_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 		    struct uverbs_attr_bundle *attrs);
+int ionic_create_user_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
+			 struct uverbs_attr_bundle *attrs);
 int ionic_destroy_cq(struct ib_cq *ibcq, struct ib_udata *udata);
 int ionic_create_qp(struct ib_qp *ibqp, struct ib_qp_init_attr *attr,
 		    struct ib_udata *udata);

-- 
2.52.0


