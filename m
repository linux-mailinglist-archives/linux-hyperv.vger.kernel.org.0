Return-Path: <linux-hyperv+bounces-9437-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WKBjEjEIuGkWYQEAu9opvQ
	(envelope-from <linux-hyperv+bounces-9437-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 16 Mar 2026 14:40:01 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DA73629A992
	for <lists+linux-hyperv@lfdr.de>; Mon, 16 Mar 2026 14:40:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AB9573012E76
	for <lists+linux-hyperv@lfdr.de>; Mon, 16 Mar 2026 13:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFBD339A045;
	Mon, 16 Mar 2026 13:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qeJUdw27"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873EB396595;
	Mon, 16 Mar 2026 13:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773668378; cv=none; b=F6ttCIzDq9hnr903E48D1eILPK4oI1SQMzco+sBfRicSYpTkBvm2iK3uu8sgvSDt2g1e7hFfSM1ALXV7dWP63NfqMm4sQcYeTc55/DN39GuY76VeuG4Cx1x3teSgGQNW6vr12DrfzHNKxv7bMS1QksuQWOEI7g6LFgGmYYscOFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773668378; c=relaxed/simple;
	bh=MUmCrmxu05s9AvqYAorOyyHRWqn+I/83N36MXNhG62o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tQ0nvUcyNQugjb9PpGgPKo2p12NdTxYut59BhAwxlf10T2R9ew9Cv5AxhN1T9h/GDrS0BEerG7JVgKqBHo5AioHHLmtuUXd5mBRE5rfS3WkNFTQ+MLZ7rQC3Py9T+m5rVQA0XluP22D3l+kmkxg1cy4U20E21toXcCXsU6kyjGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qeJUdw27; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 905ABC19421;
	Mon, 16 Mar 2026 13:39:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773668378;
	bh=MUmCrmxu05s9AvqYAorOyyHRWqn+I/83N36MXNhG62o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qeJUdw27EFKGmtMgL3F77KTf9VeB5D4szijSc5VS269FZnWNRKoCMj7Em7sxOyIp/
	 3ujoOzhLSN7JTh8MOBBCwZkWO0q+8REOCuaOq+6zBxVVLKl9mcUuHpNXxU2yLHiXum
	 ixj83TBwj0GglfR6kf6f92ucD/X2LKhM9H7gObjWQZDvULLMgzO4fAULlSD75nsq1t
	 JlLGhU7HRJM/Jx9mlgEz1UghLJgC/bHb8ZFQm7u80SOL0a7aXOsv0IdzqOh6Sx7+vw
	 MnYOS73oqbbe3qUP72hdThWdkXCYq7OdS9iq6E4eLtly04xHumDbJWKmQAM2RFXU9B
	 cO49QZ6nJQ9Ug==
Date: Mon, 16 Mar 2026 13:39:26 +0000
From: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: Usama Arif <usama.arif@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, Clemens Ladisch <clemens@ladisch.de>, 
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
Subject: Re: [PATCH 04/15] mm: add vm_ops->mapped hook
Message-ID: <1f3423d7-ee33-4639-a9a0-f722c7b8b6f1@lucifer.local>
References: <0e0fe47852e6009f662b1fa42f836447b8d1283a.1773346620.git.ljs@kernel.org>
 <20260313110238.2500603-1-usama.arif@linux.dev>
 <24cbbaf6-19f2-4403-8cb7-415007597345@lucifer.local>
 <CAJuCfpH1gzi50aWni7rh9=2gM8WwCzm=fY14DCFbjweAq82i6Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpH1gzi50aWni7rh9=2gM8WwCzm=fY14DCFbjweAq82i6Q@mail.gmail.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9437-lists,linux-hyperv=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[linux.dev,linux-foundation.org,ladisch.de,arndb.de,linuxfoundation.org,microsoft.com,kernel.org,linux.intel.com,gmail.com,foss.st.com,bootlin.com,nod.at,ti.com,oracle.com,redhat.com,auristor.com,zeniv.linux.org.uk,suse.cz,suse.com,google.com,suse.de,vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org,lists.linux.dev,kvack.org,arm.com];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ljs@kernel.org,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[44];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: DA73629A992
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, Mar 15, 2026 at 07:18:38PM -0700, Suren Baghdasaryan wrote:
> On Fri, Mar 13, 2026 at 4:58 AM Lorenzo Stoakes (Oracle) <ljs@kernel.org> wrote:
> >
> > On Fri, Mar 13, 2026 at 04:02:36AM -0700, Usama Arif wrote:
> > > On Thu, 12 Mar 2026 20:27:19 +0000 "Lorenzo Stoakes (Oracle)" <ljs@kernel.org> wrote:
> > >
> > > > Previously, when a driver needed to do something like establish a reference
> > > > count, it could do so in the mmap hook in the knowledge that the mapping
> > > > would succeed.
> > > >
> > > > With the introduction of f_op->mmap_prepare this is no longer the case, as
> > > > it is invoked prior to actually establishing the mapping.
> > > >
> > > > To take this into account, introduce a new vm_ops->mapped callback which is
> > > > invoked when the VMA is first mapped (though notably - not when it is
> > > > merged - which is correct and mirrors existing mmap/open/close behaviour).
> > > >
> > > > We do better that vm_ops->open() here, as this callback can return an
> > > > error, at which point the VMA will be unmapped.
> > > >
> > > > Note that vm_ops->mapped() is invoked after any mmap action is
> > > > complete (such as I/O remapping).
> > > >
> > > > We intentionally do not expose the VMA at this point, exposing only the
> > > > fields that could be used, and an output parameter in case the operation
> > > > needs to update the vma->vm_private_data field.
> > > >
> > > > In order to deal with stacked filesystems which invoke inner filesystem's
> > > > mmap() invocations, add __compat_vma_mapped() and invoke it on
> > > > vfs_mmap() (via compat_vma_mmap()) to ensure that the mapped callback is
> > > > handled when an mmap() caller invokes a nested filesystem's mmap_prepare()
> > > > callback.
> > > >
> > > > We can now also remove call_action_complete() and invoke
> > > > mmap_action_complete() directly, as we separate out the rmap lock logic to
> > > > be called in __mmap_region() instead via maybe_drop_file_rmap_lock().
> > > >
> > > > We also abstract unmapping of a VMA on mmap action completion into its own
> > > > helper function, unmap_vma_locked().
> > > >
> > > > Additionally, update VMA userland test headers to reflect the change.
> > > >
> > > > Signed-off-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>
> > > > ---
> > > >  include/linux/fs.h              |  9 +++-
> > > >  include/linux/mm.h              | 17 +++++++
> > > >  mm/internal.h                   | 10 ++++
> > > >  mm/util.c                       | 86 ++++++++++++++++++++++++---------
> > > >  mm/vma.c                        | 41 +++++++++++-----
> > > >  tools/testing/vma/include/dup.h | 34 ++++++++++++-
> > > >  6 files changed, 158 insertions(+), 39 deletions(-)
> > > >
> > > > diff --git a/include/linux/fs.h b/include/linux/fs.h
> > > > index a2628a12bd2b..c390f5c667e3 100644
> > > > --- a/include/linux/fs.h
> > > > +++ b/include/linux/fs.h
> > > > @@ -2059,13 +2059,20 @@ static inline bool can_mmap_file(struct file *file)
> > > >  }
> > > >
> > > >  int compat_vma_mmap(struct file *file, struct vm_area_struct *vma);
> > > > +int __vma_check_mmap_hook(struct vm_area_struct *vma);
> > > >
> > > >  static inline int vfs_mmap(struct file *file, struct vm_area_struct *vma)
> > > >  {
> > > > +   int err;
> > > > +
> > > >     if (file->f_op->mmap_prepare)
> > > >             return compat_vma_mmap(file, vma);
> > > >
> > > > -   return file->f_op->mmap(file, vma);
> > > > +   err = file->f_op->mmap(file, vma);
> > > > +   if (err)
> > > > +           return err;
> > > > +
> > > > +   return __vma_check_mmap_hook(vma);
> > > >  }
> > > >
> > > >  static inline int vfs_mmap_prepare(struct file *file, struct vm_area_desc *desc)
> > > > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > > > index 12a0b4c63736..7333d5db1221 100644
> > > > --- a/include/linux/mm.h
> > > > +++ b/include/linux/mm.h
> > > > @@ -759,6 +759,23 @@ struct vm_operations_struct {
> > > >      * Context: User context.  May sleep.  Caller holds mmap_lock.
> > > >      */
> > > >     void (*close)(struct vm_area_struct *vma);
> > > > +   /**
> > > > +    * @mapped: Called when the VMA is first mapped in the MM. Not called if
> > > > +    * the new VMA is merged with an adjacent VMA.
> > > > +    *
> > > > +    * The @vm_private_data field is an output field allowing the user to
> > > > +    * modify vma->vm_private_data as necessary.
> > > > +    *
> > > > +    * ONLY valid if set from f_op->mmap_prepare. Will result in an error if
> > > > +    * set from f_op->mmap.
> > > > +    *
> > > > +    * Returns %0 on success, or an error otherwise. On error, the VMA will
> > > > +    * be unmapped.
> > > > +    *
> > > > +    * Context: User context.  May sleep.  Caller holds mmap_lock.
> > > > +    */
> > > > +   int (*mapped)(unsigned long start, unsigned long end, pgoff_t pgoff,
> > > > +                 const struct file *file, void **vm_private_data);
> > > >     /* Called any time before splitting to check if it's allowed */
> > > >     int (*may_split)(struct vm_area_struct *vma, unsigned long addr);
> > > >     int (*mremap)(struct vm_area_struct *vma);
> > > > diff --git a/mm/internal.h b/mm/internal.h
> > > > index 7bfa85b5e78b..f0f2cf1caa36 100644
> > > > --- a/mm/internal.h
> > > > +++ b/mm/internal.h
> > > > @@ -158,6 +158,8 @@ static inline void *folio_raw_mapping(const struct folio *folio)
> > > >   * mmap hook and safely handle error conditions. On error, VMA hooks will be
> > > >   * mutated.
> > > >   *
> > > > + * IMPORTANT: f_op->mmap() is deprecated, prefer f_op->mmap_prepare().
> > > > + *
>
> What exactly would one do to "prefer f_op->mmap_prepare()"?

I'm saying a person should implement f_op->mmap_prepare() rather than
f_op->mmap(), since the latter is deprecated :)

