Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49CBC1C2007
	for <lists+linux-hyperv@lfdr.de>; Fri,  1 May 2020 23:52:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726336AbgEAVwQ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 1 May 2020 17:52:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726307AbgEAVwQ (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 1 May 2020 17:52:16 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2B12C061A0C
        for <linux-hyperv@vger.kernel.org>; Fri,  1 May 2020 14:52:15 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id r7so8291483edo.11
        for <linux-hyperv@vger.kernel.org>; Fri, 01 May 2020 14:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l07ccX0wm+AEN60sydd1sDGIVZzQnw4FgS9Ujh07hXI=;
        b=mklS7vIKVEUdl7wntEpgBeCcvwVfQHQL1n/rmnKFbnOtHIZRisDisf4dMQS+dM0Nv0
         /mRQLawzCoRa0iAq+jVvpf0LYqgCjY+tO0Nl2pQjod+pUu+y/cbys3B6QuzFNwIhgq+e
         J0hSqTnwqIVOMJOuynhAAZ9fW5a6Vt9Xzotvtdm26jvNeifB0m/HBJs7okf++OwjA9rv
         5lz3SdD51W3h8Z5eRe/aaTM0oZ8G7J5TGcoo4kQ/achD7IKEF7tdsapTw8o+0ZAJulwF
         tm+BI0y7Xg01WDXA39uPG+FQVFMkDZI0YOggS1Fzhv4x3y9WAQf7Z6g1qNe1txuqYjtH
         o9jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l07ccX0wm+AEN60sydd1sDGIVZzQnw4FgS9Ujh07hXI=;
        b=mkuDmp1Dv35NRl3PIOETeCGAmhCJljQCBEdwkd8I+eg7dZYs7n2gTlsT4NalK1R80r
         wYFk2Ys7Uy+GK3L3dShqcmo+Yt1xnnTNvhRWDd+L4ltqh9mPGxFpOmlCOB3vo9S90lv+
         zLDfhYq0/jfC4+wKKtKCho4zxBHyfk+7NVg6YnK2TAAZV2fxZiaQr+jDRKmBA27gKYc9
         M3NLciwrgZ1oD3qwsCei63fsbtD8Ned1juoIC22JQWeVOBwSWwuyPcVf6TTsPJvJKo/V
         srPQUqfD+fla7kUO/YFuMdp7JL4q3KjRFO3lSF5uQ24TTBWd6ZtYSdXlhNJpixOlu+M+
         sXcw==
X-Gm-Message-State: AGi0PuZevNmq1qVGOgvaVIc7AObsb/vHOoNQdfrpnM3/cU6uL85cy46g
        3XZqExd+z1UufM7MDAflQ0Ef8XAdrkGUm2FtxtP8sA==
X-Google-Smtp-Source: APiQypJmId2DaeM7LwaM8l70eo6m7yrxIS8YHkCL5rA5nuZuCXHz7IuoKF/W4HpVt52A/r7auZb6rjukAuRVUpn3RXs=
X-Received: by 2002:a05:6402:759:: with SMTP id p25mr5505386edy.102.1588369934563;
 Fri, 01 May 2020 14:52:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200430102908.10107-1-david@redhat.com> <1b49c3be-6e2f-57cb-96f7-f66a8f8a9380@redhat.com>
 <871ro52ary.fsf@x220.int.ebiederm.org> <373a6898-4020-4af1-5b3d-f827d705dd77@redhat.com>
 <875zdg26hp.fsf@x220.int.ebiederm.org> <b28c9e02-8cf2-33ae-646b-fe50a185738e@redhat.com>
 <20200430152403.e0d6da5eb1cad06411ac6d46@linux-foundation.org>
 <5c908ec3-9495-531e-9291-cbab24f292d6@redhat.com> <CAPcyv4j=YKnr1HW4OhAmpzbuKjtfP7FdAn4-V7uA=b-Tcpfu+A@mail.gmail.com>
 <2d019c11-a478-9d70-abd5-4fd2ebf4bc1d@redhat.com> <CAPcyv4iOqS0Wbfa2KPfE1axQFGXoRB4mmPRP__Lmqpw6Qpr_ig@mail.gmail.com>
 <62dd4ce2-86cc-5b85-734f-ec8766528a1b@redhat.com> <0169e822-a6cc-1543-88ed-2a85d95ffb93@redhat.com>
 <CAPcyv4jGnR_fPtpKBC1rD2KRcT88bTkhqnTMmuwuc+f9Dwrz1g@mail.gmail.com>
 <9f3a813e-dc1d-b675-6e69-85beed3057a4@redhat.com> <CAPcyv4jjrxQ27rsfmz6wYPgmedevU=KG+wZ0GOm=qiE6tqa+VA@mail.gmail.com>
 <04242d48-5fa9-6da4-3e4a-991e401eb580@redhat.com> <CAPcyv4iXyOUDZgqhWH1KCObvATL=gP55xEr64rsRfUuJg5B+eQ@mail.gmail.com>
 <8242c0c5-2df2-fc0c-079a-3be62c113a11@redhat.com>
In-Reply-To: <8242c0c5-2df2-fc0c-079a-3be62c113a11@redhat.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 1 May 2020 14:52:03 -0700
Message-ID: <CAPcyv4h1nWjszkVJQgeXkUc=-nPv5=Me25BOGFQCpihUyFsD6w@mail.gmail.com>
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

On Fri, May 1, 2020 at 2:11 PM David Hildenbrand <david@redhat.com> wrote:
>
> On 01.05.20 22:12, Dan Williams wrote:
[..]
> >>> Consider the case of EFI Special Purpose (SP) Memory that is
> >>> marked EFI Conventional Memory with the SP attribute. In that case the
> >>> firmware memory map marked it as conventional RAM, but the kernel
> >>> optionally marks it as System RAM vs Soft Reserved. The 2008 patch
> >>> simply does not consider that case. I'm not sure strict textualism
> >>> works for coding decisions.
> >>
> >> I am no expert on that matter (esp EFI). But looking at the users of
> >> firmware_map_add_early(), the single user is in arch/x86/kernel/e820.c
> >> . So the single source of /sys/firmware/memmap is (besides hotplug) e820.
> >>
> >> "'e820_table_firmware': the original firmware version passed to us by
> >> the bootloader - not modified by the kernel. ... inform the user about
> >> the firmware's notion of memory layout via /sys/firmware/memmap"
> >> (arch/x86/kernel/e820.c)
> >>
> >> How is the EFI Special Purpose (SP) Memory represented in e820?
> >> /sys/firmware/memmap is really simple: just dump in e820. No policies IIUC.
> >
> > e820 now has a Soft Reserved translation for this which means "try to
> > reserve, but treat as System RAM is ok too". It seems generically
> > useful to me that the toggle for determining whether Soft Reserved or
> > System RAM shows up /sys/firmware/memmap is a determination that
> > policy can make. The kernel need not preemptively block it.
>
> So, I think I have to clarify something here. We do have two ways to kexec
>
> 1. kexec_load(): User space (kexec-tools) crafts the memmap (e.g., using
> /sys/firmware/memmap on x86-64) and selects memory where to place the
> kexec images (e.g., using /proc/iomem)
>
> 2. kexec_file_load(): The kernel reuses the (basically) raw firmware
> memmap and selects memory where to place kexec images.
>
> We are talking about changing 1, to behave like 2 in regards to
> dax/kmem. 2. does currently not add any hotplugged memory to the
> fixed-up e820, and it should be fixed regarding hotplugged DIMMs that
> would appear in e820 after a reboot.
>
> Now, all these policy discussions are nice and fun, but I don't really
> see a good reason to (ab)use /sys/firmware/memmap for that (e.g., parent
> properties). If you want to be able to make this configurable, then
> e.g., add a way to configure this in the kernel (for example along with
> kmem) to make 1. and 2. behave the same way. Otherwise, you really only
> can change 1.

That's clearer.

>
>
> Now, let's clarify what I want regarding virtio-mem:
>
> 1. kexec should not add virtio-mem memory to the initial firmware
>    memmap. The driver has to be in charge as discussed.
> 2. kexec should not place kexec images onto virtio-mem memory. That
>    would end badly.
> 3. kexec should still dump virtio-mem memory via kdump.

Ok, but then seems to say to me that dax/kmem is a different type of
(driver managed) than virtio-mem and it's confusing to try to apply
the same meaning. Why not just call your type for the distinct type it
is "System RAM (virtio-mem)" and let any other driver managed memory
follow the same "System RAM ($driver)" format if it wants?
