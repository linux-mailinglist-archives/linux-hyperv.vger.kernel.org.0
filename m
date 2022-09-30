Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4622A5F0471
	for <lists+linux-hyperv@lfdr.de>; Fri, 30 Sep 2022 08:02:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbiI3GCR (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 30 Sep 2022 02:02:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230088AbiI3GCO (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 30 Sep 2022 02:02:14 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D8455200B2A;
        Thu, 29 Sep 2022 23:02:10 -0700 (PDT)
Received: by linux.microsoft.com (Postfix, from userid 1134)
        id 194AC20E0A4E; Thu, 29 Sep 2022 23:02:10 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 194AC20E0A4E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1664517730;
        bh=977Jsx8ikA7Oogcgw8EBooG0nQxyqKCRquP1jxo5VVs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RN1WjVfUaFCMNKHKm5HFi8xmaF02pFqlHssywkVyemZuOI7i2K43GLe2jJhKoQZZA
         5RgPGVkmOZaw0CrmwMbit4gPpcCjlvgOt6zhfaxjFHljjAMTA/M88V0526VriNYhNd
         5iFq8GcqSqfRCRE+jdsfUB0EycQtrdE/gpG2BCZ4=
From:   Shradha Gupta <shradhagupta@linux.microsoft.com>
To:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org
Cc:     Shradha Gupta <shradhagupta@linux.microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>
Subject: [PATCH v2 2/2] hv_balloon: Add support for configurable order free page reporting
Date:   Thu, 29 Sep 2022 23:01:39 -0700
Message-Id: <1664517699-1085-3-git-send-email-shradhagupta@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1664517699-1085-1-git-send-email-shradhagupta@linux.microsoft.com>
References: <1664447081-14744-1-git-send-email-shradhagupta@linux.microsoft.com>
 <1664517699-1085-1-git-send-email-shradhagupta@linux.microsoft.com>
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Newer versions of Hyper-V allow reporting unused guest pages in chunks
smaller than 2 Mbytes.  Using smaller chunks allows reporting more
unused guest pages, but with increased overhead in the finding the
small chunks.  To make this tradeoff configurable, use the existing
page_reporting_order module parameter to control the reporting order.
Drop and refine checks that restricted the minimun page reporting order
to 2Mbytes size pages. Add appropriate checks to make sure the
underlying Hyper-V versions support cold discard hints of any order
(and not just starting from 9)

Signed-off-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
---
 drivers/hv/hv_balloon.c | 94 ++++++++++++++++++++++++++++++++---------
 1 file changed, 73 insertions(+), 21 deletions(-)

diff --git a/drivers/hv/hv_balloon.c b/drivers/hv/hv_balloon.c
index fdf6decacf06..7088ed056e50 100644
--- a/drivers/hv/hv_balloon.c
+++ b/drivers/hv/hv_balloon.c
@@ -469,12 +469,16 @@ static bool do_hot_add;
  * the specified number of seconds.
  */
 static uint pressure_report_delay = 45;
+extern unsigned int page_reporting_order;
+#define HV_MAX_FAILURES	2
 
 /*
  * The last time we posted a pressure report to host.
  */
 static unsigned long last_post_time;
 
+static int hv_hypercall_multi_failure;
+
 module_param(hot_add, bool, (S_IRUGO | S_IWUSR));
 MODULE_PARM_DESC(hot_add, "If set attempt memory hot_add");
 
@@ -579,6 +583,10 @@ static struct hv_dynmem_device dm_device;
 
 static void post_status(struct hv_dynmem_device *dm);
 
+static void enable_page_reporting(void);
+
+static void disable_page_reporting(void);
+
 #ifdef CONFIG_MEMORY_HOTPLUG
 static inline bool has_pfn_is_backed(struct hv_hotadd_state *has,
 				     unsigned long pfn)
@@ -1418,6 +1426,18 @@ static int dm_thread_func(void *dm_dev)
 		 */
 		reinit_completion(&dm_device.config_event);
 		post_status(dm);
+		/*
+		 * disable free page reporting if multiple hypercall
+		 * failure flag set. It is not done in the page_reporting
+		 * callback context as that causes a deadlock between
+		 * page_reporting_process() and page_reporting_unregister()
+		 */
+		if (hv_hypercall_multi_failure >= HV_MAX_FAILURES) {
+			pr_err("Multiple failures in cold memory discard hypercall, disabling page reporting\n");
+			disable_page_reporting();
+			/* Reset the flag after disabling reporting */
+			hv_hypercall_multi_failure = 0;
+		}
 	}
 
 	return 0;
@@ -1593,20 +1613,20 @@ static void balloon_onchannelcallback(void *context)
 
 }
 
