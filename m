Return-Path: <linux-hyperv+bounces-9754-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gAQ+Gpqvw2nAtAQAu9opvQ
	(envelope-from <linux-hyperv+bounces-9754-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Mar 2026 10:49:14 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C316B3226F7
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Mar 2026 10:49:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 77E9E301AF65
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Mar 2026 09:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EA2638E5C8;
	Wed, 25 Mar 2026 09:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h7rjxRys"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 603D523D281;
	Wed, 25 Mar 2026 09:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774432051; cv=none; b=Q6VVoyDu4oDBiezXkcjTmsJC/IEBsyyeFurc4qDAMK5fpvF+5WmfQhFKmI6K465hELUYjogonhMROIs/VtZblubQ5Jx50Xq1erb7eiEXIgyRBuL4Kr+QpNy0u9uyXVFfCkbPZcsJEU8kOknGx1qSNB+onzpXCYXLGAfDkmr2GO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774432051; c=relaxed/simple;
	bh=vUFrcOFz84OveU1pgKHoD1qwpdPZX9ciji33h3siGaE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aZnLNvsIizDm7i/tjj711gyDkHHekYIrWSYjBxt4p4odXKxXZX7PAroLFJnlMdA1PJKWxgwGZ8VoSPDoqTWBQ1LMJIywleZ0FcrU4MbQbcvCN5rIFRl9Rsw23gWvJ2ovMscSn0MjudMJMqJNhsYTKoeRMs2ZsOoJCl2P+W/HgtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h7rjxRys; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44F83C2BC9E;
	Wed, 25 Mar 2026 09:47:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774432051;
	bh=vUFrcOFz84OveU1pgKHoD1qwpdPZX9ciji33h3siGaE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=h7rjxRys800WY0i8LFUswSR3PcQtVI+WfcvFbM55iwz1ZH6sEQagzhf2LyOreVOSW
	 R1lGyQTKbfLllWJzdn5W8eaoKRVYpL0edcGcr6SCeDfoN1NRmrSZOCLjsPkGst2Vue
	 whTAV+F4IJb7xm4J+qcGoX5SFmIZFB+fhBwrR2605pUGNgx0fg/E3JSQRqS9sFkabZ
	 CtbaFD/j2jHu/4k19QPOkOOINFcC55JlaP/BKzrZDZAQkiiAvQh9vim4ubQ9CkIKj9
	 xhp7ke2Xf5zs7lnOYxqAky/AVcczwO5PeQU9qs8vfUKFRe22DcZ0GFLqD7cqpncinF
	 7/z8KNyW3nyVA==
Message-ID: <2bf17da7-fb46-4503-8de9-9368a73d8487@kernel.org>
Date: Wed, 25 Mar 2026 10:47:21 +0100
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 10/21] fs: afs: restore mmap_prepare implementation
Content-Language: en-US
To: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Clemens Ladisch <clemens@ladisch.de>,
 Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "K . Y . Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 Bodo Stroesser <bostroesser@gmail.com>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 David Howells <dhowells@redhat.com>, Marc Dionne <marc.dionne@auristor.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 David Hildenbrand <david@kernel.org>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>, Mike Rapoport
 <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Jann Horn <jannh@google.com>,
 Pedro Falcato <pfalcato@suse.de>, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-hyperv@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-mtd@lists.infradead.org,
 linux-staging@lists.linux.dev, linux-scsi@vger.kernel.org,
 target-devel@vger.kernel.org, linux-afs@lists.infradead.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 Ryan Roberts <ryan.roberts@arm.com>
References: <cover.1774045440.git.ljs@kernel.org>
 <ad9a94350a9c7d2bdab79fc397ef0f64d3412d71.1774045440.git.ljs@kernel.org>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
In-Reply-To: <ad9a94350a9c7d2bdab79fc397ef0f64d3412d71.1774045440.git.ljs@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9754-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lwn.net,ladisch.de,arndb.de,linuxfoundation.org,microsoft.com,kernel.org,linux.intel.com,gmail.com,foss.st.com,bootlin.com,nod.at,ti.com,oracle.com,redhat.com,auristor.com,zeniv.linux.org.uk,suse.cz,google.com,suse.com,suse.de,vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org,lists.linux.dev,kvack.org,arm.com];
	RCPT_COUNT_TWELVE(0.00)[44];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vbabka@kernel.org,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C316B3226F7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/20/26 23:39, Lorenzo Stoakes (Oracle) wrote:
