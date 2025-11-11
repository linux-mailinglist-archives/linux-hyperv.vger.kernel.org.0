Return-Path: <linux-hyperv+bounces-7491-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1880CC4C02F
	for <lists+linux-hyperv@lfdr.de>; Tue, 11 Nov 2025 08:13:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC4D1189B594
	for <lists+linux-hyperv@lfdr.de>; Tue, 11 Nov 2025 07:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EE3B34B1A2;
	Tue, 11 Nov 2025 06:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="GPj2br0N"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80BF634B191;
	Tue, 11 Nov 2025 06:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762844174; cv=none; b=rslq/6PSDHU88BpnZpELqzknGkpy9crn9S0Bl96UJ0yc6Yr5BxBTVQnW03IhSaCu9VEvzveoumnwGt82LxCA8KEcPY41jNUytC+LPNtT3BBFRMqMVKDlEomTet/MAqiar4KRCOVr2Pf0VyyMavYcGRn9N9UydLsPWykR7p6wVvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762844174; c=relaxed/simple;
	bh=nyp0ilgtqt9/SF8SNMzIL5Lo3gi9su5uPwqkiWOK4qY=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=V7U3VqDYLwBDIiMuZwRR22WvmRlK0J8ookHztGu0dmzyHAICwyPY1SujYXNTyXBjhtBkRl6fRvBOi97aRMog9gzloJQpo7Yqnr3ctIXj1OG1Ii8Pa3gpUP7ThA6veh5NMpLp1vrEO1kf6pwrBxQ8WW/gZ5Q4bosCR/NrowvdVZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=GPj2br0N; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.95.76.239] (unknown [167.220.238.207])
	by linux.microsoft.com (Postfix) with ESMTPSA id 80362212AE48;
	Mon, 10 Nov 2025 22:55:57 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 80362212AE48
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1762844162;
	bh=pdnJouELL9fro4tWBEU9h3VTYbBhk/3zG64E9r7BT5A=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
	b=GPj2br0NfQJ7gOmiT4elLxEk0DhdF51QkIIWrD30qsP0l5XLXQbogYooSg93/4baG
	 0lwwhIp2AkBHJeoxjT3x/HYVUS/YEWan2oDJE/TS8rCZtRJmX1ESfHJUfbB5y0/3Yv
	 HVqGTsEhkWpTnr9Pfk/hkoDs+soI8jLtNAG6S9ds=
Message-ID: <f32292e6-b152-4d6d-b678-fc46b8e3d1ac@linux.microsoft.com>
Date: Tue, 11 Nov 2025 12:25:54 +0530
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Naman Jain <namjain@linux.microsoft.com>
Subject: Re: [PATCH v11 2/2] Drivers: hv: Introduce mshv_vtl driver
To: Peter Zijlstra <peterz@infradead.org>, Paolo Bonzini
 <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>
Cc: "K . Y . Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, "H . Peter Anvin"
 <hpa@zytor.com>, linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
 x86@kernel.org, Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Michael Kelley <mhklinux@outlook.com>,
 Mukesh Rathor <mrathor@linux.microsoft.com>,
 Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
 Nuno Das Neves <nunodasneves@linux.microsoft.com>,
 Christoph Hellwig <hch@infradead.org>,
 Saurabh Sengar <ssengar@linux.microsoft.com>,
 ALOK TIWARI <alok.a.tiwari@oracle.com>
References: <20251110050835.1603847-1-namjain@linux.microsoft.com>
 <20251110050835.1603847-3-namjain@linux.microsoft.com>
 <20251110143834.GA3245006@noisy.programming.kicks-ass.net>
