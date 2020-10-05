Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AA4F28359A
	for <lists+linux-hyperv@lfdr.de>; Mon,  5 Oct 2020 14:16:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725940AbgJEMQB (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 5 Oct 2020 08:16:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38236 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725946AbgJEMQB (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 5 Oct 2020 08:16:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601900158;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=KBX1TXpOrcsq29GpOBaph461kpBMaGykfCUU1aPiYHU=;
        b=fvHmXnd/fhhhC3C85g5BFdrmIpJzZWl5CQY8AFLn5GsGl0KDJ3JJSe4R3ZvDt25eNjR9m5
        xo8z6DUemt8FrHNcCRD5m8SUc+Mwt/J4VIvIrWXNXAGx2CNk1585qZjzFvUewNG6lU/qI9
        K/+lR5RrkkZmAC3aPnEaNTgZhZOnKDQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-587-BY-7UwbeNrSQH1yvi3bonA-1; Mon, 05 Oct 2020 08:15:54 -0400
X-MC-Unique: BY-7UwbeNrSQH1yvi3bonA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 110A38030CD;
        Mon,  5 Oct 2020 12:15:51 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-114-222.ams2.redhat.com [10.36.114.222])
        by smtp.corp.redhat.com (Postfix) with ESMTP id ACE6D277C6;
        Mon,  5 Oct 2020 12:15:36 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-hyperv@vger.kernel.org,
        xen-devel@lists.xenproject.org, linux-acpi@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michal Hocko <mhocko@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Mike Rapoport <rppt@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        Scott Cheloha <cheloha@linux.ibm.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Vlastimil Babka <vbabka@suse.cz>, Wei Liu <wei.liu@kernel.org>,
        Wei Yang <richard.weiyang@linux.alibaba.com>
Subject: [PATCH v2 0/5] mm: place pages to the freelist tail when onlining and undoing isolation
Date:   Mon,  5 Oct 2020 14:15:29 +0200
Message-Id: <20201005121534.15649-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

When adding separate memory blocks via add_memory*() and onlining them
immediately, the metadata (especially the memmap) of the next block will be
placed onto one of the just added+onlined block. This creates a chain
of unmovable allocations: If the last memory block cannot get
offlined+removed() so will all dependent ones. We directly have unmovable
allocations all over the place.

This can be observed quite easily using virtio-mem, however, it can also
be observed when using DIMMs. The freshly onlined pages will usually be
placed to the head of the freelists, meaning they will be allocated next,
turning the just-added memory usually immediately un-removable. The
fresh pages are cold, prefering to allocate others (that might be hot)
also feels to be the natural thing to do.

It also applies to the hyper-v balloon xen-balloon, and ppc64 dlpar: when
adding separate, successive memory blocks, each memory block will have
unmovable allocations on them - for example gigantic pages will fail to
allocate.

While the ZONE_NORMAL doesn't provide any guarantees that memory can get
offlined+removed again (any kind of fragmentation with unmovable
allocations is possible), there are many scenarios (hotplugging a lot of
memory, running workload, hotunplug some memory/as much as possible) where
we can offline+remove quite a lot with this patchset.

a) To visualize the problem, a very simple example:

Start a VM with 4GB and 8GB of virtio-mem memory:

 [root@localhost ~]# lsmem
 RANGE                                 SIZE  STATE REMOVABLE  BLOCK
 0x0000000000000000-0x00000000bfffffff   3G online       yes   0-23
 0x0000000100000000-0x000000033fffffff   9G online       yes 32-103

 Memory block size:       128M
 Total online memory:      12G
 Total offline memory:      0B

Then try to unplug as much as possible using virtio-mem. Observe which
memory blocks are still around. Without this patch set:

 [root@localhost ~]# lsmem
 RANGE                                  SIZE  STATE REMOVABLE   BLOCK
 0x0000000000000000-0x00000000bfffffff    3G online       yes    0-23
 0x0000000100000000-0x000000013fffffff    1G online       yes   32-39
 0x0000000148000000-0x000000014fffffff  128M online       yes      41
 0x0000000158000000-0x000000015fffffff  128M online       yes      43
 0x0000000168000000-0x000000016fffffff  128M online       yes      45
 0x0000000178000000-0x000000017fffffff  128M online       yes      47
 0x0000000188000000-0x0000000197ffffff  256M online       yes   49-50
 0x00000001a0000000-0x00000001a7ffffff  128M online       yes      52
 0x00000001b0000000-0x00000001b7ffffff  128M online       yes      54
 0x00000001c0000000-0x00000001c7ffffff  128M online       yes      56
 0x00000001d0000000-0x00000001d7ffffff  128M online       yes      58
 0x00000001e0000000-0x00000001e7ffffff  128M online       yes      60
 0x00000001f0000000-0x00000001f7ffffff  128M online       yes      62
 0x0000000200000000-0x0000000207ffffff  128M online       yes      64
 0x0000000210000000-0x0000000217ffffff  128M online       yes      66
 0x0000000220000000-0x0000000227ffffff  128M online       yes      68
 0x0000000230000000-0x0000000237ffffff  128M online       yes      70
 0x0000000240000000-0x0000000247ffffff  128M online       yes      72
 0x0000000250000000-0x0000000257ffffff  128M online       yes      74
 0x0000000260000000-0x0000000267ffffff  128M online       yes      76
 0x0000000270000000-0x0000000277ffffff  128M online       yes      78
 0x0000000280000000-0x0000000287ffffff  128M online       yes      80
 0x0000000290000000-0x0000000297ffffff  128M online       yes      82
 0x00000002a0000000-0x00000002a7ffffff  128M online       yes      84
 0x00000002b0000000-0x00000002b7ffffff  128M online       yes      86
 0x00000002c0000000-0x00000002c7ffffff  128M online       yes      88
 0x00000002d0000000-0x00000002d7ffffff  128M online       yes      90
 0x00000002e0000000-0x00000002e7ffffff  128M online       yes      92
 0x00000002f0000000-0x00000002f7ffffff  128M online       yes      94
 0x0000000300000000-0x0000000307ffffff  128M online       yes      96
 0x0000000310000000-0x0000000317ffffff  128M online       yes      98
 0x0000000320000000-0x0000000327ffffff  128M online       yes     100
 0x0000000330000000-0x000000033fffffff  256M online       yes 102-103

 Memory block size:       128M
 Total online memory:     8.1G
 Total offline memory:      0B

