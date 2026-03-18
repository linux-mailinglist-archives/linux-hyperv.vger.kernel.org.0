Return-Path: <linux-hyperv+bounces-9529-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EB+QBMziummdcwIAu9opvQ
	(envelope-from <linux-hyperv+bounces-9529-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 18 Mar 2026 18:37:16 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C0282C0690
	for <lists+linux-hyperv@lfdr.de>; Wed, 18 Mar 2026 18:37:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 27A61304F476
	for <lists+linux-hyperv@lfdr.de>; Wed, 18 Mar 2026 16:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45A093F7E67;
	Wed, 18 Mar 2026 16:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lnUpsYZw"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D003F65FF
	for <linux-hyperv@vger.kernel.org>; Wed, 18 Mar 2026 16:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773849635; cv=pass; b=POJjfi7jgLJzLsRQE6HXQQ9Vy7rb5iA9RTlzCNOgjBGOteVpqU/fD8BAnudbHdXujlLU+m4dyUUTQaDKJLJRYv78fZ7Ga7HC8y7fU79Z0A4xoGyav/OnMegxpGvLnXPmgAPcK4znZPfBVyXmFWJURkAYzcAG+R/9I+HjVwvqSxI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773849635; c=relaxed/simple;
	bh=dPbKT25C4GPcI3JtqDUYqqKrB12KKuXMc+HZEx8dtyI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CxW7/I7MwP1VG+xaiKmxF7Bh80ydeadN0wgXyvNg6muoNIM5Mg0x9hbI8BPh1Bpq4USrK55+mZhAGnFlkJcHL2pS9ZqrqP1rCWzMMxjeIMfLQ0cqxBu7lgzRR1qBOYwsUeFTogSnor4V3KvOGx36mG+ewSvwfl6VE3OHGaET7ig=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lnUpsYZw; arc=pass smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-5091ed02c54so687811cf.1
        for <linux-hyperv@vger.kernel.org>; Wed, 18 Mar 2026 09:00:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773849627; cv=none;
        d=google.com; s=arc-20240605;
        b=ER2tGEAK1Iu6r1TTr7RfUCh/N8Jdn0eK6veJXgBNhXjYdoMQBmLqNuzGOIsFgG0l18
         mtYCVOJEoGOwq3c9sfq7fhYy+PtuQO9jf2gaCQfHQyi7H+nKGP9CYdURTGGysILj5Txt
         ZzXaRe/GZfddi8xGEC3zZnzn+zCPagsXLVjHNvJou4Dw0ALWXBgF93iWLGfzAMyxrGbm
         cpgi8X+/EheGr5XPxeWEmA28n4G6b+x34cayqacmPaVlnOo/Ft+cRmJXETwxfO4yHL0P
         Fb3eRxvvfFVvUHHjRhFVaQCHx49A7+AREbVQX11fYRHtEwrTqeZqj12zACkDIu8SutSi
         PsMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8q0J7KCNx+A8Y+J2RSy7VQj65zrNoynNXfOuxxJlza4=;
        fh=RkWtc9Yt0k1o2tlaGOTCE867R/xFWZ17cx/8bMlMTTM=;
        b=kDNeAWhZFJD/czrj8SDG8E3svoa2X66wTCgloan6S5WTVWAGpzwmnqMhNQwxx95sKl
         Z9kq7FshFzpqBCEt5mN9PIQWg2ZZfesK8v/80AUZVosoo2i2pDr0LhOROgs3EVZA2zjk
         h18ms83Z5VVWTrAn4wSeCapQnvPfpd1CHGvmu4V4nOcRH8thUR8IZqBQigfguqRWzBvd
         kG5kv9FlKQBUBxlwPVR13a7oPKDS1MJFYAJT+d7wkVjQUnHMHrsyEdflbZYnEp7kD5Cw
         nGTZ05eXArFxOeNiWacApQGrAcP6lz/LnR8TtDGwKbqXZ1Snm5qDwT/sHpRtbliwJXQk
         MlPQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773849627; x=1774454427; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8q0J7KCNx+A8Y+J2RSy7VQj65zrNoynNXfOuxxJlza4=;
        b=lnUpsYZwWf6Ngn/dqPOq7iQ1HVijjDPBZhgwYESz9kfeLT/BZxbGPpEe/4D4KnGWPr
         kCCPmUNpyoC+BM+S0/AilDKxE8o1CD/tQVzgZ8m85n+tmTvRkDDUKqDbBpQ8uzK/xkwW
         krD3uuyiCYETL1cqk2fqid6RWjt8z8Yb3OG2zujBT/hOWReYHF+pLdi9roOdVeHzcsuA
         QJXe02qdxmtUe6YfR1NFuqn15NuHUpLmj9pNFJwoHIswo1qAJhFVz7jWYhedR8di+XVA
         5cqovfkCv1bJUZki95dI8il97zlBON76NQtpQB/JdBHgAIOrN5FGHw4Hm9tEDrXxvpNu
         Ytgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773849627; x=1774454427;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8q0J7KCNx+A8Y+J2RSy7VQj65zrNoynNXfOuxxJlza4=;
        b=Dd3T1DBefDcc9qRyBgUbtjmdLqq9Az9A3sq7vkqzx3pa2j98CJ6XAGKY3q+XI6R/wv
         EecfIu2gh31UUW5ivu1QNe/uaMSbqbA/OqUbVuE0mFg1QdLKfgIpb0NCPt8jgG5ZEQOR
         mqgXrEU1n/q1Wye8OFKbwRfkQlorJjlvYPYOJEUIAUwWQUl/QPBkyPZUfoo0jlEq7vVA
         6gyMfs2KMVH1DRs5WwyI23MHMHciZGawwxaf7H8o+HR36kFagDsYaQT+e0gkGA6/5uNG
         vCRVLWKeu+rgM4jKN8sI3PxkHto/zaookBFGYhd4ncU3FoDmr9IqXLQkLGcvZVozNGYM
         5JpA==
X-Forwarded-Encrypted: i=1; AJvYcCWFUrccDjva4Jgdn+P27f7Hbx5G2Io57DtVBOo2k4iqzymmsblFhf0m2h0oeJBd+6xaHGp0c+RkbzWBv9E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2cqB9TZw1SQGnQe/GCX/AEXQ1SMrUjNYb9419tPWQMvcBPoXy
	cV7OasdGpQlXUIL2oWp3Wpz6eayUHtE1ywj2v2chu1iDpZh52Z7F/b9W1VZn+vxQGLF/k/hJVBp
	Fw4c/2gDKu4QqHNmbCgePpjp6D+h/iedae5jPbsUf
X-Gm-Gg: ATEYQzx34StRicAzptq7VmviGjsFOaBvz5QHbGm943mE7STCcHijy/ouXTBDQs5dmli
	BRINkexrb4pQOMQC11FjmuJ2/VNXDhAPVthamatwPNmR1GzQn6RuDUn07X1047U3ngZzbeGTM3y
	G7Xot6nwmq+tckbCzBxXvBfn4yTarBzScs6CZGubDZ7HdzNcmI172VQIidpcpbFcbyfktbgEE+F
	qiNchbGjhv1qlxa0K6RiXMf4Izse9y4wGPHI+M3tl78NZgwirO51DGVsmh6rMGu2+PdiZvBTB2/
	K+YxO1inN4nJVNr/gvSK1ed78/3eW92S7cX51A==
X-Received: by 2002:ac8:7f4d:0:b0:509:174d:3224 with SMTP id
 d75a77b69052e-50b15c109d1mr14316251cf.11.1773849625679; Wed, 18 Mar 2026
 09:00:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1773695307.git.ljs@kernel.org> <8e28e4b63bae67bfa1a59ccbac9dc6db1442d75d.1773695307.git.ljs@kernel.org>
In-Reply-To: <8e28e4b63bae67bfa1a59ccbac9dc6db1442d75d.1773695307.git.ljs@kernel.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 18 Mar 2026 09:00:13 -0700
X-Gm-Features: AaiRm51xXcSMS3sQHOtwlzL9JQsE-2S39fLY5xwjkClhFBo1kCA372O2Zp37zjU
Message-ID: <CAJuCfpF6eS18HLgNvQtkLGd=7N0_L1JPmF0GzM-Z0QimRWT7AQ@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9529-lists,linux-hyperv=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.953];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0C0282C0690
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 16, 2026 at 2:14=E2=80=AFPM Lorenzo Stoakes (Oracle) <ljs@kerne=
l.org> wrote:
>
> A user can invoke mmap_action_map_kernel_pages() to specify that the
> mapping should map kernel pages starting from desc->start of a specified
> number of pages specified in an array.
>
> In order to implement this, adjust mmap_action_prepare() to be able to
> return an error code, as it makes sense to assert that the specified
> parameters are valid as quickly as possible as well as updating the VMA
> flags to include VMA_MIXEDMAP_BIT as necessary.
>
> This provides an mmap_prepare equivalent of vm_insert_pages().
>
> We additionally update the existing vm_insert_pages() code to use
> range_in_vma() and add a new range_in_vma_desc() helper function for the
> mmap_prepare case, sharing the code between the two in range_is_subset().
>
> We add both mmap_action_map_kernel_pages() and
> mmap_action_map_kernel_pages_full() to allow for both partial and full VM=
A
> mappings.
>
> We also add mmap_action_map_kernel_pages_discontig() to allow for
> discontiguous mapping of kernel pages should the need arise.
>
> We update the documentation to reflect the new features.
>
> Finally, we update the VMA tests accordingly to reflect the changes.
>
> Signed-off-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>

