Return-Path: <linux-hyperv+bounces-10223-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oLTyHKhU5mkDuwEAu9opvQ
	(envelope-from <linux-hyperv+bounces-10223-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 20 Apr 2026 18:30:32 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id DC1D242F8F4
	for <lists+linux-hyperv@lfdr.de>; Mon, 20 Apr 2026 18:30:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CE12E300645E
	for <lists+linux-hyperv@lfdr.de>; Mon, 20 Apr 2026 16:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2B0A346781;
	Mon, 20 Apr 2026 16:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="IhXlIkaS"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BECF2E2665;
	Mon, 20 Apr 2026 16:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776702271; cv=none; b=DT1p3aVeux6cSrUCoLYt4wXpEnzSFJNIblzmvxP9JyCMW6gswmA4k+0IPIv3oXWFTtrqFkiy0O/V3UXa6vjgBy2xh2QcADFaIIkQd3bkCd3LZOWes85XE5wbNgjy9Sbx6YvdHpfQgcP+ilxLgcRIDm7Ezxxt+p9egnx9Yer0zCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776702271; c=relaxed/simple;
	bh=Y9jrj7Gmk/LBMx6IIoGsKAe03wWQQgcJyYRFe3Ib2Ds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m/DfcW1cV6ajHkUFQ6kwwyc6uO/ayA0y23ahOfT8JG/9LA3pkVihLCkDg2styILfbkm6ISMGAOx/93BKM4SC6ppDd1QfTVQq+SsU3LeoS/Ppg9YLcPGRf8lxgEcHqUDD7KxCkITP9yEDKrojSfT5q7Bl/pV3LxwyMC9bnB5LRN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=IhXlIkaS; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii.localdomain (unknown [20.236.10.129])
	by linux.microsoft.com (Postfix) with ESMTPSA id D4D3D20B6F01;
	Mon, 20 Apr 2026 09:24:29 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D4D3D20B6F01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1776702270;
	bh=RKd9Zup8xlg/o3bwRvBbnKQ7/1IfJ8gwuMTmCYy4qFI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IhXlIkaSdY7PojjcYmka3RjdR1lP/5t0GL5r2WabOdzkDkJaRdurG69Rgt1epfMy+
	 5UufFdIcW86NEn6BJWOGs7EnjFfcssJKTN0lkLFyhFvuKFoSW5+IPoVmIvIdhJ2ltQ
	 HgFKQO0vlHWS5CWfk9HeIvuKFdSJvt/6w0ljUSF8=
Date: Mon, 20 Apr 2026 09:24:26 -0700
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: Michael Kelley <mhklinux@outlook.com>
Cc: "kys@microsoft.com" <kys@microsoft.com>,
	"haiyangz@microsoft.com" <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>,
	"longli@microsoft.com" <longli@microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/7] mshv: Add support to address range holes remapping
