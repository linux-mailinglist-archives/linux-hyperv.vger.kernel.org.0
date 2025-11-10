Return-Path: <linux-hyperv+bounces-7483-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D4D59C45F45
	for <lists+linux-hyperv@lfdr.de>; Mon, 10 Nov 2025 11:35:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7437A1882F3A
	for <lists+linux-hyperv@lfdr.de>; Mon, 10 Nov 2025 10:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21DDF301707;
	Mon, 10 Nov 2025 10:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="hhQAuU+N"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5994D2FF64C;
	Mon, 10 Nov 2025 10:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762770944; cv=none; b=hq658YpeDG1WDArAELaDdtO9ESKvAWZFWhXb0oRUYaZSIo5iYdT8p+/IMvfMZrVdcW+OlU8STKZq2CToH+Jo0MSiMWiAMPB4cnoKYhbHY/EwOACAvIlOZNTSbatUb9XT6oaDaONlHL/e0EC9xwc6LxFLHzxZwUqQ2bQPmbywoHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762770944; c=relaxed/simple;
	bh=NeK6KcdchkOG9JyXWuzd9Vn57w0zA4fF1eY5e0HFOns=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=dERKp8pS3KM5BK1A6cdqN6wRbj9buhyEqJlIphOfyuQ7+el8SoiM+xfZTw/yz1E+AlPJzSM+8BsH9o/F+MVu9AH/OIA3hm0+LafZEtpFZKBPoo6C6zxFAUGD/eMSDK0MZIRnIyt/5R30wbMo3Bx1dXVOB0hSJkifk1kDCsZbj5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=hhQAuU+N; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1204)
	id D7054206C153; Mon, 10 Nov 2025 02:35:41 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D7054206C153
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1762770941;
	bh=0EpIh5dOPNjMm5DcewM3l78ahgbqe1mDUcWq6FpXZ+c=;
	h=Date:From:To:Subject:From;
	b=hhQAuU+NtmNDGglssz0HPzjdYZ6il2OToUc0Y8T83MUCKakgM0aXvEAxBAaID2wt+
	 0DCKH+h0ivatUHIUt3tMDXL7m3QGCzgNqR1vrdqd16egHz72+shzEeePVw40hM+RK4
	 xTKbU0ND1RnaWhtHc+7WIy3YzU/EeqANYuKJYVLI=
Date: Mon, 10 Nov 2025 02:35:41 -0800
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
Subject: [PATCH net-next, v3] net: mana: Implement ndo_tx_timeout and
 serialize queue resets per port.
Message-ID: <20251110103541.GA30450@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
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
("mana_per_port_queue_reset_wq") with WQ_UNBOUND | WQ_MEM_RECLAIM and
queues exactly one work_struct per port onto it.

Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Dipayaan Roy <dipayanroy@linux.microsoft.com>
---
Changes in v3:
  -Fixed commit meesage, removed rtnl_trylock and added
   disable_work_sync, fixed mana_queue_reset_work, and few
   cosmetics.
Changes in v2:
  -Fixed cosmetic changes.
---
---
 drivers/net/ethernet/microsoft/mana/mana_en.c | 78 ++++++++++++++++++-
 include/net/mana/gdma.h                       |  7 +-
 include/net/mana/mana.h                       |  7 ++
 3 files changed, 90 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index cccd5b63cee6..636df3b066c5 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -298,6 +298,42 @@ static int mana_get_gso_hs(struct sk_buff *skb)
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
@@ -802,6 +838,23 @@ static int mana_change_mtu(struct net_device *ndev, int new_mtu)
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
@@ -884,7 +937,9 @@ static const struct net_device_ops mana_devops = {
 	.ndo_bpf		= mana_bpf,
 	.ndo_xdp_xmit		= mana_xdp_xmit,
 	.ndo_change_mtu		= mana_change_mtu,
-	.net_shaper_ops         = &mana_shaper_ops,
+	.ndo_tx_timeout		= mana_tx_timeout,
+	.net_shaper_ops		= &mana_shaper_ops,
+
 };
 
 static void mana_cleanup_port_context(struct mana_port_context *apc)
