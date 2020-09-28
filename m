Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DC6127B602
	for <lists+linux-hyperv@lfdr.de>; Mon, 28 Sep 2020 22:12:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbgI1UMM (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 28 Sep 2020 16:12:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726424AbgI1UMM (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 28 Sep 2020 16:12:12 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84E33C061755;
        Mon, 28 Sep 2020 13:12:11 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id u6so2482929iow.9;
        Mon, 28 Sep 2020 13:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xZKymCvf/3hB0NedV8stXCWKWuXrWGW8+XBJgCfh+LE=;
        b=TDPgclhnBlWg5VXfidWvaVODif2Ky2Ysrfbe6qlsall+wU6K4b9E0/tbX04SDmq9EQ
         jTaWRxt9S1JvFQXXdGnFm2JLjA3fOSc827Wdz7c3b27/bT7K90mdObWR39grRzS2YgWk
         CwpRDvAOYYt8KmZNc0+eN5dqSXCAtB+9sjeZ+WDr1ClzwF20lChfVuJSdvGqhsu4ujlC
         R4VXPQ8KsQM0k/4GV8k2EEPRsNcwIcBrzAn0s+XXZ/iBi+b2galei+43oEog2fHYBSJF
         qEQZ/wcEqdEq0I0im8TxSAzTKEpZns5PrYvPNIEtTSuSjQ+vkU5R1ArhwXV4hkv6K+BB
         1c7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xZKymCvf/3hB0NedV8stXCWKWuXrWGW8+XBJgCfh+LE=;
        b=PpLPMxjzI/e0KyLqk06mAAaE4oKgrd/C0DbQoiAHS9etgintXImerIhRTDFoIOU024
         utVay7t7XOj6jFcj8Zc5UVx0Fnrdq8BVPQOFfPqAFdP+cA/M7EIqPyjam5tZ8mfhp979
         sngqs1fC6wPNUAtVqj4vb1AdPwzmmHr2tb9l1mmyySMODlXqcit3yY6EYiSfcGKF9e9H
         HEfVo3zwce+xvhAnP7uHeN64VnmBDZDoPzp8/hfUls84iZctB1SZGYpM4MWbqjBaZTM3
         vMlQzkVriyrgCq/P3ehsOTOK+BdoJfPGHe95FBq+nFkW/UTPAftRgh28KaUDRh4hNyMV
         ZNCg==
X-Gm-Message-State: AOAM531fpK4Bi55HovCsNtFp4znCOCB73fO0FXLTIHyPc3om3f2j5okx
        mV02pcmLp9+Hpm2JcjaeqBADEF0Q0H5HNlnk96s=
X-Google-Smtp-Source: ABdhPJwRZYvxUM8BpdXgvXa6N707vOvCxbfH4iYi81EiZ5QMYe/87ZNldkSa6kbFMWFqlFO15K6N5K6tS6C14JIcttA=
X-Received: by 2002:a6b:2b45:: with SMTP id r66mr8189635ior.159.1601323930836;
 Mon, 28 Sep 2020 13:12:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200928182110.7050-1-david@redhat.com> <20200928182110.7050-2-david@redhat.com>
In-Reply-To: <20200928182110.7050-2-david@redhat.com>
From:   Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Date:   Mon, 28 Sep 2020 22:11:59 +0200
Message-ID: <CAM9Jb+iwkhvxudiNas8m2B_qXFitF-8_9N5=WxvPPWKSzEGcCA@mail.gmail.com>
Subject: Re: [PATCH v1 1/5] mm/page_alloc: convert "report" flag of
 __free_one_page() to a proper flag
To:     David Hildenbrand <david@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        linux-hyperv@vger.kernel.org, xen-devel@lists.xenproject.org,
        linux-acpi@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Oscar Salvador <osalvador@suse.de>,
        Mel Gorman <mgorman@techsingularity.net>,
        Michal Hocko <mhocko@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        Mike Rapoport <rppt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> Let's prepare for additional flags and avoid long parameter lists of bools.
> Follow-up patches will also make use of the flags in __free_pages_ok(),
> however, I wasn't able to come up with a better name for the type - should
> be good enough for internal purposes.
>
> Reviewed-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
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
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  mm/page_alloc.c | 28 ++++++++++++++++++++--------
>  1 file changed, 20 insertions(+), 8 deletions(-)
>
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index df90e3654f97..daab90e960fe 100644
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
> + * Skip free page reporting notification for the (possibly merged) page. (will
> + * *not* mark the page reported, only skip the notification).
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
> @@ -1379,7 +1390,7 @@ static void free_pcppages_bulk(struct zone *zone, int count,
>                 if (unlikely(isolated_pageblocks))
>                         mt = get_pageblock_migratetype(page);
>
> -               __free_one_page(page, page_to_pfn(page), zone, 0, mt, true);
> +               __free_one_page(page, page_to_pfn(page), zone, 0, mt, FOP_NONE);
>                 trace_mm_page_pcpu_drain(page, 0, mt);
>         }
>         spin_unlock(&zone->lock);
> @@ -1395,7 +1406,7 @@ static void free_one_page(struct zone *zone,
>                 is_migrate_isolate(migratetype))) {
>                 migratetype = get_pfnblock_migratetype(page, pfn);
>         }
> -       __free_one_page(page, pfn, zone, order, migratetype, true);
> +       __free_one_page(page, pfn, zone, order, migratetype, FOP_NONE);
>         spin_unlock(&zone->lock);
>  }
>
> @@ -3288,7 +3299,8 @@ void __putback_isolated_page(struct page *page, unsigned int order, int mt)
>         lockdep_assert_held(&zone->lock);
>
>         /* Return isolated page to tail of freelist. */
> -       __free_one_page(page, page_to_pfn(page), zone, order, mt, false);
> +       __free_one_page(page, page_to_pfn(page), zone, order, mt,
> +                       FOP_SKIP_REPORT_NOTIFY);
>  }

Reviewed-by: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
