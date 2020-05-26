Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F67C1C2764
	for <lists+linux-hyperv@lfdr.de>; Sat,  2 May 2020 20:03:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727988AbgEBSDP (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sat, 2 May 2020 14:03:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728059AbgEBSDO (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 2 May 2020 14:03:14 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9A9DC061A0F
        for <linux-hyperv@vger.kernel.org>; Sat,  2 May 2020 11:03:13 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id f12so9850402edn.12
        for <linux-hyperv@vger.kernel.org>; Sat, 02 May 2020 11:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gzsuxDlItzKXIUBK7WGNpTkOsm9nq+BDdgFK8X2BWvo=;
        b=aSBw5wCDConKD/IcaaHbp4Mo0CTJ0pgKRvNWRkiIWGE3lCN/oPbrEa9/oKAglpfRn1
         ybYK1kBJxRVbPzvApGi7N1gI88wlw4xjREME4zX7kVXKZH3FDgSbie3ks5shBRY8TZ6q
         DMFWhZRW7RkjeJCSKPKh/8pZ2QWGSZw/Nyq/zAlnOngdfv/+o/QV9wf4QVQZ5gXVDkzN
         XNN+MYW95/ejtNi3wUzQ6oJ8i+BfB05eb9CwAbUAIbruiYbVwz5lfsdGnAXaouOdPAgk
         c8v1YIbx6b+WQ999NPSKnSrIN3qI9oKtRGvdPYhTcKRXMBwc/GxItvO5XlgyBCaOSzcl
         2H2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gzsuxDlItzKXIUBK7WGNpTkOsm9nq+BDdgFK8X2BWvo=;
        b=TAD1quP6hHUcv+IP904bTRBe0T1sin9q3X1f0DtIoriLFE10tKFKJcLtX0qJFTXjXh
         1RVC0faPTOr+/IBpWyQsNUR5/DdOUC5N/4RF6gvZ0oDjNK0Mdpw/MU+H7xKtxZWvVndF
         7CjZlkA1NGVuybrcqgSfTwaOviQkZEYYfuVLSkx54gIFw0CkV/SBDmVrAfe69E6gaOtL
         g5jAS/oCE9fk6Y4WAOowevpIhrh4vVy6UNZD2YEnt8r/kmlcfMjRtMpQWeOoto3FR3CK
         r8AYBwHwwwYk/kq1moS6HUKK1u6fjVEFZHhhEk3MW2xnGQeeFoEEdgXnWY4R4A3HyaAa
         4Lkw==
X-Gm-Message-State: AGi0Puazb6hCQ9IhXe+mduYm2sfu9C42p/hZHxi+G/Flx9fCBBK9KxML
        za4JsZbOWusoC5GL0ebaf+/DOM3iDe6mjDHlwPOm0Q==
X-Google-Smtp-Source: APiQypJrbz2VzfjebhxcGzu52aKY5ET0/26CFym5+FOkkSLJ9Vu46v3NJUgCYAVe4ZsgBJWlfsgCXWWgDBxtIIIlF1U=
X-Received: by 2002:a05:6402:3136:: with SMTP id dd22mr8275680edb.165.1588442592251;
 Sat, 02 May 2020 11:03:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200430102908.10107-1-david@redhat.com> <875zdg26hp.fsf@x220.int.ebiederm.org>
 <b28c9e02-8cf2-33ae-646b-fe50a185738e@redhat.com> <20200430152403.e0d6da5eb1cad06411ac6d46@linux-foundation.org>
 <5c908ec3-9495-531e-9291-cbab24f292d6@redhat.com> <CAPcyv4j=YKnr1HW4OhAmpzbuKjtfP7FdAn4-V7uA=b-Tcpfu+A@mail.gmail.com>
 <2d019c11-a478-9d70-abd5-4fd2ebf4bc1d@redhat.com> <CAPcyv4iOqS0Wbfa2KPfE1axQFGXoRB4mmPRP__Lmqpw6Qpr_ig@mail.gmail.com>
 <62dd4ce2-86cc-5b85-734f-ec8766528a1b@redhat.com> <0169e822-a6cc-1543-88ed-2a85d95ffb93@redhat.com>
 <CAPcyv4jGnR_fPtpKBC1rD2KRcT88bTkhqnTMmuwuc+f9Dwrz1g@mail.gmail.com>
 <9f3a813e-dc1d-b675-6e69-85beed3057a4@redhat.com> <CAPcyv4jjrxQ27rsfmz6wYPgmedevU=KG+wZ0GOm=qiE6tqa+VA@mail.gmail.com>
 <04242d48-5fa9-6da4-3e4a-991e401eb580@redhat.com> <CAPcyv4iXyOUDZgqhWH1KCObvATL=gP55xEr64rsRfUuJg5B+eQ@mail.gmail.com>
 <8242c0c5-2df2-fc0c-079a-3be62c113a11@redhat.com> <CAPcyv4h1nWjszkVJQgeXkUc=-nPv5=Me25BOGFQCpihUyFsD6w@mail.gmail.com>
 <467ccba3-80ac-085c-3127-d5618d77d3e0@redhat.com>
In-Reply-To: <467ccba3-80ac-085c-3127-d5618d77d3e0@redhat.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Sat, 2 May 2020 11:03:01 -0700
Message-ID: <CAPcyv4iqwh6k40DUy-Pwi2h5pJm9vu7+JU1ghELy=3MGM1naNg@mail.gmail.com>
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
        Baoquan He <bhe@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Sat, May 2, 2020 at 2:27 AM David Hildenbrand <david@redhat.com> wrote:
>
> >> Now, let's clarify what I want regarding virtio-mem:
> >>
> >> 1. kexec should not add virtio-mem memory to the initial firmware
> >>    memmap. The driver has to be in charge as discussed.
> >> 2. kexec should not place kexec images onto virtio-mem memory. That
> >>    would end badly.
> >> 3. kexec should still dump virtio-mem memory via kdump.
> >
> > Ok, but then seems to say to me that dax/kmem is a different type of
> > (driver managed) than virtio-mem and it's confusing to try to apply
> > the same meaning. Why not just call your type for the distinct type it
> > is "System RAM (virtio-mem)" and let any other driver managed memory
> > follow the same "System RAM ($driver)" format if it wants?
>
> I had the same idea but discarded it because it seemed to uglify the
> add_memory() interface (passing yet another parameter only relevant for
> driver managed memory). Maybe we really want a new one, because I like
> that idea:
>
> /*
>  * Add special, driver-managed memory to the system as system ram.
>  * The resource_name is expected to have the name format "System RAM
>  * ($DRIVER)", so user space (esp. kexec-tools)" can special-case it.
>  *
>  * For this memory, no entries in /sys/firmware/memmap are created,
>  * as this memory won't be part of the raw firmware-provided memory map
>  * e.g., after a reboot. Also, the created memory resource is flagged
>  * with IORESOURCE_MEM_DRIVER_MANAGED, so in-kernel users can special-
>  * case this memory (e.g., not place kexec images onto it).
>  */
> int add_memory_driver_managed(int nid, u64 start, u64 size,
>                               const char *resource_name);
>
>
> If we'd ever have to special case it even more in the kernel, we could
> allow to specify further resource flags. While passing the driver name
> instead of the resource_name would be an option, this way we don't have
> to hand craft new resource strings for added memory resources.
>
> Thoughts?

Looks useful to me and simplifies walking /proc/iomem. I personally
like the safety of the string just being the $driver component of the
name, but I won't lose sleep if the interface stays freeform like you
propose.
