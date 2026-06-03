Return-Path: <linux-hyperv+bounces-11468-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id m/vgJL1jIGoP2gAAu9opvQ
	(envelope-from <linux-hyperv+bounces-11468-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 03 Jun 2026 19:26:21 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2750163A24B
	for <lists+linux-hyperv@lfdr.de>; Wed, 03 Jun 2026 19:26:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.microsoft.com header.s=default header.b=EnMUBUXn;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11468-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11468-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.microsoft.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 968313059A62
	for <lists+linux-hyperv@lfdr.de>; Wed,  3 Jun 2026 17:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48A2B3E5ED7;
	Wed,  3 Jun 2026 17:26:19 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41C223E3C5B;
	Wed,  3 Jun 2026 17:26:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780507579; cv=none; b=ckTN47Y/o5EydLHzjHA/uK2eDvaIcQTJu70UjRQhOThxEYNIzMIiwj2ED5FNsZr4nDX3OokSYD1S07hV/pOQ9MIGWXa9KCE3PVKW7bMXMOmYowZY7jXFSHqDn3Bay6I/s7RWtzFUexaH52S5QqcD0d/LsZ3lqtto8Kk3ELlwxcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780507579; c=relaxed/simple;
	bh=eUGv37BxYmGLfChvLdC2qCJFLIZQQlowPg5kLf6EkaU=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ffcswRaFeEmJEP977mHfHRdzGFiD6fIP1V18nQqeLzulhzbEkZSxg6GmSOuupqT12zdZbUpS1NC1HDHBm8WDrAbaLLpUJ/ytOv7MivqWuvwsNdWKg5eEAniVmT9NobivU/OFhBf+8a4IVDpVbmyzRQdBDU24nn/ZyNlkcbvs1oM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=EnMUBUXn; arc=none smtp.client-ip=13.77.154.182
Received: by linux.microsoft.com (Postfix, from userid 1241)
	id 928E120B7168; Wed,  3 Jun 2026 10:25:58 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 928E120B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1780507558;
	bh=DiMi2AOkr41lLQQ8lkXK5ScVvrndiW+3Zkpi2ThCMg8=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=EnMUBUXndkm6H+8pw74uuRu7AaBF6Y2P5UHSn671EYJ6AHspLIGBAjxTK0YnC63tg
	 a9gWzTZ1uhg3OfJ+IGfN+QTusX0nyLn1rYJxr/vxFjCDx91PproYwVJZZfVSXuq4sc
	 rr0JK382f+sPSDMf6vulEDPlcs/vBEF43JAe1mGA=
Received: from localhost (localhost [127.0.0.1])
	by linux.microsoft.com (Postfix) with ESMTP id 903BE307050F;
	Wed,  3 Jun 2026 10:25:58 -0700 (PDT)
Date: Wed, 3 Jun 2026 10:25:58 -0700 (PDT)
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
In-Reply-To: <ah_z3GV55RY3ZnT-@kernel.org>
Message-ID: <3197c9c9-9e4f-c592-bb7-ac422f89115@linux.microsoft.com>
References: <20260528004204.1484584-1-jloeser@linux.microsoft.com> <ahxrc4pTvVU20RTX@kernel.org> <f9d95fb1-ef3-d4a-19e4-afe7cdde5d1f@linux.microsoft.com> <ah_z3GV55RY3ZnT-@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[36];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11468-lists,linux-hyperv=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:rppt@kernel.org,m:linux-hyperv@vger.kernel.org,m:linux-mm@kvack.org,m:kexec@lists.infradead.org,m:kys@microsoft.com,m:haiyangz@microsoft.com,m:wei.liu@kernel.org,m:decui@microsoft.com,m:longli@microsoft.com,m:pasha.tatashin@soleen.com,m:pratyush@kernel.org,m:graf@amazon.com,m:jasonmiu@google.com,m:akpm@linux-foundation.org,m:david@kernel.org,m:muchun.song@linux.dev,m:osalvador@suse.de,m:bhe@redhat.com,m:catalin.marinas@arm.com,m:will@kernel.org,m:tglx@kernel.org,m:mingo@redhat.com,m:bp@alien8.de,m:dave.hansen@linux.intel.com,m:hpa@zytor.com,m:kees@kernel.org,m:ran.xiaokai@zte.com.cn,m:jbouron@amazon.com,m:sourabhjain@linux.ibm.com,m:piliu@redhat.com,m:rafael.j.wysocki@intel.com,m:mario.limonciello@amd.com,m:linux-arm-kernel@lists.infradead.org,m:x86@kernel.org,m:linux-kernel@vger.kernel.org,m:mhklinux@outlook.com,s:lists@lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER(0.00)[jloeser@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,kvack.org,lists.infradead.org,microsoft.com,kernel.org,soleen.com,amazon.com,google.com,linux-foundation.org,linux.dev,suse.de,redhat.com,arm.com,alien8.de,linux.intel.com,zytor.com,zte.com.cn,linux.ibm.com,intel.com,amd.com,outlook.com];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jloeser@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,linux.microsoft.com:mid,linux.microsoft.com:from_mime,linux.microsoft.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2750163A24B



On Wed, 3 Jun 2026, Mike Rapoport wrote:

> On Mon, Jun 01, 2026 at 01:09:41PM -0700, Jork Loeser wrote:
>> On Sun, 31 May 2026, Mike Rapoport wrote:
>>
>>>> Patch 19:      Export kexec_in_progress for modules
>>>
>>> Isn't there another way to differentiate kexec reboot?
>
> There's that "kexec reboot" string passed as the cmd to the reboot
> notifier.
> Maybe we can make it somehow more well defined API and use it?

A string? Dear my - the compiler won't flag it on an API change then, not 
ideal clearly. What's wrong with exporting kexec_in_progress()?

Best,
Jork

