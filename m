Return-Path: <linux-hyperv+bounces-5931-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC9BDADC319
	for <lists+linux-hyperv@lfdr.de>; Tue, 17 Jun 2025 09:18:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1164D163D66
	for <lists+linux-hyperv@lfdr.de>; Tue, 17 Jun 2025 07:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89B6B28F957;
	Tue, 17 Jun 2025 07:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="gTaIaXpn"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 017E628DEE7;
	Tue, 17 Jun 2025 07:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750144662; cv=none; b=cU3RwsGwSCpgdMOa7ATymjiEHukBVWgzLjqk9mgujQSLzBgDI/yi5/BcFvfXxGCD1WJxU5O64tOmF3ZdgNtrTtVv1+yUGopxRAbNO3NDRdLutlbohOmY0Hi+tASyfuqd0UO5r0Ju21UBmhDDsh6ShvPQHfMcgLSIf1iARILg14o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750144662; c=relaxed/simple;
	bh=T9yd8H4YOedrDSVr6d4darIYXetU1jiE5huP6f7FyEY=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References; b=Sni9Zty8W2mXfIcRjVYjclUEvfaH+jmdhFxqmXdFA6PYJbfKtlGzy1aroEq0cVYcISMuypbc0F0rJdZqVoFbUaV2eQSrLStqIFqdc9XWNPxYsDLNpkekSFEJjiaEBdRvfz90zHsgrAcz+AFFHWVb4GqEylZoM3CwN8OR68QRMcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=gTaIaXpn; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1173)
	id C6CF321176CF; Tue, 17 Jun 2025 00:17:40 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C6CF321176CF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1750144660;
	bh=nrlXlBoYW/LWTQTyysbIz35GJZffDR5Fc1lmm33ZF+M=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=gTaIaXpn1Le4u2RWPx2QKrMRW3cn+Q1dbaqm6y4X0GpQQQHtH+TSImV5KdE/CWKc6
	 KfF6B9eHOR7v5+eqdJ2AaCKA4NKdAvfS5aRlGLtnpL1faMh6aj9eukWMaDY7btPKBA
	 qPb2jPGGDMJCK67osgJthgZSXRhQQOJZcyoVaUCw=
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
Subject: [PATCH net-next v3 3/4] net: mana: Add speed support in mana_get_link_ksettings
Date: Tue, 17 Jun 2025 00:17:35 -0700
Message-Id: <1750144656-2021-4-git-send-email-ernis@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1750144656-2021-1-git-send-email-ernis@linux.microsoft.com>
References: <1750144656-2021-1-git-send-email-ernis@linux.microsoft.com>
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
Changes in v3:
* Rebase to latest net-next branch.
Changes in v2:
* No change.
---
 drivers/net/ethernet/microsoft/mana/mana_en.c      | 1 +
 drivers/net/ethernet/microsoft/mana/mana_ethtool.c | 6 ++++++
 include/net/mana/mana.h                            | 2 ++
 3 files changed, 9 insertions(+)

diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index 547dff450b6d..d7079e05dfb8 100644
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


