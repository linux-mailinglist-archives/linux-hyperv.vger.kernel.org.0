Return-Path: <linux-hyperv+bounces-4175-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 07555A4A619
	for <lists+linux-hyperv@lfdr.de>; Fri, 28 Feb 2025 23:42:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B921B189C4AF
	for <lists+linux-hyperv@lfdr.de>; Fri, 28 Feb 2025 22:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 160481DED44;
	Fri, 28 Feb 2025 22:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxonhyperv.com header.i=@linuxonhyperv.com header.b="NLxL2DHB"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E17923F39A;
	Fri, 28 Feb 2025 22:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740782527; cv=none; b=odjhlg/ymTKmGvNq4Gv4d1aUoUNe/mz2r36Nr/Xu+N7feX/NTPEAYyL0Wcb32mGiHYBZf4pEm5ky/St0sjF/M0sRu9a2b8XvkpQxy02C8M4kF7n+Cywa3A+Uq6Ubow/6PrDp6+VhjUsa/602yCb1GgNmIXxdSWq5I5qjfDdHSIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740782527; c=relaxed/simple;
	bh=u//XrDtfAGhnVRyNGvnTIbDxJyV4yBDTUhlfRdirEcY=;
	h=From:To:Cc:Subject:Date:Message-Id; b=SsRAOLHrg+llyYrGaIQeaPKgxezeg37inxUEPLKaylhXXaStGjaVqfQTqmpQsgU7exsAREhQ7gXa+Z69EPuexv4QY8jhozn52PV3fuMjxinSgmusSGhgXmfp98fr8+Lti5jyyxRh8gIq0L9XIMI5HxH1eJ2l26uQdA4rjNTk4oQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxonhyperv.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linuxonhyperv.com header.i=@linuxonhyperv.com header.b=NLxL2DHB; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxonhyperv.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1202)
	id 3CF9C210D0E8; Fri, 28 Feb 2025 14:42:05 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3CF9C210D0E8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxonhyperv.com;
	s=default; t=1740782525;
	bh=ajnKo8Udgtm8yjP8A4LPP4/6wP3HU81GoXRTiPwsqAk=;
	h=From:To:Cc:Subject:Date:From;
	b=NLxL2DHBpfLpG6qMuqASgNebXkUo28Ulf0ATyGEaRVCjlNXA2gGW4jdBFwcQb39ly
	 GeETViBOI732yDeWDWVCk0e5Lb0lv0ZT/0uOcXU0o7PVqPPrqVqN4eSc584Y2kZhTl
	 g3YbiyBVTUw6NcFWbx73Wrf7NbRX/PAvW6NDyUHM=
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
Subject: [Patch rdma-next] RDMA/mana_ib: handle net event for pointing to the current netdev
Date: Fri, 28 Feb 2025 14:41:59 -0800
Message-Id: <1740782519-13485-1-git-send-email-longli@linuxonhyperv.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

From: Long Li <longli@microsoft.com>

When running under Hyper-V, the master device to the RDMA device is always
bonded to this RDMA device if it's present in the kernel. This is not
user-configurable.

The master device can be unbind/bind from the kernel. During those events,
the RDMA device should set to the current netdev to relect the change of
master device from those events.

Signed-off-by: Long Li <longli@microsoft.com>
---
 drivers/infiniband/hw/mana/device.c  | 35 ++++++++++++++++++++++++++++
 drivers/infiniband/hw/mana/mana_ib.h |  1 +
 2 files changed, 36 insertions(+)

diff --git a/drivers/infiniband/hw/mana/device.c b/drivers/infiniband/hw/mana/device.c
index 3416a85f8738..3e4f069c2258 100644
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
@@ -109,6 +140,9 @@ static int mana_ib_probe(struct auxiliary_device *adev,
 	}
 	dev->gdma_dev = &mdev->gdma_context->mana_ib;
 
+	dev->nb.notifier_call = mana_ib_netdev_event;
+	register_netdevice_notifier(&dev->nb);
+
 	ret = mana_ib_gd_query_adapter_caps(dev);
 	if (ret) {
 		ibdev_err(&dev->ib_dev, "Failed to query device caps, ret %d",
@@ -159,6 +193,7 @@ static void mana_ib_remove(struct auxiliary_device *adev)
 {
 	struct mana_ib_dev *dev = dev_get_drvdata(&adev->dev);
 
+	unregister_netdevice_notifier(&dev->nb);
 	ib_unregister_device(&dev->ib_dev);
 	xa_destroy(&dev->qp_table_wq);
 	mana_ib_gd_destroy_rnic_adapter(dev);
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


