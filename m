Return-Path: <linux-hyperv+bounces-9552-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oOowJj8nvGkxtgIAu9opvQ
	(envelope-from <linux-hyperv+bounces-9552-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2026 17:41:35 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 180AD2CEF9A
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2026 17:41:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 27A0E3296243
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2026 16:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7BEF3EC2C7;
	Thu, 19 Mar 2026 16:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aF5DbFFA"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 484BE3ED5B3;
	Thu, 19 Mar 2026 16:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773937762; cv=none; b=D2lsa1xovYtGCb9NtzR3iQTVaJ3Zg8MbTH/04ygdW5k8NhtvK++8sVJczlfHNg2izwIIZ4E/JNXUHWb2tZkfKJmul4mZZkoPkESXY94a5HuxZsi9pumopjy2p8BtYLf1ysZQCuZOmoPg3OF1AICivK+r0P50Yvz86NV1zP4cYXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773937762; c=relaxed/simple;
	bh=i5FY2xFUG82H2mxUurUo54YyYFYdXZArEFQEN+SDOy0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TGZv4Sp+knHT+6Rz+pX2vCNpk/eWehpOTuMx7R6RTn9hK6FaNncehrv/xhdEqCLgitypX4AcxkwqYlmq6xR6XSdjXjsu7vkg4E7bo9N9qGDX/9SkUfVSdVDkHV5NX/3WX//aGRAU0S5IXw6OD9asFGyGsR8dR3HENUyJYKl6U/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aF5DbFFA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 248A3C19424;
	Thu, 19 Mar 2026 16:29:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773937761;
	bh=i5FY2xFUG82H2mxUurUo54YyYFYdXZArEFQEN+SDOy0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aF5DbFFAnHCvzhvJhT5dGtrQoRtJ9QNrqQlmJnbfZGodcTPOczAfqoQkVJIF/LXmE
	 NRUWZ3gYSMcre4wgwUNw09xxVKFI5Sgemkg2LAotinZjLLwX4iM1PGYkctTph/RumK
	 vZbtY4tdz04aVkTwegcY+ogZdGqZvTefi0axkcs96JyYYbbFlBfs82HELbk8bZzpWu
	 r3XKupXWro4jRmoWCi9Q8Sv10Og+jz9lMJHhwiLehTvhEzP5QW3ShgVjN49nGeFKrY
	 HHr/eCyrr+oVH6Ygchgg5RWipe/5nmkCpI4UsgYg0JGgzQb2ofwBsZCXqUHlfYYlJr
	 B/ySfzNIrgg5Q==
Date: Thu, 19 Mar 2026 16:29:19 +0000
From: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Jonathan Corbet <corbet@lwn.net>, Clemens Ladisch <clemens@ladisch.de>, 
	Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"K . Y . Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, 
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Miquel Raynal <miquel.raynal@bootlin.com>, 
	Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
	Bodo Stroesser <bostroesser@gmail.com>, "Martin K . Petersen" <martin.petersen@oracle.com>, 
	David Howells <dhowells@redhat.com>, Marc Dionne <marc.dionne@auristor.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	David Hildenbrand <david@kernel.org>, "Liam R . Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, Michal Hocko <mhocko@suse.com>, 
	Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-hyperv@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, 
	linux-mtd@lists.infradead.org, linux-staging@lists.linux.dev, linux-scsi@vger.kernel.org, 
	target-devel@vger.kernel.org, linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, Ryan Roberts <ryan.roberts@arm.com>
Subject: Re: [PATCH v2 06/16] mm: add mmap_action_simple_ioremap()
Message-ID: <939645bf-50c3-47bd-8132-89acf95056c5@lucifer.local>
References: <cover.1773695307.git.ljs@kernel.org>
 <1e58aaf3cdb61cc317d890c12c9a558dfc206913.1773695307.git.ljs@kernel.org>
 <CAJuCfpGocCSRT0yDxPOLg2NZ+W_ZSTjHGPZRKBd3U90=sQtHCw@mail.gmail.com>
 <330f3614-7dc1-4e80-96c4-8472b25108bb@lucifer.local>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <330f3614-7dc1-4e80-96c4-8472b25108bb@lucifer.local>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9552-lists,linux-hyperv=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[linux-foundation.org,lwn.net,ladisch.de,arndb.de,linuxfoundation.org,microsoft.com,kernel.org,linux.intel.com,gmail.com,foss.st.com,bootlin.com,nod.at,ti.com,oracle.com,redhat.com,auristor.com,zeniv.linux.org.uk,suse.cz,suse.com,google.com,suse.de,vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org,lists.linux.dev,kvack.org,arm.com];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.968];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ljs@kernel.org,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[44];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 180AD2CEF9A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 18, 2026 at 08:39:25PM +0000, Lorenzo Stoakes (Oracle) wrote:
> On Mon, Mar 16, 2026 at 09:14:28PM -0700, Suren Baghdasaryan wrote:
> > > +int simple_ioremap_prepare(struct vm_area_desc *desc)
> > > +{
> > > +       struct mmap_action *action = &desc->action;
> > > +       const phys_addr_t start = action->simple_ioremap.start_phys_addr;
> > > +       const unsigned long size = action->simple_ioremap.size;
> > > +       unsigned long pfn;
> > > +       int err;
> > > +
> > > +       err = __simple_ioremap_prep(desc->start, desc->end, desc->pgoff,
> > > +                                   start, size, &pfn);
> > > +       if (err)
> > > +               return err;
> > > +
> > > +       /* The I/O remap logic does the heavy lifting. */
> > > +       mmap_action_ioremap(desc, desc->start, pfn, vma_desc_size(desc));
> >
> > nit: Looks like a perfect opportunity to use mmap_action_ioremap_full() here.
>
> Yeah can do!
>
> >
> > > +       return mmap_action_prepare(desc);
> >
> > Ok, so IIUC this uses recursion:
> > mmap_action_prepare(MMAP_SIMPLE_IO_REMAP) -> simple_ioremap_prepare()
> > -> mmap_action_prepare(MMAP_IO_REMAP_PFN).
>
> Yep, it's one level, I think that should be ok? :)

On second thoughts, it's silly not just to call io_remap_pfn_range_prepare()
direct so will change it to do that!

Cheers, Lorenzo

