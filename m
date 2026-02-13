Return-Path: <linux-hyperv+bounces-8843-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id T3RiElcHj2maHQEAu9opvQ
	(envelope-from <linux-hyperv+bounces-8843-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Feb 2026 12:13:27 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CB789135944
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Feb 2026 12:13:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A91EB31CAC39
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Feb 2026 11:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C068635CBA8;
	Fri, 13 Feb 2026 11:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sjUw6VIJ"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C5193590B9;
	Fri, 13 Feb 2026 11:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770980506; cv=none; b=rnbyfHco1a9NAsxlBYZfgcyoO5gEo/iiEhTmmJ/OndglfqNTxCOvI0NIi609u7MSN/DlpGLnryflFwGvhzpYPmylmYtK30pvosXGFQuyiDWIu9aoTurVW/5RTZovmmJVsv8kDrE44a01DghTirKtvunMtY+zrXsNhLqveOh43OA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770980506; c=relaxed/simple;
	bh=f6V1fjY9WirwAECtXhaEuYokIqrMGjYjGYMTtnDJg58=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qIEmJXP/QitmVUtm6gJDVzrXYWg2kJ4CSIgpCHWGqkCyZQGDrEHvSw6v/+ZXVdtRo3kPM84XnhsLKDX7pReP7vhm4PQmEtI/+Qila1duIa9+/RGQvK+wgM5OpnxD4TfpfnLMnEWbC0fuSTBDGvmQiLZ5f8Onr2K7xp6GIoqGjmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sjUw6VIJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 850A6C116C6;
	Fri, 13 Feb 2026 11:01:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770980506;
	bh=f6V1fjY9WirwAECtXhaEuYokIqrMGjYjGYMTtnDJg58=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sjUw6VIJrOM7FaQeUGj5yRGevXgJSzJv+XxWkvFaaCJZh9KW8Wb048OyGGDrmQ56S
	 8ENf+YR2sD/FshaildMlvyeBf4KpZbZzBS48wScVLWixlPMZcL+E5jIIBhqdSmv+6Q
	 0EIUp7H4taOwXzx/Ijnpk1wFqUWo3rDHtylsVczJTVLc/ODBWmVNnkVxpok47sQVKz
	 suBX7DxP2TKzi1ejyBkG5RxSaN6PJ/+aNHpgdek4BK03n7qnD7ObU9l49Gu5pqCkSp
	 6cAgA+yjjTClBpjuU7G/aEinwMWvIJgwyP4s4IM7KRLn9bJ62FsVZ8ypkVktg8QbuH
	 yFIAFn5emSFDg==
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
Subject: =?utf-8?q?=5BPATCH_rdma-next_46/50=5D_RDMA/mlx4=3A_Use_on=E2=80?= =?utf-8?q?=91stack_variables_instead_of_storing_them_in_the_CQ_object?=
Date: Fri, 13 Feb 2026 12:58:22 +0200
Message-ID: <20260213-refactor-umem-v1-46-f3be85847922@nvidia.com>
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
	TAGGED_FROM(0.00)[bounces-8843-lists,linux-hyperv=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:mid,nvidia.com:email]
X-Rspamd-Queue-Id: CB789135944
X-Rspamd-Action: no action

From: Leon Romanovsky <leonro@nvidia.com>

These variables do not need to persist for the lifetime of the CQ object.
They can be safely allocated on the stack instead.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx4/cq.c      | 81 +++++++++++++-----------------------
 drivers/infiniband/hw/mlx4/mlx4_ib.h |  1 -
 2 files changed, 28 insertions(+), 54 deletions(-)

diff --git a/drivers/infiniband/hw/mlx4/cq.c b/drivers/infiniband/hw/mlx4/cq.c
index ffc3902dc329..6e8017ecf137 100644
--- a/drivers/infiniband/hw/mlx4/cq.c
+++ b/drivers/infiniband/hw/mlx4/cq.c
@@ -294,15 +294,29 @@ int mlx4_ib_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 	return err;
 }
 
