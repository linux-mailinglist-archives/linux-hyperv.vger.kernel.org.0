Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA43118BC9E
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2020 17:32:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727675AbgCSQ36 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 19 Mar 2020 12:29:58 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41825 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727222AbgCSQ36 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 19 Mar 2020 12:29:58 -0400
Received: by mail-wr1-f67.google.com with SMTP id h9so3861034wrc.8;
        Thu, 19 Mar 2020 09:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dUjkv/1kdxAPc8FvGXSwJvqVlpdlMdd7sScfjZuLtXU=;
        b=KOuV7mgfPxa5BS7QM1EmpVKHl+utg3R1NuD+eghOx5tCnKmaPuHRVXjvk7ETGC7+IH
         pWrSjx5ZFJvHZf44R+FxNhYQeCT5QW+rQ4hPqVWEYiBB13CMSgH3RlgZseLHIeM1bG2l
         1obkvh3OhbRF8Mk7ezjkpUNYtcONq6/QkjHI3j/LQhbXuFNPvr+ozb6qq6d7/OoORL65
         flbWD6QSUtjzo8zmFjsywEco3MosobFFfwQQ/QEi9RDyxPZkUizLDlfsgEoBkxyn28FZ
         T+rxTDp7rTvNrrva4WA9EN5sBtyDWyGY0mu7exVkkA3+j062YpuZVJfNb//An6i8J7Dg
         Q10w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dUjkv/1kdxAPc8FvGXSwJvqVlpdlMdd7sScfjZuLtXU=;
        b=mb3uXV8MHRlmY9fKmY3YGk3cp92PK7ShiWGBBnZzAb5E6VpUW5JaBD68jyvPRFgP5G
         HikdmtNbV4a0kWuZf8QVGbJqStnVnD23UjePVC+bFqLzOgj9AHm1UWXTR/Rmc/tNeHpz
         u6TCqIIleuOpEoWx31JKK0vE2cEuY/8KHm6pxNx+ItASME3UBNo8Ii4Pk7BcR/NR5J9m
         QuKWQvnH7AFqucjW507fi8U+HtRarAZxi2rvIeduiP24aMmn+xn4J5qSGD6ubR1e6apW
         Z0H2AhZRTFoo8AARps2lNQIZdZPW1eSmG0fDIdMK+6OwUrRwPmGyd+G9AM4BDpZ8z7TC
         6caQ==
X-Gm-Message-State: ANhLgQ0ClMCYQG+YuoioJnu0IvdwV4gpKeR3v2oYMZrJ1lUJhlLXVaqX
        tLUTjP4ZK8nu1PcwaVjUw0HJd0o9poKprYDSV3o=
X-Google-Smtp-Source: ADFU+vvErlZUbjGMAWaIpw3qbv9beB1N3R3kHK0bJH6Z7AaZmsMVBHwa/EoutXRVLGkwpqQKNDNT9RewnuF5ANVC4ms=
X-Received: by 2002:a5d:6146:: with SMTP id y6mr5298504wrt.107.1584635395363;
 Thu, 19 Mar 2020 09:29:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200319131221.14044-1-david@redhat.com> <20200319131221.14044-3-david@redhat.com>
In-Reply-To: <20200319131221.14044-3-david@redhat.com>
From:   Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Date:   Thu, 19 Mar 2020 17:29:44 +0100
Message-ID: <CAM9Jb+heQ+Z_Hx5F-0vGLWfc4gxQRzh7am-gw+gGTJxn-7kyZA@mail.gmail.com>
Subject: Re: [PATCH v3 2/8] drivers/base/memory: map MMOP_OFFLINE to 0
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

> Historically, we used the value -1. Just treat 0 as the special
> case now. Clarify a comment (which was wrong, when we come via
> device_online() the first time, the online_type would have been 0 /
> MEM_ONLINE). The default is now always MMOP_OFFLINE. This removes the
> last user of the manual "-1", which didn't use the enum value.
>
> This is a preparation to use the online_type as an array index.
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
>  drivers/base/memory.c          | 11 ++++-------
>  include/linux/memory_hotplug.h |  2 +-
>  2 files changed, 5 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/base/memory.c b/drivers/base/memory.c
> index 8c5ce42c0fc3..e7e77cafef80 100644
> --- a/drivers/base/memory.c
> +++ b/drivers/base/memory.c
> @@ -211,17 +211,14 @@ static int memory_subsys_online(struct device *dev)
>                 return 0;
>
>         /*
> -        * If we are called from state_store(), online_type will be
> -        * set >= 0 Otherwise we were called from the device online
> -        * attribute and need to set the online_type.
> +        * When called via device_online() without configuring the online_type,
> +        * we want to default to MMOP_ONLINE.
>          */
> -       if (mem->online_type < 0)
> +       if (mem->online_type == MMOP_OFFLINE)
>                 mem->online_type = MMOP_ONLINE;
>
>         ret = memory_block_change_state(mem, MEM_ONLINE, MEM_OFFLINE);
> -
> -       /* clear online_type */
> -       mem->online_type = -1;
> +       mem->online_type = MMOP_OFFLINE;
>
>         return ret;
>  }
> diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
> index 3aaf00db224c..76f3c617a8ab 100644
> --- a/include/linux/memory_hotplug.h
> +++ b/include/linux/memory_hotplug.h
> @@ -48,7 +48,7 @@ enum {
>  /* Types for control the zone type of onlined and offlined memory */
>  enum {
>         /* Offline the memory. */
> -       MMOP_OFFLINE = -1,
> +       MMOP_OFFLINE = 0,
>         /* Online the memory. Zone depends, see default_zone_for_pfn(). */
>         MMOP_ONLINE,
>         /* Online the memory to ZONE_NORMAL. */
> --
> 2.24.1

Looks good to me.
Acked-by: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
>
>
