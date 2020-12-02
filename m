Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2F742CB8B5
	for <lists+linux-hyperv@lfdr.de>; Wed,  2 Dec 2020 10:25:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388170AbgLBJXc (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 2 Dec 2020 04:23:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387998AbgLBJXb (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 2 Dec 2020 04:23:31 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E161C061A47;
        Wed,  2 Dec 2020 01:22:51 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id g14so2657902wrm.13;
        Wed, 02 Dec 2020 01:22:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1mAxqSMz7VFb+amOxQ3+4rc/WVh8Vx757mod6VpsOnY=;
        b=Oh+F8JyzYi+6lOccVesF09kopH9Z9xRfBHzVnG8Dtg/cPIKuG8si1wEJhO6wHR3Bjv
         YYpxYbKgKi5QI0XCIfP2OguVsIrOcTdQ/+472GjTuBK7LD2P+uilTRIu9Bh51hX4d1Q7
         9mSAHYi10IMOFbSDO/WquFSPoTL7ctglra/VaIR+8ftUtkvnQ/gnktJAiBnpUv/qGxBQ
         4JQPMiWvxG+zmjnebo5S3HVhrmC2cQL7jH6cbjCyeLXXPkxnui0riiTi679VqttG9E+7
         fz35h7uQS3dUaJA8CXxFumBcf+Biipe+ke8AcGrKNccSdh6CpNFvjqpz0Bk6ecuQ7YOu
         XJ0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1mAxqSMz7VFb+amOxQ3+4rc/WVh8Vx757mod6VpsOnY=;
        b=Gya3951XH+2BejFeOiwGdcoMfhW+hcGo/CkMwuyyCdJjviuVSMDTADfvf+edv2b9eZ
         WQ5bmkm34WGCbFTMYyQkoBcjFwWhhamXbI89kKk94uv3UMI6o4wuD5wsSnPIDlsgjM0z
         C81RVH1eH/z+VlhYR+Wqtj1FuGXBM3ABBNpe7IcqSrmBQko0zQma+TDhRpM/lMVtEZGq
         nH5Fq/lyay6+2hQPBgFkynJ1uDGBIwZ5IYJaf0wEuFDYmDdNZS4wsy+/yyMVCltRtQaA
         m7SY++lC0t5tPNOG3d4e/obT/bywcQLXqLuwajrEkwsSG4srcq4QN7dgw0COQLoGbxfY
         bVRw==
X-Gm-Message-State: AOAM531m/ZBmCRyrSHi/9JPJdfA6J+FoLWZkSOXe/KNhfnGSrnQRZdW0
        nhxxhjRnmC2wO468paFNQuCT7pJQXnLwsA==
X-Google-Smtp-Source: ABdhPJxQp0UyUsYUauoenLl67fLIVpL9quFg39MFYDZrmeSie14c1EzROI1z5F8OUpbpwUJgd78ofg==
X-Received: by 2002:a5d:51c2:: with SMTP id n2mr2201499wrv.326.1606900969578;
        Wed, 02 Dec 2020 01:22:49 -0800 (PST)
Received: from andrea.corp.microsoft.com (host-95-239-64-30.retail.telecomitalia.it. [95.239.64.30])
        by smtp.gmail.com with ESMTPSA id e27sm1535936wrc.9.2020.12.02.01.22.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 01:22:49 -0800 (PST)
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
Subject: [PATCH v2 6/7] Drivers: hv: vmbus: Resolve race condition in vmbus_onoffer_rescind()
Date:   Wed,  2 Dec 2020 10:22:13 +0100
Message-Id: <20201202092214.13520-7-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201202092214.13520-1-parri.andrea@gmail.com>
References: <20201202092214.13520-1-parri.andrea@gmail.com>
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

