Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D48A26C7DC
	for <lists+linux-hyperv@lfdr.de>; Wed, 16 Sep 2020 20:35:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727941AbgIPSei (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 16 Sep 2020 14:34:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:29357 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727284AbgIPSef (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 16 Sep 2020 14:34:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600281274;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2jblkU4ogq5hsBAPlkwaxym1Fc+Tde0ELyzoer8oJwA=;
        b=f/RScOloGDcd0BjD4xrfCLX3LUalygVlV0Szk2ItHOGfQG4xxB3G43dRs7poRsaghOuHba
        mC89+PL5IFsm15TqME32zsrkHwFhxYL3gcDaeFLR4pyTWg2LimodIwLaOv9MfaEYdFT5W6
        Lie9NiVI5KCeze16fTj5vdbyCl59OPA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-50-yst8dbbjNimjZj-WXTth4A-1; Wed, 16 Sep 2020 14:34:30 -0400
X-MC-Unique: yst8dbbjNimjZj-WXTth4A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E4AF81091065;
        Wed, 16 Sep 2020 18:34:27 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-113-190.ams2.redhat.com [10.36.113.190])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A2A3119D61;
        Wed, 16 Sep 2020 18:34:24 +0000 (UTC)
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
        Scott Cheloha <cheloha@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH RFC 2/4] mm/page_alloc: place pages to tail in __putback_isolated_page()
Date:   Wed, 16 Sep 2020 20:34:09 +0200
Message-Id: <20200916183411.64756-3-david@redhat.com>
In-Reply-To: <20200916183411.64756-1-david@redhat.com>
References: <20200916183411.64756-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

__putback_isolated_page() already documents that pages will be placed to
the tail of the freelist - this is, however, not the case for
"order >= MAX_ORDER - 2" (see buddy_merge_likely()) - which should be
the case for all existing users.

This change affects two users:
- free page reporting
- page isolation, when undoing the isolation.

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

Note: If we observe a degradation due to the changed page isolation
behavior (which I doubt), we can always make this configurable by the
instance triggering undo of isolation (e.g., alloc_contig_range(),
memory onlining, memory offlining).

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
 mm/page_alloc.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 91cefb8157dd..bba9a0f60c70 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -89,6 +89,12 @@ typedef int __bitwise fop_t;
  */
 #define FOP_SKIP_REPORT_NOTIFY	((__force fop_t)BIT(0))
 
+/*
+ * Place the freed page to the tail of the freelist after buddy merging. Will
+ * get ignored with page shuffling enabled.
+ */
+#define FOP_TO_TAIL		((__force fop_t)BIT(1))
+
 /* prevent >1 _updater_ of zone percpu pageset ->high and ->batch fields */
 static DEFINE_MUTEX(pcp_batch_high_lock);
 #define MIN_PERCPU_PAGELIST_FRACTION	(8)
@@ -1040,6 +1046,8 @@ static inline void __free_one_page(struct page *page, unsigned long pfn,
 
 	if (is_shuffle_order(order))
 		to_tail = shuffle_pick_tail();
+	else if (fop_flags & FOP_TO_TAIL)
+		to_tail = true;
 	else
 		to_tail = buddy_merge_likely(pfn, buddy_pfn, page, order);
 
@@ -3289,7 +3297,7 @@ void __putback_isolated_page(struct page *page, unsigned int order, int mt)
 
 	/* Return isolated page to tail of freelist. */
 	__free_one_page(page, page_to_pfn(page), zone, order, mt,
-			FOP_SKIP_REPORT_NOTIFY);
+			FOP_SKIP_REPORT_NOTIFY | FOP_TO_TAIL);
 }
 
 /*
-- 
2.26.2

