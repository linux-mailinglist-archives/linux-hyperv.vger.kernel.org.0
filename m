Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF58FD7575
	for <lists+linux-hyperv@lfdr.de>; Tue, 15 Oct 2019 13:47:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728223AbfJOLrT (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 15 Oct 2019 07:47:19 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36857 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726208AbfJOLrT (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 15 Oct 2019 07:47:19 -0400
Received: by mail-wm1-f66.google.com with SMTP id m18so19954909wmc.1;
        Tue, 15 Oct 2019 04:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dBUvui5EkolStKapN5CJl6A6wSxDxOynlr2athqyN+Y=;
        b=dwcWLgm6xM5Y9bUW1KqdxYjwLgQneImF/FCTkhE3N6yTvho5/Llli7UUK57VPZx70D
         cTOLiwKTh9zMopsEHbJc1tdPpSSTIZibEdE/DcIaKXhHJ405FxKSwmalp9WnsdqlD5QE
         UkXYbAo+ytjCX6WIWjHMtQXoBkBBWLLlUQf0+zS1w0lLbLAimW1drwMF+a9P0llutlu0
         qYCcttOSpycSgUckWUB4OAshntPG2pAQuvhzt3ZPrcEJCF/MothHITHQ3T4EO5I/wIjQ
         0DTF0HQdUtzQAaqwWbepjJ4cOYn1H5mwDHGPOvyHgklVmgcdIBlq6ob4U4ZXx497/ROQ
         Vp3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dBUvui5EkolStKapN5CJl6A6wSxDxOynlr2athqyN+Y=;
        b=tXLwwAoxe5gu/GnBbDZM5Q+rnTA6cGu4GR2VmtNfbDESa/26liEVw9NcE81XtHOf2E
         S07cnBRF37wtPwbeW42o87UL4cqBDXB/4uhDIP4Zo+E6Bwivf4ImjlnL6uQkpx0VIdVl
         2qG0q7Ic4doGetxUeIRveYMHdMZYLXNybAPWBpjYjrftr7aw71HlwurLGY+65c27dbax
         jHAAeMUv71kYLtlEf9wUm8z32UH5hdQ9aE29InUsBtqxERW9gnaYtGYxJDjfUQcA5WvD
         U/IScs/uqeyQOsh0q2vCij9IQUMk4npz5jFOLo4kYdwHR2d7aVrdNZ/MpDnsQ+z3riNc
         Y6yQ==
X-Gm-Message-State: APjAAAVIS0MVvwGrqJ7Dd5SW4Cq2M3AxmCJ83Yn+DySSmdjGtpK6rVqC
        LoWXUNigTMRKpDodb8Nkh4n8s9UhuxegMA==
X-Google-Smtp-Source: APXvYqwocBEnVJaejFL7a7VRGXMlavILOwYvOHqCpSrsprqX61KWUv0QHVGpT1dIFC7aPuCB3rpMCw==
X-Received: by 2002:a1c:a9c5:: with SMTP id s188mr17356846wme.61.1571140035286;
        Tue, 15 Oct 2019 04:47:15 -0700 (PDT)
Received: from andrea.corp.microsoft.com ([2a01:110:8012:1010:8d42:cc61:bfff:65c2])
        by smtp.gmail.com with ESMTPSA id u11sm20237307wmd.32.2019.10.15.04.47.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2019 04:47:14 -0700 (PDT)
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
Subject: [PATCH v3 1/3] Drivers: hv: vmbus: Introduce table of VMBus protocol versions
Date:   Tue, 15 Oct 2019 13:46:44 +0200
Message-Id: <20191015114646.15354-2-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191015114646.15354-1-parri.andrea@gmail.com>
References: <20191015114646.15354-1-parri.andrea@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

The technique used to get the next VMBus version seems increasisly
clumsy as the number of VMBus versions increases.  Performance is
not a concern since this is only done once during system boot; it's
just that we'll end up with more lines of code than is really needed.

As an alternative, introduce a table with the version numbers listed
in order (from the most recent to the oldest).  vmbus_connect() loops
through the versions listed in the table until it gets an accepted
connection or gets to the end of the table (invalid version).

Suggested-by: Michael Kelley <mikelley@microsoft.com>
Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
---
 drivers/hv/connection.c | 50 +++++++++++++++--------------------------
 drivers/hv/vmbus_drv.c  |  3 +--
 include/linux/hyperv.h  |  4 ----
 3 files changed, 19 insertions(+), 38 deletions(-)

diff --git a/drivers/hv/connection.c b/drivers/hv/connection.c
index 6e4c015783ffc..8dc48f53c1ac4 100644
--- a/drivers/hv/connection.c
+++ b/drivers/hv/connection.c
@@ -40,29 +40,17 @@ EXPORT_SYMBOL_GPL(vmbus_connection);
 __u32 vmbus_proto_version;
 EXPORT_SYMBOL_GPL(vmbus_proto_version);
 
-static __u32 vmbus_get_next_version(__u32 current_version)
-{
-	switch (current_version) {
-	case (VERSION_WIN7):
-		return VERSION_WS2008;
-
-	case (VERSION_WIN8):
-		return VERSION_WIN7;
-
-	case (VERSION_WIN8_1):
-		return VERSION_WIN8;
-
-	case (VERSION_WIN10):
-		return VERSION_WIN8_1;
-
-	case (VERSION_WIN10_V5):
-		return VERSION_WIN10;
-
-	case (VERSION_WS2008):
-	default:
-		return VERSION_INVAL;
-	}
-}
+/*
+ * Table of VMBus versions listed from newest to oldest.
+ */
+static __u32 vmbus_versions[] = {
+	VERSION_WIN10_V5,
+	VERSION_WIN10,
+	VERSION_WIN8_1,
+	VERSION_WIN8,
+	VERSION_WIN7,
+	VERSION_WS2008
+};
 
 int vmbus_negotiate_version(struct vmbus_channel_msginfo *msginfo, u32 version)
 {
@@ -169,8 +157,8 @@ int vmbus_negotiate_version(struct vmbus_channel_msginfo *msginfo, u32 version)
  */
 int vmbus_connect(void)
 {
-	int ret = 0;
 	struct vmbus_channel_msginfo *msginfo = NULL;
+	int i, ret = 0;
 	__u32 version;
 
 	/* Initialize the vmbus connection */
@@ -244,21 +232,19 @@ int vmbus_connect(void)
 	 * version.
 	 */
 
-	version = VERSION_CURRENT;
+	for (i = 0; ; i++) {
+		if (i == ARRAY_SIZE(vmbus_versions))
+			goto cleanup;
+
+		version = vmbus_versions[i];
 
-	do {
 		ret = vmbus_negotiate_version(msginfo, version);
 		if (ret == -ETIMEDOUT)
 			goto cleanup;
 
 		if (vmbus_connection.conn_state == CONNECTED)
 			break;
-
-		version = vmbus_get_next_version(version);
-	} while (version != VERSION_INVAL);
-
-	if (version == VERSION_INVAL)
-		goto cleanup;
+	}
 
 	vmbus_proto_version = version;
 	pr_info("Vmbus version:%d.%d\n",
diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 53a60c81e220d..0ac874faf7209 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -2220,8 +2220,7 @@ static int vmbus_bus_resume(struct device *dev)
 	 * We only use the 'vmbus_proto_version', which was in use before
 	 * hibernation, to re-negotiate with the host.
 	 */
-	if (vmbus_proto_version == VERSION_INVAL ||
-	    vmbus_proto_version == 0) {
+	if (!vmbus_proto_version) {
 		pr_err("Invalid proto version = 0x%x\n", vmbus_proto_version);
 		return -EINVAL;
 	}
diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
index b4a017093b697..c08b62dbd151f 100644
--- a/include/linux/hyperv.h
+++ b/include/linux/hyperv.h
@@ -192,10 +192,6 @@ static inline u32 hv_get_avail_to_write_percent(
 #define VERSION_WIN10	((4 << 16) | (0))
 #define VERSION_WIN10_V5 ((5 << 16) | (0))
 
-#define VERSION_INVAL -1
-
-#define VERSION_CURRENT VERSION_WIN10_V5
-
 /* Make maximum size of pipe payload of 16K */
 #define MAX_PIPE_DATA_PAYLOAD		(sizeof(u8) * 16384)
 
-- 
2.23.0

