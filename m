Return-Path: <linux-hyperv+bounces-9401-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sJfTKu78s2mWewAAu9opvQ
	(envelope-from <linux-hyperv+bounces-9401-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Mar 2026 13:02:54 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 68096282A04
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Mar 2026 13:02:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7C21430C2582
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Mar 2026 12:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F20739099F;
	Fri, 13 Mar 2026 12:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AfKnv5A1"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8370A390982;
	Fri, 13 Mar 2026 12:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773403215; cv=none; b=VBt4xGrE8neVSifE3NYw3qPQMLPia/BUL0OKwUPFJRDAVpthcqGhKfIhUfSSgxZ5ibyuEVLAeMcdjLlLmNcFGsnQR74r6AL+EpzjW1PFQj8mskuwiZDCP0msedxwFfackmg637mXiGAGvbngKwMLlvw5RihzvmOSvFC2CwN8Jhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773403215; c=relaxed/simple;
	bh=oJXek/425Du8hdak6ZAKOrvHZlv0IlGG9djsmRtUsQI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V4VJKLKlOrjGfOAokWSJrUn5vRZ/R4z9nSe5PSH/hLViCOHNGRY4XN43hEL3291oD8XZRUkxzIiawarkG8+wr3robyXfz0KwUaxPjpQEnb1OM8idT01Jdt9KsXe1jp5blEPXKpeL3etkEBU/3Twhd7X8eQBm7t9x2fy0hQl4Wh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AfKnv5A1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACC72C19421;
	Fri, 13 Mar 2026 12:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773403215;
	bh=oJXek/425Du8hdak6ZAKOrvHZlv0IlGG9djsmRtUsQI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AfKnv5A1okg9eNUiDxAyQy2xL/uhZe8tJX6hGHDskVrVUSvtmRufjkpjd+43UzOoT
	 j+/00iEd+AcyU75UVscGSS97YkUSD3Xj7ph8IVySNVl0YuO0W0k6uG2Gm4Ig3K3L9G
	 GxvPH9Z+HCSmaRFDcS/l0JZpB+sCZ4V3tnWxMZ9AkjTNkVBhEe3p5SvVjG3qcpMRfm
	 lj3LNsVtqxvYmqV38UIqIAegY9wtrOU6PtJCJEn1jXPI8FdDrMhoQN2V9ApulNo8Hv
	 BjUfQu7SLOUWuC9ypjjkfA3Vzk6PSSxyeIkwbc1RRGgwaSCvM4p930Dh4y7vVgEcK7
	 EjEmbpAxgrV0A==
Date: Fri, 13 Mar 2026 12:00:03 +0000
From: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
To: Usama Arif <usama.arif@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Clemens Ladisch <clemens@ladisch.de>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "K . Y . Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, 
	Long Li <longli@microsoft.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Miquel Raynal <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>, 
	Vignesh Raghavendra <vigneshr@ti.com>, Bodo Stroesser <bostroesser@gmail.com>, 
	"Martin K . Petersen" <martin.petersen@oracle.com>, David Howells <dhowells@redhat.com>, 
	Marc Dionne <marc.dionne@auristor.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, David Hildenbrand <david@kernel.org>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-hyperv@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, 
	linux-mtd@lists.infradead.org, linux-staging@lists.linux.dev, linux-scsi@vger.kernel.org, 
	target-devel@vger.kernel.org, linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, Ryan Roberts <ryan.roberts@arm.com>
Subject: Re: [PATCH 05/15] fs: afs: correctly drop reference count on mapping
 failure
Message-ID: <c62305d7-22c4-4cf7-969b-fbe214c93b64@lucifer.local>
References: <4a5fa45119220b9d99ed72a36308aed01a30d2c1.1773346620.git.ljs@kernel.org>
 <20260313110745.2573005-1-usama.arif@linux.dev>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260313110745.2573005-1-usama.arif@linux.dev>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9401-lists,linux-hyperv=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,ladisch.de,arndb.de,linuxfoundation.org,microsoft.com,kernel.org,linux.intel.com,gmail.com,foss.st.com,bootlin.com,nod.at,ti.com,oracle.com,redhat.com,auristor.com,zeniv.linux.org.uk,suse.cz,google.com,suse.com,suse.de,vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org,lists.linux.dev,kvack.org,arm.com];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lucifer.local:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 68096282A04
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 13, 2026 at 04:07:43AM -0700, Usama Arif wrote:
> On Thu, 12 Mar 2026 20:27:20 +0000 "Lorenzo Stoakes (Oracle)" <ljs@kernel.org> wrote:
>
> > Commit 9d5403b1036c ("fs: convert most other generic_file_*mmap() users to
> > .mmap_prepare()") updated AFS to use the mmap_prepare callback in favour of
> > the deprecated mmap callback.
> >
> > However, it did not account for the fact that mmap_prepare can fail to map
> > due to an out of memory error, and thus should not be incrementing a
> > reference count on mmap_prepare.
> >
> > With the newly added vm_ops->mapped callback available, we can simply defer
> > this operation to that callback which is only invoked once the mapping is
> > successfully in place (but not yet visible to userspace as the mmap and VMA
> > write locks are held).
> >
> > Therefore add afs_mapped() to implement this callback for AFS.
> >
> > In practice the mapping allocations are 'too small to fail' so this is
> > something that realistically should never happen in practice (or would do
> > so in a case where the process is about to die anyway), but we should still
> > handle this.
> >
> > Signed-off-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>
> > ---
> >  fs/afs/file.c | 20 ++++++++++++++++----
> >  1 file changed, 16 insertions(+), 4 deletions(-)
> >
> > diff --git a/fs/afs/file.c b/fs/afs/file.c
> > index f609366fd2ac..69ef86f5e274 100644
> > --- a/fs/afs/file.c
> > +++ b/fs/afs/file.c
> > @@ -28,6 +28,8 @@ static ssize_t afs_file_splice_read(struct file *in, loff_t *ppos,
> >  static void afs_vm_open(struct vm_area_struct *area);
> >  static void afs_vm_close(struct vm_area_struct *area);
> >  static vm_fault_t afs_vm_map_pages(struct vm_fault *vmf, pgoff_t start_pgoff, pgoff_t end_pgoff);
> > +static int afs_mapped(unsigned long start, unsigned long end, pgoff_t pgoff,
> > +		      const struct file *file, void **vm_private_data);
> >
> >  const struct file_operations afs_file_operations = {
> >  	.open		= afs_open,
> > @@ -61,6 +63,7 @@ const struct address_space_operations afs_file_aops = {
> >  };
> >
> >  static const struct vm_operations_struct afs_vm_ops = {
> > +	.mapped		= afs_mapped,
> >  	.open		= afs_vm_open,
> >  	.close		= afs_vm_close,
> >  	.fault		= filemap_fault,
> > @@ -500,13 +503,22 @@ static int afs_file_mmap_prepare(struct vm_area_desc *desc)
> >  	afs_add_open_mmap(vnode);
>
> Is the above afs_add_open_mmap an additional one, which could cause a reference
> leak? Does the above one need to be removed and only the one in afs_mapped()
> needs to be kept?

Ah yeah good spot, will fix thanks!

>
> >
> >  	ret = generic_file_mmap_prepare(desc);
> > -	if (ret == 0)
> > -		desc->vm_ops = &afs_vm_ops;
> > -	else
> > -		afs_drop_open_mmap(vnode);
> > +	if (ret)
> > +		return ret;
> > +
> > +	desc->vm_ops = &afs_vm_ops;
> >  	return ret;
> >  }
> >
> > +static int afs_mapped(unsigned long start, unsigned long end, pgoff_t pgoff,
> > +		      const struct file *file, void **vm_private_data)
> > +{
> > +	struct afs_vnode *vnode = AFS_FS_I(file_inode(file));
> > +
> > +	afs_add_open_mmap(vnode);
> > +	return 0;
> > +}
> > +
> >  static void afs_vm_open(struct vm_area_struct *vma)
> >  {
> >  	afs_add_open_mmap(AFS_FS_I(file_inode(vma->vm_file)));
> > --
> > 2.53.0
> >
> >

Cheers, Lorenzo

