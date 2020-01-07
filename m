Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F0599132740
	for <lists+linux-hyperv@lfdr.de>; Tue,  7 Jan 2020 14:11:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728020AbgAGNKf (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 7 Jan 2020 08:10:35 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35219 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727814AbgAGNKe (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 7 Jan 2020 08:10:34 -0500
Received: by mail-pf1-f196.google.com with SMTP id i23so23172141pfo.2;
        Tue, 07 Jan 2020 05:10:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mR/hie9wIYmGFIHTMtBBBtQSTqZTVQUrMADgeObpT+c=;
        b=WTxqHUZUsHazBF21MYJiB9UvbKOGsmyvGB0kGNG68MqwzhmjMIDut1auQbJapAK4KI
         hG1pHxyXNBNDwuAP96mUj1fRpEyPmps36HDTm0eNmCKTikdiu18e6NH/hhEzt5/tO+Lg
         MwghnrSSD4hWx98rpxqZGy7fuGL14TOIBfIr8LWy7W9joCnEyJaparl2sNXmDmLFq/vG
         ms16zKcQ5Y23NlPR8t3F18H/2a7yt4p8NYUev6Fmkl/46stSs/boTneLMtBlH4vIBOJg
         mZzLQ0Pz2PgKQeiwWt79GJYtYV4xGTIw1M0CqZYcyjBowEo234Q3vAyYpXxV4WT2iZhw
         mB3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mR/hie9wIYmGFIHTMtBBBtQSTqZTVQUrMADgeObpT+c=;
        b=lwKYJc6BOi4TLgZyrwrOBmc+zfdBs691YMhQOOXPQC02BIXPeyhAwi1GeLRw+j4A8W
         7cL4GxvG4VsAd17znhhJpAnpkrvrqYc2J5BecPnKouKo0YAPWaAAK3VhtzdyAioumJ+c
         5ol9nKXS0LY2Hu6hwOZSo2ZH1rcIHHctt22DjT2xMU0jU5B6GmLJD8obgALySstIUx0y
         mmm+3P/oUG2cngcSpswkBrEO4JaviT7DokSDOjYXurh84ywN1Ncdf1/caoHwbZkUuRMI
         02ldyYbm6I5dIku6DaQzAhvLdMaaTHiSps7Y2Za8RaAlwzSj9604the0qMpHvwJDidEO
         5fSw==
X-Gm-Message-State: APjAAAX/3zrPO2uu1y7nz3lMlcy2/GDEXPNMgLx67DprJLCF7llmnrYV
        kkQIhs2UcbIz/LF3lS+s1F2u/hQdhXs=
X-Google-Smtp-Source: APXvYqwQlpKp4gmISP3BpmhM+dAT684dkiXdWnPDEYXdpp/qdLpkdpxi4MMxExna596tG9PT8oH3fg==
X-Received: by 2002:a62:1b4d:: with SMTP id b74mr117454336pfb.59.1578402634146;
        Tue, 07 Jan 2020 05:10:34 -0800 (PST)
Received: from localhost.corp.microsoft.com ([167.220.255.5])
        by smtp.googlemail.com with ESMTPSA id m71sm27522400pje.0.2020.01.07.05.10.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 Jan 2020 05:10:33 -0800 (PST)
From:   lantianyu1986@gmail.com
X-Google-Original-From: Tianyu.Lan@microsoft.com
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        sashal@kernel.org, michael.h.kelley@microsoft.com, david@redhat.com
Cc:     Tianyu Lan <Tianyu.Lan@microsoft.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        vkuznets@redhat.com, eric.devolder@oracle.com
Subject: [RFC PATCH V2 8/10] x86/Hyper-V/Balloon: Handle request with non-aligned page number
Date:   Tue,  7 Jan 2020 21:09:48 +0800
Message-Id: <20200107130950.2983-9-Tianyu.Lan@microsoft.com>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20200107130950.2983-1-Tianyu.Lan@microsoft.com>
References: <20200107130950.2983-1-Tianyu.Lan@microsoft.com>
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Tianyu Lan <Tianyu.Lan@microsoft.com>

The mem hot-remove msg may request non-aligned page number.
Hot plug unit is 128MB. Handle the remainder pages via
balloon way that allocate memory, offline pages and return
mem back to host. In order to help to check whether memory
range in mem hot add msg is allocated by balloon driver
or not, set page private to 1 when allocate page. If the
pages associated with mem range in hot add msg is present
and page private is non-zero, clear offline flag and free
mem to return back.

Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
---
 drivers/hv/hv_balloon.c | 149 +++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 129 insertions(+), 20 deletions(-)

diff --git a/drivers/hv/hv_balloon.c b/drivers/hv/hv_balloon.c
index 3d8c09fe148a..f76c9bd7fe2f 100644
--- a/drivers/hv/hv_balloon.c
+++ b/drivers/hv/hv_balloon.c
@@ -641,6 +641,32 @@ static int hv_send_hot_remove_response(
 	return ret;
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
+static void free_balloon_pages(struct hv_dynmem_device *dm,
+			 union dm_mem_page_range *range_array)
+{
+	int num_pages = range_array->finfo.page_cnt;
+	__u64 start_frame = range_array->finfo.start_page;
+
+	free_allocated_pages(start_frame, num_pages);
+}
+
 #ifdef CONFIG_MEMORY_HOTPLUG
 static inline bool has_pfn_is_backed(struct hv_hotadd_state *has,
 				     unsigned long pfn)
@@ -1017,6 +1043,16 @@ static unsigned long process_hot_add(unsigned long pg_start,
 	if (pfn_cnt == 0)
 		return 0;
 
+	/*
+	 * Check whether page is allocated by driver via page private
+	 * data due to remainder pages.
+	 */
+	if (present_section_nr(pfn_to_section_nr(pg_start))
+	    && page_private(pfn_to_page(pg_start))) {
+		free_allocated_pages(pg_start, pfn_cnt);
+		return pfn_cnt;
+	}
+
 	if (!dm_device.host_specified_ha_region) {
 		covered = pfn_covered(pg_start, pfn_cnt);
 		if (covered < 0)
@@ -1194,6 +1230,82 @@ static int hv_hot_remove_from_ha_list(unsigned int nid, unsigned long nr_pages,
 	return ret;
 }
 
+static int hv_hot_remove_pages(struct dm_hot_remove_response *resp,
+			       u64 nr_pages, unsigned long *request_index,
+			       bool more_pages)
+{
+	int i, j, alloc_unit = PAGES_IN_2M;
+	struct page *pg;
+	int ret;
+
+	for (i = 0; i < nr_pages; i += alloc_unit) {
+		if (*request_index >= MAX_HOT_REMOVE_ENTRIES) {
+			/* Flush out all hot-remove ranges. */
+			ret = hv_send_hot_remove_response(resp,
+					*request_index, true);
+			if (ret)
+				goto free_pages;
+
+			/*
+			 * Continue to allocate memory for hot remove
+			 * after resetting send buffer and array index.
+			 */
+			memset(resp, 0x00, PAGE_SIZE);
+			*request_index = 0;
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
+		resp->range_array[*request_index].finfo.start_page
+				= page_to_pfn(pg);
+		resp->range_array[*request_index].finfo.page_cnt
+				= alloc_unit;
+		(*request_index)++;
+
+		dm_device.num_pages_ballooned += alloc_unit;
+	}
+
+	ret = hv_send_hot_remove_response(resp, *request_index, more_pages);
+	if (ret)
+		goto free_pages;
+
+	return 0;
+
+free_pages:
+	for (i = 0; i < *request_index; i++)
+		free_balloon_pages(&dm_device, &resp->range_array[i]);
+
+	/* Response hot remove failure. */
+	hv_send_hot_remove_response(resp, 0, false);
+	return ret;
+}
+
 static void hv_mem_hot_remove(unsigned int nid, u64 nr_pages)
 {
 	struct dm_hot_remove_response *resp
@@ -1201,9 +1313,24 @@ static void hv_mem_hot_remove(unsigned int nid, u64 nr_pages)
 	unsigned long start_pfn = node_start_pfn(nid);
 	unsigned long end_pfn = node_end_pfn(nid);
 	unsigned long request_index = 0;
-	int remain_pages;
+	unsigned long remainder = nr_pages % HA_CHUNK;
+	int remain_pages, ret;
 
-	/* Todo: Handle request of non-aligned page number later. */
+	/*
+	 * If page number isn't aligned with memory hot plug unit,
+	 * handle remainder pages via balloon way.
+	 */
+	if (remainder) {
+		memset(resp, 0x00, PAGE_SIZE);
+		ret = hv_hot_remove_pages(resp, remainder, &request_index,
+				!!(nr_pages - remainder));
+		if (ret)
+			return;
+
+		nr_pages -= remainder;
+		if (!nr_pages)
+			return;
+	}
 
 	/* Search hot-remove memory region from hot add list first.*/
 	memset(resp, 0x00, PAGE_SIZE);
@@ -1448,24 +1575,6 @@ static void post_status(struct hv_dynmem_device *dm)
 
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
-- 
2.14.5