With one nit,
Reviewed-by: Suren Baghdasaryan <surenb@google.com>

> ---
>  Documentation/filesystems/mmap_prepare.rst |  8 ++
>  include/linux/mm.h                         | 95 +++++++++++++++++++++-
>  include/linux/mm_types.h                   |  7 ++
>  mm/memory.c                                | 42 +++++++++-
>  mm/util.c                                  |  6 ++
>  tools/testing/vma/include/dup.h            |  7 ++
>  6 files changed, 159 insertions(+), 6 deletions(-)
>
> diff --git a/Documentation/filesystems/mmap_prepare.rst b/Documentation/f=
ilesystems/mmap_prepare.rst
> index be76ae475b9c..e810aa4134eb 100644
> --- a/Documentation/filesystems/mmap_prepare.rst
> +++ b/Documentation/filesystems/mmap_prepare.rst
> @@ -156,5 +156,13 @@ pointer. These are:
>  * mmap_action_simple_ioremap() - Sets up an I/O remap from a specified
>    physical address and over a specified length.
>
> +* mmap_action_map_kernel_pages() - Maps a specified array of `struct pag=
e`
> +  pointers in the VMA from a specific offset.
> +
> +* mmap_action_map_kernel_pages_full() - Maps a specified array of `struc=
t
> +  page` pointers over the entire VMA. The caller must ensure there are
> +  sufficient entries in the page array to cover the entire range of the
> +  described VMA.
> +
>  **NOTE:** The ``action`` field should never normally be manipulated dire=
ctly,
>  rather you ought to use one of these helpers.
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index df8fa6e6402b..6f0a3edb24e1 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2912,7 +2912,7 @@ static inline bool folio_maybe_mapped_shared(struct=
 folio *folio)
