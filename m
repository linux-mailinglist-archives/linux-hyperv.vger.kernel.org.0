Return-Path: <linux-hyperv+bounces-11435-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8NCZLGHoHWp0fwkAu9opvQ
	(envelope-from <linux-hyperv+bounces-11435-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 01 Jun 2026 22:15:29 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 31FE4624F62
	for <lists+linux-hyperv@lfdr.de>; Mon, 01 Jun 2026 22:15:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0852730358B5
	for <lists+linux-hyperv@lfdr.de>; Mon,  1 Jun 2026 20:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78F0234E766;
	Mon,  1 Jun 2026 20:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="N4fFVqdp"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 623C73EF640;
	Mon,  1 Jun 2026 20:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780344926; cv=none; b=cysfHEFTXSX5Cx6d3YIh0izoJpVYA4UdJLgeOaQlngIpGJVYB8B1uEQ1ujR0jcAF7pbpDZWRS+EyKfYTVv+O43XfpekuP4SoG+z1pp0zF1evSRrYX3h08K1arVeJgLTmdztleDi3HyzXVyQpduoANkMvrUfHiqFHFZz7o6RSFKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780344926; c=relaxed/simple;
	bh=sV59Ed4w+Eof++O+qs9Z6pjJYEeTLqX3Gwl9c7OaT1U=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=pYz3Py4+PtdwQ8bM0x95kZYTALKcWbgn/Z5lxbm9npOcGdWpUO6yaxTYoVpQAWG6pjmm+TChutfhTRE9gEccAK5PHtdsX5W+Z3cXkPWSHHoYi9Tr2badXVPegder7Z90A5BfNCMT0If3I0u6/VO6xEFckSURRaQ06GCoJACwZaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=N4fFVqdp; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1241)
	id C8C6B20B7167; Mon,  1 Jun 2026 13:15:11 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C8C6B20B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1780344911;
	bh=i8NBTcO9HEOzTK8eQah5j9/dFbH36DIcHsxmT2YF1Qc=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=N4fFVqdpnNKdfAbjqncbFZwC2cL0SqneHkeBwmGFomr8pp0NRNUByLEUbqgl8CJ8N
	 vY6qbZwhRR9MwgL5+zUBwQimuhzzrZM/WE/HOOB8z/Dme678HYaDRiKwCDmVLKYqQV
	 OjG4scG03Yvz67ic0ko8L1MxjUf3zZKekJ1EavqM=
Received: from localhost (localhost [127.0.0.1])
	by linux.microsoft.com (Postfix) with ESMTP id C62FA307029C;
	Mon,  1 Jun 2026 13:15:11 -0700 (PDT)
Date: Mon, 1 Jun 2026 13:15:11 -0700 (PDT)
From: Jork Loeser <jloeser@linux.microsoft.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
cc: Mike Rapoport <rppt@kernel.org>, linux-hyperv@vger.kernel.org, 
    linux-mm@kvack.org, kexec@lists.infradead.org, 
    "K. Y. Srinivasan" <kys@microsoft.com>, 
    Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
    Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, 
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
In-Reply-To: <ah2eBxaBnVs_1j5n@google.com>
Message-ID: <4172d271-21b4-346-924e-406baef179a1@linux.microsoft.com>
References: <20260528004204.1484584-1-jloeser@linux.microsoft.com> <ahxrc4pTvVU20RTX@kernel.org> <ah2eBxaBnVs_1j5n@google.com>
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
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,kvack.org,lists.infradead.org,microsoft.com,amazon.com,google.com,linux-foundation.org,linux.dev,suse.de,redhat.com,arm.com,alien8.de,linux.intel.com,zytor.com,zte.com.cn,linux.ibm.com,intel.com,amd.com,outlook.com];
	TAGGED_FROM(0.00)[bounces-11435-lists,linux-hyperv=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
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
X-Rspamd-Queue-Id: 31FE4624F62
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On Mon, 1 Jun 2026, Pasha Tatashin wrote:

> On 05-31 20:10, Mike Rapoport wrote:

>>>  - A freeze mechanism to lock the tree before serializing for kexec
>>>    (patch 13).
>>
>> There were a lot of effort to make KHO stateless and drop the requirement
>> for finalization/freeze.
>
> Yes, using KHO directly here is incorrect. The state machine is provided
> by LUO, so we should use LUO here. MSHV should provide a file that
> userspace adds to LUO, and all state machine management would be the
> same as for all other clients participating in LU.

The thing is, there is no file handle to rely on. Even once partitions are 
all removed, Hyper-V might hang onto pages (and won't return them even if 
asked). However, these pages very much must be excluded from Linux 
post-kexec, or the system will crash. We cannot rely on UM to ensure 
integrity of memory management.

Contrast that to standard LUO use: If you drop individual file handles, or 
even skip the LUO phase entirely, the worst that will happen is that the 
objects will be gone post-kexec. The MM itself will still be consistent. 
For MSHV & page donation, this is different.

(And yes, partition preservation will very much tie into LUO)

Best,
Jork


