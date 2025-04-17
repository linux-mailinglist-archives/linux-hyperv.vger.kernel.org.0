Return-Path: <linux-hyperv+bounces-4952-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 916A7A915E8
	for <lists+linux-hyperv@lfdr.de>; Thu, 17 Apr 2025 09:58:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A441A441B67
	for <lists+linux-hyperv@lfdr.de>; Thu, 17 Apr 2025 07:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3530D2253A0;
	Thu, 17 Apr 2025 07:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="i31VlCss"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0DEC224247;
	Thu, 17 Apr 2025 07:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744876642; cv=none; b=rO7FUlsDVKaWtN6/oUnS9Ar2AKfCtJwnZ3tNTLkkmQs3kh6MS9tH4FWi1qhHuUVBy0Gt6qqoYLik8aLtzP3WpZz44oMpB63/AskvUsX+nq6rRAJwZimlJaYWe2UCF0goELL0TaIQws8fFBVZuMynyLkDvOrBAXvdWmQKu3L7tn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744876642; c=relaxed/simple;
	bh=6lGxmJVYVxjRwe76iUsWZkXtNM2Dgrh021u/8o3aOvE=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References; b=nyvJk5XrjViQULIQjchyiKVF9zg8/Zpt5HBMYD5jlBdefGzsq41yR5Ja660Q2a0Hho/GkLU9BIa6TupzxhbkjwyFbz0HmBtLk4wddiws6zaqB5Y/gW8iw1EZSz/Af2S/BHUu1wQmFQb6uiV6rwkNYobt0C9i6Jki8d5gOcK1nKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=i31VlCss; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1173)
	id 63A4B21199CA; Thu, 17 Apr 2025 00:57:20 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 63A4B21199CA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1744876640;
	bh=8Sod1/Snb5hoL+uu1iLAQXJymDjixJgq0BF+csuNHpI=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=i31VlCssdGj2yZKPirQdpDcaETjmLdhUPFphefCfjetvrIxAi/GZf9mIjQI0hNj2J
	 CaoMYOGikVlUu/Pl4JEPbk24U72O8KBzg7+G2iXYlg05spPRZm9HjHFyoUbM/4QDYz
	 733hVkupzXqpWzQVq8+pk/RlTsrHRrPD4NVyVr+w=
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
	kent.overstreet@linux.dev,
	brett.creeley@amd.com,
	schakrabarti@linux.microsoft.com,
	ernis@linux.microsoft.com,
	shradhagupta@linux.microsoft.com,
	ssengar@linux.microsoft.com,
	rosenp@gmail.com,
	paulros@microsoft.com,
	linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org
Subject: [PATCH 3/3] net: mana: Handle unsupported HWC commands
Date: Thu, 17 Apr 2025 00:57:10 -0700
Message-Id: <1744876630-26918-4-git-send-email-ernis@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1744876630-26918-1-git-send-email-ernis@linux.microsoft.com>
References: <1744876630-26918-1-git-send-email-ernis@linux.microsoft.com>
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


