Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B815B27735B
	for <lists+linux-hyperv@lfdr.de>; Thu, 24 Sep 2020 15:59:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728219AbgIXN7k (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 24 Sep 2020 09:59:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:44136 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728152AbgIXN7g (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 24 Sep 2020 09:59:36 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 9236CB0E6;
        Thu, 24 Sep 2020 13:59:34 +0000 (UTC)
Subject: Re: [PATCH RFC 0/4] mm: place pages to the freelist tail when onling
 and undoing isolation
To:     David Hildenbrand <david@redhat.com>, osalvador@suse.de
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-hyperv@vger.kernel.org, xen-devel@lists.xenproject.org,
        linux-acpi@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michal Hocko <mhocko@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Scott Cheloha <cheloha@linux.ibm.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Wei Yang <richard.weiyang@linux.alibaba.com>
References: <5c0910c2cd0d9d351e509392a45552fb@suse.de>
 <DAC9E747-BDDF-41B6-A89B-604880DD7543@redhat.com>
 <67928cbd-950a-3279-bf9b-29b04c87728b@suse.cz>
 <fee562a3-9f8f-e9b4-68fe-09c5ea885b91@redhat.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <3af66d9b-70b1-6c19-0073-fa33c57edcdd@suse.cz>
Date:   Thu, 24 Sep 2020 15:59:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <fee562a3-9f8f-e9b4-68fe-09c5ea885b91@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 9/23/20 5:26 PM, David Hildenbrand wrote:
> On 23.09.20 16:31, Vlastimil Babka wrote:
>> On 9/16/20 9:31 PM, David Hildenbrand wrote:
>> 
> 
> Hi Vlastimil,
> 
>> I see the point, but I don't think the head/tail mechanism is great for this. It
>> might sort of work, but with other interfering activity there are no guarantees
>> and it relies on a subtle implementation detail. There are better mechanisms
> 
> For the specified use case of adding+onlining a whole bunch of memory
> this works just fine. We don't care too much about "other interfering
> activity" as you mention here, or about guarantees - this is a pure
> optimization that seems to work just fine in practice.
> 
> I'm not sure about the "subtle implementation detail" - buddy merging,
> and head/tail of buddy lists are a basic concept of our page allocator.

Mel already explained that, so I won't repeat.

> If that would ever change, the optimization here would be lost and we
> would have to think of something else. Nothing would actually break -
> and it's all kept directly in page_alloc.c

Sure, but then it can become a pointless code churn.

> I'd like to stress that what I propose here is both simple and powerful.
> 
>> possible I think, such as preparing a larger MIGRATE_UNMOVABLE area in the
>> existing memory before we allocate those long-term management structures. Or
>> onlining a bunch of blocks as zone_movable first and only later convert to
>> zone_normal in a controlled way when existing normal zone becomes depeted?
> 
> I see the following (more or less complicated) alternatives
> 
> 1) Having a larger MIGRATE_UNMOVABLE area
> 
> a) Sizing it is difficult. I mean you would have to plan ahead for all
> memory you might eventually hotplug later - and that could even be

Yeah, hence my worry about existing interfaces that work on 128MB blocks
individually without a larger strategy.

> impossible if you hotplug quite a lot of memory to a smaller machine.
> (I've seen people in the vm/container world trying to hotplug 128GB
> DIMMs to 2GB VMs ... and failing for obvious reasons)

Some planning should still be possible to maximize the contiguous area without
unmovable allocations.

> b) not really desired. You usually want to have most memory movable, not
> the opposite (just because you might hotplug memory in small chunks later).
> 
> 2) smarter onlining
> 
> I have prototype patches for better auto-onlining (which I'll share at
> some point), where I balance between ZONE_NORMAL and ZONE_MOVABLE in a
> defined ratio. Assuming something very simple, adding separate memory
> blocks and onlining them based on the current zone ratio (assuming a 1:4
> normal:movable target ratio) would (without some other policies I have
> in place) result in something like this for hotplugged memory (via
> virtio-mem):
> 
> [N][M][M][M][M][N][M][M][M][M][N][M][M][M][M]...
> 
> (note: layout is suboptimal, just a simple example)
> 
> But even here, all [N] memory blocks would immediately be use for
> allocations for the memmap of successive blocks. It doesn't solve the
> dependency issues.
> 
> Now assume we would want to group [N] in a way to allow for gigantic
> pages, like
> 
> [N][N][N][N][N][N][N][N][M][M][M][M] ....
> 
> we would, once again, never be able to allocate a gigantic page because
> all [N] would contain a memmap.

The second approach should work, if you know how much you are going to online,
and plan the size the N group accordingly, and if the onlined amount is several
gigabytes, then only the first one (or first X) will be unusable for a gigantic
page, but the rest would be? Can't get much better than that.

> 3) conversion from MOVABLE -> NORMAL
> 
> While a conversion from MOVABLE to NORMAL would be interesting to see,
> it's going to be a challenging task to actually implement (people expect
> that page_zone() remains stable). Without any hacks, we'd have to
> 
> 1. offline the selected (MOVABLE) memory block/chunk
> 2. online the selected memory block/chunk to the NORMAL zone
> 
> This is not something we can do out of random context (for example, we
> need both, the device hotplug lock and the memory hotplug lock, as we
> might race with user space) - so there might still be a chance of
> corner-case OOMs.

Right, it's trickier than I thought.

> (I assume there could also be quite a negative performance impact when
> always relying on the conversion, and not properly planning ahead as in 2.)
> 
>> 
>> I guess it's an issue that the e.g. 128M block onlines are so disconnected from
>> each other it's hard to employ a strategy that works best for e.g. a whole bunch
>> of GB onlined at once. But I noticed some effort towards new API, so maybe that
>> will be solved there too?
> 
> While new interfaces might make it easier to identify boundaries of
> separate DIMMs (e.g., to online a single DIMM either movable or
> unmovable - which can partially be done right now when going via memory
> resource boundaries), it doesn't help for the use case of adding
> separate memory blocks.
> 
> So while having an automatic conversion from MOVABLE -> NORMAL would be
> interesting, I doubt we'll see it in the foreseeable future. Are there
> any similarly simple alternatives to optimize this?

I've reviewed the series and I won't block it - yes it's an optimistic approach
that can break and leave us with code churn. But at least it's not that much
code and the extra test in  __free_one_page() shouldn't make this hotpath too
worse. But I still hope we can achieve a more robust solution one day.

> Thanks!
> 

