Return-Path: <linux-hyperv+bounces-4981-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B60DA94C9E
	for <lists+linux-hyperv@lfdr.de>; Mon, 21 Apr 2025 08:34:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9569B189049F
	for <lists+linux-hyperv@lfdr.de>; Mon, 21 Apr 2025 06:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83BAD25A347;
	Mon, 21 Apr 2025 06:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="HUyIWJxt"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0732825A2AD;
	Mon, 21 Apr 2025 06:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745217229; cv=none; b=A6cC9tpmo2jilRM/GTo3d8mMpiOePMiMwcjgEOjZPTN2ARDD07VOophWXDL7lXVgPjdlcd6iF/gLyawz5l+msRLc+bSokfrbN4CYtXthgyOUGq7eEKNMDf3GWkhthJoGBWoF+fwEw9QXDiP3LSkiaHc2c9oxsqzTErQ0kBwgpwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745217229; c=relaxed/simple;
	bh=hRmSIMzuR8/d0m4/o0m6zhYGARd5ejlhgq0mGsurWvw=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References; b=ZZYu9o44PS5Rd12Kq1iwaO+ZhvCl8HXcGMNvlk9b33Z5rQ349IjzlrkbnUTxWllWr7pJWYPm5TfKcdj4ntnit39tGgN2DQo2Y2zOO7lwsO3ZIRmp6O8Am6pN8WjbLwn4I/lycRxWyxs+jSNvA8C0/n1v6hdNylu+4nVcwWXkZnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=HUyIWJxt; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1173)
	id B14DE203B850; Sun, 20 Apr 2025 23:33:47 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B14DE203B850
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1745217227;
	bh=v+YKiVMo3CwEZb5eXCob7rQ/kDOa2zbLDf495DUK0rs=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=HUyIWJxt3tyu9qxynq+hMU7X8jdGekKiGbXEoE7cmDpJ79qAMfWIDJznH+KhPtIBO
	 Z7woID3u9EvSFn6m/Do7whLxnD/CiRywKo5K/nSSfcFQcSarhV08zVtkG2Evu0UOot
	 F10QSbP3yqv1QOGBW1PwYpwjQfRuxxUMk4XOKf/0=
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
	mhklinux@outlook.com,
	pasha.tatashin@soleen.com,
	ernis@linux.microsoft.com,
	kent.overstreet@linux.dev,
	brett.creeley@amd.com,
	schakrabarti@linux.microsoft.com,
	shradhagupta@linux.microsoft.com,
	ssengar@linux.microsoft.com,
	leon@kernel.org,
	rosenp@gmail.com,
	paulros@microsoft.com,
	linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org
Subject: [PATCH v2 3/3] net: mana: Handle unsupported HWC commands
Date: Sun, 20 Apr 2025 23:33:40 -0700
Message-Id: <1745217220-11468-4-git-send-email-ernis@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1745217220-11468-1-git-send-email-ernis@linux.microsoft.com>
References: <1745217220-11468-1-git-send-email-ernis@linux.microsoft.com>
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
Reviewed-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
---
Changes in v2:
* No change.
---
 drivers/net/ethernet/microsoft/mana/hw_channel.c |  4 ++++
 drivers/net/ethernet/microsoft/mana/mana_en.c    | 11 +++++++++++
 2 files changed, 15 insertions(+)

diff --git a/drivers/net/ethernet/microsoft/mana/hw_channel.c b/drivers/net/ethernet/microsoft/mana/hw_channel.c
index 1ba49602089b..58cfd247d8c5 100644
--- a/drivers/net/ethernet/microsoft/mana/hw_channel.c
+++ b/drivers/net/ethernet/microsoft/mana/hw_channel.c
@@ -871,6 +871,10 @@ int mana_hwc_send_request(struct hw_channel_context *hwc, u32 req_len,
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
index 5b62f1443716..cb6a583b32d9 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -871,6 +871,9 @@ static int mana_send_request(struct mana_context *ac, void *in_buf,
 	err = mana_gd_send_request(gc, in_len, in_buf, out_len,
 				   out_buf);
 	if (err || resp->status) {
+		if (err == -EOPNOTSUPP)
+			return err;
+
 		dev_err(dev, "Failed to send mana message: %d, 0x%x\n",
 			err, resp->status);
 		return err ? err : -EPROTO;
@@ -1269,6 +1272,10 @@ int mana_query_link_cfg(struct mana_port_context *apc)
 				sizeof(resp));
 
 	if (err) {
+		if (err == -EOPNOTSUPP) {
+			netdev_info_once(ndev, "MANA_QUERY_LINK_CONFIG not supported\n");
+			goto out;
+		}
 		netdev_err(ndev, "Failed to query link config: %d\n", err);
 		goto out;
 	}
@@ -1313,6 +1320,10 @@ int mana_set_bw_clamp(struct mana_port_context *apc, u32 speed,
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


