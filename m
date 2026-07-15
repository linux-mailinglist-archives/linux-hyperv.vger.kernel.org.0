Return-Path: <linux-hyperv+bounces-11984-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id wDHANgv/VmpoEAEAu9opvQ
	(envelope-from <linux-hyperv+bounces-11984-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 15 Jul 2026 05:31:23 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ED3475A48F
	for <lists+linux-hyperv@lfdr.de>; Wed, 15 Jul 2026 05:31:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11984-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11984-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=microsoft.com (policy=reject);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9C41A3061D58
	for <lists+linux-hyperv@lfdr.de>; Wed, 15 Jul 2026 03:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1DF63AF66D;
	Wed, 15 Jul 2026 03:30:22 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D895D3ACEE0;
	Wed, 15 Jul 2026 03:30:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784086220; cv=none; b=BOWaViRIfLO2gTewG/NUrsWSTwU6JTDgmQB7tFBozimS8pHti3yBb6IF89urYiTsXTmVd3BYpjNcpdY2LM4fZ5TI8gdXgPlPQiCnNqu1RPyiyJOWNqvKOlzkzSavZNmvHvtqVhqhK0exlCj97wWxKXsW6wb6AfxCorEexPmdoqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784086220; c=relaxed/simple;
	bh=VsixF+qnTTCLETMM5CI39ot8RDAO0bs0NG4gHjgFEoQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=elK7Yn4lRSeALXJnNxeswXtKS1XQIMQdsCEeCICqtidoYExU/BZNLAC69P2vmWSCFvEZI2hUS3iyrW5LkZzp98/kObEAxndWiBoa78yI3Eihdi40+jl6dhBQ7wLEjCRU8wa0pV9d5d93xjEev/tvrfMwZAuGUiV9v1mya14lvQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; arc=none smtp.client-ip=13.77.154.182
Received: by linux.microsoft.com (Postfix, from userid 1202)
	id 7223420B7168; Tue, 14 Jul 2026 20:30:00 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7223420B7168
From: Long Li <longli@microsoft.com>
To: Long Li <longli@microsoft.com>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	"K . Y . Srinivasan" <kys@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	shradhagupta@linux.microsoft.com,
	Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 4/7] net: mana: validate hardware-supplied values in the HWC RX path
