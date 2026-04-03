Return-Path: <linux-hyperv+bounces-9953-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gBBfKWpoz2lPwAYAu9opvQ
	(envelope-from <linux-hyperv+bounces-9953-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 03 Apr 2026 09:12:42 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 13A953919AB
	for <lists+linux-hyperv@lfdr.de>; Fri, 03 Apr 2026 09:12:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F251A30649F8
	for <lists+linux-hyperv@lfdr.de>; Fri,  3 Apr 2026 07:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95AF4372B31;
	Fri,  3 Apr 2026 07:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="o9ig9vVU"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64C2937106E;
	Fri,  3 Apr 2026 07:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775200210; cv=none; b=iiKZYx11kjknjNGt093FR61+3Hcztal2/Ue+RU/378PxjQ7LpxCZetvNM8GUnODYpFhe/dV9dikemIez/K3YEF8BBRqpWmbJlVQu2PdEH8Wo7PcW3Fa1IY/tef1LKi8oCcBa2hkMb8xUjkoZFkBISn2diKAo13d8JdK8v/tXxFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775200210; c=relaxed/simple;
	bh=ka/16DcRr7cSsRbNKmTcO1Wl7m1LVPWnzPAbSolk2x0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TbDg7jPKBt6VICZIXjYnuTqqQ0WBgcH0lhvh2nck4lNB+KNGfqWlLp6T0xE0ciQ5xvxMLFnu4PJiH2tX/7G1cFg03w7Mhq/Kr+IvHAsToaraXxsIreV8VB4mA6g8JN0B03Oz/yQLujMblDPEmx+y1OP/BXBTDRY9dtE5W79GVPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=o9ig9vVU; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1173)
	id 2662B20B6F01; Fri,  3 Apr 2026 00:10:09 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2662B20B6F01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1775200209;
	bh=MufsKhMKlNj+f76vqmh4y9HL9SJDhi76GV0bkj0a5O4=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=o9ig9vVUmK+8m8y+oD7axPdc6pchASjC2vmtZFkqRRgnY4Ytusg799dYV7o7FYRqh
	 yFgQppPD7AG72gbZstLtPsTthZyD04HYEoqemC9JB1hLHb9rKiHEki+h9JQXKtmLj+
	 fxOuOWfi27uP+MHM0htxnyH/So96sjRvJejUjRrA=
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
Subject: [PATCH net-next 3/4] net: mana: Don't overwrite port probe error with add_adev result
Date: Fri,  3 Apr 2026 00:09:42 -0700
Message-ID: <20260403070948.9225-4-ernis@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260403070948.9225-1-ernis@linux.microsoft.com>
References: <20260403070948.9225-1-ernis@linux.microsoft.com>
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
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-9953-lists,linux-hyperv=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ernis@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 13A953919AB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In mana_probe(), if mana_probe_port() fails for any port, the error
is stored in 'err' and the loop breaks. However, the subsequent
unconditional 'err = add_adev(gd, "eth")' overwrites this error.
If add_adev() succeeds, mana_probe() returns success despite ports
being left in a partially initialized state (ac->ports[i] == NULL).

Only call add_adev() when there is no prior error, so the probe
correctly fails and triggers mana_remove() cleanup.

Fixes: ced82fce77e9 ("net: mana: Probe rdma device in mana driver")
Signed-off-by: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
---
 drivers/net/ethernet/microsoft/mana/mana_en.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index f6ad46736418..1a141c46ac27 100644
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
+			 * Already-probed ports remain functional.
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
+			 * Already-attached ports remain functional.
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


