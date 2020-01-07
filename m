Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE6E7132739
	for <lists+linux-hyperv@lfdr.de>; Tue,  7 Jan 2020 14:10:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727975AbgAGNKU (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 7 Jan 2020 08:10:20 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38084 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727814AbgAGNKU (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 7 Jan 2020 08:10:20 -0500
Received: by mail-pf1-f194.google.com with SMTP id x185so28592717pfc.5;
        Tue, 07 Jan 2020 05:10:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yDdbHS4WjgQTjAJRgdeh1BfRON47bl8bqcm6kJmN9nQ=;
        b=rBR3TlODvd0MzYIQtFqldULdMMZz64ucILNBpLOpH3Wj7htWOMlWNHZ0Zui+r3UJBa
         0Bw4WZ1kThNBxfI6CkXhJfDdfy0FIBl56ELEsW0z6nvbLIelRJany5uhSy5hnkZgEKje
         8gMlskFknudaj+TuROD+ry7KCg+riLqz0xKaUI8JHfkO8uhu0RJ7aqSJXQgV7q6Y89g/
         h9TGKKvX4hLQ1ic9RyOljoDTn7ZIRLD3aHoM3TlQw7m8iLU51DX/rxnpQF29Ri5TqBZY
         gVNvGr0J78pes+bDCQnf+/aki4CMQ30FLTzaOHoL7Xa36z5aamwAof8ikAMMJDFTNaKs
         xvXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yDdbHS4WjgQTjAJRgdeh1BfRON47bl8bqcm6kJmN9nQ=;
        b=H7GPOGlSWnFedOFtU1bjGlUauHyMGGEX6Sh8BCqaCfEJvGVmMNQbgJHn6hdMzeIy5f
         AhcKMwfGKA6VBzQvqF6is2jwpVWc/z5rWeKKQ2YjGRVxieOEdAUd8pQFriYFzxN0rnct
         Dnvb9wPUN08/P2EwWhnRPCo8A0ENuNlNxs21+UFxAPTiwdl+HYVQOMQ/XxAaRQuG34uQ
         a4qrboYb86DiefJLvHUNYo+nOGSMJPdJ162trapwX5EiWbQxrbFE5jZzp8FDxrbkZAqd
         FKvxdrSmhAJwEap/w4Db04zFvzH8a+xL/WnUWcG3blQ4a38DdphaIuLSLPALdkss925S
         8MQw==
X-Gm-Message-State: APjAAAVDL5qEEMTVseDp+chFE+qC4u0YM5MsDVApJWMPo2ELfNekbV/P
        Hi62EKop5VNmw0xOKi3Ctd4=
X-Google-Smtp-Source: APXvYqyRDrHcT8Fp/RKixefeLfAFW8DeRf/C/073UEgRt+zYq5dhXL5f0kOiy84EmljM/Sb6jtcryg==
X-Received: by 2002:a63:2d44:: with SMTP id t65mr122306192pgt.112.1578402619350;
        Tue, 07 Jan 2020 05:10:19 -0800 (PST)
Received: from localhost.corp.microsoft.com ([167.220.255.5])
        by smtp.googlemail.com with ESMTPSA id m71sm27522400pje.0.2020.01.07.05.10.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 Jan 2020 05:10:18 -0800 (PST)
From:   lantianyu1986@gmail.com
X-Google-Original-From: Tianyu.Lan@microsoft.com
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        sashal@kernel.org, michael.h.kelley@microsoft.com, david@redhat.com
Cc:     Tianyu Lan <Tianyu.Lan@microsoft.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        vkuznets@redhat.com, eric.devolder@oracle.com
Subject: [RFC PATCH V2 4/10] x86/Hyper-V/Balloon: Convert spin lock ha_lock to mutex
Date:   Tue,  7 Jan 2020 21:09:44 +0800
Message-Id: <20200107130950.2983-5-Tianyu.Lan@microsoft.com>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20200107130950.2983-1-Tianyu.Lan@microsoft.com>
References: <20200107130950.2983-1-Tianyu.Lan@microsoft.com>
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Tianyu Lan <Tianyu.Lan@microsoft.com>

ha_lock is to protect ha_region_list and is hold in process
context. When process mem hot add msg, add_memory() will be
called in the loop of traversing ha_region_list in order to
find associated ha region. add_memory() holds device_hotplug_lock
mutex and ha_lock is also hold in hv_online_page() which is
called inside add_memory(). So current code needs to release
ha_lock before calling add_memory() in order to avoid holding
mutex under spin lock protection and holding ha_lock twice
which may cause dead lock. When implement mem hot remove, also
have such issue. To avoid releasing ha_lock in the loop of
traversing ha_region_list and simplify code, convert ha_lock
from spin lock to mutex first.

Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
---
 drivers/hv/hv_balloon.c | 49 ++++++++++++++++++++++---------------------------
 1 file changed, 22 insertions(+), 27 deletions(-)

diff --git a/drivers/hv/hv_balloon.c b/drivers/hv/hv_balloon.c
index bdb6791e6de1..185146795122 100644
--- a/drivers/hv/hv_balloon.c
+++ b/drivers/hv/hv_balloon.c
@@ -546,7 +546,7 @@ struct hv_dynmem_device {
 	 * Protects ha_region_list, num_pages_onlined counter and individual
 	 * regions from ha_region_list.
 	 */
-	spinlock_t ha_lock;
+	struct mutex ha_lock;
 
 	/*
 	 * A list of hot-add regions.
@@ -629,7 +629,7 @@ static int hv_memory_notifier(struct notifier_block *nb, unsigned long val,
 			      void *v)
 {
 	struct memory_notify *mem = (struct memory_notify *)v;
-	unsigned long flags, pfn_count;
+	unsigned long pfn_count;
 
 	switch (val) {
 	case MEM_ONLINE:
@@ -641,7 +641,7 @@ static int hv_memory_notifier(struct notifier_block *nb, unsigned long val,
 		break;
 
 	case MEM_OFFLINE:
-		spin_lock_irqsave(&dm_device.ha_lock, flags);
+		mutex_lock(&dm_device.ha_lock);
 		pfn_count = hv_page_offline_check(mem->start_pfn,
 						  mem->nr_pages);
 		if (pfn_count <= dm_device.num_pages_onlined) {
@@ -655,7 +655,7 @@ static int hv_memory_notifier(struct notifier_block *nb, unsigned long val,
 			WARN_ON_ONCE(1);
 			dm_device.num_pages_onlined = 0;
 		}
-		spin_unlock_irqrestore(&dm_device.ha_lock, flags);
+		mutex_unlock(&dm_device.ha_lock);
 		break;
 	case MEM_GOING_ONLINE:
 	case MEM_GOING_OFFLINE:
@@ -707,12 +707,11 @@ static void hv_mem_hot_add(unsigned long start, unsigned long size,
 	unsigned long start_pfn;
 	unsigned long processed_pfn;
 	unsigned long total_pfn = pfn_count;
-	unsigned long flags;
 
 	for (i = 0; i < (size/HA_CHUNK); i++) {
 		start_pfn = start + (i * HA_CHUNK);
 
-		spin_lock_irqsave(&dm_device.ha_lock, flags);
+		mutex_lock(&dm_device.ha_lock);
 		has->ha_end_pfn +=  HA_CHUNK;
 
 		if (total_pfn > HA_CHUNK) {
@@ -724,7 +723,7 @@ static void hv_mem_hot_add(unsigned long start, unsigned long size,
 		}
 
 		has->covered_end_pfn +=  processed_pfn;
-		spin_unlock_irqrestore(&dm_device.ha_lock, flags);
+		mutex_unlock(&dm_device.ha_lock);
 
 		init_completion(&dm_device.ol_waitevent);
 		dm_device.ha_waiting = !memhp_auto_online;
@@ -745,10 +744,10 @@ static void hv_mem_hot_add(unsigned long start, unsigned long size,
 				 */
 				do_hot_add = false;
 			}
-			spin_lock_irqsave(&dm_device.ha_lock, flags);
+			mutex_lock(&dm_device.ha_lock);
 			has->ha_end_pfn -= HA_CHUNK;
 			has->covered_end_pfn -=  processed_pfn;
-			spin_unlock_irqrestore(&dm_device.ha_lock, flags);
+			mutex_unlock(&dm_device.ha_lock);
 			break;
 		}
 
@@ -769,10 +768,9 @@ static void hv_mem_hot_add(unsigned long start, unsigned long size,
 static void hv_online_page(struct page *pg, unsigned int order)
 {
 	struct hv_hotadd_state *has;
-	unsigned long flags;
 	unsigned long pfn = page_to_pfn(pg);
 
-	spin_lock_irqsave(&dm_device.ha_lock, flags);
+	mutex_lock(&dm_device.ha_lock);
 	list_for_each_entry(has, &dm_device.ha_region_list, list) {
 		/* The page belongs to a different HAS. */
 		if ((pfn < has->start_pfn) ||
@@ -782,7 +780,7 @@ static void hv_online_page(struct page *pg, unsigned int order)
 		hv_bring_pgs_online(has, pfn, 1UL << order);
 		break;
 	}
-	spin_unlock_irqrestore(&dm_device.ha_lock, flags);
+	mutex_unlock(&dm_device.ha_lock);
 }
 
 static int pfn_covered(unsigned long start_pfn, unsigned long pfn_cnt)
@@ -791,9 +789,8 @@ static int pfn_covered(unsigned long start_pfn, unsigned long pfn_cnt)
 	struct hv_hotadd_gap *gap;
 	unsigned long residual, new_inc;
 	int ret = 0;
-	unsigned long flags;
 
-	spin_lock_irqsave(&dm_device.ha_lock, flags);
+	mutex_lock(&dm_device.ha_lock);
 	list_for_each_entry(has, &dm_device.ha_region_list, list) {
 		/*
 		 * If the pfn range we are dealing with is not in the current
@@ -840,7 +837,7 @@ static int pfn_covered(unsigned long start_pfn, unsigned long pfn_cnt)
 		ret = 1;
 		break;
 	}
-	spin_unlock_irqrestore(&dm_device.ha_lock, flags);
+	mutex_unlock(&dm_device.ha_lock);
 
 	return ret;
 }
@@ -854,12 +851,12 @@ static unsigned long handle_pg_range(unsigned long pg_start,
 	struct hv_hotadd_state *has;
 	unsigned long pgs_ol = 0;
 	unsigned long old_covered_state;
-	unsigned long res = 0, flags;
+	unsigned long res = 0;
 
 	pr_debug("Hot adding %lu pages starting at pfn 0x%lx.\n", pg_count,
 		pg_start);
 
-	spin_lock_irqsave(&dm_device.ha_lock, flags);
+	mutex_lock(&dm_device.ha_lock);
 	list_for_each_entry(has, &dm_device.ha_region_list, list) {
 		/*
 		 * If the pfn range we are dealing with is not in the current
@@ -912,9 +909,9 @@ static unsigned long handle_pg_range(unsigned long pg_start,
 			} else {
 				pfn_cnt = size;
 			}
-			spin_unlock_irqrestore(&dm_device.ha_lock, flags);
+			mutex_unlock(&dm_device.ha_lock);
 			hv_mem_hot_add(has->ha_end_pfn, size, pfn_cnt, has);
-			spin_lock_irqsave(&dm_device.ha_lock, flags);
+			mutex_lock(&dm_device.ha_lock);
 		}
 		/*
 		 * If we managed to online any pages that were given to us,
@@ -923,7 +920,7 @@ static unsigned long handle_pg_range(unsigned long pg_start,
 		res = has->covered_end_pfn - old_covered_state;
 		break;
 	}
-	spin_unlock_irqrestore(&dm_device.ha_lock, flags);
+	mutex_unlock(&dm_device.ha_lock);
 
 	return res;
 }
@@ -935,7 +932,6 @@ static unsigned long process_hot_add(unsigned long pg_start,
 {
 	struct hv_hotadd_state *ha_region = NULL;
 	int covered;
-	unsigned long flags;
 
 	if (pfn_cnt == 0)
 		return 0;
@@ -967,9 +963,9 @@ static unsigned long process_hot_add(unsigned long pg_start,
 		ha_region->covered_end_pfn = pg_start;
 		ha_region->end_pfn = rg_start + rg_size;
 
-		spin_lock_irqsave(&dm_device.ha_lock, flags);
+		mutex_lock(&dm_device.ha_lock);
 		list_add_tail(&ha_region->list, &dm_device.ha_region_list);
-		spin_unlock_irqrestore(&dm_device.ha_lock, flags);
+		mutex_unlock(&dm_device.ha_lock);
 	}
 
 do_pg_range:
@@ -1727,7 +1723,7 @@ static int balloon_probe(struct hv_device *dev,
 	init_completion(&dm_device.host_event);
 	init_completion(&dm_device.config_event);
 	INIT_LIST_HEAD(&dm_device.ha_region_list);
-	spin_lock_init(&dm_device.ha_lock);
+	mutex_init(&dm_device.ha_lock);
 	INIT_WORK(&dm_device.dm_wrk.wrk, dm_msg_work);
 	dm_device.host_specified_ha_region = false;
 
@@ -1769,7 +1765,6 @@ static int balloon_remove(struct hv_device *dev)
 	struct hv_dynmem_device *dm = hv_get_drvdata(dev);
 	struct hv_hotadd_state *has, *tmp;
 	struct hv_hotadd_gap *gap, *tmp_gap;
-	unsigned long flags;
 
 	if (dm->num_pages_ballooned != 0)
 		pr_warn("Ballooned pages: %d\n", dm->num_pages_ballooned);
@@ -1782,7 +1777,7 @@ static int balloon_remove(struct hv_device *dev)
 	unregister_memory_notifier(&hv_memory_nb);
 	restore_online_page_callback(&hv_online_page);
 #endif
-	spin_lock_irqsave(&dm_device.ha_lock, flags);
+	mutex_lock(&dm_device.ha_lock);
 	list_for_each_entry_safe(has, tmp, &dm->ha_region_list, list) {
 		list_for_each_entry_safe(gap, tmp_gap, &has->gap_list, list) {
 			list_del(&gap->list);
@@ -1791,7 +1786,7 @@ static int balloon_remove(struct hv_device *dev)
 		list_del(&has->list);
 		kfree(has);
 	}
-	spin_unlock_irqrestore(&dm_device.ha_lock, flags);
+	mutex_unlock(&dm_device.ha_lock);
 
 	return 0;
 }
-- 
2.14.5

