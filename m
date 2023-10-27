Return-Path: <linux-hyperv+bounces-629-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 848557DA21E
	for <lists+linux-hyperv@lfdr.de>; Fri, 27 Oct 2023 23:00:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E3A2282561
	for <lists+linux-hyperv@lfdr.de>; Fri, 27 Oct 2023 21:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FE8B3D999;
	Fri, 27 Oct 2023 21:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxonhyperv.com header.i=@linuxonhyperv.com header.b="CBOIWIE3"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 707473C084;
	Fri, 27 Oct 2023 21:00:06 +0000 (UTC)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3D22E187;
	Fri, 27 Oct 2023 14:00:05 -0700 (PDT)
Received: by linux.microsoft.com (Postfix, from userid 1004)
	id 9D8C720B74C0; Fri, 27 Oct 2023 14:00:04 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9D8C720B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxonhyperv.com;
	s=default; t=1698440404;
	bh=tjnE9pRfC9wpL1nxaW/eCyk+NG9baQ7UvLcZ/DLAOVU=;
	h=From:To:Cc:Subject:Date:From;
	b=CBOIWIE367mUa46w0DH2cViihfVP/wILGd2QxuPGXJ6dhX36MPeJQ03W/tgH7f+c9
	 wYTGm0su2uLDq0O3A1rIi0V3BwpRNVbYzOeBA3Bzx06kb5x1cmTC++XZYs9gvgpcOE
	 9VaFmC7M1MMubiK819RDilJ4yDVrx4XFijiSWAW8=
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
Cc: Long Li <longli@microsoft.com>
Subject: [Patch v2] hv_netvsc: Mark VF as slave before exposing it to user-mode
Date: Fri, 27 Oct 2023 13:59:50 -0700
Message-Id: <1698440390-13719-1-git-send-email-longli@linuxonhyperv.com>
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

Change since v1:
Use a new function to handle NETDEV_POST_INIT.

 drivers/net/hyperv/netvsc_drv.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/net/hyperv/netvsc_drv.c b/drivers/net/hyperv/netvsc_drv.c
index ec77fb9dcf89..fdad58dcc6a8 100644
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
@@ -2332,6 +2327,19 @@ static struct net_device *get_netvsc_byslot(const struct net_device *vf_netdev)
 	return NULL;
 }
 
+static int netvsc_prepare_slave(struct net_device *vf_netdev)
+{
+	struct net_device *ndev;
+
+	ndev = get_netvsc_byslot(vf_netdev);
+	if (!ndev)
+		return NOTIFY_DONE;
+
+	/* set slave flag before open to prevent IPv6 addrconf */
+	vf_netdev->flags |= IFF_SLAVE;
+	return NOTIFY_DONE;
+}
+
 static int netvsc_register_vf(struct net_device *vf_netdev)
 {
 	struct net_device_context *net_device_ctx;
@@ -2753,6 +2761,8 @@ static int netvsc_netdev_event(struct notifier_block *this,
 		return NOTIFY_DONE;
 
 	switch (event) {
+	case NETDEV_POST_INIT:
+		return netvsc_prepare_slave(event_dev);
 	case NETDEV_REGISTER:
 		return netvsc_register_vf(event_dev);
 	case NETDEV_UNREGISTER:
-- 
2.34.1


