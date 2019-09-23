Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C3978BB013
	for <lists+linux-hyperv@lfdr.de>; Mon, 23 Sep 2019 10:58:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731393AbfIWI6K (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 23 Sep 2019 04:58:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:51152 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729483AbfIWI6J (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 23 Sep 2019 04:58:09 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E41CEAAB2;
        Mon, 23 Sep 2019 08:58:07 +0000 (UTC)
Date:   Mon, 23 Sep 2019 10:58:07 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Souptick Joarder <jrdr.linux@gmail.com>,
        linux-hyperv@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Oscar Salvador <osalvador@suse.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Qian Cai <cai@lca.pw>, Sasha Levin <sashal@kernel.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Yang <richard.weiyang@gmail.com>
Subject: Re: [PATCH v1 0/3] mm/memory_hotplug: Export generic_online_page()
Message-ID: <20190923085807.GD6016@dhcp22.suse.cz>
References: <20190909114830.662-1-david@redhat.com>
 <f73c4d0f-ad81-81a6-1107-852f2b9cad41@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f73c4d0f-ad81-81a6-1107-852f2b9cad41@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri 20-09-19 10:17:54, David Hildenbrand wrote:
> On 09.09.19 13:48, David Hildenbrand wrote:
> > Based on linux/next + "[PATCH 0/3] Remove __online_page_set_limits()"
> > 
> > Let's replace the __online_page...() functions by generic_online_page().
> > Hyper-V only wants to delay the actual onlining of un-backed pages, so we
> > can simpy re-use the generic function.
> > 
> > Only compile-tested.
> > 
> > Cc: Souptick Joarder <jrdr.linux@gmail.com>
> > 
> > David Hildenbrand (3):
> >   mm/memory_hotplug: Export generic_online_page()
> >   hv_balloon: Use generic_online_page()
> >   mm/memory_hotplug: Remove __online_page_free() and
> >     __online_page_increment_counters()
> > 
> >  drivers/hv/hv_balloon.c        |  3 +--
> >  include/linux/memory_hotplug.h |  4 +---
> >  mm/memory_hotplug.c            | 17 ++---------------
> >  3 files changed, 4 insertions(+), 20 deletions(-)
> > 
> 
> Ping, any comments on this one?

Unification makes a lot of sense to me. You can add
Acked-by: Michal Hocko <mhocko@suse.com>

I will most likely won't surprise if I asked for more here though ;)
I have to confess I really detest the whole concept of a hidden callback
with a very weird API. Is this something we can do about? I do realize
that adding a callback would require either cluttering the existing APIs
but maybe we can come up with something more clever. Or maybe existing
external users of online callback can do that as a separate step after
the online is completed - or is this impossible due to locking
guarantees?
-- 
Michal Hocko
SUSE Labs
