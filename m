Return-Path: <linux-hyperv+bounces-8840-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oOSzOnIHj2ltHQEAu9opvQ
	(envelope-from <linux-hyperv+bounces-8840-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Feb 2026 12:13:54 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 696B2135968
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Feb 2026 12:13:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3AC863150E8D
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Feb 2026 11:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D66AC3624B3;
	Fri, 13 Feb 2026 11:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EDUYAqSj"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1FBE35CB84;
	Fri, 13 Feb 2026 11:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770980494; cv=none; b=PDRdjKutbF0ldBvVF/P22G2VXg0d9/LlaTIgppq9DQg8Vp4lAf5waHJpqUQ+K+9CunBWZ+gpIIXUIyYv3Zg+UhjlxDpidaGe1GW+u+Oe7mkckT570RoPj0OPN6I6BMJTsUoOrwJNcKCNQf79CZDjjUzwVbuO2S/aVFJMbSyZaXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770980494; c=relaxed/simple;
	bh=Vcw4qS4HcCegwVEjRz1foBtu5FJSEtW6cquOv2B9Bec=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mc6nTux0+W2GoukMFi2BKbjf2FBZQVUrd5ThVywK7azTmDytxZftqdJexGJgGOC0VTLqoiU0ixZQMjAdTmR4Jtz7pDJfhJTc/eWt7MvtFnGZmJBWEbO1ey5z6c/Mzjytw9LGKCrevV/5FmsQnZr6ErBKs1Tb9HoAr/LAyk3rFC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EDUYAqSj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE510C116C6;
	Fri, 13 Feb 2026 11:01:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770980494;
	bh=Vcw4qS4HcCegwVEjRz1foBtu5FJSEtW6cquOv2B9Bec=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EDUYAqSjl4myEueiU9arG5uvvxJ9UJppcb1V4yeXECSPL6tuigtIew/E0xfm+qv7l
	 aHt4WBcw4JT1LApSVyg9pO2XcCgLtEEJd7You/7hFB2be7n6bkR4IP1/fK7tFI0vaC
	 Zg3ENT8jeckeVOQB/0cS3hUGQx8g7D16lHRKr5tX4kigWLc8MuHx8/MFDwAfGrZP1U
	 qazLntwiz0/fttKeiXhs3UZZ4PlzSy+LfC3pNRP0Bap20VeGV6R4kWdJFBeeddVik8
	 2G0A82glTpbHvAQIZXWkQQzVXptRsgll8Nhe2K8GmaseuS5LsEN0AvfwxLPjFIQuQR
	 SkTNaKP3CXUTg==
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
Subject: =?utf-8?q?=5BPATCH_rdma-next_43/50=5D_RDMA/bnxt=5Fre=3A_Rely_on_?= =?utf-8?q?common_resize=E2=80=91CQ_locking?=
Date: Fri, 13 Feb 2026 12:58:19 +0200
Message-ID: <20260213-refactor-umem-v1-43-f3be85847922@nvidia.com>
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
	TAGGED_FROM(0.00)[bounces-8840-lists,linux-hyperv=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 696B2135968
X-Rspamd-Action: no action

From: Leon Romanovsky <leonro@nvidia.com>

After introducing a shared mutex to protect against concurrent
resize‑CQ operations, update the bnxt_re driver to use this mechanism.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/bnxt_re/ib_verbs.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index 2aecfbbb7eaf..d544a4fb1e96 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -3326,12 +3326,6 @@ int bnxt_re_resize_cq(struct ib_cq *ibcq, unsigned int cqe,
 	rdev = cq->rdev;
 	dev_attr = rdev->dev_attr;
 
-	if (cq->resize_umem) {
-		ibdev_err(&rdev->ibdev, "Resize CQ %#x failed - Busy",
-			  cq->qplib_cq.id);
-		return -EBUSY;
-	}
-
 	/* Check the requested cq depth out of supported depth */
 	if (cqe > dev_attr->max_cq_wqes)
 		return -EINVAL;

-- 
2.52.0


