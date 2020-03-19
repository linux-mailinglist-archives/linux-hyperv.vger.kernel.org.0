Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E9F4518BDD3
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2020 18:19:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727700AbgCSRTs (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 19 Mar 2020 13:19:48 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46272 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727112AbgCSRTs (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 19 Mar 2020 13:19:48 -0400
Received: by mail-wr1-f66.google.com with SMTP id j17so682429wru.13;
        Thu, 19 Mar 2020 10:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=REUrjEbM9E8U0Xs3ZYSD9f/6CBam6/RPzkS7LqotySY=;
        b=BM0AGY3urbibzhW1gohveGfBaMwlf1jLS7cxM3Vfon/hOn4zTW073R3eyT9eOcUhKY
         1EUT6cd63hcggxA627cjejHKeGXbdUjQtC8xqJv6f4jLr2haccGtNev9syzT4f5LWANF
         tA0pUu2GRDS7/jWWJEwWZzOcmSuyMlIthrCT2arIGb4KWhX+IGBdcxSubifbUCr27E8b
         DAU2G3/VxwINBRs8n3NDbrwxG2TToq0uyZQ5TznKJd1cnXz/pKfBgoM3v4zdDj5wLW3+
         vHg+hTD8s1ZY94S23UEy4yWxht3QcGogmEwIVrO9DqCmf3jVslGl/YH6YwOQlrceSbiJ
         sVAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=REUrjEbM9E8U0Xs3ZYSD9f/6CBam6/RPzkS7LqotySY=;
        b=WGnAIOBNoAkRtZnPz7YkQqv8oU24m3IBs4fixVHq72mpo+69kz0EbUiKfuCVKnR7vK
         tyvzK6EtUsmal/KrjC3ljb7G0Z/YE+xy2z6vq3U+zwQDhr3qnX4Q2q0/R0aCRS8tPcYA
         ZtwW05+LJ6TQ5Oswy8u5cSM3+yPOLCGNGSgsr6LU4o/So1oCjRdJd04/4YEQyIiPPW9e
         j05euwUtLZEJlE+FKbsoEcLUCzjlW1oWTYXZnpNgRiKnhUbAiGCnKtQht0wnq+7siVKf
         S19JdHZVuiTpVy9rUVhYpP9M0EVrONc19lM9M/cyaFeLf5xfFVgXTS/2mf2VCe49Dsco
         1WvQ==
X-Gm-Message-State: ANhLgQ1fhRZVDkr1bENht0UxXDHORiLgQkqp2TBHfC2KsKy6I9/wrYEp
        r/MBrhKed5h3RwsDCIwx659p0ZKeTKAZEsl9Xs0=
X-Google-Smtp-Source: ADFU+vtt4K7LLALZ400ntXCMXvpvEPIEVS4JD+piZAo5Bk7qwIuVxT+6bOMnViCSjX8yovQFCVEAetBlkIy5tk1qVrQ=
X-Received: by 2002:a5d:6146:: with SMTP id y6mr5562155wrt.107.1584638384613;
 Thu, 19 Mar 2020 10:19:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200319131221.14044-1-david@redhat.com> <20200319131221.14044-8-david@redhat.com>
In-Reply-To: <20200319131221.14044-8-david@redhat.com>
From:   Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Date:   Thu, 19 Mar 2020 18:19:33 +0100
Message-ID: <CAM9Jb+hBVihQ=TSPoL_WL1tPRnfXTUw=dUw0oGGQkPWWs6gSxw@mail.gmail.com>
Subject: Re: [PATCH v3 7/8] mm/memory_hotplug: convert memhp_auto_online to
 store an online_type
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

> ... and rename it to memhp_default_online_type. This is a preparation
> for more detailed default online behavior.
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
>  drivers/base/memory.c          | 10 ++++------
>  include/linux/memory_hotplug.h |  3 ++-
>  mm/memory_hotplug.c            | 11 ++++++-----
>  3 files changed, 12 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/base/memory.c b/drivers/base/memory.c
> index 8a7f29c0bf97..8d3e16dab69f 100644
> --- a/drivers/base/memory.c
> +++ b/drivers/base/memory.c
> @@ -386,10 +386,8 @@ static DEVICE_ATTR_RO(block_size_bytes);
>  static ssize_t auto_online_blocks_show(struct device *dev,
>                                        struct device_attribute *attr, char *buf)
>  {
> -       if (memhp_auto_online)
> -               return sprintf(buf, "online\n");
> -       else
> -               return sprintf(buf, "offline\n");
> +       return sprintf(buf, "%s\n",
> +                      online_type_to_str[memhp_default_online_type]);
>  }
>
>  static ssize_t auto_online_blocks_store(struct device *dev,
> @@ -397,9 +395,9 @@ static ssize_t auto_online_blocks_store(struct device *dev,
>                                         const char *buf, size_t count)
>  {
>         if (sysfs_streq(buf, "online"))
> -               memhp_auto_online = true;
> +               memhp_default_online_type = MMOP_ONLINE;
>         else if (sysfs_streq(buf, "offline"))
> -               memhp_auto_online = false;
> +               memhp_default_online_type = MMOP_OFFLINE;
>         else
>                 return -EINVAL;
>
> diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
> index 76f3c617a8ab..6d6f85bb66e9 100644
> --- a/include/linux/memory_hotplug.h
> +++ b/include/linux/memory_hotplug.h
> @@ -118,7 +118,8 @@ extern int arch_add_memory(int nid, u64 start, u64 size,
>                            struct mhp_params *params);
>  extern u64 max_mem_size;
>
> -extern bool memhp_auto_online;
> +/* Default online_type (MMOP_*) when new memory blocks are added. */
> +extern int memhp_default_online_type;
>  /* If movable_node boot option specified */
>  extern bool movable_node_enabled;
>  static inline bool movable_node_is_enabled(void)
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index e21a7d53ade5..4efcf8cb9ac5 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -67,17 +67,17 @@ void put_online_mems(void)
>  bool movable_node_enabled = false;
>
>  #ifndef CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE
> -bool memhp_auto_online;
> +int memhp_default_online_type = MMOP_OFFLINE;
>  #else
> -bool memhp_auto_online = true;
> +int memhp_default_online_type = MMOP_ONLINE;
>  #endif
>
>  static int __init setup_memhp_default_state(char *str)
>  {
>         if (!strcmp(str, "online"))
> -               memhp_auto_online = true;
> +               memhp_default_online_type = MMOP_ONLINE;
>         else if (!strcmp(str, "offline"))
> -               memhp_auto_online = false;
> +               memhp_default_online_type = MMOP_OFFLINE;
>
>         return 1;
>  }
> @@ -993,6 +993,7 @@ static int check_hotplug_memory_range(u64 start, u64 size)
>
>  static int online_memory_block(struct memory_block *mem, void *arg)
>  {
> +       mem->online_type = memhp_default_online_type;
>         return device_online(&mem->dev);
>  }
>
> @@ -1065,7 +1066,7 @@ int __ref add_memory_resource(int nid, struct resource *res)
>         mem_hotplug_done();
>
>         /* online pages if requested */
> -       if (memhp_auto_online)
> +       if (memhp_default_online_type != MMOP_OFFLINE)
>                 walk_memory_blocks(start, size, NULL, online_memory_block);
>
>         return ret;
> --

Acked-by: Pankaj Gupta <pankaj.gupta.linux@gmail.com>

> 2.24.1
>
>
