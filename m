Return-Path: <linux-hyperv+bounces-9418-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cObSNZo7t2kIOgEAu9opvQ
	(envelope-from <linux-hyperv+bounces-9418-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 16 Mar 2026 00:07:06 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D6AF292F0D
	for <lists+linux-hyperv@lfdr.de>; Mon, 16 Mar 2026 00:07:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3B7263017264
	for <lists+linux-hyperv@lfdr.de>; Sun, 15 Mar 2026 23:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 852ED288517;
	Sun, 15 Mar 2026 23:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A3/AQdDH"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7267E287246
	for <linux-hyperv@vger.kernel.org>; Sun, 15 Mar 2026 23:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773616023; cv=pass; b=k1IniImCN6+XzNQObba8W9/8LgHEPDnoVOUsbjZXtaONbvnbIzP5Yqddwi0QFBZ1TkpYT4399cVf2rFyFJfCZNonkTh8cC/eG6yqifUHp5EeeffCWAaqL7P6xmhYUmPL/h7KJLhVQiDjjv0STnOssIPAi3YPS98qjl3kNy+l9Q0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773616023; c=relaxed/simple;
	bh=KfoNb0kVsE3tFAeeH627EIvPTN8PVYgbuEtqyKzDT58=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FwXYjYEI1OXmBl8RlFCf6SYtUG6TpYoiomDGvFQal0Da0SAu/yVzFiwc8B5MaHa6g1xpSbu/FdHho0iOnuhllD5tOfTmCdT7eO+MzeM9XD5MzU8x/2XYScRsTlDcz2nCb6wLQKPkLZcqd4aUc4HPKPh9NUUxPiPrUu8oSagBPWM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=A3/AQdDH; arc=pass smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-509069a7a7fso756751cf.0
        for <linux-hyperv@vger.kernel.org>; Sun, 15 Mar 2026 16:07:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773616020; cv=none;
        d=google.com; s=arc-20240605;
        b=jNkW+0dWPYxynjSZZqK1JbmZp+ipEtcqG0jq+qF+CcigyfrEZarfSX55e5dHnpYkEs
         AhQHJ1y/0ETNKBuJajNaJxubwSwgQF0xbr0bcsGbRsZ6UhXDLbLsBDD52zVU9aBYhmzr
         4Uy0cUKykQVM6xLpML4kNE9JB2APcedW7j6/VZO1ylFBdQYdxI1fVlCpL/Eh+DMFpcn7
         QmmfT+/oCZsJfoOtHbGsCYFdjJScG45FWYKXTrfkiYFqQN372tUZ+8UEc7jLuRvS2eCY
         7IidXoVmpUkxEsvo/PihGS6v68Bp5FlDysW8jOx9lN7q2168c8/6sfDjRsi+y22bDAQZ
         8vYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Hh22nL2hmMEFUrxwvQFcCzGFSdbPAraMrEXF5oyKKdU=;
        fh=MwyuNHtCmmzAvWrm3e6SlD+JQja2VGIeV+HpfALtkeo=;
        b=ZUKIAxZdCD/oTyeXNfpv1/Yjj6DEaLYlDxP92uqSePS+kqxAXvjMpxAuGyL3oYoEWp
         3IFL1+WNmqKnDDI52nU3KRlgbn3kF/j/nyhlt0d/jBqfBq2wsMlf7GkZW6VQGyE0WMD/
         i5e6K0mSe0FcpA3WZ0BawzoDeYqxtDUkkomZBrWbdxXGYFkXodnpnTjHT8u7HORijIfq
         CPeH8cLbYdunEUHolGBQSFac1MLyzL0IoTHj29E2SsWj+gbFKqkH5CWqUFuFxzIuVonY
         pASZpNTXVQ/NEm+eQZntvTfKN8c+u9PIGmo9RnD7Oj27ROHgyPvlyIJYmD08pUTJ8flM
         59Lw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773616020; x=1774220820; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hh22nL2hmMEFUrxwvQFcCzGFSdbPAraMrEXF5oyKKdU=;
        b=A3/AQdDHZkRZrXzh9/JGI7NpXdyTda+HTp9xSNjMSKn/aFCrAGEcjkCZbL6PAgvsVp
         GrFt2vapNz6atIRZOJT9HbYgjE/Twt33cuQP5VDDYwyg9R052ZFL8ldzHmb6sYhbFyDS
         /+rcoQNipKQA62LzDuBX3fGxGNBBjjDBgKw872tJZF3pFRwOGuf/Tx0GzdMjaw/sFvNm
         DLDbIVvs0lDDbrHEq2lI1RXTKxL8biJ3a/lZzo4evuwpTLvt+l6+eyQMO3Gh5dZau/YA
         G6oDJuOdHx3TQ+AxV6bikN9FOUptf1rnK0zv+szJpkcMXZYUmzZqCtJbuETt211q71kz
         SrLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773616020; x=1774220820;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Hh22nL2hmMEFUrxwvQFcCzGFSdbPAraMrEXF5oyKKdU=;
        b=CZANnS6jqac710DTq51x1ZdOYy8IEZGShFkJKDL2czZW3INpflUD1GxG5gaMMETfar
         ZjnUVHsSsjStz8294vwmtZHDykwYfaTECqCcWsUt1X3Rtk0+c/vw+3OgNE5iCCairF6L
         UuUwyjfE80u6jCHLhQiakY/5tqzaLcncwf649+7IjGfik9kOaQwujp1ULCfS/bnSfg+6
         mldgxzQvmgJY87oHHKjFbFmLH0nRb+iTMo2qhQTrvQGP+9uNESCNabyR2nGhrDw9Wa6+
         nykyQOOn9hpFeW8UUghfB4LCY320eK1j3Zw2VzIk1VZfXCCjFziRkwkjprik1LcAePEf
         qxuA==
X-Forwarded-Encrypted: i=1; AJvYcCXjePqmc3AW6u5p6+sHsjyC6rlcpG6AnHwn3o1wrxcRmynU75/0vxJZycbIM7hsDtm6lG7gqxvAZL7I2mg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpjpE9Ff1TM0CBedg8A0pyVu9DmjfhEXczUdc2h17je08DiKeN
	OPPeiAb4l6iRPzFSzdp1u2hRsmy4p2ZN8lRejqU5gErUPlARw+m2Znq5xhg6JGHZj06uDv+LbpU
	lbRZiXdGAhDGY7rB3i0Z8trT5r5ljEzB61duAcSJK
X-Gm-Gg: ATEYQzxNmdLS3EAlwSCot2QLMc57iwm4lInA1uXcHawho/ei6XBm2TWKvzBd1DPpauF
	a5C1Tzm+WQd9r7GiiqFp3M7gtmOnVjspVQlNfyp7KsrIimU/WTzgn6IhuJ8FEGUnXcUolIDpHaa
	K69bX7GJhVhB7dOTH4iHay5wA2bvjj+j/c00k9IBJNxYAu3uGe+BaSOF2PjOCn8M/l/tA/qzFlJ
	1Oo8tbrGj/HxQ2pzoQS8CKzXwvClbak8FDcveRKQUug81RnWChjvLj6jpdzblxDEv25tj64BsGZ
	odFbww==
X-Received: by 2002:a05:622a:120b:b0:509:1471:1bc2 with SMTP id
 d75a77b69052e-5096aa498a9mr17201381cf.17.1773616019620; Sun, 15 Mar 2026
 16:06:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1773346620.git.ljs@kernel.org> <56372fe273f775b26675a04652c1229e14680741.1773346620.git.ljs@kernel.org>
 <CAJuCfpEsCrFEYNkkTfRLGojGOYAAx1=WOojOhpBb_=WZBr6bnQ@mail.gmail.com>
In-Reply-To: <CAJuCfpEsCrFEYNkkTfRLGojGOYAAx1=WOojOhpBb_=WZBr6bnQ@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Sun, 15 Mar 2026 16:06:48 -0700
X-Gm-Features: AaiRm528N1qqT5kapRSRN59l9MR0Mu1tnA4LnOTUgRsLLsulGwtoq5YjHKPeuow
Message-ID: <CAJuCfpHcjFU1r7ixiJM4b_a5HTesxBmW6DiCreaWpJ8DLM5haQ@mail.gmail.com>
Subject: Re: [PATCH 01/15] mm: various small mmap_prepare cleanups
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9418-lists,linux-hyperv=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 7D6AF292F0D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, Mar 15, 2026 at 3:56=E2=80=AFPM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> On Thu, Mar 12, 2026 at 1:27=E2=80=AFPM Lorenzo Stoakes (Oracle) <ljs@ker=
nel.org> wrote:
> >
> > Rather than passing arbitrary fields, pass an mmap_action field directl=
y to
> > mmap prepare and complete helpers to put all the action-specific logic =
in
> > the function actually doing the work.
> >
> > Additionally, allow mmap prepare functions to return an error so we can
> > error out as soon as possible if there is something logically incorrect=
 in
> > the input.
> >
> > Update remap_pfn_range_prepare() to properly check the input range for =
the
> > CoW case.
>
> By "properly check" do you mean the replacement of desc->start and
> desc->end with action->remap.start and action->remap.start +
> action->remap.size when calling get_remap_pgoff() from
> remap_pfn_range_prepare()?
>
> >
> > While we're here, make remap_pfn_range_prepare_vma() a little neater, a=
nd
> > pass mmap_action directly to call_action_complete().
> >
> > Then, update compat_vma_mmap() to perform its logic directly, as
> > __compat_vma_map() is not used by anything so we don't need to export i=
t.
>
> Not directly related to this patch but while reviewing, I was also
> checking vma locking rules in this mmap_prepare() + mmap() sequence
> and I noticed that the new VMA flag modification functions like
> vma_set_flags_mask() do assert vma_assert_locked(vma). It would be
> useful to add these but as a separate change. I will add it to my todo
> list.
>
> >
> > Also update compat_vma_mmap() to use vfs_mmap_prepare() rather than cal=
ling
> > the mmap_prepare op directly.
> >
> > Finally, update the VMA userland tests to reflect the changes.
> >
> > Signed-off-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>
> > ---
> >  include/linux/fs.h                |   2 -
> >  include/linux/mm.h                |   8 +--
> >  mm/internal.h                     |  28 +++++---
> >  mm/memory.c                       |  45 +++++++-----
> >  mm/util.c                         | 112 +++++++++++++-----------------
> >  mm/vma.c                          |  21 +++---
> >  tools/testing/vma/include/dup.h   |   9 ++-
> >  tools/testing/vma/include/stubs.h |   9 +--
> >  8 files changed, 123 insertions(+), 111 deletions(-)
> >
> > diff --git a/include/linux/fs.h b/include/linux/fs.h
> > index 8b3dd145b25e..a2628a12bd2b 100644
> > --- a/include/linux/fs.h
> > +++ b/include/linux/fs.h
> > @@ -2058,8 +2058,6 @@ static inline bool can_mmap_file(struct file *fil=
e)
> >         return true;
> >  }
> >
> > -int __compat_vma_mmap(const struct file_operations *f_op,
> > -               struct file *file, struct vm_area_struct *vma);
> >  int compat_vma_mmap(struct file *file, struct vm_area_struct *vma);
> >
> >  static inline int vfs_mmap(struct file *file, struct vm_area_struct *v=
ma)
> > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > index 4c4fd55fc823..cc5960a84382 100644
> > --- a/include/linux/mm.h
> > +++ b/include/linux/mm.h
> > @@ -4116,10 +4116,10 @@ static inline void mmap_action_ioremap_full(str=
uct vm_area_desc *desc,
> >         mmap_action_ioremap(desc, desc->start, start_pfn, vma_desc_size=
(desc));
> >  }
> >
> > -void mmap_action_prepare(struct mmap_action *action,
> > -                        struct vm_area_desc *desc);
> > -int mmap_action_complete(struct mmap_action *action,
> > -                        struct vm_area_struct *vma);
> > +int mmap_action_prepare(struct vm_area_desc *desc,
> > +                       struct mmap_action *action);
> > +int mmap_action_complete(struct vm_area_struct *vma,
> > +                        struct mmap_action *action);
> >
> >  /* Look up the first VMA which exactly match the interval vm_start ...=
 vm_end */
