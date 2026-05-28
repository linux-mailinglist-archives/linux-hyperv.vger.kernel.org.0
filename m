Return-Path: <linux-hyperv+bounces-11313-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qACWAoCFGGq6kggAu9opvQ
	(envelope-from <linux-hyperv+bounces-11313-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 28 May 2026 20:12:16 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C9B855F6222
	for <lists+linux-hyperv@lfdr.de>; Thu, 28 May 2026 20:12:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B96A130742F6
	for <lists+linux-hyperv@lfdr.de>; Thu, 28 May 2026 18:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD59C40800F;
	Thu, 28 May 2026 18:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Ha0wD8K+"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E5E1403E8E;
	Thu, 28 May 2026 18:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779991696; cv=none; b=K1LmYdOrQszGT9n6zbpvT+BaOfeBJO2Dg7EF3nlv5VFkt86snGzEmD6wk1gA/aX+E0TabsD3wR5Ihb0i2PMurmty7x9bryZwWr57C/lJio4cWGyy/q6FliebZ//eXlztm6aHVeDU0UsskXqPa4sIQgpj8qj3guVn0XoGOQedvas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779991696; c=relaxed/simple;
	bh=R0170DRurt5KznohmtGzjOoU03o4QnlFYT7pbNh0Mfc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=U3b3MfSesDmGOU8ydmDIu3e5LWpjlq9BndiMRn9uttdDavK5fpmBJ41WYz740fc0MP+qG3dDKwY3hZ38C9SLGNKrdr8FM+/AUDWheUBc2jFG2wPzTNTl5fgindSvnpHNr6wHqx73ZojEZbAfbSA4TwDXSps1P2KizbyPGJNoZOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Ha0wD8K+; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1173)
	id 4EFC620B7167; Thu, 28 May 2026 11:07:58 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4EFC620B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1779991678;
	bh=fmR34n8OOkEcXeaFsrYkS3bWekx70hrvA5+bSqAYTs4=;
	h=From:To:Subject:Date:From;
	b=Ha0wD8K+aRcYuKZoK5XXPNQbpCWAMoEP+bVpi8kt3UfiXApEI5reQFcZeg2Xw5WU3
	 h7OlrgXF3F0/p1BNLPLyr7Q5w8IqqZAgEYSrhDM3p3rEJIUhUNKsmbaD5+7iGF5cZY
	 BRJ7lhvs9UaRQp0sY76bhYL8aw4QkJA17O0qze98=
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
Subject: [PATCH net-next] net: mana: Cache MANA_QUERY_LINK_CONFIG result to avoid repeated HWC queries
Date: Thu, 28 May 2026 11:07:51 -0700
Message-ID: <20260528180757.1536640-1-ernis@linux.microsoft.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11313-lists,linux-hyperv=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ernis@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_TWELVE(0.00)[19];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,linux.microsoft.com:mid,linux.microsoft.com:dkim]
X-Rspamd-Queue-Id: C9B855F6222
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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

To prevent a concurrent mana_set_bw_clamp() from racing with an
in-flight query and publishing stale pre-clamp speed/max_speed,
serialize the firmware transaction and the cache update under a new
per-port mutex (link_cfg_mutex). The mutex covers both the HWC
request and the subsequent stores in mana_query_link_cfg(), and the
HWC request and invalidation in mana_set_bw_clamp(). With this lock
held, two queries can no longer interleave their speed/max_speed
stores, and an invalidation can no longer slip in between a query's
response and its publish.

Invalidate the cache inside mana_set_bw_clamp() on success, so all
current and future callers that change the link configuration
automatically trigger a fresh query on the next mana_query_link_cfg()
call. Also reset link_cfg_error during resume in mana_probe() under
link_cfg_mutex, so that any slow-path query already in flight cannot
later store 0 and silently overwrite the post-resume invalidation.

Signed-off-by: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
---
 drivers/net/ethernet/microsoft/mana/mana_en.c | 41 +++++++++++++++----
 include/net/mana/mana.h                       |  4 ++
 2 files changed, 36 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index 82f1461a48e9..43018bc13dc1 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -1456,6 +1456,12 @@ int mana_query_link_cfg(struct mana_port_context *apc)
 	struct mana_query_link_config_req req = {};
 	int err;
 
+	mutex_lock(&apc->link_cfg_mutex);
+
+	err = apc->link_cfg_error;
+	if (err <= 0)
+		goto out;
+
 	mana_gd_init_req_hdr(&req.hdr, MANA_QUERY_LINK_CONFIG,
 			     sizeof(req), sizeof(resp));
 
