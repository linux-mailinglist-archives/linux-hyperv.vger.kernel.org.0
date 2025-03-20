Return-Path: <linux-hyperv+bounces-4646-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F2B3FA6A637
	for <lists+linux-hyperv@lfdr.de>; Thu, 20 Mar 2025 13:23:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC9788A018F
	for <lists+linux-hyperv@lfdr.de>; Thu, 20 Mar 2025 12:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1044B224B08;
	Thu, 20 Mar 2025 12:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Fv1hnl/B"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D1DF2236E4;
	Thu, 20 Mar 2025 12:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742473349; cv=none; b=KNMWkxj2H1eozo4WnaEFrB/dzHY/W6NxoeTR7g2hJVGDB2Ahvs9QL0qpsf6EoxXmMpq9ro51j7v118vS/mPbUj3nme1qRYX2PaJq5mnxk86SVsrMPPPYSf2fWPvA/bsytJTd8ZMSZvILzfnxZJ3dp1HBYGtL9CDnpgVmZJ4Pd0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742473349; c=relaxed/simple;
	bh=aazNratN0oWjwOMuxNbCnK6kCy2vL37vrBIHfF8mJzM=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References; b=OoeC6qaQk5iXUM9yXn3OTlseaUnnfjo2qejpcvgSWYEXALgCLxX4ERdGt77bjStHe2Prpx0dCJMoOTya1MMzmwtTJBYg04LDHU2ZhFGq/3jO2G1DqofI15hNIuL9jvHKpqAzAsbtRtiGbuHs6sQC7arb/+/zYlcPju6TBmtThCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Fv1hnl/B; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1173)
	id 2DD1D2116B4E; Thu, 20 Mar 2025 05:22:27 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2DD1D2116B4E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1742473347;
	bh=6s0mgp4lHlYiXENPZ/aQQnsAe9IPm+594571JdrFWmc=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Fv1hnl/BNf5GZRqezgFk66HSIygFUTaDMKiwAXP614qHEFvZKgNPE7LtlrHp/AX2i
	 4QaehBLvZ0PYuGFMUR0GNezyqeVGG4a7UKcMCDrDa7cq6S+c07GDAm7wXGU2q9wAJr
	 deZz83cJQc22Y+HjGa7I7lLZOmfgOsEWeS5WAGgM=
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
	brett.creeley@amd.com,
	ernis@linux.microsoft.com,
	surenb@google.com,
	schakrabarti@linux.microsoft.com,
	kent.overstreet@linux.dev,
	shradhagupta@linux.microsoft.com,
	erick.archer@outlook.com,
	rosenp@gmail.com,
	linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org
Subject: [PATCH 3/3] net: mana: Handle unsupported HWC commands
Date: Thu, 20 Mar 2025 05:22:21 -0700
Message-Id: <1742473341-15262-4-git-send-email-ernis@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1742473341-15262-1-git-send-email-ernis@linux.microsoft.com>
References: <1742473341-15262-1-git-send-email-ernis@linux.microsoft.com>
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
index a00f915c5188..280218895c0e 100644
--- a/drivers/net/ethernet/microsoft/mana/hw_channel.c
+++ b/drivers/net/ethernet/microsoft/mana/hw_channel.c
@@ -867,6 +867,10 @@ int mana_hwc_send_request(struct hw_channel_context *hwc, u32 req_len,
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
index bcc273427423..898d18b220b8 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -779,6 +779,9 @@ static int mana_send_request(struct mana_context *ac, void *in_buf,
 	err = mana_gd_send_request(gc, in_len, in_buf, out_len,
 				   out_buf);
 	if (err || resp->status) {
+		if (err == -EOPNOTSUPP)
+			return err;
+
 		dev_err(dev, "Failed to send mana message: %d, 0x%x\n",
 			err, resp->status);
 		return err ? err : -EPROTO;
@@ -1177,6 +1180,10 @@ int mana_query_link_cfg(struct mana_port_context *apc)
 				sizeof(resp));
 
 	if (err) {
+		if (err == -EOPNOTSUPP) {
+			netdev_info_once(ndev, "MANA_QUERY_LINK_CONFIG not supported\n");
+			goto out;
+		}
 		netdev_err(ndev, "Failed to query link config: %d\n", err);
 		goto out;
 	}
@@ -1220,6 +1227,10 @@ int mana_set_bw_clamp(struct mana_port_context *apc, u32 speed)
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


