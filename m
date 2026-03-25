Return-Path: <linux-hyperv+bounces-9750-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KPPcG+2lw2lssQQAu9opvQ
	(envelope-from <linux-hyperv+bounces-9750-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Mar 2026 10:07:57 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D06C3321E30
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Mar 2026 10:07:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 410BE3034325
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Mar 2026 09:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF81F322B7B;
	Wed, 25 Mar 2026 09:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B/pXGWqx"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A517211A05;
	Wed, 25 Mar 2026 09:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774429585; cv=none; b=S/BiS1TXupxlalNNs1axY1yMUh/PFxpB4BgcQ0sYQt8NhqMzonhia/qkONPEzX6A1gUBWZr1FkQ1brPOy3mztHpp5ztckfMWMX7Vrkbce5KuUR8sE6rGGVn6hvtyPSkkboRV10JwwlEe0uEuRlYCYPJsBshWeX9I2YgjauF+oSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774429585; c=relaxed/simple;
	bh=TGeHJllmZaOU480qUtXeb/jUm42/azepnhJdaLl9P5A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F9h5GRnOS7N2DXbJ51rWO67AuAs8sqG8R4t4HJtTAFq7Cm+yrcwI2Jb80u4tHsUt43GrrrhlqY2LZvLkCpbAvd8P+2+y35TQhhRfimLv4Gk0hLp1WPbb9n97SFr0/TEOuNcWUevxpVX/rXoY49NbCXV3JKd1yZTtWUMLUE2WcLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B/pXGWqx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F5A1C4CEF7;
	Wed, 25 Mar 2026 09:06:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774429585;
	bh=TGeHJllmZaOU480qUtXeb/jUm42/azepnhJdaLl9P5A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=B/pXGWqxkc77H/QNjcNN4hXFs+1yWtOO/K6ZlFDqfhgwHp4yHtUXBY1gINF1N/v7H
	 Swoeh/4pl25iEnor6XcK93/xaSpBQCXea/x0tJWaU2vmaO0gQrTCNvrvDCRgFprVKV
	 1KqlwKP+22aqYID5Rc4LF4kA7w+kAFXYTzDiwCQpdMmDJrHF9HDz+HIU9m1OkF3LTb
	 /jwCEhab+UIAPA9vKX7zWI8lclKZJMoZ3e82DcRkAVWva3ZfDqkkW0tKKWs9g8wCY/
	 xPGCmHA6G5g4E8Zs8WC6hluY2t54Kvjz8OpvZWbU1RkOlOvI5O2Nk6MOymHovUB97F
	 cRXNnffbCU5+g==
Message-ID: <e9e9c3a3-26fb-4ca5-af27-158f4860a810@kernel.org>
Date: Wed, 25 Mar 2026 10:06:15 +0100
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 09/21] fs: afs: revert mmap_prepare() change
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
 <08804c94e39d9102a3a8fbd12385e8aa079ba1d3.1774045440.git.ljs@kernel.org>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
In-Reply-To: <08804c94e39d9102a3a8fbd12385e8aa079ba1d3.1774045440.git.ljs@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9750-lists,linux-hyperv=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D06C3321E30
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/20/26 23:39, Lorenzo Stoakes (Oracle) wrote:
> Partially reverts commit 9d5403b1036c ("fs: convert most other
> generic_file_*mmap() users to .mmap_prepare()").
> 
> This is because the .mmap invocation establishes a refcount, but
> .mmap_prepare is called at a point where a merge or an allocation failure
> might happen after the call, which would leak the refcount increment.
> 
> Functionality is being added to permit the use of .mmap_prepare in this
> case, but in the interim, we need to fix this.
> 
> Fixes: 9d5403b1036c ("fs: convert most other generic_file_*mmap() users to .mmap_prepare()")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>

Acked-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>

> ---
>  fs/afs/file.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/afs/file.c b/fs/afs/file.c
> index f609366fd2ac..74d04af51ff4 100644
> --- a/fs/afs/file.c
> +++ b/fs/afs/file.c
> @@ -19,7 +19,7 @@
>  #include <trace/events/netfs.h>
>  #include "internal.h"
>  
> -static int afs_file_mmap_prepare(struct vm_area_desc *desc);
> +static int afs_file_mmap(struct file *file, struct vm_area_struct *vma);
>  
>  static ssize_t afs_file_read_iter(struct kiocb *iocb, struct iov_iter *iter);
>  static ssize_t afs_file_splice_read(struct file *in, loff_t *ppos,
> @@ -35,7 +35,7 @@ const struct file_operations afs_file_operations = {
>  	.llseek		= generic_file_llseek,
>  	.read_iter	= afs_file_read_iter,
>  	.write_iter	= netfs_file_write_iter,
> -	.mmap_prepare	= afs_file_mmap_prepare,
> +	.mmap		= afs_file_mmap,
>  	.splice_read	= afs_file_splice_read,
>  	.splice_write	= iter_file_splice_write,
>  	.fsync		= afs_fsync,
> @@ -492,16 +492,16 @@ static void afs_drop_open_mmap(struct afs_vnode *vnode)
>  /*
>   * Handle setting up a memory mapping on an AFS file.
>   */
> -static int afs_file_mmap_prepare(struct vm_area_desc *desc)
> +static int afs_file_mmap(struct file *file, struct vm_area_struct *vma)
>  {
> -	struct afs_vnode *vnode = AFS_FS_I(file_inode(desc->file));
> +	struct afs_vnode *vnode = AFS_FS_I(file_inode(file));
>  	int ret;
>  
>  	afs_add_open_mmap(vnode);
>  
> -	ret = generic_file_mmap_prepare(desc);
> +	ret = generic_file_mmap(file, vma);
>  	if (ret == 0)
> -		desc->vm_ops = &afs_vm_ops;
> +		vma->vm_ops = &afs_vm_ops;
>  	else
>  		afs_drop_open_mmap(vnode);
>  	return ret;


