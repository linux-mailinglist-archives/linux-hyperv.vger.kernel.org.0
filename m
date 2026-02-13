Return-Path: <linux-hyperv+bounces-8825-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4CFdHssGj2mOHQEAu9opvQ
	(envelope-from <linux-hyperv+bounces-8825-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Feb 2026 12:11:07 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 13BB0135882
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Feb 2026 12:11:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 94C7130E9EA5
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Feb 2026 11:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 848323596FF;
	Fri, 13 Feb 2026 11:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OQsyLbX0"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED351F03EF;
	Fri, 13 Feb 2026 11:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770980438; cv=none; b=E3fw5D71xqxQUvgaYZZ1Oe/Q5KuzilqmnkETH/rqZpvVonc0v8BvV2Frgk5m2zjn4pliE7jmJJvYMdRggxS4+3Gde6ZdGedn7b+UXzTbTmNtaWTdu6fQee5SuI+ZwWpbnlqC5Jrtgw25f6d9elNMO6jjPuIYTpH7qNx+ra8yA9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770980438; c=relaxed/simple;
	bh=lO34ijZAFdv5MXws8lPiMPsCemhr7GqNyljZmJLSdMo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T/E6rAORBFZqInz0aw7HzJ3HfVc6/O2eTLEU/4ALK+nzERQtaVfzp9MmpPMTmEj9GdFzJHckdrY4SBtEMdMk8I41Z+NVdoZIxUoS4/VozRWuJ5EMq0o3OdicOaIkWzq8SCdS2JhJOBleA3Owjm61719xe4BqxH7WeCMNyMEjAXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OQsyLbX0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 363B2C16AAE;
	Fri, 13 Feb 2026 11:00:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770980437;
	bh=lO34ijZAFdv5MXws8lPiMPsCemhr7GqNyljZmJLSdMo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OQsyLbX07Wd4X+KOi9GPiRxqhZqgk47Pm1cOoHdR7jbavG0svkRZu7FCg+cIYcmGK
	 /2ATr4WULSKbyztLNbV5MdldX1QQltX6LTnQcp6VIja2goeY1gduWa1NUQiQ5w9saf
	 4efkmrJX9uNDXSxBmDzjXVTAOor/plFlRURBv35cJBAK8l97uuRBh/52WWRbXd2OK7
	 2c6N11HDk0xAo0ije+0M5ppYh6M41Qhk1V6ludoxSTwiwmTw5xJ3+Gi7cQxcPjs+tI
	 TK7PCyrxDXU19bYClVh/5b4sYcJ+qxinnU9ZjGeXjFmB+DK6z1VoEzhGKCWWyrA7AO
	 ycanOFk9Lwr0g==
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
Subject: [PATCH rdma-next 28/50] RDMA/siw: Split user and kernel CQ creation paths
Date: Fri, 13 Feb 2026 12:58:04 +0200
Message-ID: <20260213-refactor-umem-v1-28-f3be85847922@nvidia.com>
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
	TAGGED_FROM(0.00)[bounces-8825-lists,linux-hyperv=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:mid,nvidia.com:email]
X-Rspamd-Queue-Id: 13BB0135882
X-Rspamd-Action: no action

From: Leon Romanovsky <leonro@nvidia.com>

Separate the CQ creation logic into distinct kernel and user flows.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/sw/siw/siw_main.c  |   1 +
 drivers/infiniband/sw/siw/siw_verbs.c | 111 +++++++++++++++++++++++-----------
 drivers/infiniband/sw/siw/siw_verbs.h |   2 +
 3 files changed, 80 insertions(+), 34 deletions(-)

diff --git a/drivers/infiniband/sw/siw/siw_main.c b/drivers/infiniband/sw/siw/siw_main.c
index 5168307229a9..75dcf3578eac 100644
--- a/drivers/infiniband/sw/siw/siw_main.c
+++ b/drivers/infiniband/sw/siw/siw_main.c
@@ -232,6 +232,7 @@ static const struct ib_device_ops siw_device_ops = {
 	.alloc_pd = siw_alloc_pd,
 	.alloc_ucontext = siw_alloc_ucontext,
 	.create_cq = siw_create_cq,
+	.create_user_cq = siw_create_user_cq,
 	.create_qp = siw_create_qp,
 	.create_srq = siw_create_srq,
 	.dealloc_driver = siw_device_cleanup,
diff --git a/drivers/infiniband/sw/siw/siw_verbs.c b/drivers/infiniband/sw/siw/siw_verbs.c
index efa2f097b582..92b25b389b69 100644
--- a/drivers/infiniband/sw/siw/siw_verbs.c
+++ b/drivers/infiniband/sw/siw/siw_verbs.c
@@ -1139,15 +1139,15 @@ int siw_destroy_cq(struct ib_cq *base_cq, struct ib_udata *udata)
  * @attrs: uverbs bundle
  */
 
-int siw_create_cq(struct ib_cq *base_cq, const struct ib_cq_init_attr *attr,
-		  struct uverbs_attr_bundle *attrs)
+int siw_create_user_cq(struct ib_cq *base_cq, const struct ib_cq_init_attr *attr,
+		       struct uverbs_attr_bundle *attrs)
 {
 	struct ib_udata *udata = &attrs->driver_udata;
 	struct siw_device *sdev = to_siw_dev(base_cq->device);
 	struct siw_cq *cq = to_siw_cq(base_cq);
 	int rv, size = attr->cqe;
 
-	if (attr->flags)
+	if (attr->flags || base_cq->umem)
 		return -EOPNOTSUPP;
 
 	if (atomic_inc_return(&sdev->num_cq) > SIW_MAX_CQ) {
@@ -1155,7 +1155,7 @@ int siw_create_cq(struct ib_cq *base_cq, const struct ib_cq_init_attr *attr,
 		rv = -ENOMEM;
 		goto err_out;
 	}
-	if (size < 1 || size > sdev->attrs.max_cqe) {
+	if (attr->cqe > sdev->attrs.max_cqe) {
 		siw_dbg(base_cq->device, "CQ size error: %d\n", size);
 		rv = -EINVAL;
 		goto err_out;
@@ -1164,13 +1164,8 @@ int siw_create_cq(struct ib_cq *base_cq, const struct ib_cq_init_attr *attr,
 	cq->base_cq.cqe = size;
 	cq->num_cqe = size;
 
-	if (udata)
-		cq->queue = vmalloc_user(size * sizeof(struct siw_cqe) +
-					 sizeof(struct siw_cq_ctrl));
-	else
-		cq->queue = vzalloc(size * sizeof(struct siw_cqe) +
-				    sizeof(struct siw_cq_ctrl));
-
+	cq->queue = vmalloc_user(size * sizeof(struct siw_cqe) +
+				 sizeof(struct siw_cq_ctrl));
 	if (cq->queue == NULL) {
 		rv = -ENOMEM;
 		goto err_out;
@@ -1182,33 +1177,32 @@ int siw_create_cq(struct ib_cq *base_cq, const struct ib_cq_init_attr *attr,
 
 	cq->notify = (struct siw_cq_ctrl *)&cq->queue[size];
 
-	if (udata) {
-		struct siw_uresp_create_cq uresp = {};
-		struct siw_ucontext *ctx =
-			rdma_udata_to_drv_context(udata, struct siw_ucontext,
-						  base_ucontext);
-		size_t length = size * sizeof(struct siw_cqe) +
-			sizeof(struct siw_cq_ctrl);
+	struct siw_uresp_create_cq uresp = {};
+	struct siw_ucontext *ctx =
+		rdma_udata_to_drv_context(udata, struct siw_ucontext,
+					  base_ucontext);
+	size_t length = size * sizeof(struct siw_cqe) +
+		sizeof(struct siw_cq_ctrl);
 
-		cq->cq_entry =
-			siw_mmap_entry_insert(ctx, cq->queue,
-					      length, &uresp.cq_key);
-		if (!cq->cq_entry) {
-			rv = -ENOMEM;
-			goto err_out;
-		}
+	cq->cq_entry =
+		siw_mmap_entry_insert(ctx, cq->queue,
+				      length, &uresp.cq_key);
+	if (!cq->cq_entry) {
+		rv = -ENOMEM;
+		goto err_out;
+	}
 
-		uresp.cq_id = cq->id;
-		uresp.num_cqe = size;
+	uresp.cq_id = cq->id;
+	uresp.num_cqe = size;
 
-		if (udata->outlen < sizeof(uresp)) {
-			rv = -EINVAL;
-			goto err_out;
-		}
-		rv = ib_copy_to_udata(udata, &uresp, sizeof(uresp));
-		if (rv)
-			goto err_out;
+	if (udata->outlen < sizeof(uresp)) {
+		rv = -EINVAL;
+		goto err_out;
 	}
+	rv = ib_copy_to_udata(udata, &uresp, sizeof(uresp));
+	if (rv)
+		goto err_out;
+
 	return 0;
 
 err_out:
@@ -1227,6 +1221,55 @@ int siw_create_cq(struct ib_cq *base_cq, const struct ib_cq_init_attr *attr,
 	return rv;
 }
 
+int siw_create_cq(struct ib_cq *base_cq, const struct ib_cq_init_attr *attr,
+		  struct uverbs_attr_bundle *attrs)
+{
+	struct siw_device *sdev = to_siw_dev(base_cq->device);
+	struct siw_cq *cq = to_siw_cq(base_cq);
+	int rv, size = attr->cqe;
+
+	if (attr->flags)
+		return -EOPNOTSUPP;
+
+	if (atomic_inc_return(&sdev->num_cq) > SIW_MAX_CQ) {
+		siw_dbg(base_cq->device, "too many CQ's\n");
+		rv = -ENOMEM;
+		goto err_out;
+	}
+	if (size < 1 || size > sdev->attrs.max_cqe) {
+		siw_dbg(base_cq->device, "CQ size error: %d\n", size);
+		rv = -EINVAL;
+		goto err_out;
+	}
+	size = roundup_pow_of_two(size);
+	cq->base_cq.cqe = size;
+	cq->num_cqe = size;
+
+	cq->queue = vzalloc(size * sizeof(struct siw_cqe) +
+			    sizeof(struct siw_cq_ctrl));
+	if (cq->queue == NULL) {
+		rv = -ENOMEM;
+		goto err_out;
+	}
+	get_random_bytes(&cq->id, 4);
+	siw_dbg(base_cq->device, "new CQ [%u]\n", cq->id);
+
+	spin_lock_init(&cq->lock);
+
+	cq->notify = (struct siw_cq_ctrl *)&cq->queue[size];
+
+	return 0;
+
+err_out:
+	siw_dbg(base_cq->device, "CQ creation failed: %d", rv);
+
+	if (cq->queue)
+		vfree(cq->queue);
+	atomic_dec(&sdev->num_cq);
+
+	return rv;
+}
+
 /*
  * siw_poll_cq()
  *
diff --git a/drivers/infiniband/sw/siw/siw_verbs.h b/drivers/infiniband/sw/siw/siw_verbs.h
index e9f4463aecdc..527c356b55af 100644
--- a/drivers/infiniband/sw/siw/siw_verbs.h
+++ b/drivers/infiniband/sw/siw/siw_verbs.h
@@ -44,6 +44,8 @@ int siw_query_device(struct ib_device *base_dev, struct ib_device_attr *attr,
 		     struct ib_udata *udata);
 int siw_create_cq(struct ib_cq *base_cq, const struct ib_cq_init_attr *attr,
 		  struct uverbs_attr_bundle *attrs);
+int siw_create_user_cq(struct ib_cq *base_cq, const struct ib_cq_init_attr *attr,
+		       struct uverbs_attr_bundle *attrs);
 int siw_query_port(struct ib_device *base_dev, u32 port,
 		   struct ib_port_attr *attr);
 int siw_query_gid(struct ib_device *base_dev, u32 port, int idx,

-- 
2.52.0


