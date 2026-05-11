Return-Path: <linux-hyperv+bounces-10752-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UM6zD6L3AWqcmwEAu9opvQ
	(envelope-from <linux-hyperv+bounces-10752-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 11 May 2026 17:37:06 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 42F19511512
	for <lists+linux-hyperv@lfdr.de>; Mon, 11 May 2026 17:37:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BCDA130CE91B
	for <lists+linux-hyperv@lfdr.de>; Mon, 11 May 2026 15:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80C7A2DB794;
	Mon, 11 May 2026 15:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="LPHnISh8"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F8962D94BA;
	Mon, 11 May 2026 15:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778512011; cv=none; b=kskj2cnlPLtMLkPLBBxgc5iScucOzeWLRoboT5cJBJgiScWQ4QPRCLJJPCoQmcNOQ/yza2Aaylllm/kPp4kaXgYeuUCHRc5bSpvkdbTK7UGtXOKIbPeyuqp+lcAoH+QCi3oRR/jCwPh6qphQR1sN/L/yYQyoICTCt/E59Ybgehg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778512011; c=relaxed/simple;
	bh=PkEfSYlC4wjB7vxkV0ZeDDNoB0sNMa6LW7dZKgSbhN8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ri9Ql38FQW66Fxeg0+ECl0ff2qJYwm37UKfGgOzM7uqzyg5YauqkHAP3y6sZz2K/3FgGzcPaJGgrZna2LjAf7Mtc3wimbVTgeDbO20Aed4si61vKV85n4MvDFw7XY8CXku7KgRm7ZNuAi8IVzHvAzoSO7k0jYGvXPZlHzKUPX84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=LPHnISh8; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii.localdomain (c-98-225-44-182.hsd1.wa.comcast.net [98.225.44.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id BFACA20B7166;
	Mon, 11 May 2026 08:06:44 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com BFACA20B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1778512004;
	bh=xoxen4et4CHou4F1ZrO6fuz/aWKw4gHF3gw83x0kPQc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LPHnISh8C7QigJMW2ERQomkLAoSNsn5OveLsG+tZ2lQAMnDNh3ojtAF0egcF5lkVv
	 5BD/UhAYrv3+80W03fylO5ISCUXJcP/Avz1NZlDa4p1hee6Q/ExLoszDirmg/IWPlM
	 nlN9xcxdARtmBl94gZUwkYQ8KxEluuV6tGKbiM8k=
Date: Mon, 11 May 2026 08:06:44 -0700
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: Anirudh Rayabharam <anirudh@anirudhrb.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, longli@microsoft.com,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 02/18] mshv: Fix mshv_prepare_pinned_region error path
 for unencrypted partitions
Message-ID: <agHwhJrqEL3IewHz@skinsburskii.localdomain>
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
X-Rspamd-Queue-Id: 42F19511512
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10752-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skinsburskii@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linux.microsoft.com:dkim,skinsburskii.localdomain:mid]
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

Indeed.
The issue with all this code is that we are leaking state in
mshv_region_pin if we wimply return from it: we don't know if the pages
are pinned or unshared (or mapped) in the destruction callback.
We should either introduce a state variable to track this or just don't
call the generic mshv_region_put on case of region creation error.
The latter approch make mshv_map_user_memory idempotent and thus looks
like a better way forward.
What do you think?

Thanks,
Stanislav

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
> 

