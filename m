Return-Path: <linux-hyperv+bounces-10231-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aK0eOqe65mnX0AEAu9opvQ
	(envelope-from <linux-hyperv+bounces-10231-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 21 Apr 2026 01:45:43 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7862D434EFA
	for <lists+linux-hyperv@lfdr.de>; Tue, 21 Apr 2026 01:45:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E88D33005755
	for <lists+linux-hyperv@lfdr.de>; Mon, 20 Apr 2026 23:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B09739B962;
	Mon, 20 Apr 2026 23:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="tHDkIbjo"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6C052309AA;
	Mon, 20 Apr 2026 23:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776728740; cv=none; b=NOpZIsynKZ4CUdcAD3HTPX3hI94kVJQ9tsScEmGxSmUkxQKmNjj466OSU69idfAfy1M0ykQRm7XOSzWf8K/IyvX1qndDGXJk1dVU1Qkgf8DiVB4RqG9gQWbcvBq+/lulz0inm8BABkitDHRcX8dYQyTgTrThfmAjanAW/DT1Pvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776728740; c=relaxed/simple;
	bh=zzvk5XLSAKiifSUM4Um+b8j+fYAc5SnF3uqsgA6OODw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cwovO4F4Jcmzt22HcMvwZ/WBfPGC4CHJ0GNNpmUvdZRTpT/LSOyERYR4STyWbkE1lKfoSiYQuLKh7BuxUXRlCzd3Xsy1FVOtOM1ZnMyWQkiY3+1KyucmhX5jfctYDjGgUgnlZOr19JmIFmZNo0C3zpSV8weC+bqwZKkfcAWvPsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=tHDkIbjo; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii.localdomain (unknown [20.236.10.129])
	by linux.microsoft.com (Postfix) with ESMTPSA id 4AD6020B6F01;
	Mon, 20 Apr 2026 16:45:38 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4AD6020B6F01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1776728738;
	bh=EH3FaxNi2a4coA5ypDl8OXig+ST1WqCSlUe4vwkO0L0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tHDkIbjoc571rDn1lFIqyUEsfDc9pR/2suLc3WTGLmzYemsdg8P9pdARmKoS41WbX
	 g41r+SZsOxTlxpUxv9yWfS5KeCAES6h+GEz08C9NvIllbNIvqra3SluoFTyr/0R85f
	 AGCkvvZyUeR+J2FVjIGBPzndijVsKYtQJGBJmq14=
Date: Mon, 20 Apr 2026 16:45:36 -0700
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: Michael Kelley <mhklinux@outlook.com>
Cc: "kys@microsoft.com" <kys@microsoft.com>,
	"haiyangz@microsoft.com" <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>,
	"longli@microsoft.com" <longli@microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/7] mshv: Convert from page pointers to PFNs
Message-ID: <aea6oLf1GEPJhyQK@skinsburskii.localdomain>
References: <177490099488.81669.3758562641675983608.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <177490105758.81669.969284388846280218.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <SN6PR02MB4157CD26728B2D4BFD171DB7D4242@SN6PR02MB4157.namprd02.prod.outlook.com>
 <aeZSnjgSkm7vJxhW@skinsburskii.localdomain>
 <SN6PR02MB41571DD9045771941F371750D42F2@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <SN6PR02MB41571DD9045771941F371750D42F2@SN6PR02MB4157.namprd02.prod.outlook.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10231-lists,linux-hyperv=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[outlook.com];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skinsburskii@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: 7862D434EFA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 20, 2026 at 05:18:10PM +0000, Michael Kelley wrote:
