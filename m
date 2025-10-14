Return-Path: <linux-hyperv+bounces-7216-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 9223CBDB688
	for <lists+linux-hyperv@lfdr.de>; Tue, 14 Oct 2025 23:27:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D3C93352B1C
	for <lists+linux-hyperv@lfdr.de>; Tue, 14 Oct 2025 21:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3335830C361;
	Tue, 14 Oct 2025 21:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Y4MUHUT9"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2789B270553;
	Tue, 14 Oct 2025 21:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760477242; cv=none; b=Hu3wE9jxOxjHaNd8rdiX35FZEtoePNQnsWN9BiyT8chPXzriSsPDSKYVn+Poic+rR0+8j02EDMPBdM5YeZjKPS878loWk+fashQV0uHtWJgQXVA7DFNsXkHOhDaX5eR/MOh7LtdzTJBAnQ03BRkAFPIV8FWUs2o1DoH0J5/W3mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760477242; c=relaxed/simple;
	bh=FZEEdU24UxBJeTL+XTVmDjgu7pDp5qgDs7GTltmTjCc=;
	h=From:To:Cc:Subject:Date:Message-Id; b=hLJW4xMak7xNQRLwEkZiELINzNNOtOv6wENqBferxxFZOhqi3bjV1PNIb1br+YLCgkyu69fxhN8uYLs4/GM61LDpvJB/DHI3OAbX9TS56ppzFf7w+G7NaMD/Iu2FsVeo72ZkjknhdUOvo3pgPWeC8COnsKqgHgpjqxMGnR6//V8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Y4MUHUT9; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1006)
	id AC971206596C; Tue, 14 Oct 2025 14:27:19 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com AC971206596C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1760477239;
	bh=mOLifcEof82JC7MsvCTYACckyTNoj1LBbMyEvy7qcyo=;
	h=From:To:Cc:Subject:Date:From;
	b=Y4MUHUT9aL1mLYq1E97ysNWfSicPWaCg0xzogluhXpHK1GQieNIZtZ48Dno4CTMi/
	 U1JJqUS+/RHIZRn6YREauzgluifxgYbJ67F1ffNV19JDbqrbQYqGSWn9F7sSY5AHiA
	 KK1aM5B/cdKm/A9k2GvLgl+w8uMq7brpe4WECy1w=
From: Haiyang Zhang <haiyangz@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org
Cc: haiyangz@microsoft.com,
	paulros@microsoft.com,
	decui@microsoft.com,
	kys@microsoft.com,
	wei.liu@kernel.org,
	edumazet@google.com,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	longli@microsoft.com,
	ssengar@linux.microsoft.com,
	ernis@linux.microsoft.com,
	dipayanroy@linux.microsoft.com,
	kotaranov@microsoft.com,
	horms@kernel.org,
	shradhagupta@linux.microsoft.com,
	leon@kernel.org,
	mlevitsk@redhat.com,
	yury.norov@gmail.com,
	shirazsaleem@microsoft.com,
	andrew+netdev@lunn.ch,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next,v2] net: mana: Support HW link state events
Date: Tue, 14 Oct 2025 14:26:49 -0700
Message-Id: <1760477209-9026-1-git-send-email-haiyangz@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

From: Haiyang Zhang <haiyangz@microsoft.com>

Handle the HW link state events received from HW channel, and
set the proper link state, also stop/wake queues accordingly.

Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
---
v2:
  Updated link up/down to be symmetric, and other minor changes based
  on comments from Andrew Lunn.

---
 .../net/ethernet/microsoft/mana/gdma_main.c   |  1 +
 .../net/ethernet/microsoft/mana/hw_channel.c  | 19 +++++
 drivers/net/ethernet/microsoft/mana/mana_en.c | 76 +++++++++++++++++--
 include/net/mana/gdma.h                       |  4 +-
 include/net/mana/hw_channel.h                 |  2 +
 include/net/mana/mana.h                       |  6 ++
 6 files changed, 99 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/net/ethernet/microsoft/mana/gdma_main.c
index 43f034e180c4..effe0a2f207a 100644
--- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
+++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
@@ -528,6 +528,7 @@ static void mana_gd_process_eqe(struct gdma_queue *eq)
 	case GDMA_EQE_HWC_INIT_DONE:
 	case GDMA_EQE_HWC_SOC_SERVICE:
 	case GDMA_EQE_RNIC_QP_FATAL:
+	case GDMA_EQE_HWC_SOC_RECONFIG_DATA:
 		if (!eq->eq.callback)
 			break;
 
