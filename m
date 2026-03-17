Return-Path: <linux-hyperv+bounces-9486-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UBm9AakXuWmzqAEAu9opvQ
	(envelope-from <linux-hyperv+bounces-9486-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 17 Mar 2026 09:58:17 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 99F7C2A61FB
	for <lists+linux-hyperv@lfdr.de>; Tue, 17 Mar 2026 09:58:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D54D53025109
	for <lists+linux-hyperv@lfdr.de>; Tue, 17 Mar 2026 08:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B97B039E198;
	Tue, 17 Mar 2026 08:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jK3J4jID"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9426639C637;
	Tue, 17 Mar 2026 08:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773737894; cv=none; b=YQpTfdOzlHb2SblpGuXeLNIbQiERViv2eHVIA3+ZJ1LZ/u0+o0MM82CznBbk80fGD87wRGLPL6HaC0mHFHk6E99nHJS09jBqYOgrPsHHO6Ollccn0RFs4sxIWIYZytG9Qf/Hjl+bwweQkcZlzhGZZNsf2dZR4/UqtIAUxhWLwUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773737894; c=relaxed/simple;
	bh=6555lE8Eqz4VdrShTAZB8tLmpI5/NfoZfhGSGsRo30Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lBBZhyXa2oFhSwZE9tLIfnxrp4+rF16NVtg5Y2MQwSB0sNmYTKc5e0qN32LExju1ysQmzUR2XSA5wfo1LUhE3FQOdWYToY1P9KoUBjak9ikFlj4vzp2FlWHjWuTo29ET2twy8waEshh1LHX9GiTH7YrvPchv/T7VINrXEKtCO0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jK3J4jID; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B0D5C2BCB6;
	Tue, 17 Mar 2026 08:58:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773737894;
	bh=6555lE8Eqz4VdrShTAZB8tLmpI5/NfoZfhGSGsRo30Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jK3J4jIDbHMCKrxQ+OjUgrUordb9Xw/krWi+plO21PkM4j44mP8jyUr0+L6Gs8K54
	 3+hgkwVbgGjfrOruLgVyuttzaOPX/kP+WAWxiOzWMmNRwEJfgcT1aOb+x9THjCaONq
	 W9tloCz+rbEOI7JtI6nvRrRf2D+/xm5SN0ksYzj8cK9AxVC7/LC8vX5ZIQjB8gYlTe
	 Ws0eHBg1CWeRLxy89UpcLRszfQD6r867MrcFbjb+4b6l6NGjIPmb/YlGHORmMA2O/9
	 FjMkQioxd3ZmUvzvbV0gDNR0yAshhPSjBnl+NHW2jaZPx63xqVGFwCmPgqjWPZC4k5
	 khapcITUoXimg==
Date: Tue, 17 Mar 2026 08:58:02 +0000
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
Subject: Re: [PATCH 05/15] fs: afs: correctly drop reference count on mapping
 failure
Message-ID: <679f8190-752a-4b0c-ab5e-635938169cab@lucifer.local>
References: <4a5fa45119220b9d99ed72a36308aed01a30d2c1.1773346620.git.ljs@kernel.org>
 <20260313110745.2573005-1-usama.arif@linux.dev>
 <c62305d7-22c4-4cf7-969b-fbe214c93b64@lucifer.local>
 <CAJuCfpFio6n-O-1NkPXrymV0o3UqvHYS8ZOyQtt=JXnZ5dTGhQ@mail.gmail.com>
 <2536c05e-e228-404f-9916-906c0447b114@lucifer.local>
 <CAJuCfpH2XyAJOFKCZnviVV_UbF4O0wzj3QgJieo+LD=Cvr71jA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpH2XyAJOFKCZnviVV_UbF4O0wzj3QgJieo+LD=Cvr71jA@mail.gmail.com>
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
	TAGGED_FROM(0.00)[bounces-9486-lists,linux-hyperv=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linux.dev,linux-foundation.org,ladisch.de,arndb.de,linuxfoundation.org,microsoft.com,kernel.org,linux.intel.com,gmail.com,foss.st.com,bootlin.com,nod.at,ti.com,oracle.com,redhat.com,auristor.com,zeniv.linux.org.uk,suse.cz,suse.com,google.com,suse.de,vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org,lists.linux.dev,kvack.org,arm.com];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,lucifer.local:mid]
