Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BC7F28307A
	for <lists+linux-hyperv@lfdr.de>; Mon,  5 Oct 2020 08:56:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725898AbgJEG4y (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 5 Oct 2020 02:56:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:36870 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725869AbgJEG4w (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 5 Oct 2020 02:56:52 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1601881010;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UNEm7Tn9UNlLqhlrULq94v99iXKf+1bbfGtGmTKX+7I=;
        b=S66gtJ8axc/8vLsDG0Y3zJ3DfLtemEkgIHkSLUIWIDdOmJTl5ozJHZlvC9eijR1y/3zccB
        UdINSjYVIGbyFe6FVLK6h+OkKKunrDQK6t3reRK6hhZJGiR0LMbXvjHxmXk9olvfWeq9+p
        FIB95YWX0cll+IESTIBsni+toXRKRnQ=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 93222B224;
        Mon,  5 Oct 2020 06:56:50 +0000 (UTC)
Date:   Mon, 5 Oct 2020 08:56:48 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     David Hildenbrand <david@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-hyperv@vger.kernel.org, xen-devel@lists.xenproject.org,
        linux-acpi@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        Mike Rapoport <rppt@kernel.org>,
        Scott Cheloha <cheloha@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v1 3/5] mm/page_alloc: always move pages to the tail of
 the freelist in unset_migratetype_isolate()
Message-ID: <20201005065648.GO4555@dhcp22.suse.cz>
References: <20200928182110.7050-1-david@redhat.com>
 <20200928182110.7050-4-david@redhat.com>
 <20201002132404.GI4555@dhcp22.suse.cz>
 <df0c45bf-223f-1f0b-ce3d-f2b2e05626bd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <df0c45bf-223f-1f0b-ce3d-f2b2e05626bd@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri 02-10-20 17:20:09, David Hildenbrand wrote:
> On 02.10.20 15:24, Michal Hocko wrote:
> > On Mon 28-09-20 20:21:08, David Hildenbrand wrote:
> >> Page isolation doesn't actually touch the pages, it simply isolates
> >> pageblocks and moves all free pages to the MIGRATE_ISOLATE freelist.
> >>
> >> We already place pages to the tail of the freelists when undoing
> >> isolation via __putback_isolated_page(), let's do it in any case
> >> (e.g., if order <= pageblock_order) and document the behavior.
> >>
> >> Add a "to_tail" parameter to move_freepages_block() but introduce a
> >> a new move_to_free_list_tail() - similar to add_to_free_list_tail().
> >>
> >> This change results in all pages getting onlined via online_pages() to
> >> be placed to the tail of the freelist.
> > 
> > Is there anything preventing to do this unconditionally? Or in other
> > words is any of the existing callers of move_freepages_block benefiting
> > from adding to the head?
> 
> 1. mm/page_isolation.c:set_migratetype_isolate()
> 
> We move stuff to the MIGRATE_ISOLATE list, we don't care about the order
> there.
> 
> 2. steal_suitable_fallback():
> 
> I don't think we care too much about the order when already stealing
> pageblocks ... and the freelist is empty I guess?
> 
> 3. reserve_highatomic_pageblock()/unreserve_highatomic_pageblock()
> 
> Not sure if we really care.

Honestly, I have no idea. I can imagine that some atomic high order
workloads (e.g. in net) might benefit from cache line hot pages but I am
not sure this is really observable. If yes it would likely be better to
have this documented than relying on wild guess. If we do not have any
evidence then I would vote for simplicity first and go with
unconditional add_to_tail which would simply your patch a bit.

Maybe Vlastimil or Mel would have a better picture.

-- 
Michal Hocko
SUSE Labs
