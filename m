Return-Path: <linux-hyperv+bounces-11535-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id KzwcDAuZJmrAZQIAu9opvQ
	(envelope-from <linux-hyperv+bounces-11535-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 08 Jun 2026 12:27:23 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B2ED8655102
	for <lists+linux-hyperv@lfdr.de>; Mon, 08 Jun 2026 12:27:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.microsoft.com header.s=default header.b=joPArdp8;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11535-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11535-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.microsoft.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 717DD310D1AD
	for <lists+linux-hyperv@lfdr.de>; Mon,  8 Jun 2026 10:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1417E3BD63B;
	Mon,  8 Jun 2026 10:14:07 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9E6031327D;
	Mon,  8 Jun 2026 10:14:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780913647; cv=none; b=lfe7dl86/+qZJIxbg0MCqk99Zs8G8v4NU1EknhQLP3RDO+1yBSA3CriAxFmbcwqW4Z/Zua+EoCUwQkt5ctVgbttZ6dq3Y0i/PC4a1+APZgV8kJLmMScPq0YJPEr9gfLmL4pSZ9hpuL3Sj4f7vCKfSAveTLvp35rOuZ9E1NDwUlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780913647; c=relaxed/simple;
	bh=gC+onrXYGvy71kSebdmca8pRlTC0uWzgIwwWRfamJA8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PCJJVnuA9HwEGAyBIkf4tdLPW6GZzT5zFnX7cYoX/SYcmpp7hkq2mdj+ejY0bp+2YBHHzH8zV4q9dog8hJkdkmF9ppFm0Jj46bVWCAABtl4YEBX/OpF0OONX1MNHEHKSCzcXFFEjRQiOJAPFEZ8D0SK7gqvf1efgklVvL+b/M6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=joPArdp8; arc=none smtp.client-ip=13.77.154.182
Received: by linux.microsoft.com (Postfix, from userid 1231)
	id E0C0220B716B; Mon,  8 Jun 2026 03:13:47 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E0C0220B716B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1780913627;
	bh=trhabQE42+25m+BwIKSJ5YnDXkksfcD+tHqcjwGCLsY=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=joPArdp8YKKroAEhaNSmHzyT+frG4sQDIOAHgGTDvbHgo92DJn6P+GhtdDbAq8YoH
	 6uj7tFSnE3rBidRx/XXjPCIxPa7cwxpWXfAnoFtGxZJx3tuz+fzewhEmUTJTBtsuXu
	 +CTBzW5H/kh/MG6LleOGu1sawH+u2+H/qZpRj1gg=
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
	horms@kernel.org,
	shradhagupta@linux.microsoft.com,
	dipayanroy@linux.microsoft.com,
	ernis@linux.microsoft.com,
	kees@kernel.org,
	shacharr@microsoft.com,
	stephen@networkplumber.org,
	gargaditya@microsoft.com,
	gargaditya@linux.microsoft.com,
	ssengar@linux.microsoft.com,
	linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2 2/2] net: mana: guard TX wq object destroy with INVALID_MANA_HANDLE check
Date: Mon,  8 Jun 2026 03:13:41 -0700
Message-ID: <20260608101345.2267320-3-gargaditya@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260608101345.2267320-1-gargaditya@linux.microsoft.com>
References: <20260608101345.2267320-1-gargaditya@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11535-lists,linux-hyperv=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:kys@microsoft.com,m:haiyangz@microsoft.com,m:wei.liu@kernel.org,m:decui@microsoft.com,m:longli@microsoft.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:shradhagupta@linux.microsoft.com,m:dipayanroy@linux.microsoft.com,m:ernis@linux.microsoft.com,m:kees@kernel.org,m:shacharr@microsoft.com,m:stephen@networkplumber.org,m:gargaditya@microsoft.com,m:gargaditya@linux.microsoft.com,m:ssengar@linux.microsoft.com,m:linux-hyperv@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[gargaditya@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gargaditya@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,linux.microsoft.com:mid,linux.microsoft.com:from_mime,linux.microsoft.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B2ED8655102

mana_create_txq() has several error paths (after mana_alloc_queues() or
mana_create_wq_obj() failure) where tx_qp[i].tx_object stays as the
INVALID_MANA_HANDLE sentinel set at allocation. mana_destroy_txq() then
unconditionally calls mana_destroy_wq_obj() with (u64)-1, which firmware
rejects and logs an error.

Mirror the RX-side pattern in mana_destroy_rxq() and skip the destroy
when the handle is still INVALID_MANA_HANDLE.

Fixes: ca9c54d2d6a5 ("net: mana: Add a driver for Microsoft Azure Network Adapter (MANA)")
Signed-off-by: Aditya Garg <gargaditya@linux.microsoft.com>
Reviewed-by: Dipayaan Roy <dipayanroy@linux.microsoft.com>
Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
---
 drivers/net/ethernet/microsoft/mana/mana_en.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index c9b1df1ed109..d7de4c4d25bb 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -2334,7 +2334,8 @@ static void mana_destroy_txq(struct mana_port_context *apc)
 			netif_napi_del_locked(napi);
 			apc->tx_qp[i].txq.napi_initialized = false;
 		}
-		mana_destroy_wq_obj(apc, GDMA_SQ, apc->tx_qp[i].tx_object);
+		if (apc->tx_qp[i].tx_object != INVALID_MANA_HANDLE)
+			mana_destroy_wq_obj(apc, GDMA_SQ, apc->tx_qp[i].tx_object);
 
 		mana_deinit_cq(apc, &apc->tx_qp[i].tx_cq);
 
-- 
2.43.0


