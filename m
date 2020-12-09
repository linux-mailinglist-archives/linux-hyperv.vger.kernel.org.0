Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D09892D3C05
	for <lists+linux-hyperv@lfdr.de>; Wed,  9 Dec 2020 08:11:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728396AbgLIHKb (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 9 Dec 2020 02:10:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727938AbgLIHKV (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 9 Dec 2020 02:10:21 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56B62C0617A6;
        Tue,  8 Dec 2020 23:09:28 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id t16so529413wra.3;
        Tue, 08 Dec 2020 23:09:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1mAxqSMz7VFb+amOxQ3+4rc/WVh8Vx757mod6VpsOnY=;
        b=ZVNXslK8ANefFZHJiOv1Hz/nOV825xcSRa2lAty+x947sshQehDEJMTyQcyj/vwEPN
         e5Bv4X6ti+Fdq6HwwrO7MowXUnenFgx7KzGoQy3IBP6iU6M6Fa7JLS3cEWRirF7ODQNT
         mu0NoYb/tYldzfHf7mQkKVf0NxPKfiOpZzz4Utv9ULuwsvNZ3bHnNQhJjlnbijPws1O1
         DRvXqLI6OwHN0gtBXkiFq0f5mMA4NKH9xp+0Tfph/hPsPdrMIn1oft4JmlttJYCwu5/v
         6dQeO/A5B5Mlzc+9aalMwUIMFJu9iEWk8/RTqmnFP4qG/lMXIfVjMWGmxqbfSFtei4at
         vSrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1mAxqSMz7VFb+amOxQ3+4rc/WVh8Vx757mod6VpsOnY=;
        b=W64ID5k5UaP2+kgI/odjpS+wADvwlSzm6a4TmMvBEbvmvEJ73MRgqh0u45kpFgT5CG
         I9KLkeaLqQagTV2zxXFGumMnyqJ8D5cyMKYNj1d4oP7pQRH65v+B4QiWAwACGrRTko+Y
         D2F0WiZ9mJPJ4+9CFvrADEDUICDGAHwputOIXQCuJUvVgXDkNvvFqsjRUDcHNmXBpcB0
         +fKTESGiCzrvhzd6r3fVjz1dS6Ou4hdpnzRV0jpVGOl6Rw8VYLKtIVePfDcciJ+ZHKji
         51L6zBkORQPI865Rgq493ye8KcsfXvBOrWxud6OFGofBQx/7A2bQy1uGpVX0LKJrIxUK
         bsrA==
X-Gm-Message-State: AOAM530hirx2bIdXubbfyI0EK8hZUQad9q8JeyXDD4711QjHXaYFV+tI
        7Y33LnL/yTStgtOXHGpQY0tGXpKUMa8S8g==
X-Google-Smtp-Source: ABdhPJyMezS778En8aISEF+/LaGKguNhF0zAow04nqakFPDeTlfqaubWSvNEYzH2e3Ri5tpv2vOShw==
X-Received: by 2002:adf:ecd0:: with SMTP id s16mr926596wro.415.1607497766719;
        Tue, 08 Dec 2020 23:09:26 -0800 (PST)
Received: from andrea.corp.microsoft.com (host-95-239-64-30.retail.telecomitalia.it. [95.239.64.30])
        by smtp.gmail.com with ESMTPSA id p3sm1449122wrs.50.2020.12.08.23.09.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 23:09:26 -0800 (PST)
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
Subject: [PATCH v3 5/6] Drivers: hv: vmbus: Resolve race condition in vmbus_onoffer_rescind()
Date:   Wed,  9 Dec 2020 08:08:26 +0100
Message-Id: <20201209070827.29335-6-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201209070827.29335-1-parri.andrea@gmail.com>
References: <20201209070827.29335-1-parri.andrea@gmail.com>
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

