Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E64EE257692
	for <lists+linux-hyperv@lfdr.de>; Mon, 31 Aug 2020 11:35:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726072AbgHaJfw (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 31 Aug 2020 05:35:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725915AbgHaJfu (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 31 Aug 2020 05:35:50 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 146D8C061573;
        Mon, 31 Aug 2020 02:35:49 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id w20so5191297iom.1;
        Mon, 31 Aug 2020 02:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=HsNtRpi0XGja6Sj9lSJWoznoixc15RWCQVmmU4+oCGQ=;
        b=BkWe+B6D3lN045gds9IoFYUQ+o2juq6u/5mtP4qMWEZgN4V72MQv52x13zt+0Vagcw
         PiplKpJDZIg1gJ/K+PqleXk0+ms/PIwH4m04bUTXOP6LZe4mc4lUMCnaFMAZ1Nf7OH5R
         +TO1BAV2uJm4VdeFkABkZgYtRWdSxBF7MObhl58VcQjVfHSqlwYCoTT8LWmc7Hg5H7zn
         rFVALNyy0QNyyM9EWLw6uOxE4Uiqo6MEltvqGfVltYm+Lsi1MNLu6dooosPYw/1NDhKj
         0s2nGoPPTS/ePGpaVVkCc9/P0ug7/BLTlsgu0GElkFNNztt3JlZyxdTPXMRhtYmxlaLF
         /55A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HsNtRpi0XGja6Sj9lSJWoznoixc15RWCQVmmU4+oCGQ=;
        b=o00SnCss4AugIwNW/hj2acmI4UGAsFIP1R/7tCNXhfk2Z4R4T8hYJBtZgIp2ZMHFml
         l21CmAnU3YF00Vma3Qbqy7GZDD6xtvdUngeM7dSDatJ6J1fbPtE7DOMcYL1P9RzetKo4
         flN4N9ey1jWfK/qdrkOG59RXKi/SIwr73QjSILxWRQ0tzjshDw/SjhEOgsKGMQkTCHcH
         R6dX3XSttvLFWNfJB8vI19yyp/7dib12KVBfH6VNSDzmvBGwtliT3cNh0dokQ7erwncs
         949/oMHciN5bBSih2E7QeulOCDGkh+ZcZqX6DjXlrMz2ADVqbxFk2blfRFFhmQOpqVsh
         c5kQ==
X-Gm-Message-State: AOAM5336UvPqccJ7xOJ+pzb0vMYkCm2IqhZtENgC++nZ0CDm0oAEQGxc
        IKARigSPQRlWLlbMSfdyK9k4xtBZjk3ujquZbO8=
X-Google-Smtp-Source: ABdhPJww8t42sUm+jGq9r4vVjstNF9Iiu7OItpZmQeVdogqBS81K4nUxuzik3G0XU545fyNmeFJRfcVCeSn7YUqh2/o=
X-Received: by 2002:a6b:b513:: with SMTP id e19mr547960iof.167.1598866548037;
 Mon, 31 Aug 2020 02:35:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200821103431.13481-1-david@redhat.com> <20200821103431.13481-3-david@redhat.com>
In-Reply-To: <20200821103431.13481-3-david@redhat.com>
From:   Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Date:   Mon, 31 Aug 2020 11:35:36 +0200
Message-ID: <CAM9Jb+hJ8YSB6XZi6CB3jU-LSdVhKGZw=6NESzFhY7bbU9uOSQ@mail.gmail.com>
Subject: Re: [PATCH v1 2/5] kernel/resource: merge_system_ram_resources() to
 merge resources after hotplug
To:     David Hildenbrand <david@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        virtualization@lists.linux-foundation.org,
        Linux MM <linux-mm@kvack.org>, linux-hyperv@vger.kernel.org,
        xen-devel@lists.xenproject.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Kees Cook <keescook@chromium.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>,
        Julien Grall <julien@xen.org>, Baoquan He <bhe@redhat.com>,
        Wei Yang <richardw.yang@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> Some add_memory*() users add memory in small, contiguous memory blocks.
> Examples include virtio-mem, hyper-v balloon, and the XEN balloon.
>
> This can quickly result in a lot of memory resources, whereby the actual
> resource boundaries are not of interest (e.g., it might be relevant for
> DIMMs, exposed via /proc/iomem to user space). We really want to merge
> added resources in this scenario where possible.
>
> Let's provide an interface to trigger merging of applicable child
> resources. It will be, for example, used by virtio-mem to trigger
> merging of system ram resources it added to its resource container, but
> also by XEN and Hyper-V to trigger merging of system ram resources in
> iomem_resource.
>
> Note: We really want to merge after the whole operation succeeded, not
> directly when adding a resource to the resource tree (it would break
> add_memory_resource() and require splitting resources again when the
> operation failed - e.g., due to -ENOMEM).
>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: "K. Y. Srinivasan" <kys@microsoft.com>
> Cc: Haiyang Zhang <haiyangz@microsoft.com>
> Cc: Stephen Hemminger <sthemmin@microsoft.com>
> Cc: Wei Liu <wei.liu@kernel.org>
> Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
> Cc: Juergen Gross <jgross@suse.com>
> Cc: Stefano Stabellini <sstabellini@kernel.org>
> Cc: Roger Pau Monn=C3=A9 <roger.pau@citrix.com>
> Cc: Julien Grall <julien@xen.org>
> Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
> Cc: Baoquan He <bhe@redhat.com>
> Cc: Wei Yang <richardw.yang@linux.intel.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  include/linux/ioport.h |  3 +++
>  kernel/resource.c      | 52 ++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 55 insertions(+)
>
> diff --git a/include/linux/ioport.h b/include/linux/ioport.h
> index 52a91f5fa1a36..3bb0020cd6ddc 100644
> --- a/include/linux/ioport.h
> +++ b/include/linux/ioport.h
> @@ -251,6 +251,9 @@ extern void __release_region(struct resource *, resou=
rce_size_t,
>  extern void release_mem_region_adjustable(struct resource *, resource_si=
ze_t,
>                                           resource_size_t);
>  #endif
> +#ifdef CONFIG_MEMORY_HOTPLUG
> +extern void merge_system_ram_resources(struct resource *res);
> +#endif
>
>  /* Wrappers for managed devices */
>  struct device;
> diff --git a/kernel/resource.c b/kernel/resource.c
> index 1dcef5d53d76e..b4e0963edadd2 100644
> --- a/kernel/resource.c
> +++ b/kernel/resource.c
> @@ -1360,6 +1360,58 @@ void release_mem_region_adjustable(struct resource=
 *parent,
>  }
>  #endif /* CONFIG_MEMORY_HOTREMOVE */
>
> +#ifdef CONFIG_MEMORY_HOTPLUG
> +static bool system_ram_resources_mergeable(struct resource *r1,
> +                                          struct resource *r2)
> +{
> +       return r1->flags =3D=3D r2->flags && r1->end + 1 =3D=3D r2->start=
 &&
> +              r1->name =3D=3D r2->name && r1->desc =3D=3D r2->desc &&
> +              !r1->child && !r2->child;
> +}
> +
> +/*
> + * merge_system_ram_resources - try to merge contiguous system ram resou=
rces
> + * @parent: parent resource descriptor
> + *
> + * This interface is intended for memory hotplug, whereby lots of contig=
uous
> + * system ram resources are added (e.g., via add_memory*()) by a driver,=
 and
> + * the actual resource boundaries are not of interest (e.g., it might be
> + * relevant for DIMMs). Only immediate child resources that are busy and
> + * don't have any children are considered. All applicable child resource=
s
> + * must be immutable during the request.
> + *
> + * Note:
> + * - The caller has to make sure that no pointers to resources that migh=
t
> + *   get merged are held anymore. Callers should only trigger merging of=
 child
> + *   resources when they are the only one adding system ram resources to=
 the
> + *   parent (besides during boot).
> + * - release_mem_region_adjustable() will split on demand on memory hotu=
nplug
> + */
> +void merge_system_ram_resources(struct resource *parent)
> +{
> +       const unsigned long flags =3D IORESOURCE_SYSTEM_RAM | IORESOURCE_=
BUSY;
> +       struct resource *cur, *next;
> +
> +       write_lock(&resource_lock);
> +
> +       cur =3D parent->child;
> +       while (cur && cur->sibling) {
> +               next =3D cur->sibling;
> +               if ((cur->flags & flags) =3D=3D flags &&

Maybe this can be changed to:
!(cur->flags & ~flags)

> +                   system_ram_resources_mergeable(cur, next)) {
> +                       cur->end =3D next->end;
> +                       cur->sibling =3D next->sibling;
> +                       free_resource(next);
> +                       next =3D cur->sibling;
> +               }
> +               cur =3D next;
> +       }
> +
> +       write_unlock(&resource_lock);
> +}
> +EXPORT_SYMBOL(merge_system_ram_resources);
> +#endif /* CONFIG_MEMORY_HOTPLUG */
> +
>  /*
>   * Managed region resource
>   */
> --
> 2.26.2
>
