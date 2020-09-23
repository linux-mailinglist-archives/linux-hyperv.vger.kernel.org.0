Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA5F6275A0A
	for <lists+linux-hyperv@lfdr.de>; Wed, 23 Sep 2020 16:31:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726572AbgIWOb2 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 23 Sep 2020 10:31:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:36730 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726130AbgIWOb2 (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 23 Sep 2020 10:31:28 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 190C2B2C7;
        Wed, 23 Sep 2020 14:32:04 +0000 (UTC)
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
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <67928cbd-950a-3279-bf9b-29b04c87728b@suse.cz>
Date:   Wed, 23 Sep 2020 16:31:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <DAC9E747-BDDF-41B6-A89B-604880DD7543@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 9/16/20 9:31 PM, David Hildenbrand wrote:
> 
> 
>> Am 16.09.2020 um 20:50 schrieb osalvador@suse.de:
>> 
>> ﻿On 2020-09-16 20:34, David Hildenbrand wrote:
>>> When adding separate memory blocks via add_memory*() and onlining them
>>> immediately, the metadata (especially the memmap) of the next block will be
>>> placed onto one of the just added+onlined block. This creates a chain
>>> of unmovable allocations: If the last memory block cannot get
>>> offlined+removed() so will all dependant ones. We directly have unmovable
>>> allocations all over the place.
>>> This can be observed quite easily using virtio-mem, however, it can also
>>> be observed when using DIMMs. The freshly onlined pages will usually be
>>> placed to the head of the freelists, meaning they will be allocated next,
>>> turning the just-added memory usually immediately un-removable. The
>>> fresh pages are cold, prefering to allocate others (that might be hot)
>>> also feels to be the natural thing to do.
>>> It also applies to the hyper-v balloon xen-balloon, and ppc64 dlpar: when
>>> adding separate, successive memory blocks, each memory block will have
>>> unmovable allocations on them - for example gigantic pages will fail to
>>> allocate.
>>> While the ZONE_NORMAL doesn't provide any guarantees that memory can get
>>> offlined+removed again (any kind of fragmentation with unmovable
>>> allocations is possible), there are many scenarios (hotplugging a lot of
>>> memory, running workload, hotunplug some memory/as much as possible) where
>>> we can offline+remove quite a lot with this patchset.
>> 
>> Hi David,
>> 
> 
> Hi Oscar.
> 
>> I did not read through the patchset yet, so sorry if the question is nonsense, but is this not trying to fix the same issue the vmemmap patches did? [1]
> 
> Not nonesense at all. It only helps to some degree, though. It solves the dependencies due to the memmap. However, it‘s not completely ideal, especially for single memory blocks.
> 
> With single memory blocks (virtio-mem, xen-balloon, hv balloon, ppc dlpar) you still have unmovable (vmemmap chunks) all over the physical address space. Consider the gigantic page example after hotplug. You directly fragmented all hotplugged memory.
> 
> Of course, there might be (less extreme) dependencies due page tables for the identity mapping, extended struct pages and similar.
> 
> Having that said, there are other benefits when preferring other memory over just hotplugged memory. Think about adding+onlining memory during boot (dimms under QEMU, virtio-mem), once the system is up you will have most (all) of that memory completely untouched.
> 
> So while vmemmap on hotplugged memory would tackle some part of the issue, there are cases where this approach is better, and there are even benefits when combining both.

I see the point, but I don't think the head/tail mechanism is great for this. It
might sort of work, but with other interfering activity there are no guarantees
and it relies on a subtle implementation detail. There are better mechanisms
possible I think, such as preparing a larger MIGRATE_UNMOVABLE area in the
existing memory before we allocate those long-term management structures. Or
onlining a bunch of blocks as zone_movable first and only later convert to
zone_normal in a controlled way when existing normal zone becomes depeted?

I guess it's an issue that the e.g. 128M block onlines are so disconnected from
each other it's hard to employ a strategy that works best for e.g. a whole bunch
of GB onlined at once. But I noticed some effort towards new API, so maybe that
will be solved there too?

> Thanks!
> 
> David
> 
>> 
>> I was about to give it a new respin now that thw hwpoison stuff has been settled.
>> 
>> [1] https://patchwork.kernel.org/cover/11059175/
>> 
> 