I think that's pretty clear no?

> Since you are adding this comment for mmap_file(), I think you need to
> describe more specifically what one should call instead.

I think it'd be a complete distraction, since if you're at the point of calling
mmap_file() you're already not implement mmap_prepare except as a compatbility
layer.

I mean maybe I'll just drop this as it seems to be causing confusion.

>
> > > >   * @file: File which backs the mapping.
> > > >   * @vma:  VMA which we are mapping.
> > > >   *
> > > > @@ -201,6 +203,14 @@ static inline void vma_close(struct vm_area_struct *vma)
> > > >  /* unmap_vmas is in mm/memory.c */
> > > >  void unmap_vmas(struct mmu_gather *tlb, struct unmap_desc *unmap);
> > > >
> > > > +static inline void unmap_vma_locked(struct vm_area_struct *vma)
> > > > +{
> > > > +   const size_t len = vma_pages(vma) << PAGE_SHIFT;
> > > > +
> > > > +   mmap_assert_locked(vma->vm_mm);
>
> You must hold the mmap write lock when unmapping. Would be better to
> assert mmap_assert_write_locked() or even vma_assert_write_locked(),
> which implies mmap_assert_write_locked().

I'm not sure why we don't assert this in those paths.

I think I assumed we could only assert readonly because one of those paths
downgrades the mmap write lock to a read lock.

I don't think we can do a VMA write lock assert here, since at the point of
do_munmap() all callers can't possibly have the VMA write lock, since they are
_looking up_ the VMA at the specified address.

But I can convert this to an mmap_assert_write_locked()!

>
> > > > +   do_munmap(vma->vm_mm, vma->vm_start, len, NULL);
> > > > +}
> > > > +
> > > >  #ifdef CONFIG_MMU
> > > >
> > > >  static inline void get_anon_vma(struct anon_vma *anon_vma)
> > > > diff --git a/mm/util.c b/mm/util.c
> > > > index dba1191725b6..2b0ed54008d6 100644
> > > > --- a/mm/util.c
> > > > +++ b/mm/util.c
> > > > @@ -1163,6 +1163,55 @@ void flush_dcache_folio(struct folio *folio)
> > > >  EXPORT_SYMBOL(flush_dcache_folio);
> > > >  #endif
> > > >
> > > > +static int __compat_vma_mmap(struct file *file, struct vm_area_struct *vma)
> > > > +{
> > > > +   struct vm_area_desc desc = {
> > > > +           .mm = vma->vm_mm,
> > > > +           .file = file,
> > > > +           .start = vma->vm_start,
> > > > +           .end = vma->vm_end,
> > > > +
> > > > +           .pgoff = vma->vm_pgoff,
> > > > +           .vm_file = vma->vm_file,
> > > > +           .vma_flags = vma->flags,
> > > > +           .page_prot = vma->vm_page_prot,
> > > > +
> > > > +           .action.type = MMAP_NOTHING, /* Default */
> > > > +   };
> > > > +   int err;
> > > > +
> > > > +   err = vfs_mmap_prepare(file, &desc);
> > > > +   if (err)
> > > > +           return err;
> > > > +
> > > > +   err = mmap_action_prepare(&desc, &desc.action);
> > > > +   if (err)
> > > > +           return err;
> > > > +
> > > > +   set_vma_from_desc(vma, &desc);
> > > > +   return mmap_action_complete(vma, &desc.action);
> > > > +}
> > > > +
> > > > +static int __compat_vma_mapped(struct file *file, struct vm_area_struct *vma)
> > > > +{
> > > > +   const struct vm_operations_struct *vm_ops = vma->vm_ops;
> > > > +   void *vm_private_data = vma->vm_private_data;
> > > > +   int err;
> > > > +
> > > > +   if (!vm_ops->mapped)
> > > > +           return 0;
> > > > +
> > >
> > > Hello!
> > >
> > > Can vm_ops be NULL here?  __compat_vma_mapped() is called from
> > > compat_vma_mmap(), which is reached when a filesystem provides
> > > mmap_prepare.  If the mmap_prepare hook does not set desc->vm_ops,
> > > vma->vm_ops will be NULL and this dereferences a NULL pointer.
> >
> > I _think_ for this to ever be invoked, you would need to be dealing with a
> > file-backed VMA so vm_ops->fault would HAVE to be defined.
> >
> > But you're right anyway as a matter of principle we should check it! Will fix.
> >
> > >
> > > For e.g. drivers/char/mem.c, mmap_zero_prepare() would trigger
> > > a NULL pointer dereference here.
> > >
> > > Would need to do
> > >       if (!vm_ops || !vm_ops->mapped)
> > >               return 0;
> > >
> > > here
> >
> > Yes.
> >
> > >
> > >
> > > > +   err = vm_ops->mapped(vma->vm_start, vma->vm_end, vma->vm_pgoff, file,
> > > > +                        &vm_private_data);
> > > > +   if (err)
> > > > +           unmap_vma_locked(vma);
> > >
> > > when mapped() returns an error, unmap_vma_locked(vma) is called
> > > but execution continues into the vm_private_data update below.  After
> > > unmap_vma_locked() the VMA may be freed (do_munmap can remove the VMA
> > > entirely), so accessing vma->vm_private_data after that is a
> > > use-after-free.
> >
> > Very good point :) will fix thanks!
> >
> > Probably:
> >
> >         if (err)
> >                 unmap_vma_locked(vma);
> >         else if (vm_private_data != vma->vm_private_data)
> >                 vma->vm_private_data = vm_private_data;
> >
> >         return err;
> >
> > Would be fine.
> >
> > >
> > > Probably need to do:
> > >       if (err) {
> > >               unmap_vma_locked(vma);
> > >               return err;
> > >       }
> > >
> > > > +   /* Update private data if changed. */
> > > > +   if (vm_private_data != vma->vm_private_data)
> > > > +           vma->vm_private_data = vm_private_data;
> > > > +
> > > > +   return err;
> > > > +}
> > > > +
> > > >  /**
> > > >   * compat_vma_mmap() - Apply the file's .mmap_prepare() hook to an
> > > >   * existing VMA and execute any requested actions.
> > > > @@ -1191,34 +1240,26 @@ EXPORT_SYMBOL(flush_dcache_folio);
> > > >   */
> > > >  int compat_vma_mmap(struct file *file, struct vm_area_struct *vma)
> > > >  {
> > > > -   struct vm_area_desc desc = {
> > > > -           .mm = vma->vm_mm,
> > > > -           .file = file,
> > > > -           .start = vma->vm_start,
> > > > -           .end = vma->vm_end,
> > > > -
> > > > -           .pgoff = vma->vm_pgoff,
> > > > -           .vm_file = vma->vm_file,
> > > > -           .vma_flags = vma->flags,
> > > > -           .page_prot = vma->vm_page_prot,
> > > > -
> > > > -           .action.type = MMAP_NOTHING, /* Default */
> > > > -   };
> > > >     int err;
> > > >
> > > > -   err = vfs_mmap_prepare(file, &desc);
> > > > -   if (err)
> > > > -           return err;
> > > > -
> > > > -   err = mmap_action_prepare(&desc, &desc.action);
> > > > +   err = __compat_vma_mmap(file, vma);
> > > >     if (err)
> > > >             return err;
> > > >
> > > > -   set_vma_from_desc(vma, &desc);
> > > > -   return mmap_action_complete(vma, &desc.action);
> > > > +   return __compat_vma_mapped(file, vma);
> > > >  }
> > > >  EXPORT_SYMBOL(compat_vma_mmap);
> > > >
> > > > +int __vma_check_mmap_hook(struct vm_area_struct *vma)
> > > > +{
> > > > +   /* vm_ops->mapped is not valid if mmap() is specified. */
> > > > +   if (WARN_ON_ONCE(vma->vm_ops->mapped))
> > > > +           return -EINVAL;
> > >
> > > I think vma->vm_ops can be NULL here. Should be:
> > >
> > >       if (vma->vm_ops && WARN_ON_ONCE(vma->vm_ops->mapped))
> > >               return -EINVAL;
> >
> > I think again you'd probably only invoke this on file-backed so be ok, but again
> > as a matter of principle we should check it so will fix, thanks!
> >
> > >
> > > > +
> > > > +   return 0;
> > > > +}
> > > > +EXPORT_SYMBOL(__vma_check_mmap_hook);
>
> nit: Any reason __vma_check_mmap_hook() is not inlined next to its
> user vfs_mmap()?

