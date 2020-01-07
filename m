Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 11A7B13273E
	for <lists+linux-hyperv@lfdr.de>; Tue,  7 Jan 2020 14:11:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728115AbgAGNKc (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 7 Jan 2020 08:10:32 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37529 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727814AbgAGNKc (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 7 Jan 2020 08:10:32 -0500
Received: by mail-pg1-f193.google.com with SMTP id q127so28498407pga.4;
        Tue, 07 Jan 2020 05:10:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=v3pmTcy6qEJwh7e7FysvKYAmuT6y5pD3iMM4o529XwI=;
        b=YHJyLQq4t57RCkW3gxsrusuYhs5F9mArMG0Vhvkr1tkC65aaC9rZUfZQ/qUjxr1WKc
         hv94sJEDQQ9tGQjBtmsWdliwIQMRqr6sj4SN6G7Yhl0oNkuGVaZJLMsG7NmducH+gFC7
         sX79HA4XT9sRBGKZGi8VfUif9TuycwwRhrEJnB2UYOR6pHfgXY26m2qONHEkU3tcXvb1
         PMi5MAMa+U31YjgI1Zo6ssOVruHa5uS2LaCjWD21qom/6g2YcEf4+1TnHwhoATFMsDJS
         ++aGUzinOqg6lqZOqXAEm4iaX40RFfjeV8mAOlFmrB1uI3uRdDaPDECyTDIhaCbb1hXX
         2ESg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=v3pmTcy6qEJwh7e7FysvKYAmuT6y5pD3iMM4o529XwI=;
        b=NR6D0m1ibp9KbkLyrVAhMdON057Tq9gGGmcY+UGga8iqpx00YkOluBDHEdI/kSOzbE
         EhzatDMXeweRaDwvn4PgPglpZ/gwK2KZIqHa2eOdNC02wsMrzHzSnLFYpuyO+Ty0GM7F
         O94m56ZEIl1nNeBvY+sCLNdg2Dtd0d8U4TJ8wg4z/VUC2dtn70YYOnTLdKlDJp/m31dz
         w+q2tV44nyPg6Afq2pAUpd0+1J6Qot4gWBuO0HwjngDtChFACwfWgN3CHETVT8DOr/SX
         RhWgP+hOd4PvVMK1K68qSBRHG1B2tnA2h9DtjBXUttNIBQE2aHZrMaci9oRyMipWE6gk
         2HrA==
X-Gm-Message-State: APjAAAXwNiyLjfUl4tXlgtok8a3RxiWoXxcsYfU9J91ca1ZsClcotKMC
        bawjmXKQWsgJksFvDyPWvkEd4zJwsHc=
X-Google-Smtp-Source: APXvYqxajOJXvcFFiotYF1Pmrbxc9vj2IYQDtwAWsxNiZTaHmcDk2t1OZ7sfb3pEvWzsIW00qnlxQg==
X-Received: by 2002:a63:950c:: with SMTP id p12mr117626365pgd.85.1578402630573;
        Tue, 07 Jan 2020 05:10:30 -0800 (PST)
Received: from localhost.corp.microsoft.com ([167.220.255.5])
        by smtp.googlemail.com with ESMTPSA id m71sm27522400pje.0.2020.01.07.05.10.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 Jan 2020 05:10:29 -0800 (PST)
From:   lantianyu1986@gmail.com
X-Google-Original-From: Tianyu.Lan@microsoft.com
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        sashal@kernel.org, michael.h.kelley@microsoft.com, david@redhat.com
Cc:     Tianyu Lan <Tianyu.Lan@microsoft.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        vkuznets@redhat.com, eric.devolder@oracle.com
Subject: [RFC PATCH V2 7/10] x86/Hyper-V/Balloon: Handle mem hot-remove request
Date:   Tue,  7 Jan 2020 21:09:47 +0800
Message-Id: <20200107130950.2983-8-Tianyu.Lan@microsoft.com>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20200107130950.2983-1-Tianyu.Lan@microsoft.com>
References: <20200107130950.2983-1-Tianyu.Lan@microsoft.com>
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Tianyu Lan <Tianyu.Lan@microsoft.com>

Linux system mem hot plug unit is 128MB and request page
number maybe not aligned with unit. The non-aligned case
will handle in the later.

Handle mem hot-remve request:
First, search memory from ha region list. If find suitable memory
block, offline & remove memory and create ha region region "gap"
struct for the range. "gap" means the range in the hot-add region
is offlined or removed. The following mem hot-add msg may add
memory in the gap range back.

If there is no suitable memory in the hot-add region, search memory
from the system memory on the target node and perform offline&remove
memory.

Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
---
 drivers/hv/hv_balloon.c | 188 ++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 184 insertions(+), 4 deletions(-)

diff --git a/drivers/hv/hv_balloon.c b/drivers/hv/hv_balloon.c
index 43e490f492d5..3d8c09fe148a 100644
--- a/drivers/hv/hv_balloon.c
+++ b/drivers/hv/hv_balloon.c
@@ -56,6 +56,10 @@
 #define DYNMEM_MAJOR_VERSION(Version) ((__u32)(Version) >> 16)
 #define DYNMEM_MINOR_VERSION(Version) ((__u32)(Version) & 0xff)
 
+#define MAX_HOT_REMOVE_ENTRIES						\
+		((PAGE_SIZE - sizeof(struct dm_hot_remove_response))	\
+		 / sizeof(union dm_mem_page_range))
+
 enum {
 	DYNMEM_PROTOCOL_VERSION_1 = DYNMEM_MAKE_VERSION(0, 3),
 	DYNMEM_PROTOCOL_VERSION_2 = DYNMEM_MAKE_VERSION(1, 0),
@@ -697,6 +701,7 @@ static int hv_memory_notifier(struct notifier_block *nb, unsigned long val,
 {
 	struct memory_notify *mem = (struct memory_notify *)v;
 	unsigned long pfn_count;
+	int need_unlock;
 
 	switch (val) {
 	case MEM_ONLINE:
@@ -708,7 +713,11 @@ static int hv_memory_notifier(struct notifier_block *nb, unsigned long val,
 		break;
 
 	case MEM_OFFLINE:
-		mutex_lock(&dm_device.ha_lock);
+		if (dm_device.lock_thread != current) {
+			mutex_lock(&dm_device.ha_lock);
+			need_unlock = 1;
+		}
+
 		pfn_count = hv_page_offline_check(mem->start_pfn,
 						  mem->nr_pages);
 		if (pfn_count <= dm_device.num_pages_onlined) {
@@ -722,7 +731,9 @@ static int hv_memory_notifier(struct notifier_block *nb, unsigned long val,
 			WARN_ON_ONCE(1);
 			dm_device.num_pages_onlined = 0;
 		}
-		mutex_unlock(&dm_device.ha_lock);
+
+		if (need_unlock)
+			mutex_unlock(&dm_device.ha_lock);
 		break;
 	case MEM_GOING_ONLINE:
 	case MEM_GOING_OFFLINE:
@@ -1046,14 +1057,183 @@ static unsigned long process_hot_add(unsigned long pg_start,
 	return handle_pg_range(pg_start, pfn_cnt);
 }
 
+static int hv_hot_remove_range(unsigned int nid, unsigned long start_pfn,
+			       unsigned long end_pfn, unsigned long nr_pages,
+			       unsigned long *request_index,
+			       union dm_mem_page_range *range_array,
+			       struct hv_hotadd_state *has)
+{
+	unsigned long block_pages = HA_CHUNK;
+	unsigned long rm_pages = nr_pages;
+	unsigned long pfn;
+	int ret;
+
+	for (pfn = start_pfn; pfn < end_pfn; pfn += block_pages) {
+		struct hv_hotadd_gap *gap;
+		int in_gap;
+
+		if (*request_index >= MAX_HOT_REMOVE_ENTRIES) {
+			struct dm_hot_remove_response *resp =
+				(struct dm_hot_remove_response *)
+					balloon_up_send_buffer;
+
+			/* Flush out all hot-remove ranges. */
+			ret = hv_send_hot_remove_response(resp, *request_index,
+							  true);
+			if (ret)
+				return ret;
+
+			/* Reset request buffer. */
+			memset(resp, 0x00, PAGE_SIZE);
+			*request_index = 0;
+		}
+
+		/*
+		 * Memory in hot-add region gaps has been offlined or removed
+		 * and so skip it if remove range overlap with gap.
+		 */
+		if (has) {
+			list_for_each_entry(gap, &has->gap_list, list)
+				if (!(pfn >= gap->end_pfn ||
+				      pfn + block_pages < gap->start_pfn)) {
+					in_gap = 1;
+					break;
+				}
+
+			if (in_gap)
+				continue;
+		}
+
+		if (online_section_nr(pfn_to_section_nr(pfn))
+		    && is_mem_section_removable(pfn, block_pages)) {
+			ret = offline_and_remove_memory(nid, pfn << PAGE_SHIFT,
+					block_pages << PAGE_SHIFT);
+			if (ret)
+				continue;
+
+			range_array[*request_index].finfo.start_page = pfn;
+			range_array[*request_index].finfo.page_cnt
+					= block_pages;
+
+			(*request_index)++;
+			nr_pages -= block_pages;
+
+			if (!nr_pages)
+				break;
+		}
+	}
+
+	return rm_pages - nr_pages;
+}
+
+static int hv_hot_remove_from_ha_list(unsigned int nid, unsigned long nr_pages,
+				      unsigned long *request_index,
+				      union dm_mem_page_range *range_array)
+{
+	struct hv_hotadd_state *has;
+	unsigned long start_pfn, end_pfn;
+	int rm_pages;
+	int old_index;
+	int ret, i;
+
+	mutex_lock(&dm_device.ha_lock);
+	dm_device.lock_thread = current;
+	list_for_each_entry(has, &dm_device.ha_region_list, list) {
+		rm_pages = min(nr_pages,
+				has->covered_end_pfn - has->start_pfn);
+		start_pfn = has->start_pfn;
+		end_pfn = has->covered_end_pfn;
+		old_index = *request_index;
+
+		if (!rm_pages || pfn_to_nid(start_pfn) != nid)
+			continue;
+
+		rm_pages = hv_hot_remove_range(nid, start_pfn, end_pfn,
+				rm_pages, request_index, range_array, has);
+		if (rm_pages < 0) {
+			ret = rm_pages;
+			goto error;
+		} else if (!rm_pages) {
+			continue;
+		}
+
+		nr_pages -= rm_pages;
+		dm_device.num_pages_added -= rm_pages;
+
+		/* Create gaps for hot remove regions. */
+		for (i = old_index; i < *request_index; i++) {
+			struct hv_hotadd_gap *gap;
+
+			gap = kzalloc(sizeof(struct hv_hotadd_gap), GFP_ATOMIC);
+			if (!gap) {
+				/*
+				 * Disable dm hot-plug when fails to allocate
+				 * memory for gaps.
+				 */
+				ret = -ENOMEM;
+				do_hot_add = false;
+				goto error;
+			}
+
+			INIT_LIST_HEAD(&gap->list);
+			gap->start_pfn = range_array[i].finfo.start_page;
+			gap->end_pfn =
+				gap->start_pfn + range_array[i].finfo.page_cnt;
+			list_add_tail(&gap->list, &has->gap_list);
+		}
+
+		if (!nr_pages)
+			break;
+	}
+
+	ret = nr_pages;
+ error:
+	dm_device.lock_thread = NULL;
+	mutex_unlock(&dm_device.ha_lock);
+
+	return ret;
+}
+
+static void hv_mem_hot_remove(unsigned int nid, u64 nr_pages)
+{
+	struct dm_hot_remove_response *resp
+		= (struct dm_hot_remove_response *)balloon_up_send_buffer;
+	unsigned long start_pfn = node_start_pfn(nid);
+	unsigned long end_pfn = node_end_pfn(nid);
+	unsigned long request_index = 0;
+	int remain_pages;
+
+	/* Todo: Handle request of non-aligned page number later. */
+
+	/* Search hot-remove memory region from hot add list first.*/
+	memset(resp, 0x00, PAGE_SIZE);
+	remain_pages = hv_hot_remove_from_ha_list(nid, nr_pages,
+				&request_index,
+				resp->range_array);
+	if (remain_pages < 0) {
+		/* Send failure response msg. */
+		request_index = 0;
+	} else if (remain_pages) {
+		start_pfn = ALIGN(start_pfn, HA_CHUNK);
+		hv_hot_remove_range(nid, start_pfn, end_pfn, remain_pages,
+				    &request_index, resp->range_array, NULL);
+	}
+
+	hv_send_hot_remove_response(resp, request_index, false);
+}
+
 #endif
 
 static void hot_remove_req(union dm_msg_info *msg_info)
 {
 	struct hv_dynmem_device *dm = &dm_device;
+	unsigned int numa_node = msg_info->hot_remove.virtual_node;
+	unsigned int page_count = msg_info->hot_remove.page_count;
 
-	/* Add hot remove operation later and send failure response. */
-	hv_send_hot_remove_response((struct dm_hot_remove_response *)
+	if (IS_ENABLED(CONFIG_MEMORY_HOTPLUG) && do_hot_add)
+		hv_mem_hot_remove(numa_node, page_count);
+	else
+		hv_send_hot_remove_response((struct dm_hot_remove_response *)
 				balloon_up_send_buffer, 0, false);
 
 	dm->state = DM_INITIALIZED;
-- 
2.14.5

