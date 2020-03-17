Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 66A461890FF
	for <lists+linux-hyperv@lfdr.de>; Tue, 17 Mar 2020 23:05:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbgCQWFB (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 17 Mar 2020 18:05:01 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37490 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726476AbgCQWFA (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 17 Mar 2020 18:05:00 -0400
Received: by mail-wr1-f68.google.com with SMTP id 6so27761803wre.4;
        Tue, 17 Mar 2020 15:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Qiz8SPGjq8UjHt5B7MxSwjAG4ELELv3CtLSiX/rkTdo=;
        b=s+26uggoLggNmytLFNkdi5ReaP1mQqXWgjWy8h5Gs+gJsYAbnX71plLhfx3iTGckQJ
         3mf1zQUAz7jDZ3g6nApgpqoGosK8gPPrhlFBHDcDoL9v2pE/eeoF4r27DSIx7JfTM6dW
         cT7v5UZFhkEwJMZWl3oh3WfUmJyG6O6uDQsG2jFaNB45EGA5y6eZYi6qOyotGpQ/P2rs
         MDaqKFpT2V/jik4ZT0LcexOjipeNHS2V86cxJJVDbdppigFG8Fbga86Mi/2PSd/wU7W3
         35TKgLQF83iGAQp3rLZ1losEJcw8tKxBUQho2gmDuh0jeWLS80cLVtMh4PCzeXxBTvrZ
         v66Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Qiz8SPGjq8UjHt5B7MxSwjAG4ELELv3CtLSiX/rkTdo=;
        b=LBbGfRtiwmayShvpy2ak03+WQrSdTCpvpqZ0rB4fTkrRkurJ32r0hBP28XbjJfbRqM
         utS3sV2Zgxd7kRWb49zIrJwRO1x6tPx1dHFAUPQYyKuldUt93MnN5y3ddX+tJTsakyh9
         Vd1GCwEnJUc+D1abGPJxEfR0nTkktNjYweyhsjF859sTtOiHOWhOGiQ7sA6ZVP+42FK9
         pfWqQu02CS885qwOvh0czHWX/UHkNiz+cQDFmb+TLAa7T4jjOZIYh6rDSB9q25r3jTyO
         KMWyA+jR6WTbfd8QUHoWhfN+npUZEyOEPhhfS7BA9kNOSLiPR/Zpvkt1y+6V0DauXnRM
         /ojw==
X-Gm-Message-State: ANhLgQ0GWyE6ONZGrXYZii+vxA/MQB/3i7dGwP0Iz5xG9hqcYFddPtju
        VbFIIS7/Zup9XqveNRKTinA=
X-Google-Smtp-Source: ADFU+vvUbJs7CjVtSah/hWS9CT/exY7FEYlJgzu0BJZSQqsLIr7AAJOzF8YKAtYskOQ1IKl756J0tA==
X-Received: by 2002:adf:ef12:: with SMTP id e18mr1155345wro.108.1584482697768;
        Tue, 17 Mar 2020 15:04:57 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id y200sm1059104wmc.20.2020.03.17.15.04.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 17 Mar 2020 15:04:57 -0700 (PDT)
Date:   Tue, 17 Mar 2020 22:04:56 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linuxppc-dev@lists.ozlabs.org, linux-hyperv@vger.kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Baoquan He <bhe@redhat.com>,
        Wei Yang <richard.weiyang@gmail.com>
Subject: Re: [PATCH v2 4/8] powernv/memtrace: always online added memory
 blocks
Message-ID: <20200317220456.wczzkgtqwgxjw5c6@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20200317104942.11178-1-david@redhat.com>
 <20200317104942.11178-5-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200317104942.11178-5-david@redhat.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Mar 17, 2020 at 11:49:38AM +0100, David Hildenbrand wrote:
>Let's always try to online the re-added memory blocks. In case add_memory()
>already onlined the added memory blocks, the first device_online() call
>will fail and stop processing the remaining memory blocks.
>
>This avoids manually having to check memhp_auto_online.
>
>Note: PPC always onlines all hotplugged memory directly from the kernel
>as well - something that is handled by user space on other
>architectures.
>
>Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>Cc: Paul Mackerras <paulus@samba.org>
>Cc: Michael Ellerman <mpe@ellerman.id.au>
>Cc: Andrew Morton <akpm@linux-foundation.org>
>Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>Cc: Michal Hocko <mhocko@kernel.org>
>Cc: Oscar Salvador <osalvador@suse.de>
>Cc: "Rafael J. Wysocki" <rafael@kernel.org>
>Cc: Baoquan He <bhe@redhat.com>
>Cc: Wei Yang <richard.weiyang@gmail.com>
>Cc: linuxppc-dev@lists.ozlabs.org
>Signed-off-by: David Hildenbrand <david@redhat.com>

Looks good.

Reviewed-by: Wei Yang <richard.weiyang@gmail.com>

>---
> arch/powerpc/platforms/powernv/memtrace.c | 14 ++++----------
> 1 file changed, 4 insertions(+), 10 deletions(-)
>
>diff --git a/arch/powerpc/platforms/powernv/memtrace.c b/arch/powerpc/platforms/powernv/memtrace.c
>index d6d64f8718e6..13b369d2cc45 100644
>--- a/arch/powerpc/platforms/powernv/memtrace.c
>+++ b/arch/powerpc/platforms/powernv/memtrace.c
>@@ -231,16 +231,10 @@ static int memtrace_online(void)
> 			continue;
> 		}
> 
>-		/*
>-		 * If kernel isn't compiled with the auto online option
>-		 * we need to online the memory ourselves.
>-		 */
>-		if (!memhp_auto_online) {
>-			lock_device_hotplug();
>-			walk_memory_blocks(ent->start, ent->size, NULL,
>-					   online_mem_block);
>-			unlock_device_hotplug();
>-		}
>+		lock_device_hotplug();
>+		walk_memory_blocks(ent->start, ent->size, NULL,
>+				   online_mem_block);
>+		unlock_device_hotplug();
> 
> 		/*
> 		 * Memory was added successfully so clean up references to it
>-- 
>2.24.1

-- 
Wei Yang
Help you, Help me
