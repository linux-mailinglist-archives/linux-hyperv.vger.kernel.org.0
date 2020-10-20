Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 943E429414F
	for <lists+linux-hyperv@lfdr.de>; Tue, 20 Oct 2020 19:21:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395348AbgJTRVy (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 20 Oct 2020 13:21:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:54646 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390846AbgJTRVy (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 20 Oct 2020 13:21:54 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C225CADFF;
        Tue, 20 Oct 2020 17:21:52 +0000 (UTC)
Subject: Re: [PATCH v2 5/5] mm/memory_hotplug: update comment regarding zone
 shuffling
To:     David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-hyperv@vger.kernel.org,
        xen-devel@lists.xenproject.org, linux-acpi@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        Michal Hocko <mhocko@suse.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Michal Hocko <mhocko@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Oscar Salvador <osalvador@suse.de>,
        Mike Rapoport <rppt@kernel.org>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>
References: <20201005121534.15649-1-david@redhat.com>
 <20201005121534.15649-6-david@redhat.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <79f2eb3b-d3db-3187-ff7e-1b7bb8e769a3@suse.cz>
Date:   Tue, 20 Oct 2020 19:21:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.2
MIME-Version: 1.0
In-Reply-To: <20201005121534.15649-6-david@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 10/5/20 2:15 PM, David Hildenbrand wrote:
> As we no longer shuffle via generic_online_page() and when undoing
> isolation, we can simplify the comment.
> 
> We now effectively shuffle only once (properly) when onlining new
> memory.
> 
> Reviewed-by: Wei Yang <richard.weiyang@linux.alibaba.com>
> Acked-by: Michal Hocko <mhocko@suse.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> Cc: Mel Gorman <mgorman@techsingularity.net>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Dave Hansen <dave.hansen@intel.com>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Wei Yang <richard.weiyang@linux.alibaba.com>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Mike Rapoport <rppt@kernel.org>
> Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>   mm/memory_hotplug.c | 11 ++++-------
>   1 file changed, 4 insertions(+), 7 deletions(-)
> 
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 03a00cb68bf7..b44d4c7ba73b 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -858,13 +858,10 @@ int __ref online_pages(unsigned long pfn, unsigned long nr_pages,
>   	undo_isolate_page_range(pfn, pfn + nr_pages, MIGRATE_MOVABLE);
>   
>   	/*
> -	 * When exposing larger, physically contiguous memory areas to the
> -	 * buddy, shuffling in the buddy (when freeing onlined pages, putting
> -	 * them either to the head or the tail of the freelist) is only helpful
> -	 * for maintaining the shuffle, but not for creating the initial
> -	 * shuffle. Shuffle the whole zone to make sure the just onlined pages
> -	 * are properly distributed across the whole freelist. Make sure to
> -	 * shuffle once pageblocks are no longer isolated.
> +	 * Freshly onlined pages aren't shuffled (e.g., all pages are placed to
> +	 * the tail of the freelist when undoing isolation). Shuffle the whole
> +	 * zone to make sure the just onlined pages are properly distributed
> +	 * across the whole freelist - to create an initial shuffle.
>   	 */
>   	shuffle_zone(zone);
>   
> 

