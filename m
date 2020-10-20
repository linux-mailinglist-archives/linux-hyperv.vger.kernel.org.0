Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BCD229413E
	for <lists+linux-hyperv@lfdr.de>; Tue, 20 Oct 2020 19:18:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390616AbgJTRSE (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 20 Oct 2020 13:18:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:52454 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390588AbgJTRSD (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 20 Oct 2020 13:18:03 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 456F0AD85;
        Tue, 20 Oct 2020 17:18:02 +0000 (UTC)
Subject: Re: [PATCH v2 2/5] mm/page_alloc: place pages to tail in
 __putback_isolated_page()
To:     David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-hyperv@vger.kernel.org,
        xen-devel@lists.xenproject.org, linux-acpi@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Oscar Salvador <osalvador@suse.de>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        Michal Hocko <mhocko@suse.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Michal Hocko <mhocko@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Mike Rapoport <rppt@kernel.org>,
        Scott Cheloha <cheloha@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>
References: <20201005121534.15649-1-david@redhat.com>
 <20201005121534.15649-3-david@redhat.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <ddeba755-eed5-d412-ffa0-4d1a6a4bc297@suse.cz>
Date:   Tue, 20 Oct 2020 19:18:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.2
MIME-Version: 1.0
In-Reply-To: <20201005121534.15649-3-david@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 10/5/20 2:15 PM, David Hildenbrand wrote:
> __putback_isolated_page() already documents that pages will be placed to
> the tail of the freelist - this is, however, not the case for
> "order >= MAX_ORDER - 2" (see buddy_merge_likely()) - which should be
> the case for all existing users.
> 
> This change affects two users:
> - free page reporting
> - page isolation, when undoing the isolation (including memory onlining).
> 
> This behavior is desireable for pages that haven't really been touched
> lately, so exactly the two users that don't actually read/write page
> content, but rather move untouched pages.
> 
> The new behavior is especially desirable for memory onlining, where we
> allow allocation of newly onlined pages via undo_isolate_page_range()
> in online_pages(). Right now, we always place them to the head of the
> freelist, resulting in undesireable behavior: Assume we add
> individual memory chunks via add_memory() and online them right away to
> the NORMAL zone. We create a dependency chain of unmovable allocations
> e.g., via the memmap. The memmap of the next chunk will be placed onto
> previous chunks - if the last block cannot get offlined+removed, all
> dependent ones cannot get offlined+removed. While this can already be
> observed with individual DIMMs, it's more of an issue for virtio-mem
> (and I suspect also ppc DLPAR).
> 
> Document that this should only be used for optimizations, and no code
> should rely on this behavior for correction (if the order of the
> freelists ever changes).
> 
> We won't care about page shuffling: memory onlining already properly
> shuffles after onlining. free page reporting doesn't care about
> physically contiguous ranges, and there are already cases where page
> isolation will simply move (physically close) free pages to (currently)
> the head of the freelists via move_freepages_block() instead of
> shuffling. If this becomes ever relevant, we should shuffle the whole
> zone when undoing isolation of larger ranges, and after
> free_contig_range().
> 
> Reviewed-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> Reviewed-by: Oscar Salvador <osalvador@suse.de>
> Reviewed-by: Wei Yang <richard.weiyang@linux.alibaba.com>
> Reviewed-by: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
> Acked-by: Michal Hocko <mhocko@suse.com>

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
