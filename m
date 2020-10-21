Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5220294B92
	for <lists+linux-hyperv@lfdr.de>; Wed, 21 Oct 2020 12:58:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439228AbgJUK66 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 21 Oct 2020 06:58:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439214AbgJUK65 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 21 Oct 2020 06:58:57 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61359C0613CE;
        Wed, 21 Oct 2020 03:58:57 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id z5so2690223iob.1;
        Wed, 21 Oct 2020 03:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GICSwgN3sNFkPLzb9ZiuRIa+ZIKU5hbtJb9zZM8PdNs=;
        b=ENzNLNVw380JSauwEXTsNIwfSS+Pfic6wIwk3mcDkx2ZI8vSJTG9T4To95nV5K++3S
         wXrPtza7/nKOZyWO6GUYg/19vJCSiI3irHrOtUq4HfvmyEmN9+Er/0f8hl5JC3NY9rCU
         4VXyirx16ZxcwPrFkWNc5+fdgPzJzwoqh23QZ4siuTOAmG7kAyniMqDNFkdjAyBLV9KU
         6xUTE1fU2WS7Y2iHpg238szVhAOmVhcjtjhCua1z7pgont9fb1+CXR9apRekKvjEBXQ4
         Mjsvsuixy9gpE8FbEhU64igpCUNBdcJC/8ogPwXvQvXYuRk8lqRCeWNgGrCpzH1AQQOC
         Q+4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GICSwgN3sNFkPLzb9ZiuRIa+ZIKU5hbtJb9zZM8PdNs=;
        b=rLdhoZC9O9WwK5sULKry9MxuKsBFwmj9Xvpx5eNnh0TUL52qhTWqIAmV5ktSsh8oX9
         rTKg3aPda7RA41CbrrCPx38QuMVwRbNW1kWfTLycxfiPYLUpvr0JGq6KvpjJ3NynJiCF
         D3tJuv5Q6fPtnZFAiss5pl7srYiW0q+jT3vrgsULvlGPPM5cZhdEJnlcaDGEl8JfA4GI
         Q+IRS4qYqBc0fD2GVbIBxiCc6zuvRMMO0jObum7sjiHhi5edOoakqP4dg4/8JMBEmUv7
         HnOixyI07cygGk2UPqYJDIpyzKa6bcfik13MSV+Fz1LedAsSAnGweJDLelGg4lTFy+lQ
         hMWA==
X-Gm-Message-State: AOAM533wbJ1uunInniEBCFniJfy+siDzOqLuS5EhnA3ojkMeUpBYVfTk
        tM7HSmuxTz94tGpIZ9xwZboyOI73d8nBr0ZQvvY=
X-Google-Smtp-Source: ABdhPJxVGoa8oGWf7NMjH5r135bL5msWqxriS77JIexiAMhTvnG4ddTh5FYX+VcY2vpk3tlFdrFb/MgirSrWDhsBaEo=
X-Received: by 2002:a5d:87c7:: with SMTP id q7mr2174472ios.162.1603277936222;
 Wed, 21 Oct 2020 03:58:56 -0700 (PDT)
MIME-Version: 1.0
References: <20201005121534.15649-1-david@redhat.com> <20201005121534.15649-6-david@redhat.com>
In-Reply-To: <20201005121534.15649-6-david@redhat.com>
From:   Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Date:   Wed, 21 Oct 2020 12:58:45 +0200
Message-ID: <CAM9Jb+jXR6iPvSxExaEJvm90mqRozh1wcJ6ukEmDy_pqc-37oQ@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] mm/memory_hotplug: update comment regarding zone shuffling
To:     David Hildenbrand <david@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        linux-hyperv@vger.kernel.org, xen-devel@lists.xenproject.org,
        linux-acpi@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        Michal Hocko <mhocko@suse.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Michal Hocko <mhocko@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Oscar Salvador <osalvador@suse.de>,
        Mike Rapoport <rppt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> As we no longer shuffle via generic_online_page() and when undoing
> isolation, we can simplify the comment.
>
> We now effectively shuffle only once (properly) when onlining new
> memory.
>
> Reviewed-by: Wei Yang <richard.weiyang@linux.alibaba.com>
> Acked-by: Michal Hocko <mhocko@suse.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> Cc: Mel Gorman <mgorman@techsingularity.net>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Dave Hansen <dave.hansen@intel.com>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Wei Yang <richard.weiyang@linux.alibaba.com>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Mike Rapoport <rppt@kernel.org>
> Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  mm/memory_hotplug.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
>
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 03a00cb68bf7..b44d4c7ba73b 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -858,13 +858,10 @@ int __ref online_pages(unsigned long pfn, unsigned long nr_pages,
>         undo_isolate_page_range(pfn, pfn + nr_pages, MIGRATE_MOVABLE);
>
>         /*
> -        * When exposing larger, physically contiguous memory areas to the
> -        * buddy, shuffling in the buddy (when freeing onlined pages, putting
> -        * them either to the head or the tail of the freelist) is only helpful
> -        * for maintaining the shuffle, but not for creating the initial
> -        * shuffle. Shuffle the whole zone to make sure the just onlined pages
> -        * are properly distributed across the whole freelist. Make sure to
> -        * shuffle once pageblocks are no longer isolated.
> +        * Freshly onlined pages aren't shuffled (e.g., all pages are placed to
> +        * the tail of the freelist when undoing isolation). Shuffle the whole
> +        * zone to make sure the just onlined pages are properly distributed
> +        * across the whole freelist - to create an initial shuffle.
>          */
>         shuffle_zone(zone);
>

Acked-by: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
