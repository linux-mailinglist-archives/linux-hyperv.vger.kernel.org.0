Return-Path: <linux-hyperv+bounces-7928-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 41C36CA136C
	for <lists+linux-hyperv@lfdr.de>; Wed, 03 Dec 2025 20:01:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9F929311BA2C
	for <lists+linux-hyperv@lfdr.de>; Wed,  3 Dec 2025 18:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED95827603F;
	Wed,  3 Dec 2025 18:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="W9stIEM1"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0FBF30F811;
	Wed,  3 Dec 2025 18:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764786029; cv=none; b=PqIjujxW5gwnkt2Q6qMt9tmWdHeslpctTdbBpymwEfFhU7NuXYwR2avwsfVDI2I0G9z9xrXznxRsvXCcdROsRV3t6obzSwyAADr5mIXqE+I3vocIfpt+4uVAPQoVbUE5JkjKtrZWcoWQrWoa0eH1ZIremkOHi4idtx3oJ0/OQrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764786029; c=relaxed/simple;
	bh=DobxeypZ341v5vuYv8VIpt3rjYblS0CFFIH/zVRSA2I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EqgDMbyuEuMBoAVSZVNO6eOavW0OG31fL/8hHZzTYT303yewjbRlMg7h1ZnJcbYcEgQzxdZlsFntQq9lkG83rlj+gcoJNyZ4N9x5kQz7QkV4XjC7Hd9dfiKjEMD+jFZTIJXgRr6OFDLnBLdiCcDffevgAeRyDBXpb6mOAL7vnqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=W9stIEM1; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii.localdomain (unknown [20.236.11.42])
	by linux.microsoft.com (Postfix) with ESMTPSA id 1B0382120E85;
	Wed,  3 Dec 2025 10:20:26 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1B0382120E85
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1764786026;
	bh=O5WxbXJFwhPA2VXwEF2NANaZ70XZkHWJpEcn94YjJE4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W9stIEM1V3PnOAl3bRcNOkICOgcS20U4rV0QOIKfr+3vku2xb1alm6NCOZy8QDkTr
	 CGNmCNTt6HySUe4M99fN1XDzxvTNdzIxF3XPMb1y5hUe9/W1uCFlXYa8nCTQCSo6nW
	 8/V2+TA7o9/KajcQicmZxZcE98uWlvf+NAN6EnIs=
Date: Wed, 3 Dec 2025 10:20:24 -0800
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 3/7] Drivers: hv: Move region management to
 mshv_regions.c
Message-ID: <aTB_aLop91cLCIAT@skinsburskii.localdomain>
References: <176412196000.447063.4256335030026363827.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <176412294544.447063.14863746685758881018.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <9c614ef4-6c97-4a9c-b33a-e989e3de2c85@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9c614ef4-6c97-4a9c-b33a-e989e3de2c85@linux.microsoft.com>

