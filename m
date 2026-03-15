Return-Path: <linux-hyperv+bounces-9417-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wNUDEUo5t2nVOAEAu9opvQ
	(envelope-from <linux-hyperv+bounces-9417-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Sun, 15 Mar 2026 23:57:14 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E02F292ECA
	for <lists+linux-hyperv@lfdr.de>; Sun, 15 Mar 2026 23:57:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 316463015718
	for <lists+linux-hyperv@lfdr.de>; Sun, 15 Mar 2026 22:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E56E2749E6;
	Sun, 15 Mar 2026 22:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VFH0yDcJ"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D88626FD93
	for <linux-hyperv@vger.kernel.org>; Sun, 15 Mar 2026 22:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773615429; cv=pass; b=fdh6BV9jERLD5ArxOyZwyzhxJfHGLekUCtvfuVEHU3MuXtyA5kl81tC3Ib530xg+OsYSjx5vvWWBsNAnt9vxtOR8lShCnmwe+LwgbkIWQQ8+jn2VfKSU34XmeKlTqrpXSH2REOhVMf3w8loO3F16QMSC/CvUMk1MMyhRzbXQ9kY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773615429; c=relaxed/simple;
	bh=N757Y417PUVmBRoZCQ0NlAOx/jmlSMjJ+pd868QTWSI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TRrp9y48hGziUtf8K0XrgO0Y1F8GH6UpM8j0sZWL0VXP2RWtAFXGx7L6/2qHgbw9A3RsHS7tRW1NdjDRIndU5tfxG2Kbigi0/ln6ffH/U/ArQyZCAFvcP+MG/salTs4J3sqw14ma8qczNhSYAkBYl0vYdMcKjU0bdIKJg7MRB0A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VFH0yDcJ; arc=pass smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-50906a98ffeso710711cf.0
        for <linux-hyperv@vger.kernel.org>; Sun, 15 Mar 2026 15:57:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773615426; cv=none;
        d=google.com; s=arc-20240605;
        b=gfOTo9ZYG/GUnCpehMtEOTOvnZc+2Q2mHi5CO77SawA1Y91oOlRd5VVr7uq+8ERN8N
         0XLJA+gbjP9rz66tBHCY/afZNMUMxJFD5clnAzxMic7j02VMy/qWoK4LY7+nM+pC74SN
         hxEYk8fmtif8AM3rJqu+xTeiHwO6cjBZoscaW/pHV4vXkxZEMcsD8tE9+pH34F7THYPe
         ERyZgAbq7PDZ4o5op4bFiSL7EBThT/Qd8rUHivfhh34vMGUIk1L6cdSK07yxRpxEZEB0
         q3MdulkJAuf5xNHy4EYSe1kvLWfofsrsgPLrZHwyQXPU1/9/ggUaKFmyMK+7V51/DYOT
         ZQeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uCXOqQYTnzGNhQPDiApCXbqWFijYEREGO2671+swbzA=;
        fh=pTJgpxRPWBK9MvjdrXSSdJxAfJbZW2cbvwvLeRY+ma8=;
        b=KvNkDuxBefhzaUaJEiMBH2lHT966YF8PQo+mMoJt65FdypxX5mCENCTohRsCgE7D4c
         lFeUniWTGMmGeBXkExDjsjvF8hVcPg3CSV7md7B+khjW5ICZq0ZXFh+ruKiQ4FgNl/6+
         KmbFnfPeupBdMl3TGnPVE/xzNIGpznuMr+Z+jJOt6m4wGuMbjgGTZczAXNtHJRhbRUoN
         LgGiGPHb4o05xelbWxQKGWa5lW9Flj/QEl3ln2QZ+jyvZfUE2qJY2fFfxL7WTF1y1c1d
         2NbQHTFfT6PHmiVJlHW+q4bwzT2034IQCMGOZr9DZOiqL/xDixJosKi2lzr8AHexHpJD
         zVwg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773615426; x=1774220226; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uCXOqQYTnzGNhQPDiApCXbqWFijYEREGO2671+swbzA=;
        b=VFH0yDcJJr+Lxf1MfPElUlNs506geNjcH6TxEVzpFRW6rAuJu/8QZvdn5AbVkje1Jz
         wdiLjEvxNvNqf0kDSmdxSD+2pqjt1x0SqWtpYFH8r2BZVvkiAi6ScuRqDgF9Hk//1Awz
         ZD4V7exQBOxr4q0qFoOZMuPY8eJ67CHGovob4u5QYeRdvDQwZ1M3eMGMt+qXNvtPN8Gm
         yxSpeZ+w1BaLaiSZdbvFk6Cj8EZ++QzIWMmRnmT49p7I9AcVwLmd45u2JOeVrCdlnIOs
         z5s8lI0cYyyHs20Ee2pgQpsaejbVTFIuu3doXOMrjXJYZ9qqAXE3Qq1k2kO1AsT2Gz79
         Z8hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773615426; x=1774220226;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uCXOqQYTnzGNhQPDiApCXbqWFijYEREGO2671+swbzA=;
        b=qSSpLI51ralhn23vk92vRvWdYp3sREPUhI5gi4EzQBc1qCEwCfzQLI7R/RwJoiXO5W
         oikiTxHLvozy3WHRVsP7i+GfvcPRcW2Eo0BJawq6541A05fb19bgtv1RZLuvHVIXwuAZ
         cc2QMlSOEF2ZmuD6SqYkkDs7iBoJX/Jx8rVwKqmvJTmk7TL4nfKA8WpsQbkraJR7Lujm
         MTA0IlyZ8JNisUG9McMIhr0CLiwjA+2wvwW1k+2sWX4xfN9w4VNq156xXCfdPfQYnWd8
         QxrMfA8ncRfGqgOURtgrKzBOfPqXONsPLBsmJxWBTLvF6111/IejdugllFdoXkQr/UUi
         QNbg==
X-Forwarded-Encrypted: i=1; AJvYcCUhCzJOSnCDelP6NQGVzTlqQlsm96+BRAaOZaTlG1NxKRRJ0etVLF0qJlmLHtK/oHJaznw4+bJlqXbKKWM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywk9JEgMtk0Bq2o8O9M5kFbgXzRuoTpzXIJVKG4/qOuVgKA0v4+
	Oz8lllkZ58h70WX95IAdQym6+6KPj0AM9+8lBzO1xeblN2u5dFXcVVoeBv6t4RzyeSMqCGntXxF
	TLtJ3vGeUqrjM81oSgiYQFClPn96Su+E99Si6iPmC
X-Gm-Gg: ATEYQzylwDRvSq4auQI43qTaU/5eeUhWkOJZdfUVqToKAlaarUo/EW8oPkpnfSz0vWf
	VO2HY3Sm5XdoVCWNbFOll2l+KLfg9Uyd6Ao0FYJKBOcWUZTjpID439I8nJlxk/s+DzGlYRR0+JO
	m+REhHljGs6RQrhtawsvOLn4xpC3wYwtCpUf1JVyyEYEyhUG4pK62X7tHXaqp9bkf6NkuQP8fG0
	PbbrVMS7MA2HQUNcivMh641RFMK4uZW/snlxIKJBQUkCrUgzBlMyZgNpZjIO5Tla5WG9Y8QsV+T
	kEwKjtUG7LVOENtJ
X-Received: by 2002:a05:622a:1648:b0:509:72a:ae59 with SMTP id
 d75a77b69052e-509694c63a6mr20842221cf.10.1773615425456; Sun, 15 Mar 2026
 15:57:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1773346620.git.ljs@kernel.org> <56372fe273f775b26675a04652c1229e14680741.1773346620.git.ljs@kernel.org>
In-Reply-To: <56372fe273f775b26675a04652c1229e14680741.1773346620.git.ljs@kernel.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Sun, 15 Mar 2026 15:56:54 -0700
X-Gm-Features: AaiRm51Rev4ufazINlivV2AzV3ufvB013bFH7aap69X4pIxh6gJw0EUx7qrVlHk
Message-ID: <CAJuCfpEsCrFEYNkkTfRLGojGOYAAx1=WOojOhpBb_=WZBr6bnQ@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9417-lists,linux-hyperv=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 8E02F292ECA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 12, 2026 at 1:27=E2=80=AFPM Lorenzo Stoakes (Oracle) <ljs@kerne=
l.org> wrote:
>
> Rather than passing arbitrary fields, pass an mmap_action field directly =
to
> mmap prepare and complete helpers to put all the action-specific logic in
> the function actually doing the work.
>
> Additionally, allow mmap prepare functions to return an error so we can
> error out as soon as possible if there is something logically incorrect i=
n
> the input.
>
> Update remap_pfn_range_prepare() to properly check the input range for th=
e
> CoW case.

By "properly check" do you mean the replacement of desc->start and
desc->end with action->remap.start and action->remap.start +
action->remap.size when calling get_remap_pgoff() from
remap_pfn_range_prepare()?

>
> While we're here, make remap_pfn_range_prepare_vma() a little neater, and
> pass mmap_action directly to call_action_complete().
>
> Then, update compat_vma_mmap() to perform its logic directly, as
> __compat_vma_map() is not used by anything so we don't need to export it.

Not directly related to this patch but while reviewing, I was also
checking vma locking rules in this mmap_prepare() + mmap() sequence
and I noticed that the new VMA flag modification functions like
vma_set_flags_mask() do assert vma_assert_locked(vma). It would be
useful to add these but as a separate change. I will add it to my todo
list.

>
> Also update compat_vma_mmap() to use vfs_mmap_prepare() rather than calli=
ng
> the mmap_prepare op directly.
>
> Finally, update the VMA userland tests to reflect the changes.
>
> Signed-off-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>
> ---
>  include/linux/fs.h                |   2 -
>  include/linux/mm.h                |   8 +--
>  mm/internal.h                     |  28 +++++---
>  mm/memory.c                       |  45 +++++++-----
>  mm/util.c                         | 112 +++++++++++++-----------------
>  mm/vma.c                          |  21 +++---
>  tools/testing/vma/include/dup.h   |   9 ++-
>  tools/testing/vma/include/stubs.h |   9 +--
>  8 files changed, 123 insertions(+), 111 deletions(-)
>
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 8b3dd145b25e..a2628a12bd2b 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -2058,8 +2058,6 @@ static inline bool can_mmap_file(struct file *file)
>         return true;
>  }
>
> -int __compat_vma_mmap(const struct file_operations *f_op,
> -               struct file *file, struct vm_area_struct *vma);
>  int compat_vma_mmap(struct file *file, struct vm_area_struct *vma);
>
>  static inline int vfs_mmap(struct file *file, struct vm_area_struct *vma=
)
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 4c4fd55fc823..cc5960a84382 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -4116,10 +4116,10 @@ static inline void mmap_action_ioremap_full(struc=
t vm_area_desc *desc,
>         mmap_action_ioremap(desc, desc->start, start_pfn, vma_desc_size(d=
esc));
>  }
>
> -void mmap_action_prepare(struct mmap_action *action,
> -                        struct vm_area_desc *desc);
> -int mmap_action_complete(struct mmap_action *action,
> -                        struct vm_area_struct *vma);
> +int mmap_action_prepare(struct vm_area_desc *desc,
> +                       struct mmap_action *action);
> +int mmap_action_complete(struct vm_area_struct *vma,
> +                        struct mmap_action *action);
>
>  /* Look up the first VMA which exactly match the interval vm_start ... v=
m_end */
>  static inline struct vm_area_struct *find_exact_vma(struct mm_struct *mm=
,
> diff --git a/mm/internal.h b/mm/internal.h
> index 95b583e7e4f7..7bfa85b5e78b 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -1775,26 +1775,32 @@ int walk_page_range_debug(struct mm_struct *mm, u=
nsigned long start,
>  void dup_mm_exe_file(struct mm_struct *mm, struct mm_struct *oldmm);
>  int dup_mmap(struct mm_struct *mm, struct mm_struct *oldmm);
>
> -void remap_pfn_range_prepare(struct vm_area_desc *desc, unsigned long pf=
n);
> -int remap_pfn_range_complete(struct vm_area_struct *vma, unsigned long a=
ddr,
> -               unsigned long pfn, unsigned long size, pgprot_t pgprot);
> +int remap_pfn_range_prepare(struct vm_area_desc *desc,
> +                           struct mmap_action *action);
> +int remap_pfn_range_complete(struct vm_area_struct *vma,
> +                            struct mmap_action *action);
>
> -static inline void io_remap_pfn_range_prepare(struct vm_area_desc *desc,
> -               unsigned long orig_pfn, unsigned long size)
> +static inline int io_remap_pfn_range_prepare(struct vm_area_desc *desc,
> +                                            struct mmap_action *action)
>  {
> +       const unsigned long orig_pfn =3D action->remap.start_pfn;
> +       const unsigned long size =3D action->remap.size;
>         const unsigned long pfn =3D io_remap_pfn_range_pfn(orig_pfn, size=
);
>
> -       return remap_pfn_range_prepare(desc, pfn);
> +       action->remap.start_pfn =3D pfn;
> +       return remap_pfn_range_prepare(desc, action);
>  }
>
>  static inline int io_remap_pfn_range_complete(struct vm_area_struct *vma=
,
> -               unsigned long addr, unsigned long orig_pfn, unsigned long=
 size,
> -               pgprot_t orig_prot)
> +                                             struct mmap_action *action)
>  {
> -       const unsigned long pfn =3D io_remap_pfn_range_pfn(orig_pfn, size=
);
> -       const pgprot_t prot =3D pgprot_decrypted(orig_prot);
> +       const unsigned long size =3D action->remap.size;
> +       const unsigned long orig_pfn =3D action->remap.start_pfn;
> +       const pgprot_t orig_prot =3D vma->vm_page_prot;
>
> -       return remap_pfn_range_complete(vma, addr, pfn, size, prot);
> +       action->remap.pgprot =3D pgprot_decrypted(orig_prot);
> +       action->remap.start_pfn  =3D io_remap_pfn_range_pfn(orig_pfn, siz=
e);
> +       return remap_pfn_range_complete(vma, action);
>  }
>
>  #ifdef CONFIG_MMU_NOTIFIER
> diff --git a/mm/memory.c b/mm/memory.c
> index 6aa0ea4af1fc..364fa8a45360 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -3099,26 +3099,34 @@ static int do_remap_pfn_range(struct vm_area_stru=
ct *vma, unsigned long addr,
>  }
>  #endif
>
> -void remap_pfn_range_prepare(struct vm_area_desc *desc, unsigned long pf=
n)
> +int remap_pfn_range_prepare(struct vm_area_desc *desc,
> +                           struct mmap_action *action)
>  {
> -       /*
> -        * We set addr=3DVMA start, end=3DVMA end here, so this won't fai=
l, but we
> -        * check it again on complete and will fail there if specified ad=
dr is
> -        * invalid.
> -        */
> -       get_remap_pgoff(vma_desc_is_cow_mapping(desc), desc->start, desc-=
>end,
> -                       desc->start, desc->end, pfn, &desc->pgoff);
> +       const unsigned long start =3D action->remap.start;
> +       const unsigned long end =3D start + action->remap.size;
> +       const unsigned long pfn =3D action->remap.start_pfn;
> +       const bool is_cow =3D vma_desc_is_cow_mapping(desc);

I was trying to figure out who sets action->remap.start and
action->remap.size and if they somehow guaranteed to be always equal
to desc->start and (desc->end - desc->start). My understanding is that
action->remap.start and action->remap.size are set by
f_op->mmap_prepare() but I'm not sure if they are always the same as
desc->start and (desc->end - desc->start) and if so, how do we enforce
that.

> +       int err;
> +
> +       err =3D get_remap_pgoff(is_cow, start, end, desc->start, desc->en=
d, pfn,
> +                             &desc->pgoff);
> +       if (err)
> +               return err;
> +
>         vma_desc_set_flags_mask(desc, VMA_REMAP_FLAGS);
> +       return 0;
>  }
>
> -static int remap_pfn_range_prepare_vma(struct vm_area_struct *vma, unsig=
ned long addr,
> -               unsigned long pfn, unsigned long size)
> +static int remap_pfn_range_prepare_vma(struct vm_area_struct *vma,
> +                                      unsigned long addr, unsigned long =
pfn,
> +                                      unsigned long size)
>  {
> -       unsigned long end =3D addr + PAGE_ALIGN(size);
> +       const unsigned long end =3D addr + PAGE_ALIGN(size);
> +       const bool is_cow =3D is_cow_mapping(vma->vm_flags);
>         int err;
>
> -       err =3D get_remap_pgoff(is_cow_mapping(vma->vm_flags), addr, end,
> -                             vma->vm_start, vma->vm_end, pfn, &vma->vm_p=
goff);
> +       err =3D get_remap_pgoff(is_cow, addr, end, vma->vm_start, vma->vm=
_end,
> +                             pfn, &vma->vm_pgoff);
>         if (err)
>                 return err;
>
> @@ -3151,10 +3159,15 @@ int remap_pfn_range(struct vm_area_struct *vma, u=
nsigned long addr,
>  }
>  EXPORT_SYMBOL(remap_pfn_range);
>
> -int remap_pfn_range_complete(struct vm_area_struct *vma, unsigned long a=
ddr,
> -               unsigned long pfn, unsigned long size, pgprot_t prot)
> +int remap_pfn_range_complete(struct vm_area_struct *vma,
> +                            struct mmap_action *action)
>  {
> -       return do_remap_pfn_range(vma, addr, pfn, size, prot);
> +       const unsigned long start =3D action->remap.start;
> +       const unsigned long pfn =3D action->remap.start_pfn;
> +       const unsigned long size =3D action->remap.size;
> +       const pgprot_t prot =3D action->remap.pgprot;
> +
> +       return do_remap_pfn_range(vma, start, pfn, size, prot);
>  }
>
>  /**
> diff --git a/mm/util.c b/mm/util.c
> index ce7ae80047cf..dba1191725b6 100644
> --- a/mm/util.c
> +++ b/mm/util.c
> @@ -1163,43 +1163,6 @@ void flush_dcache_folio(struct folio *folio)
>  EXPORT_SYMBOL(flush_dcache_folio);
>  #endif
>
> -/**
> - * __compat_vma_mmap() - See description for compat_vma_mmap()
> - * for details. This is the same operation, only with a specific file op=
erations
> - * struct which may or may not be the same as vma->vm_file->f_op.
> - * @f_op: The file operations whose .mmap_prepare() hook is specified.
> - * @file: The file which backs or will back the mapping.
> - * @vma: The VMA to apply the .mmap_prepare() hook to.
> - * Returns: 0 on success or error.
> - */
> -int __compat_vma_mmap(const struct file_operations *f_op,
> -               struct file *file, struct vm_area_struct *vma)
> -{
> -       struct vm_area_desc desc =3D {
> -               .mm =3D vma->vm_mm,
> -               .file =3D file,
> -               .start =3D vma->vm_start,
> -               .end =3D vma->vm_end,
> -
> -               .pgoff =3D vma->vm_pgoff,
> -               .vm_file =3D vma->vm_file,
> -               .vma_flags =3D vma->flags,
> -               .page_prot =3D vma->vm_page_prot,
> -
> -               .action.type =3D MMAP_NOTHING, /* Default */
> -       };
> -       int err;
> -
> -       err =3D f_op->mmap_prepare(&desc);
> -       if (err)
> -               return err;
> -
> -       mmap_action_prepare(&desc.action, &desc);
> -       set_vma_from_desc(vma, &desc);
> -       return mmap_action_complete(&desc.action, vma);
> -}
> -EXPORT_SYMBOL(__compat_vma_mmap);
> -
>  /**
>   * compat_vma_mmap() - Apply the file's .mmap_prepare() hook to an
>   * existing VMA and execute any requested actions.
> @@ -1228,7 +1191,31 @@ EXPORT_SYMBOL(__compat_vma_mmap);
>   */
>  int compat_vma_mmap(struct file *file, struct vm_area_struct *vma)
>  {
> -       return __compat_vma_mmap(file->f_op, file, vma);
> +       struct vm_area_desc desc =3D {
> +               .mm =3D vma->vm_mm,
> +               .file =3D file,
> +               .start =3D vma->vm_start,
> +               .end =3D vma->vm_end,
> +
> +               .pgoff =3D vma->vm_pgoff,
> +               .vm_file =3D vma->vm_file,
> +               .vma_flags =3D vma->flags,
> +               .page_prot =3D vma->vm_page_prot,
> +
> +               .action.type =3D MMAP_NOTHING, /* Default */
> +       };
> +       int err;
> +
> +       err =3D vfs_mmap_prepare(file, &desc);
> +       if (err)
> +               return err;
> +
> +       err =3D mmap_action_prepare(&desc, &desc.action);
> +       if (err)
> +               return err;
> +
> +       set_vma_from_desc(vma, &desc);
> +       return mmap_action_complete(vma, &desc.action);
>  }
>  EXPORT_SYMBOL(compat_vma_mmap);
>
> @@ -1320,8 +1307,8 @@ void snapshot_page(struct page_snapshot *ps, const =
struct page *page)
>         }
>  }
>
> -static int mmap_action_finish(struct mmap_action *action,
> -               const struct vm_area_struct *vma, int err)
> +static int mmap_action_finish(struct vm_area_struct *vma,
> +                             struct mmap_action *action, int err)
>  {
>         /*
>          * If an error occurs, unmap the VMA altogether and return an err=
or. We
> @@ -1355,35 +1342,36 @@ static int mmap_action_finish(struct mmap_action =
*action,
>   * action which need to be performed.
>   * @desc: The VMA descriptor to prepare for @action.
>   * @action: The action to perform.
> + *
> + * Returns: 0 on success, otherwise error.
>   */
> -void mmap_action_prepare(struct mmap_action *action,
> -                        struct vm_area_desc *desc)
> +int mmap_action_prepare(struct vm_area_desc *desc,
> +                       struct mmap_action *action)

Any reason you are swapping the arguments?
It also looks like we always call mmap_action_prepare() with action =3D=3D
desc->action, like this: mmap_action_prepare(&desc.action, &desc). Why
don't we eliminate the action parameter altogether and use desc.action
from inside the function?

> +

extra new line.

>  {
>         switch (action->type) {
>         case MMAP_NOTHING:
> -               break;
> +               return 0;
>         case MMAP_REMAP_PFN:
> -               remap_pfn_range_prepare(desc, action->remap.start_pfn);
> -               break;
> +               return remap_pfn_range_prepare(desc, action);
>         case MMAP_IO_REMAP_PFN:
> -               io_remap_pfn_range_prepare(desc, action->remap.start_pfn,
> -                                          action->remap.size);
> -               break;
> +               return io_remap_pfn_range_prepare(desc, action);
>         }
>  }
>  EXPORT_SYMBOL(mmap_action_prepare);
>
>  /**
>   * mmap_action_complete - Execute VMA descriptor action.
> - * @action: The action to perform.
>   * @vma: The VMA to perform the action upon.
> + * @action: The action to perform.
>   *
>   * Similar to mmap_action_prepare().
>   *
>   * Return: 0 on success, or error, at which point the VMA will be unmapp=
ed.
>   */
> -int mmap_action_complete(struct mmap_action *action,
> -                        struct vm_area_struct *vma)
> +int mmap_action_complete(struct vm_area_struct *vma,
> +                        struct mmap_action *action)
> +
>  {
>         int err =3D 0;
>
> @@ -1391,23 +1379,19 @@ int mmap_action_complete(struct mmap_action *acti=
on,
>         case MMAP_NOTHING:
>                 break;
>         case MMAP_REMAP_PFN:
> -               err =3D remap_pfn_range_complete(vma, action->remap.start=
,
> -                               action->remap.start_pfn, action->remap.si=
ze,
> -                               action->remap.pgprot);
> +               err =3D remap_pfn_range_complete(vma, action);
>                 break;
>         case MMAP_IO_REMAP_PFN:
> -               err =3D io_remap_pfn_range_complete(vma, action->remap.st=
art,
> -                               action->remap.start_pfn, action->remap.si=
ze,
> -                               action->remap.pgprot);
> +               err =3D io_remap_pfn_range_complete(vma, action);
>                 break;
>         }
>
> -       return mmap_action_finish(action, vma, err);
> +       return mmap_action_finish(vma, action, err);
>  }
>  EXPORT_SYMBOL(mmap_action_complete);
>  #else
> -void mmap_action_prepare(struct mmap_action *action,
> -                       struct vm_area_desc *desc)
> +int mmap_action_prepare(struct vm_area_desc *desc,
> +                       struct mmap_action *action)
>  {
>         switch (action->type) {
>         case MMAP_NOTHING:
> @@ -1417,11 +1401,13 @@ void mmap_action_prepare(struct mmap_action *acti=
on,
>                 WARN_ON_ONCE(1); /* nommu cannot handle these. */
>                 break;
>         }
> +
> +       return 0;
>  }
>  EXPORT_SYMBOL(mmap_action_prepare);
>
> -int mmap_action_complete(struct mmap_action *action,
> -                       struct vm_area_struct *vma)
> +int mmap_action_complete(struct vm_area_struct *vma,
> +                        struct mmap_action *action)
>  {
>         int err =3D 0;
>
> @@ -1436,7 +1422,7 @@ int mmap_action_complete(struct mmap_action *action=
,
>                 break;
>         }
>
> -       return mmap_action_finish(action, vma, err);
> +       return mmap_action_finish(vma, action, err);
>  }
>  EXPORT_SYMBOL(mmap_action_complete);
>  #endif
> diff --git a/mm/vma.c b/mm/vma.c
> index be64f781a3aa..054cf1d262fb 100644
> --- a/mm/vma.c
> +++ b/mm/vma.c
> @@ -2613,15 +2613,19 @@ static void __mmap_complete(struct mmap_state *ma=
p, struct vm_area_struct *vma)
>         vma_set_page_prot(vma);
>  }
>
> -static void call_action_prepare(struct mmap_state *map,
> -                               struct vm_area_desc *desc)
> +static int call_action_prepare(struct mmap_state *map,
> +                              struct vm_area_desc *desc)
>  {
>         struct mmap_action *action =3D &desc->action;
> +       int err;
>
> -       mmap_action_prepare(action, desc);
> +       err =3D mmap_action_prepare(desc, action);
> +       if (err)
> +               return err;
>
>         if (action->hide_from_rmap_until_complete)
>                 map->hold_file_rmap_lock =3D true;
> +       return 0;
>  }
>
>  /*
> @@ -2645,7 +2649,9 @@ static int call_mmap_prepare(struct mmap_state *map=
,
>         if (err)
>                 return err;
>
> -       call_action_prepare(map, desc);
> +       err =3D call_action_prepare(map, desc);
> +       if (err)
> +               return err;
>
>         /* Update fields permitted to be changed. */
>         map->pgoff =3D desc->pgoff;
> @@ -2700,13 +2706,12 @@ static bool can_set_ksm_flags_early(struct mmap_s=
tate *map)
>  }
>
>  static int call_action_complete(struct mmap_state *map,
> -                               struct vm_area_desc *desc,
> +                               struct mmap_action *action,
>                                 struct vm_area_struct *vma)
>  {
> -       struct mmap_action *action =3D &desc->action;
>         int ret;
>
> -       ret =3D mmap_action_complete(action, vma);
> +       ret =3D mmap_action_complete(vma, action);
>
>         /* If we held the file rmap we need to release it. */
>         if (map->hold_file_rmap_lock) {
> @@ -2768,7 +2773,7 @@ static unsigned long __mmap_region(struct file *fil=
e, unsigned long addr,
>         __mmap_complete(&map, vma);
>
>         if (have_mmap_prepare && allocated_new) {
> -               error =3D call_action_complete(&map, &desc, vma);
> +               error =3D call_action_complete(&map, &desc.action, vma);
>
>                 if (error)
>                         return error;
> diff --git a/tools/testing/vma/include/dup.h b/tools/testing/vma/include/=
dup.h
> index 5eb313beb43d..908beb263307 100644
> --- a/tools/testing/vma/include/dup.h
> +++ b/tools/testing/vma/include/dup.h
> @@ -1106,7 +1106,7 @@ static inline int __compat_vma_mmap(const struct fi=
le_operations *f_op,
>
>                 .pgoff =3D vma->vm_pgoff,
>                 .vm_file =3D vma->vm_file,
> -               .vm_flags =3D vma->vm_flags,
> +               .vma_flags =3D vma->flags,
>                 .page_prot =3D vma->vm_page_prot,
>
>                 .action.type =3D MMAP_NOTHING, /* Default */
> @@ -1117,9 +1117,12 @@ static inline int __compat_vma_mmap(const struct f=
ile_operations *f_op,
>         if (err)
>                 return err;
>
> -       mmap_action_prepare(&desc.action, &desc);
> +       err =3D mmap_action_prepare(&desc, &desc.action);
> +       if (err)
> +               return err;
> +
>         set_vma_from_desc(vma, &desc);
> -       return mmap_action_complete(&desc.action, vma);
> +       return mmap_action_complete(vma, &desc.action);
>  }
>
>  static inline int compat_vma_mmap(struct file *file,
> diff --git a/tools/testing/vma/include/stubs.h b/tools/testing/vma/includ=
e/stubs.h
> index 947a3a0c2566..76c4b668bc62 100644
> --- a/tools/testing/vma/include/stubs.h
> +++ b/tools/testing/vma/include/stubs.h
> @@ -81,13 +81,14 @@ static inline void free_anon_vma_name(struct vm_area_=
struct *vma)
>  {
>  }
>
> -static inline void mmap_action_prepare(struct mmap_action *action,
> -                                          struct vm_area_desc *desc)
> +static inline int mmap_action_prepare(struct vm_area_desc *desc,
> +                                     struct mmap_action *action)
>  {
> +       return 0;
>  }
>
> -static inline int mmap_action_complete(struct mmap_action *action,
> -                                          struct vm_area_struct *vma)
> +static inline int mmap_action_complete(struct vm_area_struct *vma,
> +                                      struct mmap_action *action)
>  {
>         return 0;
>  }
> --
> 2.53.0
>

