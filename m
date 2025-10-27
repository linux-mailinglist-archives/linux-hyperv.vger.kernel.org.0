Return-Path: <linux-hyperv+bounces-7334-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D815AC0D3FE
	for <lists+linux-hyperv@lfdr.de>; Mon, 27 Oct 2025 12:49:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45445420CB5
	for <lists+linux-hyperv@lfdr.de>; Mon, 27 Oct 2025 11:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B160D2F6918;
	Mon, 27 Oct 2025 11:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="TOpz4b+7"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A1401D90DF;
	Mon, 27 Oct 2025 11:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761565551; cv=none; b=RqwM38dztmpOCeY3EqpX1ucVHBkgElFwR71JHyRDCMauWWoqJmO3gGzp9XFZKDiLz7i73XP6CpAwAF1wnpAiymlxGaJThhBsoYoJbgby+R1MHL3rhMuKvvQA4xzPmp6gQyYzJTbhiz4SrbWJlZGICaNRftGFJ9rAf24RHkajB8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761565551; c=relaxed/simple;
	bh=KO2IrWeJHJdKPvb52YaopHekBfLBYLKCW7Q8p3wqhOo=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=SW2k4A770nHQiqt67pMad+hkDLJzf78hoAFBGeV8ofVF6kPA9nF6M935tXF7jlfs0VsWmBXPVEk9zSZDCTAmq1AsPGKjUBtreWKr91geCIQEvSH+uf9puODQ3vV4dEg01ia1S2OS+I7d74cfphqb1BaDQFOfkHGVhPUwXRxA5cI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=TOpz4b+7; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1204)
	id 8A0542128FB1; Mon, 27 Oct 2025 04:45:49 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8A0542128FB1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1761565549;
	bh=48OMDO+6+e8aouweX6tft0JyL5JnB0rHgl/40+u1N1U=;
	h=Date:From:To:Subject:From;
	b=TOpz4b+7bPCn0FXc2uyGb1BG7+Nxpc08OBahq4mdGfRbg6D6lRl3M5qUHteeVBPoi
	 Nm+H2FyWc9T7oekSjUSM3Ndo2X11Gq4Vr59/oah7wgdwH+Jf3quxavbwSfkIboJ6AS
	 StTJmsgjwDxvPPUhVGmvTnFe0+dgQ3JkA/gDazYs=
Date: Mon, 27 Oct 2025 04:45:49 -0700
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
Subject: [PATCH net-next] net: mana: Implement ndo_tx_timeout and serialize
 queue resets per port.
Message-ID: <20251027114549.GA12252@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
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
and a device-controlled port reset for all queues can be scheduled to an
ordered workqueue. The reset for all queues on stall detection is
recomended by hardware team.

The change introduces a single ordered workqueue
("mana_per_port_queue_reset_wq") with WQ_UNBOUND | WQ_MEM_RECLAIM and
queues exactly one work_struct per port onto it. This achieves:

  * Global FIFO across all port reset requests (alloc_ordered_workqueue).
  * Natural per-port de-duplication: the same work_struct cannot be
    queued twice while pending/running.
  * Avoids hogging a per-CPU kworker for long, may-sleep reset paths
    (WQ_UNBOUND).
  * Guarantees forward progress during memory pressure
    (WQ_MEM_RECLAIM rescuer).

Signed-off-by: Dipayaan Roy <dipayanroy@linux.microsoft.com>
---
 drivers/net/ethernet/microsoft/mana/mana_en.c | 83 +++++++++++++++++++
 include/net/mana/gdma.h                       |  6 +-
 include/net/mana/mana.h                       | 12 +++
 3 files changed, 100 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index f4fc86f20213..2833f66d8b2b 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -258,6 +258,45 @@ static int mana_get_gso_hs(struct sk_buff *skb)
 	return gso_hs;
 }
 
+static void mana_per_port_queue_reset_work_handler(struct work_struct *work)
+{
+	struct mana_queue_reset_work *reset_queue_work =
+			container_of(work, struct mana_queue_reset_work, work);
+	struct mana_port_context *apc = reset_queue_work->apc;
+	struct net_device *ndev = apc->ndev;
+	struct mana_context *ac = apc->ac;
+	int err;
+
+	if (!rtnl_trylock()) {
+		/* Someone else holds RTNL, requeue and exit. */
+		queue_work(ac->per_port_queue_reset_wq,
+			   &apc->queue_reset_work.work);
+		return;
+	}
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
@@ -762,6 +801,25 @@ static int mana_change_mtu(struct net_device *ndev, int new_mtu)
 	return err;
 }
 
+static void mana_tx_timeout(struct net_device *netdev, unsigned int txqueue)
+{
+	struct mana_port_context *apc = netdev_priv(netdev);
+	struct mana_context *ac = apc->ac;
+	struct gdma_context *gc = ac->gdma_dev->gdma_context;
+
+	netdev_warn(netdev, "%s(): called on txq: %u\n", __func__, txqueue);
+
+	/* Already in service, hence tx queue reset is not required.*/
+	if (gc->in_service)
+		return;
+
+	/* Note: If there are pending queue reset work for this port(apc),
+	 * subsequent request queued up drom here are ignored. This is because
+	 * we are using the same work instance per port(apc).
+	 */
+	queue_work(ac->per_port_queue_reset_wq, &apc->queue_reset_work.work);
+}
+
 static int mana_shaper_set(struct net_shaper_binding *binding,
 			   const struct net_shaper *shaper,
 			   struct netlink_ext_ack *extack)
