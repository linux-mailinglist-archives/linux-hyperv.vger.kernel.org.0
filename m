Return-Path: <linux-hyperv+bounces-7329-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B77AC0407D
	for <lists+linux-hyperv@lfdr.de>; Fri, 24 Oct 2025 03:42:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0863119A4EC8
	for <lists+linux-hyperv@lfdr.de>; Fri, 24 Oct 2025 01:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E90E1C3F36;
	Fri, 24 Oct 2025 01:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="MFOJezJY"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94C271A23A5;
	Fri, 24 Oct 2025 01:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761270119; cv=none; b=Pkcw4ac5abbfi1zSS54NExWkSAo1yB/NlYr3ruTATgbWYCCruJL1OgIT0qJ8EaWDhgBSEuhqjij2WKV/F8K184NEbg0Rb2q1fUIVq3z5pNvBKy3CgCnmn+mWFDcWdUUW5gqIeYQCNQzXdqWRDFQxHo+ztKcuIC3Z3A1hluExizg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761270119; c=relaxed/simple;
	bh=j+tLOqZxOfVSyc+ba/m0n9E6upA7m+p/jycHLMQi85k=;
	h=From:To:Cc:Subject:Date:Message-Id; b=vBP69smENG5WAA+0+kkV3X6nDPujNFDNcVm4EOvI2DlqVATJwhMs5dQSoltqGzk7Lr99FklEHdy1c4IN9+N9T6eJyPKl+p5elSnbgQD2WDr+8My1LTLuUl4y9mdPqzMURHeN2kOn0ZxviA0qUs79a3hmTLBixVwkKaMltxrWlG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=MFOJezJY; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1006)
	id 2A40A211AF3E; Thu, 23 Oct 2025 18:41:57 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2A40A211AF3E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1761270117;
	bh=6TzER48JPcpGKeFwhlFaQlS9mIdtWw6DFXG+mWlhVh4=;
	h=From:To:Cc:Subject:Date:From;
	b=MFOJezJYmEeDxiI12MeWLUf7FZJnG527r27+NJYV97aNxeXrJjDNA6L2wR6HIGHGS
	 YvjO8twfPYXA0am0NWx4mbMhNyVYePjbh9K1Ul2BYoMaH8IrMPpiQ+0BiextM4c+gC
	 52CGHrOqAn/BKZGxPM2LztE3vdNmW/xtdO2SvLQk=
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
Subject: [net-next, v3] net: mana: Support HW link state events
Date: Thu, 23 Oct 2025 18:41:45 -0700
Message-Id: <1761270105-27215-1-git-send-email-haiyangz@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

From: Haiyang Zhang <haiyangz@microsoft.com>

Handle the HW link state events received from HW channel, and
set the proper link state accordingly.

Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>

---
v3:
  Don't stop / start the queues, and use disable_work_sync() as
  suggested by Jakub Kicinski.

v2:
  Updated link up/down to be symmetric, and other minor changes based
  on comments from Andrew Lunn.

---
 .../net/ethernet/microsoft/mana/gdma_main.c   |  1 +
 .../net/ethernet/microsoft/mana/hw_channel.c  | 12 +++++
 drivers/net/ethernet/microsoft/mana/mana_en.c | 53 +++++++++++++++++--
 include/net/mana/gdma.h                       |  4 +-
 include/net/mana/hw_channel.h                 |  2 +
 include/net/mana/mana.h                       |  4 ++
 6 files changed, 70 insertions(+), 6 deletions(-)

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
index ada6c78a2bef..367e18d71413 100644
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
+			schedule_work(&ac->link_change_work);
+
+			break;
+
 		default:
 			dev_warn(hwc->dev, "Received unknown reconfig type %u\n", type);
 			break;
diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index 0142fd98392c..949aedebc8c3 100644
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
@@ -100,6 +100,45 @@ static int mana_close(struct net_device *ndev)
 	return mana_detach(ndev, true);
 }
 
+static void mana_link_state_handle(struct work_struct *w)
+{
+	struct mana_context *ac;
+	struct net_device *ndev;
+	bool link_up;
+	int i;
+
+	ac = container_of(w, struct mana_context, link_change_work);
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
+		if (link_up) {
+			if (!netif_carrier_ok(ndev))
+				netif_carrier_on(ndev);
+
+			__netdev_notify_peers(ndev);
+		} else {
+			if (netif_carrier_ok(ndev))
+				netif_carrier_off(ndev);
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
@@ -3059,9 +3098,6 @@ int mana_attach(struct net_device *ndev)
 	/* Ensure port state updated before txq state */
 	smp_wmb();
 
-	if (apc->port_is_up)
-		netif_carrier_on(ndev);
-
 	netif_device_attach(ndev);
 
 	return 0;
@@ -3154,7 +3190,6 @@ int mana_detach(struct net_device *ndev, bool from_close)
 	smp_wmb();
 
 	netif_tx_disable(ndev);
-	netif_carrier_off(ndev);
 
 	if (apc->port_st_save) {
 		err = mana_dealloc_queues(ndev);
@@ -3243,6 +3278,8 @@ static int mana_probe_port(struct mana_context *ac, int port_idx,
 		goto free_indir;
 	}
 
+	netif_carrier_on(ndev);
+
 	debugfs_create_u32("current_speed", 0400, apc->mana_port_debugfs, &apc->speed);
 
 	return 0;
@@ -3431,6 +3468,8 @@ int mana_probe(struct gdma_dev *gd, bool resuming)
 
 	if (!resuming) {
 		ac->num_ports = num_ports;
+
+		INIT_WORK(&ac->link_change_work, mana_link_state_handle);
 	} else {
 		if (ac->num_ports != num_ports) {
 			dev_err(dev, "The number of vPorts changed: %d->%d\n",
@@ -3438,6 +3477,8 @@ int mana_probe(struct gdma_dev *gd, bool resuming)
 			err = -EPROTO;
 			goto out;
 		}
+
+		enable_work(&ac->link_change_work);
 	}
 
 	if (ac->num_ports == 0)
@@ -3500,6 +3541,8 @@ void mana_remove(struct gdma_dev *gd, bool suspending)
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


