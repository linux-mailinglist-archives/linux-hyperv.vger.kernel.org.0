Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75E1726C876
	for <lists+linux-hyperv@lfdr.de>; Wed, 16 Sep 2020 20:50:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726507AbgIPSut (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 16 Sep 2020 14:50:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:50312 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727499AbgIPSup (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 16 Sep 2020 14:50:45 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A4D40AF6D;
        Wed, 16 Sep 2020 18:50:58 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 16 Sep 2020 20:50:41 +0200
From:   osalvador@suse.de
To:     David Hildenbrand <david@redhat.com>
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
        Vlastimil Babka <vbabka@suse.cz>, Wei Liu <wei.liu@kernel.org>,
        Wei Yang <richard.weiyang@linux.alibaba.com>
Subject: Re: [PATCH RFC 0/4] mm: place pages to the freelist tail when onling
 and undoing isolation
In-Reply-To: <20200916183411.64756-1-david@redhat.com>
References: <20200916183411.64756-1-david@redhat.com>
User-Agent: Roundcube Webmail
Message-ID: <5c0910c2cd0d9d351e509392a45552fb@suse.de>
X-Sender: osalvador@suse.de
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 2020-09-16 20:34, David Hildenbrand wrote:
> When adding separate memory blocks via add_memory*() and onlining them
> immediately, the metadata (especially the memmap) of the next block 
> will be
> placed onto one of the just added+onlined block. This creates a chain
> of unmovable allocations: If the last memory block cannot get
> offlined+removed() so will all dependant ones. We directly have 
> unmovable
> allocations all over the place.
> 
> This can be observed quite easily using virtio-mem, however, it can 
> also
> be observed when using DIMMs. The freshly onlined pages will usually be
> placed to the head of the freelists, meaning they will be allocated 
> next,
> turning the just-added memory usually immediately un-removable. The
> fresh pages are cold, prefering to allocate others (that might be hot)
> also feels to be the natural thing to do.
> 
> It also applies to the hyper-v balloon xen-balloon, and ppc64 dlpar: 
> when
> adding separate, successive memory blocks, each memory block will have
> unmovable allocations on them - for example gigantic pages will fail to
> allocate.
> 
> While the ZONE_NORMAL doesn't provide any guarantees that memory can 
> get
> offlined+removed again (any kind of fragmentation with unmovable
> allocations is possible), there are many scenarios (hotplugging a lot 
> of
> memory, running workload, hotunplug some memory/as much as possible) 
> where
> we can offline+remove quite a lot with this patchset.

Hi David,

I did not read through the patchset yet, so sorry if the question is 
nonsense, but is this not trying to fix the same issue the vmemmap 
patches did? [1]

I was about to give it a new respin now that thw hwpoison stuff has been 
settled.

[1] https://patchwork.kernel.org/cover/11059175/
> 
