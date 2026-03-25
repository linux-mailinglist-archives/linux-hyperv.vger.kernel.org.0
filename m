Return-Path: <linux-hyperv+bounces-9758-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OEf7NNu1w2litgQAu9opvQ
	(envelope-from <linux-hyperv+bounces-9758-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Mar 2026 11:15:55 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 53884322B96
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Mar 2026 11:15:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 69F4B3020E9D
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Mar 2026 10:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D2063AB27F;
	Wed, 25 Mar 2026 10:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Avb9roEt"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE65F3AA1BF;
	Wed, 25 Mar 2026 10:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774433697; cv=none; b=o5apAeHR7YKfUocrPzYQ7VHIixO/YWhOiRSVuM/TN6L0+VckjutvrphdcmxRFvid3H1ZOv/EPChG/7fwCjwW8JCXuq4qcLnnGNIzb5MA+RZ/0kQyZ/xWEoB9T8yeMyFmTTuztCCpJ/peJF60v0kxR9FI2z8TN5gBXgIhlhv5XO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774433697; c=relaxed/simple;
	bh=mWCjyaxKu+x+LzWRgLuhujGHLbxlc3MmkD51VDioSIg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K0XEKwE5o9XcXqXLlYhBltaj+tNwvPDI28fzhDGrM/owzs/4I7HSNjKyMCaxqiHLjIgm6bcQWbRooepizTFuAPEtqziE+lccJNYKf4MhxOuqK24dsgGhTbu+LJfPuLBmntes58wEjDBAG1f32zz8jGTVkgYXv0VbhUOUJI2nONg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Avb9roEt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 677D8C2BC9E;
	Wed, 25 Mar 2026 10:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774433697;
	bh=mWCjyaxKu+x+LzWRgLuhujGHLbxlc3MmkD51VDioSIg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Avb9roEtz2tZC7EnR8/vBPTkFsUrFyERzOI3tR4QciMupwqnA3DiWXvUrFwz/I8Gi
	 iToXYDmfHcDBl+a0Z9K6rywnep3+HsnmYiTLv00vR8Hb44EItpTuJmrZrkc7RDMuof
	 3qYGqfxEmVJG1qEt1tGMGJ3FjTgRTeD1Xuk38xFFI74ll1XywwHliBcHsOjCiqH0s0
	 Mf1322lzYqLtit9CzSq96FEzvxUS0em6gQP+PC+HiEQ7XGm7P5Ha2K8pVKtSU72lSb
	 eV5gJPu7fOk1RVXaPY3BJekak8hgmqpoh2HE9XIskljcq/LHkXCpoUTbG74tqJfX7S
	 iVt/tb9OUXrLw==
Message-ID: <6fe7f335-2dbd-4d95-9918-702ca9fd10a7@kernel.org>
Date: Wed, 25 Mar 2026 11:14:47 +0100
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 12/21] misc: open-dice: replace deprecated mmap hook
 with mmap_prepare
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
 <5a83ab00195dc8d0609fa6cc525493010ac4ead1.1774045440.git.ljs@kernel.org>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
In-Reply-To: <5a83ab00195dc8d0609fa6cc525493010ac4ead1.1774045440.git.ljs@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-9758-lists,linux-hyperv=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 53884322B96
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/20/26 23:39, Lorenzo Stoakes (Oracle) wrote:
> The f_op->mmap interface is deprecated, so update driver to use its
> successor, mmap_prepare.
> 
> The driver previously used vm_iomap_memory(), so this change replaces it
> with its mmap_prepare equivalent, mmap_action_simple_ioremap().
> 
> Reviewed-by: Suren Baghdasaryan <surenb@google.com>
> Signed-off-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>

Acked-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>

> ---
>  drivers/misc/open-dice.c | 19 +++++++++++--------
>  1 file changed, 11 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/misc/open-dice.c b/drivers/misc/open-dice.c
> index 24c29e0f00ef..45060fb4ea27 100644
> --- a/drivers/misc/open-dice.c
> +++ b/drivers/misc/open-dice.c
> @@ -86,29 +86,32 @@ static ssize_t open_dice_write(struct file *filp, const char __user *ptr,
>  /*
>   * Creates a mapping of the reserved memory region in user address space.
>   */
> -static int open_dice_mmap(struct file *filp, struct vm_area_struct *vma)
> +static int open_dice_mmap_prepare(struct vm_area_desc *desc)
>  {
> +	struct file *filp = desc->file;
>  	struct open_dice_drvdata *drvdata = to_open_dice_drvdata(filp);
>  
> -	if (vma->vm_flags & VM_MAYSHARE) {
> +	if (vma_desc_test(desc, VMA_MAYSHARE_BIT)) {
>  		/* Do not allow userspace to modify the underlying data. */
> -		if (vma->vm_flags & VM_WRITE)
> +		if (vma_desc_test(desc, VMA_WRITE_BIT))
>  			return -EPERM;
>  		/* Ensure userspace cannot acquire VM_WRITE later. */
> -		vm_flags_clear(vma, VM_MAYWRITE);
> +		vma_desc_clear_flags(desc, VMA_MAYWRITE_BIT);
>  	}
>  
>  	/* Create write-combine mapping so all clients observe a wipe. */
> -	vma->vm_page_prot = pgprot_writecombine(vma->vm_page_prot);
> -	vm_flags_set(vma, VM_DONTCOPY | VM_DONTDUMP);
> -	return vm_iomap_memory(vma, drvdata->rmem->base, drvdata->rmem->size);
> +	desc->page_prot = pgprot_writecombine(desc->page_prot);
> +	vma_desc_set_flags(desc, VMA_DONTCOPY_BIT, VMA_DONTDUMP_BIT);
> +	mmap_action_simple_ioremap(desc, drvdata->rmem->base,
> +				   drvdata->rmem->size);
> +	return 0;
>  }
>  
>  static const struct file_operations open_dice_fops = {
>  	.owner = THIS_MODULE,
>  	.read = open_dice_read,
>  	.write = open_dice_write,
> -	.mmap = open_dice_mmap,
> +	.mmap_prepare = open_dice_mmap_prepare,
>  };
>  
>  static int __init open_dice_probe(struct platform_device *pdev)


