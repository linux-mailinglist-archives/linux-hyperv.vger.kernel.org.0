Return-Path: <linux-hyperv+bounces-8838-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aHrwDsIGj2ltHQEAu9opvQ
	(envelope-from <linux-hyperv+bounces-8838-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Feb 2026 12:10:58 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A73FC13585D
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Feb 2026 12:10:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2E2F73226B08
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Feb 2026 11:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B70C435BDCB;
	Fri, 13 Feb 2026 11:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XWQYaKeB"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9373435B642;
	Fri, 13 Feb 2026 11:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770980486; cv=none; b=ZprDFk4XvFDAo5oer/c36d80aqyRt8OIqzl71B8JVy+4nqePRvQw/TIEUROYHaMM27fZE4LTi2OBtJF9I3dj3bmNMEFWAudHGoRIb8/iMocFeeH7J3TRTtwtz05LhTdbRLzxUcFTRkR5TFxQwU3Zn/uWNBeGzaRpWIay6thUDRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770980486; c=relaxed/simple;
	bh=+71nHH7AfbBe/SSFkmhT9gZYJit0sB3BkF4FgCoqo0Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=An+sOipW3NP/bcfdZaiiActiekOc8dezeAxsFi2E9w2lYc8PQAIcKBGis88pdsLEeH3Bmq5GA3ngotuFytOTbSz5GZOTTXDhuG24sGuE1kjcDuj8TULw6XdR5iEmvA3bab/s2SpobIYJwQo7wmxQjc/kbJ9ztyeH3zkQHf0PKIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XWQYaKeB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8744FC116C6;
	Fri, 13 Feb 2026 11:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770980486;
	bh=+71nHH7AfbBe/SSFkmhT9gZYJit0sB3BkF4FgCoqo0Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XWQYaKeBB8O493B0SrqYCfrIOArNxH8idmqWxTA/Xnk1OELZOB3BnKmP8JUohkr8Q
	 KWseDRn2aS9NLDRidFFfbNnUkX46jk3L+817PIMRd2197frvjsRDkOAnMYNnW+dqdf
	 akwPp8mYzTPjmA6+/4oVxC8sHwTXxFJeBRs9PrdLNE3B50RCFtwPWfyIrZoXV14Lr5
	 1kht5U/hvQ1ZGTVJJM2Ng+v42yPpwfJHSdrPm1gPKnQpSK8Z3+84hsO8f3th/W7S35
	 naSulqW7coB00dN7JV7g25L/z6B/VV9ZPIqozL2HiijCxDwFsAwYGvS57M14pRTjFr
	 ODSNvEorXcaiA==
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
Subject: [PATCH rdma-next 41/50] RDMA/core: Generalize CQ resize locking
Date: Fri, 13 Feb 2026 12:58:17 +0200
Message-ID: <20260213-refactor-umem-v1-41-f3be85847922@nvidia.com>
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
	TAGGED_FROM(0.00)[bounces-8838-lists,linux-hyperv=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A73FC13585D
X-Rspamd-Action: no action

From: Leon Romanovsky <leonro@nvidia.com>

The CQ resize path must be protected from concurrent execution because it
updates in-kernel objects. Some drivers did not provide any locking,
leading to inconsistent behavior.

Rely on the core mutex for synchronization and drop the various ad‑hoc
locking implementations in individual drivers.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/uverbs_cmd.c          | 1 +
 drivers/infiniband/core/uverbs_std_types_cq.c | 1 +
 drivers/infiniband/core/verbs.c               | 2 ++
 include/rdma/ib_verbs.h                       | 3 +++
 4 files changed, 7 insertions(+)

diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
index b4b0c7c92fb1..1348ebd7a1c3 100644
--- a/drivers/infiniband/core/uverbs_cmd.c
+++ b/drivers/infiniband/core/uverbs_cmd.c
@@ -1067,6 +1067,7 @@ static int create_cq(struct uverbs_attr_bundle *attrs,
 	cq->event_handler = ib_uverbs_cq_event_handler;
 	cq->cq_context    = ev_file ? &ev_file->ev_queue : NULL;
 	atomic_set(&cq->usecnt, 0);
+	mutex_init(&cq->resize_mutex);
 
 	rdma_restrack_new(&cq->res, RDMA_RESTRACK_CQ);
 	rdma_restrack_set_name(&cq->res, NULL);
diff --git a/drivers/infiniband/core/uverbs_std_types_cq.c b/drivers/infiniband/core/uverbs_std_types_cq.c
index a12e3184dd5c..c572f528579d 100644
--- a/drivers/infiniband/core/uverbs_std_types_cq.c
+++ b/drivers/infiniband/core/uverbs_std_types_cq.c
@@ -195,6 +195,7 @@ static int UVERBS_HANDLER(UVERBS_METHOD_CQ_CREATE)(
 	 */
 	cq->umem = umem;
 	atomic_set(&cq->usecnt, 0);
+	mutex_init(&cq->resize_mutex);
 
 	rdma_restrack_new(&cq->res, RDMA_RESTRACK_CQ);
 	rdma_restrack_set_name(&cq->res, NULL);
diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
index 5f59487fc9d4..b308100ba964 100644
--- a/drivers/infiniband/core/verbs.c
+++ b/drivers/infiniband/core/verbs.c
@@ -2257,6 +2257,8 @@ int ib_destroy_cq_user(struct ib_cq *cq, struct ib_udata *udata)
 	if (ret)
 		return ret;
 
+	if (udata)
+		mutex_destroy(&cq->resize_mutex);
 	ib_umem_release(cq->umem);
 	rdma_restrack_del(&cq->res);
 	kfree(cq);
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 7d32d02c35e3..48340b39ab26 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -1638,8 +1638,11 @@ struct ib_cq {
 	struct ib_wc		*wc;
 	struct list_head        pool_entry;
 	union {
+		/* Kernel CQs */
 		struct irq_poll		iop;
 		struct work_struct	work;
+		/* Uverbs CQs */
+		struct mutex resize_mutex;
 	};
 	struct workqueue_struct *comp_wq;
 	struct dim *dim;

-- 
2.52.0


