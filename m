Return-Path: <linux-hyperv+bounces-9634-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aB1gM3aCvWk4+gIAu9opvQ
	(envelope-from <linux-hyperv+bounces-9634-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 20 Mar 2026 18:23:02 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A69E2DE8A4
	for <lists+linux-hyperv@lfdr.de>; Fri, 20 Mar 2026 18:23:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8BA223097BFB
	for <lists+linux-hyperv@lfdr.de>; Fri, 20 Mar 2026 17:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CCC43CD8DD;
	Fri, 20 Mar 2026 17:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bXKnbe/Z"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E12B03CF66D;
	Fri, 20 Mar 2026 17:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774026625; cv=none; b=FpOYb1rdRbgqcbH5eD6O7a0o/UWmWdgU0RDuxxs61WvT7rJS6VHzcWRKPDa797gca8aAH+ylX5BOWHBO/LzEAAYcU88HRMxgiNnUnGL1Omwg98Y/5bZwwlCn2ZkOucTXV2pcTAOpcl5YxXKceZn6BiapgQ2MQwX/LTnLVKPnlzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774026625; c=relaxed/simple;
	bh=r+p0YZoMVI7AcM9fsFhpiDTl7RR8STO6srhIbYMdrEs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FuOVgvRfyrpQDCfRxlJCkGvyPM0XM5v5tOOI6sbEkS0AcEgyH51QHC49D+gVkFiNnJsZW5kKrykgNjfNqCTVDZBdbGFh26yG1clMD1GR3VHjhRPRTnHn38H1i2vDKy8mixVObQbT9m1wsd4r1mSvQXVOtbsylJy/A2+EjfT2eA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bXKnbe/Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 920B9C19425;
	Fri, 20 Mar 2026 17:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774026624;
	bh=r+p0YZoMVI7AcM9fsFhpiDTl7RR8STO6srhIbYMdrEs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=bXKnbe/ZTMZYKmKswyp7UUNW73CC8ocNdqBGJpBjO2IEcg9klGYzKBTbn7wS6145o
	 bDx6yp6E9EoRlfZ1nChN/6xzDyc02EPnVKbzAT5MkJBM1x9r0U7ISiFB9ZK42TeeEV
	 NPQS0N+PInTeLONogYKmUybb5i5U5KXxX1g3XFI6v4Zk+gmrInpHhro/V78ZwgDZBl
	 PDIKv//vs1fkzlQQJXNTgc0NCf5mfA5lg8S5iRTjU72SybGYa8zUxK1T+5C/DsgByO
	 n+gWOBmyWdE+bwHdB8VdEbJ4rsjPU2AaNHeRHUcpRTiT8ZcyJgwkIBZUDTaCXbxgBy
	 oLeo5Gj5w1IGw==
Message-ID: <e3ecf76a-4490-415d-9d52-dae478ad43d7@kernel.org>
Date: Fri, 20 Mar 2026 18:10:14 +0100
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/16] mm: various small mmap_prepare cleanups
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
References: <cover.1773944114.git.ljs@kernel.org>
 <498a579bfbcbb8b0e4a9c39243b4454347f03a46.1773944114.git.ljs@kernel.org>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
In-Reply-To: <498a579bfbcbb8b0e4a9c39243b4454347f03a46.1773944114.git.ljs@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-9634-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lwn.net,ladisch.de,arndb.de,linuxfoundation.org,microsoft.com,kernel.org,linux.intel.com,gmail.com,foss.st.com,bootlin.com,nod.at,ti.com,oracle.com,redhat.com,auristor.com,zeniv.linux.org.uk,suse.cz,google.com,suse.com,suse.de,vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org,lists.linux.dev,kvack.org,arm.com];
	RCPT_COUNT_TWELVE(0.00)[44];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.994];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vbabka@kernel.org,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5A69E2DE8A4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/19/26 19:23, Lorenzo Stoakes (Oracle) wrote:
> Rather than passing arbitrary fields, pass a vm_area_desc pointer to mmap
> prepare functions to mmap prepare, and an action and vma pointer to mmap
> complete in order to put all the action-specific logic in the function
> actually doing the work.
> 
> Additionally, allow mmap prepare functions to return an error so we can
> error out as soon as possible if there is something logically incorrect in
> the input.
> 
> Update remap_pfn_range_prepare() to properly check the input range for the
> CoW case.
> 
> Also remove io_remap_pfn_range_complete(), as we can simply set up the
> fields correctly in io_remap_pfn_range_prepare() and use
> remap_pfn_range_complete() for this.
> 
> While we're here, make remap_pfn_range_prepare_vma() a little neater, and
> pass mmap_action directly to call_action_complete().
> 
> Then, update compat_vma_mmap() to perform its logic directly, as
> __compat_vma_map() is not used by anything so we don't need to export it.
> 
> Also update compat_vma_mmap() to use vfs_mmap_prepare() rather than
> calling the mmap_prepare op directly.
> 
> Finally, update the VMA userland tests to reflect the changes.
> 
> Signed-off-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>

Acked-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>


