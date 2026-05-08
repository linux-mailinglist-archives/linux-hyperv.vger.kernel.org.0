Return-Path: <linux-hyperv+bounces-10709-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mKtzAlZn/WlhdQAAu9opvQ
	(envelope-from <linux-hyperv+bounces-10709-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 08 May 2026 06:32:22 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AD014F18C0
	for <lists+linux-hyperv@lfdr.de>; Fri, 08 May 2026 06:32:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CD6C43058B90
	for <lists+linux-hyperv@lfdr.de>; Fri,  8 May 2026 04:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51DDC1DED42;
	Fri,  8 May 2026 04:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="saKSNoO0"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D36F173;
	Fri,  8 May 2026 04:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778214389; cv=none; b=h0eQDSdxlCsQCwvI+GIMAP4Udm8vW5p/yx2/IMLiXYcyCS9rXv1yZulKTHPKxKR78y4W5AL4ZddnUWKFuxPZjDDgP71OElhPD24RMUs9jLtCs7Ieb7aI2Mah8TZ6EqZVNyUJYLjNT0l1xBeegd1y9Uzj3+AyKVQEUBvRETTjgqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778214389; c=relaxed/simple;
	bh=wm94zlSEXpTaUUywPsTEQOOArtPjjt3FiQFadrDKZ8A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wn4ltzrcWmL/QYswh96I3sUBfGTnl/YLbSNoGpquECIu7VW9uR41LqfPBkpI6YGYzPVSMrg5rRGwYgdxpgjv+oZIw5DfgRwbZGmTKY6QBx+VXYSPcPHC3EQ1YTYPA0KeJXGiu0dcwOk6Pc3p2GTfkQnSFZOWCHdZR2b1qT4dwWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=saKSNoO0; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [192.168.0.107] (unknown [49.205.253.198])
	by linux.microsoft.com (Postfix) with ESMTPSA id DE52B20B7165;
	Thu,  7 May 2026 21:26:12 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com DE52B20B7165
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1778214383;
	bh=fZqbznsyO6uH2km9lQYaNTISd52E1x5y5ydr8MxcDaw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=saKSNoO0PcppAv0QSZCXEm1JRqArYoL9lzAhr6mpjz1I5JmqqVCasbTbSgZaIVZiH
	 sUX4ruWHuB2F+A8vGH2rkSjjbLdRPspCsm30BK8qa8CADHIXgVxA2yl9f4W+MudAuW
	 D0jhJ0Rq+J/hcu+QRyXhYoOB0C9nqZfvlttbgl9w=
Message-ID: <4c0a81b2-43b0-43c0-a836-f6f5d9c08d33@linux.microsoft.com>
Date: Fri, 8 May 2026 09:56:11 +0530
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/15] arm64: hyperv: Add support for
 mshv_vtl_return_call
To: Mark Rutland <mark.rutland@arm.com>
Cc: Marc Zyngier <maz@kernel.org>, "K . Y . Srinivasan" <kys@microsoft.com>,
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
 <afrzKl3ixCUUVL6C@J2N7QTR9R3>
Content-Language: en-US
From: Naman Jain <namjain@linux.microsoft.com>
In-Reply-To: <afrzKl3ixCUUVL6C@J2N7QTR9R3>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 5AD014F18C0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10709-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,microsoft.com,arm.com,redhat.com,alien8.de,linux.intel.com,zytor.com,arndb.de,dabbelt.com,eecs.berkeley.edu,ghiti.fr,outlook.com,gmail.com,vger.kernel.org,lists.infradead.org,mailbox.org,linux.microsoft.com];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.microsoft.com:mid,linux.microsoft.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,svcr.sm:url]
X-Rspamd-Action: no action



