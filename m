Return-Path: <linux-hyperv+bounces-9549-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CGulCncUvGnbrwIAu9opvQ
	(envelope-from <linux-hyperv+bounces-9549-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2026 16:21:27 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 820C32CD9DC
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2026 16:21:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 47152328E76F
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2026 15:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70B6B3E1CFC;
	Thu, 19 Mar 2026 15:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h2Q0UO3t"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A80DD3E0247
	for <linux-hyperv@vger.kernel.org>; Thu, 19 Mar 2026 15:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773933317; cv=pass; b=SYrMUdDlck3CX8zKwSgyWsIW1hWUUwoaN0QN4m8eHshYvmjegg4qeo2pq2Uj9FYMSzbUSiqhjru8EfoWQU8rZNPCnQp3ZgPHw+ZVT0MqKFu4ePovpVp0f7HQxZkOv5AQqpi3c/JCQ21w7v6u5EgGsv/gSg4NtFvlDaefWnSJCso=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773933317; c=relaxed/simple;
	bh=+U+h5DHutsPWQLAl47H2kO1Rj4E77RwlLxKhQLCNe1o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MSP5XBLmS4Z/h29krbM/5apiQw9Mt4QvRoSd90hCS93YAJZW6nr7Bn+eu2Mm2ZSHKfGUO9VrJOn7AFSVvT0AoslYYGMr/XITtHOXp39j3sP6U7+vthKbCzj5A9Ku4Oipo2X6RazE63CwfFzKLXrGvc8FVZsUOos5pUEI36L3DbY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=h2Q0UO3t; arc=pass smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6628cc1bd69so9885a12.1
        for <linux-hyperv@vger.kernel.org>; Thu, 19 Mar 2026 08:15:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773933309; cv=none;
        d=google.com; s=arc-20240605;
        b=Zlo366E5IkCax8d1wyHvUMaPjLFmT1M/IH454/VsqyNLrvZmXo8RWi6SytpIBdi63m
         qkNZZyNvpyolgmEt5RgQfnnXjC7qweMnI5epPBSwnF39ohHWfTEoMKitgcoDpsr2yHSe
         q9fFnUIhzzHx+ChC2QX1HXVrqTb7RBdN0LigucE5lc+s08QbHrqIyAgjx1NBZjyUvdBm
         JuqULj23U3aW5bH0P4PkKe7JNs/6LijCPiYO3RtzLk+Lel/EmqhElChIq4BkiU9WhuT0
         zzeZFCemr9nfoL0Zf7aPO9r5OPR8kF7CRQyvBk5+aW3K5RSau9Ne1Q9jHnDRzGS30xGQ
         TV/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rDGWj2LZwlvIkcEpInl/kcvhbo0ZpIck8KTLQAEkgQo=;
        fh=J84jig4Vuyrmh8PxL/cDvdafg10UQzAxOWYhVm+E6HM=;
        b=JO/UQ6uuvvj9YgTxZYpgnkf2Rf0T7F/ozzGTk+jPxVKcDuXvIgHMceFxQ5h9kT2/g7
         srj0i7OScE+ywD2FH5wOHXwDjhVGG+4FscaS1AAB58Cvs0RLvyW2r9ksDAe6eFV1Wjj5
         hHk8BuvrgmpqQXHTjfga/PCBO4o4QMZJDGOazKrI7FPZXiJjMSE0QZZ4ZJKCKkYE5x8m
         1DD+j8/3kXEgsNKOpZJf/GPwt/xoFVlUhrgzKf8vhhcVEhPgTN8gKXcxmK7MuspH4svZ
         9z6ZSOAjt7VomZXQSjd4MN2GvpFdhXgQorABJk26aoiU3MJx3U8kgxmagdBbU0HUtNKB
         YFdw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773933309; x=1774538109; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rDGWj2LZwlvIkcEpInl/kcvhbo0ZpIck8KTLQAEkgQo=;
        b=h2Q0UO3ty2jGn3w/phsAwquzFNF8cs+EFcCdQlRWCyluIdcFaZvUM1Oiz5wnl6V4OO
         RJpUH0+N0IY+hVGcs9XhMbAPLlBgdy+NWNiD2iJitJ1W6eCnQ+V0CHfWfxLPB57njIJ8
         WD0XxpwA0QSSv+kUx/u72nBDvZnSPwOIqrK4TUq50vdYFox21AN045OvKV0vvXdT5v7V
         ix5bV58mYiGGOEcExxusMAm4BIxe8PxWoNhwp0gk/E7JRknNrNLFSiKW/1ej8K3beOyb
         YUHuXCiOv8xRnVA/Jggmfvx7PZBiqQ7/7sTmw6gzHwHMyP/u9HdGaTOaN8W1mWJp2LKG
         Fd7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773933309; x=1774538109;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rDGWj2LZwlvIkcEpInl/kcvhbo0ZpIck8KTLQAEkgQo=;
        b=sjaC9t8vmbkTV1wpckB2gTy1C5nm5SUXWW1rJH2xYO5/HeS2iLTLJTTQSsoSpymMLL
         SAcnu75dj41ODEIC/uvkE9kQCAS6FLBStu+mRVAygUjI+nVPiABLr9nuq7DHr0DgSox6
         iFo0j79Fv6enLcQcf7dhaeF60QeNKScTeqiBv9SZeDRVSOfNT4QGAz0BJLpk+JJqDLhg
         tGeKq519G16njtw3mZY9qbCw23wGyAxsVJB16ydrb35BRb7+2vTyuLcqJxJ4vTJ5O/EY
         +RgUhbbe+or3CIUPVFcnJHfb8Gp2R3eSXDP9ngqN5bBpk+39VWggEjzrR8jyJE1IC2jp
         GEMA==
X-Forwarded-Encrypted: i=1; AJvYcCXSs9QVbsxOhJt0UGfVn6X1fv+JxEhoFScywGKTRBSupgeAMs/ufXmOFqg/+FpXx3ibBqJqh8GXJHI82wY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxE1MWA055fo9Ao1AnRPBKMzEtvLIwdntWiFmqQsDN/5WOJseBg
	TQRaixEudzlofPfu0TqImpDF5L0OA8GVPvCOsWhsguk5YeUoj2zW7yXzxHaee3EBsGRX7wHn8/F
	cjK/I4fpFiydsRq3yN57uT7/QnVmAdn6gM87iPKLx
X-Gm-Gg: ATEYQzwoEFfpQVcUzSAORQdd/D8UPxmwoj0VSdYBHQxLWSzEDYQGZtzSWJW/lIb6kiA
	uqgW3LyayKbfhyngnuUhCMNP0uIJBUb5DvgWJ/WXLF6ecksHGqjPOfxRza1H2kWtvD0XOfIo+Nd
	J8rqNJgN2OSmihcpqHokpnF8TjAuqKhJM6+NkdLZohhQfYFsaYQPRzxGRiniBSSut44yPbQsm3b
	U4Yl1IO8rrdK/t9XJfsGSDx/xT0ucncr44QC4/WLryl8WjT13TDc2NEGn/hxGOM2UXfIFdb7y9R
	BZHVD3WPaRsF9Ft1RWbdzhUjXe48CcU48kMQ
X-Received: by 2002:a05:6402:a518:20b0:660:f90b:a19b with SMTP id
 4fb4d7f45d1cf-66852d86339mr28785a12.8.1773933307787; Thu, 19 Mar 2026
 08:15:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1773695307.git.ljs@kernel.org> <8e28e4b63bae67bfa1a59ccbac9dc6db1442d75d.1773695307.git.ljs@kernel.org>
 <CAJuCfpF6eS18HLgNvQtkLGd=7N0_L1JPmF0GzM-Z0QimRWT7AQ@mail.gmail.com> <d877ee66-1ac9-4b1b-b860-6919dc58edfe@lucifer.local>
In-Reply-To: <d877ee66-1ac9-4b1b-b860-6919dc58edfe@lucifer.local>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 19 Mar 2026 08:14:54 -0700
X-Gm-Features: AaiRm50TBB0_y5-6zEqCgnFax1lp80ds7Lm1WJGU5srttqxVqxdb1y_yg1RHpJs
Message-ID: <CAJuCfpGsKgOEGA3rh+fMwv4BMMb0tZ5ZxVWeLCyOEvq7J12xOg@mail.gmail.com>
Subject: Re: [PATCH v2 15/16] mm: add mmap_action_map_kernel_pages[_full]()
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9549-lists,linux-hyperv=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.944];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 820C32CD9DC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 19, 2026 at 8:05=E2=80=AFAM Lorenzo Stoakes (Oracle) <ljs@kerne=
l.org> wrote:
>
> On Wed, Mar 18, 2026 at 09:00:13AM -0700, Suren Baghdasaryan wrote:
> > On Mon, Mar 16, 2026 at 2:14=E2=80=AFPM Lorenzo Stoakes (Oracle) <ljs@k=
ernel.org> wrote:
> > >
> > > A user can invoke mmap_action_map_kernel_pages() to specify that the
> > > mapping should map kernel pages starting from desc->start of a specif=
ied
> > > number of pages specified in an array.
> > >
> > > In order to implement this, adjust mmap_action_prepare() to be able t=
o
> > > return an error code, as it makes sense to assert that the specified
> > > parameters are valid as quickly as possible as well as updating the V=
MA
> > > flags to include VMA_MIXEDMAP_BIT as necessary.
> > >
> > > This provides an mmap_prepare equivalent of vm_insert_pages().
> > >
> > > We additionally update the existing vm_insert_pages() code to use
> > > range_in_vma() and add a new range_in_vma_desc() helper function for =
the
> > > mmap_prepare case, sharing the code between the two in range_is_subse=
t().
> > >
> > > We add both mmap_action_map_kernel_pages() and
> > > mmap_action_map_kernel_pages_full() to allow for both partial and ful=
l VMA
> > > mappings.
> > >
> > > We also add mmap_action_map_kernel_pages_discontig() to allow for
> > > discontiguous mapping of kernel pages should the need arise.
> > >
> > > We update the documentation to reflect the new features.
> > >
> > > Finally, we update the VMA tests accordingly to reflect the changes.
> > >
> > > Signed-off-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>
> >
> > With one nit,
> > Reviewed-by: Suren Baghdasaryan <surenb@google.com>
>
> Thanks!
>
> >
> > > ---
> > >  Documentation/filesystems/mmap_prepare.rst |  8 ++
> > >  include/linux/mm.h                         | 95 ++++++++++++++++++++=
+-
> > >  include/linux/mm_types.h                   |  7 ++
> > >  mm/memory.c                                | 42 +++++++++-
> > >  mm/util.c                                  |  6 ++
> > >  tools/testing/vma/include/dup.h            |  7 ++
> > >  6 files changed, 159 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/Documentation/filesystems/mmap_prepare.rst b/Documentati=
on/filesystems/mmap_prepare.rst
> > > index be76ae475b9c..e810aa4134eb 100644
> > > --- a/Documentation/filesystems/mmap_prepare.rst
> > > +++ b/Documentation/filesystems/mmap_prepare.rst
> > > @@ -156,5 +156,13 @@ pointer. These are:
> > >  * mmap_action_simple_ioremap() - Sets up an I/O remap from a specifi=
ed
> > >    physical address and over a specified length.
> > >
> > > +* mmap_action_map_kernel_pages() - Maps a specified array of `struct=
 page`
