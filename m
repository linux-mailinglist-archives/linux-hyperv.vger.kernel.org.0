Return-Path: <linux-hyperv+bounces-10827-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0OoAEnpdBGqiHQIAu9opvQ
	(envelope-from <linux-hyperv+bounces-10827-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 13 May 2026 13:16:10 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 88584532054
	for <lists+linux-hyperv@lfdr.de>; Wed, 13 May 2026 13:16:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E9F1F300F776
	for <lists+linux-hyperv@lfdr.de>; Wed, 13 May 2026 11:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1C773A5454;
	Wed, 13 May 2026 11:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b="ebdAcHsz"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from sender4-of-o52.zoho.com (sender4-of-o52.zoho.com [136.143.188.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689EF349CE0;
	Wed, 13 May 2026 11:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778670966; cv=pass; b=ig3uHGy37ED0huqldByDpf5hBoZf5lGpfdo2G+2mwtzquRGPqgj0aAXCCP6A1yu1zZ4SmeB31krI/gO6vEzGf0Wj19r5K6Kyrq8QNAlSNaJlg+ZHlfDpvstBdOYcjbNNclTd9Zxw3Cx0A9RLkfEgf0z38EdHTyKeQ+WJEzOizE0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778670966; c=relaxed/simple;
	bh=L6qbkl5wGHFfPfATtxzW+QGgLa9WkQMKkRgjwK3UT3s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nE1AVZiGisv6XsU3u7/GpyV+qMNzTCDOryqrfMm+rwW3mlABlFm7+TeJvwaIrKspsruyHXusB8cWODY3Ch5r3fD6mF9P+CIu002YxZ0bktxqdSE3LMynuaO/Fmi4g7tazIaQua5L5JwfmOIN5ccTRQfjM+ZDeW4uFCGmIVp3EPk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=anirudhrb.com; spf=pass smtp.mailfrom=anirudhrb.com; dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b=ebdAcHsz; arc=pass smtp.client-ip=136.143.188.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=anirudhrb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=anirudhrb.com
ARC-Seal: i=1; a=rsa-sha256; t=1778670946; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Egm9IlyFyhZDvjDZ835zanuRcnUFH83nyPia1zF13ATgYBlVN8hqNvE2OWEistEE/JF2aXgvGO+z/+eQhJtDfUoM0ooTfPC6rOtToD2jLRRegxcrPRuuWfrFCG70EoWHVCeaMqhFOq2JxxF9PLInYYgkJ6TDW2tQmuMOnh+fMCE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1778670946; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=1PVmz23sFjdJ54ldQyYvFVQvwDJ+b1q1a+yHBcL8fgc=; 
	b=kXzWGYKwFMWL6mgTF9xngMpZslKfobj7S1TMi3gYGnADlzsJUT+4w5orkazcxY8DIA+1G6Fznh+jnZtWgRzwJ4ct7K5o3Xm/r6lK5QpgT92ZekTArqO1od1nx4mDzcAXyGfnuHn/TT8qBVmbBGtgHOZDSvoMMDOQYKLii2W0bFk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=anirudhrb.com;
	spf=pass  smtp.mailfrom=anirudh@anirudhrb.com;
	dmarc=pass header.from=<anirudh@anirudhrb.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1778670946;
	s=zoho; d=anirudhrb.com; i=anirudh@anirudhrb.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:Message-Id:Reply-To;
	bh=1PVmz23sFjdJ54ldQyYvFVQvwDJ+b1q1a+yHBcL8fgc=;
	b=ebdAcHszW6u95Tv3yH7+xex9kxFIvW3yJA2uaTCjA8BUJjS+ocGmcCiyyzAe8cIk
	O4MkjW+dRQjzmkeq9UmTIvPseDQi+042q0JKFuMYbZoebRv+WzSNzaEdlYJi4EC3nRs
	nx4R1ltboYkUx548y9N74X0k/BxgeUblQPlUgR2I=
Received: by mx.zohomail.com with SMTPS id 177867094460587.87783568048155;
	Wed, 13 May 2026 04:15:44 -0700 (PDT)
Date: Wed, 13 May 2026 11:15:37 +0000
From: Anirudh Rayabharam <anirudh@anirudhrb.com>
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, longli@microsoft.com,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 02/18] mshv: Fix mshv_prepare_pinned_region error path
 for unencrypted partitions
Message-ID: <20260513-roaring-gentle-kiwi-21bccd@anirudhrb>
References: <177816592843.21765.4364464279247150355.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <177816858991.21765.2088226987194959542.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <20260511-ancient-naughty-bat-f58c2c@anirudhrb>
 <agHwhJrqEL3IewHz@skinsburskii.localdomain>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <agHwhJrqEL3IewHz@skinsburskii.localdomain>
X-ZohoMailClient: External
X-Rspamd-Queue-Id: 88584532054
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[anirudhrb.com,none];
	R_DKIM_ALLOW(-0.20)[anirudhrb.com:s=zoho];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10827-lists,linux-hyperv=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[anirudhrb.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anirudh@anirudhrb.com,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,anirudhrb.com:dkim]
X-Rspamd-Action: no action

On Mon, May 11, 2026 at 08:06:44AM -0700, Stanislav Kinsburskii wrote:
> On Mon, May 11, 2026 at 01:48:56PM +0000, Anirudh Rayabharam wrote:
> > On Thu, May 07, 2026 at 03:43:09PM +0000, Stanislav Kinsburskii wrote:
> > > mshv_prepare_pinned_region() returns 0 (success) when mshv_region_map()
> > > fails on an unencrypted partition. The condition on the error path:
> > > 
> > >     if (ret && mshv_partition_encrypted(partition))
> > > 
> > > only handles map failures for encrypted partitions — if the partition is
> > > not encrypted and the map fails, execution falls through to 'return 0',
> > > silently ignoring the error.
> > > 
> > > Additionally, calling mshv_region_invalidate() inline on map failure
> > > zeroes the mreg_pages array before the caller's cleanup path
> > > (mshv_region_destroy) can call mshv_region_unmap(). Since unmap skips
> > > pages where mreg_pages[offset] is NULL, this can leave stale SLAT
> > > mappings for partially-mapped pages.
> > > 
> > > Fix by returning immediately on success and falling through to error
> > > return on failure. For unencrypted partitions, the caller's
> > > mshv_region_destroy() handles unmap followed by invalidate in the
> > > correct order. For encrypted partitions where re-sharing fails, zero
> > > the page array without unpinning — the pages are inaccessible to the
> > > host and must not be unpinned, but zeroing prevents
> > > mshv_region_destroy() from attempting to unpin them.
> > 
> > mshv_region_destroy() calls mshv_region_invalidate() which calls
> > mshv_region_invalidate_pages() which just does:
> > 
> > 	static void mshv_region_invalidate_pages(struct mshv_mem_region *region,
> > 						 u64 page_offset, u64 page_count)
> > 	{
> > 		if (region->mreg_type == MSHV_REGION_TYPE_MEM_PINNED)
> > 			unpin_user_pages(region->mreg_pages + page_offset, page_count);
> > 
> > 		memset(region->mreg_pages + page_offset, 0,
> > 		       page_count * sizeof(struct page *));
> > 	}
> > 
> > It doesn't checked for zeroed pages before unpinning.
> > 
> > > 
> > > Fixes: 621191d709b14 ("Drivers: hv: Introduce mshv_root module to expose /dev/mshv to VMMs")
> > > Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
> > > ---
> > >  drivers/hv/mshv_root_main.c |   26 ++++++++++++++++----------
> > >  1 file changed, 16 insertions(+), 10 deletions(-)
> > > 
> > > diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
> > > index 665d565899c15..7e4252b6bc65c 100644
> > > --- a/drivers/hv/mshv_root_main.c
> > > +++ b/drivers/hv/mshv_root_main.c
> > > @@ -1360,32 +1360,38 @@ static int mshv_prepare_pinned_region(struct mshv_mem_region *region)
> > >  			pt_err(partition,
> > >  			       "Failed to unshare memory region (guest_pfn: %llu): %d\n",
> > >  			       region->start_gfn, ret);
> > > -			goto invalidate_region;
> > > +			goto err_out;
> > >  		}
> > >  	}
> > >  
> > >  	ret = mshv_region_map(region);
> > > -	if (ret && mshv_partition_encrypted(partition)) {
> > > +	if (ret)
> > > +		goto share_region;
> > > +
> > > +	return 0;
> > > +
> > > +share_region:
> > > +	if (mshv_partition_encrypted(partition)) {
> > >  		int shrc;
> > >  
> > >  		shrc = mshv_region_share(region);
> > >  		if (!shrc)
> > > -			goto invalidate_region;
> > > +			goto err_out;
> > >  
> > >  		pt_err(partition,
> > >  		       "Failed to share memory region (guest_pfn: %llu): %d\n",
> > >  		       region->start_gfn, shrc);
> > >  		/*
> > > -		 * Don't unpin if marking shared failed because pages are no
> > > -		 * longer mapped in the host, ie root, anymore.
> > > +		 * Re-sharing failed — the pages remain inaccessible to the
> > > +		 * host.  Zero the page array so that mshv_region_destroy()
> > > +		 * won't attempt to unpin them (leaking the page references
> > > +		 * is intentional; unpinning host-inaccessible pages would be
> > > +		 * unsafe).
> > >  		 */
> > 
> > Actually, mshv_region_destroy() also does mshv_region_share(). Maybe we
> > can remove it from here altogether. Either way, should this zeroing
> > logic be added there too so as not to crash the host by unpinning pages
> > that weren't marked shared?
> > 
> 
> Indeed.
> The issue with all this code is that we are leaking state in
> mshv_region_pin if we wimply return from it: we don't know if the pages
> are pinned or unshared (or mapped) in the destruction callback.
> We should either introduce a state variable to track this or just don't
> call the generic mshv_region_put on case of region creation error.
> The latter approch make mshv_map_user_memory idempotent and thus looks
> like a better way forward.
> What do you think?

I'm not sure I follow the latter approach. Omitting mshv_region_put()
would cause a dangling reference to the mshv_region right?

Thanks,
Anirudh.


