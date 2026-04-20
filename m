Return-Path: <linux-hyperv+bounces-10213-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eO2QDh8h5mkMsAEAu9opvQ
	(envelope-from <linux-hyperv+bounces-10213-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 20 Apr 2026 14:50:39 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BC47542AF47
	for <lists+linux-hyperv@lfdr.de>; Mon, 20 Apr 2026 14:50:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1C20830ABEBB
	for <lists+linux-hyperv@lfdr.de>; Mon, 20 Apr 2026 12:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97E8F3A1A2D;
	Mon, 20 Apr 2026 12:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="W1mjUhKb"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31A753A0E8D;
	Mon, 20 Apr 2026 12:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776689267; cv=none; b=U/x8E93+ArwLdm9z54/ylrSzuP7faughqJLMYsv80hBOR/+ml71qLB86U6hNnls5kzzQa2oVvV2tuGI08eXaYXpap9CW9ydRq5tQcD0DrCiu6fw6KYX35n1Na1G5f4KQ3ZbBNvIUgDKuFFmOL1WSFsO6CgFytVzUR0vG+rcSvwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776689267; c=relaxed/simple;
	bh=JoFyREzAfqWaZRB+hT/pnwcuUYGr++uNWRMaFBD91YM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jeSW1DuLQvdDK2VkW6xLOnnHZZAavxnpGzd3KPMXr974vcAROHrPzfIHgG4NlaiBIv8ZcdixoGmTDHg0W2GgskPRr1XI3i2gBwG3Dts6koTgvfA8fCvfpeEfGv28zQOMg5mLpTo7f1xxqhbvIFNBFCHFXYDM+AEtGgOnIVQWOUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=W1mjUhKb; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1173)
	id 773B120B6F15; Mon, 20 Apr 2026 05:47:46 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 773B120B6F15
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1776689266;
	bh=q77hvq8saWy7ehASOs50PUvy+3CKFGHadE9ZY8Tf360=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=W1mjUhKbSP08vqetXVc8wQVker8PbMgpZrdz4mT5pqbhOOXNeGJYVgq9rRNpF+aKR
	 NVYJZhQJb0pTLx62QCFhcL09T3VOuKdfNI5/yyoHI5nfeE3onw3VjO7STWQWEx0ekA
	 PuOzbD4IuAm9EcT7N5sI+Fj/dpDku+g5DpPWPUWM=
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
	ssengar@linux.microsoft.com,
	dipayanroy@linux.microsoft.com,
	gargaditya@linux.microsoft.com,
	shirazsaleem@microsoft.com,
	kees@kernel.org,
	kotaranov@microsoft.com,
	leon@kernel.org,
	shacharr@microsoft.com,
	stephen@networkplumber.org,
	linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v4 4/5] net: mana: Don't overwrite port probe error with add_adev result
Date: Mon, 20 Apr 2026 05:47:38 -0700
Message-ID: <20260420124741.1056179-5-ernis@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260420124741.1056179-1-ernis@linux.microsoft.com>
References: <20260420124741.1056179-1-ernis@linux.microsoft.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2600:3c0a:e001:db::12fc:5321:from];
	TAGGED_FROM(0.00)[bounces-10213-lists,linux-hyperv=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ernis@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	TO_DN_NONE(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[100.90.174.1:received,13.77.154.182:received];
	NEURAL_HAM(-0.00)[-0.994];
	RCPT_COUNT_TWELVE(0.00)[23];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.microsoft.com:dkim,linux.microsoft.com:mid]
X-Rspamd-Queue-Id: BC47542AF47
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In mana_probe(), if mana_probe_port() fails for any port, the error
is stored in 'err' and the loop breaks. However, the subsequent
unconditional 'err = add_adev(gd, "eth")' overwrites this error.
If add_adev() succeeds, mana_probe() returns success despite ports
being left in a partially initialized state (ac->ports[i] == NULL).

Only call add_adev() when there is no prior error, so the probe
correctly fails and triggers mana_remove() cleanup.

Fixes: a69839d4327d ("net: mana: Add support for auxiliary device")
Signed-off-by: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
---
Changes in v4:
* Update Fixes tag to a69839d4327d.
Changes in v3:
*  Fix inaccurate comments.
Changes in v2:
* Apply the patch in net instead of net-next.
---
 drivers/net/ethernet/microsoft/mana/mana_en.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index ce1b7ec46a27..39b18577fb51 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -3680,10 +3680,9 @@ int mana_probe(struct gdma_dev *gd, bool resuming)
 	if (!resuming) {
 		for (i = 0; i < ac->num_ports; i++) {
 			err = mana_probe_port(ac, i, &ac->ports[i]);
-			/* we log the port for which the probe failed and stop
-			 * probes for subsequent ports.
-			 * Note that we keep running ports, for which the probes
-			 * were successful, unless add_adev fails too
+			/* Log the port for which the probe failed, stop probing
+			 * subsequent ports, and skip add_adev.
+			 * mana_remove() will clean up already-probed ports.
 			 */
 			if (err) {
 				dev_err(dev, "Probe Failed for port %d\n", i);
@@ -3697,10 +3696,9 @@ int mana_probe(struct gdma_dev *gd, bool resuming)
 			enable_work(&apc->queue_reset_work);
 			err = mana_attach(ac->ports[i]);
 			rtnl_unlock();
-			/* we log the port for which the attach failed and stop
-			 * attach for subsequent ports
-			 * Note that we keep running ports, for which the attach
-			 * were successful, unless add_adev fails too
+			/* Log the port for which the attach failed, stop
+			 * attaching subsequent ports, and skip add_adev.
+			 * mana_remove() will clean up already-attached ports.
 			 */
 			if (err) {
 				dev_err(dev, "Attach Failed for port %d\n", i);
@@ -3709,7 +3707,8 @@ int mana_probe(struct gdma_dev *gd, bool resuming)
 		}
 	}
 
-	err = add_adev(gd, "eth");
+	if (!err)
+		err = add_adev(gd, "eth");
 
 	schedule_delayed_work(&ac->gf_stats_work, MANA_GF_STATS_PERIOD);
 
-- 
2.34.1


