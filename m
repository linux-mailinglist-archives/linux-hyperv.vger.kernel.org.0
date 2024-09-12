Return-Path: <linux-hyperv+bounces-3002-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CF99976331
	for <lists+linux-hyperv@lfdr.de>; Thu, 12 Sep 2024 09:45:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F9C51C22574
	for <lists+linux-hyperv@lfdr.de>; Thu, 12 Sep 2024 07:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94A0718F2D3;
	Thu, 12 Sep 2024 07:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="qSGMdRyF"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 151E318E03D;
	Thu, 12 Sep 2024 07:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726127106; cv=none; b=TFOgu3YhsbF0T7xmw5aSG/3GT1ZxPFF0anF1FlS5vJMBFl9PfJhkUjcQoDP14SDBJY/T/pAPNe6OA3ARZIEfKCi+/IuEYoOklZy67+q/xDQtqx4Jsh+3r/cpXWI42bGkc3JBfq5Zx+N3PIHx+ZgjhK6jvnedFzo6rsJUmYf+8pE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726127106; c=relaxed/simple;
	bh=Xu6sHgDKfgjbkEDyE3lLSibg39hwTKnEOVkCaHjK/cE=;
	h=From:To:Subject:Date:Message-Id; b=IOJhiw3gTidcoWTRJQMPSJqqUrtALUDTIqGGAY3AAeXpcpTqpDdvMahdWkatNTJqsnaelNxLq0Y4PYti9bx8cQ4U/0t9EIplH4kGfrX63nkvH50Tubir41q7vi8L8nqC60WR2MZpx+Zkeky7m4hQ31obUx33M19gaAc8UEGmIf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=qSGMdRyF; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1173)
	id A01E220B9A9C; Thu, 12 Sep 2024 00:45:04 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A01E220B9A9C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1726127104;
	bh=jPfdFXZMhBELWCsu42PbhhsboZKB4K+0hkhbL/v0eZc=;
	h=From:To:Subject:Date:From;
	b=qSGMdRyF9DMPGqyStHV94plqd897WMSZn7iqv12xpXjMjiYpO3TpJB8JB+fC/4oZK
	 oaJL98B4vOUD1+hHio+A+Zz6bRi01GKX14ccEn4yreK1cfjbSXsW/+vr6Qx9jpOYC0
	 DtigHJ9C3VysAXg/w5SJ8CxjwOddb3ULFjy2Nvu8=
From: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	shradhagupta@linux.microsoft.com,
	ahmed.zaki@intel.com,
	ernis@linux.microsoft.com,
	colin.i.king@gmail.com,
	linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] net: mana: Add get_link and get_link_ksettings in ethtool
Date: Thu, 12 Sep 2024 00:44:43 -0700
Message-Id: <1726127083-28538-1-git-send-email-ernis@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Add support for the ethtool get_link and get_link_ksettings
operations. Display standard port information using ethtool.

Before the change:
$ethtool enP30832s1
>No data available

After the change:
$ethtool enP30832s1
>Settings for enP30832s1:
        Supported ports: [  ]
        Supported link modes:   Not reported
        Supported pause frame use: No
        Supports auto-negotiation: Yes
        Supported FEC modes: Not reported
        Advertised link modes:  Not reported
        Advertised pause frame use: No
        Advertised auto-negotiation: Yes
        Advertised FEC modes: Not reported
        Speed: Unknown!
        Duplex: Full
        Auto-negotiation: on
        Port: Direct Attach Copper
        PHYAD: 0
        Transceiver: internal
        Link detected: yes

Signed-off-by: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
Reviewed-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
---
 .../ethernet/microsoft/mana/mana_ethtool.c    | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/net/ethernet/microsoft/mana/mana_ethtool.c b/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
index 146d5db1792f..c2716d6cad36 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
@@ -369,6 +369,24 @@ static int mana_set_channels(struct net_device *ndev,
 	return err;
 }
 
+static int mana_get_link_ksettings(struct net_device *ndev,
+				   struct ethtool_link_ksettings *cmd)
+{
+	cmd->base.duplex = DUPLEX_FULL;
+	cmd->base.autoneg = AUTONEG_ENABLE;
+	cmd->base.port = PORT_DA;
+
+	ethtool_link_ksettings_zero_link_mode(cmd, supported);
+	ethtool_link_ksettings_zero_link_mode(cmd, advertising);
+
+	ethtool_link_ksettings_add_link_mode(cmd, supported,
+					     Autoneg);
+	ethtool_link_ksettings_add_link_mode(cmd, advertising,
+					     Autoneg);
+
+	return 0;
+}
+
 const struct ethtool_ops mana_ethtool_ops = {
 	.get_ethtool_stats	= mana_get_ethtool_stats,
 	.get_sset_count		= mana_get_sset_count,
@@ -380,4 +398,6 @@ const struct ethtool_ops mana_ethtool_ops = {
 	.set_rxfh		= mana_set_rxfh,
 	.get_channels		= mana_get_channels,
 	.set_channels		= mana_set_channels,
+	.get_link_ksettings	= mana_get_link_ksettings,
+	.get_link		= ethtool_op_get_link,
 };
-- 
2.34.1


