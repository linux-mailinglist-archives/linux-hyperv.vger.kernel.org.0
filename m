Return-Path: <linux-hyperv+bounces-9353-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GJCOAOGksmnwOQAAu9opvQ
	(envelope-from <linux-hyperv+bounces-9353-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 12 Mar 2026 12:34:57 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A0C327107F
	for <lists+linux-hyperv@lfdr.de>; Thu, 12 Mar 2026 12:34:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CD91D32A1BDE
	for <lists+linux-hyperv@lfdr.de>; Thu, 12 Mar 2026 11:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D8E13C9429;
	Thu, 12 Mar 2026 11:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="GEJvw9YE"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 195D73C8731;
	Thu, 12 Mar 2026 11:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773314748; cv=none; b=dGCC9ssSvLc1f0aXmxoO0TzpTC443zGlQ1MXw91Q0y0w9ZXYun/uno+foI62HtC9cKnQptIvH12ioIZpE7tXq4qkQvHTWWeLJ4MMAAy9ddd4jaxqv5tS+gk0YjxLftTeGUhKsmKRyQOvrTgcWXyyHzANevTM8MUHV2Zc+D5bHIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773314748; c=relaxed/simple;
	bh=Y+UtdzSounWMJWkH+U3xhXlTzIMg+MMUuL47/SzZsW4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PlnJ5HiTCcf21YK6/BUxkOPjfRmE4zVHyJA/M+wdNRI8z4pCp/bqTLb1p1VOy23m1LdIk3FnnRuOhy5oNg75ZiU1hhPTymWLEvOf515jteeANZ8WWvMU1AvY5rTS7OBfhWWAPaNXbh2Km5FKqptVDqF/pr7IzFlMO2QsMCDvdTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=GEJvw9YE; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1173)
	id E326520B6F01; Thu, 12 Mar 2026 04:25:46 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E326520B6F01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1773314746;
	bh=Ad5TINA03MfgPAJ4hAnGYh96e3FcRc/vXyhtft8r6u8=;
	h=From:To:Cc:Subject:Date:From;
	b=GEJvw9YEmlVYRtQoe3UY0KX1C/iMHuIFYZ5tCSfIqrQovDuRNECBNb9DxknI1LYc4
	 VmzJMMDRfA+2+yM6kwklrv2g0GrdY7u4rv4eDSjKquox0FjHOoSaiNtCQB5NNWi/x2
	 BtrIRTKdy0EbWqw/chF0Hs9s/HVZK+d2LlTx1jJQ=
From: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
To: longli@microsoft.com,
	kotaranov@microsoft.com,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	linux-rdma@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
Subject: [PATCH net-next] net: mana: hardening: Clamp adapter capability values from MANA_IB_GET_ADAPTER_CAP
Date: Thu, 12 Mar 2026 04:25:37 -0700
Message-ID: <20260312112538.966157-1-ernis@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9353-lists,linux-hyperv=lfdr.de];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ernis@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.microsoft.com:dkim,linux.microsoft.com:mid]
X-Rspamd-Queue-Id: 6A0C327107F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

As part of MANA hardening for CVM, clamp hardware-reported adapter
capability values from the MANA_IB_GET_ADAPTER_CAP response before
they are used by the IB subsystem.

The response fields (max_qp_count, max_cq_count, max_mr_count,
max_pd_count, max_inbound_read_limit, max_outbound_read_limit,
max_qp_wr, max_send_sge_count, max_recv_sge_count) are u32 but are
assigned to signed int members in struct ib_device_attr. If hardware
returns a value exceeding INT_MAX, the implicit u32-to-int conversion
produces a negative value, which can cause incorrect behavior in the
IB core and userspace applications.

Clamp these fields to INT_MAX in mana_ib_gd_query_adapter_caps() so
all downstream consumers receive safe values.

Additionally, fix an integer overflow in mana_ib_query_device() where
max_res_rd_atom is computed as max_qp_rd_atom * max_qp. Both operands
are int and the multiplication can overflow. Widen to s64 before
multiplying and clamp the result to INT_MAX.

Signed-off-by: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
---
 drivers/infiniband/hw/mana/main.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/infiniband/hw/mana/main.c b/drivers/infiniband/hw/mana/main.c
index 8d99cd00f002..2869660077ef 100644
--- a/drivers/infiniband/hw/mana/main.c
+++ b/drivers/infiniband/hw/mana/main.c
@@ -599,7 +599,8 @@ int mana_ib_query_device(struct ib_device *ibdev, struct ib_device_attr *props,
 	props->max_mr = dev->adapter_caps.max_mr_count;
 	props->max_pd = dev->adapter_caps.max_pd_count;
 	props->max_qp_rd_atom = dev->adapter_caps.max_inbound_read_limit;
-	props->max_res_rd_atom = props->max_qp_rd_atom * props->max_qp;
+	props->max_res_rd_atom =
+		min_t(s64, (s64)props->max_qp_rd_atom * props->max_qp, INT_MAX);
 	props->max_qp_init_rd_atom = dev->adapter_caps.max_outbound_read_limit;
 	props->atomic_cap = IB_ATOMIC_NONE;
 	props->masked_atomic_cap = IB_ATOMIC_NONE;
@@ -694,20 +695,22 @@ int mana_ib_gd_query_adapter_caps(struct mana_ib_dev *dev)
 	caps->max_sq_id = resp.max_sq_id;
 	caps->max_rq_id = resp.max_rq_id;
 	caps->max_cq_id = resp.max_cq_id;
-	caps->max_qp_count = resp.max_qp_count;
-	caps->max_cq_count = resp.max_cq_count;
-	caps->max_mr_count = resp.max_mr_count;
-	caps->max_pd_count = resp.max_pd_count;
-	caps->max_inbound_read_limit = resp.max_inbound_read_limit;
-	caps->max_outbound_read_limit = resp.max_outbound_read_limit;
+	caps->max_qp_count = min_t(u32, resp.max_qp_count, INT_MAX);
+	caps->max_cq_count = min_t(u32, resp.max_cq_count, INT_MAX);
+	caps->max_mr_count = min_t(u32, resp.max_mr_count, INT_MAX);
+	caps->max_pd_count = min_t(u32, resp.max_pd_count, INT_MAX);
+	caps->max_inbound_read_limit = min_t(u32, resp.max_inbound_read_limit,
+					     INT_MAX);
+	caps->max_outbound_read_limit = min_t(u32, resp.max_outbound_read_limit,
+					      INT_MAX);
 	caps->mw_count = resp.mw_count;
 	caps->max_srq_count = resp.max_srq_count;
 	caps->max_qp_wr = min_t(u32,
 				resp.max_requester_sq_size / GDMA_MAX_SQE_SIZE,
 				resp.max_requester_rq_size / GDMA_MAX_RQE_SIZE);
 	caps->max_inline_data_size = resp.max_inline_data_size;
-	caps->max_send_sge_count = resp.max_send_sge_count;
-	caps->max_recv_sge_count = resp.max_recv_sge_count;
+	caps->max_send_sge_count = min_t(u32, resp.max_send_sge_count, INT_MAX);
+	caps->max_recv_sge_count = min_t(u32, resp.max_recv_sge_count, INT_MAX);
 	caps->feature_flags = resp.feature_flags;
 
 	caps->page_size_cap = PAGE_SZ_BM;
-- 
2.34.1