@@ -3244,6 +3299,7 @@ static int mana_probe_port(struct mana_context *ac, int port_idx,
 	ndev->min_mtu = ETH_MIN_MTU;
 	ndev->needed_headroom = MANA_HEADROOM;
 	ndev->dev_port = port_idx;
+	ndev->watchdog_timeo = 15 * HZ;
 	SET_NETDEV_DEV(ndev, gc->dev);
 
 	netif_set_tso_max_size(ndev, GSO_MAX_SIZE);
@@ -3283,6 +3339,10 @@ static int mana_probe_port(struct mana_context *ac, int port_idx,
 
 	debugfs_create_u32("current_speed", 0400, apc->mana_port_debugfs, &apc->speed);
 
+	/* Initialize the per port queue reset work.*/
+	INIT_WORK(&apc->queue_reset_work.work,
+		  mana_per_port_queue_reset_work_handler);
+
 	return 0;
 
 free_indir:
@@ -3488,6 +3548,15 @@ int mana_probe(struct gdma_dev *gd, bool resuming)
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
@@ -3557,6 +3626,8 @@ void mana_remove(struct gdma_dev *gd, bool suspending)
 			goto out;
 		}
 
+		disable_work_sync(&apc->queue_reset_work.work);
+
 		/* All cleanup actions should stay after rtnl_lock(), otherwise
 		 * other functions may access partially cleaned up data.
 		 */
@@ -3581,6 +3652,11 @@ void mana_remove(struct gdma_dev *gd, bool suspending)
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
index 637f42485dba..b892296705de 100644
--- a/include/net/mana/gdma.h
+++ b/include/net/mana/gdma.h
@@ -590,6 +590,10 @@ enum {
 
 /* Driver can self reset on FPGA Reconfig EQE notification */
 #define GDMA_DRV_CAP_FLAG_1_HANDLE_RECONFIG_EQE BIT(17)
+
+/* Driver detects stalled send queues and recovers them */
+#define GDMA_DRV_CAP_FLAG_1_HANDLE_STALL_SQ_RECOVERY BIT(18)
+
 #define GDMA_DRV_CAP_FLAG_1_HW_VPORT_LINK_AWARE BIT(6)
 
 #define GDMA_DRV_CAP_FLAGS1 \
@@ -601,7 +605,8 @@ enum {
 	 GDMA_DRV_CAP_FLAG_1_DYNAMIC_IRQ_ALLOC_SUPPORT | \
 	 GDMA_DRV_CAP_FLAG_1_SELF_RESET_ON_EQE | \
 	 GDMA_DRV_CAP_FLAG_1_HANDLE_RECONFIG_EQE | \
-	 GDMA_DRV_CAP_FLAG_1_HW_VPORT_LINK_AWARE)
+	 GDMA_DRV_CAP_FLAG_1_HW_VPORT_LINK_AWARE |\
+	 GDMA_DRV_CAP_FLAG_1_HANDLE_STALL_SQ_RECOVERY)
 
 #define GDMA_DRV_CAP_FLAGS2 0
 
diff --git a/include/net/mana/mana.h b/include/net/mana/mana.h
index 8906901535f5..095f5f1cb2ad 100644
--- a/include/net/mana/mana.h
+++ b/include/net/mana/mana.h
@@ -475,6 +475,7 @@ struct mana_context {
 
 	struct mana_eq *eqs;
 	struct dentry *mana_eqs_debugfs;
+	struct workqueue_struct *per_port_queue_reset_wq;
 
 	struct net_device *ports[MAX_PORTS_IN_MANA_DEV];
 
@@ -483,9 +484,15 @@ struct mana_context {
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


