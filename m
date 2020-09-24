Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 648792772DB
	for <lists+linux-hyperv@lfdr.de>; Thu, 24 Sep 2020 15:44:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727911AbgIXNoz (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 24 Sep 2020 09:44:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:58550 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727859AbgIXNoz (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 24 Sep 2020 09:44:55 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 235E0ABAD;
        Thu, 24 Sep 2020 13:44:53 +0000 (UTC)
Subject: Re: [PATCH RFC 4/4] mm/page_alloc: place pages to tail in
 __free_pages_core()
To:     David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-hyperv@vger.kernel.org,
        xen-devel@lists.xenproject.org, linux-acpi@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Michal Hocko <mhocko@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        Oscar Salvador <osalvador@suse.de>,
        Mike Rapoport <rppt@kernel.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>
References: <20200916183411.64756-1-david@redhat.com>
 <20200916183411.64756-5-david@redhat.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <34a094bd-d37a-b735-14bb-ea65e2e2b7a1@suse.cz>
Date:   Thu, 24 Sep 2020 15:44:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200916183411.64756-5-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 9/16/20 8:34 PM, David Hildenbrand wrote:
> __free_pages_core() is used when exposing fresh memory to the buddy
> during system boot and when onlining memory in generic_online_page().
> 
> generic_online_page() is used in two cases:
> 
> 1. Direct memory onlining in online_pages().
> 2. Deferred memory onlining in memory-ballooning-like mechanisms (HyperV
>    balloon and virtio-mem), when parts of a section are kept
>    fake-offline to be fake-onlined later on.
> 
> In 1, we already place pages to the tail of the freelist. Pages will be
> freed to MIGRATE_ISOLATE lists first and moved to the tail of the freelists
> via undo_isolate_page_range().
> 
> In 2, we currently don't implement a proper rule. In case of virtio-mem,
> where we currently always online MAX_ORDER - 1 pages, the pages will be
> placed to the HEAD of the freelist - undesireable. While the hyper-v
> balloon calls generic_online_page() with single pages, usually it will
> call it on successive single pages in a larger block.
> 
> The pages are fresh, so place them to the tail of the freelists and avoid
> the PCP.
> 
> Note: If we detect that the new behavior is undesireable for
> __free_pages_core() during boot, we can let the caller specify the
> behavior.
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> Cc: Mel Gorman <mgorman@techsingularity.net>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Dave Hansen <dave.hansen@intel.com>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Wei Yang <richard.weiyang@linux.alibaba.com>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Mike Rapoport <rppt@kernel.org>
> Cc: "K. Y. Srinivasan" <kys@microsoft.com>
> Cc: Haiyang Zhang <haiyangz@microsoft.com>
> Cc: Stephen Hemminger <sthemmin@microsoft.com>
> Cc: Wei Liu <wei.liu@kernel.org>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  mm/page_alloc.c | 32 ++++++++++++++++++++------------
>  1 file changed, 20 insertions(+), 12 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 75b0f49b4022..50746e6dc21b 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -264,7 +264,8 @@ bool pm_suspended_storage(void)
>  unsigned int pageblock_order __read_mostly;
>  #endif
>  
> -static void __free_pages_ok(struct page *page, unsigned int order);
> +static void __free_pages_ok(struct page *page, unsigned int order,
> +			    fop_t fop_flags);
>  
>  /*
>   * results with 256, 32 in the lowmem_reserve sysctl:
> @@ -676,7 +677,7 @@ static void bad_page(struct page *page, const char *reason)
>  void free_compound_page(struct page *page)
>  {
>  	mem_cgroup_uncharge(page);
> -	__free_pages_ok(page, compound_order(page));
> +	__free_pages_ok(page, compound_order(page), FOP_NONE);
>  }
>  
>  void prep_compound_page(struct page *page, unsigned int order)
> @@ -1402,17 +1403,15 @@ static void free_pcppages_bulk(struct zone *zone, int count,
>  	spin_unlock(&zone->lock);
>  }
>  
> -static void free_one_page(struct zone *zone,
> -				struct page *page, unsigned long pfn,
> -				unsigned int order,
> -				int migratetype)
> +static void free_one_page(struct zone *zone, struct page *page, unsigned long pfn,
> +			  unsigned int order, int migratetype, fop_t fop_flags)
>  {
>  	spin_lock(&zone->lock);
>  	if (unlikely(has_isolate_pageblock(zone) ||
>  		is_migrate_isolate(migratetype))) {
>  		migratetype = get_pfnblock_migratetype(page, pfn);
>  	}
> -	__free_one_page(page, pfn, zone, order, migratetype, FOP_NONE);
> +	__free_one_page(page, pfn, zone, order, migratetype, fop_flags);
>  	spin_unlock(&zone->lock);
>  }
>  
> @@ -1490,7 +1489,8 @@ void __meminit reserve_bootmem_region(phys_addr_t start, phys_addr_t end)
>  	}
>  }
>  
> -static void __free_pages_ok(struct page *page, unsigned int order)
> +static void __free_pages_ok(struct page *page, unsigned int order,
> +			    fop_t fop_flags)
>  {
>  	unsigned long flags;
>  	int migratetype;
> @@ -1502,7 +1502,8 @@ static void __free_pages_ok(struct page *page, unsigned int order)
>  	migratetype = get_pfnblock_migratetype(page, pfn);
>  	local_irq_save(flags);
>  	__count_vm_events(PGFREE, 1 << order);
> -	free_one_page(page_zone(page), page, pfn, order, migratetype);
> +	free_one_page(page_zone(page), page, pfn, order, migratetype,
> +		      fop_flags);
>  	local_irq_restore(flags);
>  }
>  
> @@ -1523,7 +1524,13 @@ void __free_pages_core(struct page *page, unsigned int order)
>  
>  	atomic_long_add(nr_pages, &page_zone(page)->managed_pages);
>  	set_page_refcounted(page);
> -	__free_pages(page, order);
> +
> +	/*
> +	 * Bypass PCP and place fresh pages right to the tail, primarily
> +	 * relevant for memory onlining.
> +	 */
> +	page_ref_dec(page);
> +	__free_pages_ok(page, order, FOP_TO_TAIL);
>  }
>  
>  #ifdef CONFIG_NEED_MULTIPLE_NODES
> @@ -3167,7 +3174,8 @@ static void free_unref_page_commit(struct page *page, unsigned long pfn)
>  	 */
>  	if (migratetype >= MIGRATE_PCPTYPES) {
>  		if (unlikely(is_migrate_isolate(migratetype))) {
> -			free_one_page(zone, page, pfn, 0, migratetype);
> +			free_one_page(zone, page, pfn, 0, migratetype,
> +				      FOP_NONE);
>  			return;
>  		}
>  		migratetype = MIGRATE_MOVABLE;
> @@ -4984,7 +4992,7 @@ static inline void free_the_page(struct page *page, unsigned int order)
>  	if (order == 0)		/* Via pcp? */
>  		free_unref_page(page);
>  	else
> -		__free_pages_ok(page, order);
> +		__free_pages_ok(page, order, FOP_NONE);
>  }
>  
>  void __free_pages(struct page *page, unsigned int order)
> 

