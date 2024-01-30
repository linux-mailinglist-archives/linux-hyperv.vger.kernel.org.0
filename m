Return-Path: <linux-hyperv+bounces-1477-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 438D7841C6E
	for <lists+linux-hyperv@lfdr.de>; Tue, 30 Jan 2024 08:19:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A7E228618D
	for <lists+linux-hyperv@lfdr.de>; Tue, 30 Jan 2024 07:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24F074C618;
	Tue, 30 Jan 2024 07:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Sn9C0PKK"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B28C26AC7;
	Tue, 30 Jan 2024 07:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706599144; cv=none; b=CW2TGJqn4b60KybrYk9kreSBbCcmiKzm7X21RBsDBKo+hMTM9o1PYCnHlYtD2ldC5i0Czl47mx1g9jl0d/77ePkoGWlyECG8RXHStD4xN5PbleF2y2JE2nmW5SnJ5mBPK074XV/49+njdpgkoeCssTBqoQ6TeA3xex8itldrQLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706599144; c=relaxed/simple;
	bh=XD0iHpQFJ0q6NZTMOVuKJqYMVJwALyyXiYdp7IAr+OQ=;
	h=From:To:Cc:Subject:Date:Message-Id; b=hQXlMbQEChoLY84Tg18LET3MGbtY3PTT0n/ne/Kk2j3udNYC7oUwGP2TX+U2c2zxEGgunMmrYQCLo2YVmPg5CndjIrCNGQ6kFc4yKe9vQN4eFsOuvBv1RU0cTkrP5T/gYKjOYQd2HZz2wnVQrqhPLf7cCgtksW9kAnbiIvW7sOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Sn9C0PKK; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1134)
	id 8875920B2000; Mon, 29 Jan 2024 23:18:56 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8875920B2000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1706599136;
	bh=KFdAJcXVrqcUHwnaCxf3QIvJzyS/dFmrIoKhQOSds9g=;
	h=From:To:Cc:Subject:Date:From;
	b=Sn9C0PKKkRuccV6/DavK5CClBZPt3JRklmnKX5xKKvK/bcQZR8Azy7qhwbwD97MfX
	 bY5ssVZDmaWP5qnjwuVz+ccR/c9JQSTR12RMPj2nSxqLtmLVjsAMyIa1JSnLtYIsWh
	 lscE9CqeBH3nMk4R8tXzoQ1Do+tNuDcCbCwxh6kk=
From: Shradha Gupta <shradhagupta@linux.microsoft.com>
To: "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Shradha Gupta <shradhagupta@linux.microsoft.com>,
	shradhagupta@microsoft.com,
	stable@vger.kernel.org
Subject: [PATCH] hv_netvsc:Register VF in netvsc_probe if NET_DEVICE_REGISTER missed
Date: Mon, 29 Jan 2024 23:18:55 -0800
Message-Id: <1706599135-12651-1-git-send-email-shradhagupta@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

If hv_netvsc driver is removed and reloaded, the NET_DEVICE_REGISTER
handler cannot perform VF register successfully as the register call
is received before netvsc_probe is finished. This is because we
register register_netdevice_notifier() very early(even before
vmbus_driver_register()).
To fix this, we try to register each such matching VF( if it is visible
as a netdevice) at the end of netvsc_probe.

Cc: stable@vger.kernel.org
Fixes: 85520856466e ("hv_netvsc: Fix race of register_netdevice_notifier and VF register")
Suggested-by: Dexuan Cui <decui@microsoft.com>
Signed-off-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
Tested-on: Ubuntu22
Testcases: LISA testsuites
	   verify_reload_hyperv_modules, perf_tcp_ntttcp_sriov
---
 drivers/net/hyperv/netvsc_drv.c | 49 ++++++++++++++++++++++++++++-----
 1 file changed, 42 insertions(+), 7 deletions(-)

diff --git a/drivers/net/hyperv/netvsc_drv.c b/drivers/net/hyperv/netvsc_drv.c
index 706ea5263e87..25c4dc9cc4bd 100644
--- a/drivers/net/hyperv/netvsc_drv.c
+++ b/drivers/net/hyperv/netvsc_drv.c
@@ -42,6 +42,10 @@
 #define LINKCHANGE_INT (2 * HZ)
 #define VF_TAKEOVER_INT (HZ / 10)
 
+/* Macros to define the context of vf registration */
+#define VF_REG_IN_PROBE		1
+#define VF_REG_IN_RECV_CBACK	2
+
 static unsigned int ring_size __ro_after_init = 128;
 module_param(ring_size, uint, 0444);
 MODULE_PARM_DESC(ring_size, "Ring buffer size (# of pages)");
