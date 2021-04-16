Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2A11362261
	for <lists+linux-hyperv@lfdr.de>; Fri, 16 Apr 2021 16:36:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236578AbhDPOfm (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 16 Apr 2021 10:35:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236583AbhDPOfm (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 16 Apr 2021 10:35:42 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A054C061756;
        Fri, 16 Apr 2021 07:35:16 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id s15so32563627edd.4;
        Fri, 16 Apr 2021 07:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=w1SG5zqgVGIcSqZQcep6A7Ljqt8+dcRBgDy6JrQmhk4=;
        b=SBCCL7h2SvtuS6VpjduKNaxkjJJYDpQ4PmXkOewc8mjNWrMQw5PHM7kWNx3/dopK+k
         eAJNC+0bxdymZjwXTLtieJI2ABGtvFH8zm2ZmUpgqWrLaaNGuqS/WM/g+lpxumdpVnKx
         FOVolS5K3xq4mFIWzdlQcPPT6rS8zXIst2/Fn5ZRnEuXlQMuQJU/BljxaPnpN0wd/skJ
         bUoL7uqi8uNi5+/lYNHcEeSP1zmddLqyts4j9Yi1hLCPWy/iX7MMSOHy/oIfI1dIUfc6
         9QCQ7eciFGW4g/oj0E7Z0Bg6SObcSKoj8o69CxlzFLcurci4fXvXFsQj66pV0sRKL3Jf
         Wyww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=w1SG5zqgVGIcSqZQcep6A7Ljqt8+dcRBgDy6JrQmhk4=;
        b=Xo0RgAI/wGlA+qn7GM7NpXYoXlA6DhwQuZZ+dJerQZDA/t+rIIxLmkUBZDJth7gXSl
         cZvJqtHAa8gSYDO6/fP5vIpmEj7zAYiLl1LRor1J95/iwnLkXwO+WVKZY2exPeTiSmi6
         6GjZL8tFxOVrj5y7MDAAQMeYIECed4IGPnIvelDGQ+3jy8MSa4//3qmCbnPygPBmTUJy
         ywsmXwcr9VTzEm+0/9o9Yz5CjnhAZ2SoIEsB/HzGQlbxCCv4+wA4+FpD7q5mEF5qvDg3
         btBGKwyT46G4JUuBQgnEYuSszH/xHqSzemA6fb2+JKHgsMt5AlGgyFcq9F8B5yBB0iCi
         RPHQ==
X-Gm-Message-State: AOAM531j7Pn4URPSzitWkio9IIIqLlNhJu2oBqmyJZWoMtfQCTua8K2d
        s9tMBeEXcevBOZGvVXrcCOAO9VugKyci9A==
X-Google-Smtp-Source: ABdhPJyYG2W9TRGrIWNY3I43uAUoO4HJ/b53QIEVvLz45nXoBjEc8zxDxxynaY01VfHX4vwtKmWxCA==
X-Received: by 2002:a05:6402:206d:: with SMTP id bd13mr10331732edb.38.1618583714995;
        Fri, 16 Apr 2021 07:35:14 -0700 (PDT)
Received: from anparri.mshome.net (mob-176-243-167-64.net.vodafone.it. [176.243.167.64])
        by smtp.gmail.com with ESMTPSA id x4sm5399472edd.58.2021.04.16.07.35.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 07:35:14 -0700 (PDT)
From:   "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, linux-hyperv@vger.kernel.org,
        mikelley@microsoft.com,
        "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>
Subject: [PATCH v3 1/3] Drivers: hv: vmbus: Introduce and negotiate VMBus protocol version 5.3
Date:   Fri, 16 Apr 2021 16:34:47 +0200
Message-Id: <20210416143449.16185-2-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210416143449.16185-1-parri.andrea@gmail.com>
References: <20210416143449.16185-1-parri.andrea@gmail.com>
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
index 2c18c8e768efe..3ce36bbb398e9 100644
--- a/include/linux/hyperv.h
+++ b/include/linux/hyperv.h
@@ -234,6 +234,7 @@ static inline u32 hv_get_avail_to_write_percent(
  * 5 . 0  (Newer Windows 10)
  * 5 . 1  (Windows 10 RS4)
  * 5 . 2  (Windows Server 2019, RS5)
+ * 5 . 3  (Windows Server 2022)
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

