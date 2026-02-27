Return-Path: <linux-hyperv+bounces-9024-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4O5FBGNmoWkJsgQAu9opvQ
	(envelope-from <linux-hyperv+bounces-9024-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 27 Feb 2026 10:39:47 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A8CC1B575E
	for <lists+linux-hyperv@lfdr.de>; Fri, 27 Feb 2026 10:39:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 517E8301468D
	for <lists+linux-hyperv@lfdr.de>; Fri, 27 Feb 2026 09:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 633A838BF63;
	Fri, 27 Feb 2026 09:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="SEiXN4xt"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E8AC3659EB;
	Fri, 27 Feb 2026 09:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772185160; cv=none; b=PPLfDFdnzJFldJJ+qY5QCG6RY3PlWnWCc26UYyQEtFwRUXYjwWP3+NE+WLYyZ//q6ONgsrumpth2B9+nF/VyAf8IXcDnAI/UOuxr8xVVQW3lsYY5otN1zmshRxZwRtb+xh+lDcwwjJPkNBmhJ/ADEgNEH+JBSrI/WIaMYP3tOAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772185160; c=relaxed/simple;
	bh=yz71I/S3RGvFKTDcwXAzrfDEXuaBQRtovTGS4adH3zI=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=XIwgXP/q6nar1vq/HXboXdkz/SqiBlzBBRDIthQvVnfu7WZ6DoJRG9pZkdEA4K90PKpiyI+skCMiK5VDzhfCf7wW2ASKxTXmcw1OQiNUatrrn7SfouH1qZdZ1n70vIVL0gwRuNXJXnJpjInS3HF8GMGAHR/rWldI+E9I8RJqqp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=SEiXN4xt; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1204)
	id D534F20B6F02; Fri, 27 Feb 2026 01:39:18 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D534F20B6F02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1772185158;
	bh=fgx6Wjns7RaGAYZDVzu9z9eNlmFuuvbMsQaWXWwZwOc=;
	h=Date:From:To:Subject:From;
	b=SEiXN4xttaniZpzSQSIzw3D5fcmkZp7z+jMchi/rBxq/7RUO7cPSUQZDycIJYzuzH
	 mIu+JtqKM8B4eUVZqWlOaLWQgDf1Z9zr0jpv6rhpnU4dsZWLw+H7pzLG+NbtExoghh
	 MJJpXZjyDYC39O4gfCgU4ZHwUAlSuWBAwp/4K1/4=
Date: Fri, 27 Feb 2026 01:39:18 -0800
From: Dipayaan Roy <dipayanroy@linux.microsoft.com>
To: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	leon@kernel.org, longli@microsoft.com, kotaranov@microsoft.com,
	horms@kernel.org, shradhagupta@linux.microsoft.com,
	ssengar@linux.microsoft.com, ernis@linux.microsoft.com,
	shirazsaleem@microsoft.com, linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org, dipayanroy@microsoft.com
Subject: [PATCH net-next] net: mana: Expose page_pool stats via ethtool
Message-ID: <aaFmRqjjOuPIEo5x@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9024-lists,linux-hyperv=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dipayanroy@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.microsoft.com:dkim,linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net:mid]
X-Rspamd-Queue-Id: 7A8CC1B575E
X-Rspamd-Action: no action

MANA relies on page_pool for RX buffers, and the buffer refill paths
can behave quite differently across architectures and configurations (e.g.
base page size, fragment vs full-page usage). This makes it harder to
understand and compare RX buffer behavior when investigating performance
and memory differences across platforms.

Wire up the generic page_pool ethtool stats helpers and report
page_pool allocation/recycle statistics via ethtool -S when
CONFIG_PAGE_POOL_STATS is enabled. The counters are exposed with the
standard "rx_pp_*" names, for example:

  rx_pp_alloc_fast
  rx_pp_alloc_slow
  rx_pp_alloc_slow_ho
  rx_pp_alloc_empty
  rx_pp_alloc_refill
  rx_pp_alloc_waive
  rx_pp_recycle_cached
  rx_pp_recycle_cache_full
  rx_pp_recycle_ring
  rx_pp_recycle_ring_full
  rx_pp_recycle_released_ref

Signed-off-by: Dipayaan Roy <dipayanroy@linux.microsoft.com>
---
 .../ethernet/microsoft/mana/mana_ethtool.c    | 30 +++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/microsoft/mana/mana_ethtool.c b/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
index f2d220b371b5..8fec74cdd3c3 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
@@ -6,6 +6,7 @@
 #include <linux/ethtool.h>
 
 #include <net/mana/mana.h>
+#include <net/page_pool/helpers.h>
 
 struct mana_stats_desc {
 	char name[ETH_GSTRING_LEN];
@@ -143,8 +144,10 @@ static int mana_get_sset_count(struct net_device *ndev, int stringset)
 	if (stringset != ETH_SS_STATS)
 		return -EINVAL;
 
-	return ARRAY_SIZE(mana_eth_stats) + ARRAY_SIZE(mana_phy_stats) + ARRAY_SIZE(mana_hc_stats) +
-			num_queues * (MANA_STATS_RX_COUNT + MANA_STATS_TX_COUNT);
+	return  ARRAY_SIZE(mana_eth_stats) + ARRAY_SIZE(mana_phy_stats) +
+		ARRAY_SIZE(mana_hc_stats) +
+		num_queues * (MANA_STATS_RX_COUNT + MANA_STATS_TX_COUNT) +
+		page_pool_ethtool_stats_get_count();
 }
 
 static void mana_get_strings(struct net_device *ndev, u32 stringset, u8 *data)
@@ -185,6 +188,27 @@ static void mana_get_strings(struct net_device *ndev, u32 stringset, u8 *data)
 		ethtool_sprintf(&data, "tx_%d_csum_partial", i);
 		ethtool_sprintf(&data, "tx_%d_mana_map_err", i);
 	}
+
+	page_pool_ethtool_stats_get_strings(data);
+}
+
+static void mana_get_page_pool_stats(struct net_device *ndev, u64 *data)
+{
+#ifdef CONFIG_PAGE_POOL_STATS
+	struct mana_port_context *apc = netdev_priv(ndev);
+	unsigned int num_queues = apc->num_queues;
+	struct page_pool_stats pp_stats = {};
+	int q;
+
+	for (q = 0; q < num_queues; q++) {
+		if (!apc->rxqs[q] || !apc->rxqs[q]->page_pool)
+			continue;
+
+		page_pool_get_stats(apc->rxqs[q]->page_pool, &pp_stats);
+	}
+
+	page_pool_ethtool_stats_get(data, &pp_stats);
+#endif /* CONFIG_PAGE_POOL_STATS */
 }
 
 static void mana_get_ethtool_stats(struct net_device *ndev,
@@ -280,6 +304,8 @@ static void mana_get_ethtool_stats(struct net_device *ndev,
 		data[i++] = csum_partial;
 		data[i++] = mana_map_err;
 	}
+
+	mana_get_page_pool_stats(ndev, &data[i]);
 }
 
 static u32 mana_get_rx_ring_count(struct net_device *ndev)
-- 
2.43.0


