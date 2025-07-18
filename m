Return-Path: <linux-hyperv+bounces-6294-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 27A69B09DF5
	for <lists+linux-hyperv@lfdr.de>; Fri, 18 Jul 2025 10:29:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3F50562396
	for <lists+linux-hyperv@lfdr.de>; Fri, 18 Jul 2025 08:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13717291C2B;
	Fri, 18 Jul 2025 08:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NKPJcX9J"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 687EC2459D1
	for <linux-hyperv@vger.kernel.org>; Fri, 18 Jul 2025 08:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752827375; cv=none; b=G69AN60pHS9anzQxwse24edX4iW1+HzHqTVBiuBY9SR52d0ec5s95ImHJP/+zO6ypMXnDWP1mhdsvfsC/+RR3IfiMFX7icuRKdp35imG11XeOkQUku3THe+7VGxzpsSD4jANXnTS5RV7FUgIJG/nUSNaUtzkwM536KTuTZHYogY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752827375; c=relaxed/simple;
	bh=2yMZxEoMhzHBRLhDU4mMOZCbhsreVPW3r72uSlrVzME=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=GsG1g/xc8zuRdtzliTfNX/mkuHPuMzGmjf/yTSYPvd2rhM3XUX9eLnRocVlzzmN2oQoH3WXjbo8xCEYfB+KtLsmbnr2bmagYGIrOIUKbLNN8QmtMQ3+yJyTJEZ5CEu7UBX96zF+Db3cNRGua3DvwSYhFkPcQg3Q+XdMp+inemcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NKPJcX9J; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752827372;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=tLxIgdhHiCoIgPGgPwU9stKbvRQ2I1q76Ap/zfjhcII=;
	b=NKPJcX9JUlNF3MpnAebcOSVPHnOPXUXuXh/UNeT+nOsgmkf24CXmB/GXWD3s+0L03HZiPS
	lmfprn13yIHR837FaIsHvnKT8hH/Z7gLBwurHBlKJIlh2MHf04M0hmRL4JiWHWXfFvRdXM
	N8QqncFiPnhJbhYQ7acJ5VhWfFBISxw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-564-Hq1APPNbMhy3c5iZgPPmNA-1; Fri,
 18 Jul 2025 04:29:28 -0400
X-MC-Unique: Hq1APPNbMhy3c5iZgPPmNA-1
X-Mimecast-MFC-AGG-ID: Hq1APPNbMhy3c5iZgPPmNA_1752827365
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 575D119560B6;
	Fri, 18 Jul 2025 08:29:25 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.34])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id AA4E830001B9;
	Fri, 18 Jul 2025 08:29:14 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Michael Kelley <mhklinux@outlook.com>,
	Shradha Gupta <shradhagupta@linux.microsoft.com>,
	Kees Cook <kees@kernel.org>,
	Saurabh Sengar <ssengar@linux.microsoft.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Guillaume Nault <gnault@redhat.com>,
	Joe Damato <jdamato@fastly.com>,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	linux-hyperv@vger.kernel.org (open list:Hyper-V/Azure CORE AND DRIVERS),
	netdev@vger.kernel.org (open list:NETWORKING DRIVERS),
	linux-kernel@vger.kernel.org (open list),
	lulu@redhat.com,
	jasowang@redhat.com
Subject: [PATCH v2] netvsc: transfer lower device max tso size
Date: Fri, 18 Jul 2025 16:28:44 +0800
Message-ID: <20250718082909.243488-1-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

From: Jason Wang <jasowang@redhat.com>

When netvsc is accelerated by the lower device, we can advertise the
lower device max tso size in order to get better performance.

One example is that when 802.3ad encap is enabled by netvsc, it has a
lower max tso size than 64K. This will lead to software segmentation
of forwarding GSO packet (e.g the one from VM/tap).

This patch help to recover the performance.

Signed-off-by: Jason Wang <jasowang@redhat.com>
Tested-by: Cindy Lu <lulu@redhat.com>
Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 drivers/net/hyperv/netvsc_drv.c |  2 +-
 include/linux/netdevice.h       |  4 ++++
 net/core/dev.c                  | 18 ++++++++++++++++++
 3 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/net/hyperv/netvsc_drv.c b/drivers/net/hyperv/netvsc_drv.c
index c41a025c66f0..7af4aa4f4abe 100644
--- a/drivers/net/hyperv/netvsc_drv.c
+++ b/drivers/net/hyperv/netvsc_drv.c
@@ -2440,7 +2440,7 @@ static int netvsc_vf_changed(struct net_device *vf_netdev, unsigned long event)
 		 * switched over to the VF
 		 */
 		if (vf_is_up)
-			netif_set_tso_max_size(ndev, vf_netdev->tso_max_size);
+			netif_stacked_transfer_tso_max_size(vf_netdev, ndev);
 		else
 			netif_set_tso_max_size(ndev, netvsc_dev->netvsc_gso_max_size);
 	}
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index adb14db25798..c695a3ffecd8 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -5275,6 +5275,9 @@ void netdev_change_features(struct net_device *dev);
 void netif_stacked_transfer_operstate(const struct net_device *rootdev,
 					struct net_device *dev);
 
+void netif_stacked_transfer_tso_max_size(const struct net_device *rootdev,
+					 struct net_device *dev);
+
 netdev_features_t passthru_features_check(struct sk_buff *skb,
 					  struct net_device *dev,
 					  netdev_features_t features);
@@ -5326,6 +5329,7 @@ static inline bool netif_needs_gso(struct sk_buff *skb,
 }
 
 void netif_set_tso_max_size(struct net_device *dev, unsigned int size);
+
 void netif_set_tso_max_segs(struct net_device *dev, unsigned int segs);
 void netif_inherit_tso_max(struct net_device *to,
 			   const struct net_device *from);
diff --git a/net/core/dev.c b/net/core/dev.c
index be97c440ecd5..3bec4284adff 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3306,6 +3306,24 @@ void netif_set_tso_max_size(struct net_device *dev, unsigned int size)
 }
 EXPORT_SYMBOL(netif_set_tso_max_size);
 
+/**
+ *	netif_stacked_transfer_tso_max_size - transfer tso max size
+ *	@rootdev: the root or lower level device to transfer tso max size from
+ *	@dev: the device to transfer operstate to
+ *
+ *	Transfer tso max size from root to device. This is normally
+ *	called when a stacking relationship exists between the root
+ *	device and the device(a leaf device).
+ */
+void netif_stacked_transfer_tso_max_size(const struct net_device *rootdev,
+					 struct net_device *dev)
+{
+	dev->tso_max_size = rootdev->tso_max_size;
+	netif_set_gso_max_size(dev, READ_ONCE(rootdev->gso_max_size));
+	netif_set_gso_ipv4_max_size(dev, READ_ONCE(rootdev->gso_ipv4_max_size));
+}
+EXPORT_SYMBOL(netif_stacked_transfer_tso_max_size);
+
 /**
  * netif_set_tso_max_segs() - set the max number of segs supported for TSO
  * @dev:	netdev to update
-- 
2.45.0


