Return-Path: <linux-hyperv+bounces-9618-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +ATVI8tdvGlxxQIAu9opvQ
	(envelope-from <linux-hyperv+bounces-9618-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2026 21:34:19 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F5C22D2373
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2026 21:34:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2B9A8306C45A
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2026 20:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2371E402B81;
	Thu, 19 Mar 2026 20:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kYaFFPkz"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 098264014AE
	for <linux-hyperv@vger.kernel.org>; Thu, 19 Mar 2026 20:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773951969; cv=none; b=r8q0I/QD+4C/BA3ULa10zRGgqHJznf2cnZ/4Kgnewff+gB2oQADQid5++nGijWGiR+IvJoA2Y5WV13LIBpIiPmQmMuHIkyPuK77D5g8gYzJtQ+igwuCxBpLGIMHgJtr5+0CPCOulOrDavFN7jk42TSXbpTm5UH1sCzvPm84NUe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773951969; c=relaxed/simple;
	bh=x0xQqLTzkCRNQUot1j/UYCtbtBAAOsk8jYrEIs7+tYA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UyqxnVx9FYbuStOaxv1eiUNxlAf5GYIYf9oemh72rcfHcdFNfnoJ+dv4Gm8qFCXeq/h6LbJG3yCeAPUktz0du6QokxAGaivvkFFh1bSXzut1n/T5lDhJRwjUFKRpO97BCB7a83NpG7aEcDD5m3yDdX31Dp90sqpIUNbHJhS8hl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kYaFFPkz; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-439b7c2788dso776251f8f.1
        for <linux-hyperv@vger.kernel.org>; Thu, 19 Mar 2026 13:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773951965; x=1774556765; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WDpJy6eUcHO0PuqsrcmnUFgysvSCvcBPbvdavy5mnIc=;
        b=kYaFFPkzLsm11BsjOcgvhswfSGK/XASDqTtHczFx1AF8Vn9krwciAheoAbRzkYgCbg
         J2kLCjgfafPyVzmP8LIdH1PQ2KfTW4IojSeMXkbemgFGBhyoIM70Fi2ogPKfkljO0jzc
         EsSZXNQJlPsTveXyECXdGtoYrYMc+YXwkqljkcI3r3+RCOLNnOU/WtwwPeHP44YML1Y/
         CrILTgiXWMVq5oPVOI7g/e/oRlzljOwX9EsY/jG32GbmLxbOuj1MkZ/2A463iZjdECYi
         V47z3FFQSirr0rlS03PxgcvyaFmQPIZMsioK3t9tPRKJSDmhC+xcTXShO5NnghPo63pU
         NG+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773951965; x=1774556765;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WDpJy6eUcHO0PuqsrcmnUFgysvSCvcBPbvdavy5mnIc=;
        b=tDZjKM2pkAtbI+3o91MXFF+v5sZiW1AY7pEvkNcZDI2yLm4XuMYIAQ0VymosY6Lvzh
         QBDBJEwH58s/HU/wTLln0iWwjcjTny7PI+vJIRVis8jj0MQe7Y7OVyUQFpnrb6UgAawn
         Z5TPJRpEkddNZQBUER/KnsVtLFA9Y62vyHVuUV3L+7kffeg2DAt+eu40pWNLBhiM10m5
         z9oC9u8jCEFyjYClD2elatgg0bKfFcoPCwy4GSI3DiK4iG4+58X+3DsNwQnsQnGti5BV
         MmwBTBMPl/9WhYwzcD8x4Jrtp9EBkIsoMDGLuVULvR/Ep2rEFspGbACxXJmrpKoR9pTc
         hZwQ==
X-Gm-Message-State: AOJu0YyeFhmb7oxinTsmMR6iTFznORxwTY4v55K7hELhhh0mDh3Wh1uj
	c1Poq69c1529kllOmcj5dChaNAaSbtl0edGUfHzvX1Af7Fn4hJq4HLjKVftrICE29o4=
X-Gm-Gg: ATEYQzy61l14cVPtP1Jr7w0xVuWUUYFQiRSQNyRQa4DH1KJVx37CtQMrUuazd0ixo+J
	JjNJgVF4NvZzIshIn5XeMs9mTs0tFID4TGM8cyjMzrUSDkcuY/yyqTA4w/soJ8+s45Upjqg399o
	ebhb8dS7DPLZCjXxh1pZ3FzGGvHXk7t35+btWeJwUSUTAEqIN/ZU7H90p/QlDTSvMH0fmRq9Dd2
	njshGj4kv7fJMou0dTrCcJj7Jlr6is4GeEntHkNa5wnXVk5rnx629wVaOUamO3wDhQuJrAlN9mW
	UNtvc9o6ulkxKRRfH9O4XhLoTzzf+Th1a40H2fZzSxBJGF6MtZy8I0u/4enoXUN3n7EHW+JU2sD
	Qlgm07CfY6Fmnr7Qvdg5gr3m7OMJzJTpIpW5qpILdz+rsuwGVj3kWK/7ow4bOIIGMydkEeqFfYl
	RkKB53IYhgf7qlQiohkJ7elqPXLX6s3WaK95YgnkDa2kE2A1/Y
X-Received: by 2002:a05:6000:25c7:b0:43b:468e:3d78 with SMTP id ffacd0b85a97d-43b64291a02mr1126082f8f.52.1773951965173;
        Thu, 19 Mar 2026 13:26:05 -0700 (PDT)
Received: from LQ5W56KC4T ([2001:8a0:672f:7800:e0e1:55cd:f0b:b1e5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b644ae16fsm1347544f8f.8.2026.03.19.13.26.04
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 19 Mar 2026 13:26:04 -0700 (PDT)
From: Eric Curtin <ericcurtin17@gmail.com>
X-Google-Original-From: Eric Curtin <eric.curtin@docker.com>
To: linux-hyperv@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	iourit@linux.microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	haiyangz@microsoft.com
Subject: [PATCH 46/55] drivers: hv: dxgkrnl: Fixed the implementation of D3DKMTQueryClockCalibration
Date: Thu, 19 Mar 2026 20:25:00 +0000
Message-ID: <20260319202509.63802-47-eric.curtin@docker.com>
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
	TAGGED_FROM(0.00)[bounces-9618-lists,linux-hyperv=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ericcurtin17@gmail.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.982];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,docker.com:mid]
X-Rspamd-Queue-Id: 0F5C22D2373
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Iouri Tarassov <iourit@linux.microsoft.com>

The result of a VM bus call was not copied to the user output structure.

Signed-off-by: Iouri Tarassov <iourit@linux.microsoft.com>
[kms: forward port to 6.6 from 6.1. No code changes made.]
Signed-off-by: Kelsey Steele <kelseysteele@microsoft.com>
---
 drivers/hv/dxgkrnl/dxgvmbus.c | 18 ++++++++++--------
 drivers/hv/dxgkrnl/ioctl.c    |  5 -----
 2 files changed, 10 insertions(+), 13 deletions(-)

diff --git a/drivers/hv/dxgkrnl/dxgvmbus.c b/drivers/hv/dxgkrnl/dxgvmbus.c
index 215e2f6648e2..67f55f4bf41d 100644
--- a/drivers/hv/dxgkrnl/dxgvmbus.c
+++ b/drivers/hv/dxgkrnl/dxgvmbus.c
@@ -1966,14 +1966,16 @@ int dxgvmb_send_query_clock_calibration(struct dxgprocess *process,
 					*__user inargs)
 {
 	struct dxgkvmb_command_queryclockcalibration *command;
-	struct dxgkvmb_command_queryclockcalibration_return result;
+	struct dxgkvmb_command_queryclockcalibration_return *result;
 	int ret;
-	struct dxgvmbusmsg msg = {.hdr = NULL};
+	struct dxgvmbusmsgres msg = {.hdr = NULL};
 
-	ret = init_message(&msg, adapter, process, sizeof(*command));
+	ret = init_message_res(&msg, adapter, sizeof(*command),
+				sizeof(*result));
 	if (ret)
 		goto cleanup;
 	command = (void *)msg.msg;
+	result = msg.res;
 
 	command_vgpu_to_host_init2(&command->hdr,
 				   DXGK_VMBCOMMAND_QUERYCLOCKCALIBRATION,
@@ -1981,20 +1983,20 @@ int dxgvmb_send_query_clock_calibration(struct dxgprocess *process,
 	command->args = *args;
 
 	ret = dxgvmb_send_sync_msg(msg.channel, msg.hdr, msg.size,
-				   &result, sizeof(result));
+				   result, sizeof(*result));
 	if (ret < 0)
 		goto cleanup;
-	ret = copy_to_user(&inargs->clock_data, &result.clock_data,
-			   sizeof(result.clock_data));
+	ret = copy_to_user(&inargs->clock_data, &result->clock_data,
+			   sizeof(result->clock_data));
 	if (ret) {
 		DXG_ERR("failed to copy clock data");
 		ret = -EFAULT;
 		goto cleanup;
 	}
-	ret = ntstatus2int(result.status);
+	ret = ntstatus2int(result->status);
 
 cleanup:
-	free_message(&msg);
+	free_message((struct dxgvmbusmsg *)&msg);
 	if (ret)
 		DXG_TRACE("err: %d", ret);
 	return ret;
diff --git a/drivers/hv/dxgkrnl/ioctl.c b/drivers/hv/dxgkrnl/ioctl.c
index 5ac6dd1f09b9..d91af2e176e9 100644
--- a/drivers/hv/dxgkrnl/ioctl.c
+++ b/drivers/hv/dxgkrnl/ioctl.c
@@ -4303,11 +4303,6 @@ dxgkio_query_clock_calibration(struct dxgprocess *process, void *__user inargs)
 						  &args, inargs);
 	if (ret < 0)
 		goto cleanup;
-	ret = copy_to_user(inargs, &args, sizeof(args));
-	if (ret) {
-		DXG_ERR("failed to copy output args");
-		ret = -EFAULT;
-	}
 
 cleanup:
 

