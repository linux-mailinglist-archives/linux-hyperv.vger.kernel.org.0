Return-Path: <linux-hyperv+bounces-7204-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BE90BD5F3F
	for <lists+linux-hyperv@lfdr.de>; Mon, 13 Oct 2025 21:33:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9953518A01ED
	for <lists+linux-hyperv@lfdr.de>; Mon, 13 Oct 2025 19:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3C4122D4E9;
	Mon, 13 Oct 2025 19:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="qV0EOtv0"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCB6319CCF5;
	Mon, 13 Oct 2025 19:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760384011; cv=none; b=NcCqV0AmQpCUmIz/L9gQVKC4rB7hXkvVgONjvmWmPD0lJoYQT6tvz9mMNL9rZ10ZVqBirgJCrF6zHIUDu7UfcVCQSKyYX628wDk1H7IKLhL3ttpNyClKa0UiO0qT0jbiwslJziFf+MO9i9PUIglySgzR3yqGrOhmQ7KGHx64crQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760384011; c=relaxed/simple;
	bh=IGRMjsapeQ0uT6RWpW+k4oJ+ncKVZV6zcCoqFxvaTs0=;
	h=From:To:Cc:Subject:Date:Message-Id; b=cT6g6PsLkGwoqtMI6/7EkW08DjhPCjYs+20tivjwKTSBbJAkh9lLHrKSDsp/dVd4490GYMvohQaD75PZ5a0BL9U40AsyYW3vzytVDEYLKQ3A/OdwsPPi4xMgM9DMVF30Lb0oxVe+uxKgnjlW2NtjtIEygFK6ziPPEb5ohvUbkgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=qV0EOtv0; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1006)
	id 4F5B62065942; Mon, 13 Oct 2025 12:33:29 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4F5B62065942
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1760384009;
	bh=PKEqWcC0OSttA8kSq08FINTe0UcdSEm7yoFon2Ds0yo=;
	h=From:To:Cc:Subject:Date:From;
	b=qV0EOtv07B4vz/z+m7iXRVZQ+/kz3j8e8wuXX/ES03DxBU42/f7yn9tkk8ww5EpnJ
	 wqExEwR62s351e+kY0B7lyoQwIVRCTanIZDv07iVmb9YF8WwDT+ZCN7uyuY55cYKWK
	 2TR7HHJuVCPwbnaMOKB6u43McGBFkuFl2vggRZFU=
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
Subject: [PATCH net-next] net: mana: Support HW link state events
Date: Mon, 13 Oct 2025 12:33:21 -0700
Message-Id: <1760384001-30805-1-git-send-email-haiyangz@linux.microsoft.com>
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
 .../net/ethernet/microsoft/mana/gdma_main.c   |  1 +
 .../net/ethernet/microsoft/mana/hw_channel.c  | 12 ++++
 drivers/net/ethernet/microsoft/mana/mana_en.c | 64 +++++++++++++++++--
 include/net/mana/gdma.h                       |  4 +-
 include/net/mana/hw_channel.h                 |  2 +
 include/net/mana/mana.h                       |  4 ++
 6 files changed, 79 insertions(+), 8 deletions(-)

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
index ada6c78a2bef..4d4113628027 100644
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
+			ac->link_event = type;
+			schedule_delayed_work(&ac->link_change_work, 0);
+
+			break;
+
 		default:
 			dev_warn(hwc->dev, "Received unknown reconfig type %u\n", type);
 			break;
diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index 0142fd98392c..1cf784740037 100644
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
@@ -100,6 +102,54 @@ static int mana_close(struct net_device *ndev)
 	return mana_detach(ndev, true);
 }
 
+static void mana_link_state_handle(struct work_struct *w)
+{
+	struct mana_context *ac =
+		container_of(w, struct mana_context, link_change_work.work);
+	struct mana_port_context *apc;
+	struct net_device *ndev;
+	bool link_up;
+	int i;
+
+	if (!rtnl_trylock()) {
+		schedule_delayed_work(&ac->link_change_work, 1);
+		return;
+	}
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
+			netif_carrier_on(ndev);
+
+			if (apc->port_is_up)
+				netif_tx_wake_all_queues(ndev);
+
+			__netdev_notify_peers(ndev);
+		} else {
+			if (netif_carrier_ok(ndev)) {
+				netif_tx_disable(ndev);
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
@@ -3059,9 +3109,6 @@ int mana_attach(struct net_device *ndev)
 	/* Ensure port state updated before txq state */
 	smp_wmb();
 
-	if (apc->port_is_up)
-		netif_carrier_on(ndev);
-
 	netif_device_attach(ndev);
 
 	return 0;
@@ -3154,7 +3201,6 @@ int mana_detach(struct net_device *ndev, bool from_close)
 	smp_wmb();
 
 	netif_tx_disable(ndev);
-	netif_carrier_off(ndev);
 
 	if (apc->port_st_save) {
 		err = mana_dealloc_queues(ndev);
@@ -3212,7 +3258,7 @@ static int mana_probe_port(struct mana_context *ac, int port_idx,
 
 	netif_set_tso_max_size(ndev, GSO_MAX_SIZE);
 
-	netif_carrier_off(ndev);
+	netif_carrier_on(ndev);
 
 	netdev_rss_key_fill(apc->hashkey, MANA_HASH_KEY_SIZE);
 
@@ -3431,6 +3477,8 @@ int mana_probe(struct gdma_dev *gd, bool resuming)
 
 	if (!resuming) {
 		ac->num_ports = num_ports;
+
+		INIT_DELAYED_WORK(&ac->link_change_work, mana_link_state_handle);
 	} else {
 		if (ac->num_ports != num_ports) {
 			dev_err(dev, "The number of vPorts changed: %d->%d\n",
@@ -3500,6 +3548,8 @@ void mana_remove(struct gdma_dev *gd, bool suspending)
 	int err;
 	int i;
 
+	cancel_delayed_work_sync(&ac->link_change_work);
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
index 0921485565c0..eee90bb9da1e 100644
--- a/include/net/mana/mana.h
+++ b/include/net/mana/mana.h
@@ -477,6 +477,10 @@ struct mana_context {
 	struct dentry *mana_eqs_debugfs;
 
 	struct net_device *ports[MAX_PORTS_IN_MANA_DEV];
+
+	/* Link state change work */
+	struct delayed_work link_change_work;
+	u32 link_event;
 };
 
 struct mana_port_context {
-- 
2.34.1


