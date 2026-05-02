Return-Path: <linux-hyperv+bounces-10572-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sLrGBcSr9WmXNwIAu9opvQ
	(envelope-from <linux-hyperv+bounces-10572-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Sat, 02 May 2026 09:46:12 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C92C4B14C7
	for <lists+linux-hyperv@lfdr.de>; Sat, 02 May 2026 09:46:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 16E4E3022A88
	for <lists+linux-hyperv@lfdr.de>; Sat,  2 May 2026 07:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE7383002DF;
	Sat,  2 May 2026 07:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="mQJ9jCfP"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77C1726AA91;
	Sat,  2 May 2026 07:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777707962; cv=none; b=OX9a2V90HFyk7/GYoKiVNDoWWjEvPKxKSRIWHK4BQkI1sRwOJu3Cq/DKC3WeDidieOwqoIhwToqON6uftiPRkxNAahAhxZ78za0tYZsZyCtRlWZkTvLk+NnltTptEDql6AgzSl9kEYk5k7PruAq3unfYLIMAF/taOF1WRzrCvQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777707962; c=relaxed/simple;
	bh=6UnbY4DrqGtksJ4MzzZtojHfq0UuwCW7gM2ovAeSmYg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WIeOorbw289wksbDMBENveAorn+iz2GjmcYrimMpz7lj0HJZUIBckJopIihsAJ2SA4umrl0Jz70ge0ytMKGFwCT1oK8XTXPl8nfJSI/x/Mja6fuXU7N6pkVUCz08kLGisV4OmIeao05RTpCcpTl+X4/SsbpzciL68vKpqLx/gdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=mQJ9jCfP; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1231)
	id D633920B716F; Sat,  2 May 2026 00:46:00 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D633920B716F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1777707960;
	bh=K/dQLWpvtfHpW7x2/2gVgixuqfIkLb/3dZkP2GDm5KU=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=mQJ9jCfPm5Mz8TL5FKv8sudWcV2ovb72IpvnkPocdPlCDhfRNM/KcvotcKMkRswLm
	 0SyA0PZC5AGrWbuc0BK20JGugnX0nIurvYpYP7gzoiWkFR+8jfMisQLTvgXDoT2sHd
	 5oMnrDRkEnqCv27LHMxxgIQhsXI2W+3xUonHdVR4=
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
Subject: [PATCH net-next v3 2/2] net: mana: Use kvmalloc for large RX queue and buffer allocations
Date: Sat,  2 May 2026 00:45:34 -0700
Message-ID: <20260502074552.23857-3-gargaditya@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260502074552.23857-1-gargaditya@linux.microsoft.com>
References: <20260502074552.23857-1-gargaditya@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 5C92C4B14C7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10572-lists,linux-hyperv=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gargaditya@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	NEURAL_HAM(-0.00)[-0.989];
	RCPT_COUNT_TWELVE(0.00)[27];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.microsoft.com:dkim,linux.microsoft.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

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


