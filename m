Return-Path: <linux-hyperv+bounces-10521-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6OyGOtUZ82nNxAEAu9opvQ
	(envelope-from <linux-hyperv+bounces-10521-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 30 Apr 2026 10:59:01 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 47B7249F8D6
	for <lists+linux-hyperv@lfdr.de>; Thu, 30 Apr 2026 10:59:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4409830038E8
	for <lists+linux-hyperv@lfdr.de>; Thu, 30 Apr 2026 08:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A042F3FF89D;
	Thu, 30 Apr 2026 08:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="qeiMzR8Q"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB85B3FE362;
	Thu, 30 Apr 2026 08:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777539408; cv=none; b=tFm+AVlXC/QShxmI5/huGAzWhPlOqthgMBXwTJsW9wWRvh2CNK18i1BPjFhqURWR+roa+h3AX4vuQJkelOOKwhRWpp8wniYxgD9jXCMJsphImo7WMk6sSdZAWVqC7raYtzgT3VhGLO0XB1fxz5k3WB/K/oTPJI9n8RdANPABsn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777539408; c=relaxed/simple;
	bh=1sPYt3HYXlR9uuUgoaurUYFLplw2XmTOjZbCd7KtAL0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=nBoYJ1I11q/ihkUUKbrSiH9/TU5QNZ8+y43ph1RPElBXZc50HabU3VX/jxikIDiUlG4OpT0GaRAqBXKcv5Vzjq8xfu/2kTNSWUza27FZ5rEpw3nUNnNts4NMYFR+urwBxLPXN718wyRjnNsdTN0tCzD2CVkpG942OcKZQ4+yBUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=qeiMzR8Q; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1173)
	id 18F0120B7175; Thu, 30 Apr 2026 01:56:47 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 18F0120B7175
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1777539407;
	bh=AI7/huEcShjMtyvFXEkAKvAjjr5VrRcIU1qEYzuphIA=;
	h=From:To:Subject:Date:From;
	b=qeiMzR8QqZgNkiwvj3Q5m6i9J9uGzoMhwkoUZiNMcNpK2ogBoBpWJT5gnedGQfL0M
	 IZjSmLt9Opud+Sjajerqc8ZqdSSCGLMRSJz/qphRRpMtCWbBsEXEZXnHeks1BfbHmf
	 HYA02dWXfYOLt0csOtO/tJDrLXzmg5ziqUqZoa7o=
From: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
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
	ernis@linux.microsoft.com,
	dipayanroy@linux.microsoft.com,
	shirazsaleem@microsoft.com,
	kees@kernel.org,
	linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2] net: mana: hardening: Reject zero max_num_queues from MANA_QUERY_VPORT_CONFIG
Date: Thu, 30 Apr 2026 01:56:31 -0700
Message-ID: <20260430085638.1875400-1-ernis@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 47B7249F8D6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
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
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10521-lists,linux-hyperv=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ernis@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_TWELVE(0.00)[17];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.microsoft.com:dkim,linux.microsoft.com:mid]

As a part of MANA hardening for CVM, validate that max_num_sq and
max_num_rq returned by MANA_QUERY_VPORT_CONFIG are not zero. These
values flow into apc->num_queues, which is used as an allocation count
and loop bound. A zero value would result in zero-size allocations and
incorrect driver behavior.

Return -EPROTO if either value is zero.

Signed-off-by: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
---
Changes in v2:
* Rebase to latest main.
---
 drivers/net/ethernet/microsoft/mana/mana_en.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index a654b3699c4c..7c83e010a1e6 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -1262,6 +1262,12 @@ static int mana_query_vport_cfg(struct mana_port_context *apc, u32 vport_index,
 
 	*max_sq = resp.max_num_sq;
 	*max_rq = resp.max_num_rq;
+
+	if (*max_sq == 0 || *max_rq == 0) {
+		netdev_err(apc->ndev, "Invalid max queues from vPort config\n");
+		return -EPROTO;
+	}
+
 	if (resp.num_indirection_ent > 0 &&
 	    resp.num_indirection_ent <= MANA_INDIRECT_TABLE_MAX_SIZE &&
 	    is_power_of_2(resp.num_indirection_ent)) {
-- 
2.34.1


