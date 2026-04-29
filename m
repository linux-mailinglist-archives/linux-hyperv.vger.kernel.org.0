Return-Path: <linux-hyperv+bounces-10462-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8G0RO8TW8Wm3kgEAu9opvQ
	(envelope-from <linux-hyperv+bounces-10462-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 29 Apr 2026 12:00:36 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D40AE4927DC
	for <lists+linux-hyperv@lfdr.de>; Wed, 29 Apr 2026 12:00:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 44797301D6BD
	for <lists+linux-hyperv@lfdr.de>; Wed, 29 Apr 2026 09:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 005852E040E;
	Wed, 29 Apr 2026 09:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="ILCjIujf"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78E8637A4B9;
	Wed, 29 Apr 2026 09:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777456582; cv=none; b=LMHTyyjJ3K2BgsccHKxXxYlXu9g1D7QdvKWrAc41hO2aVpzmsHgnFFA5i3JAiRvDrrOTaZiNH2VaEaK/LWaXLqxZkQfI+K7PPe55GaI+J50uwd0vbPa0Y08FfNJLG8e08k6jA6MMM5N1IfY9ztx05Lq06ogqfY9nWgw7oULXHrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777456582; c=relaxed/simple;
	bh=9IQPYGsCC8MNRxxreHbr7G9gvHL7AHkj3MT4L14YPMI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QOW2mvUZDBa16rEy3aDHI+5RzhashG0YAC9iX5ndyArN1mJ1Ig96HV9V0MEhqxK309dh/EVxN63unXmfvP+ywm2L9j4Ol1Q9tQR/iOhu+BHLSbb4C09ktxTmjOlXSdgkpPdGTGwaECSoi/ev2z8k2vEwrHDSYzDkj3iWTbeehpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=ILCjIujf; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.95.65.160] (unknown [167.220.238.0])
	by linux.microsoft.com (Postfix) with ESMTPSA id 2103F20B716C;
	Wed, 29 Apr 2026 02:56:13 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2103F20B716C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1777456581;
	bh=jSJDu6U+dMGP84Q05SBTqIA3q3Seu4SJCCzESfH4Y30=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ILCjIujfPfcMaiUqimA6X2yISFYX2kESPbh9QbO0KgBHOI0fElpyh2Nz6I7toMeNj
	 oPya2ORByjQhi5Un9bNdLQVnoaDnDSa7dOZYOeY7j/kOutZaT0fySJMgAyrDhOQZgn
	 FG+1X5uRaBt0DepLt6oOL+AChQHCQAFewmyQ7XKA=
Message-ID: <f4059f5d-a82b-40c2-942e-3e24cefab94f@linux.microsoft.com>
Date: Wed, 29 Apr 2026 15:26:11 +0530
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/15] arm64: hyperv: Add support for
 mshv_vtl_return_call
To: Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <maz@kernel.org>
Cc: "K . Y . Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
 Arnd Bergmann <arnd@arndb.de>, Paul Walmsley <pjw@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>, Michael Kelley <mhklinux@outlook.com>,
 Marc Zyngier <maz@kernel.org>, Timothy Hayes <timothy.hayes@arm.com>,
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
Content-Language: en-US
From: Naman Jain <namjain@linux.microsoft.com>
In-Reply-To: <aeolHwXHFH4AnX_n@J2N7QTR9R3.cambridge.arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: D40AE4927DC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10462-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[microsoft.com,kernel.org,arm.com,redhat.com,alien8.de,linux.intel.com,zytor.com,arndb.de,dabbelt.com,eecs.berkeley.edu,ghiti.fr,outlook.com,gmail.com,vger.kernel.org,lists.infradead.org,mailbox.org,linux.microsoft.com];
	RCPT_COUNT_TWELVE(0.00)[33];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[namjain@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.microsoft.com:dkim,linux.microsoft.com:mid,mailbox.org:email]