Content-Language: en-US
In-Reply-To: <20251110143834.GA3245006@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/10/2025 8:08 PM, Peter Zijlstra wrote:
> On Mon, Nov 10, 2025 at 05:08:35AM +0000, Naman Jain wrote:
>> Provide an interface for Virtual Machine Monitor like OpenVMM and its
>> use as OpenHCL paravisor to control VTL0 (Virtual trust Level).
>> Expose devices and support IOCTLs for features like VTL creation,
>> VTL0 memory management, context switch, making hypercalls,
>> mapping VTL0 address space to VTL2 userspace, getting new VMBus
>> messages and channel events in VTL2 etc.
> 
>> diff --git a/arch/x86/hyperv/hv_vtl.c b/arch/x86/hyperv/hv_vtl.c
>> index 042e8712d8de..dba27e1bcc10 100644
>> --- a/arch/x86/hyperv/hv_vtl.c
>> +++ b/arch/x86/hyperv/hv_vtl.c
>> @@ -249,3 +253,42 @@ int __init hv_vtl_early_init(void)
>>   
>>   	return 0;
>>   }
>> +
>> +DEFINE_STATIC_CALL_NULL(__mshv_vtl_return_hypercall, void (*)(void));
>> +
>> +noinstr void mshv_vtl_return_hypercall(void)
>> +{
>> +	asm volatile ("call " STATIC_CALL_TRAMP_STR(__mshv_vtl_return_hypercall));
>> +}
>> +
>> +/*
>> + * ASM_CALL_CONSTRAINT is intentionally not used in above asm block before making a call to
>> + * __mshv_vtl_return_hypercall, to avoid rbp clobbering before actual VTL return happens.
>> + * This however leads to objtool complain about "call without frame pointer save/setup".
>> + * To ignore that warning, and inform objtool about this non-standard function,
>> + * STACK_FRAME_NON_STANDARD_FP is used.
>> + */
>> +STACK_FRAME_NON_STANDARD_FP(mshv_vtl_return_hypercall);
> 
>> --- /dev/null
>> +++ b/arch/x86/hyperv/mshv_vtl_asm.S
>> @@ -0,0 +1,98 @@
>> +/* SPDX-License-Identifier: GPL-2.0
>> + *
>> + * Assembly level code for mshv_vtl VTL transition
>> + *
>> + * Copyright (c) 2025, Microsoft Corporation.
>> + *
>> + * Author:
>> + *   Naman Jain <namjain@microsoft.com>
>> + */
>> +
>> +#include <linux/linkage.h>
>> +#include <asm/asm.h>
>> +#include <asm/asm-offsets.h>
>> +#include <asm/frame.h>
>> +#include "mshv-asm-offsets.h"
>> +
>> +	.text
>> +	.section .noinstr.text, "ax"
>> +/*
>> + * void __mshv_vtl_return_call(struct mshv_vtl_cpu_context *vtl0)
> 
> Can we please get a few words on the magical context here? Like no NMIs
> and #DB traps and the like. Because if any of them were possible this
> code would be horribly broken.
Sure, I can add below comment:

This function is marked as 'noinstr' to prevent against instrumentation 
and debugging facilities. NMIs aren't a problem because the NMI handler 
saves/restores CR2 specifically to guard against #PFs in NMI context 
clobbering the guest state.
> 
>> + */
>> +SYM_FUNC_START(__mshv_vtl_return_call)
>> +	/* Push callee save registers */
>> +	pushq %rbp
>> +	mov %rsp, %rbp
>> +	pushq %r12
>> +	pushq %r13
>> +	pushq %r14
>> +	pushq %r15
>> +	pushq %rbx
>> +
>> +	/* register switch to VTL0 clobbers all registers except rax/rcx */
>> +	mov %_ASM_ARG1, %rax
>> +
>> +	/* grab rbx/rbp/rsi/rdi/r8-r15 */
>> +	mov MSHV_VTL_CPU_CONTEXT_rbx(%rax), %rbx
>> +	mov MSHV_VTL_CPU_CONTEXT_rbp(%rax), %rbp
>> +	mov MSHV_VTL_CPU_CONTEXT_rsi(%rax), %rsi
>> +	mov MSHV_VTL_CPU_CONTEXT_rdi(%rax), %rdi
>> +	mov MSHV_VTL_CPU_CONTEXT_r8(%rax), %r8
>> +	mov MSHV_VTL_CPU_CONTEXT_r9(%rax), %r9
>> +	mov MSHV_VTL_CPU_CONTEXT_r10(%rax), %r10
>> +	mov MSHV_VTL_CPU_CONTEXT_r11(%rax), %r11
>> +	mov MSHV_VTL_CPU_CONTEXT_r12(%rax), %r12
>> +	mov MSHV_VTL_CPU_CONTEXT_r13(%rax), %r13
>> +	mov MSHV_VTL_CPU_CONTEXT_r14(%rax), %r14
>> +	mov MSHV_VTL_CPU_CONTEXT_r15(%rax), %r15
>> +
>> +	mov MSHV_VTL_CPU_CONTEXT_cr2(%rax), %rdx
>> +	mov %rdx, %cr2
>> +	mov MSHV_VTL_CPU_CONTEXT_rdx(%rax), %rdx
>> +
>> +	/* stash host registers on stack */
>> +	pushq %rax
>> +	pushq %rcx
>> +
>> +	xor %ecx, %ecx
>> +
>> +	/* make a hypercall to switch VTL */
>> +	call mshv_vtl_return_hypercall
> 
> Yuck!
> 
> This seems to build for me.

