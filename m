Return-Path: <linux-hyperv+bounces-8826-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yHUlM1UGj2ltHQEAu9opvQ
	(envelope-from <linux-hyperv+bounces-8826-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Feb 2026 12:09:09 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 660B41357D4
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Feb 2026 12:09:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B16DB3150D82
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Feb 2026 11:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD0FD35DD0F;
	Fri, 13 Feb 2026 11:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h3MRYdf+"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99434357A48;
	Fri, 13 Feb 2026 11:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770980441; cv=none; b=e+zlhk46/PTqPwmtzpBSfDAhxzsrcCsEooc3OF92KfGpdu0r91/OUddBOnGv7W5raib5L/VidR4jeHGhPpblHzsZ4qWTbbYjXWPrSK5ygO4V871EOgtWxHufpu1r/QkWMw6gsWwYfYufiubg35A0H4WBZW8pejBETAwIRfxzGE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770980441; c=relaxed/simple;
	bh=1CctY2HBwLpkfQae2Bhsg6mecp9K8sByxfsXB098nls=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kiGO4/y5fImZe93obSkHfjb3HH7PWx3B06v/tH12TXswjSayOd8w/dR8aBAr71U0PSbL34SqUfnxdREMkxioiKDrN3PKbRgxxX2oyuHV37LytTphUKhT0ybXvDNBgQEYwWW/7uqEjnD1bVPOlD8xkpXcjtK0t0pXluSrPHgDasI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h3MRYdf+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B04FAC116C6;
	Fri, 13 Feb 2026 11:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770980441;
	bh=1CctY2HBwLpkfQae2Bhsg6mecp9K8sByxfsXB098nls=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=h3MRYdf+fowSfICWWtLhL3Q+lVcefmx8y2DMYlv/emZejELGChqql3aGEuj6C9tWa
	 lsLJ+junZEvuyxb74+DeR4AEPcDVuzrJsEZ5XKvMMoSWFv+egAjyJbNU246Z1H2hAW
	 yYmTE1kG2TomNj63JnhHtsqtkgXxezQhy4b+lLzPc++pQfdUW/kyzMx6jZ9ni8C/uI
	 hIuJ1ndut42HkNIiHBPHXFiUeUzjleC/1Yi/2rSjG7PLKXCkWSquRj/4s+q5F3yyNT
	 6djUi+sRbKFbfbOZptvxBk+M3cw8WY7KdZMA5Xa5tupL0P7gUVtcAeI+SyAKV1jP5d
	 gjIOu8PIm2yig==
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
Subject: [PATCH rdma-next 26/50] RDMA/erdma: Separate user and kernel CQ creation paths
Date: Fri, 13 Feb 2026 12:58:02 +0200
Message-ID: <20260213-refactor-umem-v1-26-f3be85847922@nvidia.com>
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
	TAGGED_FROM(0.00)[bounces-8826-lists,linux-hyperv=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 660B41357D4
X-Rspamd-Action: no action

From: Leon Romanovsky <leonro@nvidia.com>

Split CQ creation into distinct kernel and user flows. The hns driver,
inherited from mlx4, uses a problematic pattern that shares and caches
umem in hns_roce_db_map_user(). This design blocks the driver from
supporting generic umem sources (VMA, dmabuf, memfd, and others).

In addition, let's delete counter that counts CQ creation errors. There
are multiple ways to debug kernel in modern kernel without need to rely
on that debugfs counter.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/hns/hns_roce_cq.c      | 103 ++++++++++++++++++++-------
 drivers/infiniband/hw/hns/hns_roce_debugfs.c |   1 -
 drivers/infiniband/hw/hns/hns_roce_device.h  |   3 +-
 drivers/infiniband/hw/hns/hns_roce_main.c    |   1 +
 4 files changed, 82 insertions(+), 26 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_cq.c b/drivers/infiniband/hw/hns/hns_roce_cq.c
index 857a913326cd..0f24a916466b 100644
--- a/drivers/infiniband/hw/hns/hns_roce_cq.c
+++ b/drivers/infiniband/hw/hns/hns_roce_cq.c
@@ -335,7 +335,10 @@ static int verify_cq_create_attr(struct hns_roce_dev *hr_dev,
 {
 	struct ib_device *ibdev = &hr_dev->ib_dev;
 
-	if (!attr->cqe || attr->cqe > hr_dev->caps.max_cqes) {
+	if (attr->flags)
+		return -EOPNOTSUPP;
+
+	if (attr->cqe > hr_dev->caps.max_cqes) {
 		ibdev_err(ibdev, "failed to check CQ count %u, max = %u.\n",
 			  attr->cqe, hr_dev->caps.max_cqes);
 		return -EINVAL;
@@ -407,8 +410,8 @@ static int set_cqe_size(struct hns_roce_cq *hr_cq, struct ib_udata *udata,
 	return 0;
 }
 
-int hns_roce_create_cq(struct ib_cq *ib_cq, const struct ib_cq_init_attr *attr,
-		       struct uverbs_attr_bundle *attrs)
+int hns_roce_create_user_cq(struct ib_cq *ib_cq, const struct ib_cq_init_attr *attr,
+			    struct uverbs_attr_bundle *attrs)
 {
 	struct hns_roce_dev *hr_dev = to_hr_dev(ib_cq->device);
 	struct ib_udata *udata = &attrs->driver_udata;
@@ -418,31 +421,27 @@ int hns_roce_create_cq(struct ib_cq *ib_cq, const struct ib_cq_init_attr *attr,
 	struct hns_roce_ib_create_cq ucmd = {};
 	int ret;
 
-	if (attr->flags) {
-		ret = -EOPNOTSUPP;
-		goto err_out;
-	}
+	if (ib_cq->umem)
+		return -EOPNOTSUPP;
 
 	ret = verify_cq_create_attr(hr_dev, attr);
 	if (ret)
-		goto err_out;
+		return ret;
 
-	if (udata) {
-		ret = get_cq_ucmd(hr_cq, udata, &ucmd);
-		if (ret)
-			goto err_out;
-	}
+	ret = get_cq_ucmd(hr_cq, udata, &ucmd);
+	if (ret)
+		return ret;
 
 	set_cq_param(hr_cq, attr->cqe, attr->comp_vector, &ucmd);
 
 	ret = set_cqe_size(hr_cq, udata, &ucmd);
 	if (ret)
-		goto err_out;
+		return ret;
 
 	ret = alloc_cq_buf(hr_dev, hr_cq, udata, ucmd.buf_addr);
 	if (ret) {
 		ibdev_err(ibdev, "failed to alloc CQ buf, ret = %d.\n", ret);
-		goto err_out;
+		return ret;
 	}
 
 	ret = alloc_cq_db(hr_dev, hr_cq, udata, ucmd.db_addr, &resp);
@@ -464,13 +463,11 @@ int hns_roce_create_cq(struct ib_cq *ib_cq, const struct ib_cq_init_attr *attr,
 		goto err_cqn;
 	}
 
-	if (udata) {
-		resp.cqn = hr_cq->cqn;
-		ret = ib_copy_to_udata(udata, &resp,
-				       min(udata->outlen, sizeof(resp)));
-		if (ret)
-			goto err_cqc;
-	}
+	resp.cqn = hr_cq->cqn;
+	ret = ib_copy_to_udata(udata, &resp,
+			       min(udata->outlen, sizeof(resp)));
+	if (ret)
+		goto err_cqc;
 
 	hr_cq->cons_index = 0;
 	hr_cq->arm_sn = 1;
@@ -487,9 +484,67 @@ int hns_roce_create_cq(struct ib_cq *ib_cq, const struct ib_cq_init_attr *attr,
 	free_cq_db(hr_dev, hr_cq, udata);
 err_cq_buf:
 	free_cq_buf(hr_dev, hr_cq);
-err_out:
-	atomic64_inc(&hr_dev->dfx_cnt[HNS_ROCE_DFX_CQ_CREATE_ERR_CNT]);
+	return ret;
+}
+
+int hns_roce_create_cq(struct ib_cq *ib_cq, const struct ib_cq_init_attr *attr,
+		       struct uverbs_attr_bundle *attrs)
+{
+	struct hns_roce_dev *hr_dev = to_hr_dev(ib_cq->device);
+	struct hns_roce_ib_create_cq_resp resp = {};
+	struct hns_roce_cq *hr_cq = to_hr_cq(ib_cq);
+	struct ib_device *ibdev = &hr_dev->ib_dev;
+	struct hns_roce_ib_create_cq ucmd = {};
+	int ret;
+
+	ret = verify_cq_create_attr(hr_dev, attr);
+	if (ret)
+		return ret;
+
+	set_cq_param(hr_cq, attr->cqe, attr->comp_vector, &ucmd);
+
+	ret = set_cqe_size(hr_cq, NULL, &ucmd);
+	if (ret)
+		return ret;
 
+	ret = alloc_cq_buf(hr_dev, hr_cq, NULL, 0);
+	if (ret) {
+		ibdev_err(ibdev, "failed to alloc CQ buf, ret = %d.\n", ret);
+		return ret;
+	}
+
+	ret = alloc_cq_db(hr_dev, hr_cq, NULL, 0, &resp);
+	if (ret) {
+		ibdev_err(ibdev, "failed to alloc CQ db, ret = %d.\n", ret);
+		goto err_cq_buf;
+	}
+
+	ret = alloc_cqn(hr_dev, hr_cq, NULL);
+	if (ret) {
+		ibdev_err(ibdev, "failed to alloc CQN, ret = %d.\n", ret);
+		goto err_cq_db;
+	}
+
+	ret = alloc_cqc(hr_dev, hr_cq);
+	if (ret) {
+		ibdev_err(ibdev,
+			  "failed to alloc CQ context, ret = %d.\n", ret);
+		goto err_cqn;
+	}
+
+	hr_cq->cons_index = 0;
+	hr_cq->arm_sn = 1;
+	refcount_set(&hr_cq->refcount, 1);
+	init_completion(&hr_cq->free);
+
+	return 0;
+
+err_cqn:
+	free_cqn(hr_dev, hr_cq->cqn);
+err_cq_db:
+	free_cq_db(hr_dev, hr_cq, NULL);
+err_cq_buf:
+	free_cq_buf(hr_dev, hr_cq);
 	return ret;
 }
 
diff --git a/drivers/infiniband/hw/hns/hns_roce_debugfs.c b/drivers/infiniband/hw/hns/hns_roce_debugfs.c
index b869cdc54118..481b30f2f5b5 100644
--- a/drivers/infiniband/hw/hns/hns_roce_debugfs.c
+++ b/drivers/infiniband/hw/hns/hns_roce_debugfs.c
@@ -47,7 +47,6 @@ static const char * const sw_stat_info[] = {
 	[HNS_ROCE_DFX_MBX_EVENT_CNT] = "mbx_event",
 	[HNS_ROCE_DFX_QP_CREATE_ERR_CNT] = "qp_create_err",
 	[HNS_ROCE_DFX_QP_MODIFY_ERR_CNT] = "qp_modify_err",
-	[HNS_ROCE_DFX_CQ_CREATE_ERR_CNT] = "cq_create_err",
 	[HNS_ROCE_DFX_CQ_MODIFY_ERR_CNT] = "cq_modify_err",
 	[HNS_ROCE_DFX_SRQ_CREATE_ERR_CNT] = "srq_create_err",
 	[HNS_ROCE_DFX_SRQ_MODIFY_ERR_CNT] = "srq_modify_err",
diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index 3f032b8038af..fdc5f487d7a3 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -902,7 +902,6 @@ enum hns_roce_sw_dfx_stat_index {
 	HNS_ROCE_DFX_MBX_EVENT_CNT,
 	HNS_ROCE_DFX_QP_CREATE_ERR_CNT,
 	HNS_ROCE_DFX_QP_MODIFY_ERR_CNT,
-	HNS_ROCE_DFX_CQ_CREATE_ERR_CNT,
 	HNS_ROCE_DFX_CQ_MODIFY_ERR_CNT,
 	HNS_ROCE_DFX_SRQ_CREATE_ERR_CNT,
 	HNS_ROCE_DFX_SRQ_MODIFY_ERR_CNT,
@@ -1295,6 +1294,8 @@ int to_hr_qp_type(int qp_type);
 
 int hns_roce_create_cq(struct ib_cq *ib_cq, const struct ib_cq_init_attr *attr,
 		       struct uverbs_attr_bundle *attrs);
+int hns_roce_create_user_cq(struct ib_cq *ib_cq, const struct ib_cq_init_attr *attr,
+			    struct uverbs_attr_bundle *attrs);
 
 int hns_roce_destroy_cq(struct ib_cq *ib_cq, struct ib_udata *udata);
 int hns_roce_db_map_user(struct hns_roce_ucontext *context, unsigned long virt,
diff --git a/drivers/infiniband/hw/hns/hns_roce_main.c b/drivers/infiniband/hw/hns/hns_roce_main.c
index a3490bab297a..64de49bf8df7 100644
--- a/drivers/infiniband/hw/hns/hns_roce_main.c
+++ b/drivers/infiniband/hw/hns/hns_roce_main.c
@@ -727,6 +727,7 @@ static const struct ib_device_ops hns_roce_dev_ops = {
 	.create_ah = hns_roce_create_ah,
 	.create_user_ah = hns_roce_create_ah,
 	.create_cq = hns_roce_create_cq,
+	.create_user_cq = hns_roce_create_user_cq,
 	.create_qp = hns_roce_create_qp,
 	.dealloc_pd = hns_roce_dealloc_pd,
 	.dealloc_ucontext = hns_roce_dealloc_ucontext,

-- 
2.52.0


