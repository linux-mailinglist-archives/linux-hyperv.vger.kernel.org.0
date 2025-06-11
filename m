Return-Path: <linux-hyperv+bounces-5852-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86D64AD4ED2
	for <lists+linux-hyperv@lfdr.de>; Wed, 11 Jun 2025 10:48:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32AEF3A9849
	for <lists+linux-hyperv@lfdr.de>; Wed, 11 Jun 2025 08:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B4EE248881;
	Wed, 11 Jun 2025 08:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="IT9XsNVh"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE020246BB3;
	Wed, 11 Jun 2025 08:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749631601; cv=none; b=WZtNA6cRmjI6fS2DzBLfGgG90x7wC1SJENUazuIDm+9SbDJnyDwuFD4LoLJvU2TPCEV7/CqV5lubiTSNVAekdl9HtSv8RhOTBVeTMw8TBVXu28s4Ts4KQL485xKte/B1ilqxM9hmBXKsN+uw/n61ip8ZV5mgiX9/WpB8Mj90YMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749631601; c=relaxed/simple;
	bh=oaCZKffoKTRaYLQaOQmKEatR6VZNaajk+LZ5gGTX9/I=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References; b=aVxYI37RXmB84U0pzqXqSK5LOOK9UENkTt1nRcFfuskrg/eub+hjA7D0CeIbhlRqsEKDtAnNgzs/FMXosCeKuaGWn43ctE/J/+6Kc9VQIQyxF0kG+061hIDCp/4rex6YxYkdUBG5otukUH2WOw7GSy1z2f/wlNA4dwzJSXrUK+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=IT9XsNVh; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1173)
	id 8AA74203EE33; Wed, 11 Jun 2025 01:46:39 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8AA74203EE33
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1749631599;
	bh=OGSFbFWlvID5n+uvvpGHPCf0P298GMnuBGj103nsKgk=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=IT9XsNVhUdwOhullceh//stg/VTqX6hASTpbI6H/bYh53wBAZ9z0PlXQlROx5B6ko
	 ckffP9CydkxFrl+/Dshg0Bpi5jz9a1B44dMeZfN9ObP4tWaYG9vOCofAi9FIU5hWqW
	 mWfHwNHT9rDhGISusRjINYwvkiioQw/wiqlzpjzg=
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
Subject: [PATCH net-next 4/4] net: mana: Handle unsupported HWC commands
Date: Wed, 11 Jun 2025 01:46:16 -0700
Message-Id: <1749631576-2517-5-git-send-email-ernis@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1749631576-2517-1-git-send-email-ernis@linux.microsoft.com>
References: <1749631576-2517-1-git-send-email-ernis@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

If any of the HWC commands are not recognized by the
underlying hardware, the hardware returns the response
header status of -1. Log the information using
netdev_info_once to avoid multiple error logs in dmesg.

Signed-off-by: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
Reviewed-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
---
 drivers/net/ethernet/microsoft/mana/hw_channel.c |  4 ++++
 drivers/net/ethernet/microsoft/mana/mana_en.c    | 11 +++++++++++
 2 files changed, 15 insertions(+)

diff --git a/drivers/net/ethernet/microsoft/mana/hw_channel.c b/drivers/net/ethernet/microsoft/mana/hw_channel.c
index a8c4d8db75a5..70c3b57b1e75 100644
--- a/drivers/net/ethernet/microsoft/mana/hw_channel.c
+++ b/drivers/net/ethernet/microsoft/mana/hw_channel.c
@@ -890,6 +890,10 @@ int mana_hwc_send_request(struct hw_channel_context *hwc, u32 req_len,
 	}
 
 	if (ctx->status_code && ctx->status_code != GDMA_STATUS_MORE_ENTRIES) {
+		if (ctx->status_code == -1) {
+			err = -EOPNOTSUPP;
+			goto out;
+		}
 		dev_err(hwc->dev, "HWC: Failed hw_channel req: 0x%x\n",
 			ctx->status_code);
 		err = -EPROTO;
diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index d5644400e71f..10e766c73fca 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -847,6 +847,9 @@ static int mana_send_request(struct mana_context *ac, void *in_buf,
 	err = mana_gd_send_request(gc, in_len, in_buf, out_len,
 				   out_buf);
 	if (err || resp->status) {
+		if (err == -EOPNOTSUPP)
+			return err;
+
 		dev_err(dev, "Failed to send mana message: %d, 0x%x\n",
 			err, resp->status);
 		return err ? err : -EPROTO;
@@ -1251,6 +1254,10 @@ int mana_query_link_cfg(struct mana_port_context *apc)
 				sizeof(resp));
 
 	if (err) {
+		if (err == -EOPNOTSUPP) {
+			netdev_info_once(ndev, "MANA_QUERY_LINK_CONFIG not supported\n");
+			return err;
+		}
 		netdev_err(ndev, "Failed to query link config: %d\n", err);
 		return err;
 	}
@@ -1293,6 +1300,10 @@ int mana_set_bw_clamp(struct mana_port_context *apc, u32 speed,
 				sizeof(resp));
 
 	if (err) {
+		if (err == -EOPNOTSUPP) {
+			netdev_info_once(ndev, "MANA_SET_BW_CLAMP not supported\n");
+			return err;
+		}
 		netdev_err(ndev, "Failed to set bandwidth clamp for speed %u, err = %d",
 			   speed, err);
 		return err;
-- 
2.34.1


