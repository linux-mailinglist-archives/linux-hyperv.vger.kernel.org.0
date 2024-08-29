Return-Path: <linux-hyperv+bounces-2914-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CE429647C3
	for <lists+linux-hyperv@lfdr.de>; Thu, 29 Aug 2024 16:17:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F2C81C2263C
	for <lists+linux-hyperv@lfdr.de>; Thu, 29 Aug 2024 14:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8057C1AE04E;
	Thu, 29 Aug 2024 14:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="InKQsAT3"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D5DC19408D;
	Thu, 29 Aug 2024 14:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724941010; cv=none; b=CMckM+it4ZyC/OKUU7LtneoumUkrsW1kEfoNOg5Q2zYtnx9HL1K0Vt9+HS8eHXEFVuKeBet2x0jni+NW1GWEIGaojosfGjQoPAp5mh6Z9XkyVktYUoQbBnSLCPY1A3GDBOfORVEfrAhoPQWqYqXMSupEF06BTLwXtDjwzKUYSGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724941010; c=relaxed/simple;
	bh=Kzeqef7Cl73RQWlhJcPtJiNooSid7j+18DeILrIoT3M=;
	h=From:To:Cc:Subject:Date:Message-Id; b=PeG/j9LbuOx5wysdYECzegNAKqrQ4IIos79OSrIiJaBfiwz/TfgLMsJV6PQ7zSIwGbGDTgAyWLS16Aagg1wP8jT/XkO/Cyc+wBZvwJuH/1KP2HYhIH3PtCLslmoE+xowgfRpC/oPMWLbCNvBODaQT6ylKn+sP4bH2d3gHaFG6lU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=InKQsAT3; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1134)
	id 9BDB620B7165; Thu, 29 Aug 2024 07:16:48 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9BDB620B7165
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1724941008;
	bh=ioiS0PvcMSwqDFoOxAKdu97AGRROolR0blMaCmo8GUQ=;
	h=From:To:Cc:Subject:Date:From;
	b=InKQsAT3Pj8Cn/lX+FlwwBMVJjlwYnN6xKlBcuox0a+8d0+M3kWjKfYFz92b+oz4S
	 +5+7NChDNsL+B4OgBFpSdAR4/AyOcvulP1RW2Aqmm7aWWNTbxTvRtcnpYMiRrEK9O+
	 Y1PvPtnne9YG/71XVkKGDwZGwM5R5Z9MhdYLfTjc=
From: Shradha Gupta <shradhagupta@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org
Cc: Shradha Gupta <shradhagupta@linux.microsoft.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Long Li <longli@microsoft.com>,
	Simon Horman <horms@kernel.org>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>,
	Erick Archer <erick.archer@outlook.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	Colin Ian King <colin.i.king@gmail.com>,
	Shradha Gupta <shradhagupta@microsoft.com>
Subject: [PATCH net-next] net: mana: Improve mana_set_channels() for low mem conditions
Date: Thu, 29 Aug 2024 07:16:46 -0700
Message-Id: <1724941006-2500-1-git-send-email-shradhagupta@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

The mana_set_channels() function requires detaching the mana
driver and reattaching it with changed channel values.
During this operation if the system is low on memory, the reattach
might fail, causing the network device being down.
To avoid this we pre-allocate buffers at the beginning of set operation,
to prevent complete network loss

Signed-off-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
---
 .../ethernet/microsoft/mana/mana_ethtool.c    | 28 +++++++++++--------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/microsoft/mana/mana_ethtool.c b/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
index d6a35fbda447..5077493fdfde 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
@@ -345,27 +345,31 @@ static int mana_set_channels(struct net_device *ndev,
 	struct mana_port_context *apc = netdev_priv(ndev);
 	unsigned int new_count = channels->combined_count;
 	unsigned int old_count = apc->num_queues;
-	int err, err2;
+	int err;
+
+	apc->num_queues = new_count;
+	err = mana_pre_alloc_rxbufs(apc, ndev->mtu);
+	apc->num_queues = old_count;
+	if (err) {
+		netdev_err(ndev, "Insufficient memory for new allocations");
+		return err;
+	}
 
 	err = mana_detach(ndev, false);
 	if (err) {
 		netdev_err(ndev, "mana_detach failed: %d\n", err);
-		return err;
+		goto out;
 	}
 
 	apc->num_queues = new_count;
 	err = mana_attach(ndev);
-	if (!err)
-		return 0;
-
-	netdev_err(ndev, "mana_attach failed: %d\n", err);
-
-	/* Try to roll it back to the old configuration. */
-	apc->num_queues = old_count;
-	err2 = mana_attach(ndev);
-	if (err2)
-		netdev_err(ndev, "mana re-attach failed: %d\n", err2);
+	if (err) {
+		apc->num_queues = old_count;
+		netdev_err(ndev, "mana_attach failed: %d\n", err);
+	}
 
+out:
+	mana_pre_dealloc_rxbufs(apc);
 	return err;
 }
 
-- 
2.34.1


