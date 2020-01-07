Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6B8213273B
	for <lists+linux-hyperv@lfdr.de>; Tue,  7 Jan 2020 14:10:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728248AbgAGNKY (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 7 Jan 2020 08:10:24 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40028 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727814AbgAGNKX (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 7 Jan 2020 08:10:23 -0500
Received: by mail-pf1-f193.google.com with SMTP id q8so28591599pfh.7;
        Tue, 07 Jan 2020 05:10:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RaAjzUEIlPB8dHsGAxIqpIrbg0uPC0pABUcdUx5ADdc=;
        b=A3lGV6V4UlouKWdh9++A16QLihDszm8/31Hf3r8CvmMeIj5wV+azJNtNh/dLBiRFmf
         AsHdi9GSe7Mi632CHVh9/Fqh9cZg71ejSEeKknGIb6QkGfjMUjzN9+P8HW3HjF4qBXO/
         t1KT2NY5pDMb8FQQ1wRTWXphJ0pEFN54YTK752L1Gzky1NpzYzhJMbEje3Rt23j8uZ4y
         Q7Phwl/BqrmQbXUWUmSuiayl/5+JK6PbjsjsMHfouQScTV6uP1EYlbN218M/pZ9IW6m3
         lBlEV81FNI5iIZwri2s6QIKo2x0UHcXJsgQVO/SSsHNFu75krdRjHtiWdGRexPS8SK2n
         hwJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RaAjzUEIlPB8dHsGAxIqpIrbg0uPC0pABUcdUx5ADdc=;
        b=cLcKVq5hXl8QFNZYOfIpG6dbzLZTfR6VUxPIHih48KMMhzRlXEVb6mU8RFFIKhYA6B
         2igijTc+USKGqIVfQ/iEVmnkAol8X875w3FHFNrTeoZuOJoUwUJx+q+2Urv3U6zaWkgl
         O48G11Vf6atXOuyLZrSjbU6rrI1lHreLAa+6RH7iIajBQT0zImJFYraW5TXPZAfGvaJs
         b0M6p1ZPwtWE/AQzUpk9jCzUXqzSCViOSGio5NVXfZQDSfojeO8Mk7uL7xFokOgjF7NW
         CFJVgvAwei4ckJ58wUlhF2hTvhLMdSHSb9TdDHINen9Vpmi9k7CZlkoa4j4gDlvQOfRT
         FQcA==
X-Gm-Message-State: APjAAAXcKtmgX9l2073ZvkYppGK/KTtcyfnO/RGMlYdPKrwnPIY927Pe
        UP/68VDXQIlbIWzi1t23gU4=
X-Google-Smtp-Source: APXvYqzzW7OVvz54/4NAC8+Y5xPynKtH1cDHFNthbzbRZ+11LHmIo2dx++5O6uEEZAg2JXnw5C8s9A==
X-Received: by 2002:aa7:874a:: with SMTP id g10mr96012117pfo.205.1578402622880;
        Tue, 07 Jan 2020 05:10:22 -0800 (PST)
Received: from localhost.corp.microsoft.com ([167.220.255.5])
        by smtp.googlemail.com with ESMTPSA id m71sm27522400pje.0.2020.01.07.05.10.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 Jan 2020 05:10:22 -0800 (PST)
From:   lantianyu1986@gmail.com
X-Google-Original-From: Tianyu.Lan@microsoft.com
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        sashal@kernel.org, michael.h.kelley@microsoft.com, david@redhat.com
Cc:     Tianyu Lan <Tianyu.Lan@microsoft.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        vkuznets@redhat.com, eric.devolder@oracle.com
Subject: [RFC PATCH V2 5/10] x86/Hyper-V/Balloon: Avoid releasing ha_lock when traverse ha_region_list
Date:   Tue,  7 Jan 2020 21:09:45 +0800
Message-Id: <20200107130950.2983-6-Tianyu.Lan@microsoft.com>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20200107130950.2983-1-Tianyu.Lan@microsoft.com>
References: <20200107130950.2983-1-Tianyu.Lan@microsoft.com>
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Tianyu Lan <Tianyu.Lan@microsoft.com>

ha_lock is to protect ha_region_list. It is held in
hv_online_page() and handle_pg_range(). handle_pg_range()
is to traverse ha region list, find associated hot-add region
and add memory into system. hv_online_page() is called inside
of add_memory(). Current code is to release ha_lock before
calling add_memory() to avoid holding ha_lock twice in the
hv_online_page().

To avoid releasing ha_lock, add "lock_thread" in the struct hv_
dynmem_device to record thread of traversing ha region list,
check "lock_thread" in the hv_online_page() and try holding
ha_lock when current thread is not "lock_thread".

Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
---
 drivers/hv/hv_balloon.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/hv/hv_balloon.c b/drivers/hv/hv_balloon.c
index 185146795122..729dc5551302 100644
--- a/drivers/hv/hv_balloon.c
+++ b/drivers/hv/hv_balloon.c
@@ -547,6 +547,7 @@ struct hv_dynmem_device {
 	 * regions from ha_region_list.
 	 */
 	struct mutex ha_lock;
+	struct task_struct *lock_thread;
 
 	/*
 	 * A list of hot-add regions.
@@ -711,7 +712,6 @@ static void hv_mem_hot_add(unsigned long start, unsigned long size,
 	for (i = 0; i < (size/HA_CHUNK); i++) {
 		start_pfn = start + (i * HA_CHUNK);
 
-		mutex_lock(&dm_device.ha_lock);
 		has->ha_end_pfn +=  HA_CHUNK;
 
 		if (total_pfn > HA_CHUNK) {
@@ -723,7 +723,6 @@ static void hv_mem_hot_add(unsigned long start, unsigned long size,
 		}
 
 		has->covered_end_pfn +=  processed_pfn;
-		mutex_unlock(&dm_device.ha_lock);
 
 		init_completion(&dm_device.ol_waitevent);
 		dm_device.ha_waiting = !memhp_auto_online;
@@ -744,10 +743,8 @@ static void hv_mem_hot_add(unsigned long start, unsigned long size,
 				 */
 				do_hot_add = false;
 			}
-			mutex_lock(&dm_device.ha_lock);
 			has->ha_end_pfn -= HA_CHUNK;
 			has->covered_end_pfn -=  processed_pfn;
-			mutex_unlock(&dm_device.ha_lock);
 			break;
 		}
 
@@ -769,8 +766,14 @@ static void hv_online_page(struct page *pg, unsigned int order)
 {
 	struct hv_hotadd_state *has;
 	unsigned long pfn = page_to_pfn(pg);
+	int need_unlock;
+
+	/* If current thread hasn't hold ha_lock, take ha_lock here. */
+	if (dm_device.lock_thread != current) {
+		mutex_lock(&dm_device.ha_lock);
+		need_unlock = 1;
+	}
 
-	mutex_lock(&dm_device.ha_lock);
 	list_for_each_entry(has, &dm_device.ha_region_list, list) {
 		/* The page belongs to a different HAS. */
 		if ((pfn < has->start_pfn) ||
@@ -780,7 +783,8 @@ static void hv_online_page(struct page *pg, unsigned int order)
 		hv_bring_pgs_online(has, pfn, 1UL << order);
 		break;
 	}
-	mutex_unlock(&dm_device.ha_lock);
+	if (need_unlock)
+		mutex_unlock(&dm_device.ha_lock);
 }
 
 static int pfn_covered(unsigned long start_pfn, unsigned long pfn_cnt)
@@ -857,6 +861,7 @@ static unsigned long handle_pg_range(unsigned long pg_start,
 		pg_start);
 
 	mutex_lock(&dm_device.ha_lock);
+	dm_device.lock_thread = current;
 	list_for_each_entry(has, &dm_device.ha_region_list, list) {
 		/*
 		 * If the pfn range we are dealing with is not in the current
@@ -909,9 +914,7 @@ static unsigned long handle_pg_range(unsigned long pg_start,
 			} else {
 				pfn_cnt = size;
 			}
-			mutex_unlock(&dm_device.ha_lock);
 			hv_mem_hot_add(has->ha_end_pfn, size, pfn_cnt, has);
-			mutex_lock(&dm_device.ha_lock);
 		}
 		/*
 		 * If we managed to online any pages that were given to us,
@@ -920,6 +923,7 @@ static unsigned long handle_pg_range(unsigned long pg_start,
 		res = has->covered_end_pfn - old_covered_state;
 		break;
 	}
+	dm_device.lock_thread = NULL;
 	mutex_unlock(&dm_device.ha_lock);
 
 	return res;
-- 
2.14.5

