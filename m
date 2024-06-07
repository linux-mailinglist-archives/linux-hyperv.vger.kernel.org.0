Return-Path: <linux-hyperv+bounces-2338-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 442AB8FFEE7
	for <lists+linux-hyperv@lfdr.de>; Fri,  7 Jun 2024 11:10:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8FCFCB2579D
	for <lists+linux-hyperv@lfdr.de>; Fri,  7 Jun 2024 09:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71EDD15B98B;
	Fri,  7 Jun 2024 09:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZextfqTm"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E6DC15B977
	for <linux-hyperv@vger.kernel.org>; Fri,  7 Jun 2024 09:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717751403; cv=none; b=ug6FAuiSxpM6Pc9JMvZkjWGz0D7NcjmlYN+WJqB99ijEXl0a7hbER1IjR81VnNBf1GdjLH0DFiTqae6M6VKm1+0eIpdHS3s3+HgGZz1H54sqvjKoqQ0Mks6zEc1+wOFdBO/Wn3zlM6qWBzJVpWwrZBkyo3tZ/MfP5X2MSRr2HU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717751403; c=relaxed/simple;
	bh=7/N/II1jbPumSWuRWxmKNVW9PBuRq5EMVGtyjouxccw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qXkcLT+1dKHTd8bhPBgbPDI9p4gjUvgOMaLEBj6hqNBdVV3dKbu/tIGioUkqYAsRlkktqqyMLnYpBtCgxYQw+UPyBgKJvxL/xPPW5RqcfvNmgD7L80WLf0tLN8MOzDZYZLfMNjvSFpf4mmCMbNMEZCimuba+d5fcuPUloGPzOx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZextfqTm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717751400;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mc4++sRx3ukGDekZxB1N0n7JzUxaxxhg3TlGVFiWWaQ=;
	b=ZextfqTmY8egdL2HBoxio260dr667LoEokwyzaFij9BhWpYygS7SV2Qb9EU8Yz3Z1+RxX0
	ent/4+2u+859F4TQQ9jue2uMhC346SkgU89KUkCImO4W+1M8BfrnF/R2KhZtNnFWvcTrx4
	BGvAOmEcryUTix/sbHuS8vVY1Md9vUQ=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-606-eUzDhlzTMDqdmYuPAblQDA-1; Fri,
 07 Jun 2024 05:09:56 -0400
X-MC-Unique: eUzDhlzTMDqdmYuPAblQDA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 964D43C01221;
	Fri,  7 Jun 2024 09:09:55 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.194.94])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 30BEC37E5;
	Fri,  7 Jun 2024 09:09:51 +0000 (UTC)
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
Subject: [PATCH v1 2/3] mm/memory_hotplug: initialize memmap of !ZONE_DEVICE with PageOffline() instead of PageReserved()
Date: Fri,  7 Jun 2024 11:09:37 +0200
Message-ID: <20240607090939.89524-3-david@redhat.com>
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

We currently initialize the memmap such that PG_reserved is set and the
refcount of the page is 1. In virtio-mem code, we have to manually clear
that PG_reserved flag to make memory offlining with partially hotplugged
memory blocks possible: has_unmovable_pages() would otherwise bail out on
such pages.

We want to avoid PG_reserved where possible and move to typed pages
instead. Further, we want to further enlighten memory offlining code about
PG_offline: offline pages in an online memory section. One example is
handling managed page count adjustments in a cleaner way during memory
offlining.

So let's initialize the pages with PG_offline instead of PG_reserved.
generic_online_page()->__free_pages_core() will now clear that flag before
handing that memory to the buddy.

Note that the page refcount is still 1 and would forbid offlining of such
memory except when special care is take during GOING_OFFLINE as
currently only implemented by virtio-mem.

With this change, we can now get non-PageReserved() pages in the XEN
balloon list. From what I can tell, that can already happen via
decrease_reservation(), so that should be fine.

HV-balloon should not really observe a change: partial online memory
blocks still cannot get surprise-offlined, because the refcount of these
PageOffline() pages is 1.

Update virtio-mem, HV-balloon and XEN-balloon code to be aware that
hotplugged pages are now PageOffline() instead of PageReserved() before
they are handed over to the buddy.

We'll leave the ZONE_DEVICE case alone for now.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/hv/hv_balloon.c     |  5 ++---
 drivers/virtio/virtio_mem.c | 18 ++++++++++++------
 drivers/xen/balloon.c       |  9 +++++++--
 include/linux/page-flags.h  | 12 +++++-------
 mm/memory_hotplug.c         | 16 ++++++++++------
 mm/mm_init.c                | 10 ++++++++--
 mm/page_alloc.c             | 32 +++++++++++++++++++++++---------
 7 files changed, 67 insertions(+), 35 deletions(-)

diff --git a/drivers/hv/hv_balloon.c b/drivers/hv/hv_balloon.c
index e000fa3b9f978..c1be38edd8361 100644
--- a/drivers/hv/hv_balloon.c
+++ b/drivers/hv/hv_balloon.c
@@ -693,9 +693,8 @@ static void hv_page_online_one(struct hv_hotadd_state *has, struct page *pg)
 		if (!PageOffline(pg))
 			__SetPageOffline(pg);
 		return;
