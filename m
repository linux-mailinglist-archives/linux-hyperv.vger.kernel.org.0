Return-Path: <linux-hyperv+bounces-11522-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id j/tWDqohJGoC3gEAu9opvQ
	(envelope-from <linux-hyperv+bounces-11522-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Sat, 06 Jun 2026 15:33:30 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 278EC64DA43
	for <lists+linux-hyperv@lfdr.de>; Sat, 06 Jun 2026 15:33:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.microsoft.com header.s=default header.b=C2IFoxsj;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11522-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11522-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.microsoft.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1BAC7300E91E
	for <lists+linux-hyperv@lfdr.de>; Sat,  6 Jun 2026 13:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57C823B3890;
	Sat,  6 Jun 2026 13:33:23 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 055553AFD19;
	Sat,  6 Jun 2026 13:33:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780752803; cv=none; b=L4xi+v2sN0uExZ2SGlQWr0va8fy49+8V6j4Z0jmDSmNV1bJZX08oNc6HUwn8COzWAe2oamenzKQb/naHJ2+2jg5xqjZn40FGtcBKocwRDAEw5dBPIsnb2Lp7qHhYzhprUUKDE9qlV0MttZkpJX5Gjig722TJiwelzofJjX1DdXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780752803; c=relaxed/simple;
	bh=DYHMfQyR2sTnIYoQ4BwT3L1UOEBgVV1FnGPDeBIplG8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=cTjGZmbM06Hsc6RWo99s7aq3/ynRKny4fn9dEtdjPWvAU/Ske1YJ+Ezc/JX/SDBhXeXe+zF9ih0X85TXXgBuu+3AkxQzAaUQvD78BVLxJqixnvN0vF+6hWv8aTVrUV2aHHUjjIELq7f6jrTnD6F4PuiQrs4jtBchTJeJwaWzM2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=C2IFoxsj; arc=none smtp.client-ip=13.77.154.182
Received: by linux.microsoft.com (Postfix, from userid 1173)
	id 0F3F520B716A; Sat,  6 Jun 2026 06:33:06 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0F3F520B716A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1780752786;
	bh=RJDiIch2cS/p2BsBvB6NuI4AyVbSC79DD0GQWUtLgBo=;
	h=From:To:Subject:Date:From;
	b=C2IFoxsjLhXvm5maLlS+rXeqNA37LjgJ/raoIhs1RBrZEtLm61NNVSAku/Xfan30/
	 GVeax45NzOLWC+7xcFluh80kt/a83y5nDaR/qor9ggucsmSAY5vTBHLnxyIfmjNwSB
	 R3zs5mGMPRL/JTo+S4G24BMKDEKnZTY3/fnBgh+c=
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
	kotaranov@microsoft.com,
	horms@kernel.org,
	ernis@linux.microsoft.com,
	dipayanroy@linux.microsoft.com,
	kees@kernel.org,
	linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org
Subject: [PATCH net-next v2] net: mana: Cache MANA_QUERY_LINK_CONFIG result to avoid repeated HWC queries
Date: Sat,  6 Jun 2026 06:32:55 -0700
Message-ID: <20260606133301.2180073-1-ernis@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11522-lists,linux-hyperv=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[ernis@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:kys@microsoft.com,m:haiyangz@microsoft.com,m:wei.liu@kernel.org,m:decui@microsoft.com,m:longli@microsoft.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:kotaranov@microsoft.com,m:horms@kernel.org,m:ernis@linux.microsoft.com,m:dipayanroy@linux.microsoft.com,m:kees@kernel.org,m:linux-hyperv@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ernis@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linux.microsoft.com:mid,linux.microsoft.com:from_mime,linux.microsoft.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 278EC64DA43

mana_query_link_cfg() sends an HWC command to firmware on every call,
but the link speed and QoS values it returns only change when the
driver explicitly calls mana_set_bw_clamp(). This function is called
not only by userspace via ethtool get_link_ksettings, but also
periodically by hv_netvsc through netvsc_get_link_ksettings and by
the sysfs speed_show attribute via dev_attr_show, resulting in
unnecessary HWC traffic every few minutes.

Add a link_cfg_error field to mana_port_context to cache the query
result. The field uses three states: 1 (not yet queried, initial
value set during mana_probe_port), 0 (success, speed/max_speed are
valid), or a negative errno for permanent errors like -EOPNOTSUPP
when the hardware does not support the command. Transient errors and
qos_unconfigured responses are not cached so that subsequent calls
will retry.

MANA is ops-locked because it implements net_shaper_ops, so the core
already takes netdev_lock() around all ethtool_ops and net_shaper_ops
entry points. Reuse that lock to serialize mana_query_link_cfg() and
mana_set_bw_clamp(). This prevents a concurrent mana_set_bw_clamp()
from racing with an in-flight query and publishing stale pre-clamp
speed/max_speed.

Invalidate the cache inside mana_set_bw_clamp() on success, so all
current and future callers that change the link configuration
automatically trigger a fresh query on the next mana_query_link_cfg()
call. Also reset link_cfg_error during resume in mana_probe() under
netdev_lock(), so that any query already in flight cannot later
store 0 and silently overwrite the post-resume invalidation.

Signed-off-by: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
---
Changes in v2:
* Use netdev_lock() instead of introducing new per-port mutex.
* Update commit message.
---
 drivers/net/ethernet/microsoft/mana/mana_en.c | 23 +++++++++++++++----
 include/net/mana/mana.h                       |  4 ++++
 2 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index db14357d3732..af2517a27aad 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -1456,6 +1456,12 @@ int mana_query_link_cfg(struct mana_port_context *apc)
 	struct mana_query_link_config_req req = {};
 	int err;
 
+	netdev_assert_locked(ndev);
+
+	err = apc->link_cfg_error;
+	if (err <= 0)
+		return err;
+
 	mana_gd_init_req_hdr(&req.hdr, MANA_QUERY_LINK_CONFIG,
 			     sizeof(req), sizeof(resp));
 
@@ -1468,6 +1474,7 @@ int mana_query_link_cfg(struct mana_port_context *apc)
 	if (err) {
 		if (err == -EOPNOTSUPP) {
 			netdev_info_once(ndev, "MANA_QUERY_LINK_CONFIG not supported\n");
+			apc->link_cfg_error = err;
 			return err;
 		}
 		netdev_err(ndev, "Failed to query link config: %d\n", err);
@@ -1485,12 +1492,12 @@ int mana_query_link_cfg(struct mana_port_context *apc)
 		return err;
 	}
 
-	if (resp.qos_unconfigured) {
-		err = -EINVAL;
-		return err;
-	}
+	if (resp.qos_unconfigured)
+		return -EINVAL;
+
 	apc->speed = resp.link_speed_mbps;
 	apc->max_speed = resp.qos_speed_mbps;
+	apc->link_cfg_error = 0;
 	return 0;
 }
 
@@ -1502,6 +1509,8 @@ int mana_set_bw_clamp(struct mana_port_context *apc, u32 speed,
 	struct net_device *ndev = apc->ndev;
 	int err;
 
+	netdev_assert_locked(ndev);
+
 	mana_gd_init_req_hdr(&req.hdr, MANA_SET_BW_CLAMP,
 			     sizeof(req), sizeof(resp));
 	req.vport = apc->port_handle;
@@ -1535,6 +1544,8 @@ int mana_set_bw_clamp(struct mana_port_context *apc, u32 speed,
 	if (resp.qos_unconfigured)
 		netdev_info(ndev, "QoS is unconfigured\n");
 
+	/* Invalidate the cache; next query will re-fetch from firmware. */
+	apc->link_cfg_error = 1;
 	return 0;
 }
 
@@ -3448,6 +3459,7 @@ static int mana_probe_port(struct mana_context *ac, int port_idx,
 	apc->port_handle = INVALID_MANA_HANDLE;
 	apc->pf_filter_handle = INVALID_MANA_HANDLE;
 	apc->port_idx = port_idx;
+	apc->link_cfg_error = 1;
 	apc->cqe_coalescing_enable = 0;
 
 	mutex_init(&apc->vport_mutex);
@@ -3768,6 +3780,9 @@ int mana_probe(struct gdma_dev *gd, bool resuming)
 			rtnl_lock();
 			apc = netdev_priv(ac->ports[i]);
 			enable_work(&apc->queue_reset_work);
+			netdev_lock(ac->ports[i]);
+			apc->link_cfg_error = 1;
+			netdev_unlock(ac->ports[i]);
 			err = mana_attach(ac->ports[i]);
 			rtnl_unlock();
 			/* Log the port for which the attach failed, stop
diff --git a/include/net/mana/mana.h b/include/net/mana/mana.h
index d9c27310fd04..2a45ff7211ef 100644
--- a/include/net/mana/mana.h
+++ b/include/net/mana/mana.h
@@ -555,6 +555,10 @@ struct mana_port_context {
 	u32 speed;
 	/* Maximum speed supported by the SKU (mbps) */
 	u32 max_speed;
+	/* 1 = not queried, 0 = cached success, negative = permanent error.
+	 * Protected by the netdev instance lock.
+	 */
+	int link_cfg_error;
 
 	bool port_is_up;
 	bool port_st_save; /* Saved port state */
-- 
2.34.1


