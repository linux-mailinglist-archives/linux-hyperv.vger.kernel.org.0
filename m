Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EFC351881CA
	for <lists+linux-hyperv@lfdr.de>; Tue, 17 Mar 2020 12:20:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727761AbgCQLB2 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 17 Mar 2020 07:01:28 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:56170 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727744AbgCQLB1 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 17 Mar 2020 07:01:27 -0400
Received: by mail-wm1-f65.google.com with SMTP id 6so20924639wmi.5;
        Tue, 17 Mar 2020 04:01:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6EipgQFVgo/huvY/O4SRrQWe8XDQ0DAlFK59sTbjBUo=;
        b=UMgwvZOK6Yhf7MtEGLksGmsJ/NVy2HBt7vJOxZmwF+R42WeysBU1X7iAstYnkO+gNp
         vXmUtVgvGDY4ejXNwL3JuYhDrxw56FHDP6b02uGpbMa6MPh7DHPUAK4ZrRWAwesHERjr
         UjgT3MUddEg9+PeZboCl2tl/Heau008Q7KZF89m7fMCApbNNUA8pciNNSjATKOTCwD45
         89Izqo95G/uYs1BffI130Ky1qMqnXti56VAEXh/l9ha+83KLBuC9uhu/EBlFh3BJZwz/
         mQf6tSKDTw14i14oKGJwzdwaIvfPUDLhJcxLUUv/88rKy6GFKEXaV1eLOdJaJNot34g+
         d0qg==
X-Gm-Message-State: ANhLgQ0bOgjQZh1hQSyrN4tYvWrQ4Vx3zmHjDuQdU4NcvYslG5tPJS2E
        afJONlc6MCvWiZF8UCL20fU=
X-Google-Smtp-Source: ADFU+vsC8Dzy9TGXCGl36ggWufL9wQJFd8vsUJbzPnDHv7C0memWXP80yZxYnWH2b4rw1DPH/xRZdA==
X-Received: by 2002:a1c:23d5:: with SMTP id j204mr4961015wmj.59.1584442884527;
        Tue, 17 Mar 2020 04:01:24 -0700 (PDT)
Received: from localhost (ip-37-188-255-121.eurotel.cz. [37.188.255.121])
        by smtp.gmail.com with ESMTPSA id k3sm3879311wro.59.2020.03.17.04.01.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2020 04:01:23 -0700 (PDT)
Date:   Tue, 17 Mar 2020 12:01:21 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linuxppc-dev@lists.ozlabs.org, linux-hyperv@vger.kernel.org,
        Wei Yang <richard.weiyang@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH v2 8/8] mm/memory_hotplug: allow to specify a default
 online_type
Message-ID: <20200317110121.GN26018@dhcp22.suse.cz>
References: <20200317104942.11178-1-david@redhat.com>
 <20200317104942.11178-9-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200317104942.11178-9-david@redhat.com>
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue 17-03-20 11:49:42, David Hildenbrand wrote:
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
> hotplugging it, which can result in strange OOM situations. This waiting
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
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Baoquan He <bhe@redhat.com>
> Cc: Wei Yang <richard.weiyang@gmail.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

As I've said earlier and several times already, I really dislike this
interface. But it is fact that this patch doesn't make it any worse.
Quite contrary, so feel free to add
Acked-by: Michal Hocko <mhocko@suse.com>

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
> index 1975a2b99a2b..9916977b6ee1 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -74,10 +74,10 @@ int memhp_default_online_type = MMOP_ONLINE;
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
> -- 
> 2.24.1

-- 
Michal Hocko
SUSE Labs
