Return-Path: <linux-hyperv+bounces-8812-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WK5tCcgEj2lJHQEAu9opvQ
	(envelope-from <linux-hyperv+bounces-8812-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Feb 2026 12:02:32 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D55F1355C5
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Feb 2026 12:02:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2AB7C3101D84
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Feb 2026 10:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 790AD3563E7;
	Fri, 13 Feb 2026 10:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U0YOypzT"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5466B355020;
	Fri, 13 Feb 2026 10:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770980388; cv=none; b=PLcREXbqFWyF4eJQPMaKsa1B+adJdkcSbRnEK4bR4VI/0lqUG9WE3TJ42YKWP21vfHLAGyAXzHAzn0NgAIp1FGfttr/+cECWC/42Nzj/UQ+zWKNl4l+nkCryxXjlc+6LfQuD6mFlim4kNda1o8JaDuieoyL63kA2OQs8WfUP4ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770980388; c=relaxed/simple;
	bh=AQVvvIH7DY2oowq/cNaZ9Og/FMsRdoik9sIHT+wgp/E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rQslAURO9GvFXt6DV33s+E3/ClKduCxhvndLWlPhlJP4O/TKNvqsbl74UWrnnM9ZqTNtuOHt/syC6J2XYgjlHSZxOajjFipmUCppaRZAMdyY81YRONEVEHkRQ3Zq4nyXBkX5UM0u1abh4UEklUNxrXRu7KkFsexkVSEBoVdEVjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U0YOypzT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89170C19423;
	Fri, 13 Feb 2026 10:59:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770980388;
	bh=AQVvvIH7DY2oowq/cNaZ9Og/FMsRdoik9sIHT+wgp/E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U0YOypzTbix1qroBXmhxEWScAbtSr0lr6JKloJKtIhXM6xRLLICPbVH/KcWtNHLjb
	 WjS+tNGbk0VsRt9slTUTgPxKF1d2fHPuoGHlQtYWFxfuVPKPHj/m8feGov+bsTb/Vi
	 k7SDNtlYtTk53yJYXEeSddO0mXTwf8ulaPFYCHpAsKdyn4YSHxC7AKbgVke7A4bOH/
	 niKrnzbWGlA9MWttPR7hR3nKHkMV59SmISR1BxjYKC0XHCSzNJ/feeIxx3X8CuZowQ
	 a8+oEC0DKFsLGlX+9nvZ9MAfZ6seiubLoXkl0AvdXAI3fuDF3QEoRfDdC7DJwW6xjO
	 FPYXlXKL3709g==
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
Subject: [PATCH rdma-next 12/50] RDMA/mlx4: Inline mlx4_ib_get_cq_umem into callers
Date: Fri, 13 Feb 2026 12:57:48 +0200
Message-ID: <20260213-refactor-umem-v1-12-f3be85847922@nvidia.com>
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
	TAGGED_FROM(0.00)[bounces-8812-lists,linux-hyperv=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8D55F1355C5
X-Rspamd-Action: no action

From: Leon Romanovsky <leonro@nvidia.com>

Inline the mlx4_ib_get_cq_umem helper function into its two call sites
(mlx4_ib_create_cq and mlx4_alloc_resize_umem) to prepare for the
transition to modern CQ creation interface.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx4/cq.c | 108 ++++++++++++++++++++++------------------
 1 file changed, 60 insertions(+), 48 deletions(-)

diff --git a/drivers/infiniband/hw/mlx4/cq.c b/drivers/infiniband/hw/mlx4/cq.c
index c592374f4a58..94e9ff45725a 100644
--- a/drivers/infiniband/hw/mlx4/cq.c
+++ b/drivers/infiniband/hw/mlx4/cq.c
@@ -135,45 +135,6 @@ static void mlx4_ib_free_cq_buf(struct mlx4_ib_dev *dev, struct mlx4_ib_cq_buf *
 	mlx4_buf_free(dev->dev, (cqe + 1) * buf->entry_size, &buf->buf);
 }
 
-static int mlx4_ib_get_cq_umem(struct mlx4_ib_dev *dev,
-			       struct mlx4_ib_cq_buf *buf,
-			       struct ib_umem **umem, u64 buf_addr, int cqe)
-{
-	int err;
-	int cqe_size = dev->dev->caps.cqe_size;
-	int shift;
-	int n;
-
-	*umem = ib_umem_get(&dev->ib_dev, buf_addr, cqe * cqe_size,
-			    IB_ACCESS_LOCAL_WRITE);
-	if (IS_ERR(*umem))
-		return PTR_ERR(*umem);
-
-	shift = mlx4_ib_umem_calc_optimal_mtt_size(*umem, 0, &n);
-	if (shift < 0) {
-		err = shift;
-		goto err_buf;
-	}
-
-	err = mlx4_mtt_init(dev->dev, n, shift, &buf->mtt);
-	if (err)
-		goto err_buf;
-
-	err = mlx4_ib_umem_write_mtt(dev, &buf->mtt, *umem);
-	if (err)
-		goto err_mtt;
-
-	return 0;
-
-err_mtt:
-	mlx4_mtt_cleanup(dev->dev, &buf->mtt);
-
-err_buf:
-	ib_umem_release(*umem);
-
-	return err;
-}
-
 #define CQ_CREATE_FLAGS_SUPPORTED IB_UVERBS_CQ_FLAGS_TIMESTAMP_COMPLETION
 int mlx4_ib_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 		      struct uverbs_attr_bundle *attrs)
@@ -208,6 +169,9 @@ int mlx4_ib_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 
 	if (udata) {
 		struct mlx4_ib_create_cq ucmd;
+		int cqe_size = dev->dev->caps.cqe_size;
+		int shift;
+		int n;
 
 		if (ib_copy_from_udata(&ucmd, udata, sizeof ucmd)) {
 			err = -EFAULT;
@@ -215,10 +179,28 @@ int mlx4_ib_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 		}
 
 		buf_addr = (void *)(unsigned long)ucmd.buf_addr;
-		err = mlx4_ib_get_cq_umem(dev, &cq->buf, &cq->umem,
-					  ucmd.buf_addr, entries);
-		if (err)
+
+		cq->umem = ib_umem_get(&dev->ib_dev, ucmd.buf_addr,
+				       entries * cqe_size,
+				       IB_ACCESS_LOCAL_WRITE);
+		if (IS_ERR(cq->umem)) {
+			err = PTR_ERR(cq->umem);
 			goto err_cq;
+		}
+
+		shift = mlx4_ib_umem_calc_optimal_mtt_size(cq->umem, 0, &n);
+		if (shift < 0) {
+			err = shift;
+			goto err_umem;
+		}
+
+		err = mlx4_mtt_init(dev->dev, n, shift, &cq->buf.mtt);
+		if (err)
+			goto err_umem;
+
+		err = mlx4_ib_umem_write_mtt(dev, &cq->buf.mtt, cq->umem);
+		if (err)
+			goto err_mtt;
 
 		err = mlx4_ib_db_map_user(udata, ucmd.db_addr, &cq->db);
 		if (err)
@@ -281,6 +263,7 @@ int mlx4_ib_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 err_mtt:
 	mlx4_mtt_cleanup(dev->dev, &cq->buf.mtt);
 
+err_umem:
 	ib_umem_release(cq->umem);
 	if (!udata)
 		mlx4_ib_free_cq_buf(dev, &cq->buf, cq->ibcq.cqe);
@@ -320,6 +303,9 @@ static int mlx4_alloc_resize_umem(struct mlx4_ib_dev *dev, struct mlx4_ib_cq *cq
 				   int entries, struct ib_udata *udata)
 {
 	struct mlx4_ib_resize_cq ucmd;
+	int cqe_size = dev->dev->caps.cqe_size;
+	int shift;
+	int n;
 	int err;
 
 	if (cq->resize_umem)
@@ -332,17 +318,43 @@ static int mlx4_alloc_resize_umem(struct mlx4_ib_dev *dev, struct mlx4_ib_cq *cq
 	if (!cq->resize_buf)
 		return -ENOMEM;
 
-	err = mlx4_ib_get_cq_umem(dev, &cq->resize_buf->buf, &cq->resize_umem,
-				  ucmd.buf_addr, entries);
-	if (err) {
-		kfree(cq->resize_buf);
-		cq->resize_buf = NULL;
-		return err;
+	cq->resize_umem = ib_umem_get(&dev->ib_dev, ucmd.buf_addr,
+				      entries * cqe_size,
+				      IB_ACCESS_LOCAL_WRITE);
+	if (IS_ERR(cq->resize_umem)) {
+		err = PTR_ERR(cq->resize_umem);
+		goto err_buf;
+	}
+
+	shift = mlx4_ib_umem_calc_optimal_mtt_size(cq->resize_umem, 0, &n);
+	if (shift < 0) {
+		err = shift;
+		goto err_umem;
 	}
 
+	err = mlx4_mtt_init(dev->dev, n, shift, &cq->resize_buf->buf.mtt);
+	if (err)
+		goto err_umem;
+
+	err = mlx4_ib_umem_write_mtt(dev, &cq->resize_buf->buf.mtt,
+				     cq->resize_umem);
+	if (err)
+		goto err_mtt;
+
 	cq->resize_buf->cqe = entries - 1;
 
 	return 0;
+
+err_mtt:
+	mlx4_mtt_cleanup(dev->dev, &cq->resize_buf->buf.mtt);
+
+err_umem:
+	ib_umem_release(cq->resize_umem);
+
+err_buf:
+	kfree(cq->resize_buf);
+	cq->resize_buf = NULL;
+	return err;
 }
 
 static int mlx4_ib_get_outstanding_cqes(struct mlx4_ib_cq *cq)

-- 
2.52.0


