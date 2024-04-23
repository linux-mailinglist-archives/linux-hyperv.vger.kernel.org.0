Return-Path: <linux-hyperv+bounces-2036-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 372CE8ADC2D
	for <lists+linux-hyperv@lfdr.de>; Tue, 23 Apr 2024 05:19:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2228D1C21255
	for <lists+linux-hyperv@lfdr.de>; Tue, 23 Apr 2024 03:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95BBB1BC26;
	Tue, 23 Apr 2024 03:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="J4ujlJ/4"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CF0318E1D;
	Tue, 23 Apr 2024 03:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713842338; cv=none; b=qk8NNo7FTaMY8TVGXzD9sP7Jjj7/T1OuvTYfdFB71XFW3kwHY2eeEN1VRpPAhbyyFzrnVSteJdOKtUw0tkUgU6oHivU7wM2KEeAEf9usUu85gJfKWE+7JfMIHRUE6DhCp56rZZQNPeo1vHYKv0vkPiu8n/KOTfJ7zQmU2CDzFrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713842338; c=relaxed/simple;
	bh=skEEO4kFgAczopC58RFqHys/Huw2qXQ5TOdygai9m8Y=;
	h=From:To:Cc:Subject:Date:Message-Id; b=AbMU3rLZEzhOOOkg9R8bAwObxkwfIMkPuwbHTJhwoGOFAig2UGTvF9hn2OiPsR4gESDAs56FqMi2axsWKXcg05tat+hUoPj0jzoxSwkbL7RpXsIdXTZivQFTj6qqo5bWvzaY7BNHDCmJ/ZqePhIu8T2Fkezo3gTe/VQKLxyvpaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=J4ujlJ/4; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1175)
	id 07F0320FF4E7; Mon, 22 Apr 2024 20:18:56 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 07F0320FF4E7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1713842336;
	bh=SfykjGU21KpWUT3oWGxO9sK6oF9flIGG1eXp5wVmNbw=;
	h=From:To:Cc:Subject:Date:From;
	b=J4ujlJ/4TwDKpBZXR9CO3q6TLnGvNgGuBcU2qpoh9X1yDwQd4+f+R2vVq4emk2h30
	 fFchOHeQ55Q08g4QIJsLdKVd/20efuuZBrJyCht9KUnG5LzCVvnifVpBrMTKfbuouG
	 FWn22kBUcggUuoPbipKZ8ByqJs/nd6OHTbO1WjJY=
From: Aditya Nagesh <adityanagesh@linux.microsoft.com>
To: adityanagesh@microsoft.com,
	kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Aditya Nagesh <adityanagesh@linux.microsoft.com>
Subject: [PATCH v4] Drivers: hv: Cosmetic changes for hv.c and balloon.c
Date: Mon, 22 Apr 2024 20:18:46 -0700
Message-Id: <1713842326-25576-1-git-send-email-adityanagesh@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Fix issues reported by checkpatch.pl script in hv.c and
balloon.c
 - Remove unnecessary parentheses
 - Remove extra newlines
 - Remove extra spaces
 - Add spaces between comparison operators
 - Remove comparison with NULL in if statements

No functional changes intended

Signed-off-by: Aditya Nagesh <adityanagesh@linux.microsoft.com>
Reviewed-by: Saurabh Sengar <ssengar@linux.microsoft.com>
---
[V4]
Fix Alignment issue and revert a line since 100 characters are allowed in a line

[V3]
Fix alignment issues in multiline function parameters.

[V2]
Change Subject from "Drivers: hv: Fix Issues reported by checkpatch.pl script"
 to "Drivers: hv: Cosmetic changes for hv.c and balloon.c"

 drivers/hv/hv.c         |  37 +++++++--------
 drivers/hv/hv_balloon.c | 102 +++++++++++++++-------------------------
 2 files changed, 55 insertions(+), 84 deletions(-)

diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
index a8ad728354cb..e0d676c74f14 100644
--- a/drivers/hv/hv.c
+++ b/drivers/hv/hv.c
@@ -45,8 +45,8 @@ int hv_init(void)
  * This involves a hypercall.
  */
 int hv_post_message(union hv_connection_id connection_id,
-		  enum hv_message_type message_type,
-		  void *payload, size_t payload_size)
+			enum hv_message_type message_type,
+			void *payload, size_t payload_size)
 {
 	struct hv_input_post_message *aligned_msg;
 	unsigned long flags;
@@ -86,7 +86,7 @@ int hv_post_message(union hv_connection_id connection_id,
 			status = HV_STATUS_INVALID_PARAMETER;
 	} else {
 		status = hv_do_hypercall(HVCALL_POST_MESSAGE,
-				aligned_msg, NULL);
+					 aligned_msg, NULL);
 	}
 
 	local_irq_restore(flags);
@@ -111,7 +111,7 @@ int hv_synic_alloc(void)
 
 	hv_context.hv_numa_map = kcalloc(nr_node_ids, sizeof(struct cpumask),
 					 GFP_KERNEL);
-	if (hv_context.hv_numa_map == NULL) {
+	if (!hv_context.hv_numa_map) {
 		pr_err("Unable to allocate NUMA map\n");
 		goto err;
 	}
@@ -120,11 +120,11 @@ int hv_synic_alloc(void)
 		hv_cpu = per_cpu_ptr(hv_context.cpu_context, cpu);
 
 		tasklet_init(&hv_cpu->msg_dpc,
-			     vmbus_on_msg_dpc, (unsigned long) hv_cpu);
+			     vmbus_on_msg_dpc, (unsigned long)hv_cpu);
 
 		if (ms_hyperv.paravisor_present && hv_isolation_type_tdx()) {
 			hv_cpu->post_msg_page = (void *)get_zeroed_page(GFP_ATOMIC);
-			if (hv_cpu->post_msg_page == NULL) {
+			if (!hv_cpu->post_msg_page) {
 				pr_err("Unable to allocate post msg page\n");
 				goto err;
 			}
@@ -147,14 +147,14 @@ int hv_synic_alloc(void)
 		if (!ms_hyperv.paravisor_present && !hv_root_partition) {
 			hv_cpu->synic_message_page =
 				(void *)get_zeroed_page(GFP_ATOMIC);
-			if (hv_cpu->synic_message_page == NULL) {
+			if (!hv_cpu->synic_message_page) {
 				pr_err("Unable to allocate SYNIC message page\n");
 				goto err;
 			}
 
 			hv_cpu->synic_event_page =
 				(void *)get_zeroed_page(GFP_ATOMIC);
-			if (hv_cpu->synic_event_page == NULL) {
+			if (!hv_cpu->synic_event_page) {
 				pr_err("Unable to allocate SYNIC event page\n");
 
 				free_page((unsigned long)hv_cpu->synic_message_page);
@@ -203,14 +203,13 @@ int hv_synic_alloc(void)
 	return ret;
 }
 
-
 void hv_synic_free(void)
 {
 	int cpu, ret;
 
 	for_each_present_cpu(cpu) {
-		struct hv_per_cpu_context *hv_cpu
-			= per_cpu_ptr(hv_context.cpu_context, cpu);
+		struct hv_per_cpu_context *hv_cpu =
+			per_cpu_ptr(hv_context.cpu_context, cpu);
 
 		/* It's better to leak the page if the encryption fails. */
 		if (ms_hyperv.paravisor_present && hv_isolation_type_tdx()) {
@@ -262,8 +261,8 @@ void hv_synic_free(void)
  */
 void hv_synic_enable_regs(unsigned int cpu)
 {
-	struct hv_per_cpu_context *hv_cpu
-		= per_cpu_ptr(hv_context.cpu_context, cpu);
+	struct hv_per_cpu_context *hv_cpu =
+		per_cpu_ptr(hv_context.cpu_context, cpu);
 	union hv_synic_simp simp;
 	union hv_synic_siefp siefp;
 	union hv_synic_sint shared_sint;
@@ -277,8 +276,8 @@ void hv_synic_enable_regs(unsigned int cpu)
 		/* Mask out vTOM bit. ioremap_cache() maps decrypted */
 		u64 base = (simp.base_simp_gpa << HV_HYP_PAGE_SHIFT) &
 				~ms_hyperv.shared_gpa_boundary;
-		hv_cpu->synic_message_page
-			= (void *)ioremap_cache(base, HV_HYP_PAGE_SIZE);
+		hv_cpu->synic_message_page =
+			(void *)ioremap_cache(base, HV_HYP_PAGE_SIZE);
 		if (!hv_cpu->synic_message_page)
 			pr_err("Fail to map synic message page.\n");
 	} else {
@@ -296,8 +295,8 @@ void hv_synic_enable_regs(unsigned int cpu)
 		/* Mask out vTOM bit. ioremap_cache() maps decrypted */
 		u64 base = (siefp.base_siefp_gpa << HV_HYP_PAGE_SHIFT) &
 				~ms_hyperv.shared_gpa_boundary;
-		hv_cpu->synic_event_page
-			= (void *)ioremap_cache(base, HV_HYP_PAGE_SIZE);
+		hv_cpu->synic_event_page =
+			(void *)ioremap_cache(base, HV_HYP_PAGE_SIZE);
 		if (!hv_cpu->synic_event_page)
 			pr_err("Fail to map synic event page.\n");
 	} else {
@@ -348,8 +347,8 @@ int hv_synic_init(unsigned int cpu)
  */
 void hv_synic_disable_regs(unsigned int cpu)
 {
-	struct hv_per_cpu_context *hv_cpu
-		= per_cpu_ptr(hv_context.cpu_context, cpu);
+	struct hv_per_cpu_context *hv_cpu =
+		per_cpu_ptr(hv_context.cpu_context, cpu);
 	union hv_synic_sint shared_sint;
 	union hv_synic_simp simp;
 	union hv_synic_siefp siefp;
diff --git a/drivers/hv/hv_balloon.c b/drivers/hv/hv_balloon.c
index e000fa3b9f97..c3c16756a0fb 100644
--- a/drivers/hv/hv_balloon.c
+++ b/drivers/hv/hv_balloon.c
@@ -41,8 +41,6 @@
  * Begin protocol definitions.
  */
 
-
-
 /*
  * Protocol versions. The low word is the minor version, the high word the major
  * version.
@@ -71,8 +69,6 @@ enum {
 	DYNMEM_PROTOCOL_VERSION_CURRENT = DYNMEM_PROTOCOL_VERSION_WIN10
 };
 
-
-
 /*
  * Message Types
  */
@@ -101,7 +97,6 @@ enum dm_message_type {
 	DM_VERSION_1_MAX		= 12
 };
 
-
 /*
  * Structures defining the dynamic memory management
  * protocol.
@@ -115,7 +110,6 @@ union dm_version {
 	__u32 version;
 } __packed;
 
-
 union dm_caps {
 	struct {
 		__u64 balloon:1;
@@ -148,8 +142,6 @@ union dm_mem_page_range {
 	__u64  page_range;
 } __packed;
 
-
-
 /*
  * The header for all dynamic memory messages:
  *
@@ -174,7 +166,6 @@ struct dm_message {
 	__u8 data[]; /* enclosed message */
 } __packed;
 
-
 /*
  * Specific message types supporting the dynamic memory protocol.
  */
@@ -271,7 +262,6 @@ struct dm_status {
 	__u32 io_diff;
 } __packed;
 
-
 /*
  * Message to ask the guest to allocate memory - balloon up message.
  * This message is sent from the host to the guest. The guest may not be
@@ -286,14 +276,13 @@ struct dm_balloon {
 	__u32 reservedz;
 } __packed;
 
-
 /*
  * Balloon response message; this message is sent from the guest
  * to the host in response to the balloon message.
  *
  * reservedz: Reserved; must be set to zero.
  * more_pages: If FALSE, this is the last message of the transaction.
- * if TRUE there will atleast one more message from the guest.
+ * if TRUE there will be at least one more message from the guest.
  *
  * range_count: The number of ranges in the range array.
  *
@@ -314,7 +303,7 @@ struct dm_balloon_response {
  * to the guest to give guest more memory.
  *
  * more_pages: If FALSE, this is the last message of the transaction.
- * if TRUE there will atleast one more message from the guest.
+ * if TRUE there will be at least one more message from the guest.
  *
  * reservedz: Reserved; must be set to zero.
  *
@@ -342,7 +331,6 @@ struct dm_unballoon_response {
 	struct dm_header hdr;
 } __packed;
 
-
 /*
  * Hot add request message. Message sent from the host to the guest.
  *
@@ -390,7 +378,6 @@ enum dm_info_type {
 	MAX_INFO_TYPE
 };
 
-
 /*
  * Header for the information message.
  */
@@ -480,10 +467,10 @@ static unsigned long last_post_time;
 
 static int hv_hypercall_multi_failure;
 
-module_param(hot_add, bool, (S_IRUGO | S_IWUSR));
+module_param(hot_add, bool, 0644);
 MODULE_PARM_DESC(hot_add, "If set attempt memory hot_add");
 
-module_param(pressure_report_delay, uint, (S_IRUGO | S_IWUSR));
+module_param(pressure_report_delay, uint, 0644);
 MODULE_PARM_DESC(pressure_report_delay, "Delay in secs in reporting pressure");
 static atomic_t trans_id = ATOMIC_INIT(0);
 
@@ -502,7 +489,6 @@ enum hv_dm_state {
 	DM_INIT_ERROR
 };
 
-
 static __u8 recv_buffer[HV_HYP_PAGE_SIZE];
 static __u8 balloon_up_send_buffer[HV_HYP_PAGE_SIZE];
 #define PAGES_IN_2M (2 * 1024 * 1024 / PAGE_SIZE)
@@ -595,12 +581,12 @@ static inline bool has_pfn_is_backed(struct hv_hotadd_state *has,
 	struct hv_hotadd_gap *gap;
 
 	/* The page is not backed. */
-	if ((pfn < has->covered_start_pfn) || (pfn >= has->covered_end_pfn))
+	if (pfn < has->covered_start_pfn || pfn >= has->covered_end_pfn)
 		return false;
 
 	/* Check for gaps. */
 	list_for_each_entry(gap, &has->gap_list, list) {
-		if ((pfn >= gap->start_pfn) && (pfn < gap->end_pfn))
+		if (pfn >= gap->start_pfn && pfn < gap->end_pfn)
 			return false;
 	}
 
@@ -724,7 +710,7 @@ static void hv_mem_hot_add(unsigned long start, unsigned long size,
 	unsigned long processed_pfn;
 	unsigned long total_pfn = pfn_count;
 
-	for (i = 0; i < (size/HA_CHUNK); i++) {
+	for (i = 0; i < (size / HA_CHUNK); i++) {
 		start_pfn = start + (i * HA_CHUNK);
 
 		scoped_guard(spinlock_irqsave, &dm_device.ha_lock) {
@@ -745,7 +731,7 @@ static void hv_mem_hot_add(unsigned long start, unsigned long size,
 
 		nid = memory_add_physaddr_to_nid(PFN_PHYS(start_pfn));
 		ret = add_memory(nid, PFN_PHYS((start_pfn)),
-				(HA_CHUNK << PAGE_SHIFT), MHP_MERGE_RESOURCE);
+				 (HA_CHUNK << PAGE_SHIFT), MHP_MERGE_RESOURCE);
 
 		if (ret) {
 			pr_err("hot_add memory failed error is %d\n", ret);
@@ -787,8 +773,8 @@ static void hv_online_page(struct page *pg, unsigned int order)
 	guard(spinlock_irqsave)(&dm_device.ha_lock);
 	list_for_each_entry(has, &dm_device.ha_region_list, list) {
 		/* The page belongs to a different HAS. */
-		if ((pfn < has->start_pfn) ||
-				(pfn + (1UL << order) > has->end_pfn))
+		if (pfn < has->start_pfn ||
+		    (pfn + (1UL << order) > has->end_pfn))
 			continue;
 
 		hv_bring_pgs_online(has, pfn, 1UL << order);
@@ -855,7 +841,7 @@ static int pfn_covered(unsigned long start_pfn, unsigned long pfn_cnt)
 }
 
 static unsigned long handle_pg_range(unsigned long pg_start,
-					unsigned long pg_count)
+				     unsigned long pg_count)
 {
 	unsigned long start_pfn = pg_start;
 	unsigned long pfn_cnt = pg_count;
@@ -866,7 +852,7 @@ static unsigned long handle_pg_range(unsigned long pg_start,
 	unsigned long res = 0, flags;
 
 	pr_debug("Hot adding %lu pages starting at pfn 0x%lx.\n", pg_count,
-		pg_start);
+		 pg_start);
 
 	spin_lock_irqsave(&dm_device.ha_lock, flags);
 	list_for_each_entry(has, &dm_device.ha_region_list, list) {
@@ -902,10 +888,9 @@ static unsigned long handle_pg_range(unsigned long pg_start,
 			if (start_pfn > has->start_pfn &&
 			    online_section_nr(pfn_to_section_nr(start_pfn)))
 				hv_bring_pgs_online(has, start_pfn, pgs_ol);
-
 		}
 
-		if ((has->ha_end_pfn < has->end_pfn) && (pfn_cnt > 0)) {
+		if (has->ha_end_pfn < has->end_pfn && pfn_cnt > 0) {
 			/*
 			 * We have some residual hot add range
 			 * that needs to be hot added; hot add
@@ -1010,7 +995,7 @@ static void hot_add_req(struct work_struct *dummy)
 	rg_start = dm->ha_wrk.ha_region_range.finfo.start_page;
 	rg_sz = dm->ha_wrk.ha_region_range.finfo.page_cnt;
 
-	if ((rg_start == 0) && (!dm->host_specified_ha_region)) {
+	if (rg_start == 0 && !dm->host_specified_ha_region) {
 		unsigned long region_size;
 		unsigned long region_start;
 
@@ -1033,7 +1018,7 @@ static void hot_add_req(struct work_struct *dummy)
 
 	if (do_hot_add)
 		resp.page_count = process_hot_add(pg_start, pfn_cnt,
-						rg_start, rg_sz);
+						  rg_start, rg_sz);
 
 	dm->num_pages_added += resp.page_count;
 #endif
@@ -1211,11 +1196,10 @@ static void post_status(struct hv_dynmem_device *dm)
 				sizeof(struct dm_status),
 				(unsigned long)NULL,
 				VM_PKT_DATA_INBAND, 0);
-
 }
 
 static void free_balloon_pages(struct hv_dynmem_device *dm,
-			 union dm_mem_page_range *range_array)
+			       union dm_mem_page_range *range_array)
 {
 	int num_pages = range_array->finfo.page_cnt;
 	__u64 start_frame = range_array->finfo.start_page;
@@ -1231,8 +1215,6 @@ static void free_balloon_pages(struct hv_dynmem_device *dm,
 	}
 }
 
-
-
 static unsigned int alloc_balloon_pages(struct hv_dynmem_device *dm,
 					unsigned int num_pages,
 					struct dm_balloon_response *bl_resp,
@@ -1278,7 +1260,6 @@ static unsigned int alloc_balloon_pages(struct hv_dynmem_device *dm,
 			page_to_pfn(pg);
 		bl_resp->range_array[i].finfo.page_cnt = alloc_unit;
 		bl_resp->hdr.size += sizeof(union dm_mem_page_range);
-
 	}
 
 	return i * alloc_unit;
@@ -1332,7 +1313,7 @@ static void balloon_up(struct work_struct *dummy)
 
 		if (num_ballooned == 0 || num_ballooned == num_pages) {
 			pr_debug("Ballooned %u out of %u requested pages.\n",
-				num_pages, dm_device.balloon_wrk.num_pages);
+				 num_pages, dm_device.balloon_wrk.num_pages);
 
 			bl_resp->more_pages = 0;
 			done = true;
@@ -1366,16 +1347,15 @@ static void balloon_up(struct work_struct *dummy)
 
 			for (i = 0; i < bl_resp->range_count; i++)
 				free_balloon_pages(&dm_device,
-						 &bl_resp->range_array[i]);
+						   &bl_resp->range_array[i]);
 
 			done = true;
 		}
 	}
-
 }
 
 static void balloon_down(struct hv_dynmem_device *dm,
-			struct dm_unballoon_request *req)
+			 struct dm_unballoon_request *req)
 {
 	union dm_mem_page_range *range_array = req->range_array;
 	int range_count = req->range_count;
@@ -1389,7 +1369,7 @@ static void balloon_down(struct hv_dynmem_device *dm,
 	}
 
 	pr_debug("Freed %u ballooned pages.\n",
-		prev_pages_ballooned - dm->num_pages_ballooned);
+		 prev_pages_ballooned - dm->num_pages_ballooned);
 
 	if (req->more_pages == 1)
 		return;
@@ -1414,8 +1394,7 @@ static int dm_thread_func(void *dm_dev)
 	struct hv_dynmem_device *dm = dm_dev;
 
 	while (!kthread_should_stop()) {
-		wait_for_completion_interruptible_timeout(
-						&dm_device.config_event, 1*HZ);
+		wait_for_completion_interruptible_timeout(&dm_device.config_event, 1 * HZ);
 		/*
 		 * The host expects us to post information on the memory
 		 * pressure every second.
@@ -1439,9 +1418,8 @@ static int dm_thread_func(void *dm_dev)
 	return 0;
 }
 
-
 static void version_resp(struct hv_dynmem_device *dm,
-			struct dm_version_response *vresp)
+			 struct dm_version_response *vresp)
 {
 	struct dm_version_request version_req;
 	int ret;
@@ -1502,7 +1480,7 @@ static void version_resp(struct hv_dynmem_device *dm,
 }
 
 static void cap_resp(struct hv_dynmem_device *dm,
-			struct dm_capabilities_resp_msg *cap_resp)
+		     struct dm_capabilities_resp_msg *cap_resp)
 {
 	if (!cap_resp->is_accepted) {
 		pr_err("Capabilities not accepted by host\n");
@@ -1535,7 +1513,7 @@ static void balloon_onchannelcallback(void *context)
 		switch (dm_hdr->type) {
 		case DM_VERSION_RESPONSE:
 			version_resp(dm,
-				 (struct dm_version_response *)dm_msg);
+				     (struct dm_version_response *)dm_msg);
 			break;
 
 		case DM_CAPABILITIES_RESPONSE:
@@ -1565,7 +1543,7 @@ static void balloon_onchannelcallback(void *context)
 
 			dm->state = DM_BALLOON_DOWN;
 			balloon_down(dm,
-				 (struct dm_unballoon_request *)recv_buffer);
+				     (struct dm_unballoon_request *)recv_buffer);
 			break;
 
 		case DM_MEM_HOT_ADD_REQUEST:
@@ -1603,17 +1581,15 @@ static void balloon_onchannelcallback(void *context)
 
 		default:
 			pr_warn_ratelimited("Unhandled message: type: %d\n", dm_hdr->type);
-
 		}
 	}
-
 }
 
 #define HV_LARGE_REPORTING_ORDER	9
 #define HV_LARGE_REPORTING_LEN (HV_HYP_PAGE_SIZE << \
 		HV_LARGE_REPORTING_ORDER)
 static int hv_free_page_report(struct page_reporting_dev_info *pr_dev_info,
-		    struct scatterlist *sgl, unsigned int nents)
+			       struct scatterlist *sgl, unsigned int nents)
 {
 	unsigned long flags;
 	struct hv_memory_hint *hint;
@@ -1648,7 +1624,7 @@ static int hv_free_page_report(struct page_reporting_dev_info *pr_dev_info,
 		 */
 
 		/* page reporting for pages 2MB or higher */
-		if (order >= HV_LARGE_REPORTING_ORDER ) {
+		if (order >= HV_LARGE_REPORTING_ORDER) {
 			range->page.largepage = 1;
 			range->page_size = HV_GPA_PAGE_RANGE_PAGE_SIZE_2MB;
 			range->base_large_pfn = page_to_hvpfn(
@@ -1662,23 +1638,21 @@ static int hv_free_page_report(struct page_reporting_dev_info *pr_dev_info,
 			range->page.additional_pages =
 				(sg->length / HV_HYP_PAGE_SIZE) - 1;
 		}
-
 	}
 
 	status = hv_do_rep_hypercall(HV_EXT_CALL_MEMORY_HEAT_HINT, nents, 0,
 				     hint, NULL);
 	local_irq_restore(flags);
 	if (!hv_result_success(status)) {
-
 		pr_err("Cold memory discard hypercall failed with status %llx\n",
-				status);
+		       status);
 		if (hv_hypercall_multi_failure > 0)
 			hv_hypercall_multi_failure++;
 
 		if (hv_result(status) == HV_STATUS_INVALID_PARAMETER) {
 			pr_err("Underlying Hyper-V does not support order less than 9. Hypercall failed\n");
 			pr_err("Defaulting to page_reporting_order %d\n",
-					pageblock_order);
+			       pageblock_order);
 			page_reporting_order = pageblock_order;
 			hv_hypercall_multi_failure++;
 			return -EINVAL;
@@ -1712,7 +1686,7 @@ static void enable_page_reporting(void)
 		pr_err("Failed to enable cold memory discard: %d\n", ret);
 	} else {
 		pr_info("Cold memory discard hint enabled with order %d\n",
-				page_reporting_order);
+			page_reporting_order);
 	}
 }
 
@@ -1795,7 +1769,7 @@ static int balloon_connect_vsp(struct hv_device *dev)
 	if (ret)
 		goto out;
 
-	t = wait_for_completion_timeout(&dm_device.host_event, 5*HZ);
+	t = wait_for_completion_timeout(&dm_device.host_event, 5 * HZ);
 	if (t == 0) {
 		ret = -ETIMEDOUT;
 		goto out;
@@ -1850,7 +1824,7 @@ static int balloon_connect_vsp(struct hv_device *dev)
 	if (ret)
 		goto out;
 
-	t = wait_for_completion_timeout(&dm_device.host_event, 5*HZ);
+	t = wait_for_completion_timeout(&dm_device.host_event, 5 * HZ);
 	if (t == 0) {
 		ret = -ETIMEDOUT;
 		goto out;
@@ -1891,8 +1865,8 @@ static int hv_balloon_debug_show(struct seq_file *f, void *offset)
 	char *sname;
 
 	seq_printf(f, "%-22s: %u.%u\n", "host_version",
-				DYNMEM_MAJOR_VERSION(dm->version),
-				DYNMEM_MINOR_VERSION(dm->version));
+			DYNMEM_MAJOR_VERSION(dm->version),
+			DYNMEM_MINOR_VERSION(dm->version));
 
 	seq_printf(f, "%-22s:", "capabilities");
 	if (ballooning_enabled())
@@ -1941,10 +1915,10 @@ static int hv_balloon_debug_show(struct seq_file *f, void *offset)
 	seq_printf(f, "%-22s: %u\n", "pages_ballooned", dm->num_pages_ballooned);
 
 	seq_printf(f, "%-22s: %lu\n", "total_pages_committed",
-				get_pages_committed(dm));
+		   get_pages_committed(dm));
 
 	seq_printf(f, "%-22s: %llu\n", "max_dynamic_page_count",
-				dm->max_dynamic_page_count);
+		   dm->max_dynamic_page_count);
 
 	return 0;
 }
@@ -1954,7 +1928,7 @@ DEFINE_SHOW_ATTRIBUTE(hv_balloon_debug);
 static void  hv_balloon_debugfs_init(struct hv_dynmem_device *b)
 {
 	debugfs_create_file("hv-balloon", 0444, NULL, b,
-			&hv_balloon_debug_fops);
+			    &hv_balloon_debug_fops);
 }
 
 static void  hv_balloon_debugfs_exit(struct hv_dynmem_device *b)
@@ -2097,7 +2071,6 @@ static int balloon_suspend(struct hv_device *hv_dev)
 	tasklet_enable(&hv_dev->channel->callback_event);
 
 	return 0;
-
 }
 
 static int balloon_resume(struct hv_device *dev)
@@ -2156,7 +2129,6 @@ static  struct hv_driver balloon_drv = {
 
 static int __init init_balloon_drv(void)
 {
-
 	return vmbus_driver_register(&balloon_drv);
 }
 
-- 
2.34.1


