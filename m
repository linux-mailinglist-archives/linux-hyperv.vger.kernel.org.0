Return-Path: <linux-hyperv+bounces-9727-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wJMYOSluwmmncwQAu9opvQ
	(envelope-from <linux-hyperv+bounces-9727-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 24 Mar 2026 11:57:45 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id AB77A306DEB
	for <lists+linux-hyperv@lfdr.de>; Tue, 24 Mar 2026 11:57:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C81393046CD2
	for <lists+linux-hyperv@lfdr.de>; Tue, 24 Mar 2026 10:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A107A3E5EC3;
	Tue, 24 Mar 2026 10:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fMEcgbbG"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7806B3DEAC9;
	Tue, 24 Mar 2026 10:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774349751; cv=none; b=B7Z9UVwmDn/dqqJGccA5RsPQnncUptq6TMnA4zBCA1BoZMiR3cucZJDBHRgoYH6b9/jQCMZeYe0EKf3rqkTJDZTIJZQjiSlJMSfSUTPEhUiKr5C0iN5W2GrQNB7UVzj0DuX+YX0aXxFSEnPwrdnMNOIkDLVh4Ghu/n+5pbTAo78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774349751; c=relaxed/simple;
	bh=PKmRQSmpQcoJaB3C8EeGp80u+1D+x7QmhnNQbCSeB8o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VUso9PBHIwKWlpTaQpb2hCvT80JMX/Iyng+s/RmV3DJGG1f2WzlgjdQ97PVx9oILgp6AiLh5QE77ZGE0JdpZimRb6H3BsQ77/8GwGl4Rmk5yllaM8pfFGNM/j+JjHWoZt+a1gzirFCEki9uG3vRnfwTPeWbFFCsm5nEgHGchqsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fMEcgbbG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12D7FC19424;
	Tue, 24 Mar 2026 10:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774349751;
	bh=PKmRQSmpQcoJaB3C8EeGp80u+1D+x7QmhnNQbCSeB8o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=fMEcgbbGgPyzprrfIXmnWzFQVASvL51viSIEUIGq0ULM2FvF4mbfhFjh/HfjosHht
	 cgW+/u9gxB9fYbahyMGnurb7qoARj2GLGX6Ra96W/IHys+NfiTnIL/mImcGXUmlDjh
	 NebVgjLehpGJwqkV4cVX7lDDhnYo58udnTxoI3ZrFyMQMHtl4DswqW26b/zG06s1sO
	 T1KpDuiaLK8G1+W+b214NZfc+rI3YgT9zrIPw8TCw1KOpmEjvUWFSZAmeubTl2MSkT
	 fUye6Vy/rI8+HkSs58CRHJoldtPx4J8kBNNWCqvbMR5Ikppaz5prA9TA7BNpQhgvcl
	 Af6e9o0yrXfiQ==
Message-ID: <a9ac9f4b-9b25-43f3-a2c1-da7157a95ab9@kernel.org>
Date: Tue, 24 Mar 2026 11:55:41 +0100
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 04/21] mm: avoid deadlock when holding rmap on
 mmap_prepare error
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
 <d44248be9da68258b07c2c59d4e73485ee0ca943.1774045440.git.ljs@kernel.org>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
In-Reply-To: <d44248be9da68258b07c2c59d4e73485ee0ca943.1774045440.git.ljs@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9727-lists,linux-hyperv=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AB77A306DEB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/20/26 23:39, Lorenzo Stoakes (Oracle) wrote:
> Commit ac0a3fc9c07d ("mm: add ability to take further action in
> vm_area_desc") added the ability for drivers to instruct mm to take actions
> after the .mmap_prepare callback is complete.
> 
> To make life simpler and safer, this is done before the VMA/mmap write lock
> is dropped but when the VMA is completely established.
> 
> So on error, we simply munmap() the VMA.
> 
> As part of this implementation, unfortunately a horrible hack had to be
> implemented to support some questionable behaviour hugetlb relies upon -
> that is that the file rmap lock is held until the operation is complete.
> 
> The implementation, for convenience, did this in mmap_action_finish() so
> both the VMA and mmap_prepare compatibility layer paths would have this
> correctly handled.
> 
> However, it turns out there is a mistake here - the rmap lock cannot be
> held on munmap, as free_pgtables() -> unlink_file_vma_batch_add() ->
> unlink_file_vma_batch_process() takes the file rmap lock.
> 
> We therefore currently have a deadlock issue that might arise.
> 
> Resolve this by leaving it to callers to handle the unmap.
> 
> The compatibility layer does not support this rmap behaviour, so we simply
> have it unmap on error after calling mmap_action_complete().
> 
> In the VMA implementation, we only perform the unmap after the rmap lock is
> dropped.
> 
> This resolves the issue by ensuring the rmap lock is always dropped when
> the unmap occurs.
> 
> Fixes: ac0a3fc9c07d ("mm: add ability to take further action in vm_area_desc")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>

Acked-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>


