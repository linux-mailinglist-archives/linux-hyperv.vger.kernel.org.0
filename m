Return-Path: <linux-hyperv+bounces-9733-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EFa5DR6gwmm3fQQAu9opvQ
	(envelope-from <linux-hyperv+bounces-9733-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 24 Mar 2026 15:30:54 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D11C730A2B5
	for <lists+linux-hyperv@lfdr.de>; Tue, 24 Mar 2026 15:30:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C8EEB30CC5C1
	for <lists+linux-hyperv@lfdr.de>; Tue, 24 Mar 2026 14:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 752643FEB34;
	Tue, 24 Mar 2026 14:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jHLE0f+j"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C0F3FE34B;
	Tue, 24 Mar 2026 14:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774362398; cv=none; b=Uc3mdKLN4zCahXUVz7QBNxcvYVgup2clcAOyc/A8LMHE4KpZEzxNElwlLC6TesN6AkHpLtUulkSbAuQh6jBJ9KdlRy6U5kHcD9LNtf+h7TOTJ06nKDUreoZLXIf9qNX9xhSY7KGijJ9wdKg+gwvxGL9mKJt//N5Uf25kVDN+R7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774362398; c=relaxed/simple;
	bh=jbmeTUiHgD1/BUVa6y6/L4uBWdzAaIyEnuCWg6Aqqwk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FuWFEN7dJWXxy9cMoQNY3TpB9ZzxbguBat3WlCvj80xu4F2ksESfe5mRSnQbqTmACC40r/6+iM2tsLLLURY+OtrD/k+VUq9UTtTM1z5bJfv3xcsxFP1jn74iKCFnmHWUEwwJCyYWf6TMkjwWaqW/UVnSsK9q5BxJJOFRvhJ/gnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jHLE0f+j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF10FC19424;
	Tue, 24 Mar 2026 14:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774362397;
	bh=jbmeTUiHgD1/BUVa6y6/L4uBWdzAaIyEnuCWg6Aqqwk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=jHLE0f+jKQrZNp687YBoBRWvKqV1yWHDJoeSVdPwmNvSWECrmPXDTbAi2oKjk+1NJ
	 qnx4cHZLM+LIL/EoJtJgr2egOHXEYl3PmIEgTgWfctCXapgNTUzCU72gmELiYyBz2u
	 Bmagz4Dqlv/xXZnYGIqOcn/VE+9HcIDQca+kSTZwU2EdFdYDcSCQi3OsySsDqMWMEj
	 xJBl1+rl8ONOJYI/rFp2Q6/AgAT6Ooo3EbuSldP/+bCHPCgnXfLdZYk7zRnOoBztke
	 5D4hhUKhkSo5DjVR7YkZzeoY/AhHGi4yeVpH65JJi5N0Pl6nFAlDHXYhnAvm2OMXP/
	 QLKTQd8HLcvhQ==
Message-ID: <d5b66671-697f-4a4d-8039-d9c9ac5ad4d7@kernel.org>
Date: Tue, 24 Mar 2026 15:26:28 +0100
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 05/21] mm: switch the rmap lock held option off in
 compat layer
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
 <dda74230d26a1fcd79a3efab61fa4101dd1cac64.1774045440.git.ljs@kernel.org>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
In-Reply-To: <dda74230d26a1fcd79a3efab61fa4101dd1cac64.1774045440.git.ljs@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9733-lists,linux-hyperv=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D11C730A2B5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/20/26 23:39, Lorenzo Stoakes (Oracle) wrote:
> In the mmap_prepare compatibility layer, we don't need to hold the rmap
> lock, as we are being called from an .mmap handler.
> 
> The .mmap_prepare hook, when invoked in the VMA logic, is called prior to
> the VMA being instantiated, but the completion hook is called after the VMA
> is linked into the maple tree, meaning rmap walkers can reach it.
> 
> The mmap hook does not link the VMA into the tree, so this cannot happen.
> 
> Therefore it's safe to simply disable this in the mmap_prepare
> compatibility layer.
> 
> Also update VMA tests code to reflect current compatibility layer state.
> 
> Signed-off-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>

Acked-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>

a typo fix below, Andrew can fix locally?

> ---
>  mm/util.c                       |  6 ++++-
>  tools/testing/vma/include/dup.h | 42 +++++++++++++++++----------------
>  2 files changed, 27 insertions(+), 21 deletions(-)
> 
> diff --git a/mm/util.c b/mm/util.c
> index a2cfa0d77c35..182f0f5cc400 100644
> --- a/mm/util.c
> +++ b/mm/util.c
> @@ -1204,6 +1204,7 @@ int compat_vma_mmap(struct file *file, struct vm_area_struct *vma)
> 
>  		.action.type = MMAP_NOTHING, /* Default */
>  	};
> +	struct mmap_action *action = &desc.action;
>  	int err;
> 
>  	err = vfs_mmap_prepare(file, &desc);
> @@ -1214,8 +1215,11 @@ int compat_vma_mmap(struct file *file, struct vm_area_struct *vma)
>  	if (err)
>  		return err;
> 
> +	/* being invoked from .mmmap means we don't have to enforce this. */

				.mmap

> +	action->hide_from_rmap_until_complete = false;
> +
>  	set_vma_from_desc(vma, &desc);
> -	err = mmap_action_complete(vma, &desc.action);
> +	err = mmap_action_complete(vma, action);
>  	if (err) {
>  		const size_t len = vma_pages(vma) << PAGE_SHIFT;
> 

