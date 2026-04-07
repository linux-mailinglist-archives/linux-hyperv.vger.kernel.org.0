Return-Path: <linux-hyperv+bounces-10048-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kK8dBzUf1Wnr0wcAu9opvQ
	(envelope-from <linux-hyperv+bounces-10048-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 07 Apr 2026 17:13:57 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 708EA3B0BDA
	for <lists+linux-hyperv@lfdr.de>; Tue, 07 Apr 2026 17:13:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BC9DE3032053
	for <lists+linux-hyperv@lfdr.de>; Tue,  7 Apr 2026 15:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD45735BDD5;
	Tue,  7 Apr 2026 15:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="hrCMMVeh"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56E1535B657;
	Tue,  7 Apr 2026 15:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775574446; cv=none; b=kCsFHKBc7uxkGsGc4rg7cCBBqKWzASlzet0hMEFsLMe6D5QGJqNp/3BjQY05K792a8Njs/adLJ5WOS25bdAijhAzF3tYnPZWpbq41U3921xxyK+8W5DM08Kbt5AnORs3mwbXa9u2Mh+if5PBA+n04pNOEK7cYPM1bKnHpIaWWvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775574446; c=relaxed/simple;
	bh=adqjVGRSiOt5mr8e0GXK4w1EZYo7+mxg6ocoPvkhQNs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UeL8IeeC5X4ahzX8odUPPgkK8ytksT3Cf7UNKhlRdqGWlL/vHGNxgANw8Bko/jT0ZNZxxdoIYjg0x7vXhq0Tjfex+IPoKuRSpl8RaLW+SvCBPdaUloPQaZZJkfq99Duhg0C7olBDsc/8H5hHworCBbIVRhSHZrRBZmUFOLxEfuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=hrCMMVeh; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii.localdomain (c-98-225-44-182.hsd1.wa.comcast.net [98.225.44.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id A8E5720B710C;
	Tue,  7 Apr 2026 08:07:24 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A8E5720B710C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1775574444;
	bh=Kgr4kJ1iC8+0ZjVjNW0eGN4fsfYfpwDNw3L26seUPZk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hrCMMVeh53PrRILmZbWzNOlC1cMXTS8wvWR1mC0VrbZXSywIusCCkrECyFQySl7LW
	 sN6Xitn09h++OOWF5OkGyHPxb5cSCqAQDB+/4AV711neGignxjyJh7AVAhOhs2bSKe
	 SOwuFdhjEhm27TUiLKfoYmk9Dzp60xI2wDOKKBDY=
Date: Tue, 7 Apr 2026 08:07:22 -0700
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: Anirudh Rayabharam <anirudh@anirudhrb.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, longli@microsoft.com,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/7] mshv: Optimize memory region mapping operations
Message-ID: <adUdqlgc5B9FrZsk@skinsburskii.localdomain>
References: <177508151446.215674.7844504277869257435.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <177508156646.215674.2229578835484145880.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <20260406-expert-pelican-of-weather-75fda2@anirudhrb>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260406-expert-pelican-of-weather-75fda2@anirudhrb>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10048-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skinsburskii@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,skinsburskii.localdomain:mid]
X-Rspamd-Queue-Id: 708EA3B0BDA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 06, 2026 at 04:57:12PM +0000, Anirudh Rayabharam wrote:
> On Wed, Apr 01, 2026 at 10:12:46PM +0000, Stanislav Kinsburskii wrote:
> > Two specific operations don't require PFN iteration: region unmapping
> > and region remapping with no access. For unmapping, all frames in MSHV
> > memory regions are guaranteed to be mapped with page access, so we can
> > unmap them all without checking individual PFNs. For remapping with no
> > access, all frames are already mapped with page access, allowing us to
> > unmap them all in one pass.
> > 
> > Since neither operation needs PFN validation, iterating over PFNs is
> > redundant. Batch operations into large page-aligned chunks followed by
> > remaining pages. This eliminates PFN traversal for these operations,
> > requires no additional hypercalls compared to the PFN-checking approach,
> > and provides the simplest possible sequential execution path.
> > 
> > The optimization utilizes HV_MAP_GPA_LARGE_PAGE and
> > HV_UNMAP_GPA_LARGE_PAGE flags for aligned portions, processing only the
> > remainder with base page granularity. This removes mshv_region_chunk_unmap()
> > and mshv_region_process_range() helper functions, reducing code complexity.
> > 
> > Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
> > ---
> >  drivers/hv/mshv_regions.c |   65 ++++++++++++++++++++++++++++++++-------------
> >  1 file changed, 46 insertions(+), 19 deletions(-)
> > 
> > diff --git a/drivers/hv/mshv_regions.c b/drivers/hv/mshv_regions.c
> > index 2c4215381e0b..a92381219758 100644
> > --- a/drivers/hv/mshv_regions.c
> > +++ b/drivers/hv/mshv_regions.c
> > @@ -449,27 +449,27 @@ static int mshv_region_pin(struct mshv_region *region)
> >  	return ret < 0 ? ret : -ENOMEM;
> >  }
> >  
> > -static int mshv_region_chunk_unmap(struct mshv_region *region,
> > -				   u32 flags,
> > -				   u64 pfn_offset, u64 pfn_count,
> > -				   bool huge_page)
> > +static int mshv_region_unmap(struct mshv_region *region)
> >  {
> > -	if (!pfn_valid(region->mreg_pfns[pfn_offset]))
> > -		return 0;
> > +	u64 aligned_pages, remaining_pages;
> > +	int ret = 0;
> >  
> > -	if (huge_page)
> > -		flags |= HV_UNMAP_GPA_LARGE_PAGE;
> > +	aligned_pages = ALIGN_DOWN(region->nr_pfns, PTRS_PER_PMD);
> 
> Why is it sufficient to check just the number of pages to determine
> whether we need to use the HV_UNMAP_GPA_LARGE_PAGE? Don't we need to
> check the alignment of the start address as well?
> 

Yeah, I think it's not sufficient.
I'll address this gap.

Thanks,
Stanislav

> Thanks,
> Anirudh.

