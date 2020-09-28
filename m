Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F9E027A92D
	for <lists+linux-hyperv@lfdr.de>; Mon, 28 Sep 2020 09:58:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726630AbgI1H63 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 28 Sep 2020 03:58:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:47686 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726518AbgI1H63 (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 28 Sep 2020 03:58:29 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id DBD45B038;
        Mon, 28 Sep 2020 07:58:27 +0000 (UTC)
Date:   Mon, 28 Sep 2020 09:58:24 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-hyperv@vger.kernel.org, xen-devel@lists.xenproject.org,
        linux-acpi@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Michal Hocko <mhocko@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        Mike Rapoport <rppt@kernel.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>
Subject: Re: [PATCH RFC 4/4] mm/page_alloc: place pages to tail in
 __free_pages_core()
Message-ID: <20200928075820.GA4082@linux>
References: <20200916183411.64756-1-david@redhat.com>
 <20200916183411.64756-5-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200916183411.64756-5-david@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Sep 16, 2020 at 08:34:11PM +0200, David Hildenbrand wrote:
> @@ -1523,7 +1524,13 @@ void __free_pages_core(struct page *page, unsigned int order)
>  
>  	atomic_long_add(nr_pages, &page_zone(page)->managed_pages);
>  	set_page_refcounted(page);
> -	__free_pages(page, order);
> +
> +	/*
> +	 * Bypass PCP and place fresh pages right to the tail, primarily
> +	 * relevant for memory onlining.
> +	 */
> +	page_ref_dec(page);
> +	__free_pages_ok(page, order, FOP_TO_TAIL);

Sorry, I must be missing something obvious here, but I am a bit confused here.
I get the part of placing them at the tail so rmqueue_bulk() won't
find them, but I do not get why we decrement page's refcount.
IIUC, its refcount will be 0, but why do we want to do that?

Another thing a bit unrelated... we mess three times with page's refcount
(two before this patch).
Why do we have this dance in place?

Thanks

-- 
Oscar Salvador
SUSE L3