-static int mlx4_alloc_resize_umem(struct mlx4_ib_dev *dev, struct mlx4_ib_cq *cq,
-				   int entries, struct ib_udata *udata)
+int mlx4_ib_resize_cq(struct ib_cq *ibcq, unsigned int entries,
+		      struct ib_udata *udata)
 {
+	struct mlx4_ib_dev *dev = to_mdev(ibcq->device);
+	struct mlx4_ib_cq *cq = to_mcq(ibcq);
 	struct mlx4_ib_resize_cq ucmd;
 	int cqe_size = dev->dev->caps.cqe_size;
+	struct ib_umem *umem;
+	struct mlx4_mtt mtt;
 	int shift;
 	int n;
 	int err;
 
+	if (entries > dev->dev->caps.max_cqes)
+		return -EINVAL;
+
+	entries = roundup_pow_of_two(entries + 1);
+	if (entries == ibcq->cqe + 1)
+		return 0;
+
+	if (entries > dev->dev->caps.max_cqes + 1)
+		return -EINVAL;
+
 	if (ib_copy_from_udata(&ucmd, udata, sizeof ucmd))
 		return -EFAULT;
 
@@ -310,15 +324,14 @@ static int mlx4_alloc_resize_umem(struct mlx4_ib_dev *dev, struct mlx4_ib_cq *cq
 	if (!cq->resize_buf)
 		return -ENOMEM;
 
-	cq->resize_umem = ib_umem_get(&dev->ib_dev, ucmd.buf_addr,
-				      entries * cqe_size,
-				      IB_ACCESS_LOCAL_WRITE);
-	if (IS_ERR(cq->resize_umem)) {
-		err = PTR_ERR(cq->resize_umem);
+	umem = ib_umem_get(&dev->ib_dev, ucmd.buf_addr,
+			   entries * cqe_size, IB_ACCESS_LOCAL_WRITE);
+	if (IS_ERR(umem)) {
+		err = PTR_ERR(umem);
 		goto err_buf;
 	}
 
-	shift = mlx4_ib_umem_calc_optimal_mtt_size(cq->resize_umem, 0, &n);
+	shift = mlx4_ib_umem_calc_optimal_mtt_size(umem, 0, &n);
 	if (shift < 0) {
 		err = shift;
 		goto err_umem;
@@ -328,73 +341,35 @@ static int mlx4_alloc_resize_umem(struct mlx4_ib_dev *dev, struct mlx4_ib_cq *cq
 	if (err)
 		goto err_umem;
 
-	err = mlx4_ib_umem_write_mtt(dev, &cq->resize_buf->buf.mtt,
-				     cq->resize_umem);
+	err = mlx4_ib_umem_write_mtt(dev, &cq->resize_buf->buf.mtt, umem);
 	if (err)
 		goto err_mtt;
 
 	cq->resize_buf->cqe = entries - 1;
 
-	return 0;
-
-err_mtt:
-	mlx4_mtt_cleanup(dev->dev, &cq->resize_buf->buf.mtt);
-
-err_umem:
-	ib_umem_release(cq->resize_umem);
-	cq->resize_umem = NULL;
-err_buf:
-	kfree(cq->resize_buf);
-	cq->resize_buf = NULL;
-	return err;
-}
-
-int mlx4_ib_resize_cq(struct ib_cq *ibcq, unsigned int entries,
-		      struct ib_udata *udata)
-{
-	struct mlx4_ib_dev *dev = to_mdev(ibcq->device);
-	struct mlx4_ib_cq *cq = to_mcq(ibcq);
-	struct mlx4_mtt mtt;
-	int err;
-
-	if (entries > dev->dev->caps.max_cqes)
-		return -EINVAL;
-
-	entries = roundup_pow_of_two(entries + 1);
-	if (entries == ibcq->cqe + 1)
-		return 0;
-
-	if (entries > dev->dev->caps.max_cqes + 1)
-		return -EINVAL;
-
-	err = mlx4_alloc_resize_umem(dev, cq, entries, udata);
-	if (err)
-		return err;
 	mtt = cq->buf.mtt;
 
 	err = mlx4_cq_resize(dev->dev, &cq->mcq, entries, &cq->resize_buf->buf.mtt);
 	if (err)
-		goto err_buf;
+		goto err_mtt;
 
 	mlx4_mtt_cleanup(dev->dev, &mtt);
 	cq->buf = cq->resize_buf->buf;
 	cq->ibcq.cqe = cq->resize_buf->cqe;
 	ib_umem_release(cq->ibcq.umem);
-	cq->ibcq.umem = cq->resize_umem;
+	cq->ibcq.umem = umem;
 
 	kfree(cq->resize_buf);
 	cq->resize_buf = NULL;
-	cq->resize_umem = NULL;
 	return 0;
 
+err_mtt:
+	mlx4_mtt_cleanup(dev->dev, &cq->resize_buf->buf.mtt);
 
+err_umem:
+	ib_umem_release(umem);
 err_buf:
-	mlx4_mtt_cleanup(dev->dev, &cq->resize_buf->buf.mtt);
 	kfree(cq->resize_buf);
-	cq->resize_buf = NULL;
-
-	ib_umem_release(cq->resize_umem);
-	cq->resize_umem = NULL;
 	return err;
 }
 
diff --git a/drivers/infiniband/hw/mlx4/mlx4_ib.h b/drivers/infiniband/hw/mlx4/mlx4_ib.h
index 2f1043690554..4163a6cb32d0 100644
--- a/drivers/infiniband/hw/mlx4/mlx4_ib.h
+++ b/drivers/infiniband/hw/mlx4/mlx4_ib.h
@@ -120,7 +120,6 @@ struct mlx4_ib_cq {
 	struct mlx4_ib_cq_resize *resize_buf;
 	struct mlx4_db		db;
 	spinlock_t		lock;
-	struct ib_umem	       *resize_umem;
 	/* List of qps that it serves.*/
 	struct list_head		send_qp_list;
 	struct list_head		recv_qp_list;

-- 
2.52.0


