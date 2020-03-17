Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37882187F17
	for <lists+linux-hyperv@lfdr.de>; Tue, 17 Mar 2020 11:58:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726781AbgCQK6Y (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 17 Mar 2020 06:58:24 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34318 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726559AbgCQK6X (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 17 Mar 2020 06:58:23 -0400
Received: by mail-wr1-f68.google.com with SMTP id z15so24988560wrl.1;
        Tue, 17 Mar 2020 03:58:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GMaxJmgHFs3UkzWKRUJIGAMAuAis9ucYU7WNuhbnrM0=;
        b=EV+NFq2tk5VjP3/+8I+LUS8cx+kdgaiY2lQ8Wdkjidaw9tTCeZfX0mj/IOm/HFIpHN
         aeQBZV1k9AiiD4LYe3DwpLGhYwLeDIWeMXK2VSu1XM9ZwZD3qwg5dRhCY9z5c3fQ8Rrp
         MeCZpu5PuH+UIetO/FxfZb/4VeIt7wAQjbxVSjV/k361b7ooXGV8tP603Bh0PgR0GJOn
         o2/8+7hJBGyqyUZT/0IrMi+4TLrSHvmLNq+6h7zOm83ur+rAUNrak8cMeRg9ftx3AgG8
         okHeXyNqM+w569z58GFNjmPpyLKfug9nQxKBG3bCsKDIfw1FJTlxEg8+5vsWvsR9xQ7G
         nioA==
X-Gm-Message-State: ANhLgQ0R3BoYJpXFDxxOlgAAx1TtpPbVPj1gbvZZSfwzC4MwStzrT9HQ
        PRPcBvMJYI2kX2A4JB8HVVc=
X-Google-Smtp-Source: ADFU+vuwMUcRYGkxYv04ItK19Y8hWebnnNI8rNDKcJ7IZEFzRgxAHrUzVDn0iHSETvqcL5o3Rxedng==
X-Received: by 2002:a05:6000:1186:: with SMTP id g6mr5358405wrx.331.1584442700152;
        Tue, 17 Mar 2020 03:58:20 -0700 (PDT)
Received: from localhost (ip-37-188-255-121.eurotel.cz. [37.188.255.121])
        by smtp.gmail.com with ESMTPSA id y189sm3615478wmb.26.2020.03.17.03.58.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2020 03:58:19 -0700 (PDT)
Date:   Tue, 17 Mar 2020 11:58:18 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linuxppc-dev@lists.ozlabs.org, linux-hyperv@vger.kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Baoquan He <bhe@redhat.com>,
        Wei Yang <richard.weiyang@gmail.com>
Subject: Re: [PATCH v2 4/8] powernv/memtrace: always online added memory
 blocks
Message-ID: <20200317105818.GK26018@dhcp22.suse.cz>
References: <20200317104942.11178-1-david@redhat.com>
 <20200317104942.11178-5-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200317104942.11178-5-david@redhat.com>
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue 17-03-20 11:49:38, David Hildenbrand wrote:
> Let's always try to online the re-added memory blocks. In case add_memory()
> already onlined the added memory blocks, the first device_online() call
> will fail and stop processing the remaining memory blocks.
> 
> This avoids manually having to check memhp_auto_online.
> 
> Note: PPC always onlines all hotplugged memory directly from the kernel
> as well - something that is handled by user space on other
> architectures.
> 
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Baoquan He <bhe@redhat.com>
> Cc: Wei Yang <richard.weiyang@gmail.com>
> Cc: linuxppc-dev@lists.ozlabs.org
> Signed-off-by: David Hildenbrand <david@redhat.com>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  arch/powerpc/platforms/powernv/memtrace.c | 14 ++++----------
>  1 file changed, 4 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/powernv/memtrace.c b/arch/powerpc/platforms/powernv/memtrace.c
> index d6d64f8718e6..13b369d2cc45 100644
> --- a/arch/powerpc/platforms/powernv/memtrace.c
> +++ b/arch/powerpc/platforms/powernv/memtrace.c
> @@ -231,16 +231,10 @@ static int memtrace_online(void)
>  			continue;
>  		}
>  
> -		/*
> -		 * If kernel isn't compiled with the auto online option
> -		 * we need to online the memory ourselves.
> -		 */
> -		if (!memhp_auto_online) {
> -			lock_device_hotplug();
> -			walk_memory_blocks(ent->start, ent->size, NULL,
> -					   online_mem_block);
> -			unlock_device_hotplug();
> -		}
> +		lock_device_hotplug();
> +		walk_memory_blocks(ent->start, ent->size, NULL,
> +				   online_mem_block);
> +		unlock_device_hotplug();
>  
>  		/*
>  		 * Memory was added successfully so clean up references to it
> -- 
> 2.24.1

-- 
Michal Hocko
SUSE Labs
