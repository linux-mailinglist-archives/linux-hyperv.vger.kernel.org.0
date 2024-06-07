Return-Path: <linux-hyperv+bounces-2337-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A97B8FFEE5
	for <lists+linux-hyperv@lfdr.de>; Fri,  7 Jun 2024 11:10:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E62131F26EAF
	for <lists+linux-hyperv@lfdr.de>; Fri,  7 Jun 2024 09:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B814C15B969;
	Fri,  7 Jun 2024 09:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GNxqk8ux"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 306F615B577
	for <linux-hyperv@vger.kernel.org>; Fri,  7 Jun 2024 09:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717751399; cv=none; b=BcifBNu6ZpGtk6rWlqzVKr47WTgpWP3NRiPum1kyFIfTqKYxSAWMGNPC/gyZHrVS83zSN7/+KcgywTqzaZKUzfOGTTcdNpL2HBzRJCDbdEQSuNMynFooBM6LpF83wOIKbBvD9d+Nyl47c47EFL2Jv9CGz3ihHTR+UsVAG4zej0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717751399; c=relaxed/simple;
	bh=cV9I9SX/P8kvfoGL8PmYGcx2Q0H442GXxhK2ELdMlpU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jpWCZAaBU4xvt5xFZlagYE8bGFQQOi5WJke8eG5d/h6ikj/lJrDW+mW4SNSO94XKYrbi96CmATejAh8GeArX0sdvd96h0FugJ47shVYGTWX9dgWICBfqO/QIFQUTq3mEdkbLoq1jRXF/VeaOg/wmrRMXxP4FHYbulruN2mumPmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GNxqk8ux; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717751397;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kiFnKpy9jAQsfmTIBaaW+Ib0u1X/H+DkqsqDykpaDbc=;
	b=GNxqk8ux8t6eT3Pmk4WOQGs8g/mCXLwUO6W/xF9HOi1t8Yba2PDpiWqkULXq4K6vOtXxkM
	dTXBocFW4U8EbRfAenebeuBR230RxJHIs7+o6AVHe+1+wlMhDBVyFnYlEkF9mWCtTUgj5H
	atTIYRAsw3bPgh95K3XImwmmdPBEVrY=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-94-siZVc8J6MdebVKtoCSUwSQ-1; Fri,
 07 Jun 2024 05:09:51 -0400
X-MC-Unique: siZVc8J6MdebVKtoCSUwSQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C59D31C05190;
	Fri,  7 Jun 2024 09:09:50 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.194.94])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 44DB337E7;
	Fri,  7 Jun 2024 09:09:46 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	linux-hyperv@vger.kernel.org,
	virtualization@lists.linux.dev,
	xen-devel@lists.xenproject.org,
	kasan-dev@googlegroups.com,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Mike Rapoport <rppt@kernel.org>,
	Oscar Salvador <osalvador@suse.de>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	Alexander Potapenko <glider@google.com>,
	Marco Elver <elver@google.com>,
	Dmitry Vyukov <dvyukov@google.com>
Subject: [PATCH v1 1/3] mm: pass meminit_context to __free_pages_core()
Date: Fri,  7 Jun 2024 11:09:36 +0200
Message-ID: <20240607090939.89524-2-david@redhat.com>
In-Reply-To: <20240607090939.89524-1-david@redhat.com>
References: <20240607090939.89524-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

In preparation for further changes, let's teach __free_pages_core()
about the differences of memory hotplug handling.

Move the memory hotplug specific handling from generic_online_page() to
__free_pages_core(), use adjust_managed_page_count() on the memory
hotplug path, and spell out why memory freed via memblock
cannot currently use adjust_managed_page_count().

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/internal.h       |  3 ++-
 mm/kmsan/init.c     |  2 +-
 mm/memory_hotplug.c |  9 +--------
 mm/mm_init.c        |  4 ++--
 mm/page_alloc.c     | 17 +++++++++++++++--
 5 files changed, 21 insertions(+), 14 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index 12e95fdf61e90..3fdee779205ab 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -604,7 +604,8 @@ extern void __putback_isolated_page(struct page *page, unsigned int order,
 				    int mt);
 extern void memblock_free_pages(struct page *page, unsigned long pfn,
 					unsigned int order);
