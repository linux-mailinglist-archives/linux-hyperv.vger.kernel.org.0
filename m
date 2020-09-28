Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC32027B44E
	for <lists+linux-hyperv@lfdr.de>; Mon, 28 Sep 2020 20:21:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726552AbgI1SVd (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 28 Sep 2020 14:21:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43927 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726667AbgI1SVb (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 28 Sep 2020 14:21:31 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601317289;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=laXejcIQdTmV7rAwQlkk8zr23wQtPdyau8HQ8vO9W7g=;
        b=FIgGH11Pw7IEe34zpG1qe/Suix4eLgyXhhZfPPh6dwe5V96ayA9ErFg/xsIW5qU4Tc7biB
        OfpMCcyBygqfnxGl/ZLx41OxwMMs3z475A2mdfi3bLCULhmaJ63bx6MA22P6+1mQ6q71O+
        Wp0K1KfSrVtWdCLZASdtHq2xCdn0Ofc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-339-2QVXUUZyO6-SQFPSf2GWaw-1; Mon, 28 Sep 2020 14:21:25 -0400
X-MC-Unique: 2QVXUUZyO6-SQFPSf2GWaw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CE60614996;
        Mon, 28 Sep 2020 18:21:22 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-112-106.ams2.redhat.com [10.36.112.106])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E4BFA27CC4;
        Mon, 28 Sep 2020 18:21:19 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-hyperv@vger.kernel.org,
        xen-devel@lists.xenproject.org, linux-acpi@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Oscar Salvador <osalvador@suse.de>,
        Mel Gorman <mgorman@techsingularity.net>,
        Michal Hocko <mhocko@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        Mike Rapoport <rppt@kernel.org>
Subject: [PATCH v1 1/5] mm/page_alloc: convert "report" flag of __free_one_page() to a proper flag
Date:   Mon, 28 Sep 2020 20:21:06 +0200
Message-Id: <20200928182110.7050-2-david@redhat.com>
In-Reply-To: <20200928182110.7050-1-david@redhat.com>
References: <20200928182110.7050-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Let's prepare for additional flags and avoid long parameter lists of bools.
Follow-up patches will also make use of the flags in __free_pages_ok(),
however, I wasn't able to come up with a better name for the type - should
be good enough for internal purposes.

Reviewed-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
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
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/page_alloc.c | 28 ++++++++++++++++++++--------
 1 file changed, 20 insertions(+), 8 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index df90e3654f97..daab90e960fe 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -77,6 +77,18 @@
 #include "shuffle.h"
 #include "page_reporting.h"
 
+/* Free One Page flags: for internal, non-pcp variants of free_pages(). */
+typedef int __bitwise fop_t;
+
+/* No special request */
+#define FOP_NONE		((__force fop_t)0)
+
+/*
+ * Skip free page reporting notification for the (possibly merged) page. (will
+ * *not* mark the page reported, only skip the notification).
+ */
+#define FOP_SKIP_REPORT_NOTIFY	((__force fop_t)BIT(0))
+
 /* prevent >1 _updater_ of zone percpu pageset ->high and ->batch fields */
 static DEFINE_MUTEX(pcp_batch_high_lock);
 #define MIN_PERCPU_PAGELIST_FRACTION	(8)
@@ -948,10 +960,9 @@ buddy_merge_likely(unsigned long pfn, unsigned long buddy_pfn,
  * -- nyc
  */
 
-static inline void __free_one_page(struct page *page,
-		unsigned long pfn,
-		struct zone *zone, unsigned int order,
-		int migratetype, bool report)
+static inline void __free_one_page(struct page *page, unsigned long pfn,
+				   struct zone *zone, unsigned int order,
+				   int migratetype, fop_t fop_flags)
 {
 	struct capture_control *capc = task_capc(zone);
 	unsigned long buddy_pfn;
@@ -1038,7 +1049,7 @@ static inline void __free_one_page(struct page *page,
 		add_to_free_list(page, zone, order, migratetype);
 
 	/* Notify page reporting subsystem of freed page */
-	if (report)
+	if (!(fop_flags & FOP_SKIP_REPORT_NOTIFY))
 		page_reporting_notify_free(order);
 }
 
@@ -1379,7 +1390,7 @@ static void free_pcppages_bulk(struct zone *zone, int count,
 		if (unlikely(isolated_pageblocks))
 			mt = get_pageblock_migratetype(page);
 
-		__free_one_page(page, page_to_pfn(page), zone, 0, mt, true);
+		__free_one_page(page, page_to_pfn(page), zone, 0, mt, FOP_NONE);
 		trace_mm_page_pcpu_drain(page, 0, mt);
 	}
 	spin_unlock(&zone->lock);
@@ -1395,7 +1406,7 @@ static void free_one_page(struct zone *zone,
 		is_migrate_isolate(migratetype))) {
 		migratetype = get_pfnblock_migratetype(page, pfn);
 	}
-	__free_one_page(page, pfn, zone, order, migratetype, true);
+	__free_one_page(page, pfn, zone, order, migratetype, FOP_NONE);
 	spin_unlock(&zone->lock);
 }
 
@@ -3288,7 +3299,8 @@ void __putback_isolated_page(struct page *page, unsigned int order, int mt)
 	lockdep_assert_held(&zone->lock);
 
 	/* Return isolated page to tail of freelist. */
-	__free_one_page(page, page_to_pfn(page), zone, order, mt, false);
+	__free_one_page(page, page_to_pfn(page), zone, order, mt,
+			FOP_SKIP_REPORT_NOTIFY);
 }
 
 /*
-- 
2.26.2

