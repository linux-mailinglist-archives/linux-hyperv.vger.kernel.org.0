Return-Path: <linux-hyperv+bounces-8837-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UL8oMcIGj2mOHQEAu9opvQ
	(envelope-from <linux-hyperv+bounces-8837-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Feb 2026 12:10:58 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 630E913586B
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Feb 2026 12:10:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E518A319ACFE
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Feb 2026 11:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1CA4361DDE;
	Fri, 13 Feb 2026 11:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o0g4HcHl"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA1B35B65A;
	Fri, 13 Feb 2026 11:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770980482; cv=none; b=Db4OrPHL04MYLtA5T53tsosuW2BDHgxEX6BpoEHB0qbg9mHper9mhbztWMhbcwd+47v4NjWdbyN10beS8B+LpgANf58x2WapDJ4Og9hiadBfdaxv6oHvC4rPmU1SMrwo5zhY1gOhgX9gXeJ6hNyWP+W+5cgIAkUsWQp+2plImGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770980482; c=relaxed/simple;
	bh=tXRqtUNviOmDa3CJM4kPPztr+SgPVsUWwArMbQICjMA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O3GzPlR8UwIWLedCdWsK9EM7Y95x/P0pOYHSz7lgT9S87pg5bjr8NM4IDFDyDWe4B670nhZZIC2mL6T6EwO6ukWE+dXV1e9Nrc001P74kzr8K4je96MsPe7IMxjbTP2QmJjcO3iqiNS5QVXhgnR4/lORBKQhKumcL0HeQqa5Atc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o0g4HcHl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC2D5C116C6;
	Fri, 13 Feb 2026 11:01:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770980482;
	bh=tXRqtUNviOmDa3CJM4kPPztr+SgPVsUWwArMbQICjMA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o0g4HcHli8BNvHZMz3n5MdlxoKr3vz20VnV3/QIOrpBVtL/LeqkEjPOJvDkyAXZ7a
	 50hvMeVlKkercF2pJhC7K4M/O9Nf6Wl0NVgM+IUdRjvQ1tbpfGeWzRxY3FEyZxXr69
	 7v2P9rIuA4eF1J0SdrjexwI1uyvBOdogaBm8wUKBkp9qihhheYXY0m/sXga7/KVjEf
	 HwzWJR7phxi8gWzQ7uZ/ZSYBKUb0y4zrjvYIGpb3kWo53ktePyEMIovX7eYH0gSB66
	 VF7kyA5z4yNKpKeuYdNZ0Z3dsE5I2A54xdzpT2sOR56I+IPcA4X5BPvE8XM61U6cKR
	 hh8RgpGlNvRvQ==
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
Subject: [PATCH rdma-next 36/50] RDMA/mlx5: Remove support for resizing kernel CQs
Date: Fri, 13 Feb 2026 12:58:12 +0200
Message-ID: <20260213-refactor-umem-v1-36-f3be85847922@nvidia.com>
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
	TAGGED_FROM(0.00)[bounces-8837-lists,linux-hyperv=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 630E913586B
X-Rspamd-Action: no action

From: Leon Romanovsky <leonro@nvidia.com>

No ULP users rely on CQ resize support, so drop the unused code.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/cq.c | 161 +++++-----------------------------------
 1 file changed, 18 insertions(+), 143 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/cq.c b/drivers/infiniband/hw/mlx5/cq.c
index 52a435efd0de..ce20af01cde0 100644
--- a/drivers/infiniband/hw/mlx5/cq.c
+++ b/drivers/infiniband/hw/mlx5/cq.c
@@ -74,11 +74,6 @@ static void *get_cqe(struct mlx5_ib_cq *cq, int n)
 	return mlx5_frag_buf_get_wqe(&cq->buf.fbc, n);
 }
 
-static u8 sw_ownership_bit(int n, int nent)
-{
-	return (n & nent) ? 1 : 0;
-}
-
 static void *get_sw_cqe(struct mlx5_ib_cq *cq, int n)
 {
 	void *cqe = get_cqe(cq, n & cq->ibcq.cqe);
@@ -1258,87 +1253,11 @@ static int resize_user(struct mlx5_ib_dev *dev, struct mlx5_ib_cq *cq,
 	return 0;
 }
 
-static int resize_kernel(struct mlx5_ib_dev *dev, struct mlx5_ib_cq *cq,
-			 int entries, int cqe_size)
-{
-	int err;
-
-	cq->resize_buf = kzalloc(sizeof(*cq->resize_buf), GFP_KERNEL);
-	if (!cq->resize_buf)
-		return -ENOMEM;
-
-	err = alloc_cq_frag_buf(dev, cq->resize_buf, entries, cqe_size);
-	if (err)
-		goto ex;
-
-	init_cq_frag_buf(cq->resize_buf);
-
-	return 0;
-
-ex:
-	kfree(cq->resize_buf);
-	return err;
-}
-
-static int copy_resize_cqes(struct mlx5_ib_cq *cq)
-{
-	struct mlx5_ib_dev *dev = to_mdev(cq->ibcq.device);
-	struct mlx5_cqe64 *scqe64;
-	struct mlx5_cqe64 *dcqe64;
-	void *start_cqe;
-	void *scqe;
-	void *dcqe;
-	int ssize;
-	int dsize;
-	int i;
-	u8 sw_own;
-
-	ssize = cq->buf.cqe_size;
-	dsize = cq->resize_buf->cqe_size;
-	if (ssize != dsize) {
-		mlx5_ib_warn(dev, "resize from different cqe size is not supported\n");
-		return -EINVAL;
-	}
-
-	i = cq->mcq.cons_index;
-	scqe = get_sw_cqe(cq, i);
-	scqe64 = ssize == 64 ? scqe : scqe + 64;
-	start_cqe = scqe;
-	if (!scqe) {
-		mlx5_ib_warn(dev, "expected cqe in sw ownership\n");
-		return -EINVAL;
-	}
-
-	while (get_cqe_opcode(scqe64) != MLX5_CQE_RESIZE_CQ) {
-		dcqe = mlx5_frag_buf_get_wqe(&cq->resize_buf->fbc,
-					     (i + 1) & cq->resize_buf->nent);
-		dcqe64 = dsize == 64 ? dcqe : dcqe + 64;
-		sw_own = sw_ownership_bit(i + 1, cq->resize_buf->nent);
-		memcpy(dcqe, scqe, dsize);
-		dcqe64->op_own = (dcqe64->op_own & ~MLX5_CQE_OWNER_MASK) | sw_own;
-
-		++i;
-		scqe = get_sw_cqe(cq, i);
-		scqe64 = ssize == 64 ? scqe : scqe + 64;
-		if (!scqe) {
-			mlx5_ib_warn(dev, "expected cqe in sw ownership\n");
-			return -EINVAL;
-		}
-
-		if (scqe == start_cqe) {
-			pr_warn("resize CQ failed to get resize CQE, CQN 0x%x\n",
-				cq->mcq.cqn);
-			return -ENOMEM;
-		}
-	}
-	++cq->mcq.cons_index;
-	return 0;
-}
-
 int mlx5_ib_resize_cq(struct ib_cq *ibcq, int entries, struct ib_udata *udata)
 {
 	struct mlx5_ib_dev *dev = to_mdev(ibcq->device);
 	struct mlx5_ib_cq *cq = to_mcq(ibcq);
+	unsigned long page_size;
 	void *cqc;
 	u32 *in;
 	int err;
@@ -1348,7 +1267,6 @@ int mlx5_ib_resize_cq(struct ib_cq *ibcq, int entries, struct ib_udata *udata)
 	unsigned int page_shift;
 	int inlen;
 	int cqe_size;
-	unsigned long flags;
 
 	if (!MLX5_CAP_GEN(dev->mdev, cq_resize)) {
 		pr_info("Firmware does not support resize CQ\n");
@@ -1371,34 +1289,19 @@ int mlx5_ib_resize_cq(struct ib_cq *ibcq, int entries, struct ib_udata *udata)
 		return 0;
 
 	mutex_lock(&cq->resize_mutex);
-	if (udata) {
-		unsigned long page_size;
-
-		err = resize_user(dev, cq, entries, udata, &cqe_size);
-		if (err)
-			goto ex;
-
-		page_size = mlx5_umem_find_best_cq_quantized_pgoff(
-			cq->resize_umem, cqc, log_page_size,
-			MLX5_ADAPTER_PAGE_SHIFT, page_offset, 64,
-			&page_offset_quantized);
-		if (!page_size) {
-			err = -EINVAL;
-			goto ex_resize;
-		}
-		npas = ib_umem_num_dma_blocks(cq->resize_umem, page_size);
-		page_shift = order_base_2(page_size);
-	} else {
-		struct mlx5_frag_buf *frag_buf;
+	err = resize_user(dev, cq, entries, udata, &cqe_size);
+	if (err)
+		goto ex;
 
-		cqe_size = 64;
-		err = resize_kernel(dev, cq, entries, cqe_size);
-		if (err)
-			goto ex;
-		frag_buf = &cq->resize_buf->frag_buf;
-		npas = frag_buf->npages;
-		page_shift = frag_buf->page_shift;
+	page_size = mlx5_umem_find_best_cq_quantized_pgoff(
+		cq->resize_umem, cqc, log_page_size, MLX5_ADAPTER_PAGE_SHIFT,
+		page_offset, 64, &page_offset_quantized);
+	if (!page_size) {
+		err = -EINVAL;
+		goto ex_resize;
 	}
+	npas = ib_umem_num_dma_blocks(cq->resize_umem, page_size);
+	page_shift = order_base_2(page_size);
 
 	inlen = MLX5_ST_SZ_BYTES(modify_cq_in) +
 		MLX5_FLD_SZ_BYTES(modify_cq_in, pas[0]) * npas;
@@ -1410,11 +1313,7 @@ int mlx5_ib_resize_cq(struct ib_cq *ibcq, int entries, struct ib_udata *udata)
 	}
 
 	pas = (__be64 *)MLX5_ADDR_OF(modify_cq_in, in, pas);
-	if (udata)
-		mlx5_ib_populate_pas(cq->resize_umem, 1UL << page_shift, pas,
-				     0);
-	else
-		mlx5_fill_page_frag_array(&cq->resize_buf->frag_buf, pas);
+	mlx5_ib_populate_pas(cq->resize_umem, 1UL << page_shift, pas, 0);
 
 	MLX5_SET(modify_cq_in, in,
 		 modify_field_select_resize_field_select.resize_field_select.resize_field_select,
@@ -1440,31 +1339,10 @@ int mlx5_ib_resize_cq(struct ib_cq *ibcq, int entries, struct ib_udata *udata)
 	if (err)
 		goto ex_alloc;
 
-	if (udata) {
-		cq->ibcq.cqe = entries - 1;
-		ib_umem_release(cq->ibcq.umem);
-		cq->ibcq.umem = cq->resize_umem;
-		cq->resize_umem = NULL;
-	} else {
-		struct mlx5_ib_cq_buf tbuf;
-		int resized = 0;
-
-		spin_lock_irqsave(&cq->lock, flags);
-		if (cq->resize_buf) {
-			err = copy_resize_cqes(cq);
-			if (!err) {
-				tbuf = cq->buf;
-				cq->buf = *cq->resize_buf;
-				kfree(cq->resize_buf);
-				cq->resize_buf = NULL;
-				resized = 1;
-			}
-		}
-		cq->ibcq.cqe = entries - 1;
-		spin_unlock_irqrestore(&cq->lock, flags);
-		if (resized)
-			free_cq_buf(dev, &tbuf);
-	}
+	cq->ibcq.cqe = entries - 1;
+	ib_umem_release(cq->ibcq.umem);
+	cq->ibcq.umem = cq->resize_umem;
+	cq->resize_umem = NULL;
 	mutex_unlock(&cq->resize_mutex);
 
 	kvfree(in);
@@ -1475,10 +1353,7 @@ int mlx5_ib_resize_cq(struct ib_cq *ibcq, int entries, struct ib_udata *udata)
 
 ex_resize:
 	ib_umem_release(cq->resize_umem);
-	if (!udata) {
-		free_cq_buf(dev, cq->resize_buf);
-		cq->resize_buf = NULL;
-	}
+	cq->resize_umem = NULL;
 ex:
 	mutex_unlock(&cq->resize_mutex);
 	return err;

-- 
2.52.0


