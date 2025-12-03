Return-Path: <linux-hyperv+bounces-7927-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B44F3CA0DA8
	for <lists+linux-hyperv@lfdr.de>; Wed, 03 Dec 2025 19:15:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CAF143011AB4
	for <lists+linux-hyperv@lfdr.de>; Wed,  3 Dec 2025 18:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6A602848A0;
	Wed,  3 Dec 2025 18:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="HeZaJ7Ag"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4EC6DF6C;
	Wed,  3 Dec 2025 18:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764785636; cv=none; b=fk8omPjpERtMI5fXiE+T1xTUGrr/K26XHj7p8Z8wVfOYNaqSg2T0PL1+ic2KCQw+6LHTXcXJBHT5nhq2Vp3/S78NTdSTr5mCJD4IUmbF5IOTzmnIi0GnMUDvMlor+d6+6TMEPpkV6qljC5eTXoND3pCSV6iARAbjJxiYN1v0zk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764785636; c=relaxed/simple;
	bh=AzdqzNqoTfcOQBbBjDHzowzMsnxZCawY4zGWe2O5BIY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=omRnivglAoEoPDVPkkSco6WR/gH/bZ1K/OkLpJirC7Cz2vq/vk8/gycWNzGKUrVrRWZaDNTMQTslIBAQ3PUjCqYVYFNlLhpRcSDlBFxoUEQsQdWc57sYESL6LIeQ6z3m3hpGV8TGwGU0PiK7qbjmKiTH/SJTC32S9h3GhRZGhrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=HeZaJ7Ag; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.64.201.124] (unknown [52.148.138.235])
	by linux.microsoft.com (Postfix) with ESMTPSA id DF7F92120E85;
	Wed,  3 Dec 2025 10:13:53 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com DF7F92120E85
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1764785634;
	bh=Inp1ooCyF7EOuDv5vmdXW4AxhPsB7uAKYBCS5zOGWCg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=HeZaJ7AgJMS2WvLwIH89OjO/hrUbnBTOlRbJbEMVYTAYwuvidRdTlUQTnKn8W61SV
	 k11DOnWJ4w19nEspqF07jJRU6IjtgClGQzaBvkF1FmXH/ISadt7XkmJtiWdG4aUfBa
	 4Y+E74bMQlqWOHU0Fjz6ZtSd1mVQRlZbvrhPn06s=
Message-ID: <9c614ef4-6c97-4a9c-b33a-e989e3de2c85@linux.microsoft.com>
Date: Wed, 3 Dec 2025 10:13:52 -0800
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 3/7] Drivers: hv: Move region management to
 mshv_regions.c
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
 kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
