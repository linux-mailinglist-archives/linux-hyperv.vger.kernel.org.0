Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BAE811881DC
	for <lists+linux-hyperv@lfdr.de>; Tue, 17 Mar 2020 12:21:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726596AbgCQLUm (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 17 Mar 2020 07:20:42 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54188 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726646AbgCQLAP (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 17 Mar 2020 07:00:15 -0400
Received: by mail-wm1-f65.google.com with SMTP id 25so20933492wmk.3;
        Tue, 17 Mar 2020 04:00:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jWcJuEe3U9iMDhxO+2CXuqWIpMY9yFcTi8XiUgDM1I8=;
        b=E0CMV1glGIMs5K0mqYFj509p/+aOlQAzBjGlDBzgMDb6u+qDaFy5Yv2atOgSwSmVFz
         qAEQeu5/tLWjMSoh7yMvQMdk7SB20IlZha4XmGzQamjbxdYwXKs2mqddhziRx+ySUbOg
         TvnF0DrtdI0VaM4VohpP2O2Byjyrdnjpdo2SYtTRkZPU3D03snMgdABxJ0ceZTAcYwjI
         UU+y5gBAT6/SF9sZq9dWcuf8X+JjKqo0lJlEyKJWmf4zUBmO2ERxPunGKwczQzMe3z5m
         ZUkUD7H8bAR6gbk0y2utiwqaJYy1Cr2hsFr+fTgFB1JQkLhdIbgBNgv3F+UJNGbYiHAR
         z1JA==
X-Gm-Message-State: ANhLgQ3JtUlk0qCjz7+QpeIZh9g1A0rBCZtPUhcCox/AvfSCBk6dVdph
        7mwnq7b+4At+ocpnoXWAtek=
X-Google-Smtp-Source: ADFU+vurlY+mODK/ZSQ71xbWFObBOQrd3zMlYKfL9CGb58VdPo7Qxzu/8cGJz+tLu2RaaePI01swrQ==
X-Received: by 2002:a7b:c308:: with SMTP id k8mr4955640wmj.40.1584442812916;
        Tue, 17 Mar 2020 04:00:12 -0700 (PDT)
Received: from localhost (ip-37-188-255-121.eurotel.cz. [37.188.255.121])
        by smtp.gmail.com with ESMTPSA id a7sm28263785wmb.0.2020.03.17.04.00.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2020 04:00:11 -0700 (PDT)
Date:   Tue, 17 Mar 2020 12:00:10 +0100
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
Subject: Re: [PATCH v2 7/8] mm/memory_hotplug: convert memhp_auto_online to
 store an online_type
Message-ID: <20200317110010.GM26018@dhcp22.suse.cz>
References: <20200317104942.11178-1-david@redhat.com>
 <20200317104942.11178-8-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200317104942.11178-8-david@redhat.com>
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue 17-03-20 11:49:41, David Hildenbrand wrote:
> ... and rename it to memhp_default_online_type. This is a preparation
> for more detailed default online behavior.
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

Acked-by: Michal Hocko <mhocko@suse.com>

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
>  				       struct device_attribute *attr, char *buf)
>  {
> -	if (memhp_auto_online)
> -		return sprintf(buf, "online\n");
> -	else
> -		return sprintf(buf, "offline\n");
> +	return sprintf(buf, "%s\n",
> +		       online_type_to_str[memhp_default_online_type]);
>  }
>  
>  static ssize_t auto_online_blocks_store(struct device *dev,
> @@ -397,9 +395,9 @@ static ssize_t auto_online_blocks_store(struct device *dev,
>  					const char *buf, size_t count)
>  {
>  	if (sysfs_streq(buf, "online"))
> -		memhp_auto_online = true;
> +		memhp_default_online_type = MMOP_ONLINE;
>  	else if (sysfs_streq(buf, "offline"))
> -		memhp_auto_online = false;
> +		memhp_default_online_type = MMOP_OFFLINE;
>  	else
>  		return -EINVAL;
>  
> diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
> index c2e06ed5e0e9..c6e090b34c4b 100644
> --- a/include/linux/memory_hotplug.h
> +++ b/include/linux/memory_hotplug.h
> @@ -117,7 +117,8 @@ extern int arch_add_memory(int nid, u64 start, u64 size,
>  			struct mhp_restrictions *restrictions);
>  extern u64 max_mem_size;
>  
> -extern bool memhp_auto_online;
> +/* Default online_type (MMOP_*) when new memory blocks are added. */
> +extern int memhp_default_online_type;
>  /* If movable_node boot option specified */
>  extern bool movable_node_enabled;
>  static inline bool movable_node_is_enabled(void)
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 2d2aae830b92..1975a2b99a2b 100644
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
>  	if (!strcmp(str, "online"))
> -		memhp_auto_online = true;
> +		memhp_default_online_type = MMOP_ONLINE;
>  	else if (!strcmp(str, "offline"))
> -		memhp_auto_online = false;
> +		memhp_default_online_type = MMOP_OFFLINE;
>  
>  	return 1;
>  }
> @@ -990,6 +990,7 @@ static int check_hotplug_memory_range(u64 start, u64 size)
>  
>  static int online_memory_block(struct memory_block *mem, void *arg)
>  {
> +	mem->online_type = memhp_default_online_type;
>  	return device_online(&mem->dev);
>  }
>  
> @@ -1062,7 +1063,7 @@ int __ref add_memory_resource(int nid, struct resource *res)
>  	mem_hotplug_done();
>  
>  	/* online pages if requested */
> -	if (memhp_auto_online)
> +	if (memhp_default_online_type != MMOP_OFFLINE)
>  		walk_memory_blocks(start, size, NULL, online_memory_block);
>  
>  	return ret;
> -- 
> 2.24.1

-- 
Michal Hocko
SUSE Labs
