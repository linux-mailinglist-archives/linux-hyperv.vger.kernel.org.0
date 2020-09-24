Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AC21276DC0
	for <lists+linux-hyperv@lfdr.de>; Thu, 24 Sep 2020 11:47:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbgIXJrl (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 24 Sep 2020 05:47:41 -0400
Received: from outbound-smtp62.blacknight.com ([46.22.136.251]:54035 "EHLO
        outbound-smtp62.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726315AbgIXJrl (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 24 Sep 2020 05:47:41 -0400
X-Greylist: delayed 429 seconds by postgrey-1.27 at vger.kernel.org; Thu, 24 Sep 2020 05:47:39 EDT
Received: from mail.blacknight.com (pemlinmail06.blacknight.ie [81.17.255.152])
        by outbound-smtp62.blacknight.com (Postfix) with ESMTPS id D9600FAB6C
        for <linux-hyperv@vger.kernel.org>; Thu, 24 Sep 2020 10:40:28 +0100 (IST)
Received: (qmail 3548 invoked from network); 24 Sep 2020 09:40:28 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.22.4])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 24 Sep 2020 09:40:28 -0000
Date:   Thu, 24 Sep 2020 10:40:27 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     David Hildenbrand <david@redhat.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>, osalvador@suse.de,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-hyperv@vger.kernel.org, xen-devel@lists.xenproject.org,
        linux-acpi@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michal Hocko <mhocko@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Scott Cheloha <cheloha@linux.ibm.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Wei Yang <richard.weiyang@linux.alibaba.com>
Subject: Re: [PATCH RFC 0/4] mm: place pages to the freelist tail when onling
 and undoing isolation
Message-ID: <20200924094026.GL3179@techsingularity.net>
References: <5c0910c2cd0d9d351e509392a45552fb@suse.de>
 <DAC9E747-BDDF-41B6-A89B-604880DD7543@redhat.com>
 <67928cbd-950a-3279-bf9b-29b04c87728b@suse.cz>
 <fee562a3-9f8f-e9b4-68fe-09c5ea885b91@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <fee562a3-9f8f-e9b4-68fe-09c5ea885b91@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Sep 23, 2020 at 05:26:06PM +0200, David Hildenbrand wrote:
> >>> ???On 2020-09-16 20:34, David Hildenbrand wrote:
> >>>> When adding separate memory blocks via add_memory*() and onlining them
> >>>> immediately, the metadata (especially the memmap) of the next block will be
> >>>> placed onto one of the just added+onlined block. This creates a chain
> >>>> of unmovable allocations: If the last memory block cannot get
> >>>> offlined+removed() so will all dependant ones. We directly have unmovable
> >>>> allocations all over the place.
> >>>> This can be observed quite easily using virtio-mem, however, it can also
> >>>> be observed when using DIMMs. The freshly onlined pages will usually be
> >>>> placed to the head of the freelists, meaning they will be allocated next,
> >>>> turning the just-added memory usually immediately un-removable. The
> >>>> fresh pages are cold, prefering to allocate others (that might be hot)
> >>>> also feels to be the natural thing to do.
> >>>> It also applies to the hyper-v balloon xen-balloon, and ppc64 dlpar: when
> >>>> adding separate, successive memory blocks, each memory block will have
> >>>> unmovable allocations on them - for example gigantic pages will fail to
> >>>> allocate.
> >>>> While the ZONE_NORMAL doesn't provide any guarantees that memory can get
> >>>> offlined+removed again (any kind of fragmentation with unmovable
> >>>> allocations is possible), there are many scenarios (hotplugging a lot of
> >>>> memory, running workload, hotunplug some memory/as much as possible) where
> >>>> we can offline+remove quite a lot with this patchset.
> >>>
> >>> Hi David,
> >>>
> >>
> >> Hi Oscar.
> >>
> >>> I did not read through the patchset yet, so sorry if the question is nonsense, but is this not trying to fix the same issue the vmemmap patches did? [1]
> >>
> >> Not nonesense at all. It only helps to some degree, though. It solves the dependencies due to the memmap. However, it???s not completely ideal, especially for single memory blocks.
> >>
> >> With single memory blocks (virtio-mem, xen-balloon, hv balloon, ppc dlpar) you still have unmovable (vmemmap chunks) all over the physical address space. Consider the gigantic page example after hotplug. You directly fragmented all hotplugged memory.
> >>
> >> Of course, there might be (less extreme) dependencies due page tables for the identity mapping, extended struct pages and similar.
> >>
> >> Having that said, there are other benefits when preferring other memory over just hotplugged memory. Think about adding+onlining memory during boot (dimms under QEMU, virtio-mem), once the system is up you will have most (all) of that memory completely untouched.
> >>
> >> So while vmemmap on hotplugged memory would tackle some part of the issue, there are cases where this approach is better, and there are even benefits when combining both.
> > 
> 
> Hi Vlastimil,
> 
> > I see the point, but I don't think the head/tail mechanism is great for this. It
> > might sort of work, but with other interfering activity there are no guarantees
> > and it relies on a subtle implementation detail. There are better mechanisms
> 
> For the specified use case of adding+onlining a whole bunch of memory
> this works just fine. We don't care too much about "other interfering
> activity" as you mention here, or about guarantees - this is a pure
> optimization that seems to work just fine in practice.
> 
> I'm not sure about the "subtle implementation detail" - buddy merging,
> and head/tail of buddy lists are a basic concept of our page allocator.
> If that would ever change, the optimization here would be lost and we
> would have to think of something else. Nothing would actually break -
> and it's all kept directly in page_alloc.c
> 

It's somewhat subtle because it's relying heavily on the exact ordering
of how pages are pulled from the free lists at the moment. Lets say for
example that someone was brave enough to tackle the problem of the giant
zone lock and split the zone into allocation arenas (like what glibc does
to split the lock). Depending on the exact ordering of how pages are
added and removed from the list would break your approach. I'm wary of
anything that relies on the ordering of freelists for correctness becauuse
it limits the ability to fix the zone lock (which has been overdue for
fixing for years now and getting worse as node sizes increase).

To be robust, you'd need to do something like early memory bring-up whereby
pages are directly allocated from one part of the DIMM (presumably the
start) and use that for the metadata -- potentially all the metadata that
would be necessary to plug/unplug the entire DIMM. This would effectively
be unmovable but if you want to guarantee that all the memory except the
metadata can be unplugged, you do not have much alteratives. Playing games
with the ordering of the freelists will simply end up as "sometimes works,
sometimes does not". 

In terms of forcing ranges to be UNMOVABLE or MOVABLE (either via zones
or by implementing "sticky" pageblocks which hits complex reclaim-related
problems), you start running into problems similar to lowmem starvation
where a page cache allocation fails because unmovable metadata cannot
be allocated.

I suggest you keep it simple -- statically allocate the potential
metadata needed in the future even though it limits the maximum amount
of memory that can be unplugged. The alternative is unpredictable
plug/unplug success rates.

-- 
Mel Gorman
SUSE Labs