> >  static inline struct vm_area_struct *find_exact_vma(struct mm_struct *=
mm,
> > diff --git a/mm/internal.h b/mm/internal.h
> > index 95b583e7e4f7..7bfa85b5e78b 100644
> > --- a/mm/internal.h
> > +++ b/mm/internal.h
> > @@ -1775,26 +1775,32 @@ int walk_page_range_debug(struct mm_struct *mm,=
 unsigned long start,
> >  void dup_mm_exe_file(struct mm_struct *mm, struct mm_struct *oldmm);
> >  int dup_mmap(struct mm_struct *mm, struct mm_struct *oldmm);
> >
> > -void remap_pfn_range_prepare(struct vm_area_desc *desc, unsigned long =
pfn);
> > -int remap_pfn_range_complete(struct vm_area_struct *vma, unsigned long=
 addr,
> > -               unsigned long pfn, unsigned long size, pgprot_t pgprot)=
;
> > +int remap_pfn_range_prepare(struct vm_area_desc *desc,
> > +                           struct mmap_action *action);
> > +int remap_pfn_range_complete(struct vm_area_struct *vma,
> > +                            struct mmap_action *action);
> >
> > -static inline void io_remap_pfn_range_prepare(struct vm_area_desc *des=
c,
> > -               unsigned long orig_pfn, unsigned long size)
> > +static inline int io_remap_pfn_range_prepare(struct vm_area_desc *desc=
,
> > +                                            struct mmap_action *action=
)
> >  {
> > +       const unsigned long orig_pfn =3D action->remap.start_pfn;
> > +       const unsigned long size =3D action->remap.size;
> >         const unsigned long pfn =3D io_remap_pfn_range_pfn(orig_pfn, si=
ze);
> >
> > -       return remap_pfn_range_prepare(desc, pfn);
> > +       action->remap.start_pfn =3D pfn;
> > +       return remap_pfn_range_prepare(desc, action);
> >  }
> >
> >  static inline int io_remap_pfn_range_complete(struct vm_area_struct *v=
ma,
> > -               unsigned long addr, unsigned long orig_pfn, unsigned lo=
ng size,
> > -               pgprot_t orig_prot)
> > +                                             struct mmap_action *actio=
n)
> >  {
> > -       const unsigned long pfn =3D io_remap_pfn_range_pfn(orig_pfn, si=
ze);
> > -       const pgprot_t prot =3D pgprot_decrypted(orig_prot);
> > +       const unsigned long size =3D action->remap.size;
> > +       const unsigned long orig_pfn =3D action->remap.start_pfn;
> > +       const pgprot_t orig_prot =3D vma->vm_page_prot;
> >
> > -       return remap_pfn_range_complete(vma, addr, pfn, size, prot);
> > +       action->remap.pgprot =3D pgprot_decrypted(orig_prot);

I'm guessing it doesn't really matter but after this change
action->remap.pgprot will store the decrypted value while before this
change it was kept the way mmap_prepare() originally set it. We pass
the action structure later to mmap_action_finish() but it does not use
action->remap.pgprot, so this probably doesn't matter.

> > +       action->remap.start_pfn  =3D io_remap_pfn_range_pfn(orig_pfn, s=
ize);
> > +       return remap_pfn_range_complete(vma, action);
> >  }
> >
> >  #ifdef CONFIG_MMU_NOTIFIER
> > diff --git a/mm/memory.c b/mm/memory.c
> > index 6aa0ea4af1fc..364fa8a45360 100644
> > --- a/mm/memory.c
> > +++ b/mm/memory.c
> > @@ -3099,26 +3099,34 @@ static int do_remap_pfn_range(struct vm_area_st=
ruct *vma, unsigned long addr,
> >  }
> >  #endif
> >
> > -void remap_pfn_range_prepare(struct vm_area_desc *desc, unsigned long =
pfn)
> > +int remap_pfn_range_prepare(struct vm_area_desc *desc,
> > +                           struct mmap_action *action)
> >  {
> > -       /*
> > -        * We set addr=3DVMA start, end=3DVMA end here, so this won't f=
ail, but we
> > -        * check it again on complete and will fail there if specified =
addr is
> > -        * invalid.
> > -        */
> > -       get_remap_pgoff(vma_desc_is_cow_mapping(desc), desc->start, des=
c->end,
> > -                       desc->start, desc->end, pfn, &desc->pgoff);
> > +       const unsigned long start =3D action->remap.start;
> > +       const unsigned long end =3D start + action->remap.size;
> > +       const unsigned long pfn =3D action->remap.start_pfn;
> > +       const bool is_cow =3D vma_desc_is_cow_mapping(desc);
>
> I was trying to figure out who sets action->remap.start and
> action->remap.size and if they somehow guaranteed to be always equal
> to desc->start and (desc->end - desc->start). My understanding is that
> action->remap.start and action->remap.size are set by
> f_op->mmap_prepare() but I'm not sure if they are always the same as
> desc->start and (desc->end - desc->start) and if so, how do we enforce
> that.
>
> > +       int err;
> > +
> > +       err =3D get_remap_pgoff(is_cow, start, end, desc->start, desc->=
end, pfn,
> > +                             &desc->pgoff);
> > +       if (err)
> > +               return err;
> > +
> >         vma_desc_set_flags_mask(desc, VMA_REMAP_FLAGS);
> > +       return 0;
> >  }
> >
> > -static int remap_pfn_range_prepare_vma(struct vm_area_struct *vma, uns=
igned long addr,
> > -               unsigned long pfn, unsigned long size)
> > +static int remap_pfn_range_prepare_vma(struct vm_area_struct *vma,
> > +                                      unsigned long addr, unsigned lon=
g pfn,
> > +                                      unsigned long size)
> >  {
> > -       unsigned long end =3D addr + PAGE_ALIGN(size);
> > +       const unsigned long end =3D addr + PAGE_ALIGN(size);
> > +       const bool is_cow =3D is_cow_mapping(vma->vm_flags);
> >         int err;
> >
> > -       err =3D get_remap_pgoff(is_cow_mapping(vma->vm_flags), addr, en=
d,
> > -                             vma->vm_start, vma->vm_end, pfn, &vma->vm=
_pgoff);
> > +       err =3D get_remap_pgoff(is_cow, addr, end, vma->vm_start, vma->=
vm_end,
> > +                             pfn, &vma->vm_pgoff);
> >         if (err)
> >                 return err;
> >
> > @@ -3151,10 +3159,15 @@ int remap_pfn_range(struct vm_area_struct *vma,=
 unsigned long addr,
> >  }
> >  EXPORT_SYMBOL(remap_pfn_range);
> >
> > -int remap_pfn_range_complete(struct vm_area_struct *vma, unsigned long=
 addr,
> > -               unsigned long pfn, unsigned long size, pgprot_t prot)
> > +int remap_pfn_range_complete(struct vm_area_struct *vma,
> > +                            struct mmap_action *action)
> >  {
> > -       return do_remap_pfn_range(vma, addr, pfn, size, prot);
> > +       const unsigned long start =3D action->remap.start;
> > +       const unsigned long pfn =3D action->remap.start_pfn;
> > +       const unsigned long size =3D action->remap.size;
> > +       const pgprot_t prot =3D action->remap.pgprot;
> > +
> > +       return do_remap_pfn_range(vma, start, pfn, size, prot);
> >  }
> >
> >  /**
> > diff --git a/mm/util.c b/mm/util.c
> > index ce7ae80047cf..dba1191725b6 100644
> > --- a/mm/util.c
> > +++ b/mm/util.c
> > @@ -1163,43 +1163,6 @@ void flush_dcache_folio(struct folio *folio)
> >  EXPORT_SYMBOL(flush_dcache_folio);
> >  #endif
> >
> > -/**
> > - * __compat_vma_mmap() - See description for compat_vma_mmap()
> > - * for details. This is the same operation, only with a specific file =
operations
> > - * struct which may or may not be the same as vma->vm_file->f_op.
> > - * @f_op: The file operations whose .mmap_prepare() hook is specified.
> > - * @file: The file which backs or will back the mapping.
> > - * @vma: The VMA to apply the .mmap_prepare() hook to.
> > - * Returns: 0 on success or error.
> > - */
> > -int __compat_vma_mmap(const struct file_operations *f_op,
> > -               struct file *file, struct vm_area_struct *vma)
> > -{
> > -       struct vm_area_desc desc =3D {
> > -               .mm =3D vma->vm_mm,
> > -               .file =3D file,
> > -               .start =3D vma->vm_start,
> > -               .end =3D vma->vm_end,
> > -
> > -               .pgoff =3D vma->vm_pgoff,
> > -               .vm_file =3D vma->vm_file,
> > -               .vma_flags =3D vma->flags,
> > -               .page_prot =3D vma->vm_page_prot,
> > -
> > -               .action.type =3D MMAP_NOTHING, /* Default */
> > -       };
> > -       int err;
> > -
> > -       err =3D f_op->mmap_prepare(&desc);
> > -       if (err)
> > -               return err;
> > -
> > -       mmap_action_prepare(&desc.action, &desc);
> > -       set_vma_from_desc(vma, &desc);
> > -       return mmap_action_complete(&desc.action, vma);
> > -}
> > -EXPORT_SYMBOL(__compat_vma_mmap);
> > -
> >  /**
> >   * compat_vma_mmap() - Apply the file's .mmap_prepare() hook to an
> >   * existing VMA and execute any requested actions.
> > @@ -1228,7 +1191,31 @@ EXPORT_SYMBOL(__compat_vma_mmap);
> >   */
> >  int compat_vma_mmap(struct file *file, struct vm_area_struct *vma)
> >  {
> > -       return __compat_vma_mmap(file->f_op, file, vma);
> > +       struct vm_area_desc desc =3D {
> > +               .mm =3D vma->vm_mm,
> > +               .file =3D file,
> > +               .start =3D vma->vm_start,
> > +               .end =3D vma->vm_end,
> > +
> > +               .pgoff =3D vma->vm_pgoff,
> > +               .vm_file =3D vma->vm_file,
> > +               .vma_flags =3D vma->flags,
> > +               .page_prot =3D vma->vm_page_prot,
> > +
> > +               .action.type =3D MMAP_NOTHING, /* Default */
> > +       };
> > +       int err;
> > +
> > +       err =3D vfs_mmap_prepare(file, &desc);
> > +       if (err)
> > +               return err;
> > +
> > +       err =3D mmap_action_prepare(&desc, &desc.action);
> > +       if (err)
> > +               return err;
> > +
> > +       set_vma_from_desc(vma, &desc);
> > +       return mmap_action_complete(vma, &desc.action);
> >  }
> >  EXPORT_SYMBOL(compat_vma_mmap);
> >
> > @@ -1320,8 +1307,8 @@ void snapshot_page(struct page_snapshot *ps, cons=
t struct page *page)
> >         }
> >  }
> >
> > -static int mmap_action_finish(struct mmap_action *action,
> > -               const struct vm_area_struct *vma, int err)
> > +static int mmap_action_finish(struct vm_area_struct *vma,
> > +                             struct mmap_action *action, int err)
> >  {
> >         /*
> >          * If an error occurs, unmap the VMA altogether and return an e=
rror. We
> > @@ -1355,35 +1342,36 @@ static int mmap_action_finish(struct mmap_actio=
n *action,
> >   * action which need to be performed.
> >   * @desc: The VMA descriptor to prepare for @action.
> >   * @action: The action to perform.
> > + *
> > + * Returns: 0 on success, otherwise error.
> >   */
> > -void mmap_action_prepare(struct mmap_action *action,
> > -                        struct vm_area_desc *desc)
> > +int mmap_action_prepare(struct vm_area_desc *desc,
> > +                       struct mmap_action *action)
>
> Any reason you are swapping the arguments?
> It also looks like we always call mmap_action_prepare() with action =3D=
=3D
> desc->action, like this: mmap_action_prepare(&desc.action, &desc). Why
> don't we eliminate the action parameter altogether and use desc.action
> from inside the function?
>
> > +
>
> extra new line.
>
> >  {
> >         switch (action->type) {
> >         case MMAP_NOTHING:
> > -               break;
> > +               return 0;
> >         case MMAP_REMAP_PFN:
> > -               remap_pfn_range_prepare(desc, action->remap.start_pfn);
> > -               break;
> > +               return remap_pfn_range_prepare(desc, action);
> >         case MMAP_IO_REMAP_PFN:
> > -               io_remap_pfn_range_prepare(desc, action->remap.start_pf=
n,
> > -                                          action->remap.size);
> > -               break;
> > +               return io_remap_pfn_range_prepare(desc, action);
> >         }
> >  }
> >  EXPORT_SYMBOL(mmap_action_prepare);
> >
> >  /**
> >   * mmap_action_complete - Execute VMA descriptor action.
> > - * @action: The action to perform.
> >   * @vma: The VMA to perform the action upon.
> > + * @action: The action to perform.
> >   *
> >   * Similar to mmap_action_prepare().
> >   *
> >   * Return: 0 on success, or error, at which point the VMA will be unma=
pped.
> >   */
> > -int mmap_action_complete(struct mmap_action *action,
> > -                        struct vm_area_struct *vma)
> > +int mmap_action_complete(struct vm_area_struct *vma,
> > +                        struct mmap_action *action)
> > +
> >  {
> >         int err =3D 0;
> >
> > @@ -1391,23 +1379,19 @@ int mmap_action_complete(struct mmap_action *ac=
tion,
> >         case MMAP_NOTHING:
> >                 break;
> >         case MMAP_REMAP_PFN:
> > -               err =3D remap_pfn_range_complete(vma, action->remap.sta=
rt,
> > -                               action->remap.start_pfn, action->remap.=
size,
> > -                               action->remap.pgprot);
> > +               err =3D remap_pfn_range_complete(vma, action);
> >                 break;
> >         case MMAP_IO_REMAP_PFN:
> > -               err =3D io_remap_pfn_range_complete(vma, action->remap.=
start,
> > -                               action->remap.start_pfn, action->remap.=
size,
> > -                               action->remap.pgprot);
> > +               err =3D io_remap_pfn_range_complete(vma, action);
> >                 break;
> >         }
> >
> > -       return mmap_action_finish(action, vma, err);
> > +       return mmap_action_finish(vma, action, err);
> >  }
> >  EXPORT_SYMBOL(mmap_action_complete);
> >  #else
> > -void mmap_action_prepare(struct mmap_action *action,
> > -                       struct vm_area_desc *desc)
> > +int mmap_action_prepare(struct vm_area_desc *desc,
> > +                       struct mmap_action *action)
> >  {
> >         switch (action->type) {
> >         case MMAP_NOTHING:
> > @@ -1417,11 +1401,13 @@ void mmap_action_prepare(struct mmap_action *ac=
tion,
> >                 WARN_ON_ONCE(1); /* nommu cannot handle these. */
> >                 break;
> >         }
> > +
> > +       return 0;
> >  }
> >  EXPORT_SYMBOL(mmap_action_prepare);
> >
> > -int mmap_action_complete(struct mmap_action *action,
> > -                       struct vm_area_struct *vma)
> > +int mmap_action_complete(struct vm_area_struct *vma,
> > +                        struct mmap_action *action)
> >  {
> >         int err =3D 0;
> >
> > @@ -1436,7 +1422,7 @@ int mmap_action_complete(struct mmap_action *acti=
on,
> >                 break;
> >         }
> >
> > -       return mmap_action_finish(action, vma, err);
> > +       return mmap_action_finish(vma, action, err);
> >  }
> >  EXPORT_SYMBOL(mmap_action_complete);
> >  #endif
> > diff --git a/mm/vma.c b/mm/vma.c
> > index be64f781a3aa..054cf1d262fb 100644
> > --- a/mm/vma.c
> > +++ b/mm/vma.c
> > @@ -2613,15 +2613,19 @@ static void __mmap_complete(struct mmap_state *=
map, struct vm_area_struct *vma)
> >         vma_set_page_prot(vma);
> >  }
> >
> > -static void call_action_prepare(struct mmap_state *map,
> > -                               struct vm_area_desc *desc)
> > +static int call_action_prepare(struct mmap_state *map,
> > +                              struct vm_area_desc *desc)
> >  {
> >         struct mmap_action *action =3D &desc->action;
> > +       int err;
> >
> > -       mmap_action_prepare(action, desc);
> > +       err =3D mmap_action_prepare(desc, action);
> > +       if (err)
> > +               return err;
> >
> >         if (action->hide_from_rmap_until_complete)
> >                 map->hold_file_rmap_lock =3D true;
> > +       return 0;
> >  }
> >
> >  /*
> > @@ -2645,7 +2649,9 @@ static int call_mmap_prepare(struct mmap_state *m=
ap,
> >         if (err)
> >                 return err;
> >
> > -       call_action_prepare(map, desc);
> > +       err =3D call_action_prepare(map, desc);
> > +       if (err)
> > +               return err;
> >
> >         /* Update fields permitted to be changed. */
> >         map->pgoff =3D desc->pgoff;
> > @@ -2700,13 +2706,12 @@ static bool can_set_ksm_flags_early(struct mmap=
_state *map)
> >  }
> >
> >  static int call_action_complete(struct mmap_state *map,
> > -                               struct vm_area_desc *desc,
> > +                               struct mmap_action *action,
> >                                 struct vm_area_struct *vma)
> >  {
> > -       struct mmap_action *action =3D &desc->action;
> >         int ret;
> >
> > -       ret =3D mmap_action_complete(action, vma);
> > +       ret =3D mmap_action_complete(vma, action);
> >
> >         /* If we held the file rmap we need to release it. */
> >         if (map->hold_file_rmap_lock) {
> > @@ -2768,7 +2773,7 @@ static unsigned long __mmap_region(struct file *f=
ile, unsigned long addr,
> >         __mmap_complete(&map, vma);
> >
> >         if (have_mmap_prepare && allocated_new) {
> > -               error =3D call_action_complete(&map, &desc, vma);
> > +               error =3D call_action_complete(&map, &desc.action, vma)=
;
> >
> >                 if (error)
> >                         return error;
> > diff --git a/tools/testing/vma/include/dup.h b/tools/testing/vma/includ=
e/dup.h
> > index 5eb313beb43d..908beb263307 100644
> > --- a/tools/testing/vma/include/dup.h
> > +++ b/tools/testing/vma/include/dup.h
> > @@ -1106,7 +1106,7 @@ static inline int __compat_vma_mmap(const struct =
file_operations *f_op,
> >
> >                 .pgoff =3D vma->vm_pgoff,
> >                 .vm_file =3D vma->vm_file,
> > -               .vm_flags =3D vma->vm_flags,
> > +               .vma_flags =3D vma->flags,
> >                 .page_prot =3D vma->vm_page_prot,
> >
> >                 .action.type =3D MMAP_NOTHING, /* Default */
> > @@ -1117,9 +1117,12 @@ static inline int __compat_vma_mmap(const struct=
 file_operations *f_op,
> >         if (err)
> >                 return err;
> >
> > -       mmap_action_prepare(&desc.action, &desc);
> > +       err =3D mmap_action_prepare(&desc, &desc.action);
> > +       if (err)
> > +               return err;
> > +
> >         set_vma_from_desc(vma, &desc);
> > -       return mmap_action_complete(&desc.action, vma);
> > +       return mmap_action_complete(vma, &desc.action);
> >  }
> >
> >  static inline int compat_vma_mmap(struct file *file,
> > diff --git a/tools/testing/vma/include/stubs.h b/tools/testing/vma/incl=
ude/stubs.h
> > index 947a3a0c2566..76c4b668bc62 100644
> > --- a/tools/testing/vma/include/stubs.h
> > +++ b/tools/testing/vma/include/stubs.h
> > @@ -81,13 +81,14 @@ static inline void free_anon_vma_name(struct vm_are=
a_struct *vma)
> >  {
> >  }
> >
> > -static inline void mmap_action_prepare(struct mmap_action *action,
> > -                                          struct vm_area_desc *desc)
> > +static inline int mmap_action_prepare(struct vm_area_desc *desc,
> > +                                     struct mmap_action *action)
> >  {
> > +       return 0;
> >  }
> >
> > -static inline int mmap_action_complete(struct mmap_action *action,
> > -                                          struct vm_area_struct *vma)
> > +static inline int mmap_action_complete(struct vm_area_struct *vma,
> > +                                      struct mmap_action *action)
> >  {
> >         return 0;
> >  }
> > --
> > 2.53.0
> >

