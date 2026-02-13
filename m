Return-Path: <linux-hyperv+bounces-8846-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KHXeM+oHj2ltHQEAu9opvQ
	(envelope-from <linux-hyperv+bounces-8846-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Feb 2026 12:15:54 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3311D1359E8
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Feb 2026 12:15:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5F82D310ED85
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Feb 2026 11:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 970A135DD11;
	Fri, 13 Feb 2026 11:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rsk1ivq2"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 726841F03EF;
	Fri, 13 Feb 2026 11:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770980517; cv=none; b=OabCeXlSs6HeadUhFaAoQfZ944OOGhFSoCt0Xzn5tkt3M63Y4NwOKFQjXxB8FfOX6oBwWN4rVUuXpRSunR2bC1Wscg7QNp9/rVhZf66XUhMVYkeTpPJytkOrz873t05UPd/TU7AzB6xpvu+bxxZKbfyB9bPBahl3a/WpdjmBp0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770980517; c=relaxed/simple;
	bh=fNGUs5AQ9nFbUrFwGoGxWr1OmLlcSEue3DXaKTPPRPk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=txlYzhtRPnIrezTOucUUE4BP1qeesmf+qUZ/6ul0TpwLhBOXkZ7dFm351aGTdws8Z/OJAElpjz4RgczqRXCPlyaXOHx8HW8pVlbLd7CcSyK1IsN2nOoGuqCOG50YLXWcgHe//a9v1AhT1OxMJTGZwQa0wCzklBBFQu70LsrZBQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rsk1ivq2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 128FAC116C6;
	Fri, 13 Feb 2026 11:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770980517;
	bh=fNGUs5AQ9nFbUrFwGoGxWr1OmLlcSEue3DXaKTPPRPk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rsk1ivq24d8TYk4UHjpwCHlqD31mwB7ASM9n0clduY4Zji/wYQ9eFiS7t9WmezbPG
	 FJ54S2ojCM/lw4qqX5Ep1QIKruMUTz9V9GRa+1rnqh2OqwVAKETBVvYsqEdWTtQzNf
	 ahdkZany5kNDlNXkf+WT9aOE4AD/+QCsGHYn08icjUVfM/txKOUpFyO5cOLOKM9O6t
	 FPp2oncY193CPGUA+4k1Gl8ZLFniOzPtKZPFSAVBWbKs8lQxBMxQSJygwOnchutPoy
	 oUB78fzdDPWMPzqYtNYii+RNVqX054Hr0mXPskQxFuzxcf+AvsmU6PfquC2oUSXXow
	 eQGHUGguxz9oA==
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
Subject: [PATCH rdma-next 49/50] RDMA/mlx5: Reduce CQ memory footprint
Date: Fri, 13 Feb 2026 12:58:25 +0200
Message-ID: <20260213-refactor-umem-v1-49-f3be85847922@nvidia.com>
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
	TAGGED_FROM(0.00)[bounces-8846-lists,linux-hyperv=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:mid,nvidia.com:email]
X-Rspamd-Queue-Id: 3311D1359E8
X-Rspamd-Action: no action

From: Leon Romanovsky <leonro@nvidia.com>

There is no need to store a temporary umem pointer in the generic CQ
object. Use an on‑stack variable instead.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/cq.c      | 64 ++++++++++++------------------------
 drivers/infiniband/hw/mlx5/mlx5_ib.h |  1 -
 2 files changed, 21 insertions(+), 44 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/cq.c b/drivers/infiniband/hw/mlx5/cq.c
index 88f0f5e2944f..6d9b62742674 100644
--- a/drivers/infiniband/hw/mlx5/cq.c
+++ b/drivers/infiniband/hw/mlx5/cq.c
@@ -1218,44 +1218,13 @@ int mlx5_ib_modify_cq(struct ib_cq *cq, u16 cq_count, u16 cq_period)
 	return err;
 }
 
