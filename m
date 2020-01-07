Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01C1E132737
	for <lists+linux-hyperv@lfdr.de>; Tue,  7 Jan 2020 14:10:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728227AbgAGNKR (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 7 Jan 2020 08:10:17 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:32908 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727814AbgAGNKQ (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 7 Jan 2020 08:10:16 -0500
Received: by mail-pl1-f196.google.com with SMTP id c13so23203026pls.0;
        Tue, 07 Jan 2020 05:10:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UflshzX9upCooqlbNBULwQW482Y7iZonDkQ2ZqdJtWY=;
        b=cm37evqN7sDVRyad7IRkV3SiLVlNZYjCjyTcvyh0Mk6KL+8oHJJy95dcoSMFBh7hCF
         LNAC8xe8iv2WX2ddi02NqU7B6VX6p9gWAWAz5nCZxAcyl77dzF1aZM803LQcCNhe548M
         daqN2pcW1it7uDBzCEyyCUyp1bfoel3FL5w7bVfm5PKBdQius8R6E3ODbySTmpAU2g46
         DyUSJ6uWAOBoT4s1F0C4H63GY0x+Spuub+yyq7QdJLkO3e8WHOa27iIg2dI49Ilk1Los
         Nbw58bDOQ0DdjKZjD4ArtESRdiT6WrA8f+yW9MLBVbKxY/QLXTar8Ow+q/i2a6ObT9pg
         q4zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UflshzX9upCooqlbNBULwQW482Y7iZonDkQ2ZqdJtWY=;
        b=enfzdY6dyCgNh0fh3rIjpys/d7vrW052GsY6Gz5gRcGLHTudyvM8j7WHbNxu3wwcDN
         OB7mK3vi+RXFheg+nJv97DJ/3pXo8naogCiuDPfoL1gIYQElNTsI8LintT8VhBW+ALJp
         k9qEoZfYnP1hPmpj7PIuQuXNhFD5hX7xwSVTxpk+/p9XRkLk9PXKYiJu8Aa5kDwzrqYv
         m/pDSvV9WKItFerBfl0IwpzfYBB5yrX+BbBB4ERFmwqRozVo6xcmycDEMR2Z5qN8ZPCr
         fPbhiWOWaGZBvu97qB+QiNX7auBgW8xwtPSFCOOtH/WXEgK3zV6rA2N+KPzkW0Au58WM
         63IQ==
X-Gm-Message-State: APjAAAXBY5kuiBwsCkBnWTNCGjiyQMqRCWb5QLeC2RjIwAxttXvpu6iR
        WHh9Q6krhn5WO3iWsyutZ8k=
X-Google-Smtp-Source: APXvYqzKw2GZiH4ZELlsaqBO9ywSoN16CqOAq92Fxa4UiPtcEkV1/H1hnCdeG+ycBVl8GcMy8sO69Q==
X-Received: by 2002:a17:90a:a88f:: with SMTP id h15mr50246848pjq.32.1578402615841;
        Tue, 07 Jan 2020 05:10:15 -0800 (PST)
Received: from localhost.corp.microsoft.com ([167.220.255.5])
        by smtp.googlemail.com with ESMTPSA id m71sm27522400pje.0.2020.01.07.05.10.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 Jan 2020 05:10:15 -0800 (PST)
From:   lantianyu1986@gmail.com
X-Google-Original-From: Tianyu.Lan@microsoft.com
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        sashal@kernel.org, michael.h.kelley@microsoft.com, david@redhat.com
Cc:     Tianyu Lan <Tianyu.Lan@microsoft.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        vkuznets@redhat.com, eric.devolder@oracle.com
Subject: [RFC PATCH V2 3/10] x86/Hyper-V/Balloon: Replace hot-add and balloon up works with a common work
Date:   Tue,  7 Jan 2020 21:09:43 +0800
Message-Id: <20200107130950.2983-4-Tianyu.Lan@microsoft.com>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20200107130950.2983-1-Tianyu.Lan@microsoft.com>
References: <20200107130950.2983-1-Tianyu.Lan@microsoft.com>
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Tianyu Lan <Tianyu.Lan@microsoft.com>

The mem hot-remove operation and balloon down will be added
or moved into work context. Add a common work to handle
opeations of mem hot-add/remove and balloon up/down.

Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
---
 drivers/hv/hv_balloon.c | 86 ++++++++++++++++++++++++++++++-------------------
 1 file changed, 52 insertions(+), 34 deletions(-)

diff --git a/drivers/hv/hv_balloon.c b/drivers/hv/hv_balloon.c
index b155d0052981..bdb6791e6de1 100644
--- a/drivers/hv/hv_balloon.c
+++ b/drivers/hv/hv_balloon.c
@@ -447,15 +447,20 @@ struct hv_hotadd_gap {
 	unsigned long end_pfn;
 };
 
-struct balloon_state {
-	__u32 num_pages;
-	struct work_struct wrk;
+union dm_msg_info {
+	struct {
+		__u32 num_pages;
+	} balloon_state;
+	struct {
+		union dm_mem_page_range ha_page_range;
+		union dm_mem_page_range ha_region_range;
+	} hot_add;
 };
 
-struct hot_add_wrk {
-	union dm_mem_page_range ha_page_range;
-	union dm_mem_page_range ha_region_range;
+struct dm_msg_wrk {
+	enum dm_message_type msg_type;
 	struct work_struct wrk;
+	union dm_msg_info dm_msg;
 };
 
 static bool allow_hibernation;
@@ -514,14 +519,9 @@ struct hv_dynmem_device {
 	unsigned int num_pages_added;
 
 	/*
-	 * State to manage the ballooning (up) operation.
+	 * State to manage the ballooning (up) and "hot-add" operation.
 	 */
-	struct balloon_state balloon_wrk;
-
-	/*
-	 * State to execute the "hot-add" operation.
-	 */
-	struct hot_add_wrk ha_wrk;
+	struct dm_msg_wrk dm_wrk;
 
 	/*
 	 * This state tracks if the host has specified a hot-add
@@ -982,7 +982,7 @@ static unsigned long process_hot_add(unsigned long pg_start,
 
 #endif
 
-static void hot_add_req(struct work_struct *dummy)
+static void hot_add_req(union dm_msg_info *msg_info)
 {
 	struct dm_hot_add_response resp;
 #ifdef CONFIG_MEMORY_HOTPLUG
@@ -996,11 +996,11 @@ static void hot_add_req(struct work_struct *dummy)
 	resp.hdr.size = sizeof(struct dm_hot_add_response);
 
 #ifdef CONFIG_MEMORY_HOTPLUG
-	pg_start = dm->ha_wrk.ha_page_range.finfo.start_page;
-	pfn_cnt = dm->ha_wrk.ha_page_range.finfo.page_cnt;
+	pg_start = msg_info->hot_add.ha_page_range.finfo.start_page;
+	pfn_cnt = msg_info->hot_add.ha_page_range.finfo.page_cnt;
 
-	rg_start = dm->ha_wrk.ha_region_range.finfo.start_page;
-	rg_sz = dm->ha_wrk.ha_region_range.finfo.page_cnt;
+	rg_start = msg_info->hot_add.ha_region_range.finfo.start_page;
+	rg_sz = msg_info->hot_add.ha_region_range.finfo.page_cnt;
 
 	if ((rg_start == 0) && (!dm->host_specified_ha_region)) {
 		unsigned long region_size;
@@ -1261,9 +1261,9 @@ static unsigned int alloc_balloon_pages(struct hv_dynmem_device *dm,
 	return num_pages;
 }
 
-static void balloon_up(struct work_struct *dummy)
+static void balloon_up(union dm_msg_info *msg_info)
 {
-	unsigned int num_pages = dm_device.balloon_wrk.num_pages;
+	unsigned int num_pages = msg_info->balloon_state.num_pages;
 	unsigned int num_ballooned = 0;
 	struct dm_balloon_response *bl_resp;
 	int alloc_unit;
@@ -1313,7 +1313,7 @@ static void balloon_up(struct work_struct *dummy)
 
 		if (num_ballooned == 0 || num_ballooned == num_pages) {
 			pr_debug("Ballooned %u out of %u requested pages.\n",
-				num_pages, dm_device.balloon_wrk.num_pages);
+				num_pages, msg_info->balloon_state.num_pages);
 
 			bl_resp->more_pages = 0;
 			done = true;
@@ -1355,6 +1355,22 @@ static void balloon_up(struct work_struct *dummy)
 
 }
 
+static void dm_msg_work(struct work_struct *dummy)
+{
+	union dm_msg_info *msg_info = &dm_device.dm_wrk.dm_msg;
+
+	switch (dm_device.dm_wrk.msg_type) {
+	case DM_BALLOON_REQUEST:
+		balloon_up(msg_info);
+		break;
+	case DM_MEM_HOT_ADD_REQUEST:
+		hot_add_req(msg_info);
+		break;
+	default:
+		return;
+	}
+}
+
 static void balloon_down(struct hv_dynmem_device *dm,
 			struct dm_unballoon_request *req)
 {
@@ -1490,6 +1506,8 @@ static void balloon_onchannelcallback(void *context)
 	struct hv_dynmem_device *dm = hv_get_drvdata(dev);
 	struct dm_balloon *bal_msg;
 	struct dm_hot_add *ha_msg;
+	struct dm_msg_wrk *dm_wrk = &dm_device.dm_wrk;
+	union dm_msg_info *msg_info = &dm_wrk->dm_msg;
 	union dm_mem_page_range *ha_pg_range;
 	union dm_mem_page_range *ha_region;
 
@@ -1522,8 +1540,9 @@ static void balloon_onchannelcallback(void *context)
 				pr_warn("Currently ballooning\n");
 			bal_msg = (struct dm_balloon *)recv_buffer;
 			dm->state = DM_BALLOON_UP;
-			dm_device.balloon_wrk.num_pages = bal_msg->num_pages;
-			schedule_work(&dm_device.balloon_wrk.wrk);
+			msg_info->balloon_state.num_pages = bal_msg->num_pages;
+			dm_wrk->msg_type = DM_BALLOON_REQUEST;
+			schedule_work(&dm_wrk->wrk);
 			break;
 
 		case DM_UNBALLOON_REQUEST:
@@ -1549,8 +1568,9 @@ static void balloon_onchannelcallback(void *context)
 				 */
 				dm->host_specified_ha_region = false;
 				ha_pg_range = &ha_msg->range;
-				dm->ha_wrk.ha_page_range = *ha_pg_range;
-				dm->ha_wrk.ha_region_range.page_range = 0;
+				msg_info->hot_add.ha_page_range = *ha_pg_range;
+				msg_info->hot_add.ha_region_range.page_range
+						= 0;
 			} else {
 				/*
 				 * Host is specifying that we first hot-add
@@ -1560,10 +1580,11 @@ static void balloon_onchannelcallback(void *context)
 				dm->host_specified_ha_region = true;
 				ha_pg_range = &ha_msg->range;
 				ha_region = &ha_pg_range[1];
-				dm->ha_wrk.ha_page_range = *ha_pg_range;
-				dm->ha_wrk.ha_region_range = *ha_region;
+				msg_info->hot_add.ha_page_range = *ha_pg_range;
+				msg_info->hot_add.ha_region_range = *ha_region;
 			}
-			schedule_work(&dm_device.ha_wrk.wrk);
+			dm_wrk->msg_type = DM_MEM_HOT_ADD_REQUEST;
+			schedule_work(&dm_wrk->wrk);
 			break;
 
 		case DM_INFO_MESSAGE:
@@ -1707,8 +1728,7 @@ static int balloon_probe(struct hv_device *dev,
 	init_completion(&dm_device.config_event);
 	INIT_LIST_HEAD(&dm_device.ha_region_list);
 	spin_lock_init(&dm_device.ha_lock);
-	INIT_WORK(&dm_device.balloon_wrk.wrk, balloon_up);
-	INIT_WORK(&dm_device.ha_wrk.wrk, hot_add_req);
+	INIT_WORK(&dm_device.dm_wrk.wrk, dm_msg_work);
 	dm_device.host_specified_ha_region = false;
 
 #ifdef CONFIG_MEMORY_HOTPLUG
@@ -1754,8 +1774,7 @@ static int balloon_remove(struct hv_device *dev)
 	if (dm->num_pages_ballooned != 0)
 		pr_warn("Ballooned pages: %d\n", dm->num_pages_ballooned);
 
-	cancel_work_sync(&dm->balloon_wrk.wrk);
-	cancel_work_sync(&dm->ha_wrk.wrk);
+	cancel_work_sync(&dm->dm_wrk.wrk);
 
 	kthread_stop(dm->thread);
 	vmbus_close(dev->channel);
@@ -1783,8 +1802,7 @@ static int balloon_suspend(struct hv_device *hv_dev)
 
 	tasklet_disable(&hv_dev->channel->callback_event);
 
-	cancel_work_sync(&dm->balloon_wrk.wrk);
-	cancel_work_sync(&dm->ha_wrk.wrk);
+	cancel_work_sync(&dm->dm_wrk.wrk);
 
 	if (dm->thread) {
 		kthread_stop(dm->thread);
-- 
2.14.5

