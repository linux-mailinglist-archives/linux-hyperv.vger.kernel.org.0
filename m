Return-Path: <linux-hyperv+bounces-11953-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HTbuG72dVGoooQMAu9opvQ
	(envelope-from <linux-hyperv+bounces-11953-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 13 Jul 2026 10:11:41 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 82EAF74886E
	for <lists+linux-hyperv@lfdr.de>; Mon, 13 Jul 2026 10:11:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=JPe6aFAF;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11953-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11953-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D4DDE30091EA
	for <lists+linux-hyperv@lfdr.de>; Mon, 13 Jul 2026 08:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB28F3A6B76;
	Mon, 13 Jul 2026 08:10:53 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7134C3A451F;
	Mon, 13 Jul 2026 08:10:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783930253; cv=none; b=sJ+88PP/YjM3GlPMHOCNSdlHFK7D8q5JC7w97GnSTS4K3zn0dKupgE7igkJlRGg2rq0oF7vuvQvHXHcr4+l/Defd0LNeU6fWXGqd7sgDmVQ0UlKsxN5UQ8SVdyz2gzrRDrjzVgKD2ezcIS6QH0Q6WZuwyefiYweM+InG2V1l0ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783930253; c=relaxed/simple;
	bh=2wtDl9cqWSxofQC4HOGj+8Dirun9oX2QGYc6g148Ee0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oZu6ob/r9K1I2eRudBwVzzWAe3JN/6/1SWkXwxn/Aipec+mOlxo3X0+6DxVvlGJBRIs/Tr6R+9bHteSkgerPw/B6UKEFJcyOXQpZC9iiDe63K2/ataOLJWUz1wHSaIO/tmhzTEQ6g0O+XfCzN+3dVZWZwjJ3hfwOs/IyAeHBqZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JPe6aFAF; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10B6D1F000E9;
	Mon, 13 Jul 2026 08:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783930250;
	bh=oYl/ZCPb2/1UsGJ1CvAgoDwa/0oNbO5jCw1ejkSPLVc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JPe6aFAFUOqsRM0MK+OKaDEb5zbVQQeAgSHqxIIvUqZm2azyiERR88nc47ahbStV1
	 xLfhTIuRFY5CP68CasglWu+IF7zz2KxtJ8hrVmoLG9p+0sZy8/hEnfpDeZzU4JGIVs
	 6N2KSMuYywlycR/pfvNYoizRpcx3+bnVprDXusrQIWkh4P8UCHSKIgDo0p3ohwVSw/
	 CT+jjWyX8Eu9W/a4+/pJ/gngOohTOnYUdXhpwDFu6XtZxTO8a0K0ysY2Sz57P2Dhwn
	 zVoTBb6a4RbNl0gz6zeBP7Op0sABpkhywj2QZ/ki683LYcwi0R01N0f7MMwLRxJaRi
	 yDl81ZE5x0Y2Q==
From: Leon Romanovsky <leon@kernel.org>
To: Selvin Xavier <selvin.xavier@broadcom.com>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	Michael Margolin <mrgolin@amazon.com>,
	Gal Pressman <gal.pressman@linux.dev>,
	Yossi Leybovich <sleybo@amazon.com>,
	Cheng Xu <chengyou@linux.alibaba.com>,
	Kai Shen <kaishen@linux.alibaba.com>,
	Chengchang Tang <tangchengchang@huawei.com>,
	Junxian Huang <huangjunxian6@hisilicon.com>,
	Tatyana Nikolova <tatyana.e.nikolova@intel.com>,
	Long Li <longli@microsoft.com>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Michal Kalderon <mkalderon@marvell.com>,
	Nelson Escobar <neescoba@cisco.com>,
	Satish Kharat <satishkh@cisco.com>,
	Bernard Metzler <bernard.metzler@linux.dev>
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org
Subject: [PATCH rdma-next 1/2] RDMA/bnxt_re: Validate udata before destroying resources
Date: Mon, 13 Jul 2026 11:10:34 +0300
Message-ID: <20260713-fix-destroy-no-udata-v1-1-fcca2e34fd57@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260713-fix-destroy-no-udata-v1-0-fcca2e34fd57@nvidia.com>
References: <20260713-fix-destroy-no-udata-v1-0-fcca2e34fd57@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.15-dev-18f8f
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:selvin.xavier@broadcom.com,m:kalesh-anakkur.purayil@broadcom.com,m:jgg@ziepe.ca,m:leon@kernel.org,m:mrgolin@amazon.com,m:gal.pressman@linux.dev,m:sleybo@amazon.com,m:chengyou@linux.alibaba.com,m:kaishen@linux.alibaba.com,m:tangchengchang@huawei.com,m:huangjunxian6@hisilicon.com,m:tatyana.e.nikolova@intel.com,m:longli@microsoft.com,m:kotaranov@microsoft.com,m:yishaih@nvidia.com,m:mkalderon@marvell.com,m:neescoba@cisco.com,m:satishkh@cisco.com,m:bernard.metzler@linux.dev,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-hyperv@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[leon@kernel.org,linux-hyperv@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-11953-lists,linux-hyperv=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp,nvidia.com:mid,nvidia.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 82EAF74886E

From: Leon Romanovsky <leonro@nvidia.com>

The destroy callbacks currently zero the udata output after tearing down
their resources. If that userspace access fails, uverbs preserves the
uobject and permits the destroy callback to be entered again even though
the driver resource has already been released.

Use ib_no_udata_io() before teardown so all udata failures occur while the
resource is still intact, then return success after teardown completes.

Fixes: bed686d8dcd4 ("RDMA/bnxt_re: Use ib_respond_empty_udata()")
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/bnxt_re/ib_verbs.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index 565762529007..ef9943be1886 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -695,7 +695,7 @@ int bnxt_re_dealloc_pd(struct ib_pd *ib_pd, struct ib_udata *udata)
 	struct bnxt_re_dev *rdev = pd->rdev;
 	int ret;
 
-	ret = ib_is_udata_in_empty(udata);
+	ret = ib_no_udata_io(udata);
 	if (ret)
 		return ret;
 
@@ -712,7 +712,7 @@ int bnxt_re_dealloc_pd(struct ib_pd *ib_pd, struct ib_udata *udata)
 					   &pd->qplib_pd))
 			atomic_dec(&rdev->stats.res.pd_count);
 	}
