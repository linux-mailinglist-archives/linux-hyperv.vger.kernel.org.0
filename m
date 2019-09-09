Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E41C5AD837
	for <lists+linux-hyperv@lfdr.de>; Mon,  9 Sep 2019 13:48:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404396AbfIILsv (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 9 Sep 2019 07:48:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57242 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732500AbfIILsv (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 9 Sep 2019 07:48:51 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B011D3060815;
        Mon,  9 Sep 2019 11:48:50 +0000 (UTC)
Received: from t460s.redhat.com (ovpn-116-173.ams2.redhat.com [10.36.116.173])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AF815100197A;
        Mon,  9 Sep 2019 11:48:39 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, Souptick Joarder <jrdr.linux@gmail.com>,
        linux-hyperv@vger.kernel.org, David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.com>,
        Michal Hocko <mhocko@suse.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Wei Yang <richard.weiyang@gmail.com>, Qian Cai <cai@lca.pw>
Subject: [PATCH v1 1/3] mm/memory_hotplug: Export generic_online_page()
Date:   Mon,  9 Sep 2019 13:48:28 +0200
Message-Id: <20190909114830.662-2-david@redhat.com>
In-Reply-To: <20190909114830.662-1-david@redhat.com>
References: <20190909114830.662-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Mon, 09 Sep 2019 11:48:50 +0000 (UTC)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Let's expose generic_online_page() so online_page_callback users can
simply fallback to the generic implementation when actually deciding to
online the pages.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Oscar Salvador <osalvador@suse.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Wei Yang <richard.weiyang@gmail.com>
Cc: Qian Cai <cai@lca.pw>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/memory_hotplug.h | 1 +
 mm/memory_hotplug.c            | 5 ++---
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
index 8ee3a2ae5131..71a620eabb62 100644
--- a/include/linux/memory_hotplug.h
+++ b/include/linux/memory_hotplug.h
@@ -102,6 +102,7 @@ extern unsigned long __offline_isolated_pages(unsigned long start_pfn,
 
 typedef void (*online_page_callback_t)(struct page *page, unsigned int order);
 
+extern void generic_online_page(struct page *page, unsigned int order);
 extern int set_online_page_callback(online_page_callback_t callback);
 extern int restore_online_page_callback(online_page_callback_t callback);
 
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 2f0d2908e235..f32a5feaf7ff 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -49,8 +49,6 @@
  * and restore_online_page_callback() for generic callback restore.
  */
 
-static void generic_online_page(struct page *page, unsigned int order);
-
 static online_page_callback_t online_page_callback = generic_online_page;
 static DEFINE_MUTEX(online_page_callback_lock);
 
@@ -616,7 +614,7 @@ void __online_page_free(struct page *page)
 }
 EXPORT_SYMBOL_GPL(__online_page_free);
 
-static void generic_online_page(struct page *page, unsigned int order)
+void generic_online_page(struct page *page, unsigned int order)
 {
 	kernel_map_pages(page, 1 << order, 1);
 	__free_pages_core(page, order);
@@ -626,6 +624,7 @@ static void generic_online_page(struct page *page, unsigned int order)
 		totalhigh_pages_add(1UL << order);
 #endif
 }
+EXPORT_SYMBOL_GPL(generic_online_page);
 
 static int online_pages_range(unsigned long start_pfn, unsigned long nr_pages,
 			void *arg)
-- 
2.21.0

