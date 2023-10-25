Return-Path: <linux-hyperv+bounces-581-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E59A77D7843
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Oct 2023 00:51:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 221341C20BE0
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Oct 2023 22:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF8EA30F9A;
	Wed, 25 Oct 2023 22:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxonhyperv.com header.i=@linuxonhyperv.com header.b="o/+Wfe6u"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 282B527EFF;
	Wed, 25 Oct 2023 22:50:56 +0000 (UTC)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0BF0DBB;
	Wed, 25 Oct 2023 15:50:55 -0700 (PDT)
Received: by linux.microsoft.com (Postfix, from userid 1004)
	id 9138220B74C1; Wed, 25 Oct 2023 15:50:54 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9138220B74C1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxonhyperv.com;
	s=default; t=1698274254;
	bh=4zQSWnZRUjjGv8tDmJQi574JQo3zw9n1/Nch+18x6iQ=;
	h=From:To:Cc:Subject:Date:From;
	b=o/+Wfe6uwOpezfWcHV78m4CysvZKlOLyu7LWMxmOKjDOAbAn/XtW3q5u0NCsNMV6h
	 29Ez6cGI5WpUOMosYNV+7FDyvqYPSwDFOILomAMzBHxOJOcgD3lRPHH58muaIFf7Dj
	 eUtxB3DiGe3Qtl2NAYZGuZYTBUCBSAolBZuq5Oqw=
From: longli@linuxonhyperv.com
To: "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: linux-rdma@vger.kernel.org,
	Long Li <longli@microsoft.com>
Subject: [PATCH] hv_netvsc: Mark VF as slave before exposing it to user-mode
Date: Wed, 25 Oct 2023 15:50:50 -0700
Message-Id: <1698274250-653-1-git-send-email-longli@linuxonhyperv.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

From: Long Li <longli@microsoft.com>

When a VF is being exposed form the kernel, it should be marked as "slave"
before exposing to the user-mode. The VF is not usable without netvsc running
as master. The user-mode should never see a VF without the "slave" flag.

This commit moves the code of setting the slave flag to the time before VF is
exposed to user-mode.

Signed-off-by: Long Li <longli@microsoft.com>
---
 drivers/net/hyperv/netvsc_drv.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/net/hyperv/netvsc_drv.c b/drivers/net/hyperv/netvsc_drv.c
index ec77fb9dcf89..045777a4971d 100644
--- a/drivers/net/hyperv/netvsc_drv.c
+++ b/drivers/net/hyperv/netvsc_drv.c
@@ -2206,9 +2206,6 @@ static int netvsc_vf_join(struct net_device *vf_netdev,
 		goto upper_link_failed;
 	}
 
-	/* set slave flag before open to prevent IPv6 addrconf */
-	vf_netdev->flags |= IFF_SLAVE;
-
 	schedule_delayed_work(&ndev_ctx->vf_takeover, VF_TAKEOVER_INT);
 
 	call_netdevice_notifiers(NETDEV_JOIN, vf_netdev);
@@ -2320,11 +2317,9 @@ static struct net_device *get_netvsc_byslot(const struct net_device *vf_netdev)
 	 */
 	list_for_each_entry(ndev_ctx, &netvsc_dev_list, list) {
 		ndev = hv_get_drvdata(ndev_ctx->device_ctx);
-		if (ether_addr_equal(vf_netdev->perm_addr, ndev->perm_addr)) {
-			netdev_notice(vf_netdev,
-				      "falling back to mac addr based matching\n");
+		if (ether_addr_equal(vf_netdev->perm_addr, ndev->perm_addr) ||
+		    ether_addr_equal(vf_netdev->dev_addr, ndev->perm_addr))
 			return ndev;
-		}
 	}
 
 	netdev_notice(vf_netdev,
@@ -2332,7 +2327,7 @@ static struct net_device *get_netvsc_byslot(const struct net_device *vf_netdev)
 	return NULL;
 }
 
-static int netvsc_register_vf(struct net_device *vf_netdev)
+static int netvsc_register_vf(struct net_device *vf_netdev, unsigned long event)
 {
 	struct net_device_context *net_device_ctx;
 	struct netvsc_device *netvsc_dev;
@@ -2347,6 +2342,12 @@ static int netvsc_register_vf(struct net_device *vf_netdev)
 	if (!ndev)
 		return NOTIFY_DONE;
 
+	if (event == NETDEV_POST_INIT) {
+		/* set slave flag before open to prevent IPv6 addrconf */
+		vf_netdev->flags |= IFF_SLAVE;
+		return NOTIFY_DONE;
+	}
+
 	net_device_ctx = netdev_priv(ndev);
 	netvsc_dev = rtnl_dereference(net_device_ctx->nvdev);
 	if (!netvsc_dev || rtnl_dereference(net_device_ctx->vf_netdev))
@@ -2753,8 +2754,9 @@ static int netvsc_netdev_event(struct notifier_block *this,
 		return NOTIFY_DONE;
 
 	switch (event) {
+	case NETDEV_POST_INIT:
 	case NETDEV_REGISTER:
-		return netvsc_register_vf(event_dev);
+		return netvsc_register_vf(event_dev, event);
 	case NETDEV_UNREGISTER:
 		return netvsc_unregister_vf(event_dev);
 	case NETDEV_UP:
-- 
2.34.1


