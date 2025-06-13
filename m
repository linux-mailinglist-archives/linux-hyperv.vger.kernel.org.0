Return-Path: <linux-hyperv+bounces-5904-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BDC97AD8A41
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Jun 2025 13:21:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B6FF3BB150
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Jun 2025 11:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BD572E172C;
	Fri, 13 Jun 2025 11:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="fdBndOap"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C17F2D8778;
	Fri, 13 Jun 2025 11:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749813634; cv=none; b=aoeJtL+0EGM/YEmGm7KIVpdUFDki5rMv4uxJJZx5BuWH404zptfWNly5RHTbHQssAfI+c+s7IxpzGKLp2BmMz678gTZ9ecPOIc8PGcxymiYW0xcMDUUvV1SJC7fctL0HNsKHaPxYjWDLF+fw95PS2lSq5wuu7bvr9bCIx1L9MUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749813634; c=relaxed/simple;
	bh=OBRSd7WT4BkXBIhKRy7/4sQyu81IXc/MtzNZy6JnjkU=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References; b=UqlMp2wAYLJv8nip4hW5zHXLizqKgheDKplMja/ifb9S1fJ8Go8IxUkJ2AGv1FzrcpQDyqLsKdPnu/hVX1ajBA+Ubgrl3DQXZ40HQpUKoK7jPjDKvHLCwSDIA/xSPyNtGbpUKY21KSEC6bYrH2nbg608NNjVstfO04RhQC42ViQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=fdBndOap; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1173)
	id 1CFCD2115189; Fri, 13 Jun 2025 04:20:32 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1CFCD2115189
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1749813632;
	bh=BqSBN+65YZJiSCSL/gtogSMXpS7OJBtQMStl9721njU=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=fdBndOapKxV3jXo7zfVJa5MhUBBNJlov+QsSwWJ4IH6AKizPaqZyjvJq2r010k91a
	 CVeREEkf3ldgaDg3xOvghFKHOYeLpcpHxFJHzZoPgqoGUrukkNe+0JVZnVwtvBAbmC
	 XGNBtwILCRLJ0flMjE4L0p0q+6/9vYDi7W/flqtE=
From: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	longli@microsoft.com,
	kotaranov@microsoft.com,
	horms@kernel.org,
	shirazsaleem@microsoft.com,
	leon@kernel.org,
	ernis@linux.microsoft.com,
	shradhagupta@linux.microsoft.com,
	schakrabarti@linux.microsoft.com,
	gerhard@engleder-embedded.com,
	rosenp@gmail.com,
	sdf@fomichev.me,
	linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org
Subject: [PATCH net-next v2 3/4] net: mana: Add speed support in mana_get_link_ksettings
Date: Fri, 13 Jun 2025 04:20:26 -0700
Message-Id: <1749813627-8377-4-git-send-email-ernis@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1749813627-8377-1-git-send-email-ernis@linux.microsoft.com>
References: <1749813627-8377-1-git-send-email-ernis@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Allow mana ethtool get_link_ksettings operation to report
the maximum speed supported by the SKU in mbps.

The driver retrieves this information by issuing a
HWC command to the hardware via mana_query_link_cfg(),
which retrieves the SKU's maximum supported speed.

These APIs when invoked on hardware that are older/do
not support these APIs, the speed would be reported as UNKNOWN.

Before:
$ethtool enP30832s1
> Settings for enP30832s1:
        Supported ports: [  ]
        Supported link modes:   Not reported
        Supported pause frame use: No
        Supports auto-negotiation: No
        Supported FEC modes: Not reported
        Advertised link modes:  Not reported
        Advertised pause frame use: No
        Advertised auto-negotiation: No
        Advertised FEC modes: Not reported
        Speed: Unknown!
        Duplex: Full
        Auto-negotiation: off
        Port: Other
        PHYAD: 0
        Transceiver: internal
        Link detected: yes

After:
$ethtool enP30832s1
> Settings for enP30832s1:
        Supported ports: [  ]
        Supported link modes:   Not reported
        Supported pause frame use: No
        Supports auto-negotiation: No
        Supported FEC modes: Not reported
        Advertised link modes:  Not reported
        Advertised pause frame use: No
        Advertised auto-negotiation: No
        Advertised FEC modes: Not reported
        Speed: 16000Mb/s
        Duplex: Full
        Auto-negotiation: off
        Port: Other
        PHYAD: 0
        Transceiver: internal
        Link detected: yes

Signed-off-by: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
Reviewed-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
Reviewed-by: Saurabh Singh Sengar <ssengar@linux.microsoft.com>
---
Changes in v2:
* No change.
---
 drivers/net/ethernet/microsoft/mana/mana_en.c      | 1 +
 drivers/net/ethernet/microsoft/mana/mana_ethtool.c | 6 ++++++
 include/net/mana/mana.h                            | 2 ++
 3 files changed, 9 insertions(+)

diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index 7e8bc2c6a194..54a86c233948 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -1272,6 +1272,7 @@ int mana_query_link_cfg(struct mana_port_context *apc)
 		return err;
 	}
 	apc->speed = resp.link_speed_mbps;
+	apc->max_speed = resp.qos_speed_mbps;
 	return 0;
 }
 
diff --git a/drivers/net/ethernet/microsoft/mana/mana_ethtool.c b/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
index 4fb3a04994a2..a1afa75a9463 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
@@ -495,6 +495,12 @@ static int mana_set_ringparam(struct net_device *ndev,
 static int mana_get_link_ksettings(struct net_device *ndev,
 				   struct ethtool_link_ksettings *cmd)
 {
+	struct mana_port_context *apc = netdev_priv(ndev);
+	int err;
+
+	err = mana_query_link_cfg(apc);
+	cmd->base.speed = (err) ? SPEED_UNKNOWN : apc->max_speed;
+
 	cmd->base.duplex = DUPLEX_FULL;
 	cmd->base.port = PORT_OTHER;
 
diff --git a/include/net/mana/mana.h b/include/net/mana/mana.h
index 038b18340e51..e1030a7d2daa 100644
--- a/include/net/mana/mana.h
+++ b/include/net/mana/mana.h
@@ -533,6 +533,8 @@ struct mana_port_context {
 	u16 port_idx;
 	/* Currently configured speed (mbps) */
 	u32 speed;
+	/* Maximum speed supported by the SKU (mbps) */
+	u32 max_speed;
 
 	bool port_is_up;
 	bool port_st_save; /* Saved port state */
-- 
2.34.1


