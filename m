Return-Path: <linux-hyperv+bounces-4450-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B7A6CA5E827
	for <lists+linux-hyperv@lfdr.de>; Thu, 13 Mar 2025 00:16:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CF5B179A0E
	for <lists+linux-hyperv@lfdr.de>; Wed, 12 Mar 2025 23:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A47431F1936;
	Wed, 12 Mar 2025 23:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxonhyperv.com header.i=@linuxonhyperv.com header.b="NEmgh6hJ"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 144291F190E;
	Wed, 12 Mar 2025 23:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741821350; cv=none; b=N/5/+HotlbmsPH0F+V0M7g2pYzZ+2kAh61hpH7WpLl/F6rNy+8eJVEMChgIez2pbW5iiZl5ZAO4Bl4VkpAjMDj1md3g5h97FsIUMfowStNfn7TtTe2dhTIHtBM6cbAHfg1+Rn9NI0dcQvfE+9l0RO+SSTyiA/z8l5z4K27R8QMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741821350; c=relaxed/simple;
	bh=8dYBBUYS33H+cqMeAslgmhfxfMuxIn1RSvcSNZU/G4Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=dpyjttpzy+E+M2keH3bw4QP00SETdAPMRMhzcOr/mlyZKNrBg/zFd0ezErlXqLzEq6Ll91QPpFgxrbLHFGvzo+90uiZFxv7K6z5dWX45f1Hr8t4jIJQrVQTjDSeYnz7JSmE/dGExcgQSQFK+xLqJ942+pugFznMZZFfZIIFKkpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxonhyperv.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linuxonhyperv.com header.i=@linuxonhyperv.com header.b=NEmgh6hJ; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxonhyperv.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1202)
	id B2551210B15B; Wed, 12 Mar 2025 16:15:48 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B2551210B15B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxonhyperv.com;
	s=default; t=1741821348;
	bh=uz60Fu9C9YU+gq33nzkGQ6cX2ZfUeCkboeC0PjBrl3E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NEmgh6hJ4a2R55XxeHwk5Q/R72NpI8SPoNfM+Ac05nnFnazwHa1tQs4HV8BY3lsEF
	 YgUMpmvtkcV91zroR3hOLjfaXQ7PRAzPRVQDgOH0aXAN959B4vTWXSh/NeWnEUezw5
	 n7CSyb84butFIJSY9iod8Shbxiv7n6sbyskFwR0I=
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
Subject: [patch rdma-next v6 2/2] RDMA/mana_ib: Handle net event for pointing to the current netdev
Date: Wed, 12 Mar 2025 16:15:32 -0700
Message-Id: <1741821332-9392-2-git-send-email-longli@linuxonhyperv.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1741821332-9392-1-git-send-email-longli@linuxonhyperv.com>
References: <1741821332-9392-1-git-send-email-longli@linuxonhyperv.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

From: Long Li <longli@microsoft.com>

When running under Hyper-V, the master device to the RDMA device is always
bonded to this RDMA device. This is not user-configurable.

The master device can be unbind/bind from the kernel. During those events,
the RDMA device should set to the current netdev to reflect the change of
master device from those events.

Signed-off-by: Long Li <longli@microsoft.com>
---
Changes
v2: Add missing error handling when register_netdevice_notifier() fails.
v3: Change mana_get_primary_netdev() to return with netdev refcount held.
v4: use netdev_put().
v5: use netdevice_tracker for netdev_hold()/netdev_put().
v6: rebase to latest rdma-next

 drivers/infiniband/hw/mana/device.c  | 47 ++++++++++++++++++++++++++--
 drivers/infiniband/hw/mana/mana_ib.h |  1 +
 2 files changed, 46 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/mana/device.c b/drivers/infiniband/hw/mana/device.c
index 9357a9845c2c..b31089320aa5 100644
--- a/drivers/infiniband/hw/mana/device.c
+++ b/drivers/infiniband/hw/mana/device.c
@@ -65,6 +65,38 @@ static const struct ib_device_ops mana_ib_stats_ops = {
 	.get_hw_stats = mana_ib_get_hw_stats,
 };
 
