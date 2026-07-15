Return-Path: <linux-hyperv+bounces-11982-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id r/DrCEb/Vmp8EAEAu9opvQ
	(envelope-from <linux-hyperv+bounces-11982-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 15 Jul 2026 05:32:22 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 643E875A4AF
	for <lists+linux-hyperv@lfdr.de>; Wed, 15 Jul 2026 05:32:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11982-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11982-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=microsoft.com (policy=reject);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6C0E73116FAC
	for <lists+linux-hyperv@lfdr.de>; Wed, 15 Jul 2026 03:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A8D33AD51C;
	Wed, 15 Jul 2026 03:30:12 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E1B63AB5B7;
	Wed, 15 Jul 2026 03:30:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784086211; cv=none; b=DorEQMxXN22eddcvZ4ggXGpEi84tIpUl/Ey9jpGsdvIM5h54+nWluZhWjYqFiTf/KNHGVXqpsUT8TU0AtLT22mngieDRvvgDDPV/SAk2vcrqfiLf9+VCYzgI+IOL+ssnjXfy1p5dB8U0VoZEeOIi8XyBjfEaatsRP+2nRG4ACJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784086211; c=relaxed/simple;
	bh=fW7MLrkN3fiIRL1AdvJb2iiQxx8j5Cs8dbZRl/K2E04=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fG1SOnrDb0DZUS4AfzLo8+nKK/Bapss67UAnhSmTTu3+tl+DcvMuNmBby3+vrwJkGZmREWNVF/Bd/m2t/vAnGSofyIpLD75pQgaYXQ9rJtzlSihuXAi2ulIA9B9LG5wiICiJLtrT/K4DtZqEwRLTfIHjkIWL6JdSe14Bolwa4e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; arc=none smtp.client-ip=13.77.154.182
Received: by linux.microsoft.com (Postfix, from userid 1202)
	id A379A20B716C; Tue, 14 Jul 2026 20:29:59 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A379A20B716C
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
Subject: [PATCH net-next 3/7] net: mana: free HWC comp_buf after destroying the EQ
Date: Tue, 14 Jul 2026 20:29:37 -0700
Message-ID: <20260715032942.3945317-4-longli@microsoft.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260715032942.3945317-1-longli@microsoft.com>
References: <20260715032942.3945317-1-longli@microsoft.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER(0.00)[longli@microsoft.com,linux-hyperv@vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:longli@microsoft.com,m:kotaranov@microsoft.com,m:kuba@kernel.org,m:davem@davemloft.net,m:pabeni@redhat.com,m:edumazet@google.com,m:andrew+netdev@lunn.ch,m:jgg@ziepe.ca,m:leon@kernel.org,m:haiyangz@microsoft.com,m:kys@microsoft.com,m:wei.liu@kernel.org,m:decui@microsoft.com,m:shradhagupta@linux.microsoft.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-hyperv@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	TAGGED_FROM(0.00)[bounces-11982-lists,linux-hyperv=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[longli@microsoft.com,linux-hyperv@vger.kernel.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FROM_HAS_DN(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 643E875A4AF

mana_hwc_destroy_cq() freed hwc_cq->comp_buf before destroying the CQ and
EQ.  comp_buf is dereferenced by mana_hwc_comp_event(), which the EQ
interrupt handler invokes; freeing it while the EQ was still registered
let a late handler touch freed memory.

Destroy the CQ and EQ first -- the EQ teardown deregisters the IRQ and
fences in-flight handlers -- then free comp_buf and hwc_cq.

Fixes: ca9c54d2d6a5 ("net: mana: Add a driver for Microsoft Azure Network Adapter (MANA)")
Signed-off-by: Long Li <longli@microsoft.com>
---
 drivers/net/ethernet/microsoft/mana/hw_channel.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/microsoft/mana/hw_channel.c b/drivers/net/ethernet/microsoft/mana/hw_channel.c
index 3f011ebbe7b3..2239fdeda57c 100644
--- a/drivers/net/ethernet/microsoft/mana/hw_channel.c
+++ b/drivers/net/ethernet/microsoft/mana/hw_channel.c
@@ -384,14 +384,20 @@ static void mana_hwc_comp_event(void *ctx, struct gdma_queue *q_self)
 
 static void mana_hwc_destroy_cq(struct gdma_context *gc, struct hwc_cq *hwc_cq)
 {
-	kfree(hwc_cq->comp_buf);
-
 	if (hwc_cq->gdma_cq)
 		mana_gd_destroy_queue(gc, hwc_cq->gdma_cq);
 
+	/* comp_buf is reached only by mana_hwc_comp_event(), which the
+	 * EQ handler invokes via cq_table[id].  The CQ destroy above
+	 * already cleared that slot and ran synchronize_rcu(), so no
+	 * handler can reach comp_buf once it returns.  Destroying the EQ
+	 * here additionally tears down the IRQ (defense in depth) before
+	 * comp_buf and hwc_cq are freed below.
+	 */
 	if (hwc_cq->gdma_eq)
 		mana_gd_destroy_queue(gc, hwc_cq->gdma_eq);
 
+	kfree(hwc_cq->comp_buf);
 	kfree(hwc_cq);
 }
 
-- 
2.43.0


