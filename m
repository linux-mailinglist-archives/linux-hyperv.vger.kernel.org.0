Return-Path: <linux-hyperv+bounces-8824-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SH7iFcQGj2ltHQEAu9opvQ
	(envelope-from <linux-hyperv+bounces-8824-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Feb 2026 12:11:00 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C4C25135872
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Feb 2026 12:10:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1FB2730EA507
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Feb 2026 11:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 849C635CBA0;
	Fri, 13 Feb 2026 11:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uMJrFKtV"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60952357A20;
	Fri, 13 Feb 2026 11:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770980434; cv=none; b=blrjHMre50gQSBYEGiPTIKPbbeVPJx9Ez1R2VHrYTfP9i2z/anfgcW6n4Yl1r8IMaUeIXp+Zq+9mHIRYEoKmf2u17XGmgRLirylHJ9eCGPiwYai+U6qXFp2C7M/uLfDPoIu5FYvhUGCg6YnapIfCZpFwScP6FSAvMsnsgdgU5rQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770980434; c=relaxed/simple;
	bh=CfrMYU/15f4o2XvVTfBv9vkCjczWWAriZsLMaye5SOY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iQEL6gWArUfaYMs7Eug0Q4PTkkbseupKtoSdXD4IBQRt6QI3ewuCA4dWVR0mwTWU5AVQmBCs/oEWkhjLgScesoVFlcPmxdw6RiLkqYSj6sy6mORW/Ez/bT3mVzSRqe5IVx2OymNkZNhbUDQ8SCYta/WZGnkZbectbrHNtPhSG7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uMJrFKtV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70135C19424;
	Fri, 13 Feb 2026 11:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770980434;
	bh=CfrMYU/15f4o2XvVTfBv9vkCjczWWAriZsLMaye5SOY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uMJrFKtVI2JIyTWDjhNcZlNAmVSEOfnL0xM5gvfDvOgi5aZuD8TKA/I46F8goWd0u
	 d7OSscH5aIrjU4dDy8WIFxb8KD3VENziaf0//CuZZKIcxV88+Sawjtsh4TSy1oTSPM
	 kBVbGQjeFqhoKPal2m03tfaK+7OGBvqtOUzjkATQK5x7s6ng6sBmA8xWgcTByGE5m2
	 McG1JsFno7R6KMYgdqEkqC80t378P4YtxUx5hzE/Hgmz+xky+obZYHzcM3ypROc18s
	 cFhzkXyLrRs+Shm6AbdlvG8WPq7j297fRqOReegAcxNFnmcTliqe9XuMqEqVXiQ5ha
	 yyARplxu5mhAQ==
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
Subject: [PATCH rdma-next 27/50] RDMA/rdmavt: Split user and kernel CQ creation paths
Date: Fri, 13 Feb 2026 12:58:03 +0200
Message-ID: <20260213-refactor-umem-v1-27-f3be85847922@nvidia.com>
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
	TAGGED_FROM(0.00)[bounces-8824-lists,linux-hyperv=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:mid,nvidia.com:email]
X-Rspamd-Queue-Id: C4C25135872
X-Rspamd-Action: no action

From: Leon Romanovsky <leonro@nvidia.com>

Separate the CQ creation logic into distinct kernel and user flows.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/sw/rdmavt/cq.c | 144 +++++++++++++++++++++++++++-----------
 drivers/infiniband/sw/rdmavt/cq.h |   2 +
 drivers/infiniband/sw/rdmavt/vt.c |   1 +
 3 files changed, 106 insertions(+), 41 deletions(-)

diff --git a/drivers/infiniband/sw/rdmavt/cq.c b/drivers/infiniband/sw/rdmavt/cq.c
index e7835ca70e2b..db86eb026bb3 100644
--- a/drivers/infiniband/sw/rdmavt/cq.c
+++ b/drivers/infiniband/sw/rdmavt/cq.c
@@ -147,33 +147,32 @@ static void send_complete(struct work_struct *work)
 }
 
 /**
- * rvt_create_cq - create a completion queue
+ * rvt_create_user_cq - create a completion queue for userspace
  * @ibcq: Allocated CQ
  * @attr: creation attributes
  * @attrs: uverbs bundle
  *
- * Called by ib_create_cq() in the generic verbs code.
+ * Called by ib_create_cq() in the generic verbs code for userspace CQs.
  *
  * Return: 0 on success
  */
