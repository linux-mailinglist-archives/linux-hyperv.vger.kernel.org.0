Return-Path: <linux-hyperv+bounces-11432-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2KlvDmGgHWq+cgkAu9opvQ
	(envelope-from <linux-hyperv+bounces-11432-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 01 Jun 2026 17:08:17 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 92FEA6215FA
	for <lists+linux-hyperv@lfdr.de>; Mon, 01 Jun 2026 17:08:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 55D593070DE3
	for <lists+linux-hyperv@lfdr.de>; Mon,  1 Jun 2026 15:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E302C3D79E9;
	Mon,  1 Jun 2026 15:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="KU/olbne"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE193D79F0
	for <linux-hyperv@vger.kernel.org>; Mon,  1 Jun 2026 15:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780326063; cv=none; b=Sp8SuOQaS4ITIq+nDk2T1XSmt0IkTNY8pZ2iuSwtTVijsEGXfk70iq4rYDq1fQ94g/Ur2dzEFCaUu5+omVsUuOdypooGTVtYRuTSNEnZ49KtCB6akE79po09Qe/4vqm11NFsRZ1NceNcy+w1ZPWgJkGy4R0tFmMOAdPuO0Gzwdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780326063; c=relaxed/simple;
	bh=LfOPMBN7DRLFaAhGpMubVdqAViYRh+OngIWn62NukYk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d8vhqSSvnuvl8NxFxldqz6IT1uA0h7rPpnMZ0yWK0KrzmUxgRsI1mnUBO4jWbHhDYeoKva7yoJc8fYQrYA8aeFNgb3o8cfYPe3AbBaT7kAKuaRvkIFWdqnsrn/x6bFlyQNVFbrP1cnxxujZ9aq/FCZ46+8DopdsoQ1nv8zlFp3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=KU/olbne; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-7e1916922b9so17561137b3.1
        for <linux-hyperv@vger.kernel.org>; Mon, 01 Jun 2026 08:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1780326061; x=1780930861; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YjouT4r9OqoZMrQ0tTNPIpsZn3OGl8wc9VmtokceP+I=;
        b=KU/olbne0gIwaaS1+6ZLzmOMQrJvHLuEz4lWd2HWW9mFIlCcwKTIH/txANe7lcep2M
         mtpwyZYyxPYSgt+s97m9ixwSnnLs6HSP1cn/hNkggX15dYAeFs3xJcywSibh/OeuFTq4
         Z67z3CaeIC1FKHQcDjQZ2NhtPdRzCKGFT0GokF9fS537o9JOPRuNfbn6XMTNN2rcjOuE
         HTcjgDSMD9i157rTK3GgmUtj4VOAEqzwM52DfVFIOd54ER2TpZ3a4BHWrpXsTW3S3Wm/
         /qGHOcKWFz3gnUqH4MYU9/2gvm+t/xyOQfZ1/5HthLTpWUZ0Fp56DL13A/qh9wLaPhIq
         JHaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780326061; x=1780930861;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YjouT4r9OqoZMrQ0tTNPIpsZn3OGl8wc9VmtokceP+I=;
        b=tXFuzThKqUEN5HXQnfgyymbyzjTjXWM1rQoPYXYi1/GzTSs5SrkJnljmMHa9wpF6dS
         EY4ExbxAmhh8joJo2b4e5jw3CHbUCaBR5avooRoGxsVv00u9A/wJ255tdAFb8McS5xHO
         xlO4eL01c1ju9quVQjTfiTgkacatCV46dDktL3x42hq1zbx1BtA3oTOaxSlikrLF8y/U
         JprMBpyfnXLtQLccOWf0bGipgMYMupxOAB7WX87RqXrCpy6oUybT1uBTIEBZKvR2pBGB
         mO0pYttPUclyxChzM2QGKiFbFv2FITdyEm+G5sSHb/MApaO5P/x6xIP01Rl1WMb0tgvg
         wZzA==
X-Forwarded-Encrypted: i=1; AFNElJ9ucrLfnaUannLblxKz/9I4/mef4AoCt7Bveb2/GFHEbuL1Vdzv+NUFQ4dc73Lofke/q2dT7zu1PGu8aUg=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywa72YmyTd2IBV1BKZmn2AnpBHVxDVxJsXTxIC0Y0O+Nac1+A99
	t+ASNLfDf/HbE3xfwwUI7NQUkH+aC1KOKMs/LMoEEq6HGp6oe03w8w6HbXf4x1qCoLA=
X-Gm-Gg: Acq92OFNzL//5AykC8G3VxMuetIKaUuIxw8u/gwc9T62ZIqY6CXb+ncm1cN7KowrXcW
	6jjf9EfikdnZ4DeM+IjIiO2HSHs+kmVJqHTub9vs8dkIMPUy5wJM/HId0vPorqArwOJr2IqHVu+
	M5y82ncSdpgNEr4B3lD39klx9l9S9bXBsOV9l4AEKnJNaRYc45jGBCFpIwvhnzpcV7KmKzrdL7S
	HpfHiw+IJHRtvh2oa2vE8kqLgAF7ajfBMUjI0zyiw87jb/+xcdJ6NzvcCwRLclbRZfSMOp1vUkG
	uyCWGe8SqF+6R2LQPYoQqN2jHJiHTdMgX0yPwRygEmwGEO+WaNlp5fd8r3FJ3t2ZSh/rkhdfuRW
	rzHfRx+wS64Ai7qSC6lOfobWEnvqS+b+feRGKJayTwOcNcR0h1c/jKs4303n98c5vcrusF+1qg5
	qw6vAYZI2dr5w/EQdTiBPCOQQV5qO7+XvBfUGqRDTmGusldjXPVhxRq+Oa4TCs2pWNpK22zVs1c
	3Nv4Bkvu9mJ6tDrUy1w0w3uekTO4TnLE5I8d0fPUfc+lU0vJAuWMQ==
X-Received: by 2002:a05:690c:88b:b0:7a2:3d38:337c with SMTP id 00721157ae682-7e05d5e4ec2mr97204177b3.32.1780326061363;
        Mon, 01 Jun 2026 08:01:01 -0700 (PDT)
Received: from google.com (138.200.150.34.bc.googleusercontent.com. [34.150.200.138])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7e175de02fdsm41868227b3.7.2026.06.01.08.00.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 08:01:00 -0700 (PDT)
Date: Mon, 1 Jun 2026 11:00:59 -0400
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: Mike Rapoport <rppt@kernel.org>
Cc: Jork Loeser <jloeser@linux.microsoft.com>, 
	linux-hyperv@vger.kernel.org, linux-mm@kvack.org, kexec@lists.infradead.org, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, 
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Alexander Graf <graf@amazon.com>, Jason Miu <jasonmiu@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, 
	Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, Baoquan He <bhe@redhat.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Kees Cook <kees@kernel.org>, 
	Ran Xiaokai <ran.xiaokai@zte.com.cn>, Justinien Bouron <jbouron@amazon.com>, 
	Sourabh Jain <sourabhjain@linux.ibm.com>, Pingfan Liu <piliu@redhat.com>, 
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Mario Limonciello <mario.limonciello@amd.com>, 
	linux-arm-kernel@lists.infradead.org, x86@kernel.org, linux-kernel@vger.kernel.org, 
	Michael Kelley <mhklinux@outlook.com>
Subject: Re: [RFC PATCH 00/20] mshv: enable kexec with Hyper-V donated pages
 and partitions
Message-ID: <ah2eBxaBnVs_1j5n@google.com>
References: <20260528004204.1484584-1-jloeser@linux.microsoft.com>
 <ahxrc4pTvVU20RTX@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ahxrc4pTvVU20RTX@kernel.org>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[soleen.com,reject];
	R_DKIM_ALLOW(-0.20)[soleen.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11432-lists,linux-hyperv=lfdr.de];
	FREEMAIL_CC(0.00)[linux.microsoft.com,vger.kernel.org,kvack.org,lists.infradead.org,microsoft.com,kernel.org,soleen.com,amazon.com,google.com,linux-foundation.org,linux.dev,suse.de,redhat.com,arm.com,alien8.de,linux.intel.com,zytor.com,zte.com.cn,linux.ibm.com,intel.com,amd.com,outlook.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[37];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[soleen.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pasha.tatashin@soleen.com,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,soleen.com:dkim]
X-Rspamd-Queue-Id: 92FEA6215FA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 05-31 20:10, Mike Rapoport wrote:
> Hi Jork,
> 
> Only had time to skim through the patches.
> I have a couple of high level questions for now.
> 
> On Wed, May 27, 2026 at 05:41:42PM -0700, Jork Loeser wrote:
> > When Linux runs as an L1 Virtual Host (L1VH) under Hyper-V, the MSHV
> > root partition driver deposits pages to the hypervisor and creates
> > partitions for guest VMs. Prior patches enabled kexec for L1VH, but
> > only when no partitions had been created and no memory had been donated.
> > 
> > This series lifts that limitation. It uses KHO (Kexec Handover) to:
> > 
> >  - Track all pages deposited to the hypervisor in a KHO radix tree
> >    and preserve them across kexec so the new kernel knows which pages
> >    are owned by the hypervisor.
> > 
> >  - Freeze running partitions before kexec, record their IDs in the
> >    KHO FDT, and vacuum (tear down + reclaim memory) stale partitions
> >    after kexec.
> > 
> >  - In case of a crash, exclude hypervisor-owned pages from crash
> >    dump collection by passing the radix tree root PA via Hyper-V
> >    crash MSR P2 to the crash kernel.
> > 
> > Dependency on Pratyush's KHO series
> > ===================================
> > 
> > Patches 1-12 are cherry-picked from Pratyush Yadav's v1 series
> > "kho: make boot time huge page allocation work nicely with KHO" [1],
> > which is still under discussion. This series uses functionality from
> > those patches -- specifically the meta-data page enumeration via table
> > callbacks and the restructured radix tree API. It also extends the
> > KHO radix tree with:
> > 
> >  - A freeze mechanism to lock the tree before serializing for kexec
> >    (patch 13).
> 
> There were a lot of effort to make KHO stateless and drop the requirement
> for finalization/freeze.

Yes, using KHO directly here is incorrect. The state machine is provided 
by LUO, so we should use LUO here. MSHV should provide a file that 
userspace adds to LUO, and all state machine management would be the 
same as for all other clients participating in LU.

> 
> Why is this necessary to add a freeze mechanism to kho_radix_tree?
> If it's a hard requirement of mshv maybe the freeze part should be handled
> there?
j  
> >  - A crash-kernel-safe variant that memremaps radix nodes for use
> >    outside the direct map (patch 14).
> > 
> > Patch overview
> > ==============
> > 
> > Patches 1-12:  KHO radix tree and memblock changes (from [1])
> > Patch 13:      Radix tree freeze and del_key() error reporting
> 
> del_key() error reporting sounds like something we'd want to avoid.
> del_key() is called on "freeing" path and during error handling, it would
> be hard if at all possible to deal with errors from del_key().
> 
> > Patch 14:      Crash-kernel-safe radix tree presence check
> > Patch 15:      Page tracker using KHO radix tree for deposited pages
> > Patch 16:      Debugfs interface for page tracker
> > Patches 17-18: Crash MSR reshuffling + crash dump page exclusion
> > Patch 19:      Export kexec_in_progress for modules
> 
> Isn't there another way to differentiate kexec reboot?
> 
> > Patch 20:      Freeze and vacuum partitions across kexec
> > 
> > Feedback
> > ========
> > 
> > This is an RFC. I am looking for feedback on the overall approach as
> > well as the KHO changes (patches 13-14).
> > 
> > [1] https://lore.kernel.org/linux-mm/20260429133928.850721-1-pratyush@kernel.org/
> > 
> > Based-on: linux-next/master (next-20260527)
> 
> -- 
> Sincerely yours,
> Mike.

