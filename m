Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D14A118CE8
	for <lists+linux-hyperv@lfdr.de>; Tue, 10 Dec 2019 16:46:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727211AbfLJPqj (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 10 Dec 2019 10:46:39 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:43595 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727178AbfLJPqi (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 10 Dec 2019 10:46:38 -0500
Received: by mail-pj1-f66.google.com with SMTP id g4so7554092pjs.10;
        Tue, 10 Dec 2019 07:46:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=efMs4BaPsdKlrr69d47XF19BPlJzE5HVipCqjkEBOKE=;
        b=gmpIQC2GeFFuHpKpkZGYr+FG5KGc1n+uIAXp3Om+D0LpZ3ooLAUYmHwIE5C1g5KoMl
         q7xVn7I97A6zFmShp7JojyWFQbxOY7RlSlDjcjrQmXCqIVgxL49Jers5MSjXEG7mkgYv
         Se8iwUGEFYm2nkyirfQR2NmYkRkXLRXNZ04In9f8OI5x13pfm1WTzvPr6iy4p76UORsI
         kQKswn31EDEzTUjsppS95Cx4wJAMlXTbaRwJUrxJ7knlbFeAYNKMqfP3zzluvOpSnvSL
         5vS00SYJKlS0mfgURVsmkP5iZ8FBH1Zlmc9RUvYgrLwBjpZIt1mVGaoVXqs4u/nsPO1I
         f9Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=efMs4BaPsdKlrr69d47XF19BPlJzE5HVipCqjkEBOKE=;
        b=nV8KZiLkL2HMrL1A2kK+HEAwxQuLpd92/XrjOcQECucoye0D7HsDR7GDTPfghiwgna
         uxzYCEH8i4Z94kl5iUuaY0wtCbNZcMDAQqYV8scIZbJAYc2AX5GWXAnS5tesyL4TmBJY
         Df9BIHW61ZhWxMvTU7dCPlDZ4cR0xyjYt67hghNkBDg2HBAX1mjlE8e/B8aC7c0aZW/4
         6JD1JeY1D/XaNnCbL/kK+OB2XqsNdo2dFJHwAP4t/pL+lnw5m/bBAdG5lyUWrmSw7gs1
         TCtdrnnwlPMDaC0DVujp0V+2eh+5NdRfiogyV9GQQZDodevmc3589OdFvxMQMxI60aCH
         xKFg==
X-Gm-Message-State: APjAAAU8wUtGPp1kXflzD8JEy28j/ZxEKTGU6oJUTjmB0RAUgIoq5MI7
        oiWSbZMIyq2f/DgBd0S0gO/axqJ/aHA=
X-Google-Smtp-Source: APXvYqzJnWGH+5ViV+uaKrbFy0ZSj2BQh7rh4Bq9tFoakRUOqFrOtP3eP1HalqrpZmomIS+XJ0zraA==
X-Received: by 2002:a17:90b:30c4:: with SMTP id hi4mr6224616pjb.62.1575992797815;
        Tue, 10 Dec 2019 07:46:37 -0800 (PST)
Received: from localhost.corp.microsoft.com ([167.220.255.5])
        by smtp.googlemail.com with ESMTPSA id k13sm4113815pfp.48.2019.12.10.07.46.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 10 Dec 2019 07:46:37 -0800 (PST)
From:   lantianyu1986@gmail.com
X-Google-Original-From: Tianyu.Lan@microsoft.com
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        sashal@kernel.org, michael.h.kelley@microsoft.com
Cc:     Tianyu Lan <Tianyu.Lan@microsoft.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        vkuznets@redhat.com, eric.devolder@oracle.com
Subject: [RFC PATCH 3/4] Hyper-V/Balloon: Call add_memory() with dm_device.ha_lock.
Date:   Tue, 10 Dec 2019 23:46:10 +0800
Message-Id: <20191210154611.10958-4-Tianyu.Lan@microsoft.com>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20191210154611.10958-1-Tianyu.Lan@microsoft.com>
References: <20191210154611.10958-1-Tianyu.Lan@microsoft.com>
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Tianyu Lan <Tianyu.Lan@microsoft.com>

The ha_lock is to protect hot-add region list ha_region_list.
When Hyper-V delivers hot-add memory message, handle_pg_range()
goes through the list to find the hot-add region state
associated with message and do hot-add memory. The lock
is released in the loop before calling hv_mem_hot_add()
and is reacquired in hv_mem_hot_add(). There is a race
that list entry maybe freed during the slot.

To avoid the race and simply the code, make hv_mem_hot_add()
under protection of ha_region_list lock. There is a dead lock
case when run add_memory() under ha_lock. add_memory() calls
hv_online_page() inside and hv_online_page() also acquires
ha_lock again. Add lock_thread in the struct hv_dynmem_device
to record hv_mem_hot_add()'s thread and check lock_thread
in hv_online_page(). hv_mem_hot_add() thread already holds
lock during traverse hot add list and so not acquire lock
in hv_online_page().

Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
---
 drivers/hv/hv_balloon.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/hv/hv_balloon.c b/drivers/hv/hv_balloon.c
index 34bd73526afd..4d1a3b1e2490 100644
--- a/drivers/hv/hv_balloon.c
+++ b/drivers/hv/hv_balloon.c
@@ -545,6 +545,7 @@ struct hv_dynmem_device {
 	 * regions from ha_region_list.
 	 */
 	spinlock_t ha_lock;
+	struct task_struct *lock_thread;
 
 	/*
 	 * A list of hot-add regions.
@@ -707,12 +708,10 @@ static void hv_mem_hot_add(unsigned long start, unsigned long size,
 	unsigned long start_pfn;
 	unsigned long processed_pfn;
 	unsigned long total_pfn = pfn_count;
-	unsigned long flags;
 
 	for (i = 0; i < (size/HA_CHUNK); i++) {
 		start_pfn = start + (i * HA_CHUNK);
 
-		spin_lock_irqsave(&dm_device.ha_lock, flags);
 		has->ha_end_pfn +=  HA_CHUNK;
 
 		if (total_pfn > HA_CHUNK) {
@@ -724,7 +723,6 @@ static void hv_mem_hot_add(unsigned long start, unsigned long size,
 		}
 
 		has->covered_end_pfn +=  processed_pfn;
-		spin_unlock_irqrestore(&dm_device.ha_lock, flags);
 
 		init_completion(&dm_device.ol_waitevent);
 		dm_device.ha_waiting = !memhp_auto_online;
@@ -745,10 +743,8 @@ static void hv_mem_hot_add(unsigned long start, unsigned long size,
 				 */
 				do_hot_add = false;
 			}
-			spin_lock_irqsave(&dm_device.ha_lock, flags);
 			has->ha_end_pfn -= HA_CHUNK;
 			has->covered_end_pfn -=  processed_pfn;
-			spin_unlock_irqrestore(&dm_device.ha_lock, flags);
 			break;
 		}
 
@@ -771,8 +767,13 @@ static void hv_online_page(struct page *pg, unsigned int order)
 	struct hv_hotadd_state *has;
 	unsigned long flags;
 	unsigned long pfn = page_to_pfn(pg);
+	int unlocked;
+
+	if (dm_device.lock_thread != current) {
+		spin_lock_irqsave(&dm_device.ha_lock, flags);
+		unlocked = 1;
+	}
 
-	spin_lock_irqsave(&dm_device.ha_lock, flags);
 	list_for_each_entry(has, &dm_device.ha_region_list, list) {
 		/* The page belongs to a different HAS. */
 		if ((pfn < has->start_pfn) ||
@@ -782,7 +783,9 @@ static void hv_online_page(struct page *pg, unsigned int order)
 		hv_bring_pgs_online(has, pfn, 1UL << order);
 		break;
 	}
-	spin_unlock_irqrestore(&dm_device.ha_lock, flags);
+
+	if (unlocked)
+		spin_unlock_irqrestore(&dm_device.ha_lock, flags);
 }
 
 static int pfn_covered(unsigned long start_pfn, unsigned long pfn_cnt)
@@ -860,6 +863,7 @@ static unsigned long handle_pg_range(unsigned long pg_start,
 		pg_start);
 
 	spin_lock_irqsave(&dm_device.ha_lock, flags);
+	dm_device.lock_thread = current;
 	list_for_each_entry(has, &dm_device.ha_region_list, list) {
 		/*
 		 * If the pfn range we are dealing with is not in the current
@@ -912,9 +916,7 @@ static unsigned long handle_pg_range(unsigned long pg_start,
 			} else {
 				pfn_cnt = size;
 			}
-			spin_unlock_irqrestore(&dm_device.ha_lock, flags);
 			hv_mem_hot_add(has->ha_end_pfn, size, pfn_cnt, has);
-			spin_lock_irqsave(&dm_device.ha_lock, flags);
 		}
 		/*
 		 * If we managed to online any pages that were given to us,
@@ -923,6 +925,7 @@ static unsigned long handle_pg_range(unsigned long pg_start,
 		res = has->covered_end_pfn - old_covered_state;
 		break;
 	}
+	dm_device.lock_thread = NULL;
 	spin_unlock_irqrestore(&dm_device.ha_lock, flags);
 
 	return res;
-- 
2.14.5