Headers fun, fs.h is a 'before mm.h' header, so vm_operations_struct is not
declared yet here, so we can't actually do the check there.

>
> > > > +
> > > >  static void set_ps_flags(struct page_snapshot *ps, const struct folio *folio,
> > > >                      const struct page *page)
> > > >  {
> > > > @@ -1316,10 +1357,7 @@ static int mmap_action_finish(struct vm_area_struct *vma,
> > > >      * invoked if we do NOT merge, so we only clean up the VMA we created.
> > > >      */
> > > >     if (err) {
> > > > -           const size_t len = vma_pages(vma) << PAGE_SHIFT;
> > > > -
> > > > -           do_munmap(current->mm, vma->vm_start, len, NULL);
> > > > -
> > > > +           unmap_vma_locked(vma);
> > > >             if (action->error_hook) {
> > > >                     /* We may want to filter the error. */
> > > >                     err = action->error_hook(err);
> > > > diff --git a/mm/vma.c b/mm/vma.c
> > > > index 054cf1d262fb..ef9f5a5365d1 100644
> > > > --- a/mm/vma.c
> > > > +++ b/mm/vma.c
> > > > @@ -2705,21 +2705,35 @@ static bool can_set_ksm_flags_early(struct mmap_state *map)
> > > >     return false;
> > > >  }
> > > >
> > > > -static int call_action_complete(struct mmap_state *map,
> > > > -                           struct mmap_action *action,
> > > > -                           struct vm_area_struct *vma)
> > > > +static int call_mapped_hook(struct vm_area_struct *vma)
> > > >  {
> > > > -   int ret;
> > > > +   const struct vm_operations_struct *vm_ops = vma->vm_ops;
> > > > +   void *vm_private_data = vma->vm_private_data;
> > > > +   int err;
> > > >
> > > > -   ret = mmap_action_complete(vma, action);
> > > > +   if (!vm_ops || !vm_ops->mapped)
> > > > +           return 0;
> > > > +   err = vm_ops->mapped(vma->vm_start, vma->vm_end, vma->vm_pgoff,
> > > > +                        vma->vm_file, &vm_private_data);
> > > > +   if (err) {
> > > > +           unmap_vma_locked(vma);
> > > > +           return err;
> > > > +   }
> > > > +   /* Update private data if changed. */
> > > > +   if (vm_private_data != vma->vm_private_data)
> > > > +           vma->vm_private_data = vm_private_data;
> > > > +   return 0;
> > > > +}
> > > >
> > > > -   /* If we held the file rmap we need to release it. */
> > > > -   if (map->hold_file_rmap_lock) {
> > > > -           struct file *file = vma->vm_file;
> > > > +static void maybe_drop_file_rmap_lock(struct mmap_state *map,
> > > > +                                 struct vm_area_struct *vma)
> > > > +{
> > > > +   struct file *file;
> > > >
> > > > -           i_mmap_unlock_write(file->f_mapping);
> > > > -   }
> > > > -   return ret;
> > > > +   if (!map->hold_file_rmap_lock)
> > > > +           return;
> > > > +   file = vma->vm_file;
> > > > +   i_mmap_unlock_write(file->f_mapping);
> > > >  }
> > > >
> > > >  static unsigned long __mmap_region(struct file *file, unsigned long addr,
> > > > @@ -2773,8 +2787,11 @@ static unsigned long __mmap_region(struct file *file, unsigned long addr,
> > > >     __mmap_complete(&map, vma);
> > > >
> > > >     if (have_mmap_prepare && allocated_new) {
> > > > -           error = call_action_complete(&map, &desc.action, vma);
> > > > +           error = mmap_action_complete(vma, &desc.action);
> > > > +           if (!error)
> > > > +                   error = call_mapped_hook(vma);
> > > >
> > > > +           maybe_drop_file_rmap_lock(&map, vma);
> > > >             if (error)
> > > >                     return error;
> > > >     }
> > > > diff --git a/tools/testing/vma/include/dup.h b/tools/testing/vma/include/dup.h
> > > > index 908beb263307..47d8db809f31 100644
> > > > --- a/tools/testing/vma/include/dup.h
> > > > +++ b/tools/testing/vma/include/dup.h
> > > > @@ -606,12 +606,34 @@ struct vm_area_struct {
> > > >  } __randomize_layout;
> > > >
> > > >  struct vm_operations_struct {
> > > > -   void (*open)(struct vm_area_struct * area);
> > > > +   /**
> > > > +    * @open: Called when a VMA is remapped or split. Not called upon first
> > > > +    * mapping a VMA.
> > > > +    * Context: User context.  May sleep.  Caller holds mmap_lock.
> > > > +    */
>
> This comment should have been introduced in the previous patch.

It's the testing code, it's not really important. But if I respin I'll fix... :)

>
> > > > +   void (*open)(struct vm_area_struct *vma);
> > > >     /**
> > > >      * @close: Called when the VMA is being removed from the MM.
> > > >      * Context: User context.  May sleep.  Caller holds mmap_lock.
> > > >      */
> > > > -   void (*close)(struct vm_area_struct * area);
> > > > +   void (*close)(struct vm_area_struct *vma);
> > > > +   /**
> > > > +    * @mapped: Called when the VMA is first mapped in the MM. Not called if
> > > > +    * the new VMA is merged with an adjacent VMA.
> > > > +    *
> > > > +    * The @vm_private_data field is an output field allowing the user to
> > > > +    * modify vma->vm_private_data as necessary.
> > > > +    *
> > > > +    * ONLY valid if set from f_op->mmap_prepare. Will result in an error if
> > > > +    * set from f_op->mmap.
> > > > +    *
> > > > +    * Returns %0 on success, or an error otherwise. On error, the VMA will
> > > > +    * be unmapped.
> > > > +    *
> > > > +    * Context: User context.  May sleep.  Caller holds mmap_lock.
> > > > +    */
> > > > +   int (*mapped)(unsigned long start, unsigned long end, pgoff_t pgoff,
> > > > +                 const struct file *file, void **vm_private_data);
> > > >     /* Called any time before splitting to check if it's allowed */
> > > >     int (*may_split)(struct vm_area_struct *area, unsigned long addr);
> > > >     int (*mremap)(struct vm_area_struct *area);
> > > > @@ -1345,3 +1367,11 @@ static inline void vma_set_file(struct vm_area_struct *vma, struct file *file)
> > > >     swap(vma->vm_file, file);
> > > >     fput(file);
> > > >  }
> > > > +
> > > > +static inline void unmap_vma_locked(struct vm_area_struct *vma)
> > > > +{
> > > > +   const size_t len = vma_pages(vma) << PAGE_SHIFT;
> > > > +
> > > > +   mmap_assert_locked(vma->vm_mm);
> > > > +   do_munmap(vma->vm_mm, vma->vm_start, len, NULL);
> > > > +}
> > > > --
> > > > 2.53.0
> > > >
> > > >
> >
> > Cheers, Lorenzo