-extern void __free_pages_core(struct page *page, unsigned int order);
+extern void __free_pages_core(struct page *page, unsigned int order,
+		enum meminit_context);
 
 /*
  * This will have no effect, other than possibly generating a warning, if the
diff --git a/mm/kmsan/init.c b/mm/kmsan/init.c
index 3ac3b8921d36f..ca79636f858e5 100644
--- a/mm/kmsan/init.c
+++ b/mm/kmsan/init.c
@@ -172,7 +172,7 @@ static void do_collection(void)
 		shadow = smallstack_pop(&collect);
 		origin = smallstack_pop(&collect);
 		kmsan_setup_meta(page, shadow, origin, collect.order);
-		__free_pages_core(page, collect.order);
+		__free_pages_core(page, collect.order, MEMINIT_EARLY);
 	}
 }
 
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 171ad975c7cfd..27e3be75edcf7 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -630,14 +630,7 @@ EXPORT_SYMBOL_GPL(restore_online_page_callback);
 
 void generic_online_page(struct page *page, unsigned int order)
 {
-	/*
-	 * Freeing the page with debug_pagealloc enabled will try to unmap it,
-	 * so we should map it first. This is better than introducing a special
-	 * case in page freeing fast path.
-	 */
-	debug_pagealloc_map_pages(page, 1 << order);
-	__free_pages_core(page, order);
-	totalram_pages_add(1UL << order);
+	__free_pages_core(page, order, MEMINIT_HOTPLUG);
 }
 EXPORT_SYMBOL_GPL(generic_online_page);
 
diff --git a/mm/mm_init.c b/mm/mm_init.c
index 019193b0d8703..feb5b6e8c8875 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -1938,7 +1938,7 @@ static void __init deferred_free_range(unsigned long pfn,
 	for (i = 0; i < nr_pages; i++, page++, pfn++) {
 		if (pageblock_aligned(pfn))
 			set_pageblock_migratetype(page, MIGRATE_MOVABLE);
-		__free_pages_core(page, 0);
+		__free_pages_core(page, 0, MEMINIT_EARLY);
 	}
 }
 
@@ -2513,7 +2513,7 @@ void __init memblock_free_pages(struct page *page, unsigned long pfn,
 		}
 	}
 
-	__free_pages_core(page, order);
+	__free_pages_core(page, order, MEMINIT_EARLY);
 }
 
 DEFINE_STATIC_KEY_MAYBE(CONFIG_INIT_ON_ALLOC_DEFAULT_ON, init_on_alloc);
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 2224965ada468..e0c8a8354be36 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1214,7 +1214,8 @@ static void __free_pages_ok(struct page *page, unsigned int order,
 	__count_vm_events(PGFREE, 1 << order);
 }
 
-void __free_pages_core(struct page *page, unsigned int order)
+void __free_pages_core(struct page *page, unsigned int order,
+		enum meminit_context context)
 {
 	unsigned int nr_pages = 1 << order;
 	struct page *p = page;
@@ -1234,7 +1235,19 @@ void __free_pages_core(struct page *page, unsigned int order)
 	__ClearPageReserved(p);
 	set_page_count(p, 0);
 
-	atomic_long_add(nr_pages, &page_zone(page)->managed_pages);
+	if (IS_ENABLED(CONFIG_MEMORY_HOTPLUG) &&
+	    unlikely(context == MEMINIT_HOTPLUG)) {
+		/*
+		 * Freeing the page with debug_pagealloc enabled will try to
+		 * unmap it; some archs don't like double-unmappings, so
+		 * map it first.
+		 */
+		debug_pagealloc_map_pages(page, nr_pages);
+		adjust_managed_page_count(page, nr_pages);
+	} else {
+		/* memblock adjusts totalram_pages() ahead of time. */
+		atomic_long_add(nr_pages, &page_zone(page)->managed_pages);
+	}
 
 	if (page_contains_unaccepted(page, order)) {
 		if (order == MAX_PAGE_ORDER && __free_unaccepted(page))
-- 
2.45.1


