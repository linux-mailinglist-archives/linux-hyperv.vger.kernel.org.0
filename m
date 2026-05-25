Return-Path: <linux-hyperv+bounces-11191-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6KLUNn+cFGqpOwcAu9opvQ
	(envelope-from <linux-hyperv+bounces-11191-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 25 May 2026 21:01:19 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DD20B5CDDF2
	for <lists+linux-hyperv@lfdr.de>; Mon, 25 May 2026 21:01:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E1B5D300407E
	for <lists+linux-hyperv@lfdr.de>; Mon, 25 May 2026 19:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36E73316199;
	Mon, 25 May 2026 19:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="q/fN6tcq"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF6D81FDE31;
	Mon, 25 May 2026 19:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779735674; cv=none; b=kAoazKQALrpLPXWHZWoeMlH9cyWibBHHg2On5iAG8NqnJXywJEMIt8dWESJXjPseCwxhuyuTERYThX1Ttj5oFHYqdSjg8Rfv/+zewyhYyTkxi64+1EGOBBk1ewsY4ZTPebUDxeB9nkrxu1Y9e3xesn4N8gziiI707ndlZXs03M4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779735674; c=relaxed/simple;
	bh=CKyRKxtHLl0lHstjvPd68gVhZNBfc9IHMW1Nj3o87B4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rNRrOli3BgzUehzDIVGNbFnGXfbBF05CvxPwtLJPww7Ca1EXrBBJPoeMT8TK97vjSzNvXRXRl8KUXm6MSSd21hsfdodTiVWy6bB/kp1XvvLfyhvQVx1yg7fNf4ivAK8v3ePmWKTc2MB+1iyv4oCobW7MYBS8UE9rtoOPROH41rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=q/fN6tcq; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1173)
	id 5A1AF20B7166; Mon, 25 May 2026 12:01:03 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5A1AF20B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1779735663;
	bh=Un6NUoOXoAS8Gs2lq6egSVJZ5269tBQWMy722ZhF/YE=;
	h=From:To:Cc:Subject:Date:From;
	b=q/fN6tcqrHnRMG6Udu4k3q9BBtFPifmAXHpDbj0ygXG+N7U0nl1hajG90VcJLHkkt
	 oKK8SZlJBs7paRcvKeecqkDCM+oofEfDQkGaLohmqXTwPPffU04L8FZ6zejlCN1rdr
	 /lPfcfVtyLAIymF5ua3dTaG2UJQR74XABNvY6q5Q=
From: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
To: longli@microsoft.com,
	kotaranov@microsoft.com,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	linux-rdma@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
Subject: [PATCH rdma-next v3] RDMA/mana_ib: Clamp adapter capabilities at the ib_device_attr boundary
Date: Mon, 25 May 2026 12:01:01 -0700
Message-ID: <20260525190101.1264185-1-ernis@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11191-lists,linux-hyperv=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ernis@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: DD20B5CDDF2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

mana_ib stores its adapter capabilities internally as u32 in
struct mana_ib_adapter_caps. The IB core, however, exposes the
corresponding device attributes through struct ib_device_attr, where
fields such as max_qp, max_qp_wr, max_send_sge, max_recv_sge,
max_sge_rd, max_cq, max_cqe, max_mr, max_pd, max_qp_rd_atom,
max_res_rd_atom and max_qp_init_rd_atom are signed int.

mana_ib_query_device() is the only place that copies the cached u32
caps into these int fields. If a cap exceeds INT_MAX, the implicit
u32-to-int narrowing yields a negative value. Clamp each cap to
INT_MAX at this boundary so the values handed to the IB core are always
non-negative.

While here, fix a related overflow in the computation of
max_res_rd_atom. It is derived as max_qp_rd_atom * max_qp, both of
which are int after the assignment above; the multiplication can
overflow an int even with the new clamps in place. Widen to s64
before multiplying and clamp the result to INT_MAX.

Signed-off-by: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
---
Changes in v3:
* Drop clamping from mana_ib_gd_query_adapter_caps(). The internal u32
  caps cache does not need to be clamped.