On 4/23/2026 7:26 PM, Mark Rutland wrote:
> On Thu, Apr 23, 2026 at 12:41:57PM +0000, Naman Jain wrote:
>> Add the arm64 variant of mshv_vtl_return_call() to support the MSHV_VTL
>> driver on arm64. This function enables the transition between Virtual
>> Trust Levels (VTLs) in MSHV_VTL when the kernel acts as a paravisor.
>>
>> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
>> Reviewed-by: Roman Kisel <vdso@mailbox.org>
>> Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
>> ---
>>   arch/arm64/hyperv/Makefile        |   1 +
>>   arch/arm64/hyperv/hv_vtl.c        | 158 ++++++++++++++++++++++++++++++
>>   arch/arm64/include/asm/mshyperv.h |  13 +++
>>   arch/x86/include/asm/mshyperv.h   |   2 -
>>   drivers/hv/mshv_vtl.h             |   3 +
>>   include/asm-generic/mshyperv.h    |   2 +
>>   6 files changed, 177 insertions(+), 2 deletions(-)
>>   create mode 100644 arch/arm64/hyperv/hv_vtl.c
>>
>> diff --git a/arch/arm64/hyperv/Makefile b/arch/arm64/hyperv/Makefile
>> index 87c31c001da9..9701a837a6e1 100644
>> --- a/arch/arm64/hyperv/Makefile
>> +++ b/arch/arm64/hyperv/Makefile
>> @@ -1,2 +1,3 @@
>>   # SPDX-License-Identifier: GPL-2.0
>>   obj-y		:= hv_core.o mshyperv.o
>> +obj-$(CONFIG_HYPERV_VTL_MODE)	+= hv_vtl.o
>> diff --git a/arch/arm64/hyperv/hv_vtl.c b/arch/arm64/hyperv/hv_vtl.c
>> new file mode 100644
>> index 000000000000..59cbeb74e7b9
>> --- /dev/null
>> +++ b/arch/arm64/hyperv/hv_vtl.c
>> @@ -0,0 +1,158 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (C) 2026, Microsoft, Inc.
>> + *
>> + * Authors:
>> + *     Roman Kisel <romank@linux.microsoft.com>
>> + *     Naman Jain <namjain@linux.microsoft.com>
>> + */
>> +
>> +#include <asm/mshyperv.h>
>> +#include <asm/neon.h>
>> +#include <linux/export.h>
>> +
>> +void mshv_vtl_return_call(struct mshv_vtl_cpu_context *vtl0)
>> +{
>> +	struct user_fpsimd_state fpsimd_state;
>> +	u64 base_ptr = (u64)vtl0->x;
>> +
>> +	/*
>> +	 * Obtain the CPU FPSIMD registers for VTL context switch.
>> +	 * This saves the current task's FP/NEON state and allows us to
>> +	 * safely load VTL0's FP/NEON context for the hypercall.
>> +	 */
>> +	kernel_neon_begin(&fpsimd_state);
>> +
>> +	/*
>> +	 * VTL switch for ARM64 platform - managing VTL0's CPU context.
>> +	 * We explicitly use the stack to save the base pointer, and use x16
>> +	 * as our working register for accessing the context structure.
>> +	 *
>> +	 * Register Handling:
>> +	 * - X0-X17: Saved/restored (general-purpose, shared for VTL communication)
>> +	 * - X18: NOT touched - hypervisor-managed per-VTL (platform register)
>> +	 * - X19-X30: Saved/restored (part of VTL0's execution context)
>> +	 * - Q0-Q31: Saved/restored (128-bit NEON/floating-point registers, shared)
>> +	 * - SP: Not in structure, hypervisor-managed per-VTL
>> +	 *
>> +	 * X29 (FP) and X30 (LR) are in the structure and must be saved/restored
>> +	 * as part of VTL0's complete execution state.
>> +	 */
>> +	asm __volatile__ (
>> +		/* Save base pointer to stack explicitly, then load into x16 */
>> +		"str %0, [sp, #-16]!\n\t"     /* Push base pointer onto stack */
>> +		"mov x16, %0\n\t"             /* Load base pointer into x16 */
>> +		/* Volatile registers (Windows ARM64 ABI: x0-x17) */
>> +		"ldp x0, x1, [x16]\n\t"
>> +		"ldp x2, x3, [x16, #(2*8)]\n\t"
>> +		"ldp x4, x5, [x16, #(4*8)]\n\t"
>> +		"ldp x6, x7, [x16, #(6*8)]\n\t"
>> +		"ldp x8, x9, [x16, #(8*8)]\n\t"
>> +		"ldp x10, x11, [x16, #(10*8)]\n\t"
>> +		"ldp x12, x13, [x16, #(12*8)]\n\t"
>> +		"ldp x14, x15, [x16, #(14*8)]\n\t"
>> +		/* x16 will be loaded last, after saving base pointer */
>> +		"ldr x17, [x16, #(17*8)]\n\t"
>> +		/* x18 is hypervisor-managed per-VTL - DO NOT LOAD */
>> +
>> +		/* General-purpose registers: x19-x30 */
>> +		"ldp x19, x20, [x16, #(19*8)]\n\t"
>> +		"ldp x21, x22, [x16, #(21*8)]\n\t"
>> +		"ldp x23, x24, [x16, #(23*8)]\n\t"
>> +		"ldp x25, x26, [x16, #(25*8)]\n\t"
>> +		"ldp x27, x28, [x16, #(27*8)]\n\t"
>> +
>> +		/* Frame pointer and link register */
>> +		"ldp x29, x30, [x16, #(29*8)]\n\t"
>> +
>> +		/* Shared NEON/FP registers: Q0-Q31 (128-bit) */
>> +		"ldp q0, q1, [x16, #(32*8)]\n\t"
>> +		"ldp q2, q3, [x16, #(32*8 + 2*16)]\n\t"
>> +		"ldp q4, q5, [x16, #(32*8 + 4*16)]\n\t"
>> +		"ldp q6, q7, [x16, #(32*8 + 6*16)]\n\t"
>> +		"ldp q8, q9, [x16, #(32*8 + 8*16)]\n\t"
>> +		"ldp q10, q11, [x16, #(32*8 + 10*16)]\n\t"
>> +		"ldp q12, q13, [x16, #(32*8 + 12*16)]\n\t"
>> +		"ldp q14, q15, [x16, #(32*8 + 14*16)]\n\t"
>> +		"ldp q16, q17, [x16, #(32*8 + 16*16)]\n\t"
>> +		"ldp q18, q19, [x16, #(32*8 + 18*16)]\n\t"
>> +		"ldp q20, q21, [x16, #(32*8 + 20*16)]\n\t"
>> +		"ldp q22, q23, [x16, #(32*8 + 22*16)]\n\t"
>> +		"ldp q24, q25, [x16, #(32*8 + 24*16)]\n\t"
>> +		"ldp q26, q27, [x16, #(32*8 + 26*16)]\n\t"
>> +		"ldp q28, q29, [x16, #(32*8 + 28*16)]\n\t"
>> +		"ldp q30, q31, [x16, #(32*8 + 30*16)]\n\t"
>> +
>> +		/* Now load x16 itself */
>> +		"ldr x16, [x16, #(16*8)]\n\t"
>> +
>> +		/* Return to the lower VTL */
>> +		"hvc #3\n\t"
> 
> NAK to this.
> 
> * This is a non-SMCCC hypercall, which we have NAK'd in general in the
>    past for various reasons that I am not going to rehash here.
> 
> * It's not clear how this is going to be extended with necessary
>    architecture state in future (e.g. SVE, SME). This is not
>    future-proof, and I don't believe this is maintainable.
> 
> * This breaks general requirements for reliable stacktracing by
>    clobbering state (e.g. x29) that we depend upon being valid AT ALL
>    TIMES outside of entry code.
> 
> * IMO, if this needs to be saved/restored, that should happen in
>    whatever you are calling.
> 
> Mark.


Merging threads for addressing comments from Mark Rutland and Marc 
Zyngier on this patch.

Thanks for reviewing the changes. Please allow me to briefly explain the 
use case here and then address your comments.

Hyper-V's Virtual Trust Levels (VTLs) provide hardware-enforced 
isolation within a single VM, analogous to ARM TrustZone. The kernel 
runs in VTL2 (higher privilege) as a "paravisor", a security monitor 
that handles intercepts for the primary OS in VTL0 (lower privilege). 
The VTL switch (mshv_vtl_return_call) is functionally equivalent to 
KVM's guest enter/exit. It saves VTL2 state, loads VTL0's GPRs other 
registers from a shared context structure, issues hvc #3 to let VTL0 
run, and on return saves VTL0's updated state back.

Coming to the problems with the code, I have identified a few ways to 
address them.

I can put the assembly code in a separate .S file with 
SYM_FUNC_START/SYM_FUNC_END and marked as noinstr, to prevent 
ftrace/kprobes from instrumenting between the GPR load and the hvc, 
which could have corrupted VTL0 register state. This should solve x29 
clobbering, stack tracing problems.

I should use kernel_neon_begin()/kernel_neon_end() to save/restore the 
full extended FP state of the current task in VTL2. VTL0's Q0-Q31 can be 
loaded/saved separately via fpsimd_load_state()/fpsimd_save_state(). 
This way, the assembly touches none of the SIMD registers. This is 
SVE/SME-safe for VTL2's task state. VTL0 still only carries Q0-Q31 in 
the context struct, and extending to SVE, SME is a future context struct 
change, which will need Hyper-V arm64 ABI support.
This way, VTL2's callee-saved regs (x19-x28, x29, x30) are explicitly 
saved to the stack frame at the top and restored at the bottom of 
assembly code. The C caller (in hv_vtl.c) is a clean function call.

Regarding Non-SMCCC "hvc #3" call, I have a limitation here owing to the 
ABI that is defined by the Hyper-V hypervisor. Fixing this requires a 
hypervisor-side change to support SMCCC-style dispatch for VTL return. 
Until then, hvc #3 is the only working interface. Moreover there would 
be backward compatibility issues with this new ABI interface, if at all 
it is added.

Link to TLFS: 
https://learn.microsoft.com/en-us/virtualization/hyper-v-on-windows/tlfs/vsm#on-arm64-platforms-3

Please correct me if any of the above is incorrect or if I should be 
looking at some other existing examples to solve these problems.

Regards,
Naman