On 5/6/2026 1:22 PM, Mark Rutland wrote:
> On Wed, Apr 29, 2026 at 03:26:11PM +0530, Naman Jain wrote:
>> On 4/23/2026 7:26 PM, Mark Rutland wrote:
>>> On Thu, Apr 23, 2026 at 12:41:57PM +0000, Naman Jain wrote:
> 
> [ non-SMMC hypercall code omitted for brevity ]
> 
>>> NAK to this.
>>>
>>> * This is a non-SMCCC hypercall, which we have NAK'd in general in the
>>>     past for various reasons that I am not going to rehash here.
>>>
>>> * It's not clear how this is going to be extended with necessary
>>>     architecture state in future (e.g. SVE, SME). This is not
>>>     future-proof, and I don't believe this is maintainable.
>>>
>>> * This breaks general requirements for reliable stacktracing by
>>>     clobbering state (e.g. x29) that we depend upon being valid AT ALL
>>>     TIMES outside of entry code.
>>>
>>> * IMO, if this needs to be saved/restored, that should happen in
>>>     whatever you are calling.
>>>
>>> Mark.
>>
>> Merging threads for addressing comments from Mark Rutland and Marc Zyngier
>> on this patch.
>>
>> Thanks for reviewing the changes. Please allow me to briefly explain the use
>> case here and then address your comments.
>>
>> Hyper-V's Virtual Trust Levels (VTLs) provide hardware-enforced isolation
>> within a single VM, analogous to ARM TrustZone. The kernel runs in VTL2
>> (higher privilege) as a "paravisor", a security monitor that handles
>> intercepts for the primary OS in VTL0 (lower privilege). The VTL switch
>> (mshv_vtl_return_call) is functionally equivalent to KVM's guest enter/exit.
> 
> It's worth noting that for KVM, the KVM hyp code is *tightly* coupled
> with the host kernel (they are one single binary object), and the
> calling convention between the two is an implementation detail that can
> change at any time without any ABI concerns.
> 
> While I appreciate this might be trying to do the same thing from a
> *functional* perspective, it's certainly different from a
> maintainability perspective, and can't be treated in the same way.
> 
>> It saves VTL2 state, loads VTL0's GPRs other registers from a shared context
>> structure, issues hvc #3 to let VTL0 run, and on return saves VTL0's updated
>> state back.
>>
>> Coming to the problems with the code, I have identified a few ways to
>> address them.
>>
>> I can put the assembly code in a separate .S file with
>> SYM_FUNC_START/SYM_FUNC_END and marked as noinstr, to prevent ftrace/kprobes
>> from instrumenting between the GPR load and the hvc, which could have
>> corrupted VTL0 register state. This should solve x29 clobbering, stack
>> tracing problems.
> 
> My point was that you must not clobber those registers.
> 
> Looking at the TLFS document you linked below, it says:
> 
> | Note: X29 (FP/frame pointer), X30 (LR/link register), and SP are private
> | per-VTL
> 
> ... so clobbering those doesn't seem to be necessary anyway. Clearly
> having an arbitrary calling convention is confusing for everyone.
> 
>> I should use kernel_neon_begin()/kernel_neon_end() to save/restore the full
>> extended FP state of the current task in VTL2. VTL0's Q0-Q31 can be
>> loaded/saved separately via fpsimd_load_state()/fpsimd_save_state(). This
>> way, the assembly touches none of the SIMD registers. This is SVE/SME-safe
>> for VTL2's task state. VTL0 still only carries Q0-Q31 in the context struct,
>> and extending to SVE, SME is a future context struct change, which will need
>> Hyper-V arm64 ABI support.
>> This way, VTL2's callee-saved regs (x19-x28, x29, x30) are explicitly saved
>> to the stack frame at the top and restored at the bottom of assembly code.
>> The C caller (in hv_vtl.c) is a clean function call.
> 
> That doesn't really address my concerns here.
> 
> I do not think that Linux should have to save/restore anything here;
> that should be the job of the real hypervisor. The arbitrary separation
> of PE state into private and shared (with shred state being directly
> exposed to Linux) is a problem for maintainability and forward
> compatibility.
> 
> Looking at the TLFS document you linked below, I see:
> 
> | Note: SVE state (Z0-Z31, P0-P15, FFR) and SME state are VTL-private.
> | The lower 128-bit portion (Q registers) is shared, but the upper bits
> | of Z registers may be corrupted on VTL transitions. Software should
> | not rely on Z register contents being preserved across VTL switches.
> 
> ... which is certainly going to be a pain to manage.
> 
> Note in particular "SME state" is not an architectural term. I don't
> know which state in particular that is intended to cover (e.g. ZA, ZT0,
> SVCR, all streaming mode state)?
> 
> There's no mention of SVCR, so I don't know how this is going to
> interact with management of ZA state (ZA and ZT0, which are dependent
> upon SVCR.ZA) or streaming mode (dependent upon SVCR.SM). That state has
> been *incredibly* painful for us to manage generally. Regardless of the
> SMCCC concerns, that needs to be specified better.
> 
>> Regarding Non-SMCCC "hvc #3" call, I have a limitation here owing to the ABI
>> that is defined by the Hyper-V hypervisor. Fixing this requires a
>> hypervisor-side change to support SMCCC-style dispatch for VTL return. Until
>> then, hvc #3 is the only working interface. Moreover there would be backward
>> compatibility issues with this new ABI interface, if at all it is added.
> 
> To be clear, that's Microsoft's problem, not the Linux kernel
> community's problem. My NAK still stands.
> 
> Multiple years ago now, we made it clear that we would not accept a
> non-SMCCC calling convention. Ignoring the substance of that feedback,
> and inventing a new calling convention after that point is a
> self-inflicted problem.
> 
> [...]
> 
>> Link to TLFS: https://learn.microsoft.com/en-us/virtualization/hyper-v-on-windows/tlfs/vsm#on-arm64-platforms-3
> 
> For shared state, aside fomr GPRs and FPSIMD/SVE/SME state, that says:
> 
> | * System Information Registers (read-only or non-security-critical):
> |   * System identification and feature registers
> |   * Cache and TLB type information
> 
> It's *implied* that some of those registers might be writable, but as
> the specific set of registers is not described I cannot tell. Are there
> any writable system registers which are shared?
> 
> I don't see how we can know which registers we might need to
> save/restore without that being explicitly documented.
> 
> I also see:
> 
> | Note: SPE (Statistical Profiling Extension) state is shared across VTLs,
> | except for PMBSR_EL1 which is VTL-private.
> 
> If "SPE state" includes PMBPTR or PMBLIMITR (which is the obvious
> reading), this would be a security problem, as a lower-privileged VTL
> could clobber those and cause SPE to write to arbitrary memory
> immediately upon return to the higher-privileged VTL. Having PMBSR be
> private on its own isn't sufficient to prevent that (e.g. since the
> higher-privileged VTL could have its own active SPE profiling session).
> 
> I'm not keen on requiring hyper-v specific hooks in the SPE driver to
> achieve that, and I'm also not keen on having hyper-v support code poke
> SPE registers behind the SPE driver's back.
> 
> This does not give me confidence that any future PE state (e.g. things
> like TRBE) will be managed in a safe way either.
> 
> Mark.


Thanks for sharing this, I'll discuss it internally and come up with a plan.

Regards,
Naman

