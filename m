Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4805127B675
	for <lists+linux-hyperv@lfdr.de>; Mon, 28 Sep 2020 22:38:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbgI1Uir (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 28 Sep 2020 16:38:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726325AbgI1Uir (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 28 Sep 2020 16:38:47 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C39AC061755;
        Mon, 28 Sep 2020 13:38:47 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id f15so2681538ilj.2;
        Mon, 28 Sep 2020 13:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RnUzbIia0NAX7YNu6xY/oNMBx/xFLPCcfbG+81kQ5mc=;
        b=tltR1aMUodF5nkRM8cyDLmsi5fQHfl76MM63tnAbzplkLz2jke4mHz9iRqztBbf4Ql
         /e5kTXBINdPQATmHN0Z4FBWAQHIfEw4EXZZwvDs39YGN8a9VbK6MWAp9AICxG9CWb1ao
         JDCGZNqFhxL9QysVKyMsEk2CwMcGPGrmWKEwNvuGmQh0K9y7HV8YAm0RlTnmSiAZ6aaE
         nmR9Oy9AxXmKKqxqEQVU6DX8SoI32LkxfxQuUFZmhZQjqLGHNMbCUndxogM7/vRaij2t
         Mkei1km9STaHB548our4mbfW6rcj9zVY8AgBcW7+yRwpqxhbODOMlvLhSo4ZlGJM58l3
         iu4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RnUzbIia0NAX7YNu6xY/oNMBx/xFLPCcfbG+81kQ5mc=;
        b=FNg6k2TGXyONSqF9FD7BpRJm5FI3/PPv4Ip8vxUmgh746Mod0MbyjDdr73IgRWsFmt
         g31Ou1sQUTArqEmTTqG9jw9SQjJyzRHa7QXfIWEPcpEcOLEEDdngf354Hfitv5wnOsi+
         A21MmJeAaM4xp6NNcUrX70LyrwetABF10Pp38P9ZqEVUPS976j7mbFNl31XT1k1limBE
         EHyphETc7bRQVl3F0b6mFlbyssOtJQ8N1NL3V9EGvwjiDeHmAT6Hgewbm3N6OhFgJKNW
         +izxk1DaIcaG3cx1Pc0lPYzoKEA+VOwMkOqoT/y5B8cLUlqMGwbGDPSDkrEJ/kPrb2tZ
         DOsA==
X-Gm-Message-State: AOAM531Pxm5GRNtaogkxp2MNzuPZF/0oGWWJ4SZYtHDKFGuDCMM1y2Uo
        OTQQ1qtx9N3PuHKDnMo8ACZvq3Nrpj1VCnINf1Y=
X-Google-Smtp-Source: ABdhPJxjWOlMUtAx0Ie/fRo/uIuKgbTIfNY7SlCP+erH5Zk2azwfxXaEKbUxjnZFYoXuMDQaYHzKc8VClp8ne+ZnXf8=
X-Received: by 2002:a92:9ec7:: with SMTP id s68mr150414ilk.143.1601325526429;
 Mon, 28 Sep 2020 13:38:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200928182110.7050-1-david@redhat.com> <20200928182110.7050-3-david@redhat.com>
In-Reply-To: <20200928182110.7050-3-david@redhat.com>
From:   Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Date:   Mon, 28 Sep 2020 22:38:35 +0200
Message-ID: <CAM9Jb+iitZzZeF5b8eCWoR7fD=D3t76YDRaYsBC1o8nx-2jEYA@mail.gmail.com>
Subject: Re: [PATCH v1 2/5] mm/page_alloc: place pages to tail in __putback_isolated_page()
To:     David Hildenbrand <david@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        linux-hyperv@vger.kernel.org, xen-devel@lists.xenproject.org,
        linux-acpi@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Oscar Salvador <osalvador@suse.de>,
        Mel Gorman <mgorman@techsingularity.net>,
        Michal Hocko <mhocko@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        Mike Rapoport <rppt@kernel.org>,
        Scott Cheloha <cheloha@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> __putback_isolated_page() already documents that pages will be placed to
> the tail of the freelist - this is, however, not the case for
> "order >= MAX_ORDER - 2" (see buddy_merge_likely()) - which should be
> the case for all existing users.
>
> This change affects two users:
> - free page reporting
> - page isolation, when undoing the isolation (including memory onlining).
>
> This behavior is desireable for pages that haven't really been touched
> lately, so exactly the two users that don't actually read/write page
> content, but rather move untouched pages.
>
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
> Document that this should only be used for optimizations, and no code
> should realy on this for correction (if the order of freepage lists
> ever changes).
>
> We won't care about page shuffling: memory onlining already properly
> shuffles after onlining. free page reporting doesn't care about
> physically contiguous ranges, and there are already cases where page
> isolation will simply move (physically close) free pages to (currently)
> the head of the freelists via move_freepages_block() instead of
> shuffling. If this becomes ever relevant, we should shuffle the whole
> zone when undoing isolation of larger ranges, and after
> free_contig_range().
>
> Reviewed-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> Reviewed-by: Oscar Salvador <osalvador@suse.de>
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
>  mm/page_alloc.c | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
>
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index daab90e960fe..9e3ed4a6f69a 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -89,6 +89,18 @@ typedef int __bitwise fop_t;
>   */
>  #define FOP_SKIP_REPORT_NOTIFY ((__force fop_t)BIT(0))
>
> +/*
> + * Place the (possibly merged) page to the tail of the freelist. Will ignore
> + * page shuffling (relevant code - e.g., memory onlining - is expected to
> + * shuffle the whole zone).
> + *
> + * Note: No code should rely onto this flag for correctness - it's purely
> + *       to allow for optimizations when handing back either fresh pages
> + *       (memory onlining) or untouched pages (page isolation, free page
> + *       reporting).
> + */
> +#define FOP_TO_TAIL            ((__force fop_t)BIT(1))
> +
>  /* prevent >1 _updater_ of zone percpu pageset ->high and ->batch fields */
>  static DEFINE_MUTEX(pcp_batch_high_lock);
>  #define MIN_PERCPU_PAGELIST_FRACTION   (8)
> @@ -1038,7 +1050,9 @@ static inline void __free_one_page(struct page *page, unsigned long pfn,
>  done_merging:
>         set_page_order(page, order);
>
> -       if (is_shuffle_order(order))
> +       if (fop_flags & FOP_TO_TAIL)
> +               to_tail = true;
> +       else if (is_shuffle_order(order))
>                 to_tail = shuffle_pick_tail();
>         else
>                 to_tail = buddy_merge_likely(pfn, buddy_pfn, page, order);
> @@ -3300,7 +3314,7 @@ void __putback_isolated_page(struct page *page, unsigned int order, int mt)
>
>         /* Return isolated page to tail of freelist. */
>         __free_one_page(page, page_to_pfn(page), zone, order, mt,
> -                       FOP_SKIP_REPORT_NOTIFY);
> +                       FOP_SKIP_REPORT_NOTIFY | FOP_TO_TAIL);
>  }

Reviewed-by: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
