Return-Path: <linux-hyperv+bounces-11163-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MGryE7ToEGqmfQYAu9opvQ
	(envelope-from <linux-hyperv+bounces-11163-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Sat, 23 May 2026 01:37:24 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F2B25BB898
	for <lists+linux-hyperv@lfdr.de>; Sat, 23 May 2026 01:37:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3DEC0301FD6E
	for <lists+linux-hyperv@lfdr.de>; Fri, 22 May 2026 23:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 502BA394E80;
	Fri, 22 May 2026 23:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="D/EZELT5"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8983364047;
	Fri, 22 May 2026 23:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779492989; cv=none; b=WGCsAaf0F+XJnLPyuFS96ECM1ni9YqG+NDddtNHQ6g6oASNe0gLuS/F24GSxWoTBoPQeKhcWk/K4HwVFgkvcvXxlP/XvjMRpT5JwqmpnyBKuNeZsMdVcKZjXL1FQMshyvuT8dcTKI5tu4nIRQ9+Hmbbb7nF6q2lktQ3MtgvDeTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779492989; c=relaxed/simple;
	bh=mfHSl91WC1gD5+msUoAhsg9R2OXHjrwM9fVxUnuTD6g=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=esRFi20Js+q15XewNUOXXrB3WipbZs+mZWyuW5qLCmpgl3r68uRNz5y8B39T+LCMNhswNptsMhXlidmL9CYfZrZcMNg8mQIXJFEBNJ6q5x4ZAFOgs4mMklVXGE9I34RdTgm19V0FAMTiKGVtSZAhpdD0HF4KZRh+VH4cMx6HDFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=D/EZELT5; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id D59EA20B7168;
	Fri, 22 May 2026 16:36:18 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D59EA20B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1779492978;
	bh=BHMOMfXC+nPX5s7KV/cJnf70L+SLHNnXK7J1WnTDItY=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=D/EZELT5Tx5pFNJncZQMzDS47of1TEsZ/X/xgAT6RfzA3t66sqK0fcqT7vSNSuyXR
	 nBPQrn+1/3yM7yXtAIjo3fjUiUyOigujcy2ovRNjwJdRMg3AGJuamZWCEZtJV9LMH1
	 oSj0mg4M/9KLUU5iBdo57D90IDcta3zFBFvyHI+k=
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
Subject: [PATCH net v2 1/2] net: mana: Add NULL guards in teardown path to prevent panic on attach failure
Date: Fri, 22 May 2026 16:33:12 -0700
Message-ID: <20260522233555.1099342-2-dipayanroy@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260522233555.1099342-1-dipayanroy@linux.microsoft.com>
References: <20260522233555.1099342-1-dipayanroy@linux.microsoft.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[microsoft.com,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,linux.microsoft.com,vger.kernel.org,networkplumber.org,intel.com,debian.org,gmail.com,iogearbox.net,fomichev.me];
	TAGGED_FROM(0.00)[bounces-11163-lists,linux-hyperv=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dipayanroy@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	NEURAL_HAM(-0.00)[-0.984];
	RCPT_COUNT_TWELVE(0.00)[33];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.microsoft.com:mid,linux.microsoft.com:dkim]
X-Rspamd-Queue-Id: 9F2B25BB898
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