On Wed, Dec 03, 2025 at 10:13:52AM -0800, Nuno Das Neves wrote:
> On 11/25/2025 6:09 PM, Stanislav Kinsburskii wrote:
> > Refactor memory region management functions from mshv_root_main.c into
> > mshv_regions.c for better modularity and code organization.
> > 
> > Adjust function calls and headers to use the new implementation. Improve
> > maintainability and separation of concerns in the mshv_root module.
> > 
> > Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
> > ---
> >  drivers/hv/Makefile         |    2 
> >  drivers/hv/mshv_regions.c   |  175 +++++++++++++++++++++++++++++++++++++++++++
> >  drivers/hv/mshv_root.h      |   10 ++
> >  drivers/hv/mshv_root_main.c |  176 +++----------------------------------------
> >  4 files changed, 198 insertions(+), 165 deletions(-)
> >  create mode 100644 drivers/hv/mshv_regions.c
> > 
> > diff --git a/drivers/hv/Makefile b/drivers/hv/Makefile
> > index 58b8d07639f3..46d4f4f1b252 100644
> > --- a/drivers/hv/Makefile
> > +++ b/drivers/hv/Makefile
> > @@ -14,7 +14,7 @@ hv_vmbus-y := vmbus_drv.o \
> >  hv_vmbus-$(CONFIG_HYPERV_TESTING)	+= hv_debugfs.o
> >  hv_utils-y := hv_util.o hv_kvp.o hv_snapshot.o hv_utils_transport.o
> >  mshv_root-y := mshv_root_main.o mshv_synic.o mshv_eventfd.o mshv_irq.o \
> > -	       mshv_root_hv_call.o mshv_portid_table.o
> > +	       mshv_root_hv_call.o mshv_portid_table.o mshv_regions.o
> >  mshv_vtl-y := mshv_vtl_main.o
> >  
> >  # Code that must be built-in
> > diff --git a/drivers/hv/mshv_regions.c b/drivers/hv/mshv_regions.c
> > new file mode 100644
> > index 000000000000..35b866670840
> > --- /dev/null
> > +++ b/drivers/hv/mshv_regions.c
> > @@ -0,0 +1,175 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Copyright (c) 2025, Microsoft Corporation.
> > + *
> > + * Memory region management for mshv_root module.
> > + *
> > + * Authors: Microsoft Linux virtualization team
> > + */
> > +
> > +#include <linux/mm.h>
> > +#include <linux/vmalloc.h>
> > +
> > +#include <asm/mshyperv.h>
> > +
> > +#include "mshv_root.h"
> > +
> > +struct mshv_mem_region *mshv_region_create(u64 guest_pfn, u64 nr_pages,
> > +					   u64 uaddr, u32 flags,
> 
> nit: we use 'flags' here to mean MSHV_SET_MEM flags, but below in
> mshv_region_share/unshare() we use it to mean HV_MAP_GPA flags.
> 
> Renaming 'flags' to 'mshv_flags' here could improve the clarity.
> 

I'd rather change it in a follow up to reduce rebase churn for the
subsequent changes.

Thanks,
Stanislav

> > +					   bool is_mmio)
> > +{
> > +	struct mshv_mem_region *region;
> > +
> > +	region = vzalloc(sizeof(*region) + sizeof(struct page *) * nr_pages);
> > +	if (!region)
> > +		return ERR_PTR(-ENOMEM);
> > +
> > +	region->nr_pages = nr_pages;
> > +	region->start_gfn = guest_pfn;
> > +	region->start_uaddr = uaddr;
> > +	region->hv_map_flags = HV_MAP_GPA_READABLE | HV_MAP_GPA_ADJUSTABLE;
> > +	if (flags & BIT(MSHV_SET_MEM_BIT_WRITABLE))
> > +		region->hv_map_flags |= HV_MAP_GPA_WRITABLE;
> > +	if (flags & BIT(MSHV_SET_MEM_BIT_EXECUTABLE))
> > +		region->hv_map_flags |= HV_MAP_GPA_EXECUTABLE;
> > +
> > +	/* Note: large_pages flag populated when we pin the pages */
> > +	if (!is_mmio)
> > +		region->flags.range_pinned = true;
> > +
> > +	return region;
> > +}
> > +
> > +int mshv_region_share(struct mshv_mem_region *region)
> > +{
> > +	u32 flags = HV_MODIFY_SPA_PAGE_HOST_ACCESS_MAKE_SHARED;
> > +
> > +	if (region->flags.large_pages)
> > +		flags |= HV_MODIFY_SPA_PAGE_HOST_ACCESS_LARGE_PAGE;
> > +
> > +	return hv_call_modify_spa_host_access(region->partition->pt_id,
> > +			region->pages, region->nr_pages,
> > +			HV_MAP_GPA_READABLE | HV_MAP_GPA_WRITABLE,
> > +			flags, true);
> > +}
> > +
> > +int mshv_region_unshare(struct mshv_mem_region *region)
> > +{
> > +	u32 flags = HV_MODIFY_SPA_PAGE_HOST_ACCESS_MAKE_EXCLUSIVE;
> > +
> > +	if (region->flags.large_pages)
> > +		flags |= HV_MODIFY_SPA_PAGE_HOST_ACCESS_LARGE_PAGE;
> > +
> > +	return hv_call_modify_spa_host_access(region->partition->pt_id,
> > +			region->pages, region->nr_pages,
> > +			0,
> > +			flags, false);
> > +}<snip>
> 
> Looks fine to me. Fixing the nit is optional.
> 
> Reviewed-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>

