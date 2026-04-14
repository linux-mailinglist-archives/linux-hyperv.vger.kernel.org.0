Return-Path: <linux-hyperv+bounces-10153-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CFb3MQdd3mlfCQAAu9opvQ
	(envelope-from <linux-hyperv+bounces-10153-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 14 Apr 2026 17:28:07 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 50C2F3FBCBE
	for <lists+linux-hyperv@lfdr.de>; Tue, 14 Apr 2026 17:28:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1150A3042408
	for <lists+linux-hyperv@lfdr.de>; Tue, 14 Apr 2026 15:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C956E3E92BF;
	Tue, 14 Apr 2026 15:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="IcR9egO0"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7122E3E95A0;
	Tue, 14 Apr 2026 15:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776179720; cv=none; b=FaegEhsNgxpELCZzPRviSC81ij7vKi5bma59kggK6e+EjSrDROQRNnXe1yAqwrlYZL26EV/MPAs1o3z2qdZQeLQhzBW6jZF9afxRBbc7qfieyvTLyUDQHnOxkXNG0CkP6zhSzTvAU62tFFOcPclQW/LImIvUd6nTyPl/LcNxiis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776179720; c=relaxed/simple;
	bh=6YwKydianqUwY/z33wdXDA5OWdT1iJUUog0AXC/st0g=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hIhGPFY0DE1DFH050apjqbnFrXD3lt3s6Hre9I0sCUGeSTykQYnHx5MRw6cM99QLv7Rvx2KqPujCg3eGD7YJ82TdXlrz+rD2Lbjofo9wo+YoNRW6FOzvwgwfv5whmxzVaxC2uE+0TrXoluVicztjLtO7/rBu3fYTXz2U1wziU3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=IcR9egO0; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1231)
	id 72F7F20B6F15; Tue, 14 Apr 2026 08:15:11 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 72F7F20B6F15
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1776179711;
	bh=DwhaJTyNdzr7spJcBnG3kAKjuT66n1GUjfUJRIF8+Ck=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=IcR9egO0gVUmpT4RNn+h/pxmaWid5VJyYhIvtsII04siXegrdeKRhikqmfvJCP4G6
	 +RmI83Dl4BgaRchqUJpS95jdyl4vj0pvB2u4/TijbdnslteSASTrTg7bf04/0iWutg
	 ZIHPmSZGsoCmU1Xt+Oo0rEpFINdkjk5M8VKrQN0s=
From: Aditya Garg <gargaditya@linux.microsoft.com>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	longli@microsoft.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	kotaranov@microsoft.com,
	horms@kernel.org,
	ssengar@linux.microsoft.com,
	jacob.e.keller@intel.com,
	dipayanroy@linux.microsoft.com,
	ernis@linux.microsoft.com,
	shirazsaleem@microsoft.com,
	kees@kernel.org,
	sbhatta@marvell.com,
	leitao@debian.org,
	netdev@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	bpf@vger.kernel.org,
	gargaditya@microsoft.com,
	gargaditya@linux.microsoft.com
Subject: [PATCH net-next 2/2] net: mana: Use kvmalloc for large RX queue and buffer allocations
Date: Tue, 14 Apr 2026 08:13:30 -0700
Message-ID: <20260414151456.687506-3-gargaditya@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260414151456.687506-1-gargaditya@linux.microsoft.com>
References: <20260414151456.687506-1-gargaditya@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10153-lists,linux-hyperv=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gargaditya@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	NEURAL_HAM(-0.00)[-0.993];
	RCPT_COUNT_TWELVE(0.00)[27];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.microsoft.com:dkim,linux.microsoft.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 50C2F3FBCBE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The RX path allocations for rxbufs_pre, das_pre, and rxq scale with
queue count and queue depth. With high queue counts and depth, these can
exceed what kmalloc can reliably provide from physically contiguous
memory under fragmentation.

Switch these from kmalloc to kvmalloc variants so the allocator
transparently falls back to vmalloc when contiguous memory is scarce,
and update the corresponding frees to kvfree.

Signed-off-by: Aditya Garg <gargaditya@linux.microsoft.com>
Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
---
 drivers/net/ethernet/microsoft/mana/mana_en.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index 49ee77b0939a..585d891bbbac 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -685,11 +685,11 @@ void mana_pre_dealloc_rxbufs(struct mana_port_context *mpc)
 		put_page(virt_to_head_page(mpc->rxbufs_pre[i]));
 	}
 
-	kfree(mpc->das_pre);
+	kvfree(mpc->das_pre);
 	mpc->das_pre = NULL;
 
 out2:
-	kfree(mpc->rxbufs_pre);
+	kvfree(mpc->rxbufs_pre);
 	mpc->rxbufs_pre = NULL;
 
 out1:
@@ -806,11 +806,11 @@ int mana_pre_alloc_rxbufs(struct mana_port_context *mpc, int new_mtu, int num_qu
 	num_rxb = num_queues * mpc->rx_queue_size;
 
 	WARN(mpc->rxbufs_pre, "mana rxbufs_pre exists\n");
-	mpc->rxbufs_pre = kmalloc_array(num_rxb, sizeof(void *), GFP_KERNEL);
+	mpc->rxbufs_pre = kvmalloc_array(num_rxb, sizeof(void *), GFP_KERNEL);
 	if (!mpc->rxbufs_pre)
 		goto error;
 
-	mpc->das_pre = kmalloc_objs(dma_addr_t, num_rxb);
+	mpc->das_pre = kvmalloc_objs(dma_addr_t, num_rxb);
 	if (!mpc->das_pre)
 		goto error;
 
@@ -2527,7 +2527,7 @@ static void mana_destroy_rxq(struct mana_port_context *apc,
 	if (rxq->gdma_rq)
 		mana_gd_destroy_queue(gc, rxq->gdma_rq);
 
-	kfree(rxq);
+	kvfree(rxq);
 }
 
 static int mana_fill_rx_oob(struct mana_recv_buf_oob *rx_oob, u32 mem_key,
@@ -2667,7 +2667,7 @@ static struct mana_rxq *mana_create_rxq(struct mana_port_context *apc,
 
 	gc = gd->gdma_context;
 
-	rxq = kzalloc_flex(*rxq, rx_oobs, apc->rx_queue_size);
+	rxq = kvzalloc_flex(*rxq, rx_oobs, apc->rx_queue_size);
 	if (!rxq)
 		return NULL;
 
-- 
2.43.0


