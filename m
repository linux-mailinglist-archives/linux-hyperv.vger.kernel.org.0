Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EDFB2B7F85
	for <lists+linux-hyperv@lfdr.de>; Wed, 18 Nov 2020 15:40:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbgKROhp (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 18 Nov 2020 09:37:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725613AbgKROhn (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 18 Nov 2020 09:37:43 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A2EAC0613D4;
        Wed, 18 Nov 2020 06:37:43 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id o15so2440021wru.6;
        Wed, 18 Nov 2020 06:37:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9Rs5tsnn1mMjgVaYOmoOMGnCxyDPBfQTj3LZ6W940/g=;
        b=tZMVXDBeaK4gDcpZggmS6PXfxD/gqnyqSnLzPP/Yxf+cF1qJyr8R2vCuOuoMd41et7
         MMFKKumBeSJpvv2O/TpowXRJIQnzuvTzZKQHOPrMs549LRFr7hIILHc62YmxvkfOaV0f
         FsCIPSbAvJN9LFk1a4E3khU3VhJIOG6bz8ideNM1Gzhq/CKVh4KDgvY1TcPufJgBkvBV
         yAlVHG+HqBTDV9zzurK2H2b/+P0cERW1el/3gCh3vQbt6xKugVTn/l1qYPgqgSFBlPBr
         vj3pw7eV2ajGT9ddI+qKQx5siBmn2fzfjhK74xGzKETaYVZvh7W2jAS6QuMmdd3XlvTy
         rXkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9Rs5tsnn1mMjgVaYOmoOMGnCxyDPBfQTj3LZ6W940/g=;
        b=ma0lc99fXA0TgIX3wXiXmT9nCG5FKw8dZxjhuikBRAYMILeKBym5G82ttuGl53Xym0
         6xykpZOMGy9w+/b5NFKWD9udxKKOoLXgvakYkkIEbPBMcORd3Kh1CZLRno1IlTkkGrx5
         ERAp8yM+TjBkXTDL3yStRWIz53RIqVnxmXJAG0HtsK3tHNW5XJ4TAMB7DvlgODnt0O5m
         88bnthwqBOD73EkQw7yHng0UM5QNgMTQX59b03GS4+b2wf8BGjwcIJMlQXD9H+XSclhM
         Q9/iJuQeR8u06NzyDCJouubTHYmzyjs23GYoJ6fwqM4PAfyZM5QhWfkOPqrlZLcKAcJw
         SW3Q==
X-Gm-Message-State: AOAM531cLSls87r7cFGZ7g9m56J5Fg9qbAVjzNSJqLktH4E9PEUlpS9M
        YVnuxfNVqRjrWQ5fdI68KEBp3C4DdyQKcw==
X-Google-Smtp-Source: ABdhPJwpO5u8KNov5HuK5MpvAeEG/20+Fgchlmmt5ZxduVR7JKgoVFBklY0Z/e5Jv8FUeAG6YOWq5w==
X-Received: by 2002:adf:fed1:: with SMTP id q17mr5105144wrs.393.1605710261656;
        Wed, 18 Nov 2020 06:37:41 -0800 (PST)
Received: from localhost.localdomain (host-82-51-6-75.retail.telecomitalia.it. [82.51.6.75])
        by smtp.gmail.com with ESMTPSA id w10sm34795307wra.34.2020.11.18.06.37.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2020 06:37:41 -0800 (PST)
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
Subject: [PATCH 2/6] Drivers: hv: vmbus: Avoid double fetch of msgtype in vmbus_on_msg_dpc()
Date:   Wed, 18 Nov 2020 15:36:45 +0100
Message-Id: <20201118143649.108465-3-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201118143649.108465-1-parri.andrea@gmail.com>
References: <20201118143649.108465-1-parri.andrea@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

vmbus_on_msg_dpc() double fetches from msgtype.  The double fetch can
lead to an out-of-bound access when accessing the channel_message_table
array.  In turn, the use of the out-of-bound entry could lead to code
execution primitive (entry->message_handler()).  Avoid the double fetch
by saving the value of msgtype into a local variable.

Reported-by: Juan Vazquez <juvazq@microsoft.com>
Signed-off-by: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
---
 drivers/hv/vmbus_drv.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 0a2711aa63a15..82b23baa446d7 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -1057,6 +1057,7 @@ void vmbus_on_msg_dpc(unsigned long data)
 	struct hv_message *msg = (struct hv_message *)page_addr +
 				  VMBUS_MESSAGE_SINT;
 	struct vmbus_channel_message_header *hdr;
+	enum vmbus_channel_message_type msgtype;
 	const struct vmbus_channel_message_table_entry *entry;
 	struct onmessage_work_context *ctx;
 	u32 message_type = msg->header.message_type;
@@ -1072,12 +1073,19 @@ void vmbus_on_msg_dpc(unsigned long data)
 		/* no msg */
 		return;
 
+	/*
+	 * The hv_message object is in memory shared with the host.  The host
+	 * could erroneously or maliciously modify such object.  Make sure to
+	 * validate its fields and avoid double fetches whenever feasible.
+	 */
+
 	hdr = (struct vmbus_channel_message_header *)msg->u.payload;
+	msgtype = hdr->msgtype;
 
 	trace_vmbus_on_msg_dpc(hdr);
 
-	if (hdr->msgtype >= CHANNELMSG_COUNT) {
-		WARN_ONCE(1, "unknown msgtype=%d\n", hdr->msgtype);
+	if (msgtype >= CHANNELMSG_COUNT) {
+		WARN_ONCE(1, "unknown msgtype=%d\n", msgtype);
 		goto msg_handled;
 	}
 
@@ -1087,14 +1095,14 @@ void vmbus_on_msg_dpc(unsigned long data)
 		goto msg_handled;
 	}
 
-	entry = &channel_message_table[hdr->msgtype];
+	entry = &channel_message_table[msgtype];
 
 	if (!entry->message_handler)
 		goto msg_handled;
 
 	if (msg->header.payload_size < entry->min_payload_len) {
 		WARN_ONCE(1, "message too short: msgtype=%d len=%d\n",
-			  hdr->msgtype, msg->header.payload_size);
+			  msgtype, msg->header.payload_size);
 		goto msg_handled;
 	}
 
@@ -1115,7 +1123,7 @@ void vmbus_on_msg_dpc(unsigned long data)
 		 * by offer_in_progress and by channel_mutex.  See also the
 		 * inline comments in vmbus_onoffer_rescind().
 		 */
-		switch (hdr->msgtype) {
+		switch (msgtype) {
 		case CHANNELMSG_RESCIND_CHANNELOFFER:
 			/*
 			 * If we are handling the rescind message;
-- 
2.25.1

