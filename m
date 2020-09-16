Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB2E026CE52
	for <lists+linux-hyperv@lfdr.de>; Thu, 17 Sep 2020 00:07:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726304AbgIPWH7 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 16 Sep 2020 18:07:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726205AbgIPWH6 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 16 Sep 2020 18:07:58 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7C89C0698CC;
        Wed, 16 Sep 2020 14:50:23 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id r9so10054117ioa.2;
        Wed, 16 Sep 2020 14:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9DHi2ho0KH+wBCRJM1DdFlQ9qEjTcKukPUUIn5wAvDI=;
        b=htt3avZzKb3wDFJrlO7nW1PKF5/0ogQcZFk/WRuB9jdLRxWHo/vy0dLwunk18z0aqn
         eXXnQbFUAy7VaYV+A2lKnHa9hzrohBakycpfI63LDxzIs8JeD8pEjGaU+xmUf1+/xRi1
         8cc1Ge9TC36xj4D4UdhShvdiRjGT0hRKMZQGhdurknx6870qwHhhXj++sz86ibO5tXYj
         6unm/zqd8M5Tw+LZfW6P73FzSRowq6fP5LFeN2Qusyl03BHEVAnSkT6QjwK0uJa5BVsG
         8hRigZ7rwgPqxVOwlIO5Z5bmKJguw4pDxFIy//9s8BLyQ5pn/nVK4YGl/QUsNQkVXWTI
         Qktg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9DHi2ho0KH+wBCRJM1DdFlQ9qEjTcKukPUUIn5wAvDI=;
        b=k7RE4IX5gForoeW4plW07fsjiCTs6R+ZqAojefjE0bazpRXyVyUVslP4MVDorhjC2A
         kNEXrp8oMYHZoxT/c1Aj2ly6um869XupghdVY4gtUMl7FcoBzApIQlLg5TzKoqbJnSgc
         KNOh4eEu2KHamVStWw5UNegEp8MvSduqmk3pEdhpQe4nbGCNMUUx0KlQA4LNIQJAvYVm
         2q7tKdtJR4Y+JJUVog9BoNk9GM+V3RNbHF3cdaSZ3FwUIXlQ85sGcJ0aOWUU1AynA14R
         SIkwiuD5OOoEhZ8eQhym0uGQH1UZCfFECsYTokeqyM1cXJBE73rc+Dd7GRILq2qRCfFE
         1RTA==
X-Gm-Message-State: AOAM5323NJQ8M9p01N5tQX6KOPsYoHYwTneta61nZ8iV2gA4RCU8dOYw
        rCiyymuRkK40MW3RxhXe098Rox4lFXu2qqflk/I=
X-Google-Smtp-Source: ABdhPJzRyZ8l88j/n9kP1d9xMPyJ+mETN/OqQSnYFVABj7UBsbzXNO5CFm0s7NjDHjMNiSM2H+aGPp2knGxx0vyO9mI=
X-Received: by 2002:a5e:8f4c:: with SMTP id x12mr21471194iop.38.1600293022783;
 Wed, 16 Sep 2020 14:50:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200916183411.64756-1-david@redhat.com> <20200916183411.64756-3-david@redhat.com>
In-Reply-To: <20200916183411.64756-3-david@redhat.com>
From:   Alexander Duyck <alexander.duyck@gmail.com>
Date:   Wed, 16 Sep 2020 14:50:11 -0700
Message-ID: <CAKgT0UfaERUDFhd=qCRRrQo4GW6B+9EqOu-B6g-K8nLGXAbc4g@mail.gmail.com>
Subject: Re: [PATCH RFC 2/4] mm/page_alloc: place pages to tail in __putback_isolated_page()
To:     David Hildenbrand <david@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
        linux-hyperv@vger.kernel.org, xen-devel@lists.xenproject.org,
        linux-acpi@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Michal Hocko <mhocko@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        Oscar Salvador <osalvador@suse.de>,
        Mike Rapoport <rppt@kernel.org>,
        Scott Cheloha <cheloha@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Sep 16, 2020 at 11:34 AM David Hildenbrand <david@redhat.com> wrote:
