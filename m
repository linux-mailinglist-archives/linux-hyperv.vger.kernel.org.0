Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 129F21A291
	for <lists+linux-hyperv@lfdr.de>; Fri, 10 May 2019 19:45:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727580AbfEJRpn (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 10 May 2019 13:45:43 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:33340 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727144AbfEJRpn (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 10 May 2019 13:45:43 -0400
Received: by mail-qk1-f193.google.com with SMTP id k189so4218554qkc.0
        for <linux-hyperv@vger.kernel.org>; Fri, 10 May 2019 10:45:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=ItAX23A+ZK4sf8NEwjAZtt+aMB/LmGzTQuo1uxHF1/0=;
        b=D15+CpEKI3rcETjK7IX9Z3SzXvn3Qal3yPDFnq1pNGvlkWOQYX7K00cS28G9zSPy7X
         S6MuyPAcGuNYehKZDGfio7jvxdOyH6XO6cMTt/T0U2Ud8uLPyKS3Cq9LFtSpblTCTTkI
         OZ6HBHhArkVlgSFEEQcu4+Ys3UgLtEQYYNipyu7zOYSpz15K+nccdG1xhgaLSJ0JVoaB
         KrPxaz8BsmFNYb+GSww5II/OEAyd9lSLguTSDTG5Hdwxze5f+wdQNO+Y72Z7Td4hy81h
         a4zuV+DDerOQwFvQfHmiWWjuIfxwcGDdTe2LpeCbPYMj4S6LGDX9GJ6anhmAanuwhF//
         UV6g==
X-Gm-Message-State: APjAAAU9Tmbb9WDv9+a2b56owBPzELWZ+XJUjLCtVkqgxL9ovjrinbVx
        itPm69v1ER+9k4JKiGmrKaoFTw==
X-Google-Smtp-Source: APXvYqx1jICg7CS0UwHc52npH/Yny0UGKDM8v5+hee7gxDo8h3K94GlP6ro645dP+vmCXxSTHU2/Tw==
X-Received: by 2002:a05:620a:1463:: with SMTP id j3mr10351073qkl.157.1557510342262;
        Fri, 10 May 2019 10:45:42 -0700 (PDT)
Received: from vitty.brq.redhat.com ([209.48.7.126])
        by smtp.gmail.com with ESMTPSA id k53sm3528159qtb.65.2019.05.10.10.45.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 10 May 2019 10:45:41 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Michael Kelley <mikelley@microsoft.com>,
        "m.maya.nakamura" <m.maya.nakamura@gmail.com>
Cc:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "sashal\@kernel.org" <sashal@kernel.org>,
        "x86\@kernel.org" <x86@kernel.org>,
        "linux-hyperv\@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/6] x86: hv: hv_init.c: Replace alloc_page() with kmem_cache_alloc()
In-Reply-To: <BYAPR21MB1221962ED2DD7FEE19E7DAB6D70C0@BYAPR21MB1221.namprd21.prod.outlook.com>
References: <cover.1554426039.git.m.maya.nakamura@gmail.com> <bdbacc872e369762a877af4415ad1b07054826db.1554426040.git.m.maya.nakamura@gmail.com> <87wok8it8p.fsf@vitty.brq.redhat.com> <20190412072401.GA69620@maya190131.isni1t2eisqetojrdim5hhf1se.xx.internal.cloudapp.net> <87mukvfynk.fsf@vitty.brq.redhat.com> <20190508064559.GA54416@maya190131.isni1t2eisqetojrdim5hhf1se.xx.internal.cloudapp.net> <87mujxro70.fsf@vitty.brq.redhat.com> <MN2PR21MB1232C6ABA5DAC847C8A910E1D70C0@MN2PR21MB1232.namprd21.prod.outlook.com> <87r296qwbk.fsf@vitty.brq.redhat.com> <BYAPR21MB1221962ED2DD7FEE19E7DAB6D70C0@BYAPR21MB1221.namprd21.prod.outlook.com>
Date:   Fri, 10 May 2019 13:45:41 -0400
Message-ID: <8736lmqk3e.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Michael Kelley <mikelley@microsoft.com> writes:

> From: Vitaly Kuznetsov <vkuznets@redhat.com>  Sent: Friday, May 10, 2019 6:22 AM
>> >>
>> >> I think we can consider these allocations being DMA-like (because
>> >> Hypervisor accesses this memory too) so you can probably take a look at
>> >> dma_pool_create()/dma_pool_alloc() and friends.
>> >>
>> >
>> > I've taken a look at dma_pool_create(), and it takes a "struct device"
>> > argument with which the DMA pool will be associated.  That probably
>> > makes DMA pools a bad choice for this usage.  Pages need to be allocated
>> > pretty early during boot for Hyper-V communication, and even if the
>> > device subsystem is initialized early enough to create a fake device,
>> > such a dependency seems rather dubious.
>> 
>> We can probably use dma_pool_create()/dma_pool_alloc() from vmbus module
>> but these 'early' allocations may not have a device to bind to indeed.
>> 
>> >
>> > kmem_cache_create/alloc() seems like the only choice to get
>> > guaranteed alignment.  Do you see any actual problem with
>> > using kmem_cache_*, other than the naming?  It seems like these
>> > kmem_cache_*  functions really just act as a sub-allocator for
>> > known-size allocations, and "cache" is a common usage
>> > pattern, but not necessarily the only usage pattern.
>> 
>> Yes, it's basically the name - it makes it harder to read the code and
>> some future refactoring of kmem_cache_* may not take our use-case into
>> account (as we're misusing the API). We can try renaming it to something
>> generic of course and see what -mm people have to say :-)
>> 
>
> This makes me think of creating Hyper-V specific alloc/free functions
> that wrap whatever the backend allocator actually is.  So we have
> hv_alloc_hyperv_page() and hv_free_hyperv_page().  That makes the
> code very readable and the intent is super clear.
>
> As for the backend allocator, an alternative is to write our own simple
> allocator.  It maintains a single free list.  If hv_alloc_hyperv_page() is
> called, and the free list is empty, do alloc_page() and break it up into
> Hyper-V sized pages to replenish the free list.  (On x86, these end up
> being 1-for-1 operations.)  hv_free_hyperv_page() just puts the Hyper-V
> page back on the free list.  Don't worry trying to combine and do
> free_page() since there's very little free'ing done anyway.  And I'm
> assuming GPF_KERNEL is all we need.
>
> If in the future Linux provides an alternate general-purpose allocator
> that guarantees alignment, we can ditch the simple allocator and use
> the new mechanism with some simple code changes in one place.
>
> Thoughts?
>

+1 for adding wrappers and if the allocator turns out to be more-or-less
trivial I think we can live with that for the time being.

-- 
Vitaly
