Return-Path: <linux-hyperv+bounces-11890-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id fCVzMA9ZUGqJxAIAu9opvQ
	(envelope-from <linux-hyperv+bounces-11890-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 10 Jul 2026 04:29:35 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 3564B736AAA
	for <lists+linux-hyperv@lfdr.de>; Fri, 10 Jul 2026 04:29:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=dwzJ0DGW;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11890-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11890-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7D75D300F0E9
	for <lists+linux-hyperv@lfdr.de>; Fri, 10 Jul 2026 02:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50BE92DF3DA;
	Fri, 10 Jul 2026 02:29:04 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E04E2D3A7C
	for <linux-hyperv@vger.kernel.org>; Fri, 10 Jul 2026 02:29:02 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783650544; cv=none; b=r0eEtCthxddJxzOHd0CtuzVWBvmJ4h9NcEJ96Km1GHWhgBMV67fwcKlJys6YoRsFBvYcProbbkW5rTTmXl31UrCraJXPm978oSVnzE0Ofc4lOS9FzU7puZOWPS/0wwE/YfU5ngGrBkTWFBVTjXEgaLuBEQQWXIFU5RzDmpLkke8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783650544; c=relaxed/simple;
	bh=Xw9MV5+tUH91OggMUmq95ucMnBMqMCwFdkfsgGxUsO0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JI3F4JWW6w28h+FgSUHK0+HT/+w+yHt/c2+1EaiI4hKq5JNbgxa1gRcYhXR4f1X1heuLj2rZou/kpNy+BiY1SG0T5vGlsLDBwvuICVRoSCN4l/tUcaonb/QdoT5B+PnY1/WxkW0ppVQh71cuH0EMmEuVhLAuIhvQaX7n/nJFSiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dwzJ0DGW; arc=none smtp.client-ip=209.85.222.179
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-92b21f65b60so95657785a.1
        for <linux-hyperv@vger.kernel.org>; Thu, 09 Jul 2026 19:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783650541; x=1784255341; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qddLIoiRhTm7oXx/mi01gsuC6rzOXTw4K1iEgY1KrG0=;
        b=dwzJ0DGW7BUBPpqc5p98Oq48MJutxTn3/qCpjSJKkMsrM1TeqTp9lGJC+C1F/LJhbi
         YJbQU45ADJCa4/PsiaR9iIF0Ot2qf7WZtV5f+bRq/sxGTYvUya8sZA3AjejiAg8StKX6
         1IzlGG+fJzr3+QyVcgRgwbYP1d23+7sw5tDgw4Prtb3cCK8RYkhJrmhXn9XTDq6YXACY
         fzI7LHe8lL9m0zhM+tuhW7wBSFagbcRDoc1oygJeDHRBADFNj90v+tEr1jX1FH1+QZjM
         51+chwgWvMKx0FGCeDAwZCKQ0KHgiyMfpSHLac3QZtn7nR/JJswCN7Iq8yXymyRyf+f2
         JXqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783650541; x=1784255341;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qddLIoiRhTm7oXx/mi01gsuC6rzOXTw4K1iEgY1KrG0=;
        b=n4lTpDXyZ3kMTQJ4ZAF5KtTWubmOn+QyLyLupx5vxraU/BIcic2Stwj8uZHQtDEBOv
         +CKjBb+7rzCES5dcZntzuNwBckkKssArWOGHWPxsM5YQ0cCdqQpwrMwi1g+M4dTKgZva
         FfZ1kO+mvI/0QPhlJR/31yC5vXv+nuohypGzwcE/hymlg4trUnm7aKY5Duf4FlwsOsS2
         sn+tkjm+GH1ORcSt1SKUFD858KLpTiB43/VFCXfmqqWNntrnsft43l8pS6iCQTA1jJI6
         cTdmCGgl6ICSA2HqbmRkljARtuodukLh2ux+8A2FgRbtfFmnrfDvVMKCvsi1sgCZbowI
         08xQ==
X-Forwarded-Encrypted: i=1; AHgh+RpJzQjmwGQ+dki0WzC1vlOyLViTAfxRZwRDAVHEkPIeddPUyILKlvx+V7woFDNJ30nGmLKX3cxnmGltPJs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYna5V7OFuSM5HfyTFKTP5fBuN0Swx3YKvJd6KWrlQOhc5xKlR
	iP1buoCOh3mjnKpo2Z6jJrCWdIKw3ZgBijXXrqKbyUj7vbFgYzMXK2ST
X-Gm-Gg: AfdE7ck6XB7ZQ+pfOyBQ+bXpLFYAgzYpGJIpIpBC4LL7ABo8U0Bijruw/jvqhY3ChAP
	gisDe4it88TQGLaO/gop5mc9TnlFk1MSOUAl0+ueVRMhmC+4xq+zHVAsl0xtLy8tXqNNeYqYs+i
	TOPtq1doGO0OHxRkga+iw5oSwggsOur6L74GtoCstaphIkatI2ljqLe/etEOFS2xAExfMYdyhEB
	kf53kxW1Gxf5yibl2GNSgO3A+3kIbm37QOJ3D3obUhLt7wYILgKrTvxtfSvx42x6V0FXbgejKMS
	jvmrPyQ8STyq/0Q3bo3QM79Pfb8RkTLwlq/zTbYiOCUwWUI4mT/Be1PJwoU5jU2dGSnBrVk+C03
	va5H1bEHrFsdtgVEQ+WlEnsWGEwuoe+CAlXnX1BMe+WDr9s5chqr/82iWx0B/+fL1uL+Z//y3mb
	Pa8lQ7qNPXVRitKS720iws4bRx0NB/ISrASnqlH2E+mWGtdH0BvfSRSDJ83PDb5nBSPhXv1cilZ
	RFmoRIU7PjOkvV1y3L3skrpdZu5mfha
X-Received: by 2002:a05:620a:1993:b0:92e:7d7f:9102 with SMTP id af79cd13be357-92ee54ab5d8mr206888585a.2.1783650541428;
        Thu, 09 Jul 2026 19:29:01 -0700 (PDT)
Received: from server0.tail6e7dd.ts.net (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92ee5b86276sm90507885a.11.2026.07.09.19.28.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 19:29:00 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	kys@microsoft.com,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>
Cc: Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	linux-input@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 1/2] HID: hyperv: validate initial device info bounds
Date: Thu,  9 Jul 2026 22:28:53 -0400
Message-ID: <20260710022854.3739558-2-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260710022854.3739558-1-michael.bommarito@gmail.com>
References: <20260710022854.3739558-1-michael.bommarito@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11890-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jikos@kernel.org,m:bentiss@kernel.org,m:kys@microsoft.com,m:haiyangz@microsoft.com,m:wei.liu@kernel.org,m:decui@microsoft.com,m:longli@microsoft.com,m:linux-input@vger.kernel.org,m:linux-hyperv@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[michaelbommarito@gmail.com,linux-hyperv@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michaelbommarito@gmail.com,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3564B736AAA

The Hyper-V synthetic HID host supplies SYNTH_HID_INITIAL_DEVICE_INFO
messages that contain a HID descriptor followed by the report descriptor
bytes. mousevsc_on_receive_device_info() trusts bLength and
wDescriptorLength without checking that the received packet contains both
byte ranges.

A malformed host or backend message can therefore make the guest read
past the received VMBus packet while copying the report descriptor. Pass
the received initial-device-info size into the parser and reject
descriptor lengths that exceed the packet.

Impact: A malicious Hyper-V host or backend can crash a guest by sending
a short initial device-info message with an oversized HID report
descriptor length.

Fixes: b95f5bcb811e ("HID: Move the hid-hyperv driver out of staging")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5-5-xhigh
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
 drivers/hid/hid-hyperv.c | 27 ++++++++++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-hyperv.c b/drivers/hid/hid-hyperv.c
index 7d2b0063df151..fd90196430e29 100644
--- a/drivers/hid/hid-hyperv.c
+++ b/drivers/hid/hid-hyperv.c
@@ -171,18 +171,32 @@ static void mousevsc_free_device(struct mousevsc_dev *device)
 }
 
 static void mousevsc_on_receive_device_info(struct mousevsc_dev *input_device,
-				struct synthhid_device_info *device_info)
+					    struct synthhid_device_info *device_info,
+					    u32 device_info_size)
 {
 	int ret = 0;
 	struct hid_descriptor *desc;
 	struct mousevsc_prt_msg ack;
+	size_t desc_offset;
+	size_t desc_size;
 
 	input_device->dev_info_status = -ENOMEM;
 
+	if (device_info_size < sizeof(*device_info)) {
+		input_device->dev_info_status = -EINVAL;
+		goto cleanup;
+	}
+
 	input_device->hid_dev_info = device_info->hid_dev_info;
 	desc = &device_info->hid_descriptor;
+	desc_offset = offsetof(struct synthhid_device_info, hid_descriptor);
+	desc_size = device_info_size - desc_offset;
 	if (desc->bLength == 0)
 		goto cleanup;
+	if (desc->bLength < sizeof(*desc) || desc->bLength > desc_size) {
+		input_device->dev_info_status = -EINVAL;
+		goto cleanup;
+	}
 
 	/* The pointer is not NULL when we resume from hibernation */
 	kfree(input_device->hid_desc);
@@ -197,6 +211,10 @@ static void mousevsc_on_receive_device_info(struct mousevsc_dev *input_device,
 		input_device->dev_info_status = -EINVAL;
 		goto cleanup;
 	}
+	if (input_device->report_desc_size > desc_size - desc->bLength) {
+		input_device->dev_info_status = -EINVAL;
+		goto cleanup;
+	}
 
 	/* The pointer is not NULL when we resume from hibernation */
 	kfree(input_device->report_desc);
@@ -273,14 +291,17 @@ static void mousevsc_on_receive(struct hv_device *device,
 		break;
 
 	case SYNTH_HID_INITIAL_DEVICE_INFO:
-		WARN_ON(pipe_msg->size < sizeof(struct hv_input_dev_info));
+		if (WARN_ON_ONCE(pipe_msg->size <
+				 sizeof(struct synthhid_device_info)))
+			break;
 
 		/*
 		 * Parse out the device info into device attr,
 		 * hid desc and report desc
 		 */
 		mousevsc_on_receive_device_info(input_dev,
-			(struct synthhid_device_info *)pipe_msg->data);
+						(struct synthhid_device_info *)pipe_msg->data,
+						pipe_msg->size);
 		break;
 	case SYNTH_HID_INPUT_REPORT:
 		input_report =
-- 
2.53.0

