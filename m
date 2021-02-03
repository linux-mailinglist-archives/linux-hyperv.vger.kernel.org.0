Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EE2930D31E
	for <lists+linux-hyperv@lfdr.de>; Wed,  3 Feb 2021 06:39:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbhBCFhj (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 3 Feb 2021 00:37:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbhBCFhi (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 3 Feb 2021 00:37:38 -0500
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 247D3C061573;
        Tue,  2 Feb 2021 21:36:58 -0800 (PST)
Received: by mail-io1-xd34.google.com with SMTP id f6so3794636ioz.5;
        Tue, 02 Feb 2021 21:36:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QOAFG5e83xgmf8k0DWJGMDL7RfKZ3CHVYa0GrtuyQBw=;
        b=WZXVoX6SBgnC737ppEU8/8migVv7IeXjPzQUQq2rQmRHGbhY89dPWxCwx+Wmj9UwGC
         lc/ACKgBxCQOBOR8RUH5eS+ZPszj1UvGL6thVaamq885PN7G9pFlhBvZt/UjpdnwUrZg
         FDRP03+Qs+KKS0ZCfxVEv4+Z4/KVByyF72r3O200gqOcdZmCVoRhsevpy2Kep1gmtYrX
         Q+vutsQ/UKBFRtLGqSfujBUn6z8YXtBb9x+4Re1py20oDhkh+JYoKAnMoNlcqsZD6Vhz
         bSwoRNFfqOu/YSNSWO+PLMoufPlB/CQGXyPhvVpQUklr9CoM4qVkcvUe703e7h5kz2Ur
         uszA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QOAFG5e83xgmf8k0DWJGMDL7RfKZ3CHVYa0GrtuyQBw=;
        b=avzslR4JM45LqEGinMAwfjSECrfSy1KJDKXjcV74tyuMxz9RDC+XE9WVmeHu35o2iq
         fAq//tziTfaICWRDghUefh7u3CHjXPXtHMDflaTOF8QixwiUL4RW3VW4VTazCfbY8bvB
         Oiu2WiJQyRdTG0L95KKzmacHrVudO0Lgtt/Q5t5HdueDT0PSBeNUXXo5S9TQNHMJEFBV
         CnNOMq0/xu1Y+ArLxRXQMFBZ6dXzGDln9HDqbB3My5Jj+r9bMWKxy+6PPeAxL7/p+l9P
         WeRGPrFJPlH+cwlf65YW7hm5KO8uqbJo+v0oeuX73B9p3w9OiiVHFnB/pDOE7Fsq62bw
         R0ng==
X-Gm-Message-State: AOAM5309tKfUgQLZDWXx3S+2lgQoZKOD9w/WXA6HzRjUmjx2qkt9DvTG
        qMblARRmM9wSlIkctIGKbHVhaHFMXcPtFKwB0Ug=
X-Google-Smtp-Source: ABdhPJzDAiiFwtpxbYTCU0PBMsJeg/lZf0roQ6HxhxuikJq6gsCG0p+pEyAta6N+UlSj2M5K1LhBFUYNd+rK32Rpbt8=
X-Received: by 2002:a05:6638:33aa:: with SMTP id h42mr1547914jav.124.1612330617400;
 Tue, 02 Feb 2021 21:36:57 -0800 (PST)
MIME-Version: 1.0
References: <20210126115829.10909-1-david@redhat.com>
In-Reply-To: <20210126115829.10909-1-david@redhat.com>
From:   Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Date:   Wed, 3 Feb 2021 06:36:45 +0100
Message-ID: <CAM9Jb+hQMqBmHOQoME+ro4K82v6bVe9Fhcjmkp4bxFtighVo8w@mail.gmail.com>
Subject: Re: [PATCH v1] mm/memory_hotplug: MEMHP_MERGE_RESOURCE -> MHP_MERGE_RESOURCE
To:     David Hildenbrand <david@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        linux-hyperv@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        xen-devel@lists.xenproject.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> Let's make "MEMHP_MERGE_RESOURCE" consistent with "MHP_NONE", "mhp_t" and
> "mhp_flags". As discussed recently [1], "mhp" is our internal
> acronym for memory hotplug now.
>
> [1] https://lore.kernel.org/linux-mm/c37de2d0-28a1-4f7d-f944-cfd7d81c334d@redhat.com/
>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: "K. Y. Srinivasan" <kys@microsoft.com>
> Cc: Haiyang Zhang <haiyangz@microsoft.com>
> Cc: Stephen Hemminger <sthemmin@microsoft.com>
> Cc: Wei Liu <wei.liu@kernel.org>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
> Cc: Juergen Gross <jgross@suse.com>
> Cc: Stefano Stabellini <sstabellini@kernel.org>
> Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
> Cc: Wei Yang <richard.weiyang@linux.alibaba.com>
> Cc: linux-hyperv@vger.kernel.org
> Cc: virtualization@lists.linux-foundation.org
> Cc: xen-devel@lists.xenproject.org
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  drivers/hv/hv_balloon.c        | 2 +-
>  drivers/virtio/virtio_mem.c    | 2 +-
>  drivers/xen/balloon.c          | 2 +-
>  include/linux/memory_hotplug.h | 2 +-
>  mm/memory_hotplug.c            | 2 +-
>  5 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/hv/hv_balloon.c b/drivers/hv/hv_balloon.c
> index 8c471823a5af..2f776d78e3c1 100644
> --- a/drivers/hv/hv_balloon.c
> +++ b/drivers/hv/hv_balloon.c
> @@ -726,7 +726,7 @@ static void hv_mem_hot_add(unsigned long start, unsigned long size,
>
>                 nid = memory_add_physaddr_to_nid(PFN_PHYS(start_pfn));
>                 ret = add_memory(nid, PFN_PHYS((start_pfn)),
> -                               (HA_CHUNK << PAGE_SHIFT), MEMHP_MERGE_RESOURCE);
> +                               (HA_CHUNK << PAGE_SHIFT), MHP_MERGE_RESOURCE);
>
>                 if (ret) {
>                         pr_err("hot_add memory failed error is %d\n", ret);
> diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
> index 85a272c9978e..148bea39b09a 100644
> --- a/drivers/virtio/virtio_mem.c
> +++ b/drivers/virtio/virtio_mem.c
> @@ -623,7 +623,7 @@ static int virtio_mem_add_memory(struct virtio_mem *vm, uint64_t addr,
>         /* Memory might get onlined immediately. */
>         atomic64_add(size, &vm->offline_size);
>         rc = add_memory_driver_managed(vm->nid, addr, size, vm->resource_name,
> -                                      MEMHP_MERGE_RESOURCE);
> +                                      MHP_MERGE_RESOURCE);
>         if (rc) {
>                 atomic64_sub(size, &vm->offline_size);
>                 dev_warn(&vm->vdev->dev, "adding memory failed: %d\n", rc);
> diff --git a/drivers/xen/balloon.c b/drivers/xen/balloon.c
> index b57b2067ecbf..671c71245a7b 100644
> --- a/drivers/xen/balloon.c
> +++ b/drivers/xen/balloon.c
> @@ -331,7 +331,7 @@ static enum bp_state reserve_additional_memory(void)
>         mutex_unlock(&balloon_mutex);
>         /* add_memory_resource() requires the device_hotplug lock */
>         lock_device_hotplug();
> -       rc = add_memory_resource(nid, resource, MEMHP_MERGE_RESOURCE);
> +       rc = add_memory_resource(nid, resource, MHP_MERGE_RESOURCE);
>         unlock_device_hotplug();
>         mutex_lock(&balloon_mutex);
>
> diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
> index 3d99de0db2dd..4b834f5d032e 100644
> --- a/include/linux/memory_hotplug.h
> +++ b/include/linux/memory_hotplug.h
> @@ -53,7 +53,7 @@ typedef int __bitwise mhp_t;
>   * with this flag set, the resource pointer must no longer be used as it
>   * might be stale, or the resource might have changed.
>   */
> -#define MEMHP_MERGE_RESOURCE   ((__force mhp_t)BIT(0))
> +#define MHP_MERGE_RESOURCE     ((__force mhp_t)BIT(0))
>
>  /*
>   * Extended parameters for memory hotplug:
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 710e469fb3a1..ae497e3ff77c 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -1153,7 +1153,7 @@ int __ref add_memory_resource(int nid, struct resource *res, mhp_t mhp_flags)
>          * In case we're allowed to merge the resource, flag it and trigger
>          * merging now that adding succeeded.
>          */
> -       if (mhp_flags & MEMHP_MERGE_RESOURCE)
> +       if (mhp_flags & MHP_MERGE_RESOURCE)
>                 merge_system_ram_resource(res);
>
>         /* online pages if requested */

 Reviewed-by: Pankaj Gupta <pankaj.gupta@cloud.ionos.com>