>   * The caller must add any reference (e.g., from folio_try_get()) it mig=
ht be
>   * holding itself to the result.
>   *
> - * Returns the expected folio refcount.
> + * Returns: the expected folio refcount.

nit: I see both "Returns:" and "Return:" being used in the codebase
but this header file uses "Return:", so for consistency you should
probably do the same. This also applies to later instances in this
patch.

>   */
>  static inline int folio_expected_ref_count(const struct folio *folio)
>  {
> @@ -4364,6 +4364,45 @@ static inline void mmap_action_simple_ioremap(stru=
ct vm_area_desc *desc,
>         action->type =3D MMAP_SIMPLE_IO_REMAP;
>  }
>
> +/**
> + * mmap_action_map_kernel_pages - helper for mmap_prepare hook to specif=
y that
> + * @num kernel pages contained in the @pages array should be mapped to u=
serland
> + * starting at virtual address @start.
> + * @desc: The VMA descriptor for the VMA requiring kernel pags to be map=
ped.
> + * @start: The virtual address from which to map them.
> + * @pages: An array of struct page pointers describing the memory to map=
.
> + * @nr_pages: The number of entries in the @pages aray.
> + */
> +static inline void mmap_action_map_kernel_pages(struct vm_area_desc *des=
c,
> +               unsigned long start, struct page **pages,
> +               unsigned long nr_pages)
> +{
> +       struct mmap_action *action =3D &desc->action;
> +
> +       action->type =3D MMAP_MAP_KERNEL_PAGES;
> +       action->map_kernel.start =3D start;
> +       action->map_kernel.pages =3D pages;
> +       action->map_kernel.nr_pages =3D nr_pages;
> +       action->map_kernel.pgoff =3D desc->pgoff;
> +}
> +
> +/**
> + * mmap_action_map_kernel_pages_full - helper for mmap_prepare hook to s=
pecify that
> + * kernel pages contained in the @pages array should be mapped to userla=
nd
> + * from @desc->start to @desc->end.
> + * @desc: The VMA descriptor for the VMA requiring kernel pags to be map=
ped.
> + * @pages: An array of struct page pointers describing the memory to map=
.
> + *
> + * The caller must ensure that @pages contains sufficient entries to cov=
er the
> + * entire range described by @desc.
> + */
> +static inline void mmap_action_map_kernel_pages_full(struct vm_area_desc=
 *desc,
> +               struct page **pages)
> +{
> +       mmap_action_map_kernel_pages(desc, desc->start, pages,
> +                                    vma_desc_pages(desc));
> +}
> +
>  int mmap_action_prepare(struct vm_area_desc *desc);
>  int mmap_action_complete(struct vm_area_struct *vma,
>                          struct mmap_action *action);
> @@ -4380,10 +4419,59 @@ static inline struct vm_area_struct *find_exact_v=
ma(struct mm_struct *mm,
>         return vma;
>  }
>
> +/**
> + * range_is_subset - Is the specified inner range a subset of the outer =
range?
> + * @outer_start: The start of the outer range.
> + * @outer_end: The exclusive end of the outer range.
> + * @inner_start: The start of the inner range.
> + * @inner_end: The exclusive end of the inner range.
> + *
> + * Returns: %true if [inner_start, inner_end) is a subset of [outer_star=
t,
> + * outer_end), otherwise %false.
> + */
> +static inline bool range_is_subset(unsigned long outer_start,
> +                                  unsigned long outer_end,
> +                                  unsigned long inner_start,
> +                                  unsigned long inner_end)
> +{
> +       return outer_start <=3D inner_start && inner_end <=3D outer_end;
> +}
> +
> +/**
> + * range_in_vma - is the specified [@start, @end) range a subset of the =
VMA?
> + * @vma: The VMA against which we want to check [@start, @end).
> + * @start: The start of the range we wish to check.
> + * @end: The exclusive end of the range we wish to check.
> + *
> + * Returns: %true if [@start, @end) is a subset of [@vma->vm_start,
> + * @vma->vm_end), %false otherwise.
> + */
>  static inline bool range_in_vma(const struct vm_area_struct *vma,
>                                 unsigned long start, unsigned long end)
>  {
> -       return (vma && vma->vm_start <=3D start && end <=3D vma->vm_end);
> +       if (!vma)
> +               return false;
> +
> +       return range_is_subset(vma->vm_start, vma->vm_end, start, end);
> +}
> +
> +/**
> + * range_in_vma_desc - is the specified [@start, @end) range a subset of=
 the VMA
> + * described by @desc, a VMA descriptor?
> + * @desc: The VMA descriptor against which we want to check [@start, @en=
d).
> + * @start: The start of the range we wish to check.
> + * @end: The exclusive end of the range we wish to check.
> + *
> + * Returns: %true if [@start, @end) is a subset of [@desc->start, @desc-=
>end),
> + * %false otherwise.
> + */
> +static inline bool range_in_vma_desc(const struct vm_area_desc *desc,
> +                                    unsigned long start, unsigned long e=
nd)
> +{
> +       if (!desc)
> +               return false;
> +
> +       return range_is_subset(desc->start, desc->end, start, end);
>  }
>
>  #ifdef CONFIG_MMU
> @@ -4427,6 +4515,9 @@ int remap_pfn_range(struct vm_area_struct *vma, uns=
igned long addr,
>  int vm_insert_page(struct vm_area_struct *, unsigned long addr, struct p=
age *);
>  int vm_insert_pages(struct vm_area_struct *vma, unsigned long addr,
>                         struct page **pages, unsigned long *num);
> +int map_kernel_pages_prepare(struct vm_area_desc *desc);
> +int map_kernel_pages_complete(struct vm_area_struct *vma,
> +                             struct mmap_action *action);
>  int vm_map_pages(struct vm_area_struct *vma, struct page **pages,
>                                 unsigned long num);
>  int vm_map_pages_zero(struct vm_area_struct *vma, struct page **pages,
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 7538d64f8848..c46224020a46 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -815,6 +815,7 @@ enum mmap_action_type {
>         MMAP_REMAP_PFN,         /* Remap PFN range. */
>         MMAP_IO_REMAP_PFN,      /* I/O remap PFN range. */
>         MMAP_SIMPLE_IO_REMAP,   /* I/O remap with guardrails. */
> +       MMAP_MAP_KERNEL_PAGES,  /* Map kernel page range from array. */
>  };
>
>  /*
> @@ -833,6 +834,12 @@ struct mmap_action {
>                         phys_addr_t start_phys_addr;
>                         unsigned long size;
>                 } simple_ioremap;
> +               struct {
> +                       unsigned long start;
> +                       struct page **pages;
> +                       unsigned long nr_pages;
> +                       pgoff_t pgoff;
> +               } map_kernel;
>         };
>         enum mmap_action_type type;
>
> diff --git a/mm/memory.c b/mm/memory.c
> index f3f4046aee97..849d5d9eeb83 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -2484,13 +2484,14 @@ static int insert_pages(struct vm_area_struct *vm=
a, unsigned long addr,
>  int vm_insert_pages(struct vm_area_struct *vma, unsigned long addr,
>                         struct page **pages, unsigned long *num)
>  {
> -       const unsigned long end_addr =3D addr + (*num * PAGE_SIZE) - 1;
> +       const unsigned long nr_pages =3D *num;
> +       const unsigned long end =3D addr + PAGE_SIZE * nr_pages;
>
> -       if (addr < vma->vm_start || end_addr >=3D vma->vm_end)
> +       if (!range_in_vma(vma, addr, end))
>                 return -EFAULT;
>         if (!(vma->vm_flags & VM_MIXEDMAP)) {
> -               BUG_ON(mmap_read_trylock(vma->vm_mm));
> -               BUG_ON(vma->vm_flags & VM_PFNMAP);
> +               VM_WARN_ON_ONCE(mmap_read_trylock(vma->vm_mm));
> +               VM_WARN_ON_ONCE(vma->vm_flags & VM_PFNMAP);
>                 vm_flags_set(vma, VM_MIXEDMAP);
>         }
>         /* Defer page refcount checking till we're about to map that page=
. */
> @@ -2498,6 +2499,39 @@ int vm_insert_pages(struct vm_area_struct *vma, un=
signed long addr,
>  }
>  EXPORT_SYMBOL(vm_insert_pages);
>
> +int map_kernel_pages_prepare(struct vm_area_desc *desc)
> +{
> +       const struct mmap_action *action =3D &desc->action;
> +       const unsigned long addr =3D action->map_kernel.start;
> +       unsigned long nr_pages, end;
> +
> +       if (!vma_desc_test(desc, VMA_MIXEDMAP_BIT)) {
> +               VM_WARN_ON_ONCE(mmap_read_trylock(desc->mm));
> +               VM_WARN_ON_ONCE(vma_desc_test(desc, VMA_PFNMAP_BIT));
> +               vma_desc_set_flags(desc, VMA_MIXEDMAP_BIT);
> +       }
> +
> +       nr_pages =3D action->map_kernel.nr_pages;
> +       end =3D addr + PAGE_SIZE * nr_pages;
> +       if (!range_in_vma_desc(desc, addr, end))
> +               return -EFAULT;
> +
> +       return 0;
> +}
> +EXPORT_SYMBOL(map_kernel_pages_prepare);
> +
> +int map_kernel_pages_complete(struct vm_area_struct *vma,
> +                             struct mmap_action *action)
> +{
> +       unsigned long nr_pages;
> +
> +       nr_pages =3D action->map_kernel.nr_pages;
> +       return insert_pages(vma, action->map_kernel.start,
> +                           action->map_kernel.pages,
> +                           &nr_pages, vma->vm_page_prot);
> +}
> +EXPORT_SYMBOL(map_kernel_pages_complete);
> +
>  /**
>   * vm_insert_page - insert single page into user vma
>   * @vma: user vma to map to
> diff --git a/mm/util.c b/mm/util.c
> index a166c48fe894..dea590e7a26c 100644
> --- a/mm/util.c
> +++ b/mm/util.c
> @@ -1441,6 +1441,8 @@ int mmap_action_prepare(struct vm_area_desc *desc)
>                 return io_remap_pfn_range_prepare(desc);
>         case MMAP_SIMPLE_IO_REMAP:
>                 return simple_ioremap_prepare(desc);
> +       case MMAP_MAP_KERNEL_PAGES:
> +               return map_kernel_pages_prepare(desc);
>         }
>
>         WARN_ON_ONCE(1);
> @@ -1472,6 +1474,9 @@ int mmap_action_complete(struct vm_area_struct *vma=
,
>         case MMAP_IO_REMAP_PFN:
>                 err =3D io_remap_pfn_range_complete(vma, action);
>                 break;
> +       case MMAP_MAP_KERNEL_PAGES:
> +               err =3D map_kernel_pages_complete(vma, action);
> +               break;
>         case MMAP_SIMPLE_IO_REMAP:
>                 /*
>                  * The simple I/O remap should have been delegated to an =
I/O
> @@ -1494,6 +1499,7 @@ int mmap_action_prepare(struct vm_area_desc *desc)
>         case MMAP_REMAP_PFN:
>         case MMAP_IO_REMAP_PFN:
>         case MMAP_SIMPLE_IO_REMAP:
> +       case MMAP_MAP_KERNEL_PAGES:
>                 WARN_ON_ONCE(1); /* nommu cannot handle these. */
>                 break;
>         }
> diff --git a/tools/testing/vma/include/dup.h b/tools/testing/vma/include/=
dup.h
> index 6658df26698a..4407caf207ad 100644
> --- a/tools/testing/vma/include/dup.h
> +++ b/tools/testing/vma/include/dup.h
> @@ -454,6 +454,7 @@ enum mmap_action_type {
>         MMAP_REMAP_PFN,         /* Remap PFN range. */
>         MMAP_IO_REMAP_PFN,      /* I/O remap PFN range. */
>         MMAP_SIMPLE_IO_REMAP,   /* I/O remap with guardrails. */
> +       MMAP_MAP_KERNEL_PAGES,  /* Map kernel page range from an array. *=
/
>  };
>
>  /*
> @@ -472,6 +473,12 @@ struct mmap_action {
>                         phys_addr_t start;
>                         unsigned long len;
>                 } simple_ioremap;
> +               struct {
> +                       unsigned long start;
> +                       struct page **pages;
> +                       unsigned long num;
> +                       pgoff_t pgoff;
> +               } map_kernel;
>         };
>         enum mmap_action_type type;
>
> --
> 2.53.0
>

