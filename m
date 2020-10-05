Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 485AD2835AF
	for <lists+linux-hyperv@lfdr.de>; Mon,  5 Oct 2020 14:17:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbgJEMQr (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 5 Oct 2020 08:16:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:40391 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725994AbgJEMQp (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 5 Oct 2020 08:16:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601900202;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I03+HqTTiEYZ2UJ8Hm8w9UAbNI08TTVr15820ukCo2o=;
        b=YgrQJJ2TPmJuYA5hEQoZlIneITREmdjrt/71x9DMcH45Lw7P+QzzAwe4Lhk9kWMt3MEm/8
        ApfXRmJFTf8WUNGWcj3CGnNtMD9qKbjNUMP0Yrr47JYFNiaW7nPWN5HB6PJWnxe6blfDvD
        eODvi9TKj7y8wTSd+3opgvw3sN3KoeY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-536-hdgD0PM4N7SehO3ysGnyiw-1; Mon, 05 Oct 2020 08:16:39 -0400
X-MC-Unique: hdgD0PM4N7SehO3ysGnyiw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 547CE18A8220;
        Mon,  5 Oct 2020 12:16:36 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-114-222.ams2.redhat.com [10.36.114.222])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C518D1A8EC;
        Mon,  5 Oct 2020 12:16:23 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-hyperv@vger.kernel.org,
        xen-devel@lists.xenproject.org, linux-acpi@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Oscar Salvador <osalvador@suse.de>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        Michal Hocko <mhocko@suse.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Michal Hocko <mhocko@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Mike Rapoport <rppt@kernel.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>
Subject: [PATCH v2 4/5] mm/page_alloc: place pages to tail in __free_pages_core()
Date:   Mon,  5 Oct 2020 14:15:33 +0200
Message-Id: <20201005121534.15649-5-david@redhat.com>
In-Reply-To: <20201005121534.15649-1-david@redhat.com>
References: <20201005121534.15649-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

__free_pages_core() is used when exposing fresh memory to the buddy
during system boot and when onlining memory in generic_online_page().

generic_online_page() is used in two cases:

1. Direct memory onlining in online_pages().
2. Deferred memory onlining in memory-ballooning-like mechanisms (HyperV
   balloon and virtio-mem), when parts of a section are kept
   fake-offline to be fake-onlined later on.

In 1, we already place pages to the tail of the freelist. Pages will be
freed to MIGRATE_ISOLATE lists first and moved to the tail of the freelists
via undo_isolate_page_range().

In 2, we currently don't implement a proper rule. In case of virtio-mem,
where we currently always online MAX_ORDER - 1 pages, the pages will be
placed to the HEAD of the freelist - undesireable. While the hyper-v
balloon calls generic_online_page() with single pages, usually it will
call it on successive single pages in a larger block.

The pages are fresh, so place them to the tail of the freelist and avoid
the PCP. In __free_pages_core(), remove the now superflouos call to
set_page_refcounted() and add a comment regarding page initialization and
the refcount.

Note: In 2. we currently don't shuffle. If ever relevant (page shuffling
is usually of limited use in virtualized environments), we might want to
shuffle after a sequence of generic_online_page() calls in the
relevant callers.

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Reviewed-by: Oscar Salvador <osalvador@suse.de>
Acked-by: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Reviewed-by: Wei Yang <richard.weiyang@linux.alibaba.com>
Acked-by: Michal Hocko <mhocko@suse.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Alexander Duyck <alexander.h.duyck@linux.intel.com>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Wei Yang <richard.weiyang@linux.alibaba.com>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>
Cc: Stephen Hemminger <sthemmin@microsoft.com>
Cc: Wei Liu <wei.liu@kernel.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/page_alloc.c | 33 +++++++++++++++++++++++----------
 1 file changed, 23 insertions(+), 10 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index b187e46cf640..3dadcc6d4009 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -275,7 +275,8 @@ bool pm_suspended_storage(void)
 unsigned int pageblock_order __read_mostly;
 #endif
 
