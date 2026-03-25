Return-Path: <linux-hyperv+bounces-9761-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sD5vEDe6w2nUtgQAu9opvQ
	(envelope-from <linux-hyperv+bounces-9761-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Mar 2026 11:34:31 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A8565323101
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Mar 2026 11:34:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CD89530CA14C
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Mar 2026 10:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3B9E3AA51B;
	Wed, 25 Mar 2026 10:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DZVmn8Ix"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D17539C658;
	Wed, 25 Mar 2026 10:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774434068; cv=none; b=Uvc5j5gr+6PQICu3TPPINBO6PGQA5YmhaR0xL0pJCNPEZnYAGODX70LIqjHrF8kl2kkoeZQBnm+ZfPA7emuo+R05mIanYS4ypsP/q1IFVaGhezD9X/thHk4tommL7NPsxSoy4zgF4pdoy59oEu+n3ryzUhLCEFRQEPFUv9Zll70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774434068; c=relaxed/simple;
	bh=RwCKSiFjpQQG+EZJNqN0KyvxsrmGDZdhVKBOE/Aaduc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sVMfSyBIgTJ+by1hqyico0l837aX41bf6dlppgRxIMFvCnCoX/KdpXAA2KVFRozQKmD5bCLqWJyINK9L/5qSwmXGcP9GXQxlcUy+dLmFJ6qE8stmM1cx0Tgh6jwn7J5dzMUw3bXedY+tDxmWTGcnz+HxlybJxqwUw7tng+i3rUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DZVmn8Ix; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEE9CC4CEF7;
	Wed, 25 Mar 2026 10:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774434068;
	bh=RwCKSiFjpQQG+EZJNqN0KyvxsrmGDZdhVKBOE/Aaduc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=DZVmn8IxFYfhF8HzW7FdXHkwuvW4yhgRak70Foc0vLl1eakxYnHkDHZjUe6OelBMN
	 YrH79MiaqsFIgMBT9jA4780GQHimOe4Cv+sPzqrEw3TuC6LhDvBflKVhc6rP/hCTZ0
	 OkAtwV5P48v9lio9wSNInQxkePOmt3TugwsUQB8vPjl/zhKytLDeu/bDPGr0rtRwKf
	 5Q0Z39eqjOGm4G6rq5+oLonltaHsNJV4rmuGcNpEtABhyQ+gaiGiYGh/lQSeHB2D/D
	 pZ5uYQuilIxryf4YM/itDGepxaKc8ZzRoKiSBNAMWRegHKeDyNslHKiZ/RNKFJ+IKs
	 rWnmdaorTDm+g==
Message-ID: <05d59b49-fa53-413b-a306-feb21594f6a6@kernel.org>
Date: Wed, 25 Mar 2026 11:20:58 +0100
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 14/21] mtdchar: replace deprecated mmap hook with
 mmap_prepare, clean up
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
 <d036855c21962c58ace0eb24ecd6d973d77424fe.1774045440.git.ljs@kernel.org>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
In-Reply-To: <d036855c21962c58ace0eb24ecd6d973d77424fe.1774045440.git.ljs@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9761-lists,linux-hyperv=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nod.at:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A8565323101
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/20/26 23:39, Lorenzo Stoakes (Oracle) wrote:
> Replace the deprecated mmap callback with mmap_prepare.
> 
> Commit f5cf8f07423b ("mtd: Disable mtdchar mmap on MMU systems") commented
> out the CONFIG_MMU part of this function back in 2012, so after ~14 years
> it's probably reasonable to remove this altogether rather than updating
> dead code.
> 
> Acked-by: Richard Weinberger <richard@nod.at>
> Signed-off-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>

Acked-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>

> ---
>  drivers/mtd/mtdchar.c | 21 +++------------------
>  1 file changed, 3 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/mtd/mtdchar.c b/drivers/mtd/mtdchar.c
> index 55a43682c567..bf01e6ac7293 100644
> --- a/drivers/mtd/mtdchar.c
> +++ b/drivers/mtd/mtdchar.c
> @@ -1376,27 +1376,12 @@ static unsigned mtdchar_mmap_capabilities(struct file *file)
>  /*
>   * set up a mapping for shared memory segments
>   */
> -static int mtdchar_mmap(struct file *file, struct vm_area_struct *vma)
> +static int mtdchar_mmap_prepare(struct vm_area_desc *desc)
>  {
>  #ifdef CONFIG_MMU
> -	struct mtd_file_info *mfi = file->private_data;
> -	struct mtd_info *mtd = mfi->mtd;
> -	struct map_info *map = mtd->priv;
> -
> -        /* This is broken because it assumes the MTD device is map-based
> -	   and that mtd->priv is a valid struct map_info.  It should be
> -	   replaced with something that uses the mtd_get_unmapped_area()
> -	   operation properly. */
> -	if (0 /*mtd->type == MTD_RAM || mtd->type == MTD_ROM*/) {
> -#ifdef pgprot_noncached
> -		if (file->f_flags & O_DSYNC || map->phys >= __pa(high_memory))
> -			vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
> -#endif
> -		return vm_iomap_memory(vma, map->phys, map->size);
> -	}
>  	return -ENODEV;
>  #else
> -	return vma->vm_flags & VM_SHARED ? 0 : -EACCES;
> +	return vma_desc_test(desc, VMA_SHARED_BIT) ? 0 : -EACCES;
>  #endif
>  }
>  
> @@ -1411,7 +1396,7 @@ static const struct file_operations mtd_fops = {
>  #endif
>  	.open		= mtdchar_open,
>  	.release	= mtdchar_close,
> -	.mmap		= mtdchar_mmap,
> +	.mmap_prepare	= mtdchar_mmap_prepare,
>  #ifndef CONFIG_MMU
>  	.get_unmapped_area = mtdchar_get_unmapped_area,
>  	.mmap_capabilities = mtdchar_mmap_capabilities,


