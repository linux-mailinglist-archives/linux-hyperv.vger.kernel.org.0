Return-Path: <linux-hyperv+bounces-8821-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iCrhB7UFj2ltHQEAu9opvQ
	(envelope-from <linux-hyperv+bounces-8821-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Feb 2026 12:06:29 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C7F3135701
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Feb 2026 12:06:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7A2EE3082E04
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Feb 2026 11:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4536B35A953;
	Fri, 13 Feb 2026 11:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qTTeoEGS"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB8235B130;
	Fri, 13 Feb 2026 11:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770980423; cv=none; b=nPkLXJx1S5Ida3z4NcbcMf5hKHmrqQDDtwcrha/HbHF5O2jNIpyKGnnwUnKCsCXRXrPLnFRdBKPFkl5TdYpMHeZH9XCwMr9aQTAxg6WbWMH4fjMRut6Ye9S4fam3DrkQ75z1pgXV3dGbDdKq9QSnoyvcDsF+1+zt8JXcOIUvAcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770980423; c=relaxed/simple;
	bh=U6oZSJ7BtAPy0JlnmcsfG4w7q3okdxecgWtK+w3OOF0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JEPnWA+Fn+djB6eSrtHP0k/o0Ya2M2G5EYhld4bWi0r7CRwVO6kcmEks3bnLNIN+Z3H9s0Or5htP0C+C5NIhKxh+my/kX0svTX0doWzid0tsPxl3TMJm9NbSblPl/PS+76rbjin2Foa9MH7nn0C+Z1RGOTDLFIOF31uD7SrMV3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qTTeoEGS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23A6CC116C6;
	Fri, 13 Feb 2026 11:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770980423;
	bh=U6oZSJ7BtAPy0JlnmcsfG4w7q3okdxecgWtK+w3OOF0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qTTeoEGS2x15qGfAvIv2C/IL7k78V16eh/LYVSjQIVYQLkgGhePLwe8PBLJjXAmtr
	 klM0DFvNAdirR5fhOY9Uf41RjSY80x5MtqDKqsWx0RugnmUKbS/A9rWYBjFGJnmT/X
	 W61wIgqtsZZaODjUjxY0rMntaz2+0MPJTByvjFdjNTo8A+88ZtIzoifNDFS+pctDuO
	 mRzeBv3rX8w4c0x87CPshiGEc4NFlJOgLCcZulqAY6K/69u9vk3A+nDeMR/PbrruCP
	 Q5HW86GQKaPyv1oPBg99ItJac4wgAEN/bdD8+nmr3BQviRedqwAEFew526ngKI8nqx
	 Xj2kvXHWIQ0ww==
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
Subject: [PATCH rdma-next 24/50] RDMA/usnic: Provide a modern CQ creation interface
Date: Fri, 13 Feb 2026 12:58:00 +0200
Message-ID: <20260213-refactor-umem-v1-24-f3be85847922@nvidia.com>
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
	TAGGED_FROM(0.00)[bounces-8821-lists,linux-hyperv=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8C7F3135701
X-Rspamd-Action: no action

From: Leon Romanovsky <leonro@nvidia.com>

usnic doesn't support kernel verbs and should have only
.create_user_cq() callback.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/usnic/usnic_ib_main.c  | 2 +-
 drivers/infiniband/hw/usnic/usnic_ib_verbs.c | 6 +++---
 drivers/infiniband/hw/usnic/usnic_ib_verbs.h | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/hw/usnic/usnic_ib_main.c b/drivers/infiniband/hw/usnic/usnic_ib_main.c
index 11eca39b73a9..8a3b641d6059 100644
--- a/drivers/infiniband/hw/usnic/usnic_ib_main.c
+++ b/drivers/infiniband/hw/usnic/usnic_ib_main.c
@@ -356,7 +356,7 @@ static const struct ib_device_ops usnic_dev_ops = {
 
 	.alloc_pd = usnic_ib_alloc_pd,
 	.alloc_ucontext = usnic_ib_alloc_ucontext,
-	.create_cq = usnic_ib_create_cq,
+	.create_user_cq = usnic_ib_create_user_cq,
 	.create_qp = usnic_ib_create_qp,
 	.dealloc_pd = usnic_ib_dealloc_pd,
 	.dealloc_ucontext = usnic_ib_dealloc_ucontext,
diff --git a/drivers/infiniband/hw/usnic/usnic_ib_verbs.c b/drivers/infiniband/hw/usnic/usnic_ib_verbs.c
index ae5df96589d9..2b41ded14a65 100644
--- a/drivers/infiniband/hw/usnic/usnic_ib_verbs.c
+++ b/drivers/infiniband/hw/usnic/usnic_ib_verbs.c
@@ -576,10 +576,10 @@ int usnic_ib_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr,
 	return status;
 }
 
-int usnic_ib_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
-		       struct uverbs_attr_bundle *attrs)
+int usnic_ib_create_user_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
+			    struct uverbs_attr_bundle *attrs)
 {
-	if (attr->flags)
+	if (attr->flags || ibcq->umem)
 		return -EOPNOTSUPP;
 
 	return 0;
diff --git a/drivers/infiniband/hw/usnic/usnic_ib_verbs.h b/drivers/infiniband/hw/usnic/usnic_ib_verbs.h
index e3031ac32488..15882110a5d5 100644
--- a/drivers/infiniband/hw/usnic/usnic_ib_verbs.h
+++ b/drivers/infiniband/hw/usnic/usnic_ib_verbs.h
@@ -55,8 +55,8 @@ int usnic_ib_create_qp(struct ib_qp *qp, struct ib_qp_init_attr *init_attr,
 int usnic_ib_destroy_qp(struct ib_qp *qp, struct ib_udata *udata);
 int usnic_ib_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr,
 				int attr_mask, struct ib_udata *udata);
-int usnic_ib_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
-		       struct uverbs_attr_bundle *attrs);
+int usnic_ib_create_user_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
+			    struct uverbs_attr_bundle *attrs);
 int usnic_ib_destroy_cq(struct ib_cq *cq, struct ib_udata *udata);
 struct ib_mr *usnic_ib_reg_mr(struct ib_pd *pd, u64 start, u64 length,
 				u64 virt_addr, int access_flags,

-- 
2.52.0


