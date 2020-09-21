Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15BF927190E
	for <lists+linux-hyperv@lfdr.de>; Mon, 21 Sep 2020 03:57:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726365AbgIUB5G (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 20 Sep 2020 21:57:06 -0400
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:50964 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726244AbgIUB5G (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 20 Sep 2020 21:57:06 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R391e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=richard.weiyang@linux.alibaba.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---0U9XKMRq_1600653420;
Received: from localhost(mailfrom:richard.weiyang@linux.alibaba.com fp:SMTPD_---0U9XKMRq_1600653420)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 21 Sep 2020 09:57:01 +0800
Date:   Mon, 21 Sep 2020 09:57:00 +0800
From:   Wei Yang <richard.weiyang@linux.alibaba.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Wei Yang <richard.weiyang@linux.alibaba.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
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
Subject: Re: [PATCH RFC 2/4] mm/page_alloc: place pages to tail in
 __putback_isolated_page()
Message-ID: <20200921015700.GA83969@L-31X9LVDL-1304.local>
Reply-To: Wei Yang <richard.weiyang@linux.alibaba.com>
References: <20200916183411.64756-1-david@redhat.com>
 <20200916183411.64756-3-david@redhat.com>
 <20200918020758.GB54754@L-31X9LVDL-1304.local>
 <e287e372-7b5d-9a0b-9e27-7de1e305fc3a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e287e372-7b5d-9a0b-9e27-7de1e305fc3a@redhat.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, Sep 18, 2020 at 09:27:23AM +0200, David Hildenbrand wrote:
>On 18.09.20 04:07, Wei Yang wrote:
>> On Wed, Sep 16, 2020 at 08:34:09PM +0200, David Hildenbrand wrote:
>>> __putback_isolated_page() already documents that pages will be placed to
>>> the tail of the freelist - this is, however, not the case for
>>> "order >= MAX_ORDER - 2" (see buddy_merge_likely()) - which should be
>>> the case for all existing users.
>>>
>>> This change affects two users:
>>> - free page reporting
>>> - page isolation, when undoing the isolation.
>>>
>>> This behavior is desireable for pages that haven't really been touched
>>> lately, so exactly the two users that don't actually read/write page
>>> content, but rather move untouched pages.
>>>
>>> The new behavior is especially desirable for memory onlining, where we
>>> allow allocation of newly onlined pages via undo_isolate_page_range()
>>> in online_pages(). Right now, we always place them to the head of the
>> 
>> The code looks good, while I don't fully understand the log here.
>> 
>> undo_isolate_page_range() is used in __offline_pages and alloc_contig_range. I
>> don't connect them with online_pages(). Do I miss something?
>
>Yeah, please look at -mm / -next instead. See
>
>https://lkml.kernel.org/r/20200819175957.28465-11-david@redhat.com
>

Thanks, I get the point.

>
>-- 
>Thanks,
>
>David / dhildenb

-- 
Wei Yang
Help you, Help me
