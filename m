Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E47018B07E
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2020 10:49:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725768AbgCSJtw (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 19 Mar 2020 05:49:52 -0400
Received: from ozlabs.org ([203.11.71.1]:33729 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725601AbgCSJtw (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 19 Mar 2020 05:49:52 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 48jhvw5NCyz9sPF;
        Thu, 19 Mar 2020 20:49:48 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1584611389;
        bh=D+Q6J/bh0fif9u1z1m+OOV+M4Bo54jJdaeTGMRX6pe0=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=P5t7qg+uFhsXVHj/dGsqwMeHcyT0zb6aCcAP9pCh9sU5LJNryN893v2fqhEN4BqX4
         S3GXGk+rHMaXEOQsacD7MF0Bx5B6TshTYYqYo6ToQMeuLZji/+1ZtQKdyI/rQEGl2h
         pvOsSqItdZeRFJPJ/9eGRLiBr46Johep5VQGxzU2B01YhqNzaKmgx1hPx6gp699FY0
         HqwgCGwc62dtUWU1+rd3NgbkuL5H0S9ICvAo2aqnrd0eKi8ciEPL92vpKdVWnx7fQ5
         3/Aab35W1AEhGldn8upttkR191P6KVZJdVc9H0tYu+++o/In27Fj9LfbXVtvov7Qpa
         X6r19DYk3RAbg==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
        linux-hyperv@vger.kernel.org, David Hildenbrand <david@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Baoquan He <bhe@redhat.com>,
        Wei Yang <richard.weiyang@gmail.com>
Subject: Re: [PATCH v2 4/8] powernv/memtrace: always online added memory blocks
In-Reply-To: <20200317104942.11178-5-david@redhat.com>
References: <20200317104942.11178-1-david@redhat.com> <20200317104942.11178-5-david@redhat.com>
Date:   Thu, 19 Mar 2020 20:49:47 +1100
Message-ID: <8736a4eksk.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

David Hildenbrand <david@redhat.com> writes:
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
> ---
>  arch/powerpc/platforms/powernv/memtrace.c | 14 ++++----------
>  1 file changed, 4 insertions(+), 10 deletions(-)

Fine by me.

Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)

cheers

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
