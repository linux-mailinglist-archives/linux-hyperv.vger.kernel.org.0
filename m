Return-Path: <linux-hyperv+bounces-11796-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 6bLRC27lRWrHGQsAu9opvQ
	(envelope-from <linux-hyperv+bounces-11796-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 02 Jul 2026 06:13:34 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B6B616F3645
	for <lists+linux-hyperv@lfdr.de>; Thu, 02 Jul 2026 06:13:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=microsoft.com (policy=reject);
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11796-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11796-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8F82130305E9
	for <lists+linux-hyperv@lfdr.de>; Thu,  2 Jul 2026 04:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48108352016;
	Thu,  2 Jul 2026 04:13:15 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0424417A2F6;
	Thu,  2 Jul 2026 04:13:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782965595; cv=none; b=AdgSA7OWDv8T69REQU7EYukWjN6rA1xipbZZT/P2QkVNkdX7aq1bhyNlTXePR9aZ76ClnR4kSSFH5F2iHo8ZMCi8gydszwBRgwZ2mPVlQZMk/lMyzoHchbr11HnrV45UIvIzgpWJjXUrBUGndU2DB3vi2SoiI9UqKdJ3123/kt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782965595; c=relaxed/simple;
	bh=a0dMgq+2G2AAP8nxpuoGlbVjKuukbyCRin93jGIQ2Y4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l3fOHacOZZ9//74j/BOeuUDIQn7Ml2Mjpgnn+lCtA114B4eG89ppaHP/NEqf4117kQ+g/cxXwYLuW6FPMmcuBH+XM1IpdZqs33tvsVqh3dGEeHRQawX+iBuLUmLzfM+yEwLlCu6X5LwdW3+GfJCIgQazKcSVmKH4t2iAH615jGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; arc=none smtp.client-ip=13.77.154.182
Received: by linux.microsoft.com (Postfix, from userid 1009)
	id 1612120B716F; Wed,  1 Jul 2026 21:13:06 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1612120B716F
From: Dexuan Cui <decui@microsoft.com>
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
	ernis@linux.microsoft.com,
	dipayanroy@linux.microsoft.com,
	kees@kernel.org,
	jacob.e.keller@intel.com,
	ssengar@linux.microsoft.com,
	linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH net v3 2/2] net: mana: Sync page pool RX frags for CPU