@@ -844,7 +902,9 @@ static const struct net_device_ops mana_devops = {
 	.ndo_bpf		= mana_bpf,
 	.ndo_xdp_xmit		= mana_xdp_xmit,
 	.ndo_change_mtu		= mana_change_mtu,
+	.ndo_tx_timeout     = mana_tx_timeout,
 	.net_shaper_ops         = &mana_shaper_ops,
+
 };
 
 static void mana_cleanup_port_context(struct mana_port_context *apc)
@@ -3218,6 +3278,7 @@ static int mana_probe_port(struct mana_context *ac, int port_idx,
 	ndev->min_mtu = ETH_MIN_MTU;
 	ndev->needed_headroom = MANA_HEADROOM;
 	ndev->dev_port = port_idx;
+	ndev->watchdog_timeo = MANA_TXQ_TIMEOUT;
 	SET_NETDEV_DEV(ndev, gc->dev);
 
 	netif_set_tso_max_size(ndev, GSO_MAX_SIZE);
@@ -3255,6 +3316,11 @@ static int mana_probe_port(struct mana_context *ac, int port_idx,
 
 	debugfs_create_u32("current_speed", 0400, apc->mana_port_debugfs, &apc->speed);
 
+	/* Initialize the per port queue reset work.*/
+	apc->queue_reset_work.apc = apc;
+	INIT_WORK(&apc->queue_reset_work.work,
+		  mana_per_port_queue_reset_work_handler);
+
 	return 0;
 
 free_indir:
@@ -3456,6 +3522,15 @@ int mana_probe(struct gdma_dev *gd, bool resuming)
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
@@ -3528,6 +3603,8 @@ void mana_remove(struct gdma_dev *gd, bool suspending)
 		 */
 		rtnl_lock();
 
+		cancel_work_sync(&apc->queue_reset_work.work);
+
 		err = mana_detach(ndev, false);
 		if (err)
 			netdev_err(ndev, "Failed to detach vPort %d: %d\n",
@@ -3547,6 +3624,12 @@ void mana_remove(struct gdma_dev *gd, bool suspending)
 		free_netdev(ndev);
 	}
 
+	if (ac->per_port_queue_reset_wq) {
+		drain_workqueue(ac->per_port_queue_reset_wq);
+		destroy_workqueue(ac->per_port_queue_reset_wq);
+		ac->per_port_queue_reset_wq = NULL;
+	}
+
 	mana_destroy_eq(ac);
 out:
 	mana_gd_deregister_device(gd);
diff --git a/include/net/mana/gdma.h b/include/net/mana/gdma.h
index 57df78cfbf82..1f8c536ba3be 100644
--- a/include/net/mana/gdma.h
+++ b/include/net/mana/gdma.h
@@ -591,6 +591,9 @@ enum {
 /* Driver can self reset on FPGA Reconfig EQE notification */
 #define GDMA_DRV_CAP_FLAG_1_HANDLE_RECONFIG_EQE BIT(17)
 
+/* Driver detects stalled send queues and recovers them */
+#define GDMA_DRV_CAP_FLAG_1_HANDLE_STALL_SQ_RECOVERY BIT(18)
+
 #define GDMA_DRV_CAP_FLAGS1 \
 	(GDMA_DRV_CAP_FLAG_1_EQ_SHARING_MULTI_VPORT | \
 	 GDMA_DRV_CAP_FLAG_1_NAPI_WKDONE_FIX | \
@@ -599,7 +602,8 @@ enum {
 	 GDMA_DRV_CAP_FLAG_1_DEV_LIST_HOLES_SUP | \
 	 GDMA_DRV_CAP_FLAG_1_DYNAMIC_IRQ_ALLOC_SUPPORT | \
 	 GDMA_DRV_CAP_FLAG_1_SELF_RESET_ON_EQE | \
-	 GDMA_DRV_CAP_FLAG_1_HANDLE_RECONFIG_EQE)
+	 GDMA_DRV_CAP_FLAG_1_HANDLE_RECONFIG_EQE | \
+	 GDMA_DRV_CAP_FLAG_1_HANDLE_STALL_SQ_RECOVERY)
 
 #define GDMA_DRV_CAP_FLAGS2 0
 
diff --git a/include/net/mana/mana.h b/include/net/mana/mana.h
index 0921485565c0..9b8f236f27c9 100644
--- a/include/net/mana/mana.h
+++ b/include/net/mana/mana.h
@@ -67,6 +67,11 @@ enum TRI_STATE {
 
 #define MANA_RX_FRAG_ALIGNMENT 64
 
+/* Timeout value for Txq stall detetcion & recovery used by ndo_tx_timeout.
+ * The value is chosen after considering fpga re-config scenarios.
+ */
+#define MANA_TXQ_TIMEOUT (15 * HZ)
+
 struct mana_stats_rx {
 	u64 packets;
 	u64 bytes;
@@ -475,13 +480,20 @@ struct mana_context {
 
 	struct mana_eq *eqs;
 	struct dentry *mana_eqs_debugfs;
+	struct workqueue_struct *per_port_queue_reset_wq;
 
 	struct net_device *ports[MAX_PORTS_IN_MANA_DEV];
 };
 
+struct mana_queue_reset_work {
+	struct work_struct work;              // Work structure
+	struct mana_port_context *apc;        // Pointer to the port context
+};
+
 struct mana_port_context {
 	struct mana_context *ac;
 	struct net_device *ndev;
+	struct mana_queue_reset_work queue_reset_work;
 
 	u8 mac_addr[ETH_ALEN];
 
-- 
2.43.0