> > > +  pointers in the VMA from a specific offset.
> > > +
> > > +* mmap_action_map_kernel_pages_full() - Maps a specified array of `s=
truct
> > > +  page` pointers over the entire VMA. The caller must ensure there a=
re
> > > +  sufficient entries in the page array to cover the entire range of =
the
> > > +  described VMA.
> > > +
> > >  **NOTE:** The ``action`` field should never normally be manipulated =
directly,
> > >  rather you ought to use one of these helpers.
> > > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > > index df8fa6e6402b..6f0a3edb24e1 100644
> > > --- a/include/linux/mm.h
> > > +++ b/include/linux/mm.h
> > > @@ -2912,7 +2912,7 @@ static inline bool folio_maybe_mapped_shared(st=
ruct folio *folio)
> > >   * The caller must add any reference (e.g., from folio_try_get()) it=
 might be
> > >   * holding itself to the result.
> > >   *
> > > - * Returns the expected folio refcount.
> > > + * Returns: the expected folio refcount.
> >
> > nit: I see both "Returns:" and "Return:" being used in the codebase
> > but this header file uses "Return:", so for consistency you should
> > probably do the same. This also applies to later instances in this
> > patch.
>
> Well here I'm just adding the colon, while I'm here (maybe have been an
> update in response to feedback actualy).
>
> And this function that's not part of my change already uses 'Returns' and
> I'm pretty sure that's the correct form.
>
> So I think not a big deal to keep using that?

