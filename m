Return-Path: <linux-hyperv+bounces-10712-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wGXNKrK0/WkXhwAAu9opvQ
	(envelope-from <linux-hyperv+bounces-10712-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 08 May 2026 12:02:26 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 28D6B4F4AED
	for <lists+linux-hyperv@lfdr.de>; Fri, 08 May 2026 12:02:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 17C7C305933B
	for <lists+linux-hyperv@lfdr.de>; Fri,  8 May 2026 09:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9576C372B23;
	Fri,  8 May 2026 09:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="QJ6oUHjr"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2879137AA64;
	Fri,  8 May 2026 09:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778234198; cv=none; b=hemu/mGTmBcViJKIAuhWdO4yyAza7x5A5BMFpTXt4ZJYDpE3l5goV8t4MD7iglsGSw1Vlvg4E/pb434msujLly+UAqXhRAWPJwqW+HaNgJFYGYqkYW9Q33VLhNtdJJi0OHfG3ZqMSUZfNOW7l9A8g0UOtO1QjOYD+bHaJ1759t8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778234198; c=relaxed/simple;
	bh=z9LhCQzOuAxYHri2c/oHKYfbfIg7XXcgg6EJ75szlmE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X11wenBXlXIJIf2+/Rc25jztJkGKF+B0tTFttDzFBQUap9uFeXreYUT+D6DuoxUzI9aAofgxq1bCi8YmshWAUZdd9Tzi60SdHoY1AkfrBW2pHZY8B3GzqrmcRbA9fdrJmUHsnWwcivoRDnSiWgP5sJug3tOq2avZBPCmIb+sGJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=QJ6oUHjr; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.79.201.50] (unknown [4.194.122.136])
	by linux.microsoft.com (Postfix) with ESMTPSA id 6CF7820B7165;
	Fri,  8 May 2026 02:56:17 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6CF7820B7165
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1778234192;
	bh=n1jCOVqxUTmwpgXP8ny02/M4Ut73nTiReI4y3CRTH+c=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=QJ6oUHjrogYVM+kjRGk/5FN3Kaqyj4GlCgXNgUf9P0S+nw1wg2ye/8oHu64jq8lPQ
	 CMOhwNPm/6iMwgQU/93VXi34h8th9BR0Xss2y1PX6XpYNudLxhI968GRgCveOmj6Wd
	 6uOeIJ3fQL1Hw1yrrCTaANeT8bv9dpGVG/B1oA8k=
Message-ID: <3415fe72-0572-429c-aeff-a078dab5a930@linux.microsoft.com>
Date: Fri, 8 May 2026 15:26:14 +0530
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/15] arm64: hyperv: Add support for
 mshv_vtl_return_call
To: Marc Zyngier <maz@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
 "K . Y . Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
 Arnd Bergmann <arnd@arndb.de>, Paul Walmsley <pjw@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>, Michael Kelley <mhklinux@outlook.com>,
 Timothy Hayes <timothy.hayes@arm.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Sascha Bischoff <sascha.bischoff@arm.com>,
 mrigendrachaubey <mrigendra.chaubey@gmail.com>,
 linux-hyperv@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-riscv@lists.infradead.org, vdso@mailbox.org,
 ssengar@linux.microsoft.com
References: <20260423124206.2410879-1-namjain@linux.microsoft.com>
 <20260423124206.2410879-8-namjain@linux.microsoft.com>
 <aeolHwXHFH4AnX_n@J2N7QTR9R3.cambridge.arm.com>
 <f4059f5d-a82b-40c2-942e-3e24cefab94f@linux.microsoft.com>
 <86mryaxng3.wl-maz@kernel.org>
Content-Language: en-US
From: Naman Jain <namjain@linux.microsoft.com>
In-Reply-To: <86mryaxng3.wl-maz@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 28D6B4F4AED
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10712-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[arm.com,microsoft.com,kernel.org,redhat.com,alien8.de,linux.intel.com,zytor.com,arndb.de,dabbelt.com,eecs.berkeley.edu,ghiti.fr,outlook.com,gmail.com,vger.kernel.org,lists.infradead.org,mailbox.org,linux.microsoft.com];
	RCPT_COUNT_TWELVE(0.00)[32];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[namjain@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.microsoft.com:mid,linux.microsoft.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action



On 5/8/2026 2:55 PM, Marc Zyngier wrote:
> On Wed, 29 Apr 2026 10:56:11 +0100,
> Naman Jain <namjain@linux.microsoft.com> wrote:
>>
> 
> [...]
> 
>> Merging threads for addressing comments from Mark Rutland and Marc
>> Zyngier on this patch.
>>
>> Thanks for reviewing the changes. Please allow me to briefly explain
>> the use case here and then address your comments.
>>
>> Hyper-V's Virtual Trust Levels (VTLs) provide hardware-enforced
>> isolation within a single VM, analogous to ARM TrustZone. The kernel
>> runs in VTL2 (higher privilege) as a "paravisor", a security monitor
>> that handles intercepts for the primary OS in VTL0 (lower
>> privilege). The VTL switch (mshv_vtl_return_call) is functionally
>> equivalent to KVM's guest enter/exit. It saves VTL2 state, loads
>> VTL0's GPRs other registers from a shared context structure, issues
>> hvc #3 to let VTL0 run, and on return saves VTL0's updated state back.
> 
> No, this is fundamentally different. KVM is purely architectural,
> doesn't try to "sanitise" anything, and context switches *all* of the
> guest state. No ifs, no buts, no "reserved registers".
> 
> [...]

Acked.

> 
>> Regarding Non-SMCCC "hvc #3" call, I have a limitation here owing to
>> the ABI that is defined by the Hyper-V hypervisor. Fixing this
>> requires a hypervisor-side change to support SMCCC-style dispatch for
>> VTL return. Until then, hvc #3 is the only working interface. Moreover
>> there would be backward compatibility issues with this new ABI
>> interface, if at all it is added.
> 
> Left hand, please talk to right hand. This is not the first time we
> push back on this, and we already had this annoying discussion back
> when arm64 as a Hyper-V guest was first proposed (6, 7 years ago?).
> 
> What has changed since? Absolutely nothing.
> 
> If the Hyper-V folks decide to ignore the standard and go their own
> way, that's fine. They only get to keep the pieces.
> 
> Thanks,
> 
> 	M.
> 

Thanks for the feedback. I understand your and Mark’s concerns with this 
approach now, and I’ve initiated internal discussions with the team to 
explore potential solutions.

Regards,
Naman

