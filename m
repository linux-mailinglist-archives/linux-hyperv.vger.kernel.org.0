Return-Path: <linux-hyperv+bounces-3370-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEF7F9DAE08
	for <lists+linux-hyperv@lfdr.de>; Wed, 27 Nov 2024 20:44:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49C79B25632
	for <lists+linux-hyperv@lfdr.de>; Wed, 27 Nov 2024 19:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D907202F67;
	Wed, 27 Nov 2024 19:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxonhyperv.com header.i=@linuxonhyperv.com header.b="icCGYt3L"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E46C5140E38;
	Wed, 27 Nov 2024 19:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732736633; cv=none; b=NhfyUu6/xi/L0uvo0yssvI9gcwDmEuIZxoADb4BZ5oQD7tWkj78Up8NQBgw+yRbqjXr4DQSX/YGqlz9B4/AzBcV5Z7j/ZOCHK5Oflr8nPA9rddBYJvaWRuN+45awq8hclTSLiLV6cYp5VxQHT4Ht33/uEgaCznqmBbXZ8vXLDz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732736633; c=relaxed/simple;
	bh=YFqt/v9lYYyS0VuBFYxcm5SzSZRVOlVlHtpslldEQ1E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=PBtHu6XqE8Y5XCEXD621z8S6hPJDBhX+wPkxB5htvqq/SoD3e89r/70mYHg65btOatfwkfFMBhxbmU1yQ2byjQmJi83X2SUvkKcjaX+iNiDfa53WN5/I/DKhsIjlpd8noPYfxRgSIwAuD+xko8qheN9STp73xrSfVwkoubE5JL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxonhyperv.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linuxonhyperv.com header.i=@linuxonhyperv.com header.b=icCGYt3L; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxonhyperv.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1202)
	id 9DCD923718AC; Wed, 27 Nov 2024 11:43:51 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9DCD923718AC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxonhyperv.com;
	s=default; t=1732736631;
	bh=JkLPdYVaxEl9YCyCBAslmJiCCvCYTJUAyTFgETaVWl0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=icCGYt3Lbsys7q7d1ApDKZvaYEC86YzXlh3DxRgSZL9+TwZv/eYMq0PmK7M+VQu0a
	 5PVKsBbzMnOlsGIycueigbQ28KK6V5EjQTbth1KEJ9mMQDjBJXQQmt6H9Q3QtFkPDw
	 Il/kqJDlpYP9Q54ws6My6yl7FHKWlu9eg1mtvrjQ=
From: longli@linuxonhyperv.com
To: Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	Ajay Sharma <sharmaajay@microsoft.com>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	Long Li <longli@microsoft.com>,
	stable@kernel.org
Subject: [PATCH] RDMA/mana_ib: Use the correct net device for IB
Date: Wed, 27 Nov 2024 11:43:37 -0800
Message-Id: <1732736619-19941-2-git-send-email-longli@linuxonhyperv.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1732736619-19941-1-git-send-email-longli@linuxonhyperv.com>
References: <1732736619-19941-1-git-send-email-longli@linuxonhyperv.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

From: Long Li <longli@microsoft.com>

mana_ib should not set the net device on its master device when it's
bonded. The main purpose of doing this is to get the correct GID, however
it makes it impossible to unload the master device from kernel, and move
to user-space (e.g. DPDK usage).

Fix this by using its VF device as net device. RoCE core will handle the
GID caching by looking for its correct master device.

Fixes: 1df03a4b4414 ("RDMA/mana_ib: Set correct device into ib")
Cc: stable@kernel.org
Signed-off-by: Long Li <longli@microsoft.com>
---
 drivers/infiniband/hw/mana/device.c           |  7 +++----
 drivers/net/ethernet/microsoft/mana/mana_en.c | 16 +++-------------
 include/net/mana/mana.h                       |  2 +-
 3 files changed, 7 insertions(+), 18 deletions(-)

diff --git a/drivers/infiniband/hw/mana/device.c b/drivers/infiniband/hw/mana/device.c
index 7ac01918ef7c..52784a7cf89a 100644
--- a/drivers/infiniband/hw/mana/device.c
+++ b/drivers/infiniband/hw/mana/device.c
@@ -84,18 +84,17 @@ static int mana_ib_probe(struct auxiliary_device *adev,
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
 	}
+
 	ether_addr_copy(mac_addr, ndev->dev_addr);
 	addrconf_addr_eui48((u8 *)&dev->ib_dev.node_guid, ndev->dev_addr);
+
 	ret = ib_device_set_netdev(&dev->ib_dev, ndev, 1);
-	rcu_read_unlock();
 	if (ret) {
 		ibdev_err(&dev->ib_dev, "Failed to set ib netdev, ret %d", ret);
 		goto free_ib_device;
diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index 57ac732e7707..c0c5e2997a9d 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -3130,21 +3130,11 @@ void mana_remove(struct gdma_dev *gd, bool suspending)
 	kfree(ac);
 }
 
-struct net_device *mana_get_primary_netdev_rcu(struct mana_context *ac, u32 port_index)
+struct net_device *mana_get_primary_netdev(struct mana_context *ac, u32 port_index)
 {
-	struct net_device *ndev;
-
-	RCU_LOCKDEP_WARN(!rcu_read_lock_held(),
-			 "Taking primary netdev without holding the RCU read lock");
 	if (port_index >= ac->num_ports)
 		return NULL;
 
-	/* When mana is used in netvsc, the upper netdevice should be returned. */
-	if (ac->ports[port_index]->flags & IFF_SLAVE)
-		ndev = netdev_master_upper_dev_get_rcu(ac->ports[port_index]);
-	else
-		ndev = ac->ports[port_index];
-
-	return ndev;
+	return ac->ports[port_index];
 }
-EXPORT_SYMBOL_NS(mana_get_primary_netdev_rcu, NET_MANA);
+EXPORT_SYMBOL_NS(mana_get_primary_netdev, NET_MANA);
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


