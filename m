Return-Path: <linux-hyperv+bounces-9533-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WKY3LpsNu2kSegIAu9opvQ
	(envelope-from <linux-hyperv+bounces-9533-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 18 Mar 2026 21:39:55 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 637712C28DD
	for <lists+linux-hyperv@lfdr.de>; Wed, 18 Mar 2026 21:39:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 53FC5304B032
	for <lists+linux-hyperv@lfdr.de>; Wed, 18 Mar 2026 20:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68028343216;
	Wed, 18 Mar 2026 20:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E47VA4ey"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC221F192E;
	Wed, 18 Mar 2026 20:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773866377; cv=none; b=ROJzl/nnlsMhyYq8OA7WZGskZLFALnXGCu98PGnrGlmYChyfwaUeuduD/wU1d0Osrq0pWTMmmnsNsumcKOaUCDRxE5LAZZYn8tmUZ3fmyJFUPrvW/20ac437vlsgw/rJnWfaBNbEPP1PZQ2cPR7ExV+PDbyLJitljvRHvqeULCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773866377; c=relaxed/simple;
	bh=ko4orCFKsaEPvSaBxnt5g878sJgcfWQEheBNrNLKEMQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pejHhklYbwDFhobM8mv8AiAEZFTeRaRCLRgGP8Lt0OCHUR0CsL40713GPe8k5E1ggBBfsoHDPrTyfuH4s+KiiTUF9Me6KcaU00kc/qgRNt6G8BcJbMRNEd2a7ddDRnRjjtHqzjIo9cuMo/tdXK5fshO/HhEp3rPtlQTO+/E4fo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E47VA4ey; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7479EC19424;
	Wed, 18 Mar 2026 20:39:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773866376;
	bh=ko4orCFKsaEPvSaBxnt5g878sJgcfWQEheBNrNLKEMQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E47VA4eyxbQXzd9/UHnJc4CUyaJrHozBi4afZf6c2jVcv2hd+Z0m+zIqpNy1M8pcj
	 w9oXKVlXsLe1VI72kOIoJ7l6ut2RfKSHB1X8nGTrbocnlF7Eed4LpFpwhujoluz0ah
	 A2YQHuP+2I42ZaCouQNufu5wxVSBwJIHljGN7Mpuwkfmno/V0udnRXB25cKn2Fu76k
	 Bj63OdwEfHZJK2feU7hXM5AaBG8wRBm9rVwUfTJFLT5MH/nlGD/sZWJpPDFTJMmEYQ
	 nIrm5s3/krtA3DDEiPdP/tIOsTj2jTMHTs15YMbXC5SKfl8L20fd17zraYnMf17hnN
	 qalFYxNmTkB4w==
Date: Wed, 18 Mar 2026 20:39:25 +0000
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
Message-ID: <330f3614-7dc1-4e80-96c4-8472b25108bb@lucifer.local>
References: <cover.1773695307.git.ljs@kernel.org>
 <1e58aaf3cdb61cc317d890c12c9a558dfc206913.1773695307.git.ljs@kernel.org>
 <CAJuCfpGocCSRT0yDxPOLg2NZ+W_ZSTjHGPZRKBd3U90=sQtHCw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpGocCSRT0yDxPOLg2NZ+W_ZSTjHGPZRKBd3U90=sQtHCw@mail.gmail.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9533-lists,linux-hyperv=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,lwn.net,ladisch.de,arndb.de,linuxfoundation.org,microsoft.com,kernel.org,linux.intel.com,gmail.com,foss.st.com,bootlin.com,nod.at,ti.com,oracle.com,redhat.com,auristor.com,zeniv.linux.org.uk,suse.cz,suse.com,google.com,suse.de,vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org,lists.linux.dev,kvack.org,arm.com];
	RCPT_COUNT_TWELVE(0.00)[44];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.964];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ljs@kernel.org,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lucifer.local:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 637712C28DD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 16, 2026 at 09:14:28PM -0700, Suren Baghdasaryan wrote:
> On Mon, Mar 16, 2026 at 2:13 PM Lorenzo Stoakes (Oracle) <ljs@kernel.org> wrote:
> >
> > Currently drivers use vm_iomap_memory() as a simple helper function for
> > I/O remapping memory over a range starting at a specified physical address
> > over a specified length.
> >
> > In order to utilise this from mmap_prepare, separate out the core logic
> > into __simple_ioremap_prep(), update vm_iomap_memory() to use it, and add
> > simple_ioremap_prepare() to do the same with a VMA descriptor object.
> >
> > We also add MMAP_SIMPLE_IO_REMAP and relevant fields to the struct
> > mmap_action type to permit this operation also.
> >
> > We use mmap_action_ioremap() to set up the actual I/O remap operation once
> > we have checked and figured out the parameters, which makes
> > simple_ioremap_prepare() easy to implement.
> >
> > We then add mmap_action_simple_ioremap() to allow drivers to make use of
> > this mode.
> >
> > We update the mmap_prepare documentation to describe this mode.
> >
> > Finally, we update the VMA tests to reflect this change.
> >
> > Signed-off-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>
>
> A couple of nits, but otherwise LGTM.
>
> Reviewed-by: Suren Baghdasaryan <surenb@google.com>

