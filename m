Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9053D26F6F5
	for <lists+linux-hyperv@lfdr.de>; Fri, 18 Sep 2020 09:29:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbgIRH3V (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 18 Sep 2020 03:29:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45540 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726343AbgIRH3V (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 18 Sep 2020 03:29:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600414158;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=3nNbPrMpeCmauSWcgQKTEdZjS23TgYlhx2xl9AxKkXk=;
        b=gOGvOYHCyYSUXoPtsWQrgeJgMQfsenxJ3PmVfegCjyFM6NMOH04fNTFohuKrDym3fipv1F
        AybfzSIu5Z2mSISVdCxzoMWqsg4RbAAmEpw0gwcVMoJtH9h/XE84mFJ72WFTr7a+iu/NYv
        oHOZNUs+7saokbk5keudOo+vhnP1vpg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-531-OMcRpJM4O6-ksj2UXD6L4w-1; Fri, 18 Sep 2020 03:29:13 -0400
X-MC-Unique: OMcRpJM4O6-ksj2UXD6L4w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6046B800EBB;
        Fri, 18 Sep 2020 07:29:11 +0000 (UTC)
Received: from [10.36.114.41] (ovpn-114-41.ams2.redhat.com [10.36.114.41])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C3C5660FC2;
        Fri, 18 Sep 2020 07:29:07 +0000 (UTC)
Subject: Re: [PATCH RFC 2/4] mm/page_alloc: place pages to tail in
 __putback_isolated_page()
To:     Wei Yang <richard.weiyang@linux.alibaba.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-hyperv@vger.kernel.org, xen-devel@lists.xenproject.org,
        linux-acpi@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Michal Hocko <mhocko@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Oscar Salvador <osalvador@suse.de>,
        Mike Rapoport <rppt@kernel.org>,
        Scott Cheloha <cheloha@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>
References: <20200916183411.64756-1-david@redhat.com>
 <20200916183411.64756-3-david@redhat.com>
 <20200918021654.GC54754@L-31X9LVDL-1304.local>
From:   David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
 WNyWQQ==
Organization: Red Hat GmbH
Message-ID: <a9d38779-73c5-73e9-aa7d-e26b87f6dbbb@redhat.com>
Date:   Fri, 18 Sep 2020 09:29:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200918021654.GC54754@L-31X9LVDL-1304.local>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 18.09.20 04:16, Wei Yang wrote:
> On Wed, Sep 16, 2020 at 08:34:09PM +0200, David Hildenbrand wrote:
>> __putback_isolated_page() already documents that pages will be placed to
>> the tail of the freelist - this is, however, not the case for
>> "order >= MAX_ORDER - 2" (see buddy_merge_likely()) - which should be
>> the case for all existing users.
>>
>> This change affects two users:
>> - free page reporting
>> - page isolation, when undoing the isolation.
>>
>> This behavior is desireable for pages that haven't really been touched
>> lately, so exactly the two users that don't actually read/write page
>> content, but rather move untouched pages.
>>
>> The new behavior is especially desirable for memory onlining, where we
>> allow allocation of newly onlined pages via undo_isolate_page_range()
>> in online_pages(). Right now, we always place them to the head of the
>> free list, resulting in undesireable behavior: Assume we add
>> individual memory chunks via add_memory() and online them right away to
>> the NORMAL zone. We create a dependency chain of unmovable allocations
>> e.g., via the memmap. The memmap of the next chunk will be placed onto
>> previous chunks - if the last block cannot get offlined+removed, all
>> dependent ones cannot get offlined+removed. While this can already be
>> observed with individual DIMMs, it's more of an issue for virtio-mem
>> (and I suspect also ppc DLPAR).
>>
>> Note: If we observe a degradation due to the changed page isolation
>> behavior (which I doubt), we can always make this configurable by the
>> instance triggering undo of isolation (e.g., alloc_contig_range(),
>> memory onlining, memory offlining).
>>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: Alexander Duyck <alexander.h.duyck@linux.intel.com>
>> Cc: Mel Gorman <mgorman@techsingularity.net>
>> Cc: Michal Hocko <mhocko@kernel.org>
>> Cc: Dave Hansen <dave.hansen@intel.com>
>> Cc: Vlastimil Babka <vbabka@suse.cz>
>> Cc: Wei Yang <richard.weiyang@linux.alibaba.com>
>> Cc: Oscar Salvador <osalvador@suse.de>
>> Cc: Mike Rapoport <rppt@kernel.org>
>> Cc: Scott Cheloha <cheloha@linux.ibm.com>
>> Cc: Michael Ellerman <mpe@ellerman.id.au>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>> mm/page_alloc.c | 10 +++++++++-
>> 1 file changed, 9 insertions(+), 1 deletion(-)
>>
>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>> index 91cefb8157dd..bba9a0f60c70 100644
>> --- a/mm/page_alloc.c
>> +++ b/mm/page_alloc.c
>> @@ -89,6 +89,12 @@ typedef int __bitwise fop_t;
>>  */
>> #define FOP_SKIP_REPORT_NOTIFY	((__force fop_t)BIT(0))
>>
>> +/*
>> + * Place the freed page to the tail of the freelist after buddy merging. Will
>> + * get ignored with page shuffling enabled.
>> + */
>> +#define FOP_TO_TAIL		((__force fop_t)BIT(1))
>> +
>> /* prevent >1 _updater_ of zone percpu pageset ->high and ->batch fields */
>> static DEFINE_MUTEX(pcp_batch_high_lock);
>> #define MIN_PERCPU_PAGELIST_FRACTION	(8)
>> @@ -1040,6 +1046,8 @@ static inline void __free_one_page(struct page *page, unsigned long pfn,
>>
>> 	if (is_shuffle_order(order))
>> 		to_tail = shuffle_pick_tail();
>> +	else if (fop_flags & FOP_TO_TAIL)
>> +		to_tail = true;
> 
> Take another look into this part. Maybe we can move this check at top?
> 
> For online_page case, currently we have following call flow:
> 
>     online_page
>         online_pages_range
> 	shuffle_zone
> 
> This means we would always shuffle the newly added pages. Maybe we don't need
> to do the shuffle when adding them to the free_list?

Yeah we don't, but it doesn't really buy us too much as the call paths I
am touching are used by other mechanisms as well that need it
(especially undoing page isolation).

-- 
Thanks,

David / dhildenb