With this patch set:

 [root@localhost ~]# lsmem
 RANGE                                 SIZE  STATE REMOVABLE BLOCK
 0x0000000000000000-0x00000000bfffffff   3G online       yes  0-23
 0x0000000100000000-0x000000013fffffff   1G online       yes 32-39

 Memory block size:       128M
 Total online memory:       4G
 Total offline memory:      0B

All memory can get unplugged, all memory block can get removed. Of course,
no workload ran and the system was basically idle, but it highlights the
issue - the fairly deterministic chain of unmovable allocations. When a
huge page for the 2MB memmap is needed, a just-onlined 4MB page will
be split. The remaining 2MB page will be used for the memmap of the next
memory block. So one memory block will hold the memmap of the two following
memory blocks. Finally the pages of the last-onlined memory block will get
used for the next bigger allocations - if any allocation is unmovable,
all dependent memory blocks cannot get unplugged and removed until that
allocation is gone.

Note that with bigger memory blocks (e.g., 256MB), *all* memory
blocks are dependent and none can get unplugged again!

b) Experiment with memory intensive workload

I performed an experiment with an older version of this patch set
(before we used undo_isolate_page_range() in online_pages():
Hotplug 56GB to a VM with an initial 4GB, onlining all memory to
ZONE_NORMAL right from the kernel when adding it. I then run various
memory intensive workloads that consume most system memory for a total of
45 minutes. Once finished, I try to unplug as much memory as possible.

With this change, I am able to remove via virtio-mem (adding individual
128MB memory blocks) 413 out of 448 added memory blocks. Via individual
(256MB) DIMMs 380 out of 448 added memory blocks. (I don't have any numbers
without this patchset, but looking at the above example, it's at most half
of the 448 memory blocks for virtio-mem, and most probably none for DIMMs).

Again, there are workloads that might behave very differently due to the
nature of ZONE_NORMAL.

This change also affects (besodes memory onlining):
- Other users of undo_isolate_page_range(): Pages are always placed to the
  tail.
-- When memory offlining fails
-- When memory isolation fails after having isolated some pageblocks
-- When alloc_contig_range() either succeeds or fails
- Other users of __putback_isolated_page(): Pages are always placed to the
  tail.
-- Free page reporting
- Other users of __free_pages_core()
-- AFAIKs, any memory that is getting exposed to the buddy during boot.
   IIUC we will now usually allocate memory from lower addresses within
   a zone first (especially during boot).
- Other users of generic_online_page()
-- Hyper-V balloon

v1 -> v2:
- Avoid changing indentation/alignment of function parameters
- Minor spelling fixes
- "mm/page_alloc: convert "report" flag of __free_one_page() to a proper
   flag"
-- fop_t -> fpi_t
-- Clarify/extend documentation of FPI_SKIP_REPORT_NOTIFY
- "mm/page_alloc: move pages to tail in move_to_free_list()"
-- Perform change for all move_to_free_list()/move_freepages_block() users
   to simplify.
-- Adjust subject/description accordingly.
- "mm/page_alloc: place pages to tail in __free_pages_core()"
-- s/init_single_page/__init_single_page/

RFC -> v1:
- Tweak some patch descriptions
- "mm/page_alloc: place pages to tail in __putback_isolated_page()"
-- FOP_TO_TAIL now has higher precedence than page shuffling
-- Add a note that nothing should rely on FOP_TO_TAIL for correctness
- "mm/page_alloc: always move pages to the tail of the freelist in
   unset_migratetype_isolate()"
-- Use "bool" parameter for move_freepages_block() as requested
- "mm/page_alloc: place pages to tail in __free_pages_core()"
-- Eliminate set_page_refcounted() + page_ref_dec() and add a comment
- "mm/memory_hotplug: update comment regarding zone shuffling"
-- Added

David Hildenbrand (5):
  mm/page_alloc: convert "report" flag of __free_one_page() to a proper
    flag
  mm/page_alloc: place pages to tail in __putback_isolated_page()
  mm/page_alloc: move pages to tail in move_to_free_list()
  mm/page_alloc: place pages to tail in __free_pages_core()
  mm/memory_hotplug: update comment regarding zone shuffling

 mm/memory_hotplug.c | 11 +++---
 mm/page_alloc.c     | 84 +++++++++++++++++++++++++++++++++++----------
 mm/page_isolation.c |  5 +++
 3 files changed, 75 insertions(+), 25 deletions(-)

-- 
2.26.2

