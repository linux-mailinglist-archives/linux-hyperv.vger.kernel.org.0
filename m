Return-Path: <linux-hyperv+bounces-10646-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IApiNzvz+mnfUgMAu9opvQ
	(envelope-from <linux-hyperv+bounces-10646-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 06 May 2026 09:52:27 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BF054D775F
	for <lists+linux-hyperv@lfdr.de>; Wed, 06 May 2026 09:52:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4A8FB300C03B
	for <lists+linux-hyperv@lfdr.de>; Wed,  6 May 2026 07:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB9CC369203;
	Wed,  6 May 2026 07:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="meaziBh2"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B0CC2FE074;
	Wed,  6 May 2026 07:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778053944; cv=none; b=Qn9aB4OUzM8UXMt9B6R2Lav3LW6BMx2NFTPRXb4dF1OA+Je3XnNQTashhT6UCEHl1qYMUhCaL0qcy9cpI+QYAMy/kjlAdjT467qbRb4yjb9HxwE05QIO35ih+wrVPtRTDfPHzpLdFnSqri88HkyPLdHiKBrvsoKfoL3fQy7Lwuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778053944; c=relaxed/simple;
	bh=6FFVqh/7MHmu6fMlze6Pr8sVj+Fc68+P/CMCl97GJHY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VZ/hb3KYLWaOdo2AhWwsWrhfN5IAls3UAAYMSu6XzY+3s3egBuKlJcnaL8QtV3hN37l249HdWwZLjibBcZ2stwOxx/OoDIbq0I6VIz6eWINbTDzZlDQckU0qkKdEDSgV+5BzH+G0uObGOrceli8kTraSr1iSNts+TgXRZqhRYqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=meaziBh2; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EDC9816F8;
	Wed,  6 May 2026 00:52:16 -0700 (PDT)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E7F223F7B4;
	Wed,  6 May 2026 00:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1778053942; bh=6FFVqh/7MHmu6fMlze6Pr8sVj+Fc68+P/CMCl97GJHY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=meaziBh2Y9VBs+iy/L6rKp64Itbk/SuVY9x+LY628fB+3BjdMpShAfiz7kxaVUmK3
	 ML5Shd4PkZizJdBxdiUxDSD16EtZOZgzSYKb2WqhuFmuhUGrne0s9eqpQddsN+hRNR
	 s8bBXG8z4UPrCKTSgYHbdm5hCjsmKq0wzvAMc6Yo=
Date: Wed, 6 May 2026 08:52:10 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Naman Jain <namjain@linux.microsoft.com>
Cc: Marc Zyngier <maz@kernel.org>, "K . Y . Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Michael Kelley <mhklinux@outlook.com>,
	Timothy Hayes <timothy.hayes@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Sascha Bischoff <sascha.bischoff@arm.com>,
	mrigendrachaubey <mrigendra.chaubey@gmail.com>,
	linux-hyperv@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-riscv@lists.infradead.org, vdso@mailbox.org,
	ssengar@linux.microsoft.com
Subject: Re: [PATCH v2 07/15] arm64: hyperv: Add support for
 mshv_vtl_return_call
Message-ID: <afrzKl3ixCUUVL6C@J2N7QTR9R3>
References: <20260423124206.2410879-1-namjain@linux.microsoft.com>
 <20260423124206.2410879-8-namjain@linux.microsoft.com>
 <aeolHwXHFH4AnX_n@J2N7QTR9R3.cambridge.arm.com>
 <f4059f5d-a82b-40c2-942e-3e24cefab94f@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f4059f5d-a82b-40c2-942e-3e24cefab94f@linux.microsoft.com>
X-Rspamd-Queue-Id: 2BF054D775F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[arm.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[arm.com:s=foss];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10646-lists,linux-hyperv=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[32];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,microsoft.com,arm.com,redhat.com,alien8.de,linux.intel.com,zytor.com,arndb.de,dabbelt.com,eecs.berkeley.edu,ghiti.fr,outlook.com,gmail.com,vger.kernel.org,lists.infradead.org,mailbox.org,linux.microsoft.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mark.rutland@arm.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[arm.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,arm.com:dkim,svcr.sm:url]

On Wed, Apr 29, 2026 at 03:26:11PM +0530, Naman Jain wrote:
> On 4/23/2026 7:26 PM, Mark Rutland wrote:
> > On Thu, Apr 23, 2026 at 12:41:57PM +0000, Naman Jain wrote:

[ non-SMMC hypercall code omitted for brevity ]

> > NAK to this.
> > 
> > * This is a non-SMCCC hypercall, which we have NAK'd in general in the
> >    past for various reasons that I am not going to rehash here.
> > 
> > * It's not clear how this is going to be extended with necessary
> >    architecture state in future (e.g. SVE, SME). This is not
> >    future-proof, and I don't believe this is maintainable.
> > 
> > * This breaks general requirements for reliable stacktracing by
> >    clobbering state (e.g. x29) that we depend upon being valid AT ALL
> >    TIMES outside of entry code.
> > 
> > * IMO, if this needs to be saved/restored, that should happen in
> >    whatever you are calling.
> > 
> > Mark.
> 
> Merging threads for addressing comments from Mark Rutland and Marc Zyngier
> on this patch.
> 
> Thanks for reviewing the changes. Please allow me to briefly explain the use
> case here and then address your comments.
> 
> Hyper-V's Virtual Trust Levels (VTLs) provide hardware-enforced isolation
> within a single VM, analogous to ARM TrustZone. The kernel runs in VTL2
> (higher privilege) as a "paravisor", a security monitor that handles
> intercepts for the primary OS in VTL0 (lower privilege). The VTL switch
> (mshv_vtl_return_call) is functionally equivalent to KVM's guest enter/exit.

It's worth noting that for KVM, the KVM hyp code is *tightly* coupled
with the host kernel (they are one single binary object), and the
calling convention between the two is an implementation detail that can
change at any time without any ABI concerns.

While I appreciate this might be trying to do the same thing from a
*functional* perspective, it's certainly different from a
maintainability perspective, and can't be treated in the same way.

> It saves VTL2 state, loads VTL0's GPRs other registers from a shared context
> structure, issues hvc #3 to let VTL0 run, and on return saves VTL0's updated
> state back.
> 
> Coming to the problems with the code, I have identified a few ways to
> address them.
> 
> I can put the assembly code in a separate .S file with
> SYM_FUNC_START/SYM_FUNC_END and marked as noinstr, to prevent ftrace/kprobes
> from instrumenting between the GPR load and the hvc, which could have
> corrupted VTL0 register state. This should solve x29 clobbering, stack
> tracing problems.

My point was that you must not clobber those registers.

Looking at the TLFS document you linked below, it says:

| Note: X29 (FP/frame pointer), X30 (LR/link register), and SP are private
| per-VTL

... so clobbering those doesn't seem to be necessary anyway. Clearly
having an arbitrary calling convention is confusing for everyone.

> I should use kernel_neon_begin()/kernel_neon_end() to save/restore the full
> extended FP state of the current task in VTL2. VTL0's Q0-Q31 can be
> loaded/saved separately via fpsimd_load_state()/fpsimd_save_state(). This
> way, the assembly touches none of the SIMD registers. This is SVE/SME-safe
> for VTL2's task state. VTL0 still only carries Q0-Q31 in the context struct,
> and extending to SVE, SME is a future context struct change, which will need
> Hyper-V arm64 ABI support.
> This way, VTL2's callee-saved regs (x19-x28, x29, x30) are explicitly saved
> to the stack frame at the top and restored at the bottom of assembly code.
> The C caller (in hv_vtl.c) is a clean function call.

That doesn't really address my concerns here.

I do not think that Linux should have to save/restore anything here;
that should be the job of the real hypervisor. The arbitrary separation
of PE state into private and shared (with shred state being directly
exposed to Linux) is a problem for maintainability and forward
compatibility.

Looking at the TLFS document you linked below, I see:

| Note: SVE state (Z0-Z31, P0-P15, FFR) and SME state are VTL-private.
| The lower 128-bit portion (Q registers) is shared, but the upper bits
| of Z registers may be corrupted on VTL transitions. Software should
| not rely on Z register contents being preserved across VTL switches.

... which is certainly going to be a pain to manage.

Note in particular "SME state" is not an architectural term. I don't
know which state in particular that is intended to cover (e.g. ZA, ZT0,
SVCR, all streaming mode state)?

There's no mention of SVCR, so I don't know how this is going to
interact with management of ZA state (ZA and ZT0, which are dependent
upon SVCR.ZA) or streaming mode (dependent upon SVCR.SM). That state has
been *incredibly* painful for us to manage generally. Regardless of the
SMCCC concerns, that needs to be specified better.

> Regarding Non-SMCCC "hvc #3" call, I have a limitation here owing to the ABI
> that is defined by the Hyper-V hypervisor. Fixing this requires a
> hypervisor-side change to support SMCCC-style dispatch for VTL return. Until
> then, hvc #3 is the only working interface. Moreover there would be backward
> compatibility issues with this new ABI interface, if at all it is added.

To be clear, that's Microsoft's problem, not the Linux kernel
community's problem. My NAK still stands.

Multiple years ago now, we made it clear that we would not accept a
non-SMCCC calling convention. Ignoring the substance of that feedback,
and inventing a new calling convention after that point is a
self-inflicted problem.

[...]

> Link to TLFS: https://learn.microsoft.com/en-us/virtualization/hyper-v-on-windows/tlfs/vsm#on-arm64-platforms-3

For shared state, aside fomr GPRs and FPSIMD/SVE/SME state, that says:

| * System Information Registers (read-only or non-security-critical):
|   * System identification and feature registers
|   * Cache and TLB type information

It's *implied* that some of those registers might be writable, but as
the specific set of registers is not described I cannot tell. Are there
any writable system registers which are shared?

I don't see how we can know which registers we might need to
save/restore without that being explicitly documented.

I also see:

| Note: SPE (Statistical Profiling Extension) state is shared across VTLs,
| except for PMBSR_EL1 which is VTL-private.

If "SPE state" includes PMBPTR or PMBLIMITR (which is the obvious
reading), this would be a security problem, as a lower-privileged VTL
could clobber those and cause SPE to write to arbitrary memory
immediately upon return to the higher-privileged VTL. Having PMBSR be
private on its own isn't sufficient to prevent that (e.g. since the
higher-privileged VTL could have its own active SPE profiling session).

I'm not keen on requiring hyper-v specific hooks in the SPE driver to
achieve that, and I'm also not keen on having hyper-v support code poke
SPE registers behind the SPE driver's back.

This does not give me confidence that any future PE state (e.g. things
like TRBE) will be managed in a safe way either.

Mark.

