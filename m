Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05D7B26C7DD
	for <lists+linux-hyperv@lfdr.de>; Wed, 16 Sep 2020 20:35:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727897AbgIPSfF (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 16 Sep 2020 14:35:05 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:40698 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728185AbgIPSeu (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 16 Sep 2020 14:34:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600281288;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=K36Yi+Yui5jwLqHmtqjUnD4ieo4W1F/4OXFgJRadTHo=;
        b=UEIQBRiBslD5esuuXS7ImLJ/Fnl9fbg45R1uAYXwAN5tRt2dx3b+lm20gxf/4qD3Oni/C/
        LVmfeWBtAaomten0ZinrcZttJOtEaBULZU2EMVuy3WLx916oKZaSmp8CqKWwDKqL9/I4v1
        SLvSBIbVRNsT8gvjC5+rXJOeauGcDws=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-163-yOMc6tw1N0S2tGGPouOSjQ-1; Wed, 16 Sep 2020 14:34:44 -0400
X-MC-Unique: yOMc6tw1N0S2tGGPouOSjQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5453E801AC4;
        Wed, 16 Sep 2020 18:34:41 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-113-190.ams2.redhat.com [10.36.113.190])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C9EA419D61;
        Wed, 16 Sep 2020 18:34:31 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-hyperv@vger.kernel.org,
        xen-devel@lists.xenproject.org, linux-acpi@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Michal Hocko <mhocko@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        Oscar Salvador <osalvador@suse.de>,
        Mike Rapoport <rppt@kernel.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>
Subject: [PATCH RFC 4/4] mm/page_alloc: place pages to tail in __free_pages_core()
Date:   Wed, 16 Sep 2020 20:34:11 +0200
Message-Id: <20200916183411.64756-5-david@redhat.com>
In-Reply-To: <20200916183411.64756-1-david@redhat.com>
References: <20200916183411.64756-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-hyperv-owner@vger.kernel.org
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

The pages are fresh, so place them to the tail of the freelists and avoid
the PCP.

Note: If we detect that the new behavior is undesireable for
__free_pages_core() during boot, we can let the caller specify the
behavior.

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
 mm/page_alloc.c | 32 ++++++++++++++++++++------------
 1 file changed, 20 insertions(+), 12 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 75b0f49b4022..50746e6dc21b 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -264,7 +264,8 @@ bool pm_suspended_storage(void)
 unsigned int pageblock_order __read_mostly;
 #endif
 
-static void __free_pages_ok(struct page *page, unsigned int order);
+static void __free_pages_ok(struct page *page, unsigned int order,
+			    fop_t fop_flags);
 
 /*
  * results with 256, 32 in the lowmem_reserve sysctl:
@@ -676,7 +677,7 @@ static void bad_page(struct page *page, const char *reason)
 void free_compound_page(struct page *page)
 {
 	mem_cgroup_uncharge(page);
-	__free_pages_ok(page, compound_order(page));
+	__free_pages_ok(page, compound_order(page), FOP_NONE);
 }
 
 void prep_compound_page(struct page *page, unsigned int order)
@@ -1402,17 +1403,15 @@ static void free_pcppages_bulk(struct zone *zone, int count,
 	spin_unlock(&zone->lock);
 }
 
-static void free_one_page(struct zone *zone,
-				struct page *page, unsigned long pfn,
-				unsigned int order,
-				int migratetype)
+static void free_one_page(struct zone *zone, struct page *page, unsigned long pfn,
+			  unsigned int order, int migratetype, fop_t fop_flags)
 {
 	spin_lock(&zone->lock);
 	if (unlikely(has_isolate_pageblock(zone) ||
 		is_migrate_isolate(migratetype))) {
 		migratetype = get_pfnblock_migratetype(page, pfn);
 	}
-	__free_one_page(page, pfn, zone, order, migratetype, FOP_NONE);
+	__free_one_page(page, pfn, zone, order, migratetype, fop_flags);
 	spin_unlock(&zone->lock);
 }
 
@@ -1490,7 +1489,8 @@ void __meminit reserve_bootmem_region(phys_addr_t start, phys_addr_t end)
 	}
 }
 
-static void __free_pages_ok(struct page *page, unsigned int order)
+static void __free_pages_ok(struct page *page, unsigned int order,
+			    fop_t fop_flags)
 {
 	unsigned long flags;
 	int migratetype;
@@ -1502,7 +1502,8 @@ static void __free_pages_ok(struct page *page, unsigned int order)
 	migratetype = get_pfnblock_migratetype(page, pfn);
 	local_irq_save(flags);
 	__count_vm_events(PGFREE, 1 << order);
-	free_one_page(page_zone(page), page, pfn, order, migratetype);
+	free_one_page(page_zone(page), page, pfn, order, migratetype,
+		      fop_flags);
 	local_irq_restore(flags);
 }
 
@@ -1523,7 +1524,13 @@ void __free_pages_core(struct page *page, unsigned int order)
 
 	atomic_long_add(nr_pages, &page_zone(page)->managed_pages);
 	set_page_refcounted(page);
-	__free_pages(page, order);
+
+	/*
+	 * Bypass PCP and place fresh pages right to the tail, primarily
+	 * relevant for memory onlining.
+	 */
+	page_ref_dec(page);
+	__free_pages_ok(page, order, FOP_TO_TAIL);
 }
 
 #ifdef CONFIG_NEED_MULTIPLE_NODES
@@ -3167,7 +3174,8 @@ static void free_unref_page_commit(struct page *page, unsigned long pfn)
 	 */
 	if (migratetype >= MIGRATE_PCPTYPES) {
 		if (unlikely(is_migrate_isolate(migratetype))) {
-			free_one_page(zone, page, pfn, 0, migratetype);
+			free_one_page(zone, page, pfn, 0, migratetype,
+				      FOP_NONE);
 			return;
 		}
 		migratetype = MIGRATE_MOVABLE;
@@ -4984,7 +4992,7 @@ static inline void free_the_page(struct page *page, unsigned int order)
 	if (order == 0)		/* Via pcp? */
 		free_unref_page(page);
 	else
-		__free_pages_ok(page, order);
+		__free_pages_ok(page, order, FOP_NONE);
 }
 
 void __free_pages(struct page *page, unsigned int order)
-- 
2.26.2

