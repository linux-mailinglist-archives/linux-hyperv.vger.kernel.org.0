Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B01D727AE49
	for <lists+linux-hyperv@lfdr.de>; Mon, 28 Sep 2020 14:54:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbgI1Mx4 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 28 Sep 2020 08:53:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:60790 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726466AbgI1Mx4 (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 28 Sep 2020 08:53:56 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 12751AC24;
        Mon, 28 Sep 2020 12:53:55 +0000 (UTC)
Date:   Mon, 28 Sep 2020 14:53:51 +0200
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
Message-ID: <20200928125346.GA7703@linux>
References: <20200916183411.64756-1-david@redhat.com>
 <20200916183411.64756-5-david@redhat.com>
 <20200928075820.GA4082@linux>
 <a18327c0-b86a-df00-e984-27c26468caf7@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a18327c0-b86a-df00-e984-27c26468caf7@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, Sep 28, 2020 at 10:36:00AM +0200, David Hildenbrand wrote:
> Hi Oscar!

Hi David :-)

> 
> Old code:
> 
> set_page_refcounted(): sets the refcount to 1.
> __free_pages()
>   -> put_page_testzero(): sets it to 0
>   -> free_the_page()->__free_pages_ok()
> 
> New code:
> 
> set_page_refcounted(): sets the refcount to 1.
> page_ref_dec(page): sets it to 0
> __free_pages_ok():

bleh, I misread the patch, somehow I managed to not see that you replaced
__free_pages with __free_pages_ok.

To be honest, now that we do not need the page's refcount to be 1 for the
put_page_testzero to trigger (and since you are decrementing it anyways),
I think it would be much clear for those two to be gone.

But not strong, so:

Reviewed-by: Oscar Salvador <osalvador@suse.de>

-- 
Oscar Salvador
SUSE L3
