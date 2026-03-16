Return-Path: <linux-hyperv+bounces-9442-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8HFBJaEauGn/YwEAu9opvQ
	(envelope-from <linux-hyperv+bounces-9442-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 16 Mar 2026 15:58:41 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F3B7629BE38
	for <lists+linux-hyperv@lfdr.de>; Mon, 16 Mar 2026 15:58:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0167A3038174
	for <lists+linux-hyperv@lfdr.de>; Mon, 16 Mar 2026 14:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 598362F5A12;
	Mon, 16 Mar 2026 14:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tSLnPF1F"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3436C2F290E;
	Mon, 16 Mar 2026 14:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773672719; cv=none; b=DpRGbUpA31BMj6EiRgRykOwLju0Agfat0wmDFk+AK3Hvt0WMmJAS3ZnbE7pzFjamzc+U9ucuwSQp1W6Nh7vLCp9Obnp2aRzmu/F7c0iwTyBPwIr+V48T94uxEC2QSmvkzdPd/49OKg9iTgaiPFTXV5g+FKQLYcIxz0rSkUfD5gI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773672719; c=relaxed/simple;
	bh=KIRMkEs2ki4Q4dp6M/GOhb93ujwUaNLq8lzChwMmjn0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BEeEqURnIB2OsfWVPRcs0+sh4dYUmASciWgjx6No7c9SxDAx95eyhxnEMvAaUSl7IXTqWvCJHHplKSTLbeExTksHbgnavH0U6okBzWB6DXzOFcj0lzxWw7867aFQRLJviR867trKuD3uvunijSnwubIQLzmhuhl6V0OM+X4smXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tSLnPF1F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EB72C19421;
	Mon, 16 Mar 2026 14:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773672718;
	bh=KIRMkEs2ki4Q4dp6M/GOhb93ujwUaNLq8lzChwMmjn0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tSLnPF1FQGukX0jNpyUPpw39RNpf5reYLO7x3EfolXRfSyklFjmya7iBIUL9cYR6P
	 03ZQOFOVkIRw02GeRSmaaZYbqDhPig/hYez6AG/QQcB6PIpP1NgYdwb2UyqLlLW8iw
	 xUqt4NFyQEpDdvNYzd7D140Zjk7FrDTOTJkLe0vutUmzUAeVv2IEcNlfeMcAvkPVaM
	 JQNf8HpqT3Lstxvxat/f9kXEENmcKZ8Ntab7TkVbAmfxGz8pl03oD9b+QUUc8+zciP
	 F7uXVlaQGF7zb+pS6vO6CMdBKRn645sD50BB1GRswzWJvFb4E88gqDAtEdIxjhTHlA
	 ZD/322/wk5nBA==
Date: Mon, 16 Mar 2026 14:51:47 +0000
From: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
To: Randy Dunlap <rdunlap@infradead.org>
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
	Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Jann Horn <jannh@google.com>, 
	Pedro Falcato <pfalcato@suse.de>, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-hyperv@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-mtd@lists.infradead.org, linux-staging@lists.linux.dev, 
	linux-scsi@vger.kernel.org, target-devel@vger.kernel.org, linux-afs@lists.infradead.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, Ryan Roberts <ryan.roberts@arm.com>
Subject: Re: [PATCH 02/15] mm: add documentation for the mmap_prepare file
 operation callback
Message-ID: <0eeb2bcb-3ee1-47cf-a5ee-45eb0038ec67@lucifer.local>
References: <cover.1773346620.git.ljs@kernel.org>
 <c5bb61cf789df1ecb32facc29df9749987c7ddfc.1773346620.git.ljs@kernel.org>
 <f0e33b51-d465-462d-b0f6-98a1db66bb15@infradead.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f0e33b51-d465-462d-b0f6-98a1db66bb15@infradead.org>
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
	TAGGED_FROM(0.00)[bounces-9442-lists,linux-hyperv=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,lwn.net,ladisch.de,arndb.de,linuxfoundation.org,microsoft.com,kernel.org,linux.intel.com,gmail.com,foss.st.com,bootlin.com,nod.at,ti.com,oracle.com,redhat.com,auristor.com,zeniv.linux.org.uk,suse.cz,google.com,suse.com,suse.de,vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org,lists.linux.dev,kvack.org,arm.com];
	RCPT_COUNT_TWELVE(0.00)[45];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lucifer.local:mid]
