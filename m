Return-Path: <linux-hyperv+bounces-9765-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UMhTNPbrw2kAvAQAu9opvQ
	(envelope-from <linux-hyperv+bounces-9765-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Mar 2026 15:06:46 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 325A432669C
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Mar 2026 15:06:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C72313193DC1
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Mar 2026 13:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A3A3347512;
	Wed, 25 Mar 2026 13:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ODtAzKp5"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D932C26059D;
	Wed, 25 Mar 2026 13:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774446207; cv=none; b=hzyQUWEYGgqsUyOsWz+mXnGCeBOLqUkPWTxRR6E8FXKVpTfYWQ3OT62w6s0aX3MeZpsV0ZkdvzJ2hOBYiUgwo2hlAyCALyOGLlAFrR6OoY8yQ1xXzHtGFs0xrg6ydV75z66GZeLUugdtGj6MwQC1f1MNU0QhMzc0zjs5Tm4mRvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774446207; c=relaxed/simple;
	bh=qxevTlxq6Ql+gdnUMuEobyzjtUWmEQEM7p+9cyL1w4Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iyVlo3Ud0xUhltiKXyMFHGmRHDprH9mcG2wTLVSK4Smc0eKKLse+Nggo13gdZ3n905g7nbL1ZejenwCFMH7IDF5AiGaphiz1REvDnY+kL7tc+kDNGlWfpA7TTlRA3W3ksn3Sy7CQ6etqmWp53DIwyyQGqdcjdqsE1E3EJBoiHC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ODtAzKp5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A6BBC4CEF7;
	Wed, 25 Mar 2026 13:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774446207;
	bh=qxevTlxq6Ql+gdnUMuEobyzjtUWmEQEM7p+9cyL1w4Y=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ODtAzKp5cU4HDdomvw7sjdSs8IHMAYOOSxEs2h/rRrufXoBx4l+v61cnqidyuTOjR
	 iyslCByJgqr+gYe1bpcw+qjFkLYUy2aJBCrTv7KOx+rg/9hq5C1zQTvm6a8/0OKmDp
	 xXjVE9RyRH1deEzegZ4TCsOnQVxdwZsSvAa9CCFcC5wjmHDMcU8HW+oBbiOik87SmN
	 OLN8n4X7Jmzw1dtixKYNu9Iz2DUe+Au4CZmOQDmiYIkAkcjqZj1Bh791LYOoWgopPm
	 B4loXaMgr7w3ShZ9dyeuoE2TY9qrf2WGjX+ihaHCV+KkYfXDhqdALgObvmO/DiuGm3
	 oZal5k+Xpk1qA==
Message-ID: <bd916c05-504f-4d81-8020-45c5a563a2d8@kernel.org>
Date: Wed, 25 Mar 2026 14:43:17 +0100
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 17/21] mm: allow handling of stacked mmap_prepare hooks
 in more drivers
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
 <24aac3019dd34740e788d169fccbe3c62781e648.1774045440.git.ljs@kernel.org>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
In-Reply-To: <24aac3019dd34740e788d169fccbe3c62781e648.1774045440.git.ljs@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-9765-lists,linux-hyperv=lfdr.de];
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
X-Rspamd-Queue-Id: 325A432669C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/20/26 23:39, Lorenzo Stoakes (Oracle) wrote:
> While the conversion of mmap hooks to mmap_prepare is underway, we will
> encounter situations where mmap hooks need to invoke nested mmap_prepare
> hooks.
> 
> The nesting of mmap hooks is termed 'stacking'.  In order to flexibly
> facilitate the conversion of custom mmap hooks in drivers which stack, we
> must split up the existing __compat_vma_mmap() function into two separate
> functions:
> 
> * compat_set_desc_from_vma() - This allows the setting of a vm_area_desc
>   object's fields to the relevant fields of a VMA.
> 
> * __compat_vma_mmap() - Once an mmap_prepare hook has been executed upon a
>   vm_area_desc object, this function performs any mmap actions specified by
>   the mmap_prepare hook and then invokes its vm_ops->mapped() hook if any
>   were specified.
> 
> In ordinary cases, where a file's f_op->mmap_prepare() hook simply needs
> to be invoked in a stacked mmap() hook, compat_vma_mmap() can be used.
> 
> However some drivers define their own nested hooks, which are invoked in
> turn by another hook.
> 
> A concrete example is vmbus_channel->mmap_ring_buffer(), which is invoked
> in turn by bin_attribute->mmap():
> 
> vmbus_channel->mmap_ring_buffer() has a signature of:
> 
> int (*mmap_ring_buffer)(struct vmbus_channel *channel,
> 			struct vm_area_struct *vma);
> 
> And bin_attribute->mmap() has a signature of:
> 
> 	int (*mmap)(struct file *, struct kobject *,
> 		    const struct bin_attribute *attr,
> 		    struct vm_area_struct *vma);
> 
> And so compat_vma_mmap() cannot be used here for incremental conversion of
> hooks from mmap() to mmap_prepare().
> 
> There are many such instances like this, where conversion to mmap_prepare
> would otherwise cascade to a huge change set due to nesting of this kind.
> 
> The changes in this patch mean we could now instead convert
> vmbus_channel->mmap_ring_buffer() to
> vmbus_channel->mmap_prepare_ring_buffer(), and implement something like:
> 
> 	struct vm_area_desc desc;
> 	int err;
> 
> 	compat_set_desc_from_vma(&desc, file, vma);
> 	err = channel->mmap_prepare_ring_buffer(channel, &desc);
> 	if (err)
> 		return err;
> 
> 	return __compat_vma_mmap(&desc, vma);
> 
> Allowing us to incrementally update this logic, and other logic like it.
> 
> Unfortunately, as part of this change, we need to be able to flexibly
> assign to the VMA descriptor, so have to remove some of the const
> declarations within the structure.
> 
> Also update the VMA tests to reflect the changes.
> 
> Signed-off-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>

Acked-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>



