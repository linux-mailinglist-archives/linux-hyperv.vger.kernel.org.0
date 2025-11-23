Return-Path: <linux-hyperv+bounces-7782-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CAAB2C7E546
	for <lists+linux-hyperv@lfdr.de>; Sun, 23 Nov 2025 19:08:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 48ABA3411D7
	for <lists+linux-hyperv@lfdr.de>; Sun, 23 Nov 2025 18:08:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0E3B242D70;
	Sun, 23 Nov 2025 18:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="dcXIcT77"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B5AA2D3218;
	Sun, 23 Nov 2025 18:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763921306; cv=none; b=Yboi88oCIPgtquwnKDRCG53szbvDgDYj5/xckd8ZhY8ihtAUttgWfxtQzwP5gh5jEm992ILu75FoO44f2D9V2I7dhQkRdlDCBqBRbLmXt3QpbLkvwP/2BXQVF/ExtH1rOTANy44C/ndS8pJYoBRxMVYUmFXBn72VaXG9ImnxLjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763921306; c=relaxed/simple;
	bh=FK5CO4GeTPmtwy57uc4iEa9rZePcIDRJPX9TXFUhx3M=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=oqdLruGAUO2QFA0Qwyo07mDqeylqJdoCRMCb1fafM252QKnrY7lJw2NRDqmMkQz4uC0X/ddwrfVdUKgLQ+RHSBoR5RL6AdiplkFe2ycW9TF79Fh9TpkTGvsAc/tu4vvyWBCA4UQdzQkLkWvI6RMvxS8+x084PzvVfqV/xqVpQ3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=dcXIcT77; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1204)
	id 452672129D90; Sun, 23 Nov 2025 10:08:18 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 452672129D90
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1763921298;
	bh=eUuAW+EBorJhzAJFacpYRZoC+glQCTI9O7wPdIVctLk=;
	h=Date:From:To:Subject:From;
	b=dcXIcT77364lmjH8B2tP0sonMDyoxH6wTuoPbH5yRN8mg/bhSCnwzRCu7an+/f98b
	 jkMEKD1a7ZPFqyca0kSHk1F8SMTnAAgdk7ZRAH4YTLjdZ+MfT/mRM98pxT1tToYmA4
	 j/DU0A+f0ZMXXNxKgt73RK5wtZMVkCvADxfr/PqA=
Date: Sun, 23 Nov 2025 10:08:18 -0800
From: Dipayaan Roy <dipayanroy@linux.microsoft.com>
To: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	longli@microsoft.com, kotaranov@microsoft.com, horms@kernel.org,
	shradhagupta@linux.microsoft.com, ssengar@linux.microsoft.com,
	ernis@linux.microsoft.com, shirazsaleem@microsoft.com,
	linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
	dipayanroy@microsoft.com
Subject: [PATCH net-next, v4] net: mana: Implement ndo_tx_timeout and
 serialize queue resets per port.
Message-ID: <20251123180818.GA18398@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)

Implement .ndo_tx_timeout for MANA so any stalled TX queue can be detected
and a device-controlled port reset for all queues can be scheduled to a
ordered workqueue. The reset for all queues on stall detection is
recomended by hardware team.

The change introduces a single ordered workqueue
"mana_per_port_queue_reset_wq" queuing one work_struct per port,
using WQ_UNBOUND | WQ_MEM_RECLAIM so stalled queue reset work can
run on any CPU and still make forward progress under memory
pressure.

Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Dipayaan Roy <dipayanroy@linux.microsoft.com>
---
Changes in v4:
  -Fixed commit message, work initialization before registering netdev,
   fixed potential null pointer de-reference bug.
Changes in v3:
  -Fixed commit meesage, removed rtnl_trylock and added
   disable_work_sync, fixed mana_queue_reset_work, and few
   cosmetics.
Changes in v2:
  -Fixed cosmetic changes.
---
---
 drivers/net/ethernet/microsoft/mana/mana_en.c | 77 ++++++++++++++++++-
 include/net/mana/gdma.h                       |  7 +-
 include/net/mana/mana.h                       |  8 +-
 3 files changed, 89 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index 1ad154f9db1a..7c71257b43a4 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -299,6 +299,42 @@ static int mana_get_gso_hs(struct sk_buff *skb)
 	return gso_hs;
 }
 