-	}
-	if (PageOffline(pg))
-		__ClearPageOffline(pg);
+	} else if (!PageOffline(pg))
+		return;
 
 	/* This frame is currently backed; online the page. */
 	generic_online_page(pg, 0);
diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
index a3857bacc8446..b90df29621c81 100644
--- a/drivers/virtio/virtio_mem.c
+++ b/drivers/virtio/virtio_mem.c
@@ -1146,12 +1146,16 @@ static void virtio_mem_set_fake_offline(unsigned long pfn,
 	for (; nr_pages--; pfn++) {
 		struct page *page = pfn_to_page(pfn);
 
-		__SetPageOffline(page);
-		if (!onlined) {
+		if (!onlined)
+			/*
+			 * Pages that have not been onlined yet were initialized
+			 * to PageOffline(). Remember that we have to route them
+			 * through generic_online_page().
+			 */
 			SetPageDirty(page);
-			/* FIXME: remove after cleanups */
-			ClearPageReserved(page);
-		}
+		else
+			__SetPageOffline(page);
+		VM_WARN_ON_ONCE(!PageOffline(page));
 	}
 	page_offline_end();
 }
@@ -1166,9 +1170,11 @@ static void virtio_mem_clear_fake_offline(unsigned long pfn,
 	for (; nr_pages--; pfn++) {
 		struct page *page = pfn_to_page(pfn);
 
-		__ClearPageOffline(page);
 		if (!onlined)
+			/* generic_online_page() will clear PageOffline(). */
 			ClearPageDirty(page);
+		else
+			__ClearPageOffline(page);
 	}
 }
 
