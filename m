Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC5D8181E77
	for <lists+linux-hyperv@lfdr.de>; Wed, 11 Mar 2020 17:56:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730247AbgCKQz4 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 11 Mar 2020 12:55:56 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:50357 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730019AbgCKQzz (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 11 Mar 2020 12:55:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583945754;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HSgjM26zIX3PavBkrCBluq3yJAmMXPt5zdmFUceEPUk=;
        b=a7WHphIs2iyqNmAWxX2m13PXrUahHxgzcm4LkO+93c2zN719y8osdOdtqhujLwsXEVd9LI
        Dn5zo2oSHaywbLQUYB4hPixoPjKnwYJLafucvh6WHubfOT/r26wZpmPUqe7KnDp3od4cLp
        0FJVUxXF2IO3ZaEDJJXZ94uINwuO0JU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-285-G-UMHpPYNiSCK-Y1jgWK6g-1; Wed, 11 Mar 2020 12:55:52 -0400
X-MC-Unique: G-UMHpPYNiSCK-Y1jgWK6g-1
Received: by mail-wm1-f70.google.com with SMTP id x7so866692wmi.4
        for <linux-hyperv@vger.kernel.org>; Wed, 11 Mar 2020 09:55:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=HSgjM26zIX3PavBkrCBluq3yJAmMXPt5zdmFUceEPUk=;
        b=eQLOF4UPyVF8nW60grnwXYCWw0E1bHgW2vlKdHz9Hw2cXJ4MUgNqscEGq27aOzfVMZ
         poWtoXCNZ2zYwLH+EbuIblduUp6c5qu+pFSuqqWRvM0IXrrJCfuXXc8LP7FxE1GwHr+M
         jEcuVbXb2QFRrq71ZTu3bE1QGEaHYZD1N7Er9VF0MlgGnQmWfQqFcy4JpnOkorQgvSrP
         gXei3BJQtoS2DVOFYlkMfzJCq+YAB3IraAGJDm5G6HyxsEAfmKIUXhuGQQHAtQimSzar
         g/LarAjo4B9xZ2yif+sdWG3bouz6ZbM8UMzr2EcrF0jGb0xHhxxWPUiwGQ28/jSk6itY
         GrcA==
X-Gm-Message-State: ANhLgQ3oZwBnZHKRoKKVpGORJM2WuDbLq0nJZLYl3Lkv+h48D2BJ/Mbk
        3GFQBDs0qs68WbpgOPbjnsIs/PGjMKncR20VjhFV3Qhj20C3qzDrDN6PxciOBVWTmQYzdugtbfl
        /liPw+s6P07Jw0eZpojLj84Sq
X-Received: by 2002:a5d:63c7:: with SMTP id c7mr5326989wrw.384.1583945751468;
        Wed, 11 Mar 2020 09:55:51 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vsW35ore7Qm3vjEYXtbIoqC8m+BW/xNy5Vy9kjOPP+WoiYbSKW84175pQgJX/okAmoW7A9FTg==
X-Received: by 2002:a5d:63c7:: with SMTP id c7mr5326967wrw.384.1583945751193;
        Wed, 11 Mar 2020 09:55:51 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id p10sm7252926wru.4.2020.03.11.09.55.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2020 09:55:49 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
        linux-hyperv@vger.kernel.org, David Hildenbrand <david@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Baoquan He <bhe@redhat.com>,
        Wei Yang <richard.weiyang@gmail.com>
Subject: Re: [PATCH v1 5/5] mm/memory_hotplug: allow to specify a default online_type
In-Reply-To: <20200311123026.16071-6-david@redhat.com>
References: <20200311123026.16071-1-david@redhat.com> <20200311123026.16071-6-david@redhat.com>
Date:   Wed, 11 Mar 2020 17:55:48 +0100
Message-ID: <877dzqsuej.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

David Hildenbrand <david@redhat.com> writes:

> For now, distributions implement advanced udev rules to essentially
> - Don't online any hotplugged memory (s390x)
> - Online all memory to ZONE_NORMAL (e.g., most virt environments like
>   hyperv)
> - Online all memory to ZONE_MOVABLE in case the zone imbalance is taken
>   care of (e.g., bare metal, special virt environments)
>
> In summary: All memory is usually onlined the same way, however, the
> kernel always has to ask userspace to come up with the same answer.
> E.g., HyperV always waits for a memory block to get onlined before
> continuing, otherwise it might end up adding memory faster than
> hotplugging it, which can result in strange OOM situations.
>
> Let's allow to specify a default online_type, not just "online" and
> "offline". This allows distributions to configure the default online_type
> when booting up and be done with it.
>
> We can now specify "offline", "online", "online_movable" and
> "online_kernel" via
> - "memhp_default_state=" on the kernel cmdline
> - /sys/devices/systemn/memory/auto_online_blocks
> just like we are able to specify for a single memory block via
> /sys/devices/systemn/memory/memoryX/state
>

Thank you for picking this up! 

It's been awhile since I've added CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE
but I vaguely recall one problem: memory hotplug may happen *very* early
(just because some memory is presented to a VM as hotplug memory, it is
not in e820). It happens way before we launch userspace (including
udev). The question is -- which ZONE will this memory be assigned too?

'memhp_default_state=' resolves the issue but nobody likes additional
kernel parameters for anything but
debug. CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE was supposed to help, but it
is binary and distro-wide (so *all* deployments will get the same
default and as you validly stated we want it differently).

We could've added something like your example onlining script to the
kernel itself but this is likely going to be hard to sell: "policies
belong to userspace!" will likely be the answer. 

So if we don't want to start the endless discussions (again), your
proposal is 'good enough'.


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
>  	[MMOP_ONLINE_MOVABLE] = "online_movable",
>  };
>  
> -static int memhp_online_type_from_str(const char *str)
> +int memhp_online_type_from_str(const char *str)
>  {
>  	int i;
>  
> @@ -394,13 +394,12 @@ static ssize_t auto_online_blocks_store(struct device *dev,
>  					struct device_attribute *attr,
>  					const char *buf, size_t count)
>  {
> -	if (sysfs_streq(buf, "online"))
> -		memhp_default_online_type = MMOP_ONLINE;
> -	else if (sysfs_streq(buf, "offline"))
> -		memhp_default_online_type = MMOP_OFFLINE;
> -	else
> +	const int online_type = memhp_online_type_from_str(buf);
> +
> +	if (online_type < 0)
>  		return -EINVAL;
>  
> +	memhp_default_online_type = online_type;
>  	return count;
>  }
>  
> diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
> index c6e090b34c4b..ef55115320fb 100644
> --- a/include/linux/memory_hotplug.h
> +++ b/include/linux/memory_hotplug.h
> @@ -117,6 +117,8 @@ extern int arch_add_memory(int nid, u64 start, u64 size,
>  			struct mhp_restrictions *restrictions);
>  extern u64 max_mem_size;
>  
> +extern int memhp_online_type_from_str(const char *str);
> +
>  /* Default online_type (MMOP_*) when new memory blocks are added. */
>  extern int memhp_default_online_type;
>  /* If movable_node boot option specified */
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 01443c70aa27..4a96273eafa7 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -75,10 +75,10 @@ EXPORT_SYMBOL_GPL(memhp_default_online_type);
>  
>  static int __init setup_memhp_default_state(char *str)
>  {
> -	if (!strcmp(str, "online"))
> -		memhp_default_online_type = MMOP_ONLINE;
> -	else if (!strcmp(str, "offline"))
> -		memhp_default_online_type = MMOP_OFFLINE;
> +	const int online_type = memhp_online_type_from_str(str);
> +
> +	if (online_type >= 0)
> +		memhp_default_online_type = online_type;
>  
>  	return 1;
>  }

-- 
Vitaly

