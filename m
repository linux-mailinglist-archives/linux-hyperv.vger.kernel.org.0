Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 83EE218BDF6
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2020 18:26:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727009AbgCSR0z (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 19 Mar 2020 13:26:55 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37097 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726934AbgCSR0z (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 19 Mar 2020 13:26:55 -0400
Received: by mail-wr1-f68.google.com with SMTP id w10so4147877wrm.4;
        Thu, 19 Mar 2020 10:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3F6p9VA0cVyFpp1otJBkETuyS8iU0ECrOYMDdRLVRxI=;
        b=QuAr0rCwgtiF82xHBWqQ4lSffZ977W564JnS7kFkj4jk+O1B4hwEtwYTvDMJd0KPzC
         W7UMfVthKh74N0igpoKyyZvB59aca9fYgTGHWI0wxqZpebWmfrzwomuaPhyu2VJEO56g
         p8dYe7vIpKa4hy2K1oGI5SvuFhZUuFjqaQ5nCVNmmA+eKRhwn1dzNTMdTUiPfQVqqylK
         /qunIobrNuRJE4LBBm/nxChANZ1J+lczwkjXC9am2snUc9QdDh9lM9vvgy4mt1gKjnpW
         XeCTdXi13mIw6cdMmEAXO9RJzB/RauIdkXZbliOpFv5hr2B7Il01mhJLYeyZ4YNCat++
         sZ8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3F6p9VA0cVyFpp1otJBkETuyS8iU0ECrOYMDdRLVRxI=;
        b=lIfsDiusw09b4ZRQw5u7Be9F5J2jhKUzKMQDrwSBsD4UvFg6M6i5NTRFZewU099JNk
         99pP+lDT6lBXMi9IZh7L/Ry5FnUfpGRneAQbPVoGzv2OdR6oqVER2Sx/nMr8FUp+d1JT
         K02doUFRzxo3h4we8Maw8vldCJ/57XynCyqxuTzCt/9iULyYDokU6ktNy1IsegGP73Dj
         j3XfoqjPPRb/ermHFu4b5iD4hXz6PmnS6Z2hPXXji4kQqeLOHHj0KYirhsO+sdDB0nIf
         /m9gX1yyyGDUw16sfbONd4r4iNjFHljGSqNzhpKs6FOOayfH8NlbeJTj0n6dP92zgJaV
         XyYw==
X-Gm-Message-State: ANhLgQ24D7Uv7Whb8lmAE6csKuRIl2CAao6gNBL9h3HDk2WvqlVs8AGT
        w0w4+2mnAyVPDiUZiahCMxM+xdTIRAPHPVqXbDg=
X-Google-Smtp-Source: ADFU+vuGxJnVkZr1vtGIyeQ2LhE/Qgr1xykJ1BEWBBmT3lH5VpBqrgI47O6jQXgHrf2qVsBwT9UGn19a4U3S1q5tmWg=
X-Received: by 2002:a5d:56c9:: with SMTP id m9mr5376031wrw.289.1584638812775;
 Thu, 19 Mar 2020 10:26:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200319131221.14044-1-david@redhat.com> <20200319131221.14044-9-david@redhat.com>
In-Reply-To: <20200319131221.14044-9-david@redhat.com>
From:   Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Date:   Thu, 19 Mar 2020 18:26:41 +0100
Message-ID: <CAM9Jb+iUrSf_KixRwj9M9FP=zSzvxn_E17Bxb0ZUiKpncThSAg@mail.gmail.com>
Subject: Re: [PATCH v3 8/8] mm/memory_hotplug: allow to specify a default online_type
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linuxppc-dev@lists.ozlabs.org, linux-hyperv@vger.kernel.org,
        Wei Yang <richard.weiyang@gmail.com>,
        Michal Hocko <mhocko@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Baoquan He <bhe@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> For now, distributions implement advanced udev rules to essentially
> - Don't online any hotplugged memory (s390x)
> - Online all memory to ZONE_NORMAL (e.g., most virt environments like
>   hyperv)
> - Online all memory to ZONE_MOVABLE in case the zone imbalance is taken
>   care of (e.g., bare metal, special virt environments)
>
> In summary: All memory is usually onlined the same way, however, the
> kernel always has to ask user space to come up with the same answer.
> E.g., Hyper-V always waits for a memory block to get onlined before
> continuing, otherwise it might end up adding memory faster than
> onlining it, which can result in strange OOM situations. This waiting
> slows down adding of a bigger amount of memory.
>
> Let's allow to specify a default online_type, not just "online" and
> "offline". This allows distributions to configure the default online_type
> when booting up and be done with it.
>
> We can now specify "offline", "online", "online_movable" and
> "online_kernel" via
> - "memhp_default_state=" on the kernel cmdline
> - /sys/devices/system/memory/auto_online_blocks
> just like we are able to specify for a single memory block via
> /sys/devices/system/memory/memoryX/state
>
> Reviewed-by: Wei Yang <richard.weiyang@gmail.com>
> Acked-by: Michal Hocko <mhocko@suse.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Baoquan He <bhe@redhat.com>
> Cc: Wei Yang <richard.weiyang@gmail.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  drivers/base/memory.c          | 11 +++++------
>  include/linux/memory_hotplug.h |  2 ++
>  mm/memory_hotplug.c            |  8 ++++----
>  3 files changed, 11 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/base/memory.c b/drivers/base/memory.c
> index 8d3e16dab69f..2b09b68b9f78 100644
> --- a/drivers/base/memory.c
> +++ b/drivers/base/memory.c
> @@ -35,7 +35,7 @@ static const char *const online_type_to_str[] = {
>         [MMOP_ONLINE_MOVABLE] = "online_movable",
>  };
>
> -static int memhp_online_type_from_str(const char *str)
> +int memhp_online_type_from_str(const char *str)
>  {
>         int i;
>
> @@ -394,13 +394,12 @@ static ssize_t auto_online_blocks_store(struct device *dev,
>                                         struct device_attribute *attr,
>                                         const char *buf, size_t count)
>  {
> -       if (sysfs_streq(buf, "online"))
> -               memhp_default_online_type = MMOP_ONLINE;
> -       else if (sysfs_streq(buf, "offline"))
> -               memhp_default_online_type = MMOP_OFFLINE;
> -       else
> +       const int online_type = memhp_online_type_from_str(buf);
> +
> +       if (online_type < 0)
>                 return -EINVAL;
>
> +       memhp_default_online_type = online_type;
>         return count;
>  }
>
> diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
> index 6d6f85bb66e9..93d9ada74ddd 100644
> --- a/include/linux/memory_hotplug.h
> +++ b/include/linux/memory_hotplug.h
> @@ -118,6 +118,8 @@ extern int arch_add_memory(int nid, u64 start, u64 size,
>                            struct mhp_params *params);
>  extern u64 max_mem_size;
>
> +extern int memhp_online_type_from_str(const char *str);
> +
>  /* Default online_type (MMOP_*) when new memory blocks are added. */
>  extern int memhp_default_online_type;
>  /* If movable_node boot option specified */
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 4efcf8cb9ac5..89197163d138 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -74,10 +74,10 @@ int memhp_default_online_type = MMOP_ONLINE;
>
>  static int __init setup_memhp_default_state(char *str)
>  {
> -       if (!strcmp(str, "online"))
> -               memhp_default_online_type = MMOP_ONLINE;
> -       else if (!strcmp(str, "offline"))
> -               memhp_default_online_type = MMOP_OFFLINE;
> +       const int online_type = memhp_online_type_from_str(str);
> +
> +       if (online_type >= 0)
> +               memhp_default_online_type = online_type;
>
>         return 1;
>  }
> --
Acked-by: Pankaj Gupta <pankaj.gupta.linux@gmail.com>

> 2.24.1
>
>
