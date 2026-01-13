Return-Path: <linux-hyperv+bounces-8253-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 18DD0D16B17
	for <lists+linux-hyperv@lfdr.de>; Tue, 13 Jan 2026 06:25:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 21D86301B4AA
	for <lists+linux-hyperv@lfdr.de>; Tue, 13 Jan 2026 05:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A90BD2E62A2;
	Tue, 13 Jan 2026 05:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="qlW3jH9/"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E6D1258EF3;
	Tue, 13 Jan 2026 05:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768281903; cv=none; b=qqufqCbPxB2+so6bt1HRQAzvx3fiEaSBTrnzEeaLyWx89biFqTN3pYYF38PaE80x9kcJgF/vjn/+8K08rnwNf5H1NWeEuefHVTkESKyeUHIDhSDtXnO8bdp7oZ6J2OoCYu0UQHVHTk6oANIunmEcqRzuH2neIr1J7yDgwHcb+rI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768281903; c=relaxed/simple;
	bh=xOKw3Zeb/nUfh9+NJB/hbKdH5VkXZKOQUbGqG/OJM8M=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=BZvh8XET54kDKv437INKNvVsLD5PuBKOvJvHjjg6XPaKBdqyPRyr0qmnID/KiF34SToyz8CjFhmPpVxNO8YyImpGQ7Mjj1IZ5KR1x3eupUYt3v0Gs9fiUkn83jGAWDzTjSTFlXXtJ9DIEGXdEEo55RGQg1xNrxMm4JATzqbIH/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=qlW3jH9/; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1173)
	id DCDB720B716B; Mon, 12 Jan 2026 21:25:01 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com DCDB720B716B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1768281901;
	bh=Ci1DvAACpgzBeefn/TT61dYqGcygCuZWzY5SkkICp0g=;
	h=From:To:Subject:Date:From;
	b=qlW3jH9/dDJgK0/cuvqSEyXFCjr+8ZvuwHMG92+sygJmnBIp63EOAnye+jobBo7dh
	 OfDA8yZhtYRPT+Wyj530Eg4FjimbueDOxXlqAFmrOL2g20wC3XRACMY+G1XsaNcKdA
	 VbQUHydln9hS15uKOiP4uoNZlyKv6oCHr6by5gqE=
From: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	longli@microsoft.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	ernis@linux.microsoft.com,
	dipayanroy@linux.microsoft.com,
	ssengar@linux.microsoft.com,
	shirazsaleem@microsoft.com,
	shradhagupta@linux.microsoft.com,
	gargaditya@linux.microsoft.com,
	linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] net: mana: Add MAC address to vPort logs and clarify error messages
Date: Mon, 12 Jan 2026 21:24:58 -0800
Message-ID: <20260113052458.25338-1-ernis@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add MAC address to vPort configuration success message and update error
message to be more specific about HWC message errors in
mana_send_request.

Signed-off-by: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
---
 drivers/net/ethernet/microsoft/mana/hw_channel.c | 12 +++++++-----
 drivers/net/ethernet/microsoft/mana/mana_en.c    |  8 ++++----
 2 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/microsoft/mana/hw_channel.c b/drivers/net/ethernet/microsoft/mana/hw_channel.c
index aa4e2731e2ba..95402c5e90fa 100644
--- a/drivers/net/ethernet/microsoft/mana/hw_channel.c
+++ b/drivers/net/ethernet/microsoft/mana/hw_channel.c
@@ -853,6 +853,7 @@ int mana_hwc_send_request(struct hw_channel_context *hwc, u32 req_len,
 	struct hwc_caller_ctx *ctx;
 	u32 dest_vrcq = 0;
 	u32 dest_vrq = 0;
+	u32 command;
 	u16 msg_id;
 	int err;
 
@@ -878,6 +879,7 @@ int mana_hwc_send_request(struct hw_channel_context *hwc, u32 req_len,
 	req_msg->req.hwc_msg_id = msg_id;
 
 	tx_wr->msg_size = req_len;
+	command = req_msg->req.msg_type;
 
 	if (gc->is_pf) {
 		dest_vrq = hwc->pf_dest_vrq_id;
@@ -893,8 +895,8 @@ int mana_hwc_send_request(struct hw_channel_context *hwc, u32 req_len,
 	if (!wait_for_completion_timeout(&ctx->comp_event,
 					 (msecs_to_jiffies(hwc->hwc_timeout)))) {
 		if (hwc->hwc_timeout != 0)
-			dev_err(hwc->dev, "HWC: Request timed out: %u ms\n",
-				hwc->hwc_timeout);
+			dev_err(hwc->dev, "HWC: Request timed out: %u ms for command 0x%x\n",
+				hwc->hwc_timeout, command);
 
 		/* Reduce further waiting if HWC no response */
 		if (hwc->hwc_timeout > 1)
@@ -914,9 +916,9 @@ int mana_hwc_send_request(struct hw_channel_context *hwc, u32 req_len,
 			err = -EOPNOTSUPP;
 			goto out;
 		}
-		if (req_msg->req.msg_type != MANA_QUERY_PHY_STAT)
-			dev_err(hwc->dev, "HWC: Failed hw_channel req: 0x%x\n",
-				ctx->status_code);
+		if (command != MANA_QUERY_PHY_STAT)
+			dev_err(hwc->dev, "hw_channel command 0x%x failed with status: 0x%x\n",
+				command, ctx->status_code);
 		err = -EPROTO;
 		goto out;
 	}
diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index 1ad154f9db1a..f0584262e95b 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -975,8 +975,8 @@ static int mana_send_request(struct mana_context *ac, void *in_buf,
 
 		if (req->req.msg_type != MANA_QUERY_PHY_STAT &&
 		    mana_need_log(gc, err))
-			dev_err(dev, "Failed to send mana message: %d, 0x%x\n",
-				err, resp->status);
+			dev_err(dev, "Command 0x%x failed with status: 0x%x, err: %d\n",
+				req->req.msg_type, resp->status, err);
 		return err ? err : -EPROTO;
 	}
 
@@ -1289,8 +1289,8 @@ int mana_cfg_vport(struct mana_port_context *apc, u32 protection_dom_id,
 	apc->tx_shortform_allowed = resp.short_form_allowed;
 	apc->tx_vp_offset = resp.tx_vport_offset;
 
-	netdev_info(apc->ndev, "Configured vPort %llu PD %u DB %u\n",
-		    apc->port_handle, protection_dom_id, doorbell_pg_id);
+	netdev_info(apc->ndev, "Configured vPort %llu PD %u DB %u MAC %pM\n",
+		    apc->port_handle, protection_dom_id, doorbell_pg_id, apc->mac_addr);
 out:
 	if (err)
 		mana_uncfg_vport(apc);
-- 
2.34.1


