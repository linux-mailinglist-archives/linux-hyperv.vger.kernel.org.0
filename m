Return-Path: <linux-hyperv+bounces-9739-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kFZSEoTAwmmjlQQAu9opvQ
	(envelope-from <linux-hyperv+bounces-9739-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 24 Mar 2026 17:49:08 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AE3B3195B6
	for <lists+linux-hyperv@lfdr.de>; Tue, 24 Mar 2026 17:49:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 864443056435
	for <lists+linux-hyperv@lfdr.de>; Tue, 24 Mar 2026 16:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E31F3EDAAA;
	Tue, 24 Mar 2026 16:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mCj3nnRZ"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 463C63DDDCD;
	Tue, 24 Mar 2026 16:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774370122; cv=none; b=qYci5dqyf7AmmAxg7/zogFolhE+E2jaGMZ0YAVBkfyoI6qLQI1AiqDh0hdLHfrKwSWKdem99eOW+ab8Qc+SAdoihz3/wVOLpYgHE0lWbFtaM/wHPiE40dxueg0cVA31tvkbOwTsqIWeeUyy8j9roIhJbzZ6eGgMkf7ge06oKA4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774370122; c=relaxed/simple;
	bh=uvgrzaHO3grkwKy9+089vaxpnmbs4+0xFVD7fE+BlCg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GfrUkX7GZjvmykWCP1v4WT3N9hTKVip2s8RQMu3ALVQBE49hXyTWs5rCZ5HrLSPsjK4Rxwlc+w9KK5pqtZYB3adM89PIooo69HfG3fiRYsdxN5lOjrPzp3FfofC5Hwa4E/N9y3Eiy9xqohW6PzaGl/gaIiQStUYRkR1HGtul6/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mCj3nnRZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A27FCC19424;
	Tue, 24 Mar 2026 16:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774370121;
	bh=uvgrzaHO3grkwKy9+089vaxpnmbs4+0xFVD7fE+BlCg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mCj3nnRZEPIdtmViKw3PDpai7OwDquEgzLJEZ26oE90AfteaXy0i9TaB/c7BaxFvb
	 TbEiCuWEA6Wv27Asd6DPIJsTH4Mx9POnWfqMFokRI+bLy/W2CLoSfDEWfM24Us13Cs
	 QXtvIAoK0qd8ujZUWv2rJrVyiBeVoH8QP/Ob/fjUArQV4sgDIv/QN7M4pvzKbUoZdK
	 +j93tcLxP+JAgxjn7Uj5hDnfPw51TI0eFm6GJldqWDg6h4T1BtYK6geAEWodxE/Zw7
	 nSMQAMGNOD6Cc/Ya9icBBPVn1CDFRReP2qnF9OeRpbQUvvkbOLXBBmRg8bD9QubspZ
	 mndsFT1HJo3ng==
Date: Tue, 24 Mar 2026 16:35:10 +0000
From: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
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
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-hyperv@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, 
	linux-mtd@lists.infradead.org, linux-staging@lists.linux.dev, linux-scsi@vger.kernel.org, 
	target-devel@vger.kernel.org, linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, Ryan Roberts <ryan.roberts@arm.com>
Subject: Re: [PATCH v4 05/21] mm: switch the rmap lock held option off in
 compat layer
Message-ID: <ad5e5bed-12b7-4ef7-a93f-753489115cb0@lucifer.local>
References: <cover.1774045440.git.ljs@kernel.org>
 <dda74230d26a1fcd79a3efab61fa4101dd1cac64.1774045440.git.ljs@kernel.org>
 <d5b66671-697f-4a4d-8039-d9c9ac5ad4d7@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d5b66671-697f-4a4d-8039-d9c9ac5ad4d7@kernel.org>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9739-lists,linux-hyperv=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,lwn.net,ladisch.de,arndb.de,linuxfoundation.org,microsoft.com,kernel.org,linux.intel.com,gmail.com,foss.st.com,bootlin.com,nod.at,ti.com,oracle.com,redhat.com,auristor.com,zeniv.linux.org.uk,suse.cz,google.com,suse.com,suse.de,vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org,lists.linux.dev,kvack.org,arm.com];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,lucifer.local:mid]
X-Rspamd-Queue-Id: 9AE3B3195B6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 24, 2026 at 03:26:28PM +0100, Vlastimil Babka (SUSE) wrote:
> On 3/20/26 23:39, Lorenzo Stoakes (Oracle) wrote:
> > In the mmap_prepare compatibility layer, we don't need to hold the rmap
> > lock, as we are being called from an .mmap handler.
> >
> > The .mmap_prepare hook, when invoked in the VMA logic, is called prior to
> > the VMA being instantiated, but the completion hook is called after the VMA
> > is linked into the maple tree, meaning rmap walkers can reach it.
> >
> > The mmap hook does not link the VMA into the tree, so this cannot happen.
> >
> > Therefore it's safe to simply disable this in the mmap_prepare
> > compatibility layer.
> >
> > Also update VMA tests code to reflect current compatibility layer state.
> >
> > Signed-off-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>
>
> Acked-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
>
> a typo fix below, Andrew can fix locally?
>
> > ---
> >  mm/util.c                       |  6 ++++-
> >  tools/testing/vma/include/dup.h | 42 +++++++++++++++++----------------
> >  2 files changed, 27 insertions(+), 21 deletions(-)
> >
> > diff --git a/mm/util.c b/mm/util.c
> > index a2cfa0d77c35..182f0f5cc400 100644
> > --- a/mm/util.c
> > +++ b/mm/util.c
> > @@ -1204,6 +1204,7 @@ int compat_vma_mmap(struct file *file, struct vm_area_struct *vma)
> >
> >  		.action.type = MMAP_NOTHING, /* Default */
> >  	};
> > +	struct mmap_action *action = &desc.action;
> >  	int err;
> >
> >  	err = vfs_mmap_prepare(file, &desc);
> > @@ -1214,8 +1215,11 @@ int compat_vma_mmap(struct file *file, struct vm_area_struct *vma)
> >  	if (err)
> >  		return err;
> >
> > +	/* being invoked from .mmmap means we don't have to enforce this. */
>
> 				.mmap

mmmmm map! ;)

Andrew - could you fixup in place? Thanks.

>
> > +	action->hide_from_rmap_until_complete = false;
> > +
> >  	set_vma_from_desc(vma, &desc);
> > -	err = mmap_action_complete(vma, &desc.action);
> > +	err = mmap_action_complete(vma, action);
> >  	if (err) {
> >  		const size_t len = vma_pages(vma) << PAGE_SHIFT;
> >