+static void mana_per_port_queue_reset_work_handler(struct work_struct *work)
+{
+	struct mana_queue_reset_work *reset_queue_work =
+			container_of(work, struct mana_queue_reset_work, work);
+
+	struct mana_port_context *apc = container_of(reset_queue_work,
+						     struct mana_port_context,
+						     queue_reset_work);
+	struct net_device *ndev = apc->ndev;
+	int err;
+
+	rtnl_lock();
+
+	/* Pre-allocate buffers to prevent failure in mana_attach later */
+	err = mana_pre_alloc_rxbufs(apc, ndev->mtu, apc->num_queues);
+	if (err) {
+		netdev_err(ndev, "Insufficient memory for reset post tx stall detection\n");
+		goto out;
+	}
+
+	err = mana_detach(ndev, false);
+	if (err) {
+		netdev_err(ndev, "mana_detach failed: %d\n", err);
+		goto dealloc_pre_rxbufs;
+	}
+
+	err = mana_attach(ndev);
+	if (err)
+		netdev_err(ndev, "mana_attach failed: %d\n", err);
+
+dealloc_pre_rxbufs:
+	mana_pre_dealloc_rxbufs(apc);
+out:
+	rtnl_unlock();
+}
+
 netdev_tx_t mana_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 {
 	enum mana_tx_pkt_format pkt_fmt = MANA_SHORT_PKT_FMT;
@@ -839,6 +875,23 @@ static int mana_change_mtu(struct net_device *ndev, int new_mtu)
 	return err;
 }
 
+static void mana_tx_timeout(struct net_device *netdev, unsigned int txqueue)
+{
+	struct mana_port_context *apc = netdev_priv(netdev);
+	struct mana_context *ac = apc->ac;
+	struct gdma_context *gc = ac->gdma_dev->gdma_context;
+
+	/* Already in service, hence tx queue reset is not required.*/
+	if (gc->in_service)
+		return;
+
+	/* Note: If there are pending queue reset work for this port(apc),
+	 * subsequent request queued up from here are ignored. This is because
+	 * we are using the same work instance per port(apc).
+	 */
+	queue_work(ac->per_port_queue_reset_wq, &apc->queue_reset_work.work);
+}
+
 static int mana_shaper_set(struct net_shaper_binding *binding,
 			   const struct net_shaper *shaper,
 			   struct netlink_ext_ack *extack)
@@ -924,6 +977,7 @@ static const struct net_device_ops mana_devops = {
 	.ndo_bpf		= mana_bpf,
 	.ndo_xdp_xmit		= mana_xdp_xmit,
 	.ndo_change_mtu		= mana_change_mtu,
+	.ndo_tx_timeout		= mana_tx_timeout,
 	.net_shaper_ops         = &mana_shaper_ops,
 };
 
