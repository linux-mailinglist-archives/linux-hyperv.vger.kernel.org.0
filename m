Return-Path: <linux-hyperv+bounces-8834-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SB7JBzoHj2ltHQEAu9opvQ
	(envelope-from <linux-hyperv+bounces-8834-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Feb 2026 12:12:58 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BBAA135916
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Feb 2026 12:12:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1479D311315E
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Feb 2026 11:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFA3A3612DE;
	Fri, 13 Feb 2026 11:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b3PiFvH4"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC413563EE;
	Fri, 13 Feb 2026 11:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770980471; cv=none; b=trbyO/4fP4ezVHI6KhWh7zc15Drew7LwE5L7+btInB/UhDWsLE8hoQn3vx+AdwAz1UqTpyOS4yF1+S0x69Gj4qdCZl2KY3KhXNloOovuri15VBRdqrpCfpWjIFscg+4wZ+EC1a5Tm5TeguBDmYkQnaUNViKo2NlXnllsv8H5Su0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770980471; c=relaxed/simple;
	bh=k0n1uflccrs3HflvsAbkbwYqRMc/45QTYy53WMc4NF8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hdlaDmUc4tnWQ9SbnfVRY2ieFcwK+wf+oEa+XsdDKFDaqZZYHwIhTcADyESqhRTmY1jp3aSQH8lglfq5+VCA8tBjTn2veDTOrtte9HgwQfrXfoi8uWuWkAzJspbze5KkvC1VU/9m1JsluMPVMXey0Xg/wZGJG6V9C9SLN4sahkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b3PiFvH4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C21C0C116C6;
	Fri, 13 Feb 2026 11:01:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770980471;
	bh=k0n1uflccrs3HflvsAbkbwYqRMc/45QTYy53WMc4NF8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=b3PiFvH464fFpDVnF/dzdyH5OfdqjzADJGlsSgqY2KuWy/EwzZ38H3K8UH+Ub7YyE
	 fuThn87+zUgESmWBFieEWLAzYg2uMYV1hgGQDbSj09/dXqwlzq2TLKg/u95Cb1TL80
	 eCrSbO9h2OH60fIK6FDPDNx8Ds1E2ZEWBwOlC6jfn3G39kBADTCQ+sZrFEwD92ikk9
	 9HFLR/EFPMB3KthM3g3jhho5SyQ/6DGbvSZae9VvVOl2RcBrFhh3RloFa2jljRYbxZ
	 V2P14r+tlCN7+dOev8wXy7mImFT/ehPwu+nCzH7MsQwH1nrYYdOJA2OuFZgBwj+IuK
	 /0OxR3Rk/SasA==
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
Subject: [PATCH rdma-next 37/50] RDMA/mthca: Remove resize support for kernel CQs
Date: Fri, 13 Feb 2026 12:58:13 +0200
Message-ID: <20260213-refactor-umem-v1-37-f3be85847922@nvidia.com>
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
	TAGGED_FROM(0.00)[bounces-8834-lists,linux-hyperv=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8BBAA135916
X-Rspamd-Action: no action

From: Leon Romanovsky <leonro@nvidia.com>

The CQ resize operation is a uverbs-only interface and is not required for
kernel-created CQs. Drop this unused functionality.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mthca/mthca_provider.c | 102 ++-------------------------
 1 file changed, 6 insertions(+), 96 deletions(-)

diff --git a/drivers/infiniband/hw/mthca/mthca_provider.c b/drivers/infiniband/hw/mthca/mthca_provider.c
index 8920deceea73..fd306a229318 100644
--- a/drivers/infiniband/hw/mthca/mthca_provider.c
+++ b/drivers/infiniband/hw/mthca/mthca_provider.c
@@ -626,8 +626,6 @@ static int mthca_create_user_cq(struct ib_cq *ibcq,
 		goto err_unmap_arm;
 	}
 
-	cq->resize_buf = NULL;
-
 	return 0;
 
 err_unmap_arm:
@@ -667,53 +665,6 @@ static int mthca_create_cq(struct ib_cq *ibcq,
 	if (err)
 		return err;
 
-	cq->resize_buf = NULL;
-
-	return 0;
-}
-
-static int mthca_alloc_resize_buf(struct mthca_dev *dev, struct mthca_cq *cq,
-				  int entries)
-{
-	int ret;
-
-	spin_lock_irq(&cq->lock);
-	if (cq->resize_buf) {
-		ret = -EBUSY;
-		goto unlock;
-	}
-
-	cq->resize_buf = kmalloc(sizeof *cq->resize_buf, GFP_ATOMIC);
-	if (!cq->resize_buf) {
-		ret = -ENOMEM;
-		goto unlock;
-	}
-
-	cq->resize_buf->state = CQ_RESIZE_ALLOC;
-
-	ret = 0;
-
-unlock:
-	spin_unlock_irq(&cq->lock);
-
-	if (ret)
-		return ret;
-
-	ret = mthca_alloc_cq_buf(dev, &cq->resize_buf->buf, entries);
-	if (ret) {
-		spin_lock_irq(&cq->lock);
-		kfree(cq->resize_buf);
-		cq->resize_buf = NULL;
-		spin_unlock_irq(&cq->lock);
-		return ret;
-	}
-
-	cq->resize_buf->cqe = entries - 1;
-
-	spin_lock_irq(&cq->lock);
-	cq->resize_buf->state = CQ_RESIZE_READY;
-	spin_unlock_irq(&cq->lock);
-
 	return 0;
 }
 
@@ -736,60 +687,19 @@ static int mthca_resize_cq(struct ib_cq *ibcq, int entries, struct ib_udata *uda
 		goto out;
 	}
 
-	if (cq->is_kernel) {
-		ret = mthca_alloc_resize_buf(dev, cq, entries);
-		if (ret)
-			goto out;
-		lkey = cq->resize_buf->buf.mr.ibmr.lkey;
-	} else {
-		if (ib_copy_from_udata(&ucmd, udata, sizeof ucmd)) {
-			ret = -EFAULT;
-			goto out;
-		}
-		lkey = ucmd.lkey;
+	if (ib_copy_from_udata(&ucmd, udata, sizeof ucmd)) {
+		ret = -EFAULT;
+		goto out;
 	}
+	lkey = ucmd.lkey;
 
 	ret = mthca_RESIZE_CQ(dev, cq->cqn, lkey, ilog2(entries));
-
-	if (ret) {
-		if (cq->resize_buf) {
-			mthca_free_cq_buf(dev, &cq->resize_buf->buf,
-					  cq->resize_buf->cqe);
-			kfree(cq->resize_buf);
-			spin_lock_irq(&cq->lock);
-			cq->resize_buf = NULL;
-			spin_unlock_irq(&cq->lock);
-		}
+	if (ret)
 		goto out;
-	}
-
-	if (cq->is_kernel) {
-		struct mthca_cq_buf tbuf;
-		int tcqe;
-
-		spin_lock_irq(&cq->lock);
-		if (cq->resize_buf->state == CQ_RESIZE_READY) {
-			mthca_cq_resize_copy_cqes(cq);
-			tbuf         = cq->buf;
-			tcqe         = cq->ibcq.cqe;
-			cq->buf      = cq->resize_buf->buf;
-			cq->ibcq.cqe = cq->resize_buf->cqe;
-		} else {
-			tbuf = cq->resize_buf->buf;
-			tcqe = cq->resize_buf->cqe;
-		}
-
-		kfree(cq->resize_buf);
-		cq->resize_buf = NULL;
-		spin_unlock_irq(&cq->lock);
-
-		mthca_free_cq_buf(dev, &tbuf, tcqe);
-	} else
-		ibcq->cqe = entries - 1;
 
+	ibcq->cqe = entries - 1;
 out:
 	mutex_unlock(&cq->mutex);
-
 	return ret;
 }
 

-- 
2.52.0


