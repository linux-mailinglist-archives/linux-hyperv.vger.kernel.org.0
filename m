Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06ACC294147
	for <lists+linux-hyperv@lfdr.de>; Tue, 20 Oct 2020 19:20:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730666AbgJTRUZ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 20 Oct 2020 13:20:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:53600 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730473AbgJTRUZ (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 20 Oct 2020 13:20:25 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id EDB3BAC23;
        Tue, 20 Oct 2020 17:20:22 +0000 (UTC)
Subject: Re: [PATCH v2 3/5] mm/page_alloc: move pages to tail in
 move_to_free_list()
To:     David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-hyperv@vger.kernel.org,
        xen-devel@lists.xenproject.org, linux-acpi@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Oscar Salvador <osalvador@suse.de>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Michal Hocko <mhocko@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Mike Rapoport <rppt@kernel.org>,
        Scott Cheloha <cheloha@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>
References: <20201005121534.15649-1-david@redhat.com>
 <20201005121534.15649-4-david@redhat.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <505935d6-90d2-3fce-57f0-5946968d6372@suse.cz>
Date:   Tue, 20 Oct 2020 19:20:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.2
MIME-Version: 1.0
In-Reply-To: <20201005121534.15649-4-david@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 10/5/20 2:15 PM, David Hildenbrand wrote:
> Whenever we move pages between freelists via move_to_free_list()/
> move_freepages_block(), we don't actually touch the pages:
> 1. Page isolation doesn't actually touch the pages, it simply isolates
>     pageblocks and moves all free pages to the MIGRATE_ISOLATE freelist.
>     When undoing isolation, we move the pages back to the target list.
> 2. Page stealing (steal_suitable_fallback()) moves free pages directly
>     between lists without touching them.
> 3. reserve_highatomic_pageblock()/unreserve_highatomic_pageblock() moves
>     free pages directly between freelists without touching them.
> 
> We already place pages to the tail of the freelists when undoing isolation
> via __putback_isolated_page(), let's do it in any case (e.g., if order <=
> pageblock_order) and document the behavior. To simplify, let's move the
> pages to the tail for all move_to_free_list()/move_freepages_block() users.
> 
> In 2., the target list is empty, so there should be no change. In 3.,
> we might observe a change, however, highatomic is more concerned about
> allocations succeeding than cache hotness - if we ever realize this
> change degrades a workload, we can special-case this instance and add a
> proper comment.
> 
> This change results in all pages getting onlined via online_pages() to
> be placed to the tail of the freelist.
> 
> Reviewed-by: Oscar Salvador <osalvador@suse.de>
> Acked-by: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
> Reviewed-by: Wei Yang <richard.weiyang@linux.alibaba.com>

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
