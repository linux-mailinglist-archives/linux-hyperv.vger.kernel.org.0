Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A4AD276DF8
	for <lists+linux-hyperv@lfdr.de>; Thu, 24 Sep 2020 11:55:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbgIXJzM (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 24 Sep 2020 05:55:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:40126 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726380AbgIXJzM (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 24 Sep 2020 05:55:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600941309;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=sGemXayVVcKI7k7rUXtOEXM3ho8iy5RAT6KxodnngbM=;
        b=CiLgMUWGeG2n52KNSvosb93+F/EDH2eaWcRwYNNxRIcjGKbCOyax8dXOnLkg4BSQH/FYvW
        bPo/y33ZIaxtP7fYSdYY4C3dxw7AwGeeXuz2dsh6PoQNpY/vKcE4/25MAL73XKRXGdl3bZ
        r6PB8phq9Sdi6i675WiiPtvbnw/BoRw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-390-i46fx_QgM_GO3Wvk61L0Aw-1; Thu, 24 Sep 2020 05:55:07 -0400
X-MC-Unique: i46fx_QgM_GO3Wvk61L0Aw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 021821017DC9;
        Thu, 24 Sep 2020 09:55:05 +0000 (UTC)
Received: from [10.36.114.4] (ovpn-114-4.ams2.redhat.com [10.36.114.4])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AE3166198B;
        Thu, 24 Sep 2020 09:55:00 +0000 (UTC)
Subject: Re: [PATCH RFC 0/4] mm: place pages to the freelist tail when onling
 and undoing isolation
To:     Mel Gorman <mgorman@techsingularity.net>
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
References: <5c0910c2cd0d9d351e509392a45552fb@suse.de>
 <DAC9E747-BDDF-41B6-A89B-604880DD7543@redhat.com>
 <67928cbd-950a-3279-bf9b-29b04c87728b@suse.cz>
 <fee562a3-9f8f-e9b4-68fe-09c5ea885b91@redhat.com>
 <20200924094026.GL3179@techsingularity.net>
From:   David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 mQINBFXLn5EBEAC+zYvAFJxCBY9Tr1xZgcESmxVNI/0ffzE/ZQOiHJl6mGkmA1R7/uUpiCjJ
 dBrn+lhhOYjjNefFQou6478faXE6o2AhmebqT4KiQoUQFV4R7y1KMEKoSyy8hQaK1umALTdL
 QZLQMzNE74ap+GDK0wnacPQFpcG1AE9RMq3aeErY5tujekBS32jfC/7AnH7I0v1v1TbbK3Gp
 XNeiN4QroO+5qaSr0ID2sz5jtBLRb15RMre27E1ImpaIv2Jw8NJgW0k/D1RyKCwaTsgRdwuK
 Kx/Y91XuSBdz0uOyU/S8kM1+ag0wvsGlpBVxRR/xw/E8M7TEwuCZQArqqTCmkG6HGcXFT0V9
 PXFNNgV5jXMQRwU0O/ztJIQqsE5LsUomE//bLwzj9IVsaQpKDqW6TAPjcdBDPLHvriq7kGjt
 WhVhdl0qEYB8lkBEU7V2Yb+SYhmhpDrti9Fq1EsmhiHSkxJcGREoMK/63r9WLZYI3+4W2rAc
 UucZa4OT27U5ZISjNg3Ev0rxU5UH2/pT4wJCfxwocmqaRr6UYmrtZmND89X0KigoFD/XSeVv
 jwBRNjPAubK9/k5NoRrYqztM9W6sJqrH8+UWZ1Idd/DdmogJh0gNC0+N42Za9yBRURfIdKSb
 B3JfpUqcWwE7vUaYrHG1nw54pLUoPG6sAA7Mehl3nd4pZUALHwARAQABtCREYXZpZCBIaWxk
 ZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT6JAlgEEwEIAEICGwMGCwkIBwMCBhUIAgkKCwQW
 AgMBAh4BAheAAhkBFiEEG9nKrXNcTDpGDfzKTd4Q9wD/g1oFAl8Ox4kFCRKpKXgACgkQTd4Q
 9wD/g1oHcA//a6Tj7SBNjFNM1iNhWUo1lxAja0lpSodSnB2g4FCZ4R61SBR4l/psBL73xktp
 rDHrx4aSpwkRP6Epu6mLvhlfjmkRG4OynJ5HG1gfv7RJJfnUdUM1z5kdS8JBrOhMJS2c/gPf
 wv1TGRq2XdMPnfY2o0CxRqpcLkx4vBODvJGl2mQyJF/gPepdDfcT8/PY9BJ7FL6Hrq1gnAo4
 3Iv9qV0JiT2wmZciNyYQhmA1V6dyTRiQ4YAc31zOo2IM+xisPzeSHgw3ONY/XhYvfZ9r7W1l
 pNQdc2G+o4Di9NPFHQQhDw3YTRR1opJaTlRDzxYxzU6ZnUUBghxt9cwUWTpfCktkMZiPSDGd
 KgQBjnweV2jw9UOTxjb4LXqDjmSNkjDdQUOU69jGMUXgihvo4zhYcMX8F5gWdRtMR7DzW/YE
 BgVcyxNkMIXoY1aYj6npHYiNQesQlqjU6azjbH70/SXKM5tNRplgW8TNprMDuntdvV9wNkFs
 9TyM02V5aWxFfI42+aivc4KEw69SE9KXwC7FSf5wXzuTot97N9Phj/Z3+jx443jo2NR34XgF
 89cct7wJMjOF7bBefo0fPPZQuIma0Zym71cP61OP/i11ahNye6HGKfxGCOcs5wW9kRQEk8P9
 M/k2wt3mt/fCQnuP/mWutNPt95w9wSsUyATLmtNrwccz63W5Ag0EVcufkQEQAOfX3n0g0fZz
 Bgm/S2zF/kxQKCEKP8ID+Vz8sy2GpDvveBq4H2Y34XWsT1zLJdvqPI4af4ZSMxuerWjXbVWb
 T6d4odQIG0fKx4F8NccDqbgHeZRNajXeeJ3R7gAzvWvQNLz4piHrO/B4tf8svmRBL0ZB5P5A
 2uhdwLU3NZuK22zpNn4is87BPWF8HhY0L5fafgDMOqnf4guJVJPYNPhUFzXUbPqOKOkL8ojk
 CXxkOFHAbjstSK5Ca3fKquY3rdX3DNo+EL7FvAiw1mUtS+5GeYE+RMnDCsVFm/C7kY8c2d0G
 NWkB9pJM5+mnIoFNxy7YBcldYATVeOHoY4LyaUWNnAvFYWp08dHWfZo9WCiJMuTfgtH9tc75
 7QanMVdPt6fDK8UUXIBLQ2TWr/sQKE9xtFuEmoQGlE1l6bGaDnnMLcYu+Asp3kDT0w4zYGsx
 5r6XQVRH4+5N6eHZiaeYtFOujp5n+pjBaQK7wUUjDilPQ5QMzIuCL4YjVoylWiBNknvQWBXS
 lQCWmavOT9sttGQXdPCC5ynI+1ymZC1ORZKANLnRAb0NH/UCzcsstw2TAkFnMEbo9Zu9w7Kv
 AxBQXWeXhJI9XQssfrf4Gusdqx8nPEpfOqCtbbwJMATbHyqLt7/oz/5deGuwxgb65pWIzufa
 N7eop7uh+6bezi+rugUI+w6DABEBAAGJAjwEGAEIACYCGwwWIQQb2cqtc1xMOkYN/MpN3hD3
 AP+DWgUCXw7HsgUJEqkpoQAKCRBN3hD3AP+DWrrpD/4qS3dyVRxDcDHIlmguXjC1Q5tZTwNB
 boaBTPHSy/Nksu0eY7x6HfQJ3xajVH32Ms6t1trDQmPx2iP5+7iDsb7OKAb5eOS8h+BEBDeq
 3ecsQDv0fFJOA9ag5O3LLNk+3x3q7e0uo06XMaY7UHS341ozXUUI7wC7iKfoUTv03iO9El5f
 XpNMx/YrIMduZ2+nd9Di7o5+KIwlb2mAB9sTNHdMrXesX8eBL6T9b+MZJk+mZuPxKNVfEQMQ
 a5SxUEADIPQTPNvBewdeI80yeOCrN+Zzwy/Mrx9EPeu59Y5vSJOx/z6OUImD/GhX7Xvkt3kq
 Er5KTrJz3++B6SH9pum9PuoE/k+nntJkNMmQpR4MCBaV/J9gIOPGodDKnjdng+mXliF3Ptu6
 3oxc2RCyGzTlxyMwuc2U5Q7KtUNTdDe8T0uE+9b8BLMVQDDfJjqY0VVqSUwImzTDLX9S4g/8
 kC4HRcclk8hpyhY2jKGluZO0awwTIMgVEzmTyBphDg/Gx7dZU1Xf8HFuE+UZ5UDHDTnwgv7E
 th6RC9+WrhDNspZ9fJjKWRbveQgUFCpe1sa77LAw+XFrKmBHXp9ZVIe90RMe2tRL06BGiRZr
 jPrnvUsUUsjRoRNJjKKA/REq+sAnhkNPPZ/NNMjaZ5b8Tovi8C0tmxiCHaQYqj7G2rgnT0kt
 WNyWQQ==
Organization: Red Hat GmbH
Message-ID: <e2279c19-07aa-81c8-fe8c-c0efa6b982e7@redhat.com>
Date:   Thu, 24 Sep 2020 11:54:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200924094026.GL3179@techsingularity.net>
Content-Type: text/plain; charset=iso-8859-15
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 24.09.20 11:40, Mel Gorman wrote:
> On Wed, Sep 23, 2020 at 05:26:06PM +0200, David Hildenbrand wrote:
>>>>> ???On 2020-09-16 20:34, David Hildenbrand wrote:
>>>>>> When adding separate memory blocks via add_memory*() and onlining them
>>>>>> immediately, the metadata (especially the memmap) of the next block will be
>>>>>> placed onto one of the just added+onlined block. This creates a chain
>>>>>> of unmovable allocations: If the last memory block cannot get
>>>>>> offlined+removed() so will all dependant ones. We directly have unmovable
>>>>>> allocations all over the place.
>>>>>> This can be observed quite easily using virtio-mem, however, it can also
>>>>>> be observed when using DIMMs. The freshly onlined pages will usually be
>>>>>> placed to the head of the freelists, meaning they will be allocated next,
>>>>>> turning the just-added memory usually immediately un-removable. The
>>>>>> fresh pages are cold, prefering to allocate others (that might be hot)
>>>>>> also feels to be the natural thing to do.
>>>>>> It also applies to the hyper-v balloon xen-balloon, and ppc64 dlpar: when
>>>>>> adding separate, successive memory blocks, each memory block will have
>>>>>> unmovable allocations on them - for example gigantic pages will fail to
>>>>>> allocate.
>>>>>> While the ZONE_NORMAL doesn't provide any guarantees that memory can get
>>>>>> offlined+removed again (any kind of fragmentation with unmovable
>>>>>> allocations is possible), there are many scenarios (hotplugging a lot of
>>>>>> memory, running workload, hotunplug some memory/as much as possible) where
>>>>>> we can offline+remove quite a lot with this patchset.
>>>>>
>>>>> Hi David,
>>>>>
>>>>
>>>> Hi Oscar.
>>>>
>>>>> I did not read through the patchset yet, so sorry if the question is nonsense, but is this not trying to fix the same issue the vmemmap patches did? [1]
>>>>
>>>> Not nonesense at all. It only helps to some degree, though. It solves the dependencies due to the memmap. However, it???s not completely ideal, especially for single memory blocks.
>>>>
>>>> With single memory blocks (virtio-mem, xen-balloon, hv balloon, ppc dlpar) you still have unmovable (vmemmap chunks) all over the physical address space. Consider the gigantic page example after hotplug. You directly fragmented all hotplugged memory.
>>>>
>>>> Of course, there might be (less extreme) dependencies due page tables for the identity mapping, extended struct pages and similar.
>>>>
>>>> Having that said, there are other benefits when preferring other memory over just hotplugged memory. Think about adding+onlining memory during boot (dimms under QEMU, virtio-mem), once the system is up you will have most (all) of that memory completely untouched.
>>>>
>>>> So while vmemmap on hotplugged memory would tackle some part of the issue, there are cases where this approach is better, and there are even benefits when combining both.
>>>
>>
>> Hi Vlastimil,
>>
>>> I see the point, but I don't think the head/tail mechanism is great for this. It
>>> might sort of work, but with other interfering activity there are no guarantees
>>> and it relies on a subtle implementation detail. There are better mechanisms
>>
>> For the specified use case of adding+onlining a whole bunch of memory
>> this works just fine. We don't care too much about "other interfering
>> activity" as you mention here, or about guarantees - this is a pure
>> optimization that seems to work just fine in practice.
>>
>> I'm not sure about the "subtle implementation detail" - buddy merging,
>> and head/tail of buddy lists are a basic concept of our page allocator.
>> If that would ever change, the optimization here would be lost and we
>> would have to think of something else. Nothing would actually break -
>> and it's all kept directly in page_alloc.c
>>

Hi Mel,

thanks for your reply.

> 
> It's somewhat subtle because it's relying heavily on the exact ordering
> of how pages are pulled from the free lists at the moment. Lets say for
> example that someone was brave enough to tackle the problem of the giant
> zone lock and split the zone into allocation arenas (like what glibc does
> to split the lock). Depending on the exact ordering of how pages are
> added and removed from the list would break your approach. I'm wary of

First of all, it would not break it (as I already said). The
optimization would be lost. Totally acceptable.

However, I assume we would apply the same technique (optimized buddy
merging - placing to head/tail, page shuffling) on these allocation
arenas. So the optimization would still mostly apply, just in different
granularity - which would be fine.

> anything that relies on the ordering of freelists for correctness becauuse
> it limits the ability to fix the zone lock (which has been overdue for
> fixing for years now and getting worse as node sizes increase).

"for correctness" - no, this is an optimization. As I said, there are no
guarantees. Please keep that in mind.

(also, page shuffling relies on the ordering of freelists right now ...
for correctness)

> 
> To be robust, you'd need to do something like early memory bring-up whereby
> pages are directly allocated from one part of the DIMM (presumably the
> start) and use that for the metadata -- potentially all the metadata that
> would be necessary to plug/unplug the entire DIMM. This would effectively
> be unmovable but if you want to guarantee that all the memory except the
> metadata can be unplugged, you do not have much alteratives. Playing games
> with the ordering of the freelists will simply end up as "sometimes works,
> sometimes does not". 

As answered to Oscar already, while something like that might be
feasible for DIMMs in the future (and there are still quite some issues
to be sorted out), it isn't always desired adding separate (small -
e.g., 128MB) memory blocks.  You - again- have unmovable allocations all
over the place that won't allow you to allocate any gigantic page.

> 
> In terms of forcing ranges to be UNMOVABLE or MOVABLE (either via zones
> or by implementing "sticky" pageblocks which hits complex reclaim-related
> problems), you start running into problems similar to lowmem starvation
> where a page cache allocation fails because unmovable metadata cannot
> be allocated.

Exactly.

> 
> I suggest you keep it simple -- statically allocate the potential
> metadata needed in the future even though it limits the maximum amount
> of memory that can be unplugged. The alternative is unpredictable
> plug/unplug success rates.
> 

I'm sorry I can't follow. How is this "simple"?  Or even "simpler" than
what I suggest?

And as I said, it doesn't always work. Assume I hotplug 128GB to a 2GB
machine via virtio-mem (which works just fine, as we add+online memory
in small chunks compared to a single, huge DIMM), I would have to
pre-allocate 2GB just for the memmap - which obviously doesn't work.

Again, I'd like to stress that this is a pure optimization that I am
proposing - nothing would "break" when ripping it out again, except that
we lose the optimizations I mentioned.

-- 
Thanks,

David / dhildenb

