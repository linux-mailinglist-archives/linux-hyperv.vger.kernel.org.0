Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6006BAD83C
	for <lists+linux-hyperv@lfdr.de>; Mon,  9 Sep 2019 13:49:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404438AbfIILtA (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 9 Sep 2019 07:49:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42451 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732500AbfIILs7 (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 9 Sep 2019 07:48:59 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5393DC045750;
        Mon,  9 Sep 2019 11:48:59 +0000 (UTC)
Received: from t460s.redhat.com (ovpn-116-173.ams2.redhat.com [10.36.116.173])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 09F6F100195C;
        Mon,  9 Sep 2019 11:48:56 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, Souptick Joarder <jrdr.linux@gmail.com>,
        linux-hyperv@vger.kernel.org, David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.com>,
        Michal Hocko <mhocko@suse.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        Dan Williams <dan.j.williams@intel.com>, Qian Cai <cai@lca.pw>
Subject: [PATCH v1 3/3] mm/memory_hotplug: Remove __online_page_free() and __online_page_increment_counters()
Date:   Mon,  9 Sep 2019 13:48:30 +0200
Message-Id: <20190909114830.662-4-david@redhat.com>
In-Reply-To: <20190909114830.662-1-david@redhat.com>
References: <20190909114830.662-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Mon, 09 Sep 2019 11:48:59 +0000 (UTC)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Let's drop the now unused functions.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Oscar Salvador <osalvador@suse.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
Cc: Wei Yang <richard.weiyang@gmail.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Qian Cai <cai@lca.pw>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/memory_hotplug.h |  3 ---
 mm/memory_hotplug.c            | 12 ------------
 2 files changed, 15 deletions(-)

diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
index 71a620eabb62..933f2bb3bdbb 100644
--- a/include/linux/memory_hotplug.h
+++ b/include/linux/memory_hotplug.h
@@ -106,9 +106,6 @@ extern void generic_online_page(struct page *page, unsigned int order);
 extern int set_online_page_callback(online_page_callback_t callback);
 extern int restore_online_page_callback(online_page_callback_t callback);
 
-extern void __online_page_increment_counters(struct page *page);
-extern void __online_page_free(struct page *page);
-
 extern int try_online_node(int nid);
 
 extern int arch_add_memory(int nid, u64 start, u64 size,
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index f32a5feaf7ff..16dd5b1498e8 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -602,18 +602,6 @@ int restore_online_page_callback(online_page_callback_t callback)
 }
 EXPORT_SYMBOL_GPL(restore_online_page_callback);
 
-void __online_page_increment_counters(struct page *page)
-{
-	adjust_managed_page_count(page, 1);
-}
-EXPORT_SYMBOL_GPL(__online_page_increment_counters);
-
-void __online_page_free(struct page *page)
-{
-	__free_reserved_page(page);
-}
-EXPORT_SYMBOL_GPL(__online_page_free);
-
 void generic_online_page(struct page *page, unsigned int order)
 {
 	kernel_map_pages(page, 1 << order, 1);
-- 
2.21.0

