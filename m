Return-Path: <linux-hyperv+bounces-8988-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eHySN2ZEn2m5ZgQAu9opvQ
	(envelope-from <linux-hyperv+bounces-8988-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Feb 2026 19:50:14 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8454519C6F4
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Feb 2026 19:50:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DC88E303298F
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Feb 2026 18:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E85503ED129;
	Wed, 25 Feb 2026 18:50:08 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFA933D4127;
	Wed, 25 Feb 2026 18:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772045408; cv=none; b=pVwRjHT0fRy8bqQqCjJ+qX2RZJuRByW4/ILxJcFjHAG3XHu3LhhiPMjv0AMjhr+YhmY1qIgrg6fTTsyvqQzTSRdILuxMScaWxr94WBWf+8YvrmlgC5epuAPiOD7uxcdlNWuKBr7RcnjHh8jXzONn//Kz4qg7ZCNxWGGJcfNypRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772045408; c=relaxed/simple;
	bh=wL4+TlbUlIL2gNos6tx0NzDuYPhO4XDsOMYg5kj56oQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gU8obwCNBAD85p52h0KW45ZtFgp+jIAkTRNj6mWY5FRBh9iWnbNw+tx8C1ZWcUsEBAP/NTFSd8gA+kfL3A8Js/+MRu3aPMy79/KjZSddK7TuZ+4MEMUtWhlZhTTbLxmq2LlCBLxSER4eq6KfxmVIW9koDiS6bDeD3P6OyFopU10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1202)
	id 8D18320B6F02; Wed, 25 Feb 2026 10:50:06 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8D18320B6F02
From: Long Li <longli@microsoft.com>
To: "K . Y . Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Shradha Gupta <shradhagupta@linux.microsoft.com>,
	Erni Sri Satya Vennela <ernis@linux.microsoft.com>,
	linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net] net: mana: Ring doorbell at 4 CQ wraparounds
Date: Wed, 25 Feb 2026 10:49:48 -0800
Message-ID: <20260225184948.941599-1-longli@microsoft.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.54 / 15.00];
	DMARC_POLICY_REJECT(2.00)[microsoft.com : SPF not aligned (relaxed), No valid DKIM,reject];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-8988-lists,linux-hyperv=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.971];
	FROM_NEQ_ENVFROM(0.00)[longli@microsoft.com,linux-hyperv@vger.kernel.org];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8454519C6F4
X-Rspamd-Action: no action

MANA hardware requires at least one doorbell ring every 8 wraparounds
of the CQ. The driver rings the doorbell as a form of flow control to
inform hardware that CQEs have been consumed.

The NAPI poll functions mana_poll_tx_cq() and mana_poll_rx_cq() can
poll up to CQE_POLLING_BUFFER (512) completions per call. If the CQ
has fewer than 512 entries, a single poll call can process more than
4 wraparounds without ringing the doorbell. The doorbell threshold
check also uses ">" instead of ">=", delaying the ring by one extra
CQE beyond 4 wraparounds. Combined, these issues can cause the driver
to exceed the 8-wraparound hardware limit, leading to missed
completions and stalled queues.

Fix this by capping the number of CQEs polled per call to 4 wraparounds
of the CQ in both TX and RX paths. Also change the doorbell threshold
from ">" to ">=" so the doorbell is rung as soon as 4 wraparounds are
reached.

Cc: stable@vger.kernel.org
Fixes: 58a63729c957 ("net: mana: Fix doorbell out of order violation and avoid unnecessary doorbell rings")
Signed-off-by: Long Li <longli@microsoft.com>
---
 drivers/net/ethernet/microsoft/mana/mana_en.c | 23 +++++++++++++++----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index 9919183ad39e..fe667e0d930d 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -1770,8 +1770,14 @@ static void mana_poll_tx_cq(struct mana_cq *cq)
 	ndev = txq->ndev;
 	apc = netdev_priv(ndev);
 
+	/* Limit CQEs polled to 4 wraparounds of the CQ to ensure the
+	 * doorbell can be rung in time for the hardware's requirement
+	 * of at least one doorbell ring every 8 wraparounds.
+	 */
 	comp_read = mana_gd_poll_cq(cq->gdma_cq, completions,
-				    CQE_POLLING_BUFFER);
+				    min_t(u32, (cq->gdma_cq->queue_size /
+					   COMP_ENTRY_SIZE) * 4,
+					  CQE_POLLING_BUFFER));
 
 	if (comp_read < 1)
 		return;
@@ -2156,7 +2162,14 @@ static void mana_poll_rx_cq(struct mana_cq *cq)
 	struct mana_rxq *rxq = cq->rxq;
 	int comp_read, i;
 
-	comp_read = mana_gd_poll_cq(cq->gdma_cq, comp, CQE_POLLING_BUFFER);
+	/* Limit CQEs polled to 4 wraparounds of the CQ to ensure the
+	 * doorbell can be rung in time for the hardware's requirement
+	 * of at least one doorbell ring every 8 wraparounds.
+	 */
+	comp_read = mana_gd_poll_cq(cq->gdma_cq, comp,
+				    min_t(u32, (cq->gdma_cq->queue_size /
+					   COMP_ENTRY_SIZE) * 4,
+					  CQE_POLLING_BUFFER));
 	WARN_ON_ONCE(comp_read > CQE_POLLING_BUFFER);
 
 	rxq->xdp_flush = false;
@@ -2201,11 +2214,11 @@ static int mana_cq_handler(void *context, struct gdma_queue *gdma_queue)
 		mana_gd_ring_cq(gdma_queue, SET_ARM_BIT);
 		cq->work_done_since_doorbell = 0;
 		napi_complete_done(&cq->napi, w);
-	} else if (cq->work_done_since_doorbell >
-		   cq->gdma_cq->queue_size / COMP_ENTRY_SIZE * 4) {
+	} else if (cq->work_done_since_doorbell >=
+		   (cq->gdma_cq->queue_size / COMP_ENTRY_SIZE) * 4) {
 		/* MANA hardware requires at least one doorbell ring every 8
 		 * wraparounds of CQ even if there is no need to arm the CQ.
-		 * This driver rings the doorbell as soon as we have exceeded
+		 * This driver rings the doorbell as soon as it has processed
 		 * 4 wraparounds.
 		 */
 		mana_gd_ring_cq(gdma_queue, 0);
-- 
2.43.0


