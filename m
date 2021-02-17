Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5313331DB5F
	for <lists+linux-hyperv@lfdr.de>; Wed, 17 Feb 2021 15:24:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233453AbhBQOXc (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 17 Feb 2021 09:23:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233390AbhBQOX2 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 17 Feb 2021 09:23:28 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40836C061574;
        Wed, 17 Feb 2021 06:22:48 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id s16so3572433plr.9;
        Wed, 17 Feb 2021 06:22:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mFwrbBRar0ZFgwsE7uD0jgClSERbKKwZDbGmgiCI+Qg=;
        b=YIA1iaXyAwMIthjoITDsPUAU5rRGReZnCBQQJVEOiYgABOSD0on9KIYTOYtJ5aNm+g
         MRqyBfANOOxWGqKhT9ZycywBaT5lmPBRJuyKROLAR6aY3hzPitkJlDCSfdgwrJ5QEbmS
         IYLW2vPDT2jylQoFwgqHpK8gSA6Y7Qr3ugdSDhlH4A9g6a3IHr7rOYRO5b9oZJq7UGcn
         34llarg2W2OUssNqOxk1xaGMZhmdWb0GIq+SJ0HYHqj1s++ceqhwk2uibeBN+hIWg5Pz
         393R2Dwd5etY7BsIljZP8qdnl1I1xjURvfMTGuVyDR1NAiZxbBl1D1kGxOpnlXNLGNRr
         XTZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mFwrbBRar0ZFgwsE7uD0jgClSERbKKwZDbGmgiCI+Qg=;
        b=UYsmJnUvVv1NA/UPhfMfNfikBdktSbUQVR9YgxdGnoC66EPaCK0YhmAGQSovEReQtb
         t66to4qKPEtMCxJ9maWTvFTBA1XgIXe/+JM6r0UP1C/qT+C3v5ZxxdsPYSp6fs4vsOdK
         EkCMgja9rWNy+H/QKTEJBEHLnPlqYvlslQ4u3haJKeOsagUHV15U2bN9/Pb7CaF9FShq
         p1O7J9rGYbcnfgEoplzKwNT83n5bfO+vdWy7CaLAEkjtCIA7y0mAlYXCuRLFWFI5986c
         U9K5SHth6IsaDLu3AjhxwvfRpv5VCzgnRu/D53ZS9Nn7IpT60/mAfhLGZPJpzOhF9Av/
         aTiA==
X-Gm-Message-State: AOAM5326KcDMYzW/E+F2eGocNu0aSTGvvyZWRz7rW5eCK62s9jlztPK1
        HiugCXV/GybhkMF87DT87marqylCleDHV3xH
X-Google-Smtp-Source: ABdhPJxW0I4jCh6NgNTDm7hSR49VVdKastG5zfs8sZ+6Ud+w50ALTuijNevGlnCjm9DB9G5lqs8DcQ==
X-Received: by 2002:a17:90a:f2ce:: with SMTP id gt14mr9149461pjb.221.1613571767730;
        Wed, 17 Feb 2021 06:22:47 -0800 (PST)
Received: from localhost.localdomain ([2405:201:e01e:c062:b757:c18c:b83f:9a4])
        by smtp.gmail.com with ESMTPSA id z22sm2865080pfa.41.2021.02.17.06.22.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Feb 2021 06:22:47 -0800 (PST)
From:   Vasanth <vasanth3g@gmail.com>
To:     kys@microsoft.com
Cc:     haiyangz@microsoft.com, sthemmin@microsoft.com, wei.liu@kernel.org,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vasanth <vasanth3g@gmail.com>
Subject: [PATCH] Staging: hv: channel.c: fixed a tab spaces before space       hv: connection.c fixed a "=" sign without space in code
Date:   Wed, 17 Feb 2021 19:52:28 +0530
Message-Id: <20210217142228.393370-1-vasanth3g@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Signed-off-by: Vasanth Mathivanan <vasanth3g@gmail.com>
---
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

