Return-Path: <linux-hyperv+bounces-5932-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 29F1EADC31F
	for <lists+linux-hyperv@lfdr.de>; Tue, 17 Jun 2025 09:19:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 473FE1881977
	for <lists+linux-hyperv@lfdr.de>; Tue, 17 Jun 2025 07:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADDDB28D85F;
	Tue, 17 Jun 2025 07:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="YsOf1Xy5"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B049290BC6;
	Tue, 17 Jun 2025 07:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750144666; cv=none; b=BSDcT1mib6y4EgXLU+uhvVHyEPcNBUxO5vU817a1Ew2HAaiWoruNek5/X0BTfzXHsPP1eT0nwOBsIyH6j7MuePDYm8XeFcAWX7wppUoeLyYo1LYMQhhdcBhceqkIDNbuxBwO7E1RyEZ1vusUcTsiTgs9Z3kM3ncO4wxyFbSWwac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750144666; c=relaxed/simple;
	bh=F1gx+vQUf172w9LtF5/IcAONaJB4Rn6JW/DLAOvKpbs=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References; b=Zzwb+owVW03jCDpbXy+agejn7x5FHJbN9ja16X+nqHrI+lv/zw8lmBuQy/Ew8uGnoTQnVsDm9z44zXgRt15N3wE7ElXKqYuB6xdWzh5UrdlJWlQPAdh5RSih9PWTlFP+6+yvp4IS+RTdInPNePTztv6KipcXqhxvFb+4CsTZLcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=YsOf1Xy5; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1173)
	id C861921176DE; Tue, 17 Jun 2025 00:17:44 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C861921176DE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1750144664;
	bh=iuVu/Xa3ktHW/EAnoVfNYUcqYE9Q+71sMK3z+ize3FE=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=YsOf1Xy5hTI2oxbqUTFGo+722wGke5IoBpEN4NC/cooN7BGHR2TjeQijUIXjHjiaD
	 S5BHvWSP4J00O+qvS9eDmR+RP1rZPzy6o7bk2ATLlltmL4a2QO/majA6EpHePT6n8Y
	 9C2qW8LXFKW7alWITmP5h+Gx6eVAxKjaboRndxQo=
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
Subject: [PATCH net-next v3 4/4] net: mana: Handle unsupported HWC commands
Date: Tue, 17 Jun 2025 00:17:36 -0700
Message-Id: <1750144656-2021-5-git-send-email-ernis@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1750144656-2021-1-git-send-email-ernis@linux.microsoft.com>
References: <1750144656-2021-1-git-send-email-ernis@linux.microsoft.com>
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
Reviewed-by: Saurabh Singh Sengar <ssengar@linux.microsoft.com>
Reviewed-by: Dipayaan Roy <dipayanroy@linux.microsoft.com>
---
Changes in v3:
* Rebase to latest net-next branch.
Changes in v2:
* Define GDMA_STATUS_CMD_UNSUPPORTED for unsupported HWC status code
  instead of using -1.
---
 drivers/net/ethernet/microsoft/mana/hw_channel.c |  4 ++++
 drivers/net/ethernet/microsoft/mana/mana_en.c    | 11 +++++++++++
 include/net/mana/gdma.h                          |  1 +
 3 files changed, 16 insertions(+)

diff --git a/drivers/net/ethernet/microsoft/mana/hw_channel.c b/drivers/net/ethernet/microsoft/mana/hw_channel.c
index 3d3677c0d014..650d22654d49 100644
--- a/drivers/net/ethernet/microsoft/mana/hw_channel.c
+++ b/drivers/net/ethernet/microsoft/mana/hw_channel.c
@@ -891,6 +891,10 @@ int mana_hwc_send_request(struct hw_channel_context *hwc, u32 req_len,
 	}
 
 	if (ctx->status_code && ctx->status_code != GDMA_STATUS_MORE_ENTRIES) {
+		if (ctx->status_code == GDMA_STATUS_CMD_UNSUPPORTED) {
+			err = -EOPNOTSUPP;
+			goto out;
+		}
 		if (req_msg->req.msg_type != MANA_QUERY_PHY_STAT)
 			dev_err(hwc->dev, "HWC: Failed hw_channel req: 0x%x\n",
 				ctx->status_code);
diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index d7079e05dfb8..5aee7bda1504 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -847,6 +847,9 @@ static int mana_send_request(struct mana_context *ac, void *in_buf,
 	err = mana_gd_send_request(gc, in_len, in_buf, out_len,
 				   out_buf);
 	if (err || resp->status) {
+		if (err == -EOPNOTSUPP)
+			return err;
+
 		if (req->req.msg_type != MANA_QUERY_PHY_STAT)
 			dev_err(dev, "Failed to send mana message: %d, 0x%x\n",
 				err, resp->status);
@@ -1252,6 +1255,10 @@ int mana_query_link_cfg(struct mana_port_context *apc)
 				sizeof(resp));
 
 	if (err) {
+		if (err == -EOPNOTSUPP) {
+			netdev_info_once(ndev, "MANA_QUERY_LINK_CONFIG not supported\n");
+			return err;
+		}
 		netdev_err(ndev, "Failed to query link config: %d\n", err);
 		return err;
 	}
@@ -1294,6 +1301,10 @@ int mana_set_bw_clamp(struct mana_port_context *apc, u32 speed,
 				sizeof(resp));
 
 	if (err) {
+		if (err == -EOPNOTSUPP) {
+			netdev_info_once(ndev, "MANA_SET_BW_CLAMP not supported\n");
+			return err;
+		}
 		netdev_err(ndev, "Failed to set bandwidth clamp for speed %u, err = %d",
 			   speed, err);
 		return err;
diff --git a/include/net/mana/gdma.h b/include/net/mana/gdma.h
index bfae59202669..fdf144988cec 100644
--- a/include/net/mana/gdma.h
+++ b/include/net/mana/gdma.h
@@ -10,6 +10,7 @@
 #include "shm_channel.h"
 
 #define GDMA_STATUS_MORE_ENTRIES	0x00000105
+#define GDMA_STATUS_CMD_UNSUPPORTED	0xffffffff
 
 /* Structures labeled with "HW DATA" are exchanged with the hardware. All of
  * them are naturally aligned and hence don't need __packed.
-- 
2.34.1