> Commit 9d5403b1036c ("fs: convert most other generic_file_*mmap() users to
> .mmap_prepare()") updated AFS to use the mmap_prepare callback in favour
> of the deprecated mmap callback.
> 
> However, it did not account for the fact that mmap_prepare is called
> pre-merge, and may then be merged, nor that mmap_prepare can fail to map
> due to an out of memory error.
> 
> This change was therefore since reverted.
> 
> Both of those are cases in which we should not be incrementing a reference
> count.
> 
> With the newly added vm_ops->mapped callback available, we can simply
> defer this operation to that callback which is only invoked once the
> mapping is successfully in place (but not yet visible to userspace as the
> mmap and VMA write locks are held).
> 
> This allows us to once again reimplement the .mmap_prepare implementation
> for this file system.
> 
> Therefore add afs_mapped() to implement this callback for AFS, and remove
> the code doing so in afs_mmap_prepare().
> 
> Also update afs_vm_open(), afs_vm_close() and afs_vm_map_pages() to be
> consistent in how the vnode is accessed.
> 
> Signed-off-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>

Yep that should take care of that reference count problem.

Acked-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>

> ---
>  fs/afs/file.c | 42 +++++++++++++++++++++++++++++-------------
>  1 file changed, 29 insertions(+), 13 deletions(-)
> 
> diff --git a/fs/afs/file.c b/fs/afs/file.c
> index 74d04af51ff4..85696ac984cc 100644
> --- a/fs/afs/file.c
> +++ b/fs/afs/file.c
> @@ -19,7 +19,7 @@
>  #include <trace/events/netfs.h>
>  #include "internal.h"
> 
> -static int afs_file_mmap(struct file *file, struct vm_area_struct *vma);
> +static int afs_file_mmap_prepare(struct vm_area_desc *desc);
> 
>  static ssize_t afs_file_read_iter(struct kiocb *iocb, struct iov_iter *iter);
>  static ssize_t afs_file_splice_read(struct file *in, loff_t *ppos,
> @@ -28,6 +28,8 @@ static ssize_t afs_file_splice_read(struct file *in, loff_t *ppos,
>  static void afs_vm_open(struct vm_area_struct *area);
>  static void afs_vm_close(struct vm_area_struct *area);
>  static vm_fault_t afs_vm_map_pages(struct vm_fault *vmf, pgoff_t start_pgoff, pgoff_t end_pgoff);
> +static int afs_mapped(unsigned long start, unsigned long end, pgoff_t pgoff,
> +		      const struct file *file, void **vm_private_data);
> 
>  const struct file_operations afs_file_operations = {
>  	.open		= afs_open,
> @@ -35,7 +37,7 @@ const struct file_operations afs_file_operations = {
>  	.llseek		= generic_file_llseek,
>  	.read_iter	= afs_file_read_iter,
>  	.write_iter	= netfs_file_write_iter,
> -	.mmap		= afs_file_mmap,
> +	.mmap_prepare	= afs_file_mmap_prepare,
>  	.splice_read	= afs_file_splice_read,
>  	.splice_write	= iter_file_splice_write,
>  	.fsync		= afs_fsync,
> @@ -61,6 +63,7 @@ const struct address_space_operations afs_file_aops = {
>  };
> 
>  static const struct vm_operations_struct afs_vm_ops = {
> +	.mapped		= afs_mapped,
>  	.open		= afs_vm_open,
>  	.close		= afs_vm_close,
>  	.fault		= filemap_fault,
> @@ -492,34 +495,47 @@ static void afs_drop_open_mmap(struct afs_vnode *vnode)
>  /*
>   * Handle setting up a memory mapping on an AFS file.
>   */
> -static int afs_file_mmap(struct file *file, struct vm_area_struct *vma)
> +static int afs_file_mmap_prepare(struct vm_area_desc *desc)
>  {
> -	struct afs_vnode *vnode = AFS_FS_I(file_inode(file));
>  	int ret;
> 
> -	afs_add_open_mmap(vnode);
> +	ret = generic_file_mmap_prepare(desc);
> +	if (ret)
> +		return ret;
> 
> -	ret = generic_file_mmap(file, vma);
> -	if (ret == 0)
> -		vma->vm_ops = &afs_vm_ops;
> -	else
> -		afs_drop_open_mmap(vnode);
> +	desc->vm_ops = &afs_vm_ops;
>  	return ret;
>  }
> 
> +static int afs_mapped(unsigned long start, unsigned long end, pgoff_t pgoff,
> +		      const struct file *file, void **vm_private_data)
> +{
> +	struct afs_vnode *vnode = AFS_FS_I(file_inode(file));
> +
> +	afs_add_open_mmap(vnode);
> +	return 0;
> +}
> +
>  static void afs_vm_open(struct vm_area_struct *vma)
>  {
> -	afs_add_open_mmap(AFS_FS_I(file_inode(vma->vm_file)));
> +	struct file *file = vma->vm_file;
> +	struct afs_vnode *vnode = AFS_FS_I(file_inode(file));
> +
> +	afs_add_open_mmap(vnode);
>  }
> 
>  static void afs_vm_close(struct vm_area_struct *vma)
>  {
> -	afs_drop_open_mmap(AFS_FS_I(file_inode(vma->vm_file)));
> +	struct file *file = vma->vm_file;
> +	struct afs_vnode *vnode = AFS_FS_I(file_inode(file));
> +
> +	afs_drop_open_mmap(vnode);
>  }
> 
>  static vm_fault_t afs_vm_map_pages(struct vm_fault *vmf, pgoff_t start_pgoff, pgoff_t end_pgoff)
>  {
> -	struct afs_vnode *vnode = AFS_FS_I(file_inode(vmf->vma->vm_file));
> +	struct file *file = vmf->vma->vm_file;
> +	struct afs_vnode *vnode = AFS_FS_I(file_inode(file));
> 
>  	if (afs_check_validity(vnode))
>  		return filemap_map_pages(vmf, start_pgoff, end_pgoff);
> --
> 2.53.0


