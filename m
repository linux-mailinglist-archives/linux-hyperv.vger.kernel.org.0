Return-Path: <linux-hyperv+bounces-7922-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 94803CA11EB
	for <lists+linux-hyperv@lfdr.de>; Wed, 03 Dec 2025 19:44:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6A84B312BCBA
	for <lists+linux-hyperv@lfdr.de>; Wed,  3 Dec 2025 17:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AAD0272E72;
	Wed,  3 Dec 2025 17:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Wnr7nZhU"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8607F2FE051;
	Wed,  3 Dec 2025 17:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764784009; cv=none; b=dX5fvIIMi9TZs5MciBXhjvKkfCIz1iL9qzwxJHu3+HL3ChxlG1vz4vxhK9BhgTrif5QPHzPZVmWSKVKBAmaQSjGon/+eCP8K5bQleh+QrLuW4K0JUvZZmFaMhZVxowioxDtK0h/Flbr+RJlg9DMvxu572JKa7uZ4hi2r2hsvp2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764784009; c=relaxed/simple;
	bh=wgLLPCUGcYy+Ks26+CRr84olGrJifV+9beYJ2oNRNW8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TiY1qk/ooiGk1gta+2TMGVp1RCEhBYbPT57RLRnBENai3Xcqa7Omd5eTkXM5+Ucj9pbYBUjRGzcvUDnMgsJfc9Pe1q4sGPf8c7wkhLnmKdUgVWxKCzQDQksD37F9JnTTFM2ZDTYgs+ERcNuhaYUnYT4yeHaKUq8Cydx/LYlECko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Wnr7nZhU; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii.localdomain (unknown [20.236.11.42])
	by linux.microsoft.com (Postfix) with ESMTPSA id 3B6532120E87;
	Wed,  3 Dec 2025 09:46:46 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3B6532120E87
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1764784006;
	bh=gevfMTJ0Boka641A3Po3emCaiMOL4hsX0Gq/RlAdZ6s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Wnr7nZhUPwSeNDT5yXqNqqxm7qKlglMt1/e6zSiYH3pzizaIqbnKXQmiKVxsCeS/t
	 b4f1DgvbGu8ryvfFR6c/KZEgDk5K+cGnY67iysOnnTtRNRj01kSBvvGZsS0bOcnKjo
	 VSaxUpnX4HUS6yKTpT2Zkixr+CPZGYT3qGzmI790=
Date: Wed, 3 Dec 2025 09:46:44 -0800
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: Michael Kelley <mhklinux@outlook.com>
Cc: "kys@microsoft.com" <kys@microsoft.com>,
	"haiyangz@microsoft.com" <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>,
	Nuno Das Neves <nunodasneves@linux.microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 5/7] Drivers: hv: Improve region overlap detection in
 partition create
Message-ID: <aTB3hJ94SpwEUk_r@skinsburskii.localdomain>
References: <176412196000.447063.4256335030026363827.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <176412295734.447063.5692907557041244468.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <SN6PR02MB41573FF177210DBC95509B09D4D8A@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR02MB41573FF177210DBC95509B09D4D8A@SN6PR02MB4157.namprd02.prod.outlook.com>

On Tue, Dec 02, 2025 at 06:39:51PM +0000, Michael Kelley wrote:
> From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com> Sent: Tuesday, November 25, 2025 6:09 PM
> > 
> > Refactor region overlap check in mshv_partition_create_region to use
> > mshv_partition_region_by_gfn for both start and end guest PFNs, replacing
> > manual iteration.
> > 
> > This is a cleaner approach that leverages existing functionality to
> > accurately detect overlapping memory regions.
> 
> Unfortunately, the cleaner approach doesn't work. :-( It doesn't detect a
> new region request that completely overlaps an existing region.
> 
> See https://lore.kernel.org/linux-hyperv/6a5f4ed5-63ae-4760-84c9-7290aaff8bd1@linux.microsoft.com/T/#ma91254da1900de61da520acb96c0de38c43562f6.
> I couldn't see anything that prevents the scenario. Nuno created this 
> patch less than a month ago: https://lore.kernel.org/linux-hyperv/1762467211-8213-2-git-send-email-nunodasneves@linux.microsoft.com/.
> 
> Michael
> 

I see. 
I'll drop it then.

Thanks,
Stanislav

> > 
> > Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
> > ---
> >  drivers/hv/mshv_root_main.c |    8 ++------
> >  1 file changed, 2 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
> > index 5dfb933da981..ae600b927f49 100644
> > --- a/drivers/hv/mshv_root_main.c
> > +++ b/drivers/hv/mshv_root_main.c
> > @@ -1086,13 +1086,9 @@ static int mshv_partition_create_region(struct
> > mshv_partition *partition,
> >  	u64 nr_pages = HVPFN_DOWN(mem->size);
> > 
> >  	/* Reject overlapping regions */
> > -	hlist_for_each_entry(rg, &partition->pt_mem_regions, hnode) {
> > -		if (mem->guest_pfn + nr_pages <= rg->start_gfn ||
> > -		    rg->start_gfn + rg->nr_pages <= mem->guest_pfn)
> > -			continue;
> > -
> > +	if (mshv_partition_region_by_gfn(partition, mem->guest_pfn) ||
> > +	    mshv_partition_region_by_gfn(partition, mem->guest_pfn + nr_pages - 1))
> >  		return -EEXIST;
> > -	}
> > 
> >  	rg = mshv_region_create(mem->guest_pfn, nr_pages,
> >  				mem->userspace_addr, mem->flags,
> > 
> > 
> 

