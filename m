Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A60CB2D3BFE
	for <lists+linux-hyperv@lfdr.de>; Wed,  9 Dec 2020 08:11:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725816AbgLIHKU (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 9 Dec 2020 02:10:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726839AbgLIHKJ (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 9 Dec 2020 02:10:09 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA539C061794;
        Tue,  8 Dec 2020 23:09:23 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id x22so467377wmc.5;
        Tue, 08 Dec 2020 23:09:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/BM6lIEZcpWVYdZyLdlDnitxFukrlBDsW1DAuiV/UXw=;
        b=hqBwN7HaEGhVelgkMPe+pVaNUBaa/wAfmqsOTr8Xr/M3/zTb/f0hqyOhlZC7o4rJMl
         kEHx4oMFTp3HMxzxX9IHOMBXe8m+96bDj72NM/FzMX4h8efLDGt+z58uzspLxC6EMcwD
         cQyLF0uwgkIgBT4Duhc0j23VvjDfU5vLbfs5+fMy9aSYQihkV6T+lYJvwb/4qar4zGGg
         j9FW9wlBJicBxypF1wyzTZzpjdIbVf3NXwzaHvCPSx/D26SsUrajn54ra/105XcHdz29
         /YbZbwjwppMFoezuBEimY5ClW9cR85FfzJFWUFr9iEQL+QBvq/8JIJR33daHJYzKvW1H
         i51A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/BM6lIEZcpWVYdZyLdlDnitxFukrlBDsW1DAuiV/UXw=;
        b=LpU5PnQ8c6tfkEI5IwHquTYIWBCavoWQ2vyDJHtq45fieJGkS49bZk/Kl/7zXucfek
         QSF8dG7OkM0cjYdkqD8DuZwYHtzpRI2uIY3UFf+rsRqoNr/vtCGEBbeh/ZzaeVNeHTFI
         +thcyBqnrz9TVnmNHGzYfyoxm7klbKxbR44gt+TbYzYIXhVzlyT/wsBbK/X4A9FjjuE0
         E/XoFd5G7MRSbgAS7dgW5f0/FE2yiPZPZKNukMZfrYO6WegcWW9SGEEfMxnerREXHJ2s
         c/L8X9w5QWU70NVJ4s3C7fOM1+WOepbhX9m+Wwd9IgVaJLh+3AnyQIeYj2mYIzW0rAXk
         kjkw==
X-Gm-Message-State: AOAM53338wROiWw2M8XzHSv1lHsqcwR8GHnjxogawV3JeK91ZxRPnpfN
        syqocqb0A1gk6T66zbJLr5szbrTe7d0pNg==
X-Google-Smtp-Source: ABdhPJwEuCn+ZOY0CFBQ5Y4RKZiEdfToQ+mMaFhATKqyczDEIyXyXvvM8pbum+6hxpPBsn7xAQqtyw==
X-Received: by 2002:a1c:40d6:: with SMTP id n205mr1178061wma.0.1607497762203;
        Tue, 08 Dec 2020 23:09:22 -0800 (PST)
Received: from andrea.corp.microsoft.com (host-95-239-64-30.retail.telecomitalia.it. [95.239.64.30])
        by smtp.gmail.com with ESMTPSA id p3sm1449122wrs.50.2020.12.08.23.09.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 23:09:21 -0800 (PST)
From:   "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org
Cc:     "K . Y . Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Juan Vazquez <juvazq@microsoft.com>,
        Saruhan Karademir <skarade@microsoft.com>,
        "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>
Subject: [PATCH v3 3/6] Drivers: hv: vmbus: Copy the hv_message in vmbus_on_msg_dpc()
Date:   Wed,  9 Dec 2020 08:08:24 +0100
Message-Id: <20201209070827.29335-4-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201209070827.29335-1-parri.andrea@gmail.com>
References: <20201209070827.29335-1-parri.andrea@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Since the message is in memory shared with the host, an erroneous or a
malicious Hyper-V could 'corrupt' the message while vmbus_on_msg_dpc()
or individual message handlers are executing.  To prevent it, copy the
message into private memory.

Reported-by: Juan Vazquez <juvazq@microsoft.com>
Signed-off-by: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
---
Changes since v2:
  - Revisit commit message and inline comment

 drivers/hv/vmbus_drv.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 44bcf9ccdaf5f..b1c5a89d75f9d 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -1054,14 +1054,14 @@ void vmbus_on_msg_dpc(unsigned long data)
 {
 	struct hv_per_cpu_context *hv_cpu = (void *)data;
 	void *page_addr = hv_cpu->synic_message_page;
-	struct hv_message *msg = (struct hv_message *)page_addr +
+	struct hv_message msg_copy, *msg = (struct hv_message *)page_addr +
 				  VMBUS_MESSAGE_SINT;
 	struct vmbus_channel_message_header *hdr;
 	enum vmbus_channel_message_type msgtype;
 	const struct vmbus_channel_message_table_entry *entry;
 	struct onmessage_work_context *ctx;
-	u32 message_type = msg->header.message_type;
 	__u8 payload_size;
+	u32 message_type;
 
 	/*
 	 * 'enum vmbus_channel_message_type' is supposed to always be 'u32' as
@@ -1070,11 +1070,20 @@ void vmbus_on_msg_dpc(unsigned long data)
 	 */
 	BUILD_BUG_ON(sizeof(enum vmbus_channel_message_type) != sizeof(u32));
 
+	/*
+	 * Since the message is in memory shared with the host, an erroneous or
+	 * malicious Hyper-V could modify the message while vmbus_on_msg_dpc()
+	 * or individual message handlers are executing; to prevent this, copy
+	 * the message into private memory.
+	 */
+	memcpy(&msg_copy, msg, sizeof(struct hv_message));
+
+	message_type = msg_copy.header.message_type;
 	if (message_type == HVMSG_NONE)
 		/* no msg */
 		return;
 
-	hdr = (struct vmbus_channel_message_header *)msg->u.payload;
+	hdr = (struct vmbus_channel_message_header *)msg_copy.u.payload;
 	msgtype = hdr->msgtype;
 
 	trace_vmbus_on_msg_dpc(hdr);
@@ -1084,7 +1093,7 @@ void vmbus_on_msg_dpc(unsigned long data)
 		goto msg_handled;
 	}
 
-	payload_size = msg->header.payload_size;
+	payload_size = msg_copy.header.payload_size;
 	if (payload_size > HV_MESSAGE_PAYLOAD_BYTE_COUNT) {
 		WARN_ONCE(1, "payload size is too large (%d)\n", payload_size);
 		goto msg_handled;
@@ -1106,7 +1115,7 @@ void vmbus_on_msg_dpc(unsigned long data)
 			return;
 
 		INIT_WORK(&ctx->work, vmbus_onmessage_work);
-		memcpy(&ctx->msg, msg, sizeof(msg->header) + payload_size);
+		memcpy(&ctx->msg, &msg_copy, sizeof(msg->header) + payload_size);
 
 		/*
 		 * The host can generate a rescind message while we
-- 
2.25.1

