Return-Path: <linux-hyperv+bounces-3056-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ED0397DA3B
	for <lists+linux-hyperv@lfdr.de>; Fri, 20 Sep 2024 23:18:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFEA628294E
	for <lists+linux-hyperv@lfdr.de>; Fri, 20 Sep 2024 21:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9A1B184534;
	Fri, 20 Sep 2024 21:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="SUIzWG4E"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51BC2558BC;
	Fri, 20 Sep 2024 21:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726867107; cv=none; b=e9jZciN+FCKaNjw0TtzjWs3DlV9Vk64Sb5ovYJC9jDm7ymNQrujlprFw0t76s1NbqO6G7nrfdQ5EkJZZk25lJsQpFlxRW0B+SatNF+NsVWCVBkSMVMTsThrFxSuklTitn63flrWqmqfr+uXKdv2PfWIj4DT4OMO3bVCDCUOXaxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726867107; c=relaxed/simple;
	bh=VBBKALegdhR59CYTd2UllHzTLDvAds0WaiDy8WW2DKM=;
	h=From:To:Cc:Subject:Date:Message-Id; b=gDP5FBWZ3Qx7tm0gIRs4HSRBjioBjx/B8RbqG9XJ4gejkSteh/w7uXyyfpqOkAeW35SR3tzbu7/kDPzGWaYLDwX7YLQslqrAZO9g241HUyKu16EHyapA2gqUZU3BxDc97SFjN5IDYha4wuavusqOCdrLrJ1LHbGWtiag8svWoto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=SUIzWG4E; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1173)
	id D7C7820C0B35; Fri, 20 Sep 2024 14:18:25 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D7C7820C0B35
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1726867105;
	bh=BpdSP4DAHYZuzbODydBsRdZaeOFwXuLS3KrCe9Oaq38=;
	h=From:To:Cc:Subject:Date:From;
	b=SUIzWG4EvxhJEiPzddecPf7FqLD0/pGiQZ8fKbUVUDUFClbMRPZqybNB0OGC+vKRz
	 VXd5chVxUu5tyRBOwQ7UCUXRRzfEfpkEExzWv3EV3SIv0Bl6PC0sUesTuKgPDhscDP
	 ngVf/7RRnYc2/2dSafkDuX+mvwNeXoHYZ1M0jI/A=
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
	leon@kernel.org,
	colin.i.king@gmail.com,
	linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: ernis@microsoft.com,
	Erni Sri Satya Vennela <ernis@linux.microsoft.com>
Subject: [PATCH v2] net: mana: Add get_link and get_link_ksettings in ethtool
Date: Fri, 20 Sep 2024 14:18:23 -0700
Message-Id: <1726867103-19295-1-git-send-email-ernis@linux.microsoft.com>
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
> No data available

After the change:
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

Signed-off-by: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
Reviewed-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
---
Changes in v2:
* Remove support for displaying auto-negotiation details
* Change PORT_DA to PORT_OTHER
---
 drivers/net/ethernet/microsoft/mana/mana_ethtool.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/net/ethernet/microsoft/mana/mana_ethtool.c b/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
index dc3864377538..349f11bf8e64 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
@@ -443,6 +443,15 @@ static int mana_set_ringparam(struct net_device *ndev,
 	return err;
 }
 
+static int mana_get_link_ksettings(struct net_device *ndev,
+				   struct ethtool_link_ksettings *cmd)
+{
+	cmd->base.duplex = DUPLEX_FULL;
+	cmd->base.port = PORT_OTHER;
+
+	return 0;
+}
+
 const struct ethtool_ops mana_ethtool_ops = {
 	.get_ethtool_stats	= mana_get_ethtool_stats,
 	.get_sset_count		= mana_get_sset_count,
@@ -456,4 +465,6 @@ const struct ethtool_ops mana_ethtool_ops = {
 	.set_channels		= mana_set_channels,
 	.get_ringparam          = mana_get_ringparam,
 	.set_ringparam          = mana_set_ringparam,
+	.get_link_ksettings	= mana_get_link_ksettings,
+	.get_link		= ethtool_op_get_link,
 };
-- 
2.34.1