Message-ID: <aeZTOj0htus0eoF1@skinsburskii.localdomain>
References: <177490099488.81669.3758562641675983608.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <177490106397.81669.13650500489059864399.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <SN6PR02MB4157D44B15BAA0F3CA8B078BD4242@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR02MB4157D44B15BAA0F3CA8B078BD4242@SN6PR02MB4157.namprd02.prod.outlook.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10223-lists,linux-hyperv=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[outlook.com];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skinsburskii@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[skinsburskii.localdomain:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linux.microsoft.com:dkim]
X-Rspamd-Queue-Id: DC1D242F8F4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 13, 2026 at 09:08:31PM +0000, Michael Kelley wrote:
> From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com> Sent: Monday, March 30, 2026 1:04 PM
> > 
> > Consolidate memory region processing to handle both valid and invalid PFNs
> > uniformly. This eliminates code duplication across remap, unmap, share, and
> > unshare operations by using a common range processing interface.
> > 
> > Holes are now remapped with no-access permissions to enable
> > hypervisor dirty page tracking for precopy live migration.
> > 
> > This refactoring is a precursor to an upcoming change that will map
> > present pages in movable regions upon region creation, requiring
> > consistent handling of both mapped and unmapped ranges.
> > 
> > Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
> > ---
> >  drivers/hv/mshv_regions.c |  108
> > ++++++++++++++++++++++++++++++++++++++++-----
> >  1 file changed, 95 insertions(+), 13 deletions(-)
> > 
> > diff --git a/drivers/hv/mshv_regions.c b/drivers/hv/mshv_regions.c
> > index b1a707d16c07..ed9c55841140 100644
> > --- a/drivers/hv/mshv_regions.c
> > +++ b/drivers/hv/mshv_regions.c
> > @@ -119,6 +119,57 @@ static long mshv_region_process_pfns(struct mshv_mem_region *region,
> >  	return count;
> >  }
> > 
> > +/**
> > + * mshv_region_process_hole - Handle a hole (invalid PFNs) in a memory
> > + *                            region
> > + * @region    : Memory region containing the hole
> > + * @flags     : Flags to pass to the handler function
> > + * @pfn_offset: Starting PFN offset within the region
> > + * @pfn_count : Number of PFNs in the hole
> > + * @handler   : Callback function to invoke for the hole
> > + *
> > + * Invokes the handler function for a contiguous hole with the specified
> > + * parameters.
> > + *
> > + * Return: Number of PFNs handled, or negative error code.
> > + */
> > +static long mshv_region_process_hole(struct mshv_mem_region *region,
> > +				     u32 flags,
> > +				     u64 pfn_offset, u64 pfn_count,
> > +				     int (*handler)(struct mshv_mem_region *region,
> > +						    u32 flags,
> > +						    u64 pfn_offset,
> > +						    u64 pfn_count,
> > +						    bool huge_page))
> > +{
> > +	long ret;
> > +
> > +	ret = handler(region, flags, pfn_offset, pfn_count, 0);
> > +	if (ret)
> > +		return ret;
> > +
> > +	return pfn_count;
> > +}
> > +
> > +static long mshv_region_process_chunk(struct mshv_mem_region *region,
> > +				      u32 flags,
> > +				      u64 pfn_offset, u64 pfn_count,
> > +				      int (*handler)(struct mshv_mem_region *region,
> > +						     u32 flags,
> > +						     u64 pfn_offset,
> > +						     u64 pfn_count,
> > +						     bool huge_page))
> > +{
> > +	if (pfn_valid(region->mreg_pfns[pfn_offset]))
> > +		return mshv_region_process_pfns(region, flags,
> > +				pfn_offset, pfn_count,
> > +				handler);
> > +	else
> > +		return mshv_region_process_hole(region, flags,
> > +				pfn_offset, pfn_count,
> > +				handler);
> > +}
> > +
> >  /**
> >   * mshv_region_process_range - Processes a range of PFNs in a region.
> >   * @region    : Pointer to the memory region structure.
> > @@ -146,33 +197,47 @@ static int mshv_region_process_range(struct mshv_mem_region *region,
> >  						    u64 pfn_count,
> >  						    bool huge_page))
> >  {
> > -	u64 pfn_end;
> > +	u64 start, end;
> >  	long ret;
> > 
> > -	if (check_add_overflow(pfn_offset, pfn_count, &pfn_end))
> > +	if (!pfn_count)
> > +		return 0;
> > +
> > +	if (check_add_overflow(pfn_offset, pfn_count, &end))
> >  		return -EOVERFLOW;
> > 
> > -	if (pfn_end > region->nr_pfns)
> > +	if (end > region->nr_pfns)
> >  		return -EINVAL;
> > 
> > -	while (pfn_count) {
> > -		/* Skip non-present pages */
> > -		if (!pfn_valid(region->mreg_pfns[pfn_offset])) {
> > -			pfn_offset++;
> > -			pfn_count--;
> > +	start = pfn_offset;
> > +	end = pfn_offset + 1;
> > +
> > +	while (end < pfn_offset + pfn_count) {
> > +		/*
> > +		 * Accumulate contiguous pfns with the same validity
> > +		 * (valid or not).
> > +		 */
> > +		if (pfn_valid(region->mreg_pfns[start]) ==
> > +		    pfn_valid(region->mreg_pfns[end])) {
> > +			end++;
> >  			continue;
> >  		}
> > 
> > -		ret = mshv_region_process_pfns(region, flags,
> > -					       pfn_offset, pfn_count,
> > -					       handler);
> > +		ret = mshv_region_process_chunk(region, flags,
> > +						start, end - start,
> > +						handler);
> >  		if (ret < 0)
> >  			return ret;
> > 
> > -		pfn_offset += ret;
> > -		pfn_count -= ret;
> > +		start += ret;
> >  	}
> > 
> > +	ret = mshv_region_process_chunk(region, flags,
> > +					start, end - start,
> > +					handler);
> > +	if (ret < 0)
> > +		return ret;
> > +
> >  	return 0;
> >  }
> > 
> > @@ -208,6 +273,9 @@ static int mshv_region_chunk_share(struct mshv_mem_region *region,
> >  				   u64 pfn_offset, u64 pfn_count,
> >  				   bool huge_page)
> >  {
> > +	if (!pfn_valid(region->mreg_pfns[pfn_offset]))
> > +		return -EINVAL;
> > +
> >  	if (huge_page)
> >  		flags |= HV_MODIFY_SPA_PAGE_HOST_ACCESS_LARGE_PAGE;
> > 
> > @@ -233,6 +301,9 @@ static int mshv_region_chunk_unshare(struct mshv_mem_region *region,
> >  				     u64 pfn_offset, u64 pfn_count,
> >  				     bool huge_page)
> >  {
> > +	if (!pfn_valid(region->mreg_pfns[pfn_offset]))
> > +		return -EINVAL;
> > +
> >  	if (huge_page)
> >  		flags |= HV_MODIFY_SPA_PAGE_HOST_ACCESS_LARGE_PAGE;
> > 
> > @@ -256,6 +327,14 @@ static int mshv_region_chunk_remap(struct mshv_mem_region *region,
> >  				   u64 pfn_offset, u64 pfn_count,
> >  				   bool huge_page)
> >  {
> > +	/*
> > +	 * Remap missing pages with no access to let the
> > +	 * hypervisor track dirty pages, enabling precopy live
> > +	 * migration.
> > +	 */
> > +	if (!pfn_valid(region->mreg_pfns[pfn_offset]))
> > +		flags = HV_MAP_GPA_NO_ACCESS;
> 
> Is it OK to wipe out any other flags that might be set? Certainly, any previous
> flags in PERMISSIONS_MASK should be removed, but what about ADJUSTABLE
> and NOT_CACHED?
> 

Yes, this is the right approach. The HV_MAP_GPA_NO_ACCESS flag will
immediately cause a hypervisor fault on any access to the page. So
caching and adjustability no longer matter.

Thanks,
Stanislav

> > +
> >  	if (huge_page)
> >  		flags |= HV_MAP_GPA_LARGE_PAGE;
> > 
> > @@ -357,6 +436,9 @@ static int mshv_region_chunk_unmap(struct mshv_mem_region *region,
> >  				   u64 pfn_offset, u64 pfn_count,
> >  				   bool huge_page)
> >  {
> > +	if (!pfn_valid(region->mreg_pfns[pfn_offset]))
> > +		return 0;
> > +
> >  	if (huge_page)
> >  		flags |= HV_UNMAP_GPA_LARGE_PAGE;
> > 
> > 
> > 
> 

