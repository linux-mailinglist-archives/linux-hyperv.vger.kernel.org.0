Return-Path: <linux-hyperv+bounces-4215-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C050A4F1EB
	for <lists+linux-hyperv@lfdr.de>; Wed,  5 Mar 2025 01:00:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C6D316E3DB
	for <lists+linux-hyperv@lfdr.de>; Wed,  5 Mar 2025 00:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22C631957E4;
	Wed,  5 Mar 2025 00:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxonhyperv.com header.i=@linuxonhyperv.com header.b="hA3/+aEQ"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B3F524C09A;
	Wed,  5 Mar 2025 00:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741132809; cv=none; b=abMoiwmWNrmEd+PrgPPpK4AU2RAMIHmYZPmoaebKXGJiqQIMsw9Hsqysct1PxX8BK4Ao5UE8mW6YiKBJQKEp577eJLBq0PGjCEdX+MSz50Oq/G53nUsKD1RwpFuHxt5QVRlSumB1jfN/5Q9DqmpUN7eDG0IMtKWCWGmtBpS8st4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741132809; c=relaxed/simple;
	bh=maeTuTRd1RxaKuCtTaK1UNUJtNBfFivEbPZ207OaVYM=;
	h=From:To:Cc:Subject:Date:Message-Id; b=GMYL8VFvaKjl1t77Ifc6TgjYM2greaU2kWSY2zf0ND18Cs5zh+WFl3lHXNGa49fMP9mU4fH4yJOf7jkIfmHMV7OMFfpInEJ1xxU9x91OZ6SCh0ZuA3J/0koFcClUDzlAvtUS6EAsZ0EVYgUY6BGd9FUl+u7+F9RgJwNaI8ct9mU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxonhyperv.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linuxonhyperv.com header.i=@linuxonhyperv.com header.b=hA3/+aEQ; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxonhyperv.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1202)
	id D22CE2112503; Tue,  4 Mar 2025 16:00:06 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D22CE2112503
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxonhyperv.com;
	s=default; t=1741132806;
	bh=YQAURlkfG3zyvMgNUuVAdt7wlORGt/c6p0druqSXPmM=;
	h=From:To:Cc:Subject:Date:From;
	b=hA3/+aEQsCaaOvHufY5KTMCArhTJFvIdHfJ7u4joBgsDWBpjZpqLE1O2uVdpDxd6A
	 MkTAcW6ND7hADwClrgS7UTZ6CZYvVWuEnCpzuFwNSBq93ar4PUzOzBeeFYMcOIwxzy
	 xamNw2rSq33mKeODFampNIZaBiYIxxOhzz98HhPQ=
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
Subject: [patch rdma-next v3 1/2] net: mana: Change the function signature of mana_get_primary_netdev_rcu
Date: Tue,  4 Mar 2025 16:00:01 -0800
Message-Id: <1741132802-26795-1-git-send-email-longli@linuxonhyperv.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

From: Long Li <longli@microsoft.com>

Change mana_get_primary_netdev_rcu() to mana_get_primary_netdev(), and
return the ndev with refcount held. The caller is responsible for dropping
the refcount by calling dev_put().

Signed-off-by: Long Li <longli@microsoft.com>
---
 drivers/infiniband/hw/mana/device.c           |  7 +++----
 drivers/net/ethernet/microsoft/mana/mana_en.c | 11 +++++++----
 include/net/mana/mana.h                       |  2 +-
 3 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/infiniband/hw/mana/device.c b/drivers/infiniband/hw/mana/device.c
index 3416a85f8738..afe3d8d20b3b 100644
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
+	dev_put(ndev);
 	if (ret) {
 		ibdev_err(&dev->ib_dev, "Failed to set ib netdev, ret %d", ret);
 		goto free_ib_device;
diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index aa1e47233fe5..cfa664d5a137 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -3131,21 +3131,24 @@ void mana_remove(struct gdma_dev *gd, bool suspending)
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
 
+	rcu_read_lock();
+
 	/* When mana is used in netvsc, the upper netdevice should be returned. */
 	if (ac->ports[port_index]->flags & IFF_SLAVE)
 		ndev = netdev_master_upper_dev_get_rcu(ac->ports[port_index]);
 	else
 		ndev = ac->ports[port_index];
 
+	dev_hold(ndev);
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


