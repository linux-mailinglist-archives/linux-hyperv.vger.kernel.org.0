Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E2CFE19E03
	for <lists+linux-hyperv@lfdr.de>; Fri, 10 May 2019 15:21:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727528AbfEJNVg (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 10 May 2019 09:21:36 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34126 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727446AbfEJNVg (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 10 May 2019 09:21:36 -0400
Received: by mail-pf1-f193.google.com with SMTP id n19so3243622pfa.1
        for <linux-hyperv@vger.kernel.org>; Fri, 10 May 2019 06:21:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=kbHsD2JbexjKT0tydjMxWS7kn38gpelo9w4d6bQawBc=;
        b=V+GtxjfcEnuqOZc/bhm4s0ZY6cQUld6BCP+BJ8jS+OAJu6XDw5jgFiiWdKDk0LaeXo
         cpttq538Z0sm+Sc9fm49ZlQDKGX5MoEA7MwAlFYbBU7bqtX00S6Tz5URR/3L0nYcEM1X
         XIJ6An/FBJ35+EsE1DnCSpRSdwVODdUKm55JEMf0dkpRS4X852hD9kxmSKoYDoyTffWo
         yq+pbE1mpnA2HHaIiTzYOxZH1Hw07H5qILPKlpgUzTuIW6gn6gVeJczYuPlCpBaYMybM
         yMGz8b2AQCK0miIsCJnNQO5UaXm1y/JFhcBXDDgSIYcuQeRL529+udndChSZ7nRwN7Lb
         yHtg==
X-Gm-Message-State: APjAAAVkyicykHmrFTm8Y8w1g6fC0fCM7kARJD6b3es+xG74Xlmn1Dhn
        yWHPsV8ZPDJwg7eFq9mnkmq46A==
X-Google-Smtp-Source: APXvYqxiZdXv2qEAfpxxi0MyUbkqrk1ybmWyizdwsm/tM5AVyv4/4RjQ/08sB00CStbDpmyAWkFJog==
X-Received: by 2002:a63:4346:: with SMTP id q67mr13421318pga.241.1557494495364;
        Fri, 10 May 2019 06:21:35 -0700 (PDT)
Received: from vitty.brq.redhat.com (THE-HIMMER.bear1.Boston1.Level3.net. [4.30.124.170])
        by smtp.gmail.com with ESMTPSA id d15sm17392952pfm.186.2019.05.10.06.21.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 10 May 2019 06:21:34 -0700 (PDT)
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
In-Reply-To: <MN2PR21MB1232C6ABA5DAC847C8A910E1D70C0@MN2PR21MB1232.namprd21.prod.outlook.com>
References: <cover.1554426039.git.m.maya.nakamura@gmail.com> <bdbacc872e369762a877af4415ad1b07054826db.1554426040.git.m.maya.nakamura@gmail.com> <87wok8it8p.fsf@vitty.brq.redhat.com> <20190412072401.GA69620@maya190131.isni1t2eisqetojrdim5hhf1se.xx.internal.cloudapp.net> <87mukvfynk.fsf@vitty.brq.redhat.com> <20190508064559.GA54416@maya190131.isni1t2eisqetojrdim5hhf1se.xx.internal.cloudapp.net> <87mujxro70.fsf@vitty.brq.redhat.com> <MN2PR21MB1232C6ABA5DAC847C8A910E1D70C0@MN2PR21MB1232.namprd21.prod.outlook.com>
Date:   Fri, 10 May 2019 09:21:35 -0400
Message-ID: <87r296qwbk.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Michael Kelley <mikelley@microsoft.com> writes:

> From: Vitaly Kuznetsov <vkuznets@redhat.com>  Sent: Wednesday, May 8, 2019 7:55 AM
>> >>
>> >> Sorry, my bad: I meant to say "not cache-like" (these allocations are
>> >> not 'cache') but the typo made it completely incomprehensible.
>> >
>> > No worries! Thank you for sharing your thoughts with me, Vitaly.
>> >
>> > Do you know of any alternatives to kmem_cache that can allocate memory
>> > in a specified size (different than a guest page size) with alignment?
>> > Memory allocated by alloc_page() is aligned but limited to the guest
>> > page size, and kmalloc() can allocate a particular size but it seems
>> > that it does not guarantee alignment. I am asking this while considering
>> > the changes for architecture independent code.
>> >
>> 
>> I think we can consider these allocations being DMA-like (because
>> Hypervisor accesses this memory too) so you can probably take a look at
>> dma_pool_create()/dma_pool_alloc() and friends.
>> 
>
> I've taken a look at dma_pool_create(), and it takes a "struct device"
> argument with which the DMA pool will be associated.  That probably
> makes DMA pools a bad choice for this usage.  Pages need to be allocated
> pretty early during boot for Hyper-V communication, and even if the
> device subsystem is initialized early enough to create a fake device,
> such a dependency seems rather dubious.

We can probably use dma_pool_create()/dma_pool_alloc() from vmbus module
but these 'early' allocations may not have a device to bind to indeed.

>
> kmem_cache_create/alloc() seems like the only choice to get
> guaranteed alignment.  Do you see any actual problem with
> using kmem_cache_*, other than the naming?  It seems like these
> kmem_cache_*  functions really just act as a sub-allocator for
> known-size allocations, and "cache" is a common usage
> pattern, but not necessarily the only usage pattern.

Yes, it's basically the name - it makes it harder to read the code and
some future refactoring of kmem_cache_* may not take our use-case into
account (as we're misusing the API). We can try renaming it to something
generic of course and see what -mm people have to say :-)

-- 
Vitaly
