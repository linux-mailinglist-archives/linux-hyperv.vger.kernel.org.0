Return-Path: <linux-hyperv+bounces-7358-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A882BC12E96
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 Oct 2025 06:09:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2F4D2350E49
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 Oct 2025 05:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CC51224234;
	Tue, 28 Oct 2025 05:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="mRfIxqyL"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C09831F4C8E;
	Tue, 28 Oct 2025 05:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761628191; cv=none; b=gYLxQhw1wImZLYJDf7/ssBR2Du1u/wCnBNq93vET05Ih+kn8390EmFneY6nAtmWGW6WTDrO5U7YuGiqwmJV3r12NrrS2d1IuS7r9wh+6CqHuLuUpLVibepkVq3V6UFcjGlKBme6eIrNTSfsaEL3Jrjiq3RkZLOpzQPAeevP/7A8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761628191; c=relaxed/simple;
	bh=khLhpRe3NhEqJeipfDp4tUJ0g/LDtL5h4GKtbPm1Ljo=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=VNB5r45oLfOs4htPyqCUAxjHwulR8UPzMwFqqa1AUjaE/76gIke1PYDTGKiLmZztquRiyHI0PJfl7ra5wLnx6tpWgC1JiOL5Vu28T7FutRtl3S+0VIHzyopJT9F2GJPhMmysX13bQUkfZYttNkrl7x+C0znpVLMbcYS6bz5ZXCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=mRfIxqyL; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.95.76.239] (unknown [167.220.238.207])
	by linux.microsoft.com (Postfix) with ESMTPSA id AA8C1200FE56;
	Mon, 27 Oct 2025 22:09:43 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com AA8C1200FE56
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1761628188;
	bh=CrCZotvoz9ZVYe7EM+YL/i9fF6Af8T3thrppv9Sk8j8=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=mRfIxqyL1Ma0E84emoIDM/H95Wqp1QogNbRd4FS5KBAJqVvGUngUBIy7SfohJGHHy
	 HNFO3iZ6DGRwa8LLggdF3XzLu2wztoDpzZih4Erww4EXYwQp6YopH5LNop/CE2KP8F
	 4ij2KcGsnKB9tedxNCr6cieuuBpaEqFRWAMuN1Pk=
Message-ID: <6b4d5054-9adb-4313-b7dc-caa7c0751b5a@linux.microsoft.com>
Date: Tue, 28 Oct 2025 10:39:41 +0530
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 0/2] Drivers: hv: Introduce new driver - mshv_vtl
From: Naman Jain <namjain@linux.microsoft.com>
To: Michael Kelley <mhklinux@outlook.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "x86@kernel.org" <x86@kernel.org>,
 Mukesh Rathor <mrathor@linux.microsoft.com>,
 Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
 Nuno Das Neves <nunodasneves@linux.microsoft.com>,
 Christoph Hellwig <hch@infradead.org>,
 Saurabh Sengar <ssengar@linux.microsoft.com>,
 ALOK TIWARI <alok.a.tiwari@oracle.com>,
 "K . Y . Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, "H . Peter Anvin" <hpa@zytor.com>
References: <20251017074507.142704-1-namjain@linux.microsoft.com>
 <SN6PR02MB4157AE454F412993BC1D4BFDD4F6A@SN6PR02MB4157.namprd02.prod.outlook.com>
 <0f9f9d71-d12a-4b52-8477-46a66a534eda@linux.microsoft.com>
