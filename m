Return-Path: <linux-hyperv+bounces-3869-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E634A2E333
	for <lists+linux-hyperv@lfdr.de>; Mon, 10 Feb 2025 05:40:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A08FB18875D8
	for <lists+linux-hyperv@lfdr.de>; Mon, 10 Feb 2025 04:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D91B213FD86;
	Mon, 10 Feb 2025 04:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="c1HeStwI"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E36D35950;
	Mon, 10 Feb 2025 04:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739162455; cv=none; b=h8IOidk1rZoJ6TM0hTwwb14LaL3jaynkUi8aJWTOpm4/+x3jTltjYx+1E2ctO90vBsosOaDDnTW3aJB2u8MDPXqf7/Eq+v1g8BHBttQyzisxJAXQMabgogC7Jfbv/PYzbQZX9VGMSIKE3QLOmlXyt5M+sx20TyfGPm6FCVjUPRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739162455; c=relaxed/simple;
	bh=V+X++7IKWPkm4b0Uaz5A7ZFc+QChUiSngdaD/I5xPrY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=kq/75zCpkLQt9L35t6ZO2bAEngmKF4de4euVkLZaF2WYdySrQsbAlr3sGdFSWkSoPSLclRAehFYkfSRXkIIZFjvOn7cK9+M4wzquDpyaMm3UPdpNAhvGe/edbPsum1wHz+Eh65GHT0M+UVWFuMBg0WxyGuv4ZAJp+16S+q+bfts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=c1HeStwI; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1134)
	id 109E02107338; Sun,  9 Feb 2025 20:40:54 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 109E02107338
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1739162454;
	bh=ADvNUhAK+77BU7r4HcsCMy90Jg91GnipLA00ytq30jU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c1HeStwIGgSEItxs/tHEP94qtqHIjxZVGV+K4RsO9CkC1IszyepERRoUDre9o48ov
	 KFrkqh657T/1b0VQKLbWMPRA838vwoftAnMQmbnWTC4mbwTg8TG1QqYUbIO5oyCBDZ
	 Pn7/MeW4Jp+12C8+TA+jdSr2ozJnAc8DAMr5VhsU=
From: Shradha Gupta <shradhagupta@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Shradha Gupta <shradhagupta@linux.microsoft.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Long Li <longli@microsoft.com>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>,
	Erick Archer <erick.archer@outlook.com>,
	Shradha Gupta <shradhagupta@microsoft.com>
Subject: [PATCH v2 net-next 2/2] hv_netvsc: Use VF's tso_max_size value when data path is VF
Date: Sun,  9 Feb 2025 20:40:49 -0800
Message-Id: <1739162449-6831-1-git-send-email-shradhagupta@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1739162392-6356-1-git-send-email-shradhagupta@linux.microsoft.com>
References: <1739162392-6356-1-git-send-email-shradhagupta@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

On Azure, increasing VF's gso/gro packet size to up-to GSO_MAX_SIZE
is not possible without allowing the same for netvsc NIC
(as the NICs are bonded together). For bonded NICs, the min of the max
aggregated pkt size of the members is propagated in the stack.

Therefore, we use netif_set_tso_max_size() to set max aggregated pkt size
to VF's packet size for netvsc too, when the data path is switched over
to the VF
Tested on azure env with Accelerated Networking enabled and disabled.

Signed-off-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
---
 Changes in v2
 * Instead of using 'tcp segment' throughout the patch used used more accurate
   term 'aggregated pkt size'
---
 drivers/net/hyperv/hyperv_net.h   |  2 ++
 drivers/net/hyperv/netvsc_drv.c   | 15 +++++++++++++++
 drivers/net/hyperv/rndis_filter.c | 13 +++++++------
 3 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/drivers/net/hyperv/hyperv_net.h b/drivers/net/hyperv/hyperv_net.h