Date: Wed,  1 Jul 2026 21:12:37 -0700
Message-ID: <20260702041237.617719-3-decui@microsoft.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260702041237.617719-1-decui@microsoft.com>
References: <20260702041237.617719-1-decui@microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
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
	FORGED_RECIPIENTS(0.00)[m:kys@microsoft.com,m:haiyangz@microsoft.com,m:wei.liu@kernel.org,m:decui@microsoft.com,m:longli@microsoft.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:kotaranov@microsoft.com,m:horms@kernel.org,m:ernis@linux.microsoft.com,m:dipayanroy@linux.microsoft.com,m:kees@kernel.org,m:jacob.e.keller@intel.com,m:ssengar@linux.microsoft.com,m:linux-hyperv@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:stable@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11796-lists,linux-hyperv=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[decui@microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[decui@microsoft.com,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_DKIM_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_SENDER_FORWARDING(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B6B616F3645

MANA allocates RX buffers from page pool fragments when frag_count is
greater than 1. In that case the buffers remain DMA mapped by page pool
and the RX completion path does not call dma_unmap_single(). As a result,
the implicit sync-for-CPU normally performed by dma_unmap_single() is
missing before the packet data is passed to the networking stack.

This breaks RX on configurations which require explicit DMA syncing, for
example when booted with swiotlb=force.

Fix this by recording the page pool page and DMA sync offset when the RX
buffer is allocated, and syncing the received packet range for CPU access
before handing the RX buffer to the stack.

Fixes: 730ff06d3f5c ("net: mana: Use page pool fragments for RX buffers instead of full pages to improve memory efficiency.")
Cc: stable@vger.kernel.org
Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Dexuan Cui <decui@microsoft.com>
---

Changes since v1:
    v1 is split into two patches in the v2.
    Add Haiyang's Reviewed-by.

Changes since v2:
    Swapped the order of the 2 patches in v2.
    No extra change.

 drivers/net/ethernet/microsoft/mana/mana_en.c | 40 +++++++++++++++----
 include/net/mana/mana.h                       |  8 ++++
 2 files changed, 41 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index edc504b2447a..0b44c51ae6ec 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -2044,12 +2044,16 @@ static void mana_rx_skb(void *buf_va, bool from_pool,
 }
 
 static void *mana_get_rxfrag(struct mana_rxq *rxq, struct device *dev,
-			     dma_addr_t *da, bool *from_pool)
+			     dma_addr_t *da, bool *from_pool,
+			     struct page **pp_page, u32 *dma_sync_offset)
 {
 	struct page *page;
 	u32 offset;
 	void *va;
+
 	*from_pool = false;
+	*pp_page = NULL;
+	*dma_sync_offset = 0;
 
 	/* Don't use fragments for jumbo frames or XDP where it's 1 fragment
 	 * per page.
@@ -2087,31 +2091,47 @@ static void *mana_get_rxfrag(struct mana_rxq *rxq, struct device *dev,
 	va  = page_to_virt(page) + offset;
 	*da = page_pool_get_dma_addr(page) + offset + rxq->headroom;
 	*from_pool = true;
+	*pp_page = page;
+	*dma_sync_offset = offset + rxq->headroom;
 
 	return va;
 }
 
 /* Allocate frag for rx buffer, and save the old buf */
 static void mana_refill_rx_oob(struct device *dev, struct mana_rxq *rxq,
-			       struct mana_recv_buf_oob *rxoob, void **old_buf,
-			       bool *old_fp)
+			       struct mana_recv_buf_oob *rxoob, u32 pktlen,
+			       void **old_buf, bool *old_fp)
 {
+	struct page *pp_page;
+	u32 dma_sync_offset;
 	bool from_pool;
 	dma_addr_t da;
 	void *va;
 
-	va = mana_get_rxfrag(rxq, dev, &da, &from_pool);
+	va = mana_get_rxfrag(rxq, dev, &da, &from_pool, &pp_page,
+			     &dma_sync_offset);
 	if (!va)
 		return;
-	if (!rxoob->from_pool || rxq->frag_count == 1)
+	if (!rxoob->from_pool || rxq->frag_count == 1) {
 		dma_unmap_single(dev, rxoob->sgl[0].address, rxq->datasize,
 				 DMA_FROM_DEVICE);
+	} else {
+		/* The page pool maps the whole page and only syncs for device
+		 * automatically (PP_FLAG_DMA_SYNC_DEV). Sync the received bytes
+		 * for the CPU before they are read: this is required if DMA
+		 * is incoherent or bounce buffers are used.
+		 */
+		page_pool_dma_sync_for_cpu(rxq->page_pool, rxoob->pp_page,
+					   rxoob->dma_sync_offset, pktlen);
+	}
 	*old_buf = rxoob->buf_va;
 	*old_fp = rxoob->from_pool;
 
 	rxoob->buf_va = va;
 	rxoob->sgl[0].address = da;
 	rxoob->from_pool = from_pool;
+	rxoob->pp_page = pp_page;
+	rxoob->dma_sync_offset = dma_sync_offset;
 }
 
 static void mana_process_rx_cqe(struct mana_rxq *rxq, struct mana_cq *cq,
@@ -2182,7 +2202,8 @@ static void mana_process_rx_cqe(struct mana_rxq *rxq, struct mana_cq *cq,
 			/* Reuse the RX buffer since rxbuf_oob is unchanged. */
 		} else {
 
-			mana_refill_rx_oob(dev, rxq, rxbuf_oob, &old_buf, &old_fp);
+			mana_refill_rx_oob(dev, rxq, rxbuf_oob, pktlen,
+					   &old_buf, &old_fp);
 
 			/* Unsuccessful refill will have old_buf == NULL.
 			 * In this case, mana_rx_skb() will drop the packet.
@@ -2579,6 +2600,8 @@ static int mana_fill_rx_oob(struct mana_recv_buf_oob *rx_oob, u32 mem_key,
 			    struct mana_rxq *rxq, struct device *dev)
 {
 	struct mana_port_context *mpc = netdev_priv(rxq->ndev);
+	struct page *pp_page = NULL;
+	u32 dma_sync_offset = 0;
 	bool from_pool = false;
 	dma_addr_t da;
 	void *va;
@@ -2586,13 +2609,16 @@ static int mana_fill_rx_oob(struct mana_recv_buf_oob *rx_oob, u32 mem_key,
 	if (mpc->rxbufs_pre)
 		va = mana_get_rxbuf_pre(rxq, &da);
 	else
-		va = mana_get_rxfrag(rxq, dev, &da, &from_pool);
+		va = mana_get_rxfrag(rxq, dev, &da, &from_pool, &pp_page,
+				     &dma_sync_offset);
 
 	if (!va)
 		return -ENOMEM;
 
 	rx_oob->buf_va = va;
 	rx_oob->from_pool = from_pool;
+	rx_oob->pp_page = pp_page;
+	rx_oob->dma_sync_offset = dma_sync_offset;
 
 	rx_oob->sgl[0].address = da;
 	rx_oob->sgl[0].size = rxq->datasize;
diff --git a/include/net/mana/mana.h b/include/net/mana/mana.h
index 8f721cd4e4a7..4111b93169d2 100644
--- a/include/net/mana/mana.h
+++ b/include/net/mana/mana.h
@@ -305,6 +305,14 @@ struct mana_recv_buf_oob {
 
 	void *buf_va;
 	bool from_pool; /* allocated from a page pool */
+	/* head page of the page_pool fragment; valid only when
+	 * from_pool && frag_count > 1.
+	 */
+	struct page *pp_page;
+	/* Fragment offset plus rxq->headroom, passed to
+	 * page_pool_dma_sync_for_cpu().
+	 */
+	u32 dma_sync_offset;
 
 	/* SGL of the buffer going to be sent as part of the work request. */
 	u32 num_sge;
-- 
2.34.1


