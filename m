Return-Path: <linux-hyperv+bounces-2377-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C60C903423
	for <lists+linux-hyperv@lfdr.de>; Tue, 11 Jun 2024 09:46:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C24B281897
	for <lists+linux-hyperv@lfdr.de>; Tue, 11 Jun 2024 07:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED87A172796;
	Tue, 11 Jun 2024 07:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="u5mEgWuS";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Vs4QnX1R";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="beS+LyS4";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="blQE/fLA"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CBC616F85B;
	Tue, 11 Jun 2024 07:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718091961; cv=none; b=Y6sTi11zo/u6ZT8ms/P3pAxKxKMAl+tGc3cRIbeZosm2EPSna7FQR/HD1fZCPTeoqhugvIisTUT+c2rcsxM1IwVRASd2A1QCrJte8vsaYfxRy8Wl8LYmc3AYHUS1lJZfaN+xKVez4gcgX/6g1eJc40dkJiYwVrX7io8q5tAzB+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718091961; c=relaxed/simple;
	bh=mp2IL7MdmeQ+2HOU+/QV+QdLYLJxOsq9VsJKxybVlgY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qSXORAKkCqdRWIT9oYVdC1AH1KnpddTZKFaSxK8fbZNZumBjJTN4IZIWfjssoE+pWgzU+8f6ViC8rT26R7oi2FDi/ojcNc2fXNXRt1seVaqYx8/gEeIzunPl4oMyE7OR9VkyWeX3GrMRRuME0CridmGEMf9sHbZBCtJVDAcWZZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=u5mEgWuS; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Vs4QnX1R; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=beS+LyS4; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=blQE/fLA; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0B24722CCD;
	Tue, 11 Jun 2024 07:45:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718091958; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HVao4QsDP4Z+JAjo5dOzj5sxwVNV/Y4USEllUqua+SQ=;
	b=u5mEgWuSpunEORDd99KB+qYCCofPeL9U0D+nligMM1u7MVYkAsDQ4tHD3Kx6+UbLLoWb9Q
	ZKLtpOD0A7zMaX96b5O0y7p1jSfvfiouCBinzY0ukzGsQHISDNnZX5BxP7yYnZl30CXRvD
	XUtm+fRniwugupRUTF0pqvUJ6aUhHeI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718091958;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HVao4QsDP4Z+JAjo5dOzj5sxwVNV/Y4USEllUqua+SQ=;
	b=Vs4QnX1RXzMMer0yUJ/gnSrGDlsxSJRsNXNkxuY1DjYdWEK4c26NAw8fho5r6ae0TqbKkl
	TducIsP3PboEO4DQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718091957; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HVao4QsDP4Z+JAjo5dOzj5sxwVNV/Y4USEllUqua+SQ=;
	b=beS+LyS4FBWnwGXe6a5zd/EhBO0SySrgPbqyL6f5aR8KILqXrR2/CI5lDKJ80NRBdN/pSq
	JbySBQlifQRqEKrIl1R/jcgrzWFcaHlw0Fl6CIKXrfrMDA8Ys0+B7INFr6lrOOFwfTr1iS
	ef8d3ylhBReZsLmY5KbBBlD/myYBhkQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718091957;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HVao4QsDP4Z+JAjo5dOzj5sxwVNV/Y4USEllUqua+SQ=;
	b=blQE/fLATW0heDMQ1LEDrIBV+gvCQOtxZiUyMLRgeESKGRSW5JNnkJ/TCLcUuKPV7v/6M6
	dbtt7phZc0CzDZBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D8AB213A55;
	Tue, 11 Jun 2024 07:45:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4MdfMrMAaGYMUQAAD6G6ig
	(envelope-from <osalvador@suse.de>); Tue, 11 Jun 2024 07:45:55 +0000
Date: Tue, 11 Jun 2024 09:45:54 +0200
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
Subject: Re: [PATCH v1 2/3] mm/memory_hotplug: initialize memmap of
 !ZONE_DEVICE with PageOffline() instead of PageReserved()
Message-ID: <ZmgAsolx7SAHeDW7@localhost.localdomain>
References: <20240607090939.89524-1-david@redhat.com>
 <20240607090939.89524-3-david@redhat.com>
 <ZmZ_3Xc7fdrL1R15@localhost.localdomain>
 <5d9583e1-3374-437d-8eea-6ab1e1400a30@redhat.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d9583e1-3374-437d-8eea-6ab1e1400a30@redhat.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	SUBJECT_HAS_EXCLAIM(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[23];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -4.30
X-Spam-Flag: NO

On Mon, Jun 10, 2024 at 10:56:02AM +0200, David Hildenbrand wrote:
> There are fortunately not that many left.
> 
> I'd even say marking them (vmemmap) reserved is more wrong than right: note
> that ordinary vmemmap pages after memory hotplug are not reserved! Only
> bootmem should be reserved.

Ok, that is a very good point that I missed.
I thought that hotplugged-vmemmap pages (not selfhosted) were marked as
Reserved, that is why I thought this would be inconsistent.
But then, if that is the case, I think we are safe as kernel can already
encounter vmemmap pages that are not reserved and it deals with them
somehow.

> Let's take at the relevant core-mm ones (arch stuff is mostly just for MMIO
> remapping)
> 
... 
> Any PageReserved user that I am missing, or why we should handle these
> vmemmap pages differently than the ones allocated during ordinary memory
> hotplug?

No, I cannot think of a reason why normal vmemmap pages should behave
different than self-hosted.

I was also confused because I thought that after this change
pfn_to_online_page() would be different for self-hosted vmemmap pages,
because I thought that somehow we relied on PageOffline(), but it is not
the case.

> In the future, we might want to consider using a dedicated page type for
> them, so we can stop using a bit that doesn't allow to reliably identify
> them. (we should mark all vmemmap with that type then)

Yes, a all-vmemmap pages type would be a good thing, so we do not have
to special case.

Just one last thing.
Now self-hosted vmemmap pages will have the PageOffline cleared, and that
will still remain after the memory-block they belong to has gone
offline, which is ok because those vmemmap pages lay around until the
chunk of memory gets removed.

Ok, just wanted to convince myself that there will no be surprises.

Thanks David for claryfing.
 

-- 
Oscar Salvador
SUSE Labs

