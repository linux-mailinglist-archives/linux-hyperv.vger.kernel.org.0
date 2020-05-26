Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 379441C1C05
	for <lists+linux-hyperv@lfdr.de>; Fri,  1 May 2020 19:39:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730175AbgEARjp (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 1 May 2020 13:39:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729807AbgEARjl (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 1 May 2020 13:39:41 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68F1FC08E859
        for <linux-hyperv@vger.kernel.org>; Fri,  1 May 2020 10:39:41 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id s9so8085651eju.1
        for <linux-hyperv@vger.kernel.org>; Fri, 01 May 2020 10:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dy1QO3v2TmcaobStg64BpwnTJR5lVFKTuFOSCo8GmkA=;
        b=ZFbBfzs2QE4xxYrnFXEMSgV7VomZkqIDLnKCbwZuLXE2bdQRRKnDJ2f4J0afAZ5AGo
         rP9kuD2G28NH74yg1IkNEaGUxilA8vimracGEKo4jJDRlhwm0FMsADHlSBvQrzOuq0ZK
         CZBlpTbtqNsQtcEwMe9p4/JuUqyXanSoZOH1zmdbc+9MNweeD6uoRH0cl0RKU1zhcEwi
         KVK/UkwuhvXWFad3q9M9sXR1q1XB/5wW5F4/UrTA0mWQDlwW4wqfNJ4uHouclRWwP8aF
         YHpwqQqOd2mOX5F09RWu9qYoNn6ux/9GamnFIvyqW4sbCL/HFriqsV+cTfO6VBepp8ym
         UREw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dy1QO3v2TmcaobStg64BpwnTJR5lVFKTuFOSCo8GmkA=;
        b=DZZkw8FjR/FElF52ymgBlFflsg31XRQRVJqTyex59wdOqnGUVrGoi5OU/vu6CfqBbF
         FRf5NipJ1QIu19OIBlKZyGYfxFzBJZD6zm17xUvCKFcWPglM+B+sOBBRtc+MoMgPyCkr
         9XBWSNaNA6CA2ZhgaQizAeJyZDz0r+TZjaIrIKMFFSGoY4I9KqeZ4YQNCqFeauVPMSoB
         OeJgxdNZTghfb7nmwG8G28k6y6zGhuVFvmG4rMgGXJ1F2uLtRgcXQmJShPzndnmxBn2u
         Trxa9U/rAHfmpw27dzYECPaKcA9xGx29V7I/78ApWWG/Mpn5bi8keGuRmj9yMJlsxpDG
         nDcg==
X-Gm-Message-State: AGi0PubWXU1Tj+ExEdGuejV/rU8Z+eaUy9PWKNIMQBZtJBsa8JAYy8V0
        g1yBplhwCEbGSxiWaoqQbmOJCPcxu8aNqmzrl5nyWw==
X-Google-Smtp-Source: APiQypKykdi+282JilRe16+6KKLcB6tg9cgSEAjlHPf89wAO5Cv3AtR5Wk0ydTXi3sTqOc+y0w//0y1mp0EsvfqmPHo=
X-Received: by 2002:a17:906:90cc:: with SMTP id v12mr4384205ejw.211.1588354779963;
 Fri, 01 May 2020 10:39:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200430102908.10107-1-david@redhat.com> <20200430102908.10107-3-david@redhat.com>
 <87pnbp2dcz.fsf@x220.int.ebiederm.org> <1b49c3be-6e2f-57cb-96f7-f66a8f8a9380@redhat.com>
 <871ro52ary.fsf@x220.int.ebiederm.org> <373a6898-4020-4af1-5b3d-f827d705dd77@redhat.com>
 <875zdg26hp.fsf@x220.int.ebiederm.org> <b28c9e02-8cf2-33ae-646b-fe50a185738e@redhat.com>
 <20200430152403.e0d6da5eb1cad06411ac6d46@linux-foundation.org>
 <5c908ec3-9495-531e-9291-cbab24f292d6@redhat.com> <CAPcyv4j=YKnr1HW4OhAmpzbuKjtfP7FdAn4-V7uA=b-Tcpfu+A@mail.gmail.com>
 <2d019c11-a478-9d70-abd5-4fd2ebf4bc1d@redhat.com>
In-Reply-To: <2d019c11-a478-9d70-abd5-4fd2ebf4bc1d@redhat.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 1 May 2020 10:39:28 -0700
Message-ID: <CAPcyv4iOqS0Wbfa2KPfE1axQFGXoRB4mmPRP__Lmqpw6Qpr_ig@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] mm/memory_hotplug: Introduce MHP_NO_FIRMWARE_MEMMAP
To:     David Hildenbrand <david@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>, virtio-dev@lists.oasis-open.org,
        virtualization@lists.linux-foundation.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        linux-hyperv@vger.kernel.org,
        linux-s390 <linux-s390@vger.kernel.org>,
        xen-devel <xen-devel@lists.xenproject.org>,
        Michal Hocko <mhocko@kernel.org>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        Baoquan He <bhe@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, May 1, 2020 at 10:21 AM David Hildenbrand <david@redhat.com> wrote:
>
> On 01.05.20 18:56, Dan Williams wrote:
> > On Fri, May 1, 2020 at 2:34 AM David Hildenbrand <david@redhat.com> wrote:
> >>
> >> On 01.05.20 00:24, Andrew Morton wrote:
> >>> On Thu, 30 Apr 2020 20:43:39 +0200 David Hildenbrand <david@redhat.com> wrote:
> >>>
> >>>>>
> >>>>> Why does the firmware map support hotplug entries?
> >>>>
> >>>> I assume:
> >>>>
> >>>> The firmware memmap was added primarily for x86-64 kexec (and still, is
> >>>> mostly used on x86-64 only IIRC). There, we had ACPI hotplug. When DIMMs
> >>>> get hotplugged on real HW, they get added to e820. Same applies to
> >>>> memory added via HyperV balloon (unless memory is unplugged via
> >>>> ballooning and you reboot ... the the e820 is changed as well). I assume
> >>>> we wanted to be able to reflect that, to make kexec look like a real reboot.
> >>>>
> >>>> This worked for a while. Then came dax/kmem. Now comes virtio-mem.
> >>>>
> >>>>
> >>>> But I assume only Andrew can enlighten us.
> >>>>
> >>>> @Andrew, any guidance here? Should we really add all memory to the
> >>>> firmware memmap, even if this contradicts with the existing
> >>>> documentation? (especially, if the actual firmware memmap will *not*
> >>>> contain that memory after a reboot)
> >>>
> >>> For some reason that patch is misattributed - it was authored by
> >>> Shaohui Zheng <shaohui.zheng@intel.com>, who hasn't been heard from in
> >>> a decade.  I looked through the email discussion from that time and I'm
> >>> not seeing anything useful.  But I wasn't able to locate Dave Hansen's
> >>> review comments.
> >>
> >> Okay, thanks for checking. I think the documentation from 2008 is pretty
> >> clear what has to be done here. I will add some of these details to the
> >> patch description.
> >>
> >> Also, now that I know that esp. kexec-tools already don't consider
> >> dax/kmem memory properly (memory will not get dumped via kdump) and
> >> won't really suffer from a name change in /proc/iomem, I will go back to
> >> the MHP_DRIVER_MANAGED approach and
> >> 1. Don't create firmware memmap entries
> >> 2. Name the resource "System RAM (driver managed)"
> >> 3. Flag the resource via something like IORESOURCE_MEM_DRIVER_MANAGED.
> >>
> >> This way, kernel users and user space can figure out that this memory
> >> has different semantics and handle it accordingly - I think that was
> >> what Eric was asking for.
> >>
> >> Of course, open for suggestions.
> >
> > I'm still more of a fan of this being communicated by "System RAM"
>
> I was mentioning somewhere in this thread that "System RAM" inside a
> hierarchy (like dax/kmem) will already be basically ignored by
> kexec-tools. So, placing it inside a hierarchy already makes it look
> special already.
>
> But after all, as we have to change kexec-tools either way, we can
> directly go ahead and flag it properly as special (in case there will
> ever be other cases where we could no longer distinguish it).
>
> > being parented especially because that tells you something about how
> > the memory is driver-managed and which mechanism might be in play.
>
> The could be communicated to some degree via the resource hierarchy.
>
> E.g.,
>
>             [root@localhost ~]# cat /proc/iomem
>             ...
>             140000000-33fffffff : Persistent Memory
>               140000000-1481fffff : namespace0.0
>               150000000-33fffffff : dax0.0
>                 150000000-33fffffff : System RAM (driver managed)
>
> vs.
>
>            :/# cat /proc/iomem
>             [...]
>             140000000-333ffffff : virtio-mem (virtio0)
>               140000000-147ffffff : System RAM (driver managed)
>               148000000-14fffffff : System RAM (driver managed)
>               150000000-157ffffff : System RAM (driver managed)
>
> Good enough for my taste.
>
> > What about adding an optional /sys/firmware/memmap/X/parent attribute.
>
> I really don't want any firmware memmap entries for something that is
> not part of the firmware provided memmap. In addition,
> /sys/firmware/memmap/ is still a fairly x86_64 specific thing. Only mips
> and two arm configs enable it at all.
>
> So, IMHO, /sys/firmware/memmap/ is definitely not the way to go.

I think that's a policy decision and policy decisions do not belong in
the kernel. Give the tooling the opportunity to decide whether System
RAM stays that way over a kexec. The parenthetical reference otherwise
looks out of place to me in the /proc/iomem output. What makes it
"driver managed" is how the kernel handles it, not how the kernel
names it.
