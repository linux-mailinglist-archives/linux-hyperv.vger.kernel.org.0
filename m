Return-Path: <linux-hyperv+bounces-4201-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 164CCA4D134
	for <lists+linux-hyperv@lfdr.de>; Tue,  4 Mar 2025 02:47:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BB9717413F
	for <lists+linux-hyperv@lfdr.de>; Tue,  4 Mar 2025 01:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7184A13B58B;
	Tue,  4 Mar 2025 01:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxonhyperv.com header.i=@linuxonhyperv.com header.b="D0mGKI6u"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0E6A136347;
	Tue,  4 Mar 2025 01:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741052851; cv=none; b=YAOtCvL9rO/Z9Uc+/NGgPDrO3+s2sCishrGwLHjnqYm5SyTUqUAr4jIErGRnobmCZHCrDtE/5pmQWPLyN+t/ljkuMb3X0YGWoZOr7MaZokGnWud4hws3+HSaoXqtejhT3Ybqh4nj1cv4W1vdiYaCBoEKrPcxP0g9pR0pQJj4JQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741052851; c=relaxed/simple;
	bh=itatnIBL9MuZ4JyVcFNO6XYKdUfb6qT39ConBCUndNA=;
	h=From:To:Cc:Subject:Date:Message-Id; b=r1C518cMLcZzIb62Zr2XlGpkPYiGK/I0PbdtuEyC1sEoxVvmQCpAXxv3orXAtuAsz65IvkQ+mFaZrr6YwP+Qlf0TQKQ8F3Q2ZZXpTv2+gVsffJTqxvpC5/Unq8PcRAwGfUPopxTFEbEq+AnyWzRabXg+hXYeNdGT2Am5f9FHzVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxonhyperv.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linuxonhyperv.com header.i=@linuxonhyperv.com header.b=D0mGKI6u; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxonhyperv.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1202)
	id 126D9204E5B9; Mon,  3 Mar 2025 17:47:29 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 126D9204E5B9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxonhyperv.com;
	s=default; t=1741052849;
	bh=bSP8AbizQps9S7CQl+lE3G/sxd1tc37Q1iVyE0aCu4E=;
	h=From:To:Cc:Subject:Date:From;
	b=D0mGKI6uNQC7M8tBttoqq04lMw5G7hJuaBOvg8Ik25rMIlz0LVhg9gc8g9KhJl5LW
	 aAGnM6+7DQA37FbOt2xvRVvgYjMjtHd+KDyJzouq6xnrdQfWD4NN25CdebFgXS55Yc
	 fl/n09UL+OV3MLYe0NSOTTlItLTOha3XtvRKC7GI=
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
Subject: [Patch rdma-next v2] RDMA/mana_ib: handle net event for pointing to the current netdev
Date: Mon,  3 Mar 2025 17:47:27 -0800
Message-Id: <1741052847-8271-1-git-send-email-longli@linuxonhyperv.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

From: Long Li <longli@microsoft.com>

When running under Hyper-V, the master device to the RDMA device is always
bonded to this RDMA device. This is not user-configurable.

The master device can be unbind/bind from the kernel. During those events,
the RDMA device should set to the current netdev to relect the change of
master device from those events.

Signed-off-by: Long Li <longli@microsoft.com>
---
Change in v2:
Add missing error handling when register_netdevice_notifier() fails.

 drivers/infiniband/hw/mana/device.c  | 46 ++++++++++++++++++++++++++--
 drivers/infiniband/hw/mana/mana_ib.h |  1 +
 2 files changed, 45 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/mana/device.c b/drivers/infiniband/hw/mana/device.c
index 3416a85f8738..8c922a6d6720 100644
--- a/drivers/infiniband/hw/mana/device.c
+++ b/drivers/infiniband/hw/mana/device.c
@@ -51,6 +51,37 @@ static const struct ib_device_ops mana_ib_dev_ops = {
 			   ib_ind_table),
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
+	if (event_dev != mc->ports[0])
+		return NOTIFY_DONE;
+
+	switch (event) {
+	case NETDEV_CHANGEUPPER:
+		rcu_read_lock();
+		ndev = mana_get_primary_netdev_rcu(mc, 0);
+		rcu_read_unlock();
+
+		/*
+		 * RDMA core will setup GID based on updated netdev.
+		 * It's not possible to race with the core as rtnl lock is being
+		 * held.
+		 */
+		ib_device_set_netdev(&dev->ib_dev, ndev, 1);
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
@@ -109,17 +140,25 @@ static int mana_ib_probe(struct auxiliary_device *adev,
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
 
 	ret = mana_ib_create_eqs(dev);
 	if (ret) {
 		ibdev_err(&dev->ib_dev, "Failed to create EQs, ret %d", ret);
-		goto deregister_device;
+		goto deregister_net_notifier;
 	}
 
 	ret = mana_ib_gd_create_rnic_adapter(dev);
@@ -148,6 +187,8 @@ static int mana_ib_probe(struct auxiliary_device *adev,
 	mana_ib_gd_destroy_rnic_adapter(dev);
 destroy_eqs:
 	mana_ib_destroy_eqs(dev);
+deregister_net_notifier:
+	unregister_netdevice_notifier(&dev->nb);
 deregister_device:
 	mana_gd_deregister_device(dev->gdma_dev);
 free_ib_device:
@@ -164,6 +205,7 @@ static void mana_ib_remove(struct auxiliary_device *adev)
 	mana_ib_gd_destroy_rnic_adapter(dev);
 	mana_ib_destroy_eqs(dev);
 	mana_gd_deregister_device(dev->gdma_dev);
+	unregister_netdevice_notifier(&dev->nb);
 	ib_dealloc_device(&dev->ib_dev);
 }
 
diff --git a/drivers/infiniband/hw/mana/mana_ib.h b/drivers/infiniband/hw/mana/mana_ib.h
index b53a5b4de908..d88187072899 100644
--- a/drivers/infiniband/hw/mana/mana_ib.h
+++ b/drivers/infiniband/hw/mana/mana_ib.h
@@ -64,6 +64,7 @@ struct mana_ib_dev {
 	struct gdma_queue **eqs;
 	struct xarray qp_table_wq;
 	struct mana_ib_adapter_caps adapter_caps;
+	struct notifier_block nb;
 };
 
 struct mana_ib_wq {
-- 
2.34.1


