Return-Path: <linux-hyperv+bounces-8811-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +HKmDKIEj2lJHQEAu9opvQ
	(envelope-from <linux-hyperv+bounces-8811-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Feb 2026 12:01:54 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A9A42135583
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Feb 2026 12:01:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4655230F2CB0
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Feb 2026 10:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D682B3563C3;
	Fri, 13 Feb 2026 10:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V7j2tVQC"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B290435294F;
	Fri, 13 Feb 2026 10:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770980384; cv=none; b=qDbX5+3WheypdbXG4k2r/mov+AEP54rv0CSDZHK8hE9i3MXfnJQ7G9voB84ur1txJYm4MbXC7lTS2/yBJnsMQ4l0MxW7TH+egNWfCLqswf4fdvMEvfTFEc5OR/Hl2cyzCCbMaSxgK7GUHAbc9g19mplz7I3xFlC2ybo9+efHemo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770980384; c=relaxed/simple;
	bh=8eMb3Q5rwUIFizfROKKCiitPdmAXPkVddaMbWoQJ9iA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gxKULQ3NfKjBI0k9Qdd8yNgl38ekcvjMVDB9AanPoxyWfykdPY1W2iG7OvyJU/JCQ/3ctuq7vjdfhnmVhr6rePgMHzF8AzuUvK0HAJllVaYZrYPlt1xZhcbWveBkZRNOLOqgfQMTron1ybaAJu8uJZOg05Qtturxu1RylOggl6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V7j2tVQC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B88A0C16AAE;
	Fri, 13 Feb 2026 10:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770980384;
	bh=8eMb3Q5rwUIFizfROKKCiitPdmAXPkVddaMbWoQJ9iA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=V7j2tVQC0mZgo79iYz40OcfqBk1Vvbu2n9O0NtY7KcbpUUsQmIm8JbTCLfsqtsHwO
	 GnkpRpsd4j3de0N2cML3jbhWw18VjMQxaXihf8aTI/bZaPF6LhH9N7NARejC71nNKu
	 /PV8Thw0Kt5IV19yzB4Jrmuo8O7YvXZ8ZqEiA53JkhvBxf8sTU2CF3soRZcy7+P6dq
	 kWt1KBme7viUVsvaS9SVhneJjaG7fbLcftOmq+srGB2KN88CbY9JbP1noyaZwkZPpq
	 naANnxVrxik5OaN0wuNZbrp9+bDMo0HdsElY4/o3/luXEsMurzg+wRyMWj8KFoROGW
	 298rUYaU49Mug==
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
Subject: [PATCH rdma-next 14/50] RDMA/mlx4: Remove unused create_flags field from CQ structure
Date: Fri, 13 Feb 2026 12:57:50 +0200
Message-ID: <20260213-refactor-umem-v1-14-f3be85847922@nvidia.com>
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
	TAGGED_FROM(0.00)[bounces-8811-lists,linux-hyperv=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A9A42135583
X-Rspamd-Action: no action

From: Leon Romanovsky <leonro@nvidia.com>

The CQ creation flags do not need to be cached, as they are used
immediately at the point where they are stored. Remove the unused
field and reclaim 4 bytes.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx4/cq.c      | 4 +---
 drivers/infiniband/hw/mlx4/mlx4_ib.h | 1 -
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/infiniband/hw/mlx4/cq.c b/drivers/infiniband/hw/mlx4/cq.c
index 4bee08317620..83169060d120 100644
--- a/drivers/infiniband/hw/mlx4/cq.c
+++ b/drivers/infiniband/hw/mlx4/cq.c
@@ -165,7 +165,6 @@ int mlx4_ib_create_user_cq(struct ib_cq *ibcq,
 	cq->ibcq.cqe = entries - 1;
 	mutex_init(&cq->resize_mutex);
 	spin_lock_init(&cq->lock);
-	cq->create_flags = attr->flags;
 	INIT_LIST_HEAD(&cq->send_qp_list);
 	INIT_LIST_HEAD(&cq->recv_qp_list);
 
@@ -208,8 +207,7 @@ int mlx4_ib_create_user_cq(struct ib_cq *ibcq,
 
 	err = mlx4_cq_alloc(dev->dev, entries, &cq->buf.mtt, &context->uar,
 			    cq->db.dma, &cq->mcq, vector, 0,
-			    !!(cq->create_flags &
-			       IB_UVERBS_CQ_FLAGS_TIMESTAMP_COMPLETION),
+			    attr->flags & IB_UVERBS_CQ_FLAGS_TIMESTAMP_COMPLETION,
 			    buf_addr, true);
 	if (err)
 		goto err_dbmap;
diff --git a/drivers/infiniband/hw/mlx4/mlx4_ib.h b/drivers/infiniband/hw/mlx4/mlx4_ib.h
index 96563c0836ce..6a7ed5225c7d 100644
--- a/drivers/infiniband/hw/mlx4/mlx4_ib.h
+++ b/drivers/infiniband/hw/mlx4/mlx4_ib.h
@@ -122,7 +122,6 @@ struct mlx4_ib_cq {
 	spinlock_t		lock;
 	struct mutex		resize_mutex;
 	struct ib_umem	       *resize_umem;
-	int			create_flags;
 	/* List of qps that it serves.*/
 	struct list_head		send_qp_list;
 	struct list_head		recv_qp_list;

-- 
2.52.0