This would have been the cleanest approach. We discussed this before and 
unfortunately it didn't work. Please find the link to this discussion:

https://lore.kernel.org/all/9f8007a3-f810-4b60-8942-e721cd6a32c4@linux.microsoft.com/

To summarize above discussion, I see below compilation error with this 
from objtool. You may have CONFIG_X86_KERNEL_IBT enabled in your 
workspace, which would have masked this.


   AS      arch/x86/hyperv/mshv_vtl_asm.o
arch/x86/hyperv/mshv_vtl_asm.o: error: objtool: static_call: can't find 
static_call_key symbol: __SCK____mshv_vtl_return_hypercall
make[4]: *** [scripts/Makefile.build:430: 
arch/x86/hyperv/mshv_vtl_asm.o] Error 255
make[4]: *** Deleting file 'arch/x86/hyperv/mshv_vtl_asm.o'
make[3]: *** [scripts/Makefile.build:556: arch/x86/hyperv] Error 2


Because of this compilation error, I had to implement this wrapper 
function (mshv_vtl_return_hypercall) which makes this static call in C.

> 
> ---
> --- a/arch/x86/hyperv/hv_vtl.c
> +++ b/arch/x86/hyperv/hv_vtl.c
> @@ -256,20 +256,6 @@ int __init hv_vtl_early_init(void)
>   
>   DEFINE_STATIC_CALL_NULL(__mshv_vtl_return_hypercall, void (*)(void));
>   
> -noinstr void mshv_vtl_return_hypercall(void)
> -{
> -	asm volatile ("call " STATIC_CALL_TRAMP_STR(__mshv_vtl_return_hypercall));
> -}
> -
> -/*
> - * ASM_CALL_CONSTRAINT is intentionally not used in above asm block before making a call to
> - * __mshv_vtl_return_hypercall, to avoid rbp clobbering before actual VTL return happens.
> - * This however leads to objtool complain about "call without frame pointer save/setup".
> - * To ignore that warning, and inform objtool about this non-standard function,
> - * STACK_FRAME_NON_STANDARD_FP is used.
> - */
> -STACK_FRAME_NON_STANDARD_FP(mshv_vtl_return_hypercall)
> -
>   void mshv_vtl_return_call_init(u64 vtl_return_offset)
>   {
>   	static_call_update(__mshv_vtl_return_hypercall,
> --- a/arch/x86/hyperv/mshv_vtl_asm.S
> +++ b/arch/x86/hyperv/mshv_vtl_asm.S
> @@ -9,6 +9,7 @@
>    */

<snip>

Regards,
Naman


