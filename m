Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B345027B451
	for <lists+linux-hyperv@lfdr.de>; Mon, 28 Sep 2020 20:21:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726737AbgI1SVg (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 28 Sep 2020 14:21:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:50821 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726734AbgI1SVf (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 28 Sep 2020 14:21:35 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601317294;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TNhyUHqO1xaNUWjaJC5gALnSiwlS9rj3Gwt2eIRdkhA=;
        b=fJ4UM4VBGyv8wPoIigSSnr9riD+7cI2HrmN2gysc1a6x2G2i1tuaJFW2qVmXYm4g/AszBP
        r1tgiyIeF++PE/8auEMP2r0kedzgDs3rjcxP5/hNlUrjoYh9lDCWRh9P0gK4/CEP5jpHh+
        Awa2mCeTg9RIBP9DSGflf0pmrLc4Cro=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-68-_1TlHN4uMYm91E83m_d4sA-1; Mon, 28 Sep 2020 14:21:29 -0400
X-MC-Unique: _1TlHN4uMYm91E83m_d4sA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 881B914996;
        Mon, 28 Sep 2020 18:21:27 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-112-106.ams2.redhat.com [10.36.112.106])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2961C27CC7;
        Mon, 28 Sep 2020 18:21:23 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-hyperv@vger.kernel.org,
        xen-devel@lists.xenproject.org, linux-acpi@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Oscar Salvador <osalvador@suse.de>,
        Mel Gorman <mgorman@techsingularity.net>,
        Michal Hocko <mhocko@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        Mike Rapoport <rppt@kernel.org>,
        Scott Cheloha <cheloha@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH v1 2/5] mm/page_alloc: place pages to tail in __putback_isolated_page()
Date:   Mon, 28 Sep 2020 20:21:07 +0200
Message-Id: <20200928182110.7050-3-david@redhat.com>
In-Reply-To: <20200928182110.7050-1-david@redhat.com>
References: <20200928182110.7050-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

__putback_isolated_page() already documents that pages will be placed to
the tail of the freelist - this is, however, not the case for
"order >= MAX_ORDER - 2" (see buddy_merge_likely()) - which should be
the case for all existing users.

This change affects two users:
- free page reporting
- page isolation, when undoing the isolation (including memory onlining).

This behavior is desireable for pages that haven't really been touched
lately, so exactly the two users that don't actually read/write page
content, but rather move untouched pages.

The new behavior is especially desirable for memory onlining, where we
allow allocation of newly onlined pages via undo_isolate_page_range()
in online_pages(). Right now, we always place them to the head of the
free list, resulting in undesireable behavior: Assume we add
individual memory chunks via add_memory() and online them right away to
the NORMAL zone. We create a dependency chain of unmovable allocations
e.g., via the memmap. The memmap of the next chunk will be placed onto
previous chunks - if the last block cannot get offlined+removed, all
dependent ones cannot get offlined+removed. While this can already be
observed with individual DIMMs, it's more of an issue for virtio-mem
(and I suspect also ppc DLPAR).

Document that this should only be used for optimizations, and no code
should realy on this for correction (if the order of freepage lists
ever changes).

We won't care about page shuffling: memory onlining already properly
shuffles after onlining. free page reporting doesn't care about
physically contiguous ranges, and there are already cases where page
isolation will simply move (physically close) free pages to (currently)
the head of the freelists via move_freepages_block() instead of
shuffling. If this becomes ever relevant, we should shuffle the whole
zone when undoing isolation of larger ranges, and after
free_contig_range().

Reviewed-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
Reviewed-by: Oscar Salvador <osalvador@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Alexander Duyck <alexander.h.duyck@linux.intel.com>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Wei Yang <richard.weiyang@linux.alibaba.com>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Scott Cheloha <cheloha@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/page_alloc.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index daab90e960fe..9e3ed4a6f69a 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -89,6 +89,18 @@ typedef int __bitwise fop_t;
  */
 #define FOP_SKIP_REPORT_NOTIFY	((__force fop_t)BIT(0))
 
+/*
+ * Place the (possibly merged) page to the tail of the freelist. Will ignore
+ * page shuffling (relevant code - e.g., memory onlining - is expected to
+ * shuffle the whole zone).
+ *
+ * Note: No code should rely onto this flag for correctness - it's purely
+ *       to allow for optimizations when handing back either fresh pages
+ *       (memory onlining) or untouched pages (page isolation, free page
+ *       reporting).
+ */
+#define FOP_TO_TAIL		((__force fop_t)BIT(1))
+
 /* prevent >1 _updater_ of zone percpu pageset ->high and ->batch fields */
 static DEFINE_MUTEX(pcp_batch_high_lock);
 #define MIN_PERCPU_PAGELIST_FRACTION	(8)
@@ -1038,7 +1050,9 @@ static inline void __free_one_page(struct page *page, unsigned long pfn,
 done_merging:
 	set_page_order(page, order);
 
-	if (is_shuffle_order(order))
+	if (fop_flags & FOP_TO_TAIL)
+		to_tail = true;
+	else if (is_shuffle_order(order))
 		to_tail = shuffle_pick_tail();
 	else
 		to_tail = buddy_merge_likely(pfn, buddy_pfn, page, order);
@@ -3300,7 +3314,7 @@ void __putback_isolated_page(struct page *page, unsigned int order, int mt)
 
 	/* Return isolated page to tail of freelist. */
 	__free_one_page(page, page_to_pfn(page), zone, order, mt,
-			FOP_SKIP_REPORT_NOTIFY);
+			FOP_SKIP_REPORT_NOTIFY | FOP_TO_TAIL);
 }
 
 /*
-- 
2.26.2

