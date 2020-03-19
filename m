Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B759F18BC6C
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2020 17:28:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727592AbgCSQ2T (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 19 Mar 2020 12:28:19 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39764 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727416AbgCSQ2T (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 19 Mar 2020 12:28:19 -0400
Received: by mail-wr1-f68.google.com with SMTP id h6so3858779wrs.6;
        Thu, 19 Mar 2020 09:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SPgbvNOx93ZbKq64/B6/Z1gW0+quFKremjRSKVCy664=;
        b=LFqUgnckFAOA9p+wCjOZ+EhTau2SI0k45PYdANda466lpPHrNJ665SzPzR+aNSKJxB
         Rwm3nn/XF7a0al/6zmG4QENhSXWyEmxDnpnirHW4YW2XKi/1n/5jYuUl+/xCRq5n4oPC
         O4XQzz8H4fKscVlPYfA2098A+MPZKS6Xhyf/chTQglAkwcbL4wa4mXMSoWDWgaQ5ZqtA
         xuFpKp2fRITG0nc1x4ZJniRpm88xs0+d62KmZg2ZGrzTY3bzKNvjXFwmmFWNn8EQsksT
         91cj7xrLFx3tLg+RklBpueUhbArZ/yDFXB2H44fIiYwTqkkYQ1JP3xjPeG1RGJm1Hurv
         EXQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SPgbvNOx93ZbKq64/B6/Z1gW0+quFKremjRSKVCy664=;
        b=QXs7c4Z5n/TJ9frAFuk9VmxebokU5ETsFl5AbzrjodejXmcFRQMrBS0V9pu73yzij2
         W3/CxTp/MSHcrGz8HOer+bLAfg7WRmPgw2R33wAEWS5JP1KbaCGkclJOXmgN3Zb6cXyq
         8vZ83w+CTVavNIiOh+cK+bdyVB+eOtnT/klr6tYXkDoBpAccejUAITuHnJpOqRNld1F3
         K7380/xIVTU4yugNwxs56/+H6crYol8PVJBCYHLXp+3cbYARswUF8UUpiSw09iQKPOlk
         8yuzDCHK2V2ZqAxHVYMQJOx0o1fdLeP/4sul5IrwYbv74Ulj8X5lNybayPKCsu7Lz7XO
         Buvw==
X-Gm-Message-State: ANhLgQ1B5oJA1eloo76uEK6/3KfCSM6lGJbXD2v5wk6cJcGG6pw7v2DA
        wdwHT8x5TBjTokH9yRIES7VrbSCR+zZCuOiQ3Rk=
X-Google-Smtp-Source: ADFU+vuaZB2YqdQTSwwXNJGT/DzeIMoI6zgsU2pirhzQONlQGEuJaSY7zIUne4g6UI8NM14HSloKXFs1XHhWX101AEo=
X-Received: by 2002:a5d:56c9:: with SMTP id m9mr5082680wrw.289.1584635297101;
 Thu, 19 Mar 2020 09:28:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200319131221.14044-1-david@redhat.com> <20200319131221.14044-2-david@redhat.com>
In-Reply-To: <20200319131221.14044-2-david@redhat.com>
From:   Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Date:   Thu, 19 Mar 2020 17:28:05 +0100
Message-ID: <CAM9Jb+gD9YWgio5Nod577iH9=HHf8jZFspVHstQ7cyCWzE2PKQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/8] drivers/base/memory: rename MMOP_ONLINE_KEEP to MMOP_ONLINE
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linuxppc-dev@lists.ozlabs.org, linux-hyperv@vger.kernel.org,
        Wei Yang <richard.weiyang@gmail.com>,
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

> The name is misleading and it's not really clear what is "kept". Let's just
> name it like the online_type name we expose to user space ("online").
>
> Add some documentation to the types.
>
> Reviewed-by: Wei Yang <richard.weiyang@gmail.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Baoquan He <bhe@redhat.com>
> Cc: Wei Yang <richard.weiyang@gmail.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  drivers/base/memory.c          | 9 +++++----
>  include/linux/memory_hotplug.h | 6 +++++-
>  2 files changed, 10 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/base/memory.c b/drivers/base/memory.c
> index 6448c9ece2cb..8c5ce42c0fc3 100644
> --- a/drivers/base/memory.c
> +++ b/drivers/base/memory.c
> @@ -216,7 +216,7 @@ static int memory_subsys_online(struct device *dev)
>          * attribute and need to set the online_type.
>          */
>         if (mem->online_type < 0)
> -               mem->online_type = MMOP_ONLINE_KEEP;
> +               mem->online_type = MMOP_ONLINE;
>
>         ret = memory_block_change_state(mem, MEM_ONLINE, MEM_OFFLINE);
>
> @@ -251,7 +251,7 @@ static ssize_t state_store(struct device *dev, struct device_attribute *attr,
>         else if (sysfs_streq(buf, "online_movable"))
>                 online_type = MMOP_ONLINE_MOVABLE;
>         else if (sysfs_streq(buf, "online"))
> -               online_type = MMOP_ONLINE_KEEP;
> +               online_type = MMOP_ONLINE;
>         else if (sysfs_streq(buf, "offline"))
>                 online_type = MMOP_OFFLINE;
>         else {
> @@ -262,7 +262,7 @@ static ssize_t state_store(struct device *dev, struct device_attribute *attr,
>         switch (online_type) {
>         case MMOP_ONLINE_KERNEL:
>         case MMOP_ONLINE_MOVABLE:
> -       case MMOP_ONLINE_KEEP:
> +       case MMOP_ONLINE:
>                 /* mem->online_type is protected by device_hotplug_lock */
>                 mem->online_type = online_type;
>                 ret = device_online(&mem->dev);
> @@ -342,7 +342,8 @@ static ssize_t valid_zones_show(struct device *dev,
>         }
>
>         nid = mem->nid;
> -       default_zone = zone_for_pfn_range(MMOP_ONLINE_KEEP, nid, start_pfn, nr_pages);
> +       default_zone = zone_for_pfn_range(MMOP_ONLINE, nid, start_pfn,
> +                                         nr_pages);
>         strcat(buf, default_zone->name);
>
>         print_allowed_zone(buf, nid, start_pfn, nr_pages, MMOP_ONLINE_KERNEL,
> diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
> index 3195d11876ea..3aaf00db224c 100644
> --- a/include/linux/memory_hotplug.h
> +++ b/include/linux/memory_hotplug.h
> @@ -47,9 +47,13 @@ enum {
>
>  /* Types for control the zone type of onlined and offlined memory */
>  enum {
> +       /* Offline the memory. */
>         MMOP_OFFLINE = -1,
> -       MMOP_ONLINE_KEEP,
> +       /* Online the memory. Zone depends, see default_zone_for_pfn(). */
> +       MMOP_ONLINE,
> +       /* Online the memory to ZONE_NORMAL. */
>         MMOP_ONLINE_KERNEL,
> +       /* Online the memory to ZONE_MOVABLE. */
>         MMOP_ONLINE_MOVABLE,
>  };
>
> --
Looks good to me.

Acked-by: Pankaj Gupta <pankaj.gupta.linux@gmail.com>

> 2.24.1
>
>
