Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 09A0FCE949
	for <lists+linux-hyperv@lfdr.de>; Mon,  7 Oct 2019 18:32:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727801AbfJGQcE (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 7 Oct 2019 12:32:04 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39752 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727876AbfJGQcE (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 7 Oct 2019 12:32:04 -0400
Received: by mail-wr1-f65.google.com with SMTP id r3so16113008wrj.6;
        Mon, 07 Oct 2019 09:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+psXr2moFENqtCIAGa6EJe/FepyA9u0xvKcvjuFUI3s=;
        b=TrVMgq4kHvMp3JKtkb7H0LtYEQoEgP25lAc/0CgCns/QoycaaVHRckO7itR3PxqLft
         xW/EnBzQ8TGXhaDKDi9YzE1bCfTZ4c1A3xYy7EK5dKOwa+M7way0hbj2OUI7PJ+fluZG
         xNN5/PMs9zP/sYFKutyn/f9jKNqgUaYVf2/5IXctw2+Ie6NFoVtz9vI3FCwEgWZarkaG
         xq7jZlEqxl3CI9jrI6V2S3BG2Qomwo1u1SocSJPrToBxYPYJCvXUR3oTSpStBBalv0R2
         xkzmXMsxJoGB1yD6XfhbdYPzskLHDIVNtoLPPodd4MRptdgkNB5q6GnVc7v53rqaXFDX
         jiuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+psXr2moFENqtCIAGa6EJe/FepyA9u0xvKcvjuFUI3s=;
        b=MkQE7qpVxSLgjkK6ITYQ210jWleVDBRYijyr+4vVp9WuC/iTSt1JGb78MiG3Ts1jna
         tczW8OEXR9XAtlU9isAiwCKJfemh0C4bU+3m9ghuxe5YABF0B00TD+Wq1ary/KVivN5K
         svUgVyAv+ggTed0jDfOXCMXsOs9uuo4CPgnewQcgWJejbcTts+pN6xZ37fzoCk7TFNiD
         n9ks4nLzU1NnvaBKsFe5pfYxQ+54M6HDJW87lr+dq52TgTIIl6AxMN3hX/NY3iD3ZW8V
         7yieSb4ZMYu6YvtOu8Wdq8H/hmIFaIBMXs1AzBJV0CC/5gNexiYMMQC7JvpUBexWMLq8
         2QpA==
X-Gm-Message-State: APjAAAXnpVqxYG55Mlg2JxFOyWIe1DNa6YHu+H/N+uWwCaJAyb9bEUq7
        zp3pt/idffmVqetNYK52L9tAJi17ew+KrA==
X-Google-Smtp-Source: APXvYqzrcXw54BDORsz0/TccRj2Hqw+oZ0dsc5Egb5OsfkzQ6S7y7F559sJJCN54XUquy+F036cmoA==
X-Received: by 2002:adf:cc0a:: with SMTP id x10mr18987206wrh.195.1570465921405;
        Mon, 07 Oct 2019 09:32:01 -0700 (PDT)
Received: from localhost.localdomain (userh394.uk.uudial.com. [194.69.102.21])
        by smtp.gmail.com with ESMTPSA id a9sm148524wmf.14.2019.10.07.09.32.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2019 09:32:00 -0700 (PDT)
From:   Andrea Parri <parri.andrea@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org
Cc:     "K . Y . Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Andrea Parri <parri.andrea@gmail.com>
Subject: [PATCH 2/2] Drivers: hv: vmbus: Enable VMBus protocol versions 5.1 and 5.2
Date:   Mon,  7 Oct 2019 18:31:15 +0200
Message-Id: <20191007163115.26197-3-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191007163115.26197-1-parri.andrea@gmail.com>
References: <20191007163115.26197-1-parri.andrea@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hyper-V has added VMBus protocol versions 5.1 and 5.2 in recent release
versions.  Allow Linux guests to negotiate these new protocol versions
on versions of Hyper-V that support them.

Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
---
 drivers/hv/connection.c | 12 +++++++-----
 include/linux/hyperv.h  |  4 ++++
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/hv/connection.c b/drivers/hv/connection.c
index 90a32c9d79403..d05fef3e09080 100644
--- a/drivers/hv/connection.c
+++ b/drivers/hv/connection.c
@@ -45,6 +45,8 @@ EXPORT_SYMBOL_GPL(vmbus_proto_version);
  * must terminate with VERSION_INVAL.
  */
 __u32 vmbus_versions[] = {
+	VERSION_WIN10_V5_2,
+	VERSION_WIN10_V5_1,
 	VERSION_WIN10_V5,
 	VERSION_WIN10,
 	VERSION_WIN8_1,
@@ -70,12 +72,12 @@ int vmbus_negotiate_version(struct vmbus_channel_msginfo *msginfo, u32 version)
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
@@ -400,7 +402,7 @@ int vmbus_post_msg(void *buffer, size_t buflen, bool can_sleep)
 		case HV_STATUS_INVALID_CONNECTION_ID:
 			/*
 			 * See vmbus_negotiate_version(): VMBus protocol 5.0
-			 * requires that we must use
+			 * and higher require that we must use
 			 * VMBUS_MESSAGE_CONNECTION_ID_4 for the Initiate
 			 * Contact message, but on old hosts that only
 			 * support VMBus protocol 4.0 or lower, here we get
diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
index 7073f1eb3618c..5ecb2ff7cc25d 100644
--- a/include/linux/hyperv.h
+++ b/include/linux/hyperv.h
@@ -183,6 +183,8 @@ static inline u32 hv_get_avail_to_write_percent(
  * 3 . 0  (Windows 8 R2)
  * 4 . 0  (Windows 10)
  * 5 . 0  (Newer Windows 10)
+ * 5 . 1  (Windows 10 RS4)
+ * 5 . 2  (Windows Server 2019, RS5)
  */
 
 #define VERSION_WS2008  ((0 << 16) | (13))
@@ -191,6 +193,8 @@ static inline u32 hv_get_avail_to_write_percent(
 #define VERSION_WIN8_1    ((3 << 16) | (0))
 #define VERSION_WIN10	((4 << 16) | (0))
 #define VERSION_WIN10_V5 ((5 << 16) | (0))
+#define VERSION_WIN10_V5_1 ((5 << 16) | (1))
+#define VERSION_WIN10_V5_2 ((5 << 16) | (2))
 
 #define VERSION_INVAL -1
 
-- 
2.23.0

