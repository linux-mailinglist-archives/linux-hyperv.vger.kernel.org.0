Return-Path: <linux-hyperv+bounces-9439-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6EU8CUUUuGl/YwEAu9opvQ
	(envelope-from <linux-hyperv+bounces-9439-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 16 Mar 2026 15:31:33 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AF8E29B6AC
	for <lists+linux-hyperv@lfdr.de>; Mon, 16 Mar 2026 15:31:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6419D3005AB7
	for <lists+linux-hyperv@lfdr.de>; Mon, 16 Mar 2026 14:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B93129A32D;
	Mon, 16 Mar 2026 14:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X1MvHmFe"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A36277029;
	Mon, 16 Mar 2026 14:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773671488; cv=none; b=EFprvwqJfNh7sFhYJ0Jeoul5NVzImWOeYtT5nXY1eY1dADaFMBNXloVqY55l+C/B0266AmFHTPJHcV8lbBDmER77ZmJzWxdokko2kHWP2H9zyH6hpkSmOCXW6JCaFOaQ+p5LiHkbLGBLefPLYc/WIXISmEB14poWL5XhsnL3g8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773671488; c=relaxed/simple;
	bh=wmwRlESgrnvepPbb1PirkwNJB9yCJFViHuseAPzZgTU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S8lvj6JZSYNsQRHR8W8Sc6LBAyls3N54lM/mJS3zaN3RkBKOAmprstpl4Elcuc+gRuZc8SPPqa2dHgeNtOtNa+DlpjRRmDTrpro+KzoC+RBELreYKxzbbdCczSfM6IkulaqYnok9KFlYJ5E7+DDxQwAOMGx9Sg5xcB+PZ34Dgpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X1MvHmFe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC85CC19421;
	Mon, 16 Mar 2026 14:31:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773671488;
	bh=wmwRlESgrnvepPbb1PirkwNJB9yCJFViHuseAPzZgTU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X1MvHmFeTMXLS17UDbf4qKWdxfdfl1nIIM1Znjt/hB9Jrz7XpIjRGeKs/GgD5HbmT
	 GJnoLBvTQBD3mLyiQNYu/uMaiNpDmAFyJZxaGwL4kth9NMa+7N8pWmipLI9MOUnNIm
	 XZuQWf4hbnuJkGt5El0XdUQ+XGEEEj/ffydaRt0U7/71pqXpi7xrliHkFxDB3ruYpx
	 nd8CvutsY0NcvbrtfRvTcx8uB1G0uZ0HoUdnCcCHmTSa8GQRX3yC4bOT9X7R/YGAmG
	 CL3fSgSn9uu67vMXPRuf0GENu4YKm6u93U51R6SiQiRnK+y3zr8woWQTM2An6cXIJn
	 BxJKdQaXB4REg==
Date: Mon, 16 Mar 2026 14:31:17 +0000
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
Subject: Re: [PATCH 03/15] mm: document vm_operations_struct->open the same
 as close()
Message-ID: <fdc193c6-483e-4e8e-8813-fa71d984bfb1@lucifer.local>
References: <cover.1773346620.git.ljs@kernel.org>
 <52a7b9a003ea51521ab3c0baf30337a7800a3af7.1773346620.git.ljs@kernel.org>
 <CAJuCfpHVN66abFrJgorXKBsjv7Ut=CP-E4NpLMC4SW613tJwtw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpHVN66abFrJgorXKBsjv7Ut=CP-E4NpLMC4SW613tJwtw@mail.gmail.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9439-lists,linux-hyperv=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,lwn.net,ladisch.de,arndb.de,linuxfoundation.org,microsoft.com,kernel.org,linux.intel.com,gmail.com,foss.st.com,bootlin.com,nod.at,ti.com,oracle.com,redhat.com,auristor.com,zeniv.linux.org.uk,suse.cz,suse.com,google.com,suse.de,vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org,lists.linux.dev,kvack.org,arm.com];
	RCPT_COUNT_TWELVE(0.00)[44];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ljs@kernel.org,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lucifer.local:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7AF8E29B6AC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, Mar 15, 2026 at 05:43:41PM -0700, Suren Baghdasaryan wrote:
> On Thu, Mar 12, 2026 at 1:27 PM Lorenzo Stoakes (Oracle) <ljs@kernel.org> wrote:
> >
> > Describe when the operation is invoked and the context in which it is
> > invoked, matching the description already added for vm_op->close().
> >
> > While we're here, update all outdated references to an 'area' field for
> > VMAs to the more consistent 'vma'.
> >
> > Signed-off-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>
> > ---
> >  include/linux/mm.h | 15 ++++++++++-----
> >  1 file changed, 10 insertions(+), 5 deletions(-)
> >
> > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > index cc5960a84382..12a0b4c63736 100644
> > --- a/include/linux/mm.h
> > +++ b/include/linux/mm.h
> > @@ -748,15 +748,20 @@ struct vm_uffd_ops;
> >   * to the functions called when a no-page or a wp-page exception occurs.
> >   */
> >  struct vm_operations_struct {
> > -       void (*open)(struct vm_area_struct * area);
> > +       /**
> > +        * @open: Called when a VMA is remapped or split. Not called upon first
> > +        * mapping a VMA.
>
> It's also called from dup_mmap() which is part of forking.

Ah yup :) will update thanks!

>
> > +        * Context: User context.  May sleep.  Caller holds mmap_lock.
> > +        */
> > +       void (*open)(struct vm_area_struct *vma);
> >         /**
> >          * @close: Called when the VMA is being removed from the MM.
> >          * Context: User context.  May sleep.  Caller holds mmap_lock.
> >          */
> > -       void (*close)(struct vm_area_struct * area);
> > +       void (*close)(struct vm_area_struct *vma);
> >         /* Called any time before splitting to check if it's allowed */
> > -       int (*may_split)(struct vm_area_struct *area, unsigned long addr);
> > -       int (*mremap)(struct vm_area_struct *area);
> > +       int (*may_split)(struct vm_area_struct *vma, unsigned long addr);
> > +       int (*mremap)(struct vm_area_struct *vma);
> >         /*
> >          * Called by mprotect() to make driver-specific permission
> >          * checks before mprotect() is finalised.   The VMA must not
> > @@ -768,7 +773,7 @@ struct vm_operations_struct {
> >         vm_fault_t (*huge_fault)(struct vm_fault *vmf, unsigned int order);
> >         vm_fault_t (*map_pages)(struct vm_fault *vmf,
> >                         pgoff_t start_pgoff, pgoff_t end_pgoff);
> > -       unsigned long (*pagesize)(struct vm_area_struct * area);
> > +       unsigned long (*pagesize)(struct vm_area_struct *vma);
> >
> >         /* notification that a previously read-only page is about to become
> >          * writable, if an error is returned it will cause a SIGBUS */
> > --
> > 2.53.0
> >

Cheers, Lorenzo

