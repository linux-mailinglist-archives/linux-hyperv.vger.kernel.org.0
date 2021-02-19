Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E417D31FDB4
	for <lists+linux-hyperv@lfdr.de>; Fri, 19 Feb 2021 18:14:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbhBSROU (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 19 Feb 2021 12:14:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbhBSROU (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 19 Feb 2021 12:14:20 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB1C9C061574;
        Fri, 19 Feb 2021 09:13:39 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id o63so4990648pgo.6;
        Fri, 19 Feb 2021 09:13:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bRbXNXl96pj0w403t4rykQMl66r9sAJYFL2E2EApayA=;
        b=pUM5Xpak3YIB8uObyyVofupIjMdw5XxyBgilN/16alnc4NgIxDrKGlFm4yxDlMQaT1
         ZGz1D86BSDLbIykgZO3tJGXBq++vfQNGRLE3YhW+3nxjG/wfveqxu0V4ghksCAD9oiwz
         sXUJbRWtDsX4johzk5eM2FytisnO/LMBmMOZzcUHMF9yUFclnsp6RcwwkZhz3wjmURDV
         i5s5llX04e7jkO8js7P2nx6uS5qois6q5MDIXH1wBB1Pi0hQwu4fUyxk0vCC1AOsdipY
         LCjK0zCBV6tqkWIVvMdiKoxF/NiSYwArbxCriaAuAoPhj6ccaO69HJE6VwiHkAlCLwpC
         UBlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bRbXNXl96pj0w403t4rykQMl66r9sAJYFL2E2EApayA=;
        b=DlhHTzTUb6/Vui+4CJIu90iGD7o0RrTQD/xQ+DNIJVZUxsexJOfeAGHnepagf8RbYO
         rLqjjAeBl1lV3XByRNtoWzSlIn4iy0ZrOGfglxpts0JAAXmYAtITOkHe4651CINYignD
         doWgwW31T1CoEFk7MpXgGNwYGG9IDnsLfUewOqbI7BTvo1zcI1RJdMfARpfiPTs+wb/n
         ugWQ7Pc4bIeFbloiFvIh4yeuwyTntD1Nusw0GurvS8sLgkxnrzSzHelDblUJC9Dxko7G
         cQgNfGcz++2Ch7IOYlxsPTpUiWXvHx62eOJ5jh2qyux0iuaZ7dlNb30UfqEtwiggKV6I
         3aEw==
X-Gm-Message-State: AOAM530UolIUgXkX3L0rU2br2B+6DIT754XaTEWAKDOlyNFSdpULhcRm
        Wm1dgynjwf1vsH7qd3hprvY=
X-Google-Smtp-Source: ABdhPJxuH9EoIxl0uq4PAmzY39XqDdILioOVNC56kQWIbjxIXTA6WWMpngsDpwiXLSb9VMn7O6yOeg==
X-Received: by 2002:a63:fa06:: with SMTP id y6mr9248596pgh.364.1613754819470;
        Fri, 19 Feb 2021 09:13:39 -0800 (PST)
Received: from localhost.localdomain ([2405:201:e01e:c062:88cf:ed5a:1c1f:ec9])
        by smtp.gmail.com with ESMTPSA id s15sm10669386pfe.108.2021.02.19.09.13.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Feb 2021 09:13:39 -0800 (PST)
From:   Vasanth <vasanth3g@gmail.com>
To:     kys@microsoft.com
Cc:     haiyangz@microsoft.com, sthemmin@microsoft.com, wei.liu@kernel.org,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vasanth <vasanth3g@gmail.com>
Subject: [PATCH v3] drivers: hv: Fix whitespace errors
Date:   Fri, 19 Feb 2021 22:43:11 +0530
Message-Id: <20210219171311.421961-1-vasanth3g@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Fixed checkpatch warning and errors on hv driver.

Signed-off-by: Vasanth <vasanth3g@gmail.com>
---

changes in v2:
*  Added commit message
*  Revised Subject

 drivers/hv/channel.c    | 2 +-
 drivers/hv/connection.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hv/channel.c b/drivers/hv/channel.c
index 6fb0c76bfbf8..587234065e37 100644
--- a/drivers/hv/channel.c
+++ b/drivers/hv/channel.c
@@ -385,7 +385,7 @@ static int create_gpadl_header(enum hv_gpadl_type type, void *kbuffer,
  * @kbuffer: from kmalloc or vmalloc
  * @size: page-size multiple
  * @send_offset: the offset (in bytes) where the send ring buffer starts,
- * 		 should be 0 for BUFFER type gpadl
+ *              should be 0 for BUFFER type gpadl
  * @gpadl_handle: some funky thing
  */
 static int __vmbus_establish_gpadl(struct vmbus_channel *channel,
diff --git a/drivers/hv/connection.c b/drivers/hv/connection.c
index 11170d9a2e1a..3760cbb6ffaf 100644
--- a/drivers/hv/connection.c
+++ b/drivers/hv/connection.c
@@ -28,7 +28,7 @@ struct vmbus_connection vmbus_connection = {
 	.conn_state		= DISCONNECTED,
 	.next_gpadl_handle	= ATOMIC_INIT(0xE1E10),
 
-	.ready_for_suspend_event= COMPLETION_INITIALIZER(
+	.ready_for_suspend_event = COMPLETION_INITIALIZER(
 				  vmbus_connection.ready_for_suspend_event),
 	.ready_for_resume_event	= COMPLETION_INITIALIZER(
 				  vmbus_connection.ready_for_resume_event),
-- 
2.25.1