index e690b95b1bbb..def41067ea3f 100644
--- a/drivers/net/hyperv/hyperv_net.h
+++ b/drivers/net/hyperv/hyperv_net.h
@@ -1166,6 +1166,8 @@ struct netvsc_device {
 	u32 max_chn;
 	u32 num_chn;
 
+	u32 netvsc_gso_max_size;
+
 	atomic_t open_chn;
 	struct work_struct subchan_work;
 	wait_queue_head_t subchan_open;
diff --git a/drivers/net/hyperv/netvsc_drv.c b/drivers/net/hyperv/netvsc_drv.c
index d6c4abfc3a28..cbb517aa59cf 100644
--- a/drivers/net/hyperv/netvsc_drv.c
+++ b/drivers/net/hyperv/netvsc_drv.c
@@ -2461,6 +2461,21 @@ static int netvsc_vf_changed(struct net_device *vf_netdev, unsigned long event)
 	} else {
 		netdev_info(ndev, "Data path switched %s VF: %s\n",
 			    vf_is_up ? "to" : "from", vf_netdev->name);
+
+		/* In Azure, when accelerated networking in enabled, other NICs
+		 * like MANA, MLX, are configured as a bonded nic with
+		 * Netvsc(failover) NIC. For bonded NICs, the min of the max
+		 * pkt aggregate size of the members is propagated in the stack.
+		 * In order to allow these NICs (MANA/MLX) to use up to
+		 * GSO_MAX_SIZE gso packet size, we need to allow Netvsc NIC to
+		 * also support this in the guest.
+		 * This value is only increased for netvsc NIC when datapath is
+		 * switched over to the VF
+		 */
+		if (vf_is_up)
+			netif_set_tso_max_size(ndev, vf_netdev->tso_max_size);
+		else
+			netif_set_tso_max_size(ndev, netvsc_dev->netvsc_gso_max_size);
 	}
 
 	return NOTIFY_OK;
diff --git a/drivers/net/hyperv/rndis_filter.c b/drivers/net/hyperv/rndis_filter.c
index c0ceeef4fcd8..82747dfacd70 100644
--- a/drivers/net/hyperv/rndis_filter.c
+++ b/drivers/net/hyperv/rndis_filter.c
@@ -1356,9 +1356,10 @@ static int rndis_netdev_set_hwcaps(struct rndis_device *rndis_device,
 	struct net_device_context *net_device_ctx = netdev_priv(net);
 	struct ndis_offload hwcaps;
 	struct ndis_offload_params offloads;
-	unsigned int gso_max_size = GSO_LEGACY_MAX_SIZE;
 	int ret;
 
+	nvdev->netvsc_gso_max_size = GSO_LEGACY_MAX_SIZE;
+
 	/* Find HW offload capabilities */
 	ret = rndis_query_hwcaps(rndis_device, nvdev, &hwcaps);
 	if (ret != 0)
@@ -1390,8 +1391,8 @@ static int rndis_netdev_set_hwcaps(struct rndis_device *rndis_device,
 			offloads.lso_v2_ipv4 = NDIS_OFFLOAD_PARAMETERS_LSOV2_ENABLED;
 			net->hw_features |= NETIF_F_TSO;
 
-			if (hwcaps.lsov2.ip4_maxsz < gso_max_size)
-				gso_max_size = hwcaps.lsov2.ip4_maxsz;
+			if (hwcaps.lsov2.ip4_maxsz < nvdev->netvsc_gso_max_size)
+				nvdev->netvsc_gso_max_size = hwcaps.lsov2.ip4_maxsz;
 		}
 
 		if (hwcaps.csum.ip4_txcsum & NDIS_TXCSUM_CAP_UDP4) {
@@ -1411,8 +1412,8 @@ static int rndis_netdev_set_hwcaps(struct rndis_device *rndis_device,
 			offloads.lso_v2_ipv6 = NDIS_OFFLOAD_PARAMETERS_LSOV2_ENABLED;
 			net->hw_features |= NETIF_F_TSO6;
 
-			if (hwcaps.lsov2.ip6_maxsz < gso_max_size)
-				gso_max_size = hwcaps.lsov2.ip6_maxsz;
+			if (hwcaps.lsov2.ip6_maxsz < nvdev->netvsc_gso_max_size)
+				nvdev->netvsc_gso_max_size = hwcaps.lsov2.ip6_maxsz;
 		}
 
 		if (hwcaps.csum.ip6_txcsum & NDIS_TXCSUM_CAP_UDP6) {
@@ -1438,7 +1439,7 @@ static int rndis_netdev_set_hwcaps(struct rndis_device *rndis_device,
 	 */
 	net->features &= ~NETVSC_SUPPORTED_HW_FEATURES | net->hw_features;
 
-	netif_set_tso_max_size(net, gso_max_size);
+	netif_set_tso_max_size(net, nvdev->netvsc_gso_max_size);
 
 	ret = rndis_filter_set_offload_params(net, nvdev, &offloads);
 
-- 
2.34.1


