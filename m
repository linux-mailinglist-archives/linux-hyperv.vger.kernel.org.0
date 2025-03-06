Return-Path: <linux-hyperv+bounces-4260-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 773B9A55681
	for <lists+linux-hyperv@lfdr.de>; Thu,  6 Mar 2025 20:24:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B86F3B3F35
	for <lists+linux-hyperv@lfdr.de>; Thu,  6 Mar 2025 19:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56CA526E16F;
	Thu,  6 Mar 2025 19:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxonhyperv.com header.i=@linuxonhyperv.com header.b="DuHzzPAf"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0301211476;
	Thu,  6 Mar 2025 19:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741289084; cv=none; b=ZptCuxmCPyCv/L07GeyBewCdZJgx+vFF3wohlT4rwppojeGr/oLOw3Szo8nxfS6KdLPvErvHUxQKdUGWINO7TjrJ1qAS5D9bUTI3bdOx4+FJyQmWW1LhIp9sbRUftq7VV5ddszequD7ylkABrHkEAUzvON7hrLj/QLbyN2gQ0dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741289084; c=relaxed/simple;
	bh=nbRLzIOOa7m9nYevtoKhk36VnuLqeUKs5GWulz/zjQo=;
	h=From:To:Cc:Subject:Date:Message-Id; b=asosVHgk7CH/WzB5b/ParGISO3ojYnN7D1B2c/vV7r0f0dMTh2ulGnWVYhbcrkVHhi3adB4gkIdF0SXGuOO4NSV6gOzbxWyCsVnSOAXDe8+rH6NEKG/WUGFBK9xnnqcbxRvDawIezZJZeY4fKHEiiz8cthIQo9vXEVw0Lm1Qd+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxonhyperv.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linuxonhyperv.com header.i=@linuxonhyperv.com header.b=DuHzzPAf; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxonhyperv.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1202)
	id 60D7A210EAE5; Thu,  6 Mar 2025 11:24:42 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 60D7A210EAE5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxonhyperv.com;
	s=default; t=1741289082;
	bh=TvbvlMSyhaZWRXp1gG0nGpdUVO19wq4jNvWj6tm9Igs=;
	h=From:To:Cc:Subject:Date:From;
	b=DuHzzPAfqwDKzkp3CnIWwzIjRsdVYWkQ576huWqZNW9H4rGJryVMRxMZ5Vyvx4moz
	 UsOJSMVKSqPOmWHVGPA7zxDxK6LaKZc8+h/XgVeh7OXg1pViy2lgbOTj3ufZ1E3bxW
	 i4ngtLOclpaMkVC/VXUDD2jZNNAbB1Gl1SOQnWjw=
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
Subject: [patch rdma-next v5 1/2] net: mana: Change the function signature of mana_get_primary_netdev_rcu
Date: Thu,  6 Mar 2025 11:24:38 -0800
Message-Id: <1741289079-18744-1-git-send-email-longli@linuxonhyperv.com>
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
v5: use netdevice_tracker in mana_ib_dev for netdev_hold()/netdev_put()

 drivers/infiniband/hw/mana/device.c           |  7 +++---
 drivers/infiniband/hw/mana/mana_ib.h          |  1 +
 drivers/net/ethernet/microsoft/mana/mana_en.c | 22 ++++++++++++-------
 include/net/mana/mana.h                       |  4 +++-
 4 files changed, 21 insertions(+), 13 deletions(-)

diff --git a/drivers/infiniband/hw/mana/device.c b/drivers/infiniband/hw/mana/device.c
index 3416a85f8738..363566095501 100644
--- a/drivers/infiniband/hw/mana/device.c
+++ b/drivers/infiniband/hw/mana/device.c
@@ -84,10 +84,8 @@ static int mana_ib_probe(struct auxiliary_device *adev,
 	dev->ib_dev.num_comp_vectors = mdev->gdma_context->max_num_queues;
 	dev->ib_dev.dev.parent = mdev->gdma_context->dev;
 
-	rcu_read_lock(); /* required to get primary netdev */
-	ndev = mana_get_primary_netdev_rcu(mc, 0);
+	ndev = mana_get_primary_netdev(mc, 0, &dev->dev_tracker);
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
+	netdev_put(ndev, &dev->dev_tracker);
 	if (ret) {
 		ibdev_err(&dev->ib_dev, "Failed to set ib netdev, ret %d", ret);
 		goto free_ib_device;
diff --git a/drivers/infiniband/hw/mana/mana_ib.h b/drivers/infiniband/hw/mana/mana_ib.h
index b53a5b4de908..2638688f2505 100644
--- a/drivers/infiniband/hw/mana/mana_ib.h
+++ b/drivers/infiniband/hw/mana/mana_ib.h
@@ -64,6 +64,7 @@ struct mana_ib_dev {
 	struct gdma_queue **eqs;
 	struct xarray qp_table_wq;
 	struct mana_ib_adapter_caps adapter_caps;
+	netdevice_tracker dev_tracker;
 };
 
 struct mana_ib_wq {
diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index aa1e47233fe5..4e870b11f946 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -3131,21 +3131,27 @@ void mana_remove(struct gdma_dev *gd, bool suspending)
 	kfree(ac);
 }
 
-struct net_device *mana_get_primary_netdev_rcu(struct mana_context *ac, u32 port_index)
+struct net_device *mana_get_primary_netdev(struct mana_context *ac,
+					   u32 port_index,
+					   netdevice_tracker *tracker)
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
 
+	netdev_hold(ndev, tracker, GFP_ATOMIC);
+	rcu_read_unlock();
+
 	return ndev;
 }
-EXPORT_SYMBOL_NS(mana_get_primary_netdev_rcu, "NET_MANA");
+EXPORT_SYMBOL_NS(mana_get_primary_netdev, "NET_MANA");
diff --git a/include/net/mana/mana.h b/include/net/mana/mana.h
index 0d00b24eacaf..0f78065de8fe 100644
--- a/include/net/mana/mana.h
+++ b/include/net/mana/mana.h
@@ -827,5 +827,7 @@ int mana_cfg_vport(struct mana_port_context *apc, u32 protection_dom_id,
 		   u32 doorbell_pg_id);
 void mana_uncfg_vport(struct mana_port_context *apc);
 
-struct net_device *mana_get_primary_netdev_rcu(struct mana_context *ac, u32 port_index);
+struct net_device *mana_get_primary_netdev(struct mana_context *ac,
+					   u32 port_index,
+					   netdevice_tracker *tracker);
 #endif /* _MANA_H */
-- 
2.34.1