* Move all clamping exclusively to mana_ib_query_device(), which is the
  only place the cached u32 values are narrowed into the signed int
  fields of struct ib_device_attr.
* Reframe commit message: this is a u32-to-int type boundary fix, not a
  CVM/untrusted-hardware hardening patch.
Changes in v2:
* Update patch title.
---
 drivers/infiniband/hw/mana/main.c | 33 ++++++++++++++++++++-----------
 1 file changed, 21 insertions(+), 12 deletions(-)

diff --git a/drivers/infiniband/hw/mana/main.c b/drivers/infiniband/hw/mana/main.c
index ac5e75dd3494..ca843083140f 100644
--- a/drivers/infiniband/hw/mana/main.c
+++ b/drivers/infiniband/hw/mana/main.c
@@ -555,19 +555,28 @@ int mana_ib_query_device(struct ib_device *ibdev, struct ib_device_attr *props,
 	props->vendor_part_id = dev->gdma_dev->dev_id.type;
 	props->max_mr_size = MANA_IB_MAX_MR_SIZE;
 	props->page_size_cap = dev->adapter_caps.page_size_cap;
-	props->max_qp = dev->adapter_caps.max_qp_count;
-	props->max_qp_wr = dev->adapter_caps.max_qp_wr;
+	/*
+	 * mana_ib stores adapter capabilities internally as u32, but the
+	 * corresponding ib_device_attr fields are signed int. Clamp each
+	 * value at this boundary so a cap larger than INT_MAX is never
+	 * narrowed into a negative value visible to the IB core or
+	 * userspace.
+	 */
+	props->max_qp = min_t(u32, dev->adapter_caps.max_qp_count, INT_MAX);
+	props->max_qp_wr = min_t(u32, dev->adapter_caps.max_qp_wr, INT_MAX);
 	props->device_cap_flags = IB_DEVICE_RC_RNR_NAK_GEN;
-	props->max_send_sge = dev->adapter_caps.max_send_sge_count;
-	props->max_recv_sge = dev->adapter_caps.max_recv_sge_count;
-	props->max_sge_rd = dev->adapter_caps.max_recv_sge_count;
-	props->max_cq = dev->adapter_caps.max_cq_count;
-	props->max_cqe = dev->adapter_caps.max_qp_wr;
-	props->max_mr = dev->adapter_caps.max_mr_count;
-	props->max_pd = dev->adapter_caps.max_pd_count;
-	props->max_qp_rd_atom = dev->adapter_caps.max_inbound_read_limit;
-	props->max_res_rd_atom = props->max_qp_rd_atom * props->max_qp;
-	props->max_qp_init_rd_atom = dev->adapter_caps.max_outbound_read_limit;
+	props->max_send_sge = min_t(u32, dev->adapter_caps.max_send_sge_count, INT_MAX);
+	props->max_recv_sge = min_t(u32, dev->adapter_caps.max_recv_sge_count, INT_MAX);
+	props->max_sge_rd = min_t(u32, dev->adapter_caps.max_recv_sge_count, INT_MAX);
+	props->max_cq = min_t(u32, dev->adapter_caps.max_cq_count, INT_MAX);
+	props->max_cqe = min_t(u32, dev->adapter_caps.max_qp_wr, INT_MAX);
+	props->max_mr = min_t(u32, dev->adapter_caps.max_mr_count, INT_MAX);
+	props->max_pd = min_t(u32, dev->adapter_caps.max_pd_count, INT_MAX);
+	props->max_qp_rd_atom = min_t(u32, dev->adapter_caps.max_inbound_read_limit, INT_MAX);
+	props->max_res_rd_atom = min_t(s64,
+				       (s64)props->max_qp_rd_atom * props->max_qp,
+				       INT_MAX);
+	props->max_qp_init_rd_atom = min_t(u32, dev->adapter_caps.max_outbound_read_limit, INT_MAX);
 	props->atomic_cap = IB_ATOMIC_NONE;
 	props->masked_atomic_cap = IB_ATOMIC_NONE;
 	props->max_ah = INT_MAX;
-- 
2.34.1