diff --git a/drivers/net/ethernet/microsoft/mana/hw_channel.c b/drivers/net/ethernet/microsoft/mana/hw_channel.c
index ada6c78a2bef..eae68995492a 100644
--- a/drivers/net/ethernet/microsoft/mana/hw_channel.c
+++ b/drivers/net/ethernet/microsoft/mana/hw_channel.c
@@ -118,6 +118,7 @@ static void mana_hwc_init_event_handler(void *ctx, struct gdma_queue *q_self,
 	struct gdma_dev *gd = hwc->gdma_dev;
 	union hwc_init_type_data type_data;
 	union hwc_init_eq_id_db eq_db;
+	struct mana_context *ac;
 	u32 type, val;
 	int ret;
 
@@ -196,6 +197,24 @@ static void mana_hwc_init_event_handler(void *ctx, struct gdma_queue *q_self,
 			hwc->hwc_timeout = val;
 			break;
 
+		case HWC_DATA_HW_LINK_CONNECT:
+		case HWC_DATA_HW_LINK_DISCONNECT:
+			ac = gd->gdma_context->mana.driver_data;
+			if (!ac)
+				break;
+
+			if (ac->mana_removing) {
+				dev_info(hwc->dev,
+					 "Removing: skip link event %u\n",
+					 type);
+				break;
+			}
+
+			ac->link_event = type;
+			schedule_work(&ac->link_change_work);
+
+			break;
+
 		default:
 			dev_warn(hwc->dev, "Received unknown reconfig type %u\n", type);
 			break;
diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index 0142fd98392c..51959d37b0a7 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -20,6 +20,7 @@
 
 #include <net/mana/mana.h>
 #include <net/mana/mana_auxiliary.h>
+#include <net/mana/hw_channel.h>
 
 static DEFINE_IDA(mana_adev_ida);
 
@@ -84,8 +85,9 @@ static int mana_open(struct net_device *ndev)
 	/* Ensure port state updated before txq state */
 	smp_wmb();
 
-	netif_carrier_on(ndev);
-	netif_tx_wake_all_queues(ndev);
+	if (netif_carrier_ok(ndev))
+		netif_tx_wake_all_queues(ndev);
+
 	netdev_dbg(ndev, "%s successful\n", __func__);
 	return 0;
 }
@@ -100,6 +102,59 @@ static int mana_close(struct net_device *ndev)
 	return mana_detach(ndev, true);
 }
 