@@ -2183,7 +2187,7 @@ static rx_handler_result_t netvsc_vf_handle_frame(struct sk_buff **pskb)
 }
 
 static int netvsc_vf_join(struct net_device *vf_netdev,
-			  struct net_device *ndev)
+			  struct net_device *ndev, int context)
 {
 	struct net_device_context *ndev_ctx = netdev_priv(ndev);
 	int ret;
@@ -2205,8 +2209,11 @@ static int netvsc_vf_join(struct net_device *vf_netdev,
 			   ndev->name, ret);
 		goto upper_link_failed;
 	}
-
-	schedule_delayed_work(&ndev_ctx->vf_takeover, VF_TAKEOVER_INT);
+	/* If this registration is called from probe context vf_takeover
+	 * is taken care of later in probe itself.
+	 */
+	if (context == VF_REG_IN_RECV_CBACK)
+		schedule_delayed_work(&ndev_ctx->vf_takeover, VF_TAKEOVER_INT);
 
 	call_netdevice_notifiers(NETDEV_JOIN, vf_netdev);
 
@@ -2344,7 +2351,7 @@ static int netvsc_prepare_bonding(struct net_device *vf_netdev)
 	return NOTIFY_DONE;
 }
 
-static int netvsc_register_vf(struct net_device *vf_netdev)
+static int netvsc_register_vf(struct net_device *vf_netdev, int context)
 {
 	struct net_device_context *net_device_ctx;
 	struct netvsc_device *netvsc_dev;
@@ -2384,7 +2391,7 @@ static int netvsc_register_vf(struct net_device *vf_netdev)
 
 	netdev_info(ndev, "VF registering: %s\n", vf_netdev->name);
 
-	if (netvsc_vf_join(vf_netdev, ndev) != 0)
+	if (netvsc_vf_join(vf_netdev, ndev, context) != 0)
 		return NOTIFY_DONE;
 
 	dev_hold(vf_netdev);
@@ -2485,7 +2492,7 @@ static int netvsc_unregister_vf(struct net_device *vf_netdev)
 static int netvsc_probe(struct hv_device *dev,
 			const struct hv_vmbus_device_id *dev_id)
 {
-	struct net_device *net = NULL;
+	struct net_device *net = NULL, *vf_netdev;
 	struct net_device_context *net_device_ctx;
 	struct netvsc_device_info *device_info = NULL;
 	struct netvsc_device *nvdev;
@@ -2597,6 +2604,34 @@ static int netvsc_probe(struct hv_device *dev,
 	}
 
 	list_add(&net_device_ctx->list, &netvsc_dev_list);
+
+	/* When the hv_netvsc driver is removed and readded, the
+	 * NET_DEVICE_REGISTER for the vf device is replayed before probe
+	 * is complete. This is because register_netdevice_notifier() gets
+	 * registered before vmbus_driver_register() so that callback func
+	 * is set before probe and we don't miss events like NETDEV_POST_INIT
+	 * So, in this section we try to register each matching
+	 * vf device that is present as a netdevice, knowing that it's register
+	 * call is not processed in the netvsc_netdev_notifier(as probing is
+	 * progress and get_netvsc_byslot fails).
+	 */
+	for_each_netdev(dev_net(net), vf_netdev) {
+		if (vf_netdev->netdev_ops == &device_ops)
+			continue;
+
+		if (vf_netdev->type != ARPHRD_ETHER)
+			continue;
+
+		if (is_vlan_dev(vf_netdev))
+			continue;
+
+		if (netif_is_bond_master(vf_netdev))
+			continue;
+
+		netvsc_prepare_bonding(vf_netdev);
+		netvsc_register_vf(vf_netdev, VF_REG_IN_PROBE);
+		__netvsc_vf_setup(net, vf_netdev);
+	}
 	rtnl_unlock();
 
 	netvsc_devinfo_put(device_info);
@@ -2773,7 +2808,7 @@ static int netvsc_netdev_event(struct notifier_block *this,
 	case NETDEV_POST_INIT:
 		return netvsc_prepare_bonding(event_dev);
 	case NETDEV_REGISTER:
-		return netvsc_register_vf(event_dev);
+		return netvsc_register_vf(event_dev, VF_REG_IN_RECV_CBACK);
 	case NETDEV_UNREGISTER:
 		return netvsc_unregister_vf(event_dev);
 	case NETDEV_UP:
-- 
2.34.1