-	return ib_respond_empty_udata(udata);
+	return 0;
 }
 
 int bnxt_re_alloc_pd(struct ib_pd *ibpd, struct ib_udata *udata)
@@ -1015,7 +1015,7 @@ int bnxt_re_destroy_qp(struct ib_qp *ib_qp, struct ib_udata *udata)
 	unsigned int flags;
 	int rc;
 
-	rc = ib_is_udata_in_empty(udata);
+	rc = ib_no_udata_io(udata);
 	if (rc)
 		return rc;
 
@@ -1064,7 +1064,7 @@ int bnxt_re_destroy_qp(struct ib_qp *ib_qp, struct ib_udata *udata)
 	if (scq_nq != rcq_nq)
 		bnxt_re_synchronize_nq(rcq_nq);
 
-	return ib_respond_empty_udata(udata);
+	return 0;
 }
 
 static u8 __from_ib_qp_type(enum ib_qp_type type)
@@ -2148,7 +2148,7 @@ int bnxt_re_destroy_srq(struct ib_srq *ib_srq, struct ib_udata *udata)
 	struct bnxt_qplib_srq *qplib_srq = &srq->qplib_srq;
 	int ret;
 
-	ret = ib_is_udata_in_empty(udata);
+	ret = ib_no_udata_io(udata);
 	if (ret)
 		return ret;
 
@@ -2159,7 +2159,7 @@ int bnxt_re_destroy_srq(struct ib_srq *ib_srq, struct ib_udata *udata)
 		free_page((unsigned long)srq->uctx_srq_page);
 	ib_umem_release(srq->umem);
 	atomic_dec(&rdev->stats.res.srq_count);
-	return ib_respond_empty_udata(udata);
+	return 0;
 }
 
 static int bnxt_re_init_user_srq(struct bnxt_re_dev *rdev,
@@ -3471,7 +3471,7 @@ int bnxt_re_destroy_cq(struct ib_cq *ib_cq, struct ib_udata *udata)
 	nq = cq->qplib_cq.nq;
 	cctx = rdev->chip_ctx;
 
-	ret = ib_is_udata_in_empty(udata);
+	ret = ib_no_udata_io(udata);
 	if (ret)
 		return ret;
 
@@ -3486,7 +3486,7 @@ int bnxt_re_destroy_cq(struct ib_cq *ib_cq, struct ib_udata *udata)
 	atomic_dec(&rdev->stats.res.cq_count);
 	kfree(cq->cql);
 	ib_umem_release(cq->umem);
-	return ib_respond_empty_udata(udata);
+	return 0;
 }
 
 int bnxt_re_create_user_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
@@ -4449,7 +4449,7 @@ int bnxt_re_dereg_mr(struct ib_mr *ib_mr, struct ib_udata *udata)
 	struct bnxt_re_dev *rdev = mr->rdev;
 	int rc;
 
-	rc = ib_is_udata_in_empty(udata);
+	rc = ib_no_udata_io(udata);
 	if (rc)
 		return rc;
 
@@ -4472,7 +4472,7 @@ int bnxt_re_dereg_mr(struct ib_mr *ib_mr, struct ib_udata *udata)
 	atomic_dec(&rdev->stats.res.mr_count);
 	if (rc)
 		return rc;
-	return ib_respond_empty_udata(udata);
+	return 0;
 }
 
 static int bnxt_re_set_page(struct ib_mr *ib_mr, u64 addr)

-- 
2.54.0


