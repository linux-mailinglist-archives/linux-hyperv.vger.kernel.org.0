Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 565393272C3
	for <lists+linux-hyperv@lfdr.de>; Sun, 28 Feb 2021 16:06:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230413AbhB1PGL (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 28 Feb 2021 10:06:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230503AbhB1PFg (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 28 Feb 2021 10:05:36 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83732C061794;
        Sun, 28 Feb 2021 07:04:18 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id u12so9437439pjr.2;
        Sun, 28 Feb 2021 07:04:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CgliuRyi4yQdYw8SI+/9lG6XvPLZehKqGC6v+rN6kBE=;
        b=pWWftE5hz3arrPCVWBGrfhF7pRAusmknADiLQQb1z01p+DFE+ibqzipWjuCAyWu2yO
         XuVD3OXcidap4B2B4784QhRZ7vm5e/Xx0tU246PAtWuAYFcjeVYP5c032PoVy/3lBur/
         JIdh6zEszeaWUvztk0FDwdy/izoBa3KhZpQ5MRRbDAmUU5UzfPbAAli1tAFz0b8twRpj
         3rxL1HQjA8ihd8vx+Rruyokv/C/2qpdAfXFkGkNVfiussabTajJ/MFcO54MW3gYPHviu
         7WZTUvPRI+BsO+msRpLLGLp7/EhNcxHHZM0q5UnBPZLmG3ROCyHWxNEgrF+/182Dwz5h
         r+6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CgliuRyi4yQdYw8SI+/9lG6XvPLZehKqGC6v+rN6kBE=;
        b=d4FFhJY3zFuCra8MbMzhBIRsc0YYYSQdQ8wJxbgegVHXlVp2gKLip5bu/NZm0o1ClI
         xfHwm2lKYmOraN7BzZDRLPIdNerHcJhp+MZIZWqGzdEUsqXTOmEiA+fyVOIGnjFI0ypD
         EL74ehJKQTWUDYFpTGrW4ZcWpyxgpwghZ1zEP3pdpBKfXS/17hE/PV66EIPoMs74bDQY
         8SrUAKh04/Z9etre1sS1RRaPh9RBYL5wvxL4SFOsLoe/jMWeLWFG/mdCkxuEsH196TAH
         x9TJwyzbcg/ECoO3NeZdyggLdHfG4moKEcs5+NCjQLrUGULVG8J8xLaEdvC8AZw7o8W1
         IHCQ==
X-Gm-Message-State: AOAM532nxcuZNZahbd/BKJgIPLgUP55N9kqAV7m4TFm91Ek0T3Pxz+3i
        ///1HieNvX9QlvvIF1BRPjD2j/Afhgbq3A==
X-Google-Smtp-Source: ABdhPJzMwT2DAmyf6vnBld5F8JMVxaYMvm3pm4nNYAba36YrrgHEsA/PJ4zjlQUJBwllhExrmQbxRA==
X-Received: by 2002:a17:90a:69c6:: with SMTP id s64mr11397425pjj.37.1614524658132;
        Sun, 28 Feb 2021 07:04:18 -0800 (PST)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com ([2001:4898:80e8:0:561f:afde:af07:8820])
        by smtp.gmail.com with ESMTPSA id 142sm8391331pfz.196.2021.02.28.07.04.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Feb 2021 07:04:17 -0800 (PST)
From:   Tianyu Lan <ltykernel@gmail.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org
Cc:     Tianyu Lan <Tianyu.Lan@microsoft.com>,
        linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
        vkuznets@redhat.com, thomas.lendacky@amd.com,
        brijesh.singh@amd.com, sunilmut@microsoft.com
Subject: [RFC PATCH 8/12] x86/Hyper-V: Initialize bounce buffer page cache and list
Date:   Sun, 28 Feb 2021 10:03:11 -0500
Message-Id: <20210228150315.2552437-9-ltykernel@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210228150315.2552437-1-ltykernel@gmail.com>
References: <20210228150315.2552437-1-ltykernel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Tianyu Lan <Tianyu.Lan@microsoft.com>

Initialize/free bounce buffer resource when add/delete
vmbus channel in Isolation VM.

Signed-off-by: Sunil Muthuswamy <sunilmut@microsoft.com>
Co-Developed-by: Sunil Muthuswamy <sunilmut@microsoft.com>
Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
---
 drivers/hv/Makefile       |  2 +-
 drivers/hv/channel_mgmt.c | 29 +++++++++++++++++----------
 drivers/hv/hv_bounce.c    | 42 +++++++++++++++++++++++++++++++++++++++
 drivers/hv/hyperv_vmbus.h | 14 +++++++++++++
 include/linux/hyperv.h    | 22 ++++++++++++++++++++
 5 files changed, 97 insertions(+), 12 deletions(-)
 create mode 100644 drivers/hv/hv_bounce.c

diff --git a/drivers/hv/Makefile b/drivers/hv/Makefile
index 94daf8240c95..b0c20fed9153 100644
--- a/drivers/hv/Makefile
+++ b/drivers/hv/Makefile
@@ -8,6 +8,6 @@ CFLAGS_hv_balloon.o = -I$(src)
 
 hv_vmbus-y := vmbus_drv.o \
 		 hv.o connection.o channel.o \
-		 channel_mgmt.o ring_buffer.o hv_trace.o
+		 channel_mgmt.o ring_buffer.o hv_trace.o hv_bounce.o
 hv_vmbus-$(CONFIG_HYPERV_TESTING)	+= hv_debugfs.o
 hv_utils-y := hv_util.o hv_kvp.o hv_snapshot.o hv_fcopy.o hv_utils_transport.o
diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
index f0ed730e2e4e..e2846cacfd70 100644
--- a/drivers/hv/channel_mgmt.c
+++ b/drivers/hv/channel_mgmt.c
@@ -336,6 +336,18 @@ bool vmbus_prep_negotiate_resp(struct icmsg_hdr *icmsghdrp, u8 *buf,
 
 EXPORT_SYMBOL_GPL(vmbus_prep_negotiate_resp);
 
+/*
+ * free_channel - Release the resources used by the vmbus channel object
+ */
+static void free_channel(struct vmbus_channel *channel)
+{
+	tasklet_kill(&channel->callback_event);
+	vmbus_remove_channel_attr_group(channel);
+
+	kobject_put(&channel->kobj);
+	hv_free_channel_ivm(channel);
+}
+
 /*
  * alloc_channel - Allocate and initialize a vmbus channel object
  */
@@ -360,17 +372,6 @@ static struct vmbus_channel *alloc_channel(void)
 	return channel;
 }
 
-/*
- * free_channel - Release the resources used by the vmbus channel object
- */
-static void free_channel(struct vmbus_channel *channel)
-{
-	tasklet_kill(&channel->callback_event);
-	vmbus_remove_channel_attr_group(channel);
-
-	kobject_put(&channel->kobj);
-}
-
 void vmbus_channel_map_relid(struct vmbus_channel *channel)
 {
 	if (WARN_ON(channel->offermsg.child_relid >= MAX_CHANNEL_RELIDS))
@@ -510,6 +511,8 @@ static void vmbus_add_channel_work(struct work_struct *work)
 		if (vmbus_add_channel_kobj(dev, newchannel))
 			goto err_deq_chan;
 
+		hv_init_channel_ivm(newchannel);
+
 		if (primary_channel->sc_creation_callback != NULL)
 			primary_channel->sc_creation_callback(newchannel);
 
@@ -543,6 +546,10 @@ static void vmbus_add_channel_work(struct work_struct *work)
 	}
 
 	newchannel->probe_done = true;
+
+	if (hv_init_channel_ivm(newchannel))
+		goto err_deq_chan;
+
 	return;
 
 err_deq_chan:
diff --git a/drivers/hv/hv_bounce.c b/drivers/hv/hv_bounce.c
new file mode 100644
index 000000000000..c5898325b238
--- /dev/null
+++ b/drivers/hv/hv_bounce.c
@@ -0,0 +1,42 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Bounce buffer code for Hyper-V Isolation VM support.
+ *
+ * Authors:
+ *   Sunil Muthuswamy <sunilmut@microsoft.com>
+ *   Tianyu Lan <Tianyu.Lan@microsoft.com>
+ */
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include "hyperv_vmbus.h"
+
+int hv_init_channel_ivm(struct vmbus_channel *channel)
+{
+	if (!hv_is_isolation_supported())
+		return 0;
+
+	INIT_LIST_HEAD(&channel->bounce_page_free_head);
+	INIT_LIST_HEAD(&channel->bounce_pkt_free_list_head);
+
+	channel->bounce_pkt_cache = KMEM_CACHE(hv_bounce_pkt, 0);
+	if (unlikely(!channel->bounce_pkt_cache))
+		return -ENOMEM;
+	channel->bounce_page_cache = KMEM_CACHE(hv_bounce_page_list, 0);
+	if (unlikely(!channel->bounce_page_cache))
+		return -ENOMEM;
+
+	return 0;
+}
+
+void hv_free_channel_ivm(struct vmbus_channel *channel)
+{
+	if (!hv_is_isolation_supported())
+		return;
+
+
+	cancel_delayed_work_sync(&channel->bounce_page_list_maintain);
+	hv_bounce_pkt_list_free(channel, &channel->bounce_pkt_free_list_head);
+	hv_bounce_page_list_free(channel, &channel->bounce_page_free_head);
+	kmem_cache_destroy(channel->bounce_pkt_cache);
+	kmem_cache_destroy(channel->bounce_page_cache);
+}
diff --git a/drivers/hv/hyperv_vmbus.h b/drivers/hv/hyperv_vmbus.h
index d78a04ad5490..7edf2be60d2c 100644
--- a/drivers/hv/hyperv_vmbus.h
+++ b/drivers/hv/hyperv_vmbus.h
@@ -19,6 +19,7 @@
 #include <linux/hyperv.h>
 #include <linux/interrupt.h>
 
+#include <asm/mshyperv.h>
 #include "hv_trace.h"
 
 /*
@@ -56,6 +57,19 @@ union hv_monitor_trigger_state {
 	};
 };
 
+/*
+ * All vmbus channels initially start with zero bounce pages and are required
+ * to set any non-zero size, if needed.
+ */
+#define HV_DEFAULT_BOUNCE_BUFFER_PAGES  0
+
+/* MIN should be a power of 2 */
+#define HV_MIN_BOUNCE_BUFFER_PAGES	64
+
+extern int hv_init_channel_ivm(struct vmbus_channel *channel);
+
+extern void hv_free_channel_ivm(struct vmbus_channel *channel);
+
 /* struct hv_monitor_page Layout */
 /* ------------------------------------------------------ */
 /* | 0   | TriggerState (4 bytes) | Rsvd1 (4 bytes)     | */
diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
index 41cbaa2db567..d518aba17565 100644
--- a/include/linux/hyperv.h
+++ b/include/linux/hyperv.h
@@ -25,6 +25,9 @@
 #include <linux/interrupt.h>
 #include <linux/reciprocal_div.h>
 #include <asm/hyperv-tlfs.h>
+#include <linux/slab.h>
+#include <linux/mempool.h>
+#include <linux/mempool.h>
 
 #define MAX_PAGE_BUFFER_COUNT				32
 #define MAX_MULTIPAGE_BUFFER_COUNT			32 /* 128K */
@@ -1007,9 +1010,28 @@ struct vmbus_channel {
 	u32 fuzz_testing_interrupt_delay;
 	u32 fuzz_testing_message_delay;
 
+
 	/* request/transaction ids for VMBus */
 	struct vmbus_requestor requestor;
 	u32 rqstor_size;
+	/*
+	 * Minimum number of bounce resources (i.e bounce packets & pages) that
+	 * should be allocated and reserved for this channel. Allocation is
+	 * permitted to go beyond this limit, and the maintenance task takes
+	 * care of releasing the extra allocated resources.
+	 */
+	u32 min_bounce_resource_count;
+
+	/* The free list of bounce pages is LRU sorted based on last used */
+	struct list_head bounce_page_free_head;
+	u32 bounce_page_alloc_count;
+	struct delayed_work bounce_page_list_maintain;
+
+	struct kmem_cache *bounce_page_cache;
+	struct kmem_cache *bounce_pkt_cache;
+	struct list_head bounce_pkt_free_list_head;
+	u32 bounce_pkt_free_count;
+	spinlock_t bp_lock;
 };
 
 u64 vmbus_next_request_id(struct vmbus_requestor *rqstor, u64 rqst_addr);
-- 
2.25.1

