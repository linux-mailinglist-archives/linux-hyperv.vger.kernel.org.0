Return-Path: <linux-hyperv+bounces-8833-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aPOcKiwGj2ltHQEAu9opvQ
	(envelope-from <linux-hyperv+bounces-8833-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Feb 2026 12:08:28 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 23EBD1357B7
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Feb 2026 12:08:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 765F3310CD4B
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Feb 2026 11:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0749D35B14B;
	Fri, 13 Feb 2026 11:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZABIR7H7"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E963563EE;
	Fri, 13 Feb 2026 11:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770980467; cv=none; b=ATf1oR2RP3PnmitovcNs5XcyOK02HquaxlYidVNselqEacFDTuaHoDZaxnISrUnf8RhRAbNQy7RGBLZmmuUVqbJW7v23w3yfWaLJ6u7DbeMAMGSjbdVS5LunkrmpEwNkQ3Ua9w84sDeIjJotbppap3AUves0ZG3u/n8mRouz59c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770980467; c=relaxed/simple;
	bh=lJd7pNWwbz/yljv7iIoOKoXZ5xZZRifiDg+GM9LSUKc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lT6kEsNHF7070iael3i3yvQp0L7jq3qdVcq/6IJdnDPkokuzICZO2OCHV7RkpNTqo5qsh4XRL83MaQAEm3LWYsmiUiSL3WXfuFCUK+WN60F/IpMtjNf7I412t6z9YxkM5yZmNO78Bg9nmvxmrautqBkqkDu5Y2Sgh1uVKeqf9ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZABIR7H7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D639DC116C6;
	Fri, 13 Feb 2026 11:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770980467;
	bh=lJd7pNWwbz/yljv7iIoOKoXZ5xZZRifiDg+GM9LSUKc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZABIR7H7gBh77uE7071tByAHH2fokXvkebI9I4yiCoJvKAAiGEohi0JcZWwCSMtFC
	 jpAAVgxgoVqKYTAzPTLjUw7pWtyeoUX/ZbWRoJh8eBW007RxAySrx+sX2fGOJw3X1y
	 /Uop7F9+RZ66lf/HEx7L70yv36Cn0BwFK93ZulgudG/Kjfaj5Ovbr4Ocd2Xa5RAbSw
	 3e7irxkZa7UhGoSxkf5PmoUAEFzg6kg22NgzvqoL2g4045in60Ykf3Nm24k0xd0B0N
	 IARiyOpxzpe7OUOYF05IDN7Z0JSAMcODfwnVlek78w/8TJFK1gqkaufnb/mEja5js1
	 OJJfi014geqNA==
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
Subject: =?utf-8?q?=5BPATCH_rdma-next_32/50=5D_RDMA=3A_Clarify_that_CQ_re?= =?utf-8?q?size_is_a_user=E2=80=91space_verb?=
Date: Fri, 13 Feb 2026 12:58:08 +0200
Message-ID: <20260213-refactor-umem-v1-32-f3be85847922@nvidia.com>
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
	TAGGED_FROM(0.00)[bounces-8833-lists,linux-hyperv=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 23EBD1357B7
X-Rspamd-Action: no action

From: Leon Romanovsky <leonro@nvidia.com>

The CQ resize operation is used only by uverbs. Make this explicit.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/device.c             | 2 +-
 drivers/infiniband/core/uverbs_cmd.c         | 4 ++--
 drivers/infiniband/hw/bnxt_re/main.c         | 2 +-
 drivers/infiniband/hw/irdma/verbs.c          | 2 +-
 drivers/infiniband/hw/mlx4/main.c            | 2 +-
 drivers/infiniband/hw/mlx5/main.c            | 2 +-
 drivers/infiniband/hw/mthca/mthca_provider.c | 2 +-
 drivers/infiniband/hw/ocrdma/ocrdma_main.c   | 2 +-
 drivers/infiniband/sw/rdmavt/vt.c            | 2 +-
 drivers/infiniband/sw/rxe/rxe_verbs.c        | 2 +-
 include/rdma/ib_verbs.h                      | 3 ++-
 11 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index 9209b8c664ef..9411f7805eed 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -2799,7 +2799,7 @@ void ib_set_device_ops(struct ib_device *dev, const struct ib_device_ops *ops)
 	SET_DEVICE_OP(dev_ops, reg_user_mr_dmabuf);
 	SET_DEVICE_OP(dev_ops, req_notify_cq);
 	SET_DEVICE_OP(dev_ops, rereg_user_mr);
-	SET_DEVICE_OP(dev_ops, resize_cq);
+	SET_DEVICE_OP(dev_ops, resize_user_cq);
 	SET_DEVICE_OP(dev_ops, set_vf_guid);
 	SET_DEVICE_OP(dev_ops, set_vf_link_state);
 	SET_DEVICE_OP(dev_ops, ufile_hw_cleanup);
diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
index cdfee86fb800..57697738fd25 100644
--- a/drivers/infiniband/core/uverbs_cmd.c
+++ b/drivers/infiniband/core/uverbs_cmd.c
@@ -1151,7 +1151,7 @@ static int ib_uverbs_resize_cq(struct uverbs_attr_bundle *attrs)
 	if (IS_ERR(cq))
 		return PTR_ERR(cq);
 
-	ret = cq->device->ops.resize_cq(cq, cmd.cqe, &attrs->driver_udata);
+	ret = cq->device->ops.resize_user_cq(cq, cmd.cqe, &attrs->driver_udata);
 	if (ret)
 		goto out;
 
@@ -3811,7 +3811,7 @@ const struct uapi_definition uverbs_def_write_intf[] = {
 				     UAPI_DEF_WRITE_UDATA_IO(
 					     struct ib_uverbs_resize_cq,
 					     struct ib_uverbs_resize_cq_resp),
-				     UAPI_DEF_METHOD_NEEDS_FN(resize_cq)),
+				     UAPI_DEF_METHOD_NEEDS_FN(resize_user_cq)),
 		DECLARE_UVERBS_WRITE_EX(
 			IB_USER_VERBS_EX_CMD_CREATE_CQ,
 			ib_uverbs_ex_create_cq,
diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index 368c1fd8172e..ccc01fc222ca 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -1373,7 +1373,7 @@ static const struct ib_device_ops bnxt_re_dev_ops = {
 	.reg_user_mr = bnxt_re_reg_user_mr,
 	.reg_user_mr_dmabuf = bnxt_re_reg_user_mr_dmabuf,
 	.req_notify_cq = bnxt_re_req_notify_cq,
-	.resize_cq = bnxt_re_resize_cq,
+	.resize_user_cq = bnxt_re_resize_cq,
 	.create_flow = bnxt_re_create_flow,
 	.destroy_flow = bnxt_re_destroy_flow,
 	INIT_RDMA_OBJ_SIZE(ib_ah, bnxt_re_ah, ib_ah),
diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
index f2b3cfe125af..f727d1922a84 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -5460,7 +5460,7 @@ static const struct ib_device_ops irdma_dev_ops = {
 	.reg_user_mr_dmabuf = irdma_reg_user_mr_dmabuf,
 	.rereg_user_mr = irdma_rereg_user_mr,
 	.req_notify_cq = irdma_req_notify_cq,
-	.resize_cq = irdma_resize_cq,
+	.resize_user_cq = irdma_resize_cq,
 	INIT_RDMA_OBJ_SIZE(ib_pd, irdma_pd, ibpd),
 	INIT_RDMA_OBJ_SIZE(ib_ucontext, irdma_ucontext, ibucontext),
 	INIT_RDMA_OBJ_SIZE(ib_ah, irdma_ah, ibah),
diff --git a/drivers/infiniband/hw/mlx4/main.c b/drivers/infiniband/hw/mlx4/main.c
index fc05e7a1a870..daf95f94ec6f 100644
--- a/drivers/infiniband/hw/mlx4/main.c
+++ b/drivers/infiniband/hw/mlx4/main.c
@@ -2570,7 +2570,7 @@ static const struct ib_device_ops mlx4_ib_dev_ops = {
 	.reg_user_mr = mlx4_ib_reg_user_mr,
 	.req_notify_cq = mlx4_ib_arm_cq,
 	.rereg_user_mr = mlx4_ib_rereg_user_mr,
-	.resize_cq = mlx4_ib_resize_cq,
+	.resize_user_cq = mlx4_ib_resize_cq,
 	.report_port_event = mlx4_ib_port_event,
 
 	INIT_RDMA_OBJ_SIZE(ib_ah, mlx4_ib_ah, ibah),
diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index 4f49f65e2c16..0471155eb739 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -4496,7 +4496,7 @@ static const struct ib_device_ops mlx5_ib_dev_ops = {
 	.reg_user_mr_dmabuf = mlx5_ib_reg_user_mr_dmabuf,
 	.req_notify_cq = mlx5_ib_arm_cq,
 	.rereg_user_mr = mlx5_ib_rereg_user_mr,
-	.resize_cq = mlx5_ib_resize_cq,
+	.resize_user_cq = mlx5_ib_resize_cq,
 	.ufile_hw_cleanup = mlx5_ib_ufile_hw_cleanup,
 
 	INIT_RDMA_OBJ_SIZE(ib_ah, mlx5_ib_ah, ibah),
diff --git a/drivers/infiniband/hw/mthca/mthca_provider.c b/drivers/infiniband/hw/mthca/mthca_provider.c
index 6bf825978846..8920deceea73 100644
--- a/drivers/infiniband/hw/mthca/mthca_provider.c
+++ b/drivers/infiniband/hw/mthca/mthca_provider.c
@@ -1119,7 +1119,7 @@ static const struct ib_device_ops mthca_dev_ops = {
 	.query_port = mthca_query_port,
 	.query_qp = mthca_query_qp,
 	.reg_user_mr = mthca_reg_user_mr,
-	.resize_cq = mthca_resize_cq,
+	.resize_user_cq = mthca_resize_cq,
 
 	INIT_RDMA_OBJ_SIZE(ib_ah, mthca_ah, ibah),
 	INIT_RDMA_OBJ_SIZE(ib_cq, mthca_cq, ibcq),
diff --git a/drivers/infiniband/hw/ocrdma/ocrdma_main.c b/drivers/infiniband/hw/ocrdma/ocrdma_main.c
index 0d89c5ec9a7a..7dafebc7f57e 100644
--- a/drivers/infiniband/hw/ocrdma/ocrdma_main.c
+++ b/drivers/infiniband/hw/ocrdma/ocrdma_main.c
@@ -167,7 +167,7 @@ static const struct ib_device_ops ocrdma_dev_ops = {
 	.query_qp = ocrdma_query_qp,
 	.reg_user_mr = ocrdma_reg_user_mr,
 	.req_notify_cq = ocrdma_arm_cq,
-	.resize_cq = ocrdma_resize_cq,
+	.resize_user_cq = ocrdma_resize_cq,
 
 	INIT_RDMA_OBJ_SIZE(ib_ah, ocrdma_ah, ibah),
 	INIT_RDMA_OBJ_SIZE(ib_cq, ocrdma_cq, ibcq),
diff --git a/drivers/infiniband/sw/rdmavt/vt.c b/drivers/infiniband/sw/rdmavt/vt.c
index 15964400b8d3..5aff65b3916b 100644
--- a/drivers/infiniband/sw/rdmavt/vt.c
+++ b/drivers/infiniband/sw/rdmavt/vt.c
@@ -368,7 +368,7 @@ static const struct ib_device_ops rvt_dev_ops = {
 	.query_srq = rvt_query_srq,
 	.reg_user_mr = rvt_reg_user_mr,
 	.req_notify_cq = rvt_req_notify_cq,
-	.resize_cq = rvt_resize_cq,
+	.resize_user_cq = rvt_resize_cq,
 
 	INIT_RDMA_OBJ_SIZE(ib_ah, rvt_ah, ibah),
 	INIT_RDMA_OBJ_SIZE(ib_cq, rvt_cq, ibcq),
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index 1e651bdd8622..72e3019ed1cb 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -1532,7 +1532,7 @@ static const struct ib_device_ops rxe_dev_ops = {
 	.reg_user_mr = rxe_reg_user_mr,
 	.req_notify_cq = rxe_req_notify_cq,
 	.rereg_user_mr = rxe_rereg_user_mr,
-	.resize_cq = rxe_resize_cq,
+	.resize_user_cq = rxe_resize_cq,
 
 	INIT_RDMA_OBJ_SIZE(ib_ah, rxe_ah, ibah),
 	INIT_RDMA_OBJ_SIZE(ib_cq, rxe_cq, ibcq),
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index b8adc2f17e73..94bb3cc4c67a 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -2534,7 +2534,8 @@ struct ib_device_ops {
 			      struct uverbs_attr_bundle *attrs);
 	int (*modify_cq)(struct ib_cq *cq, u16 cq_count, u16 cq_period);
 	int (*destroy_cq)(struct ib_cq *cq, struct ib_udata *udata);
-	int (*resize_cq)(struct ib_cq *cq, int cqe, struct ib_udata *udata);
+	int (*resize_user_cq)(struct ib_cq *cq, int cqe,
+			      struct ib_udata *udata);
 	/*
 	 * pre_destroy_cq - Prevent a cq from generating any new work
 	 * completions, but not free any kernel resources

-- 
2.52.0


