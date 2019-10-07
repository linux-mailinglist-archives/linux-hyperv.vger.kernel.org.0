Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2BB23CE946
	for <lists+linux-hyperv@lfdr.de>; Mon,  7 Oct 2019 18:32:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728528AbfJGQcC (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 7 Oct 2019 12:32:02 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41918 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727801AbfJGQcB (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 7 Oct 2019 12:32:01 -0400
Received: by mail-wr1-f65.google.com with SMTP id q9so16106759wrm.8;
        Mon, 07 Oct 2019 09:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=r5sgxvl6WRaxv9ieNmw/70z/3jD9DTABC5OOXf90ftA=;
        b=Raq6uKl3MJ7Cw7B+KO/NR0HC5loXMtgUHwXRPzbK7dBOVRU1Y+ppZMImJwz//Ltt6o
         bP3W/3S5EAuMkchJMY8i5j5uDkfQ7gNEj/ogPlaCzzvxFu1N2cDckT2AO9KppcPnFDDu
         gGX/T9wHDpNTf09IVMUL0soTcH5YDdFZyvqAMWx9Afltt+jBpV5W5hfZ1ZaNsMe2tihV
         5XXAGtpHrAyNgK+Iw6pPTFKCdtEikaVgk9OHSJMKdWyuyoa+zgDEBbxdfJoawtKg92kJ
         8Y7OXu4PxJD78CAxFheiNGU/xcCzpvtB9wquX2ahWUWdyGeo734aIZBVwihiNXEeN5eM
         2hvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=r5sgxvl6WRaxv9ieNmw/70z/3jD9DTABC5OOXf90ftA=;
        b=Wdijzm4cdzP/wuutppOBlU1/MhIJNKClE0jK/4w4zotzHESnqAI3W2KLBA/DQQACM1
         OJfkgTL84r2/4pM6X5zknc8goJWNYA3LtQUu960EsVgGsswZ5v5KYH7r475xLTZfXg7y
         H3Pi9EFTWL6LD3E/9qmQ22/w9nr76ua1YVaiusv4hSSY5gbi6PNI5IHxyr9nUQYIAlg0
         ixT8uTUNUpnciSiWuYM4yOt3kFsr3/hbB1fhy5fhbfJS3zC4G1bcwl0UeMhZHV2dDWSn
         ypGVyaykwn/+BefGYhTTnWgUszY8G9wVN5lh8rZED70QQJXUF4uGdNEREbcUeswQtNT1
         z37g==
X-Gm-Message-State: APjAAAUC3MDP08oILWX3meTiznv8dA0i/eA5afB0iXBaq1hGuzr/jbOi
        Pu8dL9c4fiEBz7m6oKgoJmw8bmDwKkx1Yw==
X-Google-Smtp-Source: APXvYqxOqCQKUl4DWmDllgEwqvCvElcB3G2AlfDMcqca9ZfL4BfcKrYMDbK7o4JmNZ1ejk675pOL5g==
X-Received: by 2002:adf:ed85:: with SMTP id c5mr12244204wro.14.1570465919066;
        Mon, 07 Oct 2019 09:31:59 -0700 (PDT)
Received: from localhost.localdomain (userh394.uk.uudial.com. [194.69.102.21])
        by smtp.gmail.com with ESMTPSA id a9sm148524wmf.14.2019.10.07.09.31.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2019 09:31:58 -0700 (PDT)
From:   Andrea Parri <parri.andrea@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org
Cc:     "K . Y . Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Andrea Parri <parri.andrea@gmail.com>
Subject: [PATCH 1/2] Drivers: hv: vmbus: Introduce table of VMBus protocol versions
Date:   Mon,  7 Oct 2019 18:31:14 +0200
Message-Id: <20191007163115.26197-2-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191007163115.26197-1-parri.andrea@gmail.com>
References: <20191007163115.26197-1-parri.andrea@gmail.com>
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
 drivers/hv/connection.c | 51 +++++++++++++++--------------------------
 include/linux/hyperv.h  |  2 --
 2 files changed, 19 insertions(+), 34 deletions(-)

diff --git a/drivers/hv/connection.c b/drivers/hv/connection.c
index 6e4c015783ffc..90a32c9d79403 100644
--- a/drivers/hv/connection.c
+++ b/drivers/hv/connection.c
@@ -40,29 +40,19 @@ EXPORT_SYMBOL_GPL(vmbus_connection);
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
+ * Table of VMBus versions listed from newest to oldest; the table
+ * must terminate with VERSION_INVAL.
+ */
+__u32 vmbus_versions[] = {
+	VERSION_WIN10_V5,
+	VERSION_WIN10,
+	VERSION_WIN8_1,
+	VERSION_WIN8,
+	VERSION_WIN7,
+	VERSION_WS2008,
+	VERSION_INVAL
+};
 
 int vmbus_negotiate_version(struct vmbus_channel_msginfo *msginfo, u32 version)
 {
@@ -169,8 +159,8 @@ int vmbus_negotiate_version(struct vmbus_channel_msginfo *msginfo, u32 version)
  */
 int vmbus_connect(void)
 {
-	int ret = 0;
 	struct vmbus_channel_msginfo *msginfo = NULL;
+	int i, ret = 0;
 	__u32 version;
 
 	/* Initialize the vmbus connection */
@@ -244,21 +234,18 @@ int vmbus_connect(void)
 	 * version.
 	 */
 
-	version = VERSION_CURRENT;
+	for (i = 0; ; i++) {
+		version = vmbus_versions[i];
+		if (version == VERSION_INVAL)
+			goto cleanup;
 
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
diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
index b4a017093b697..7073f1eb3618c 100644
--- a/include/linux/hyperv.h
+++ b/include/linux/hyperv.h
@@ -194,8 +194,6 @@ static inline u32 hv_get_avail_to_write_percent(
 
 #define VERSION_INVAL -1
 
-#define VERSION_CURRENT VERSION_WIN10_V5
-
 /* Make maximum size of pipe payload of 16K */
 #define MAX_PIPE_DATA_PAYLOAD		(sizeof(u8) * 16384)
 
-- 
2.23.0

