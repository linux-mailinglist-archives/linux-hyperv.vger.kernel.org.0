Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B88F6186E9A
	for <lists+linux-hyperv@lfdr.de>; Mon, 16 Mar 2020 16:31:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731658AbgCPPbg (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 16 Mar 2020 11:31:36 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38205 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731673AbgCPPbf (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 16 Mar 2020 11:31:35 -0400
Received: by mail-wm1-f68.google.com with SMTP id t13so12216712wmi.3;
        Mon, 16 Mar 2020 08:31:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2enG6C5+gvMUBNCdTFQ/fIEu52PBtZwHWzc4db6XZpQ=;
        b=PE/1Ec067z4TYf1lZVIfs9XhuC4WBBsSz3kTSaM9Zv9+E9xcMsidmIkEgHcPyk4aaJ
         ylLLomjTmlBfIL92aRaritvzfBnWEUc87JRuSF6axdTTtChjGy6T8HRojJ/Y4vEbkqI2
         cI2yw2CpODFx6Lp0IptU9W8AbwPdSoGGJF2/Tjjtlym2CXaekYeVgOfA8IyrHgHcPHJD
         5bY6UpgFTZXRAtlfXcf/r9FonrWUdbwjgzJDvVDTt2oiPch8w+am6HdJsF5lELZNGZNb
         OLuG858sj1NEgfr71E70fZ2SOVb9xzDGHbgWpO5bt1OxpCRLngkhXhanrnryZUC4CMHL
         dY+g==
X-Gm-Message-State: ANhLgQ3q9WnVum1ZnInYJ+SVPzC3PSsC1JeIxUbhGzx/vjMseYCC3zzE
        yGfTjyEvx5NqMuU+0X5rnVA=
X-Google-Smtp-Source: ADFU+vvbB2Au5sNpIKfd6SgHcAn8IC+EDtW12OQN9jVlc5ApS3fGOjrBFNIuPUEGD0eSFUwGgVqj/g==
X-Received: by 2002:a1c:7901:: with SMTP id l1mr28381812wme.188.1584372693830;
        Mon, 16 Mar 2020 08:31:33 -0700 (PDT)
Received: from localhost ([37.188.132.163])
        by smtp.gmail.com with ESMTPSA id h15sm320797wrw.97.2020.03.16.08.31.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2020 08:31:33 -0700 (PDT)
Date:   Mon, 16 Mar 2020 16:31:31 +0100
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
Subject: Re: [PATCH v1 5/5] mm/memory_hotplug: allow to specify a default
 online_type
Message-ID: <20200316153131.GW11482@dhcp22.suse.cz>
References: <20200311123026.16071-1-david@redhat.com>
 <20200311123026.16071-6-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200311123026.16071-6-david@redhat.com>
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed 11-03-20 13:30:26, David Hildenbrand wrote:
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

I still strongly believe that the whole interface is wrong. This is just
adding more lipstick on the pig. On the other hand I recognize that the
event based onlining is a PITA as well. The proper interface would
somehow communicate the type of the memory via the event or other sysfs
attribute and then the FW/HV could tell that this is an offline memory,
hotplugable memory or just an additional memory that doesn't need to
support hotremove by the consumer. The userspace or the kernel could
handle the hotadd request much more easier that way.

> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Baoquan He <bhe@redhat.com>
> Cc: Wei Yang <richard.weiyang@gmail.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

That being said, I will not object to this patch. I simply gave up
fighting this interface. So if it works for consumers and it doesn't
break the existing userspace (which is shouldn't AFAICS) then go ahead.

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
> -- 
> 2.24.1

-- 
Michal Hocko
SUSE Labs
