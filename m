Return-Path: <linux-hyperv+bounces-5872-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DF8EAD5974
	for <lists+linux-hyperv@lfdr.de>; Wed, 11 Jun 2025 17:01:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 728337AA9E9
	for <lists+linux-hyperv@lfdr.de>; Wed, 11 Jun 2025 14:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E0502BF3C3;
	Wed, 11 Jun 2025 14:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hROu9cu5"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B3C2BEC57;
	Wed, 11 Jun 2025 14:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749653999; cv=none; b=qakWjMQRwP3D5x2sYBL2pZj970JIOy5c4SMdyiz4GqMsKeK7CKYSff0kAQmA24R7IMfQ92l1bFhFAB+KqCfj3uI3qtN0WMaeXI+6IdWnLhHXB6QvFRvjILjpzu65NaqpSHk9KE3FFZAZBq9LUdndSqGgoVvhKFNpPVusPaVHobM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749653999; c=relaxed/simple;
	bh=PlJfPfdZ6LPISUeVTSiRPqUa55sVvPJwIdL6Z078ZH8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q8VB9WEV1agi89be2wR5IjqVuWH1eXldsU7Gl86F7y/0deOr9iPCR0qnm6JADiqbJK2Cj/DWDm1AayFZOuRwa/Uoh0UALmrJEFhnySCE8vBj7Mr+KfTXFAwwv7/sZ9AVwJHmKszIfdHqt3tqe2HsCawhQcXp4yYf8mY0aVx0oFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hROu9cu5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 343C8C4CEE3;
	Wed, 11 Jun 2025 14:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749653998;
	bh=PlJfPfdZ6LPISUeVTSiRPqUa55sVvPJwIdL6Z078ZH8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hROu9cu5UPfLUjlZlgWal5bkST6hIYyO5m/vQ7j/P5hsOWrM7464Me7QSDlXJG+X2
	 H9HUdRYrH0+vjHUN4yW/BEwq30vaweD+U2CpBFp0hED3i2Rp9lRIyxUW4xwl8LWhHo
	 4DrcEuU9/Fz6Bzxpymt/f6vFXrNOiX7DOWhbmfSp9xB4OXRsUb4DGUgT5ABz/DixXs
	 2j5v8VQhJ4zR5fQpur+BOtUxdMixKppglj9bB1zC2UjJVtqjGWkEdsh9aNIG0zoq1z
	 r7Lopjk61xcTBhODGHMnfpsbbvuh+en8RYoejnSIak66sFk+aQSwP7hVAj7maUzzPr
	 7u0GpEa/ODbHw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	ecree.xilinx@gmail.com,
	Jakub Kicinski <kuba@kernel.org>,
	kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	linux-hyperv@vger.kernel.org
Subject: [PATCH net-next 9/9] net: drv: hyperv: migrate to new RXFH callbacks
Date: Wed, 11 Jun 2025 07:59:49 -0700
Message-ID: <20250611145949.2674086-10-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250611145949.2674086-1-kuba@kernel.org>
References: <20250611145949.2674086-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for the new rxfh_fields callbacks, instead of de-muxing
the rxnfc calls. This driver does not support flow filtering so
the set_rxnfc callback is completely removed.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: kys@microsoft.com
CC: haiyangz@microsoft.com
CC: wei.liu@kernel.org
CC: decui@microsoft.com
CC: linux-hyperv@vger.kernel.org
---
 drivers/net/hyperv/netvsc_drv.c | 30 +++++++++++-------------------
 1 file changed, 11 insertions(+), 19 deletions(-)

diff --git a/drivers/net/hyperv/netvsc_drv.c b/drivers/net/hyperv/netvsc_drv.c
index c41a025c66f0..42d98e99566e 100644
--- a/drivers/net/hyperv/netvsc_drv.c
+++ b/drivers/net/hyperv/netvsc_drv.c
@@ -1580,9 +1580,10 @@ static void netvsc_get_strings(struct net_device *dev, u32 stringset, u8 *data)
 }
 
 static int
-netvsc_get_rss_hash_opts(struct net_device_context *ndc,
-			 struct ethtool_rxnfc *info)
+netvsc_get_rxfh_fields(struct net_device *ndev,
+		       struct ethtool_rxfh_fields *info)
 {
+	struct net_device_context *ndc = netdev_priv(ndev);
 	const u32 l4_flag = RXH_L4_B_0_1 | RXH_L4_B_2_3;
 
 	info->data = RXH_IP_SRC | RXH_IP_DST;
@@ -1637,16 +1638,17 @@ netvsc_get_rxnfc(struct net_device *dev, struct ethtool_rxnfc *info,
 	case ETHTOOL_GRXRINGS:
 		info->data = nvdev->num_chn;
 		return 0;
-
-	case ETHTOOL_GRXFH:
-		return netvsc_get_rss_hash_opts(ndc, info);
 	}
 	return -EOPNOTSUPP;
 }
 
-static int netvsc_set_rss_hash_opts(struct net_device_context *ndc,
-				    struct ethtool_rxnfc *info)
+static int
+netvsc_set_rxfh_fields(struct net_device *dev,
+		       const struct ethtool_rxfh_fields *info,
+		       struct netlink_ext_ack *extack)
 {
+	struct net_device_context *ndc = netdev_priv(dev);
+
 	if (info->data == (RXH_IP_SRC | RXH_IP_DST |
 			   RXH_L4_B_0_1 | RXH_L4_B_2_3)) {
 		switch (info->flow_type) {
@@ -1701,17 +1703,6 @@ static int netvsc_set_rss_hash_opts(struct net_device_context *ndc,
 	return -EOPNOTSUPP;
 }
 
-static int
-netvsc_set_rxnfc(struct net_device *ndev, struct ethtool_rxnfc *info)
-{
-	struct net_device_context *ndc = netdev_priv(ndev);
-
-	if (info->cmd == ETHTOOL_SRXFH)
-		return netvsc_set_rss_hash_opts(ndc, info);
-
-	return -EOPNOTSUPP;
-}
-
 static u32 netvsc_get_rxfh_key_size(struct net_device *dev)
 {
 	return NETVSC_HASH_KEYLEN;
@@ -1979,11 +1970,12 @@ static const struct ethtool_ops ethtool_ops = {
 	.set_channels   = netvsc_set_channels,
 	.get_ts_info	= ethtool_op_get_ts_info,
 	.get_rxnfc	= netvsc_get_rxnfc,
-	.set_rxnfc	= netvsc_set_rxnfc,
 	.get_rxfh_key_size = netvsc_get_rxfh_key_size,
 	.get_rxfh_indir_size = netvsc_rss_indir_size,
 	.get_rxfh	= netvsc_get_rxfh,
 	.set_rxfh	= netvsc_set_rxfh,
+	.get_rxfh_fields = netvsc_get_rxfh_fields,
+	.set_rxfh_fields = netvsc_set_rxfh_fields,
 	.get_link_ksettings = netvsc_get_link_ksettings,
 	.set_link_ksettings = netvsc_set_link_ksettings,
 	.get_ringparam	= netvsc_get_ringparam,
-- 
2.49.0