Content-Language: en-US
In-Reply-To: <0f9f9d71-d12a-4b52-8477-46a66a534eda@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 10/23/2025 8:51 PM, Naman Jain wrote:
> 
> 
> On 10/18/2025 12:02 AM, Michael Kelley wrote:
>> From: Naman Jain <namjain@linux.microsoft.com> Sent: Friday, October 
>> 17, 2025 12:45 AM
>>>
>>> Introduce a new mshv_vtl driver to provide an interface for Virtual
>>> Machine Monitor like OpenVMM and its use as OpenHCL paravisor to
>>> control VTL0 (Virtual trust Level).
>>> Expose devices and support IOCTLs for features like VTL creation,
>>> VTL0 memory management, context switch, making hypercalls,
>>> mapping VTL0 address space to VTL2 userspace, getting new VMBus
>>> messages and channel events in VTL2 etc.
>>>
>>> OpenVMM : https://openvmm.dev/guide/
>>>
>>> Changes since v8:
>>> https://lore.kernel.org/all/20251013060353.67326-1- 
>>> namjain@linux.microsoft.com/
>>> Addressed Sean's comments:
>>> * Removed forcing SIGPENDING, and other minor changes, in
>>>    mshv_vtl_ioctl_return_to_lower_vtl after referring
>>>    to Sean's earlier changes for xfer_to_guest_mode_handle_work.
>>>
>>> * Rebased and resolved merge conflicts, compilation errors on latest
>>>    linux-next kernel tip, after Roman's Confidential VM changes,
>>>    which merged recently. No functional changes.
>>
>> Did your testing against the latest linux-next included testing with
>> CONFIG_X86_KERNEL_IBT=y?  This is Indirect Branch Tracking, which would
>> have generated a fault with your v7 series and earlier because of the 
>> indirect
>> call instruction when doing VTL Return through the hypercall page (which
>> doesn't have the needed ENDBR64 instruction). But now that VTL Return is
>> doing a static call, that should be direct, which won't trigger an IBT 
>> fault.
>>
>> To confirm that you really are running with IBT enabled, you should see
>>
>> [    0.047008] CET detected: Indirect Branch Tracking enabled
>>
>> in the VTL2 dmesg output.  And "ibt" should appear in the
>> "flags" output line of 'cat /proc/cpuinfo' (or the 'lscpu' command).
>>
>> Michael
> 
> 
> Hi Michael,
> I have now tested with and without IBT, and in case of IBT enabled, I do 
> see the log you pasted for IBT in VTL2 logs and there are no failures.
> 
> However, this additional testing uncovered another issue here where 
> there is a crash in VTL0, some time after boot, due to rbp clobbering in 
> mshv_vtl_return_hypercall() wrapper function.
> 
> Thanks a lot Michael for helping me offline on this, to understand and 
> identify the issue.
> 
> 
> 
> Hi Peter, Paolo, Sean,
> Here is the summary of the problem and the fix:
> 
> Assembly code make a call to mshv_vtl_return_hypercall() after handling 
> rbp properly. However, current wrapper function in C updates rbp to rsp 
> before making the static call. This creates problems.
> 
> <-snippet->
> 
> arch/x86/hyperv/mshv_vtl_asm.S:
>      /* make a hypercall to switch VTL */
>      call mshv_vtl_return_hypercall
> 
> arch/x86/hyperv/hv_vtl.c:
> noinstr void mshv_vtl_return_hypercall(void)
> {
>      asm volatile ("call " 
> STATIC_CALL_TRAMP_STR(__mshv_vtl_return_hypercall) :
>                ASM_CALL_CONSTRAINT);
> }
> 
> (gdb) disassemble mshv_vtl_return_hypercall
> Dump of assembler code for function mshv_vtl_return_hypercall:
>     0xffffffff886981a0 <+0>:     push   %rbp
>     0xffffffff886981a1 <+1>:     mov    %rsp,%rbp
>     0xffffffff886981a4 <+4>:     call   0xffffffff886a77a8 
> <__SCT____mshv_vtl_return_hypercall>
>     0xffffffff886981a9 <+9>:     pop    %rbp
>     0xffffffff886981aa <+10>:    jmp    0xffffffff886a7670 
> <__x86_return_thunk>
> 
> <-end->
> 
> 
> This is fixed after removing ASM_CALL_CONSTRAINT from above function 
> which makes sure it does not add save/restore rbp logic before the 
> assembly call instructions.
> 
> 
> <-snippet->
> 
> (gdb) disassemble mshv_vtl_return_hypercall
> Dump of assembler code for function mshv_vtl_return_hypercall:
>     0xffffffff886981a0 <+0>:     call   0xffffffff886a77a8 
> <__SCT____mshv_vtl_return_hypercall>
>     0xffffffff886981a5 <+5>:     jmp    0xffffffff886a7670 
> <__x86_return_thunk>
> End of assembler dump.
> 
> <-end->
> 
> But then we see a warning reported by objtool for frame pointer, but 
> since this is expected, I will need to add STACK_FRAME_NON_STANDARD_FP 
> to suppress it.
> 
> vmlinux.o: warning: objtool: mshv_vtl_return_hypercall+0x4: call without 
> frame pointer save/setup
> 
> 
> During code review, I found CR2 handling was missing after making 
> mshv_vtl_return_hypercall call in assembly, which I will *additionally* 
> fix in next version.
> 
> Pasting the diff at the end, on top of this patch, which should fix 
> these issues.
> 
> Please let me know if I should be doing it differently or if you foresee 
> any issues with this approach.
> 
> Regards,
> Naman
> 
> ------------------------
> diff --git a/arch/x86/hyperv/hv_vtl.c b/arch/x86/hyperv/hv_vtl.c
> index 636e9253b81e..c61d2dce4d68 100644
> --- a/arch/x86/hyperv/hv_vtl.c
> +++ b/arch/x86/hyperv/hv_vtl.c
> @@ -258,9 +258,9 @@ DEFINE_STATIC_CALL_NULL(__mshv_vtl_return_hypercall, 
> void (*)(void));
> 
>   noinstr void mshv_vtl_return_hypercall(void)
>   {
> -       asm volatile ("call " 
> STATIC_CALL_TRAMP_STR(__mshv_vtl_return_hypercall) :
> -                     ASM_CALL_CONSTRAINT);
> +       asm volatile ("call " 
> STATIC_CALL_TRAMP_STR(__mshv_vtl_return_hypercall));
>   }
> +STACK_FRAME_NON_STANDARD_FP(mshv_vtl_return_hypercall);
> 
>   extern void __mshv_vtl_return_call(struct mshv_vtl_cpu_context *vtl0);
> 
> diff --git a/arch/x86/hyperv/mshv_vtl_asm.S b/arch/x86/hyperv/ 
> mshv_vtl_asm.S
> index 4085073a5876..5f4b511749f8 100644
> --- a/arch/x86/hyperv/mshv_vtl_asm.S
> +++ b/arch/x86/hyperv/mshv_vtl_asm.S
> @@ -65,6 +65,9 @@ SYM_FUNC_START(__mshv_vtl_return_call)
>          mov 16(%rsp), %rcx
>          mov 24(%rsp), %rax
> 
> +       mov %rdx, MSHV_VTL_CPU_CONTEXT_rdx(%rax)
> +       mov %cr2, %rdx
> +       mov %rdx, MSHV_VTL_CPU_CONTEXT_cr2(%rax)
>          pop MSHV_VTL_CPU_CONTEXT_rcx(%rax)
>          pop MSHV_VTL_CPU_CONTEXT_rax(%rax)
>          add $16, %rsp


I plan to send the next version of this series, incorporating the 
changes mentioned above, within the next day or two. Additionally, I 
will include a comment regarding the use of STACK_FRAME_NON_STANDARD_FP 
and avoiding ASM_CALL_CONSTRAINT.

If you see any opportunities for improvement or feel something should be 
approached differently, please let me know.

Regards,
Naman