X-Rspamd-Queue-Id: 99F7C2A61FB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 16, 2026 at 08:41:48PM -0700, Suren Baghdasaryan wrote:
> On Mon, Mar 16, 2026 at 7:29 AM Lorenzo Stoakes (Oracle) <ljs@kernel.org> wrote:
> >
> > On Sun, Mar 15, 2026 at 07:32:54PM -0700, Suren Baghdasaryan wrote:
> > > On Fri, Mar 13, 2026 at 5:00 AM Lorenzo Stoakes (Oracle) <ljs@kernel.org> wrote:
> > > >
> > > > On Fri, Mar 13, 2026 at 04:07:43AM -0700, Usama Arif wrote:
> > > > > On Thu, 12 Mar 2026 20:27:20 +0000 "Lorenzo Stoakes (Oracle)" <ljs@kernel.org> wrote:
> > > > >
> > > > > > Commit 9d5403b1036c ("fs: convert most other generic_file_*mmap() users to
> > > > > > .mmap_prepare()") updated AFS to use the mmap_prepare callback in favour of
> > > > > > the deprecated mmap callback.
> > > > > >
> > > > > > However, it did not account for the fact that mmap_prepare can fail to map
> > > > > > due to an out of memory error, and thus should not be incrementing a
> > > > > > reference count on mmap_prepare.
> > >
> > > This is a bit confusing. I see the current implementation does
> > > afs_add_open_mmap() and then if generic_file_mmap_prepare() fails it
> > > does afs_drop_open_mmap(), therefore refcounting seems to be balanced.
> > > Is there really a problem?
> >
> > Firstly, mmap_prepare is invoked before we try to merge, so the VMA could in
> > theory get merged and then the refcounting will be wrong.
>
> I see now. Ok, makes sense.
>
> >
> > Secondly, mmap_prepare occurs at such at time where it is _possible_ that
> > allocation failures as described below could happen.
>
> Right, but in that case afs_file_mmap_prepare() would drop its
> refcount and return an error, so refcounting is still good, no?

Nope, in __mmap_region():

call_mmap_prepare()
-> __mmap_new_vma()
vm_area_alloc() -> can fail
vma_iter_prealloc() -> can fail
__mmap_new_file_vma() / shmem_zero_setup() -> can fail

If any of those fail the VMA is not even set up, so no close() will be called
because there's no VMA to call close on.

This is what makes mmap_prepare very different from mmap which passes in (a
partially established) VMA.

That and of course a potential merge would mean any refcount increment would be
wrong.

>
> >
> > I'll update the commit message to reflect the merge aspect actually.
>
> Thanks!

You're welcome, and done in v2 :)

>
> >
> > >
> > > > > >
> > > > > > With the newly added vm_ops->mapped callback available, we can simply defer
> > > > > > this operation to that callback which is only invoked once the mapping is
> > > > > > successfully in place (but not yet visible to userspace as the mmap and VMA
> > > > > > write locks are held).
> > > > > >
> > > > > > Therefore add afs_mapped() to implement this callback for AFS.
> > > > > >
> > > > > > In practice the mapping allocations are 'too small to fail' so this is
> > > > > > something that realistically should never happen in practice (or would do
> > > > > > so in a case where the process is about to die anyway), but we should still
> > > > > > handle this.
> > >
> > > nit: I would drop the above paragraph. If it's impossible why are you
> > > handling it? If it's unlikely, then handling it is even more
> > > important.
> >
> > Sure I can drop it, but it's an ongoing thing with these small allocations.
> >
> > I wish we could just move to a scenario where we can simpy assume allocations
> > will always succeed :)
>
> That would be really nice but unfortunately the world is not that
> perfect. I just don't want to be chasing some rarely reproducible bug
> because of the assumption that an allocation is too small to fail.

I mean I agree, we should handle all error paths.

Cheers, Lorenzo

