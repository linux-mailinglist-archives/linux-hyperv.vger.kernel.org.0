Return-Path: <linux-hyperv+bounces-9094-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WBgIHhLNpWm1GwAAu9opvQ
	(envelope-from <linux-hyperv+bounces-9094-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 02 Mar 2026 18:46:58 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1620C1DE02C
	for <lists+linux-hyperv@lfdr.de>; Mon, 02 Mar 2026 18:46:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 19C30304FF8F
	for <lists+linux-hyperv@lfdr.de>; Mon,  2 Mar 2026 17:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADFB6426EBF;
	Mon,  2 Mar 2026 17:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="rcAQtLNS"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EB5841C0B5;
	Mon,  2 Mar 2026 17:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772473346; cv=none; b=dKsV4h8niIp78o/EBAzcFoHmpIBuxCac4L/Vl//qE7hxeQVn4oFKjBJ2lVmUFI5Ae5Yf9iVoiLX6zk54qej1aNdey0UkloQh3A04pkDyB2gmCaWmYk2xlk6lMD0xcW+NnN1EH1Vcel8r7LlonisI6wkD6676Whxp4vNayWBm0qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772473346; c=relaxed/simple;
	bh=1Mp0vDVQcDgl7Qklj750thfupk0/BQ3aTXvNOMtXHAc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=ahfOwo2ESKOlKKy89npmxmezWM3m82VKvwpfMlCgy6gbWvPFFg+NNFXrYWpontZdfUWFnBoJOXTzuIMVNJKSV0X4SXO9Nr1FQcTAtWk5zyHIcfnPLkaspD9ULlsSqaOljYWyAXar4HdjIsfd59mXN5gG63D0GQcEYBkog9HhcgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=rcAQtLNS; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1173)
	id 36E6820B6F02; Mon,  2 Mar 2026 09:42:19 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 36E6820B6F02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1772473339;
	bh=803R9Og+OhLJbeAslGl4Pw1Lizqc+NMZMaMU6c6NYeo=;
	h=From:To:Subject:Date:From;
	b=rcAQtLNS3J48Yw4KT/EQzDevgEdvBLjWpLfYjTpLekPM7k6NH8/GMhqzoAckirPuo
	 xbzqg2gGd+WFLQSQMfQq5WUXGQmAYxU6qs7AYn2XrusDCRyRTmKTxXN7Jc9WEAjfe1
	 9Mvq0g8SmPhUiTAe04qjSu0wUTcj1657VYzTEQEw=
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
	dipayanroy@linux.microsoft.com,
	shirazsaleem@microsoft.com,
	kees@kernel.org,
	ernis@linux.microsoft.com,
	shradhagupta@linux.microsoft.com,
	gargaditya@linux.microsoft.com,
	linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v5] net: mana: Add MAC address to vPort logs and clarify error messages
Date: Mon,  2 Mar 2026 09:41:52 -0800
Message-ID: <20260302174204.234837-1-ernis@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 1620C1DE02C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9094-lists,linux-hyperv=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ernis@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_TWELVE(0.00)[19];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.microsoft.com:dkim,linux.microsoft.com:mid]
X-Rspamd-Action: no action

Add MAC address to vPort configuration success message and update error
message to be more specific about HWC message errors in
mana_send_request.

Signed-off-by: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
---
Changes in v5:
* Remove __func__ and __LINE__ from error logs in hw_channel.c
Changes in v4:
* Remove logs that do not add value in hw_channel.c.
Changes in v3:
* Remove the changes from v2 and Update commit message.
* Use "Enabled vPort ..." instead of "Configured vPort" in
  mana_cfg_vport.
* Update error logs in mana_hwc_send_request.
Changes in v2:
* Update commit message.
* Use "Enabled vPort ..." instead of "Configured vPort" in
  mana_cfg_vport.
* Add info log in mana_uncfg_vport, mana_gd_verify_vf_version,
  mana_gd_query_max_resources, mana_query_device_cfg and
  mana_query_vport_cfg.
---
 drivers/net/ethernet/microsoft/mana/hw_channel.c | 12 +++++++-----
 drivers/net/ethernet/microsoft/mana/mana_en.c    |  8 ++++----
 2 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/microsoft/mana/hw_channel.c b/drivers/net/ethernet/microsoft/mana/hw_channel.c
index ba3467f1e2ea..91975bdb5686 100644
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
+			dev_err(hwc->dev, "Command 0x%x timed out: %u ms\n",
+				command, hwc->hwc_timeout);
 
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
+			dev_err(hwc->dev, "Command 0x%x failed with status: 0x%x\n",
+				command, ctx->status_code);
 		err = -EPROTO;
 		goto out;
 	}
diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index 933e9d681ded..e25d85b38845 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -1021,8 +1021,8 @@ static int mana_send_request(struct mana_context *ac, void *in_buf,
 
 		if (req->req.msg_type != MANA_QUERY_PHY_STAT &&
 		    mana_need_log(gc, err))
-			dev_err(dev, "Failed to send mana message: %d, 0x%x\n",
-				err, resp->status);
+			dev_err(dev, "Command 0x%x failed with status: 0x%x, err: %d\n",
+				req->req.msg_type, resp->status, err);
 		return err ? err : -EPROTO;
 	}
 
@@ -1335,8 +1335,8 @@ int mana_cfg_vport(struct mana_port_context *apc, u32 protection_dom_id,
 	apc->tx_shortform_allowed = resp.short_form_allowed;
 	apc->tx_vp_offset = resp.tx_vport_offset;
 
-	netdev_info(apc->ndev, "Configured vPort %llu PD %u DB %u\n",
-		    apc->port_handle, protection_dom_id, doorbell_pg_id);
+	netdev_info(apc->ndev, "Enabled vPort %llu PD %u DB %u MAC %pM\n",
+		    apc->port_handle, protection_dom_id, doorbell_pg_id, apc->mac_addr);
 out:
 	if (err)
 		mana_uncfg_vport(apc);
-- 
2.34.1


