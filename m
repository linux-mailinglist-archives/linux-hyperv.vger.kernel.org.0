Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B15CD27C167
	for <lists+linux-hyperv@lfdr.de>; Tue, 29 Sep 2020 11:38:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727729AbgI2Jgz (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 29 Sep 2020 05:36:55 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:37519 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725826AbgI2Jgz (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 29 Sep 2020 05:36:55 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=richard.weiyang@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0UATcn6E_1601372210;
Received: from localhost(mailfrom:richard.weiyang@linux.alibaba.com fp:SMTPD_---0UATcn6E_1601372210)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 29 Sep 2020 17:36:51 +0800
Date:   Tue, 29 Sep 2020 17:36:50 +0800
From:   Wei Yang <richard.weiyang@linux.alibaba.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-hyperv@vger.kernel.org, xen-devel@lists.xenproject.org,
        linux-acpi@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Oscar Salvador <osalvador@suse.de>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Michal Hocko <mhocko@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        Mike Rapoport <rppt@kernel.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>
Subject: Re: [PATCH v1 4/5] mm/page_alloc: place pages to tail in
 __free_pages_core()
Message-ID: <20200929093650.GC36904@L-31X9LVDL-1304.local>
Reply-To: Wei Yang <richard.weiyang@linux.alibaba.com>
References: <20200928182110.7050-1-david@redhat.com>
 <20200928182110.7050-5-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200928182110.7050-5-david@redhat.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, Sep 28, 2020 at 08:21:09PM +0200, David Hildenbrand wrote:
>__free_pages_core() is used when exposing fresh memory to the buddy
>during system boot and when onlining memory in generic_online_page().
>
>generic_online_page() is used in two cases:
>
>1. Direct memory onlining in online_pages().
>2. Deferred memory onlining in memory-ballooning-like mechanisms (HyperV
>   balloon and virtio-mem), when parts of a section are kept
>   fake-offline to be fake-onlined later on.
>
>In 1, we already place pages to the tail of the freelist. Pages will be
>freed to MIGRATE_ISOLATE lists first and moved to the tail of the freelists
>via undo_isolate_page_range().
>
>In 2, we currently don't implement a proper rule. In case of virtio-mem,
>where we currently always online MAX_ORDER - 1 pages, the pages will be
>placed to the HEAD of the freelist - undesireable. While the hyper-v
>balloon calls generic_online_page() with single pages, usually it will
>call it on successive single pages in a larger block.
>
>The pages are fresh, so place them to the tail of the freelists and avoid
>the PCP. In __free_pages_core(), remove the now superflouos call to
>set_page_refcounted() and add a comment regarding page initialization and
>the refcount.
>
>Note: In 2. we currently don't shuffle. If ever relevant (page shuffling
>is usually of limited use in virtualized environments), we might want to
>shuffle after a sequence of generic_online_page() calls in the
>relevant callers.
>
>Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
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
>Cc: "K. Y. Srinivasan" <kys@microsoft.com>
>Cc: Haiyang Zhang <haiyangz@microsoft.com>
>Cc: Stephen Hemminger <sthemmin@microsoft.com>
>Cc: Wei Liu <wei.liu@kernel.org>
>Signed-off-by: David Hildenbrand <david@redhat.com>
>---
> mm/page_alloc.c | 37 ++++++++++++++++++++++++-------------
> 1 file changed, 24 insertions(+), 13 deletions(-)
>
>diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>index d5a5f528b8ca..8a2134fe9947 100644
>--- a/mm/page_alloc.c
>+++ b/mm/page_alloc.c
>@@ -270,7 +270,8 @@ bool pm_suspended_storage(void)
> unsigned int pageblock_order __read_mostly;
> #endif
> 
>-static void __free_pages_ok(struct page *page, unsigned int order);
>+static void __free_pages_ok(struct page *page, unsigned int order,
>+			    fop_t fop_flags);
> 
> /*
>  * results with 256, 32 in the lowmem_reserve sysctl:
>@@ -682,7 +683,7 @@ static void bad_page(struct page *page, const char *reason)
> void free_compound_page(struct page *page)
> {
> 	mem_cgroup_uncharge(page);
>-	__free_pages_ok(page, compound_order(page));
>+	__free_pages_ok(page, compound_order(page), FOP_NONE);
> }
> 
> void prep_compound_page(struct page *page, unsigned int order)
>@@ -1419,17 +1420,15 @@ static void free_pcppages_bulk(struct zone *zone, int count,
> 	spin_unlock(&zone->lock);
> }
> 
>-static void free_one_page(struct zone *zone,
>-				struct page *page, unsigned long pfn,
>-				unsigned int order,
>-				int migratetype)
>+static void free_one_page(struct zone *zone, struct page *page, unsigned long pfn,
>+			  unsigned int order, int migratetype, fop_t fop_flags)
> {
> 	spin_lock(&zone->lock);
> 	if (unlikely(has_isolate_pageblock(zone) ||
> 		is_migrate_isolate(migratetype))) {
> 		migratetype = get_pfnblock_migratetype(page, pfn);
> 	}
>-	__free_one_page(page, pfn, zone, order, migratetype, FOP_NONE);
>+	__free_one_page(page, pfn, zone, order, migratetype, fop_flags);
> 	spin_unlock(&zone->lock);
> }
> 
>@@ -1507,7 +1506,8 @@ void __meminit reserve_bootmem_region(phys_addr_t start, phys_addr_t end)
> 	}
> }
> 
>-static void __free_pages_ok(struct page *page, unsigned int order)
>+static void __free_pages_ok(struct page *page, unsigned int order,
>+			    fop_t fop_flags)
> {
> 	unsigned long flags;
> 	int migratetype;
>@@ -1519,7 +1519,8 @@ static void __free_pages_ok(struct page *page, unsigned int order)
> 	migratetype = get_pfnblock_migratetype(page, pfn);
> 	local_irq_save(flags);
> 	__count_vm_events(PGFREE, 1 << order);
>-	free_one_page(page_zone(page), page, pfn, order, migratetype);
>+	free_one_page(page_zone(page), page, pfn, order, migratetype,
>+		      fop_flags);
> 	local_irq_restore(flags);
> }
> 
>@@ -1529,6 +1530,11 @@ void __free_pages_core(struct page *page, unsigned int order)
> 	struct page *p = page;
> 	unsigned int loop;
> 
>+	/*
>+	 * When initializing the memmap, init_single_page() sets the refcount

If my code is the latest version.

s/init_single_page/__init_single_page/

Besides this.

Reviewed-by: Wei Yang <richard.weiyang@linux.alibaba.com>

>+	 * of all pages to 1 ("allocated"/"not free"). We have to set the
>+	 * refcount of all involved pages to 0.
>+	 */
> 	prefetchw(p);
> 	for (loop = 0; loop < (nr_pages - 1); loop++, p++) {
> 		prefetchw(p + 1);
>@@ -1539,8 +1545,12 @@ void __free_pages_core(struct page *page, unsigned int order)
> 	set_page_count(p, 0);
> 
> 	atomic_long_add(nr_pages, &page_zone(page)->managed_pages);
>-	set_page_refcounted(page);
>-	__free_pages(page, order);
>+
>+	/*
>+	 * Bypass PCP and place fresh pages right to the tail, primarily
>+	 * relevant for memory onlining.
>+	 */
>+	__free_pages_ok(page, order, FOP_TO_TAIL);
> }
> 
> #ifdef CONFIG_NEED_MULTIPLE_NODES
>@@ -3171,7 +3181,8 @@ static void free_unref_page_commit(struct page *page, unsigned long pfn)
> 	 */
> 	if (migratetype >= MIGRATE_PCPTYPES) {
> 		if (unlikely(is_migrate_isolate(migratetype))) {
>-			free_one_page(zone, page, pfn, 0, migratetype);
>+			free_one_page(zone, page, pfn, 0, migratetype,
>+				      FOP_NONE);
> 			return;
> 		}
> 		migratetype = MIGRATE_MOVABLE;
>@@ -5063,7 +5074,7 @@ static inline void free_the_page(struct page *page, unsigned int order)
> 	if (order == 0)		/* Via pcp? */
> 		free_unref_page(page);
> 	else
>-		__free_pages_ok(page, order);
>+		__free_pages_ok(page, order, FOP_NONE);
> }
> 
> void __free_pages(struct page *page, unsigned int order)
>-- 
>2.26.2

-- 
Wei Yang
Help you, Help me
