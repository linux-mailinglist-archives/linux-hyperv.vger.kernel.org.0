Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 627972CB8B0
	for <lists+linux-hyperv@lfdr.de>; Wed,  2 Dec 2020 10:25:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387951AbgLBJXZ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 2 Dec 2020 04:23:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387839AbgLBJXY (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 2 Dec 2020 04:23:24 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F74EC0617A7;
        Wed,  2 Dec 2020 01:22:44 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id e7so2702316wrv.6;
        Wed, 02 Dec 2020 01:22:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oUt//bTkwsRrgK4y9pyKInt9C1fdhCh6LTSbXfNlTqo=;
        b=ufG4i0y3zJrlALGylJn7ES1745xVG946OmhVcwAMLhGlH2sFi++rx+cAO0KrqhYLX+
         fiipOTBSi4LPOoGmW8xO2gPFzBBEMBeNHTTpn/zQFeSt8VmV4WPGfxHXpuupTEV8hqUy
         Aac3nrQ9T1HZZU4fusSV7gsuOLm+d7l2pX4z1GvgIkGbQzfdHMdlVSMU404yy+3ALsDQ
         cl5Si24dSS8h5/ufvUe2MxMvMwhHGKHHgVXkTXLYi0fw0YGm2nIGfEcPy5ov2PoZ2P1P
         2EnIPXpLF6XTj+uLaCj8XU50dmEphacaICxHWuvDZ0/NsF3sixHeYauufSYE3X6BctOa
         jbJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oUt//bTkwsRrgK4y9pyKInt9C1fdhCh6LTSbXfNlTqo=;
        b=BHtmohwDMi4mp4tVL86omrfnAq38yTdKDyUPINMsvGFDVY2UZT+zRUarVJAlo9hYQk
         8p2EuugUlij2UEq3XoElwcPhTNk9ZkOUhQt68YC6SoW0LH7J/F/WQtiBJ1tRCPT+jt9i
         ZNizJum1gEfSQ9HoM/792AbNks1J8wNuPdxllV7HCbbIlI9/iKVFbyClD8oJnqgeakig
         w0ZZDdXk/UkBq/0aIMpAWqESm4Ol/70v6E1LyFyndd3Ld7h4J37NFSuo1jnzjnPgueHz
         RDny+j3fKOS09fp+qzlQg1PyvdqhK64hLs0dSdBhHXUvBQY2+iyM//6J4g4BOZ2Io6TB
         SAOA==
X-Gm-Message-State: AOAM530Fm5DDDpmcn0kGPc6wirXd0rUD2VofovLaoYWTO/v2ZmdPAvHM
        z+N5eRidiegL12E38cuNt9XvO21BT729Qg==
X-Google-Smtp-Source: ABdhPJxHt2HeKkB4ghXjj9Q/31vYIkMuwZ5FrOKmLC8kooPrqKs12C2X1f3fjmDMuNZCaq65uT5GYA==
X-Received: by 2002:adf:94c3:: with SMTP id 61mr2174397wrr.143.1606900962378;
        Wed, 02 Dec 2020 01:22:42 -0800 (PST)
Received: from andrea.corp.microsoft.com (host-95-239-64-30.retail.telecomitalia.it. [95.239.64.30])
        by smtp.gmail.com with ESMTPSA id e27sm1535936wrc.9.2020.12.02.01.22.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 01:22:42 -0800 (PST)
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
Subject: [PATCH v2 3/7] Drivers: hv: vmbus: Avoid double fetch of payload_size in vmbus_on_msg_dpc()
Date:   Wed,  2 Dec 2020 10:22:10 +0100
Message-Id: <20201202092214.13520-4-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201202092214.13520-1-parri.andrea@gmail.com>
References: <20201202092214.13520-1-parri.andrea@gmail.com>
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

