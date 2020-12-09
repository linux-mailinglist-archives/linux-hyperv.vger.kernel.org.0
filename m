Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA55B2D3BFA
	for <lists+linux-hyperv@lfdr.de>; Wed,  9 Dec 2020 08:11:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727679AbgLIHJ7 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 9 Dec 2020 02:09:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727394AbgLIHJ7 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 9 Dec 2020 02:09:59 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7ED3C0613D6;
        Tue,  8 Dec 2020 23:09:18 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id a3so516252wmb.5;
        Tue, 08 Dec 2020 23:09:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2tQJ2hrC5+io0MNRypmrH8SpoyzTYa0aU3UjhbMzL7Y=;
        b=ZH8XwTT6s3jVNTcPcJAfaqx5gAtZyCBOoCrEXRGyRQvAx3P6L5MjfZC7+DuCNZMS08
         yk+86k0if9lKTme4HIlI0FEjeK5zYkxlD5hsMCmDH9iVR3qUM8JEGhtmYbw+XSoCv60h
         2XeqO7U7IEEXc+9lMNZpILmXYe66KqRnB9FwFRis0zlIdJKzeqH1p7xuJZGaHiIoNRMu
         TDkJ7ckv31NCy1h6wQBVShEs4Cc+9irkQYxdTj6C3fUWnSxfqi7Pxwd7idH9m34iFw1t
         6MHDE9BMpM1lfbnku80j7jqP5/eL52xB9xa36eYC3x7JZhUMvb1Ef8FJXddZtX2FEDK/
         t4Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2tQJ2hrC5+io0MNRypmrH8SpoyzTYa0aU3UjhbMzL7Y=;
        b=CAe1zUYkV2ihDnPWxhVu0J6DokVgU/m2+N7+4zT/ej+Sk4f5p0M7R4kbhja/oxxav7
         XBh0CWe87ZmRDZTceieAIGXWaO4xuFIKroX0IH3AiD1OZ/MIP5tiAkh7S1BKnfO+LgbE
         HaH1lzq6hyXLKj5+uuxTF5+EteapDAccox1A1v2GO71QheMZ8Twdjelm2b2s4kR3fBc1
         k3/aV+CLK3Ev3Cj1rj03CT6OM7knGc267HiBnv2hKkEDsqG2ZKa/nhKic98/p3t9tbj2
         iA54sPd2stNdXJ/qPzsamya9wHjytH0kekzmXh+OiSaDmBZjeEJ8Hea0Bm9vRs0pW91v
         YzTg==
X-Gm-Message-State: AOAM531x21JuGM9F7iY/JQ6ORqbLRXg945zh9Wsp8RBbT1rr5vu4Iodo
        PhUe7+KHIAJR+lckCL1UOiE5TjjiLJJrzw==
X-Google-Smtp-Source: ABdhPJyWfW6ve8XiLvqPWfQZ8aXo7k+EHcQexO0YLIew7g8kSMMJQRnaeWQySDplCUUdq4zHd9Z8QA==
X-Received: by 2002:a1c:1d85:: with SMTP id d127mr1155886wmd.49.1607497757163;
        Tue, 08 Dec 2020 23:09:17 -0800 (PST)
Received: from andrea.corp.microsoft.com (host-95-239-64-30.retail.telecomitalia.it. [95.239.64.30])
        by smtp.gmail.com with ESMTPSA id p3sm1449122wrs.50.2020.12.08.23.09.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 23:09:16 -0800 (PST)
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
Subject: [PATCH v3 1/6] Drivers: hv: vmbus: Initialize memory to be sent to the host
Date:   Wed,  9 Dec 2020 08:08:22 +0100
Message-Id: <20201209070827.29335-2-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201209070827.29335-1-parri.andrea@gmail.com>
References: <20201209070827.29335-1-parri.andrea@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

__vmbus_open() and vmbus_teardown_gpadl() do not inizialite the memory
for the vmbus_channel_open_channel and the vmbus_channel_gpadl_teardown
objects they allocate respectively.  These objects contain padding bytes
and fields that are left uninitialized and that are later sent to the
host, potentially leaking guest data.  Zero initialize such fields to
avoid leaking sensitive information to the host.

Reported-by: Juan Vazquez <juvazq@microsoft.com>
Signed-off-by: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
---
Changes since v2:
  - Add Reviewed-by: tag

 drivers/hv/channel.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hv/channel.c b/drivers/hv/channel.c
index 0d63862d65518..9aa789e5f22bb 100644
--- a/drivers/hv/channel.c
+++ b/drivers/hv/channel.c
@@ -621,7 +621,7 @@ static int __vmbus_open(struct vmbus_channel *newchannel,
 		goto error_clean_ring;
 
 	/* Create and init the channel open message */
-	open_info = kmalloc(sizeof(*open_info) +
+	open_info = kzalloc(sizeof(*open_info) +
 			   sizeof(struct vmbus_channel_open_channel),
 			   GFP_KERNEL);
 	if (!open_info) {
@@ -748,7 +748,7 @@ int vmbus_teardown_gpadl(struct vmbus_channel *channel, u32 gpadl_handle)
 	unsigned long flags;
 	int ret;
 
-	info = kmalloc(sizeof(*info) +
+	info = kzalloc(sizeof(*info) +
 		       sizeof(struct vmbus_channel_gpadl_teardown), GFP_KERNEL);
 	if (!info)
 		return -ENOMEM;
-- 
2.25.1