@@ -1468,10 +1474,11 @@ int mana_query_link_cfg(struct mana_port_context *apc)
 	if (err) {
 		if (err == -EOPNOTSUPP) {
 			netdev_info_once(ndev, "MANA_QUERY_LINK_CONFIG not supported\n");
-			return err;
+			apc->link_cfg_error = err;
+			goto out;
 		}
 		netdev_err(ndev, "Failed to query link config: %d\n", err);
-		return err;
+		goto out;
 	}
 
 	err = mana_verify_resp_hdr(&resp.hdr, MANA_QUERY_LINK_CONFIG,
@@ -1482,16 +1489,20 @@ int mana_query_link_cfg(struct mana_port_context *apc)
 			   resp.hdr.status);
 		if (!err)
 			err = -EOPNOTSUPP;
-		return err;
+		goto out;
 	}
 
 	if (resp.qos_unconfigured) {
 		err = -EINVAL;
-		return err;
+		goto out;
 	}
 	apc->speed = resp.link_speed_mbps;
 	apc->max_speed = resp.qos_speed_mbps;
-	return 0;
+	apc->link_cfg_error = 0;
+	err = 0;
+out:
+	mutex_unlock(&apc->link_cfg_mutex);
+	return err;
 }
 
 int mana_set_bw_clamp(struct mana_port_context *apc, u32 speed,
@@ -1508,17 +1519,19 @@ int mana_set_bw_clamp(struct mana_port_context *apc, u32 speed,
 	req.link_speed_mbps = speed;
 	req.enable_clamping = enable_clamping;
 
+	mutex_lock(&apc->link_cfg_mutex);
+
 	err = mana_send_request(apc->ac, &req, sizeof(req), &resp,
 				sizeof(resp));
 
 	if (err) {
 		if (err == -EOPNOTSUPP) {
 			netdev_info_once(ndev, "MANA_SET_BW_CLAMP not supported\n");
-			return err;
+			goto out;
 		}
 		netdev_err(ndev, "Failed to set bandwidth clamp for speed %u, err = %d",
 			   speed, err);
-		return err;
+		goto out;
 	}
 
 	err = mana_verify_resp_hdr(&resp.hdr, MANA_SET_BW_CLAMP,
@@ -1529,13 +1542,18 @@ int mana_set_bw_clamp(struct mana_port_context *apc, u32 speed,
 			   resp.hdr.status);
 		if (!err)
 			err = -EOPNOTSUPP;
-		return err;
+		goto out;
 	}
 
 	if (resp.qos_unconfigured)
 		netdev_info(ndev, "QoS is unconfigured\n");
 
-	return 0;
+	/* Invalidate the cache; next query will re-fetch from firmware. */
+	apc->link_cfg_error = 1;
+	err = 0;
+out:
+	mutex_unlock(&apc->link_cfg_mutex);
+	return err;
 }
 
 int mana_create_wq_obj(struct mana_port_context *apc,
@@ -3430,6 +3448,8 @@ static int mana_probe_port(struct mana_context *ac, int port_idx,
 	apc->port_handle = INVALID_MANA_HANDLE;
 	apc->pf_filter_handle = INVALID_MANA_HANDLE;
 	apc->port_idx = port_idx;
+	apc->link_cfg_error = 1;
+	mutex_init(&apc->link_cfg_mutex);
 	apc->cqe_coalescing_enable = 0;
 
 	mutex_init(&apc->vport_mutex);
@@ -3750,6 +3770,9 @@ int mana_probe(struct gdma_dev *gd, bool resuming)
 			rtnl_lock();
 			apc = netdev_priv(ac->ports[i]);
 			enable_work(&apc->queue_reset_work);
+			mutex_lock(&apc->link_cfg_mutex);
+			apc->link_cfg_error = 1;
+			mutex_unlock(&apc->link_cfg_mutex);
 			err = mana_attach(ac->ports[i]);
 			rtnl_unlock();
 			/* Log the port for which the attach failed, stop
diff --git a/include/net/mana/mana.h b/include/net/mana/mana.h
index d9c27310fd04..af772b7297ec 100644
--- a/include/net/mana/mana.h
+++ b/include/net/mana/mana.h
@@ -555,6 +555,10 @@ struct mana_port_context {
 	u32 speed;
 	/* Maximum speed supported by the SKU (mbps) */
 	u32 max_speed;
+	/* 1 = not queried, 0 = cached success, negative = permanent error */
+	int link_cfg_error;
+	/* Serializes mana_query_link_cfg() and mana_set_bw_clamp(). */
+	struct mutex link_cfg_mutex;
 
 	bool port_is_up;
 	bool port_st_save; /* Saved port state */
-- 
2.34.1


