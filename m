Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F11F2835B2
	for <lists+linux-hyperv@lfdr.de>; Mon,  5 Oct 2020 14:17:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726160AbgJEMQ6 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 5 Oct 2020 08:16:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:32946 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726329AbgJEMQu (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 5 Oct 2020 08:16:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601900209;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0AsZOi2g9AlkyekUiDSDSjeyhdmKjvuUsI97IJKTuTs=;
        b=ic+D7sC4ZfZuNEKbtQv8oeu8IIy37KaR3P49BBhgbeAb1izamQ96ydf5IN7P+HF2h0Yi1U
        YpsIfSCyeKtKWPPL29HKNoM239QISArroBWsyMHU5JhCItKUPl3Hw3rNckzGdnZF7+01GW
        w5rM/BsDliBg6j4nriLC1X00qZt5xRQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-70-7gZGHkSGNu2LzffQTpddTg-1; Mon, 05 Oct 2020 08:16:45 -0400
X-MC-Unique: 7gZGHkSGNu2LzffQTpddTg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 887B4801AB1;
        Mon,  5 Oct 2020 12:16:43 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-114-222.ams2.redhat.com [10.36.114.222])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A40231A8EC;
        Mon,  5 Oct 2020 12:16:36 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-hyperv@vger.kernel.org,
        xen-devel@lists.xenproject.org, linux-acpi@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        Michal Hocko <mhocko@suse.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Michal Hocko <mhocko@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Oscar Salvador <osalvador@suse.de>,
        Mike Rapoport <rppt@kernel.org>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Subject: [PATCH v2 5/5] mm/memory_hotplug: update comment regarding zone shuffling
Date:   Mon,  5 Oct 2020 14:15:34 +0200
Message-Id: <20201005121534.15649-6-david@redhat.com>
In-Reply-To: <20201005121534.15649-1-david@redhat.com>
References: <20201005121534.15649-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

As we no longer shuffle via generic_online_page() and when undoing
isolation, we can simplify the comment.

We now effectively shuffle only once (properly) when onlining new
memory.

Reviewed-by: Wei Yang <richard.weiyang@linux.alibaba.com>
Acked-by: Michal Hocko <mhocko@suse.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Alexander Duyck <alexander.h.duyck@linux.intel.com>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Wei Yang <richard.weiyang@linux.alibaba.com>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/memory_hotplug.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 03a00cb68bf7..b44d4c7ba73b 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -858,13 +858,10 @@ int __ref online_pages(unsigned long pfn, unsigned long nr_pages,
 	undo_isolate_page_range(pfn, pfn + nr_pages, MIGRATE_MOVABLE);
 
 	/*
-	 * When exposing larger, physically contiguous memory areas to the
-	 * buddy, shuffling in the buddy (when freeing onlined pages, putting
-	 * them either to the head or the tail of the freelist) is only helpful
-	 * for maintaining the shuffle, but not for creating the initial
-	 * shuffle. Shuffle the whole zone to make sure the just onlined pages
-	 * are properly distributed across the whole freelist. Make sure to
-	 * shuffle once pageblocks are no longer isolated.
+	 * Freshly onlined pages aren't shuffled (e.g., all pages are placed to
+	 * the tail of the freelist when undoing isolation). Shuffle the whole
+	 * zone to make sure the just onlined pages are properly distributed
+	 * across the whole freelist - to create an initial shuffle.
 	 */
 	shuffle_zone(zone);
 
-- 
2.26.2