Thanks!

>
> > ---
> >  Documentation/filesystems/mmap_prepare.rst |  3 +
> >  include/linux/mm.h                         | 24 +++++-
> >  include/linux/mm_types.h                   |  6 +-
> >  mm/internal.h                              |  2 +
> >  mm/memory.c                                | 87 +++++++++++++++-------
> >  mm/util.c                                  | 12 +++
> >  tools/testing/vma/include/dup.h            |  6 +-
> >  7 files changed, 112 insertions(+), 28 deletions(-)
> >
> > diff --git a/Documentation/filesystems/mmap_prepare.rst b/Documentation/filesystems/mmap_prepare.rst
> > index 20db474915da..be76ae475b9c 100644
> > --- a/Documentation/filesystems/mmap_prepare.rst
> > +++ b/Documentation/filesystems/mmap_prepare.rst
> > @@ -153,5 +153,8 @@ pointer. These are:
> >  * mmap_action_ioremap_full() - Same as mmap_action_ioremap(), only remaps
> >    the entire mapping from ``start_pfn`` onward.
> >
> > +* mmap_action_simple_ioremap() - Sets up an I/O remap from a specified
> > +  physical address and over a specified length.
> > +
> >  **NOTE:** The ``action`` field should never normally be manipulated directly,
> >  rather you ought to use one of these helpers.
> > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > index ad1b8c3c0cfd..df8fa6e6402b 100644
> > --- a/include/linux/mm.h
> > +++ b/include/linux/mm.h
> > @@ -4337,11 +4337,33 @@ static inline void mmap_action_ioremap(struct vm_area_desc *desc,
> >   * @start_pfn: The first PFN in the range to remap.
> >   */
> >  static inline void mmap_action_ioremap_full(struct vm_area_desc *desc,
> > -                                         unsigned long start_pfn)
> > +                                           unsigned long start_pfn)
> >  {
> >         mmap_action_ioremap(desc, desc->start, start_pfn, vma_desc_size(desc));
> >  }
> >
> > +/**
> > + * mmap_action_simple_ioremap - helper for mmap_prepare hook to specify that the
> > + * physical range in [start_phys_addr, start_phys_addr + size) should be I/O
> > + * remapped.
> > + * @desc: The VMA descriptor for the VMA requiring remap.
> > + * @start_phys_addr: Start of the physical memory to be mapped.
> > + * @size: Size of the area to map.
> > + *
> > + * NOTE: Some drivers might want to tweak desc->page_prot for purposes of
> > + * write-combine or similar.
> > + */
> > +static inline void mmap_action_simple_ioremap(struct vm_area_desc *desc,
> > +                                             phys_addr_t start_phys_addr,
> > +                                             unsigned long size)
> > +{
> > +       struct mmap_action *action = &desc->action;
> > +
> > +       action->simple_ioremap.start_phys_addr = start_phys_addr;
> > +       action->simple_ioremap.size = size;
> > +       action->type = MMAP_SIMPLE_IO_REMAP;
> > +}
> > +
> >  int mmap_action_prepare(struct vm_area_desc *desc);
> >  int mmap_action_complete(struct vm_area_struct *vma,
> >                          struct mmap_action *action);
> > diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> > index 4a229cc0a06b..50685cf29792 100644
> > --- a/include/linux/mm_types.h
> > +++ b/include/linux/mm_types.h
> > @@ -814,6 +814,7 @@ enum mmap_action_type {
> >         MMAP_NOTHING,           /* Mapping is complete, no further action. */
> >         MMAP_REMAP_PFN,         /* Remap PFN range. */
> >         MMAP_IO_REMAP_PFN,      /* I/O remap PFN range. */
> > +       MMAP_SIMPLE_IO_REMAP,   /* I/O remap with guardrails. */
> >  };
> >
> >  /*
> > @@ -822,13 +823,16 @@ enum mmap_action_type {
> >   */
> >  struct mmap_action {
> >         union {
> > -               /* Remap range. */
> >                 struct {
> >                         unsigned long start;
> >                         unsigned long start_pfn;
> >                         unsigned long size;
> >                         pgprot_t pgprot;
> >                 } remap;
> > +               struct {
> > +                       phys_addr_t start_phys_addr;
> > +                       unsigned long size;
> > +               } simple_ioremap;
> >         };
> >         enum mmap_action_type type;
> >
> > diff --git a/mm/internal.h b/mm/internal.h
> > index f5774892071e..0eaca2f0eb6a 100644
> > --- a/mm/internal.h
> > +++ b/mm/internal.h
> > @@ -1804,6 +1804,8 @@ int dup_mmap(struct mm_struct *mm, struct mm_struct *oldmm);
> >  int remap_pfn_range_prepare(struct vm_area_desc *desc);
> >  int remap_pfn_range_complete(struct vm_area_struct *vma,
> >                              struct mmap_action *action);
> > +int simple_ioremap_prepare(struct vm_area_desc *desc);
> > +/* No simple_ioremap_complete, is ultimately handled by remap complete. */
> >
> >  static inline int io_remap_pfn_range_prepare(struct vm_area_desc *desc)
> >  {
> > diff --git a/mm/memory.c b/mm/memory.c
> > index 9dec67a18116..f3f4046aee97 100644
> > --- a/mm/memory.c
> > +++ b/mm/memory.c
> > @@ -3170,6 +3170,59 @@ int remap_pfn_range_complete(struct vm_area_struct *vma,
> >         return do_remap_pfn_range(vma, start, pfn, size, prot);
> >  }
> >
> > +static int __simple_ioremap_prep(unsigned long vm_start, unsigned long vm_end,
>
> nit: vm_start and vm_end are used only to calculate vm_len. You could
> reduce the number of arguments by just passing vm_len.

Ack will fixup!

>
> > +                                pgoff_t vm_pgoff, phys_addr_t start_phys,
> > +                                unsigned long size, unsigned long *pfnp)
> > +{
> > +       const unsigned long vm_len = vm_end - vm_start;
> > +       unsigned long pfn, pages;
> > +
> > +       /* Check that the physical memory area passed in looks valid */
> > +       if (start_phys + size < start_phys)
> > +               return -EINVAL;
> > +       /*
> > +        * You *really* shouldn't map things that aren't page-aligned,
> > +        * but we've historically allowed it because IO memory might
> > +        * just have smaller alignment.
> > +        */
> > +       size += start_phys & ~PAGE_MASK;
> > +       pfn = start_phys >> PAGE_SHIFT;
> > +       pages = (size + ~PAGE_MASK) >> PAGE_SHIFT;
> > +       if (pfn + pages < pfn)
> > +               return -EINVAL;
> > +
> > +       /* We start the mapping 'vm_pgoff' pages into the area */
> > +       if (vm_pgoff > pages)
> > +               return -EINVAL;
> > +       pfn += vm_pgoff;
> > +       pages -= vm_pgoff;
> > +
> > +       /* Can we fit all of the mapping? */
> > +       if ((vm_len >> PAGE_SHIFT) > pages)
> > +               return -EINVAL;
> > +
> > +       *pfnp = pfn;
> > +       return 0;
> > +}
> > +
> > +int simple_ioremap_prepare(struct vm_area_desc *desc)
> > +{
> > +       struct mmap_action *action = &desc->action;
> > +       const phys_addr_t start = action->simple_ioremap.start_phys_addr;
> > +       const unsigned long size = action->simple_ioremap.size;
> > +       unsigned long pfn;
> > +       int err;
> > +
> > +       err = __simple_ioremap_prep(desc->start, desc->end, desc->pgoff,
> > +                                   start, size, &pfn);
> > +       if (err)
> > +               return err;
> > +
> > +       /* The I/O remap logic does the heavy lifting. */
> > +       mmap_action_ioremap(desc, desc->start, pfn, vma_desc_size(desc));
>
> nit: Looks like a perfect opportunity to use mmap_action_ioremap_full() here.

Yeah can do!

>
> > +       return mmap_action_prepare(desc);
>
> Ok, so IIUC this uses recursion:
> mmap_action_prepare(MMAP_SIMPLE_IO_REMAP) -> simple_ioremap_prepare()
> -> mmap_action_prepare(MMAP_IO_REMAP_PFN).

Yep, it's one level, I think that should be ok? :)

>
> > +}
> > +
> >  /**
> >   * vm_iomap_memory - remap memory to userspace
> >   * @vma: user vma to map to
> > @@ -3187,32 +3240,16 @@ int remap_pfn_range_complete(struct vm_area_struct *vma,
> >   */
> >  int vm_iomap_memory(struct vm_area_struct *vma, phys_addr_t start, unsigned long len)
> >  {
> > -       unsigned long vm_len, pfn, pages;
> > -
> > -       /* Check that the physical memory area passed in looks valid */
> > -       if (start + len < start)
> > -               return -EINVAL;
> > -       /*
> > -        * You *really* shouldn't map things that aren't page-aligned,
> > -        * but we've historically allowed it because IO memory might
> > -        * just have smaller alignment.
> > -        */
> > -       len += start & ~PAGE_MASK;
> > -       pfn = start >> PAGE_SHIFT;
> > -       pages = (len + ~PAGE_MASK) >> PAGE_SHIFT;
> > -       if (pfn + pages < pfn)
> > -               return -EINVAL;
> > -
> > -       /* We start the mapping 'vm_pgoff' pages into the area */
> > -       if (vma->vm_pgoff > pages)
> > -               return -EINVAL;
> > -       pfn += vma->vm_pgoff;
> > -       pages -= vma->vm_pgoff;
> > +       const unsigned long vm_start = vma->vm_start;
> > +       const unsigned long vm_end = vma->vm_end;
> > +       const unsigned long vm_len = vm_end - vm_start;
> > +       unsigned long pfn;
> > +       int err;
> >
> > -       /* Can we fit all of the mapping? */
> > -       vm_len = vma->vm_end - vma->vm_start;
> > -       if (vm_len >> PAGE_SHIFT > pages)
> > -               return -EINVAL;
> > +       err = __simple_ioremap_prep(vm_start, vm_end, vma->vm_pgoff, start,
> > +                                   len, &pfn);
> > +       if (err)
> > +               return err;
> >
> >         /* Ok, let it rip */
> >         return io_remap_pfn_range(vma, vma->vm_start, pfn, vm_len, vma->vm_page_prot);
> > diff --git a/mm/util.c b/mm/util.c
> > index cdfba09e50d7..aa92e471afe1 100644
> > --- a/mm/util.c
> > +++ b/mm/util.c
> > @@ -1390,6 +1390,8 @@ int mmap_action_prepare(struct vm_area_desc *desc)
> >                 return remap_pfn_range_prepare(desc);
> >         case MMAP_IO_REMAP_PFN:
> >                 return io_remap_pfn_range_prepare(desc);
> > +       case MMAP_SIMPLE_IO_REMAP:
> > +               return simple_ioremap_prepare(desc);
> >         }
> >
> >         WARN_ON_ONCE(1);
> > @@ -1421,6 +1423,14 @@ int mmap_action_complete(struct vm_area_struct *vma,
> >         case MMAP_IO_REMAP_PFN:
> >                 err = io_remap_pfn_range_complete(vma, action);
> >                 break;
> > +       case MMAP_SIMPLE_IO_REMAP:
> > +               /*
> > +                * The simple I/O remap should have been delegated to an I/O
> > +                * remap.
> > +                */
> > +               WARN_ON_ONCE(1);
> > +               err = -EINVAL;
> > +               break;
> >         }
> >
> >         return mmap_action_finish(vma, action, err);
> > @@ -1434,6 +1444,7 @@ int mmap_action_prepare(struct vm_area_desc *desc)
> >                 break;
> >         case MMAP_REMAP_PFN:
> >         case MMAP_IO_REMAP_PFN:
> > +       case MMAP_SIMPLE_IO_REMAP:
> >                 WARN_ON_ONCE(1); /* nommu cannot handle these. */
> >                 break;
> >         }
> > @@ -1452,6 +1463,7 @@ int mmap_action_complete(struct vm_area_struct *vma,
> >                 break;
> >         case MMAP_REMAP_PFN:
> >         case MMAP_IO_REMAP_PFN:
> > +       case MMAP_SIMPLE_IO_REMAP:
> >                 WARN_ON_ONCE(1); /* nommu cannot handle this. */
> >
> >                 err = -EINVAL;
> > diff --git a/tools/testing/vma/include/dup.h b/tools/testing/vma/include/dup.h
> > index 4570ec77f153..114daaef4f73 100644
> > --- a/tools/testing/vma/include/dup.h
> > +++ b/tools/testing/vma/include/dup.h
> > @@ -453,6 +453,7 @@ enum mmap_action_type {
> >         MMAP_NOTHING,           /* Mapping is complete, no further action. */
> >         MMAP_REMAP_PFN,         /* Remap PFN range. */
> >         MMAP_IO_REMAP_PFN,      /* I/O remap PFN range. */
> > +       MMAP_SIMPLE_IO_REMAP,   /* I/O remap with guardrails. */
> >  };
> >> >  /*
> > @@ -461,13 +462,16 @@ enum mmap_action_type {
> >   */
> >  struct mmap_action {
> >         union {
> > -               /* Remap range. */
> >                 struct {
> >                         unsigned long start;
> >                         unsigned long start_pfn;
> >                         unsigned long size;
> >                         pgprot_t pgprot;
> >                 } remap;
> > +               struct {
> > +                       phys_addr_t start;
> > +                       unsigned long len;
> > +               } simple_ioremap;
> >         };
> >         enum mmap_action_type type;
> >
> > --
> > 2.53.0
> >

Cheers, Lorenzo

