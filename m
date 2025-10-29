Return-Path: <linux-hyperv+bounces-7376-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 228EFC1D414
	for <lists+linux-hyperv@lfdr.de>; Wed, 29 Oct 2025 21:44:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BA5884E1E71
	for <lists+linux-hyperv@lfdr.de>; Wed, 29 Oct 2025 20:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02E0A359FAF;
	Wed, 29 Oct 2025 20:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="gq3YGVmN"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39E95233722;
	Wed, 29 Oct 2025 20:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761770639; cv=none; b=Xty+wT0CIKhbRDtDiu8QzNHd/e7dhk0Tvjwwl+eXCA9jQlN/eYvPyyzV+uftfUoEoZy1Yan47Bp79WnFk8FHPuQnlF7jGy2E5yDDMgneCEdHC/41RBdjddl8RCM4DN29zGy0X6W4XXzJSIQE/xPCyRIaXp9/GGnZGYgKtj2PZDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761770639; c=relaxed/simple;
	bh=pLK0RmIcI+uBzpaVWm3UjzZFRr7tpTzhtKddIue0iKY=;
	h=From:To:Cc:Subject:Date:Message-Id; b=rphNYTE+pcCbzhFHHkr0t7CFT0Y5qVC3JzE0X4vpdirOR9tx3atBHMCrp1YTRXBuh8k2RP/J68gNKrCbRsNDHhQrH9yokJeWwarmNf+ZxzMEsEDtLRMrlOxO+gOZ2f6bdZSeUySBKRZ4CM0azJadEr1JnaOTTUCO9Lp2OGXQDSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=gq3YGVmN; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1006)
	id DC910211D8A7; Wed, 29 Oct 2025 13:43:51 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com DC910211D8A7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1761770631;
	bh=ijZ2rJhqIbi7vXqkeZlwbgMNLmV5tgqHCq7j6cxSiZ0=;
	h=From:To:Cc:Subject:Date:From;
	b=gq3YGVmNWlr9qLiZ+qH0AdxC1YswIWQoPJArSmvjk86p/y78ChvM7hs8ZjK5CCEts
	 PZzabpB6J9y1L9h7ngVl59KCPVWpdl9X1M95JO4nJnXFp76zmZsn5h+qklgavvhliq
	 kLKcBwq4x8t47ZHEAeZZKJyTN4mkfFeDwLE3keVw=
From: Haiyang Zhang <haiyangz@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org,
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
	Simon Horman <horms@kernel.org>,
	Leon Romanovsky <leon@kernel.org>,
	Shradha Gupta <shradhagupta@linux.microsoft.com>,
	Maxim Levitsky <mlevitsk@redhat.com>,
	Erni Sri Satya Vennela <ernis@linux.microsoft.com>,
	Yury Norov <yury.norov@gmail.com>,
	Dipayaan Roy <dipayanroy@linux.microsoft.com>,
	Shiraz Saleem <shirazsaleem@microsoft.com>,
	Saurabh Sengar <ssengar@linux.microsoft.com>,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org
Cc: paulros@microsoft.com
Subject: [net-next,v4] net: mana: Support HW link state events
Date: Wed, 29 Oct 2025 13:43:10 -0700
Message-Id: <1761770601-16920-1-git-send-email-haiyangz@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

From: Haiyang Zhang <haiyangz@microsoft.com>

Handle the NIC hardware link state events received from the HW
channel, then set the proper link state accordingly.

And, add a feature bit, GDMA_DRV_CAP_FLAG_1_HW_VPORT_LINK_AWARE,
to inform the NIC hardware this handler exists.

Our MANA NIC only sends out the link state down/up messages
when we need to let the VM rerun DHCP client and change IP
address. So, add netif_carrier_on() in the probe(), let the NIC
show the right initial state in /sys/class/net/ethX/operstate.

Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
---
v4:
  Remove the netif_carrier_ok(), and add READ/WRITE_ONCE. Also,
  more details in the commit message as suggested by Jakub Kicinski.

v3:
  Don't stop / start the queues, and use disable_work_sync() as
  suggested by Jakub Kicinski.

v2:
  Updated link up/down to be symmetric, and other minor changes based
  on comments from Andrew Lunn.

