Return-Path: <linux-hyperv+bounces-9737-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EJ2FLM2xwmmRkwQAu9opvQ
	(envelope-from <linux-hyperv+bounces-9737-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 24 Mar 2026 16:46:21 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E1F3E318542
	for <lists+linux-hyperv@lfdr.de>; Tue, 24 Mar 2026 16:46:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8E8563023D5E
	for <lists+linux-hyperv@lfdr.de>; Tue, 24 Mar 2026 15:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65E8E390CAA;
	Tue, 24 Mar 2026 15:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A8CdR1TD"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F0438AC90;
	Tue, 24 Mar 2026 15:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774366348; cv=none; b=grV/dUaA/CixhdCqAuJglIzwf/GU3jNISvGlSrhW7HO3OVO09U8d8uyMsZ4svkpqE3mQi/lp6lOSEQn0wrXiArq0tnDJ1Vd+loHUpNmb286l2cr9r4eO3I53JQhPrdUiYnXNUZCT9YrsJTiNBUaQwktRCFjgPg6x3VmgfqDiU7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774366348; c=relaxed/simple;
	bh=Pj+OtiBpuBF7IoC42Kw/vtLSB42CPkuKUZUpsmZAtF8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JQ8HAgoisIhTyxZX6WPGP1AfGRfPar7Z4QzJWHkKg5/oJjsJvPJ8iDhrhUZRRiS+kbvOzE1JMq882IbpUisPdyySInvH+eT/kTqhCY7kS8Mw0auVYHLNYZqv/+2OnJK1dg5gLlPGH7pBpN7T/HJLXDpAG7RU7A63SJZfXU1HWfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A8CdR1TD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5E0FC19424;
	Tue, 24 Mar 2026 15:32:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774366348;
	bh=Pj+OtiBpuBF7IoC42Kw/vtLSB42CPkuKUZUpsmZAtF8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=A8CdR1TDIvUqf/UIBWs17Nn4y+ea/fY6CzTak5aX12J4D+twwLfy+SwnX5lrhff4D
	 CUzBvNr9gv4/0D50Bsuh5GstOCFIQ7l1/YDJTViyrQcTcXkjPsV2NcEd1kTpkceCXt
	 qvmlEfeNjP0yn00Q1AmSFrv9QGGtJ2oKpyqS2VkQuMlb7xlEpzGPo2Z8H/X24jQkzS
	 /dRZDV1lzwWddAwn65weghGa9oo7qiThUc/kW/BhhH1pEumyxJoYG7WP3BMi6+9/xr
	 Y4kgvnO6kl4rFLyL5hI2Nvbd4V/5vHv9ZNMEpKAQRKpcauDbgPeLzXT7iYy5Aj7+iX
	 gcx1tICooGAPQ==
Message-ID: <ee66e204-4439-482f-a8cc-93de1d332a8d@kernel.org>
Date: Tue, 24 Mar 2026 16:32:17 +0100
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 08/21] mm: add vm_ops->mapped hook
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
 <4c5e98297eb0aae9565c564e1c296a112702f144.1774045440.git.ljs@kernel.org>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
In-Reply-To: <4c5e98297eb0aae9565c564e1c296a112702f144.1774045440.git.ljs@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9737-lists,linux-hyperv=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E1F3E318542
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/20/26 23:39, Lorenzo Stoakes (Oracle) wrote:
> Previously, when a driver needed to do something like establish a
> reference count, it could do so in the mmap hook in the knowledge that the
> mapping would succeed.
> 
> With the introduction of f_op->mmap_prepare this is no longer the case, as
> it is invoked prior to actually establishing the mapping.
> 
> mmap_prepare is not appropriate for this kind of thing as it is called
> before any merge might take place, and after which an error might occur
> meaning resources could be leaked.
> 
> To take this into account, introduce a new vm_ops->mapped callback which
> is invoked when the VMA is first mapped (though notably - not when it is
> merged - which is correct and mirrors existing mmap/open/close behaviour).
> 
> We do better that vm_ops->open() here, as this callback can return an
> error, at which point the VMA will be unmapped.
> 
> Note that vm_ops->mapped() is invoked after any mmap action is complete
> (such as I/O remapping).
> 
> We intentionally do not expose the VMA at this point, exposing only the
> fields that could be used, and an output parameter in case the operation
> needs to update the vma->vm_private_data field.
> 
> In order to deal with stacked filesystems which invoke inner filesystem's
> mmap() invocations, add __compat_vma_mapped() and invoke it on vfs_mmap()
> (via compat_vma_mmap()) to ensure that the mapped callback is handled when
> an mmap() caller invokes a nested filesystem's mmap_prepare() callback.
> 
> Update the mmap_prepare documentation to describe the mapped hook and make
> it clear what its intended use is.
> 
> The vm_ops->mapped() call is handled by the mmap complete logic to ensure
> the same code paths are handled by both the compatibility and VMA layers.
> 
> Additionally, update VMA userland test headers to reflect the change.
> 
> Signed-off-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>

Acked-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>



