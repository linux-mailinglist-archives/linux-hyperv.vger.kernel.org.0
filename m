Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E60AE132744
	for <lists+linux-hyperv@lfdr.de>; Tue,  7 Jan 2020 14:11:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727814AbgAGNKn (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 7 Jan 2020 08:10:43 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42064 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728296AbgAGNKm (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 7 Jan 2020 08:10:42 -0500
Received: by mail-pf1-f193.google.com with SMTP id 4so28581030pfz.9;
        Tue, 07 Jan 2020 05:10:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=L00YIbrKDzzkZYycDncaqE3HMvA9FpbAU5f9CoxFhR0=;
        b=jceohFpLZAZPCOx6KvKGnu2DAE6P8vLSBL8Z2cStDnXewyreGHxk+gpXb1H5xKGRLh
         XDp4YrcZ8eCb/VuSrvsHQNRj4TzgluFvj9rgxvINqpVcn5Mq8s79NoAbXRYoCJGPtARq
         3fbxmOY26howLc2is3L8SRN4OhjdG7TlYhCoQAlwc5hEAkUB6cjyEg9gR/lY6MFGWaFo
         XY1QnoI5/fYCBx+6zPNQicgXyoX7+P5go56RDwUxM6shwfCJKKLzg7K5qujdE5rMcTEh
         TAhI65Cm8j79oYCRr0kSkIa0XYgfN7LLgZaw0DnHvf5MP8+UFuvrd2KEfN9k3ym7aGLp
         ZzUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=L00YIbrKDzzkZYycDncaqE3HMvA9FpbAU5f9CoxFhR0=;
        b=PoyWRaphd6TolzH9h8oCYt933xY8iWZeepa2KrhqKYvHAJ7UxMI5/FVQfZJHBTgGgf
         XZzJQsKhm1XFvmc6hc6Ese/LMscwp10+lLfYn8sMwoDfxkwvRcw/v96onEcvtiuWO/lF
         xB5u70LlPsvXG3xIES2hm7rpap6vckD2vhJ4EFfJjrdJO6xZKHUnwlKWHFjFzZvUHThh
         S1szhOBV1kwNkX15KFM5i32bf0feiW8nvMKeWJ12f7NjeRD45ThQ27jFoq9bsKgYvpWK
         qgDpMUaIPw/wZeA7U/5SqdjFoOXXVH1WGEf4mClO/HIHRRY47ZF+7UKqzt10ooymgBV2
         xRAA==
X-Gm-Message-State: APjAAAUmBHTdeERBHTKKgD/RrM7tVbG57a4Cc54dh3za5WginAmxgjUk
        bLZmS/q0HMT/IIoAJYpVIe8=
X-Google-Smtp-Source: APXvYqznCxw+fPXVlwbUtB8atvLbOitIBeaUAoe7B44PC0EWWUMijzt2AEJiF6mwzQ7BviMdOaLZnw==
X-Received: by 2002:a63:447:: with SMTP id 68mr119756577pge.364.1578402641194;
        Tue, 07 Jan 2020 05:10:41 -0800 (PST)
Received: from localhost.corp.microsoft.com ([167.220.255.5])
        by smtp.googlemail.com with ESMTPSA id m71sm27522400pje.0.2020.01.07.05.10.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 Jan 2020 05:10:40 -0800 (PST)
From:   lantianyu1986@gmail.com
X-Google-Original-From: Tianyu.Lan@microsoft.com
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        sashal@kernel.org, michael.h.kelley@microsoft.com, david@redhat.com
Cc:     Tianyu Lan <Tianyu.Lan@microsoft.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        vkuznets@redhat.com, eric.devolder@oracle.com
Subject: [RFC PATCH V2 10/10] x86/Hyper-V: Workaround Hyper-V unballoon msg bug
Date:   Tue,  7 Jan 2020 21:09:50 +0800
Message-Id: <20200107130950.2983-11-Tianyu.Lan@microsoft.com>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20200107130950.2983-1-Tianyu.Lan@microsoft.com>
References: <20200107130950.2983-1-Tianyu.Lan@microsoft.com>
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Tianyu Lan <Tianyu.Lan@microsoft.com>

Hyper-V sends unballoon msg instead of mem hot add msg in some
case. System doesn't receive balloon msg before unballoon msg
and this will cause balloon_down() to produce warning of
free non-exist memory. Workaround the issue via treating
unballoon msg as mem hot-add msg when mem hot-add is
enabled.

Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
---
 drivers/hv/hv_balloon.c | 116 +++++++++++++++++++++++++++---------------------
 1 file changed, 66 insertions(+), 50 deletions(-)

diff --git a/drivers/hv/hv_balloon.c b/drivers/hv/hv_balloon.c
index 5aaae62955bf..7f3e7ab22d5d 100644
--- a/drivers/hv/hv_balloon.c
+++ b/drivers/hv/hv_balloon.c
@@ -486,6 +486,9 @@ union dm_msg_info {
 	struct {
 		__u32 num_pages;
 	} balloon_state;
+	struct {
+		struct dm_unballoon_request *request;
+	} unballoon_state;
 	struct {
 		union dm_mem_page_range ha_page_range;
 		union dm_mem_page_range ha_region_range;
@@ -1155,6 +1158,21 @@ static unsigned long process_hot_add(unsigned long pg_start,
 		return pfn_cnt;
 	}
 
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
+
+		rg_start = (pg_start / HA_CHUNK) * HA_CHUNK;
+	}
+
 	if (!dm_device.host_specified_ha_region) {
 		covered = pfn_covered(pg_start, pfn_cnt);
 		if (covered < 0)
@@ -1488,28 +1506,6 @@ static void hot_add_req(union dm_msg_info *msg_info)
 	rg_start = msg_info->hot_add.ha_region_range.finfo.start_page;
 	rg_sz = msg_info->hot_add.ha_region_range.finfo.page_cnt;
 
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
@@ -1823,41 +1819,37 @@ static void balloon_up(union dm_msg_info *msg_info)
 
 }
 
-static void dm_msg_work(struct work_struct *dummy)
-{
-	union dm_msg_info *msg_info = &dm_device.dm_wrk.dm_msg;
-
-	switch (dm_device.dm_wrk.msg_type) {
-	case DM_BALLOON_REQUEST:
-		balloon_up(msg_info);
-		break;
-	case DM_MEM_HOT_ADD_REQUEST:
-		hot_add_req(msg_info);
-		break;
-	case DM_MEM_HOT_REMOVE_REQUEST:
-		hot_remove_req(msg_info);
-		break;
-	default:
-		return;
-	}
-}
-
-static void balloon_down(struct hv_dynmem_device *dm,
-			struct dm_unballoon_request *req)
+static void balloon_down(union dm_msg_info *msg_info)
 {
+	struct dm_unballoon_request *req = msg_info->unballoon_state.request;
 	union dm_mem_page_range *range_array = req->range_array;
+	struct hv_dynmem_device *dm = &dm_device;
+	unsigned int prev_pages_ballooned = dm->num_pages_ballooned;
 	int range_count = req->range_count;
 	struct dm_unballoon_response resp;
 	int i;
-	unsigned int prev_pages_ballooned = dm->num_pages_ballooned;
 
 	for (i = 0; i < range_count; i++) {
-		free_balloon_pages(dm, &range_array[i]);
-		complete(&dm_device.config_event);
+		/*
+		 * Hyper-V has a bug that send unballoon msg instead
+		 * of hot add msg even if there is no balloon msg sent
+		 * before. Treat all unballoon msgs as hot add msgs
+		 * if hot add capability is enabled.
+		 */
+		if (IS_ENABLED(CONFIG_MEMORY_HOTPLUG) && do_hot_add) {
+			dm->host_specified_ha_region = false;
+			dm->num_pages_added +=
+				process_hot_add(range_array[i].finfo.start_page,
+				range_array[i].finfo.page_cnt, 0, 0);
+		} else {
+			free_balloon_pages(dm, &range_array[i]);
+			complete(&dm_device.config_event);
+		}
 	}
 
-	pr_debug("Freed %u ballooned pages.\n",
-		prev_pages_ballooned - dm->num_pages_ballooned);
+	if (!do_hot_add)
+		pr_debug("Freed %u ballooned pages.\n",
+			prev_pages_ballooned - dm->num_pages_ballooned);
 
 	if (req->more_pages == 1)
 		return;
@@ -1875,6 +1867,28 @@ static void balloon_down(struct hv_dynmem_device *dm,
 	dm->state = DM_INITIALIZED;
 }
 
+static void dm_msg_work(struct work_struct *dummy)
+{
+	union dm_msg_info *msg_info = &dm_device.dm_wrk.dm_msg;
+
+	switch (dm_device.dm_wrk.msg_type) {
+	case DM_BALLOON_REQUEST:
+		balloon_up(msg_info);
+		break;
+	case DM_UNBALLOON_REQUEST:
+		balloon_down(msg_info);
+		break;
+	case DM_MEM_HOT_ADD_REQUEST:
+		hot_add_req(msg_info);
+		break;
+	case DM_MEM_HOT_REMOVE_REQUEST:
+		hot_remove_req(msg_info);
+		break;
+	default:
+		return;
+	}
+}
+
 static void balloon_onchannelcallback(void *context);
 
 static int dm_thread_func(void *dm_dev)
@@ -2024,8 +2038,10 @@ static void balloon_onchannelcallback(void *context)
 			}
 
 			dm->state = DM_BALLOON_DOWN;
-			balloon_down(dm,
-				 (struct dm_unballoon_request *)recv_buffer);
+			dm_wrk->msg_type = DM_UNBALLOON_REQUEST;
+			msg_info->unballoon_state.request
+				= (struct dm_unballoon_request *)recv_buffer;
+			schedule_work(&dm_wrk->wrk);
 			break;
 
 		case DM_MEM_HOT_ADD_REQUEST:
-- 
2.14.5

