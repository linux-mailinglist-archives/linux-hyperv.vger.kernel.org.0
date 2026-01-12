Return-Path: <linux-hyperv+bounces-8220-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E921D12AC8
	for <lists+linux-hyperv@lfdr.de>; Mon, 12 Jan 2026 14:05:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A2FEA30028AF
	for <lists+linux-hyperv@lfdr.de>; Mon, 12 Jan 2026 13:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79A7C357A47;
	Mon, 12 Jan 2026 13:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="M/Y6jAha"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 047FD346AE6;
	Mon, 12 Jan 2026 13:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768223154; cv=none; b=ZJddwLJEhxgtZUMxquu77KITgAoKH/XZu+SQVLGsVdweghjH2/pn5wFXSbvpGRM4KbPZSA5Xf5IwEUwNLo85S7wgFvM3R+AkJFUvwbaGUuvOYHGb/mC6aAbe+0ziAzftDnSYJSxTSg8GMswMWbThB6OcCkOqx4dH6FnqXNSekXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768223154; c=relaxed/simple;
	bh=LDRMrQRVyy1prgME2OQUHsThxIlbPrQ6Bi0i03otMnM=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=DMvIgvoebgxiQ6uZxqpG8sf2/CIP6lB1rnaZvyTpmN8vQgBixzsd7IzDekKXGhQ+t214WE1TVEml51bk6jQ1+9MjjBOED5EDoFyCrV3AJyUe8xSBePLwB2pbjkcKnXdHtWvDHx125ObQeD4UJUHo4+3Yfrdye9qKDEhMAC5OqVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=M/Y6jAha; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1204)
	id ACA39201AC86; Mon, 12 Jan 2026 05:05:52 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com ACA39201AC86
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1768223152;
	bh=tEofgjfRMhXX8w5hgxWzQkqBlNRBlhwkGqlGrIa89mQ=;
	h=Date:From:To:Subject:From;
	b=M/Y6jAhaGZvHcUM8xjpRplCaHhdvFsALngovYyCgthkKOJQM+Zut6y3o7/PWejbA8
	 QqzIctEwcXRYKWzuXgn52oMu3BvUFDgoBHn5Jz3O8mJSH8I2EXrOfgeJuoO3blAPSr
	 lsWwF0VVJxRgCzSq7d398HzlWwAcPF4N8L3p+JGY=
Date: Mon, 12 Jan 2026 05:05:52 -0800
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
Subject: [PATCH net-next, v8] net: mana: Implement ndo_tx_timeout and
 serialize queue resets per port.
Message-ID: <20260112130552.GA11785@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
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

Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Dipayaan Roy <dipayanroy@linux.microsoft.com>
---
Changes in v8:
  - better aligned queue reset work struct.
Changes in v7:
  - Add enable_work in resume path.
Changes in v6:
  - Rebased.
Changes in v5:
  -Fixed commit message, used 'create_singlethread_workqueue' and fixed
   cleanup part.
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
 include/net/mana/mana.h                       |  3 +-
 3 files changed, 84 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index 1ad154f9db1a..91c418097284 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -299,6 +299,39 @@ static int mana_get_gso_hs(struct sk_buff *skb)
 	return gso_hs;
 }
 