+static int mana_ib_netdev_event(struct notifier_block *this,
+				unsigned long event, void *ptr)
+{
+	struct mana_ib_dev *dev = container_of(this, struct mana_ib_dev, nb);
+	struct net_device *event_dev = netdev_notifier_info_to_dev(ptr);
+	struct gdma_context *gc = dev->gdma_dev->gdma_context;
+	struct mana_context *mc = gc->mana.driver_data;
+	struct net_device *ndev;
+
+	/* Only process events from our parent device */
+	if (event_dev != mc->ports[0])
+		return NOTIFY_DONE;
+
+	switch (event) {
+	case NETDEV_CHANGEUPPER:
+		ndev = mana_get_primary_netdev(mc, 0, &dev->dev_tracker);
+		/*
+		 * RDMA core will setup GID based on updated netdev.
+		 * It's not possible to race with the core as rtnl lock is being
+		 * held.
+		 */
+		ib_device_set_netdev(&dev->ib_dev, ndev, 1);
+
+		/* mana_get_primary_netdev() returns ndev with refcount held */
+		netdev_put(ndev, &dev->dev_tracker);
+
+		return NOTIFY_OK;
+	default:
+		return NOTIFY_DONE;
+	}
+}
+
 static int mana_ib_probe(struct auxiliary_device *adev,
 			 const struct auxiliary_device_id *id)
 {
@@ -122,11 +154,19 @@ static int mana_ib_probe(struct auxiliary_device *adev,
 	}
 	dev->gdma_dev = &mdev->gdma_context->mana_ib;
 
+	dev->nb.notifier_call = mana_ib_netdev_event;
+	ret = register_netdevice_notifier(&dev->nb);
+	if (ret) {
+		ibdev_err(&dev->ib_dev, "Failed to register net notifier, %d",
+			  ret);
+		goto deregister_device;
+	}
+
 	ret = mana_ib_gd_query_adapter_caps(dev);
 	if (ret) {
 		ibdev_err(&dev->ib_dev, "Failed to query device caps, ret %d",
 			  ret);
-		goto deregister_device;
+		goto deregister_net_notifier;
 	}
 
 	ib_set_device_ops(&dev->ib_dev, &mana_ib_stats_ops);
@@ -134,7 +174,7 @@ static int mana_ib_probe(struct auxiliary_device *adev,
 	ret = mana_ib_create_eqs(dev);
 	if (ret) {
 		ibdev_err(&dev->ib_dev, "Failed to create EQs, ret %d", ret);
-		goto deregister_device;
+		goto deregister_net_notifier;
 	}
 
 	ret = mana_ib_gd_create_rnic_adapter(dev);
@@ -172,6 +212,8 @@ static int mana_ib_probe(struct auxiliary_device *adev,
 	mana_ib_gd_destroy_rnic_adapter(dev);
 destroy_eqs:
 	mana_ib_destroy_eqs(dev);
+deregister_net_notifier:
+	unregister_netdevice_notifier(&dev->nb);
 deregister_device:
 	mana_gd_deregister_device(dev->gdma_dev);
 free_ib_device:
@@ -188,6 +230,7 @@ static void mana_ib_remove(struct auxiliary_device *adev)
 	xa_destroy(&dev->qp_table_wq);
 	mana_ib_gd_destroy_rnic_adapter(dev);
 	mana_ib_destroy_eqs(dev);
+	unregister_netdevice_notifier(&dev->nb);
 	mana_gd_deregister_device(dev->gdma_dev);
 	ib_dealloc_device(&dev->ib_dev);
 }
diff --git a/drivers/infiniband/hw/mana/mana_ib.h b/drivers/infiniband/hw/mana/mana_ib.h
index 81a7e7474462..6903946677e5 100644
--- a/drivers/infiniband/hw/mana/mana_ib.h
+++ b/drivers/infiniband/hw/mana/mana_ib.h
@@ -79,6 +79,7 @@ struct mana_ib_dev {
 	struct mana_ib_adapter_caps adapter_caps;
 	struct dma_pool *av_pool;
 	netdevice_tracker dev_tracker;
+	struct notifier_block nb;
 };
 
 struct mana_ib_wq {
-- 
2.34.1


