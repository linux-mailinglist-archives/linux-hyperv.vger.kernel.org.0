Return-Path: <linux-hyperv+bounces-11891-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ZEZKIhxZUGqMxAIAu9opvQ
	(envelope-from <linux-hyperv+bounces-11891-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 10 Jul 2026 04:29:48 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 304DA736AB7
	for <lists+linux-hyperv@lfdr.de>; Fri, 10 Jul 2026 04:29:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="q/S7o5G9";
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11891-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11891-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D59ED3033AC0
	for <lists+linux-hyperv@lfdr.de>; Fri, 10 Jul 2026 02:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CC252EA75E;
	Fri, 10 Jul 2026 02:29:06 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B7B02DF701
	for <linux-hyperv@vger.kernel.org>; Fri, 10 Jul 2026 02:29:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783650546; cv=none; b=vA6CHN4ADmk/SjZcPbviP2MaAlVbv4VtCGhfMwNV+66bThr/Ln4f1hCfwF+vGt7rS4crWVYhuCA2w4WMRoDdT/aDIv80dEmeRDkk2TjQCtUtEdpX1xzUvGmwv3WFcvEAy/KyvG8MXeGVfd5jpVztp1iEIQOpPCl9pMuFDaKnOlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783650546; c=relaxed/simple;
	bh=GoEUjL9uCDds3bFd5UbAdn2JckJTHLD8D7KtLu1awmU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BQiyUq/m8xgb+Zuyk5CxzWCQk7Il9ZgczV4BdI55xUa1WBxxg8z3NLq5oJI0ieRlVvMIDmu26fzxKK/knKSsl2vNIjHVbMnPzDz9YKxK22I+SjVH/4i09MhmF0mRYqDEIv9+S4l8ib9eXe4hGP1+sZohUtas1r3jLpFkzrl0ask=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q/S7o5G9; arc=none smtp.client-ip=209.85.222.177
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-92e50c5d14cso18450285a.2
        for <linux-hyperv@vger.kernel.org>; Thu, 09 Jul 2026 19:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783650543; x=1784255343; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=w88OZllgC2a2Srw7/0oeygAu1BDvnNAAlvecR7ZdXpM=;
        b=q/S7o5G9Ldx/fWD1O1SZpD0y/RvsyA4p8oGQNIgof+yglSY6yOtSQHxXqMDRkGk/Ik
         2ym3MRSeQr0aUhymqI+eymVIsdV3lg88b27L9cfG4tLg+HpOANsSUkzZPg6T2FGdb8MX
         43S/ZD4jg9kRwu5ugxp8OhfIU3sQfr6ybjjeWvFVloq6B6hIpqoGxZEDHtavwUabRzrw
         4VvVQdfdEB9Ye/U5gsx1GmysdNYzEbr3ipFb1JRozbRYPqchher6WKsUNhjkNfXk4OfW
         991rdWBpxbc1czKq1onohjKPk+KxeAytsZ+FUOmhsJzwv3LMAqsBp7p9oJwwpIGKUutp
         u4Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783650543; x=1784255343;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=w88OZllgC2a2Srw7/0oeygAu1BDvnNAAlvecR7ZdXpM=;
        b=IYYlI+PC1aBD5r+/+dA5MV8OAPhQzSWWsjmaFmZ/PDidCI8d3CZZz0o8RiDJaoiP2I
         3k0WbOydOiRa2Ddahk+RMW4VNxrvva0khx6xCkb3O4RryOBilyxsTBlWEeuxS3kpL+45
         9aZzx3HZYPah/zew2vaSBu3QiXosIvVkXNDm0HFK3c3HMTWiMqxPvN3Jb1ZTj8CadAwG
         gOjRHzwBs5JiTqmhyK/UmHeoh18Qly0lDV/HDgmmJD6t89V/xabazcdPwE70jplb5ABN
         +oj3ST2m5N8r0Axr/2ebTNhrVc5wYQdARuKXc8/rNnYtC20oGv8ki/rTkknYWk9kma8E
         25WA==
X-Forwarded-Encrypted: i=1; AHgh+RrE/jxEtgW/boTFVAp7W0rcyIU8JPNUVzBDuz71d1Wq8ENotMwrdqLQOnkLt/N4nMs3Rbs/8oBcu2hkfLM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVj3bssvRBZU9WEnj47OHiUUupXcAnBMPC4RV3twEYVPh+CjH2
	+ybD6RyEgM5ZO1S/RadNSEpNaECLl1oAdrTdVoE1ctT+tsNkMtcUbEgF
X-Gm-Gg: AfdE7clUOtkXYGmaq3s8uQXb0l3nwO0oNpKPmsYuhwwNIVgXeUAzsOj6aWq6eBgxVcS
	0ELpzn0MzRCc3QIvs9FxRJairIlEq5yGAza9xjxZImCX/h33Fe/ly2pn4kq0VNHt+k2jxj9hFmE
	8NLaGh+P0hEn8eVr6EtwojbANIRVsqaHZtCFF9yIR6DutZJxi2j1X+gJphXLhisWhfT/wbWk6ij
	yk5G2IXTnIRBhCqO7QL6YG/x8KyiP/P58nFNRCaPe+aC8zBzhhCcZ63lidB2zaLI1A7fNvLR2p0
	dybCeKpqMc/hsYnkCYWgIqKuJ/L3QIqsRdPXpEWP1zmcjn7Raqz9pJtDA7ElEAq+ScASS442gPe
	36vTlAm/yNSopERWGOKA/rRasra9nto/4IIE+TH74k/XjCIRFCGfgGAERzJtcM6nhjohXo8XKAg
	ZXg41HEUUzpmPoKbdoXkhQZauopLgzkqpsHJjji9wf+XlzkRdz+XCb6DoH1tdGCBFgXHLU+AzbW
	esBomc5UEuEISoOuI5nXERqs9c0O9+4
X-Received: by 2002:a05:620a:2953:b0:92e:7a3c:add7 with SMTP id af79cd13be357-92ecf5f3e9amr1050972485a.27.1783650543205;
        Thu, 09 Jul 2026 19:29:03 -0700 (PDT)
Received: from server0.tail6e7dd.ts.net (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92ee5b86276sm90507885a.11.2026.07.09.19.29.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 19:29:02 -0700 (PDT)
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
Subject: [PATCH 2/2] HID: hyperv: add KUnit coverage for device info bounds
Date: Thu,  9 Jul 2026 22:28:54 -0400
Message-ID: <20260710022854.3739558-3-michael.bommarito@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11891-lists,linux-hyperv=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 304DA736AB7

Add KUnit coverage for Hyper-V synthetic HID initial device-info parsing.
The tests cover zero bLength, a valid descriptor plus report descriptor,
and a malformed report descriptor length that exceeds the received
message.

The same-translation-unit test uses a KUnit-only ACK bypass so parser
coverage does not require a live VMBus channel.

Assisted-by: Codex:gpt-5-5-xhigh
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
 drivers/hid/Kconfig      |  10 ++++
 drivers/hid/hid-hyperv.c | 117 ++++++++++++++++++++++++++++++++++++---
 2 files changed, 120 insertions(+), 7 deletions(-)

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index c1d9f7c6a5f23..41ca48d9adc9e 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -1183,6 +1183,16 @@ config HID_HYPERV_MOUSE
 	help
 	Select this option to enable the Hyper-V mouse driver.
 
+config HID_HYPERV_MOUSE_KUNIT_TEST
+	bool "KUnit tests for Hyper-V mouse driver" if !KUNIT_ALL_TESTS
+	depends on KUNIT && HID_HYPERV_MOUSE
+	default KUNIT_ALL_TESTS
+	help
+	  Builds unit tests for the Hyper-V synthetic HID driver.
+	  These tests exercise the initial device-info parser with
+	  malformed host-provided HID descriptors and are only useful
+	  for kernel developers running KUnit.
+
 config HID_SMARTJOYPLUS
 	tristate "SmartJoy PLUS PS2/USB adapter support"
 	help
diff --git a/drivers/hid/hid-hyperv.c b/drivers/hid/hid-hyperv.c
index fd90196430e29..6579bd19da13a 100644
--- a/drivers/hid/hid-hyperv.c
+++ b/drivers/hid/hid-hyperv.c
@@ -13,6 +13,9 @@
 #include <linux/hiddev.h>
 #include <linux/hyperv.h>
 
+#if IS_ENABLED(CONFIG_HID_HYPERV_MOUSE_KUNIT_TEST)
+#include <kunit/test.h>
+#endif
 
 struct hv_input_dev_info {
 	unsigned int size;
@@ -240,13 +243,18 @@ static void mousevsc_on_receive_device_info(struct mousevsc_dev *input_device,
 	ack.ack.header.size = 1;
 	ack.ack.reserved = 0;
 
-	ret = vmbus_sendpacket(input_device->device->channel,
-			&ack,
-			sizeof(struct pipe_prt_msg) +
-			sizeof(struct synthhid_device_info_ack),
-			(unsigned long)&ack,
-			VM_PKT_DATA_INBAND,
-			VMBUS_DATA_PACKET_FLAG_COMPLETION_REQUESTED);
+	if (IS_ENABLED(CONFIG_HID_HYPERV_MOUSE_KUNIT_TEST) &&
+	    !input_device->device) {
+		ret = 0;
+	} else {
+		ret = vmbus_sendpacket(input_device->device->channel,
+				       &ack,
+				       sizeof(struct pipe_prt_msg) +
+				       sizeof(struct synthhid_device_info_ack),
+				       (unsigned long)&ack,
+				       VM_PKT_DATA_INBAND,
+				       VMBUS_DATA_PACKET_FLAG_COMPLETION_REQUESTED);
+	}
 
 	if (!ret)
 		input_device->dev_info_status = 0;
@@ -635,5 +643,100 @@ static void __exit mousevsc_exit(void)
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("Microsoft Hyper-V Synthetic HID Driver");
 
+#if IS_ENABLED(CONFIG_HID_HYPERV_MOUSE_KUNIT_TEST)
+static struct mousevsc_dev *mousevsc_kunit_alloc_dev(struct kunit *test)
+{
+	struct mousevsc_dev *input_dev;
+
+	input_dev = kunit_kzalloc(test, sizeof(*input_dev), GFP_KERNEL);
+	if (!input_dev)
+		return NULL;
+
+	init_completion(&input_dev->wait_event);
+
+	return input_dev;
+}
+
+static void mousevsc_device_info_zero_blength(struct kunit *test)
+{
+	struct synthhid_device_info *info;
+	struct mousevsc_dev *input_dev;
+
+	input_dev = mousevsc_kunit_alloc_dev(test);
+	KUNIT_ASSERT_NOT_NULL(test, input_dev);
+	info = kunit_kzalloc(test, sizeof(*info), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, info);
+
+	info->hid_descriptor.bLength = 0;
+
+	mousevsc_on_receive_device_info(input_dev, info, sizeof(*info));
+
+	KUNIT_EXPECT_EQ(test, input_dev->dev_info_status, -ENOMEM);
+}
+
+static void mousevsc_device_info_valid_descriptor(struct kunit *test)
+{
+	struct synthhid_device_info *info;
+	struct mousevsc_dev *input_dev;
+	u8 *report;
+
+	input_dev = mousevsc_kunit_alloc_dev(test);
+	KUNIT_ASSERT_NOT_NULL(test, input_dev);
+	info = kunit_kzalloc(test, sizeof(*info) + 4, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, info);
+
+	info->hid_descriptor.bLength = sizeof(struct hid_descriptor);
+	info->hid_descriptor.rpt_desc.wDescriptorLength = cpu_to_le16(4);
+	report = ((u8 *)&info->hid_descriptor) + info->hid_descriptor.bLength;
+	memset(report, 0x42, 4);
+
+	mousevsc_on_receive_device_info(input_dev, info, sizeof(*info) + 4);
+
+	KUNIT_EXPECT_EQ(test, input_dev->dev_info_status, 0);
+	KUNIT_EXPECT_EQ(test, input_dev->report_desc_size, 4);
+	KUNIT_EXPECT_MEMEQ(test, input_dev->report_desc, report, 4);
+
+	kfree(input_dev->hid_desc);
+	kfree(input_dev->report_desc);
+}
+
+static void mousevsc_device_info_report_desc_oob(struct kunit *test)
+{
+	struct synthhid_device_info *info;
+	struct mousevsc_dev *input_dev;
+	u8 *report;
+
+	input_dev = mousevsc_kunit_alloc_dev(test);
+	KUNIT_ASSERT_NOT_NULL(test, input_dev);
+	info = kunit_kzalloc(test, sizeof(*info) + 8, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, info);
+
+	info->hid_descriptor.bLength = sizeof(struct hid_descriptor);
+	info->hid_descriptor.rpt_desc.wDescriptorLength = cpu_to_le16(64);
+	report = ((u8 *)&info->hid_descriptor) + info->hid_descriptor.bLength;
+	memset(report, 0x42, 8);
+
+	mousevsc_on_receive_device_info(input_dev, info, sizeof(*info) + 8);
+
+	KUNIT_EXPECT_EQ(test, input_dev->dev_info_status, -EINVAL);
+
+	kfree(input_dev->hid_desc);
+}
+
+static struct kunit_case mousevsc_test_cases[] = {
+	KUNIT_CASE(mousevsc_device_info_zero_blength),
+	KUNIT_CASE(mousevsc_device_info_valid_descriptor),
+	KUNIT_CASE(mousevsc_device_info_report_desc_oob),
+	{}
+};
+
+static struct kunit_suite mousevsc_test_suite = {
+	.name = "hid_hyperv_mouse",
+	.test_cases = mousevsc_test_cases,
+};
+
+kunit_test_suite(mousevsc_test_suite);
+#endif
+
 module_init(mousevsc_init);
 module_exit(mousevsc_exit);
-- 
2.53.0

