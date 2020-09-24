Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25981276EDE
	for <lists+linux-hyperv@lfdr.de>; Thu, 24 Sep 2020 12:37:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726615AbgIXKho (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 24 Sep 2020 06:37:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:43776 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726154AbgIXKho (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 24 Sep 2020 06:37:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 20DD2ADAB;
        Thu, 24 Sep 2020 10:38:21 +0000 (UTC)
Subject: Re: [PATCH RFC 2/4] mm/page_alloc: place pages to tail in
 __putback_isolated_page()
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
        Scott Cheloha <cheloha@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>
References: <20200916183411.64756-1-david@redhat.com>
 <20200916183411.64756-3-david@redhat.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <6edfc921-eacc-23bd-befa-f947fbcb50ba@suse.cz>
Date:   Thu, 24 Sep 2020 12:37:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200916183411.64756-3-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 9/16/20 8:34 PM, David Hildenbrand wrote:
> __putback_isolated_page() already documents that pages will be placed to
> the tail of the freelist - this is, however, not the case for
> "order >= MAX_ORDER - 2" (see buddy_merge_likely()) - which should be
> the case for all existing users.

I think here should be a sentence saying something along "Thus this patch
introduces a FOP_TO_TAIL flag to really ensure moving pages to tail."

> This change affects two users:
> - free page reporting
> - page isolation, when undoing the isolation.
> 
> This behavior is desireable for pages that haven't really been touched
> lately, so exactly the two users that don't actually read/write page
> content, but rather move untouched pages.
> 
> The new behavior is especially desirable for memory onlining, where we
> allow allocation of newly onlined pages via undo_isolate_page_range()
> in online_pages(). Right now, we always place them to the head of the
> free list, resulting in undesireable behavior: Assume we add
> individual memory chunks via add_memory() and online them right away to
> the NORMAL zone. We create a dependency chain of unmovable allocations
> e.g., via the memmap. The memmap of the next chunk will be placed onto
> previous chunks - if the last block cannot get offlined+removed, all
> dependent ones cannot get offlined+removed. While this can already be
> observed with individual DIMMs, it's more of an issue for virtio-mem
> (and I suspect also ppc DLPAR).
> 
> Note: If we observe a degradation due to the changed page isolation
> behavior (which I doubt), we can always make this configurable by the
> instance triggering undo of isolation (e.g., alloc_contig_range(),
> memory onlining, memory offlining).
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
> Cc: Scott Cheloha <cheloha@linux.ibm.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  mm/page_alloc.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 91cefb8157dd..bba9a0f60c70 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -89,6 +89,12 @@ typedef int __bitwise fop_t;
>   */
>  #define FOP_SKIP_REPORT_NOTIFY	((__force fop_t)BIT(0))
>  
> +/*
> + * Place the freed page to the tail of the freelist after buddy merging. Will
> + * get ignored with page shuffling enabled.
> + */
> +#define FOP_TO_TAIL		((__force fop_t)BIT(1))
> +
>  /* prevent >1 _updater_ of zone percpu pageset ->high and ->batch fields */
>  static DEFINE_MUTEX(pcp_batch_high_lock);
>  #define MIN_PERCPU_PAGELIST_FRACTION	(8)
> @@ -1040,6 +1046,8 @@ static inline void __free_one_page(struct page *page, unsigned long pfn,
>  
>  	if (is_shuffle_order(order))
>  		to_tail = shuffle_pick_tail();
> +	else if (fop_flags & FOP_TO_TAIL)
> +		to_tail = true;

Should we really let random shuffling decision have a larger priority than
explicit FOP_TO_TAIL request? Wei Yang mentioned that there's a call to
shuffle_zone() anyway to process a freshly added memory, so we don't need to do
that also during the process of addition itself? Might help with your goal of
reducing dependencies even on systems that do have shuffling enabled?

Thanks,
Vlastimil

>  	else
>  		to_tail = buddy_merge_likely(pfn, buddy_pfn, page, order);
>  
> @@ -3289,7 +3297,7 @@ void __putback_isolated_page(struct page *page, unsigned int order, int mt)
>  
>  	/* Return isolated page to tail of freelist. */
>  	__free_one_page(page, page_to_pfn(page), zone, order, mt,
> -			FOP_SKIP_REPORT_NOTIFY);
> +			FOP_SKIP_REPORT_NOTIFY | FOP_TO_TAIL);
>  }
>  
>  /*
> 

