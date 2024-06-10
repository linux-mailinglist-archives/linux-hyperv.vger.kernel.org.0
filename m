Return-Path: <linux-hyperv+bounces-2364-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29FF29019A3
	for <lists+linux-hyperv@lfdr.de>; Mon, 10 Jun 2024 06:03:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5F26281C2D
	for <lists+linux-hyperv@lfdr.de>; Mon, 10 Jun 2024 04:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FA0D2901;
	Mon, 10 Jun 2024 04:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ydtYYv4z";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="2VfRPhmr";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ydtYYv4z";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="2VfRPhmr"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1465C6FC7;
	Mon, 10 Jun 2024 04:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717992224; cv=none; b=tEsQVJDQ09OPb6myZcx7zf12crTohkW32TojwlmffVi/SfWEdYtyFvN/Ed+TZjl5YuLuzPi58Q5Pbg2/NPxyxMUYcCm/sSgTg9wwH/E7v0Gzn8088OUFrN4xcEAsyOFrTdE4Y7JsPRMBCT9oBzaUHTPhv6Ksplgk4NXiPJY57sI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717992224; c=relaxed/simple;
	bh=GChWdvz367o5jaGDbpYnIiP5MM27bWYnZ96439DZOVE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pXhnArazV7CtHWx5K8Gn/d5ePF2FWWs5k9Fq0lY3NwyTs4FBUVKg8tKQJlKH2ySOgGQHf2zhv+4Efdr1QA9T8DrbSUtcmSqmITY+iFREROIFcljs+XWP+1INjkICc+ytCMIEnF3JSZ3tFrC+sb699JlFw/9mJUu8ec7T1i59U8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ydtYYv4z; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=2VfRPhmr; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ydtYYv4z; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=2VfRPhmr; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 48E781F74B;
	Mon, 10 Jun 2024 04:03:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1717992221; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IYHZUWJMx20LtuFCKKBR+s4SdF/zVxwDIU/zuxJyVpA=;
	b=ydtYYv4zpnWoA+DOEizDfb0xxwSoFgVJdNwaHwsZ4KNXXr0McZcQoDjm0TnP6modKw7qU/
	YU6A1x5Wb6Mc5i5eAKt/8AnZNi+ROMDh3WDQz74dIE+RuF5EAw2jT5VaieXlP6Lpkd0vmq
	E86gqlWw/GGQiz4G8sn557CdigPAhQM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1717992221;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IYHZUWJMx20LtuFCKKBR+s4SdF/zVxwDIU/zuxJyVpA=;
	b=2VfRPhmrW05hUtLnVJUcfs9KMJfRv9vz9QyGoBqjvqYUGpchjhJed480Cqm/I/F3MSoXT2
	Q9/kUhFsd2NbvbBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1717992221; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IYHZUWJMx20LtuFCKKBR+s4SdF/zVxwDIU/zuxJyVpA=;
	b=ydtYYv4zpnWoA+DOEizDfb0xxwSoFgVJdNwaHwsZ4KNXXr0McZcQoDjm0TnP6modKw7qU/
	YU6A1x5Wb6Mc5i5eAKt/8AnZNi+ROMDh3WDQz74dIE+RuF5EAw2jT5VaieXlP6Lpkd0vmq
	E86gqlWw/GGQiz4G8sn557CdigPAhQM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1717992221;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IYHZUWJMx20LtuFCKKBR+s4SdF/zVxwDIU/zuxJyVpA=;
	b=2VfRPhmrW05hUtLnVJUcfs9KMJfRv9vz9QyGoBqjvqYUGpchjhJed480Cqm/I/F3MSoXT2
	Q9/kUhFsd2NbvbBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2ECBB13A85;
	Mon, 10 Jun 2024 04:03:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id K/XmCBx7ZmbzEgAAD6G6ig
	(envelope-from <osalvador@suse.de>); Mon, 10 Jun 2024 04:03:40 +0000
Date: Mon, 10 Jun 2024 06:03:38 +0200
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
Message-ID: <ZmZ7GgwJw4ucPJaM@localhost.localdomain>
References: <20240607090939.89524-1-david@redhat.com>
 <20240607090939.89524-2-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240607090939.89524-2-david@redhat.com>
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]

On Fri, Jun 07, 2024 at 11:09:36AM +0200, David Hildenbrand wrote:
> In preparation for further changes, let's teach __free_pages_core()
> about the differences of memory hotplug handling.
> 
> Move the memory hotplug specific handling from generic_online_page() to
> __free_pages_core(), use adjust_managed_page_count() on the memory
> hotplug path, and spell out why memory freed via memblock
> cannot currently use adjust_managed_page_count().
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>

All looks good but I am puzzled with something.

> +	} else {
> +		/* memblock adjusts totalram_pages() ahead of time. */
> +		atomic_long_add(nr_pages, &page_zone(page)->managed_pages);
> +	}

You say that memblock adjusts totalram_pages ahead of time, and I guess
you mean in memblock_free_all()

 pages = free_low_memory_core_early()
 totalram_pages_add(pages);

but that is not ahead, it looks like it is upading __after__ sending
them to buddy?


-- 
Oscar Salvador
SUSE Labs

