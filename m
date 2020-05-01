Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C3491C1AED
	for <lists+linux-hyperv@lfdr.de>; Fri,  1 May 2020 18:57:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729323AbgEAQ5K (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 1 May 2020 12:57:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728841AbgEAQ5J (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 1 May 2020 12:57:09 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2DD3C061A0C
        for <linux-hyperv@vger.kernel.org>; Fri,  1 May 2020 09:57:08 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id k22so7720952eds.6
        for <linux-hyperv@vger.kernel.org>; Fri, 01 May 2020 09:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b9REn6X5SevH+LhOI4dPec9Nj6TaOfQYrUIVwbI6BoM=;
        b=mG1IcDPBM3HrlLCRXRv7RTTYgDzrduMX/5i/AlHCRx1Od+IpfQAyd0PeN//EsT0f5h
         4ISFK8ebgantTgILgro22Ez5VhTT+nYI/BrtdR2EEj+8gVO8TXYZXeoKV+n5R7g8buaW
         2yUZz1nPzY+7zON3G0XQLly2Qxcbo0G4O5Y6WDLkdJ7/fnZJpvu7siFKyoRkKMeO0fUZ
         /D0cspPD70+dXDGbdUVG4+VwKt7dWiqpPW5XzMx4fPRxJpNAeD6LnRMMzp+TiNYAZ53P
         qpaqeGLDtip2gO0UP/p8HNcC5mdTxBx8phoHoUjMgHPlB7ivmPuMEBOrgC5YppxB1E9h
         UOtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b9REn6X5SevH+LhOI4dPec9Nj6TaOfQYrUIVwbI6BoM=;
        b=dNA4tABeo9Yo4ReX9eA3a/mwe4dL6OeoCE0avwb+raq0i0llE5bvN8hhUhsCe28cvs
         31L8OrmTmtoplV1AQqoNBeug862gor0ZCXVe33cjrlyAzdd0XzveV/8DpbSirCpoXNkn
         CjjoEfr3ucxtio/othN5y/A1LgJw8SVHn29cYJZrWHD4aZhHd4kKyS68309oQfDb/RLB
         x6qwEHfLFeM8LqITdNZmQ7tZU1AgoBm4hDURXp6BSoWdw78d4c/6UEED8z3tzTszM0z5
         QxLxSTZHZN17qzVjx7qs/wwhdhfP32tfkfoyXkP/Kq6WNF2KiCD7jCjT6sDVc6+dEZQG
         GuHA==
X-Gm-Message-State: AGi0PuatJUd+rY7B29FFMPKyBoK7611x5x7zPralBWNe7XA+annMvUb0
        Jko8SmzSpddb+qfa5HPTFZUOdWLiBcBkF7PYWCGCdQ==
X-Google-Smtp-Source: APiQypJO8dBUZTWLLj3LS+obr3vgzbWXqFSCM7dxYsl5W+J7URhuw83eMvKFki8Cpffi0gsBU7jQUIflqfdneq89wWQ=
X-Received: by 2002:aa7:c643:: with SMTP id z3mr4236295edr.154.1588352227631;
 Fri, 01 May 2020 09:57:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200430102908.10107-1-david@redhat.com> <20200430102908.10107-3-david@redhat.com>
 <87pnbp2dcz.fsf@x220.int.ebiederm.org> <1b49c3be-6e2f-57cb-96f7-f66a8f8a9380@redhat.com>
 <871ro52ary.fsf@x220.int.ebiederm.org> <373a6898-4020-4af1-5b3d-f827d705dd77@redhat.com>
 <875zdg26hp.fsf@x220.int.ebiederm.org> <b28c9e02-8cf2-33ae-646b-fe50a185738e@redhat.com>
 <20200430152403.e0d6da5eb1cad06411ac6d46@linux-foundation.org> <5c908ec3-9495-531e-9291-cbab24f292d6@redhat.com>
In-Reply-To: <5c908ec3-9495-531e-9291-cbab24f292d6@redhat.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 1 May 2020 09:56:56 -0700
Message-ID: <CAPcyv4j=YKnr1HW4OhAmpzbuKjtfP7FdAn4-V7uA=b-Tcpfu+A@mail.gmail.com>
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

On Fri, May 1, 2020 at 2:34 AM David Hildenbrand <david@redhat.com> wrote:
>
> On 01.05.20 00:24, Andrew Morton wrote:
> > On Thu, 30 Apr 2020 20:43:39 +0200 David Hildenbrand <david@redhat.com> wrote:
> >
> >>>
> >>> Why does the firmware map support hotplug entries?
> >>
> >> I assume:
> >>
> >> The firmware memmap was added primarily for x86-64 kexec (and still, is
> >> mostly used on x86-64 only IIRC). There, we had ACPI hotplug. When DIMMs
> >> get hotplugged on real HW, they get added to e820. Same applies to
> >> memory added via HyperV balloon (unless memory is unplugged via
> >> ballooning and you reboot ... the the e820 is changed as well). I assume
> >> we wanted to be able to reflect that, to make kexec look like a real reboot.
> >>
> >> This worked for a while. Then came dax/kmem. Now comes virtio-mem.
> >>
> >>
> >> But I assume only Andrew can enlighten us.
> >>
> >> @Andrew, any guidance here? Should we really add all memory to the
> >> firmware memmap, even if this contradicts with the existing
> >> documentation? (especially, if the actual firmware memmap will *not*
> >> contain that memory after a reboot)
> >
> > For some reason that patch is misattributed - it was authored by
> > Shaohui Zheng <shaohui.zheng@intel.com>, who hasn't been heard from in
> > a decade.  I looked through the email discussion from that time and I'm
> > not seeing anything useful.  But I wasn't able to locate Dave Hansen's
> > review comments.
>
> Okay, thanks for checking. I think the documentation from 2008 is pretty
> clear what has to be done here. I will add some of these details to the
> patch description.
>
> Also, now that I know that esp. kexec-tools already don't consider
> dax/kmem memory properly (memory will not get dumped via kdump) and
> won't really suffer from a name change in /proc/iomem, I will go back to
> the MHP_DRIVER_MANAGED approach and
> 1. Don't create firmware memmap entries
> 2. Name the resource "System RAM (driver managed)"
> 3. Flag the resource via something like IORESOURCE_MEM_DRIVER_MANAGED.
>
> This way, kernel users and user space can figure out that this memory
> has different semantics and handle it accordingly - I think that was
> what Eric was asking for.
>
> Of course, open for suggestions.

I'm still more of a fan of this being communicated by "System RAM"
being parented especially because that tells you something about how
the memory is driver-managed and which mechanism might be in play.
What about adding an optional /sys/firmware/memmap/X/parent attribute.
This lets tooling check if it cares via that interface and lets it
lookup the related infrastructure to interact with if it would do
something different for virtio-mem vs dax/kmem?
