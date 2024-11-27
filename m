Return-Path: <linux-hyperv+bounces-3368-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21A129DAE00
	for <lists+linux-hyperv@lfdr.de>; Wed, 27 Nov 2024 20:43:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C70D0165BAE
	for <lists+linux-hyperv@lfdr.de>; Wed, 27 Nov 2024 19:43:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E736320127A;
	Wed, 27 Nov 2024 19:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxonhyperv.com header.i=@linuxonhyperv.com header.b="WhhFwb/4"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67D42140E38;
	Wed, 27 Nov 2024 19:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732736587; cv=none; b=D2joQu4YdZt5ugtTWg1RwGnMfmspSqxYI2id6yQzFuQ7VAt9q/w0WACv153Hop4q5YiNDdE5bEBVi3jI34Tmjfq/J18C5V+cE97YcGCR1sQpx1u3TcjEyaOZZtj0DjJsND7VBdQKvMnPO/hI3/5cf1fJuXh8UFEf9OHU5X/caCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732736587; c=relaxed/simple;
	bh=HVQuuwQb5rZJel6SBrPX26hBtVs9kVwg4TvserHvY78=;
	h=From:To:Cc:Subject:Date:Message-Id; b=pjfAXcgt4FCudNivCdIbv7P5VNiSpv0+E2IEYyVzhZp4n1XCY14YKGrliEFa0/fhspkj2/fsFWDTRZ8gaNem0H38ovC4uX1n2bK67ddupXiuJy2FImRMgVE5Kmq5UyvlezcEIloT4taJpT26fA2ZS6SiK2PzeO40Cb7AloKOvpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxonhyperv.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linuxonhyperv.com header.i=@linuxonhyperv.com header.b=WhhFwb/4; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxonhyperv.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1202)
	id C42D7205A776; Wed, 27 Nov 2024 11:43:00 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C42D7205A776
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxonhyperv.com;
	s=default; t=1732736580;
	bh=yahO6gN8LvsXHwlEmabMDbmXoKyfIceqCe29Wsef84w=;
	h=From:To:Cc:Subject:Date:From;
	b=WhhFwb/4c+4ubGrf66e+ie+JwDg/SQbTKHTStP8XlHkfBwcqOHQ8cadaiR6dLdm70
	 UdL0kgnrsQbClMpVeDdiNpH3woCJtzfcOsIVQTPdn0As5zvj4kMTGFOVq9cI0RqDtA
	 iNbr1888FJqRZ41IoFl/WQOJ3zahqO6O53optWJ8=
From: longli@linuxonhyperv.com
To: "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Shradha Gupta <shradhagupta@linux.microsoft.com>,
	Simon Horman <horms@kernel.org>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>,
	Erick Archer <erick.archer@outlook.com>,
	linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org
Cc: Long Li <longli@microsoft.com>
Subject: [PATCH] hv_netvsc: Set device flags for properly indicating bonding
Date: Wed, 27 Nov 2024 11:42:50 -0800
Message-Id: <1732736570-19700-1-git-send-email-longli@linuxonhyperv.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

From: Long Li <longli@microsoft.com>

hv_netvsc uses a subset of bonding features in that the master always
has only one active slave. But it never properly setup those flags.

Other kernel APIs (e.g those in "include/linux/netdevice.h") check for
IFF_MASTER, IFF_SLAVE and IFF_BONDING for determing if those are used
in a master/slave setup. RDMA uses those APIs extensively when looking
for master/slave devices.

Make hv_netvsc properly setup those flags.

Signed-off-by: Long Li <longli@microsoft.com>
---
 drivers/net/hyperv/netvsc_drv.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/net/hyperv/netvsc_drv.c b/drivers/net/hyperv/netvsc_drv.c
index d6c4abfc3a28..2112fb74eb21 100644
--- a/drivers/net/hyperv/netvsc_drv.c
+++ b/drivers/net/hyperv/netvsc_drv.c
@@ -2204,6 +2204,10 @@ static int netvsc_vf_join(struct net_device *vf_netdev,
 		goto rx_handler_failed;
 	}
 
+	vf_netdev->priv_flags |= IFF_BONDING;
+	ndev->priv_flags |= IFF_BONDING;
+	ndev->flags |= IFF_MASTER;
+
 	ret = netdev_master_upper_dev_link(vf_netdev, ndev,
 					   NULL, NULL, NULL);
 	if (ret != 0) {
@@ -2484,7 +2488,15 @@ static int netvsc_unregister_vf(struct net_device *vf_netdev)
 
 	reinit_completion(&net_device_ctx->vf_add);
 	netdev_rx_handler_unregister(vf_netdev);
+
+	/* Unlink the slave device and clear flag */
+	vf_netdev->priv_flags &= ~IFF_BONDING;
+	ndev->priv_flags &= ~IFF_BONDING;
+	vf_netdev->flags &= ~IFF_SLAVE;
+	ndev->flags &= ~IFF_MASTER;
+
 	netdev_upper_dev_unlink(vf_netdev, ndev);
+
 	RCU_INIT_POINTER(net_device_ctx->vf_netdev, NULL);
 	dev_put(vf_netdev);
 
-- 
2.34.1


