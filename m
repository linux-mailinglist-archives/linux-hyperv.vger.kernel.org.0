Return-Path: <linux-hyperv+bounces-2339-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 24F948FFEED
	for <lists+linux-hyperv@lfdr.de>; Fri,  7 Jun 2024 11:10:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0919E1C20402
	for <lists+linux-hyperv@lfdr.de>; Fri,  7 Jun 2024 09:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1849815CD4D;
	Fri,  7 Jun 2024 09:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EyM1/bpm"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61BD215B99C
	for <linux-hyperv@vger.kernel.org>; Fri,  7 Jun 2024 09:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717751408; cv=none; b=TcOnTUkgs7SZjAXwTzqKm5dfbi6atuIuU6kJ5DZxMbJ86WIcM8DSRDe0uF7sVFJAl6+dIxwjrMC0SuUMrjCBHanzfZGDuhSBPsVHuMoqEwkZ1rUbYcKNN6TplzJiKzQCvkbrBJ1YGnOlaEb1w3ix0jO9S/2Jel0EztdPglMxRWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717751408; c=relaxed/simple;
	bh=rcr98LUxMH4GskxdErEsuVpzVDjlNv4ljeb+rvJlTGs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DlkbR8zAElMsT3P0Z1FBVWml+A4F/9g6ICyu8979Tmk2p87dgxBk6SvYdvIclQCpqsZ3Gv9QvKfiIoaURqwAca3fT3OLBHQ95YsZHpQskRECv6ENKeBeJIh5ZkZhmk9T49oJLWC/KZ5xJNvsLOrQvewpe1hnbHLigeN7hZFz9M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EyM1/bpm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717751405;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BkvZtA0DZCTst0gmiY3p4tzfSSSAg0RWHnN+gN89loE=;
	b=EyM1/bpmKug/pD2Sj/tnYMQ7j3JBCoiij7zJQVlBLk5ZKyFs3N06CQjm/Wx9BzBZyn8kz+
	GHyQ8SbTwQKMNEUNEIwuG+h+WSPXvS0jwc93rSiHH//1y5dpwTPqFcPJRHKmnrkRAXGBvT
	TUO7dtH5cumVnzQieZ0Xk34i9K0fQDI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-yH10sX6lNoa9rUALrYBFDg-1; Fri, 07 Jun 2024 05:10:01 -0400
X-MC-Unique: yH10sX6lNoa9rUALrYBFDg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 16217811E81;
	Fri,  7 Jun 2024 09:10:00 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.194.94])
	by smtp.corp.redhat.com (Postfix) with ESMTP id CF51437E7;
	Fri,  7 Jun 2024 09:09:55 +0000 (UTC)
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
Subject: [PATCH v1 3/3] mm/memory_hotplug: skip adjust_managed_page_count() for PageOffline() pages when offlining
Date: Fri,  7 Jun 2024 11:09:38 +0200
Message-ID: <20240607090939.89524-4-david@redhat.com>
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

We currently have a hack for virtio-mem in place to handle memory
offlining with PageOffline pages for which we already adjusted the
managed page count.

Let's enlighten memory offlining code so we can get rid of that hack,
and document the situation.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/virtio/virtio_mem.c    | 11 ++---------
 include/linux/memory_hotplug.h |  4 ++--
 include/linux/page-flags.h     |  8 ++++++--
 mm/memory_hotplug.c            |  6 +++---
 mm/page_alloc.c                | 12 ++++++++++--
 5 files changed, 23 insertions(+), 18 deletions(-)

diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
index b90df29621c81..b0b8714415783 100644
--- a/drivers/virtio/virtio_mem.c
+++ b/drivers/virtio/virtio_mem.c
@@ -1269,12 +1269,6 @@ static void virtio_mem_fake_offline_going_offline(unsigned long pfn,
 	struct page *page;
 	unsigned long i;
 
-	/*
-	 * Drop our reference to the pages so the memory can get offlined
-	 * and add the unplugged pages to the managed page counters (so
-	 * offlining code can correctly subtract them again).
-	 */
-	adjust_managed_page_count(pfn_to_page(pfn), nr_pages);
 	/* Drop our reference to the pages so the memory can get offlined. */
 	for (i = 0; i < nr_pages; i++) {
 		page = pfn_to_page(pfn + i);
@@ -1293,10 +1287,9 @@ static void virtio_mem_fake_offline_cancel_offline(unsigned long pfn,
 	unsigned long i;
 
 	/*
-	 * Get the reference we dropped when going offline and subtract the
-	 * unplugged pages from the managed page counters.
+	 * Get the reference again that we dropped via page_ref_dec_and_test()
+	 * when going offline.
 	 */
-	adjust_managed_page_count(pfn_to_page(pfn), -nr_pages);
 	for (i = 0; i < nr_pages; i++)
 		page_ref_inc(pfn_to_page(pfn + i));
 }
diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
index 7a9ff464608d7..ebe876930e782 100644
--- a/include/linux/memory_hotplug.h
+++ b/include/linux/memory_hotplug.h
@@ -175,8 +175,8 @@ extern int mhp_init_memmap_on_memory(unsigned long pfn, unsigned long nr_pages,
 extern void mhp_deinit_memmap_on_memory(unsigned long pfn, unsigned long nr_pages);
 extern int online_pages(unsigned long pfn, unsigned long nr_pages,
 			struct zone *zone, struct memory_group *group);
-extern void __offline_isolated_pages(unsigned long start_pfn,
-				     unsigned long end_pfn);
+extern unsigned long __offline_isolated_pages(unsigned long start_pfn,
+		unsigned long end_pfn);
 
 typedef void (*online_page_callback_t)(struct page *page, unsigned int order);
 
diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index e0362ce7fc109..0876aca0833e7 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -1024,11 +1024,15 @@ PAGE_TYPE_OPS(Buddy, buddy, buddy)
  * putting them back to the buddy, it can do so via the memory notifier by
  * decrementing the reference count in MEM_GOING_OFFLINE and incrementing the
  * reference count in MEM_CANCEL_OFFLINE. When offlining, the PageOffline()
- * pages (now with a reference count of zero) are treated like free pages,
- * allowing the containing memory block to get offlined. A driver that
+ * pages (now with a reference count of zero) are treated like free (unmanaged)
+ * pages, allowing the containing memory block to get offlined. A driver that
  * relies on this feature is aware that re-onlining the memory block will
  * require not giving them to the buddy via generic_online_page().
  *
+ * Memory offlining code will not adjust the managed page count for any
+ * PageOffline() pages, treating them like they were never exposed to the
+ * buddy using generic_online_page().
+ *
  * There are drivers that mark a page PageOffline() and expect there won't be
  * any further access to page content. PFN walkers that read content of random
  * pages should check PageOffline() and synchronize with such drivers using
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 0254059efcbe1..965707a02556f 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1941,7 +1941,7 @@ int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages,
 			struct zone *zone, struct memory_group *group)
 {
 	const unsigned long end_pfn = start_pfn + nr_pages;
-	unsigned long pfn, system_ram_pages = 0;
+	unsigned long pfn, managed_pages, system_ram_pages = 0;
 	const int node = zone_to_nid(zone);
 	unsigned long flags;
 	struct memory_notify arg;
@@ -2062,7 +2062,7 @@ int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages,
 	} while (ret);
 
 	/* Mark all sections offline and remove free pages from the buddy. */
-	__offline_isolated_pages(start_pfn, end_pfn);
+	managed_pages = __offline_isolated_pages(start_pfn, end_pfn);
 	pr_debug("Offlined Pages %ld\n", nr_pages);
 
 	/*
@@ -2078,7 +2078,7 @@ int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages,
 	zone_pcp_enable(zone);
 
 	/* removal success */
-	adjust_managed_page_count(pfn_to_page(start_pfn), -nr_pages);
+	adjust_managed_page_count(pfn_to_page(start_pfn), -managed_pages);
 	adjust_present_page_count(pfn_to_page(start_pfn), group, -nr_pages);
 
 	/* reinitialise watermarks and update pcp limits */
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 039bc52cc9091..809bc4a816e85 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -6745,14 +6745,19 @@ void zone_pcp_reset(struct zone *zone)
 /*
  * All pages in the range must be in a single zone, must not contain holes,
  * must span full sections, and must be isolated before calling this function.
+ *
+ * Returns the number of managed (non-PageOffline()) pages in the range: the
+ * number of pages for which memory offlining code must adjust managed page
+ * counters using adjust_managed_page_count().
  */
-void __offline_isolated_pages(unsigned long start_pfn, unsigned long end_pfn)
+unsigned long __offline_isolated_pages(unsigned long start_pfn,
+		unsigned long end_pfn)
 {
+	unsigned long already_offline = 0, flags;
 	unsigned long pfn = start_pfn;
 	struct page *page;
 	struct zone *zone;
 	unsigned int order;
-	unsigned long flags;
 
 	offline_mem_sections(pfn, end_pfn);
 	zone = page_zone(pfn_to_page(pfn));
@@ -6774,6 +6779,7 @@ void __offline_isolated_pages(unsigned long start_pfn, unsigned long end_pfn)
 		if (PageOffline(page)) {
 			BUG_ON(page_count(page));
 			BUG_ON(PageBuddy(page));
+			already_offline++;
 			pfn++;
 			continue;
 		}
@@ -6786,6 +6792,8 @@ void __offline_isolated_pages(unsigned long start_pfn, unsigned long end_pfn)
 		pfn += (1 << order);
 	}
 	spin_unlock_irqrestore(&zone->lock, flags);
+
+	return end_pfn - start_pfn - already_offline;
 }
 #endif
 
-- 
2.45.1


