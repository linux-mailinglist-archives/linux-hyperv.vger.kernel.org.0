Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F6B526C9DD
	for <lists+linux-hyperv@lfdr.de>; Wed, 16 Sep 2020 21:33:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727282AbgIPTdl (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 16 Sep 2020 15:33:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59408 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727535AbgIPTcF (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 16 Sep 2020 15:32:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600284688;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=H30dbXoNbzsTkPGiKpd2XjhJWXqjtA7dGp0dwpbyBQA=;
        b=ImR8D9FBk1nPql8yB//BTP70Ry+M7tvnprSzFKIwQ+LrEcxwT1g4mAHe2VQ+Fj4UgR8HI/
        lTgb7jUkhHvmaI1CppbODHMqWeXzqKl7AhlKgb9kvmQrqLRCeLMxdGuV66Y9g7VQQuWlh+
        dM/4tBUfa42BbMEazlwv9ahZlKH2JUw=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-213-fiEtrBYMPxSrgZI5lQgkZw-1; Wed, 16 Sep 2020 15:31:25 -0400
X-MC-Unique: fiEtrBYMPxSrgZI5lQgkZw-1
Received: by mail-ej1-f72.google.com with SMTP id dc22so3339715ejb.21
        for <linux-hyperv@vger.kernel.org>; Wed, 16 Sep 2020 12:31:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=H30dbXoNbzsTkPGiKpd2XjhJWXqjtA7dGp0dwpbyBQA=;
        b=l6XMoLuUVxipL0GFyrpPWjHWzY7eNGp8Tg7ihP8tiWGjgU9J22XdZ5oBOmLaDqu4+L
         c77drdIH0KYBgVfGTEx2+T8g0JlAc71D3NE3uqoFq84mm3FtbWRdVEFINlfyxVvijsyi
         LzNkqgfBmcQ293F0mn+5aB+rfkqJ2zXXPocIGhMmZ/utGGQotmnq4GAATYw9L4LvWCsB
         vDQYbVz/AwnTs4hlqb6BGXbWJckzoXKap6GAbk7E9JstdTZKgPEFTcuzhpKFCNbT0uMZ
         QoFyiWN5aFeQ/lkIvkVHYwF8KcvkGF3Gr0Zu0s0jY3ESgZ/+nf+JPDzq4LFCw2lbkm/4
         /euw==
X-Gm-Message-State: AOAM533/rCyHgjvfcg8/NCOe3jqZc65bVBYFE5CfYOMYav623qMoep3j
        zObclHobkSBOUjUY9fhyfW0f+dGo2q0vxVCozlOqe4nbhp228XKDnBgic3gV622pZDvV6HKBlv5
        jGvT6MFs4N//6h+iqON6wdL44
X-Received: by 2002:aa7:c7c2:: with SMTP id o2mr30417825eds.366.1600284684121;
        Wed, 16 Sep 2020 12:31:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwNf5C6IgWA4C90hz+1DV+boU+avbJN14GYmBM3jetRxVAOiNjdDaQK6JfCvz8qKCYsfBo/YA==
X-Received: by 2002:aa7:c7c2:: with SMTP id o2mr30417797eds.366.1600284683833;
        Wed, 16 Sep 2020 12:31:23 -0700 (PDT)
Received: from [192.168.3.122] (p4ff23c30.dip0.t-ipconnect.de. [79.242.60.48])
        by smtp.gmail.com with ESMTPSA id k25sm13202917ejk.3.2020.09.16.12.31.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Sep 2020 12:31:23 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   David Hildenbrand <david@redhat.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH RFC 0/4] mm: place pages to the freelist tail when onling and undoing isolation
Date:   Wed, 16 Sep 2020 21:31:21 +0200
Message-Id: <DAC9E747-BDDF-41B6-A89B-604880DD7543@redhat.com>
References: <5c0910c2cd0d9d351e509392a45552fb@suse.de>
Cc:     David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-hyperv@vger.kernel.org,
        xen-devel@lists.xenproject.org, linux-acpi@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michal Hocko <mhocko@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Scott Cheloha <cheloha@linux.ibm.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Vlastimil Babka <vbabka@suse.cz>, Wei Liu <wei.liu@kernel.org>,
        Wei Yang <richard.weiyang@linux.alibaba.com>
In-Reply-To: <5c0910c2cd0d9d351e509392a45552fb@suse.de>
To:     osalvador@suse.de
X-Mailer: iPhone Mail (17H35)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org



> Am 16.09.2020 um 20:50 schrieb osalvador@suse.de:
>=20
> =EF=BB=BFOn 2020-09-16 20:34, David Hildenbrand wrote:
>> When adding separate memory blocks via add_memory*() and onlining them
>> immediately, the metadata (especially the memmap) of the next block will b=
e
>> placed onto one of the just added+onlined block. This creates a chain
>> of unmovable allocations: If the last memory block cannot get
>> offlined+removed() so will all dependant ones. We directly have unmovable=

>> allocations all over the place.
>> This can be observed quite easily using virtio-mem, however, it can also
>> be observed when using DIMMs. The freshly onlined pages will usually be
>> placed to the head of the freelists, meaning they will be allocated next,=

>> turning the just-added memory usually immediately un-removable. The
>> fresh pages are cold, prefering to allocate others (that might be hot)
>> also feels to be the natural thing to do.
>> It also applies to the hyper-v balloon xen-balloon, and ppc64 dlpar: when=

>> adding separate, successive memory blocks, each memory block will have
>> unmovable allocations on them - for example gigantic pages will fail to
>> allocate.
>> While the ZONE_NORMAL doesn't provide any guarantees that memory can get
>> offlined+removed again (any kind of fragmentation with unmovable
>> allocations is possible), there are many scenarios (hotplugging a lot of
>> memory, running workload, hotunplug some memory/as much as possible) wher=
e
>> we can offline+remove quite a lot with this patchset.
>=20
> Hi David,
>=20

Hi Oscar.

> I did not read through the patchset yet, so sorry if the question is nonse=
nse, but is this not trying to fix the same issue the vmemmap patches did? [=
1]

Not nonesense at all. It only helps to some degree, though. It solves the de=
pendencies due to the memmap. However, it=E2=80=98s not completely ideal, es=
pecially for single memory blocks.

With single memory blocks (virtio-mem, xen-balloon, hv balloon, ppc dlpar) y=
ou still have unmovable (vmemmap chunks) all over the physical address space=
. Consider the gigantic page example after hotplug. You directly fragmented a=
ll hotplugged memory.

Of course, there might be (less extreme) dependencies due page tables for th=
e identity mapping, extended struct pages and similar.

Having that said, there are other benefits when preferring other memory over=
 just hotplugged memory. Think about adding+onlining memory during boot (dim=
ms under QEMU, virtio-mem), once the system is up you will have most (all) o=
f that memory completely untouched.

So while vmemmap on hotplugged memory would tackle some part of the issue, t=
here are cases where this approach is better, and there are even benefits wh=
en combining both.

Thanks!

David

>=20
> I was about to give it a new respin now that thw hwpoison stuff has been s=
ettled.
>=20
> [1] https://patchwork.kernel.org/cover/11059175/
>=20

