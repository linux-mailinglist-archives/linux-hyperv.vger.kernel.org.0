Return-Path: <linux-hyperv+bounces-10388-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iPahDK9m72kIBAEAu9opvQ
	(envelope-from <linux-hyperv+bounces-10388-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 27 Apr 2026 15:37:51 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CB2904738FD
	for <lists+linux-hyperv@lfdr.de>; Mon, 27 Apr 2026 15:37:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6568E300FEE0
	for <lists+linux-hyperv@lfdr.de>; Mon, 27 Apr 2026 13:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C4FD3CBE61;
	Mon, 27 Apr 2026 13:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="OvoJEIid"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 240B93CA481;
	Mon, 27 Apr 2026 13:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777296927; cv=none; b=cw5KGXvrDKlkQmtSmwmzlz7KD9hdBM5/Qvoj1RLoVQw2Y+VaHWSWCk/9br1Gy70mgNvO5v70I5aJARvGgx+DbAnJ2FvqA7g+FK+9CABnf+TsVKwl7Hx8VqRwEIIiz2g8PCkpZEb1ekPPLN5OZiHr8ULbklIoteQUW5mE0V4CfWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777296927; c=relaxed/simple;
	bh=6UnbY4DrqGtksJ4MzzZtojHfq0UuwCW7gM2ovAeSmYg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SpXJYuE1Kxp9By95LHSTAE5tcu4gyw4Ps8+RB3Okd+2fQF8cXllml0wInrsWd8SZoz2juGDVZ4PNoYTuIv4+Pg/GxN7O+UkGLEjy01sSYqJvJAN2jxN8XEWh6jjWTxNm7pybgiamd6hgUFuAvTD1bD3OeAbi0/I/Lqh2gHPQGMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=OvoJEIid; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1231)
	id 460C420B716E; Mon, 27 Apr 2026 06:35:26 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 460C420B716E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1777296926;
	bh=K/dQLWpvtfHpW7x2/2gVgixuqfIkLb/3dZkP2GDm5KU=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=OvoJEIidR5awQYT90mrlCmhY4HAlsh3WlvMkUWHSGMMurZxtSecu67XyqKVtIvA40
	 KaRp1QMqSPHxxgeis+1TExCMq8PlFs0b+xv9zHoR8QzFfgUJOEU8lS6R9n+NFH28uV
	 6yNOPRPBUWAqgPb0bGo/rMVIfJGf6iGY+FH8ynco=
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
Subject: [PATCH net-next v2 2/2] net: mana: Use kvmalloc for large RX queue and buffer allocations
Date: Mon, 27 Apr 2026 06:23:35 -0700
Message-ID: <20260427132807.1642290-3-gargaditya@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260427132807.1642290-1-gargaditya@linux.microsoft.com>
References: <20260427132807.1642290-1-gargaditya@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: CB2904738FD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10388-lists,linux-hyperv=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gargaditya@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_TWELVE(0.00)[27];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.microsoft.com:dkim,linux.microsoft.com:mid]

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
index 8adf72b96145..e1d8ac3417e8 100644
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
 
@@ -2564,7 +2564,7 @@ static void mana_destroy_rxq(struct mana_port_context *apc,
 	if (rxq->gdma_rq)
 		mana_gd_destroy_queue(gc, rxq->gdma_rq);
 
-	kfree(rxq);
+	kvfree(rxq);
 }
 
 static int mana_fill_rx_oob(struct mana_recv_buf_oob *rx_oob, u32 mem_key,
@@ -2704,7 +2704,7 @@ static struct mana_rxq *mana_create_rxq(struct mana_port_context *apc,
 
 	gc = gd->gdma_context;
 
-	rxq = kzalloc_flex(*rxq, rx_oobs, apc->rx_queue_size);
+	rxq = kvzalloc_flex(*rxq, rx_oobs, apc->rx_queue_size);
 	if (!rxq)
 		return NULL;
 
-- 
2.43.0


