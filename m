Return-Path: <linux-hyperv+bounces-11481-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id kVPUJC8yIWrpAQEAu9opvQ
	(envelope-from <linux-hyperv+bounces-11481-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 04 Jun 2026 10:07:11 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0579A63DD85
	for <lists+linux-hyperv@lfdr.de>; Thu, 04 Jun 2026 10:07:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.microsoft.com header.s=default header.b=WCdFTXs+;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11481-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11481-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.microsoft.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C206D30816E9
	for <lists+linux-hyperv@lfdr.de>; Thu,  4 Jun 2026 08:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 253F93939D2;
	Thu,  4 Jun 2026 08:02:00 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA0F537105A;
	Thu,  4 Jun 2026 08:01:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780560120; cv=none; b=kEOx6fp4p0c8vdBU1DK8uM7ORN9pq/Uy0dqhSua+/EYhbEDegVJ76IZpc/EVXkSKcHPR/gvHzUs+zQj9DkIPGTMFYeWOhifN0ZufVTbwbDP/RC/f4FYQCuzu8ywoV4jSaONaM9MDxj4W8YDPZzjnrx9b5YBtiSB2xXx33EEWf3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780560120; c=relaxed/simple;
	bh=3dP7tSKE777SpeJjpcqFKvadQN1HE9zy/yv1fQvLeRA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t4kZm/p9KokhQKCGzfNS196xt2x6D8Pa+UxuEVd6mTz04Rp70oebffnNEnC9cZ9k2RDE6Ez4bwx3vWmECGl6BIn7EbWBaDZaIfmtf6jNAiqUvS29hmzX7TiXy+epaME4g3UFuLtTysRu70dQrl6FN61ie7n1eZ03euezP82Avt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=WCdFTXs+; arc=none smtp.client-ip=13.77.154.182
Received: by linux.microsoft.com (Postfix, from userid 1231)
	id 405EF20B716D; Thu,  4 Jun 2026 01:01:43 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 405EF20B716D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1780560103;
	bh=XPoYNCGvDJaTicqaJgBWKLcSrkwnst8h0cS85WM1Ij0=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=WCdFTXs+lyRejL+5qYa1V89vD2RW8wbzfBoWMXa9BY1QBTiKbCukS+ZmwUto+9bAy
	 PXalcoeGi7lmTksMy5khgdXF0QLj1iEoLA9TresXJydw6DDMJUdHkuLZ5OZOv2Un2j
	 RjXAN+K269VUicXaQc4iHsGJMH5R97V/M8dHTp7o=
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
Subject: [PATCH net 2/2] net: mana: guard TX wq object destroy with INVALID_MANA_HANDLE check
Date: Thu,  4 Jun 2026 01:01:26 -0700
Message-ID: <20260604080137.1995269-3-gargaditya@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260604080137.1995269-1-gargaditya@linux.microsoft.com>
References: <20260604080137.1995269-1-gargaditya@linux.microsoft.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11481-lists,linux-hyperv=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[gargaditya@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:kys@microsoft.com,m:haiyangz@microsoft.com,m:wei.liu@kernel.org,m:decui@microsoft.com,m:longli@microsoft.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:shradhagupta@linux.microsoft.com,m:dipayanroy@linux.microsoft.com,m:ernis@linux.microsoft.com,m:kees@kernel.org,m:shacharr@microsoft.com,m:stephen@networkplumber.org,m:gargaditya@microsoft.com,m:gargaditya@linux.microsoft.com,m:ssengar@linux.microsoft.com,m:linux-hyperv@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0579A63DD85

mana_create_txq() has several error paths (after mana_alloc_queues() or
mana_create_wq_obj() failure) where tx_qp[i]->tx_object stays as the
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
index db14357d3732..4a2cd800111e 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -2351,7 +2351,8 @@ static void mana_destroy_txq(struct mana_port_context *apc)
 			netif_napi_del_locked(napi);
 			apc->tx_qp[i]->txq.napi_initialized = false;
 		}
-		mana_destroy_wq_obj(apc, GDMA_SQ, apc->tx_qp[i]->tx_object);
+		if (apc->tx_qp[i]->tx_object != INVALID_MANA_HANDLE)
+			mana_destroy_wq_obj(apc, GDMA_SQ, apc->tx_qp[i]->tx_object);
 
 		mana_deinit_cq(apc, &apc->tx_qp[i]->tx_cq);
 
-- 
2.43.0


