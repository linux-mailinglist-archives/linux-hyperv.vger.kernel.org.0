Return-Path: <linux-hyperv+bounces-8832-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iLrIHBAGj2ltHQEAu9opvQ
	(envelope-from <linux-hyperv+bounces-8832-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Feb 2026 12:08:00 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F78A13577C
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Feb 2026 12:07:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0658631790D3
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Feb 2026 11:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EE7C35A939;
	Fri, 13 Feb 2026 11:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="suCrbUt5"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B2213563EE;
	Fri, 13 Feb 2026 11:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770980464; cv=none; b=epMzOApNAAX/QFHypIsST+pRmAFktFZOE4fmm2MZvgwoTvOqc24rXiTQKYQHj/FZXksy8Wn+JqWyWqbTv3wSJCJhqnsLM0tHypvBVk2v01UTvAGh3+dRt04wfo7A2FRZKRLYWrMXXYXYpfFmuqMf8eTcBYOwP2oz6i7oA1EBke4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770980464; c=relaxed/simple;
	bh=cXVPMCACaL/gKFCQ/f3NUv6u2y9sogOUml+fOjhCVfE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=el4pgY49LFuAf8+8tdv9Mc/NmjUTQBEH1zzZU4+zyN5WCI7P7dqIW8k8FndB5rAPwhXVjcKigYo2GGP1l+Tlpbuoc0GvHYojl+oN9PUWdbxh0MaWKYudORzFJlcDkGBrLfutWnuP9y9GjjlwIpBUdLE6Eaw7m+9KgVGoUWdCdJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=suCrbUt5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 313DAC116C6;
	Fri, 13 Feb 2026 11:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770980464;
	bh=cXVPMCACaL/gKFCQ/f3NUv6u2y9sogOUml+fOjhCVfE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=suCrbUt5uobz+J8Zy+H2OulDR2mfdrJR0brxW3fwatLE/yC+GHU1zAwiEII9nGIlH
	 dwB7IM0le2zD/3l7+CsDSeQXhaZ30wsUn9AePU+13uEMQqCGmvv80yDQysD1LNPXMy
	 BsN0wxScW7nm5ncAEhNBPrkkgWqKhYGXU/uoPkXPsOlrG2PTwIN1/qDK2+KAyBDuJe
	 wUU8gBfSj9opmPAciR81jKqlqJ6jtSK4/YFNPU3q9CIXTNDJ/75rMJbFiZcG9IFDHd
	 tTh4Wr8bl2lkx2F3s0iyqxv0ayEPgZqjz/nbflxUmcqzWsIgZBnNq/LZiV60TSLkBZ
	 mP1U5Y6AXvWjw==
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
Subject: [PATCH rdma-next 35/50] RDMA/mlx4: Remove support for kernel CQ resize
Date: Fri, 13 Feb 2026 12:58:11 +0200
Message-ID: <20260213-refactor-umem-v1-35-f3be85847922@nvidia.com>
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
	TAGGED_FROM(0.00)[bounces-8832-lists,linux-hyperv=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1F78A13577C
X-Rspamd-Action: no action

From: Leon Romanovsky <leonro@nvidia.com>

No upper‑layer protocol currently uses CQ resize, and the feature has no
active callers. Drop the unused functionality.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx4/cq.c | 167 +++++-----------------------------------
 1 file changed, 21 insertions(+), 146 deletions(-)

diff --git a/drivers/infiniband/hw/mlx4/cq.c b/drivers/infiniband/hw/mlx4/cq.c
index 83169060d120..05fad06b89c2 100644
--- a/drivers/infiniband/hw/mlx4/cq.c
+++ b/drivers/infiniband/hw/mlx4/cq.c
@@ -296,30 +296,6 @@ int mlx4_ib_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 	return err;
 }
 
-static int mlx4_alloc_resize_buf(struct mlx4_ib_dev *dev, struct mlx4_ib_cq *cq,
-				  int entries)
-{
-	int err;
-
-	if (cq->resize_buf)
-		return -EBUSY;
-
-	cq->resize_buf = kmalloc(sizeof *cq->resize_buf, GFP_KERNEL);
-	if (!cq->resize_buf)
-		return -ENOMEM;
-
-	err = mlx4_ib_alloc_cq_buf(dev, &cq->resize_buf->buf, entries);
-	if (err) {
-		kfree(cq->resize_buf);
-		cq->resize_buf = NULL;
-		return err;
-	}
-
-	cq->resize_buf->cqe = entries - 1;
-
-	return 0;
-}
-
 static int mlx4_alloc_resize_umem(struct mlx4_ib_dev *dev, struct mlx4_ib_cq *cq,
 				   int entries, struct ib_udata *udata)
 {
@@ -329,9 +305,6 @@ static int mlx4_alloc_resize_umem(struct mlx4_ib_dev *dev, struct mlx4_ib_cq *cq
 	int n;
 	int err;
 
-	if (cq->resize_umem)
-		return -EBUSY;
-
 	if (ib_copy_from_udata(&ucmd, udata, sizeof ucmd))
 		return -EFAULT;
 
@@ -371,91 +344,36 @@ static int mlx4_alloc_resize_umem(struct mlx4_ib_dev *dev, struct mlx4_ib_cq *cq
 
 err_umem:
 	ib_umem_release(cq->resize_umem);
-
+	cq->resize_umem = NULL;
 err_buf:
 	kfree(cq->resize_buf);
 	cq->resize_buf = NULL;
 	return err;
 }
 
-static int mlx4_ib_get_outstanding_cqes(struct mlx4_ib_cq *cq)
-{
-	u32 i;
-
-	i = cq->mcq.cons_index;
-	while (get_sw_cqe(cq, i))
-		++i;
-
-	return i - cq->mcq.cons_index;
-}
-
-static void mlx4_ib_cq_resize_copy_cqes(struct mlx4_ib_cq *cq)
-{
-	struct mlx4_cqe *cqe, *new_cqe;
-	int i;
-	int cqe_size = cq->buf.entry_size;
-	int cqe_inc = cqe_size == 64 ? 1 : 0;
-
-	i = cq->mcq.cons_index;
-	cqe = get_cqe(cq, i & cq->ibcq.cqe);
-	cqe += cqe_inc;
-
-	while ((cqe->owner_sr_opcode & MLX4_CQE_OPCODE_MASK) != MLX4_CQE_OPCODE_RESIZE) {
-		new_cqe = get_cqe_from_buf(&cq->resize_buf->buf,
-					   (i + 1) & cq->resize_buf->cqe);
-		memcpy(new_cqe, get_cqe(cq, i & cq->ibcq.cqe), cqe_size);
-		new_cqe += cqe_inc;
-
-		new_cqe->owner_sr_opcode = (cqe->owner_sr_opcode & ~MLX4_CQE_OWNER_MASK) |
-			(((i + 1) & (cq->resize_buf->cqe + 1)) ? MLX4_CQE_OWNER_MASK : 0);
-		cqe = get_cqe(cq, ++i & cq->ibcq.cqe);
-		cqe += cqe_inc;
-	}
-	++cq->mcq.cons_index;
-}
-
 int mlx4_ib_resize_cq(struct ib_cq *ibcq, int entries, struct ib_udata *udata)
 {
 	struct mlx4_ib_dev *dev = to_mdev(ibcq->device);
 	struct mlx4_ib_cq *cq = to_mcq(ibcq);
 	struct mlx4_mtt mtt;
-	int outst_cqe;
 	int err;
 
-	mutex_lock(&cq->resize_mutex);
-	if (entries < 1 || entries > dev->dev->caps.max_cqes) {
-		err = -EINVAL;
-		goto out;
-	}
+	if (entries < 1 || entries > dev->dev->caps.max_cqes)
+		return -EINVAL;
 
 	entries = roundup_pow_of_two(entries + 1);
-	if (entries == ibcq->cqe + 1) {
-		err = 0;
-		goto out;
-	}
-
-	if (entries > dev->dev->caps.max_cqes + 1) {
-		err = -EINVAL;
-		goto out;
-	}
+	if (entries == ibcq->cqe + 1)
+		return 0;
 
-	if (ibcq->uobject) {
-		err = mlx4_alloc_resize_umem(dev, cq, entries, udata);
-		if (err)
-			goto out;
-	} else {
-		/* Can't be smaller than the number of outstanding CQEs */
-		outst_cqe = mlx4_ib_get_outstanding_cqes(cq);
-		if (entries < outst_cqe + 1) {
-			err = -EINVAL;
-			goto out;
-		}
+	if (entries > dev->dev->caps.max_cqes + 1)
+		return -EINVAL;
 
-		err = mlx4_alloc_resize_buf(dev, cq, entries);
-		if (err)
-			goto out;
+	mutex_lock(&cq->resize_mutex);
+	err = mlx4_alloc_resize_umem(dev, cq, entries, udata);
+	if (err) {
+		mutex_unlock(&cq->resize_mutex);
+		return err;
 	}
-
 	mtt = cq->buf.mtt;
 
 	err = mlx4_cq_resize(dev->dev, &cq->mcq, entries, &cq->resize_buf->buf.mtt);
@@ -463,52 +381,26 @@ int mlx4_ib_resize_cq(struct ib_cq *ibcq, int entries, struct ib_udata *udata)
 		goto err_buf;
 
 	mlx4_mtt_cleanup(dev->dev, &mtt);
-	if (ibcq->uobject) {
-		cq->buf      = cq->resize_buf->buf;
-		cq->ibcq.cqe = cq->resize_buf->cqe;
-		ib_umem_release(cq->ibcq.umem);
-		cq->ibcq.umem     = cq->resize_umem;
-
-		kfree(cq->resize_buf);
-		cq->resize_buf = NULL;
-		cq->resize_umem = NULL;
-	} else {
-		struct mlx4_ib_cq_buf tmp_buf;
-		int tmp_cqe = 0;
-
-		spin_lock_irq(&cq->lock);
-		if (cq->resize_buf) {
-			mlx4_ib_cq_resize_copy_cqes(cq);
-			tmp_buf = cq->buf;
-			tmp_cqe = cq->ibcq.cqe;
-			cq->buf      = cq->resize_buf->buf;
-			cq->ibcq.cqe = cq->resize_buf->cqe;
-
-			kfree(cq->resize_buf);
-			cq->resize_buf = NULL;
-		}
-		spin_unlock_irq(&cq->lock);
+	cq->buf = cq->resize_buf->buf;
+	cq->ibcq.cqe = cq->resize_buf->cqe;
+	ib_umem_release(cq->ibcq.umem);
+	cq->ibcq.umem = cq->resize_umem;
 
-		if (tmp_cqe)
-			mlx4_ib_free_cq_buf(dev, &tmp_buf, tmp_cqe);
-	}
+	kfree(cq->resize_buf);
+	cq->resize_buf = NULL;
+	cq->resize_umem = NULL;
+	mutex_unlock(&cq->resize_mutex);
+	return 0;
 
-	goto out;
 
 err_buf:
 	mlx4_mtt_cleanup(dev->dev, &cq->resize_buf->buf.mtt);
-	if (!ibcq->uobject)
-		mlx4_ib_free_cq_buf(dev, &cq->resize_buf->buf,
-				    cq->resize_buf->cqe);
-
 	kfree(cq->resize_buf);
 	cq->resize_buf = NULL;
 
 	ib_umem_release(cq->resize_umem);
 	cq->resize_umem = NULL;
-out:
 	mutex_unlock(&cq->resize_mutex);
-
 	return err;
 }
 
@@ -707,7 +599,6 @@ static int mlx4_ib_poll_one(struct mlx4_ib_cq *cq,
 	u16 wqe_ctr;
 	unsigned tail = 0;
 
-repoll:
 	cqe = next_cqe_sw(cq);
 	if (!cqe)
 		return -EAGAIN;
@@ -727,22 +618,6 @@ static int mlx4_ib_poll_one(struct mlx4_ib_cq *cq,
 	is_error = (cqe->owner_sr_opcode & MLX4_CQE_OPCODE_MASK) ==
 		MLX4_CQE_OPCODE_ERROR;
 
-	/* Resize CQ in progress */
-	if (unlikely((cqe->owner_sr_opcode & MLX4_CQE_OPCODE_MASK) == MLX4_CQE_OPCODE_RESIZE)) {
-		if (cq->resize_buf) {
-			struct mlx4_ib_dev *dev = to_mdev(cq->ibcq.device);
-
-			mlx4_ib_free_cq_buf(dev, &cq->buf, cq->ibcq.cqe);
-			cq->buf      = cq->resize_buf->buf;
-			cq->ibcq.cqe = cq->resize_buf->cqe;
-
-			kfree(cq->resize_buf);
-			cq->resize_buf = NULL;
-		}
-
-		goto repoll;
-	}
-
 	if (!*cur_qp ||
 	    (be32_to_cpu(cqe->vlan_my_qpn) & MLX4_CQE_QPN_MASK) != (*cur_qp)->mqp.qpn) {
 		/*

-- 
2.52.0


