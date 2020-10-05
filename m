Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1BC2283200
	for <lists+linux-hyperv@lfdr.de>; Mon,  5 Oct 2020 10:29:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725891AbgJEI3E (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 5 Oct 2020 04:29:04 -0400
Received: from outbound-smtp30.blacknight.com ([81.17.249.61]:44485 "EHLO
        outbound-smtp30.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725880AbgJEI3E (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 5 Oct 2020 04:29:04 -0400
X-Greylist: delayed 492 seconds by postgrey-1.27 at vger.kernel.org; Mon, 05 Oct 2020 04:29:03 EDT
Received: from mail.blacknight.com (pemlinmail01.blacknight.ie [81.17.254.10])
        by outbound-smtp30.blacknight.com (Postfix) with ESMTPS id 26ED518068
        for <linux-hyperv@vger.kernel.org>; Mon,  5 Oct 2020 09:20:51 +0100 (IST)
Received: (qmail 11945 invoked from network); 5 Oct 2020 08:20:50 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.22.4])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 5 Oct 2020 08:20:50 -0000
Date:   Mon, 5 Oct 2020 09:20:49 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Michal Hocko <mhocko@suse.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-hyperv@vger.kernel.org,
        xen-devel@lists.xenproject.org, linux-acpi@vger.kernel.org,
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
Message-ID: <20201005082049.GI3227@techsingularity.net>
References: <20200928182110.7050-1-david@redhat.com>
 <20200928182110.7050-4-david@redhat.com>
 <20201002132404.GI4555@dhcp22.suse.cz>
 <df0c45bf-223f-1f0b-ce3d-f2b2e05626bd@redhat.com>
 <20201005065648.GO4555@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20201005065648.GO4555@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, Oct 05, 2020 at 08:56:48AM +0200, Michal Hocko wrote:
> On Fri 02-10-20 17:20:09, David Hildenbrand wrote:
> > On 02.10.20 15:24, Michal Hocko wrote:
> > > On Mon 28-09-20 20:21:08, David Hildenbrand wrote:
> > >> Page isolation doesn't actually touch the pages, it simply isolates
> > >> pageblocks and moves all free pages to the MIGRATE_ISOLATE freelist.
> > >>
> > >> We already place pages to the tail of the freelists when undoing
> > >> isolation via __putback_isolated_page(), let's do it in any case
> > >> (e.g., if order <= pageblock_order) and document the behavior.
> > >>
> > >> Add a "to_tail" parameter to move_freepages_block() but introduce a
> > >> a new move_to_free_list_tail() - similar to add_to_free_list_tail().
> > >>
> > >> This change results in all pages getting onlined via online_pages() to
> > >> be placed to the tail of the freelist.
> > > 
> > > Is there anything preventing to do this unconditionally? Or in other
> > > words is any of the existing callers of move_freepages_block benefiting
> > > from adding to the head?
> > 
> > 1. mm/page_isolation.c:set_migratetype_isolate()
> > 
> > We move stuff to the MIGRATE_ISOLATE list, we don't care about the order
> > there.
> > 
> > 2. steal_suitable_fallback():
> > 
> > I don't think we care too much about the order when already stealing
> > pageblocks ... and the freelist is empty I guess?
> > 
> > 3. reserve_highatomic_pageblock()/unreserve_highatomic_pageblock()
> > 
> > Not sure if we really care.
> 
> Honestly, I have no idea. I can imagine that some atomic high order
> workloads (e.g. in net) might benefit from cache line hot pages but I am
> not sure this is really observable.

The highatomic reserve is more concerned that about the allocation
succeeding than it is about cache hotness.

-- 
Mel Gorman
SUSE Labs
