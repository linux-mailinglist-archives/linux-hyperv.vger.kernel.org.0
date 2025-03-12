Return-Path: <linux-hyperv+bounces-4449-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A5A0A5E824
	for <lists+linux-hyperv@lfdr.de>; Thu, 13 Mar 2025 00:15:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DECA118998D8
	for <lists+linux-hyperv@lfdr.de>; Wed, 12 Mar 2025 23:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9D3A1EF099;
	Wed, 12 Mar 2025 23:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxonhyperv.com header.i=@linuxonhyperv.com header.b="gxq9KOPy"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DEE818A93C;
	Wed, 12 Mar 2025 23:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741821346; cv=none; b=FRupw14exdMJaP5D0j839jWCFIDI8z5pROZmUE1jl0ktm4ydGJAQwVePYHrDsabahcwIKuBRZ1q5IMuLj5SLoDWeR0a3wFRuwziwMwK4Ib3E/ar/DIYhIl3bqY26aa+QGa71cYRXdT+22GYEs7NGgthvhcsFzaE/q6ucqJumKi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741821346; c=relaxed/simple;
	bh=FSoMB+rP9Brn8rbfRSWqyO/Hlr4VYRRieXZmXSZTOYI=;
	h=From:To:Cc:Subject:Date:Message-Id; b=Q/GtIyv/XohkR+qYjUfv5PCfYHN1iYlRTI3Iwfin9N/44l1SENG6eSQcaXIYj2Sctj03cu4dBCQaH8YMrGMH2DYxLqxHEQnWd8qcFiSH/eqj4fkQpf4JnAViaDavuUmlWha8PSwJ2sP6WcPRnFrEk6Qe7ieqSoIJ8Eoabl9Ys5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxonhyperv.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linuxonhyperv.com header.i=@linuxonhyperv.com header.b=gxq9KOPy; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxonhyperv.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1202)
	id 93B3D210B15B; Wed, 12 Mar 2025 16:15:44 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 93B3D210B15B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxonhyperv.com;
	s=default; t=1741821344;
	bh=DJla9Iq0AsTzhODsit36dfQMKIH8hxfpvo2EOnMD5Gk=;
	h=From:To:Cc:Subject:Date:From;
	b=gxq9KOPyz5cjC8GNYAi01cmu2V0HGACjTe/Uy7xpZ961ayDxt4kga/dOIWSiwcQUA
	 vb8vDOb/ByC1lNqN03ZUPc56i0sE8LwY8qTlH6ywv6mqz56b+8oboJkvCbSS53lFcV
	 MF/qi5VYOKFn+N5GVi6IfOjFYQ1QAgxPTfATqo9g=
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
Subject: [patch rdma-next v6 1/2] net: mana: Change the function signature of mana_get_primary_netdev_rcu
Date: Wed, 12 Mar 2025 16:15:31 -0700
Message-Id: <1741821332-9392-1-git-send-email-longli@linuxonhyperv.com>
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
v6: rebase to latest rdma-next

 drivers/infiniband/hw/mana/device.c           |  7 +++---
 drivers/infiniband/hw/mana/mana_ib.h          |  1 +
 drivers/net/ethernet/microsoft/mana/mana_en.c | 22 ++++++++++++-------
 include/net/mana/mana.h                       |  4 +++-
 4 files changed, 21 insertions(+), 13 deletions(-)

diff --git a/drivers/infiniband/hw/mana/device.c b/drivers/infiniband/hw/mana/device.c
index d1a02c54a236..9357a9845c2c 100644
--- a/drivers/infiniband/hw/mana/device.c
+++ b/drivers/infiniband/hw/mana/device.c
@@ -98,10 +98,8 @@ static int mana_ib_probe(struct auxiliary_device *adev,
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
@@ -109,7 +107,8 @@ static int mana_ib_probe(struct auxiliary_device *adev,
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
index 77fc1032eda8..81a7e7474462 100644
--- a/drivers/infiniband/hw/mana/mana_ib.h
+++ b/drivers/infiniband/hw/mana/mana_ib.h
@@ -78,6 +78,7 @@ struct mana_ib_dev {
 	struct xarray qp_table_wq;
 	struct mana_ib_adapter_caps adapter_caps;
 	struct dma_pool *av_pool;
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


