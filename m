Return-Path: <linux-hyperv+bounces-8828-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gBUxNPUFj2ltHQEAu9opvQ
	(envelope-from <linux-hyperv+bounces-8828-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Feb 2026 12:07:33 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EB42135767
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Feb 2026 12:07:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AB49B321682F
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Feb 2026 11:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0488135EDD1;
	Fri, 13 Feb 2026 11:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BdW0sEya"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D45EF357A48;
	Fri, 13 Feb 2026 11:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770980448; cv=none; b=VTFfYIyxCBx1i4gMyThZ7hms7emqwWbzD7IDk2q/tflzK9F0hpoPDFOLKbDgq2QZrpfpNneWC1wSBwTkpzv1haA4pC6oPy0wuf4vSBxLbtOlPt080NdUGk8NacZ4FPzygg/UYSX6cDnlw62hMqo07aQe7ACSOClKXEyy7rBFzUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770980448; c=relaxed/simple;
	bh=Sp8gis0/mbQbLEUwfhSepvWCD6rochTkCa5B+TgVyAg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H+sJ9U22pS3eTT3WWZkqq+9npp4SI+Iwry6nLLhZhSbF5Ey7xZ1bQIKp80AGYL7NUhMVN4G3bJ4Fp46uF9QQBa9bbEBHJvScylIoamq+AbIqf3wWhr1j5xMgKJ+UAhSOPNwCAsOxtnJq3u2934Vui6URvsV3cgE4G9yCXrtw040=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BdW0sEya; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CD9BC116C6;
	Fri, 13 Feb 2026 11:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770980448;
	bh=Sp8gis0/mbQbLEUwfhSepvWCD6rochTkCa5B+TgVyAg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BdW0sEyaIVu2bI013scid28x1csrnTeT2oq31WiCGYjKbHIKl/paLEHKm9SZH1mBb
	 LqSCC748iINh81+g9yLhfNJ5sYaXdQFqftda6D7lQIZpCFnS7/BpFu1TZLGhPLHNgt
	 fVgLNwByc7ZwGOhG2gYCRqUrTBBhEWsteDiN+8CfC+BlrL7wJBICIOodsY9fLkxoAF
	 CLVgyRRTr0EiP+3tazgI3fP7j5OExxkf5ooqRnjwS+IiO1LeYIBfUJ0scs7ib+A7hd
	 4HQ9HDwqMZtpGyZSl93RgtVeDPKcD9+1BY/1kSXhKXiVCGUPBdLuhleH+nX9X0URSa
	 i1Rk3dfrGxViQ==
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
Subject: [PATCH rdma-next 31/50] RDMA/core: Remove unused ib_resize_cq() implementation
Date: Fri, 13 Feb 2026 12:58:07 +0200
Message-ID: <20260213-refactor-umem-v1-31-f3be85847922@nvidia.com>
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
	TAGGED_FROM(0.00)[bounces-8828-lists,linux-hyperv=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7EB42135767
X-Rspamd-Action: no action

From: Leon Romanovsky <leonro@nvidia.com>

There are no in-kernel users of the CQ resize functionality, so drop it.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/verbs.c | 10 ----------
 include/rdma/ib_verbs.h         |  9 ---------
 2 files changed, 19 deletions(-)

diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
index 9d075eeda463..5f59487fc9d4 100644
--- a/drivers/infiniband/core/verbs.c
+++ b/drivers/infiniband/core/verbs.c
@@ -2264,16 +2264,6 @@ int ib_destroy_cq_user(struct ib_cq *cq, struct ib_udata *udata)
 }
 EXPORT_SYMBOL(ib_destroy_cq_user);
 
-int ib_resize_cq(struct ib_cq *cq, int cqe)
-{
-	if (cq->shared)
-		return -EOPNOTSUPP;
-
-	return cq->device->ops.resize_cq ?
-		cq->device->ops.resize_cq(cq, cqe, NULL) : -EOPNOTSUPP;
-}
-EXPORT_SYMBOL(ib_resize_cq);
-
 /* Memory regions */
 
 struct ib_mr *ib_reg_user_mr(struct ib_pd *pd, u64 start, u64 length,
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 67aa5fc2c0b7..b8adc2f17e73 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -4001,15 +4001,6 @@ struct ib_cq *__ib_create_cq(struct ib_device *device,
 #define ib_create_cq(device, cmp_hndlr, evt_hndlr, cq_ctxt, cq_attr) \
 	__ib_create_cq((device), (cmp_hndlr), (evt_hndlr), (cq_ctxt), (cq_attr), KBUILD_MODNAME)
 
-/**
- * ib_resize_cq - Modifies the capacity of the CQ.
- * @cq: The CQ to resize.
- * @cqe: The minimum size of the CQ.
- *
- * Users can examine the cq structure to determine the actual CQ size.
- */
-int ib_resize_cq(struct ib_cq *cq, int cqe);
-
 /**
  * rdma_set_cq_moderation - Modifies moderation params of the CQ
  * @cq: The CQ to modify.

-- 
2.52.0


