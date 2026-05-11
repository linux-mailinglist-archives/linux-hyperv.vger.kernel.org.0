Return-Path: <linux-hyperv+bounces-10753-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ULouA930AWoFmwEAu9opvQ
	(envelope-from <linux-hyperv+bounces-10753-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 11 May 2026 17:25:17 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A11975111D0
	for <lists+linux-hyperv@lfdr.de>; Mon, 11 May 2026 17:25:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CF6FB3092A5F
	for <lists+linux-hyperv@lfdr.de>; Mon, 11 May 2026 15:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 728B140244B;
	Mon, 11 May 2026 15:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="AV1rVHfm"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2436740243B;
	Mon, 11 May 2026 15:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778512373; cv=none; b=itNzC371aIkCmMnReKx6Jw6+njaO1wJcM63YZOJou+09TOOAHqUdQ2aByLBijmaH+ylkhEzjpv37RdsOngTK7yyOqubnmUfaZnQJfbbbrcREETj7mEsANmtMIyywzM0i7755WfRs06YTH42XQk85Nfpkdx1jSxYvIfCIY66G5cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778512373; c=relaxed/simple;
	bh=T4t4EiPEeAX+9ArpqKT/R4R/NZA163GIGVrf4gp91fk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YhCvbR2DNwlmWETJHXOI5GqgcAEdboPO2LqvEISvHesoDcmho0kG48WvbL0pE6MAl5By+SVG9bBz4N9c5xg2LGbQ3oGrZShilvAICNEGujdoOL+tb6oMqEjGYqsLGlI1+PlubGhS5FLnOQW0DlKsvxBjZ0zG8dYZUf8h4AYV4vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=AV1rVHfm; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii.localdomain (c-98-225-44-182.hsd1.wa.comcast.net [98.225.44.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id C9B2320B7166;
	Mon, 11 May 2026 08:12:49 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C9B2320B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1778512370;
	bh=NsicUKKNfTPpbZ1cpGJvifAuNnk8DiphxlMCS1ywlnY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AV1rVHfmj7cLUTq2NjrcOaT6fQhuH2fv7N1tVVwjgNlWmHR8eTUF37WBgMvr47hZF
	 iLgXw0JETBBjtKE6pJtim6MaXtFOBPDWgX+mtQKRwJvKTLt9HnMzE3j6c4wzqUmomd
	 eewdlrTLCNyido5slwY0/N/Gxs4CLVwbFOkmIUXI=
Date: Mon, 11 May 2026 08:12:49 -0700
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: Anirudh Rayabharam <anirudh@anirudhrb.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, longli@microsoft.com,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 02/18] mshv: Fix mshv_prepare_pinned_region error path
 for unencrypted partitions
Message-ID: <agHx8f16I5qMOOHk@skinsburskii.localdomain>
References: <177816592843.21765.4364464279247150355.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <177816858991.21765.2088226987194959542.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <20260511-ancient-naughty-bat-f58c2c@anirudhrb>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260511-ancient-naughty-bat-f58c2c@anirudhrb>
X-Rspamd-Queue-Id: A11975111D0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10753-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skinsburskii@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.microsoft.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Mon, May 11, 2026 at 01:48:56PM +0000, Anirudh Rayabharam wrote:
> On Thu, May 07, 2026 at 03:43:09PM +0000, Stanislav Kinsburskii wrote:
> > mshv_prepare_pinned_region() returns 0 (success) when mshv_region_map()
> > fails on an unencrypted partition. The condition on the error path:
> > 
> >     if (ret && mshv_partition_encrypted(partition))
> > 
> > only handles map failures for encrypted partitions — if the partition is
> > not encrypted and the map fails, execution falls through to 'return 0',
> > silently ignoring the error.
> > 
> > Additionally, calling mshv_region_invalidate() inline on map failure
> > zeroes the mreg_pages array before the caller's cleanup path
> > (mshv_region_destroy) can call mshv_region_unmap(). Since unmap skips
> > pages where mreg_pages[offset] is NULL, this can leave stale SLAT
> > mappings for partially-mapped pages.
> > 
> > Fix by returning immediately on success and falling through to error
> > return on failure. For unencrypted partitions, the caller's
> > mshv_region_destroy() handles unmap followed by invalidate in the
> > correct order. For encrypted partitions where re-sharing fails, zero
> > the page array without unpinning — the pages are inaccessible to the
> > host and must not be unpinned, but zeroing prevents
> > mshv_region_destroy() from attempting to unpin them.
> 
> mshv_region_destroy() calls mshv_region_invalidate() which calls
> mshv_region_invalidate_pages() which just does:
> 
> 	static void mshv_region_invalidate_pages(struct mshv_mem_region *region,
> 						 u64 page_offset, u64 page_count)
> 	{
> 		if (region->mreg_type == MSHV_REGION_TYPE_MEM_PINNED)
> 			unpin_user_pages(region->mreg_pages + page_offset, page_count);
> 
> 		memset(region->mreg_pages + page_offset, 0,
> 		       page_count * sizeof(struct page *));
> 	}
> 
> It doesn't checked for zeroed pages before unpinning.
> 

unpin_user_pages skips NULL pages.

Thanks,
Stanislav

> > 
> > Fixes: 621191d709b14 ("Drivers: hv: Introduce mshv_root module to expose /dev/mshv to VMMs")
> > Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
> > ---
> >  drivers/hv/mshv_root_main.c |   26 ++++++++++++++++----------
> >  1 file changed, 16 insertions(+), 10 deletions(-)
> > 
> > diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
> > index 665d565899c15..7e4252b6bc65c 100644
> > --- a/drivers/hv/mshv_root_main.c
> > +++ b/drivers/hv/mshv_root_main.c
> > @@ -1360,32 +1360,38 @@ static int mshv_prepare_pinned_region(struct mshv_mem_region *region)
> >  			pt_err(partition,
> >  			       "Failed to unshare memory region (guest_pfn: %llu): %d\n",
> >  			       region->start_gfn, ret);
> > -			goto invalidate_region;
> > +			goto err_out;
> >  		}
> >  	}
> >  
> >  	ret = mshv_region_map(region);
> > -	if (ret && mshv_partition_encrypted(partition)) {
> > +	if (ret)
> > +		goto share_region;
> > +
> > +	return 0;
> > +
> > +share_region:
> > +	if (mshv_partition_encrypted(partition)) {
> >  		int shrc;
> >  
> >  		shrc = mshv_region_share(region);
> >  		if (!shrc)
> > -			goto invalidate_region;
> > +			goto err_out;
> >  
> >  		pt_err(partition,
> >  		       "Failed to share memory region (guest_pfn: %llu): %d\n",
> >  		       region->start_gfn, shrc);
> >  		/*
> > -		 * Don't unpin if marking shared failed because pages are no
> > -		 * longer mapped in the host, ie root, anymore.
> > +		 * Re-sharing failed — the pages remain inaccessible to the
> > +		 * host.  Zero the page array so that mshv_region_destroy()
> > +		 * won't attempt to unpin them (leaking the page references
> > +		 * is intentional; unpinning host-inaccessible pages would be
> > +		 * unsafe).
> >  		 */
> 
> Actually, mshv_region_destroy() also does mshv_region_share(). Maybe we
> can remove it from here altogether. Either way, should this zeroing
> logic be added there too so as not to crash the host by unpinning pages
> that weren't marked shared?
> 
> >From mshv_region_destroy():
> 
> 	if (mshv_partition_encrypted(partition)) {
> 		ret = mshv_region_share(region);
> 		if (ret) {
> 			pt_err(partition,
> 			       "Failed to regain access to memory, unpinning user pages will fail and crash the host error: %d\n",
> 			       ret);
> 			return;
> 		}
> 	}
> 
> Thanks,
> Anirudh.

