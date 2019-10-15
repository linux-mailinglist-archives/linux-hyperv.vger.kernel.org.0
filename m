Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97734D7577
	for <lists+linux-hyperv@lfdr.de>; Tue, 15 Oct 2019 13:47:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729319AbfJOLr0 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 15 Oct 2019 07:47:26 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37726 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726208AbfJOLrZ (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 15 Oct 2019 07:47:25 -0400
Received: by mail-wr1-f67.google.com with SMTP id p14so23461594wro.4;
        Tue, 15 Oct 2019 04:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oj3zpGaUH9oZIonIZd3EujKbBWwYig+e3cg7+bt6Oxo=;
        b=Y/b9puu8GdqhjUGkK7ZqbqtERBOdCnLzIviwEhobukyb/ZbhSNnANxy63P7H/6N3SO
         ZtPRWPNUkrv1u0QNidsNrcUSjuH+rfCJtRsCNiBeLi1ZFVI/swJxvpJ9kEueqYLna120
         8WqHCcSm8N2FYdmBLy1GL+uXmlzP84St/dYA3n7r94G2WmFG62WAdTHfihLUG/zmMAai
         cNWv9+Vn6v/PLD7yWaW4LS8gcdhbv+mbxfeZDntNLb13cT4DfrtmFtSnytoWce0n5hep
         Et352GLjIJNPLoHv5cUKLuuHJEPZNUkxEBMs8cekswYJ2bPGjyMKCZnIImB8+8tglz9l
         agnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oj3zpGaUH9oZIonIZd3EujKbBWwYig+e3cg7+bt6Oxo=;
        b=no+WbA9e7HmACCRMES8frG2Qqh3nCymS5egEDMctMuak8lvkPWR7CKgDQDqJ5+90Z8
         OAzmQAIpr+bA7bGxKadkoF2Jup2r4sBr4Un/tjC6N8fO8SitEiUD6pSaI5GME6jx9Eny
         ahkrpBZ6lRcXF7BzkTAH25sspzuI0h41wcDW6GVFWJxxU3jslq2Wo4URrRtNxBTduyYo
         PlSxgCBWNx1qWbyiaI9nJnkt8mZLZa6mL+mlU+UeicLXoq/js4+kmoJjKmH+R0Sa/a3M
         E9QwcQUNfLM07rMfuDOVxYdO3ygJjPg9fXnDSLGlAUP51/1PQT8sgBnnc2IzgV0aUeMF
         9lmw==
X-Gm-Message-State: APjAAAU1C+HhO2E5jqSsEehddbx+NTPlqWcLzhtczbFar5G385mFimmn
        tXceBqrVyKD9pacH1H7hXRpl8sbzYGOb8Q==
X-Google-Smtp-Source: APXvYqxcVZp6O+6VfbOYYyCkbaUGIhNXT5MEP+2n4VLufcQcrjWhQXdMbAv46B3YqtNho4SpsAPwkg==
X-Received: by 2002:a5d:614c:: with SMTP id y12mr32162932wrt.235.1571140041736;
        Tue, 15 Oct 2019 04:47:21 -0700 (PDT)
Received: from andrea.corp.microsoft.com ([2a01:110:8012:1010:8d42:cc61:bfff:65c2])
        by smtp.gmail.com with ESMTPSA id u11sm20237307wmd.32.2019.10.15.04.47.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2019 04:47:21 -0700 (PDT)
From:   Andrea Parri <parri.andrea@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org
Cc:     "K . Y . Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Dexuan Cui <decui@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
        Andrea Parri <parri.andrea@gmail.com>
Subject: [PATCH v3 2/3] Drivers: hv: vmbus: Enable VMBus protocol versions 4.1, 5.1 and 5.2
Date:   Tue, 15 Oct 2019 13:46:45 +0200
Message-Id: <20191015114646.15354-3-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191015114646.15354-1-parri.andrea@gmail.com>
References: <20191015114646.15354-1-parri.andrea@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hyper-V has added VMBus protocol versions 5.1 and 5.2 in recent release
versions.  Allow Linux guests to negotiate these new protocol versions
on versions of Hyper-V that support them.  While on this, also allow
guests to negotiate the VMBus protocol version 4.1 (which was missing).

Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
---
 drivers/hv/connection.c | 13 ++++++++-----
 include/linux/hyperv.h  |  8 +++++++-
 2 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/hv/connection.c b/drivers/hv/connection.c
index 8dc48f53c1ac4..cadfb34b38d80 100644
--- a/drivers/hv/connection.c
+++ b/drivers/hv/connection.c
@@ -44,7 +44,10 @@ EXPORT_SYMBOL_GPL(vmbus_proto_version);
  * Table of VMBus versions listed from newest to oldest.
  */
 static __u32 vmbus_versions[] = {
+	VERSION_WIN10_V5_2,
+	VERSION_WIN10_V5_1,
 	VERSION_WIN10_V5,
+	VERSION_WIN10_V4_1,
 	VERSION_WIN10,
 	VERSION_WIN8_1,
 	VERSION_WIN8,
@@ -68,12 +71,12 @@ int vmbus_negotiate_version(struct vmbus_channel_msginfo *msginfo, u32 version)
 	msg->vmbus_version_requested = version;
 
 	/*
-	 * VMBus protocol 5.0 (VERSION_WIN10_V5) requires that we must use
-	 * VMBUS_MESSAGE_CONNECTION_ID_4 for the Initiate Contact Message,
+	 * VMBus protocol 5.0 (VERSION_WIN10_V5) and higher require that we must
+	 * use VMBUS_MESSAGE_CONNECTION_ID_4 for the Initiate Contact Message,
 	 * and for subsequent messages, we must use the Message Connection ID
 	 * field in the host-returned Version Response Message. And, with
-	 * VERSION_WIN10_V5, we don't use msg->interrupt_page, but we tell
-	 * the host explicitly that we still use VMBUS_MESSAGE_SINT(2) for
+	 * VERSION_WIN10_V5 and higher, we don't use msg->interrupt_page, but we
+	 * tell the host explicitly that we still use VMBUS_MESSAGE_SINT(2) for
 	 * compatibility.
 	 *
 	 * On old hosts, we should always use VMBUS_MESSAGE_CONNECTION_ID (1).
@@ -399,7 +402,7 @@ int vmbus_post_msg(void *buffer, size_t buflen, bool can_sleep)
 		case HV_STATUS_INVALID_CONNECTION_ID:
 			/*
 			 * See vmbus_negotiate_version(): VMBus protocol 5.0
-			 * requires that we must use
+			 * and higher require that we must use
 			 * VMBUS_MESSAGE_CONNECTION_ID_4 for the Initiate
 			 * Contact message, but on old hosts that only
 			 * support VMBus protocol 4.0 or lower, here we get
diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
index c08b62dbd151f..f17f2cd22e39f 100644
--- a/include/linux/hyperv.h
+++ b/include/linux/hyperv.h
@@ -182,15 +182,21 @@ static inline u32 hv_get_avail_to_write_percent(
  * 2 . 4  (Windows 8)
  * 3 . 0  (Windows 8 R2)
  * 4 . 0  (Windows 10)
+ * 4 . 1  (Windows 10 RS3)
  * 5 . 0  (Newer Windows 10)
+ * 5 . 1  (Windows 10 RS4)
+ * 5 . 2  (Windows Server 2019, RS5)
  */
 
 #define VERSION_WS2008  ((0 << 16) | (13))
 #define VERSION_WIN7    ((1 << 16) | (1))
 #define VERSION_WIN8    ((2 << 16) | (4))
 #define VERSION_WIN8_1    ((3 << 16) | (0))
-#define VERSION_WIN10	((4 << 16) | (0))
+#define VERSION_WIN10 ((4 << 16) | (0))
+#define VERSION_WIN10_V4_1 ((4 << 16) | (1))
 #define VERSION_WIN10_V5 ((5 << 16) | (0))
+#define VERSION_WIN10_V5_1 ((5 << 16) | (1))
+#define VERSION_WIN10_V5_2 ((5 << 16) | (2))
 
 /* Make maximum size of pipe payload of 16K */
 #define MAX_PIPE_DATA_PAYLOAD		(sizeof(u8) * 16384)
-- 
2.23.0