@@ -3287,6 +3341,7 @@ static int mana_probe_port(struct mana_context *ac, int port_idx,
 	ndev->min_mtu = ETH_MIN_MTU;
 	ndev->needed_headroom = MANA_HEADROOM;
 	ndev->dev_port = port_idx;
+	ndev->watchdog_timeo = 15 * HZ;
 	SET_NETDEV_DEV(ndev, gc->dev);
 
 	netif_set_tso_max_size(ndev, GSO_MAX_SIZE);
@@ -3303,6 +3358,10 @@ static int mana_probe_port(struct mana_context *ac, int port_idx,
 	if (err)
 		goto reset_apc;
 
+	/* Initialize the per port queue reset work.*/
+	INIT_WORK(&apc->queue_reset_work.work,
+		  mana_per_port_queue_reset_work_handler);
+
 	netdev_lockdep_set_classes(ndev);
 
 	ndev->hw_features = NETIF_F_SG | NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM;
@@ -3549,6 +3608,15 @@ int mana_probe(struct gdma_dev *gd, bool resuming)
 	if (ac->num_ports > MAX_PORTS_IN_MANA_DEV)
 		ac->num_ports = MAX_PORTS_IN_MANA_DEV;
 
+	ac->per_port_queue_reset_wq =
+			alloc_ordered_workqueue("mana_per_port_queue_reset_wq",
+						WQ_UNBOUND | WQ_MEM_RECLAIM);
+	if (!ac->per_port_queue_reset_wq) {
+		dev_err(dev, "Failed to allocate per port queue reset workqueue\n");
+		err = -ENOMEM;
+		goto out;
+	}
+
 	if (!resuming) {
 		for (i = 0; i < ac->num_ports; i++) {
 			err = mana_probe_port(ac, i, &ac->ports[i]);
@@ -3616,13 +3684,15 @@ void mana_remove(struct gdma_dev *gd, bool suspending)
 
 	for (i = 0; i < ac->num_ports; i++) {
 		ndev = ac->ports[i];
-		apc = netdev_priv(ndev);
 		if (!ndev) {
 			if (i == 0)
 				dev_err(dev, "No net device to remove\n");
 			goto out;
 		}
 
+		apc = netdev_priv(ndev);
+		disable_work_sync(&apc->queue_reset_work.work);
+
 		/* All cleanup actions should stay after rtnl_lock(), otherwise
 		 * other functions may access partially cleaned up data.
 		 */
@@ -3647,6 +3717,11 @@ void mana_remove(struct gdma_dev *gd, bool suspending)
 		free_netdev(ndev);
 	}
 
+	if (ac->per_port_queue_reset_wq) {
+		destroy_workqueue(ac->per_port_queue_reset_wq);
+		ac->per_port_queue_reset_wq = NULL;
+	}
+
 	mana_destroy_eq(ac);
 out:
 	mana_gd_deregister_device(gd);
diff --git a/include/net/mana/gdma.h b/include/net/mana/gdma.h
index a4cf307859f8..808622ae5ccc 100644
--- a/include/net/mana/gdma.h
+++ b/include/net/mana/gdma.h
@@ -592,6 +592,10 @@ enum {
 
 /* Driver can self reset on FPGA Reconfig EQE notification */
 #define GDMA_DRV_CAP_FLAG_1_HANDLE_RECONFIG_EQE BIT(17)
+
+/* Driver detects stalled send queues and recovers them */
+#define GDMA_DRV_CAP_FLAG_1_HANDLE_STALL_SQ_RECOVERY BIT(18)
+
 #define GDMA_DRV_CAP_FLAG_1_HW_VPORT_LINK_AWARE BIT(6)
 
 /* Driver supports linearizing the skb when num_sge exceeds hardware limit */
@@ -611,7 +615,8 @@ enum {
 	 GDMA_DRV_CAP_FLAG_1_HANDLE_RECONFIG_EQE | \
 	 GDMA_DRV_CAP_FLAG_1_HW_VPORT_LINK_AWARE | \
 	 GDMA_DRV_CAP_FLAG_1_PERIODIC_STATS_QUERY | \
-	 GDMA_DRV_CAP_FLAG_1_SKB_LINEARIZE)
+	 GDMA_DRV_CAP_FLAG_1_SKB_LINEARIZE        | \
+	 GDMA_DRV_CAP_FLAG_1_HANDLE_STALL_SQ_RECOVERY)
 
 #define GDMA_DRV_CAP_FLAGS2 0
 
diff --git a/include/net/mana/mana.h b/include/net/mana/mana.h
index d7e089c6b694..cef78a871c7c 100644
--- a/include/net/mana/mana.h
+++ b/include/net/mana/mana.h
@@ -480,7 +480,7 @@ struct mana_context {
 	struct mana_ethtool_hc_stats hc_stats;
 	struct mana_eq *eqs;
 	struct dentry *mana_eqs_debugfs;
-
+	struct workqueue_struct *per_port_queue_reset_wq;
 	/* Workqueue for querying hardware stats */
 	struct delayed_work gf_stats_work;
 	bool hwc_timeout_occurred;
@@ -492,9 +492,15 @@ struct mana_context {
 	u32 link_event;
 };
 
+struct mana_queue_reset_work {
+	/* Work structure */
+	struct work_struct work;
+};
+
 struct mana_port_context {
 	struct mana_context *ac;
 	struct net_device *ndev;
+	struct mana_queue_reset_work queue_reset_work;
 
 	u8 mac_addr[ETH_ALEN];
 
-- 
2.43.0


