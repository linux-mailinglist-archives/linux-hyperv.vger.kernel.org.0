Return-Path: <linux-hyperv+bounces-4240-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71399A50E7C
	for <lists+linux-hyperv@lfdr.de>; Wed,  5 Mar 2025 23:22:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD5633A4717
	for <lists+linux-hyperv@lfdr.de>; Wed,  5 Mar 2025 22:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5B45266576;
	Wed,  5 Mar 2025 22:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxonhyperv.com header.i=@linuxonhyperv.com header.b="CsZWzDKf"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B662146588;
	Wed,  5 Mar 2025 22:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741213374; cv=none; b=l4B4EhdEonP4qsa/evMfBWPy6xR768uk97EnL/dJletK5XWk3PrkZvmOPU8Is/sKf1TGp47SL04vppjkGD2KPWMS59FQ3BNrS0W7NmRGAsp8wam2ffC3fw9ntBm6XzK+yumeP3fjQbkIcD5+IAWMl8mjadZ9jR2zy5tdqLijLoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741213374; c=relaxed/simple;
	bh=0o4weJ+KgysiO9Mt1rap+L4SV9i8KLmCIvOPJMjt5Ww=;
	h=From:To:Cc:Subject:Date:Message-Id; b=NR/GW5EvP4cAOhuKz5R9nNwCMBDcloVpgXJL5rHG6sxCfBzh3+yMUsWRhcVNnU98jFJEEzBMP92JyKfls4BvCw1lq9U+eSTicowJbph0NRLHtPXLiNhmfQ4zmC8fcKkE6iD37aL1IKa9Dvj9V/nKjj54yByJZcpgyGeMfumltu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxonhyperv.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linuxonhyperv.com header.i=@linuxonhyperv.com header.b=CsZWzDKf; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxonhyperv.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1202)
	id AE8DD210EAE9; Wed,  5 Mar 2025 14:22:52 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com AE8DD210EAE9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxonhyperv.com;
	s=default; t=1741213372;
	bh=RspJRdagYaj1rzMO5hoDvU2sJmUeCTW8jfbzZOY0F2Y=;
	h=From:To:Cc:Subject:Date:From;
	b=CsZWzDKfMEcmrtCScboHHLJ99xkVNZs5LGbbRLcz3M3GvXM3kNnUQdHUenXcPhbOd
	 38yg/ix01irQ8Fi5+pUDDPFARc1X5x3GEd6HLh5JAPYx5eY2xmSxAEa017BYUjq0hy
	 OUGoPH2/jRv8t0V9wtrag1HRwAeyrYtI4mJrUx+Q=
From: longli@linuxonhyperv.com
To: Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	Long Li <longli@microsoft.com>
Subject: [patch rdma-next v4 1/2] net: mana: Change the function signature of mana_get_primary_netdev_rcu
Date: Wed,  5 Mar 2025 14:22:39 -0800
Message-Id: <1741213360-14567-1-git-send-email-longli@linuxonhyperv.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

From: Long Li <longli@microsoft.com>

Change mana_get_primary_netdev_rcu() to mana_get_primary_netdev(), and
return the ndev with refcount held. The caller is responsible for dropping
the refcount.

Also drop the check for IFF_SLAVE as it is not necessary if the upper
device is present.

Signed-off-by: Long Li <longli@microsoft.com>
---
Changes
v4: use netdev_hold()/netdev_put() and remove the check for IFF_SLAVE

 drivers/infiniband/hw/mana/device.c           |  7 +++----
 drivers/net/ethernet/microsoft/mana/mana_en.c | 20 +++++++++++--------
 include/net/mana/mana.h                       |  2 +-
 3 files changed, 16 insertions(+), 13 deletions(-)

diff --git a/drivers/infiniband/hw/mana/device.c b/drivers/infiniband/hw/mana/device.c
index 3416a85f8738..2b4dd34a41ba 100644
--- a/drivers/infiniband/hw/mana/device.c
+++ b/drivers/infiniband/hw/mana/device.c
@@ -84,10 +84,8 @@ static int mana_ib_probe(struct auxiliary_device *adev,
 	dev->ib_dev.num_comp_vectors = mdev->gdma_context->max_num_queues;
 	dev->ib_dev.dev.parent = mdev->gdma_context->dev;
 
-	rcu_read_lock(); /* required to get primary netdev */
-	ndev = mana_get_primary_netdev_rcu(mc, 0);
+	ndev = mana_get_primary_netdev(mc, 0);
 	if (!ndev) {
-		rcu_read_unlock();
 		ret = -ENODEV;
 		ibdev_err(&dev->ib_dev, "Failed to get netdev for IB port 1");
 		goto free_ib_device;
@@ -95,7 +93,8 @@ static int mana_ib_probe(struct auxiliary_device *adev,
 	ether_addr_copy(mac_addr, ndev->dev_addr);
 	addrconf_addr_eui48((u8 *)&dev->ib_dev.node_guid, ndev->dev_addr);
 	ret = ib_device_set_netdev(&dev->ib_dev, ndev, 1);
-	rcu_read_unlock();
+	/* mana_get_primary_netdev() returns ndev with refcount held */
+	netdev_put(ndev, NULL);
 	if (ret) {
 		ibdev_err(&dev->ib_dev, "Failed to set ib netdev, ret %d", ret);
 		goto free_ib_device;
diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index aa1e47233fe5..a8e7f030c11b 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -3131,21 +3131,25 @@ void mana_remove(struct gdma_dev *gd, bool suspending)
 	kfree(ac);
 }
 
-struct net_device *mana_get_primary_netdev_rcu(struct mana_context *ac, u32 port_index)
+struct net_device *mana_get_primary_netdev(struct mana_context *ac, u32 port_index)
 {
 	struct net_device *ndev;
 
-	RCU_LOCKDEP_WARN(!rcu_read_lock_held(),
-			 "Taking primary netdev without holding the RCU read lock");
 	if (port_index >= ac->num_ports)
 		return NULL;
 
-	/* When mana is used in netvsc, the upper netdevice should be returned. */
-	if (ac->ports[port_index]->flags & IFF_SLAVE)
-		ndev = netdev_master_upper_dev_get_rcu(ac->ports[port_index]);
-	else
+	rcu_read_lock();
+
+	/* If mana is used in netvsc, the upper netdevice should be returned. */
+	ndev = netdev_master_upper_dev_get_rcu(ac->ports[port_index]);
+
+	/* If there is no upper device, use the parent Ethernet device */
+	if (!ndev)
 		ndev = ac->ports[port_index];
 
+	netdev_hold(ndev, NULL, GFP_ATOMIC);
+	rcu_read_unlock();
+
 	return ndev;
 }
-EXPORT_SYMBOL_NS(mana_get_primary_netdev_rcu, "NET_MANA");
+EXPORT_SYMBOL_NS(mana_get_primary_netdev, "NET_MANA");
diff --git a/include/net/mana/mana.h b/include/net/mana/mana.h
index 0d00b24eacaf..770359ce7d3b 100644
--- a/include/net/mana/mana.h
+++ b/include/net/mana/mana.h
@@ -827,5 +827,5 @@ int mana_cfg_vport(struct mana_port_context *apc, u32 protection_dom_id,
 		   u32 doorbell_pg_id);
 void mana_uncfg_vport(struct mana_port_context *apc);
 
-struct net_device *mana_get_primary_netdev_rcu(struct mana_context *ac, u32 port_index);
+struct net_device *mana_get_primary_netdev(struct mana_context *ac, u32 port_index);
 #endif /* _MANA_H */
-- 
2.34.1