-/* Hyper-V only supports reporting 2MB pages or higher */
-#define HV_MIN_PAGE_REPORTING_ORDER	9
-#define HV_MIN_PAGE_REPORTING_LEN (HV_HYP_PAGE_SIZE << HV_MIN_PAGE_REPORTING_ORDER)
+#define HV_LARGE_REPORTING_ORDER	9
+#define HV_LARGE_REPORTING_LEN (HV_HYP_PAGE_SIZE << \
+		HV_LARGE_REPORTING_ORDER)
 static int hv_free_page_report(struct page_reporting_dev_info *pr_dev_info,
 		    struct scatterlist *sgl, unsigned int nents)
 {
 	unsigned long flags;
 	struct hv_memory_hint *hint;
-	int i;
+	int i, order;
 	u64 status;
 	struct scatterlist *sg;
 
 	WARN_ON_ONCE(nents > HV_MEMORY_HINT_MAX_GPA_PAGE_RANGES);
-	WARN_ON_ONCE(sgl->length < HV_MIN_PAGE_REPORTING_LEN);
+	WARN_ON_ONCE(sgl->length < (HV_HYP_PAGE_SIZE << page_reporting_order));
 	local_irq_save(flags);
 	hint = *(struct hv_memory_hint **)this_cpu_ptr(hyperv_pcpu_input_arg);
 	if (!hint) {
@@ -1621,21 +1641,53 @@ static int hv_free_page_report(struct page_reporting_dev_info *pr_dev_info,
 
 		range = &hint->ranges[i];
 		range->address_space = 0;
-		/* page reporting only reports 2MB pages or higher */
-		range->page.largepage = 1;
-		range->page.additional_pages =
-			(sg->length / HV_MIN_PAGE_REPORTING_LEN) - 1;
-		range->page_size = HV_GPA_PAGE_RANGE_PAGE_SIZE_2MB;
-		range->base_large_pfn =
-			page_to_hvpfn(sg_page(sg)) >> HV_MIN_PAGE_REPORTING_ORDER;
+		order = get_order(sg->length);
+		/*
+		 * Hyper-V expects the additional_pages field in the units
+		 * of one of these 3 sizes, 4Kbytes, 2Mbytes or 1Gbytes.
+		 * This is dictated by the values of the fields page.largesize
+		 * and page_size.
+		 * This code however, only uses 4Kbytes and 2Mbytes units
+		 * and not 1Gbytes unit.
+		 */
+
+		/* page reporting for pages 2MB or higher */
+		if (order >= HV_LARGE_REPORTING_ORDER ) {
+			range->page.largepage = 1;
+			range->page_size = HV_GPA_PAGE_RANGE_PAGE_SIZE_2MB;
+			range->base_large_pfn = page_to_hvpfn(
+					sg_page(sg)) >> HV_LARGE_REPORTING_ORDER;
+			range->page.additional_pages =
+				(sg->length / HV_LARGE_REPORTING_LEN) - 1;
+		} else {
+			/* Page reporting for pages below 2MB */
+			range->page.basepfn = page_to_hvpfn(sg_page(sg));
+			range->page.largepage = false;
+			range->page.additional_pages =
+				(sg->length / HV_HYP_PAGE_SIZE) - 1;
+		}
+
 	}
 
 	status = hv_do_rep_hypercall(HV_EXT_CALL_MEMORY_HEAT_HINT, nents, 0,
 				     hint, NULL);
 	local_irq_restore(flags);
-	if ((status & HV_HYPERCALL_RESULT_MASK) != HV_STATUS_SUCCESS) {
+	if (!hv_result_success(status)) {
+
 		pr_err("Cold memory discard hypercall failed with status %llx\n",
-			status);
+				status);
+		if (hv_hypercall_multi_failure > 0)
+			hv_hypercall_multi_failure++;
+
+		if (hv_result(status) == HV_STATUS_INVALID_PARAMETER) {
+			pr_err("Underlying Hyper-V does not support order less than 9. Hypercall failed\n");
+			pr_err("Defaulting to page_reporting_order %d\n",
+					pageblock_order);
+			page_reporting_order = pageblock_order;
+			hv_hypercall_multi_failure++;
+			return -EINVAL;
+		}
+
 		return -EINVAL;
 	}
 
@@ -1646,12 +1698,6 @@ static void enable_page_reporting(void)
 {
 	int ret;
 
-	/* Essentially, validating 'PAGE_REPORTING_MIN_ORDER' is big enough. */
-	if (pageblock_order < HV_MIN_PAGE_REPORTING_ORDER) {
-		pr_debug("Cold memory discard is only supported on 2MB pages and above\n");
-		return;
-	}
-
 	if (!hv_query_ext_cap(HV_EXT_CAPABILITY_MEMORY_COLD_DISCARD_HINT)) {
 		pr_debug("Cold memory discard hint not supported by Hyper-V\n");
 		return;
@@ -1659,12 +1705,18 @@ static void enable_page_reporting(void)
 
 	BUILD_BUG_ON(PAGE_REPORTING_CAPACITY > HV_MEMORY_HINT_MAX_GPA_PAGE_RANGES);
 	dm_device.pr_dev_info.report = hv_free_page_report;
+	/*
+	 * We let the page_reporting_order parameter decide the order
+	 * in the page_reporting code
+	 */
+	dm_device.pr_dev_info.order = 0;
 	ret = page_reporting_register(&dm_device.pr_dev_info);
 	if (ret < 0) {
 		dm_device.pr_dev_info.report = NULL;
 		pr_err("Failed to enable cold memory discard: %d\n", ret);
 	} else {
-		pr_info("Cold memory discard hint enabled\n");
+		pr_info("Cold memory discard hint enabled with order %d\n",
+				page_reporting_order);
 	}
 }
 
-- 
2.37.2

