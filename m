Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF3823040B0
	for <lists+linux-hyperv@lfdr.de>; Tue, 26 Jan 2021 15:44:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391185AbhAZOmy (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 26 Jan 2021 09:42:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56582 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2391486AbhAZOmo (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 26 Jan 2021 09:42:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611672074;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lpQ5FIdDj86dAJrmmf5VYfY1DlwRO3+NvNwOL07qIDw=;
        b=JzkU8chpbP+ZXG+0y5nz9vxUpObgAOtniyb8uN1FWyLpzhsyn1ssyjN1h0CoYFJ/pr9yf7
        04fqDa2+n9E48fpE68dthH4aeFbbH2jMICehjUIipEmW7C3+5l+Qtha9dANPteQlN5XpDA
        7B1KWv7nE3Ypyr/JfovQf8RA93+DHiY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-79-_DjPlFZpPFWH8XvaI7jMQA-1; Tue, 26 Jan 2021 09:41:10 -0500
X-MC-Unique: _DjPlFZpPFWH8XvaI7jMQA-1
Received: by mail-wr1-f71.google.com with SMTP id w3so5862057wrm.22
        for <linux-hyperv@vger.kernel.org>; Tue, 26 Jan 2021 06:41:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lpQ5FIdDj86dAJrmmf5VYfY1DlwRO3+NvNwOL07qIDw=;
        b=TVOWdqcROr0jQ7BaHaMu4i1oumNR+gasRZolh1vUQlb/RPG++QTQv4PaurklEo0Q43
         Ap9zhtSKB9OCj92IWHy7sO4zO8bk+yvhsa+F/uMlNX3GQQnj+QS0iX79W6PcoNU1Nndj
         ZoklWiTOVoG8xMTF7ouw3e4600mwidaot7A+wUaet5gUqtI+WqukojkAND7qhAhuWU/k
         9x7u0jn3EowWMzwoe/O463Ou1OAFHk5M9iezibvxsMX93EDiSp5r98XssH/ZBot/YtcH
         a4kv2+DB0RSa4YT/qHfROmBORjtxEtJ4TDkecAXR8Jhv4yb2Qm7bfsNusx4Mauyy/Zkt
         w3/w==
X-Gm-Message-State: AOAM532yHB2k0cIm3ryOuZHawZ9BPwguLR6p8l75+RblZQu8LJS0c4Vy
        zRVqm4E3Qfjs1ilZrggZy0DBYZfAopmu7z0XDPBTGraqjCsQI9mEyq1sApn0Gn5QUTpuMUXCuMf
        2OyzM6rbhqKMZHxOX8IYrkH9J
X-Received: by 2002:a5d:4a06:: with SMTP id m6mr6488581wrq.258.1611672069388;
        Tue, 26 Jan 2021 06:41:09 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz39NDd6BmGGfj8bbtVOHXLcl2Kc7EC7CxqUvm9YDLAkU4h3pGT+kzWVgom/wIh//yZaOjzQw==
X-Received: by 2002:a5d:4a06:: with SMTP id m6mr6488565wrq.258.1611672069262;
        Tue, 26 Jan 2021 06:41:09 -0800 (PST)
Received: from redhat.com (bzq-79-177-39-148.red.bezeqint.net. [79.177.39.148])
        by smtp.gmail.com with ESMTPSA id k15sm3578856wmj.6.2021.01.26.06.41.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 06:41:08 -0800 (PST)
Date:   Tue, 26 Jan 2021 09:41:05 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Jason Wang <jasowang@redhat.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        Michal Hocko <mhocko@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        linux-hyperv@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        xen-devel@lists.xenproject.org
Subject: Re: [PATCH v1] mm/memory_hotplug: MEMHP_MERGE_RESOURCE ->
 MHP_MERGE_RESOURCE
Message-ID: <20210126094058-mutt-send-email-mst@kernel.org>
References: <20210126115829.10909-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210126115829.10909-1-david@redhat.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Jan 26, 2021 at 12:58:29PM +0100, David Hildenbrand wrote:
> Let's make "MEMHP_MERGE_RESOURCE" consistent with "MHP_NONE", "mhp_t" and
> "mhp_flags". As discussed recently [1], "mhp" is our internal
> acronym for memory hotplug now.
> 
> [1] https://lore.kernel.org/linux-mm/c37de2d0-28a1-4f7d-f944-cfd7d81c334d@redhat.com/
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: "K. Y. Srinivasan" <kys@microsoft.com>
> Cc: Haiyang Zhang <haiyangz@microsoft.com>
> Cc: Stephen Hemminger <sthemmin@microsoft.com>
> Cc: Wei Liu <wei.liu@kernel.org>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
> Cc: Juergen Gross <jgross@suse.com>
> Cc: Stefano Stabellini <sstabellini@kernel.org>
> Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
> Cc: Wei Yang <richard.weiyang@linux.alibaba.com>
> Cc: linux-hyperv@vger.kernel.org
> Cc: virtualization@lists.linux-foundation.org
> Cc: xen-devel@lists.xenproject.org
> Signed-off-by: David Hildenbrand <david@redhat.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  drivers/hv/hv_balloon.c        | 2 +-
>  drivers/virtio/virtio_mem.c    | 2 +-
>  drivers/xen/balloon.c          | 2 +-
>  include/linux/memory_hotplug.h | 2 +-
>  mm/memory_hotplug.c            | 2 +-
>  5 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/hv/hv_balloon.c b/drivers/hv/hv_balloon.c
> index 8c471823a5af..2f776d78e3c1 100644
> --- a/drivers/hv/hv_balloon.c
> +++ b/drivers/hv/hv_balloon.c
> @@ -726,7 +726,7 @@ static void hv_mem_hot_add(unsigned long start, unsigned long size,
>  
>  		nid = memory_add_physaddr_to_nid(PFN_PHYS(start_pfn));
>  		ret = add_memory(nid, PFN_PHYS((start_pfn)),
> -				(HA_CHUNK << PAGE_SHIFT), MEMHP_MERGE_RESOURCE);
> +				(HA_CHUNK << PAGE_SHIFT), MHP_MERGE_RESOURCE);
>  
>  		if (ret) {
>  			pr_err("hot_add memory failed error is %d\n", ret);
> diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
> index 85a272c9978e..148bea39b09a 100644
> --- a/drivers/virtio/virtio_mem.c
> +++ b/drivers/virtio/virtio_mem.c
> @@ -623,7 +623,7 @@ static int virtio_mem_add_memory(struct virtio_mem *vm, uint64_t addr,
>  	/* Memory might get onlined immediately. */
>  	atomic64_add(size, &vm->offline_size);
>  	rc = add_memory_driver_managed(vm->nid, addr, size, vm->resource_name,
> -				       MEMHP_MERGE_RESOURCE);
> +				       MHP_MERGE_RESOURCE);
>  	if (rc) {
>  		atomic64_sub(size, &vm->offline_size);
>  		dev_warn(&vm->vdev->dev, "adding memory failed: %d\n", rc);
> diff --git a/drivers/xen/balloon.c b/drivers/xen/balloon.c
> index b57b2067ecbf..671c71245a7b 100644
> --- a/drivers/xen/balloon.c
> +++ b/drivers/xen/balloon.c
> @@ -331,7 +331,7 @@ static enum bp_state reserve_additional_memory(void)
>  	mutex_unlock(&balloon_mutex);
>  	/* add_memory_resource() requires the device_hotplug lock */
>  	lock_device_hotplug();
> -	rc = add_memory_resource(nid, resource, MEMHP_MERGE_RESOURCE);
> +	rc = add_memory_resource(nid, resource, MHP_MERGE_RESOURCE);
>  	unlock_device_hotplug();
>  	mutex_lock(&balloon_mutex);
>  
> diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
> index 3d99de0db2dd..4b834f5d032e 100644
> --- a/include/linux/memory_hotplug.h
> +++ b/include/linux/memory_hotplug.h
> @@ -53,7 +53,7 @@ typedef int __bitwise mhp_t;
>   * with this flag set, the resource pointer must no longer be used as it
>   * might be stale, or the resource might have changed.
>   */
> -#define MEMHP_MERGE_RESOURCE	((__force mhp_t)BIT(0))
> +#define MHP_MERGE_RESOURCE	((__force mhp_t)BIT(0))
>  
>  /*
>   * Extended parameters for memory hotplug:
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 710e469fb3a1..ae497e3ff77c 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -1153,7 +1153,7 @@ int __ref add_memory_resource(int nid, struct resource *res, mhp_t mhp_flags)
>  	 * In case we're allowed to merge the resource, flag it and trigger
>  	 * merging now that adding succeeded.
>  	 */
> -	if (mhp_flags & MEMHP_MERGE_RESOURCE)
> +	if (mhp_flags & MHP_MERGE_RESOURCE)
>  		merge_system_ram_resource(res);
>  
>  	/* online pages if requested */
> -- 
> 2.29.2