Date: Tue, 14 Jul 2026 20:29:38 -0700
Message-ID: <20260715032942.3945317-5-longli@microsoft.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260715032942.3945317-1-longli@microsoft.com>
References: <20260715032942.3945317-1-longli@microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [3.04 / 15.00];
	DMARC_POLICY_REJECT(2.00)[microsoft.com : SPF not aligned (relaxed), No valid DKIM,reject];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11984-lists,linux-hyperv=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:longli@microsoft.com,m:kotaranov@microsoft.com,m:kuba@kernel.org,m:davem@davemloft.net,m:pabeni@redhat.com,m:edumazet@google.com,m:andrew+netdev@lunn.ch,m:jgg@ziepe.ca,m:leon@kernel.org,m:haiyangz@microsoft.com,m:kys@microsoft.com,m:wei.liu@kernel.org,m:decui@microsoft.com,m:shradhagupta@linux.microsoft.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-hyperv@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[longli@microsoft.com,linux-hyperv@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[longli@microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4ED3475A48F

mana_hwc_rx_event_handler() and mana_hwc_handle_resp() consumed lengths
and indices taken straight from device DMA without validation.  A buggy
firmware or a malicious host (in a confidential VM, where the DMA buffer
is shared) could drive a wrong or reused in-flight request to completion
or index out of bounds.  Validate before use:

  - match the SGE address against the address the driver posted for that
    slot, not just an in-range index -- an in-range but wrong SGE would
    otherwise truncate onto a neighbouring slot and read a stale response;
  - require the response to cover a full gdma_resp_hdr before reading
    hwc_msg_id, so a short response cannot complete a slot with stale
    bytes left by the buffer's previous occupant;
  - bounds-check hwc_msg_id in mana_hwc_handle_resp() before indexing the
    inflight bitmap and caller_ctx;
  - reject a resp_len larger than the RX buffer.

Repost the RX WQE on every validation early-return so a rejected response
does not permanently shrink the posted RQ depth.  The one path that
cannot identify the slot (SGE mismatch) intentionally leaks a single WQE
rather than risk reposting the wrong one.

Fixes: ca9c54d2d6a5 ("net: mana: Add a driver for Microsoft Azure Network Adapter (MANA)")
Signed-off-by: Long Li <longli@microsoft.com>
---
 .../net/ethernet/microsoft/mana/hw_channel.c  | 58 +++++++++++++++++--
 1 file changed, 54 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/microsoft/mana/hw_channel.c b/drivers/net/ethernet/microsoft/mana/hw_channel.c
index 2239fdeda57c..68236727aee8 100644
--- a/drivers/net/ethernet/microsoft/mana/hw_channel.c
+++ b/drivers/net/ethernet/microsoft/mana/hw_channel.c
@@ -83,6 +83,17 @@ static void mana_hwc_handle_resp(struct hw_channel_context *hwc, u32 resp_len,
 	struct hwc_caller_ctx *ctx;
 	int err;
 
+	/* Validate msg_id is in range before using it to index bitmap
+	 * and caller_ctx array.  Malicious firmware could send
+	 * out-of-range msg_id causing out-of-bounds access.
+	 */
+	if (msg_id >= hwc->num_inflight_msg) {
+		dev_err(hwc->dev, "hwc_rx: msg_id %u >= max %u\n",
+			msg_id, hwc->num_inflight_msg);
+		mana_hwc_post_rx_wqe(hwc->rxq, rx_req);
+		return;
+	}
+
 	if (!test_bit(msg_id, hwc->inflight_msg_res.map)) {
 		dev_err(hwc->dev, "hwc_rx: invalid msg_id = %u\n", msg_id);
 		mana_hwc_post_rx_wqe(hwc->rxq, rx_req);
@@ -90,6 +101,18 @@ static void mana_hwc_handle_resp(struct hw_channel_context *hwc, u32 resp_len,
 	}
 
 	ctx = hwc->caller_ctx + msg_id;
+
+	/* Reject responses larger than the RX DMA buffer — the SGE
+	 * limits what hardware can DMA, so an oversized resp_len
+	 * indicates a firmware bug.  Fail rather than silently
+	 * truncating.
+	 */
+	if (resp_len > rx_req->buf_len) {
+		dev_err(hwc->dev, "HWC RX: resp_len %u > buf_len %u\n",
+			resp_len, rx_req->buf_len);
+		resp_len = 0;
+	}
+
 	err = mana_hwc_verify_resp_msg(ctx, resp_msg, resp_len);
 	if (err)
 		goto out;
@@ -261,19 +284,45 @@ static void mana_hwc_rx_event_handler(void *ctx, u32 gdma_rxq_id,
 
 	sge = (struct gdma_sge *)(wqe + 8 + dma_oob->inline_oob_size_div4 * 4);
 
-	/* Select the RX work request for virtual address and for reposting. */
+	/* Recover the originating RX slot from the SGE address.  Of the three
+	 * terms here only sge->address lives in device-accessible RQ memory;
+	 * rq_base_addr and max_resp_msg_size are driver-private constants.  An
+	 * in-range but wrong/unaligned SGE (corrupted WQE, or a malicious host
+	 * in a CVM) would otherwise truncate onto a neighbouring slot, letting
+	 * us read a stale response that could complete the wrong, reused
+	 * in-flight request.  Require the index to be in range AND the address
+	 * to exactly match the value the driver posted for that slot.
+	 */
 	rq_base_addr = hwc_rxq->msg_buf->mem_info.dma_handle;
 	rx_req_idx = (sge->address - rq_base_addr) / hwc->max_resp_msg_size;
 
-	if (rx_req_idx >= hwc_rxq->msg_buf->num_reqs) {
-		dev_err(hwc->dev, "HWC RX: wrong rx_req_idx=%llu, num_reqs=%u\n",
-			rx_req_idx, hwc_rxq->msg_buf->num_reqs);
+	if (rx_req_idx >= hwc_rxq->queue_depth ||
+	    sge->address != (u64)hwc_rxq->msg_buf->reqs[rx_req_idx].buf_sge_addr) {
+		/* Cannot trust which WQE this is, so we cannot safely repost
+		 * it; leak one RX WQE and bail.  This permanently leaks one
+		 * RX WQE but indicates a corrupted SGE from hardware (or host
+		 * tampering), which is an unrecoverable device error.
+		 */
+		dev_err(hwc->dev, "HWC RX: invalid SGE address %llx (idx=%llu)\n",
+			sge->address, rx_req_idx);
 		return;
 	}
 
 	rx_req = &hwc_rxq->msg_buf->reqs[rx_req_idx];
 	resp = (struct gdma_resp_hdr *)rx_req->buf_va;
 
+	/* Validate resp_len covers the response header before reading
+	 * hwc_msg_id.  A short response leaves stale data from the
+	 * previous buffer occupant, which could match a live slot and
+	 * complete the wrong request.
+	 */
+	if (rx_oob->tx_oob_data_size < sizeof(*resp)) {
+		dev_err(hwc->dev, "HWC RX: short resp_len=%u\n",
+			rx_oob->tx_oob_data_size);
+		mana_hwc_post_rx_wqe(hwc_rxq, rx_req);
+		return;
+	}
+
 	/* Read msg_id once from DMA buffer to prevent TOCTOU:
 	 * DMA memory is shared/unencrypted in CVMs - host can
 	 * modify it between reads.
@@ -281,6 +330,7 @@ static void mana_hwc_rx_event_handler(void *ctx, u32 gdma_rxq_id,
 	msg_id = READ_ONCE(resp->response.hwc_msg_id);
 	if (msg_id >= hwc->num_inflight_msg) {
 		dev_err(hwc->dev, "HWC RX: wrong msg_id=%u\n", msg_id);
+		mana_hwc_post_rx_wqe(hwc_rxq, rx_req);
 		return;
 	}
 
-- 
2.43.0


