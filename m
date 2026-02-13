Return-Path: <linux-hyperv+bounces-8848-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eFFQHYEHj2maHQEAu9opvQ
	(envelope-from <linux-hyperv+bounces-8848-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Feb 2026 12:14:09 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1087A13597F
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Feb 2026 12:14:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C54FC30EEF8D
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Feb 2026 11:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72604364EA0;
	Fri, 13 Feb 2026 11:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EvlIOKhn"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC3E35EDAD;
	Fri, 13 Feb 2026 11:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770980525; cv=none; b=TxCzRagqMSVV6WRfej4duomPPYLvVjB5v5Dg/IhM2kD9BgIp0cRAwSsB2+FsefoXZ/C5ngrVtVRelfkJMzQRTNNOlHNdMY9WClliRr462FohZ4CwcUHpv8GHK+9yXIsoEJ2Gdzw5tmNpEGqJILekypA/02BhbBOcS/xRnKvQoFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770980525; c=relaxed/simple;
	bh=5ZIbUGGs+YK+IU7xvhz8h2Eb5dryzLeGsmBwdIcmdSc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rWYWLM+Gh+YpR6tUq5v2NTpdcnJOtZLgEM6lsuL2GRr4j2h1fqLB7YrO3i/QCaaUyQBm25Sooi+pZIqET8Uz16EhigtENLJxnnTGThPKJP2N0kGBnEirdEMGFKTm/7lBTtMZ4NJhYLRJfehBoZcLO0xYIZVXVt+Q2KiaGXCkpqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EvlIOKhn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E9D0C116C6;
	Fri, 13 Feb 2026 11:02:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770980524;
	bh=5ZIbUGGs+YK+IU7xvhz8h2Eb5dryzLeGsmBwdIcmdSc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EvlIOKhnsQGkKppFt1lN/N6Z1fysGoXAX9xR5snDsQfYdnOtpp84Dh+lQ5kWRcwVp
	 tLMY1Gt8NC/qUSk8J72rkaAVaKb9PaVdfUuKlhPfPfTbqP2gfyCXAWh9ZL9wLiYjZh
	 /piW4K1lACWsruRpyKPTgm84t3ne6QoJE62N6YQwmMzCorByFKAV6h+Oh/UrldhNcO
	 +7gLnMuxD/6mgiZr0yGhdeK/5JzbRbg+KkFRG/BlBVIbbTS6x/vqE+yN8Ga4zL8Xc8
	 xE4OZ/hY58bFtm5/eri2gVLGfUZqDgjnDmmxfPUXZSqw6jH5SvcyRKAk0pAJu96Xoj
	 RZ0unm6gYI6Mw==
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
Subject: =?utf-8?q?=5BPATCH_rdma-next_48/50=5D_RDMA/mlx5=3A_Select_resize?= =?utf-8?q?=E2=80=91CQ_callback_based_on_device_capabilities?=
Date: Fri, 13 Feb 2026 12:58:24 +0200
Message-ID: <20260213-refactor-umem-v1-48-f3be85847922@nvidia.com>
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
	TAGGED_FROM(0.00)[bounces-8848-lists,linux-hyperv=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:mid,nvidia.com:email]
X-Rspamd-Queue-Id: 1087A13597F
X-Rspamd-Action: no action

From: Leon Romanovsky <leonro@nvidia.com>

Remove the legacy capability check when issuing the resize‑CQ command.
Instead, rely on choosing the correct ops during initialization.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/cq.c   | 5 -----
 drivers/infiniband/hw/mlx5/main.c | 8 +++++++-
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/cq.c b/drivers/infiniband/hw/mlx5/cq.c
index f7fb6f4aef7d..88f0f5e2944f 100644
--- a/drivers/infiniband/hw/mlx5/cq.c
+++ b/drivers/infiniband/hw/mlx5/cq.c
@@ -1267,11 +1267,6 @@ int mlx5_ib_resize_cq(struct ib_cq *ibcq, unsigned int entries,
 	int inlen;
 	int cqe_size;
 
-	if (!MLX5_CAP_GEN(dev->mdev, cq_resize)) {
-		pr_info("Firmware does not support resize CQ\n");
-		return -ENOSYS;
-	}
-
 	if (entries > (1 << MLX5_CAP_GEN(dev->mdev, log_max_cq_sz)))
 		return -EINVAL;
 
diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index 0471155eb739..f86721681f5b 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -4496,7 +4496,6 @@ static const struct ib_device_ops mlx5_ib_dev_ops = {
 	.reg_user_mr_dmabuf = mlx5_ib_reg_user_mr_dmabuf,
 	.req_notify_cq = mlx5_ib_arm_cq,
 	.rereg_user_mr = mlx5_ib_rereg_user_mr,
-	.resize_user_cq = mlx5_ib_resize_cq,
 	.ufile_hw_cleanup = mlx5_ib_ufile_hw_cleanup,
 
 	INIT_RDMA_OBJ_SIZE(ib_ah, mlx5_ib_ah, ibah),
@@ -4509,6 +4508,10 @@ static const struct ib_device_ops mlx5_ib_dev_ops = {
 	INIT_RDMA_OBJ_SIZE(ib_ucontext, mlx5_ib_ucontext, ibucontext),
 };
 
+static const struct ib_device_ops mlx5_ib_dev_resize_cq_ops = {
+	.resize_user_cq = mlx5_ib_resize_cq,
+};
+
 static const struct ib_device_ops mlx5_ib_dev_ipoib_enhanced_ops = {
 	.rdma_netdev_get_params = mlx5_ib_rn_get_params,
 };
@@ -4635,6 +4638,9 @@ static int mlx5_ib_stage_caps_init(struct mlx5_ib_dev *dev)
 
 	ib_set_device_ops(&dev->ib_dev, &mlx5_ib_dev_ops);
 
+	if (MLX5_CAP_GEN(mdev, cq_resize))
+		ib_set_device_ops(&dev->ib_dev, &mlx5_ib_dev_resize_cq_ops);
+
 	if (IS_ENABLED(CONFIG_INFINIBAND_USER_ACCESS))
 		dev->ib_dev.driver_def = mlx5_ib_defs;
 

-- 
2.52.0