References: <176412196000.447063.4256335030026363827.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <176412294544.447063.14863746685758881018.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
Content-Language: en-US
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
In-Reply-To: <176412294544.447063.14863746685758881018.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/25/2025 6:09 PM, Stanislav Kinsburskii wrote:
> Refactor memory region management functions from mshv_root_main.c into
> mshv_regions.c for better modularity and code organization.
> 
> Adjust function calls and headers to use the new implementation. Improve
> maintainability and separation of concerns in the mshv_root module.
> 
> Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
> ---
>  drivers/hv/Makefile         |    2 
>  drivers/hv/mshv_regions.c   |  175 +++++++++++++++++++++++++++++++++++++++++++
>  drivers/hv/mshv_root.h      |   10 ++
>  drivers/hv/mshv_root_main.c |  176 +++----------------------------------------
>  4 files changed, 198 insertions(+), 165 deletions(-)
>  create mode 100644 drivers/hv/mshv_regions.c
> 
> diff --git a/drivers/hv/Makefile b/drivers/hv/Makefile
> index 58b8d07639f3..46d4f4f1b252 100644
> --- a/drivers/hv/Makefile
> +++ b/drivers/hv/Makefile
> @@ -14,7 +14,7 @@ hv_vmbus-y := vmbus_drv.o \
>  hv_vmbus-$(CONFIG_HYPERV_TESTING)	+= hv_debugfs.o
>  hv_utils-y := hv_util.o hv_kvp.o hv_snapshot.o hv_utils_transport.o
>  mshv_root-y := mshv_root_main.o mshv_synic.o mshv_eventfd.o mshv_irq.o \
> -	       mshv_root_hv_call.o mshv_portid_table.o
> +	       mshv_root_hv_call.o mshv_portid_table.o mshv_regions.o
>  mshv_vtl-y := mshv_vtl_main.o
>  
>  # Code that must be built-in
> diff --git a/drivers/hv/mshv_regions.c b/drivers/hv/mshv_regions.c
> new file mode 100644
> index 000000000000..35b866670840
> --- /dev/null
> +++ b/drivers/hv/mshv_regions.c
> @@ -0,0 +1,175 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2025, Microsoft Corporation.
> + *
> + * Memory region management for mshv_root module.
> + *
> + * Authors: Microsoft Linux virtualization team
> + */
> +
> +#include <linux/mm.h>
> +#include <linux/vmalloc.h>
> +
> +#include <asm/mshyperv.h>
> +
> +#include "mshv_root.h"
> +
> +struct mshv_mem_region *mshv_region_create(u64 guest_pfn, u64 nr_pages,
> +					   u64 uaddr, u32 flags,

nit: we use 'flags' here to mean MSHV_SET_MEM flags, but below in
mshv_region_share/unshare() we use it to mean HV_MAP_GPA flags.

Renaming 'flags' to 'mshv_flags' here could improve the clarity.

> +					   bool is_mmio)
> +{
> +	struct mshv_mem_region *region;
> +
> +	region = vzalloc(sizeof(*region) + sizeof(struct page *) * nr_pages);
> +	if (!region)
> +		return ERR_PTR(-ENOMEM);
> +
> +	region->nr_pages = nr_pages;
> +	region->start_gfn = guest_pfn;
> +	region->start_uaddr = uaddr;
> +	region->hv_map_flags = HV_MAP_GPA_READABLE | HV_MAP_GPA_ADJUSTABLE;
> +	if (flags & BIT(MSHV_SET_MEM_BIT_WRITABLE))
> +		region->hv_map_flags |= HV_MAP_GPA_WRITABLE;
> +	if (flags & BIT(MSHV_SET_MEM_BIT_EXECUTABLE))
> +		region->hv_map_flags |= HV_MAP_GPA_EXECUTABLE;
> +
> +	/* Note: large_pages flag populated when we pin the pages */
> +	if (!is_mmio)
> +		region->flags.range_pinned = true;
> +
> +	return region;
> +}
> +
> +int mshv_region_share(struct mshv_mem_region *region)
> +{
> +	u32 flags = HV_MODIFY_SPA_PAGE_HOST_ACCESS_MAKE_SHARED;
> +
> +	if (region->flags.large_pages)
> +		flags |= HV_MODIFY_SPA_PAGE_HOST_ACCESS_LARGE_PAGE;
> +
> +	return hv_call_modify_spa_host_access(region->partition->pt_id,
> +			region->pages, region->nr_pages,
> +			HV_MAP_GPA_READABLE | HV_MAP_GPA_WRITABLE,
> +			flags, true);
> +}
> +
> +int mshv_region_unshare(struct mshv_mem_region *region)
> +{
> +	u32 flags = HV_MODIFY_SPA_PAGE_HOST_ACCESS_MAKE_EXCLUSIVE;
> +
> +	if (region->flags.large_pages)
> +		flags |= HV_MODIFY_SPA_PAGE_HOST_ACCESS_LARGE_PAGE;
> +
> +	return hv_call_modify_spa_host_access(region->partition->pt_id,
> +			region->pages, region->nr_pages,
> +			0,
> +			flags, false);
> +}<snip>

Looks fine to me. Fixing the nit is optional.

Reviewed-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>

