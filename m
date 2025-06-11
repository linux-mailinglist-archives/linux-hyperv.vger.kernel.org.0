Return-Path: <linux-hyperv+bounces-5851-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EADD8AD4EC3
	for <lists+linux-hyperv@lfdr.de>; Wed, 11 Jun 2025 10:47:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52CE917D4A5
	for <lists+linux-hyperv@lfdr.de>; Wed, 11 Jun 2025 08:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F99F247287;
	Wed, 11 Jun 2025 08:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="XGgjj2eQ"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98DAF244696;
	Wed, 11 Jun 2025 08:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749631600; cv=none; b=MjJCyvvVDyzPD36+JAuWUUof0T65uwalJwjmbVUYxHXfTojHqQTxtn32qXtGW9KRHPE7zQlRpDlTeVvs/qTLDvF0udftynqnDswX2x62X5RvMcw4JsfauKFCh7cmWd42bWMimtZAsIeh3DqzhSGBi1PELfSD1iq9i6ys1esmaRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749631600; c=relaxed/simple;
	bh=B5QcjUw1TVB/cgcJXO0yOq+qijZPDe2RgswZ2wz1BQ8=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References; b=eNc5zuyBionyDjhVuzT7xGmg3HI0ZUq7Z+i2zf2cYzVgIGC3ol8f050OUwvsbOPEBkvTByu6ihRXECPbAtkToEvB0rQl4owdiD1+tX597ZEGFKl1vU7MI9XBbuFndlVddfn/71q2ov945tpVOfVHRfLzEph2jPL5cB5cN4N1UbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=XGgjj2eQ; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1173)
	id 4E060211518F; Wed, 11 Jun 2025 01:46:38 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4E060211518F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1749631598;
	bh=I6vB1Wq27t0k520nUYZpKG2BNw+dELu8m+xor7KkEjI=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=XGgjj2eQDxSSGSxnN6VTn6LiUGdMAHblbeRDlk/8Ka8ziPJapig03AVbivZKtO4Df
	 f+dI0vCdOoM0hr7ySIDsUfCUXNDdBmxMgIfb47azc4dkUTAzhQHMv3l6AvfSHqAiYN
	 gYkuBpZm35oimOe/tLT/G65emXLvY2s4cvsAcz14=
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
	kotaranov@microsoft.com,
	longli@microsoft.com,
	horms@kernel.org,
	shirazsaleem@microsoft.com,
	leon@kernel.org,
	ernis@linux.microsoft.com,
	shradhagupta@linux.microsoft.com,
	schakrabarti@linux.microsoft.com,
	rosenp@gmail.com,
	sdf@fomichev.me,
	linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org
Subject: [PATCH net-next 3/4] net: mana: Add speed support in mana_get_link_ksettings
Date: Wed, 11 Jun 2025 01:46:15 -0700
Message-Id: <1749631576-2517-4-git-send-email-ernis@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1749631576-2517-1-git-send-email-ernis@linux.microsoft.com>
References: <1749631576-2517-1-git-send-email-ernis@linux.microsoft.com>
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

These APIs when invoked on hardware that are older ot that do
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
---
 drivers/net/ethernet/microsoft/mana/mana_en.c      | 1 +
 drivers/net/ethernet/microsoft/mana/mana_ethtool.c | 6 ++++++
 include/net/mana/mana.h                            | 2 ++
 3 files changed, 9 insertions(+)

diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index b704dbc5e344..d5644400e71f 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -1271,6 +1271,7 @@ int mana_query_link_cfg(struct mana_port_context *apc)
 		return err;
 	}
 	apc->speed = resp.link_speed_mbps;
+	apc->max_speed = resp.qos_speed_mbps;
 	return 0;
 }
 
diff --git a/drivers/net/ethernet/microsoft/mana/mana_ethtool.c b/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
index c419626073f5..1026b0b2b59f 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
@@ -427,6 +427,12 @@ static int mana_set_ringparam(struct net_device *ndev,
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
index 0df84e51d541..5f38dec04d31 100644
--- a/include/net/mana/mana.h
+++ b/include/net/mana/mana.h
@@ -474,6 +474,8 @@ struct mana_port_context {
 	u16 port_idx;
 	/* Currently configured speed (mbps) */
 	u32 speed;
+	/* Maximum speed supported by the SKU (mbps) */
+	u32 max_speed;
 
 	bool port_is_up;
 	bool port_st_save; /* Saved port state */
-- 
2.34.1