Correct. Anything I mark as "nit:" is not critical and can be ignored.

>
> >
> > >   */
> > >  static inline int folio_expected_ref_count(const struct folio *folio=
)
> > >  {
> > > @@ -4364,6 +4364,45 @@ static inline void mmap_action_simple_ioremap(=
struct vm_area_desc *desc,
> > >         action->type =3D MMAP_SIMPLE_IO_REMAP;
> > >  }
> > >
> > > +/**
> > > + * mmap_action_map_kernel_pages - helper for mmap_prepare hook to sp=
ecify that
> > > + * @num kernel pages contained in the @pages array should be mapped =
to userland
> > > + * starting at virtual address @start.
> > > + * @desc: The VMA descriptor for the VMA requiring kernel pags to be=
 mapped.
> > > + * @start: The virtual address from which to map them.
> > > + * @pages: An array of struct page pointers describing the memory to=
 map.
> > > + * @nr_pages: The number of entries in the @pages aray.
> > > + */
> > > +static inline void mmap_action_map_kernel_pages(struct vm_area_desc =
*desc,
> > > +               unsigned long start, struct page **pages,
> > > +               unsigned long nr_pages)
> > > +{
> > > +       struct mmap_action *action =3D &desc->action;
> > > +
> > > +       action->type =3D MMAP_MAP_KERNEL_PAGES;
> > > +       action->map_kernel.start =3D start;
> > > +       action->map_kernel.pages =3D pages;
> > > +       action->map_kernel.nr_pages =3D nr_pages;
> > > +       action->map_kernel.pgoff =3D desc->pgoff;
> > > +}
> > > +
> > > +/**
> > > + * mmap_action_map_kernel_pages_full - helper for mmap_prepare hook =
to specify that
> > > + * kernel pages contained in the @pages array should be mapped to us=
erland
> > > + * from @desc->start to @desc->end.
> > > + * @desc: The VMA descriptor for the VMA requiring kernel pags to be=
 mapped.
> > > + * @pages: An array of struct page pointers describing the memory to=
 map.
> > > + *
> > > + * The caller must ensure that @pages contains sufficient entries to=
 cover the
> > > + * entire range described by @desc.
> > > + */
> > > +static inline void mmap_action_map_kernel_pages_full(struct vm_area_=
desc *desc,
> > > +               struct page **pages)
> > > +{
> > > +       mmap_action_map_kernel_pages(desc, desc->start, pages,
> > > +                                    vma_desc_pages(desc));
> > > +}
> > > +
> > >  int mmap_action_prepare(struct vm_area_desc *desc);
> > >  int mmap_action_complete(struct vm_area_struct *vma,
> > >                          struct mmap_action *action);
> > > @@ -4380,10 +4419,59 @@ static inline struct vm_area_struct *find_exa=
ct_vma(struct mm_struct *mm,
> > >         return vma;
> > >  }
> > >
> > > +/**
> > > + * range_is_subset - Is the specified inner range a subset of the ou=
ter range?
> > > + * @outer_start: The start of the outer range.
> > > + * @outer_end: The exclusive end of the outer range.
> > > + * @inner_start: The start of the inner range.
> > > + * @inner_end: The exclusive end of the inner range.
> > > + *
> > > + * Returns: %true if [inner_start, inner_end) is a subset of [outer_=
start,
> > > + * outer_end), otherwise %false.
> > > + */
> > > +static inline bool range_is_subset(unsigned long outer_start,
> > > +                                  unsigned long outer_end,
> > > +                                  unsigned long inner_start,
> > > +                                  unsigned long inner_end)
> > > +{
> > > +       return outer_start <=3D inner_start && inner_end <=3D outer_e=
nd;
> > > +}
> > > +
> > > +/**
> > > + * range_in_vma - is the specified [@start, @end) range a subset of =
the VMA?
> > > + * @vma: The VMA against which we want to check [@start, @end).
> > > + * @start: The start of the range we wish to check.
> > > + * @end: The exclusive end of the range we wish to check.
> > > + *
> > > + * Returns: %true if [@start, @end) is a subset of [@vma->vm_start,
> > > + * @vma->vm_end), %false otherwise.
> > > + */
> > >  static inline bool range_in_vma(const struct vm_area_struct *vma,
> > >                                 unsigned long start, unsigned long en=
d)
> > >  {
> > > -       return (vma && vma->vm_start <=3D start && end <=3D vma->vm_e=
nd);
> > > +       if (!vma)
> > > +               return false;
> > > +
> > > +       return range_is_subset(vma->vm_start, vma->vm_end, start, end=
);
> > > +}
> > > +
> > > +/**
> > > + * range_in_vma_desc - is the specified [@start, @end) range a subse=
t of the VMA
> > > + * described by @desc, a VMA descriptor?
> > > + * @desc: The VMA descriptor against which we want to check [@start,=
 @end).
> > > + * @start: The start of the range we wish to check.
> > > + * @end: The exclusive end of the range we wish to check.
> > > + *
> > > + * Returns: %true if [@start, @end) is a subset of [@desc->start, @d=
esc->end),
> > > + * %false otherwise.
> > > + */
> > > +static inline bool range_in_vma_desc(const struct vm_area_desc *desc=
,
> > > +                                    unsigned long start, unsigned lo=
ng end)
> > > +{
> > > +       if (!desc)
> > > +               return false;
> > > +
> > > +       return range_is_subset(desc->start, desc->end, start, end);
> > >  }
> > >
> > >  #ifdef CONFIG_MMU
> > > @@ -4427,6 +4515,9 @@ int remap_pfn_range(struct vm_area_struct *vma,=
 unsigned long addr,
> > >  int vm_insert_page(struct vm_area_struct *, unsigned long addr, stru=
ct page *);
> > >  int vm_insert_pages(struct vm_area_struct *vma, unsigned long addr,
> > >                         struct page **pages, unsigned long *num);
> > > +int map_kernel_pages_prepare(struct vm_area_desc *desc);
> > > +int map_kernel_pages_complete(struct vm_area_struct *vma,
> > > +                             struct mmap_action *action);
> > >  int vm_map_pages(struct vm_area_struct *vma, struct page **pages,
> > >                                 unsigned long num);
> > >  int vm_map_pages_zero(struct vm_area_struct *vma, struct page **page=
s,
> > > diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> > > index 7538d64f8848..c46224020a46 100644
> > > --- a/include/linux/mm_types.h
> > > +++ b/include/linux/mm_types.h
> > > @@ -815,6 +815,7 @@ enum mmap_action_type {
> > >         MMAP_REMAP_PFN,         /* Remap PFN range. */
> > >         MMAP_IO_REMAP_PFN,      /* I/O remap PFN range. */
> > >         MMAP_SIMPLE_IO_REMAP,   /* I/O remap with guardrails. */
> > > +       MMAP_MAP_KERNEL_PAGES,  /* Map kernel page range from array. =
*/
> > >  };
> > >
> > >  /*
> > > @@ -833,6 +834,12 @@ struct mmap_action {
> > >                         phys_addr_t start_phys_addr;
> > >                         unsigned long size;
> > >                 } simple_ioremap;
> > > +               struct {
> > > +                       unsigned long start;
> > > +                       struct page **pages;
> > > +                       unsigned long nr_pages;
> > > +                       pgoff_t pgoff;
> > > +               } map_kernel;
> > >         };
> > >         enum mmap_action_type type;
> > >
> > > diff --git a/mm/memory.c b/mm/memory.c
> > > index f3f4046aee97..849d5d9eeb83 100644
> > > --- a/mm/memory.c
> > > +++ b/mm/memory.c
> > > @@ -2484,13 +2484,14 @@ static int insert_pages(struct vm_area_struct=
 *vma, unsigned long addr,
> > >  int vm_insert_pages(struct vm_area_struct *vma, unsigned long addr,
> > >                         struct page **pages, unsigned long *num)
> > >  {
> > > -       const unsigned long end_addr =3D addr + (*num * PAGE_SIZE) - =
1;
> > > +       const unsigned long nr_pages =3D *num;
> > > +       const unsigned long end =3D addr + PAGE_SIZE * nr_pages;
> > >
> > > -       if (addr < vma->vm_start || end_addr >=3D vma->vm_end)
> > > +       if (!range_in_vma(vma, addr, end))
> > >                 return -EFAULT;
> > >         if (!(vma->vm_flags & VM_MIXEDMAP)) {
> > > -               BUG_ON(mmap_read_trylock(vma->vm_mm));
> > > -               BUG_ON(vma->vm_flags & VM_PFNMAP);
> > > +               VM_WARN_ON_ONCE(mmap_read_trylock(vma->vm_mm));
> > > +               VM_WARN_ON_ONCE(vma->vm_flags & VM_PFNMAP);
> > >                 vm_flags_set(vma, VM_MIXEDMAP);
> > >         }
> > >         /* Defer page refcount checking till we're about to map that =
page. */
> > > @@ -2498,6 +2499,39 @@ int vm_insert_pages(struct vm_area_struct *vma=
, unsigned long addr,
> > >  }
> > >  EXPORT_SYMBOL(vm_insert_pages);
> > >
> > > +int map_kernel_pages_prepare(struct vm_area_desc *desc)
> > > +{
> > > +       const struct mmap_action *action =3D &desc->action;
> > > +       const unsigned long addr =3D action->map_kernel.start;
> > > +       unsigned long nr_pages, end;
> > > +
> > > +       if (!vma_desc_test(desc, VMA_MIXEDMAP_BIT)) {
> > > +               VM_WARN_ON_ONCE(mmap_read_trylock(desc->mm));
> > > +               VM_WARN_ON_ONCE(vma_desc_test(desc, VMA_PFNMAP_BIT));
> > > +               vma_desc_set_flags(desc, VMA_MIXEDMAP_BIT);
> > > +       }
> > > +
> > > +       nr_pages =3D action->map_kernel.nr_pages;
> > > +       end =3D addr + PAGE_SIZE * nr_pages;
> > > +       if (!range_in_vma_desc(desc, addr, end))
> > > +               return -EFAULT;
> > > +
> > > +       return 0;
> > > +}
> > > +EXPORT_SYMBOL(map_kernel_pages_prepare);
> > > +
> > > +int map_kernel_pages_complete(struct vm_area_struct *vma,
> > > +                             struct mmap_action *action)
> > > +{
> > > +       unsigned long nr_pages;
> > > +
> > > +       nr_pages =3D action->map_kernel.nr_pages;
> > > +       return insert_pages(vma, action->map_kernel.start,
> > > +                           action->map_kernel.pages,
> > > +                           &nr_pages, vma->vm_page_prot);
> > > +}
> > > +EXPORT_SYMBOL(map_kernel_pages_complete);
> > > +
> > >  /**
> > >   * vm_insert_page - insert single page into user vma
> > >   * @vma: user vma to map to
> > > diff --git a/mm/util.c b/mm/util.c
> > > index a166c48fe894..dea590e7a26c 100644
> > > --- a/mm/util.c
> > > +++ b/mm/util.c
> > > @@ -1441,6 +1441,8 @@ int mmap_action_prepare(struct vm_area_desc *de=
sc)
> > >                 return io_remap_pfn_range_prepare(desc);
> > >         case MMAP_SIMPLE_IO_REMAP:
> > >                 return simple_ioremap_prepare(desc);
> > > +       case MMAP_MAP_KERNEL_PAGES:
> > > +               return map_kernel_pages_prepare(desc);
> > >         }
> > >
> > >         WARN_ON_ONCE(1);
> > > @@ -1472,6 +1474,9 @@ int mmap_action_complete(struct vm_area_struct =
*vma,
> > >         case MMAP_IO_REMAP_PFN:
> > >                 err =3D io_remap_pfn_range_complete(vma, action);
> > >                 break;
> > > +       case MMAP_MAP_KERNEL_PAGES:
> > > +               err =3D map_kernel_pages_complete(vma, action);
> > > +               break;
> > >         case MMAP_SIMPLE_IO_REMAP:
> > >                 /*
> > >                  * The simple I/O remap should have been delegated to=
 an I/O
> > > @@ -1494,6 +1499,7 @@ int mmap_action_prepare(struct vm_area_desc *de=
sc)
> > >         case MMAP_REMAP_PFN:
> > >         case MMAP_IO_REMAP_PFN:
> > >         case MMAP_SIMPLE_IO_REMAP:
> > > +       case MMAP_MAP_KERNEL_PAGES:
> > >                 WARN_ON_ONCE(1); /* nommu cannot handle these. */
> > >                 break;
> > >         }
> > > diff --git a/tools/testing/vma/include/dup.h b/tools/testing/vma/incl=
ude/dup.h
> > > index 6658df26698a..4407caf207ad 100644
> > > --- a/tools/testing/vma/include/dup.h
> > > +++ b/tools/testing/vma/include/dup.h
> > > @@ -454,6 +454,7 @@ enum mmap_action_type {
> > >         MMAP_REMAP_PFN,         /* Remap PFN range. */
> > >         MMAP_IO_REMAP_PFN,      /* I/O remap PFN range. */
> > >         MMAP_SIMPLE_IO_REMAP,   /* I/O remap with guardrails. */
> > > +       MMAP_MAP_KERNEL_PAGES,  /* Map kernel page range from an arra=
y. */
> > >  };
> > >
> > >  /*
> > > @@ -472,6 +473,12 @@ struct mmap_action {
> > >                         phys_addr_t start;
> > >                         unsigned long len;
> > >                 } simple_ioremap;
> > > +               struct {
> > > +                       unsigned long start;
> > > +                       struct page **pages;
> > > +                       unsigned long num;
> > > +                       pgoff_t pgoff;
> > > +               } map_kernel;
> > >         };
> > >         enum mmap_action_type type;
> > >
> > > --
> > > 2.53.0
> > >