X-Rspamd-Queue-Id: F3B7629BE38
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 12, 2026 at 05:12:04PM -0700, Randy Dunlap wrote:
> (Andrew: patch attached)
>
>
> On 3/12/26 1:27 PM, Lorenzo Stoakes (Oracle) wrote:
>
> Documentation/filesystems/mmap_prepare.rst: WARNING: document isn't included in any toctree [toc.not_included]
>
> Should be in some index.rst file. In filesystems I suppose.

Ack thanks.

>
> > ---
> >  Documentation/filesystems/mmap_prepare.rst | 131 +++++++++++++++++++++
> >  1 file changed, 131 insertions(+)
> >  create mode 100644 Documentation/filesystems/mmap_prepare.rst
> >
> > diff --git a/Documentation/filesystems/mmap_prepare.rst b/Documentation/filesystems/mmap_prepare.rst
> > new file mode 100644
> > index 000000000000..76908200f3a1
> > --- /dev/null
> > +++ b/Documentation/filesystems/mmap_prepare.rst
> > @@ -0,0 +1,131 @@
> > +.. SPDX-License-Identifier: GPL-2.0
> > +
> > +===========================
> > +mmap_prepare callback HOWTO
> > +===========================
> > +
> > +Introduction
> > +############
>
> Kernel style is "=============" above instead of "############".

Ack

>
> > +
> > +The `struct file->f_op->mmap()` callback has been deprecated as it is both a
> > +stability and security risk, and doesn't always permit the merging of adjacent
> > +mappings resulting in unnecessary memory fragmentation.
> > +
> > +It has been replaced with the `file->f_op->mmap_prepare()` callback which solves
> > +these problems.
> > +
> > +## How To Use
> > +
> > +In your driver's `struct file_operations` struct, specify an `mmap_prepare`
> > +callback rather than an `mmap` one, e.g. for ext4:
> > +
> > +
> > +.. code-block:: C
> > +
> > +    const struct file_operations ext4_file_operations = {
> > +        ...
> > +        .mmap_prepare    = ext4_file_mmap_prepare,
> > +    };
> > +
> > +This has a signature of `int (*mmap_prepare)(struct vm_area_desc *)`.
> > +
> > +Examining the `struct vm_area_desc` type:
> > +
> > +.. code-block:: C
> > +
> > +    struct vm_area_desc {
> > +        /* Immutable state. */
> > +        const struct mm_struct *const mm;
> > +        struct file *const file; /* May vary from vm_file in stacked callers. */
> > +        unsigned long start;
> > +        unsigned long end;
> > +
> > +        /* Mutable fields. Populated with initial state. */
> > +        pgoff_t pgoff;
> > +        struct file *vm_file;
> > +        vma_flags_t vma_flags;
> > +        pgprot_t page_prot;
> > +
> > +        /* Write-only fields. */
> > +        const struct vm_operations_struct *vm_ops;
> > +        void *private_data;
> > +
> > +        /* Take further action? */
> > +        struct mmap_action action;
> > +    };
> > +
> > +This is straightforward - you have all the fields you need to set up the
> > +mapping, and you can update the mutable and writable fields, for instance:
> > +
> > +.. code-block:: Cw
>
>    .. code-block:: C
>
> Documentation/filesystems/mmap_prepare.rst:60: WARNING: Pygments lexer name 'Cw' is not known [misc.highlighting_failure]
>
> Maybe a typo?

Yeah is a typo thanks!

>
> > +
> > +    static int ext4_file_mmap_prepare(struct vm_area_desc *desc)
> > +    {
> > +        int ret;
> > +        struct file *file = desc->file;
> > +        struct inode *inode = file->f_mapping->host;
> > +
> > +        ...
> > +
> > +        file_accessed(file);
> > +        if (IS_DAX(file_inode(file))) {
> > +            desc->vm_ops = &ext4_dax_vm_ops;
> > +            vma_desc_set_flags(desc, VMA_HUGEPAGE_BIT);
> > +        } else {
> > +            desc->vm_ops = &ext4_file_vm_ops;
> > +        }
> > +        return 0;
> > +    }
> > +
> > +Importantly, you no longer have to dance around with reference counts or locks
> > +when updating these fields - __you can simply go ahead and change them__.
> > +
> > +Everything is taken care of by the mapping code.
> > +
> > +VMA Flags
> > +=========
>
> and then use "---------------" here instead of "==============".

