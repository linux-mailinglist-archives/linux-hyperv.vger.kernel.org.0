Return-Path: <linux-hyperv+bounces-8842-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iKAlKo0Hj2ltHQEAu9opvQ
	(envelope-from <linux-hyperv+bounces-8842-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Feb 2026 12:14:21 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B965135995
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Feb 2026 12:14:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BA52831B384D
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Feb 2026 11:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D83BA363C4C;
	Fri, 13 Feb 2026 11:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EX9UUHPu"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B44D3363C45;
	Fri, 13 Feb 2026 11:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770980502; cv=none; b=Fcust+4BAB+rLlqxSrk9hcLmsig1+5p1gZPiC9DWgJX3YcWpSAVyL2pVscft77qyqos8YgDXI1CCfEoawMHGdKnbbg3+gaL2fcA4pjrGtTpiAbDco9UUKWFcsbSJkM4Kpo7NYFrw/mKapW/APvbmwCnvFPC03L5Z4uTa2IpTwdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770980502; c=relaxed/simple;
	bh=BcpgeLlLPsDR96BzelXgUw4MnjuLJVb15vuF2Iq2eN0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d2TAZ9vDOew7dwdeMKFG6Hw2ZVOtqMfcEz/jzOGyZKmhNXAO6iEgjn3J1V3eJVcabRrllLFGE1chAl78ZOhkaet+vekeahLbt0xflMODjBWb9YH4wpGLvboIud4FfA8GBWnMvAGh2g1Y+JYtgbfzbnljNt9KG5QI3dZh71wzsg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EX9UUHPu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CA50C116C6;
	Fri, 13 Feb 2026 11:01:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770980502;
	bh=BcpgeLlLPsDR96BzelXgUw4MnjuLJVb15vuF2Iq2eN0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EX9UUHPulnToXrHs9CRIhEkoouooY6Zre6pjGUBCXusVCI1SmwcWaREEBv9I5MJIC
	 gAyNBFMt5OYbNEWStP/Izpo9FZS317c1rLhnbifeIf+y6NugZfLkmKWDLzg6ZzEdKO
	 Hs0vGuN0IMR52obMjHsA5U6U5Gt+J7UEsoxSuAE3oHq8Dpi6wX8RYx4Xmo9HwF+0Cx
	 sLXp7nyaVeU6Ov/jMUNt4QXIIqnXOFHCqFifjoNZCW+lNYxQ/h3V0XtxQVBoAeqA9j
	 qqSY8VESFdigcVGiPrrmHjXVZLMlfOd87vbPgVOdakhRlY/VL5SGbFDslM+e/NmCSp
	 r+8QSxzU7qk6Q==
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
Subject: [PATCH rdma-next 45/50] RDMA/mlx4: Use generic resize-CQ lock
Date: Fri, 13 Feb 2026 12:58:21 +0200
Message-ID: <20260213-refactor-umem-v1-45-f3be85847922@nvidia.com>
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
	TAGGED_FROM(0.00)[bounces-8842-lists,linux-hyperv=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:mid,nvidia.com:email]
X-Rspamd-Queue-Id: 6B965135995
X-Rspamd-Action: no action

From: Leon Romanovsky <leonro@nvidia.com>

Replace the open‑coded resize‑CQ lock with the standard core
implementation for better consistency and maintainability.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx4/cq.c      | 9 +--------
 drivers/infiniband/hw/mlx4/mlx4_ib.h | 1 -
 2 files changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/infiniband/hw/mlx4/cq.c b/drivers/infiniband/hw/mlx4/cq.c
index f4595afced45..ffc3902dc329 100644
--- a/drivers/infiniband/hw/mlx4/cq.c
+++ b/drivers/infiniband/hw/mlx4/cq.c
@@ -163,7 +163,6 @@ int mlx4_ib_create_user_cq(struct ib_cq *ibcq,
 
 	entries      = roundup_pow_of_two(entries + 1);
 	cq->ibcq.cqe = entries - 1;
-	mutex_init(&cq->resize_mutex);
 	spin_lock_init(&cq->lock);
 	INIT_LIST_HEAD(&cq->send_qp_list);
 	INIT_LIST_HEAD(&cq->recv_qp_list);
@@ -253,7 +252,6 @@ int mlx4_ib_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 
 	entries      = roundup_pow_of_two(entries + 1);
 	cq->ibcq.cqe = entries - 1;
-	mutex_init(&cq->resize_mutex);
 	spin_lock_init(&cq->lock);
 	INIT_LIST_HEAD(&cq->send_qp_list);
 	INIT_LIST_HEAD(&cq->recv_qp_list);
@@ -369,12 +367,9 @@ int mlx4_ib_resize_cq(struct ib_cq *ibcq, unsigned int entries,
 	if (entries > dev->dev->caps.max_cqes + 1)
 		return -EINVAL;
 
-	mutex_lock(&cq->resize_mutex);
 	err = mlx4_alloc_resize_umem(dev, cq, entries, udata);
-	if (err) {
-		mutex_unlock(&cq->resize_mutex);
+	if (err)
 		return err;
-	}
 	mtt = cq->buf.mtt;
 
 	err = mlx4_cq_resize(dev->dev, &cq->mcq, entries, &cq->resize_buf->buf.mtt);
@@ -390,7 +385,6 @@ int mlx4_ib_resize_cq(struct ib_cq *ibcq, unsigned int entries,
 	kfree(cq->resize_buf);
 	cq->resize_buf = NULL;
 	cq->resize_umem = NULL;
-	mutex_unlock(&cq->resize_mutex);
 	return 0;
 
 
@@ -401,7 +395,6 @@ int mlx4_ib_resize_cq(struct ib_cq *ibcq, unsigned int entries,
 
 	ib_umem_release(cq->resize_umem);
 	cq->resize_umem = NULL;
-	mutex_unlock(&cq->resize_mutex);
 	return err;
 }
 
diff --git a/drivers/infiniband/hw/mlx4/mlx4_ib.h b/drivers/infiniband/hw/mlx4/mlx4_ib.h
index 5a799d6df93e..2f1043690554 100644
--- a/drivers/infiniband/hw/mlx4/mlx4_ib.h
+++ b/drivers/infiniband/hw/mlx4/mlx4_ib.h
@@ -120,7 +120,6 @@ struct mlx4_ib_cq {
 	struct mlx4_ib_cq_resize *resize_buf;
 	struct mlx4_db		db;
 	spinlock_t		lock;
-	struct mutex		resize_mutex;
 	struct ib_umem	       *resize_umem;
 	/* List of qps that it serves.*/
 	struct list_head		send_qp_list;

-- 
2.52.0


