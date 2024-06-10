Return-Path: <linux-hyperv+bounces-2371-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4CAB9020AA
	for <lists+linux-hyperv@lfdr.de>; Mon, 10 Jun 2024 13:47:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20F37B22B60
	for <lists+linux-hyperv@lfdr.de>; Mon, 10 Jun 2024 11:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4DDE7E58F;
	Mon, 10 Jun 2024 11:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="jQO+Qx/4";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="pE7TkXSX";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="jQO+Qx/4";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="pE7TkXSX"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 818D17581D;
	Mon, 10 Jun 2024 11:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718020054; cv=none; b=OoI6TvV7vRp4mLFpdjflFOzqhmcGIY2LSJt1pU25GyeWshooahg+tbwMGrlIEXoLurPL8mLTphRH3r7dvQ71J/xcrnEkDEI1I8Wxd9Rkeavir9KbKtoSXoFgCowdFzxWKojqU3cC8mJQGpFdon2vI2lPEbr/Udmno8Ya2fj0paM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718020054; c=relaxed/simple;
	bh=7iIJx2j8iSuki6xIdbK8K2GFSXMHa46eeRn+C5M4uUI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jMDkydwrRlKOhLU82WuNbiA+G3kwofMzxalLam6tIBKKJYwZ2j0rw+NKkBIzNefomm1oTrJp8FVqrFH4TkRZC9TSCrsPliyJTiPE45yQui5hRXhPrp9evAWT9fzyZfR7f5iYlISG6VqUkZurC9x3MN5JFuAdo7kf+27KJDBCLUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=jQO+Qx/4; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=pE7TkXSX; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=jQO+Qx/4; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=pE7TkXSX; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8172421A5B;
	Mon, 10 Jun 2024 11:47:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718020049; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WJbUj0Me5/uIhq7+KJarpD1i6Sf3idu2woFatetNcL0=;
	b=jQO+Qx/4Mj+vDjMEgjaHWKq33ho5f4Qb6TYgmmU0qZfZs7hYxUfoNdVh0yH7bMllbzqIzj
	cBgRVPF2mcuk7QqY+/pskie2ykcdmVfJAarIg0QR57zOzx4iU4VSWIXTSa8mKRdzIBa0QD
	lO9DjXCGRfL9yocXH6oR8JUqcqdOAxc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718020049;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WJbUj0Me5/uIhq7+KJarpD1i6Sf3idu2woFatetNcL0=;
	b=pE7TkXSXVcV2z59Zw2hFhiW+a9rT+ETwB+nt36sIeCijTXDS4lhfOoWDZeBLz9algnI9z/
	eVn0jCO+My8aZ1Ag==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718020049; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WJbUj0Me5/uIhq7+KJarpD1i6Sf3idu2woFatetNcL0=;
	b=jQO+Qx/4Mj+vDjMEgjaHWKq33ho5f4Qb6TYgmmU0qZfZs7hYxUfoNdVh0yH7bMllbzqIzj
	cBgRVPF2mcuk7QqY+/pskie2ykcdmVfJAarIg0QR57zOzx4iU4VSWIXTSa8mKRdzIBa0QD
	lO9DjXCGRfL9yocXH6oR8JUqcqdOAxc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718020049;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WJbUj0Me5/uIhq7+KJarpD1i6Sf3idu2woFatetNcL0=;
	b=pE7TkXSXVcV2z59Zw2hFhiW+a9rT+ETwB+nt36sIeCijTXDS4lhfOoWDZeBLz9algnI9z/
	eVn0jCO+My8aZ1Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6843213A7F;
	Mon, 10 Jun 2024 11:47:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 5brfFtDnZmbLFQAAD6G6ig
	(envelope-from <osalvador@suse.de>); Mon, 10 Jun 2024 11:47:28 +0000
Date: Mon, 10 Jun 2024 13:47:18 +0200
From: Oscar Salvador <osalvador@suse.de>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-hyperv@vger.kernel.org, virtualization@lists.linux.dev,
	xen-devel@lists.xenproject.org, kasan-dev@googlegroups.com,
	Andrew Morton <akpm@linux-foundation.org>,
	Mike Rapoport <rppt@kernel.org>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	Alexander Potapenko <glider@google.com>,
	Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>
Subject: Re: [PATCH v1 1/3] mm: pass meminit_context to __free_pages_core()
Message-ID: <ZmbnxrOuoarMbC6X@localhost.localdomain>
References: <20240607090939.89524-1-david@redhat.com>
 <20240607090939.89524-2-david@redhat.com>
 <ZmZ7GgwJw4ucPJaM@localhost.localdomain>
 <13070847-4129-490c-b228-2e52bd77566a@redhat.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13070847-4129-490c-b228-2e52bd77566a@redhat.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.993];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[]
X-Spam-Score: -4.30
X-Spam-Flag: NO

On Mon, Jun 10, 2024 at 10:38:05AM +0200, David Hildenbrand wrote:
> On 10.06.24 06:03, Oscar Salvador wrote:
> > On Fri, Jun 07, 2024 at 11:09:36AM +0200, David Hildenbrand wrote:
> > > In preparation for further changes, let's teach __free_pages_core()
> > > about the differences of memory hotplug handling.
> > > 
> > > Move the memory hotplug specific handling from generic_online_page() to
> > > __free_pages_core(), use adjust_managed_page_count() on the memory
> > > hotplug path, and spell out why memory freed via memblock
> > > cannot currently use adjust_managed_page_count().
> > > 
> > > Signed-off-by: David Hildenbrand <david@redhat.com>
> > 
> > All looks good but I am puzzled with something.
> > 
> > > +	} else {
> > > +		/* memblock adjusts totalram_pages() ahead of time. */
> > > +		atomic_long_add(nr_pages, &page_zone(page)->managed_pages);
> > > +	}
> > 
> > You say that memblock adjusts totalram_pages ahead of time, and I guess
> > you mean in memblock_free_all()
> 
> And memblock_free_late(), which uses atomic_long_inc().

Ah yes.

 
> Right (it's suboptimal, but not really problematic so far. Hopefully Wei can
> clean it up and move it in here as well)

That would be great.

> For the time being
> 
> "/* memblock adjusts totalram_pages() manually. */"

Yes, I think that is better ;-)

Thanks!
 

-- 
Oscar Salvador
SUSE Labs

