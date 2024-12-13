Return-Path: <linux-hyperv+bounces-3477-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 082B29F1730
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Dec 2024 21:11:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D82F162705
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Dec 2024 20:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39934191478;
	Fri, 13 Dec 2024 20:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxonhyperv.com header.i=@linuxonhyperv.com header.b="bUsl9Xks"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B33718FDBE;
	Fri, 13 Dec 2024 20:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734120386; cv=none; b=WS+EFUZmchgANShzcD4L2qvJryJcKmIQ9MxrIBr4r2NBHT2YFGlEUhOXacA7mCUELDVMtXRZ3T61UtO29j2MdyXHVtLCuwY8tko2YxSmqNEXp96jvvnU90AF64bCrkAabBEqD704RvpZ0VXACMALsoG1SjArYyKvUnxnRMBXwI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734120386; c=relaxed/simple;
	bh=PpdV+TAyG3tKXdPwl6HN0V9j9NLvFMFR7G1T99bJP4A=;
	h=From:To:Cc:Subject:Date:Message-Id; b=gTrtVQhc82KU26l8aCjBOtPuQwFWgLz4uoNxHo4JfYV4KdUUYmHphUjTNXtDEqMBl6ZVL5eovbx7i45/koORwm3k1acSG8X47Kp31s5JCA1kuOt1+DB8e0xSfihxxUEunbuFX7sWsnzdERqtB07K2HgPBhYLkiRiAT/gI0fE3WU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxonhyperv.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linuxonhyperv.com header.i=@linuxonhyperv.com header.b=bUsl9Xks; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxonhyperv.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1202)
	id 0CCBF20BCAD0; Fri, 13 Dec 2024 12:06:24 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0CCBF20BCAD0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxonhyperv.com;
	s=default; t=1734120384;
	bh=vJ1S+b1BSe5VAHRIRV0GkW0d4sHaXpM7+ERD6ffAyVE=;
	h=From:To:Cc:Subject:Date:From;
	b=bUsl9XksWclBwDTryioRbgDJcBWGomCsPSbbY003/uRc8A4dCpW+CVqRwunLyD8PB
	 +EVjyuA//sWeDmAjX5OqxZIZ7hVVSgF1hgTD2yn6bGQbIIlDFn/rscNSFFmY1+6SxO
	 VCOabvRZruoaaQ0IawAf86m9DlYMoIKcX61svFoM=
From: longli@linuxonhyperv.com
To: Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	Ajay Sharma <sharmaajay@microsoft.com>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Stephen Hemminger <stephen@networkplumber.org>
Cc: linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	Long Li <longli@microsoft.com>
Subject: [Patch net-next v2] hv_netvsc: Set device flags for properly indicating bonding in Hyper-V
Date: Fri, 13 Dec 2024 12:06:01 -0800
Message-Id: <1734120361-26599-1-git-send-email-longli@linuxonhyperv.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

From: Long Li <longli@microsoft.com>

On Hyper-V platforms, a slave VF netdev always bonds to Netvsc and remains
as Netvsc's only active slave as long as the slave device is present. This
behavior is not user-configurable.

Other kernel APIs (e.g those in "include/linux/netdevice.h") check for
IFF_MASTER, IFF_SLAVE and IFF_BONDING for determing if those are used
in a master/slave bonded setup. RDMA uses those APIs extensively when
looking for master/slave devices. Netvsc's bonding setup with its slave
device falls into this category.

Make hv_netvsc properly indicate bonding with its slave and change the
API to reflect this bonding setup.

Signed-off-by: Long Li <longli@microsoft.com>
---

Change log
v2: instead of re-using IFF_BOND, introduce permanent_bond in netdev

 drivers/net/hyperv/netvsc_drv.c | 12 ++++++++++++
 include/linux/netdevice.h       |  8 ++++++--
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/net/hyperv/netvsc_drv.c b/drivers/net/hyperv/netvsc_drv.c
index d6c4abfc3a28..7867f8e45f86 100644
--- a/drivers/net/hyperv/netvsc_drv.c
+++ b/drivers/net/hyperv/netvsc_drv.c
@@ -2204,6 +2204,10 @@ static int netvsc_vf_join(struct net_device *vf_netdev,
 		goto rx_handler_failed;
 	}
 
+	vf_netdev->permanent_bond = 1;
+	ndev->permanent_bond = 1;
+	ndev->flags |= IFF_MASTER;
+
 	ret = netdev_master_upper_dev_link(vf_netdev, ndev,
 					   NULL, NULL, NULL);
 	if (ret != 0) {
@@ -2484,7 +2488,15 @@ static int netvsc_unregister_vf(struct net_device *vf_netdev)
 
 	reinit_completion(&net_device_ctx->vf_add);
 	netdev_rx_handler_unregister(vf_netdev);
+
+	/* Unlink the slave device and clear flag */
+	vf_netdev->permanent_bond = 0;
+	ndev->permanent_bond = 0;
+	vf_netdev->flags &= ~IFF_SLAVE;
+	ndev->flags &= ~IFF_MASTER;
+
 	netdev_upper_dev_unlink(vf_netdev, ndev);
+
 	RCU_INIT_POINTER(net_device_ctx->vf_netdev, NULL);
 	dev_put(vf_netdev);
 
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index ecc686409161..4531f45d3e83 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -1997,6 +1997,7 @@ enum netdev_reg_state {
  *	@change_proto_down: device supports setting carrier via IFLA_PROTO_DOWN
  *	@netns_local: interface can't change network namespaces
  *	@fcoe_mtu:	device supports maximum FCoE MTU, 2158 bytes
+ *	@permanent_bond: device is permanently bonded to another device
  *
  *	@net_notifier_list:	List of per-net netdev notifier block
  *				that follow this device when it is moved
@@ -2402,6 +2403,7 @@ struct net_device {
 	unsigned long		change_proto_down:1;
 	unsigned long		netns_local:1;
 	unsigned long		fcoe_mtu:1;
+	unsigned long		permanent_bond:1;
 
 	struct list_head	net_notifier_list;
 
@@ -5150,12 +5152,14 @@ static inline bool netif_is_macvlan_port(const struct net_device *dev)
 
 static inline bool netif_is_bond_master(const struct net_device *dev)
 {
-	return dev->flags & IFF_MASTER && dev->priv_flags & IFF_BONDING;
+	return dev->flags & IFF_MASTER &&
+	       (dev->priv_flags & IFF_BONDING || dev->permanent_bond);
 }
 
 static inline bool netif_is_bond_slave(const struct net_device *dev)
 {
-	return dev->flags & IFF_SLAVE && dev->priv_flags & IFF_BONDING;
+	return dev->flags & IFF_SLAVE &&
+	       (dev->priv_flags & IFF_BONDING || dev->permanent_bond);
 }
 
 static inline bool netif_supports_nofcs(struct net_device *dev)
-- 
2.34.1


