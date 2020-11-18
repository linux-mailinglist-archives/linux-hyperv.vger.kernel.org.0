Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47CF02B7F89
	for <lists+linux-hyperv@lfdr.de>; Wed, 18 Nov 2020 15:40:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbgKROht (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 18 Nov 2020 09:37:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725613AbgKROhs (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 18 Nov 2020 09:37:48 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 812BBC0613D4;
        Wed, 18 Nov 2020 06:37:48 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id 1so2937935wme.3;
        Wed, 18 Nov 2020 06:37:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oUt//bTkwsRrgK4y9pyKInt9C1fdhCh6LTSbXfNlTqo=;
        b=jzPfMtXi3c3lf3x5WTV2VKBiyf3pBIUrqYGHGLm2s6bBxGPaCh1iYCYvnWhkAUjpU8
         Zv8n70xpdmlaa5lm8wdSS3FKmpwU/BfbxDHm1UpZbNkccLLwaLZWFSPn8LmefP/6cQ7P
         4x+Vq1JMNAbzDXE/O0/nmfPo8RSaZW8xSehCFifVrx3I8YLrbb9YzM1RqYtdXEWRg63b
         WzLWsyo7jSYPTSBuEEv9G1YPU5JipHH5T2fUUoFUH2Xhg4v8tfwDmHGNt7AhfP/S4kGw
         NiyB9PR1jnEo0NpYlbKTUAiS4SoP+qDwogpexp8w9jfFxEzREyfUFX5ji2UjO/5tNLWR
         gi8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oUt//bTkwsRrgK4y9pyKInt9C1fdhCh6LTSbXfNlTqo=;
        b=JmHKGMnEN8eXfDshFFt2vwueIWRdLomPE8LPQ9So/6eNfCgulXuJfelfWhx0HlipPV
         E9VLPqMUc2Mc4TzFzXO+yMeUPh23HTdSqixoW6Xa1aCFPpwJwn1k8KTeWYbXuc5p8lp3
         kDQgIIpsuoxl+NSmSdwn8XYTuuLEAzsgKNID+DCTFByDBvjhrFuBBoNe/lRsCWk6ofBE
         sIlBhG1Efu3yruW7zApBKdR8bYYYRpARxwAqCqrikw4R8JquLOcUfh0okPOPhKhter4y
         Ve2YcCUI99TW0foLy4Cvl/ncs/Typk3Fm0404BSY6t2U5Oc1Fug/iHYZMwq5DUgUfzHK
         OQLQ==
X-Gm-Message-State: AOAM531WjhKJKofYIDKC7QJ94jdCBgtMufCh0PyimM0e6gjdh8M645+s
        5bvoZV1pqU4STT/5rYgIG5mhmDMmXFNmZQ==
X-Google-Smtp-Source: ABdhPJz3MdZwKXcwvNF4Wy0Iq9wGRXlU0i7KJaPSSNqW5EttSHUZByXG3u7xjldMS4lInOfd/DClnA==
X-Received: by 2002:a1c:80c3:: with SMTP id b186mr385952wmd.20.1605710263838;
        Wed, 18 Nov 2020 06:37:43 -0800 (PST)
Received: from localhost.localdomain (host-82-51-6-75.retail.telecomitalia.it. [82.51.6.75])
        by smtp.gmail.com with ESMTPSA id w10sm34795307wra.34.2020.11.18.06.37.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2020 06:37:43 -0800 (PST)
From:   "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     "K . Y . Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, linux-hyperv@vger.kernel.org,
        Michael Kelley <mikelley@microsoft.com>,
        Juan Vazquez <juvazq@microsoft.com>,
        Saruhan Karademir <skarade@microsoft.com>,
        "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>
Subject: [PATCH 3/6] Drivers: hv: vmbus: Avoid double fetch of payload_size in vmbus_on_msg_dpc()
Date:   Wed, 18 Nov 2020 15:36:46 +0100
Message-Id: <20201118143649.108465-4-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201118143649.108465-1-parri.andrea@gmail.com>
References: <20201118143649.108465-1-parri.andrea@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

vmbus_on_msg_dpc() double fetches from payload_size.  The double fetch
can lead to a buffer overflow when (mem)copying the hv_message object.
Avoid the double fetch by saving the value of payload_size into a local
variable.

Reported-by: Juan Vazquez <juvazq@microsoft.com>
Signed-off-by: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
---
 drivers/hv/vmbus_drv.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 82b23baa446d7..0e39f1d6182e9 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -1056,6 +1056,7 @@ void vmbus_on_msg_dpc(unsigned long data)
 	void *page_addr = hv_cpu->synic_message_page;
 	struct hv_message *msg = (struct hv_message *)page_addr +
 				  VMBUS_MESSAGE_SINT;
+	__u8 payload_size = msg->header.payload_size;
 	struct vmbus_channel_message_header *hdr;
 	enum vmbus_channel_message_type msgtype;
 	const struct vmbus_channel_message_table_entry *entry;
@@ -1089,9 +1090,8 @@ void vmbus_on_msg_dpc(unsigned long data)
 		goto msg_handled;
 	}
 
-	if (msg->header.payload_size > HV_MESSAGE_PAYLOAD_BYTE_COUNT) {
-		WARN_ONCE(1, "payload size is too large (%d)\n",
-			  msg->header.payload_size);
+	if (payload_size > HV_MESSAGE_PAYLOAD_BYTE_COUNT) {
+		WARN_ONCE(1, "payload size is too large (%d)\n", payload_size);
 		goto msg_handled;
 	}
 
@@ -1100,21 +1100,18 @@ void vmbus_on_msg_dpc(unsigned long data)
 	if (!entry->message_handler)
 		goto msg_handled;
 
-	if (msg->header.payload_size < entry->min_payload_len) {
-		WARN_ONCE(1, "message too short: msgtype=%d len=%d\n",
-			  msgtype, msg->header.payload_size);
+	if (payload_size < entry->min_payload_len) {
+		WARN_ONCE(1, "message too short: msgtype=%d len=%d\n", msgtype, payload_size);
 		goto msg_handled;
 	}
 
 	if (entry->handler_type	== VMHT_BLOCKING) {
-		ctx = kmalloc(sizeof(*ctx) + msg->header.payload_size,
-			      GFP_ATOMIC);
+		ctx = kmalloc(sizeof(*ctx) + payload_size, GFP_ATOMIC);
 		if (ctx == NULL)
 			return;
 
 		INIT_WORK(&ctx->work, vmbus_onmessage_work);
-		memcpy(&ctx->msg, msg, sizeof(msg->header) +
-		       msg->header.payload_size);
+		memcpy(&ctx->msg, msg, sizeof(msg->header) + payload_size);
 
 		/*
 		 * The host can generate a rescind message while we
-- 
2.25.1

