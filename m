Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD83F569186
	for <lists+linux-hyperv@lfdr.de>; Wed,  6 Jul 2022 20:16:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232418AbiGFSP4 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 6 Jul 2022 14:15:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbiGFSPz (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 6 Jul 2022 14:15:55 -0400
Received: from relay.virtuozzo.com (relay.virtuozzo.com [130.117.225.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB9DC9FCF;
        Wed,  6 Jul 2022 11:15:54 -0700 (PDT)
Received: from [192.168.16.236] (helo=vzdev.sw.ru)
        by relay.virtuozzo.com with esmtp (Exim 4.95)
        (envelope-from <alexander.atanasov@virtuozzo.com>)
        id 1o99Yd-00927l-6j;
        Wed, 06 Jul 2022 20:15:27 +0200
From:   Alexander Atanasov <alexander.atanasov@virtuozzo.com>
To:     "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>
Cc:     kernel@openvz.org,
        Alexander Atanasov <alexander.atanasov@virtuozzo.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/1] Create debugfs file with hyper-v balloon usage information
Date:   Wed,  6 Jul 2022 18:15:09 +0000
Message-Id: <20220706181510.32236-1-alexander.atanasov@virtuozzo.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220706180202.bzbm6boi232bruct@liuwe-devbox-debian-v2>
References: <20220706180202.bzbm6boi232bruct@liuwe-devbox-debian-v2>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Allow the guest to know how much it is ballooned by the host.
It is useful when debugging out of memory conditions.

When host gets back memory from the guest it is accounted
as used memory in the guest but the guest have no way to know
how much it is actually ballooned.

Expose current state, flags and max possible memory to the guest.
While at it - fix a 10+ years old typo.

Signed-off-by: Alexander Atanasov <alexander.atanasov@virtuozzo.com>
---
 drivers/hv/hv_balloon.c | 126 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 125 insertions(+), 1 deletion(-)

V1->V2:
 - Fix C&P errors - you got me :)

Note - no attempt to handle guest vs host page size difference
is made - see ballooning_enabled.
Basicly if balloon page size != guest page size balloon is off.

diff --git a/drivers/hv/hv_balloon.c b/drivers/hv/hv_balloon.c
index 91e8a72eee14..91dfde06c6fb 100644
--- a/drivers/hv/hv_balloon.c
+++ b/drivers/hv/hv_balloon.c
@@ -11,6 +11,7 @@
 #include <linux/kernel.h>
 #include <linux/jiffies.h>
 #include <linux/mman.h>
+#include <linux/debugfs.h>
 #include <linux/delay.h>
 #include <linux/init.h>
 #include <linux/module.h>
@@ -248,7 +249,7 @@ struct dm_capabilities_resp_msg {
  * num_committed: Committed memory in pages.
  * page_file_size: The accumulated size of all page files
  *		   in the system in pages.
- * zero_free: The nunber of zero and free pages.
+ * zero_free: The number of zero and free pages.
  * page_file_writes: The writes to the page file in pages.
  * io_diff: An indicator of file cache efficiency or page file activity,
  *	    calculated as File Cache Page Fault Count - Page Read Count.
@@ -567,6 +568,13 @@ struct hv_dynmem_device {
 	__u32 version;
 
 	struct page_reporting_dev_info pr_dev_info;
+
+#ifdef CONFIG_DEBUG_FS
+	/*
+	 * Maximum number of pages that can be hot_add-ed
+	 */
+	__u64 max_dynamic_page_count;
+#endif
 };
 
 static struct hv_dynmem_device dm_device;
@@ -1078,6 +1086,9 @@ static void process_info(struct hv_dynmem_device *dm, struct dm_info_msg *msg)
 
 			pr_info("Max. dynamic memory size: %llu MB\n",
 				(*max_page_count) >> (20 - HV_HYP_PAGE_SHIFT));
+#ifdef CONFIG_DEBUG_FS
+			dm->max_dynamic_page_count = *max_page_count;
+#endif
 		}
 
 		break;
@@ -1807,6 +1818,115 @@ static int balloon_connect_vsp(struct hv_device *dev)
 	return ret;
 }
 
