Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 212A4186E53
	for <lists+linux-hyperv@lfdr.de>; Mon, 16 Mar 2020 16:12:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731688AbgCPPM3 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 16 Mar 2020 11:12:29 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35169 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729964AbgCPPM3 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 16 Mar 2020 11:12:29 -0400
Received: by mail-wm1-f68.google.com with SMTP id m3so18493922wmi.0;
        Mon, 16 Mar 2020 08:12:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pP29NNx6Ci3tKu2VMQ6svFhSLpTYpkSdhU02iawHkFs=;
        b=Dnwlz34mWXgBWLnFf8OBoTMCCjGEIjnY7+NNYOn65l9S3hkmn81ytzDfT6y9PhntMr
         SFLK54ZKh9T0dnqBCNjg18J/5xXqU6Dutf65o0mA9LJ8tUK/KdKNChq8ouj9QeRcRCbS
         8n501882hm2Sc8eBAPEhX3CMGqQqmzy9vUs4LqvYxBoLveX9Q/FO07l2DJCXPUnEwsHX
         YtQnY5FLBu4kySaj89LiqlrQQbbiwwE21QFOyfe4ybweOkNlHfxnktLSO6qeWRxQYzX+
         4ZUSW3yMfjcdy+eoEC1nCzKPtrjSTvAUJKm5we85MalKwaG0fMwCMGOY7Z8try3A1Y8O
         Iv7g==
X-Gm-Message-State: ANhLgQ0W5UHiRbs/JemC3KLjZLExWn9Qp5gdfhE+bwbL5oyIhngWTDWj
        /0hgMDXn9rQ8ikPfltraVe8=
X-Google-Smtp-Source: ADFU+vu/tvS5V97YVVfKD2ivxmneOufMFO5W9ErMHPP4C5Ju1eQN39CBYRDgFDWYm0T37VQ9dxYtJg==
X-Received: by 2002:a7b:c75a:: with SMTP id w26mr10625158wmk.2.1584371544960;
        Mon, 16 Mar 2020 08:12:24 -0700 (PDT)
Received: from localhost ([37.188.132.163])
        by smtp.gmail.com with ESMTPSA id s15sm347045wrr.45.2020.03.16.08.12.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2020 08:12:24 -0700 (PDT)
Date:   Mon, 16 Mar 2020 16:12:23 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linuxppc-dev@lists.ozlabs.org, linux-hyperv@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Baoquan He <bhe@redhat.com>,
        Wei Yang <richard.weiyang@gmail.com>
Subject: Re: [PATCH v1 1/5] drivers/base/memory: rename MMOP_ONLINE_KEEP to
 MMOP_ONLINE
Message-ID: <20200316151223.GS11482@dhcp22.suse.cz>
References: <20200311123026.16071-1-david@redhat.com>
 <20200311123026.16071-2-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200311123026.16071-2-david@redhat.com>
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed 11-03-20 13:30:22, David Hildenbrand wrote:
> The name is misleading. Let's just name it like the online_type name we
> expose to user space ("online").

I would disagree the name is misleading. It just says that you want to
online and keep the zone type. Nothing I would insist on though.

> Add some documentation to the types.
> 
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
>  	 * attribute and need to set the online_type.
>  	 */
>  	if (mem->online_type < 0)
> -		mem->online_type = MMOP_ONLINE_KEEP;
> +		mem->online_type = MMOP_ONLINE;
>  
>  	ret = memory_block_change_state(mem, MEM_ONLINE, MEM_OFFLINE);
>  
> @@ -251,7 +251,7 @@ static ssize_t state_store(struct device *dev, struct device_attribute *attr,
>  	else if (sysfs_streq(buf, "online_movable"))
>  		online_type = MMOP_ONLINE_MOVABLE;
>  	else if (sysfs_streq(buf, "online"))
> -		online_type = MMOP_ONLINE_KEEP;
> +		online_type = MMOP_ONLINE;
>  	else if (sysfs_streq(buf, "offline"))
>  		online_type = MMOP_OFFLINE;
>  	else {
> @@ -262,7 +262,7 @@ static ssize_t state_store(struct device *dev, struct device_attribute *attr,
>  	switch (online_type) {
>  	case MMOP_ONLINE_KERNEL:
>  	case MMOP_ONLINE_MOVABLE:
> -	case MMOP_ONLINE_KEEP:
> +	case MMOP_ONLINE:
>  		/* mem->online_type is protected by device_hotplug_lock */
>  		mem->online_type = online_type;
>  		ret = device_online(&mem->dev);
> @@ -342,7 +342,8 @@ static ssize_t valid_zones_show(struct device *dev,
>  	}
>  
>  	nid = mem->nid;
> -	default_zone = zone_for_pfn_range(MMOP_ONLINE_KEEP, nid, start_pfn, nr_pages);
> +	default_zone = zone_for_pfn_range(MMOP_ONLINE, nid, start_pfn,
> +					  nr_pages);
>  	strcat(buf, default_zone->name);
>  
>  	print_allowed_zone(buf, nid, start_pfn, nr_pages, MMOP_ONLINE_KERNEL,
> diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
> index f4d59155f3d4..261dbf010d5d 100644
> --- a/include/linux/memory_hotplug.h
> +++ b/include/linux/memory_hotplug.h
> @@ -47,9 +47,13 @@ enum {
>  
>  /* Types for control the zone type of onlined and offlined memory */
>  enum {
> +	/* Offline the memory. */
>  	MMOP_OFFLINE = -1,
> -	MMOP_ONLINE_KEEP,
> +	/* Online the memory. Zone depends, see default_zone_for_pfn(). */
> +	MMOP_ONLINE,
> +	/* Online the memory to ZONE_NORMAL. */
>  	MMOP_ONLINE_KERNEL,
> +	/* Online the memory to ZONE_MOVABLE. */
>  	MMOP_ONLINE_MOVABLE,
>  };
>  
> -- 
> 2.24.1

-- 
Michal Hocko
SUSE Labs