>
> __putback_isolated_page() already documents that pages will be placed to
> the tail of the freelist - this is, however, not the case for
> "order >= MAX_ORDER - 2" (see buddy_merge_likely()) - which should be
> the case for all existing users.
>
> This change affects two users:
> - free page reporting
> - page isolation, when undoing the isolation.
>
> This behavior is desireable for pages that haven't really been touched

I think "desirable" is misspelled here.

> lately, so exactly the two users that don't actually read/write page
> content, but rather move untouched pages.

So in reality we were already dealing with this for page reporting,
but not in the most direct way. If I recall we were adding the pages
to the head of the list and then when we would go back to pull more
pages we were doing list rotation in the report function so they were
technically being added to the head, but usually would end up back on
the tail anyway. If anything the benefit for page reporting is that it
should be more direct this way as we will only have to rescan the
pages now when we have consumed all of the reported ones on the list.

> The new behavior is especially desirable for memory onlining, where we
> allow allocation of newly onlined pages via undo_isolate_page_range()
> in online_pages(). Right now, we always place them to the head of the
> free list, resulting in undesireable behavior: Assume we add
> individual memory chunks via add_memory() and online them right away to
> the NORMAL zone. We create a dependency chain of unmovable allocations
> e.g., via the memmap. The memmap of the next chunk will be placed onto
> previous chunks - if the last block cannot get offlined+removed, all
> dependent ones cannot get offlined+removed. While this can already be
> observed with individual DIMMs, it's more of an issue for virtio-mem
> (and I suspect also ppc DLPAR).
>
> Note: If we observe a degradation due to the changed page isolation
> behavior (which I doubt), we can always make this configurable by the
> instance triggering undo of isolation (e.g., alloc_contig_range(),
> memory onlining, memory offlining).
>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> Cc: Mel Gorman <mgorman@techsingularity.net>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Dave Hansen <dave.hansen@intel.com>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Wei Yang <richard.weiyang@linux.alibaba.com>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Mike Rapoport <rppt@kernel.org>
> Cc: Scott Cheloha <cheloha@linux.ibm.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  mm/page_alloc.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 91cefb8157dd..bba9a0f60c70 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -89,6 +89,12 @@ typedef int __bitwise fop_t;
>   */
>  #define FOP_SKIP_REPORT_NOTIFY ((__force fop_t)BIT(0))
>
> +/*
> + * Place the freed page to the tail of the freelist after buddy merging. Will
> + * get ignored with page shuffling enabled.
> + */
> +#define FOP_TO_TAIL            ((__force fop_t)BIT(1))
> +
>  /* prevent >1 _updater_ of zone percpu pageset ->high and ->batch fields */
>  static DEFINE_MUTEX(pcp_batch_high_lock);
>  #define MIN_PERCPU_PAGELIST_FRACTION   (8)
> @@ -1040,6 +1046,8 @@ static inline void __free_one_page(struct page *page, unsigned long pfn,
>
>         if (is_shuffle_order(order))
>                 to_tail = shuffle_pick_tail();
> +       else if (fop_flags & FOP_TO_TAIL)
> +               to_tail = true;
>         else
>                 to_tail = buddy_merge_likely(pfn, buddy_pfn, page, order);
>
> @@ -3289,7 +3297,7 @@ void __putback_isolated_page(struct page *page, unsigned int order, int mt)
>
>         /* Return isolated page to tail of freelist. */
>         __free_one_page(page, page_to_pfn(page), zone, order, mt,
> -                       FOP_SKIP_REPORT_NOTIFY);
> +                       FOP_SKIP_REPORT_NOTIFY | FOP_TO_TAIL);
>  }
>
>  /*

The code looks good to me.

Reviewed-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
