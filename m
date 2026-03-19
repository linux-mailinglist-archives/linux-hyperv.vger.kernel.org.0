Return-Path: <linux-hyperv+bounces-9546-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YHs5BGcOvGkirwIAu9opvQ
	(envelope-from <linux-hyperv+bounces-9546-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2026 15:55:35 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A8A002CD434
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2026 15:55:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AEB0C300D924
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2026 14:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8FDA3DCD84;
	Thu, 19 Mar 2026 14:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DWK1/jLt"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B16B43D9DC0;
	Thu, 19 Mar 2026 14:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773932102; cv=none; b=liljrbxCpwZqIReqNOj++2clH1wN690cUMqrOmZntYiNuGXEMF0iUwBduuibqCqbsW11q2Xvy+FkIDVIi6b4xZEDwyPKLP5DPDUopTTt36Y8pVlEWFfFa/3TMbrhWEr9AznsGyqUsbHBK4bCYx8N2JmE6n1ppc2ml4QHyptKXWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773932102; c=relaxed/simple;
	bh=vZULXEbqvj9XMh1iYVr0JxZ7kXOOtLBngxqmvXJyFD8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CkcjakwC0OOnM5DLfbCujwxbcz3uvf+1srXbTtLYqt8vyRX6SgyYKzh00FM75/dr9Ydg4RusDe0Rtv8wLwewG4Gu9ujKKjEtzwo+oUBXipcRRHrb95qynjvThkfDL1Cv+vxsZoN4UIywwqQbBHHIJNKVfUImYfJChSJwtc9QsZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DWK1/jLt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA46BC19424;
	Thu, 19 Mar 2026 14:55:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773932102;
	bh=vZULXEbqvj9XMh1iYVr0JxZ7kXOOtLBngxqmvXJyFD8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DWK1/jLtFiueTNNf0pKNXUf0Wa+NCtGhMgYPS/t0qA9zA1dxoc4Ik3Nf5HFoaRTlI
	 ZwECl51xgnBi+rSjBkwE9ujeqvhnhxXTEQUH4rRcDnoW4wKG+gPiRa4Kg/HMH5dRAw
	 2PhCk0R4iSLNJBmtXcgsUFCEmb5vCcz/NqSeir7Y/POHMXx0jlq7aZCe5pHNH0vP3M
	 KOZzMRHcg2i1C+Sb7X7aeYo4lLhsHzNPVMAtbUovXYUwi2SRf2nJuhsGJNx8DqdxGw
	 kjjsd8A9g0s19vG6z1+5nKRV/txEbuDzgBGRKOoZHEjirW/6VCeDwwWCUiwBJ6YC+Q
	 YjwfuxBcKb4Lw==
Date: Thu, 19 Mar 2026 14:54:59 +0000
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
Subject: Re: [PATCH v2 11/16] staging: vme_user: replace deprecated mmap hook
 with mmap_prepare
Message-ID: <8cdad898-b306-40fe-a367-efe7147f83b9@lucifer.local>
References: <cover.1773695307.git.ljs@kernel.org>
 <48c6d25e374b57dba6df4fdddd4830d3fc1105be.1773695307.git.ljs@kernel.org>
 <CAJuCfpFXuHg4KPY27pqMC-xV5y9ZY2W72_R8_rxO0DvrJ=_yvw@mail.gmail.com>
 <CAJuCfpE5qZmi43EeZiRcy78pD6YvJb5n_xnoUJfwEjomowu0=A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpE5qZmi43EeZiRcy78pD6YvJb5n_xnoUJfwEjomowu0=A@mail.gmail.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9546-lists,linux-hyperv=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,lwn.net,ladisch.de,arndb.de,linuxfoundation.org,microsoft.com,kernel.org,linux.intel.com,gmail.com,foss.st.com,bootlin.com,nod.at,ti.com,oracle.com,redhat.com,auristor.com,zeniv.linux.org.uk,suse.cz,suse.com,google.com,suse.de,vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org,lists.linux.dev,kvack.org,arm.com];
	RCPT_COUNT_TWELVE(0.00)[44];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.960];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ljs@kernel.org,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A8A002CD434
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 17, 2026 at 02:32:16PM -0700, Suren Baghdasaryan wrote:
> On Tue, Mar 17, 2026 at 2:26 PM Suren Baghdasaryan <surenb@google.com> wrote:
> >
> > On Mon, Mar 16, 2026 at 2:14 PM Lorenzo Stoakes (Oracle) <ljs@kernel.org> wrote:
> > >
> > > The f_op->mmap interface is deprecated, so update driver to use its
> > > successor, mmap_prepare.
> > >
> > > The driver previously used vm_iomap_memory(), so this change replaces it
> > > with its mmap_prepare equivalent, mmap_action_simple_ioremap().
> > >
> > > Functions that wrap mmap() are also converted to wrap mmap_prepare()
> > > instead.
> > >
> > > Also update the documentation accordingly.
> > >
> > > Signed-off-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>
> > > ---
> > >  Documentation/driver-api/vme.rst    |  2 +-
> > >  drivers/staging/vme_user/vme.c      | 20 +++++------
> > >  drivers/staging/vme_user/vme.h      |  2 +-
> > >  drivers/staging/vme_user/vme_user.c | 51 +++++++++++++++++------------
> > >  4 files changed, 42 insertions(+), 33 deletions(-)
> > >
> > > diff --git a/Documentation/driver-api/vme.rst b/Documentation/driver-api/vme.rst
> > > index c0b475369de0..7111999abc14 100644
> > > --- a/Documentation/driver-api/vme.rst
> > > +++ b/Documentation/driver-api/vme.rst
> > > @@ -107,7 +107,7 @@ The function :c:func:`vme_master_read` can be used to read from and
> > >
> > >  In addition to simple reads and writes, :c:func:`vme_master_rmw` is provided to
> > >  do a read-modify-write transaction. Parts of a VME window can also be mapped
> > > -into user space memory using :c:func:`vme_master_mmap`.
> > > +into user space memory using :c:func:`vme_master_mmap_prepare`.
> > >
> > >
> > >  Slave windows
> > > diff --git a/drivers/staging/vme_user/vme.c b/drivers/staging/vme_user/vme.c
> > > index f10a00c05f12..7220aba7b919 100644
> > > --- a/drivers/staging/vme_user/vme.c
> > > +++ b/drivers/staging/vme_user/vme.c
> > > @@ -735,9 +735,9 @@ unsigned int vme_master_rmw(struct vme_resource *resource, unsigned int mask,
> > >  EXPORT_SYMBOL(vme_master_rmw);
> > >
> > >  /**
> > > - * vme_master_mmap - Mmap region of VME master window.
> > > + * vme_master_mmap_prepare - Mmap region of VME master window.
> > >   * @resource: Pointer to VME master resource.
> > > - * @vma: Pointer to definition of user mapping.
> > > + * @desc: Pointer to descriptor of user mapping.
> > >   *
> > >   * Memory map a region of the VME master window into user space.
> > >   *
> > > @@ -745,12 +745,13 @@ EXPORT_SYMBOL(vme_master_rmw);
> > >   *         resource or -EFAULT if map exceeds window size. Other generic mmap
> > >   *         errors may also be returned.
> > >   */
> > > -int vme_master_mmap(struct vme_resource *resource, struct vm_area_struct *vma)
> > > +int vme_master_mmap_prepare(struct vme_resource *resource,
> > > +                           struct vm_area_desc *desc)
> > >  {
> > > +       const unsigned long vma_size = vma_desc_size(desc);
> > >         struct vme_bridge *bridge = find_bridge(resource);
> > >         struct vme_master_resource *image;
> > >         phys_addr_t phys_addr;
> > > -       unsigned long vma_size;
> > >
> > >         if (resource->type != VME_MASTER) {
> > >                 dev_err(bridge->parent, "Not a master resource\n");
> > > @@ -758,19 +759,18 @@ int vme_master_mmap(struct vme_resource *resource, struct vm_area_struct *vma)
> > >         }
> > >
> > >         image = list_entry(resource->entry, struct vme_master_resource, list);
> > > -       phys_addr = image->bus_resource.start + (vma->vm_pgoff << PAGE_SHIFT);
> > > -       vma_size = vma->vm_end - vma->vm_start;
> > > +       phys_addr = image->bus_resource.start + (desc->pgoff << PAGE_SHIFT);
> > >
> > >         if (phys_addr + vma_size > image->bus_resource.end + 1) {
> > >                 dev_err(bridge->parent, "Map size cannot exceed the window size\n");
> > >                 return -EFAULT;
> > >         }
> > >
> > > -       vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
> > > -
> > > -       return vm_iomap_memory(vma, phys_addr, vma->vm_end - vma->vm_start);
> > > +       desc->page_prot = pgprot_noncached(desc->page_prot);
> > > +       mmap_action_simple_ioremap(desc, phys_addr, vma_size);
> > > +       return 0;
> > >  }
> > > -EXPORT_SYMBOL(vme_master_mmap);
> > > +EXPORT_SYMBOL(vme_master_mmap_prepare);
> > >
> > >  /**
> > >   * vme_master_free - Free VME master window
> > > diff --git a/drivers/staging/vme_user/vme.h b/drivers/staging/vme_user/vme.h
> > > index 797e9940fdd1..b6413605ea49 100644
> > > --- a/drivers/staging/vme_user/vme.h
> > > +++ b/drivers/staging/vme_user/vme.h
> > > @@ -151,7 +151,7 @@ ssize_t vme_master_read(struct vme_resource *resource, void *buf, size_t count,
> > >  ssize_t vme_master_write(struct vme_resource *resource, void *buf, size_t count, loff_t offset);
> > >  unsigned int vme_master_rmw(struct vme_resource *resource, unsigned int mask, unsigned int compare,
> > >                             unsigned int swap, loff_t offset);
> > > -int vme_master_mmap(struct vme_resource *resource, struct vm_area_struct *vma);
> > > +int vme_master_mmap_prepare(struct vme_resource *resource, struct vm_area_desc *desc);
> > >  void vme_master_free(struct vme_resource *resource);
> > >
> > >  struct vme_resource *vme_dma_request(struct vme_dev *vdev, u32 route);
> > > diff --git a/drivers/staging/vme_user/vme_user.c b/drivers/staging/vme_user/vme_user.c
> > > index d95dd7d9190a..11e25c2f6b0a 100644
> > > --- a/drivers/staging/vme_user/vme_user.c
> > > +++ b/drivers/staging/vme_user/vme_user.c
> > > @@ -446,24 +446,14 @@ static void vme_user_vm_close(struct vm_area_struct *vma)
> > >         kfree(vma_priv);
> > >  }
> > >
> > > -static const struct vm_operations_struct vme_user_vm_ops = {
> > > -       .open = vme_user_vm_open,
> > > -       .close = vme_user_vm_close,
> > > -};
> > > -
> > > -static int vme_user_master_mmap(unsigned int minor, struct vm_area_struct *vma)
> > > +static int vme_user_vm_mapped(unsigned long start, unsigned long end, pgoff_t pgoff,
> > > +                             const struct file *file, void **vm_private_data)
> > >  {
> > > -       int err;
> > > +       const unsigned int minor = iminor(file_inode(file));
> > >         struct vme_user_vma_priv *vma_priv;
> > >
> > >         mutex_lock(&image[minor].mutex);
> > >
> > > -       err = vme_master_mmap(image[minor].resource, vma);
> > > -       if (err) {
> > > -               mutex_unlock(&image[minor].mutex);
> > > -               return err;
> > > -       }
> > > -
> >
> > Ok, this changes the set of the operations performed under image[minor].mutex.
> > Before we had:
> >
> > mutex_lock(&image[minor].mutex);
> > vme_master_mmap();
> > <some final adjustments>
> > mutex_unlock(&image[minor].mutex);
> >
> > Now we have:
> >
> > mutex_lock(&image[minor].mutex);
> > vme_master_mmap_prepare()
> > mutex_unlock(&image[minor].mutex);
> > vm_iomap_memory();
> > mutex_lock(&image[minor].mutex);
> > vme_user_vm_mapped(); // <some final adjustments>
> > mutex_unlock(&image[minor].mutex);
> >
> > I think as long as image[minor] does not change while we are not
> > holding the mutex we should be safe, and looking at the code it seems
> > to be the case. But I'm not familiar with this driver and might be
> > wrong. Worth double-checking.

The file is pinned for the duration, the mutex is associated with the file,
so there's no sane world in which that could be problematic.

Keeping in mind that we manipulate stuff on vme_user_vm_close() that
directly acceses image[minor] at an arbitary time.

>
> A side note: if we had to hold the mutex across all those operations I
> think we would need to take the mutex in the vm_ops->mmap_prepare and
> add a vm_ops->map_failed hook or something along that line to drop the
> mutex in case mmap_action_complete() fails. Not sure if we will have
> such cases though...

No, I don't want to do this if it can be at all avoided. You should in
nearly any sane circumstance be able to defer things until the mapped hook
anyway.

Also a merge can happen too after an .mmap_prepare, so we'd have to have
some 'success' hook and I'm just not going there it'll end up open to abuse
again.

(We do have success and error filtering hooks right now, sadly, but they're
really for hugetlb and I plan to find a way to get rid of them).

The mmap_prepare is meant to essentially be as stateless as possible.

Anyway I don't think it's relevant here.

>
> >
> > >         vma_priv = kmalloc_obj(*vma_priv);
> > >         if (!vma_priv) {
> > >                 mutex_unlock(&image[minor].mutex);
> > > @@ -472,22 +462,41 @@ static int vme_user_master_mmap(unsigned int minor, struct vm_area_struct *vma)
> > >
> > >         vma_priv->minor = minor;
> > >         refcount_set(&vma_priv->refcnt, 1);
> > > -       vma->vm_ops = &vme_user_vm_ops;
> > > -       vma->vm_private_data = vma_priv;
> > > -
> > > +       *vm_private_data = vma_priv;
> > >         image[minor].mmap_count++;
> > >
> > >         mutex_unlock(&image[minor].mutex);
> > > -
> > >         return 0;
> > >  }
> > >
> > > -static int vme_user_mmap(struct file *file, struct vm_area_struct *vma)
> > > +static const struct vm_operations_struct vme_user_vm_ops = {
> > > +       .mapped = vme_user_vm_mapped,
> > > +       .open = vme_user_vm_open,
> > > +       .close = vme_user_vm_close,
> > > +};
> > > +
> > > +static int vme_user_master_mmap_prepare(unsigned int minor,
> > > +                                       struct vm_area_desc *desc)
> > > +{
> > > +       int err;
> > > +
> > > +       mutex_lock(&image[minor].mutex);
> > > +
> > > +       err = vme_master_mmap_prepare(image[minor].resource, desc);
> > > +       if (!err)
> > > +               desc->vm_ops = &vme_user_vm_ops;
> > > +
> > > +       mutex_unlock(&image[minor].mutex);
> > > +       return err;
> > > +}
> > > +
> > > +static int vme_user_mmap_prepare(struct vm_area_desc *desc)
> > >  {
> > > -       unsigned int minor = iminor(file_inode(file));
> > > +       const struct file *file = desc->file;
> > > +       const unsigned int minor = iminor(file_inode(file));
> > >
> > >         if (type[minor] == MASTER_MINOR)
> > > -               return vme_user_master_mmap(minor, vma);
> > > +               return vme_user_master_mmap_prepare(minor, desc);
> > >
> > >         return -ENODEV;
> > >  }
> > > @@ -498,7 +507,7 @@ static const struct file_operations vme_user_fops = {
> > >         .llseek = vme_user_llseek,
> > >         .unlocked_ioctl = vme_user_unlocked_ioctl,
> > >         .compat_ioctl = compat_ptr_ioctl,
> > > -       .mmap = vme_user_mmap,
> > > +       .mmap_prepare = vme_user_mmap_prepare,
> > >  };
> > >
> > >  static int vme_user_match(struct vme_dev *vdev)
> > > --
> > > 2.53.0
> > >

Cheers, Lorenzo

