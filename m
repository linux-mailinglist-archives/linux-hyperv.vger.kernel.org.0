Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C5A6275BCA
	for <lists+linux-hyperv@lfdr.de>; Wed, 23 Sep 2020 17:26:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726184AbgIWP0U (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 23 Sep 2020 11:26:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:49658 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726684AbgIWP0U (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 23 Sep 2020 11:26:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600874777;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=TpOu0LQpxSmgKrorKRNPGs/CUcDdTq51lBoo6YwLZQU=;
        b=SRpPaXFIOG4QJJNhlgdMeyy6o5FCDr7ArKxtgKmBfav0dli36XXpknns3kDGiSBYCzpeAe
        yCdL0U+5w3G7l3p8q9/BuK7lv5WseTYRt5NkvVegUR1KF9wu1pm1JejeTrNIuJECrINt35
        E2Xx3ND9snZuvyLay52FJyF3saFvPNI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-82-ohuB0gbdOfCPTqcziG7Twg-1; Wed, 23 Sep 2020 11:26:14 -0400
X-MC-Unique: ohuB0gbdOfCPTqcziG7Twg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 552CD10BBED9;
        Wed, 23 Sep 2020 15:26:11 +0000 (UTC)
Received: from [10.36.112.54] (ovpn-112-54.ams2.redhat.com [10.36.112.54])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 321B57B7CF;
        Wed, 23 Sep 2020 15:26:07 +0000 (UTC)
Subject: Re: [PATCH RFC 0/4] mm: place pages to the freelist tail when onling
 and undoing isolation
To:     Vlastimil Babka <vbabka@suse.cz>, osalvador@suse.de
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
From:   David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
 WNyWQQ==
Organization: Red Hat GmbH
Message-ID: <fee562a3-9f8f-e9b4-68fe-09c5ea885b91@redhat.com>
Date:   Wed, 23 Sep 2020 17:26:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <67928cbd-950a-3279-bf9b-29b04c87728b@suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 23.09.20 16:31, Vlastimil Babka wrote:
> On 9/16/20 9:31 PM, David Hildenbrand wrote:
>>
>>
>>> Am 16.09.2020 um 20:50 schrieb osalvador@suse.de:
>>>
>>> ﻿On 2020-09-16 20:34, David Hildenbrand wrote:
>>>> When adding separate memory blocks via add_memory*() and onlining them
>>>> immediately, the metadata (especially the memmap) of the next block will be
>>>> placed onto one of the just added+onlined block. This creates a chain
>>>> of unmovable allocations: If the last memory block cannot get
>>>> offlined+removed() so will all dependant ones. We directly have unmovable
>>>> allocations all over the place.
>>>> This can be observed quite easily using virtio-mem, however, it can also
>>>> be observed when using DIMMs. The freshly onlined pages will usually be
>>>> placed to the head of the freelists, meaning they will be allocated next,
>>>> turning the just-added memory usually immediately un-removable. The
>>>> fresh pages are cold, prefering to allocate others (that might be hot)
>>>> also feels to be the natural thing to do.
>>>> It also applies to the hyper-v balloon xen-balloon, and ppc64 dlpar: when
>>>> adding separate, successive memory blocks, each memory block will have
>>>> unmovable allocations on them - for example gigantic pages will fail to
>>>> allocate.
>>>> While the ZONE_NORMAL doesn't provide any guarantees that memory can get
>>>> offlined+removed again (any kind of fragmentation with unmovable
>>>> allocations is possible), there are many scenarios (hotplugging a lot of
>>>> memory, running workload, hotunplug some memory/as much as possible) where
>>>> we can offline+remove quite a lot with this patchset.
>>>
>>> Hi David,
>>>
>>
>> Hi Oscar.
>>
>>> I did not read through the patchset yet, so sorry if the question is nonsense, but is this not trying to fix the same issue the vmemmap patches did? [1]
>>
>> Not nonesense at all. It only helps to some degree, though. It solves the dependencies due to the memmap. However, it‘s not completely ideal, especially for single memory blocks.
>>
>> With single memory blocks (virtio-mem, xen-balloon, hv balloon, ppc dlpar) you still have unmovable (vmemmap chunks) all over the physical address space. Consider the gigantic page example after hotplug. You directly fragmented all hotplugged memory.
>>
>> Of course, there might be (less extreme) dependencies due page tables for the identity mapping, extended struct pages and similar.
>>
>> Having that said, there are other benefits when preferring other memory over just hotplugged memory. Think about adding+onlining memory during boot (dimms under QEMU, virtio-mem), once the system is up you will have most (all) of that memory completely untouched.
>>
>> So while vmemmap on hotplugged memory would tackle some part of the issue, there are cases where this approach is better, and there are even benefits when combining both.
> 

Hi Vlastimil,

> I see the point, but I don't think the head/tail mechanism is great for this. It
> might sort of work, but with other interfering activity there are no guarantees
> and it relies on a subtle implementation detail. There are better mechanisms

For the specified use case of adding+onlining a whole bunch of memory
this works just fine. We don't care too much about "other interfering
activity" as you mention here, or about guarantees - this is a pure
optimization that seems to work just fine in practice.

I'm not sure about the "subtle implementation detail" - buddy merging,
and head/tail of buddy lists are a basic concept of our page allocator.
If that would ever change, the optimization here would be lost and we
would have to think of something else. Nothing would actually break -
and it's all kept directly in page_alloc.c

I'd like to stress that what I propose here is both simple and powerful.

> possible I think, such as preparing a larger MIGRATE_UNMOVABLE area in the
> existing memory before we allocate those long-term management structures. Or
> onlining a bunch of blocks as zone_movable first and only later convert to
> zone_normal in a controlled way when existing normal zone becomes depeted?

I see the following (more or less complicated) alternatives

1) Having a larger MIGRATE_UNMOVABLE area

a) Sizing it is difficult. I mean you would have to plan ahead for all
memory you might eventually hotplug later - and that could even be
impossible if you hotplug quite a lot of memory to a smaller machine.
(I've seen people in the vm/container world trying to hotplug 128GB
DIMMs to 2GB VMs ... and failing for obvious reasons)
b) not really desired. You usually want to have most memory movable, not
the opposite (just because you might hotplug memory in small chunks later).