+static void mana_per_port_queue_reset_work_handler(struct work_struct *work)
+{
+	struct mana_port_context *apc = container_of(work,
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
@@ -839,6 +872,23 @@ static int mana_change_mtu(struct net_device *ndev, int new_mtu)
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
+	queue_work(ac->per_port_queue_reset_wq, &apc->queue_reset_work);
+}
+
 static int mana_shaper_set(struct net_shaper_binding *binding,
 			   const struct net_shaper *shaper,
 			   struct netlink_ext_ack *extack)
@@ -924,6 +974,7 @@ static const struct net_device_ops mana_devops = {
 	.ndo_bpf		= mana_bpf,
 	.ndo_xdp_xmit		= mana_xdp_xmit,
 	.ndo_change_mtu		= mana_change_mtu,
+	.ndo_tx_timeout		= mana_tx_timeout,
 	.net_shaper_ops         = &mana_shaper_ops,
 };
 
@@ -3287,6 +3338,8 @@ static int mana_probe_port(struct mana_context *ac, int port_idx,
 	ndev->min_mtu = ETH_MIN_MTU;
 	ndev->needed_headroom = MANA_HEADROOM;
 	ndev->dev_port = port_idx;
+	/* Recommended timeout based on HW FPGA re-config scenario. */
+	ndev->watchdog_timeo = 15 * HZ;
 	SET_NETDEV_DEV(ndev, gc->dev);
 
 	netif_set_tso_max_size(ndev, GSO_MAX_SIZE);
@@ -3303,6 +3356,10 @@ static int mana_probe_port(struct mana_context *ac, int port_idx,
 	if (err)
 		goto reset_apc;
 
+	/* Initialize the per port queue reset work.*/
+	INIT_WORK(&apc->queue_reset_work,
+		  mana_per_port_queue_reset_work_handler);
+
 	netdev_lockdep_set_classes(ndev);
 
 	ndev->hw_features = NETIF_F_SG | NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM;
@@ -3492,6 +3549,7 @@ int mana_probe(struct gdma_dev *gd, bool resuming)
 {
 	struct gdma_context *gc = gd->gdma_context;
 	struct mana_context *ac = gd->driver_data;
+	struct mana_port_context *apc = NULL;
 	struct device *dev = gc->dev;
 	u8 bm_hostmode = 0;
 	u16 num_ports = 0;
@@ -3549,6 +3607,14 @@ int mana_probe(struct gdma_dev *gd, bool resuming)
 	if (ac->num_ports > MAX_PORTS_IN_MANA_DEV)
 		ac->num_ports = MAX_PORTS_IN_MANA_DEV;
 
+	ac->per_port_queue_reset_wq =
+		create_singlethread_workqueue("mana_per_port_queue_reset_wq");
+	if (!ac->per_port_queue_reset_wq) {
+		dev_err(dev, "Failed to allocate per port queue reset workqueue\n");
+		err = -ENOMEM;
+		goto out;
+	}
+
 	if (!resuming) {
 		for (i = 0; i < ac->num_ports; i++) {
 			err = mana_probe_port(ac, i, &ac->ports[i]);
@@ -3565,6 +3631,8 @@ int mana_probe(struct gdma_dev *gd, bool resuming)
 	} else {
 		for (i = 0; i < ac->num_ports; i++) {
 			rtnl_lock();
+			apc = netdev_priv(ac->ports[i]);
+			enable_work(&apc->queue_reset_work);
 			err = mana_attach(ac->ports[i]);
 			rtnl_unlock();
 			/* we log the port for which the attach failed and stop
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
+		disable_work_sync(&apc->queue_reset_work);
+
 		/* All cleanup actions should stay after rtnl_lock(), otherwise
 		 * other functions may access partially cleaned up data.
 		 */
@@ -3649,6 +3719,11 @@ void mana_remove(struct gdma_dev *gd, bool suspending)
 
 	mana_destroy_eq(ac);
 out:
+	if (ac->per_port_queue_reset_wq) {
+		destroy_workqueue(ac->per_port_queue_reset_wq);
+		ac->per_port_queue_reset_wq = NULL;
+	}
+
 	mana_gd_deregister_device(gd);
 
 	if (suspending)
diff --git a/include/net/mana/gdma.h b/include/net/mana/gdma.h
index eaa27483f99b..a59bd4035a99 100644
--- a/include/net/mana/gdma.h
+++ b/include/net/mana/gdma.h
@@ -598,6 +598,10 @@ enum {
 
 /* Driver can self reset on FPGA Reconfig EQE notification */
 #define GDMA_DRV_CAP_FLAG_1_HANDLE_RECONFIG_EQE BIT(17)
+
+/* Driver detects stalled send queues and recovers them */
+#define GDMA_DRV_CAP_FLAG_1_HANDLE_STALL_SQ_RECOVERY BIT(18)
+
 #define GDMA_DRV_CAP_FLAG_1_HW_VPORT_LINK_AWARE BIT(6)
 
 /* Driver supports linearizing the skb when num_sge exceeds hardware limit */
@@ -621,7 +625,8 @@ enum {
 	 GDMA_DRV_CAP_FLAG_1_HW_VPORT_LINK_AWARE | \
 	 GDMA_DRV_CAP_FLAG_1_PERIODIC_STATS_QUERY | \
 	 GDMA_DRV_CAP_FLAG_1_SKB_LINEARIZE | \
-	 GDMA_DRV_CAP_FLAG_1_PROBE_RECOVERY)
+	 GDMA_DRV_CAP_FLAG_1_PROBE_RECOVERY | \
+	 GDMA_DRV_CAP_FLAG_1_HANDLE_STALL_SQ_RECOVERY)
 
 #define GDMA_DRV_CAP_FLAGS2 0
 
diff --git a/include/net/mana/mana.h b/include/net/mana/mana.h
index d7e089c6b694..a078af283bdd 100644
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
@@ -495,6 +495,7 @@ struct mana_context {
 struct mana_port_context {
 	struct mana_context *ac;
 	struct net_device *ndev;
+	struct work_struct queue_reset_work;
 
 	u8 mac_addr[ETH_ALEN];
 
-- 
2.43.0


