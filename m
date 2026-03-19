Return-Path: <linux-hyperv+bounces-9551-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sEfINYQWvGnbrwIAu9opvQ
	(envelope-from <linux-hyperv+bounces-9551-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2026 16:30:12 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E78092CDBDF
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2026 16:30:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 11A22307993A
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2026 15:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D16353E51C4;
	Thu, 19 Mar 2026 15:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="APmyZl3o"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EBF13E0C48
	for <linux-hyperv@vger.kernel.org>; Thu, 19 Mar 2026 15:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773933593; cv=pass; b=BqpjcIA74Hwh5txJihREye96ExYUeE53O7P1zcoruCSP0yNLXPqNDPGMrG+4633r+/5QjKx0p365OdEIs7SYZtobY31TKnu+ZEspi3tLBwdpy7Zo0der5+F9xf8nLbSDFMavooDOzaAkqRad71Zap8NtrTkkSKBfrjNAnexz87M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773933593; c=relaxed/simple;
	bh=cd2Yc6Pq+XjnR/Goq5WKVux5mwTDBBwiKIMMeMo1T34=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pkjLskg7bETlgYfz3bJbJnSPmR35eDU8cftQHDXmB30gt5HKWDEIYT3Du05SUJXSP6Z8/zSFz/oPcPqAuQAc2/Mvil5xZXodCMw7bUiXv/MSlhjKy6UqiE4IQG0Kbkp0C0VJcwllLRLKyM60oq0K48+ro4MwjC5Uc6mr14GGXwc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=APmyZl3o; arc=pass smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-667365131b0so12342a12.0
        for <linux-hyperv@vger.kernel.org>; Thu, 19 Mar 2026 08:19:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773933590; cv=none;
        d=google.com; s=arc-20240605;
        b=Lbsqi3+yNqXTBfCGgDGbbZK6ql0EMa7EGlnZjYRE7VubfUt/Zv740jM0icMzbGJkc5
         Gz/QPA1PKAucoOO2cRr6fLSH/TpnSCHUjpi9HuKq2ZAC19ZONB0e8011oP5qwORacvJc
         pfe1n3o43TsC+sZ681R//jdiDawsHxT3QcmlbKVJoSxZTpitLRLUygtAHGQs73XjqFUD
         zeJS2QJJgB9bKWmBTOG6E/7jXVcZtxwVFEXK/2g+LW7BGrUBlxkHHHWa7vpr4j/hRJTY
         6fh2ChfMVI3m72Atup2dCUWr8nqCdKzx+sIlYPpDrsdUtkn5qcbAz1VOTx+pqoLSYk5n
         iJGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OfH8Q5Td26D2zz2vaWeEEQdnUyXBLu9cQNzXDyggGWs=;
        fh=ou5n41h4/rSzK/+bsM/7uJ1eYcJgSCooCwLfdp6VoF0=;
        b=VwcBkpSJlL5JAyTONEkRzHweFfgbz1rhxtlY/oOjP1GVRLcw2UJcj4QZwT+eH2f5ns
         azUVNyIVXQAKDKGBnm8DfQna61acum4k/O05RmJB8iOYTsJhLJ4F8GJ+4OQyBOz0+hRV
         oaeQopXPqTNieo38sdf09SCNwK7kQNvyaToqFF0rhC9Ruut4uzKO/QT4DtFnXoTJHMAA
         rs72aq2IoikXPBs4Vd05DFqqYtPbVE5PNCFFA0nl88PCp7xEZSi0j+/w+lnIEaplXNQH
         IX+sTsAK0KFUDzTtWUGwIwUDIHw6P7UdNcIyDk0sK44K0xtk4BZvB1u2eQVhSIuZvfYf
         xA4A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773933590; x=1774538390; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OfH8Q5Td26D2zz2vaWeEEQdnUyXBLu9cQNzXDyggGWs=;
        b=APmyZl3oeQueRTmeziy3SJdrcPsjCwIOAj2jNKPmTym9K8ETNtFxyE/UFMUYhtrc5q
         GB/nIPyLN6hfGntMHmt9dfHM7PfjMcnmARl7l9vxeRa5Z6X8vyFcJtavGpYR7HGrjgTd
         HpxbSNjN/pR2DCvhPHO07tEo4jMm5sTFowCJH+oxCaHcjzN1z2eJfXeIPKrS9nuO3Sui
         GiTp2InFaceJm8b9omVrtlETA1ZPWNMYCpfteIxl4+1j3B1JsIz7X9Rp+hvEi2VDArQn
         7dbUq2H0Fgz455Cn+z49tHCsEmp/3RJ2CiDks0Ufyr7BUn2X/enGHT6A0qkiAuhn994R
         CGUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773933590; x=1774538390;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OfH8Q5Td26D2zz2vaWeEEQdnUyXBLu9cQNzXDyggGWs=;
        b=NldhrO+J9WxJ6DLoTDyuwtpezx1TJxhuWBDkP80xk38w/wivP9TR320ren9t1j8yKt
         p3Ujc2yRuHhd9V7lCMmGgLWVYRv5nga77oihzyzEHZPDFggEbcHpBDBzkgE++4IDNAwf
         hMni38pfHu4b7zp8w604GuNHrul4tIU8PbPBB1H4fjnUttl9/4Qdw3jVjE5KjP83DEP9
         qvAfkpQ4lBbKUOA3/i9NGY2ACMEJwAF8iV2TyjgNe1dzCG1eSg8yKCkZOMlCO8I6hG1s
         Vy24sukeFRbrSh0bTy4afVla4DJzlqdQMXhPVkkEK6Ih3/vUFdpjGbFR1Mapp1LKu7Z/
         IhCA==
X-Forwarded-Encrypted: i=1; AJvYcCXDF1fpqkSsKcYYuY1pmbX8YOJhqZP1RgreLOg9kK8VCud7NoVY3yfUMAEVyiTL2odK64KkwRSqxWqpcx8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGd7Pb31p0g/ZYECSsXlh7AnkNs8JedW9MXvFCVhpQqvg5UhH6
	Bh77z81KoDzzAgw2MNdjQO3o1w26lfSpxXfPkWD4gGQzZNhbPlwLTyZDsaQS0Ozf9IoEK+3M5gF
	b/gK3YP3BqwCMQBAB97tL9dH73eLCxazD05r1fmFP
X-Gm-Gg: ATEYQzxAt1q98729sH/zmjoT8SSYoE+OhhpQXPMXZGn6VV06ERTFTJvT4z82dwgdVKy
	+0D9nrdE7eYSOKbdzfo+HAyenrP9NJo1Q8S76Hw5ra8TvbbH+FrJxgT3evUoBj96Jkdy48M7xUm
	+xZzVX7Li7X/MvHfTDW5LlTTvZZPLusRyQFFP0BhgH7pUue0/jshr2J2ObHHkwjbtKBE2hfl+F1
	eOm3bilB0tiNyz20p+mzmMKiZ2ENSs1n58AXWe6uK/ZkeLWoGo5YZ8QG2xSf/PFZ91hI3CjOYLs
	CS9sQ8yvTIW91IVsTHuDaDvMw9tGzq58ki8S
X-Received: by 2002:a05:6402:46c5:b0:665:d39:4b18 with SMTP id
 4fb4d7f45d1cf-66852d6c8abmr48783a12.8.1773933589136; Thu, 19 Mar 2026
 08:19:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1773695307.git.ljs@kernel.org> <48c6d25e374b57dba6df4fdddd4830d3fc1105be.1773695307.git.ljs@kernel.org>
 <CAJuCfpFXuHg4KPY27pqMC-xV5y9ZY2W72_R8_rxO0DvrJ=_yvw@mail.gmail.com>
 <CAJuCfpE5qZmi43EeZiRcy78pD6YvJb5n_xnoUJfwEjomowu0=A@mail.gmail.com>
 <8cdad898-b306-40fe-a367-efe7147f83b9@lucifer.local> <CAJuCfpHXqtxZr5s84jCcz513a2pgMeDoobsLBJH9pSON49cM+w@mail.gmail.com>
In-Reply-To: <CAJuCfpHXqtxZr5s84jCcz513a2pgMeDoobsLBJH9pSON49cM+w@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 19 Mar 2026 08:19:35 -0700
X-Gm-Features: AaiRm51bFJ7jnCWExjTkTJWtl61x7cY-2jhtQRDi8xxndWDLsjo0Sko90eA6oXU
Message-ID: <CAJuCfpG4F7r=AMTBRkazFeQsnKocu9OPFyV2TsQccLQc=oLwNA@mail.gmail.com>
Subject: Re: [PATCH v2 11/16] staging: vme_user: replace deprecated mmap hook
 with mmap_prepare
To: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Jonathan Corbet <corbet@lwn.net>, 
	Clemens Ladisch <clemens@ladisch.de>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "K . Y . Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Miquel Raynal <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>, 
	Vignesh Raghavendra <vigneshr@ti.com>, Bodo Stroesser <bostroesser@gmail.com>, 
	"Martin K . Petersen" <martin.petersen@oracle.com>, David Howells <dhowells@redhat.com>, 
	Marc Dionne <marc.dionne@auristor.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, David Hildenbrand <david@kernel.org>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Michal Hocko <mhocko@suse.com>, Jann Horn <jannh@google.com>, 
	Pedro Falcato <pfalcato@suse.de>, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-hyperv@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-mtd@lists.infradead.org, 
	linux-staging@lists.linux.dev, linux-scsi@vger.kernel.org, 
	target-devel@vger.kernel.org, linux-afs@lists.infradead.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	Ryan Roberts <ryan.roberts@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9551-lists,linux-hyperv=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[44];
	FREEMAIL_CC(0.00)[linux-foundation.org,lwn.net,ladisch.de,arndb.de,linuxfoundation.org,microsoft.com,kernel.org,linux.intel.com,gmail.com,foss.st.com,bootlin.com,nod.at,ti.com,oracle.com,redhat.com,auristor.com,zeniv.linux.org.uk,suse.cz,suse.com,google.com,suse.de,vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org,lists.linux.dev,kvack.org,arm.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[surenb@google.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-0.945];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E78092CDBDF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 19, 2026 at 8:19=E2=80=AFAM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> On Thu, Mar 19, 2026 at 7:55=E2=80=AFAM Lorenzo Stoakes (Oracle) <ljs@ker=
nel.org> wrote:
> >
> > On Tue, Mar 17, 2026 at 02:32:16PM -0700, Suren Baghdasaryan wrote:
> > > On Tue, Mar 17, 2026 at 2:26=E2=80=AFPM Suren Baghdasaryan <surenb@go=
ogle.com> wrote:
> > > >
> > > > On Mon, Mar 16, 2026 at 2:14=E2=80=AFPM Lorenzo Stoakes (Oracle) <l=
js@kernel.org> wrote:
> > > > >
> > > > > The f_op->mmap interface is deprecated, so update driver to use i=
ts
> > > > > successor, mmap_prepare.
> > > > >
> > > > > The driver previously used vm_iomap_memory(), so this change repl=
aces it
> > > > > with its mmap_prepare equivalent, mmap_action_simple_ioremap().
> > > > >
> > > > > Functions that wrap mmap() are also converted to wrap mmap_prepar=
e()
> > > > > instead.
> > > > >
> > > > > Also update the documentation accordingly.
> > > > >
> > > > > Signed-off-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>

Reviewed-by: Suren Baghdasaryan <surenb@google.com>

> > > > > ---
> > > > >  Documentation/driver-api/vme.rst    |  2 +-
> > > > >  drivers/staging/vme_user/vme.c      | 20 +++++------
> > > > >  drivers/staging/vme_user/vme.h      |  2 +-
> > > > >  drivers/staging/vme_user/vme_user.c | 51 +++++++++++++++++------=
------
> > > > >  4 files changed, 42 insertions(+), 33 deletions(-)
> > > > >
> > > > > diff --git a/Documentation/driver-api/vme.rst b/Documentation/dri=
ver-api/vme.rst
> > > > > index c0b475369de0..7111999abc14 100644
> > > > > --- a/Documentation/driver-api/vme.rst
> > > > > +++ b/Documentation/driver-api/vme.rst
> > > > > @@ -107,7 +107,7 @@ The function :c:func:`vme_master_read` can be=
 used to read from and
> > > > >
> > > > >  In addition to simple reads and writes, :c:func:`vme_master_rmw`=
 is provided to
> > > > >  do a read-modify-write transaction. Parts of a VME window can al=
so be mapped
> > > > > -into user space memory using :c:func:`vme_master_mmap`.
> > > > > +into user space memory using :c:func:`vme_master_mmap_prepare`.
> > > > >
> > > > >
> > > > >  Slave windows
> > > > > diff --git a/drivers/staging/vme_user/vme.c b/drivers/staging/vme=
_user/vme.c
> > > > > index f10a00c05f12..7220aba7b919 100644
> > > > > --- a/drivers/staging/vme_user/vme.c
> > > > > +++ b/drivers/staging/vme_user/vme.c
> > > > > @@ -735,9 +735,9 @@ unsigned int vme_master_rmw(struct vme_resour=
ce *resource, unsigned int mask,
> > > > >  EXPORT_SYMBOL(vme_master_rmw);
> > > > >
> > > > >  /**
> > > > > - * vme_master_mmap - Mmap region of VME master window.
> > > > > + * vme_master_mmap_prepare - Mmap region of VME master window.
> > > > >   * @resource: Pointer to VME master resource.
> > > > > - * @vma: Pointer to definition of user mapping.
> > > > > + * @desc: Pointer to descriptor of user mapping.
> > > > >   *
> > > > >   * Memory map a region of the VME master window into user space.
> > > > >   *
> > > > > @@ -745,12 +745,13 @@ EXPORT_SYMBOL(vme_master_rmw);
> > > > >   *         resource or -EFAULT if map exceeds window size. Other=
 generic mmap
> > > > >   *         errors may also be returned.
> > > > >   */
> > > > > -int vme_master_mmap(struct vme_resource *resource, struct vm_are=
a_struct *vma)
> > > > > +int vme_master_mmap_prepare(struct vme_resource *resource,
> > > > > +                           struct vm_area_desc *desc)
> > > > >  {
> > > > > +       const unsigned long vma_size =3D vma_desc_size(desc);
> > > > >         struct vme_bridge *bridge =3D find_bridge(resource);
> > > > >         struct vme_master_resource *image;
> > > > >         phys_addr_t phys_addr;
> > > > > -       unsigned long vma_size;
> > > > >
> > > > >         if (resource->type !=3D VME_MASTER) {
> > > > >                 dev_err(bridge->parent, "Not a master resource\n"=
);
> > > > > @@ -758,19 +759,18 @@ int vme_master_mmap(struct vme_resource *re=
source, struct vm_area_struct *vma)
> > > > >         }
> > > > >
> > > > >         image =3D list_entry(resource->entry, struct vme_master_r=
esource, list);
> > > > > -       phys_addr =3D image->bus_resource.start + (vma->vm_pgoff =
<< PAGE_SHIFT);
> > > > > -       vma_size =3D vma->vm_end - vma->vm_start;
> > > > > +       phys_addr =3D image->bus_resource.start + (desc->pgoff <<=
 PAGE_SHIFT);
> > > > >
> > > > >         if (phys_addr + vma_size > image->bus_resource.end + 1) {
> > > > >                 dev_err(bridge->parent, "Map size cannot exceed t=
he window size\n");
> > > > >                 return -EFAULT;
> > > > >         }
> > > > >
> > > > > -       vma->vm_page_prot =3D pgprot_noncached(vma->vm_page_prot)=
;
> > > > > -
> > > > > -       return vm_iomap_memory(vma, phys_addr, vma->vm_end - vma-=
>vm_start);
> > > > > +       desc->page_prot =3D pgprot_noncached(desc->page_prot);
> > > > > +       mmap_action_simple_ioremap(desc, phys_addr, vma_size);
> > > > > +       return 0;
> > > > >  }
> > > > > -EXPORT_SYMBOL(vme_master_mmap);
> > > > > +EXPORT_SYMBOL(vme_master_mmap_prepare);
> > > > >
> > > > >  /**
> > > > >   * vme_master_free - Free VME master window
> > > > > diff --git a/drivers/staging/vme_user/vme.h b/drivers/staging/vme=
_user/vme.h
> > > > > index 797e9940fdd1..b6413605ea49 100644
> > > > > --- a/drivers/staging/vme_user/vme.h
> > > > > +++ b/drivers/staging/vme_user/vme.h
> > > > > @@ -151,7 +151,7 @@ ssize_t vme_master_read(struct vme_resource *=
resource, void *buf, size_t count,
> > > > >  ssize_t vme_master_write(struct vme_resource *resource, void *bu=
f, size_t count, loff_t offset);
> > > > >  unsigned int vme_master_rmw(struct vme_resource *resource, unsig=
ned int mask, unsigned int compare,
> > > > >                             unsigned int swap, loff_t offset);
> > > > > -int vme_master_mmap(struct vme_resource *resource, struct vm_are=
a_struct *vma);
> > > > > +int vme_master_mmap_prepare(struct vme_resource *resource, struc=
t vm_area_desc *desc);
> > > > >  void vme_master_free(struct vme_resource *resource);
> > > > >
> > > > >  struct vme_resource *vme_dma_request(struct vme_dev *vdev, u32 r=
oute);
> > > > > diff --git a/drivers/staging/vme_user/vme_user.c b/drivers/stagin=
g/vme_user/vme_user.c
> > > > > index d95dd7d9190a..11e25c2f6b0a 100644
> > > > > --- a/drivers/staging/vme_user/vme_user.c
> > > > > +++ b/drivers/staging/vme_user/vme_user.c
> > > > > @@ -446,24 +446,14 @@ static void vme_user_vm_close(struct vm_are=
a_struct *vma)
> > > > >         kfree(vma_priv);
> > > > >  }
> > > > >
> > > > > -static const struct vm_operations_struct vme_user_vm_ops =3D {
> > > > > -       .open =3D vme_user_vm_open,
> > > > > -       .close =3D vme_user_vm_close,
> > > > > -};
> > > > > -
> > > > > -static int vme_user_master_mmap(unsigned int minor, struct vm_ar=
ea_struct *vma)
> > > > > +static int vme_user_vm_mapped(unsigned long start, unsigned long=
 end, pgoff_t pgoff,
> > > > > +                             const struct file *file, void **vm_=
private_data)
> > > > >  {
> > > > > -       int err;
> > > > > +       const unsigned int minor =3D iminor(file_inode(file));
> > > > >         struct vme_user_vma_priv *vma_priv;
> > > > >
> > > > >         mutex_lock(&image[minor].mutex);
> > > > >
> > > > > -       err =3D vme_master_mmap(image[minor].resource, vma);
> > > > > -       if (err) {
> > > > > -               mutex_unlock(&image[minor].mutex);
> > > > > -               return err;
> > > > > -       }
> > > > > -
> > > >
> > > > Ok, this changes the set of the operations performed under image[mi=
nor].mutex.
> > > > Before we had:
> > > >
> > > > mutex_lock(&image[minor].mutex);
> > > > vme_master_mmap();
> > > > <some final adjustments>
> > > > mutex_unlock(&image[minor].mutex);
> > > >
> > > > Now we have:
> > > >
> > > > mutex_lock(&image[minor].mutex);
> > > > vme_master_mmap_prepare()
> > > > mutex_unlock(&image[minor].mutex);
> > > > vm_iomap_memory();
> > > > mutex_lock(&image[minor].mutex);
> > > > vme_user_vm_mapped(); // <some final adjustments>
> > > > mutex_unlock(&image[minor].mutex);
> > > >
> > > > I think as long as image[minor] does not change while we are not
> > > > holding the mutex we should be safe, and looking at the code it see=
ms
> > > > to be the case. But I'm not familiar with this driver and might be
> > > > wrong. Worth double-checking.
> >
> > The file is pinned for the duration, the mutex is associated with the f=
ile,
> > so there's no sane world in which that could be problematic.
> >
> > Keeping in mind that we manipulate stuff on vme_user_vm_close() that
> > directly acceses image[minor] at an arbitary time.
>
> That was my understanding as well. Thanks for confirming.
>
> >
> > >
> > > A side note: if we had to hold the mutex across all those operations =
I
> > > think we would need to take the mutex in the vm_ops->mmap_prepare and
> > > add a vm_ops->map_failed hook or something along that line to drop th=
e
> > > mutex in case mmap_action_complete() fails. Not sure if we will have
> > > such cases though...
> >
> > No, I don't want to do this if it can be at all avoided. You should in
> > nearly any sane circumstance be able to defer things until the mapped h=
ook
> > anyway.
> >
> > Also a merge can happen too after an .mmap_prepare, so we'd have to hav=
e
> > some 'success' hook and I'm just not going there it'll end up open to a=
buse
> > again.
> >
> > (We do have success and error filtering hooks right now, sadly, but the=
y're
> > really for hugetlb and I plan to find a way to get rid of them).
> >
> > The mmap_prepare is meant to essentially be as stateless as possible.
>
> Yes, I also hope we won't encounter cases requiring us to keep any
> state information between the mmap_prepare and mapped stages.
>
> >
> > Anyway I don't think it's relevant here.
> >
> > >
> > > >
> > > > >         vma_priv =3D kmalloc_obj(*vma_priv);
> > > > >         if (!vma_priv) {
> > > > >                 mutex_unlock(&image[minor].mutex);
> > > > > @@ -472,22 +462,41 @@ static int vme_user_master_mmap(unsigned in=
t minor, struct vm_area_struct *vma)
> > > > >
> > > > >         vma_priv->minor =3D minor;
> > > > >         refcount_set(&vma_priv->refcnt, 1);
> > > > > -       vma->vm_ops =3D &vme_user_vm_ops;
> > > > > -       vma->vm_private_data =3D vma_priv;
> > > > > -
> > > > > +       *vm_private_data =3D vma_priv;
> > > > >         image[minor].mmap_count++;
> > > > >
> > > > >         mutex_unlock(&image[minor].mutex);
> > > > > -
> > > > >         return 0;
> > > > >  }
> > > > >
> > > > > -static int vme_user_mmap(struct file *file, struct vm_area_struc=
t *vma)
> > > > > +static const struct vm_operations_struct vme_user_vm_ops =3D {
> > > > > +       .mapped =3D vme_user_vm_mapped,
> > > > > +       .open =3D vme_user_vm_open,
> > > > > +       .close =3D vme_user_vm_close,
> > > > > +};
> > > > > +
> > > > > +static int vme_user_master_mmap_prepare(unsigned int minor,
> > > > > +                                       struct vm_area_desc *desc=
)
> > > > > +{
> > > > > +       int err;
> > > > > +
> > > > > +       mutex_lock(&image[minor].mutex);
> > > > > +
> > > > > +       err =3D vme_master_mmap_prepare(image[minor].resource, de=
sc);
> > > > > +       if (!err)
> > > > > +               desc->vm_ops =3D &vme_user_vm_ops;
> > > > > +
> > > > > +       mutex_unlock(&image[minor].mutex);
> > > > > +       return err;
> > > > > +}
> > > > > +
> > > > > +static int vme_user_mmap_prepare(struct vm_area_desc *desc)
> > > > >  {
> > > > > -       unsigned int minor =3D iminor(file_inode(file));
> > > > > +       const struct file *file =3D desc->file;
> > > > > +       const unsigned int minor =3D iminor(file_inode(file));
> > > > >
> > > > >         if (type[minor] =3D=3D MASTER_MINOR)
> > > > > -               return vme_user_master_mmap(minor, vma);
> > > > > +               return vme_user_master_mmap_prepare(minor, desc);
> > > > >
> > > > >         return -ENODEV;
> > > > >  }
> > > > > @@ -498,7 +507,7 @@ static const struct file_operations vme_user_=
fops =3D {
> > > > >         .llseek =3D vme_user_llseek,
> > > > >         .unlocked_ioctl =3D vme_user_unlocked_ioctl,
> > > > >         .compat_ioctl =3D compat_ptr_ioctl,
> > > > > -       .mmap =3D vme_user_mmap,
> > > > > +       .mmap_prepare =3D vme_user_mmap_prepare,
> > > > >  };
> > > > >
> > > > >  static int vme_user_match(struct vme_dev *vdev)
> > > > > --
> > > > > 2.53.0
> > > > >
> >
> > Cheers, Lorenzo

