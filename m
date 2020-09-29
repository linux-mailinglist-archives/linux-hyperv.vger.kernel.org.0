Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFAE027C16F
	for <lists+linux-hyperv@lfdr.de>; Tue, 29 Sep 2020 11:40:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727700AbgI2Jk0 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 29 Sep 2020 05:40:26 -0400
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:50140 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727698AbgI2Jk0 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 29 Sep 2020 05:40:26 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=richard.weiyang@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0UATyNsI_1601372421;
Received: from localhost(mailfrom:richard.weiyang@linux.alibaba.com fp:SMTPD_---0UATyNsI_1601372421)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 29 Sep 2020 17:40:21 +0800
Date:   Tue, 29 Sep 2020 17:40:21 +0800
From:   Wei Yang <richard.weiyang@linux.alibaba.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-hyperv@vger.kernel.org, xen-devel@lists.xenproject.org,
        linux-acpi@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Michal Hocko <mhocko@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        Oscar Salvador <osalvador@suse.de>,
        Mike Rapoport <rppt@kernel.org>
Subject: Re: [PATCH v1 5/5] mm/memory_hotplug: update comment regarding zone
 shuffling
Message-ID: <20200929094021.GD36904@L-31X9LVDL-1304.local>
Reply-To: Wei Yang <richard.weiyang@linux.alibaba.com>
References: <20200928182110.7050-1-david@redhat.com>
 <20200928182110.7050-6-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200928182110.7050-6-david@redhat.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, Sep 28, 2020 at 08:21:10PM +0200, David Hildenbrand wrote:
>As we no longer shuffle via generic_online_page() and when undoing
>isolation, we can simplify the comment.
>
>We now effectively shuffle only once (properly) when onlining new
>memory.
>
>Cc: Andrew Morton <akpm@linux-foundation.org>
>Cc: Alexander Duyck <alexander.h.duyck@linux.intel.com>
>Cc: Mel Gorman <mgorman@techsingularity.net>
>Cc: Michal Hocko <mhocko@kernel.org>
>Cc: Dave Hansen <dave.hansen@intel.com>
>Cc: Vlastimil Babka <vbabka@suse.cz>
>Cc: Wei Yang <richard.weiyang@linux.alibaba.com>
>Cc: Oscar Salvador <osalvador@suse.de>
>Cc: Mike Rapoport <rppt@kernel.org>
>Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Wei Yang <richard.weiyang@linux.alibaba.com>

>---
> mm/memory_hotplug.c | 11 ++++-------
> 1 file changed, 4 insertions(+), 7 deletions(-)
>
>diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
>index 9db80ee29caa..c589bd8801bb 100644
>--- a/mm/memory_hotplug.c
>+++ b/mm/memory_hotplug.c
>@@ -859,13 +859,10 @@ int __ref online_pages(unsigned long pfn, unsigned long nr_pages,
> 	undo_isolate_page_range(pfn, pfn + nr_pages, MIGRATE_MOVABLE);
> 
> 	/*
>-	 * When exposing larger, physically contiguous memory areas to the
>-	 * buddy, shuffling in the buddy (when freeing onlined pages, putting
>-	 * them either to the head or the tail of the freelist) is only helpful
>-	 * for maintaining the shuffle, but not for creating the initial
>-	 * shuffle. Shuffle the whole zone to make sure the just onlined pages
>-	 * are properly distributed across the whole freelist. Make sure to
>-	 * shuffle once pageblocks are no longer isolated.
>+	 * Freshly onlined pages aren't shuffled (e.g., all pages are placed to
>+	 * the tail of the freelist when undoing isolation). Shuffle the whole
>+	 * zone to make sure the just onlined pages are properly distributed
>+	 * across the whole freelist - to create an initial shuffle.
> 	 */
> 	shuffle_zone(zone);
> 
>-- 
>2.26.2

-- 
Wei Yang
Help you, Help me
