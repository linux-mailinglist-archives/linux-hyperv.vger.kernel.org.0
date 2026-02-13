Return-Path: <linux-hyperv+bounces-8847-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CH+WBfIHj2ltHQEAu9opvQ
	(envelope-from <linux-hyperv+bounces-8847-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Feb 2026 12:16:02 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A1D681359F6
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Feb 2026 12:16:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 53651310ACB2
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Feb 2026 11:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CC37364E81;
	Fri, 13 Feb 2026 11:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mFbKbfqu"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6921E3596E4;
	Fri, 13 Feb 2026 11:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770980521; cv=none; b=X2IWbTQWBeeER8Nq5rETZN3TG+skYoM+zP4etYcp+9hawUmPkiVw3grGmPS6XTbSYwLIaqq9cED1eLivnbUeTzq7zMQr4agU7j0QLBdmqtW8aoj6sDeWEq2r6teeAKeohC/KrZMRIYtrz9DqijAJ5k5dTu/MmUG4Dd4fZMwUG+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770980521; c=relaxed/simple;
	bh=46FOhXy82s7WTWz6+l85BPMRthsUy90zX4MlVpe3m6w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Cne7TwDsO/PcFPcTirSsxcYwZ8y+90dc4kBD5h5VLeS6FL6CAXb808B+HarxY3sh5neJvkLbsU3CYpbf4pisdwqROn/oiZsjHYLytvaX0mJYJIz7tzxf5t/Rgkt8VMeB32XUMOCSaDp1osc6X/K/JQ7tssapJiXiQLi+BEq6k+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mFbKbfqu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FA60C116C6;
	Fri, 13 Feb 2026 11:02:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770980521;
	bh=46FOhXy82s7WTWz6+l85BPMRthsUy90zX4MlVpe3m6w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mFbKbfqudf4zer/t7PIEGz2aaHZV/Rfc7eXOFwMRdcf5T243TjgDF6GAKPJNx2DQx
	 mbdU8jSd+n2nLYbqzOt1vi/+NuWS6MY2PI0vG0rm5fhM3mq7Q3uTvoRFX29OeFqI2e
	 Dq7uOZRHqAwrC+7oaeCIqDF6wcbr8sMhfiwBzQF+rW5L/b4vNQY78iPvw2yFRHrBbw
	 kVtuKgwFot52fCK8DF+k3q3iAbRz8bL0//Ucp6sCKVq06Ba/nX1lI6CNM8ChReYcNi
	 LAxNRUOLuXadHun8HBVM0M2S3i+Ph3DTCs2ApGBKWZweeT1gdp4HqwXdPAP9RV99tB
	 tjAiuscfqHbLA==
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
Subject: [PATCH rdma-next 50/50] RDMA/mthca: Use generic resize-CQ lock
Date: Fri, 13 Feb 2026 12:58:26 +0200
Message-ID: <20260213-refactor-umem-v1-50-f3be85847922@nvidia.com>
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
	TAGGED_FROM(0.00)[bounces-8847-lists,linux-hyperv=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:mid,nvidia.com:email]
X-Rspamd-Queue-Id: A1D681359F6
X-Rspamd-Action: no action

From: Leon Romanovsky <leonro@nvidia.com>

Replace the open‑coded resize‑CQ lock with the standard core
implementation for better consistency and maintainability.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mthca/mthca_cq.c       |  1 -
 drivers/infiniband/hw/mthca/mthca_provider.c | 20 ++++++--------------
 drivers/infiniband/hw/mthca/mthca_provider.h |  1 -
 3 files changed, 6 insertions(+), 16 deletions(-)

diff --git a/drivers/infiniband/hw/mthca/mthca_cq.c b/drivers/infiniband/hw/mthca/mthca_cq.c
index 26c3408dcaca..9c15e9b886d1 100644
--- a/drivers/infiniband/hw/mthca/mthca_cq.c
+++ b/drivers/infiniband/hw/mthca/mthca_cq.c
@@ -819,7 +819,6 @@ int mthca_init_cq(struct mthca_dev *dev, int nent,
 	spin_lock_init(&cq->lock);
 	cq->refcount = 1;
 	init_waitqueue_head(&cq->wait);
-	mutex_init(&cq->mutex);
 
 	memset(cq_context, 0, sizeof *cq_context);
 	cq_context->flags           = cpu_to_be32(MTHCA_CQ_STATUS_OK      |
diff --git a/drivers/infiniband/hw/mthca/mthca_provider.c b/drivers/infiniband/hw/mthca/mthca_provider.c
index 85de004547ab..cb94d73e89d6 100644
--- a/drivers/infiniband/hw/mthca/mthca_provider.c
+++ b/drivers/infiniband/hw/mthca/mthca_provider.c
@@ -680,28 +680,20 @@ static int mthca_resize_cq(struct ib_cq *ibcq, unsigned int entries,
 	if (entries > dev->limits.max_cqes)
 		return -EINVAL;
 
-	mutex_lock(&cq->mutex);
-
 	entries = roundup_pow_of_two(entries + 1);
-	if (entries == ibcq->cqe + 1) {
-		ret = 0;
-		goto out;
-	}
+	if (entries == ibcq->cqe + 1)
+		return 0;
 
-	if (ib_copy_from_udata(&ucmd, udata, sizeof ucmd)) {
-		ret = -EFAULT;
-		goto out;
-	}
+	if (ib_copy_from_udata(&ucmd, udata, sizeof(ucmd)))
+		return -EFAULT;
 	lkey = ucmd.lkey;
 
 	ret = mthca_RESIZE_CQ(dev, cq->cqn, lkey, ilog2(entries));
 	if (ret)
-		goto out;
+		return ret;
 
 	ibcq->cqe = entries - 1;
-out:
-	mutex_unlock(&cq->mutex);
-	return ret;
+	return 0;
 }
 
 static int mthca_destroy_cq(struct ib_cq *cq, struct ib_udata *udata)
diff --git a/drivers/infiniband/hw/mthca/mthca_provider.h b/drivers/infiniband/hw/mthca/mthca_provider.h
index 8a77483bb33c..7797d76fb93d 100644
--- a/drivers/infiniband/hw/mthca/mthca_provider.h
+++ b/drivers/infiniband/hw/mthca/mthca_provider.h
@@ -198,7 +198,6 @@ struct mthca_cq {
 	int			arm_sn;
 
 	wait_queue_head_t	wait;
-	struct mutex		mutex;
 };
 
 struct mthca_srq {

-- 
2.52.0


