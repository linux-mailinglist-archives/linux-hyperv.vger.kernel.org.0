Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 660D42CB8AE
	for <lists+linux-hyperv@lfdr.de>; Wed,  2 Dec 2020 10:25:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729261AbgLBJXX (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 2 Dec 2020 04:23:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729251AbgLBJXW (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 2 Dec 2020 04:23:22 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06896C0617A6;
        Wed,  2 Dec 2020 01:22:42 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id 64so2667830wra.11;
        Wed, 02 Dec 2020 01:22:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9Rs5tsnn1mMjgVaYOmoOMGnCxyDPBfQTj3LZ6W940/g=;
        b=YKKhgYLKvVDPfv6dXD6Xhh0a7vlAedO+KhL8084IwX02W3z3UAw8DG1TiARzgictf0
         ln+jiECmWK4jYg3DQxmMvteovry7YUrGWP4bI02XqifiWvPl7Hv8ul2JirwFnQa7JGs/
         HVbCbJzL8HvzjrAufM/S8dp78CnumhKa4kFl6IXz7P1ZWBoKwAzdCCcRRjpYykSNIocN
         iyObnBcHdnKRlOvrksBSUpQuFwU+l6qNIjVayULYnc81yQY8cvV/42AEGlFqkXY2ndei
         zdRUV+fYj+F9Lg3AMpZvPcidUp2/H75Mhb15Dbb5RyIIymdnoF3A7k/FAawCqdIYAlc4
         zT8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9Rs5tsnn1mMjgVaYOmoOMGnCxyDPBfQTj3LZ6W940/g=;
        b=GZb4/HsbwQQ5YHB/vGQI9krrQg0OWy5u9g+ZWUanGb0+Am+ZJfRVEN2XeslpQt5h3T
         duKZ5SYAFPyjVVfU8o6i1HatBa80lexx+kSCH6brD1ifN0WbBycW50LGA77//FEa1NiC
         mkpTgmqJ5cxBosIQaRXVmkFvHowCIPsCpt4Hm8XmtT/3LaJps1rO2XtAPziyx3YW/Lq7
         FTWa6kJZ7lybcFmLaK6Umez84Bw+CryD2E2c+DWx10OnrGmpWP5bWhb62U5uBuaUzSi0
         XjzMMZ6T3NKkI3Y2MIlTCOd2dXbujSQ1sGbe818p+tXX1zFmsdeptNNaN7WOZQUa0QQm
         blgA==
X-Gm-Message-State: AOAM533iF2ml40qLIbkcqOVlD09bcqJkoKYIy5SzbHGPP/HLJhrUQWbs
        ddg7KlvYQ0cL9HZq/dk6VruZjuHvNU75+Q==
X-Google-Smtp-Source: ABdhPJyBlauei1ysqixsV7g7Uy98f8jzEa2aoqEHcXDSDC+R/OStCONfyHZeWaVszT3gAPhggNA01w==
X-Received: by 2002:adf:93e6:: with SMTP id 93mr2177942wrp.197.1606900960113;
        Wed, 02 Dec 2020 01:22:40 -0800 (PST)
Received: from andrea.corp.microsoft.com (host-95-239-64-30.retail.telecomitalia.it. [95.239.64.30])
        by smtp.gmail.com with ESMTPSA id e27sm1535936wrc.9.2020.12.02.01.22.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 01:22:39 -0800 (PST)
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
Subject: [PATCH v2 2/7] Drivers: hv: vmbus: Avoid double fetch of msgtype in vmbus_on_msg_dpc()
Date:   Wed,  2 Dec 2020 10:22:09 +0100
Message-Id: <20201202092214.13520-3-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201202092214.13520-1-parri.andrea@gmail.com>
References: <20201202092214.13520-1-parri.andrea@gmail.com>
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