+/*
+ * DEBUGFS Interface
+ */
+#ifdef CONFIG_DEBUG_FS
+
+/**
+ * hv_balloon_debug_show - shows statistics of balloon operations.
+ * @f: pointer to the &struct seq_file.
+ * @offset: ignored.
+ *
+ * Provides the statistics that can be accessed in hv-balloon in the debugfs.
+ *
+ * Return: zero on success or an error code.
+ */
+static int hv_balloon_debug_show(struct seq_file *f, void *offset)
+{
+	struct hv_dynmem_device *dm = f->private;
+	unsigned long num_pages_committed;
+	char *sname;
+
+	seq_printf(f, "%-22s: %u.%u\n", "host_version",
+				DYNMEM_MAJOR_VERSION(dm->version),
+				DYNMEM_MINOR_VERSION(dm->version));
+
+	seq_printf(f, "%-22s:", "capabilities");
+	if (ballooning_enabled())
+		seq_puts(f, " enabled");
+
+	if (hot_add_enabled())
+		seq_puts(f, " hot_add");
+
+	seq_puts(f, "\n");
+
+	seq_printf(f, "%-22s: %u", "state", dm->state);
+	switch (dm->state) {
+	case DM_INITIALIZING:
+			sname = "Initializing";
+			break;
+	case DM_INITIALIZED:
+			sname = "Initialized";
+			break;
+	case DM_BALLOON_UP:
+			sname = "Balloon Up";
+			break;
+	case DM_BALLOON_DOWN:
+			sname = "Balloon Down";
+			break;
+	case DM_HOT_ADD:
+			sname = "Hot Add";
+			break;
+	case DM_INIT_ERROR:
+			sname = "Error";
+			break;
+	default:
+			sname = "Unknown";
+	}
+	seq_printf(f, " (%s)\n", sname);
+
+	/* HV Page Size */
+	seq_printf(f, "%-22s: %ld\n", "page_size", HV_HYP_PAGE_SIZE);
+
+	/* Pages added with hot_add */
+	seq_printf(f, "%-22s: %u\n", "pages_added", dm->num_pages_added);
+
+	/* pages that are "onlined"/used from pages_added */
+	seq_printf(f, "%-22s: %u\n", "pages_onlined", dm->num_pages_onlined);
+
+	/* pages we have given back to host */
+	seq_printf(f, "%-22s: %u\n", "pages_ballooned", dm->num_pages_ballooned);
+
+	num_pages_committed = vm_memory_committed();
+	num_pages_committed += dm->num_pages_ballooned +
+				(dm->num_pages_added > dm->num_pages_onlined ?
+				dm->num_pages_added - dm->num_pages_onlined : 0) +
+				compute_balloon_floor();
+	seq_printf(f, "%-22s: %lu\n", "total_pages_commited",
+				num_pages_committed);
+
+	seq_printf(f, "%-22s: %llu\n", "max_dynamic_page_count",
+				dm->max_dynamic_page_count);
+
+	return 0;
+}
+
+DEFINE_SHOW_ATTRIBUTE(hv_balloon_debug);
+
+static void  hv_balloon_debugfs_init(struct hv_dynmem_device *b)
+{
+	debugfs_create_file("hv-balloon", 0444, NULL, b,
+			&hv_balloon_debug_fops);
+}
+
+static void  hv_balloon_debugfs_exit(struct hv_dynmem_device *b)
+{
+	debugfs_remove(debugfs_lookup("hv-balloon", NULL));
+}
+
+#else
+
+static inline void hv_balloon_debugfs_init(struct hv_dynmem_device  *b)
+{
+}
+
+static inline void hv_balloon_debugfs_exit(struct hv_dynmem_device *b)
+{
+}
+
+#endif	/* CONFIG_DEBUG_FS */
+
 static int balloon_probe(struct hv_device *dev,
 			 const struct hv_vmbus_device_id *dev_id)
 {
@@ -1854,6 +1974,8 @@ static int balloon_probe(struct hv_device *dev,
 		goto probe_error;
 	}
 
+	hv_balloon_debugfs_init(&dm_device);
+
 	return 0;
 
 probe_error:
@@ -1879,6 +2001,8 @@ static int balloon_remove(struct hv_device *dev)
 	if (dm->num_pages_ballooned != 0)
 		pr_warn("Ballooned pages: %d\n", dm->num_pages_ballooned);
 
+	hv_balloon_debugfs_exit(dm);
+
 	cancel_work_sync(&dm->balloon_wrk.wrk);
 	cancel_work_sync(&dm->ha_wrk.wrk);
 
-- 
2.25.1