+static void mana_link_state_handle(struct work_struct *w)
+{
+	struct mana_port_context *apc;
+	struct mana_context *ac;
+	struct net_device *ndev;
+	bool link_up;
+	int i;
+
+	ac = container_of(w, struct mana_context, link_change_work);
+
+	if (ac->mana_removing)
+		return;
+
+	rtnl_lock();
+
+	if (ac->link_event == HWC_DATA_HW_LINK_CONNECT)
+		link_up = true;
+	else if (ac->link_event == HWC_DATA_HW_LINK_DISCONNECT)
+		link_up = false;
+	else
+		goto out;
+
+	/* Process all ports */
+	for (i = 0; i < ac->num_ports; i++) {
+		ndev = ac->ports[i];
+		if (!ndev)
+			continue;
+
+		apc = netdev_priv(ndev);
+
+		if (link_up) {
+			if (!netif_carrier_ok(ndev)) {
+				netif_carrier_on(ndev);
+
+				if (apc->port_is_up)
+					netif_tx_wake_all_queues(ndev);
+			}
+
+			__netdev_notify_peers(ndev);
+		} else {
+			if (netif_carrier_ok(ndev)) {
+				if (apc->port_is_up)
+					netif_tx_disable(ndev);
+
+				netif_carrier_off(ndev);
+			}
+		}
+	}
+
+out:
+	rtnl_unlock();
+}
+
 static bool mana_can_tx(struct gdma_queue *wq)
 {
 	return mana_gd_wq_avail_space(wq) >= MAX_TX_WQE_SIZE;
@@ -3059,9 +3114,6 @@ int mana_attach(struct net_device *ndev)
 	/* Ensure port state updated before txq state */
 	smp_wmb();
 
-	if (apc->port_is_up)
-		netif_carrier_on(ndev);
-
 	netif_device_attach(ndev);
 
 	return 0;
@@ -3153,8 +3205,8 @@ int mana_detach(struct net_device *ndev, bool from_close)
 	/* Ensure port state updated before txq state */
 	smp_wmb();
 
-	netif_tx_disable(ndev);
-	netif_carrier_off(ndev);
+	if (netif_carrier_ok(ndev))
+		netif_tx_disable(ndev);
 
 	if (apc->port_st_save) {
 		err = mana_dealloc_queues(ndev);
@@ -3212,7 +3264,7 @@ static int mana_probe_port(struct mana_context *ac, int port_idx,
 
 	netif_set_tso_max_size(ndev, GSO_MAX_SIZE);
 
-	netif_carrier_off(ndev);
+	netif_carrier_on(ndev);
 
 	netdev_rss_key_fill(apc->hashkey, MANA_HASH_KEY_SIZE);
 
@@ -3431,6 +3483,8 @@ int mana_probe(struct gdma_dev *gd, bool resuming)
 
 	if (!resuming) {
 		ac->num_ports = num_ports;
+
+		INIT_WORK(&ac->link_change_work, mana_link_state_handle);
 	} else {
 		if (ac->num_ports != num_ports) {
 			dev_err(dev, "The number of vPorts changed: %d->%d\n",
@@ -3481,6 +3535,8 @@ int mana_probe(struct gdma_dev *gd, bool resuming)
 	if (err) {
 		mana_remove(gd, false);
 	} else {
+		ac->mana_removing = false;
+
 		dev_dbg(dev, "gd=%p, id=%u, num_ports=%d, type=%u, instance=%u\n",
 			gd, gd->dev_id.as_uint32, ac->num_ports,
 			gd->dev_id.type, gd->dev_id.instance);
@@ -3500,6 +3556,10 @@ void mana_remove(struct gdma_dev *gd, bool suspending)
 	int err;
 	int i;
 
+	ac->mana_removing = true;
+
+	cancel_work_sync(&ac->link_change_work);
+
 	/* adev currently doesn't support suspending, always remove it */
 	if (gd->adev)
 		remove_adev(gd);
diff --git a/include/net/mana/gdma.h b/include/net/mana/gdma.h
index 57df78cfbf82..637f42485dba 100644
--- a/include/net/mana/gdma.h
+++ b/include/net/mana/gdma.h
@@ -590,6 +590,7 @@ enum {
 
 /* Driver can self reset on FPGA Reconfig EQE notification */
 #define GDMA_DRV_CAP_FLAG_1_HANDLE_RECONFIG_EQE BIT(17)
+#define GDMA_DRV_CAP_FLAG_1_HW_VPORT_LINK_AWARE BIT(6)
 
 #define GDMA_DRV_CAP_FLAGS1 \
 	(GDMA_DRV_CAP_FLAG_1_EQ_SHARING_MULTI_VPORT | \
@@ -599,7 +600,8 @@ enum {
 	 GDMA_DRV_CAP_FLAG_1_DEV_LIST_HOLES_SUP | \
 	 GDMA_DRV_CAP_FLAG_1_DYNAMIC_IRQ_ALLOC_SUPPORT | \
 	 GDMA_DRV_CAP_FLAG_1_SELF_RESET_ON_EQE | \
-	 GDMA_DRV_CAP_FLAG_1_HANDLE_RECONFIG_EQE)
+	 GDMA_DRV_CAP_FLAG_1_HANDLE_RECONFIG_EQE | \
+	 GDMA_DRV_CAP_FLAG_1_HW_VPORT_LINK_AWARE)
 
 #define GDMA_DRV_CAP_FLAGS2 0
 
diff --git a/include/net/mana/hw_channel.h b/include/net/mana/hw_channel.h
index 83cf93338eb3..16feb39616c1 100644
--- a/include/net/mana/hw_channel.h
+++ b/include/net/mana/hw_channel.h
@@ -24,6 +24,8 @@
 #define HWC_INIT_DATA_PF_DEST_CQ_ID	11
 
 #define HWC_DATA_CFG_HWC_TIMEOUT 1
+#define HWC_DATA_HW_LINK_CONNECT 2
+#define HWC_DATA_HW_LINK_DISCONNECT 3
 
 #define HW_CHANNEL_WAIT_RESOURCE_TIMEOUT_MS 30000
 
diff --git a/include/net/mana/mana.h b/include/net/mana/mana.h
index 0921485565c0..d59e1f4656ce 100644
--- a/include/net/mana/mana.h
+++ b/include/net/mana/mana.h
@@ -477,6 +477,12 @@ struct mana_context {
 	struct dentry *mana_eqs_debugfs;
 
 	struct net_device *ports[MAX_PORTS_IN_MANA_DEV];
+
+	/* Link state change work */
+	struct work_struct link_change_work;
+	u32 link_event;
+
+	bool mana_removing;
 };
 
 struct mana_port_context {
-- 
2.34.1


