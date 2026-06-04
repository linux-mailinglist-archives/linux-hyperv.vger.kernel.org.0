Return-Path: <linux-hyperv+bounces-11488-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Twb/EDlvIWpyGQEAu9opvQ
	(envelope-from <linux-hyperv+bounces-11488-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 04 Jun 2026 14:27:37 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EDA363FD7A
	for <lists+linux-hyperv@lfdr.de>; Thu, 04 Jun 2026 14:27:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=eJT1W+a7;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11488-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11488-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1D8013047421
	for <lists+linux-hyperv@lfdr.de>; Thu,  4 Jun 2026 12:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A5D737106D;
	Thu,  4 Jun 2026 12:17:36 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A233D3EFD24;
	Thu,  4 Jun 2026 12:17:35 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780575456; cv=none; b=mppqJ+/bO8yXytMXPrrNo0nucPxCLHFr/+gfw22YpNasC6IF6JXQggGdf2OVEiy7ZydbRWAnvIGaYdxJmfywUQcvtRd+IxX9hgBD5AfaunU9QAz1INhAtpI/L0ppEEOI+ghMEm+XnLkpU1/ewObjKOvM2TVa90dSQW4YMqief4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780575456; c=relaxed/simple;
	bh=jy9wNXrlbzwxZ9O6GecZWqZOM9Gp0gZ/hrygFvd2E+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LiGLvtqXo9Nk6ToTat433fT1Lyw/cBjb9az3DNZqgEaLn5yUv0TJ2fmExypwEBvly14XHpRwriN9YjbKve+3UmxelJbfkH1K5fCxRvHUctxw3vSVls5E6uWnicaSMLmRz8Ei3U/Ik+0U71kQaeXgL4DBHdJkb3dxoBQI2ke8WaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eJT1W+a7; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F7A51F00893;
	Thu,  4 Jun 2026 12:17:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780575455;
	bh=6tcDaEhePlIudWCcnW0SAhasLmYK5dwxdEw+RSf4P8c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=eJT1W+a7yBFj5f0F08Rf3p+a5QNdyb2ZOlFDLriNmO2DidwrP1SwEKpexjiYGbXtI
	 mrg493otE2WPbKmxOLVcQEDVxAX81TPqkPR+YF4hP2pW2devqPit639cMGJgjtMQU2
	 AG5qUsLs7SRJ21lXhntgVzwUiRdBV+CiXRLXYlK6qyIFJt6HP6BjhjpLKcTCpN1C2j
	 MdccibZC2LGohJqgT2WVSxIER2+5wQcA79GHLyl16IhYbrBbCKfylMKEou3aoGT+1W
	 lAJpv/fbjL+hlGx0tzVtdTaV/qtZTay37HLuxRbIdBk7BuKOR6T5UqLLfSh4toAoP4
	 y4lbtqS/nGtOA==
Date: Thu, 4 Jun 2026 15:17:20 +0300
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
Message-ID: <aiFs0OLJQWtIbJEF@kernel.org>
References: <20260528004204.1484584-1-jloeser@linux.microsoft.com>
 <ahxrc4pTvVU20RTX@kernel.org>
 <f9d95fb1-ef3-d4a-19e4-afe7cdde5d1f@linux.microsoft.com>
 <ah_z3GV55RY3ZnT-@kernel.org>
 <3197c9c9-9e4f-c592-bb7-ac422f89115@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3197c9c9-9e4f-c592-bb7-ac422f89115@linux.microsoft.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11488-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jloeser@linux.microsoft.com,m:linux-hyperv@vger.kernel.org,m:linux-mm@kvack.org,m:kexec@lists.infradead.org,m:kys@microsoft.com,m:haiyangz@microsoft.com,m:wei.liu@kernel.org,m:decui@microsoft.com,m:longli@microsoft.com,m:pasha.tatashin@soleen.com,m:pratyush@kernel.org,m:graf@amazon.com,m:jasonmiu@google.com,m:akpm@linux-foundation.org,m:david@kernel.org,m:muchun.song@linux.dev,m:osalvador@suse.de,m:bhe@redhat.com,m:catalin.marinas@arm.com,m:will@kernel.org,m:tglx@kernel.org,m:mingo@redhat.com,m:bp@alien8.de,m:dave.hansen@linux.intel.com,m:hpa@zytor.com,m:kees@kernel.org,m:ran.xiaokai@zte.com.cn,m:jbouron@amazon.com,m:sourabhjain@linux.ibm.com,m:piliu@redhat.com,m:rafael.j.wysocki@intel.com,m:mario.limonciello@amd.com,m:linux-arm-kernel@lists.infradead.org,m:x86@kernel.org,m:linux-kernel@vger.kernel.org,m:mhklinux@outlook.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[rppt@kernel.org,linux-hyperv@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,kvack.org,lists.infradead.org,microsoft.com,kernel.org,soleen.com,amazon.com,google.com,linux-foundation.org,linux.dev,suse.de,redhat.com,arm.com,alien8.de,linux.intel.com,zytor.com,zte.com.cn,linux.ibm.com,intel.com,amd.com,outlook.com];
	RCPT_COUNT_TWELVE(0.00)[36];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rppt@kernel.org,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8EDA363FD7A

On Wed, Jun 03, 2026 at 10:25:58AM -0700, Jork Loeser wrote:
> 
> 
> On Wed, 3 Jun 2026, Mike Rapoport wrote:
> 
> > On Mon, Jun 01, 2026 at 01:09:41PM -0700, Jork Loeser wrote:
> > > On Sun, 31 May 2026, Mike Rapoport wrote:
> > > 
> > > > > Patch 19:      Export kexec_in_progress for modules
> > > > 
> > > > Isn't there another way to differentiate kexec reboot?
> > 
> > There's that "kexec reboot" string passed as the cmd to the reboot
> > notifier.
> > Maybe we can make it somehow more well defined API and use it?
> 
> A string? Dear my - the compiler won't flag it on an API change then, not
> ideal clearly. What's wrong with exporting kexec_in_progress()?

The policy in general is avoid exports unless strictly necessary.
A string can be declared as const char *KEXEC_REBOOT = "kexec reboot" and
used in both kexec and mshv. Not ideal, but still better.

No strong feelings from my side, just EXPORT_SYMBOL there felt a bit off.
 
> Best,
> Jork

-- 
Sincerely yours,
Mike.