-static int resize_user(struct mlx5_ib_dev *dev, struct mlx5_ib_cq *cq,
-		       int entries, struct ib_udata *udata,
-		       int *cqe_size)
-{
-	struct mlx5_ib_resize_cq ucmd;
-	struct ib_umem *umem;
-	int err;
-
-	err = ib_copy_from_udata(&ucmd, udata, sizeof(ucmd));
-	if (err)
-		return err;
-
-	if (ucmd.reserved0 || ucmd.reserved1)
-		return -EINVAL;
-
-	/* check multiplication overflow */
-	if (ucmd.cqe_size && SIZE_MAX / ucmd.cqe_size <= entries - 1)
-		return -EINVAL;
-
-	umem = ib_umem_get(&dev->ib_dev, ucmd.buf_addr,
-			   (size_t)ucmd.cqe_size * entries,
-			   IB_ACCESS_LOCAL_WRITE);
-	if (IS_ERR(umem)) {
-		err = PTR_ERR(umem);
-		return err;
-	}
-
-	cq->resize_umem = umem;
-	*cqe_size = ucmd.cqe_size;
-
-	return 0;
-}
-
 int mlx5_ib_resize_cq(struct ib_cq *ibcq, unsigned int entries,
 		      struct ib_udata *udata)
 {
 	struct mlx5_ib_dev *dev = to_mdev(ibcq->device);
 	struct mlx5_ib_cq *cq = to_mcq(ibcq);
+	struct mlx5_ib_resize_cq ucmd;
+	struct ib_umem *umem;
 	unsigned long page_size;
 	void *cqc;
 	u32 *in;
@@ -1264,8 +1233,8 @@ int mlx5_ib_resize_cq(struct ib_cq *ibcq, unsigned int entries,
 	__be64 *pas;
 	unsigned int page_offset_quantized = 0;
 	unsigned int page_shift;
+	size_t umem_size;
 	int inlen;
-	int cqe_size;
 
 	if (entries > (1 << MLX5_CAP_GEN(dev->mdev, log_max_cq_sz)))
 		return -EINVAL;
@@ -1277,18 +1246,29 @@ int mlx5_ib_resize_cq(struct ib_cq *ibcq, unsigned int entries,
 	if (entries == ibcq->cqe + 1)
 		return 0;
 
-	err = resize_user(dev, cq, entries, udata, &cqe_size);
+	err = ib_copy_from_udata(&ucmd, udata, sizeof(ucmd));
 	if (err)
 		return err;
 
+	if (ucmd.reserved0 || ucmd.reserved1)
+		return -EINVAL;
+
+	if (check_mul_overflow(ucmd.cqe_size, entries, &umem_size))
+		return -EINVAL;
+
+	umem = ib_umem_get(&dev->ib_dev, ucmd.buf_addr, umem_size,
+			   IB_ACCESS_LOCAL_WRITE);
+	if (IS_ERR(umem))
+		return PTR_ERR(umem);
+
 	page_size = mlx5_umem_find_best_cq_quantized_pgoff(
-		cq->resize_umem, cqc, log_page_size, MLX5_ADAPTER_PAGE_SHIFT,
+		umem, cqc, log_page_size, MLX5_ADAPTER_PAGE_SHIFT,
 		page_offset, 64, &page_offset_quantized);
 	if (!page_size) {
 		err = -EINVAL;
 		goto ex_resize;
 	}
-	npas = ib_umem_num_dma_blocks(cq->resize_umem, page_size);
+	npas = ib_umem_num_dma_blocks(umem, page_size);
 	page_shift = order_base_2(page_size);
 
 	inlen = MLX5_ST_SZ_BYTES(modify_cq_in) +
@@ -1301,7 +1281,7 @@ int mlx5_ib_resize_cq(struct ib_cq *ibcq, unsigned int entries,
 	}
 
 	pas = (__be64 *)MLX5_ADDR_OF(modify_cq_in, in, pas);
-	mlx5_ib_populate_pas(cq->resize_umem, 1UL << page_shift, pas, 0);
+	mlx5_ib_populate_pas(umem, 1UL << page_shift, pas, 0);
 
 	MLX5_SET(modify_cq_in, in,
 		 modify_field_select_resize_field_select.resize_field_select.resize_field_select,
@@ -1315,7 +1295,7 @@ int mlx5_ib_resize_cq(struct ib_cq *ibcq, unsigned int entries,
 		 page_shift - MLX5_ADAPTER_PAGE_SHIFT);
 	MLX5_SET(cqc, cqc, page_offset, page_offset_quantized);
 	MLX5_SET(cqc, cqc, cqe_sz,
-		 cqe_sz_to_mlx_sz(cqe_size,
+		 cqe_sz_to_mlx_sz(ucmd.cqe_size,
 				  cq->private_flags &
 				  MLX5_IB_CQ_PR_FLAGS_CQE_128_PAD));
 	MLX5_SET(cqc, cqc, log_cq_size, ilog2(entries));
@@ -1329,8 +1309,7 @@ int mlx5_ib_resize_cq(struct ib_cq *ibcq, unsigned int entries,
 
 	cq->ibcq.cqe = entries - 1;
 	ib_umem_release(cq->ibcq.umem);
-	cq->ibcq.umem = cq->resize_umem;
-	cq->resize_umem = NULL;
+	cq->ibcq.umem = umem;
 
 	kvfree(in);
 	return 0;
@@ -1339,8 +1318,7 @@ int mlx5_ib_resize_cq(struct ib_cq *ibcq, unsigned int entries,
 	kvfree(in);
 
 ex_resize:
-	ib_umem_release(cq->resize_umem);
-	cq->resize_umem = NULL;
+	ib_umem_release(umem);
 	return err;
 }
 
diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index 7b34f32b5ecb..11e4b2ae0469 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -575,7 +575,6 @@ struct mlx5_ib_cq {
 	spinlock_t		lock;
 
 	struct mlx5_ib_cq_buf  *resize_buf;
-	struct ib_umem	       *resize_umem;
 	int			cqe_size;
 	struct list_head	list_send_qp;
 	struct list_head	list_recv_qp;

-- 
2.52.0


