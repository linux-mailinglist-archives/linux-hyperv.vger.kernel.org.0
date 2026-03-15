Return-Path: <linux-hyperv+bounces-9419-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WEt/KHM/t2kcOwEAu9opvQ
	(envelope-from <linux-hyperv+bounces-9419-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 16 Mar 2026 00:23:31 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E632292FEE
	for <lists+linux-hyperv@lfdr.de>; Mon, 16 Mar 2026 00:23:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 17E10300B741
	for <lists+linux-hyperv@lfdr.de>; Sun, 15 Mar 2026 23:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A54B29C33F;
	Sun, 15 Mar 2026 23:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="suNZAZzv"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B505229D26C
	for <linux-hyperv@vger.kernel.org>; Sun, 15 Mar 2026 23:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773617008; cv=pass; b=lg8lgoOd8oQ3FNgtNYamZS84W2BDqTkk6bkI+3QD4qFsEhvTqD94ld8BBpP+z4h5gIjkwGd8ETVhKwR3ybXaYWYzlhsOqV1qEjnlR5UtTX1BDeGHhEbp+pbVjt0xSdo8LgvlldPMHtDBcScfnxnGFsRp4ZbdluQD/5qXsP9z7Sk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773617008; c=relaxed/simple;
	bh=PVq272pwfUPXpFbMSUn68cn48r3pF+BdTgdFJu/GdP0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sZZaEecmGPu6UFPDpgK+H2Bulq/O0HPHGjPZVqjtNJMi0keISnlhUGEL+5LGQQrILgCNEn0Aw+MBjjEkmtATI3AAUDpQf4B6cVz2jIlijvLx/wjuxqzZGZIU7vj/Qxu1uJ8ESh1jMAMGIQ5pJ536BFskRxSneAiNfx/IrS2Vf8w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=suNZAZzv; arc=pass smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-50906a98ffeso714421cf.0
        for <linux-hyperv@vger.kernel.org>; Sun, 15 Mar 2026 16:23:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773617006; cv=none;
        d=google.com; s=arc-20240605;
        b=kCEzH8SV60EGmJNaboCZ2z0i/q33TwpgxK0LnQX9C/5+pYwySAv5yJxJ22Ks0mezVJ
         m/YVL3TmJPvLJDgutN1kfCmJAARcWPWz0NaV71DfLAkC/y9zRnqJO8aiwMjst3PD+/1H
         qg/nfp1tmB1b1aAiH76GlXzCU+WvTNKmtcOQ5ivVLh+wsBb1gavHBLfZKPscJPyfmUNA
         ZJfmxTw5iDDigvrEqPCvmKEZV7B5IdcnWICtbeRB4wH8JyLbFZceZ8Q+HQBBjGbCCW2B
         7tEj9KCVjw27nk74fs3RtwAxuGC/+ZJPp0MpRjHpdneGzL7XXUtiyjW/sfIGmV0rD47h
         Mjng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OT8Iw6M557aLYwHQwbfjFt5SgiwLxQR3GJ4aDtnOQyU=;
        fh=2Qe98uvXqYLCR/egOufGTLOJ57ugDhiZUdrDw2a4/Bo=;
        b=TR7IfvLcUXVBFYb4W6TKIT52/4vHM0rdtROZxjRLhROL+9lxNqqsUuG35AtPrFO33o
         B6yEIXz2fYXRXap30Ewicw1ihBAC9fLrT92j/yYZH/ddh2xxTjUoRTKqcapa+ugoe8ad
         qXafQsPi5NEd8pzcDj/GBTkm9lqb3gd2ESiWUT0+/Ew5hs5Z4V7TQb5PIPjf2prTX4TQ
         dDQEpe/fc6y4oZC8z3zD/pu6c6V6POGWHCxnji8MBE7GSVjuaRN4FXZm4zkbSSqokoie
         wKF6KWsoIbpClajeYh3gwmKL7iT8Xyz7H4xJqnYIn0Uy305OrS3bpCSaNfYp1FcRZIZo
         TaNw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773617006; x=1774221806; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OT8Iw6M557aLYwHQwbfjFt5SgiwLxQR3GJ4aDtnOQyU=;
        b=suNZAZzv3pGLa1X9bIl3qgW3SWhV99HMVIguTsB5ag2+7n6ZDXcYwFBsMru5tqwCpT
         srZ+9UTzcdx4RbYNm2rkE4QYzV4l60ea581qRU+pVTJd4s3tlF83pC72jHeEM+uAcF6J
         TLkD8psnAriT1UHr627hduaiKoCspj3yV+gSrwblu/xQw6LU7cg5wQDhNjja7wCqy3Km
         5IOYd7z9QjnZly79b30RyZao/vOn+qgd4efaOYti6pP+9N9ub2b5QfupeEVZOHujFgrp
         FjB4RBo2i/M6a66OS1ifQrAClFznFwn06Sj+OQgeUa7/Ip5riBz7EOJsqon+2ds4rV7P
         P84A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773617006; x=1774221806;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OT8Iw6M557aLYwHQwbfjFt5SgiwLxQR3GJ4aDtnOQyU=;
        b=aJgNEv37oCFJ9Xq4aroebYlZlK7sePmgY+JPYsdiB4klO/xDpqMOZfrnW3JYL5L1yR
         Hb1jnzMrOA1WtYEGyxh3wz2oChXrSRi8b37vB3Q0lK2zueJekV+5G+49u/pDzi9Xl9k2
         WHqdyEsHsbAZum+nOdU++i4F/dxSTLt/UYTv753q7WhXuF44W+obKnqEvG+GN42FKSK0
         QAVNxWm2fLk0x8VIZATUmBUMcX2YkOnRyWJOI/upfWGqODzl7LGSKPzgszrplo99Pe2p
         NbdGfiPrwgTB+I4tp54JAncSa19TsEmAyXd3/X0yixGJySn37smiHd7+x2gzcPByTySO
         edmg==
X-Forwarded-Encrypted: i=1; AJvYcCXvHJaBPxBg4XCLBOCrfwQEO46hVx3uRvsa/AGRtykc5GoFFuNpQXR1El1AEC/cQC/AcXXor0uvgDV5qU0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDCCAGiSPs1T+lFbnPYpR27mmZYNI12jHmnYTq0klYlrswx9sL
	wl7oChXPlVW3Z3C+BjIpdt4mXAeoLPslkNAJfIjumkxYgzqVJ+9r3aTLSV1GnH5mpjecXqm1gVn
	NcrNSATMewX9XZfEVlzzwJaPwycBruk9GaZ3zW7bh
X-Gm-Gg: ATEYQzxwifWcTIhuCRMIYljPudNqmc9gdF1W2M6ppPQoVm6Jo45yHOVaZm1uvjDNm/Y
	IN4C+Yg7zDYrBBFlOtwQXkLjzkpcfCc4WfCJbBYPm3TA97pgmVQM4lgiZNmTXpPZf7k9P3Jx3GR
	h6srTSqpu1IJ1z8AN9Sns+APSMTidTFFrf0biMGfmh+kn3OQqR/yWPvHSqZEpvWdIthyRF4xc4H
	7GXXPxf4rjTPdbo8P9ES6hBmRUKBI8UEtWAmkNm28MZfRFoj3wtQy/tuBt/t8fjgxmBKHhztT+C
	4pmg9z6iVkV3O8DJ
X-Received: by 2002:a05:622a:1822:b0:509:1d4b:f86f with SMTP id
 d75a77b69052e-509694fc2a0mr18649221cf.14.1773617005021; Sun, 15 Mar 2026
 16:23:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1773346620.git.ljs@kernel.org> <c5bb61cf789df1ecb32facc29df9749987c7ddfc.1773346620.git.ljs@kernel.org>
In-Reply-To: <c5bb61cf789df1ecb32facc29df9749987c7ddfc.1773346620.git.ljs@kernel.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Sun, 15 Mar 2026 16:23:14 -0700
X-Gm-Features: AaiRm50msQxab5MfkpLsIIibDHC-kfdIQCyqr3kXogsNup53_Z_U3j15wVPbEHM
Message-ID: <CAJuCfpGd702=Xop3X5Aop9rrScdiAOQEEooTu1gcJqR9pmO5GA@mail.gmail.com>
Subject: Re: [PATCH 02/15] mm: add documentation for the mmap_prepare file
 operation callback
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9419-lists,linux-hyperv=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 1E632292FEE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 12, 2026 at 1:27=E2=80=AFPM Lorenzo Stoakes (Oracle) <ljs@kerne=
l.org> wrote:
>
> This documentation makes it easier for a driver/file system implementer t=
o
> correctly use this callback.
>
> It covers the fundamentals, whilst intentionally leaving the less lovely
> possible actions one might take undocumented (for instance - the
> success_hook, error_hook fields in mmap_action).
>
> The document also covers the new VMA flags implementation which is the on=
ly
> one which will work correctly with mmap_prepare.
>
> Signed-off-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>
> ---
>  Documentation/filesystems/mmap_prepare.rst | 131 +++++++++++++++++++++
>  1 file changed, 131 insertions(+)
>  create mode 100644 Documentation/filesystems/mmap_prepare.rst
>
> diff --git a/Documentation/filesystems/mmap_prepare.rst b/Documentation/f=
ilesystems/mmap_prepare.rst
> new file mode 100644
> index 000000000000..76908200f3a1
> --- /dev/null
> +++ b/Documentation/filesystems/mmap_prepare.rst
> @@ -0,0 +1,131 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> +mmap_prepare callback HOWTO
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> +
> +Introduction
> +############
> +
> +The `struct file->f_op->mmap()` callback has been deprecated as it is bo=
th a
> +stability and security risk, and doesn't always permit the merging of ad=
jacent
> +mappings resulting in unnecessary memory fragmentation.
> +
> +It has been replaced with the `file->f_op->mmap_prepare()` callback whic=
h solves
> +these problems.
> +
> +## How To Use
> +
> +In your driver's `struct file_operations` struct, specify an `mmap_prepa=
re`
> +callback rather than an `mmap` one, e.g. for ext4:
> +
> +
> +.. code-block:: C
> +
> +    const struct file_operations ext4_file_operations =3D {
> +        ...
> +        .mmap_prepare    =3D ext4_file_mmap_prepare,
> +    };
> +
> +This has a signature of `int (*mmap_prepare)(struct vm_area_desc *)`.
> +
> +Examining the `struct vm_area_desc` type:
> +
> +.. code-block:: C
> +
> +    struct vm_area_desc {
> +        /* Immutable state. */
> +        const struct mm_struct *const mm;
> +        struct file *const file; /* May vary from vm_file in stacked cal=
lers. */
> +        unsigned long start;
> +        unsigned long end;
> +
> +        /* Mutable fields. Populated with initial state. */
> +        pgoff_t pgoff;
> +        struct file *vm_file;
> +        vma_flags_t vma_flags;
> +        pgprot_t page_prot;
> +
> +        /* Write-only fields. */
> +        const struct vm_operations_struct *vm_ops;
> +        void *private_data;
> +
> +        /* Take further action? */
> +        struct mmap_action action;

So, action still belongs to /* Write-only fields. */ section? This is
nitpicky, but it might be better to have this as:

        /* Write-only fields. */
        const struct vm_operations_struct *vm_ops;
        void *private_data;
        struct mmap_action action; /* Take further action? */

> +    };
> +
> +This is straightforward - you have all the fields you need to set up the
> +mapping, and you can update the mutable and writable fields, for instanc=
e:
> +
> +.. code-block:: Cw
> +
> +    static int ext4_file_mmap_prepare(struct vm_area_desc *desc)
> +    {
> +        int ret;
> +        struct file *file =3D desc->file;
> +        struct inode *inode =3D file->f_mapping->host;
> +
> +        ...
> +
> +        file_accessed(file);
> +        if (IS_DAX(file_inode(file))) {
> +            desc->vm_ops =3D &ext4_dax_vm_ops;
> +            vma_desc_set_flags(desc, VMA_HUGEPAGE_BIT);
> +        } else {
> +            desc->vm_ops =3D &ext4_file_vm_ops;
> +        }
> +        return 0;
> +    }
> +
> +Importantly, you no longer have to dance around with reference counts or=
 locks
> +when updating these fields - __you can simply go ahead and change them__=
.
> +
> +Everything is taken care of by the mapping code.
> +
> +VMA Flags
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Along with `mmap_prepare`, VMA flags have undergone an overhaul. Where b=
efore
> +you would invoke one of `vm_flags_init()`, `vm_flags_reset()`, `vm_flags=
_set()`,
> +`vm_flags_clear()`, and `vm_flags_mod()` to modify flags (and to have th=
e
> +locking done correctly for you, this is no longer necessary.
> +
> +Also, the legacy approach of specifying VMA flags via `VM_READ`, `VM_WRI=
TE`,
> +etc. - i.e. using a `VM_xxx` macro has changed too.
> +
> +When implementing `mmap_prepare()`, reference flags by their bit number,=
 defined
> +as a `VMA_xxx_BIT` macro, e.g. `VMA_READ_BIT`, `VMA_WRITE_BIT` etc., and=
 use one
> +of (where `desc` is a pointer to `struct vma_area_desc`):
> +
> +* `vma_desc_test_flags(desc, ...)` - Specify a comma-separated list of f=
lags you
> +  wish to test for (whether _any_ are set), e.g. - `vma_desc_test_flags(=
desc,
> +  VMA_WRITE_BIT, VMA_MAYWRITE_BIT)` - returns `true` if either are set,
> +  otherwise `false`.
> +* `vma_desc_set_flags(desc, ...)` - Update the VMA descriptor flags to s=
et
> +  additional flags specified by a comma-separated list,
> +  e.g. - `vma_desc_set_flags(desc, VMA_PFNMAP_BIT, VMA_IO_BIT)`.
> +* `vma_desc_clear_flags(desc, ...)` - Update the VMA descriptor flags to=
 clear
> +  flags specified by a comma-separated list, e.g. - `vma_desc_clear_flag=
s(desc,
> +  VMA_WRITE_BIT, VMA_MAYWRITE_BIT)`.
> +
> +Actions
> +=3D=3D=3D=3D=3D=3D=3D
> +
> +You can now very easily have actions be performed upon a mapping once se=
t up by
> +utilising simple helper functions invoked upon the `struct vm_area_desc`
> +pointer. These are:
> +
> +* `mmap_action_remap()` - Remaps a range consisting only of PFNs for a s=
pecific
> +  range starting a virtual address and PFN number of a set size.
> +
> +* `mmap_action_remap_full()` - Same as `mmap_action_remap()`, only remap=
s the
> +  entire mapping from `start_pfn` onward.
> +
> +* `mmap_action_ioremap()` - Same as `mmap_action_remap()`, only performs=
 an I/O
> +  remap.
> +
> +* `mmap_action_ioremap_full()` - Same as `mmap_action_ioremap()`, only r=
emaps
> +  the entire mapping from `start_pfn` onward.
> +
> +**NOTE:** The 'action' field should never normally be manipulated direct=
ly,
> +rather you ought to use one of these helpers.

I'm guessing the start and size parameters passed to
mmap_action_remap() and such are restricted by vm_area_desc.start
vm_area_desc.end. If so, should we document those restrictions and
enforce them in the code?

> +    struct vm_area_desc {
> +        /* Immutable state. */
> +        const struct mm_struct *const mm;
> +        struct file *const file; /* May vary from vm_file in stacked cal=
lers. */
> +        unsigned long start;
> +        unsigned long end;


> --
> 2.53.0
>