> From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com> Sent: Monday, April 20, 2026 9:22 AM
> > 
> > On Mon, Apr 13, 2026 at 09:08:16PM +0000, Michael Kelley wrote:
> > > From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com> Sent: Monday, March 30, 2026 1:04 PM
> > > >
> 
> [snip]
> 
> > > > @@ -57,60 +58,61 @@ static int mshv_chunk_stride(struct page *page,
> > > >  /**
> > > >   * mshv_region_process_chunk - Processes a contiguous chunk of memory pages
> > > >   *                             in a region.
> > > > - * @region     : Pointer to the memory region structure.
> > > > - * @flags      : Flags to pass to the handler.
> > > > - * @page_offset: Offset into the region's pages array to start processing.
> > > > - * @page_count : Number of pages to process.
> > > > - * @handler    : Callback function to handle the chunk.
> > > > + * @region    : Pointer to the memory region structure.
> > > > + * @flags     : Flags to pass to the handler.
> > > > + * @pfn_offset: Offset into the region's PFNs array to start processing.
> > > > + * @pfn_count : Number of PFNs to process.
> > > > + * @handler   : Callback function to handle the chunk.
> > > >   *
> > > > - * This function scans the region's pages starting from @page_offset,
> > > > - * checking for contiguous present pages of the same size (normal or huge).
> > > > - * It invokes @handler for the chunk of contiguous pages found. Returns the
> > > > - * number of pages handled, or a negative error code if the first page is
> > > > - * not present or the handler fails.
> > > > + * This function scans the region's PFNs starting from @pfn_offset,
> > > > + * checking for contiguous valid PFNs backed by pages of the same size
> > > > + * (normal or huge). It invokes @handler for the chunk of contiguous valid
> > > > + * PFNs found. Returns the number of PFNs handled, or a negative error code
> > > > + * if the first PFN is invalid or the handler fails.
> > > >   *
> > > > - * Note: The @handler callback must be able to handle both normal and huge
> > > > - * pages.
> > > > + * Note: The @handler callback must be able to handle valid PFNs backed by
> > > > + * both normal and huge pages.
> > > >   *
> > > >   * Return: Number of pages handled, or negative error code.
> > > >   */
> > > > -static long mshv_region_process_chunk(struct mshv_mem_region *region,
> > > > -				      u32 flags,
> > > > -				      u64 page_offset, u64 page_count,
> > > > -				      int (*handler)(struct mshv_mem_region *region,
> > > > -						     u32 flags,
> > > > -						     u64 page_offset,
> > > > -						     u64 page_count,
> > > > -						     bool huge_page))
> > > > +static long mshv_region_process_pfns(struct mshv_mem_region *region,
> > > > +				     u32 flags,
> > > > +				     u64 pfn_offset, u64 pfn_count,
> > > > +				     int (*handler)(struct mshv_mem_region *region,
> > > > +						    u32 flags,
> > > > +						    u64 pfn_offset,
> > > > +						    u64 pfn_count,
> > > > +						    bool huge_page))
> > > >  {
> > > > -	u64 gfn = region->start_gfn + page_offset;
> > > > +	u64 gfn = region->start_gfn + pfn_offset;
> > > >  	u64 count;
> > > > -	struct page *page;
> > > > +	unsigned long pfn;
> > > >  	int stride, ret;
> > > >
> > > > -	page = region->mreg_pages[page_offset];
> > > > -	if (!page)
> > > > +	pfn = region->mreg_pfns[pfn_offset];
> > > > +	if (!pfn_valid(pfn))
> > > >  		return -EINVAL;
> > > >
> > > > -	stride = mshv_chunk_stride(page, gfn, page_count);
> > > > +	stride = mshv_chunk_stride(pfn_to_page(pfn), gfn, pfn_count);
> > > >  	if (stride < 0)
> > > >  		return stride;
> > > >
> > > >  	/* Start at stride since the first stride is validated */
> > > > -	for (count = stride; count < page_count; count += stride) {
> > > > -		page = region->mreg_pages[page_offset + count];
> > > > +	for (count = stride; count < pfn_count ; count += stride) {
> > > > +		pfn = region->mreg_pfns[pfn_offset + count];
> > > >
> > > > -		/* Break if current page is not present */
> > > > -		if (!page)
> > > > +		/* Break if current pfn is invalid */
> > > > +		if (!pfn_valid(pfn))
> > >
> > > pfn_valid() is a relatively expensive test to be doing in a loop
> > > on what may be every single page. It does an RCU lock/unlock
> > > and make other checks that aren't necessary here. Since
> > > mreg_pfns[] is populated from mm calls, the only invalid PFNs
> > > would be MSHV_INVALID_PFN that code in this module has
> > > explicitly put there. Just testing against MSHV_INVALID_PFN
> > > would be a lot faster here and elsewhere in this module. It's
> > > really a "pfn set/not set" test. Defining a pfn_set() macro
> > > here in this module that tests against MSHV_INVALID_PFN
> > > would accomplish the same thing more efficiently.
> > >
> > 
> > Yes, we could do it the way you suggest. For completeness, I should add
> > that pfn_valid() is expensive only on 32-bit ARM and ARC, which we
> > don’t care about.
> > 
> 
> Could you elaborate? On x86, I'm seeing that pfn_valid() is about
> 220 bytes of code. It's the version in include/linux/mmzone.h, not
> the simple version in include/asm-generic/memory_model.h. The
> latter is used only for CONFIG_FLATMEM=y. Or is the root partition
> kernel build setting CONFIG_FLATMEM_MANUAL and hence getting
> the simple version?
> 

I was wrong: this long function is indeed compiled for x86.
Still, it's not big of a runtime impact as taking the rcu lock is cheap,
but I'll simplify as proposed.

Thanks,
Stanislav

> Michael

