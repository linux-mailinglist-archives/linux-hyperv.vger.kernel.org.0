Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 501B426CE9E
	for <lists+linux-hyperv@lfdr.de>; Thu, 17 Sep 2020 00:23:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726582AbgIPWXF (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 16 Sep 2020 18:23:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726426AbgIPWXC (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 16 Sep 2020 18:23:02 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26E36C0698CA;
        Wed, 16 Sep 2020 14:44:26 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id r9so10037727ioa.2;
        Wed, 16 Sep 2020 14:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/6p2UL06xRCrtfganU+UNWFu+nueRBEvuh8BmgJZ8II=;
        b=fTJMcutrq6igd5vYMabKNTl2pV3QLLIVga8eZVWB3Qo8LD5CuAU2xBCagWdvlNfz7Y
         SdgLDHmtx+cP77RccgrN17Zpod+wgXnVDWU4BWCp8glD8TmR0CgYjIK7sLhk3gCv4jka
         0gbLLTASvnEGY2kVqdeZEAAj+Xc+ag6xxs2n1cu0ypLrogcOS57JfDYiPaxg0LJA89D3
         bES/LQ47vgte8onzKDnKVVIsfe4evM0ux9J7ojZJx4ruWYRLDpiMdRs++WmWMiRluaDE
         RkpwwSpAnZ0yEClbYo3zllxy1Ya+SnHZx3iZ/1TrKJfNpfmg6ZilGkn/hSmOuJJfnWy3
         zo8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/6p2UL06xRCrtfganU+UNWFu+nueRBEvuh8BmgJZ8II=;
        b=NmvgBL/tm7ZQFfkp7AtW9keatgjkfW4KrlcBvy459hJnFLLAffwbrB61ju0Sp7az6g
         T3mSBrb4bpwl7uW6/JXpaehLFdwsCIVLzglq1N5wGPV2SgwRTuuEqRro3zvYtkBQQ8oY
         XIF+veh2aPGZi5vJQ/kchOsFaX7B0m8aX9WtAmRQ2ciVIHsVGH3HM5pG+AO/pW528bWF
         LD+U/XZV1mjSgjFX4CjDuL8sDsj8Bk7aARdgSJ/mYuJEc0ByJ7q/aL+2MeX+vRKWZoPd
         9j53uiUiQuYkg3TObev2ww/gWQPeMbu53aFUGIPVhXRVjhJhrpgaVQb9Yz/vfCZ/MuJM
         Hs1Q==
X-Gm-Message-State: AOAM530rCXwvZnEVZpn2i0GF79HkomyxqsJpx93bQbna7ZZWXN0nKcnn
        zRRTDZ0IJt/zt/JVzv7t4WRCuI1tBk+A4qvBSNN3f5fDDXk=
X-Google-Smtp-Source: ABdhPJxVIty+Dfq+gHcJafZBfiUeb8mqaNsz4GMGNLyLwU88OT1JilrdN5E6o4aMmGksSrwkrnrtPtD7su/aUhaQfzw=
X-Received: by 2002:a6b:7a41:: with SMTP id k1mr21469290iop.187.1600292665347;
 Wed, 16 Sep 2020 14:44:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200916183411.64756-1-david@redhat.com> <20200916183411.64756-2-david@redhat.com>
In-Reply-To: <20200916183411.64756-2-david@redhat.com>
From:   Alexander Duyck <alexander.duyck@gmail.com>
Date:   Wed, 16 Sep 2020 14:44:14 -0700
Message-ID: <CAKgT0UfbnWoPOsaK5H_JtYbQdp-p+ngupO+6sq-_sy8Zetoanw@mail.gmail.com>
Subject: Re: [PATCH RFC 1/4] mm/page_alloc: convert "report" flag of
 __free_one_page() to a proper flag
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
        Mike Rapoport <rppt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Sep 16, 2020 at 11:34 AM David Hildenbrand <david@redhat.com> wrote:
>
> Let's prepare for additional flags and avoid long parameter lists of bools.
> Follow-up patches will also make use of the flags in __free_pages_ok(),
> however, I wasn't able to come up with a better name for the type - should
> be good enough for internal purposes.
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
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  mm/page_alloc.c | 28 ++++++++++++++++++++--------
>  1 file changed, 20 insertions(+), 8 deletions(-)
>
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 6b699d273d6e..91cefb8157dd 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -77,6 +77,18 @@
>  #include "shuffle.h"
>  #include "page_reporting.h"
>
> +/* Free One Page flags: for internal, non-pcp variants of free_pages(). */
> +typedef int __bitwise fop_t;
> +
> +/* No special request */
> +#define FOP_NONE               ((__force fop_t)0)
> +
> +/*
> + * Skip free page reporting notification after buddy merging (will *not* mark
> + * the page reported, only skip the notification).
> + */
> +#define FOP_SKIP_REPORT_NOTIFY ((__force fop_t)BIT(0))
> +
>  /* prevent >1 _updater_ of zone percpu pageset ->high and ->batch fields */
>  static DEFINE_MUTEX(pcp_batch_high_lock);
>  #define MIN_PERCPU_PAGELIST_FRACTION   (8)
> @@ -948,10 +960,9 @@ buddy_merge_likely(unsigned long pfn, unsigned long buddy_pfn,
>   * -- nyc
>   */
>
> -static inline void __free_one_page(struct page *page,
> -               unsigned long pfn,
> -               struct zone *zone, unsigned int order,
> -               int migratetype, bool report)
> +static inline void __free_one_page(struct page *page, unsigned long pfn,
> +                                  struct zone *zone, unsigned int order,
> +                                  int migratetype, fop_t fop_flags)
>  {
>         struct capture_control *capc = task_capc(zone);
>         unsigned long buddy_pfn;
> @@ -1038,7 +1049,7 @@ static inline void __free_one_page(struct page *page,
>                 add_to_free_list(page, zone, order, migratetype);
>
>         /* Notify page reporting subsystem of freed page */
> -       if (report)
> +       if (!(fop_flags & FOP_SKIP_REPORT_NOTIFY))
>                 page_reporting_notify_free(order);
>  }
>
> @@ -1368,7 +1379,7 @@ static void free_pcppages_bulk(struct zone *zone, int count,
>                 if (unlikely(isolated_pageblocks))
>                         mt = get_pageblock_migratetype(page);
>
> -               __free_one_page(page, page_to_pfn(page), zone, 0, mt, true);
> +               __free_one_page(page, page_to_pfn(page), zone, 0, mt, FOP_NONE);
>                 trace_mm_page_pcpu_drain(page, 0, mt);
>         }
>         spin_unlock(&zone->lock);
> @@ -1384,7 +1395,7 @@ static void free_one_page(struct zone *zone,
>                 is_migrate_isolate(migratetype))) {
>                 migratetype = get_pfnblock_migratetype(page, pfn);
>         }
> -       __free_one_page(page, pfn, zone, order, migratetype, true);
> +       __free_one_page(page, pfn, zone, order, migratetype, FOP_NONE);
>         spin_unlock(&zone->lock);
>  }
>
> @@ -3277,7 +3288,8 @@ void __putback_isolated_page(struct page *page, unsigned int order, int mt)
>         lockdep_assert_held(&zone->lock);
>
>         /* Return isolated page to tail of freelist. */
> -       __free_one_page(page, page_to_pfn(page), zone, order, mt, false);
> +       __free_one_page(page, page_to_pfn(page), zone, order, mt,
> +                       FOP_SKIP_REPORT_NOTIFY);
>  }
>
>  /*

Seems pretty straight forward. So we are basically flipping the logic
and replacing !report with FOP_SKIP_REPORT_NOTIFY.

Reviewed-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
