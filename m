Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10D51281445
	for <lists+linux-hyperv@lfdr.de>; Fri,  2 Oct 2020 15:41:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387919AbgJBNlY (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 2 Oct 2020 09:41:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbgJBNlY (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 2 Oct 2020 09:41:24 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D28E3C0613D0;
        Fri,  2 Oct 2020 06:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=YAy0v19KwKZlKr9ru/zVpzMUsVTEeJ2e3pekJyodo14=; b=iexghG7snc7QxKkez1o5os1/3C
        VMsVigSDzAim81w0WG62063q1/2M6oleyQVttaq/DwGZpvUko1TAcHMiTc7Y71fOc776brlCHNpL9
        TF/rDja+6ZlYfSRQyLAmdcF816yQQD7Gh4cjTtX9zkHPhiQblkCbSro/WbJRcAl55o/FbkG8U4+cK
        ODEbYlsH/oL9/v8WuT6CkyJmXG3JPi8Quc8roDPCf51ax85lpPy9eX0zXlMe9YyE+ArPm6I6HfE9l
        /uwdBF13nEBfPVG49VpiveihT4b0xj7wbQ3rHDVvRI8ViBmr5WRPZYCia8pMZ2UvYjRxjqdaMXw/s
        NITHbeMw==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kOLJG-0008Pc-Cw; Fri, 02 Oct 2020 13:41:18 +0000
Date:   Fri, 2 Oct 2020 14:41:18 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
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
Subject: Re: [PATCH v1 1/5] mm/page_alloc: convert "report" flag of
 __free_one_page() to a proper flag
Message-ID: <20201002134118.GA20115@casper.infradead.org>
References: <20200928182110.7050-1-david@redhat.com>
 <20200928182110.7050-2-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200928182110.7050-2-david@redhat.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, Sep 28, 2020 at 08:21:06PM +0200, David Hildenbrand wrote:
> Let's prepare for additional flags and avoid long parameter lists of bools.
> Follow-up patches will also make use of the flags in __free_pages_ok(),
> however, I wasn't able to come up with a better name for the type - should
> be good enough for internal purposes.

> +/* Free One Page flags: for internal, non-pcp variants of free_pages(). */
> +typedef int __bitwise fop_t;

That invites confusion with f_op.  There's no reason to use _t as a suffix
here ... why not free_f?

> +/*
> + * Skip free page reporting notification for the (possibly merged) page. (will
> + * *not* mark the page reported, only skip the notification).

... Don't you mean "will not skip marking the page as reported, only
skip the notification"?

*reads code*

No, I'm still confused.  What does this sentence mean?

Would it help to have a FOP_DEFAULT that has FOP_REPORT_NOTIFY set and
then a FOP_SKIP_REPORT_NOTIFY define that is 0?

> -static inline void __free_one_page(struct page *page,
> -		unsigned long pfn,
> -		struct zone *zone, unsigned int order,
> -		int migratetype, bool report)
> +static inline void __free_one_page(struct page *page, unsigned long pfn,
> +				   struct zone *zone, unsigned int order,
> +				   int migratetype, fop_t fop_flags)

Please don't over-indent like this.

static inline void __free_one_page(struct page *page, unsigned long pfn,
		struct zone *zone, unsigned int order, int migratetype,
		fop_t fop_flags)

reads just as well and then if someone needs to delete the 'static'
later, they don't need to fiddle around with subsequent lines getting
the whitespace to line up again.

