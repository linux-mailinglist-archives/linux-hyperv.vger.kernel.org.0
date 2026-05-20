Return-Path: <linux-hyperv+bounces-11046-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kEqoBLlDDWpavQUAu9opvQ
	(envelope-from <linux-hyperv+bounces-11046-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 20 May 2026 07:16:41 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A54A7587B84
	for <lists+linux-hyperv@lfdr.de>; Wed, 20 May 2026 07:16:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D433430309BE
	for <lists+linux-hyperv@lfdr.de>; Wed, 20 May 2026 05:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 597AC2C11E6;
	Wed, 20 May 2026 05:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="FnsZo2tF"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 163BD13777E;
	Wed, 20 May 2026 05:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779254198; cv=none; b=JCP8XIIPwVoxJ7KIkXCRumJwHR+31C2NHZ/mDc+0MQBRvkVu47Z6euxljJOF1q3se+mxM4H6oZUwzqm7Kzt5tL7zkiBxOWJdn2D8+bwLGxDsI6bPeQy5HhOYijED58Ye9L+6JkDuaJcCPXfBQSwrz2fLBlXZvWKng7ie6vIlwDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779254198; c=relaxed/simple;
	bh=WdHn3d15Hkz8jqlTvANknw9uJkaUxvxceLOycR7Dp2g=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=FgZQyYEsF6f8/pHI7wD6TzxT1yIvJFpBAahBhGjRKFleLEj8gGPQX4tGKCroPdC5DypRSeVuJXscsBvE1jkCAXlBrsXpC3QirgwiLDtHkh7IOGEOnXFJ53zxchoKZhrKVnXh2XT0yAt6fEd6GP1vUYKTd3hCwNX1pVxIOqMBEp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=FnsZo2tF; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1231)
	id 6A79220B7167; Tue, 19 May 2026 22:16:30 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6A79220B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1779254190;
	bh=DrE/i6ZKMO2plCD1vGlbCRDqcx0o7vgWo+LSfk9jo4Q=;
	h=From:To:Subject:Date:From;
	b=FnsZo2tFtNULL5EJjIwiV5SaC9iSn1x/cCQ+cbak0fXiz0bGreOD74UT61hcvpqBc
	 /7/uDeAl2TQPPoe19ZsXyL1uOKj1wgOZlkqxh8gatjBXt7Fs3K0kRTkVkEYssZTgIv
	 iNKPuN1BxZ22V29mp8S5r3eXqYbKxNNppXV1YtK4=
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
	dipayanroy@linux.microsoft.com,
	horms@kernel.org,
	ernis@linux.microsoft.com,
	gargaditya@linux.microsoft.com,
	gargaditya@microsoft.com,
	kees@kernel.org,
	stephen@networkplumber.org,
	shacharr@microsoft.com,
	ssengar@linux.microsoft.com,
	linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] net: mana: validate rx_req_idx to prevent out-of-bounds array access
Date: Tue, 19 May 2026 22:15:53 -0700
Message-ID: <20260520051553.857120-1-gargaditya@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11046-lists,linux-hyperv=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gargaditya@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_TWELVE(0.00)[22];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.microsoft.com:mid,linux.microsoft.com:dkim]
X-Rspamd-Queue-Id: A54A7587B84
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In mana_hwc_rx_event_handler(), rx_req_idx is derived from
sge->address in DMA-coherent memory. In Confidential VMs
(SEV-SNP/TDX), this memory is shared unencrypted and HW can modify
WQE contents at any time. No bounds check exists on rx_req_idx,
which can lead to an out-of-bounds access into reqs[].

Add bounds check on rx_req_idx in mana_hwc_rx_event_handler() before
using it to index the reqs[] array.

Fixes: ca9c54d2d6a5 ("net: mana: Add a driver for Microsoft Azure Network Adapter (MANA)")
Signed-off-by: Aditya Garg <gargaditya@linux.microsoft.com>
Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
---
 drivers/net/ethernet/microsoft/mana/hw_channel.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/microsoft/mana/hw_channel.c b/drivers/net/ethernet/microsoft/mana/hw_channel.c
index dbbde0fa57e7..a60f733d1a07 100644
--- a/drivers/net/ethernet/microsoft/mana/hw_channel.c
+++ b/drivers/net/ethernet/microsoft/mana/hw_channel.c
@@ -266,6 +266,12 @@ static void mana_hwc_rx_event_handler(void *ctx, u32 gdma_rxq_id,
 	rq_base_addr = hwc_rxq->msg_buf->mem_info.dma_handle;
 	rx_req_idx = (sge->address - rq_base_addr) / hwc->max_req_msg_size;
 
+	if (rx_req_idx >= hwc_rxq->msg_buf->num_reqs) {
+		dev_err(hwc->dev, "HWC RX: wrong rx_req_idx=%llu, num_reqs=%u\n",
+			rx_req_idx, hwc_rxq->msg_buf->num_reqs);
+		return;
+	}
+
 	rx_req = &hwc_rxq->msg_buf->reqs[rx_req_idx];
 	resp = (struct gdma_resp_hdr *)rx_req->buf_va;
 
-- 
2.43.0


