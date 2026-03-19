Return-Path: <linux-hyperv+bounces-9625-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IMa7HItevGlxxQIAu9opvQ
	(envelope-from <linux-hyperv+bounces-9625-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2026 21:37:31 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E7DEB2D2409
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2026 21:37:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B238730CF20A
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2026 20:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29FCB407101;
	Thu, 19 Mar 2026 20:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GLmUfEl5"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4D2405AD1
	for <linux-hyperv@vger.kernel.org>; Thu, 19 Mar 2026 20:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773951976; cv=none; b=tdw/elVk5jaq4XKazbqrBK0lp03tB3/5gtGU4my5JKH2sC9tuT7g7IE3AWzZkdrWeKzTH5QS8SiXSeSah4BHD0OTLTw94wuZYnHNVwM9WqLUsKii4qjJVBNYiotVFdnNWZQ5/uag1wMGB8b/tPW/yuRhKzOx0uuKvK8mOHfDy6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773951976; c=relaxed/simple;
	bh=RXAKopPqswssMamyZTu+CjsystEpYm23+bEkJx/MHsI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YB1YBEDfGPkDbHcMLEFxtQe4iRp6g4USCym1Mj+KSXkAKtgeLmr3lR++RMrb0/FE2Cy8MzojDB7MExyiIfiLXW+jUbbInhvaL/HYU20m45KzsMBM/EaNVuagGrwOpOPyo+wA/cliQfD30ImwJqA+owsJ2KsH/4XCsZ38vuy1q/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GLmUfEl5; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-43b4d734678so1373514f8f.1
        for <linux-hyperv@vger.kernel.org>; Thu, 19 Mar 2026 13:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773951973; x=1774556773; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M4Vjw28unlG5YFFVDdPo2EpwlOdhnBXqMUOBR/+aRX8=;
        b=GLmUfEl5ZOQ5OmLilT5g++YYTXVwY+1G1fWh1b+3/oQrJ/NfII4uWETBFgbR73+uUq
         3kRegHl1f4G552JQxOM7S3eDSOjc753b8oPSgoWwIxt4cCN6xjjOP/A9JMQGG/5a0uGP
         EhCyiHNOPx3xO9zTwFcWLJU2jycLUcAiqMprIgwRqujsmJKPLt9C9idxWsrZz9gkOFDh
         EX2KWHoHeOwccx4xeeaLnNYoOClfyPtVo9pfMj91JzlVBT1o0GAx80pBS2k0MXUp3lKr
         UGY3SH+z/ex8JHtIYuZa5cybxI0Y2fJsNdLV+YBatU5tF8WLgf3ovp4cBg11FDnj3VgJ
         IhfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773951973; x=1774556773;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=M4Vjw28unlG5YFFVDdPo2EpwlOdhnBXqMUOBR/+aRX8=;
        b=TpRqUDh76WpBsxE/H1S1BOBl/t/mu40sQchjoHbqRJ1gva5KYZYFj2mLikfpDYUa+K
         B8/66XnDDGnyMf9mZiJtOi0JgpZl0zY52VQy/k8HNgu4WEjEswIAy7x0ag2rlANmpZUQ
         VWypcfEFPFS386fHgiCnAFAa+FN+XqN0pmjR/IhIzmalvDr1/igOAVIsIvv4rP7PkoQG
         VwRCZ90B0aiWQa59gxkwNwyapg0142ZhaOnaGdIRRRB1MFno5DtwKInEer2GQz0344MK
         WpXc8Vq9i87u5U5amthIMYCZrJA6SLy3mmJPM1yk2NeUUJOyxPNR6vGVf+q/sdcyO3g7
         dhvQ==
X-Gm-Message-State: AOJu0YwJ1VfWvH5VUuu1p2PwBu+Srhbj/nbv/fyI1drimk/LOhFI0Fwe
	3DwoobiR40/0NDPRGy1jkV4kzbfXv8FjBpuV7QuxqkwO5ob/b1JfUCaCpnqeWyswmu8=
X-Gm-Gg: ATEYQzzL7HATS8eNWSa791DbOexoSVEDzaWlPNS/E3Yi6xijeCSN4LRfniqf2bEWrVk
	W7jIWc1rmO59cRtSmJOXf4rWlZk5gJ/RnsnYy5BCPeA2b7ybqBqSQ9bliDKvDQn+shShxRt5tzt
	Oz5MmpOTAK91q802DwoR99SQvODqeXTvjc6gFf1C3JxoQiR4Nv8npo30P/s4xXFRj+gs1TRIeC5
	XKQl1RzK0wB98JjFek05AsJMSPGibHeGSoXBCuV8qYwm7wAFRn/LFon9Y42MSGeFBwMAv6hD2dy
	wf7FkOeNYpnpa4QLmBbV1iYN8AawyVsUxKLN1NWmeHrxlbar2Nw4X6J1u5jAFs1CN5Cq1PHOpv+
	0zQ7c3lqKsiVgo7eGePoHxOra0uIfMXgvjq+2W/w2013ergWCFWIWJKDJW4xY2iCUUdfwnoqjr7
	fZJSg0+Ec3H8qly8Uan/3y5hn0M97tBdXxgTSaAEZf1HJZeaFn
X-Received: by 2002:a05:6000:26c3:b0:43b:45d1:f438 with SMTP id ffacd0b85a97d-43b64234722mr1195366f8f.3.1773951972545;
        Thu, 19 Mar 2026 13:26:12 -0700 (PDT)
Received: from LQ5W56KC4T ([2001:8a0:672f:7800:e0e1:55cd:f0b:b1e5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b644ae16fsm1347544f8f.8.2026.03.19.13.26.11
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 19 Mar 2026 13:26:12 -0700 (PDT)
From: Eric Curtin <ericcurtin17@gmail.com>
X-Google-Original-From: Eric Curtin <eric.curtin@docker.com>
To: linux-hyperv@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	iourit@linux.microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	haiyangz@microsoft.com
Subject: [PATCH 53/55] drivers: hv: dxgkrnl: Do not print error messages when virtual GPU is not present
Date: Thu, 19 Mar 2026 20:25:07 +0000
Message-ID: <20260319202509.63802-54-eric.curtin@docker.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260319202509.63802-1-eric.curtin@docker.com>
References: <20260319202509.63802-1-eric.curtin@docker.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9625-lists,linux-hyperv=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ericcurtin17@gmail.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.983];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,docker.com:mid]
X-Rspamd-Queue-Id: E7DEB2D2409
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Iouri Tarassov <iourit@linux.microsoft.com>

Dxgkrnl prints the error message "Failed to acquire global channel lock"
when a process tries to open the /dev/dxg device and there is no
virtual GPU. This message should not be printed in this scenario.

Signed-off-by: Iouri Tarassov <iourit@linux.microsoft.com>
---
 drivers/hv/dxgkrnl/dxgadapter.c | 2 +-
 drivers/hv/dxgkrnl/dxgmodule.c  | 4 ++++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/hv/dxgkrnl/dxgadapter.c b/drivers/hv/dxgkrnl/dxgadapter.c
index c94283b09fa1..6d3cabb24e6f 100644
--- a/drivers/hv/dxgkrnl/dxgadapter.c
+++ b/drivers/hv/dxgkrnl/dxgadapter.c
@@ -78,12 +78,12 @@ void dxgadapter_start(struct dxgadapter *adapter)
 
 	/* The global channel is initialized when the first adapter starts */
 	if (!dxgglobal->global_channel_initialized) {
+		dxgglobal->global_channel_initialized = true;
 		ret = dxgglobal_init_global_channel();
 		if (ret) {
 			dxgglobal_destroy_global_channel();
 			return;
 		}
-		dxgglobal->global_channel_initialized = true;
 	}
 
 	/* Initialize vGPU vm bus channel */
diff --git a/drivers/hv/dxgkrnl/dxgmodule.c b/drivers/hv/dxgkrnl/dxgmodule.c
index 8f5d6db256a3..c2a4a2a2136f 100644
--- a/drivers/hv/dxgkrnl/dxgmodule.c
+++ b/drivers/hv/dxgkrnl/dxgmodule.c
@@ -46,9 +46,13 @@ int dxgglobal_acquire_channel_lock(void)
 {
 	struct dxgglobal *dxgglobal = dxggbl();
 
+	if (!dxgglobal->global_channel_initialized)
+		return -ENODEV;
+
 	down_read(&dxgglobal->channel_lock);
 	if (dxgglobal->channel.channel == NULL) {
 		DXG_ERR("Failed to acquire global channel lock");
+		up_read(&dxgglobal->channel_lock);
 		return -ENODEV;
 	} else {
 		return 0;

