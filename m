Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC91527C0DC
	for <lists+linux-hyperv@lfdr.de>; Tue, 29 Sep 2020 11:19:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727956AbgI2JSS (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 29 Sep 2020 05:18:18 -0400
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:37599 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727484AbgI2JSS (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 29 Sep 2020 05:18:18 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=richard.weiyang@linux.alibaba.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---0UATyKVV_1601371083;
Received: from localhost(mailfrom:richard.weiyang@linux.alibaba.com fp:SMTPD_---0UATyKVV_1601371083)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 29 Sep 2020 17:18:04 +0800
Date:   Tue, 29 Sep 2020 17:18:03 +0800
From:   Wei Yang <richard.weiyang@linux.alibaba.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-hyperv@vger.kernel.org, xen-devel@lists.xenproject.org,
        linux-acpi@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Michal Hocko <mhocko@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        Mike Rapoport <rppt@kernel.org>,
        Scott Cheloha <cheloha@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v1 3/5] mm/page_alloc: always move pages to the tail of
 the freelist in unset_migratetype_isolate()
Message-ID: <20200929091803.GB36904@L-31X9LVDL-1304.local>
Reply-To: Wei Yang <richard.weiyang@linux.alibaba.com>
References: <20200928182110.7050-1-david@redhat.com>
 <20200928182110.7050-4-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200928182110.7050-4-david@redhat.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, Sep 28, 2020 at 08:21:08PM +0200, David Hildenbrand wrote:
>Page isolation doesn't actually touch the pages, it simply isolates
>pageblocks and moves all free pages to the MIGRATE_ISOLATE freelist.
>
>We already place pages to the tail of the freelists when undoing
>isolation via __putback_isolated_page(), let's do it in any case
>(e.g., if order <= pageblock_order) and document the behavior.
>
>Add a "to_tail" parameter to move_freepages_block() but introduce a
>a new move_to_free_list_tail() - similar to add_to_free_list_tail().
>
>This change results in all pages getting onlined via online_pages() to
>be placed to the tail of the freelist.
>
>Reviewed-by: Oscar Salvador <osalvador@suse.de>
>Cc: Andrew Morton <akpm@linux-foundation.org>
>Cc: Alexander Duyck <alexander.h.duyck@linux.intel.com>
>Cc: Mel Gorman <mgorman@techsingularity.net>
>Cc: Michal Hocko <mhocko@kernel.org>
>Cc: Dave Hansen <dave.hansen@intel.com>
>Cc: Vlastimil Babka <vbabka@suse.cz>
>Cc: Wei Yang <richard.weiyang@linux.alibaba.com>
>Cc: Oscar Salvador <osalvador@suse.de>
>Cc: Mike Rapoport <rppt@kernel.org>
>Cc: Scott Cheloha <cheloha@linux.ibm.com>
>Cc: Michael Ellerman <mpe@ellerman.id.au>
>Signed-off-by: David Hildenbrand <david@redhat.com>
>---
> include/linux/page-isolation.h |  4 ++--
> mm/page_alloc.c                | 35 +++++++++++++++++++++++-----------
> mm/page_isolation.c            | 12 +++++++++---
> 3 files changed, 35 insertions(+), 16 deletions(-)
>
>diff --git a/include/linux/page-isolation.h b/include/linux/page-isolation.h
>index 572458016331..3eca9b3c5305 100644
>--- a/include/linux/page-isolation.h
>+++ b/include/linux/page-isolation.h
>@@ -36,8 +36,8 @@ static inline bool is_migrate_isolate(int migratetype)
> struct page *has_unmovable_pages(struct zone *zone, struct page *page,
> 				 int migratetype, int flags);
> void set_pageblock_migratetype(struct page *page, int migratetype);
>-int move_freepages_block(struct zone *zone, struct page *page,
>-				int migratetype, int *num_movable);
>+int move_freepages_block(struct zone *zone, struct page *page, int migratetype,
>+			 bool to_tail, int *num_movable);
> 
> /*
>  * Changes migrate type in [start_pfn, end_pfn) to be MIGRATE_ISOLATE.
>diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>index 9e3ed4a6f69a..d5a5f528b8ca 100644
>--- a/mm/page_alloc.c
>+++ b/mm/page_alloc.c
>@@ -905,6 +905,15 @@ static inline void move_to_free_list(struct page *page, struct zone *zone,
> 	list_move(&page->lru, &area->free_list[migratetype]);
> }
> 
>+/* Used for pages which are on another list */
>+static inline void move_to_free_list_tail(struct page *page, struct zone *zone,
>+					  unsigned int order, int migratetype)
>+{
>+	struct free_area *area = &zone->free_area[order];
>+
>+	list_move_tail(&page->lru, &area->free_list[migratetype]);
>+}
>+

Would it be better to pass the *to_tail* to move_to_free_list(), so we won't
have a new function?

> static inline void del_page_from_free_list(struct page *page, struct zone *zone,
> 					   unsigned int order)
> {
>@@ -2338,9 +2347,9 @@ static inline struct page *__rmqueue_cma_fallback(struct zone *zone,
>  * Note that start_page and end_pages are not aligned on a pageblock
>  * boundary. If alignment is required, use move_freepages_block()
>  */
>-static int move_freepages(struct zone *zone,
>-			  struct page *start_page, struct page *end_page,
>-			  int migratetype, int *num_movable)
>+static int move_freepages(struct zone *zone, struct page *start_page,
>+			  struct page *end_page, int migratetype,
>+			  bool to_tail, int *num_movable)
> {
> 	struct page *page;
> 	unsigned int order;
>@@ -2371,7 +2380,10 @@ static int move_freepages(struct zone *zone,
> 		VM_BUG_ON_PAGE(page_zone(page) != zone, page);
> 
> 		order = page_order(page);
>-		move_to_free_list(page, zone, order, migratetype);
>+		if (to_tail)
>+			move_to_free_list_tail(page, zone, order, migratetype);
>+		else
>+			move_to_free_list(page, zone, order, migratetype);

And here, we just need to pass the *to_tail* to move_to_free_list().

> 		page += 1 << order;
> 		pages_moved += 1 << order;
> 	}
>@@ -2379,8 +2391,8 @@ static int move_freepages(struct zone *zone,
> 	return pages_moved;
> }
> 
>-int move_freepages_block(struct zone *zone, struct page *page,
>-				int migratetype, int *num_movable)
>+int move_freepages_block(struct zone *zone, struct page *page, int migratetype,
>+			 bool to_tail, int *num_movable)
> {
> 	unsigned long start_pfn, end_pfn;
> 	struct page *start_page, *end_page;
>@@ -2401,7 +2413,7 @@ int move_freepages_block(struct zone *zone, struct page *page,
> 		return 0;
> 
> 	return move_freepages(zone, start_page, end_page, migratetype,
>-								num_movable);
>+			      to_tail, num_movable);
> }
> 
> static void change_pageblock_range(struct page *pageblock_page,
>@@ -2526,8 +2538,8 @@ static void steal_suitable_fallback(struct zone *zone, struct page *page,
> 	if (!whole_block)
> 		goto single_page;
> 
>-	free_pages = move_freepages_block(zone, page, start_type,
>-						&movable_pages);
>+	free_pages = move_freepages_block(zone, page, start_type, false,
>+					  &movable_pages);
> 	/*
> 	 * Determine how many pages are compatible with our allocation.
> 	 * For movable allocation, it's the number of movable pages which
>@@ -2635,7 +2647,8 @@ static void reserve_highatomic_pageblock(struct page *page, struct zone *zone,
> 	    && !is_migrate_cma(mt)) {
> 		zone->nr_reserved_highatomic += pageblock_nr_pages;
> 		set_pageblock_migratetype(page, MIGRATE_HIGHATOMIC);
>-		move_freepages_block(zone, page, MIGRATE_HIGHATOMIC, NULL);
>+		move_freepages_block(zone, page, MIGRATE_HIGHATOMIC, false,
>+				     NULL);
> 	}
> 
> out_unlock:
>@@ -2711,7 +2724,7 @@ static bool unreserve_highatomic_pageblock(const struct alloc_context *ac,
> 			 */
> 			set_pageblock_migratetype(page, ac->migratetype);
> 			ret = move_freepages_block(zone, page, ac->migratetype,
>-									NULL);
>+						   false, NULL);
> 			if (ret) {
> 				spin_unlock_irqrestore(&zone->lock, flags);
> 				return ret;
>diff --git a/mm/page_isolation.c b/mm/page_isolation.c
>index abfe26ad59fd..de44e1329706 100644
>--- a/mm/page_isolation.c
>+++ b/mm/page_isolation.c
>@@ -45,7 +45,7 @@ static int set_migratetype_isolate(struct page *page, int migratetype, int isol_
> 		set_pageblock_migratetype(page, MIGRATE_ISOLATE);
> 		zone->nr_isolate_pageblock++;
> 		nr_pages = move_freepages_block(zone, page, MIGRATE_ISOLATE,
>-									NULL);
>+						false, NULL);
> 
> 		__mod_zone_freepage_state(zone, -nr_pages, mt);
> 		spin_unlock_irqrestore(&zone->lock, flags);
>@@ -83,7 +83,7 @@ static void unset_migratetype_isolate(struct page *page, unsigned migratetype)
> 	 * Because freepage with more than pageblock_order on isolated
> 	 * pageblock is restricted to merge due to freepage counting problem,
> 	 * it is possible that there is free buddy page.
>-	 * move_freepages_block() doesn't care of merge so we need other
>+	 * move_freepages_block() don't care about merging, so we need another
> 	 * approach in order to merge them. Isolation and free will make
> 	 * these pages to be merged.
> 	 */
>@@ -106,9 +106,15 @@ static void unset_migratetype_isolate(struct page *page, unsigned migratetype)
> 	 * If we isolate freepage with more than pageblock_order, there
> 	 * should be no freepage in the range, so we could avoid costly
> 	 * pageblock scanning for freepage moving.
>+	 *
>+	 * We didn't actually touch any of the isolated pages, so place them
>+	 * to the tail of the freelist. This is an optimization for memory
>+	 * onlining - just onlined memory won't immediately be considered for
>+	 * allocation.
> 	 */
> 	if (!isolated_page) {
>-		nr_pages = move_freepages_block(zone, page, migratetype, NULL);
>+		nr_pages = move_freepages_block(zone, page, migratetype, true,
>+						NULL);
> 		__mod_zone_freepage_state(zone, nr_pages, migratetype);
> 	}
> 	set_pageblock_migratetype(page, migratetype);
>-- 
>2.26.2

Others looks good to me.

-- 
Wei Yang
Help you, Help me
