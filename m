Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE5652B7F88
	for <lists+linux-hyperv@lfdr.de>; Wed, 18 Nov 2020 15:40:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726969AbgKROhs (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 18 Nov 2020 09:37:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725613AbgKROhr (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 18 Nov 2020 09:37:47 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8825DC0613D4;
        Wed, 18 Nov 2020 06:37:47 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id p1so2370717wrf.12;
        Wed, 18 Nov 2020 06:37:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1EyviBt7geIMMKK7bQG4xUWKkJ8ibnz1+ePwM8GcLlg=;
        b=I5cofbdXdY5T23J2n7cJiPXuYwErHc3IRWq36SXLfrdk8XLJhm4zjhxEreAN1fdqi0
         OTbNTGerjvON0XOy+BGqWObx8IfSWG++ZdwTNETg1KqRhSS9lG0qlHBM0BePxhbBtQFh
         oyr/ZTkSN5jDZpLHd7bLne7c3oNU+aFLo7Lm67OVdBdqgqGATicTOJdaxpJna0hHnPqP
         8cd/xnXPC+NZTCFIcCBOe4UKBaw3jaIZsULbrFDkLz0ydLRLtG+o1fwf93l1id1mWqXx
         OTn4ldqcj3dkybzkE/mtdPzc67Nq6ZhZpS4JXhv34rQ+HNnBHSqqiqv+xynXzGwRZgrk
         XQXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1EyviBt7geIMMKK7bQG4xUWKkJ8ibnz1+ePwM8GcLlg=;
        b=ppiRftsg0s5QgtjtfF4XYUafYcXQucGGiTdcR4TOx5j7ehcc64rdhDC8ET8VXbnohO
         HxbHLdqnwnqtOEGA7y7A9XcXvF78/Z3Z8xOw91wJNXfpYyMKi56nDa0knOJszXFx5DoX
         Uz5JuLQtiMG94WeUwLk0wHSGMcxnoEsyBQ5VdeKM87Dfly9ZT0TSlG1zfWomyxV5t2Xy
         6Ve+LCzSi8bqdNZYEC4vJAzVPCc0qZmD5eNyJJ6hKKt6ux+NBVtbhcYPM3iq2YHu3KaQ
         WovOTe0swbIUgZqbyaX/R0AGXHQ/g4rro8l8s/HDsZxv44xs9LoJ7nMsXYc/v9Y4b+57
         A7dQ==
X-Gm-Message-State: AOAM530ooOUHnsSdF9wF+x0p4Zo7hi1fFxlFMmOYDxgo+P5To0suzktC
        i+t7vToKAmb9LKUKD6iTTLhRyA4EGfwHEw==
X-Google-Smtp-Source: ABdhPJyiHl5jcXZZv67Ja0vtqfB+DtOjRQbIrHey9kvU99Ot22GUkS3nmqpkZFzr6UNncknkXNJD8Q==
X-Received: by 2002:adf:9e48:: with SMTP id v8mr5514445wre.55.1605710265713;
        Wed, 18 Nov 2020 06:37:45 -0800 (PST)
Received: from localhost.localdomain (host-82-51-6-75.retail.telecomitalia.it. [82.51.6.75])
        by smtp.gmail.com with ESMTPSA id w10sm34795307wra.34.2020.11.18.06.37.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2020 06:37:45 -0800 (PST)
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
Subject: [PATCH 4/6] Drivers: hv: vmbus: Avoid use-after-free in vmbus_onoffer_rescind()
Date:   Wed, 18 Nov 2020 15:36:47 +0100
Message-Id: <20201118143649.108465-5-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201118143649.108465-1-parri.andrea@gmail.com>
References: <20201118143649.108465-1-parri.andrea@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

When channel->device_obj is non-NULL, vmbus_onoffer_rescind() could
invoke put_device(), that will eventually release the device and free
the channel object (cf. vmbus_device_release()).  However, a pointer
to the object is dereferenced again later to load the primary_channel.
The use-after-free can be avoided by noticing that this load/check is
redundant if device_obk is non-NULL: primary_channel must be NULL if
device_obj is non-NULL, cf. vmbus_add_channel_work().

Reported-by: Juan Vazquez <juvazq@microsoft.com>
Signed-off-by: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
---
 drivers/hv/channel_mgmt.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
index 5bc5eef5da159..4072fd1f22146 100644
--- a/drivers/hv/channel_mgmt.c
+++ b/drivers/hv/channel_mgmt.c
@@ -1116,8 +1116,7 @@ static void vmbus_onoffer_rescind(struct vmbus_channel_message_header *hdr)
 			vmbus_device_unregister(channel->device_obj);
 			put_device(dev);
 		}
-	}
-	if (channel->primary_channel != NULL) {
+	} else if (channel->primary_channel != NULL) {
 		/*
 		 * Sub-channel is being rescinded. Following is the channel
 		 * close sequence when initiated from the driveri (refer to
-- 
2.25.1

