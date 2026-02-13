Return-Path: <linux-hyperv+bounces-8805-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id RoLWC9QEj2ltHQEAu9opvQ
	(envelope-from <linux-hyperv+bounces-8805-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Feb 2026 12:02:44 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 726FC1355CD
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Feb 2026 12:02:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B07F03171D52
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Feb 2026 10:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EE823559FB;
	Fri, 13 Feb 2026 10:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fTwv9NGD"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A04D35292B;
	Fri, 13 Feb 2026 10:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770980362; cv=none; b=PbCOJ42LkQB2XRKCrYLVF8fKbuCq76QML4UaxWs6HWfnYE8J+5P6DMRGs2cTYE0U85pIRxFbtyBTpNdjVq/HDbYEk6StwwXVOeV6cryvWY8XjV5n/dHVEaSgIDIGL5kd2Wbv+GiKlSVBG7gUHohKlKydbfMsoq+auWVMMTnp/GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770980362; c=relaxed/simple;
	bh=ZILxVEto2dj+Iffa0Sa1Wb70T82yzlvYw9kGejs6jBw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c5yWmNfTmqj3PZaBp4XVWYVUWwncAdnHz76yGiJki6abNKjhuLyBOGezCGnuep/S3Gr5JTFKEfqBq5FgNKlm7NqXz4Mqg+7If1aGL3LoeSH6nVJRpxWrwkJgIv7Ggd6Jb4d29T1dalarINAz1rIqTgUMNoFZW5xinrXCEqJkHoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fTwv9NGD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F05CEC19424;
	Fri, 13 Feb 2026 10:59:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770980361;
	bh=ZILxVEto2dj+Iffa0Sa1Wb70T82yzlvYw9kGejs6jBw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fTwv9NGDFfVLOYoBNBJOs+KZpr8/U1GDQ1r7U98CpZCpf/Lr/e/YHay2cCb8lGwK+
	 QSEkenAemqrc3AhuytwHLzSP9qgWxKZOOMTjp0cXPoWI7LddISHaQgk/4Af+h9BEBv
	 SUABRjCsF9DwOumCW3rclXWW1pfVBndubJKGZvw4ARvURMZAVwzKU+APxnUx/gfzka
	 Bm9jN2rKuRbiFsJH7lL4F+YLNWRSsHBoOHTcen1XXOjhuCn1RnDrmHX4mMsMyvXRqL
	 UEvrbADxyFpjJJO3XCbmK2H/ZIN4iVYKt7Mv4wZszKK333eFdxeiqxAh+C80mPkOmP
	 zswM2t4SfIGZw==
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
Subject: [PATCH rdma-next 08/50] RDMA/core: Reject zero CQE count
Date: Fri, 13 Feb 2026 12:57:44 +0200
Message-ID: <20260213-refactor-umem-v1-8-f3be85847922@nvidia.com>
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
	TAGGED_FROM(0.00)[bounces-8805-lists,linux-hyperv=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:mid,nvidia.com:email]
X-Rspamd-Queue-Id: 726FC1355CD
X-Rspamd-Action: no action

From: Leon Romanovsky <leonro@nvidia.com>

All drivers already ensure that the number of CQEs is at least 1.
Add this validation to the core so drivers no longer need to repeat it.
Future patches converting to the .create_user_cq() interface will remove
the per‑driver checks.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/cq.c                  |  3 +++
 drivers/infiniband/core/uverbs_cmd.c          |  3 +++
 drivers/infiniband/core/uverbs_std_types_cq.c | 15 +++++++++------
 drivers/infiniband/core/verbs.c               |  3 +++
 4 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/core/cq.c b/drivers/infiniband/core/cq.c
index 584537c71545..7e0b54ec4141 100644
--- a/drivers/infiniband/core/cq.c
+++ b/drivers/infiniband/core/cq.c
@@ -220,6 +220,9 @@ struct ib_cq *__ib_alloc_cq(struct ib_device *dev, void *private, int nr_cqe,
 	struct ib_cq *cq;
 	int ret = -ENOMEM;
 
+	if (WARN_ON_ONCE(!nr_cqe))
+		return ERR_PTR(-EINVAL);
+
 	cq = rdma_zalloc_drv_obj(dev, ib_cq);
 	if (!cq)
 		return ERR_PTR(ret);
diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
index c7be592f60e8..041bed7a43b4 100644
--- a/drivers/infiniband/core/uverbs_cmd.c
+++ b/drivers/infiniband/core/uverbs_cmd.c
@@ -1032,6 +1032,9 @@ static int create_cq(struct uverbs_attr_bundle *attrs,
 	if (cmd->comp_vector >= attrs->ufile->device->num_comp_vectors)
 		return -EINVAL;
 
+	if (!cmd->cqe)
+		return -EINVAL;
+
 	obj = (struct ib_ucq_object *)uobj_alloc(UVERBS_OBJECT_CQ, attrs,
 						 &ib_dev);
 	if (IS_ERR(obj))
diff --git a/drivers/infiniband/core/uverbs_std_types_cq.c b/drivers/infiniband/core/uverbs_std_types_cq.c
index b999d8d62694..d2c8f71f934c 100644
--- a/drivers/infiniband/core/uverbs_std_types_cq.c
+++ b/drivers/infiniband/core/uverbs_std_types_cq.c
@@ -84,12 +84,15 @@ static int UVERBS_HANDLER(UVERBS_METHOD_CQ_CREATE)(
 
 	ret = uverbs_copy_from(&attr.comp_vector, attrs,
 			       UVERBS_ATTR_CREATE_CQ_COMP_VECTOR);
-	if (!ret)
-		ret = uverbs_copy_from(&attr.cqe, attrs,
-				       UVERBS_ATTR_CREATE_CQ_CQE);
-	if (!ret)
-		ret = uverbs_copy_from(&user_handle, attrs,
-				       UVERBS_ATTR_CREATE_CQ_USER_HANDLE);
+	if (ret)
+		return ret;
+
+	ret = uverbs_copy_from(&attr.cqe, attrs, UVERBS_ATTR_CREATE_CQ_CQE);
+	if (ret || !attr.cqe)
+		return ret ? : -EINVAL;
+
+	ret = uverbs_copy_from(&user_handle, attrs,
+			       UVERBS_ATTR_CREATE_CQ_USER_HANDLE);
 	if (ret)
 		return ret;
 
diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
index d0880346ebe2..9d075eeda463 100644
--- a/drivers/infiniband/core/verbs.c
+++ b/drivers/infiniband/core/verbs.c
@@ -2203,6 +2203,9 @@ struct ib_cq *__ib_create_cq(struct ib_device *device,
 	if (!cq)
 		return ERR_PTR(-ENOMEM);
 
+	if (WARN_ON_ONCE(!cq_attr->cqe))
+		return ERR_PTR(-EINVAL);
+
 	cq->device = device;
 	cq->comp_handler = comp_handler;
 	cq->event_handler = event_handler;

-- 
2.52.0