diff --git a/drivers/xen/balloon.c b/drivers/xen/balloon.c
index aaf2514fcfa46..528395133b4f8 100644
--- a/drivers/xen/balloon.c
+++ b/drivers/xen/balloon.c
@@ -146,7 +146,8 @@ static DECLARE_WAIT_QUEUE_HEAD(balloon_wq);
 /* balloon_append: add the given page to the balloon. */
 static void balloon_append(struct page *page)
 {
-	__SetPageOffline(page);
+	if (!PageOffline(page))
+		__SetPageOffline(page);
 
 	/* Lowmem is re-populated first, so highmem pages go at list tail. */
 	if (PageHighMem(page)) {
@@ -412,7 +413,11 @@ static enum bp_state increase_reservation(unsigned long nr_pages)
 
 		xenmem_reservation_va_mapping_update(1, &page, &frame_list[i]);
 
-		/* Relinquish the page back to the allocator. */
+		/*
+		 * Relinquish the page back to the allocator. Note that
+		 * some pages, including ones added via xen_online_page(), might
+		 * not be marked reserved; free_reserved_page() will handle that.
+		 */
 		free_reserved_page(page);
 	}
 
diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index f04fea86324d9..e0362ce7fc109 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -30,16 +30,11 @@
  * - Pages falling into physical memory gaps - not IORESOURCE_SYSRAM. Trying
  *   to read/write these pages might end badly. Don't touch!
  * - The zero page(s)
- * - Pages not added to the page allocator when onlining a section because
- *   they were excluded via the online_page_callback() or because they are
- *   PG_hwpoison.
  * - Pages allocated in the context of kexec/kdump (loaded kernel image,
  *   control pages, vmcoreinfo)
  * - MMIO/DMA pages. Some architectures don't allow to ioremap pages that are
  *   not marked PG_reserved (as they might be in use by somebody else who does
  *   not respect the caching strategy).
- * - Pages part of an offline section (struct pages of offline sections should
- *   not be trusted as they will be initialized when first onlined).
  * - MCA pages on ia64
  * - Pages holding CPU notes for POWER Firmware Assisted Dump
  * - Device memory (e.g. PMEM, DAX, HMM)
@@ -1021,6 +1016,10 @@ PAGE_TYPE_OPS(Buddy, buddy, buddy)
  * The content of these pages is effectively stale. Such pages should not
  * be touched (read/write/dump/save) except by their owner.
  *
+ * When a memory block gets onlined, all pages are initialized with a
+ * refcount of 1 and PageOffline(). generic_online_page() will
+ * take care of clearing PageOffline().
+ *
  * If a driver wants to allow to offline unmovable PageOffline() pages without
  * putting them back to the buddy, it can do so via the memory notifier by
  * decrementing the reference count in MEM_GOING_OFFLINE and incrementing the
@@ -1028,8 +1027,7 @@ PAGE_TYPE_OPS(Buddy, buddy, buddy)
  * pages (now with a reference count of zero) are treated like free pages,
  * allowing the containing memory block to get offlined. A driver that
  * relies on this feature is aware that re-onlining the memory block will
- * require to re-set the pages PageOffline() and not giving them to the
- * buddy via online_page_callback_t.
+ * require not giving them to the buddy via generic_online_page().
  *
  * There are drivers that mark a page PageOffline() and expect there won't be
  * any further access to page content. PFN walkers that read content of random
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 27e3be75edcf7..0254059efcbe1 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -734,7 +734,7 @@ static inline void section_taint_zone_device(unsigned long pfn)
 /*
  * Associate the pfn range with the given zone, initializing the memmaps
  * and resizing the pgdat/zone data to span the added pages. After this
- * call, all affected pages are PG_reserved.
+ * call, all affected pages are PageOffline().
  *
  * All aligned pageblocks are initialized to the specified migratetype
  * (usually MIGRATE_MOVABLE). Besides setting the migratetype, no related
@@ -1100,8 +1100,12 @@ int mhp_init_memmap_on_memory(unsigned long pfn, unsigned long nr_pages,
 
 	move_pfn_range_to_zone(zone, pfn, nr_pages, NULL, MIGRATE_UNMOVABLE);
 
-	for (i = 0; i < nr_pages; i++)
-		SetPageVmemmapSelfHosted(pfn_to_page(pfn + i));
+	for (i = 0; i < nr_pages; i++) {
+		struct page *page = pfn_to_page(pfn + i);
+
+		__ClearPageOffline(page);
+		SetPageVmemmapSelfHosted(page);
+	}
 
 	/*
 	 * It might be that the vmemmap_pages fully span sections. If that is
@@ -1959,9 +1963,9 @@ int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages,
 	 * Don't allow to offline memory blocks that contain holes.
 	 * Consequently, memory blocks with holes can never get onlined
 	 * via the hotplug path - online_pages() - as hotplugged memory has
-	 * no holes. This way, we e.g., don't have to worry about marking
-	 * memory holes PG_reserved, don't need pfn_valid() checks, and can
-	 * avoid using walk_system_ram_range() later.
+	 * no holes. This way, we don't have to worry about memory holes,
+	 * don't need pfn_valid() checks, and can avoid using
+	 * walk_system_ram_range() later.
 	 */
 	walk_system_ram_range(start_pfn, nr_pages, &system_ram_pages,
 			      count_system_ram_pages_cb);
diff --git a/mm/mm_init.c b/mm/mm_init.c
index feb5b6e8c8875..c066c1c474837 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -892,8 +892,14 @@ void __meminit memmap_init_range(unsigned long size, int nid, unsigned long zone
 
 		page = pfn_to_page(pfn);
 		__init_single_page(page, pfn, zone, nid);
-		if (context == MEMINIT_HOTPLUG)
-			__SetPageReserved(page);
+		if (context == MEMINIT_HOTPLUG) {
+#ifdef CONFIG_ZONE_DEVICE
+			if (zone == ZONE_DEVICE)
+				__SetPageReserved(page);
+			else
+#endif
+				__SetPageOffline(page);
+		}
 
 		/*
 		 * Usually, we want to mark the pageblock MIGRATE_MOVABLE,
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index e0c8a8354be36..039bc52cc9091 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1225,18 +1225,23 @@ void __free_pages_core(struct page *page, unsigned int order,
 	 * When initializing the memmap, __init_single_page() sets the refcount
 	 * of all pages to 1 ("allocated"/"not free"). We have to set the
 	 * refcount of all involved pages to 0.
+	 *
+	 * Note that hotplugged memory pages are initialized to PageOffline().
+	 * Pages freed from memblock might be marked as reserved.
 	 */
-	prefetchw(p);
-	for (loop = 0; loop < (nr_pages - 1); loop++, p++) {
-		prefetchw(p + 1);
-		__ClearPageReserved(p);
-		set_page_count(p, 0);
-	}
-	__ClearPageReserved(p);
-	set_page_count(p, 0);
-
 	if (IS_ENABLED(CONFIG_MEMORY_HOTPLUG) &&
 	    unlikely(context == MEMINIT_HOTPLUG)) {
+		prefetchw(p);
+		for (loop = 0; loop < (nr_pages - 1); loop++, p++) {
+			prefetchw(p + 1);
+			VM_WARN_ON_ONCE(PageReserved(p));
+			__ClearPageOffline(p);
+			set_page_count(p, 0);
+		}
+		VM_WARN_ON_ONCE(PageReserved(p));
+		__ClearPageOffline(p);
+		set_page_count(p, 0);
+
 		/*
 		 * Freeing the page with debug_pagealloc enabled will try to
 		 * unmap it; some archs don't like double-unmappings, so
@@ -1245,6 +1250,15 @@ void __free_pages_core(struct page *page, unsigned int order,
 		debug_pagealloc_map_pages(page, nr_pages);
 		adjust_managed_page_count(page, nr_pages);
 	} else {
+		prefetchw(p);
+		for (loop = 0; loop < (nr_pages - 1); loop++, p++) {
+			prefetchw(p + 1);
+			__ClearPageReserved(p);
+			set_page_count(p, 0);
+		}
+		__ClearPageReserved(p);
+		set_page_count(p, 0);
+
 		/* memblock adjusts totalram_pages() ahead of time. */
 		atomic_long_add(nr_pages, &page_zone(page)->managed_pages);
 	}
-- 
2.45.1


