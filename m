Return-Path: <linux-hyperv+bounces-4216-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9027A4F1ED
	for <lists+linux-hyperv@lfdr.de>; Wed,  5 Mar 2025 01:00:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13C6A188D0C8
	for <lists+linux-hyperv@lfdr.de>; Wed,  5 Mar 2025 00:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B459323C8CA;
	Wed,  5 Mar 2025 00:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxonhyperv.com header.i=@linuxonhyperv.com header.b="DM/wmKzU"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 087C323BCF7;
	Wed,  5 Mar 2025 00:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741132809; cv=none; b=G/rv7HIfOFD2ChyvihdfnJvJn2JSuWixrVHGt82DiR9P4EYE1zmpfVZVQG9ZTU8ggUuf4NRr4hmj+NNHx+J/KxnUuwvrm2EVlyMblrq5D9rfXfZJVMgQlvcDESpeMueKAL/3fwdcaDdJ5B+qNh+PAZkmNC53Mw3qZ7Aa0LJOKcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741132809; c=relaxed/simple;
	bh=p7ys8mvToushqQoAbCFX9UMvMk9S3Fd3cwdjFVfRosg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=Ov2MHUSc2jq1f8mrUVCC9N6uocau/nz6eZHjKsRdWWRw/jRcCDT9r+Q/g++4yRd2inBGxCv2tpdEN47XUvp2MILzp+7b0odEA/ThafHL6YXNveIT55UD3brwbqmEvD6vfhm5EsEWMXia/TrbY/Q28pjQqD/FWtGIUXznGBN4wMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxonhyperv.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linuxonhyperv.com header.i=@linuxonhyperv.com header.b=DM/wmKzU; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxonhyperv.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1202)
	id 9F50A2112504; Tue,  4 Mar 2025 16:00:07 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9F50A2112504
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxonhyperv.com;
	s=default; t=1741132807;
	bh=vzn02cWkPx/F8QdVCcYD6nrle8ymPhDePDvSmaJZ+Pg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DM/wmKzU6DQLt4EFXxBTKQ3bMsbSEUSjWLu2HP+Lo2hPz0DY2xFkngmBuSzcs+Jjm
	 rfmEVDDak9rmZJyX10LnCUDmH02pfxr7oxJZCUUi3Vh8ddM318Z+L7nOrLJcwBzQKV
	 RViyP9bRw4ylXWPIyxeeoInuERNP/i8kll7gryB8=
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
Subject: [patch rdma-next v3 2/2] RDMA/mana_ib: Handle net event for pointing to the current netdev
Date: Tue,  4 Mar 2025 16:00:02 -0800
Message-Id: <1741132802-26795-2-git-send-email-longli@linuxonhyperv.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1741132802-26795-1-git-send-email-longli@linuxonhyperv.com>
References: <1741132802-26795-1-git-send-email-longli@linuxonhyperv.com>
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
Changes
v2: Add missing error handling when register_netdevice_notifier() fails.
v3: Change mana_get_primary_netdev() to return with netdev refcount held.

 drivers/infiniband/hw/mana/device.c  | 46 ++++++++++++++++++++++++++--
 drivers/infiniband/hw/mana/mana_ib.h |  1 +
 2 files changed, 45 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/mana/device.c b/drivers/infiniband/hw/mana/device.c
index afe3d8d20b3b..dc03f2d8c1b6 100644
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
+		ndev = mana_get_primary_netdev(mc, 0);
+		/*
+		 * RDMA core will setup GID based on updated netdev.
+		 * It's not possible to race with the core as rtnl lock is being
+		 * held.
+		 */
+		ib_device_set_netdev(&dev->ib_dev, ndev, 1);
+
+		/* mana_get_primary_netdev() returns ndev with refcount held */
+		dev_put(ndev);
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
@@ -108,17 +139,25 @@ static int mana_ib_probe(struct auxiliary_device *adev,
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
@@ -147,6 +186,8 @@ static int mana_ib_probe(struct auxiliary_device *adev,
 	mana_ib_gd_destroy_rnic_adapter(dev);
 destroy_eqs:
 	mana_ib_destroy_eqs(dev);
+deregister_net_notifier:
+	unregister_netdevice_notifier(&dev->nb);
 deregister_device:
 	mana_gd_deregister_device(dev->gdma_dev);
 free_ib_device:
@@ -162,6 +203,7 @@ static void mana_ib_remove(struct auxiliary_device *adev)
 	xa_destroy(&dev->qp_table_wq);
 	mana_ib_gd_destroy_rnic_adapter(dev);
 	mana_ib_destroy_eqs(dev);
+	unregister_netdevice_notifier(&dev->nb);
 	mana_gd_deregister_device(dev->gdma_dev);
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


