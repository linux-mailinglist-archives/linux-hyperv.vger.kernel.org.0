Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6C69118CEA
	for <lists+linux-hyperv@lfdr.de>; Tue, 10 Dec 2019 16:46:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727568AbfLJPqn (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 10 Dec 2019 10:46:43 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:35015 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727178AbfLJPqn (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 10 Dec 2019 10:46:43 -0500
Received: by mail-pj1-f67.google.com with SMTP id w23so7574548pjd.2;
        Tue, 10 Dec 2019 07:46:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=209GGGWMa/fAi0/ssT9koD9quvvOVKH8l/wFHo52+8U=;
        b=PJ4ndv0JFZ0MEoJ8hdaBBjZWrEl+wnEbVZgfo5iPQjMbICy5fVJK6KuuSDLzfQ7ETb
         /bYlO060GrGZVPOzR7oY7GCref9z75Cs9oePeMyMMlKw6XsYr+erfkcy52TQN0OZYuFP
         jE6m2wtvBVvD7We2IxFzpqA4PRAXGgJt9V00PWlB9mHFtYVENltWW5VhkRXE62q9wY0c
         2nw7jimNE7dUohEJBAf/ONOHYUJtJGZ4kSAYo3R5hmHcUSAu3CgTtkZ4Swc9At6ErqAH
         EqK5chaEzB+DdQAbOiwYXisqFZwlmafde/63KACm+ouuGiG0726sZ4ow5kG8AamGT1+8
         rW7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=209GGGWMa/fAi0/ssT9koD9quvvOVKH8l/wFHo52+8U=;
        b=MgaIE2PVXhNZzQwNtx5LNzc25EiMvh//9rAQn6UST1dYJQ+l8htjGWsY/AJrFwy1I+
         UymoYf6gRsJpLY284LPlhcgQeeJYfp7u476DMMaL9XH+MHSsyLY2yh++XkbPzR/J1ybK
         Ik0zRPYWqxmkLwHz2NK/0CuR/hDhynM185jYgJLp/f/DH71waKn4NH53sihk+BnhJIsu
         veWdJwMzj+4A7jfR10gxIXhhChte6+0+1qskXgxr0iUvkS0RT1W4ZC5cxp/ouNCTFsBQ
         wdW86rbwQ+De/JJxtvlwmfQn7IgeDyuNbwVbrzV1GEBfnNX81Lsb6BKY9+cPzN6v2QnQ
         oIVQ==
X-Gm-Message-State: APjAAAXDUS7MpeEiGrROzgyQ5XVH+80vEqJtjDVoJlppBCgeNkuMPHeK
        U5Z2xP6SttjDmI2iCZ8DqOM=
X-Google-Smtp-Source: APXvYqxOt4wANJTDCXLenmRcOZwrRP5SPNWWM0ITqZ+px+PT1nxSggE8d1e/va/iW1Jnmfs4oEKd3Q==
X-Received: by 2002:a17:90a:be03:: with SMTP id a3mr6158904pjs.75.1575992801748;
        Tue, 10 Dec 2019 07:46:41 -0800 (PST)
Received: from localhost.corp.microsoft.com ([167.220.255.5])
        by smtp.googlemail.com with ESMTPSA id k13sm4113815pfp.48.2019.12.10.07.46.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 10 Dec 2019 07:46:40 -0800 (PST)
From:   lantianyu1986@gmail.com
X-Google-Original-From: Tianyu.Lan@microsoft.com
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        sashal@kernel.org, michael.h.kelley@microsoft.com
Cc:     Tianyu Lan <Tianyu.Lan@microsoft.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        vkuznets@redhat.com, eric.devolder@oracle.com
Subject: [RFC PATCH 4/4] x86/Hyper-V: Add memory hot remove function
Date:   Tue, 10 Dec 2019 23:46:11 +0800
Message-Id: <20191210154611.10958-5-Tianyu.Lan@microsoft.com>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20191210154611.10958-1-Tianyu.Lan@microsoft.com>
References: <20191210154611.10958-1-Tianyu.Lan@microsoft.com>
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Tianyu Lan <Tianyu.Lan@microsoft.com>

Hyper-V provides dynamic memory hot add/remove function.
Memory hot-add has already enabled in Hyper-V balloon driver.
Now add memory hot-remove function.

When driver receives hot-remove msg, it first checks whether
request remove page number is aligned with hot plug unit(128MB).
If there are remainder pages(pages%128MB), handle remainder pages
via balloon way(allocate pages, offline pages and return back to
Hyper-V).

To remove memory chunks, search memory in the hot add blocks first
and then other system memory.

Hyper-V has a bug of sending unballoon msg to request memory
hot-add after doing memory hot-remove. Fix it to handle all
unballoon msg with memory hot-add operation.

Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
---
 drivers/hv/hv_balloon.c | 686 +++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 616 insertions(+), 70 deletions(-)

diff --git a/drivers/hv/hv_balloon.c b/drivers/hv/hv_balloon.c
index 4d1a3b1e2490..015e9e993188 100644
--- a/drivers/hv/hv_balloon.c
+++ b/drivers/hv/hv_balloon.c
@@ -19,6 +19,7 @@
 #include <linux/completion.h>
 #include <linux/memory_hotplug.h>
 #include <linux/memory.h>
+#include <linux/memblock.h>
 #include <linux/notifier.h>
 #include <linux/percpu_counter.h>
 
@@ -46,12 +47,17 @@
  * Changes to 0.2 on 2009/05/14
  * Changes to 0.3 on 2009/12/03
  * Changed to 1.0 on 2011/04/05
+ * Changed to 2.0 on 2019/12/10
  */
 
 #define DYNMEM_MAKE_VERSION(Major, Minor) ((__u32)(((Major) << 16) | (Minor)))
 #define DYNMEM_MAJOR_VERSION(Version) ((__u32)(Version) >> 16)
 #define DYNMEM_MINOR_VERSION(Version) ((__u32)(Version) & 0xff)
 
+#define MAX_HOT_REMOVE_ENTRIES						\
+		((PAGE_SIZE - sizeof(struct dm_hot_remove_response))	\
+		 / sizeof(union dm_mem_page_range))
+
 enum {
 	DYNMEM_PROTOCOL_VERSION_1 = DYNMEM_MAKE_VERSION(0, 3),
 	DYNMEM_PROTOCOL_VERSION_2 = DYNMEM_MAKE_VERSION(1, 0),
@@ -91,7 +97,13 @@ enum dm_message_type {
 	 * Version 1.0.
 	 */
 	DM_INFO_MESSAGE			= 12,
-	DM_VERSION_1_MAX		= 12
+	DM_VERSION_1_MAX		= 12,
+
+	/*
+	 * Version 2.0
+	 */
+	DM_MEM_HOT_REMOVE_REQUEST        = 13,
+	DM_MEM_HOT_REMOVE_RESPONSE       = 14
 };
 
 
@@ -120,7 +132,8 @@ union dm_caps {
 		 * represents an alignment of 2^n in mega bytes.
 		 */
 		__u64 hot_add_alignment:4;
-		__u64 reservedz:58;
+		__u64 hot_remove:1;
+		__u64 reservedz:57;
 	} cap_bits;
 	__u64 caps;
 } __packed;
@@ -231,7 +244,9 @@ struct dm_capabilities {
 struct dm_capabilities_resp_msg {
 	struct dm_header hdr;
 	__u64 is_accepted:1;
-	__u64 reservedz:63;
+	__u64 hot_remove:1;
+	__u64 suppress_pressure_reports:1;
+	__u64 reservedz:61;
 } __packed;
 
 /*
@@ -376,6 +391,27 @@ struct dm_hot_add_response {
 	__u32 result;
 } __packed;
 
+struct dm_hot_remove {
+	struct dm_header hdr;
+	__u32 virtual_node;
+	__u32 page_count;
+	__u32 qos_flags;
+	__u32 reservedZ;
+} __packed;
+
+struct dm_hot_remove_response {
+	struct dm_header hdr;
+	__u32 result;
+	__u32 range_count;
+	__u64 more_pages:1;
+	__u64 reservedz:63;
+	union dm_mem_page_range range_array[];
+} __packed;
+
+#define DM_REMOVE_QOS_LARGE	 (1 << 0)
+#define DM_REMOVE_QOS_LOCAL	 (1 << 1)
+#define DM_REMOVE_QoS_MASK       (0x3)
+
 /*
  * Types of information sent from host to the guest.
  */
@@ -457,6 +493,13 @@ struct hot_add_wrk {
 	struct work_struct wrk;
 };
 
+struct hot_remove_wrk {
+	__u32 virtual_node;
+	__u32 page_count;
+	__u32 qos_flags;
+	struct work_struct wrk;
+};
+
 static bool hot_add = true;
 static bool do_hot_add;
 /*
@@ -489,6 +532,7 @@ enum hv_dm_state {
 	DM_BALLOON_UP,
 	DM_BALLOON_DOWN,
 	DM_HOT_ADD,
+	DM_HOT_REMOVE,
 	DM_INIT_ERROR
 };
 
@@ -515,11 +559,13 @@ struct hv_dynmem_device {
 	 * State to manage the ballooning (up) operation.
 	 */
 	struct balloon_state balloon_wrk;
+	struct balloon_state unballoon_wrk;
 
 	/*
 	 * State to execute the "hot-add" operation.
 	 */
 	struct hot_add_wrk ha_wrk;
+	struct hot_remove_wrk hr_wrk;
 
 	/*
 	 * This state tracks if the host has specified a hot-add
@@ -569,6 +615,42 @@ static struct hv_dynmem_device dm_device;
 
 static void post_status(struct hv_dynmem_device *dm);
 
+static int hv_send_hot_remove_response(
+	       struct dm_hot_remove_response *resp,
+	       long array_index, bool more_pages)
+{
+	struct hv_dynmem_device *dm = &dm_device;
+	int ret;
+
+	resp->hdr.type = DM_MEM_HOT_REMOVE_RESPONSE;
+	resp->range_count = array_index;
+	resp->more_pages = more_pages;
+	resp->hdr.size = sizeof(struct dm_hot_remove_response)
+			+ sizeof(union dm_mem_page_range) * array_index;
+
+	if (array_index)
+		resp->result = 0;
+	else
+		resp->result = 1;
+
+	do {
+		resp->hdr.trans_id = atomic_inc_return(&trans_id);
+		ret = vmbus_sendpacket(dm->dev->channel, resp,
+				       resp->hdr.size,
+				       (unsigned long)NULL,
+				       VM_PKT_DATA_INBAND, 0);
+
+		if (ret == -EAGAIN)
+			msleep(20);
+		post_status(&dm_device);
+	} while (ret == -EAGAIN);
+
+	if (ret)
+		pr_err("Fail to send hot-remove response msg.\n");
+
+	return ret;
+}
+
 #ifdef CONFIG_MEMORY_HOTPLUG
 static inline bool has_pfn_is_backed(struct hv_hotadd_state *has,
 				     unsigned long pfn)
@@ -628,7 +710,9 @@ static int hv_memory_notifier(struct notifier_block *nb, unsigned long val,
 			      void *v)
 {
 	struct memory_notify *mem = (struct memory_notify *)v;
-	unsigned long flags, pfn_count;
+	unsigned long pfn_count;
+	unsigned long flags = 0;
+	int unlocked;
 
 	switch (val) {
 	case MEM_ONLINE:
@@ -640,7 +724,11 @@ static int hv_memory_notifier(struct notifier_block *nb, unsigned long val,
 		break;
 
 	case MEM_OFFLINE:
-		spin_lock_irqsave(&dm_device.ha_lock, flags);
+		if (dm_device.lock_thread != current) {
+			spin_lock_irqsave(&dm_device.ha_lock, flags);
+			unlocked = 1;
+		}
+
 		pfn_count = hv_page_offline_check(mem->start_pfn,
 						  mem->nr_pages);
 		if (pfn_count <= dm_device.num_pages_onlined) {
@@ -654,7 +742,10 @@ static int hv_memory_notifier(struct notifier_block *nb, unsigned long val,
 			WARN_ON_ONCE(1);
 			dm_device.num_pages_onlined = 0;
 		}
-		spin_unlock_irqrestore(&dm_device.ha_lock, flags);
+
+		if (unlocked)
+			spin_unlock_irqrestore(&dm_device.ha_lock, flags);
+
 		break;
 	case MEM_GOING_ONLINE:
 	case MEM_GOING_OFFLINE:
@@ -727,9 +818,17 @@ static void hv_mem_hot_add(unsigned long start, unsigned long size,
 		init_completion(&dm_device.ol_waitevent);
 		dm_device.ha_waiting = !memhp_auto_online;
 
-		nid = memory_add_physaddr_to_nid(PFN_PHYS(start_pfn));
-		ret = add_memory(nid, PFN_PHYS((start_pfn)),
-				(HA_CHUNK << PAGE_SHIFT));
+		/*
+		 * If memory section of hot add region is online,
+		 * just bring pages online in the region.
+		 */
+		if (online_section_nr(pfn_to_section_nr(start_pfn))) {
+			hv_bring_pgs_online(has, start_pfn, processed_pfn);
+		} else {
+			nid = memory_add_physaddr_to_nid(PFN_PHYS(start_pfn));
+			ret = add_memory(nid, PFN_PHYS((start_pfn)),
+					(HA_CHUNK << PAGE_SHIFT));
+		}
 
 		if (ret) {
 			pr_err("hot_add memory failed error is %d\n", ret);
@@ -765,8 +864,8 @@ static void hv_mem_hot_add(unsigned long start, unsigned long size,
 static void hv_online_page(struct page *pg, unsigned int order)
 {
 	struct hv_hotadd_state *has;
-	unsigned long flags;
 	unsigned long pfn = page_to_pfn(pg);
+	unsigned long flags = 0;
 	int unlocked;
 
 	if (dm_device.lock_thread != current) {
@@ -806,10 +905,12 @@ static int pfn_covered(unsigned long start_pfn, unsigned long pfn_cnt)
 			continue;
 
 		/*
-		 * If the current start pfn is not where the covered_end
-		 * is, create a gap and update covered_end_pfn.
+		 * If the current start pfn is great than covered_end_pfn,
+		 * create a gap and update covered_end_pfn. Start pfn may
+		 * locate at gap which is created during hot remove. The
+		 * gap range is less than covered_end_pfn.
 		 */
-		if (has->covered_end_pfn != start_pfn) {
+		if (has->covered_end_pfn < start_pfn) {
 			gap = kzalloc(sizeof(struct hv_hotadd_gap), GFP_ATOMIC);
 			if (!gap) {
 				ret = -ENOMEM;
@@ -848,6 +949,91 @@ static int pfn_covered(unsigned long start_pfn, unsigned long pfn_cnt)
 	return ret;
 }
 
+static int handle_hot_add_in_gap(unsigned long start, unsigned long pg_cnt,
+			  struct hv_hotadd_state *has)
+{
+	struct hv_hotadd_gap *gap, *new_gap, *tmp_gap;
+	unsigned long pfn_cnt = pg_cnt;
+	unsigned long start_pfn = start;
+	unsigned long end_pfn;
+	unsigned long pages;
+	unsigned long pgs_ol;
+	unsigned long block_pages = HA_CHUNK;
+	unsigned long pfn;
+	int nid;
+	int ret;
+
+	list_for_each_entry_safe(gap, tmp_gap, &has->gap_list, list) {
+
+		if ((start_pfn < gap->start_pfn)
+		    || (start_pfn >= gap->end_pfn))
+			continue;
+
+		end_pfn = min(gap->end_pfn, start_pfn + pfn_cnt);
+		pgs_ol = end_pfn - start_pfn;
+
+		/*
+		 * hv_bring_pgs_online() identifies whether pfn
+		 * should be online or not via checking pfn is in
+		 * hot add covered range or gap range(Detail see
+		 * has_pfn_is_backed()). So adjust gap before bringing
+		 * online or add memory.
+		 */
+		if (gap->end_pfn - gap->start_pfn == pgs_ol) {
+			list_del(&gap->list);
+			kfree(gap);
+		} else if (gap->start_pfn < start && gap->end_pfn == end_pfn) {
+			gap->end_pfn = start_pfn;
+		} else if (gap->end_pfn > end_pfn
+		   && gap->start_pfn == start_pfn) {
+			gap->start_pfn = end_pfn;
+		} else {
+			gap->end_pfn = start_pfn;
+
+			new_gap = kzalloc(sizeof(struct hv_hotadd_gap),
+					GFP_ATOMIC);
+			if (!new_gap) {
+				do_hot_add = false;
+				return -ENOMEM;
+			}
+
+			INIT_LIST_HEAD(&new_gap->list);
+			new_gap->start_pfn = end_pfn;
+			new_gap->end_pfn = gap->end_pfn;
+			list_add_tail(&gap->list, &has->gap_list);
+		}
+
+		/* Bring online or add memmory in gaps. */
+		for (pfn = start_pfn; pfn < end_pfn;
+		     pfn = round_up(pfn + 1, block_pages)) {
+			pages = min(round_up(pfn + 1, block_pages),
+				    end_pfn) - pfn;
+
+			if (online_section_nr(pfn_to_section_nr(pfn))) {
+				hv_bring_pgs_online(has, pfn, pages);
+			} else {
+				nid = memory_add_physaddr_to_nid(PFN_PHYS(pfn));
+				ret = add_memory(nid, PFN_PHYS(pfn),
+						 round_up(pages, block_pages)
+						 << PAGE_SHIFT);
+				if (ret) {
+					pr_err("Fail to add memory in gaps(error=%d).\n",
+					       ret);
+					do_hot_add = false;
+					return ret;
+				}
+			}
+		}
+
+		start_pfn += pgs_ol;
+		pfn_cnt -= pgs_ol;
+		if (!pfn_cnt)
+			break;
+	}
+
+	return pg_cnt - pfn_cnt;
+}
+
 static unsigned long handle_pg_range(unsigned long pg_start,
 					unsigned long pg_count)
 {
@@ -874,6 +1060,22 @@ static unsigned long handle_pg_range(unsigned long pg_start,
 
 		old_covered_state = has->covered_end_pfn;
 
+		/*
+		 * If start_pfn is less than cover_end_pfn, the hot-add memory
+		 * area is in the gap range.
+		 */
+		if (start_pfn < has->covered_end_pfn) {
+			pgs_ol = handle_hot_add_in_gap(start_pfn, pfn_cnt, has);
+
+			pfn_cnt -= pgs_ol;
+			if (!pfn_cnt) {
+				res = pgs_ol;
+				break;
+			}
+
+			start_pfn += pgs_ol;
+		}
+
 		if (start_pfn < has->ha_end_pfn) {
 			/*
 			 * This is the case where we are backing pages
@@ -931,6 +1133,23 @@ static unsigned long handle_pg_range(unsigned long pg_start,
 	return res;
 }
 
+static void free_allocated_pages(__u64 start_frame, int num_pages)
+{
+	struct page *pg;
+	int i;
+
+	for (i = 0; i < num_pages; i++) {
+		pg = pfn_to_page(i + start_frame);
+
+		if (page_private(pfn_to_page(i)))
+			set_page_private(pfn_to_page(i), 0);
+
+		__ClearPageOffline(pg);
+		__free_page(pg);
+		dm_device.num_pages_ballooned--;
+	}
+}
+
 static unsigned long process_hot_add(unsigned long pg_start,
 					unsigned long pfn_cnt,
 					unsigned long rg_start,
@@ -940,18 +1159,40 @@ static unsigned long process_hot_add(unsigned long pg_start,
 	int covered;
 	unsigned long flags;
 
-	if (pfn_cnt == 0)
-		return 0;
+	/*
+	 * Check whether page is allocated by driver via page private
+	 * data due to remainder pages.
+	 */
+	if (present_section_nr(pfn_to_section_nr(pg_start))
+	    && page_private(pfn_to_page(pg_start))) {
+		free_allocated_pages(pg_start, pfn_cnt);
+		return pfn_cnt;
+	}
 
-	if (!dm_device.host_specified_ha_region) {
-		covered = pfn_covered(pg_start, pfn_cnt);
-		if (covered < 0)
-			return 0;
+	if ((rg_start == 0) && (!dm_device.host_specified_ha_region)) {
+		/*
+		 * The host has not specified the hot-add region.
+		 * Based on the hot-add page range being specified,
+		 * compute a hot-add region that can cover the pages
+		 * that need to be hot-added while ensuring the alignment
+		 * and size requirements of Linux as it relates to hot-add.
+		 */
+		rg_size = (pfn_cnt / HA_CHUNK) * HA_CHUNK;
+		if (pfn_cnt % HA_CHUNK)
+			rg_size += HA_CHUNK;
 
-		if (covered)
-			goto do_pg_range;
+		rg_start = (pg_start / HA_CHUNK) * HA_CHUNK;
 	}
 
+	if (pfn_cnt == 0)
+		return 0;
+
+	covered = pfn_covered(pg_start, pfn_cnt);
+	if (covered < 0)
+		return 0;
+	else if (covered)
+		goto do_pg_range;
+
 	/*
 	 * If the host has specified a hot-add range; deal with it first.
 	 */
@@ -983,8 +1224,321 @@ static unsigned long process_hot_add(unsigned long pg_start,
 	return handle_pg_range(pg_start, pfn_cnt);
 }
 
+static int check_memblock_online(struct memory_block *mem, void *arg)
+{
+	if (mem->state != MEM_ONLINE)
+		return -1;
+
+	return 0;
+}
+
+static int change_memblock_state(struct memory_block *mem, void *arg)
+{
+	unsigned long state = (unsigned long)arg;
+
+	mem->state = state;
+
+	return 0;
+}
+
+static bool hv_offline_pages(unsigned long start_pfn, unsigned long nr_pages)
+{
+	const unsigned long start = PFN_PHYS(start_pfn);
+	const unsigned long size = PFN_PHYS(nr_pages);
+
+	lock_device_hotplug();
+
+	if (walk_memory_blocks(start, size, NULL, check_memblock_online)) {
+		unlock_device_hotplug();
+		return false;
+	}
+
+	walk_memory_blocks(start, size, (void *)MEM_GOING_OFFLINE,
+			  change_memblock_state);
+
+	if (offline_pages(start_pfn, nr_pages)) {
+		walk_memory_blocks(start_pfn, nr_pages, (void *)MEM_ONLINE,
+				  change_memblock_state);
+		unlock_device_hotplug();
+		return false;
+	}
+
+	walk_memory_blocks(start, size, (void *)MEM_OFFLINE,
+			  change_memblock_state);
+
+	unlock_device_hotplug();
+	return true;
+}
+
+static int hv_hot_remove_range(unsigned int nid, unsigned long start_pfn,
+			       unsigned long end_pfn, unsigned long nr_pages,
+			       unsigned long *array_index,
+			       union dm_mem_page_range *range_array,
+			       struct hv_hotadd_state *has)
+{
+	unsigned long block_pages = HA_CHUNK;
+	unsigned long rm_pages = nr_pages;
+	unsigned long pfn;
+
+	for (pfn = start_pfn; pfn < end_pfn; pfn += block_pages) {
+		struct hv_hotadd_gap *gap;
+		int in_gaps = 0;
+
+		if (*array_index >= MAX_HOT_REMOVE_ENTRIES) {
+			struct dm_hot_remove_response *resp =
+				(struct dm_hot_remove_response *)
+					balloon_up_send_buffer;
+			int ret;
+
+			/* Flush out all remove response entries. */
+			ret = hv_send_hot_remove_response(resp, *array_index,
+							  true);
+			if (ret)
+				return ret;
+
+			memset(resp, 0x00, PAGE_SIZE);
+			*array_index = 0;
+		}
+
+		if (has) {
+			/*
+			 * Memory in gaps has been offlined or removed and
+			 * so skip it if remove range overlap with gap.
+			 */
+			list_for_each_entry(gap, &has->gap_list, list)
+				if (!(pfn >= gap->end_pfn ||
+				      pfn + block_pages < gap->start_pfn)) {
+					in_gaps = 1;
+					break;
+				}
+
+			if (in_gaps)
+				continue;
+		}
+
+		if (online_section_nr(pfn_to_section_nr(pfn))
+		    && is_mem_section_removable(pfn, block_pages)
+		    && hv_offline_pages(pfn, block_pages)) {
+			remove_memory(nid, pfn << PAGE_SHIFT,
+				      block_pages << PAGE_SHIFT);
+
+			range_array[*array_index].finfo.start_page = pfn;
+			range_array[*array_index].finfo.page_cnt = block_pages;
+
+			(*array_index)++;
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
+				      unsigned long *array_index,
+				      union dm_mem_page_range *range_array)
+{
+	struct hv_hotadd_state *has;
+	unsigned long start_pfn, end_pfn;
+	unsigned long flags, rm_pages;
+	int old_index;
+	int ret, i;
+
+	spin_lock_irqsave(&dm_device.ha_lock, flags);
+	dm_device.lock_thread = current;
+	list_for_each_entry(has, &dm_device.ha_region_list, list) {
+		start_pfn = has->start_pfn;
+		end_pfn = has->covered_end_pfn;
+		rm_pages = min(nr_pages, has->covered_end_pfn - has->start_pfn);
+		old_index = *array_index;
+
+		if (!rm_pages || pfn_to_nid(start_pfn) != nid)
+			continue;
+
+		rm_pages = hv_hot_remove_range(nid, start_pfn, end_pfn,
+				rm_pages, array_index, range_array, has);
+
+		if (rm_pages < 0)
+			return rm_pages;
+		else if (!rm_pages)
+			continue;
+
+		nr_pages -= rm_pages;
+		dm_device.num_pages_added -= rm_pages;
+
+		/* Create gaps for hot remove regions. */
+		for (i = old_index; i < *array_index; i++) {
+			struct hv_hotadd_gap *gap;
+
+			gap = kzalloc(sizeof(struct hv_hotadd_gap), GFP_ATOMIC);
+			if (!gap) {
+				ret = -ENOMEM;
+				do_hot_add = false;
+				return ret;
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
+	dm_device.lock_thread = NULL;
+	spin_unlock_irqrestore(&dm_device.ha_lock, flags);
+
+	return nr_pages;
+}
+
+static void free_balloon_pages(struct hv_dynmem_device *dm,
+			 union dm_mem_page_range *range_array)
+{
+	int num_pages = range_array->finfo.page_cnt;
+	__u64 start_frame = range_array->finfo.start_page;
+
+	free_allocated_pages(start_frame, num_pages);
+}
+
+static int hv_hot_remove_pages(struct dm_hot_remove_response *resp,
+			       u64 nr_pages, unsigned long *array_index,
+			       bool more_pages)
+{
+	int i, j, alloc_unit = PAGES_IN_2M;
+	struct page *pg;
+	int ret;
+
+	for (i = 0; i < nr_pages; i += alloc_unit) {
+		if (*array_index >= MAX_HOT_REMOVE_ENTRIES) {
+			/* Flush out all remove response entries. */
+			ret = hv_send_hot_remove_response(resp,
+					*array_index, true);
+			if (ret)
+				goto free_pages;
+
+			/*
+			 * Continue to allocate memory for hot remove
+			 * after resetting send buffer and array index.
+			 */
+			memset(resp, 0x00, PAGE_SIZE);
+			*array_index = 0;
+		}
+retry:
+		pg = alloc_pages(GFP_HIGHUSER | __GFP_NORETRY |
+			__GFP_NOMEMALLOC | __GFP_NOWARN,
+			get_order(alloc_unit << PAGE_SHIFT));
+		if (!pg) {
+			if (alloc_unit == 1) {
+				ret = -ENOMEM;
+				goto free_pages;
+			}
+
+			alloc_unit = 1;
+			goto retry;
+		}
+
+		if (alloc_unit != 1)
+			split_page(pg, get_order(alloc_unit << PAGE_SHIFT));
+
+		for (j = 0; j < (1 << get_order(alloc_unit << PAGE_SHIFT));
+		    j++) {
+			__SetPageOffline(pg + j);
+
+			/*
+			 * Set page's private data to non-zero and use it
+			 * to identify whehter the page is allocated by driver
+			 * or new hot-add memory in process_hot_add().
+			 */
+			set_page_private(pg + j, 1);
+		}
+
+		resp->range_array[*array_index].finfo.start_page
+				= page_to_pfn(pg);
+		resp->range_array[*array_index].finfo.page_cnt
+				= alloc_unit;
+		(*array_index)++;
+
+		dm_device.num_pages_ballooned += alloc_unit;
+	}
+
+	ret = hv_send_hot_remove_response(resp, *array_index, more_pages);
+	if (ret)
+		goto free_pages;
+
+	return 0;
+
+free_pages:
+	for (i = 0; i < *array_index; i++)
+		free_balloon_pages(&dm_device, &resp->range_array[i]);
+
+	/* Response hot remove failure. */
+	hv_send_hot_remove_response(resp, 0, false);
+	return ret;
+}
+
+static void hv_hot_remove_mem_from_node(unsigned int nid, u64 nr_pages)
+{
+	struct dm_hot_remove_response *resp
+		= (struct dm_hot_remove_response *)balloon_up_send_buffer;
+	unsigned long remainder = nr_pages % HA_CHUNK;
+	unsigned long start_pfn = node_start_pfn(nid);
+	unsigned long end_pfn = node_end_pfn(nid);
+	unsigned long array_index = 0;
+	int ret;
+
+	/*
+	 * If page number isn't aligned with memory hot plug unit,
+	 * handle remainder pages via balloon way.
+	 */
+	if (remainder) {
+		memset(resp, 0x00, PAGE_SIZE);
+		ret = hv_hot_remove_pages(resp, remainder, &array_index,
+				!!(nr_pages - remainder));
+		if (ret)
+			return;
+
+		nr_pages -= remainder;
+		if (!nr_pages)
+			return;
+	}
+
+	memset(resp, 0x00, PAGE_SIZE);
+	array_index = 0;
+	nr_pages = hv_hot_remove_from_ha_list(nid, nr_pages, &array_index,
+				resp->range_array);
+	if (nr_pages < 0) {
+		/* Set array_index to 0 and response failure in resposne msg. */
+		array_index = 0;
+	} else if (nr_pages) {
+		start_pfn = ALIGN(start_pfn, HA_CHUNK);
+		hv_hot_remove_range(nid, start_pfn, end_pfn, nr_pages,
+				    &array_index, resp->range_array, NULL);
+	}
+
+	hv_send_hot_remove_response(resp, array_index, false);
+}
+
 #endif
 
+static void hot_remove_req(struct work_struct *dummy)
+{
+	struct hv_dynmem_device *dm = &dm_device;
+	unsigned int numa_node = dm->hr_wrk.virtual_node;
+	unsigned int page_count = dm->hr_wrk.page_count;
+
+	if (IS_ENABLED(CONFIG_MEMORY_HOTPLUG) || do_hot_add)
+		hv_hot_remove_mem_from_node(numa_node, page_count);
+	else
+		hv_send_hot_remove_response((struct dm_hot_remove_response *)
+				balloon_up_send_buffer, 0, false);
+
+	dm->state = DM_INITIALIZED;
+}
+
 static void hot_add_req(struct work_struct *dummy)
 {
 	struct dm_hot_add_response resp;
@@ -1005,28 +1559,6 @@ static void hot_add_req(struct work_struct *dummy)
 	rg_start = dm->ha_wrk.ha_region_range.finfo.start_page;
 	rg_sz = dm->ha_wrk.ha_region_range.finfo.page_cnt;
 
-	if ((rg_start == 0) && (!dm->host_specified_ha_region)) {
-		unsigned long region_size;
-		unsigned long region_start;
-
-		/*
-		 * The host has not specified the hot-add region.
-		 * Based on the hot-add page range being specified,
-		 * compute a hot-add region that can cover the pages
-		 * that need to be hot-added while ensuring the alignment
-		 * and size requirements of Linux as it relates to hot-add.
-		 */
-		region_start = pg_start;
-		region_size = (pfn_cnt / HA_CHUNK) * HA_CHUNK;
-		if (pfn_cnt % HA_CHUNK)
-			region_size += HA_CHUNK;
-
-		region_start = (pg_start / HA_CHUNK) * HA_CHUNK;
-
-		rg_start = region_start;
-		rg_sz = region_size;
-	}
-
 	if (do_hot_add)
 		resp.page_count = process_hot_add(pg_start, pfn_cnt,
 						rg_start, rg_sz);
@@ -1190,24 +1722,6 @@ static void post_status(struct hv_dynmem_device *dm)
 
 }
 
-static void free_balloon_pages(struct hv_dynmem_device *dm,
-			 union dm_mem_page_range *range_array)
-{
-	int num_pages = range_array->finfo.page_cnt;
-	__u64 start_frame = range_array->finfo.start_page;
-	struct page *pg;
-	int i;
-
-	for (i = 0; i < num_pages; i++) {
-		pg = pfn_to_page(i + start_frame);
-		__ClearPageOffline(pg);
-		__free_page(pg);
-		dm->num_pages_ballooned--;
-	}
-}
-
-
-
 static unsigned int alloc_balloon_pages(struct hv_dynmem_device *dm,
 					unsigned int num_pages,
 					struct dm_balloon_response *bl_resp,
@@ -1354,22 +1868,38 @@ static void balloon_up(struct work_struct *dummy)
 
 }
 
-static void balloon_down(struct hv_dynmem_device *dm,
-			struct dm_unballoon_request *req)
+static void balloon_down(struct work_struct *dummy)
 {
+	struct dm_unballoon_request *req =
+		(struct dm_unballoon_request *)recv_buffer;
 	union dm_mem_page_range *range_array = req->range_array;
 	int range_count = req->range_count;
 	struct dm_unballoon_response resp;
-	int i;
+	struct hv_dynmem_device *dm = &dm_device;
 	unsigned int prev_pages_ballooned = dm->num_pages_ballooned;
+	int i;
 
 	for (i = 0; i < range_count; i++) {
-		free_balloon_pages(dm, &range_array[i]);
-		complete(&dm_device.config_event);
+		/*
+		 * Hyper-V has a bug of sending unballoon msg instead
+		 * of hot add msg when there is no balloon msg sent before
+		 * Do hot add operation for all unballoon msg If hot add
+		 * capability is enabled,
+		 */
+		if (do_hot_add) {
+			dm->host_specified_ha_region = false;
+			dm->num_pages_added +=
+				process_hot_add(range_array[i].finfo.start_page,
+				range_array[i].finfo.page_cnt, 0, 0);
+		} else {
+			free_balloon_pages(dm, &range_array[i]);
+		}
 	}
+	complete(&dm_device.config_event);
 
-	pr_debug("Freed %u ballooned pages.\n",
-		prev_pages_ballooned - dm->num_pages_ballooned);
+	if (!do_hot_add)
+		pr_debug("Freed %u ballooned pages.\n",
+			prev_pages_ballooned - dm->num_pages_ballooned);
 
 	if (req->more_pages == 1)
 		return;
@@ -1489,6 +2019,7 @@ static void balloon_onchannelcallback(void *context)
 	struct hv_dynmem_device *dm = hv_get_drvdata(dev);
 	struct dm_balloon *bal_msg;
 	struct dm_hot_add *ha_msg;
+	struct dm_hot_remove *hr_msg;
 	union dm_mem_page_range *ha_pg_range;
 	union dm_mem_page_range *ha_region;
 
@@ -1522,8 +2053,7 @@ static void balloon_onchannelcallback(void *context)
 
 		case DM_UNBALLOON_REQUEST:
 			dm->state = DM_BALLOON_DOWN;
-			balloon_down(dm,
-				 (struct dm_unballoon_request *)recv_buffer);
+			schedule_work(&dm_device.unballoon_wrk.wrk);
 			break;
 
 		case DM_MEM_HOT_ADD_REQUEST:
@@ -1554,6 +2084,19 @@ static void balloon_onchannelcallback(void *context)
 			}
 			schedule_work(&dm_device.ha_wrk.wrk);
 			break;
+		case DM_MEM_HOT_REMOVE_REQUEST:
+			if (dm->state == DM_HOT_REMOVE)
+				pr_warn("Currently hot-removing.\n");
+
+			dm->state = DM_HOT_REMOVE;
+			hr_msg = (struct dm_hot_remove *)recv_buffer;
+
+			dm->hr_wrk.virtual_node = hr_msg->virtual_node;
+			dm->hr_wrk.page_count = hr_msg->page_count;
+			dm->hr_wrk.qos_flags = hr_msg->qos_flags;
+
+			schedule_work(&dm_device.hr_wrk.wrk);
+			break;
 
 		case DM_INFO_MESSAGE:
 			process_info(dm, (struct dm_info_msg *)dm_msg);
@@ -1628,6 +2171,7 @@ static int balloon_connect_vsp(struct hv_device *dev)
 
 	cap_msg.caps.cap_bits.balloon = 1;
 	cap_msg.caps.cap_bits.hot_add = 1;
+	cap_msg.caps.cap_bits.hot_remove = 1;
 
 	/*
 	 * Specify our alignment requirements as it relates
@@ -1688,7 +2232,9 @@ static int balloon_probe(struct hv_device *dev,
 	INIT_LIST_HEAD(&dm_device.ha_region_list);
 	spin_lock_init(&dm_device.ha_lock);
 	INIT_WORK(&dm_device.balloon_wrk.wrk, balloon_up);
+	INIT_WORK(&dm_device.unballoon_wrk.wrk, balloon_down);
 	INIT_WORK(&dm_device.ha_wrk.wrk, hot_add_req);
+	INIT_WORK(&dm_device.hr_wrk.wrk, hot_remove_req);
 	dm_device.host_specified_ha_region = false;
 
 #ifdef CONFIG_MEMORY_HOTPLUG
-- 
2.14.5

