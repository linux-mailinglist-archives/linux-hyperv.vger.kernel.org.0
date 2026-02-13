Return-Path: <linux-hyperv+bounces-8827-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2CB8IfAFj2l5HQEAu9opvQ
	(envelope-from <linux-hyperv+bounces-8827-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Feb 2026 12:07:28 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F3457135760
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Feb 2026 12:07:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D5A36315A0F7
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Feb 2026 11:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5389235EDA9;
	Fri, 13 Feb 2026 11:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cDYe/qQb"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD1635E558;
	Fri, 13 Feb 2026 11:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770980445; cv=none; b=thqpN1kT8+DFlHUQ1h+Op9MxFWoQ1g03+vzXbkraKnwOGZsXmYcWobnyBo/wYTLSKZKgBm3dTEZrfFZlJtjY6nWPXPtjbtn7Ncc/WPVyR+/ONmLRiTK7vKbwcaYdc3RrR0iUL2IZBZwO3aIsse3SJe+uNc9RhMyVwjHkmhSCDLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770980445; c=relaxed/simple;
	bh=2nVLE73sT2uaUudlFaxYimETRxX/g6qBtDOZjvSQO0I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N0djZfXcNcHbHwr+0KOzQbyJuOIGWPvWAUReVIcUtB7vAGa5oAfvd90wlNV6O9UoarazuLOSQfCwxh1nDKigk20lJopPj7YBhVD6Wn1MTo/Kszi+h1xfuf31vDCU8ZAlYR5IHatci0mZ3qWB2jb+BEoxbEOOSCaOUmVgkLJFnmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cDYe/qQb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D06EC116C6;
	Fri, 13 Feb 2026 11:00:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770980445;
	bh=2nVLE73sT2uaUudlFaxYimETRxX/g6qBtDOZjvSQO0I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cDYe/qQbdAS++XO3ZDdALH5QDW1EbZV+dBVWefvD5H7nNwAPz8tcSUOyl/i1VaQ6w
	 xiDySHBCW7fLfIy4Rx09MdsCZR/mb7kaC+bZ7NxHGcR5+bWDHgX+g+gu71zDHMfTrJ
	 /SCNJyoA5Z6Bw+qS+tgz50JQiD9teIlqslUq8gA4CSe1aSnQ/8ITIDBleT8RjA2z/k
	 SUiTFXuxXMnzTpZ0Mi0UzvC3jJ5LgJHSbxjhjSmjN8Hk+JGpKDo925odrLy6mbIXju
	 C39xhF4URUo95wlwgdgHdLUeuDu4VrlUe0kyW2v21THFUUiKhvwxzpXiMtmPo8ZjaF
	 sP4bzB1EyaSdA==
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
Subject: [PATCH rdma-next 30/50] RDMA/core: Remove legacy CQ creation fallback path
Date: Fri, 13 Feb 2026 12:58:06 +0200
Message-ID: <20260213-refactor-umem-v1-30-f3be85847922@nvidia.com>
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
	TAGGED_FROM(0.00)[bounces-8827-lists,linux-hyperv=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F3457135760
X-Rspamd-Action: no action

From: Leon Romanovsky <leonro@nvidia.com>

All drivers now support the modern CQ creation interface via the
create_user_cq callback. Remove the legacy fallback to create_cq
for userspace CQ creation.

This simplifies the core code by eliminating conditional logic and
ensures all userspace CQ creation goes through the modern interface
that properly supports user-supplied umem.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/uverbs_cmd.c          | 9 +++------
 drivers/infiniband/core/uverbs_std_types_cq.c | 8 ++------
 2 files changed, 5 insertions(+), 12 deletions(-)

diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
index 041bed7a43b4..cdfee86fb800 100644
--- a/drivers/infiniband/core/uverbs_cmd.c
+++ b/drivers/infiniband/core/uverbs_cmd.c
@@ -1071,10 +1071,7 @@ static int create_cq(struct uverbs_attr_bundle *attrs,
 	rdma_restrack_new(&cq->res, RDMA_RESTRACK_CQ);
 	rdma_restrack_set_name(&cq->res, NULL);
 
-	if (ib_dev->ops.create_user_cq)
-		ret = ib_dev->ops.create_user_cq(cq, &attr, attrs);
-	else
-		ret = ib_dev->ops.create_cq(cq, &attr, attrs);
+	ret = ib_dev->ops.create_user_cq(cq, &attr, attrs);
 	if (ret)
 		goto err_free;
 	rdma_restrack_add(&cq->res);
@@ -3791,7 +3788,7 @@ const struct uapi_definition uverbs_def_write_intf[] = {
 				     UAPI_DEF_WRITE_UDATA_IO(
 					     struct ib_uverbs_create_cq,
 					     struct ib_uverbs_create_cq_resp),
-				     UAPI_DEF_METHOD_NEEDS_FN(create_cq)),
+				     UAPI_DEF_METHOD_NEEDS_FN(create_user_cq)),
 		DECLARE_UVERBS_WRITE(
 			IB_USER_VERBS_CMD_DESTROY_CQ,
 			ib_uverbs_destroy_cq,
@@ -3822,7 +3819,7 @@ const struct uapi_definition uverbs_def_write_intf[] = {
 					     reserved,
 					     struct ib_uverbs_ex_create_cq_resp,
 					     response_length),
-			UAPI_DEF_METHOD_NEEDS_FN(create_cq)),
+			UAPI_DEF_METHOD_NEEDS_FN(create_user_cq)),
 		DECLARE_UVERBS_WRITE_EX(
 			IB_USER_VERBS_EX_CMD_MODIFY_CQ,
 			ib_uverbs_ex_modify_cq,
diff --git a/drivers/infiniband/core/uverbs_std_types_cq.c b/drivers/infiniband/core/uverbs_std_types_cq.c
index d2c8f71f934c..a12e3184dd5c 100644
--- a/drivers/infiniband/core/uverbs_std_types_cq.c
+++ b/drivers/infiniband/core/uverbs_std_types_cq.c
@@ -78,8 +78,7 @@ static int UVERBS_HANDLER(UVERBS_METHOD_CQ_CREATE)(
 	int buffer_fd;
 	int ret;
 
-	if ((!ib_dev->ops.create_cq && !ib_dev->ops.create_user_cq) ||
-	    !ib_dev->ops.destroy_cq)
+	if (!ib_dev->ops.create_user_cq || !ib_dev->ops.destroy_cq)
 		return -EOPNOTSUPP;
 
 	ret = uverbs_copy_from(&attr.comp_vector, attrs,
@@ -200,10 +199,7 @@ static int UVERBS_HANDLER(UVERBS_METHOD_CQ_CREATE)(
 	rdma_restrack_new(&cq->res, RDMA_RESTRACK_CQ);
 	rdma_restrack_set_name(&cq->res, NULL);
 
-	if (ib_dev->ops.create_user_cq)
-		ret = ib_dev->ops.create_user_cq(cq, &attr, attrs);
-	else
-		ret = ib_dev->ops.create_cq(cq, &attr, attrs);
+	ret = ib_dev->ops.create_user_cq(cq, &attr, attrs);
 	if (ret)
 		goto err_free;
 

-- 
2.52.0


