Return-Path: <linux-hyperv+bounces-10177-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +O9pK/NH32mFRQAAu9opvQ
	(envelope-from <linux-hyperv+bounces-10177-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 15 Apr 2026 10:10:27 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F2CF401BDC
	for <lists+linux-hyperv@lfdr.de>; Wed, 15 Apr 2026 10:10:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 17652303E2D3
	for <lists+linux-hyperv@lfdr.de>; Wed, 15 Apr 2026 08:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A54C43B0AEF;
	Wed, 15 Apr 2026 08:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="TK6JQBVx"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82F483CE4B3;
	Wed, 15 Apr 2026 08:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776240591; cv=none; b=JNMzulSQR6RPkACxmFmJAK7uVdYhz2/rFQfTgv7GzFi5ZHw6jQY7YNs/AQRo8vt0Lxrmf1nEj6oex9Em6XK+WmX5EmK4s7F+cSoFBTOgxZq3UV6mN+Bo+2q4HD3erw2vtCbCAH+e3pXaCe3o/fQ827vKko6yfMnyXKr5tJeUog8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776240591; c=relaxed/simple;
	bh=UJ1GEY5GoWkbM7DoTWg7Yau76nI63MmakyN1t3mDcNM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AQ4VqWCJGGubpquzgmRlDAEVjtLXQdChbL2aBujc0Itr+YQinBo1x6gPBrTy71cDoor0U8t+PGIPo/xskciN8UGGac+a8sXjMiQqcF/lKDhuLGsbLhdslDOzHin2IRc6hjOJD+jxT9o1gVcsUOb8gsW/uEwrRYzuhm4SDd2oW7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=TK6JQBVx; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1173)
	id 764F420B7017; Wed, 15 Apr 2026 01:09:48 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 764F420B7017
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1776240588;
	bh=U6Zg0MH0awSapYH4NtsgkQDL5z7isF9zF61w01KHq0c=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=TK6JQBVxzmuJvOQxRyeBxG0DJBcnHa7OSZReOmEZbg5aDFaK//vOUytkh/N6DQ5QL
	 6ozxhRB7234aXHxWPcSWiFUMS7VRRXJD/3fOEO5ZWGker9YnwI9yvs45XQkntgxPcr
	 GhGhcs3nWH5HpfF67CfJTO8c18bJJ4/49vtSpf+s=
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
Subject: [PATCH net v3 4/5] net: mana: Don't overwrite port probe error with add_adev result
Date: Wed, 15 Apr 2026 01:09:40 -0700
Message-ID: <20260415080944.732901-5-ernis@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260415080944.732901-1-ernis@linux.microsoft.com>
References: <20260415080944.732901-1-ernis@linux.microsoft.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10177-lists,linux-hyperv=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ernis@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	NEURAL_HAM(-0.00)[-0.993];
	RCPT_COUNT_TWELVE(0.00)[23];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linux.microsoft.com:dkim,linux.microsoft.com:mid]
X-Rspamd-Queue-Id: 4F2CF401BDC
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


