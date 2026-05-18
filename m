Return-Path: <linux-hyperv+bounces-11007-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +I/ANKhtC2rSHgUAu9opvQ
	(envelope-from <linux-hyperv+bounces-11007-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 18 May 2026 21:51:04 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F4375731E1
	for <lists+linux-hyperv@lfdr.de>; Mon, 18 May 2026 21:51:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F19353055D6A
	for <lists+linux-hyperv@lfdr.de>; Mon, 18 May 2026 19:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 479F6391828;
	Mon, 18 May 2026 19:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="C1wEeh2z"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E44D3379979;
	Mon, 18 May 2026 19:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779133642; cv=none; b=dUr2NFATKc+bUuJ3E87y/Si7KlltSvZyzX9mn9RQ4n+/s6io+/xrvAYG7hPPIVQuZIZ1Xrheav0Lz6L5XP+NUqhOC0b8cVct4N18wWtpKqfAz0We1BUo8kbSBp3RiiKh06L+dt9z6MQCKPSEExemIMR+9OOuYblZOm70NEs1oFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779133642; c=relaxed/simple;
	bh=3+uhNPAe90CZ/8i4LjeoXa8PXzSV6BEbybG8SQ2DHJA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GLOloepadlV1Iam2iUqC+rXFecoN/S5zVVqfwr3t7pBr5s/IiB8KDcHaikS/Z0/JsQsd9UGaJUfPdG2oAP/DovbhVeC7ds0EysfRYKTcvJSLDFrHc3hhyDU/Rnm7SiR9OdZ3dBoTf+cXpEaO8qvFPG5NYS7qHrv6s6CuDqGlTRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=C1wEeh2z; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id D3F3A20B7167;
	Mon, 18 May 2026 12:47:14 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D3F3A20B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1779133634;
	bh=VAImdNSenqd/MKvEKpeyBgJGXFRdv09o3V59MmstgwM=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=C1wEeh2z23wkcIbk2gpBZxhMpEqzUoGi4QXKAZDJoxIGwwJaHb9raxwChK8EOVcl6
	 ZJ3VkssdrK5WCDVfw0Ix4BWwbdlHdlEmXfGoU955tdm846DI6KzkgPZxzmfHtvmG/H
	 xz2Y5EThy4GiiIfJc+Wozd9emaNzW0dKIcqW8HMA=
From: Dipayaan Roy <dipayanroy@linux.microsoft.com>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	leon@kernel.org,
	longli@microsoft.com,
	kotaranov@microsoft.com,
	horms@kernel.org,
	shradhagupta@linux.microsoft.com,
	ssengar@linux.microsoft.com,
	ernis@linux.microsoft.com,
	shirazsaleem@microsoft.com,
	linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	stephen@networkplumber.org,
	jacob.e.keller@intel.com,
	dipayanroy@microsoft.com,
	leitao@debian.org,
	kees@kernel.org,
	john.fastabend@gmail.com,
	hawk@kernel.org,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	ast@kernel.org,
	sdf@fomichev.me,
	yury.norov@gmail.com
Subject: [PATCH net 1/2] net: mana: Add NULL guards in teardown path to prevent panic on attach failure
Date: Mon, 18 May 2026 12:43:50 -0700
Message-ID: <20260518194654.735580-2-dipayanroy@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260518194654.735580-1-dipayanroy@linux.microsoft.com>
References: <20260518194654.735580-1-dipayanroy@linux.microsoft.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[microsoft.com,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,linux.microsoft.com,vger.kernel.org,networkplumber.org,intel.com,debian.org,gmail.com,iogearbox.net,fomichev.me];
	TAGGED_FROM(0.00)[bounces-11007-lists,linux-hyperv=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[33];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dipayanroy@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.microsoft.com:mid,linux.microsoft.com:dkim]
X-Rspamd-Queue-Id: 2F4375731E1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When queue allocation fails partway through, the error cleanup frees
and NULLs apc->tx_qp and apc->rxqs. Multiple teardown paths such as
mana_remove(), mana_change_mtu() recovery, and internal error handling
in mana_alloc_queues() can subsequently call into functions that
dereference these pointers without NULL checks:

- mana_chn_setxdp() dereferences apc->rxqs[0], causing a NULL pointer
  dereference panic (CR2: 0000000000000000 at mana_chn_setxdp+0x26).
- mana_destroy_vport() iterates apc->rxqs without a NULL check.
- mana_fence_rqs() iterates apc->rxqs without a NULL check.
- mana_dealloc_queues() iterates apc->tx_qp without a NULL check.

Add NULL guards for apc->rxqs in mana_fence_rqs(),
mana_destroy_vport(), and before the mana_chn_setxdp() call. Add a
NULL guard for apc->tx_qp in mana_dealloc_queues() to skip TX queue
draining when TX queues were never allocated or already freed.

Fixes: ca9c54d2d6a5 ("net: mana: Add a driver for Microsoft Azure Network Adapter (MANA)")
Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Dipayaan Roy <dipayanroy@linux.microsoft.com>
---
 drivers/net/ethernet/microsoft/mana/mana_en.c | 70 +++++++++++--------
 1 file changed, 41 insertions(+), 29 deletions(-)

diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index 9afc786b297a..0582803907a8 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -1727,6 +1727,9 @@ static void mana_fence_rqs(struct mana_port_context *apc)
 	struct mana_rxq *rxq;
 	int err;
 
+	if (!apc->rxqs)
+		return;
+
 	for (rxq_idx = 0; rxq_idx < apc->num_queues; rxq_idx++) {
 		rxq = apc->rxqs[rxq_idx];
 		err = mana_fence_rq(apc, rxq);
@@ -2858,13 +2861,16 @@ static void mana_destroy_vport(struct mana_port_context *apc)
 	struct mana_rxq *rxq;
 	u32 rxq_idx;
 
-	for (rxq_idx = 0; rxq_idx < apc->num_queues; rxq_idx++) {
-		rxq = apc->rxqs[rxq_idx];
-		if (!rxq)
-			continue;
+	if (apc->rxqs) {
 
-		mana_destroy_rxq(apc, rxq, true);
-		apc->rxqs[rxq_idx] = NULL;
+		for (rxq_idx = 0; rxq_idx < apc->num_queues; rxq_idx++) {
+			rxq = apc->rxqs[rxq_idx];
+			if (!rxq)
+				continue;
+
+			mana_destroy_rxq(apc, rxq, true);
+			apc->rxqs[rxq_idx] = NULL;
+		}
 	}
 
 	mana_destroy_txq(apc);
@@ -3269,7 +3275,8 @@ static int mana_dealloc_queues(struct net_device *ndev)
 	if (apc->port_is_up)
 		return -EINVAL;
 
-	mana_chn_setxdp(apc, NULL);
+	if (apc->rxqs)
+		mana_chn_setxdp(apc, NULL);
 
 	if (gd->gdma_context->is_pf && !apc->ac->bm_hostmode)
 		mana_pf_deregister_filter(apc);
@@ -3287,33 +3294,38 @@ static int mana_dealloc_queues(struct net_device *ndev)
 	 * number of queues.
 	 */
 
-	for (i = 0; i < apc->num_queues; i++) {
-		txq = &apc->tx_qp[i].txq;
-		tsleep = 1000;
-		while (atomic_read(&txq->pending_sends) > 0 &&
-		       time_before(jiffies, timeout)) {
-			usleep_range(tsleep, tsleep + 1000);
-			tsleep <<= 1;
-		}
-		if (atomic_read(&txq->pending_sends)) {
-			err = pcie_flr(to_pci_dev(gd->gdma_context->dev));
-			if (err) {
-				netdev_err(ndev, "flr failed %d with %d pkts pending in txq %u\n",
-					   err, atomic_read(&txq->pending_sends),
-					   txq->gdma_txq_id);
+	if (apc->tx_qp) {
+		for (i = 0; i < apc->num_queues; i++) {
+			txq = &apc->tx_qp[i].txq;
+			tsleep = 1000;
+			while (atomic_read(&txq->pending_sends) > 0 &&
+			       time_before(jiffies, timeout)) {
+				usleep_range(tsleep, tsleep + 1000);
+				tsleep <<= 1;
+			}
+			if (atomic_read(&txq->pending_sends)) {
+				err =
+				    pcie_flr(to_pci_dev(gd->gdma_context->dev));
+				if (err) {
+					netdev_err(ndev, "flr failed %d with %d pkts pending in txq %u\n",
+						   err,
+					    atomic_read(&txq->pending_sends),
+					    txq->gdma_txq_id);
+				}
+				break;
 			}
-			break;
 		}
-	}
 
-	for (i = 0; i < apc->num_queues; i++) {
-		txq = &apc->tx_qp[i].txq;
-		while ((skb = skb_dequeue(&txq->pending_skbs))) {
-			mana_unmap_skb(skb, apc);
-			dev_kfree_skb_any(skb);
+		for (i = 0; i < apc->num_queues; i++) {
+			txq = &apc->tx_qp[i].txq;
+			while ((skb = skb_dequeue(&txq->pending_skbs))) {
+				mana_unmap_skb(skb, apc);
+				dev_kfree_skb_any(skb);
+			}
+			atomic_set(&txq->pending_sends, 0);
 		}
-		atomic_set(&txq->pending_sends, 0);
 	}
+
 	/* We're 100% sure the queues can no longer be woken up, because
 	 * we're sure now mana_poll_tx_cq() can't be running.
 	 */
-- 
2.43.0


