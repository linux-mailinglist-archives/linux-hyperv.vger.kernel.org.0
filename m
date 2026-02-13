Return-Path: <linux-hyperv+bounces-8804-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +Bv4ILMEj2lJHQEAu9opvQ
	(envelope-from <linux-hyperv+bounces-8804-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Feb 2026 12:02:11 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 22C051355A2
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Feb 2026 12:02:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 99492315E217
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Feb 2026 10:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C7153563C6;
	Fri, 13 Feb 2026 10:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n8sM4rSO"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7820B355020;
	Fri, 13 Feb 2026 10:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770980358; cv=none; b=SHNpR6b2gNStTvKAPuM5LYAjSiypq0fQu6A7CDtrshOZh42Jt9PvX9xQ0Ded6APQtcnsXYHhpI+vg4T6GCbVNS83YFWNRnCngLPCERDx4dhh0rX25k9rL4CTdwG0NfITheqQ9jojn/hym5uF+sF8boNqz26O6EetgvfExIHy2EQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770980358; c=relaxed/simple;
	bh=rYH5HyXwxD1symtbsN1uVQMrg094hCT9fjaacofZLOU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H2OkevspTptj1qS7H2FfjOXo+ZCwVHzokkw0n/l1157b6aSQHAXNHZdPzVkVOze6TRHbm+czn9oo17Uv5dXJxtE8NmADQG0W5rJuA0hDn7f8EdDMaI0NlW7HZed64C7Z+vWC0zspJrGjJUJ3/68h6rqoiCJiKwCjsKp3jpFvfU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n8sM4rSO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42A23C4AF09;
	Fri, 13 Feb 2026 10:59:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770980358;
	bh=rYH5HyXwxD1symtbsN1uVQMrg094hCT9fjaacofZLOU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n8sM4rSOdUEG/M/TzshrL//oLw9vpCl3qfAS22do1sFm1/4LsvdEbGuLp2E8soZQP
	 eHpBcGk77UTEX20+baIr9Kt3IYmavuj3jt8IokEMSCeSby9OdBAUbe+VnR1FFUCNU6
	 hqDaXeV/jr/rvOPNSQlHj0PxEk5pQSgLQdF+tT8kMW+WV+wq1xQYLoxBfw3JjpOZr9
	 ZPrWBAoDD50DuAwjn0vlS7NWeEtHsZOvbMKy76W3XtMfyNkvUahIZQj0z/zfQs9sIW
	 QpBaQSkdTl9EIne/MFn1U8oaocPRBgmMqwlpnTvZj9cueHzb/ZkkepCkEN/McYFZlJ
	 tuq7/N5VBAAUw==
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
Subject: [PATCH rdma-next 07/50] RDMA/core: Prepare create CQ path for API unification
Date: Fri, 13 Feb 2026 12:57:43 +0200
Message-ID: <20260213-refactor-umem-v1-7-f3be85847922@nvidia.com>
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
	TAGGED_FROM(0.00)[bounces-8804-lists,linux-hyperv=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 22C051355A2
X-Rspamd-Action: no action

From: Leon Romanovsky <leonro@nvidia.com>

Ensure that .create_cq_umem() and .create_cq() follow the same API
contract, allowing drivers to be gradually migrated to the umem-aware
CQ management flow.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/device.c              |  2 +-
 drivers/infiniband/core/uverbs_cmd.c          |  5 ++++-
 drivers/infiniband/core/uverbs_std_types_cq.c | 16 +++++++++++-----
 drivers/infiniband/core/verbs.c               |  6 +++++-
 drivers/infiniband/hw/efa/efa.h               |  6 ++----
 drivers/infiniband/hw/efa/efa_main.c          |  3 +--
 drivers/infiniband/hw/efa/efa_verbs.c         | 10 ++--------
 include/rdma/ib_verbs.h                       |  3 +--
 8 files changed, 27 insertions(+), 24 deletions(-)

diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index 4e09f6e0995e..9209b8c664ef 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -2701,7 +2701,7 @@ void ib_set_device_ops(struct ib_device *dev, const struct ib_device_ops *ops)
 	SET_DEVICE_OP(dev_ops, create_ah);
 	SET_DEVICE_OP(dev_ops, create_counters);
 	SET_DEVICE_OP(dev_ops, create_cq);
-	SET_DEVICE_OP(dev_ops, create_cq_umem);
+	SET_DEVICE_OP(dev_ops, create_user_cq);
 	SET_DEVICE_OP(dev_ops, create_flow);
 	SET_DEVICE_OP(dev_ops, create_qp);
 	SET_DEVICE_OP(dev_ops, create_rwq_ind_table);
diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
index fb19395b9f2a..c7be592f60e8 100644
--- a/drivers/infiniband/core/uverbs_cmd.c
+++ b/drivers/infiniband/core/uverbs_cmd.c
@@ -1068,7 +1068,10 @@ static int create_cq(struct uverbs_attr_bundle *attrs,
 	rdma_restrack_new(&cq->res, RDMA_RESTRACK_CQ);
 	rdma_restrack_set_name(&cq->res, NULL);
 
-	ret = ib_dev->ops.create_cq(cq, &attr, attrs);
+	if (ib_dev->ops.create_user_cq)
+		ret = ib_dev->ops.create_user_cq(cq, &attr, attrs);
+	else
+		ret = ib_dev->ops.create_cq(cq, &attr, attrs);
 	if (ret)
 		goto err_free;
 	rdma_restrack_add(&cq->res);
diff --git a/drivers/infiniband/core/uverbs_std_types_cq.c b/drivers/infiniband/core/uverbs_std_types_cq.c
index 05809f9ff0f6..b999d8d62694 100644
--- a/drivers/infiniband/core/uverbs_std_types_cq.c
+++ b/drivers/infiniband/core/uverbs_std_types_cq.c
@@ -78,7 +78,8 @@ static int UVERBS_HANDLER(UVERBS_METHOD_CQ_CREATE)(
 	int buffer_fd;
 	int ret;
 
-	if ((!ib_dev->ops.create_cq && !ib_dev->ops.create_cq_umem) || !ib_dev->ops.destroy_cq)
+	if ((!ib_dev->ops.create_cq && !ib_dev->ops.create_user_cq) ||
+	    !ib_dev->ops.destroy_cq)
 		return -EOPNOTSUPP;
 
 	ret = uverbs_copy_from(&attr.comp_vector, attrs,
@@ -130,7 +131,7 @@ static int UVERBS_HANDLER(UVERBS_METHOD_CQ_CREATE)(
 
 		if (uverbs_attr_is_valid(attrs, UVERBS_ATTR_CREATE_CQ_BUFFER_FD) ||
 		    uverbs_attr_is_valid(attrs, UVERBS_ATTR_CREATE_CQ_BUFFER_OFFSET) ||
-		    !ib_dev->ops.create_cq_umem) {
+		    !ib_dev->ops.create_user_cq) {
 			ret = -EINVAL;
 			goto err_event_file;
 		}
@@ -155,7 +156,7 @@ static int UVERBS_HANDLER(UVERBS_METHOD_CQ_CREATE)(
 			goto err_event_file;
 
 		if (uverbs_attr_is_valid(attrs, UVERBS_ATTR_CREATE_CQ_BUFFER_VA) ||
-		    !ib_dev->ops.create_cq_umem) {
+		    !ib_dev->ops.create_user_cq) {
 			ret = -EINVAL;
 			goto err_event_file;
 		}
@@ -196,11 +197,16 @@ static int UVERBS_HANDLER(UVERBS_METHOD_CQ_CREATE)(
 	rdma_restrack_new(&cq->res, RDMA_RESTRACK_CQ);
 	rdma_restrack_set_name(&cq->res, NULL);
 
-	ret = umem ? ib_dev->ops.create_cq_umem(cq, &attr, umem, attrs) :
-		ib_dev->ops.create_cq(cq, &attr, attrs);
+	if (ib_dev->ops.create_user_cq)
+		ret = ib_dev->ops.create_user_cq(cq, &attr, attrs);
+	else
+		ret = ib_dev->ops.create_cq(cq, &attr, attrs);
 	if (ret)
 		goto err_free;
 
+	/* Check that driver didn't overrun existing umem */
+	WARN_ON(umem && cq->umem != umem);
+
 	obj->uevent.uobject.object = cq;
 	obj->uevent.uobject.user_handle = user_handle;
 	rdma_restrack_add(&cq->res);
diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
index ad48d2458a3f..d0880346ebe2 100644
--- a/drivers/infiniband/core/verbs.c
+++ b/drivers/infiniband/core/verbs.c
@@ -2204,7 +2204,6 @@ struct ib_cq *__ib_create_cq(struct ib_device *device,
 		return ERR_PTR(-ENOMEM);
 
 	cq->device = device;
-	cq->uobject = NULL;
 	cq->comp_handler = comp_handler;
 	cq->event_handler = event_handler;
 	cq->cq_context = cq_context;
@@ -2219,6 +2218,11 @@ struct ib_cq *__ib_create_cq(struct ib_device *device,
 		kfree(cq);
 		return ERR_PTR(ret);
 	}
+	/*
+	 * We are in kernel verbs flow and drivers are not allowed
+	 * to set umem pointer, it needs to stay NULL.
+	 */
+	WARN_ON_ONCE(cq->umem);
 
 	rdma_restrack_add(&cq->res);
 	return cq;
diff --git a/drivers/infiniband/hw/efa/efa.h b/drivers/infiniband/hw/efa/efa.h
index 96f9c3bc98b2..00b19f2ba3da 100644
--- a/drivers/infiniband/hw/efa/efa.h
+++ b/drivers/infiniband/hw/efa/efa.h
@@ -161,10 +161,8 @@ int efa_destroy_qp(struct ib_qp *ibqp, struct ib_udata *udata);
 int efa_create_qp(struct ib_qp *ibqp, struct ib_qp_init_attr *init_attr,
 		  struct ib_udata *udata);
 int efa_destroy_cq(struct ib_cq *ibcq, struct ib_udata *udata);
-int efa_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
-		  struct uverbs_attr_bundle *attrs);
-int efa_create_cq_umem(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
-		       struct ib_umem *umem, struct uverbs_attr_bundle *attrs);
+int efa_create_user_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
+		       struct uverbs_attr_bundle *attrs);
 struct ib_mr *efa_reg_mr(struct ib_pd *ibpd, u64 start, u64 length,
 			 u64 virt_addr, int access_flags,
 			 struct ib_dmah *dmah,
diff --git a/drivers/infiniband/hw/efa/efa_main.c b/drivers/infiniband/hw/efa/efa_main.c
index 6c415b9adb5f..a1d68dc49e45 100644
--- a/drivers/infiniband/hw/efa/efa_main.c
+++ b/drivers/infiniband/hw/efa/efa_main.c
@@ -371,8 +371,7 @@ static const struct ib_device_ops efa_dev_ops = {
 	.alloc_hw_device_stats = efa_alloc_hw_device_stats,
 	.alloc_pd = efa_alloc_pd,
 	.alloc_ucontext = efa_alloc_ucontext,
-	.create_cq = efa_create_cq,
-	.create_cq_umem = efa_create_cq_umem,
+	.create_user_cq = efa_create_user_cq,
 	.create_qp = efa_create_qp,
 	.create_user_ah = efa_create_ah,
 	.dealloc_pd = efa_dealloc_pd,
diff --git a/drivers/infiniband/hw/efa/efa_verbs.c b/drivers/infiniband/hw/efa/efa_verbs.c
index bc69aef3e436..d465e6acfe3c 100644
--- a/drivers/infiniband/hw/efa/efa_verbs.c
+++ b/drivers/infiniband/hw/efa/efa_verbs.c
@@ -1130,8 +1130,8 @@ static int cq_mmap_entries_setup(struct efa_dev *dev, struct efa_cq *cq,
 	return 0;
 }
 
-int efa_create_cq_umem(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
-		       struct ib_umem *umem, struct uverbs_attr_bundle *attrs)
+int efa_create_user_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
+		       struct uverbs_attr_bundle *attrs)
 {
 	struct ib_udata *udata = &attrs->driver_udata;
 	struct efa_ucontext *ucontext = rdma_udata_to_drv_context(
@@ -1306,12 +1306,6 @@ int efa_create_cq_umem(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 	return err;
 }
 
-int efa_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
-		  struct uverbs_attr_bundle *attrs)
-{
-	return efa_create_cq_umem(ibcq, attr, NULL, attrs);
-}
-
 static int umem_to_page_list(struct efa_dev *dev,
 			     struct ib_umem *umem,
 			     u64 *page_list,
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index b1e34fd2ed5f..67aa5fc2c0b7 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -2529,9 +2529,8 @@ struct ib_device_ops {
 	int (*destroy_qp)(struct ib_qp *qp, struct ib_udata *udata);
 	int (*create_cq)(struct ib_cq *cq, const struct ib_cq_init_attr *attr,
 			 struct uverbs_attr_bundle *attrs);
-	int (*create_cq_umem)(struct ib_cq *cq,
+	int (*create_user_cq)(struct ib_cq *cq,
 			      const struct ib_cq_init_attr *attr,
-			      struct ib_umem *umem,
 			      struct uverbs_attr_bundle *attrs);
 	int (*modify_cq)(struct ib_cq *cq, u16 cq_count, u16 cq_period);
 	int (*destroy_cq)(struct ib_cq *cq, struct ib_udata *udata);

-- 
2.52.0


