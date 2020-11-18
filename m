Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 881B02B7F83
	for <lists+linux-hyperv@lfdr.de>; Wed, 18 Nov 2020 15:40:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbgKROhl (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 18 Nov 2020 09:37:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726702AbgKROhl (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 18 Nov 2020 09:37:41 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AADBC0613D4;
        Wed, 18 Nov 2020 06:37:41 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id a3so2925343wmb.5;
        Wed, 18 Nov 2020 06:37:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KmfIqVNpO1qdYqld/se9wMpL7fXGnp4cSTMlbr3vWAM=;
        b=Cj+7mX7+BJKse0BaDdJxmhVssBNRLqrikz/XxYkqEXFlnDDmUgHPx0BsTmtpr23eum
         mEGc77Az2bdFZY9z5OTpGwQenrAu4I7NW9fwnqNZOo0mj+PF80yBEiDO/RUv7qd0/hIb
         l03DSLY4CRpfHAoxsu38TUCl4nuNpQSss+3QCbDYyFMWDci/RyBk/oTcVpKgETHNmE54
         yS6EYsRxxDAxEQb9CAstL/lOEm65kdwdJJINvl5ORv/zTjnH49RnHrC48itMyeYGjiUK
         TWFknSjQEX+C6Pv/Gh/I8yzXnAj4IQsxZ6Wy3Jtc7jyzHfs5KJRmun1UvBKbCRrArHhO
         m5nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KmfIqVNpO1qdYqld/se9wMpL7fXGnp4cSTMlbr3vWAM=;
        b=pogPXHFaUEEAa9pLOcvRoKbIP7iPcH1HI7ttWWa3IjbeIKDCSq+qC3dELaCIwVORmV
         1mJEHYZdNxSiFTKQlLYXN5rxl5+nIbsAD8PM4aD3t/OS9RHukGzm6Cs83TNDEJIu1/uw
         yLGG33XG9x6jcfw1AYM914gfJmQ0wxdlcLKaKKpVkKEtT0251XAozonzeUjMfwt5P9nO
         0DWm1tlu4aJHzpev/gc/X7CSOM3yBSCSHkt6TghjSOP9AxTdNJCdTy79YDYhLXuhwpeT
         TIweUqQM4iV18mOhN65ZGPBB6ldy4lswWRYo4jfdqWze0bluHASaOlLnAqW3xppXvW36
         hGNA==
X-Gm-Message-State: AOAM530ZQrz3y7hsapUFIhrPo3hD4qYXNb/i8H4ogspYZTIeUVAJ9p3N
        aNhPYw/TrOz2a1tMtZY2AuIhGp6TXYcvdw==
X-Google-Smtp-Source: ABdhPJz+nlllOknZB9IxEtenVJ9oUAC831zHIbE5d0EH8DPu1oZBanJt43k2BvbrKWx2Lr0M392hSw==
X-Received: by 2002:a7b:c458:: with SMTP id l24mr344585wmi.136.1605710259243;
        Wed, 18 Nov 2020 06:37:39 -0800 (PST)
Received: from localhost.localdomain (host-82-51-6-75.retail.telecomitalia.it. [82.51.6.75])
        by smtp.gmail.com with ESMTPSA id w10sm34795307wra.34.2020.11.18.06.37.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2020 06:37:38 -0800 (PST)
From:   "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     "K . Y . Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, linux-hyperv@vger.kernel.org,
        Michael Kelley <mikelley@microsoft.com>,
        Juan Vazquez <juvazq@microsoft.com>,
        Saruhan Karademir <skarade@microsoft.com>,
        "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>
Subject: [PATCH 1/6] Drivers: hv: vmbus: Initialize memory to be sent to the host
Date:   Wed, 18 Nov 2020 15:36:44 +0100
Message-Id: <20201118143649.108465-2-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201118143649.108465-1-parri.andrea@gmail.com>
References: <20201118143649.108465-1-parri.andrea@gmail.com>
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
---
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