---
 .../net/ethernet/microsoft/mana/gdma_main.c   |  1 +
 .../net/ethernet/microsoft/mana/hw_channel.c  | 12 +++++
 drivers/net/ethernet/microsoft/mana/mana_en.c | 54 +++++++++++++++++--
 include/net/mana/gdma.h                       |  4 +-
 include/net/mana/hw_channel.h                 |  2 +
 include/net/mana/mana.h                       |  4 ++
 6 files changed, 71 insertions(+), 6 deletions(-)

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
index ada6c78a2bef..aa4e2731e2ba 100644
--- a/drivers/net/ethernet/microsoft/mana/hw_channel.c
+++ b/drivers/net/ethernet/microsoft/mana/hw_channel.c
@@ -118,6 +118,7 @@ static void mana_hwc_init_event_handler(void *ctx, struct gdma_queue *q_self,
 	struct gdma_dev *gd = hwc->gdma_dev;
 	union hwc_init_type_data type_data;
 	union hwc_init_eq_id_db eq_db;
+	struct mana_context *ac;
 	u32 type, val;
 	int ret;
 
@@ -196,6 +197,17 @@ static void mana_hwc_init_event_handler(void *ctx, struct gdma_queue *q_self,
 			hwc->hwc_timeout = val;
 			break;
 
+		case HWC_DATA_HW_LINK_CONNECT:
+		case HWC_DATA_HW_LINK_DISCONNECT:
+			ac = gd->gdma_context->mana.driver_data;
+			if (!ac)
+				break;
+
+			WRITE_ONCE(ac->link_event, type);
+			schedule_work(&ac->link_change_work);
+
+			break;
+
 		default:
 			dev_warn(hwc->dev, "Received unknown reconfig type %u\n", type);
 			break;
diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index 0142fd98392c..739087081dfd 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -20,6 +20,7 @@
 
 #include <net/mana/mana.h>
 #include <net/mana/mana_auxiliary.h>
+#include <net/mana/hw_channel.h>
 
 static DEFINE_IDA(mana_adev_ida);
 
@@ -84,7 +85,6 @@ static int mana_open(struct net_device *ndev)
 	/* Ensure port state updated before txq state */
 	smp_wmb();
 
-	netif_carrier_on(ndev);
 	netif_tx_wake_all_queues(ndev);
 	netdev_dbg(ndev, "%s successful\n", __func__);
 	return 0;
@@ -100,6 +100,46 @@ static int mana_close(struct net_device *ndev)
 	return mana_detach(ndev, true);
 }
 
+static void mana_link_state_handle(struct work_struct *w)
+{
+	struct mana_context *ac;
+	struct net_device *ndev;
+	u32 link_event;
+	bool link_up;
+	int i;
+
+	ac = container_of(w, struct mana_context, link_change_work);
+
+	rtnl_lock();
+
+	link_event = READ_ONCE(ac->link_event);
+
+	if (link_event == HWC_DATA_HW_LINK_CONNECT)
+		link_up = true;
+	else if (link_event == HWC_DATA_HW_LINK_DISCONNECT)
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
+		if (link_up) {
+			netif_carrier_on(ndev);
+
+			__netdev_notify_peers(ndev);
+		} else {
+			netif_carrier_off(ndev);
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
@@ -3059,9 +3099,6 @@ int mana_attach(struct net_device *ndev)
 	/* Ensure port state updated before txq state */
 	smp_wmb();
 
-	if (apc->port_is_up)
-		netif_carrier_on(ndev);
-
 	netif_device_attach(ndev);
 
 	return 0;
@@ -3154,7 +3191,6 @@ int mana_detach(struct net_device *ndev, bool from_close)
 	smp_wmb();
 
 	netif_tx_disable(ndev);
-	netif_carrier_off(ndev);
 
 	if (apc->port_st_save) {
 		err = mana_dealloc_queues(ndev);
@@ -3243,6 +3279,8 @@ static int mana_probe_port(struct mana_context *ac, int port_idx,
 		goto free_indir;
 	}
 
+	netif_carrier_on(ndev);
+
 	debugfs_create_u32("current_speed", 0400, apc->mana_port_debugfs, &apc->speed);
 
 	return 0;
@@ -3431,6 +3469,8 @@ int mana_probe(struct gdma_dev *gd, bool resuming)
 
 	if (!resuming) {
 		ac->num_ports = num_ports;
+
+		INIT_WORK(&ac->link_change_work, mana_link_state_handle);
 	} else {
 		if (ac->num_ports != num_ports) {
 			dev_err(dev, "The number of vPorts changed: %d->%d\n",
@@ -3438,6 +3478,8 @@ int mana_probe(struct gdma_dev *gd, bool resuming)
 			err = -EPROTO;
 			goto out;
 		}
+
+		enable_work(&ac->link_change_work);
 	}
 
 	if (ac->num_ports == 0)
@@ -3500,6 +3542,8 @@ void mana_remove(struct gdma_dev *gd, bool suspending)
 	int err;
 	int i;
 
+	disable_work_sync(&ac->link_change_work);
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
index 0921485565c0..8906901535f5 100644
--- a/include/net/mana/mana.h
+++ b/include/net/mana/mana.h
@@ -477,6 +477,10 @@ struct mana_context {
 	struct dentry *mana_eqs_debugfs;
 
 	struct net_device *ports[MAX_PORTS_IN_MANA_DEV];
+
+	/* Link state change work */
+	struct work_struct link_change_work;
+	u32 link_event;
 };
 
 struct mana_port_context {
-- 
2.34.1


