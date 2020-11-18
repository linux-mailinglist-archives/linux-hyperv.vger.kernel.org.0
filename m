Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38BA62B7F8B
	for <lists+linux-hyperv@lfdr.de>; Wed, 18 Nov 2020 15:40:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726110AbgKROhu (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 18 Nov 2020 09:37:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725613AbgKROht (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 18 Nov 2020 09:37:49 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92390C0613D4;
        Wed, 18 Nov 2020 06:37:49 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id p19so4272632wmg.0;
        Wed, 18 Nov 2020 06:37:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1mAxqSMz7VFb+amOxQ3+4rc/WVh8Vx757mod6VpsOnY=;
        b=vYKnF7pQidIU7sStZFyqfePGYTfxNwN60y236e80fDbUzl1DUv1Uu5TAUJ+AIdijLk
         zDJJ+8Ktt8Hi/q1oKtGB6uX8O+88qQ20fSTL05Zm/1UD1lAVhz5QGbkUotUFdNd+/yJ7
         SpGQGQIy20QravKzRMbwJyrezs+kGXvKjLhvYHlmtfSYVTMkCL4368Sjp/r/T33BLof+
         AUSq4trsa6uuKg08gBsgH/kuemDPCdkdf2WOWoOwzVtXfmOr+Dvw9y3Pv2Y0nkGvH6Ir
         3UyQm3dbHOOWni9r2Ph707VrOr+qHF+Xx+LT65XhdYrI/jnbKAQjzhKe9OXsISJO7ISp
         Id0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1mAxqSMz7VFb+amOxQ3+4rc/WVh8Vx757mod6VpsOnY=;
        b=HhDB/yWJu0fKGn/rlg5Mi4jt1SnYlFZrbyFEW+ROqq36uOJqepvm8roiU3GCJNWzng
         eKi79OagDDvrk/sy0iQf7GNVFsJrmxT1pOVBYdivnG/aJMYRBOVyC51n/90HvYcnfa4C
         UiB30EpbsBR+YXGYKPf30LrUiEc/lJUyrLXd10qP/7iOQsU6kUEk2y2T8MMX6mjbnOTO
         OSoK7+4Sk67fOAx+7wqsS3w0EWTMH2ygHBTRMDwK4Y7RhBYUVMQV8euMBovbYUBr+0gs
         CwCpd2QCzCd6GO7NNNiDvKIWrMIKwWCKixBSiO7MEfNzkBZG0se0CAu4nHk+z5FQYFhE
         wkBQ==
X-Gm-Message-State: AOAM533dOu2tgFExWlFYGvoFFIGe/j16JCfvtymCOB2/jiQZuYql/uIE
        Y3TKC/R4TXsvQdA9UoBSvwIHsuw9JwlFmg==
X-Google-Smtp-Source: ABdhPJygBuWONCcVsuNYiU3PUEDRNxDrxloSGA2GJTKX7i+JvRN/r5rLtgfIFWoav7eNXzl4Ezf+gQ==
X-Received: by 2002:a1c:964d:: with SMTP id y74mr310954wmd.129.1605710267885;
        Wed, 18 Nov 2020 06:37:47 -0800 (PST)
Received: from localhost.localdomain (host-82-51-6-75.retail.telecomitalia.it. [82.51.6.75])
        by smtp.gmail.com with ESMTPSA id w10sm34795307wra.34.2020.11.18.06.37.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2020 06:37:47 -0800 (PST)
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
Subject: [PATCH 5/6] Drivers: hv: vmbus: Resolve race condition in vmbus_onoffer_rescind()
Date:   Wed, 18 Nov 2020 15:36:48 +0100
Message-Id: <20201118143649.108465-6-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201118143649.108465-1-parri.andrea@gmail.com>
References: <20201118143649.108465-1-parri.andrea@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

An erroneous or malicious host could send multiple rescind messages for
a same channel.  In vmbus_onoffer_rescind(), the guest maps the channel
ID to obtain a pointer to the channel object and it eventually releases
such object and associated data.  The host could time rescind messages
and lead to an use-after-free.  Add a new flag to the channel structure
to make sure that only one instance of vmbus_onoffer_rescind() can get
the reference to the channel object.

Reported-by: Juan Vazquez <juvazq@microsoft.com>
Signed-off-by: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
---
 drivers/hv/channel_mgmt.c | 12 ++++++++++++
 include/linux/hyperv.h    |  1 +
 2 files changed, 13 insertions(+)

diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
index 4072fd1f22146..68950a1e4b638 100644
--- a/drivers/hv/channel_mgmt.c
+++ b/drivers/hv/channel_mgmt.c
@@ -1063,6 +1063,18 @@ static void vmbus_onoffer_rescind(struct vmbus_channel_message_header *hdr)
 
 	mutex_lock(&vmbus_connection.channel_mutex);
 	channel = relid2channel(rescind->child_relid);
+	if (channel != NULL) {
+		/*
+		 * Guarantee that no other instance of vmbus_onoffer_rescind()
+		 * has got a reference to the channel object.  Synchronize on
+		 * &vmbus_connection.channel_mutex.
+		 */
+		if (channel->rescind_ref) {
+			mutex_unlock(&vmbus_connection.channel_mutex);
+			return;
+		}
+		channel->rescind_ref = true;
+	}
 	mutex_unlock(&vmbus_connection.channel_mutex);
 
 	if (channel == NULL) {
diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
index 2ea967bc17adf..f0d48a368f131 100644
--- a/include/linux/hyperv.h
+++ b/include/linux/hyperv.h
@@ -809,6 +809,7 @@ struct vmbus_channel {
 	u8 monitor_bit;
 
 	bool rescind; /* got rescind msg */
+	bool rescind_ref; /* got rescind msg, got channel reference */
 	struct completion rescind_event;
 
 	u32 ringbuffer_gpadlhandle;
-- 
2.25.1

