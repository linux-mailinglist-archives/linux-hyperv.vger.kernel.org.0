Return-Path: <linux-hyperv+bounces-11900-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id J0zDDW/yUGqr8wIAu9opvQ
	(envelope-from <linux-hyperv+bounces-11900-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 10 Jul 2026 15:23:59 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BF2673B36D
	for <lists+linux-hyperv@lfdr.de>; Fri, 10 Jul 2026 15:23:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.microsoft.com header.s=default header.b=Y1YK4MIE;
	dmarc=pass (policy=none) header.from=linux.microsoft.com;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11900-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11900-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 00BA1300B52A
	for <lists+linux-hyperv@lfdr.de>; Fri, 10 Jul 2026 13:23:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3474C42E013;
	Fri, 10 Jul 2026 13:23:38 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3B754189C0;
	Fri, 10 Jul 2026 13:23:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783689818; cv=none; b=TOuMdNSLMFk8Vi5C+O08X1tJ9RLuqP4Bfmd10ZNWBprXJ57yTOv3pd6cdH8RYiLXdXiEsarwMA5EGVzafbg0+j1Wazk2wo7tBUqlifjSRrmAeGRgydes0rGtIttP3eVSEMAd8uWIF+0gT407vGSUk7ipndeWH8/CwAP5rHJd3vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783689818; c=relaxed/simple;
	bh=9nEljnZQeIIirhHTNpz60NxuDdzoP2cR3awIo0m0qxQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=MiWJZ3W/xY+kLWCwJuKZBYlx8BIw+YWS0pg5zcrelQjw9Kru9L+b1pC0fvT7nqI+S8XMmL7Ofnau6qeE/GZDV6jJgyxlSegxIOBNVgCcfg8j7bI+Jv098zBEXg+wWmPlgxNHinJ7wgvQssl1+P2tqA5Yy1YDiaW9C26/xL3oR1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Y1YK4MIE; arc=none smtp.client-ip=13.77.154.182
Received: by linux.microsoft.com (Postfix, from userid 1231)
	id 8AECB20B716F; Fri, 10 Jul 2026 06:23:30 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8AECB20B716F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1783689810;
	bh=tWadOobs0k+qwzIzGFvhW9CN/liX9HwGSzfTB/U2bxU=;
	h=From:To:Subject:Date:From;
	b=Y1YK4MIEkBtXg75v7xYxSCy2luRFY0oOTHEDKLa0wH5u9EjNWrKp+uHyZFySdxma8
	 ju3dSXE0Dg7JkNTG5Y6tBxNYXs1hJzv5yfW6aDebReW+Zwz3/4G/0/8MzPvHRLzkGj
	 Nsue5dmItZlTg+PJi06/Um2Af6e8/g4RAg7csQMY=
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
	kotaranov@microsoft.com,
	horms@kernel.org,
	ernis@linux.microsoft.com,
	dipayanroy@linux.microsoft.com,
	gargaditya@linux.microsoft.com,
	ssengar@linux.microsoft.com,
	gargaditya@microsoft.com,
	linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org
Subject: [PATCH net-next] net: mana: Add debug knob to skip TX timeout recovery reset
Date: Fri, 10 Jul 2026 06:22:29 -0700
Message-ID: <20260710132229.2851441-1-gargaditya@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[microsoft.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11900-lists,linux-hyperv=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[gargaditya@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:kys@microsoft.com,m:haiyangz@microsoft.com,m:wei.liu@kernel.org,m:decui@microsoft.com,m:longli@microsoft.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:kotaranov@microsoft.com,m:horms@kernel.org,m:ernis@linux.microsoft.com,m:dipayanroy@linux.microsoft.com,m:gargaditya@linux.microsoft.com,m:ssengar@linux.microsoft.com,m:gargaditya@microsoft.com,m:linux-hyperv@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gargaditya@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1BF2673B36D

Add a per-port debugfs boolean "tx_timeout_skip_reset" that, when
enabled, makes mana_tx_timeout() log the TX timeout and return without
queueing the per-port detach/attach recovery work.

This is a debug-only aid for bringup and qualification: skipping the
recovery reset keeps the device and queue state intact so a TX timeout
can be correlated with hardware telemetry. The knob defaults to false,
so production recovery behaviour is unchanged.

Signed-off-by: Aditya Garg <gargaditya@linux.microsoft.com>
Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
Reviewed-by: Dipayaan Roy <dipayanroy@linux.microsoft.com>
---
 drivers/net/ethernet/microsoft/mana/mana_en.c | 14 ++++++++++++++
 include/net/mana/mana.h                       |  3 +++
 2 files changed, 17 insertions(+)

diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index 89e7f59f635d..a8c329bdbacf 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -892,6 +892,17 @@ static void mana_tx_timeout(struct net_device *netdev, unsigned int txqueue)
 	struct mana_context *ac = apc->ac;
 	struct gdma_context *gc = ac->gdma_dev->gdma_context;
 
+	/* Debug knob for bringup/qualification: when set, log the timeout and
+	 * skip the reset so the failing state is preserved for telemetry.
+	 * Disabled by default; production behaviour is unchanged.
+	 */
+	if (READ_ONCE(apc->tx_timeout_skip_reset)) {
+		netdev_warn(netdev,
+			    "TX timeout on queue %u: reset skipped (tx_timeout_skip_reset enabled)\n",
+			    txqueue);
+		return;
+	}
+
 	/* Already in service, hence tx queue reset is not required.*/
 	if (test_bit(GC_IN_SERVICE, &gc->flags))
 		return;
@@ -3486,6 +3497,9 @@ static int mana_init_port(struct net_device *ndev)
 			   &apc->steer_cqe_coalescing);
 	debugfs_create_u32("current_speed", 0400, apc->mana_port_debugfs,
 			   &apc->speed);
+	debugfs_create_bool("tx_timeout_skip_reset", 0600,
+			    apc->mana_port_debugfs,
+			    &apc->tx_timeout_skip_reset);
 	return 0;
 
 reset_apc:
diff --git a/include/net/mana/mana.h b/include/net/mana/mana.h
index 226b61504596..4d041fb8437f 100644
--- a/include/net/mana/mana.h
+++ b/include/net/mana/mana.h
@@ -530,6 +530,9 @@ struct mana_port_context {
 	struct net_device *ndev;
 	struct work_struct queue_reset_work;
 
+	/* Debug knob to log TX timeout but skip recovery reset */
+	bool tx_timeout_skip_reset;
+
 	u8 mac_addr[ETH_ALEN];
 
 	struct mana_eq *eqs;
-- 
2.43.0


