Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 670B418BCA9
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2020 17:33:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727222AbgCSQdX (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 19 Mar 2020 12:33:23 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39422 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727212AbgCSQdW (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 19 Mar 2020 12:33:22 -0400
Received: by mail-wm1-f66.google.com with SMTP id a9so21967wmj.4;
        Thu, 19 Mar 2020 09:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EV0H/xHTVbYqHl2SwE3LQu0p/ZfnWJaxt/btO6HNCKc=;
        b=RJtNiJ3k6sAQDNVAqFF3d2CVXcvwFgvzjPC0w+H5R7gWQps28vhYZy7GgZRM06MHya
         QQToYt3EjmXhucEHTTvjR2hIFJxawkijfrEt8iN8LtDMLt+j6AwONiJSxTULhlCNicK/
         +2o07B+kQGc/5U0zBOnKomsAAPEA1SyHhbaxhsqSEVcs2J5aIsAF/b3hnElTY5l/yVGY
         FW3tBOTVHWiCiVxbKsIH2UfwuUwtau3dd3Z0YMgmaG/L4gaSLfteA3UF0aZQWm1E4kin
         XVSYSvYkEtok8vrKTtSzm+rcUV6j7CmguoLOaJTsGftxMjOZcOw2ChsJlGdiHRtOWKFj
         C8UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EV0H/xHTVbYqHl2SwE3LQu0p/ZfnWJaxt/btO6HNCKc=;
        b=lKI/QxGzvatFFAhOb4U4RjWMyDpNyiUB6Njz+fmfzclSzo20MHjNOlCxBlI4mOiFCD
         iTOc1eS/I0rvjB3H4FifA+GCp538C7dGCb7/s2NfA4t6DsFwq91l4Miv8RV8eO3G/Ghr
         GDtlm9CuzRJRhcfXwl0FKfCraPUGqf0emnbeQnY+RKVCU5Xwy72t35QJzYKnWrvMGEq8
         zwxryCN/xWAHV9rorIg4/ezjyKOY/MgGZclZUMtkZgvWTchJaPyKdDpRno4LbGcygszl
         qH652o39ksNFGY2rty7IbKtyzHhkhQGH0kcV/4sYdSJVBiv/hYjvv5TY14sBEFfYUKB4
         YlpA==
X-Gm-Message-State: ANhLgQ2Fk0G1OvTm20nv4hTg1sw4YWGc+t6kRUQQE1A6JndtyR14e7b0
        1L8MF2zwHWcsk4FQCMSZSou1vDoZGroh6Y9DrR0=
X-Google-Smtp-Source: ADFU+vumPc/wa4n9qWnBfWoVelrKk4kAGib5WSrNdiwqlrFqLF1BlylJKsfGJ5rFJXKaGKbYD3+R/QLpQgtoSmTw7E4=
X-Received: by 2002:a1c:1fc7:: with SMTP id f190mr4567359wmf.2.1584635599696;
 Thu, 19 Mar 2020 09:33:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200319131221.14044-1-david@redhat.com> <20200319131221.14044-4-david@redhat.com>
In-Reply-To: <20200319131221.14044-4-david@redhat.com>
From:   Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Date:   Thu, 19 Mar 2020 17:33:08 +0100
Message-ID: <CAM9Jb+i-idWyxCX1vPow3VPGBbqTQEAbzLio0vn1QLHrpGJSSg@mail.gmail.com>
Subject: Re: [PATCH v3 3/8] drivers/base/memory: store mapping between MMOP_*
 and string in an array
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

> Let's use a simple array which we can reuse soon. While at it, move the
> string->mmop conversion out of the device hotplug lock.
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
>  drivers/base/memory.c | 38 +++++++++++++++++++++++---------------
>  1 file changed, 23 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/base/memory.c b/drivers/base/memory.c
> index e7e77cafef80..8a7f29c0bf97 100644
> --- a/drivers/base/memory.c
> +++ b/drivers/base/memory.c
> @@ -28,6 +28,24 @@
>
>  #define MEMORY_CLASS_NAME      "memory"
>
> +static const char *const online_type_to_str[] = {
> +       [MMOP_OFFLINE] = "offline",
> +       [MMOP_ONLINE] = "online",
> +       [MMOP_ONLINE_KERNEL] = "online_kernel",
> +       [MMOP_ONLINE_MOVABLE] = "online_movable",
> +};
> +
> +static int memhp_online_type_from_str(const char *str)
> +{
> +       int i;
> +
> +       for (i = 0; i < ARRAY_SIZE(online_type_to_str); i++) {
> +               if (sysfs_streq(str, online_type_to_str[i]))
> +                       return i;
> +       }
> +       return -EINVAL;
> +}
> +
>  #define to_memory_block(dev) container_of(dev, struct memory_block, dev)
>
>  static int sections_per_block;
> @@ -236,26 +254,17 @@ static int memory_subsys_offline(struct device *dev)
>  static ssize_t state_store(struct device *dev, struct device_attribute *attr,
>                            const char *buf, size_t count)
>  {
> +       const int online_type = memhp_online_type_from_str(buf);
>         struct memory_block *mem = to_memory_block(dev);
> -       int ret, online_type;
> +       int ret;
> +
> +       if (online_type < 0)
> +               return -EINVAL;
>
>         ret = lock_device_hotplug_sysfs();
>         if (ret)
>                 return ret;
>
> -       if (sysfs_streq(buf, "online_kernel"))
> -               online_type = MMOP_ONLINE_KERNEL;
> -       else if (sysfs_streq(buf, "online_movable"))
> -               online_type = MMOP_ONLINE_MOVABLE;
> -       else if (sysfs_streq(buf, "online"))
> -               online_type = MMOP_ONLINE;
> -       else if (sysfs_streq(buf, "offline"))
> -               online_type = MMOP_OFFLINE;
> -       else {
> -               ret = -EINVAL;
> -               goto err;
> -       }
> -
>         switch (online_type) {
>         case MMOP_ONLINE_KERNEL:
>         case MMOP_ONLINE_MOVABLE:
> @@ -271,7 +280,6 @@ static ssize_t state_store(struct device *dev, struct device_attribute *attr,
>                 ret = -EINVAL; /* should never happen */
>         }
>
> -err:
>         unlock_device_hotplug();
>
>         if (ret < 0)
> --

Nice cleanup patch.
Acked-by: Pankaj Gupta <pankaj.gupta.linux@gmail.com>

> 2.24.1
>
>
