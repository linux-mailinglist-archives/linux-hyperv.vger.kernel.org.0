Return-Path: <linux-hyperv+bounces-9441-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OM8hHagZuGn/YwEAu9opvQ
	(envelope-from <linux-hyperv+bounces-9441-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 16 Mar 2026 15:54:32 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 200B129BC7D
	for <lists+linux-hyperv@lfdr.de>; Mon, 16 Mar 2026 15:54:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CD79D306B082
	for <lists+linux-hyperv@lfdr.de>; Mon, 16 Mar 2026 14:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86C1A2EDD78;
	Mon, 16 Mar 2026 14:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fBoPKg5a"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 610EB2ED84A;
	Mon, 16 Mar 2026 14:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773672455; cv=none; b=phXod38CD0CdQEJ5Wpg4wx7OEFpI8ETAzgbWmjA3sVTWoquBDzo2b5DedsbEdL1pzkbvF0/WtPoa0TdC2a3maxyGm+rQnN1OmtiH0zIZlBbkesDicNSuu48pnuihZyX2lpRTCTjUNxaBQnccBykERTyvpZhMkr91+id4IS3mXyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773672455; c=relaxed/simple;
	bh=SWyWovQpZcRYDA2RTZfFVXcBgJf/dKBAYGsO0cjwpR8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IzvvgI1+3PvFIE0Hz8hHcHYRavjaZgdW+vpDAfpbMVZ8da5ZyYGLU2U4aXBknXCWgy4CwDMdG5ewx3kISesp4yFZvC4H0cfBYbgHEY2BYuTVlFq7meg/j2X9sc5STZ5iDp/NWA2wc61SDwwKwZyDrsL3TTOYnIBJBmy/kXD6L1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fBoPKg5a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C73DEC2BC87;
	Mon, 16 Mar 2026 14:47:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773672455;
	bh=SWyWovQpZcRYDA2RTZfFVXcBgJf/dKBAYGsO0cjwpR8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fBoPKg5akPio74rsRGXjA5HYsmf0U0scEYxrF9JlUrnKHGrjoBxvJmuqAcLCHgUoS
	 IFCj8Q6ofjLHnZu+caNKOvyGbzv4zt5yp93PoYG0JqtHPeAHRWXKG7bs4UrW91MZHc
	 AOTUOG75P0LPx53kTgiD9zdeSjGIjxfzeut773v0jtaoImyzhRkvHh9a/Uzr51SXfi
	 gokr/3PW4cHZn0v/iCNUutyK7CIsTQk80ZURS3qpuz7koF3Fd9qNvUkuVpQG0yN/9k
	 uONkj8w6MwBSTEMqIXQ4bc8ZhtmCxRAk5iXQW6PEviYet3WsvklRl6FBuzmcJmE6t0
	 4z2vm0eSfUFwA==
Date: Mon, 16 Mar 2026 14:47:24 +0000
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
Subject: Re: [PATCH 01/15] mm: various small mmap_prepare cleanups
Message-ID: <c7e16d31-ce30-456c-aba7-aaa6dd781b19@lucifer.local>
References: <cover.1773346620.git.ljs@kernel.org>
 <56372fe273f775b26675a04652c1229e14680741.1773346620.git.ljs@kernel.org>
 <CAJuCfpEsCrFEYNkkTfRLGojGOYAAx1=WOojOhpBb_=WZBr6bnQ@mail.gmail.com>
 <CAJuCfpHcjFU1r7ixiJM4b_a5HTesxBmW6DiCreaWpJ8DLM5haQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJuCfpHcjFU1r7ixiJM4b_a5HTesxBmW6DiCreaWpJ8DLM5haQ@mail.gmail.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9441-lists,linux-hyperv=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,lwn.net,ladisch.de,arndb.de,linuxfoundation.org,microsoft.com,kernel.org,linux.intel.com,gmail.com,foss.st.com,bootlin.com,nod.at,ti.com,oracle.com,redhat.com,auristor.com,zeniv.linux.org.uk,suse.cz,suse.com,google.com,suse.de,vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org,lists.linux.dev,kvack.org,arm.com];
	RCPT_COUNT_TWELVE(0.00)[44];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ljs@kernel.org,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lucifer.local:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 200B129BC7D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, Mar 15, 2026 at 04:06:48PM -0700, Suren Baghdasaryan wrote:
> > > --- a/include/linux/mm.h
> > > +++ b/include/linux/mm.h
> > > @@ -4116,10 +4116,10 @@ static inline void mmap_action_ioremap_full(struct vm_area_desc *desc,
> > >         mmap_action_ioremap(desc, desc->start, start_pfn, vma_desc_size(desc));
> > >  }
> > >
> > > -void mmap_action_prepare(struct mmap_action *action,
> > > -                        struct vm_area_desc *desc);
> > > -int mmap_action_complete(struct mmap_action *action,
> > > -                        struct vm_area_struct *vma);
> > > +int mmap_action_prepare(struct vm_area_desc *desc,
> > > +                       struct mmap_action *action);
> > > +int mmap_action_complete(struct vm_area_struct *vma,
> > > +                        struct mmap_action *action);
> > >
> > >  /* Look up the first VMA which exactly match the interval vm_start ... vm_end */
> > >  static inline struct vm_area_struct *find_exact_vma(struct mm_struct *mm,
> > > diff --git a/mm/internal.h b/mm/internal.h
> > > index 95b583e7e4f7..7bfa85b5e78b 100644
> > > --- a/mm/internal.h
> > > +++ b/mm/internal.h
> > > @@ -1775,26 +1775,32 @@ int walk_page_range_debug(struct mm_struct *mm, unsigned long start,
> > >  void dup_mm_exe_file(struct mm_struct *mm, struct mm_struct *oldmm);
> > >  int dup_mmap(struct mm_struct *mm, struct mm_struct *oldmm);
> > >
> > > -void remap_pfn_range_prepare(struct vm_area_desc *desc, unsigned long pfn);
> > > -int remap_pfn_range_complete(struct vm_area_struct *vma, unsigned long addr,
> > > -               unsigned long pfn, unsigned long size, pgprot_t pgprot);
> > > +int remap_pfn_range_prepare(struct vm_area_desc *desc,
> > > +                           struct mmap_action *action);
> > > +int remap_pfn_range_complete(struct vm_area_struct *vma,
> > > +                            struct mmap_action *action);
> > >
> > > -static inline void io_remap_pfn_range_prepare(struct vm_area_desc *desc,
> > > -               unsigned long orig_pfn, unsigned long size)
> > > +static inline int io_remap_pfn_range_prepare(struct vm_area_desc *desc,
> > > +                                            struct mmap_action *action)
> > >  {
> > > +       const unsigned long orig_pfn = action->remap.start_pfn;
> > > +       const unsigned long size = action->remap.size;
> > >         const unsigned long pfn = io_remap_pfn_range_pfn(orig_pfn, size);
> > >
> > > -       return remap_pfn_range_prepare(desc, pfn);
> > > +       action->remap.start_pfn = pfn;
> > > +       return remap_pfn_range_prepare(desc, action);
> > >  }
> > >
> > >  static inline int io_remap_pfn_range_complete(struct vm_area_struct *vma,
> > > -               unsigned long addr, unsigned long orig_pfn, unsigned long size,
> > > -               pgprot_t orig_prot)
> > > +                                             struct mmap_action *action)
> > >  {
> > > -       const unsigned long pfn = io_remap_pfn_range_pfn(orig_pfn, size);
> > > -       const pgprot_t prot = pgprot_decrypted(orig_prot);
> > > +       const unsigned long size = action->remap.size;
> > > +       const unsigned long orig_pfn = action->remap.start_pfn;
> > > +       const pgprot_t orig_prot = vma->vm_page_prot;
> > >
> > > -       return remap_pfn_range_complete(vma, addr, pfn, size, prot);
> > > +       action->remap.pgprot = pgprot_decrypted(orig_prot);
>
> I'm guessing it doesn't really matter but after this change
> action->remap.pgprot will store the decrypted value while before this
> change it was kept the way mmap_prepare() originally set it. We pass
> the action structure later to mmap_actpion_finish() but it does not use
> action->remap.pgprot, so this probably doesn't matter.

Yeah it doesn't really matter either way.

Cheers, Lorenzo

