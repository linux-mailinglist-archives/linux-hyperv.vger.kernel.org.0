Return-Path: <linux-hyperv+bounces-9643-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WJTtJRGyvWlBAgMAu9opvQ
	(envelope-from <linux-hyperv+bounces-9643-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 20 Mar 2026 21:46:09 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 41ABE2E0FBC
	for <lists+linux-hyperv@lfdr.de>; Fri, 20 Mar 2026 21:46:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1F71B30825D1
	for <lists+linux-hyperv@lfdr.de>; Fri, 20 Mar 2026 20:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62E5B365A02;
	Fri, 20 Mar 2026 20:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CypuAB31"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A849364922;
	Fri, 20 Mar 2026 20:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774039413; cv=none; b=jQWHjIMmX/2+ufu2XcEeWhgKYp4nMsC22StCgsmXzj9TMdeWXhxjdxyeJBKUijrT5vNRT09LGIPUeTVq7QVyrfPwtGUN3uhGsbah6DWuuk52/tz1K7KKJlKvkOWh3hafXZMoA0EvSPtv4+97235sWPzxkhDzOLPQhWyUtdbqTug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774039413; c=relaxed/simple;
	bh=XzczC32VV00AwDiIh21zb/sCHxyX8rnSOTF7An9uPcg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fYMJ1/r28rCay/BzduHzDeg8/ikxKb5HvAgkBbKGDciHc/ncpjVBDs/TnyOPhOnfT4IUzi17NfSpwt17Mome6Eg+96PtWKVubzytgkEy730thC1F4130qJyX3BtZ5RKK5ax5cjkguoWgt0IuLA6nB3kyptrqIfdG/dnY88PUsmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CypuAB31; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45D20C2BC87;
	Fri, 20 Mar 2026 20:43:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774039412;
	bh=XzczC32VV00AwDiIh21zb/sCHxyX8rnSOTF7An9uPcg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CypuAB31keYeNpOx6+BKaUkwMJAfZXn2C8u2PsOdPDThy38YXRFbY3/5pqAtP2cro
	 HcRPsPMEoqtBOp0Y89OOq0diEXH+QJUGD4o3QQPB/lSWNd63ck3NFlPYMPPWlX6Xdh
	 NY1MxQ8mtYPuDD9Hbj0TTMRMJ5nHPBd59/x7XDvfNJi+dQOQLqpW3Cc07z0rxBdKVg
	 Zj4xs72z1sb5iNfDp0ESmZJVtFbjrzICMsXM1S8xUE9gwY/R6UUKFhHfPVNUMKzrEc
	 uXQMf3LaWOivk84XWig7hurOoAmqWcKrF5KB1u4nDb4nrI88wQkI0PYARg8sxzO+Xv
	 /gE1kUOfP2KbA==
Date: Fri, 20 Mar 2026 20:43:30 +0000
From: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Jonathan Corbet <corbet@lwn.net>, Clemens Ladisch <clemens@ladisch.de>, 
	Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"K . Y . Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, 
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Miquel Raynal <miquel.raynal@bootlin.com>, 
	Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
	Bodo Stroesser <bostroesser@gmail.com>, "Martin K . Petersen" <martin.petersen@oracle.com>, 
	David Howells <dhowells@redhat.com>, Marc Dionne <marc.dionne@auristor.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	David Hildenbrand <david@kernel.org>, "Liam R . Howlett" <Liam.Howlett@oracle.com>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-hyperv@vger.kernel.org, 
	linux-mtd@lists.infradead.org, linux-staging@lists.linux.dev, linux-scsi@vger.kernel.org, 
	target-devel@vger.kernel.org, linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, Ryan Roberts <ryan.roberts@arm.com>
Subject: Re: [PATCH v3 04/16] mm: add vm_ops->mapped hook
Message-ID: <f711f67a-9c87-4c9c-8ddd-0a78df962942@lucifer.local>
References: <cover.1773944114.git.ljs@kernel.org>
 <a97366fa6f22a0ca1340cfd2b0d4df87c80ac80a.1773944114.git.ljs@kernel.org>
 <c9068fbb-a23c-4342-8638-3b11897a57cb@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c9068fbb-a23c-4342-8638-3b11897a57cb@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-9643-lists,linux-hyperv=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,lwn.net,ladisch.de,arndb.de,linuxfoundation.org,microsoft.com,kernel.org,linux.intel.com,gmail.com,foss.st.com,bootlin.com,nod.at,ti.com,oracle.com,redhat.com,auristor.com,zeniv.linux.org.uk,suse.cz,google.com,suse.com,suse.de,vger.kernel.org,lists.infradead.org,lists.linux.dev,kvack.org,arm.com];
	RCPT_COUNT_TWELVE(0.00)[42];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,lucifer.local:mid]
X-Rspamd-Queue-Id: 41ABE2E0FBC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 20, 2026 at 07:26:37PM +0100, Vlastimil Babka (SUSE) wrote:
> On 3/19/26 19:23, Lorenzo Stoakes (Oracle) wrote:
> > Previously, when a driver needed to do something like establish a
> > reference count, it could do so in the mmap hook in the knowledge that the
> > mapping would succeed.
> >
> > With the introduction of f_op->mmap_prepare this is no longer the case, as
> > it is invoked prior to actually establishing the mapping.
> >
> > mmap_prepare is not appropriate for this kind of thing as it is called
> > before any merge might take place, and after which an error might occur
> > meaning resources could be leaked.
> >
> > To take this into account, introduce a new vm_ops->mapped callback which
> > is invoked when the VMA is first mapped (though notably - not when it is
> > merged - which is correct and mirrors existing mmap/open/close behaviour).
> >
> > We do better that vm_ops->open() here, as this callback can return an
> > error, at which point the VMA will be unmapped.
> >
> > Note that vm_ops->mapped() is invoked after any mmap action is complete
> > (such as I/O remapping).
> >
> > We intentionally do not expose the VMA at this point, exposing only the
> > fields that could be used, and an output parameter in case the operation
> > needs to update the vma->vm_private_data field.
> >
> > In order to deal with stacked filesystems which invoke inner filesystem's
> > mmap() invocations, add __compat_vma_mapped() and invoke it on vfs_mmap()
> > (via compat_vma_mmap()) to ensure that the mapped callback is handled when
> > an mmap() caller invokes a nested filesystem's mmap_prepare() callback.
> >
> > We can now also remove call_action_complete() and invoke
> > mmap_action_complete() directly, as we separate out the rmap lock logic.
> >
> > The rmap lock logic, which was added in order to keep hugetlb working (!)
> > to allow for the rmap lock to be held longer, needs to be propagated to the
> > error paths on mmap complete and mapped hook error paths.
> >
> > This is because do_munmap() might otherwise deadlock with the rmap being
> > held, so instead we unlock at the point of unmap.
>
> Hmm but that was also true prior to this series? So is this a bugfix? Should
> it be a stable hotfix done outside of the series before the refactoring?

Yup, will send a hotfix.

Thanks, Lorenzo