-static void __free_pages_ok(struct page *page, unsigned int order);
+static void __free_pages_ok(struct page *page, unsigned int order,
+			    fpi_t fpi_flags);
 
 /*
  * results with 256, 32 in the lowmem_reserve sysctl:
@@ -687,7 +688,7 @@ static void bad_page(struct page *page, const char *reason)
 void free_compound_page(struct page *page)
 {
 	mem_cgroup_uncharge(page);
-	__free_pages_ok(page, compound_order(page));
+	__free_pages_ok(page, compound_order(page), FPI_NONE);
 }
 
 void prep_compound_page(struct page *page, unsigned int order)
@@ -1423,14 +1424,14 @@ static void free_pcppages_bulk(struct zone *zone, int count,
 static void free_one_page(struct zone *zone,
 				struct page *page, unsigned long pfn,
 				unsigned int order,
-				int migratetype)
+				int migratetype, fpi_t fpi_flags)
 {
 	spin_lock(&zone->lock);
 	if (unlikely(has_isolate_pageblock(zone) ||
 		is_migrate_isolate(migratetype))) {
 		migratetype = get_pfnblock_migratetype(page, pfn);
 	}
-	__free_one_page(page, pfn, zone, order, migratetype, FPI_NONE);
+	__free_one_page(page, pfn, zone, order, migratetype, fpi_flags);
 	spin_unlock(&zone->lock);
 }
 
@@ -1508,7 +1509,8 @@ void __meminit reserve_bootmem_region(phys_addr_t start, phys_addr_t end)
 	}
 }
 
-static void __free_pages_ok(struct page *page, unsigned int order)
+static void __free_pages_ok(struct page *page, unsigned int order,
+			    fpi_t fpi_flags)
 {
 	unsigned long flags;
 	int migratetype;
@@ -1520,7 +1522,8 @@ static void __free_pages_ok(struct page *page, unsigned int order)
 	migratetype = get_pfnblock_migratetype(page, pfn);
 	local_irq_save(flags);
 	__count_vm_events(PGFREE, 1 << order);
-	free_one_page(page_zone(page), page, pfn, order, migratetype);
+	free_one_page(page_zone(page), page, pfn, order, migratetype,
+		      fpi_flags);
 	local_irq_restore(flags);
 }
 
@@ -1530,6 +1533,11 @@ void __free_pages_core(struct page *page, unsigned int order)
 	struct page *p = page;
 	unsigned int loop;
 
+	/*
+	 * When initializing the memmap, __init_single_page() sets the refcount
+	 * of all pages to 1 ("allocated"/"not free"). We have to set the
+	 * refcount of all involved pages to 0.
+	 */
 	prefetchw(p);
 	for (loop = 0; loop < (nr_pages - 1); loop++, p++) {
 		prefetchw(p + 1);
@@ -1540,8 +1548,12 @@ void __free_pages_core(struct page *page, unsigned int order)
 	set_page_count(p, 0);
 
 	atomic_long_add(nr_pages, &page_zone(page)->managed_pages);
-	set_page_refcounted(page);
-	__free_pages(page, order);
+
+	/*
+	 * Bypass PCP and place fresh pages right to the tail, primarily
+	 * relevant for memory onlining.
+	 */
+	__free_pages_ok(page, order, FPI_TO_TAIL);
 }
 
 #ifdef CONFIG_NEED_MULTIPLE_NODES
@@ -3168,7 +3180,8 @@ static void free_unref_page_commit(struct page *page, unsigned long pfn)
 	 */
 	if (migratetype >= MIGRATE_PCPTYPES) {
 		if (unlikely(is_migrate_isolate(migratetype))) {
-			free_one_page(zone, page, pfn, 0, migratetype);
+			free_one_page(zone, page, pfn, 0, migratetype,
+				      FPI_NONE);
 			return;
 		}
 		migratetype = MIGRATE_MOVABLE;
@@ -4991,7 +5004,7 @@ static inline void free_the_page(struct page *page, unsigned int order)
 	if (order == 0)		/* Via pcp? */
 		free_unref_page(page);
 	else
-		__free_pages_ok(page, order);
+		__free_pages_ok(page, order, FPI_NONE);
 }
 
 void __free_pages(struct page *page, unsigned int order)
-- 
2.26.2

