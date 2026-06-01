Return-Path: <linux-hyperv+bounces-11434-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qF/COmXoHWp0fwkAu9opvQ
	(envelope-from <linux-hyperv+bounces-11434-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 01 Jun 2026 22:15:33 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 52067624F78
	for <lists+linux-hyperv@lfdr.de>; Mon, 01 Jun 2026 22:15:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 790F13029E63
	for <lists+linux-hyperv@lfdr.de>; Mon,  1 Jun 2026 20:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49A7D366DB4;
	Mon,  1 Jun 2026 20:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="HJp+sRV7"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 247C22594B9;
	Mon,  1 Jun 2026 20:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780344596; cv=none; b=Wf4AFg3n4F4U35CB5UFQyGOTxtRvZJzX/CIGGw//7/jBxynq2BmiWOzNttii9E2PDb82R7IevZXXRE1xx3IP6Jq84doV8Pv0CJb0zOP3fNG4CJxioFa0iYPoVr5O/+zTN0/zumInyiq67G9VKBEmt2cFUa76u0eppYHMwPi5BrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780344596; c=relaxed/simple;
	bh=7l4BvlJpVf3NkvTVDw8qXMvHqwBVNaAlWk6ZdVwqwEM=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Kac9PGeOcYc7PpagcEbsuEMWgvelGZ5zp9UpeCgYXFK+geLZlzBBYqZtzJOntpUninIz/QMK8Uo2lj5ed85waBRhf2Jb+PwHIvYAkH06LHG/foXf7fulKtFtL1V8ZHJI8ncerqVrnDwa4JNek7HJshSiuZxGs00DUbhd1ixJJoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=HJp+sRV7; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1241)
	id 7E93A20B7166; Mon,  1 Jun 2026 13:09:41 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7E93A20B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1780344581;
	bh=eDXJ86FB/Xnvqi9RF8rrZVf1GrIi8kltJ1EOvKoDwfg=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=HJp+sRV7Z+MPOGir5B+cVGDJgSKPlmbFixBaKBsui3oAaZjlZBs+SpoXYgUhogRkt
	 2V69j+/mhNBX90+hxId+3srtlmItfZ4xvOVH6zQix9CSW4B3cF4dMKO1vETTdCKdTk
	 t0hko/RYjtgxX/S0C1zWqVZwqNlBNpYmi1ctKyps=
Received: from localhost (localhost [127.0.0.1])
	by linux.microsoft.com (Postfix) with ESMTP id 7B665307029C;
	Mon,  1 Jun 2026 13:09:41 -0700 (PDT)
Date: Mon, 1 Jun 2026 13:09:41 -0700 (PDT)
From: Jork Loeser <jloeser@linux.microsoft.com>
To: Mike Rapoport <rppt@kernel.org>
cc: linux-hyperv@vger.kernel.org, linux-mm@kvack.org, 
    kexec@lists.infradead.org, "K. Y. Srinivasan" <kys@microsoft.com>, 
    Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
    Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, 
    Pasha Tatashin <pasha.tatashin@soleen.com>, 
    Pratyush Yadav <pratyush@kernel.org>, Alexander Graf <graf@amazon.com>, 
    Jason Miu <jasonmiu@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
    David Hildenbrand <david@kernel.org>, Muchun Song <muchun.song@linux.dev>, 
    Oscar Salvador <osalvador@suse.de>, Baoquan He <bhe@redhat.com>, 
    Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
    Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
    Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
    "H. Peter Anvin" <hpa@zytor.com>, Kees Cook <kees@kernel.org>, 
    Ran Xiaokai <ran.xiaokai@zte.com.cn>, 
    Justinien Bouron <jbouron@amazon.com>, 
    Sourabh Jain <sourabhjain@linux.ibm.com>, Pingfan Liu <piliu@redhat.com>, 
    "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
    Mario Limonciello <mario.limonciello@amd.com>, 
    linux-arm-kernel@lists.infradead.org, x86@kernel.org, 
    linux-kernel@vger.kernel.org, Michael Kelley <mhklinux@outlook.com>
Subject: Re: [RFC PATCH 00/20] mshv: enable kexec with Hyper-V donated pages
 and partitions
In-Reply-To: <ahxrc4pTvVU20RTX@kernel.org>
Message-ID: <f9d95fb1-ef3-d4a-19e4-afe7cdde5d1f@linux.microsoft.com>
References: <20260528004204.1484584-1-jloeser@linux.microsoft.com> <ahxrc4pTvVU20RTX@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kvack.org,lists.infradead.org,microsoft.com,kernel.org,soleen.com,amazon.com,google.com,linux-foundation.org,linux.dev,suse.de,redhat.com,arm.com,alien8.de,linux.intel.com,zytor.com,zte.com.cn,linux.ibm.com,intel.com,amd.com,outlook.com];
	TAGGED_FROM(0.00)[bounces-11434-lists,linux-hyperv=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jloeser@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[36];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 52067624F78
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On Sun, 31 May 2026, Mike Rapoport wrote:

> Hi Jork,

>>  - A freeze mechanism to lock the tree before serializing for kexec
>>    (patch 13).
>
> There were a lot of effort to make KHO stateless and drop the requirement
> for finalization/freeze.
>
> Why is this necessary to add a freeze mechanism to kho_radix_tree?
> If it's a hard requirement of mshv maybe the freeze part should be handled
> there?

Good feedback. It's a safety-net so we do not accidentally donate pages 
without being able to track them. Thought it might be a good generic 
feature. Let me keep it in the MSHV driver.

>> Patch 13:      Radix tree freeze and del_key() error reporting
>
> del_key() error reporting sounds like something we'd want to avoid.
> del_key() is called on "freeing" path and during error handling, it would
> be hard if at all possible to deal with errors from del_key().

I hear you. Stating "yeah, it can only really fail if the key isn't there, 
or it's frozen, but not due to other things, so don't bother to check the 
return code if you are sure" is an odd contract. With the freeze-logic 
moving into MSHV, will revert to no-error.

>> Patch 19:      Export kexec_in_progress for modules
>
> Isn't there another way to differentiate kexec reboot?

I could not find one, unfortunately.

> Sincerely yours,
> Mike.

Best,
Jork

