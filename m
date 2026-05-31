Return-Path: <linux-hyperv+bounces-11416-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WHHAKohrHGoSNwkAu9opvQ
	(envelope-from <linux-hyperv+bounces-11416-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Sun, 31 May 2026 19:10:32 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 496196174B0
	for <lists+linux-hyperv@lfdr.de>; Sun, 31 May 2026 19:10:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F2C9B3015718
	for <lists+linux-hyperv@lfdr.de>; Sun, 31 May 2026 17:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 905683911CD;
	Sun, 31 May 2026 17:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cd5xFtLc"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 814DB233722;
	Sun, 31 May 2026 17:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780247427; cv=none; b=BQ8GJxj4ezkVuCShsOT6IxL8VDxhPtmiAX7piwiNFmScOkCrAZ+WKeX+MO+6BX7h7440gPNi4gf/ggPwgU6lAmRDBYjcM9c++P3ws0xVwOGlGOQ3oD/k9Q275AbkDmuUaAzT787C66Ics4+cJAgBHp5mt9x8Ncy0+1gxXaJEzsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780247427; c=relaxed/simple;
	bh=7s+Z1GjBiJnzLS3yQ/OP+PEtPzvXo5vnALcX9NwWwEo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RWaiZy3vr9di0Kfbk6mkCXlUDI5hquiaXbtekhj/42H8B7NqVfjOUFsPmd29hc6A0wcl6wBoXK37diTxud9mnoHzkewiIH86waj571SRcBEO/id4UVJLfQ9/HWyts649vQLewyX3mN2QFkrxkvA5LQVuUndOmzqeDp2IWz7OqWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cd5xFtLc; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34B131F00893;
	Sun, 31 May 2026 17:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780247426;
	bh=WLye1OeGSvGfRb8KDc6cQsEQJDuu8/tX64BsRlEPQ/8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cd5xFtLc8CgSUAo5VbGm+pKIlSN5dodN7UW+f0GhB53myIoxNH6p+dDCuSowwLt1M
	 tn6pbkJrs6TvruipRFHl17aKPzkzwwClUW3OCw2kaVqtuO8SCeKbwrz+glC8UeZEHr
	 GtexD/nJZv5cqchIGk9LPD0u7HqxLjrc8lVMZ8tUA9w35qyh8ltsFucDy0MxNZ9tZU
	 d2U6RyTtMK1CdN+Cj8hhy00WNDZZe6O2rSmmW7KgtJNLz+pYi9BC6RF5u4rlYqXqdK
	 OLXNC8wRdf5z8eAJSKbI+sKv+ylMD/5luOBySRgN6a7aVGyuVCVVx7szWKIZv4EWX4
	 cUVPlWHqBfd5Q==
Date: Sun, 31 May 2026 20:10:11 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Jork Loeser <jloeser@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, linux-mm@kvack.org,
	kexec@lists.infradead.org, "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Alexander Graf <graf@amazon.com>, Jason Miu <jasonmiu@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>, Baoquan He <bhe@redhat.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Kees Cook <kees@kernel.org>,
	Ran Xiaokai <ran.xiaokai@zte.com.cn>,
	Justinien Bouron <jbouron@amazon.com>,
	Sourabh Jain <sourabhjain@linux.ibm.com>,
	Pingfan Liu <piliu@redhat.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	linux-arm-kernel@lists.infradead.org, x86@kernel.org,
	linux-kernel@vger.kernel.org, Michael Kelley <mhklinux@outlook.com>
Subject: Re: [RFC PATCH 00/20] mshv: enable kexec with Hyper-V donated pages
 and partitions
Message-ID: <ahxrc4pTvVU20RTX@kernel.org>
References: <20260528004204.1484584-1-jloeser@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260528004204.1484584-1-jloeser@linux.microsoft.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kvack.org,lists.infradead.org,microsoft.com,kernel.org,soleen.com,amazon.com,google.com,linux-foundation.org,linux.dev,suse.de,redhat.com,arm.com,alien8.de,linux.intel.com,zytor.com,zte.com.cn,linux.ibm.com,intel.com,amd.com,outlook.com];
	TAGGED_FROM(0.00)[bounces-11416-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[36];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rppt@kernel.org,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 496196174B0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Jork,

Only had time to skim through the patches.
I have a couple of high level questions for now.

On Wed, May 27, 2026 at 05:41:42PM -0700, Jork Loeser wrote:
> When Linux runs as an L1 Virtual Host (L1VH) under Hyper-V, the MSHV
> root partition driver deposits pages to the hypervisor and creates
> partitions for guest VMs. Prior patches enabled kexec for L1VH, but
> only when no partitions had been created and no memory had been donated.
> 
> This series lifts that limitation. It uses KHO (Kexec Handover) to:
> 
>  - Track all pages deposited to the hypervisor in a KHO radix tree
>    and preserve them across kexec so the new kernel knows which pages
>    are owned by the hypervisor.
> 
>  - Freeze running partitions before kexec, record their IDs in the
>    KHO FDT, and vacuum (tear down + reclaim memory) stale partitions
>    after kexec.
> 
>  - In case of a crash, exclude hypervisor-owned pages from crash
>    dump collection by passing the radix tree root PA via Hyper-V
>    crash MSR P2 to the crash kernel.
> 
> Dependency on Pratyush's KHO series
> ===================================
> 
> Patches 1-12 are cherry-picked from Pratyush Yadav's v1 series
> "kho: make boot time huge page allocation work nicely with KHO" [1],
> which is still under discussion. This series uses functionality from
> those patches -- specifically the meta-data page enumeration via table
> callbacks and the restructured radix tree API. It also extends the
> KHO radix tree with:
> 
>  - A freeze mechanism to lock the tree before serializing for kexec
>    (patch 13).

There were a lot of effort to make KHO stateless and drop the requirement
for finalization/freeze.

Why is this necessary to add a freeze mechanism to kho_radix_tree?
If it's a hard requirement of mshv maybe the freeze part should be handled
there?
 
>  - A crash-kernel-safe variant that memremaps radix nodes for use
>    outside the direct map (patch 14).
> 
> Patch overview
> ==============
> 
> Patches 1-12:  KHO radix tree and memblock changes (from [1])
> Patch 13:      Radix tree freeze and del_key() error reporting

del_key() error reporting sounds like something we'd want to avoid.
del_key() is called on "freeing" path and during error handling, it would
be hard if at all possible to deal with errors from del_key().

> Patch 14:      Crash-kernel-safe radix tree presence check
> Patch 15:      Page tracker using KHO radix tree for deposited pages
> Patch 16:      Debugfs interface for page tracker
> Patches 17-18: Crash MSR reshuffling + crash dump page exclusion
> Patch 19:      Export kexec_in_progress for modules

Isn't there another way to differentiate kexec reboot?

> Patch 20:      Freeze and vacuum partitions across kexec
> 
> Feedback
> ========
> 
> This is an RFC. I am looking for feedback on the overall approach as
> well as the KHO changes (patches 13-14).
> 
> [1] https://lore.kernel.org/linux-mm/20260429133928.850721-1-pratyush@kernel.org/
> 
> Based-on: linux-next/master (next-20260527)

-- 
Sincerely yours,
Mike.

