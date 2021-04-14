Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0630335F723
	for <lists+linux-hyperv@lfdr.de>; Wed, 14 Apr 2021 17:12:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232527AbhDNPBz (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 14 Apr 2021 11:01:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232447AbhDNPBz (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 14 Apr 2021 11:01:55 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 775D1C061574;
        Wed, 14 Apr 2021 08:01:33 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id v6so30616709ejo.6;
        Wed, 14 Apr 2021 08:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NQzmRz1SgfYPiy5PiCbLc0US4QTVYKM0ZTRqQQ8H8rc=;
        b=rh+NGnuKNbhWeF0aC1YJbanhaPJVUOej1hVSdDCIJOrRE/3tu5JIg0S569FT8N62nu
         4hBIkfuizskZEryw7ulOujHP7XeoVNcAKAEIJbnQ8kxIWwai+RoCTa+DcAoD4QX8qctP
         EECnf9W+Mzvl5lvpanBjZ715yEZE0brlC39vjvCWmM2uP4YlsSg8W3fpl14WNV2tVe0N
         ONvRr1fINu0BFRnCecTS7BqYdM/0Msh6ZSVCXUf/xPuEEdxE7FUnRcTQUFRg+r9l6ycF
         pi74tCWMDGyLxof13HNVGt2/9FNEegeiWCco7e3QnUexxOOjxgwE47WvyuPRKtgJeOjI
         XzCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NQzmRz1SgfYPiy5PiCbLc0US4QTVYKM0ZTRqQQ8H8rc=;
        b=mRIcbBrvjxZR+XPgFbebVZe8lfNIXjERx1/9nXDpalHvQzsRZoD2gfum6Tq6qpwUCw
         7B9p8OzI8LDxc6izAIiGpApOFI7IB0D1Y3dDitLoDPRlCHe3hBUhbP8SIcPELhMABxlL
         HwpgSGKDuD9o1On2UVwf3UYxofolQuapLMbc8nj08MG6Jrb8BeJt1flGu2iBN1jCcQnV
         0WJIw04LiPuO4l3/rniTIYjSsyjk3cMxWMBneNUlxTMERSpm/F0jNw36DiYxtA3NHC5b
         voLgXeB768SPF6B//hC3+dTecSMB8L6kXyZzSZ10LaF8M9gOYGliNGvMoLKISYQnERRX
         m7nQ==
X-Gm-Message-State: AOAM530GoU8Jm2hs4NIt5hTl/hjNS/a/XoGELZOXIh1WjoprJc743+V2
        DzsYpuDxPu3uNzvCJgrEdjPp0mEoZGNo1A==
X-Google-Smtp-Source: ABdhPJxsYqCxBmma/WVKkt9vYsjGy8pxEOfbLSuY0jtoL22PK9VWDXZF6OszCR2IosXcGPCy9aZbpQ==
X-Received: by 2002:a17:906:b7ce:: with SMTP id fy14mr18392793ejb.261.1618412491855;
        Wed, 14 Apr 2021 08:01:31 -0700 (PDT)
Received: from anparri.mshome.net (host-95-232-15-7.retail.telecomitalia.it. [95.232.15.7])
        by smtp.gmail.com with ESMTPSA id c12sm12683393edx.54.2021.04.14.08.01.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 08:01:31 -0700 (PDT)
From:   "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, linux-hyperv@vger.kernel.org,
        mikelley@microsoft.com,
        "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>
Subject: [PATCH v2 1/3] Drivers: hv: vmbus: Introduce and negotiate VMBus protocol version 5.3
Date:   Wed, 14 Apr 2021 17:01:16 +0200
Message-Id: <20210414150118.2843-2-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210414150118.2843-1-parri.andrea@gmail.com>
References: <20210414150118.2843-1-parri.andrea@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hyper-V has added VMBus protocol version 5.3.  Allow Linux guests to
negotiate the new version on version of Hyper-V that support it.

Signed-off-by: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
---
 drivers/hv/connection.c | 3 ++-
 include/linux/hyperv.h  | 2 ++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/hv/connection.c b/drivers/hv/connection.c
index 350e8c5cafa8c..dc19d5ae4373c 100644
--- a/drivers/hv/connection.c
+++ b/drivers/hv/connection.c
@@ -45,6 +45,7 @@ EXPORT_SYMBOL_GPL(vmbus_proto_version);
  * Table of VMBus versions listed from newest to oldest.
  */
 static __u32 vmbus_versions[] = {
+	VERSION_WIN10_V5_3,
 	VERSION_WIN10_V5_2,
 	VERSION_WIN10_V5_1,
 	VERSION_WIN10_V5,
@@ -60,7 +61,7 @@ static __u32 vmbus_versions[] = {
  * Maximal VMBus protocol version guests can negotiate.  Useful to cap the
  * VMBus version for testing and debugging purpose.
  */
-static uint max_version = VERSION_WIN10_V5_2;
+static uint max_version = VERSION_WIN10_V5_3;
 
 module_param(max_version, uint, S_IRUGO);
 MODULE_PARM_DESC(max_version,
diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
index 2c18c8e768efe..d6a6f76040b5f 100644
--- a/include/linux/hyperv.h
+++ b/include/linux/hyperv.h
@@ -234,6 +234,7 @@ static inline u32 hv_get_avail_to_write_percent(
  * 5 . 0  (Newer Windows 10)
  * 5 . 1  (Windows 10 RS4)
  * 5 . 2  (Windows Server 2019, RS5)
+ * 5 . 3  (Windows Server 2021) // FIXME: use proper version number/name
  */
 
 #define VERSION_WS2008  ((0 << 16) | (13))
@@ -245,6 +246,7 @@ static inline u32 hv_get_avail_to_write_percent(
 #define VERSION_WIN10_V5 ((5 << 16) | (0))
 #define VERSION_WIN10_V5_1 ((5 << 16) | (1))
 #define VERSION_WIN10_V5_2 ((5 << 16) | (2))
+#define VERSION_WIN10_V5_3 ((5 << 16) | (3))
 
 /* Make maximum size of pipe payload of 16K */
 #define MAX_PIPE_DATA_PAYLOAD		(sizeof(u8) * 16384)
-- 
2.25.1