2) smarter onlining

I have prototype patches for better auto-onlining (which I'll share at
some point), where I balance between ZONE_NORMAL and ZONE_MOVABLE in a
defined ratio. Assuming something very simple, adding separate memory
blocks and onlining them based on the current zone ratio (assuming a 1:4
normal:movable target ratio) would (without some other policies I have
in place) result in something like this for hotplugged memory (via
virtio-mem):

[N][M][M][M][M][N][M][M][M][M][N][M][M][M][M]...

(note: layout is suboptimal, just a simple example)

But even here, all [N] memory blocks would immediately be use for
allocations for the memmap of successive blocks. It doesn't solve the
dependency issues.

Now assume we would want to group [N] in a way to allow for gigantic
pages, like

[N][N][N][N][N][N][N][N][M][M][M][M] ....

we would, once again, never be able to allocate a gigantic page because
all [N] would contain a memmap.

3) conversion from MOVABLE -> NORMAL

While a conversion from MOVABLE to NORMAL would be interesting to see,
it's going to be a challenging task to actually implement (people expect
that page_zone() remains stable). Without any hacks, we'd have to

1. offline the selected (MOVABLE) memory block/chunk
2. online the selected memory block/chunk to the NORMAL zone

This is not something we can do out of random context (for example, we
need both, the device hotplug lock and the memory hotplug lock, as we
might race with user space) - so there might still be a chance of
corner-case OOMs.

(I assume there could also be quite a negative performance impact when
always relying on the conversion, and not properly planning ahead as in 2.)

> 
> I guess it's an issue that the e.g. 128M block onlines are so disconnected from
> each other it's hard to employ a strategy that works best for e.g. a whole bunch
> of GB onlined at once. But I noticed some effort towards new API, so maybe that
> will be solved there too?

While new interfaces might make it easier to identify boundaries of
separate DIMMs (e.g., to online a single DIMM either movable or
unmovable - which can partially be done right now when going via memory
resource boundaries), it doesn't help for the use case of adding
separate memory blocks.

So while having an automatic conversion from MOVABLE -> NORMAL would be
interesting, I doubt we'll see it in the foreseeable future. Are there
any similarly simple alternatives to optimize this?

Thanks!

-- 
Thanks,

David / dhildenb