Ack

>
> (from Documentation/doc-guide/sphinx.rst)
>
> > +
> > +Along with `mmap_prepare`, VMA flags have undergone an overhaul. Where before
> > +you would invoke one of `vm_flags_init()`, `vm_flags_reset()`, `vm_flags_set()`,
> > +`vm_flags_clear()`, and `vm_flags_mod()` to modify flags (and to have the
> > +locking done correctly for you, this is no longer necessary.
> > +
> > +Also, the legacy approach of specifying VMA flags via `VM_READ`, `VM_WRITE`,
> > +etc. - i.e. using a `VM_xxx` macro has changed too.
> > +
> > +When implementing `mmap_prepare()`, reference flags by their bit number, defined
> > +as a `VMA_xxx_BIT` macro, e.g. `VMA_READ_BIT`, `VMA_WRITE_BIT` etc., and use one
> > +of (where `desc` is a pointer to `struct vma_area_desc`):
> > +
> > +* `vma_desc_test_flags(desc, ...)` - Specify a comma-separated list of flags you
> > +  wish to test for (whether _any_ are set), e.g. - `vma_desc_test_flags(desc,
> > +  VMA_WRITE_BIT, VMA_MAYWRITE_BIT)` - returns `true` if either are set,
> > +  otherwise `false`.
> > +* `vma_desc_set_flags(desc, ...)` - Update the VMA descriptor flags to set
> > +  additional flags specified by a comma-separated list,
> > +  e.g. - `vma_desc_set_flags(desc, VMA_PFNMAP_BIT, VMA_IO_BIT)`.
> > +* `vma_desc_clear_flags(desc, ...)` - Update the VMA descriptor flags to clear
> > +  flags specified by a comma-separated list, e.g. - `vma_desc_clear_flags(desc,
> > +  VMA_WRITE_BIT, VMA_MAYWRITE_BIT)`.
> > +
> > +Actions
> > +=======
> > +
> > +You can now very easily have actions be performed upon a mapping once set up by
> > +utilising simple helper functions invoked upon the `struct vm_area_desc`
> > +pointer. These are:
> > +
> > +* `mmap_action_remap()` - Remaps a range consisting only of PFNs for a specific
> > +  range starting a virtual address and PFN number of a set size.
> > +
> > +* `mmap_action_remap_full()` - Same as `mmap_action_remap()`, only remaps the
> > +  entire mapping from `start_pfn` onward.
> > +
> > +* `mmap_action_ioremap()` - Same as `mmap_action_remap()`, only performs an I/O
> > +  remap.
> > +
> > +* `mmap_action_ioremap_full()` - Same as `mmap_action_ioremap()`, only remaps
> > +  the entire mapping from `start_pfn` onward.
> > +
> > +**NOTE:** The 'action' field should never normally be manipulated directly,
> > +rather you ought to use one of these helpers.
>
> I also see this warning, but I don't know what it is referring to:
>
> Documentation/filesystems/mmap_prepare.rst:132: ERROR: Anonymous hyperlink mismatch: 1 references but 0 targets.
> See "backrefs" attribute for IDs. [docutils]
>
> (OK, I found/fixed that also.)
>
> There are also lots of single ` marks which mean italics. I thought those were
> not what was intended, so I changed (most of) them to `` marks, which means
> "code block / monospace". I can fix those if needed.
>
> from the patch file:
> @Lorenzo: ISTR that you prefer explicit quoting on structs and
> functions. I didn't do that here since kernel automarkup does that,
> but if you prefer, I can redo the patch with those changes.

The issue was in another document it didn't seem to properly recognise the types
AFAICT (but I might have been mistaken anyway!) But I'm fine without.

>
> HTH.
> --
> ~Randy

Thanks for this, will fold the patch into the respin also!

Cheers, Lorenzo