-int rvt_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
-		  struct uverbs_attr_bundle *attrs)
+int rvt_create_user_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
+		       struct uverbs_attr_bundle *attrs)
 {
 	struct ib_udata *udata = &attrs->driver_udata;
 	struct ib_device *ibdev = ibcq->device;
 	struct rvt_dev_info *rdi = ib_to_rvt(ibdev);
 	struct rvt_cq *cq = ibcq_to_rvtcq(ibcq);
-	struct rvt_cq_wc *u_wc = NULL;
-	struct rvt_k_cq_wc *k_wc = NULL;
+	struct rvt_cq_wc *u_wc;
 	u32 sz;
 	unsigned int entries = attr->cqe;
 	int comp_vector = attr->comp_vector;
 	int err;
 
-	if (attr->flags)
+	if (attr->flags || ibcq->umem)
 		return -EOPNOTSUPP;
 
-	if (entries < 1 || entries > rdi->dparms.props.max_cqe)
+	if (entries > rdi->dparms.props.max_cqe)
 		return -EINVAL;
 
 	if (comp_vector < 0)
@@ -188,37 +187,27 @@ int rvt_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 	 * We need to use vmalloc() in order to support mmap and large
 	 * numbers of entries.
 	 */
-	if (udata && udata->outlen >= sizeof(__u64)) {
-		sz = sizeof(struct ib_uverbs_wc) * (entries + 1);
-		sz += sizeof(*u_wc);
-		u_wc = vmalloc_user(sz);
-		if (!u_wc)
-			return -ENOMEM;
-	} else {
-		sz = sizeof(struct ib_wc) * (entries + 1);
-		sz += sizeof(*k_wc);
-		k_wc = vzalloc_node(sz, rdi->dparms.node);
-		if (!k_wc)
-			return -ENOMEM;
-	}
+	sz = sizeof(struct ib_uverbs_wc) * (entries + 1);
+	sz += sizeof(*u_wc);
+	u_wc = vmalloc_user(sz);
+	if (!u_wc)
+		return -ENOMEM;
 
 	/*
 	 * Return the address of the WC as the offset to mmap.
 	 * See rvt_mmap() for details.
 	 */
-	if (udata && udata->outlen >= sizeof(__u64)) {
-		cq->ip = rvt_create_mmap_info(rdi, sz, udata, u_wc);
-		if (IS_ERR(cq->ip)) {
-			err = PTR_ERR(cq->ip);
-			goto bail_wc;
-		}
-
-		err = ib_copy_to_udata(udata, &cq->ip->offset,
-				       sizeof(cq->ip->offset));
-		if (err)
-			goto bail_ip;
+	cq->ip = rvt_create_mmap_info(rdi, sz, udata, u_wc);
+	if (IS_ERR(cq->ip)) {
+		err = PTR_ERR(cq->ip);
+		goto bail_wc;
 	}
 
+	err = ib_copy_to_udata(udata, &cq->ip->offset,
+			       sizeof(cq->ip->offset));
+	if (err)
+		goto bail_ip;
+
 	spin_lock_irq(&rdi->n_cqs_lock);
 	if (rdi->n_cqs_allocated == rdi->dparms.props.max_cq) {
 		spin_unlock_irq(&rdi->n_cqs_lock);
@@ -229,11 +218,9 @@ int rvt_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 	rdi->n_cqs_allocated++;
 	spin_unlock_irq(&rdi->n_cqs_lock);
 
-	if (cq->ip) {
-		spin_lock_irq(&rdi->pending_lock);
-		list_add(&cq->ip->pending_mmaps, &rdi->pending_mmaps);
-		spin_unlock_irq(&rdi->pending_lock);
-	}
+	spin_lock_irq(&rdi->pending_lock);
+	list_add(&cq->ip->pending_mmaps, &rdi->pending_mmaps);
+	spin_unlock_irq(&rdi->pending_lock);
 
 	/*
 	 * ib_create_cq() will initialize cq->ibcq except for cq->ibcq.cqe.
@@ -252,10 +239,7 @@ int rvt_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 	cq->notify = RVT_CQ_NONE;
 	spin_lock_init(&cq->lock);
 	INIT_WORK(&cq->comptask, send_complete);
-	if (u_wc)
-		cq->queue = u_wc;
-	else
-		cq->kqueue = k_wc;
+	cq->queue = u_wc;
 
 	trace_rvt_create_cq(cq, attr);
 	return 0;
@@ -264,6 +248,84 @@ int rvt_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 	kfree(cq->ip);
 bail_wc:
 	vfree(u_wc);
+	return err;
+}
+
+/**
+ * rvt_create_cq - create a completion queue for kernel
+ * @ibcq: Allocated CQ
+ * @attr: creation attributes
+ * @attrs: uverbs bundle
+ *
+ * Called by ib_create_cq() in the generic verbs code for kernel CQs.
+ *
+ * Return: 0 on success
+ */
+int rvt_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
+		  struct uverbs_attr_bundle *attrs)
+{
+	struct ib_device *ibdev = ibcq->device;
+	struct rvt_dev_info *rdi = ib_to_rvt(ibdev);
+	struct rvt_cq *cq = ibcq_to_rvtcq(ibcq);
+	struct rvt_k_cq_wc *k_wc;
+	u32 sz;
+	unsigned int entries = attr->cqe;
+	int comp_vector = attr->comp_vector;
+	int err;
+
+	if (attr->flags)
+		return -EOPNOTSUPP;
+
+	if (entries > rdi->dparms.props.max_cqe)
+		return -EINVAL;
+
+	if (comp_vector < 0)
+		comp_vector = 0;
+
+	comp_vector = comp_vector % rdi->ibdev.num_comp_vectors;
+
+	/*
+	 * Allocate the completion queue entries and head/tail pointers.
+	 */
+	sz = sizeof(struct ib_wc) * (entries + 1);
+	sz += sizeof(*k_wc);
+	k_wc = vzalloc_node(sz, rdi->dparms.node);
+	if (!k_wc)
+		return -ENOMEM;
+
+	spin_lock_irq(&rdi->n_cqs_lock);
+	if (rdi->n_cqs_allocated == rdi->dparms.props.max_cq) {
+		spin_unlock_irq(&rdi->n_cqs_lock);
+		err = -ENOMEM;
+		goto bail_wc;
+	}
+
+	rdi->n_cqs_allocated++;
+	spin_unlock_irq(&rdi->n_cqs_lock);
+
+	/*
+	 * ib_create_cq() will initialize cq->ibcq except for cq->ibcq.cqe.
+	 * The number of entries should be >= the number requested or return
+	 * an error.
+	 */
+	cq->rdi = rdi;
+	if (rdi->driver_f.comp_vect_cpu_lookup)
+		cq->comp_vector_cpu =
+			rdi->driver_f.comp_vect_cpu_lookup(rdi, comp_vector);
+	else
+		cq->comp_vector_cpu =
+			cpumask_first(cpumask_of_node(rdi->dparms.node));
+
+	cq->ibcq.cqe = entries;
+	cq->notify = RVT_CQ_NONE;
+	spin_lock_init(&cq->lock);
+	INIT_WORK(&cq->comptask, send_complete);
+	cq->kqueue = k_wc;
+
+	trace_rvt_create_cq(cq, attr);
+	return 0;
+
+bail_wc:
 	vfree(k_wc);
 	return err;
 }
diff --git a/drivers/infiniband/sw/rdmavt/cq.h b/drivers/infiniband/sw/rdmavt/cq.h
index 4028702a7b2f..14ee2705c443 100644
--- a/drivers/infiniband/sw/rdmavt/cq.h
+++ b/drivers/infiniband/sw/rdmavt/cq.h
@@ -11,6 +11,8 @@
 
 int rvt_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 		  struct uverbs_attr_bundle *attrs);
+int rvt_create_user_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
+		       struct uverbs_attr_bundle *attrs);
 int rvt_destroy_cq(struct ib_cq *ibcq, struct ib_udata *udata);
 int rvt_req_notify_cq(struct ib_cq *ibcq, enum ib_cq_notify_flags notify_flags);
 int rvt_resize_cq(struct ib_cq *ibcq, int cqe, struct ib_udata *udata);
diff --git a/drivers/infiniband/sw/rdmavt/vt.c b/drivers/infiniband/sw/rdmavt/vt.c
index d22d610c2696..15964400b8d3 100644
--- a/drivers/infiniband/sw/rdmavt/vt.c
+++ b/drivers/infiniband/sw/rdmavt/vt.c
@@ -333,6 +333,7 @@ static const struct ib_device_ops rvt_dev_ops = {
 	.attach_mcast = rvt_attach_mcast,
 	.create_ah = rvt_create_ah,
 	.create_cq = rvt_create_cq,
+	.create_user_cq = rvt_create_user_cq,
 	.create_qp = rvt_create_qp,
 	.create_srq = rvt_create_srq,
 	.create_user_ah = rvt_create_ah,

-- 
2.52.0


